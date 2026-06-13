local MailPoptemCtrl = BaseClass("MailPoptemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local M = MailPoptemCtrl
function M:Init()
    self._data = nil
    self:SetClickCallback(Bind(self, self._ClickItem))
end

function M:_ClickItem(go)
    GameHelper.PopItem(self.data.Id, 0, self._view)
end

function M:UpdateItem(data)
    self.data = data
    self:SetInfo(data.Id, ItemNumberType.TOTLE, data.Cnt)
    self:SetFinish(data.state == protocol.MailState.MS_EXTRACT)
end

return MailPoptemCtrl
