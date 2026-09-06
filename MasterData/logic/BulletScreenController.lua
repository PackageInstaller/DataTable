-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bulletscreen/controller/BulletScreenController.lua

module("logic.extensions.bulletscreen.controller.BulletScreenController", package.seeall)

local BulletScreenController = class("BulletScreenController", BaseController)

function BulletScreenController:ctor()
	self._key = "1"
	self._subKey = "1"
end

function BulletScreenController:onInit()
	self._onOff = true
end

function BulletScreenController:onReset()
	return
end

function BulletScreenController:setStarTime()
	self._startTime = ServerTime.now()
end

function BulletScreenController:getStartTime()
	return checknumber(self._startTime)
end

function BulletScreenController:setOnOff(value)
	self._onOff = value

	local str = "false"

	if value == true then
		str = "true"
	end
end

function BulletScreenController:tryOpenView()
	local enum, key = BulletScreenModel.instance:getCurKeys()

	if enum and key then
		local cfgs = BulletScreenConfig.instance:getCfgList(enum, key)

		if #cfgs > 0 then
			print("try enum = " .. enum .. "key = " .. key)
			UIStateManager.instance:open(ViewName.BulletScreen)

			return true
		end
	end

	return false
end

function BulletScreenController:getOnOff()
	return self._onOff
end

BulletScreenController.instance = BulletScreenController.New()

return BulletScreenController
