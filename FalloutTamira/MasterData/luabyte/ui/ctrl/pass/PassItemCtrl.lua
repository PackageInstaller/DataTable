local PassItemCtrl = BaseClass("PassItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local M = PassItemCtrl

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self:SetInfo(data.id, ItemNumberType.TOTLE, data.cnt)
    self:EnablePopItem(true)
end

return PassItemCtrl