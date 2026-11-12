local MiningGameGuideCardCtrl = class("MiningGameGuideCardCtrl", BaseCtrl)
MiningGameGuideCardCtrl._mapNodeConfig = {
  btn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Selected"
  },
  img_selected = {},
  iconTra = {
    sNodeName = "img_icon",
    sComponentName = "RectTransform"
  },
  img_icon = {sComponentName = "Image"},
  img_type = {nCount = 4}
}
MiningGameGuideCardCtrl._mapEventConfig = {
  MiningGame_SelectedCard = "OnEvent_SelectedCard"
}
MiningGameGuideCardCtrl._mapRedDotConfig = {}

function MiningGameGuideCardCtrl:SetData(id)
  local config = ConfigTable.GetData("MiningTreasure", id)
  if config == nil then
    return
  end
  self.nId = id
  if config.Icon ~= "" then
    self:SetPngSprite(self._mapNode.img_icon, config.Icon)
    self._mapNode.iconTra.localRotation = Quaternion.Euler(0, 0, config.SelfRotate)
  end
  for index, go in pairs(self._mapNode.img_type) do
    if index == config.MiningItemType then
      go:SetActive(true)
    else
      go:SetActive(false)
    end
  end
end

function MiningGameGuideCardCtrl:SetSelected(id)
  if id == self.nId then
    self._mapNode.img_selected:SetActive(true)
  else
    self._mapNode.img_selected:SetActive(false)
  end
end

function MiningGameGuideCardCtrl:OnBtnClick_Selected()
  EventManager.Hit("MiningGame_SelectedCard", self.nId)
end

function MiningGameGuideCardCtrl:OnEvent_SelectedCard(id)
  self:SetSelected(id)
end

return MiningGameGuideCardCtrl
