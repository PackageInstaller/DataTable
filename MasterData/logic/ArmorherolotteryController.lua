-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/armorherolottery/controller/ArmorherolotteryController.lua

module("logic.extensions.armorherolottery.controller.ArmorherolotteryController", package.seeall)

local ArmorherolotteryController = class("ArmorherolotteryController", BaseController)

function ArmorherolotteryController:ctor()
	return
end

function ArmorherolotteryController:onInit()
	self:onReset()
end

function ArmorherolotteryController:onReset()
	return
end

ArmorherolotteryController.instance = ArmorherolotteryController.New()

return ArmorherolotteryController
