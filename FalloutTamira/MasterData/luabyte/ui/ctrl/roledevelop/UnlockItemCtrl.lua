--突破成功界面
--预制体  CommonBreachUI
local UnlockItemCtrl = BaseClass("UnlockItemCtrl", UIBaseComponent)
local M = UnlockItemCtrl

function M:__init(view)
    self._view = view
end

function M:UpdateData(data)
    self._view.labTips:SetText(data)
end

return UnlockItemCtrl
