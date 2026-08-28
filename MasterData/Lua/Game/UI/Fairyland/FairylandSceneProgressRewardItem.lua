---
--- 乱流幻境累计奖励 Item
--- Author: dawanfan
--- Date: 2024-1-17 11:33:15
---

local UIEventProxy = CS.Engine.UI.UIEventProxy


---@type FairylandComponent
local FairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
local FairylandUtils = import("Game.Fairyland.FairylandUtils")
local ConstantsFairyland = import("Game.Fairyland.ConstantsFairyland")

--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandDifficultySelectDialog.prefab > name: RewardItem1
---@class FairylandSceneProgressRewardItem
---@field Env                           	FairylandSceneProgressRewardItem        
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgCompleted                  	UnityEngine.RectTransform               	@ 0    
---@field ImgGood                       	UnityEngine.RectTransform               	@ 1    
---@field ReceiveParticle               	UnityEngine.RectTransform               	@ 2    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 3    
local FairylandSceneProgressRewardItem = Class("FairylandSceneProgressRewardItem")

function FairylandSceneProgressRewardItem:__init()
    
end

function FairylandSceneProgressRewardItem:__delete()
    
end

---@param index number
---@param questProgressRewardVo FairylandQuestRewardsVo | nil
function FairylandSceneProgressRewardItem:Init(index, questProgressRewardVo)
    self.index = index
    ---@type FairylandQuestRewardsVo[]
    self.questProgressRewardVo = FairylandUtils.GetQuestProgressRewardVos(FairylandUtils.CurrentEnterQuestId)
    self.progress = self.questProgressRewardVo[self.index].progress

    if questProgressRewardVo then
        self.questProgressRewardVo = questProgressRewardVo
        self.rewards = {}
        for i = 1, #self.questProgressRewardVo.progressReward do
            table.insert(self.rewards, {goodsId=self.questProgressRewardVo.progressReward[i], num=self.questProgressRewardVo.rewardNumber[i]})
        end
        CfUtils.GetOrAddComponent(self.controller.gameObject, typeof(UIEventProxy)).onPointerClick = function()
            self:OnItemClick()
        end
    end

    CfUtils.FillText(self.TxtNum, self.progress)
end

function FairylandSceneProgressRewardItem:Refresh(progress)
    if IsNull(progress) then
        progress = FairylandComponent.dojo:GetRewardProgress()
    end
    if self.progress <= progress then
        CfUtils.SetUISwitchImage(self.ImgGood, 2)
        if FairylandComponent.dojo:IsProgressRewardTake(FairylandUtils.CurrentEnterQuestId, self.progress) then
            CfUtils.SetActive(self.ReceiveParticle, false)
            CfUtils.SetActive(self.ImgCompleted, true)
        else
            CfUtils.SetActive(self.ReceiveParticle, true)
            CfUtils.SetActive(self.ImgCompleted, false)
        end
    else
        CfUtils.SetUISwitchImage(self.ImgGood, 1)
    end
end


function FairylandSceneProgressRewardItem:SetState(state)
    if state == ConstantsFairyland.ProgressRewardState.NotTrigger then
        CfUtils.SetUISwitchImage(self.ImgGood, 1)
    else
        CfUtils.SetUISwitchImage(self.ImgGood, 2)
        if state == ConstantsFairyland.ProgressRewardState.CanTake then
            CfUtils.SetActive(self.ReceiveParticle, true)
            CfUtils.SetActive(self.ImgCompleted, false)
        else
            CfUtils.SetActive(self.ReceiveParticle, false)
            CfUtils.SetActive(self.ImgCompleted, true)
        end
    end

end

function FairylandSceneProgressRewardItem:OnItemClick()
    GameUtils.ShowCommonTipsBoardRewardPreview(self.controller.gameObject, self.rewards)
end

function FairylandSceneProgressRewardItem:OnDestroy()
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return FairylandSceneProgressRewardItem
