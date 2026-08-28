---
--- 乱流幻境关卡界面
--- Author: dawanfan
--- Date: 2024-1-15 18:58:56
---

local util = require 'XLua.util'
local UIModule = CS.Engine.UI.UIModule
local Yielders = CS.Engine.Lib.Yielders
local CoWait = CS.Engine.Lib.CoWait
local FontStyleButton = CS.Game.Native.Common.FontStyleButton
local cs_coroutine = require('XLua.cs_coroutine')

---@type DreamSpaceStates
local DreamSpaceStates = import('Game.DreamSpace.Tools.DreamSpaceStates')
---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")
local FairylandUtils = import("Game.Fairyland.FairylandUtils")


--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandLevelDetailsDialog.prefab > name: ActionFairylandLevelDetailsDialog
---@class FairylandLevelDetailsDialog
---@field Env                           	FairylandLevelDetailsDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RewardList                    	UnityEngine.RectTransform               
---@field BtnStartBattle                	UnityEngine.RectTransform               
---@field ProgressAddText               	UnityEngine.RectTransform               
---@field RecommendPowerText            	UnityEngine.RectTransform               
---@field ActionFairylandBossDetailsNode	UnityEngine.RectTransform               
---@field dynamicRectTransform          	UnityEngine.RectTransform               
---@field RewardItem1                   	UnityEngine.RectTransform               
---@field TxtName                       	UnityEngine.RectTransform               
local FairylandLevelDetailsDialog = Class("FairylandLevelDetailsDialog")

function FairylandLevelDetailsDialog:__init()
    
end

function FairylandLevelDetailsDialog:__delete()
    
end

function FairylandLevelDetailsDialog:Awake()
    SetButtonAction(self.BtnStartBattle, Bind(self, self.OnStartBattleClick))
end

function FairylandLevelDetailsDialog:OnShow()
    ---@type Engine.Lib.CoWait
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        self:FillSelf()
    end))
    return coWait
end

function FairylandLevelDetailsDialog:OnFocus()
    
end

function FairylandLevelDetailsDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(
        util.cs_generator(
            function ()
                local initParams = self.controller.Argument.parameters or {}
                self.index = initParams.index
                
                DreamSpaceStates.LockInput_ByCount(DreamSpaceStates.InputLockState.Lock)
                DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Lock)

                CfUtils.StartCoroutineWithBlocker(function ()
                    Events.Broadcast(Constants.EventNames.FairylandLevelDetailDialogLoad, self.index)
                    cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
                end)
            end
        )
    )

    return coWait
end

function FairylandLevelDetailsDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()

        DreamSpaceStates.LockInput_ByCount(DreamSpaceStates.InputLockState.Unlock)
        DreamSpaceStates.LockViewRotate_ByFlag(DreamSpaceStates.InputLockState.Unlock)

        self.controller = nil
        self:Delete()
        self = nil
    end))
    return coWait
end

function FairylandLevelDetailsDialog:FillSelf()
    local levelInfo = FairylandComponent.dojo:GetLevelInfo(FairylandUtils.CurrentEnterQuestId, self.index)
    
    CfUtils.FillText(self.RecommendPowerText, levelInfo.proposalLevel)
    if self.index ~= ConstantsFairyland.SelectNodeIndex.Mirror then
        CfUtils.FillText(self.ProgressAddText, "+" .. tostring(levelInfo.scale * 100) .. "%")
        CfUtils.FillText(self.TxtName, levelInfo.name)
    else
        CfUtils.SetActive(self.RewardItem1, false)
        CfUtils.SetActive(self.RewardList, true)
        CfUtils.FillText(self.TxtName, ConstantsFairyland.MirrorLevelName)

        local luaScr = CfUtils.GetLuaScr(self.RewardList, "Game.Behaviours.CommonGoodsListLight")
        if luaScr then
            luaScr:FreshBaseUI(levelInfo.rewards)
        end
    end

    self.BtnStartBattle:GetComponent(typeof(FontStyleButton)):ResetFontStyle(FairylandComponent:CanChallenge(FairylandUtils.CurrentEnterQuestId, self.index) and "B1" or "B17")
end

function FairylandLevelDetailsDialog:OnStartBattleClick()

    if not FairylandComponent:CanChallenge(FairylandUtils.CurrentEnterQuestId, self.index) then
        if self.index == ConstantsFairyland.SelectNodeIndex.Mirror then
            GameUtils.Toast(localize("暂未开启，请先通关普通关卡充能"))
        else
            GameUtils.Toast(localize("挑战次数不足"))
        end
        return
    end

    if self.index ~= ConstantsFairyland.SelectNodeIndex.Mirror then
        local levelInfo = FairylandComponent.dojo:GetLevelInfo(FairylandUtils.CurrentEnterQuestId, self.index)
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIFightTeamChoose,
                                    parameters = { levelId = levelInfo.id, routerType = Constants.BattleRouterType.Fairyland } },
                                        { { id = Constants.UITypeIds.FairylandLevelDetailsDialog, params={index=self.index}}})
    else
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIFightTeamChoose,
            parameters = { levelId = Constants.SpecialQuestId.Mirror, routerType = Constants.BattleRouterType.Fairyland } },
                { { id = Constants.UITypeIds.FairylandLevelDetailsDialog, params={index=self.index}}})
    end
end

---@param ball FairylandBall | FairylandMirror
function FairylandLevelDetailsDialog:InitDynamicNode(ball)
    self.ballScr = ball

    if ball.index ~= ConstantsFairyland.SelectNodeIndex.Mirror then
        CfUtils.SetActive(ball.Head, true)
    else
        CfUtils.SetActive(self.ActionFairylandBossDetailsNode, true)
        local nodeScr = CfUtils.GetLuaScr(self.ActionFairylandBossDetailsNode, "Game.UI.Fairyland.UIFairylandBossDetailsNode")
        nodeScr:FillSelf()
        local nodePosition = ball:GetDetailsNodePosition()
        local newAnchoredPosition = CfUtils.WorldPosition2UIPosition(nodePosition, self.dynamicRectTransform, nil)
        self.ActionFairylandBossDetailsNode.anchoredPosition = newAnchoredPosition
    end
end


return FairylandLevelDetailsDialog
