local UINHomeGeneralBtn = class("UINHomeGeneralBtn", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINHomeGeneralBtn:OnInit()
  self.isUnlock = false
  self.isHaveRedDot = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHomeGeneralBtn:RefeshUnlockInfo(isUnlock, unlockDes)
  self.isUnlock = isUnlock
  self.unlockDes = unlockDes
  if self.ui.lock ~= nil then
    self.ui.lock:SetActive(not isUnlock)
  end
  if not isUnlock and self.ui.tex_Condition ~= nil and unlockDes ~= nil then
    self.ui.tex_Condition.text = unlockDes
  end
  self:RefreshRedDot(self.__lastNum, self.__lastIsBlue)
  if self.ui.infoArray ~= nil then
    for _, go in ipairs(self.ui.infoArray) do
      go:SetActive(isUnlock)
    end
  end
end

function UINHomeGeneralBtn:RefreshRedDot(num, isBlue)
  self.__lastNum = num
  self.__lastIsBlue = isBlue
  self.isHaveRedDot = 0 < (num or 0)
  if not IsNull(self.ui.obj_RedDot) then
    self.ui.obj_RedDot:SetActive(self.isUnlock and self.isHaveRedDot and not isBlue)
  end
  if not IsNull(self.ui.obj_redDotWithCount) then
    local isHave = self.isUnlock and self.isHaveRedDot and not isBlue
    self.ui.obj_redDotWithCount:SetActive(isHave)
    if isHave then
      local num = num or 0
      if 1 < num then
        self.ui.tex_Count.text = tostring(num)
        self.ui.tex_Count.gameObject:SetActive(true)
        self.ui.redDotWithCount:SetIndex(1)
      else
        self.ui.tex_Count.gameObject:SetActive(false)
        self.ui.redDotWithCount:SetIndex(0)
      end
    end
  end
  if not IsNull(self.ui.blueDot) then
    self.ui.blueDot:SetActive(self.isUnlock and self.isHaveRedDot and isBlue)
  end
end

function UINHomeGeneralBtn:GetRedDotFunc()
  return BindCallback(self, self.RefreshRedDot)
end

function UINHomeGeneralBtn:RefreshBlueDot(num)
  if not IsNull(self.ui.obj_blueDot) then
    self.ui.obj_blueDot:SetActive(self.isUnlock and not self.isHaveRedDot and 0 < num)
  end
end

function UINHomeGeneralBtn:GetBlueDotFunc()
  return BindCallback(self, self.RefreshBlueDot)
end

function UINHomeGeneralBtn:ShowUnlockDes()
  if self.unlockDes ~= nil then
    cs_MessageCommon.ShowMessageTips(self.unlockDes)
  end
end

function UINHomeGeneralBtn:OnDelete()
  base.OnDelete(self)
end

return UINHomeGeneralBtn
