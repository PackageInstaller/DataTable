local UINGameNoticeTag = class("UINGameNoticeTag", UIBaseNode)
local base = UIBaseNode

function UINGameNoticeTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.tog_NoticeItem, self, self._OnValueChange)
end

function UINGameNoticeTag:SetNoticeTagClickCallback(callback)
  self._onClickCallback = callback
end

function UINGameNoticeTag:RefreshGameNoticeTag(index, gameNoticData, callback)
  self._idx = index
  self.ui.tex_Name.text = gameNoticData.name
  self:SetNoticeTagClickCallback(callback)
  local timeDate = TimeUtil:TimestampToDate(gameNoticData.startTimeStamp, nil, true)
  self.ui.tex_Date.text = timeDate.month .. "/" .. timeDate.day
  local ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice)
  self:SetNewUICorner(ctrl:ContainGameNoticeIsNew(gameNoticData.idx))
end

function UINGameNoticeTag:SetNewUICorner(active)
  self.ui.obj_New:SetActive(active)
end

function UINGameNoticeTag:SetNoticeTagIsOn(isOn)
  if isOn then
    self.ui.tog_NoticeItem.group:SetAllTogglesOff()
  end
  self.ui.tog_NoticeItem.isOn = isOn
end

function UINGameNoticeTag:_OnValueChange(bool)
  self.ui.img_OnSelect:SetIndex(bool and 1 or 0)
  if not bool then
    return
  end
  self:SetNewUICorner(false)
  if self._onClickCallback ~= nil then
    self._onClickCallback(self._idx)
  end
end

function UINGameNoticeTag:OnHide()
  self:SetNoticeTagIsOn(false)
end

function UINGameNoticeTag:OnDelete()
  base.OnDelete(self)
end

return UINGameNoticeTag
