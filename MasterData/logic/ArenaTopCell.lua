-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/view/ArenaTopCell.lua

module("logic.extensions.arena.view.ArenaTopCell", package.seeall)

local ArenaTopCell = class("ArenaTopCell")
local LuaComponentContainer = Framework.LuaComponentContainer

function ArenaTopCell.AddOnce(go)
	local component = ArenaTopCell.Get(go)

	component = component or LuaComponentContainer.Add(go, ArenaTopCell)

	return component
end

function ArenaTopCell.Remove(go)
	LuaComponentContainer.Remove(go, ArenaTopCell)
end

function ArenaTopCell.Get(go)
	return (LuaComponentContainer.Get(go, ArenaTopCell))
end

function ArenaTopCell:ctor(container)
	self._container = container
end

function ArenaTopCell:initCell(data)
	local _group = self._container:GetComponent("UIChangeGroup")

	_group:SetState(data.position - 1)

	local _Txt_Name = goutil.findChildTextComponent(self._container, "Txt_Name")

	_Txt_Name.text = data.userName

	local _Txt_Power = goutil.findChildTextComponent(self._container, "Txt_Power")

	_Txt_Power.text = data.everMaxZdl
end

return ArenaTopCell
