-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/minigame/obj/AQAFWeaponCon.lua

module("logic.extensions.aoqiattackforce.minigame.obj.AQAFWeaponCon", package.seeall)

local AQAFWeaponCon = class("AQAFWeaponCon")

function AQAFWeaponCon:ctor(container, view)
	self._view = view
	self.curUnit = nil

	self:buildUI(container)
end

function AQAFWeaponCon:buildUI(container)
	return
end

function AQAFWeaponCon:setUnit(unit)
	self.curUnit = unit
end

function AQAFWeaponCon:lateUpdate()
	return
end

function AQAFWeaponCon:reset()
	self.curUnit = nil
end

function AQAFWeaponCon:destroy()
	self:reset()
	goutil.destroy(self.container)

	self.container = nil
end

function AQAFWeaponCon:die()
	return
end

return AQAFWeaponCon
