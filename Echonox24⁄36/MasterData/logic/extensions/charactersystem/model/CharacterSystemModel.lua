-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/CharacterSystemModel.lua

module("logic.extensions.charactersystem.model.CharacterSystemModel", package.seeall)

local M = class("CharacterSystemModel", BaseModel)

function M:onInit()
	self._characterPageTabDelayTime = 0.6

	self:onReset()
end

function M:onReset()
	self._characterSysPageIndex = nil
end

function M:setPageIndex(index)
	self._characterSysPageIndex = index

	GlobalDispatcher:dispatchEvent(EventType.ON_CHARACTER_SYS_PAGE_CHANGE, index)
end

function M:getPageIndex()
	return self._characterSysPageIndex
end

function M:setCharacterSysPageTabDelayTime(time)
	time = time or 0
	time = time < 0 and 1 or time
	self._characterPageTabDelayTime = time
end

function M:getCharacterSysPageTabDelayTime()
	return self._characterPageTabDelayTime
end

M.instance = M.New()

return M
