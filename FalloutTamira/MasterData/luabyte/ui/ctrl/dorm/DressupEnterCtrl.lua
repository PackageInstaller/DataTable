local DressupEnterCtrl = BaseClass("DressupEnterCtrl", BaseUICtrl)
local M = DressupEnterCtrl

function M:Init()
end

function M:OnEnter(furnitureId, curFurnitureId)
end

function M:OnBack()
    return true
end

function M:OnClose()
end

function M:OnDispose()
    M.super.OnDispose(self)
end

return DressupEnterCtrl
