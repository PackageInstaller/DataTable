-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/UnitCompTeamSpine.lua

module("logic.scene.unit.component.UnitCompTeamSpine", package.seeall)

local UnitCompTeamSpine = class("UnitCompTeamSpine", UnitCompSpine, UnitComponentBase)

function UnitCompTeamSpine:onInit()
	self:onReuse()
end

function UnitCompTeamSpine:onReuse()
	return
end

function UnitCompTeamSpine:onReset()
	if self._unit then
		-- block empty
	end
end

function UnitCompTeamSpine:onDestroy()
	self:onReset()
end

function UnitCompTeamSpine:_onBodyLoaded(loader)
	UnitCompTeamSpine.super._onBodyLoaded(self, loader)
end

return UnitCompTeamSpine
