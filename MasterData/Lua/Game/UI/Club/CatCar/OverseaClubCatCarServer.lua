
local OverseaClubCatCarDojo = import("Game.UI.Club.CatCar.OverseaClubCatCarDojo")

---@class OverseaClubCatCarServer
local OverseaClubCatCarServer = Class("OverseaClubCatCarServer")

function OverseaClubCatCarServer:__init()
    ---@type OverseaClubCatCarDojo
    self.dojo = OverseaClubCatCarDojo.New()
end

function OverseaClubCatCarServer:__delete()

end

function OverseaClubCatCarServer:GetActivityData()
    return { } --TODO 
end

--{{{ interface
--OverseaClubCatCarHome = "OverseaClub/catCarHome",                  -- 社团猫车首页
--    OverseaClubCatCarRank = "OverseaClub/catCarRank",                  -- 社团猫车排行榜
--    OverseaClubPlayerCatCarRank = "OverseaClub/clubPlayerCatCarRank",  -- 社团boss成员点数排行榜
--    OverseaClubCatCarBossAt = "OverseaClub/catCarBossAt",              -- 社团猫车BOSS战斗
--    OverseaClubCatCarBossGrage = "OverseaClub/catCarBossGrage",        -- 社团猫车BOSS结算
--    OverseaClubCallDice = "OverseaClub/CallDice",                      -- 社团猫车摇骰子
--    OverseaClubSubmitDice = "OverseaClub/submitDice",                  -- 社团猫车提交骰子
--    OverseaClubCallPool = "OverseaClub/callPool",                      -- 社团猫车抽奖池
function OverseaClubCatCarServer:ReqCatCarHome(callback)
    GameUtils.Request(Interfaces.OverseaClubCatCarHome,{},function(request, response) 
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        self.dojo:Init(response.data)

        if callback then
            callback(response.data)
        end
    end)
end

--function OverseaClubCatCarServer:ReqCatCarRank(callback)
--    GameUtils.Request(Interfaces.OverseaClubCatCarRank,{},function(request, response) 
--        if checkNumber(response.errCode) ~= 0 then
--            return
--        end
--        self.dojo.carRankInfo = response.data
--        
--        if callback then
--            callback(response.data)
--        end
--    end)
--end

--function OverseaClubCatCarServer:ReqClubPlayerCatCarRank(callback)
--    GameUtils.Request(Interfaces.OverseaClubPlayerCatCarRank,{},function(request, response) 
--        if checkNumber(response.errCode) ~= 0 then
--            return
--        end
--        self.dojo.bossRankInfo = response.data
--        
--        if callback then
--            callback(response.data)
--        end
--    end)
--end

function OverseaClubCatCarServer:ReqCallDice(callback,onFail)
    ----TODO Test
    --self.dojo.catCarInfo.playerDiceNumber = {math.random(1, 6), math.random(1, 6), math.random(1, 6)}
    --if callback then
    --    callback()
    --end
    
    GameUtils.Request(Interfaces.OverseaClubCallDice,{},function(request, response) 
        if checkNumber(response.errCode) ~= 0 then
            if onFail then
                onFail()
            end
            return
        end
        if self.dojo.catCarInfo.playerDiceNumber ~= nil and table.count(self.dojo.catCarInfo.playerDiceNumber) ~= 0 then
            self.dojo.catCarInfo.playerDiceTimesLeft = checkNumber(self.dojo.catCarInfo.playerDiceTimesLeft) - 1
        end
        self.dojo.catCarInfo.playerDiceNumber = checkTable(response.data.playerDiceNumber)
        
        Events.Broadcast(ClubUtils.EventName.Dice_Call)

        if callback then
            callback(response.data)
        end
    end)
end

function OverseaClubCatCarServer:ReqSubmitDice(callback)
    --self.dojo.clubCatCarLevel = self.dojo.clubCatCarLevel + 1
    --self.dojo.clubScore = self.dojo.clubScore + 20
    --self.dojo.catCarInfo.selfRankInfo.score = self.dojo.clubScore
    --
    --Events.Broadcast(ClubUtils.EventName.Dice_Submit,true,true)
    --
    --if self.dojo.clubCatCarLevel == 5 then
    --    self.dojo.clubCatCarLevel = 1
    --end
    
    GameUtils.Request(Interfaces.OverseaClubSubmitDice,{},function(request, response) 
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        ---@type OverseaClubCatCarUtils
        local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")
        
        self.dojo.clubScore = checkNumber(response.data.clubScore)
        self.dojo.catCarInfo.submitDiceTimes = checkNumber(self.dojo.catCarInfo.submitDiceTimes) + 1
        local totalNum = checkNumber(self.dojo.catCarInfo.playerDiceNumber[1]) + checkNumber(self.dojo.catCarInfo.playerDiceNumber[2]) + checkNumber(self.dojo.catCarInfo.playerDiceNumber[3])
        local dayIndex  = OverseaClubCatCarUtils:GetTodayIndex()
        self.dojo.diceRecords = checkTable(self.dojo.diceRecords)
        self.dojo.diceRecords[tostring(dayIndex)] = checkNumber(self.dojo.diceRecords[tostring(dayIndex)]) + totalNum
        self.dojo.totalSubmitDiceTimes = checkNumber(self.dojo.totalSubmitDiceTimes) + 1
        ---@type ClubCatCarSpeedGradeVo
        local curVo = OverseaClubCatCarUtils:GetCurSpeedGradeVo(self.dojo.clubScore)
        local levelChange = nil
        if curVo.id ~= self.dojo.clubCatCarLevel then
            self.dojo.clubCatCarLevel = curVo.id
            levelChange = true
        end
        self.dojo.playerScore = checkNumber(self.dojo.playerScore) + totalNum
        self.dojo.catCarInfo.playerDiceNumber = nil
        if response.data.rankInfo and table.count(response.data.rankInfo) ~= 0 then
            local overtake = true
            if self.dojo.catCarInfo.selfRankInfo == nil then
                overtake = false
            end
            self.dojo.catCarInfo.rankInfo = response.data.rankInfo
            self.dojo:CheckCarRankInfo()
            Events.Broadcast(ClubUtils.EventName.Dice_Submit,overtake,levelChange)
        else
            if self.dojo.catCarInfo.selfRankInfo then
                self.dojo.catCarInfo.selfRankInfo.score = self.dojo.clubScore
            end
            Events.Broadcast(ClubUtils.EventName.Dice_Submit,false,levelChange)
        end
        if callback then
            callback(response.data)
        end
    end)
end

local testCalledId = 1

function OverseaClubCatCarServer:ReqCallPool(callback)
    
    ----TODO Test
    --self.dojo.catCarCallInfo.callConf[testCalledId].new = nil
    --testCalledId = testCalledId + 1
    --self.dojo.catCarCallInfo.calledId = testCalledId
    --self.dojo.catCarCallInfo.callConf[testCalledId].avater = 1
    --self.dojo.catCarCallInfo.callConf[testCalledId].new = true
    --if callback then
    --    callback()
    --end
    
    GameUtils.Request(Interfaces.OverseaClubCallPool,{},function(request, response) 
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local rewards = checkTable(response.data.rewards)
        GoodsUtils.DrawRewards(rewards)
        local lastCalledItem = self.dojo.catCarCallInfo.callConf[self.dojo.catCarCallInfo.calledId]
        if lastCalledItem then
            lastCalledItem.new = nil
        end

        self.dojo.catCarCallInfo.calledId = checkNumber(response.data.id)
        self.dojo.catCarCallInfo.playerCallNum = checkNumber(self.dojo.catCarCallInfo.playerCallNum) - 1
        self.dojo.catCarCallInfo.playerCallNum  = math.max(0,self.dojo.catCarCallInfo.playerCallNum)
        
        local calledItem = self.dojo.catCarCallInfo.callConf[checkNumber(response.data.id)]
        local playerInfo = checkTable(response.data.playerInfo)
        
        ---@type OverseaClubCatCarDojo.CallLog
        local newCallLog = {}
        newCallLog.id = checkNumber(response.data.id)
        newCallLog.avavar = checkNumber(playerInfo.avatar)
        newCallLog.avatarFrame = checkNumber(playerInfo.avatarFrame)
        ---@type PlayerComponent
        local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
        ---@type OverseaClubCatCarUtils
        local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")
        
        if calledItem then
            newCallLog.logText = localize("社团成员_name_刮出了_level_",{_name_ = playerComponent.playerDojo.playerName,_level_ = OverseaClubCatCarUtils:GetRewardLevelName(calledItem.type)})
            self.dojo.catCarCallInfo.callLog[1] = newCallLog
            calledItem.new = true
            calledItem.avatar = checkNumber(playerInfo.avatar)
            calledItem.avatarFrame = checkNumber(playerInfo.avatarFrame)
        end

        if callback then
            callback(response.data)
        end
    end)
end

function OverseaClubCatCarServer:ReqDrawCarTrackRewards(grade,callback)
    GameUtils.Request(Interfaces.OverseaClubDrawCarTrackRewards,{id = grade},function(request, response) 
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        local rewards = checkTable(response.data.rewards)
        GoodsUtils.DrawRewards(rewards)
        CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop,{rewards = rewards})
        
        table.insert(self.dojo.catCarInfo.drawCarTrackIds,tostring(grade))
        GameUtils.SetRedPointNum(Constants.RedPointConst.ClubCatCarTrackChest,0)
        if callback then
            callback(response.data)
        end
    end)
end

function OverseaClubCatCarServer:ReqLogs(callback)
    GameUtils.Request(Interfaces.OverseaClubCatCarCallPollLog,{},function(request, response) 
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        self.dojo.catCarCallInfo.log = checkTable(response.data.log)

        if callback then
            callback(response.data)
        end
    end)
end

--}}}

function OverseaClubCatCarServer:BattleEnd()
    printInfo("-----------------OverseaClubCatCarServer:BattleEnd")
end

return OverseaClubCatCarServer