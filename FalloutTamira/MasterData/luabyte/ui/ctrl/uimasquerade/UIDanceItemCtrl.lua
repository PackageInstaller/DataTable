--baoruichang
local UIDanceItemCtrl = BaseClass("UIDanceItemCtrl", UIBaseComponent)
local M = UIDanceItemCtrl

function M:__init(view)
    self._view = view
    self._isEnablePopItem = true
    self:Init()
end

function M:Init()
    self._view:onClick(Bind(self, self._OnClick))
end

function M:UpdateData(data)
    self._data = data
    self._view.imgIcon:SetItemIcon(data.id)
    self._view.labNum:SetText(tostring(data.num))
    local itemCfg = ConfigHelper.GetCfg("item", data.id)
    self._view.state:SetState(itemCfg.quality)
end

function M:_OnClick()
    if not self._isEnablePopItem then
        return
    end
    GameHelper.PopItem(self._data.id, 0, self._view)
end

function M:EnablePopItem(isEnablePopItem)
    self._isEnablePopItem = isEnablePopItem
end

return UIDanceItemCtrl
