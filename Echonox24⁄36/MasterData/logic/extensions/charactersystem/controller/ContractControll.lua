-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/controller/ContractControll.lua

module("logic.extensions.charactersystem.controller.ContractControll", package.seeall)

local M = class("ContractControll", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.CONTRACT_ITEM, self._clickContract, self)
end

function M:_clickContract(e, data)
	if data then
		ToolTipsController.instance:_openComposeItemView(data)
	end
end

M.instance = M.New()

return M
