---
--- 乱流幻境场景界面
--- Author: dawanfan
--- Date: 2024-1-11 18:01:05
---

local util = require 'XLua.util'


local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local UIModule = CS.Engine.UI.UIModule
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local BehaviorExecutedAfterCMBrain = CS.DreamSpace.BehaviorExecutedAfterCMBrain
local Vector2 = CS.UnityEngine.Vector2


---@type LuaParametersReader
local LuaParametersReader = import('Game.Utils.LuaParametersReader')
local LuaParametersType = LuaParametersReader.Type
local LuaParameters = CS.Engine.Modules.LuaParameters

---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local FairylandMgr = import("Game.Fairyland.FairylandMgr")
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")

---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')
local KeyboardInfo = DreamSpaceStates.KeyboardInfo
local KeyboardInputMap = import("Game.DreamSpace.CharacterController.KeyboardInputMap")

local GlobalsInDreamSpace = CS.DreamSpace.GlobalsInDreamSpace


--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandDifficultySelectDialog.prefab > name: ActionFairylandDifficultySelectDialog
---@class FairylandSceneDialog
---@field Env                           	FairylandSceneDialog                    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field SelectNodePrefab              	UnityEngine.RectTransform               	0    
---@field Dynamic                       	UnityEngine.RectTransform               	1    
---@field Slilder                       	UnityEngine.UI.Slider                   	2    
---@field ProgressRewardGroup           	UnityEngine.RectTransform               	3    
---@field RewardProgressText            	UnityEngine.RectTransform               	4    
---@field BtnBattle                     	UnityEngine.RectTransform               	5    
---@field BtnMirrorChallenge            	UnityEngine.RectTransform               	6    
---@field ChallengeGoHighlight          	UnityEngine.RectTransform               	7    
---@field ChallengeGoText               	UnityEngine.RectTransform               	8    
---@field ChallengeProgressText         	UnityEngine.RectTransform               	9    
---@field PcTips                        	UnityEngine.RectTransform               	10   
---@field etcJoyStickGo                 	UnityEngine.RectTransform               	11   
---@field TextBattleInteractTip         	UnityEngine.RectTransform               	12   
local FairylandSceneDialog = Class("FairylandSceneDialog")

function FairylandSceneDialog:__init()
    ---@type FairylandSceneProgressRewardItem[]
    self.progressRewardsScr = {}
    ---@type FairylandSceneSelectNode[]
    self.selectNodeScrs = {}

    self.__OnNearBall = Bind(self, self.OnNearBall)
    Events.AddListener(Constants.EventNames.FairylandSceneNearBall, self.__OnNearBall)
end

function FairylandSceneDialog:__delete()
    self.progressRewardsScr = {}
    self.selectNodeScrs = {}
    Events.RemoveListener(Constants.EventNames.FairylandSceneNearBall, self.__OnNearBall)
end

function FairylandSceneDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        local navigatorScr = CfUtils.GetLuaScr(CS.UINavigationBarRoot.Instance.gameObject, "Game.Main.UINavigatorBar")
        if navigatorScr then
            navigatorScr:SetCustomBackHandlerAction(function()
                self:OnNavigatorBackClick()
            end)
        end
        self:FillSelf()

        self:RegisterInputFunc()
    end))
    return coWait
end

function FairylandSceneDialog:OnNavigatorBackClick()

    local backFunc = function ()
        FairylandUtils.CurrentNearIndex = 0

        local parameters = {
            isBackToHomeScene = true,
            isSaveSceneRecord = true, 
            isReleaseBattle   = true,
            extraUIPages = {
                UIArgs(Constants.UITypeIds.UIActionPrimaryMapDialog),
                UIArgs(Constants.UITypeIds.UIActionFairylandStageSelectDialog),
            }
        }

        GameUtils.OpenLoadingPanel(UIArgs(Constants.UITypeIds.UISceneHome, parameters), nil, Constants.LoadingType.Others, false, true)
    end
    
    if FairylandComponent.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) then
        FairylandComponent:RequestGiveUpQuest(FairylandUtils.CurrentEnterQuestId, backFunc)
    else
        backFunc()
    end
end

function FairylandSceneDialog:OnHide()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        CfUtils.ResetNavigatorCustomBackAction()
        self:UnRegisterInputFunc()
    end))
    return coWait
end

