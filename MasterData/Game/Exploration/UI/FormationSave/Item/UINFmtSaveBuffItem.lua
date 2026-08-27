local base = UIBaseNode
local UINFmtSaveBuffItem = class("UINFmtSaveBuffItem", base)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINFmtSaveBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_root.onPressDown:AddListener(BindCallback(self, self._OnClickRoot))
  self.ui.btn_root.onPressUp:AddListener(BindCallback(self, self._OnClickRootUp))
end

function UINFmtSaveBuffItem:InitFmtSaveBuffItem(buffCfg)
  self.buffCfg = buffCfg
  self.ui.icon.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
end

function UINFmtSaveBuffItem:_OnClickRoot()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local des = self.buffCfg.describe
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(self.buffCfg.name), LanguageUtil.GetLocaleText(des))
  win:FloatTo(self.transform, HAType.autoCenter, VAType.up, 0, 0.5)
end

function UINFmtSaveBuffItem:_OnClickRootUp()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UINFmtSaveBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtSaveBuffItem
