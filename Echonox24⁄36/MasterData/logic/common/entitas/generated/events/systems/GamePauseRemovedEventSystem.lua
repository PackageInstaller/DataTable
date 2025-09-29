-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/systems/GamePauseRemovedEventSystem.lua

module("logic.common.entitas.generated.events.systems.GamePauseRemovedEventSystem", package.seeall)

local Game_comps = GameComponents
local Game_comps_ext = GamePauseListenerComponent
local Matcher = require("Matcher")
local M = class("GamePauseRemovedEventSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context)

	self._listeners = context:get_group(Matcher({
		Game_comps.PauseListener
	}))
end

function M:get_trigger()
	return {
		{
			Matcher({
				Game_comps.Pause
			}),
			BitUtil.BitOR(BitUtil.BitOR(GroupEvent.ADDED, GroupEvent.REMOVED), GroupEvent.UPDATE)
		}
	}
end

function M:filter(entity)
	return true
end

function M:_execute()
	local entities = self._entities

	if self._collector == nil then
		return
	end

	if self._collector.entities:size() > 0 then
		print("self._collector.entities:size()", self._collector.entities:size())
		self._collector.entities:foreach(function(entity)
			if self:filter(entity) then
				entities:push(entity)
			end
		end)
		self._collector:clear_entities()

		if entities:size() > 0 then
			self:execute(entities)
			entities:clear()
		end
	end
end

function M:execute(es)
	local buffer = self._listeners:get_entity_buffer()

	print("暂停切换1", comp, #buffer)
	es:foreach(function(e)
		local comp = e.pause

		print("暂停切换1", comp, #buffer)

		for _, entity in pairs(buffer) do
			local list = entity.pauseListener.value

			list:OnGamePause(e, e:hasPause())
			print("暂停切换1", e:hasPause(), entity.pauseListener.value.__cname)
		end
	end)
end

function GameEntity:hasPauseListener()
	return self:has(Game_comps.PauseListener) ~= nil
end

function GameEntity:addPauseListener(value)
	self:add(Game_comps.PauseListener, value)

	return self
end

function GameEntity:replacePauseListener(value)
	self:replace(Game_comps.PauseListener, value)

	return self
end

function GameEntity:removePauseListener()
	self:remove(Game_comps.PauseListener)

	return self
end

return M
