---
---
--- Author: dawanfan
--- Date: 2024-1-26 10:10:01
---

local FairylandUtils = import("Game.Fairyland.FairylandUtils")


--- from: Assets/BundleResources/Prefabs/Action/ActionFairylandFinishPopup.prefab > name: DetailItem1
---@class FairylandFinishPopupDetailItem
---@field Env                           	FairylandFinishPopupDetailItem          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextChallengeTimes            	UnityEngine.RectTransform               
local FairylandFinishPopupDetailItem = Class("FairylandFinishPopupDetailItem")

function FairylandFinishPopupDetailItem:Initialize(index)
    self.index = index
    self:RefreshUI()
end

function FairylandFinishPopupDetailItem:RefreshUI()
    local fairylandComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent)
    CfUtils.FillText(self.TextChallengeTimes, fairylandComponent.dojo:GetQuestDifficultChallengeTimes(FairylandUtils.CurrentEnterQuestId, self.index))
end

function FairylandFinishPopupDetailItem:OnDestroy()
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
    self = nil
end

return FairylandFinishPopupDetailItem