function FairylandSceneDialog:Awake()
    --self.etcJoyStick = CfUtils.GetLuaScr(self.etcJoyStickGo, "Game.Behaviours.ETCJoystick")
    SetButtonAction(self.BtnBattle, Bind(self, self.OnBtnBattleClick))
    SetButtonAction(self.BtnMirrorChallenge, Bind(self, self.OnBtnMirrorClick))

    self.behaviorAction = KTool.GetOrAddComponent(self.controller.gameObject, typeof(BehaviourAction))
    self.behaviorAction.LateUpdateAction = Bind(self, self.LateUpdate)

    self.behaviorExecutedAfterCMBrain = KTool.GetComponent(self.controller.gameObject, typeof(BehaviorExecutedAfterCMBrain))
    self.__LateUpdateDynamicUI = Bind(self, self.LateUpdateDynamicUI)
    self.behaviorExecutedAfterCMBrain:INTERNAL_LateUpdate( '+', self.__LateUpdateDynamicUI )

end

function FairylandSceneDialog:OnFocus() end

function FairylandSceneDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                self:InitData()

                for i = 1, 3 do
                    local rewardItemGo = self.ProgressRewardGroup.transform:Find("RewardItem" .. i)
                    if self.questProgressRewardVo[i] ~= nil then
                        CfUtils.SetActive(rewardItemGo, true)
                        self.progressRewardsScr[i] = CfUtils.GetLuaScr(rewardItemGo, "Game.UI.Fairyland.FairylandSceneProgressRewardItem")
                        self.progressRewardsScr[i]:Init(i, self.questProgressRewardVo[i])
                    else
                        CfUtils.SetActive(rewardItemGo, false)
                    end
                end

                if DreamSpaceStates.isWindowsPlatform then
                    CfUtils.SetActive(self.PcTips, true)
                    CfUtils.SetActive(self.TextBattleInteractTip, true)
                else
                    -- self.leftJoystick = CfUtils.GetLuaScr(self.etcJoyStickGo.gameObject, "Game.Behaviours.ETCJoystick" )
                    -- self.leftJoystick:Active()
                end

                -- local playerInputSwitcher = GlobalsInDreamSpace.FindComponent("playerInputSwitcher")
                -- playerInputSwitcher.Env:Init()
                Events.Broadcast(Constants.EventNames.FairylandSceneDialogLoad)
            end
        )
    )

    return coWait
end

function FairylandSceneDialog:InitData()
    ---@type FairylandQuestRewardsVo[]
    self.questProgressRewardVo = FairylandUtils.GetQuestProgressRewardVos(FairylandUtils.CurrentEnterQuestId) --CfUtils.GetCfVo(AutoIds.IdSetting6161, "FairylandQuestRewardsVo", FairylandUtils.CurrentEnterQuestId)
    
end

