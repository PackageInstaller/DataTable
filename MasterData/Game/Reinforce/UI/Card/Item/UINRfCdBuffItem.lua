local base = UIBaseNode
local UINRfCdBuffItem = class("UINRfCdBuffItem", base)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINRfCdBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if self.ui.btn_root then
    UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClick)
    self.ui.btn_root.onPressDown:AddListener(BindCallback(self, self._OnClickRoot))
    self.ui.btn_root.onPressUp:AddListener(BindCallback(self, self._OnClickRootUp))
  end
end

function UINRfCdBuffItem:InitRfCdBuffItem(buffCfg)
  self.buffCfg = buffCfg
  self.ui.icon.sprite = CRH:GetSprite(buffCfg.icon, CommonAtlasType.ExplorationIcon)
  if self.ui.tex_BuffName ~= nil then
    self.ui.tex_BuffName.text = LanguageUtil.GetLocaleText(buffCfg.name)
  end
end

function UINRfCdBuffItem:SetRfCdBuffItemLock(isLock)
  self.ui.obj_Lock:SetActive(isLock)
end

function UINRfCdBuffItem:SetRfCdBuffItemUnlockStar(unlockStar)
  self.ui.tex_Lock:SetIndex(0, tostring(unlockStar))
end

function UINRfCdBuffItem:SetRfCdBuffItemClickFunc(clickFunc)
  self._clickFunc = clickFunc
end

function UINRfCdBuffItem:_OnClick()
  if self._clickFunc then
    self._clickFunc(self.buffCfg)
  end
end

function UINRfCdBuffItem:_OnClickRoot()
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local des = self.buffCfg.describe
  win:SetTitleAndContext(LanguageUtil.GetLocaleText(self.buffCfg.name), LanguageUtil.GetLocaleText(des))
  win:FloatTo(self.transform, HAType.autoCenter, VAType.up, 0, 0.5)
end

function UINRfCdBuffItem:_OnClickRootUp()
  UIManager:HideWindow(UIWindowTypeID.FloatingFrame)
end

function UINRfCdBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCdBuffItem
