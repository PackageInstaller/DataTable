local M = BaseClass("KitChenItemCtrl")
local sfmt = string.format

function M:__init(view)
    self._view = view
end

function M:UpdateItem(data)
    self._view.img_icon:SetItemIcon(data.id)
    local desc = ConfigHelper.GetLocalString(6257)
    local name = ConfigHelper.GetLocalString(data.name)
    desc = sfmt(desc, name)
    self._view.txt_name:SetText(desc)

end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