function FairylandSceneDialog:FillSelf()
    -- 镜像挑战 Btn
    local secretInfo = FairylandComponent.dojo.secretInfo[FairylandUtils.CurrentEnterQuestId]
    local challengeProgress = tonumber(secretInfo.energy) / 10
    if challengeProgress == 100 then
        CfUtils.SetActive(self.ChallengeProgressText, false)
        CfUtils.SetActive(self.ChallengeGoHighlight, true)
    else
        CfUtils.SetActive(self.ChallengeProgressText, true)
        CfUtils.SetActive(self.ChallengeGoHighlight, false)
        CfUtils.FillText(self.ChallengeProgressText, tostring(challengeProgress) .. "%")
    end

    CfUtils.SetActive(self.BtnBattle, FairylandUtils.CurrentNearIndex ~= 0)

    -- 进度奖励
    for _, scr in pairs(self.progressRewardsScr) do
        scr:Refresh()
    end

    if #self.progressRewardsScr == 2 then
        self.progressRewardsScr[1].controller.transform.anchoredPosition = Vector2(110, 0)
        self.progressRewardsScr[2].controller.transform.anchoredPosition = Vector2(360, 0)
    end

    CfUtils.FillText(self.RewardProgressText, string.format("<color=#ffffff><size=50>%s</color></size>/%s", FairylandComponent.dojo:GetRewardProgress(), self.questProgressRewardVo[#self.questProgressRewardVo].progress))
    CfUtils.SetSliderPercent(self.Slilder, FairylandComponent.dojo:GetRewardProgress() / self.questProgressRewardVo[#self.questProgressRewardVo].progress)

    if FairylandComponent.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) and FairylandUtils.ShowFinish then
        UIModule.OpenDialog({id=Constants.UITypeIds.FairylandFinishPopupDialog}, {{ id = Constants.UITypeIds.FairylandSceneDialog }}, false)
        CfUtils.SetActive(self.BtnMirrorChallenge, false)
    end
end

---@param index number
---@param ball FairylandBall | FairylandMirror
function FairylandSceneDialog:InitBallNode(index, ball)
    if index ~= ConstantsFairyland.SelectNodeIndex.Mirror and not FairylandComponent:CanChallenge(FairylandUtils.CurrentEnterQuestId, index) then
        return
    elseif FairylandComponent.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) then
        return
    end

    if self.selectNodeScrs[index] ~= nil or IsNull(ball) then
        return
    end

    local fiarylandMgr = FairylandMgr.GetInstance()

    local go = CfUtils.InstantiateGo(self.SelectNodePrefab, fiarylandMgr.WorldSpaceCanvas)
    if go ~= nil then
        local selectScr = CfUtils.GetLuaScr(go, "Game.UI.Fairyland.FairylandSceneSelectNode")
        go.name = "SelectNode" .. tostring("index")
        if selectScr then
            selectScr:InitNode(fiarylandMgr.WorldSpaceCanvas, 40, 0, 0, ball)
            self.selectNodeScrs[index] = selectScr
            return selectScr
        end
    end

    return nil
end

function FairylandSceneDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        if self.behaviorAction ~= nil then
            self.behaviorAction.UpdateAction = nil
            self.behaviorAction.LateUpdateAction = nil
        end

        self.behaviorExecutedAfterCMBrain:INTERNAL_LateUpdate( '-', self.__LateUpdateDynamicUI )

        for _, ballNodeScr in pairs(self.selectNodeScrs) do
            CS.UnityEngine.GameObject.Destroy(ballNodeScr.controller.gameObject)
        end

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function FairylandSceneDialog:OnBtnBattleClick()
    if FairylandUtils.CurrentNearIndex == 0 then
        return
    end

    local fairylandMgr = FairylandMgr.GetInstance()
    if fairylandMgr:CheckNeedMoveToPosition(FairylandUtils.CurrentNearIndex, 0.5) then
        fairylandMgr:GoToPosition(FairylandUtils.CurrentNearIndex, 0.5, function ()
            self:DoBtnBattleClick()
        end)
    else
        self:DoBtnBattleClick()
    end
end

function FairylandSceneDialog:DoBtnBattleClick()
    Events.Broadcast(Constants.EventNames.FairylandSceneBattleClick, FairylandUtils.CurrentNearIndex)
    UIModule.OpenDialog({id=Constants.UITypeIds.FairylandLevelDetailsDialog, parameters={index=FairylandUtils.CurrentNearIndex}}, {
        { id = Constants.UITypeIds.FairylandSceneDialog }
    })
end

function FairylandSceneDialog:OnNearBall(isNear, index)
    if FairylandComponent.dojo:IsQuestFinished(FairylandUtils.CurrentEnterQuestId) then
        return
    end

    if isNear then
        FairylandUtils.CurrentNearIndex = index
        
        if index ~= ConstantsFairyland.SelectNodeIndex.Mirror then
            if FairylandComponent:CanChallenge(FairylandUtils.CurrentEnterQuestId, index) then
                CfUtils.SetActive(self.BtnBattle, true)
            end
        else
            CfUtils.SetActive(self.BtnBattle, true)
        end
    else
        if index == FairylandUtils.CurrentNearIndex then
            FairylandUtils.CurrentNearIndex = 0
            CfUtils.SetActive(self.BtnBattle, false)
        end
    end
end

function FairylandSceneDialog:LateUpdate()
    
end

function FairylandSceneDialog:LateUpdateDynamicUI()
    for _, selectNodeScr in pairs(self.selectNodeScrs) do
        selectNodeScr:UpdateUIPositionAndScale()
    end
end

function FairylandSceneDialog:OnBtnMirrorClick()
    local fairylandMgr = FairylandMgr.GetInstance()
    if not fairylandMgr:CheckNeedMoveToPosition(ConstantsFairyland.SelectNodeIndex.Mirror, 0.5) then
        fairylandMgr:WalkAroundBall(ConstantsFairyland.SelectNodeIndex.Mirror)
    else
        fairylandMgr:GoToPosition(ConstantsFairyland.SelectNodeIndex.Mirror, 0.5)
    end
end

function FairylandSceneDialog:ShowTip()
    local keyboardInputMap = KeyboardInputMap:GetInstance()
    keyboardInputMap:UnRegisterInput(KeyboardInfo.PcTipsKey)
    UIModule.OpenDialog({id=Constants.UITypeIds.FairylandInputPcTipsPopup, parameters={}}, {
        { id = Constants.UITypeIds.FairylandSceneDialog }
    }, false)
end

function FairylandSceneDialog:RegisterInputFunc()
    local keyboardInputMap = KeyboardInputMap:GetInstance()

    keyboardInputMap:UnRegisterInput(KeyboardInfo.PcTipsKey)
    keyboardInputMap:RegisterInput(KeyboardInfo.PcTipsKey, Bind(self, self.ShowTip))
    keyboardInputMap:RegisterInput(KeyboardInfo.InteractiveKey, Bind(self, self.OnBtnBattleClick))
end

function FairylandSceneDialog:UnRegisterInputFunc()
    local keyboardInputMap = KeyboardInputMap:GetInstance()
    keyboardInputMap:UnRegisterInput(KeyboardInfo.InteractiveKey)
end

return FairylandSceneDialog
