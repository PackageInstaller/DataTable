---
--- 乱流幻境场景难度选择节点
--- Author: dawanfan
--- Date: 2024-1-16 18:53:30
---


local DynamicUINode3D = import("Game.UI.Fairyland.DynamicUINode3D")
-- ---@type FairylandComponent
-- local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local FairylandMgr = import("Game.Fairyland.FairylandMgr")

local Vector3 = CS.UnityEngine.Vector3


--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandDifficultySelectNode.prefab > name: ActionFairylandDifficultySelectNode
---@class FairylandSceneSelectNode: DynamicUINode
---@field Env                           	FairylandSceneSelectNode                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field SelectButton                  	UnityEngine.RectTransform               	0    
---@field DifficultyText                	UnityEngine.RectTransform               	1    
---@field ChallengeProgressText         	UnityEngine.RectTransform               	2    
---@field BossSchedule                  	UnityEngine.RectTransform               	3    
---@field ImgDifficIcon                 	UnityEngine.RectTransform               	4    
---@field rectTransform                 	UnityEngine.RectTransform               	5    
---@field canvas                        	UnityEngine.Canvas                      	6    
---@field selectAnimation               	UnityEngine.RectTransform               	7    
local FairylandSceneSelectNode = Class("FairylandSceneSelectNode", DynamicUINode3D)

function FairylandSceneSelectNode:Awake()
    SetButtonAction(self.SelectButton, Bind(self, self.OnNodeClick))
    self.selected = false
    self.__OnNearBall = Bind(self, self.OnNearBall)
    Events.AddListener(Constants.EventNames.FairylandSceneNearBall, self.__OnNearBall)
end

function FairylandSceneSelectNode:OnDestroy()
    Events.RemoveListener(Constants.EventNames.FairylandSceneNearBall, self.__OnNearBall)
    self.controller = nil
    self:Delete()
    self = nil
end

---@param ball FairylandBall
function FairylandSceneSelectNode:DoInit(ball)
    self.ball = ball

    self:RefreshUI()
end

function FairylandSceneSelectNode:GetPosition3D()
    return self.ball:GetSceneNodePosition()
end

function FairylandSceneSelectNode:RefreshUI()
    local index = self.ball.index
    ---@type FairylandComponent
    local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    local levelInfo = FairylandComponent.dojo:GetLevelInfo(FairylandUtils.CurrentEnterQuestId, index)

    if index == ConstantsFairyland.SelectNodeIndex.Mirror then
        self.controller.gameObject.transform.localScale = Vector3.one * self.ball:GetTitleScale()
    end

    CfUtils.SetUISwitchImage(self.ImgDifficIcon, levelInfo.difficulty)

    if index ~= ConstantsFairyland.SelectNodeIndex.Mirror then
        CfUtils.FillText(self.DifficultyText, localize("难度") .. tostring(levelInfo.difficulty))
    else
        CfUtils.FillText(self.DifficultyText, ConstantsFairyland.MirrorLevelName)
        CfUtils.SetActive(self.BossSchedule, true)
        CfUtils.FillText(self.ChallengeProgressText, tostring(levelInfo.energy) .. "%")
    end

end

function FairylandSceneSelectNode:OnNodeClick()
    local fairylandMgr = FairylandMgr.GetInstance()
    if not fairylandMgr:CheckNeedMoveToPosition(self.ball.index, 0.5) then
        fairylandMgr:WalkAroundBall(self.ball.index)
    else
        fairylandMgr:GoToPosition(self.ball.index, 0.5)
    end
end

function FairylandSceneSelectNode:OnNearBall(isNear, index)

    if index == self.ball.index then
        if isNear then
            CfUtils.SetActive(self.selectAnimation, true)
            ---@type FairylandComponent
            local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
            local levelInfo = FairylandComponent.dojo:GetLevelInfo(FairylandUtils.CurrentEnterQuestId, index)
            CfUtils.PlayAnimation(self.selectAnimation, string.format("ActionFairylandDifficultySelectNode_difficult%s", levelInfo.difficulty), true)
            self.selected = true
        else
            CfUtils.SetActive(self.selectAnimation, false)
            self.selected = false
        end
    elseif self.selected and isNear then
        CfUtils.SetActive(self.selectAnimation, false)
        self.selected = false
    end

end

return FairylandSceneSelectNode
