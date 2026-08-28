---
--- 烹饪玩法 Component
--- Author: dawanfan
--- Date: 2024-3-12 19:09:41
---

local ECSComponent = import("Frame.ECS.ECSComponent")
local ActivityCookingDojo = import("Game.Dojo.ActivityCookingDojo")
local ActivityCookingConstants = import("Game.UI.ActivityCooking.ActivityCookingConstants")
local UIModule = CS.Engine.UI.UIModule

---@class ActivityCookingComponent
---@field dojo ActivityCookingDojo
local ActivityCookingComponent = Class("ActivityCookingComponent", ECSComponent)

function ActivityCookingComponent:__init()
    self.dojo = ActivityCookingDojo.New()

end

function ActivityCookingComponent:__delete()
    self.dojo = nil
end

function ActivityCookingComponent:CookingHome(excludeIds)
    
    GameUtils.Request(Interfaces.ActivityCookingHome, {}, function(request, response) 
        local responseData = checkTable(response.data)

        if response.errCode ~= 0 then
            return
        end

        self.dojo:Init(responseData)

        local dialog = ActivityCookingConstants.CookingUIConfigs[self.dojo.config.id].EntryDialog
        UIModule.OpenDialog({id=dialog}, excludeIds)
    end)
end

function ActivityCookingComponent:CookingHomeTest()
    UIModule.OpenDialog({id=Constants.UITypeIds.ActivityCakeShopFightDialog})
end

function ActivityCookingComponent:CookingEnd(levelId, selledFood, selledPrice, cb)

    GameUtils.Request(Interfaces.ActivityCookingGrade, {questId=levelId, selledFood=selledFood, selledPrice=selledPrice}, function(request, response) 
        
        local data = checkTable(response.data)

        local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
        -- local levelVo = ActivityCookingUtils.GetCookingLevelVo(levelId)

        -- if levelVo.type ~= ActivityCookingConstants.GameMode.Endless then
        local levelInfo = self.dojo.levelInfo[levelId]
        local addStar = math.max(checkInt(data.star) - checkInt(levelInfo.star), 0)
        self.dojo.totalStar = self.dojo.totalStar + addStar
        levelInfo.star = levelInfo.star + addStar
        self.dojo.levelInfo[levelId] = levelInfo
        -- end

        GoodsUtils.DrawRewards(data.rewards, true)

        local dialog = ActivityCookingConstants.CookingUIConfigs[self.dojo.config.id].OperatePopup
        UIModule.OpenDialog({id=dialog, parameters = {
            levelId=levelId,
            rewards=data.rewards,
            starNum=data.star,
            selledPrice=selledPrice
        }})

        if cb then
            cb()
        end
        
    end)

end

function ActivityCookingComponent:KitchenwareUpgrade(kitchenwareId, showMessage)

    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    local vo = ActivityCookingUtils.GetKitchenwareVo(kitchenwareId)
    local info = self.dojo.kitchenwareInfos[kitchenwareId]

    if not self:CheckItemCanUpgrade(vo, info, showMessage) then
        return
    end

    GameUtils.Request(Interfaces.ActivityCookingKitchenwareUpgrade, {tablewareId=kitchenwareId}, function (request, response)
        if response.errCode == 4 then
            GameUtils.Toast(localize(response.errMsg))
            return
        end

        GoodsUtils.ConsumeGoods({{
            goodsId = vo.levelupConsumeItem[info.level],
            num = vo.levelupConsume[info.level]
        }}, true)
        
        self.dojo.kitchenwareInfos[kitchenwareId].level = self.dojo.kitchenwareInfos[kitchenwareId].level + 1
        Events.Broadcast(Constants.EventNames.ActivityCookingUpgrade, kitchenwareId, ActivityCookingConstants.UpgradeItemType.Kitchenware)
    end)

end

function ActivityCookingComponent:IngredientsUpgrade(ingredientsId, showMessage)

    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    local vo = ActivityCookingUtils.GetCookingIngredientsVo(ingredientsId)
    local info = self.dojo.ingredientsInfo[ingredientsId]

    if not self:CheckItemCanUpgrade(vo, info, showMessage) then
        return
    end

    GameUtils.Request(Interfaces.ActivityCookingIngredientsUpgrade, {foodId=ingredientsId}, function (request, response)

        if response.errCode == 4 then
            GameUtils.Toast(localize(response.errMsg))
            return
        end

        GoodsUtils.ConsumeGoods({{
            goodsId = vo.levelupConsumeItem[info.level],
            num = vo.levelupConsume[info.level]
        }}, true)

        self.dojo.ingredientsInfo[ingredientsId].level = self.dojo.ingredientsInfo[ingredientsId].level + 1
        Events.Broadcast(Constants.EventNames.ActivityCookingUpgrade, ingredientsId, ActivityCookingConstants.UpgradeItemType.Ingredients)
    end)
end

