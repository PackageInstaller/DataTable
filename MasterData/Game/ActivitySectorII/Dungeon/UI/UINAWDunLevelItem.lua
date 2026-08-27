local UINAWDunLevelItem = class("UINAWDunLevelItem", UIBaseNode)
local base = UIBaseNode

function UINAWDunLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.rootBtn, self, self.__OnClickLevelItem)
  self:SetTexTileBestFit(false)
end

function UINAWDunLevelItem:RefreshWADunLevelItem(SIIDunData, onClickWADunItem)
  self.SIIDunData = SIIDunData
  self.onClickWADunItem = onClickWADunItem
  self.gameObject.name = tostring(SIIDunData:GetDungeonLevelStageId())
  self.transform.anchoredPosition = SIIDunData:GetAWDungeonPos()
  self:RefreshUI()
end

function UINAWDunLevelItem:RefreshUI()
  self.ui.tex_Tile.text = self.SIIDunData:GetDungeonLevelName()
  self.ui.tex_SubTile.text = self.SIIDunData:GetDungeonLevelOrderName()
  local isUnlock = self.SIIDunData:GetIsLevelUnlock()
  self:_ShowUILock(not isUnlock)
  self:_ShowUITitle(isUnlock)
  self:_ShowUIComplete(self.SIIDunData:GetIsLevelComplete())
  self:__RefreshBlueDot()
end

function UINAWDunLevelItem:_ShowUILock(enabled)
  self.ui.img_Lock.enabled = enabled
end

function UINAWDunLevelItem:_ShowUIComplete(enabled)
  self.ui.img_Complete.enabled = enabled
end

function UINAWDunLevelItem:_ShowUITitle(isUnlock)
  self.ui.rect_title.gameObject:SetActive(isUnlock)
end

function UINAWDunLevelItem:__RefreshBlueDot()
  if self.SIIDunData:GetIsLevelUnlock() and not self.SIIDunData:GetIsLevelComplete() then
    self.ui.blueDot:SetActive(true)
    return
  end
  self.ui.blueDot:SetActive(false)
end

function UINAWDunLevelItem:GetStageHolderRect()
  return self.ui.stageHolder
end

function UINAWDunLevelItem:__OnClickLevelItem()
  if self.onClickWADunItem ~= nil then
    self.onClickWADunItem(self)
  end
end

function UINAWDunLevelItem:GetPointUI()
  return self.ui.rect_point
end

function UINAWDunLevelItem:GetTitleUI()
  return self.ui.rect_title
end

function UINAWDunLevelItem:SetTexTileBestFit(isOn)
  self.ui.tex_Tile.resizeTextForBestFit = isOn
end

function UINAWDunLevelItem:GetAWDunLevelAnchoredPos()
  return self.transform.anchoredPosition
end

function UINAWDunLevelItem:OnDelete()
end

return UINAWDunLevelItem
