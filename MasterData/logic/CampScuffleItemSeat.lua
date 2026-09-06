-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/scufflemission/CampScuffleItemSeat.lua

module("logic.extensions.funcamp.view.scufflemission.CampScuffleItemSeat", package.seeall)

local CampScuffleItemSeat = class("CampScuffleItemSeat", ItemSeat)
local LuaComponentContainer = Framework.LuaComponentContainer

function CampScuffleItemSeat.AddOnce(go)
	local component = CampScuffleItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, CampScuffleItemSeat)

	return component
end

function CampScuffleItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, CampScuffleItemSeat))
end

function CampScuffleItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, CampScuffleItemSeat)
end

function CampScuffleItemSeat:_getPet(petId)
	return CampScuffleModel.instance:getPet(petId)
end

function CampScuffleItemSeat:_getCurFormId()
	return CampScuffleModel.instance:getCurFormationId()
end

return CampScuffleItemSeat
