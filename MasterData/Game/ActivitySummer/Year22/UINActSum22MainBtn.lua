local UINActSum22MainBtn = class("UINActSum22MainBtn", UIBaseNode)
local base = UIBaseNode

function UINActSum22MainBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickItem)
  if self.ui.bottom ~= nil then
    self._bottomColor = self.ui.bottom.color
  end
  if self.ui.tex_Name ~= nil then
    self._namreColor = self.ui.tex_Name.color
  end
  self._cnNameColor = self.ui.tex_CNName.color
  self._enNameColor = self.ui.tex_ENName.color
end

function UINActSum22MainBtn:InitSum22Btn(cfg, isUnlock, callback, lockedCallback)
  self._isUnlock = isUnlock
  self._callback = callback
  self._lockedCallback = lockedCallback
  self.ui.tex_CNName.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tex_ENName.text = LanguageUtil.GetLocaleText(cfg.name_en)
  if self.ui.tex_Name ~= nil then
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.name_func)
  end
  if isUnlock then
    self:RefreshSum22BtnUnlock()
  else
    self:RefreshSum22Locked()
  end
end

function UINActSum22MainBtn:RefreshSum22BtnUnlock()
  self._isUnlock = true
  if self.ui.lock ~= nil then
    self.ui.lock:SetActive(false)
  end
  if self.ui.bottom ~= nil then
    self.ui.bottom.color = Color.white
  end
  local color = self.ui.tex_CNName.color
  color.a = 1
  self.ui.tex_CNName.color = color
  color = self.ui.tex_ENName.color
  color.a = 1
  self.ui.tex_ENName.color = color
  if self.ui.tex_Name ~= nil then
    color = self.ui.tex_Name.color
    color.a = 1
    self.ui.tex_Name.color = color
  end
end

function UINActSum22MainBtn:RefreshSum22Locked()
  self._isUnlock = false
  if self.ui.lock ~= nil then
    self.ui.lock:SetActive(true)
  end
  if self.ui.bottom ~= nil then
    self.ui.bottom.color = self._bottomColor
  end
  self.ui.tex_CNName.color = self._cnNameColor
  self.ui.tex_ENName.color = self._enNameColor
  if self.ui.tex_Name ~= nil then
    self.ui.tex_Name.color = self._namreColor
  end
end

function UINActSum22MainBtn:OnClickItem()
  if self._isUnlock then
    if self._callback ~= nil then
      self._callback()
    end
  elseif self._lockedCallback ~= nil then
    self._lockedCallback()
  end
end

return UINActSum22MainBtn
