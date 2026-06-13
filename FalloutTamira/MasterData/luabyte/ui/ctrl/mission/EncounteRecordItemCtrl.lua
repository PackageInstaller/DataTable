local EncounteRecordItemCtrl = BaseClass("EncounteRecordItemCtrl",UIBaseComponent)
local M = EncounteRecordItemCtrl

function M:SetItem(zoneData)
    self._view.passItem:SetInfo(zoneData)
    self._view.icon:SetPic(zoneData:IconPath())
end
return EncounteRecordItemCtrl