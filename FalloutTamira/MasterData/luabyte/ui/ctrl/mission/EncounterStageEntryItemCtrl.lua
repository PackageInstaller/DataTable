local EncounterStageEntryItemCtrl = BaseClass("EncounterStageEntryItemCtrl")
local M = EncounterStageEntryItemCtrl
function M:__init(view)
    self._view = view
end

function M:SetEntryInfo(nameId, icon,entryId)
    self._view.img_icon:SetPic(icon)
    if self._view.txt_cnName then 
        self._view.txt_cnName:SetText(nameId)
    end
end

function M:SetActive(value)
    self._view:SetActive(value)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return EncounterStageEntryItemCtrl
