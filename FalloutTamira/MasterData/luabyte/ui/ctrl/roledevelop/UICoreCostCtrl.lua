local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UICoreCostCtrl = BaseClass("UICoreCostCtrl", CircularScrollViewItem)
local M = UICoreCostCtrl

function M:Init()
end

function M:UpdateItem(data)
    self._view.item:SetInfo(data.id, 3, data.needNum, data.haveNum)
    self._view.item:EnablePopItem(true)
end

return UICoreCostCtrl
