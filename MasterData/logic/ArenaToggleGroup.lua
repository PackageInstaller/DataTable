-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaToggleGroup.lua

module("logic.extensions.arena.view.ArenaToggleGroup", package.seeall)

local ArenaToggleGroup = class("ArenaToggleGroup")

function ArenaToggleGroup.AddOnce(go)
	local component = ArenaToggleGroup.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, ArenaToggleGroup)

	return component
end

function ArenaToggleGroup.Remove(go)
	Framework.LuaComponentContainer.Remove(go, ArenaToggleGroup)
end

function ArenaToggleGroup.Get(go)
	return (Framework.LuaComponentContainer.Get(go, ArenaToggleGroup))
end

function ArenaToggleGroup:ctor(container)
	self._container = container
end

return ArenaToggleGroup
