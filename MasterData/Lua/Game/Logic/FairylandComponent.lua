---
--- 乱流幻境组件
--- Author: dawanfan
--- Date: 2024-1-9 11:21:57
---

local UIModule = CS.Engine.UI.UIModule

local ECSComponent = import("Frame.ECS.ECSComponent")
local FairylandDojo = import("Game.Dojo.FairylandDojo")
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")


---@class FairylandComponent
---@field dojo FairylandDojo
local FairylandComponent = Class("FairylandComponent", ECSComponent)

function FairylandComponent:__init()
    self.dojo = FairylandDojo.New()

end

function FairylandComponent:__delete()
    self.dojo = nil
end

function FairylandComponent:InitialDojo(data)

    if self.dojo == nil then
        self.dojo = FairylandDojo.New()
    end

    self.dojo:Fill(data)
end

---@param cb function
function FairylandComponent:FairylandHome(cb)
    GameUtils.Request(Interfaces.CatClanHome, {}, function (request, response)
        local responseData = checkTable(response.data)

        self.dojo:Fill(responseData)

        if cb then
            cb()
        end
    end)
end

function FairylandComponent:RequestEnterQuest(questId)

    ---@type FairylandQuestVo
    local fairylandQuestVo = CfUtils.GetCfVo(AutoIds.IdSetting6160, "FairylandQuestVo", questId)
    local haveNo = GoodsUtils.GetThingNo(fairylandQuestVo.consume)
    if haveNo < fairylandQuestVo.number then
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(fairylandQuestVo.consume)
        GameUtils.Toast(localize("_name_不足", {_name_ = goodsVo.name}))
        return
    end

    GameUtils.Request(Interfaces.CatClanSecretEnter, {copyId=questId}, function (request, response)
        local responseData = checkTable(response.data)
        if response.errCode ~= 0 then
            GameUtils.Toast(localize(response.errMsg))
            return
        end

        -- GoodsUtils.ConsumeGoods({{goodsId=fairylandQuestVo.consume, num=fairylandQuestVo.number}})
        self.dojo.hpData.hp = self.dojo.hpData.hp - fairylandQuestVo.number
        self.dojo:UpdateSecretInfo(questId, responseData.secretInfo)
        FairylandUtils.CurrentEnterQuestId = questId
        UIModule.AddUIPage({ id = Constants.UITypeIds.UIActionFairylandStageSelectDialog})
    
        GameUtils.OpenLoadingPanel(
            UIArgs(Constants.UITypeIds.FairylandSceneEnter, {questId=fairylandQuestVo.id}),
            {}, Constants.LoadingType.Others, false
        )
    end)
end

function FairylandComponent:RequestGiveUpQuest(questId, cb)
    GameUtils.Request(Interfaces.CatClanSecretGiveUp, {copyId=questId}, function (request, response)
        local responseData = checkTable(response.data)
        -- self.dojo.secretInfo[questId] = responseData.secretInfo
        self.dojo:UpdateSecretInfo(questId, responseData.secretInfo)
        -- self.dojo.currentQuestId = 0
        if cb then
            cb()
        end
    end)
end

function FairylandComponent:CanChallenge(questId, index)
    local secretInfo = self.dojo.secretInfo[questId]
    if secretInfo == nil then
        return false
    end

    if index == ConstantsFairyland.SelectNodeIndex.Mirror then
       return secretInfo.energy >= ConstantsFairyland.MirrorEnergyStage.Max 
    else
        return secretInfo.progress < secretInfo.completeMax
    end
end

function FairylandComponent:FightEnter(levelId, args, dialogArguments)
    local isMirrorQuest = levelId == Constants.SpecialQuestId.Mirror

    local battleEnterReqId = isMirrorQuest and Interfaces.CatClanSecretImageAt or Interfaces.CatClanSecretAt
    local battleEndReqId = isMirrorQuest and Interfaces.CatClanSecretImageGrade or Interfaces.CatClanSecretGrade
    local battleEnterReqBody = {questId=levelId, copyId=FairylandUtils.CurrentEnterQuestId}

    ---@type FightPreWarMgr
    local fightPreWarMgr = FightPreWarMgr:GetInstance()

    GameUtils.Request(battleEnterReqId, battleEnterReqBody, function(request, response)
        if checkNumber(response.errCode) ~= 0 then
            fightPreWarMgr:SetArgs(args)
            fightPreWarMgr:BattleEnterErrorHandle(levelId)
            return
        end

        local responseData = checkTable(response.data)
        -- fightPreWarMgr:BattleBeforHandle(questId)

        -- 更新编队的最大战力
        if responseData.battleData then
            local power = fightPreWarMgr:GetMyPlayerTotalPower(responseData.battleData)
            local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent)
            playerComponent.playerDojo:UpdateHistoryTeamsPower(power)
        end

        responseData.isRecord = checkNumber(args.isRecord)
        --保存战斗数据
        fightPreWarMgr:SetFightData(responseData, args)

        BattleMgr = import('Game.Battle.Core.BattleMgr')
        BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
        BattleMgr.gameMode = Constants.GameMode.PVE
        BattleViewMgr.gameMode = Constants.GameMode.PVE
        if checkNumber(args.index) > 1 then
            BattleViewMgr:RestartBattle(responseData.battleData)
        else
            UIModule.ResetStack()
            --进入战斗场景
            GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.BattleScene, parameters = {
                questId = levelId, path = battleEndReqId, body = { questId = levelId, copyId=FairylandUtils.CurrentEnterQuestId }, callback = function ()
                    UIModule.ResetStack()
                    FairylandUtils.EnterFairylandScene()
                end
            }}, dialogArguments, Constants.LoadingType.Others)
        end
    end)
