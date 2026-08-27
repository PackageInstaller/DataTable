local base = UIBaseNode
local UINFmtSaveChipItem = class("UINFmtSaveChipItem", base)
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")

function UINFmtSaveChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.btn_Tog, self, self._OnClickTog)
  self._onChipClick = BindCallback(self, self._OnClickChip)
  self._chipItem = UINChipItem.New()
  self._chipItem:Init(self.ui.UINChipItem)
end

function UINFmtSaveChipItem:InitFmtSaveChipItem(chipData, clickChipFunc, clickTogFunc)
  self._clickChipFunc = clickChipFunc
  self._clickTogFunc = clickTogFunc
  self._chipData = chipData
  self._chipItem:InitChipItem(chipData, true, self._onChipClick)
  local suitCfg = chipData:TryGetSuitCfg()
  self.ui.Suit:SetActive(suitCfg ~= nil)
  if suitCfg then
    self.ui.Tex_Name.text = LanguageUtil.GetLocaleText(suitCfg.tag_name)
    self.ui.img_SuitIcon.sprite = CRH:GetSprite(suitCfg.tag_icon, CommonAtlasType.ExplorationIcon)
  end
end

function UINFmtSaveChipItem:_OnClickChip()
  if self._clickChipFunc ~= nil then
    self._clickChipFunc(self._chipData)
  end
end

function UINFmtSaveChipItem:_OnClickTog(isOn)
  if self._clickTogFunc ~= nil then
    local isOk = self._clickTogFunc(self._chipData, isOn)
    if not isOk then
      self.ui.btn_Tog.isOn = not isOn
    end
  end
end

function UINFmtSaveChipItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtSaveChipItem
