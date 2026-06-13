local UIAttrCtrl = BaseClass("UIAttrCtrl")
local M = UIAttrCtrl

function M:__init(view)
    self._view = view
end

function M:Update(num1, num2, attributeId, hideNum2)
    self._view.labNum1:SetText(tostring(num1))

    if not hideNum2 then
        self._view.labNum2:SetText(tostring(num2))
        self._view.labNum2:SetActive(true)
        self._view.tfAdd:SetActive(true)
    else
        self._view.labNum2:SetActive(false)
        self._view.tfAdd:SetActive(false)
    end

    local attr = ConfigHelper.GetCfgByLua("attribute", attributeId)
    self._view.icon:SetPic(attr.icon)
    self._view.labName:SetText(attr.name)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UIAttrCtrl
