local BoardSelectedCtrl = class("BoardSelectedCtrl", BaseCtrl)
local PlayerHandbookData = PlayerData.Handbook
BoardSelectedCtrl._mapNodeConfig = {
  goEmpty = {},
  goSelected = {},
  imgIcon = {sComponentName = "Image"},
  imgRare = {sComponentName = "Image"},
  imgCornerRole = {},
  imgCornerOutfit = {},
  btnItem = {
    sComponentName = "Button",
    callback = "OnBtnClick_Item"
  }
}

function BoardSelectedCtrl:Refresh(idx, id, bIsSelected)
  local bEmpty = nil == id
  self.nHandbookId = id
  self._mapNode.goEmpty.gameObject:SetActive(true)
  self._mapNode.goSelected.gameObject:SetActive(not bEmpty)
  if not bEmpty then
    local handbookData = PlayerHandbookData:GetHandbookDataById(id)
    if nil == handbookData then
      return
    end
    self._mapNode.imgCornerRole.gameObject:SetActive(handbookData:GetType() == GameEnum.handbookType.SKIN)
    self._mapNode.imgCornerOutfit.gameObject:SetActive(handbookData:GetType() == GameEnum.handbookType.OUTFIT)
    if handbookData:GetType() == GameEnum.handbookType.SKIN then
      local charCfgData = handbookData:GetCharCfgData()
      if nil ~= charCfgData then
        local rareIconName = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[charCfgData.Grade]
        self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", rareIconName)
        NovaAPI.SetImageNativeSize(self._mapNode.imgRare)
      end
      local charSkinCfgData = handbookData:GetSkinCfgData()
      if nil ~= charSkinCfgData then
        self:SetPngSprite(self._mapNode.imgIcon, charSkinCfgData.Icon, AllEnum.CharHeadIconSurfix.XXL)
      end
    elseif handbookData:GetType() == GameEnum.handbookType.OUTFIT then
      local discCfgData = handbookData:GetDiscCfgData()
      local outfitItemCfgData = handbookData:GetDiscItemCfgData()
      if nil ~= discCfgData and nil ~= outfitItemCfgData then
        self:SetPngSprite(self._mapNode.imgIcon, outfitItemCfgData.Icon .. AllEnum.OutfitIconSurfix.ListGrid)
        local sPath = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[outfitItemCfgData.Rarity]
        self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sPath)
        NovaAPI.SetImageNativeSize(self._mapNode.imgRare)
      end
    end
    if bIsSelected == true then
      self._mapNode.goSelected.transform.localScale = Vector3(0.5, 0.5, 1)
      self._mapNode.goSelected.transform:DOScale(1, 0.2):SetUpdate(true):SetEase(Ease.OutBack)
    end
  end
end

function BoardSelectedCtrl:OnBtnClick_Item()
  if nil ~= self.nHandbookId then
    EventManager.Hit(EventId.BoardSelectItem, self.nHandbookId)
  end
end

return BoardSelectedCtrl
