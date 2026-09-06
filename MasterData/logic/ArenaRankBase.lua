-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaRankBase.lua

module("logic.extensions.arena.view.ArenaRankBase", package.seeall)

local ArenaRankBase = class("ArenaRankBase")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaRankBase.AddOnce(go)
	local component = ArenaRankBase.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaRankBase)

	return component
end

function ArenaRankBase.Remove(go)
	LuaComponentContainer.Remove(go, ArenaRankBase)
end

function ArenaRankBase.Get(go)
	return (LuaComponentContainer.Get(go, ArenaRankBase))
end

function ArenaRankBase:ctor(container)
	self._container = container
end

function ArenaRankBase:initTitle(id)
	return
end

return ArenaRankBase
