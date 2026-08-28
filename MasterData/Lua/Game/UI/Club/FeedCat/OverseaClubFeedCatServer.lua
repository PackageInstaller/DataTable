local OverseaClubFeedCatDojo = import("Game.UI.Club.FeedCat.OverseaClubFeedCatDojo")
---@class OverseaClubFeedCatServer
local OverseaClubFeedCatServer = Class("OverseaClubFeedCatServer")
---@type OverseaClubFeedCatUtils
local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")

function OverseaClubFeedCatServer:__init()
    ---@type OverseaClubFeedCatDojo
    self.dojo = OverseaClubFeedCatDojo.New()
end

function OverseaClubFeedCatServer:__delete()

end

--{{{ test
--升阶
function OverseaClubFeedCatServer:ReqFeedCatTestPhaseUp(foodId,num,cb)
    self.dojo.petsPhase = checkNumber(self.dojo.petsPhase) + 1
    Events.Broadcast(ClubUtils.EventName.FeedCat_PhaseUp,self.dojo.petsPhase)
    if cb then
        cb()
    end
end
--升级
function OverseaClubFeedCatServer:ReqFeedCatTestLevelUp(foodId,num,cb)
    self.dojo.petsLevel = checkNumber(self.dojo.petsLevel) + 1
    local oldPhase = Utils.CalPetPhase(self.dojo.petsLevel -1)
    local newPhase = Utils.CalPetPhase(self.dojo.petsLevel)
    if oldPhase ~= newPhase then
        Events.Broadcast(ClubUtils.EventName.FeedCat_PhaseUp,newPhase)
    else
        Events.Broadcast(ClubUtils.EventName.FeedCat_LevelUp,self.dojo.petsLevel)
    end
    if cb then
        cb()
    end
end

--}}}

--{{{ interface
function OverseaClubFeedCatServer:ReqFeedCat(foodId,num,cb)
    GameUtils.Request(Interfaces.OverseaClubPetsFeet, {foodId = foodId, num = num}, function(request,response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        local function ShowReward(addClubExp, addClubCoin)
            -- CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop,{rewards = checkTable(response.data.rewards)})
            -- local foodVo      = Utils.GetFoodVo(foodId)
            -- local addClubExp  = checkInt(num) * checkInt(foodVo.clubExp)
            -- local addClubCoin = checkInt(num) * checkInt(foodVo.likeClubIntegral)
            local rewardList  = {
                { showText = false, goodsId = Constants.Currency.ClubCoin, num = addClubCoin },
                { showText = false, goodsId = ClubUtils.GetParamValue(ClubUtils.ParamsId.CLUB_EXP_ID), num = addClubExp },
            }
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewardList})
        end
        
        self.dojo.petsExp = checkNumber(response.data.petsExp)
        self.dojo.petsSatiety = checkNumber(response.data.petsSatiety)
        self.dojo.petsFeedTimes = checkNumber(self.dojo.petsFeedTimes) + num
        
        --消耗食物
        GoodsUtils.ConsumeGoods({{goodsId = foodId, num = num}})
        ClubUtils.GetClubComp():CheckDonationRedPoint()
        
        -- 服装   (升阶可能造成服装变化)
        if isNotNull(response.data.petsFacade) then
            self.dojo:SetPetsFacade(response.data.petsFacade)
        end
        
        -- 等级 阶段
        if isNotNull(response.data.petsLevel) then
            local newLevel = checkNumber(response.data.petsLevel)
            if self.dojo.petsLevel ~= newLevel then
                local oldPhase = Utils.CalPetPhase(self.dojo.petsLevel)
                local newPhase = Utils.CalPetPhase(newLevel)

                self.dojo.petsLevel = checkNumber(response.data.petsLevel)
                self.dojo:CheckPetsLevel()
                if oldPhase ~= newPhase then
                    Events.Broadcast(ClubUtils.EventName.FeedCat_PhaseUp,newPhase)
                else
                    Events.Broadcast(ClubUtils.EventName.FeedCat_LevelUp,self.dojo.petsLevel)
                end
            else
                Events.Broadcast(ClubUtils.EventName.FeedCat_FeedSuccess)
            end
        else
            Events.Broadcast(ClubUtils.EventName.FeedCat_FeedSuccess)
        end

        -- update clubExp  贡献值/公会经验
        local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
        local addclubExp = checkInt(response.data.contributionPoint) - clubHomeDojo.contributionPoint
        if addclubExp > 0 then
            ClubUtils.GetClubComp():AddClubExp(addclubExp)
        end

        -- update myself point
        local foodVo = Utils.GetFoodVo(foodId)
        clubHomeDojo:AddMySelfPoint(foodVo.clubExp * checkInt(num))

        -- update clubCoin  社团币/社团积分
        local coindId = Constants.Currency.ClubCoin
        local haveNum = GoodsUtils.GetThingNo(coindId)
        local finalNum = checkInt(response.data.clubPoint)
        local addClubCoinNum = finalNum - haveNum
        if addClubCoinNum > 0 then
            GoodsUtils.DrawRewards({
                {goodsId = coindId, num = addClubCoinNum}
            })
        end
        
        ShowReward(addclubExp, addClubCoinNum)
        
        if cb then
            cb()
        end
    end)
end

--    OverseaClubPetsDonat = "OverseaClub/petsDonat",                     -- 社团宠物捐献
--    OverseaClubPetsReset = "OverseaClub/petsReset",                     -- 社团宠物洗练
function OverseaClubFeedCatServer:ReqDonat(num,cb)
    GameUtils.Request(Interfaces.OverseaClubPetsDonat, {num = num}, function(request,response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        self.dojo:SetPetsFund(response.data.petsFund)
        self.dojo.dailyDonateNum = self.dojo.dailyDonateNum + num

        ---@type OverseaClubFeedCatUtils
        local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")
        local donateItemId = Utils.GetParamValue(Utils.ParamsId.MemberDonateItemId)
        GoodsUtils.ConsumeGoods({{goodsId = donateItemId, num = num}})
        local rewards = checkTable(response.data.rewards)
        GoodsUtils.DrawRewards(rewards)
        CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop,{rewards = rewards})
        Events.Broadcast(ClubUtils.EventName.FeedCat_RefineCoinChange)
        if cb then
            cb()
        end
    end)
end

function OverseaClubFeedCatServer:ReqReset(part,cb)
    GameUtils.Request(Interfaces.OverseaClubPetsReset, {type = part}, function(request,response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        self.dojo:SetPetsFund(response.data.petsFund)
        self.dojo:SetPetsFacade(response.data.petsFacade)
        
        if cb then
            cb()
        end
    end)
end

---购买特殊料理
function OverseaClubFeedCatServer:ReqBuySpecialFood(num,cb)
    GameUtils.Request(Interfaces.OverseaClubBuyPetsFood, {num = num}, function(request,response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        
        GoodsUtils.DrawRewards(response.data.rewards)
        CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop,{rewards = response.data.rewards})
        ---@type OverseaClubFeedCatUtils
        local Utils = import("Game.UI.Club.FeedCat.OverseaClubFeedCatUtils")
        local consumeNum = num * Utils.GetParamValue(Utils.ParamsId.BuySpecialFoodCost)
        GoodsUtils.ConsumeGoods({{goodsId = Utils.GetParamValue(Utils.ParamsId.BuySpecialFoodItemId), num = consumeNum}})
        
        if cb then
            cb()
        end
    end)
end
--}}}

return OverseaClubFeedCatServer