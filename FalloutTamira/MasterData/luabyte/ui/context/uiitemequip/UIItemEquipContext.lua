--baoruichang
--2022/2/28 15:12:50
local UIItemEquipContext = BaseClass("UIItemEquipContext", BaseContext)
local M = UIItemEquipContext

function M:Init()
end

function M:Open(type, itemId, num, closeCallback, maxNum, shopItemId, shopId)
    self:_Show(type, itemId, num, closeCallback, maxNum, shopItemId, shopId)
end

function M:OnClose()
    M.super.OnClose(self)
end


return UIItemEquipContext