function ActivityCookingComponent:CheckItemCanUpgrade(vo, info, showMessage)
    if info.level >= vo.maxLevel then
        return false
    end

    local haveNo = GoodsUtils.GetThingNo(vo.levelupConsumeItem[info.level])
    if haveNo < vo.levelupConsume[info.level] then
        if showMessage then
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(vo.levelupConsumeItem[info.level])
            GameUtils.Toast(localize("_name_不足", {_name_ = goodsVo.name}))
        end
        return false
    end

    return true
end

function ActivityCookingComponent:EnterGame(levelId)
    
    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    local levelVo = ActivityCookingUtils.GetCookingLevelVo(levelId)

    if levelVo.unlockStarNum > self.dojo.totalStar then
        return
    end

    local haveNo = GoodsUtils.GetThingNo(levelVo.costItem)
    if haveNo < levelVo.costNum then
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(levelVo.costItem)
        GameUtils.Toast(localize("_name_不足", {_name_ = goodsVo.name}))
        return
    end

    GameUtils.Request(Interfaces.ActivityCookingAt, {questId=levelId}, function (request, response)

        if response.errCode == 4 then
            GameUtils.Toast(localize(response.errMsg))
            return
        end

        self.dojo.hpData.hp = self.dojo.hpData.hp - levelVo.costNum

        local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()
        ActivityCookingGame:StartGame(levelId)
    end)
end

function ActivityCookingComponent:RestartGame(cb)
    ---@type ActivityCookingGame
    local ActivityCookingGame = import("Game.UI.ActivityCooking.ActivityCookingGame"):GetInstance()

    local ActivityCookingUtils = import("Game.UI.ActivityCooking.ActivityCookingUtils")
    local levelVo = ActivityCookingUtils.GetCookingLevelVo(ActivityCookingGame.currentLevel)

    local haveNo = GoodsUtils.GetThingNo(levelVo.costItem)
    if haveNo < levelVo.costNum then
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(levelVo.costItem)
        GameUtils.Toast(localize("_name_不足", {_name_ = goodsVo.name}))
        if cb then
            cb()
        end
        ActivityCookingGame:ExitGame()
        return
    end

    GameUtils.Request(Interfaces.ActivityCookingAt, {questId=ActivityCookingGame.currentLevel}, function (request, response)

        if cb then
            cb()
        end

        if response.errCode == 4 then
            GameUtils.Toast(localize(response.errMsg))
            ActivityCookingGame:ExitGame()
            return
        end

        self.dojo.hpData.hp = self.dojo.hpData.hp - levelVo.costNum

        ActivityCookingGame:GameRestart()
    end)
    
end

function ActivityCookingComponent:BuyActivityHp()

    local consumeGoodsId = self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.BUY_CONSUME_ITEM)

    local consumeNums = parse_strings(self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.BUY_CONSUME_ITEM_NUM))
    local consumeNum = consumeNums[self.dojo.hpData.buyTimes + 1] or consumeNums[#consumeNums]
    local prices = {{currency = checkInt(consumeGoodsId), current = checkInt(consumeNum)}}
    local maxBuyLimit = self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.BUY_DAILY_TIME_LIMIT)
    local maxBuyNum = 1
    if checkInt(self.dojo.hpData.buyTimes) >= checkInt(maxBuyLimit) then
        maxBuyNum = 0
    end
    local activityTips = localize('今日剩余兑换次数: _num_', {_num_ = checkInt(maxBuyLimit) - self.dojo.hpData.buyTimes})

    UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonBuyItemDialog, parameters = {
        goodsId        = self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.HP_ITEM_ID),
        goodsNum       = self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.BUY_NUM),
        isShowNum      = true,
        maxHaveNum     = checkInt(self:GetConfigParamsById(ActivityCookingConstants.ParamsDefine.HP_UP_LIMIT)),
        prices         = prices,
        maxBuyNum      = maxBuyNum,
        activityTips   = activityTips,
        buyCb          = function (price, buyNum)
            GameUtils.Request(Interfaces.ActivityCookingBuyHp, {}, function(request, response)
                local showRewards = clone(response.data.rewards)
                table.insert(response.data.rewards, {
                    goodsId = consumeGoodsId,
                    num = -consumeNum
                })
                self.dojo.hpData = response.data.hp
                
                GoodsUtils.DrawRewards(response.data.rewards, true)
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = showRewards } })
            end)
        end
    }})
end

function ActivityCookingComponent:GetConfigParamsById(id)
    return self.dojo:GetConfigParamsById(id)
end

function ActivityCookingComponent:OpenRankDialog()
    GameUtils.Request(Interfaces.ActivityCookingGetRankInfo, {}, function(request, response)
        local data = clone(response.data)

        self.dojo.playerRank = data.playerRank
        self.dojo.rank = data.rank
        self.dojo.totalRankNum = data.totalNum


        local ActivityCookingRankingsDialogImp = import("Game.UI.Common.CommonRankingsDialogImp.ActivityCookingRankingsDialogImp")
        local dialog = ActivityCookingConstants.CookingUIConfigs[self.dojo.config.id].RankDialog
        CfUtils.DialogOpen(dialog, {
            impCls = ActivityCookingRankingsDialogImp.New()
        })
    end)
end


return ActivityCookingComponent
