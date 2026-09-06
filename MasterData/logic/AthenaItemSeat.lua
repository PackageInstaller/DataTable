-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/athena/AthenaItemSeat.lua

module("logic.extensions.timelimitedchallenge.view.athena.AthenaItemSeat", package.seeall)

local AthenaItemSeat = class("AthenaItemSeat", ItemSeat)

function AthenaItemSeat.AddOnce(go)
	local component = AthenaItemSeat.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, AthenaItemSeat)

	return component
end

function AthenaItemSeat.Get(go)
	return (Framework.LuaComponentContainer.Get(go, AthenaItemSeat))
end

function AthenaItemSeat.Remove(go)
	Framework.LuaComponentContainer.Remove(go, AthenaItemSeat)
end

function AthenaItemSeat:_getPet(petId)
	return AthenaModel.instance:getPetMo(petId)
end

return AthenaItemSeat
