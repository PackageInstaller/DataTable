local ItemAttrCtrl = BaseClass("ItemAttrCtrl", UIBaseComponent)
local M = ItemAttrCtrl

function M:__init(view)
    self._view = view
end

function M:UpdateData(data)
    local attribute = ConfigHelper.GetCfgByLua("attribute", data.id)
    self._view.imgIcon:SetPic(attribute.icon)
    self._view.labDesc:SetText(attribute.name)
    self._view.labNum:SetText("+" .. data.num)
    self._view.state:SetState((data.index + 1) % 2 + 1)
end

return ItemAttrCtrl
