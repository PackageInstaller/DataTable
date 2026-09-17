CostumeRoomRewardLayer = class("CostumeRoomRewardLayer", (require("view.Layer.BaseUILayer")))

local TempWidget = require("view.Sprite.TempWidget")
local socket = require("socket")

function CostumeRoomRewardLayer:ctor()
	self.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.costume_room_reward_manager"):getInstance()
end

function CostumeRoomRewardLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = CostumeRoomRewardLayer.new()

	if var_2_0 and var_2_0:init() then
		return var_2_0
	end

	return nil
end

function CostumeRoomRewardLayer:onEnter()
	self.super.onEnter(self)
end

function CostumeRoomRewardLayer:onExit()
	self.super.onExit(self)
end

function CostumeRoomRewardLayer:init()
	self:initLayer()
	self:initListener()

	return true
end

function CostumeRoomRewardLayer:initLayer()
	self._root = TempWidget:CreateTempLayout(self._root)

	self._root:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self._root:_setBack()
	self._root:setBackGroundColor(cc.c3b(0, 0, 0))
	self._root:setBackGroundColorOpacity(150)
	self._root:_addEvent(function()
		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self:addChild(self._root)

	local var_6_0 = TempWidget:CreateTempImg("mainScenebg/costume_room_reward_bg.png", self._root, 0)

	var_6_0:_addEvent(function()
		return
	end)
	var_6_0:center()

	self.bg = var_6_0

	self.manager:requestInfo()
end

function CostumeRoomRewardLayer.initListener(arg_9_0)
	return
end

function CostumeRoomRewardLayer:updateLayer()
	local var_10_0 = require("view.Layer.CostumeRoom.CostumeRoomCumulativeRewardLayer"):create()

	self.bg:addChild(var_10_0)
	var_10_0:setPosition(cc.p(10, 20))
end

return CostumeRoomRewardLayer
