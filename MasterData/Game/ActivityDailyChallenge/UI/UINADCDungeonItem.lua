local UINADCDungeonItem = class("UINADCDungeonItem", UIBaseNode)
local base = UIBaseNode

function UINADCDungeonItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.shadow, self, self.OnClickItem)
end

function UINADCDungeonItem:InitADCDungeonItem(adcData, dungeonCfg, callback)
  self._adcData = adcData
  self._dungeonCfg = ConfigData.battle_dungeon[dungeonCfg.dungeon_id]
  self._callback = callback
  self._isInfinite = dungeonCfg.is_infinite
  self._dungeonColor = dungeonCfg.dungeon_color
  self.ui.tex_LevelName.text = LanguageUtil.GetLocaleText(self._dungeonCfg.name)
  self.ui.tex_dungeonEn.text = LanguageUtil.GetLocaleText(dungeonCfg.dungeon_en)
  local index = self._dungeonColor
  self.ui.img_MiddenBg:SetIndex(index)
  self.ui.img_BottonRighticon:SetIndex(index)
  self.ui.img_LeftLine:SetIndex(index)
  self:RefreshADCDungeonItem()
end

function UINADCDungeonItem:RefreshADCDungeonItem()
  local isUnlock = self._adcData:IsADCDungeonUnlock(self._dungeonCfg.id)
  if not isUnlock then
    self.ui.img_Lockmask:SetActive(true)
    self.ui.tex_CurrentDes.gameObject:SetActive(false)
    self.ui.tex_CurrentScore.gameObject:SetActive(false)
    self.ui.texbg.gameObject:SetActive(false)
    return
  end
  self.ui.texbg.gameObject:SetActive(true)
  self.ui.img_Lockmask:SetActive(false)
  self.ui.tex_CurrentDes.gameObject:SetActive(true)
  local score = self._adcData:GetADCDungeonPoint(self._dungeonCfg.id)
  local flag = 0 < score
  self.ui.tex_CurrentScore.gameObject:SetActive(flag)
  self.ui.tex_CurrentDes:SetIndex(flag and 0 or 1)
  self.ui.tex_CurrentScore.text = tostring(score)
  local index = 4
  if flag then
    index = self._dungeonColor + 1
  end
  self.ui.texbg.color = self.ui.color_texbg[index]
end

function UINADCDungeonItem:RefreshADCSelectState(dungeonId)
  self.ui.img_Selected:SetActive(dungeonId == self._dungeonCfg.id)
end

function UINADCDungeonItem:OnClickItem()
  if self._callback ~= nil then
    self._callback(self._dungeonCfg.id, self)
  end
end

return UINADCDungeonItem
