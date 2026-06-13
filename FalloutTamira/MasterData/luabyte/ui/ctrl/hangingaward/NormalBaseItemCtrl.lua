---如需继承，请保证view中的变量是一致的
local NormalBaseItemCtrl = BaseClass("NormalBaseItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local M = NormalBaseItemCtrl

function M:Init()
    self:EnablePopItem(true)
    self:SetItemNameActive(false)
end

function M:UpdateItem(data)
    self:SetInfo(data.Id, ItemNumberType.TOTLE, data.Cnt)
end

return NormalBaseItemCtrl
