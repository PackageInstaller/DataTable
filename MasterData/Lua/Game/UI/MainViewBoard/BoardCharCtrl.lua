local BoardCharCtrl = class("BoardCharCtrl", BaseCtrl)
local PlayerHandbookData = PlayerData.Handbook
local PlayerBoardData = PlayerData.Board
BoardCharCtrl._mapNodeConfig = {
  imgChose = {},
  imgChoseMask = {},
  imgAnimMask = {},
  imgItemIcon = {sComponentName = "Image"},
  imgItemRare = {sComponentName = "Image"},
  imgChoseBg = {},
  imgSelectIndex = {sComponentName = "Image"},
  txtSelected = {
    sComponentName = "TMP_Text",
    sLanguageId = "HomePage_Selected"
  },
  goAnim = {}
}

function BoardCharCtrl:RefreshItemData(bShowFavorite)
  self._mapNode.goAnim.gameObject:SetActive(false)
  local handbookData = PlayerHandbookData:GetHandbookDataById(self.nId)
  if handbookData:GetType() == GameEnum.handbookType.SKIN then
    self._mapNode.goAnim.gameObject:SetActive(bShowFavorite and handbookData:CheckFavorCG())
    local charCfgData = handbookData:GetCharCfgData()
    if nil ~= charCfgData then
      local rareIconName = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[charCfgData.Grade]
      self:SetAtlasSprite(self._mapNode.imgItemRare, "12_rare", rareIconName)
    end
    local charSkinCfgData = handbookData:GetSkinCfgData()
    if nil ~= charSkinCfgData then
      self:SetPngSprite(self._mapNode.imgItemIcon, charSkinCfgData.Icon, AllEnum.CharHeadIconSurfix.XXL)
    end
  elseif handbookData:GetType() == GameEnum.handbookType.OUTFIT then
    local discCfgData = handbookData:GetDiscCfgData()
    local discItemCfgData = handbookData:GetDiscItemCfgData()
    if nil ~= discCfgData and nil ~= discItemCfgData then
      self._mapNode.goAnim.gameObject:SetActive(bShowFavorite and handbookData:GetRarity() == GameEnum.itemRarity.SSR and handbookData:CheckDiscL2D())
      self:SetPngSprite(self._mapNode.imgItemIcon, discItemCfgData.Icon .. AllEnum.OutfitIconSurfix.ListGrid)
      local rareIconName = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[discItemCfgData.Rarity]
      self:SetAtlasSprite(self._mapNode.imgItemRare, "12_rare", rareIconName)
    end
  elseif handbookData:GetType() == GameEnum.handbookType.PLOT or handbookData:GetType() == GameEnum.handbookType.StorySet or handbookData:GetType() == GameEnum.handbookType.StoryReview then
    local plotCfgData = handbookData:GetPlotCfgData()
    if nil ~= plotCfgData then
      local tbResourcePath = PlayerData.Handbook:GetPlotResourcePath(self.nId)
      self:SetPngSprite(self._mapNode.imgItemIcon, tbResourcePath.Icon)
    end
    local rareIconName = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[2]
    self:SetAtlasSprite(self._mapNode.imgItemRare, "12_rare", rareIconName)
  end
end

function BoardCharCtrl:SetItemData(itemData)
  local nMaxCount = PlayerBoardData:GetMaxSelectCount()
  self.nId = itemData.data:GetId()
  self:RefreshItemData(true)
  local nSelect = itemData.nSelect > 0 and nMaxCount - itemData.nSelect + 1 or 0
  self:SetSelect(nSelect)
end

function BoardCharCtrl:SetItemSortData(nId, nIndex)
  self.nId = nId
  self:RefreshItemData(false)
  self._mapNode.imgChose.gameObject:SetActive(false)
  self._mapNode.imgChoseMask.gameObject:SetActive(false)
  self._mapNode.imgChoseBg.gameObject:SetActive(false)
  self._mapNode.imgAnimMask.gameObject:SetActive(false)
end

function BoardCharCtrl:SetSelect(nSelectIdx)
  self.bSelect = nil ~= nSelectIdx and 0 < nSelectIdx
  self._mapNode.imgChose.gameObject:SetActive(self.bSelect)
  self._mapNode.imgChoseMask.gameObject:SetActive(self.bSelect)
  self._mapNode.imgChoseBg.gameObject:SetActive(self.bSelect)
  self._mapNode.imgAnimMask.gameObject:SetActive(self.bSelect)
  if self.bSelect then
    self:SetAtlasSprite(self._mapNode.imgSelectIndex, "11_ico", "zs_team_select_" .. nSelectIdx)
  end
end

function BoardCharCtrl:CheckSelect(tbSelected)
  local nSelectIdx
  for k, v in ipairs(tbSelected) do
    if v == self.nId then
      nSelectIdx = k
      break
    end
  end
  self:SetSelect(nSelectIdx)
end

return BoardCharCtrl