end

function FairylandComponent:FightFinish(args, argument)
    GameUtils.Request(argument.path, argument.body, function(request, response)
        if checkNumber(response.errCode) == 0 then
            ---@type FightPreWarMgr
            local fightPreWarMgr = FightPreWarMgr:GetInstance()
            
            local showTimeCountDown = false
            local countDownCallback

            local responseData = checkTable(response.data)


            FairylandUtils.LastEnergy = self.dojo.secretInfo[FairylandUtils.CurrentEnterQuestId].energy
            -- 普通关卡胜利返回幻境场景需播放动效，记录所需信息
            -- 镜像关卡已经充能完毕则不播放动效
            if argument.questId ~= Constants.SpecialQuestId.Mirror and checkInt(responseData.isPassed) > 0 and FairylandUtils.LastEnergy < ConstantsFairyland.MirrorEnergyStage.Max then
                FairylandUtils.LastCombatIndex = FairylandUtils.CurrentNearIndex
                FairylandUtils.LastLevelId = checkNumber(argument.questId)
                FairylandUtils.PlayLevelSettlement = true
                if FairylandUtils.LastEnergy < ConstantsFairyland.MirrorEnergyStage.Max and responseData.secretInfo.energy >= ConstantsFairyland.MirrorEnergyStage.Max then
                    FairylandUtils.PlayMirrorOpen = true
                end
            end

            -- self:BattleEndHandle(responseData.questId, responseData, args, argument)
            self.dojo:UpdateSecretInfo(FairylandUtils.CurrentEnterQuestId, responseData.secretInfo)

            if self.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) then
                FairylandUtils.ResetLevelCache()
                FairylandUtils.ShowFinish = true
            end

            -- 更新玩家奖励
            fightPreWarMgr:UpdateRewards(responseData)
            -- 更新玩家经验
            local playerOldLevel = fightPreWarMgr:UpdatePlayerExp(responseData)
            -- 更新卡牌经验
            local cardExpInfo = fightPreWarMgr:UpdateCardExp(responseData)
            
            UIModule.OpenDialog({ id = Constants.UITypeIds.UIBattleEndDialog, parameters = {
                questId = checkNumber(argument.questId),
                isPassed = checkNumber(responseData.isPassed),
                --(checkBool(args.isWin) and 1 or 0)),
                starIds = checkString(argument.starIds),
                response = responseData,
                callback = function()
                    if argument.callback then
                        argument.callback(clone(responseData.rewards))
                    end
                end,
                startable = responseData.starInfo,
                mazeArg = { pointStr = argument.body.pointStr, pointName = argument.body.pointName },
                playerOldLv = playerOldLevel,
                cardExpInfo = cardExpInfo,
                needShowAnnihilationPopup = false,
                showTimeCountDown = showTimeCountDown,
                countDownCallback = countDownCallback,
                isMirror = argument.path == Interfaces.CatClanSecretImageGrade
            } })

        elseif checkNumber(response.errCode) == 101 then
            -- 超时，返回登陆
            local _funcBackToLogin = function()
                if BattleViewMgr then
                    BattleViewMgr:OnDestroy()
                    BattleViewMgr = nil
                end
                GameUtils.BackToGameStart()
            end
            GameUtils.SecondConfirm(localize('游戏超时，请退出游戏重新登录'), function()
                _funcBackToLogin()
            end, function()
                _funcBackToLogin()
            end)
        else
            local _functionBackToFightReady = function()
                Events.Broadcast(Constants.EventNames.UIBattlingBackToFightReady)
                local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
                UIBattlingCtrlMgr:GetInstance():BackToFightReadyCommon()
                
            end
            local _getDescFromQuestType = function()
                return checkString(response.errMsg) .. " T_T "
            end
            GameUtils.SecondConfirm(_getDescFromQuestType(), function()
                _functionBackToFightReady()
            end, function()
                _functionBackToFightReady()
            end)
        end
    end)
end

function FairylandComponent:GetFightEndArgs(battleFinishData)
    local isPassed = (checkBool(battleFinishData.isWin) and 1 or 0)
    local questBattleData = checkString(battleFinishData.recordData)

    local argument = UIModule.CurrentScreen.Argument.parameters
    argument.body = { isPassed = isPassed, questBattleData = questBattleData }

    return argument
end

function FairylandComponent:GetConfigParamsById(id)
    ---@type BaseArgVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6163, "FairylandParameterVo", id)
    if vo == nil then
        printError("12队副本参数表中未找到 %s", id)
        return 0
    end
    return vo.num
end

return FairylandComponent
