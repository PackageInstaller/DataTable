require("ui_item_node")
_class("UIN33ItemNormalNode", UIItemNodeBase)
UIN33ItemNormalNode = UIN33ItemNormalNode

function UIN33ItemNormalNode:OnInit()
  self._num = self._uiView:GetUIComponent("UILocalizationText", "Text")
  self._icon = self._uiView:GetUIComponent("RawImageLoader", "RawImageItem")
  self._imgType = {}
  self._imgType[0] = self._uiView:GetGameObject("ImageType1")
  self._imgType[1] = self._uiView:GetGameObject("ImageType2")
end

function UIN33ItemNormalNode:OnShow()
  self._num:SetText("X" .. self._uiItemData.count)
  self._icon:LoadImage(self._uiItemData.icon)
  self._imgType[0]:SetActive(self._uiItemData.awardType == ECampaignLRType.E_CLRT_big)
  self._imgType[1]:SetActive(self._uiItemData.awardType == ECampaignLRType.E_CLRT_rare)
end

function UIN33ItemNormalNode:OnHide()
end
