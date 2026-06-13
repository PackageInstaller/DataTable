local UIAdvancedItemCtrl = BaseClass("UIAdvancedItemCtrl")
local M = UIAdvancedItemCtrl

function M:__init(view)
    self._view = view
end

function M:SetActive(b)
    self._view:SetActive(b)
end

function M:Update(attrid, num, nextNum)
    local attr = ConfigHelper.GetCfgByLua("attribute", attrid)
    if num == nil then
        num = 0
    end
    local curValue = tostring(num)
    local nextValue = tostring(nextNum)
    if attr.viewType == 1 then
        num = num / 100
        nextNum = nextNum / 100
        curValue = num .. "%"
        nextValue = nextNum .. "%"
    end
    self._view.sprIcon:SetPic(attr.icon)
    self._view.labName:SetText(attr.name)
    self._view.labNum1:SetText(curValue)
    self._view.labNum2:SetText(nextValue)
    self._view.gameObject:SetActive(true)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UIAdvancedItemCtrl
