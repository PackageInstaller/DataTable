local UINCommonSwitchToggle = class("UINCommonSwitchToggle", UIBaseNode)
local base = UIBaseNode

function UINCommonSwitchToggle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if self.ui.btn_root ~= nil then
    UIUtil.AddButtonListener(self.ui.btn_root, self, self._onClickRoot)
  end
  self._autoSetValue = true
end

function UINCommonSwitchToggle:InitCommonSwitchToggle(isOn, changeValueFunc)
  self.changeValueFunc = changeValueFunc
  self:SetCommonSwitchToggleValue(isOn, false)
  self:_ResetSwitchTween(isOn)
end

function UINCommonSwitchToggle:CommonSwitchTogAutoSetValue(auto)
  self._autoSetValue = auto
end

function UINCommonSwitchToggle:SetCommonSwitchToggleValue(isOn, withoutTween)
  isOn = isOn or false
  if self._isOn == isOn then
    return
  end
  self._isOn = isOn
  if not IsNull(self.ui.tex_State) then
    self.ui.tex_State:SetIndex(isOn and 1 or 0)
  end
  self.ui.img_Buttom.color = self.ui.color_toggleBg[isOn and 2 or 1]
  if not withoutTween then
    self:_SwitchTween(isOn)
  end
end

function UINCommonSwitchToggle:GetCommonSwitchToggleValue()
  return self._isOn
end

function UINCommonSwitchToggle:_onClickRoot()
  local isOn = not self._isOn
  if self.changeValueFunc ~= nil then
    self.changeValueFunc(isOn)
  end
  if self._autoSetValue then
    self:SetCommonSwitchToggleValue(isOn)
  end
end

function UINCommonSwitchToggle:_ResetSwitchTween(isOn)
  if isOn then
    self.ui.dt_Icon:DORewind()
  else
    self.ui.dt_Icon:DOComplete()
  end
end

function UINCommonSwitchToggle:_SwitchTween(isOn)
  if isOn then
    self.ui.dt_Icon:DOPlayBackwards()
  else
    self.ui.dt_Icon:DOPlayForward()
  end
end

function UINCommonSwitchToggle:OnDelete()
  base.OnDelete(self)
end

return UINCommonSwitchToggle
