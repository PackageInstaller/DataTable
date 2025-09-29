-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/model/HouseMainStateModel.lua

module("logic.extensions.housemain.model.HouseMainStateModel", package.seeall)

local M = class("HouseMainStateModel", BaseModel)
local State = HouseMainEnum.State

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._state = nil
end

function M:getState()
	return self._state or HouseMainEnum.State.Normal
end

function M:isInState(state)
	return self:getState() == state
end

function M:changeState(state, info)
	self._state = state
end

M.instance = M.New()

return M
