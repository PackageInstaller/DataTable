local SoldierItemGridCtrl = class("SoldierItemGridCtrl", BaseCtrl)
local RootPath = "Icon/SoldierOtherIcon/"
SoldierItemGridCtrl._mapNodeConfig = {
  img_rarity = {sComponentName = "Image"},
  img_icon = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"}
}
SoldierItemGridCtrl._mapEventConfig = {
  SoldierHandbookStrategyCard_Selected = "OnEvent_SoldierHandbookStrategyCard_Selected"
}
SoldierItemGridCtrl._mapRedDotConfig = {}

function SoldierItemGridCtrl:SetItem(nRarity, nCount, sIcon, nItemId)
  self:SetPngSprite(self._mapNode.img_rarity, RootPath .. AllEnum.SoldierItemRarityIcon[nRarity])
  if sIcon ~= nil and sIcon ~= "" then
    self:SetPngSprite(self._mapNode.img_icon, sIcon)
  end
  if 0 < nCount then
    self._mapNode.txtCount.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtCount, nCount)
  else
    self._mapNode.txtCount.gameObject:SetActive(false)
  end
  if nItemId ~= nil and 0 < nItemId then
    self.btnSelf = self.gameObject:GetComponent("UIButton")
    if self.btnSelf ~= nil then
      self.btnSelf.onClick:RemoveAllListeners()
      self.btnSelf.onClick:AddListener(function()
        UTILS.ClickItemGridWithTips(nItemId, self.gameObject.transform, true)
      end)
    end
  end
end

function SoldierItemGridCtrl:OnDisable()
  if self.btnSelf ~= nil then
    self.btnSelf.onClick:RemoveAllListeners()
    self.btnSelf = nil
  end
end

return SoldierItemGridCtrl
