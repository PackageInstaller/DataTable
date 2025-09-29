-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveLogItemView.lua

module("logic.extensions.retrieve.view.RetrieveLogItemView", package.seeall)

local M = class("RetrieveLogItemView", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)
end

function M:_initComponents()
	self:_addComponent("normal", RetrieveLogItemCellComponet)
end

return M
