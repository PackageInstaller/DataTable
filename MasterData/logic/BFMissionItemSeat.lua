-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/BFMissionItemSeat.lua

module("logic.extensions.mission.view.BFMissionItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local BFMissionItemSeat = class("BFMissionItemSeat", ItemSeat)

function BFMissionItemSeat.AddOnce(go)
	local component = BFMissionItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, BFMissionItemSeat)

	return component
end

function BFMissionItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, BFMissionItemSeat))
end

function BFMissionItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, BFMissionItemSeat)
end

function BFMissionItemSeat:_getPet(petId)
	return BreakFormationController.instance:getTempMaxPet(petId)
end

return BFMissionItemSeat
