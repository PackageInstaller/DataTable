local UINSwitchHouseBtn = class("UINSwitchHouseBtn", UIBaseNode)
local base = UIBaseNode

function UINSwitchHouseBtn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_House, self, self._OnBtnHouseClick)
end

function UINSwitchHouseBtn:InitSwitchHouse(houseId, name, iconIdx, clickAction)
  self._clickAction = clickAction
  self._houseId = houseId
  self.ui.img_House:SetIndex(iconIdx)
  self.ui.tex_Name.text = tostring(name)
end

function UINSwitchHouseBtn:_OnBtnHouseClick()
  if self._clickAction ~= nil then
    self._clickAction(self._houseId, true)
  end
end

function UINSwitchHouseBtn:SetSwitchHouseBtnLock(isLock)
  self.ui.obj_Lock:SetActive(isLock)
  self.ui.img_House.image.enabled = not isLock
  self.ui.tex_Name.color = isLock and self.ui.color_lockName or Color.white
end

function UINSwitchHouseBtn:SetSwitchHouseReddot(active)
  self.ui.obj_redDot:SetActive(active)
end

function UINSwitchHouseBtn:ShowSwitchHouseBlueDot(isShow)
  self.ui.obj_blueDot:SetActive(isShow)
end

function UINSwitchHouseBtn:OnDelete()
  base.OnDelete(self)
end

return UINSwitchHouseBtn
