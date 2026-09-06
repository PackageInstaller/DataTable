-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aceteam/view/mission/AceTeamItemSeat.lua

module("logic.extensions.mission.view.AceTeamItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local AceTeamItemSeat = class("AceTeamItemSeat", ItemSeat)

function AceTeamItemSeat.AddOnce(go)
	local component = AceTeamItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, AceTeamItemSeat)

	return component
end

function AceTeamItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, AceTeamItemSeat))
end

function AceTeamItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, AceTeamItemSeat)
end

function AceTeamItemSeat:_getPet(petId)
	return AceTeamModel.instance:getCurTeamPetMo(petId)
end

return AceTeamItemSeat
