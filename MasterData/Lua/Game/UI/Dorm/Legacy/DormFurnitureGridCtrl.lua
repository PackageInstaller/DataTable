local DormFurnitureGridCtrl = class("DormFurnitureGridCtrl", BaseCtrl)
DormFurnitureGridCtrl._mapNodeConfig = {
  tc_item_01 = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgSelect = {},
  TMPTempName = {sComponentName = "TMP_Text"}
}
DormFurnitureGridCtrl._mapEventConfig = {}
DormFurnitureGridCtrl._mapRedDotConfig = {}

function DormFurnitureGridCtrl:Awake()
  self.nItemId = 0
  self.nItemCount = 0
end

function DormFurnitureGridCtrl:FadeIn()
end

function DormFurnitureGridCtrl:FadeOut()
end

function DormFurnitureGridCtrl:OnEnable()
end

function DormFurnitureGridCtrl:OnDisable()
end

function DormFurnitureGridCtrl:OnDestroy()
end

function DormFurnitureGridCtrl:OnRelease()
end

function DormFurnitureGridCtrl:Refresh(nItemId, nCount)
  self.nItemId = nItemId
  self.nItemCount = nCount
  local mapFurnitureConfig = ConfigTable.GetData("Item", nItemId)
  if mapFurnitureConfig ~= nil then
    NovaAPI.SetTMPText(self._mapNode.TMPTempName, mapFurnitureConfig.Title)
  end
  self._mapNode.tc_item_01:SetItem(nItemId, nil, nCount, nil, nil, nil, nil, false)
end

function DormFurnitureGridCtrl:SetSelect(bSelected)
  self._mapNode.imgSelect:SetActive(bSelected)
end

function DormFurnitureGridCtrl:SetCount(nCount)
  self.nItemCount = nCount
  self._mapNode.tc_item_01:SetItem(self.nItemId, nil, nCount, nil, nil, nil, nil, false)
end

return DormFurnitureGridCtrl
