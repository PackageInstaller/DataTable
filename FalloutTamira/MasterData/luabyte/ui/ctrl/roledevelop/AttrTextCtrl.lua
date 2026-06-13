local AttrTextCtrl = BaseClass("AttrTextCtrl",UIBaseComponent)
local M = AttrTextCtrl 

function M:SetLabel(attrid,num)
    local attr = ConfigHelper.GetCfgByLua("attribute",attrid)

    --self._view.Icon:SetPic()
    self._view.label:SetText(attr.name)
    self._view.value:SetText(tostring(num))
    self._view.gameObject:SetActive(true)
end

return AttrTextCtrl