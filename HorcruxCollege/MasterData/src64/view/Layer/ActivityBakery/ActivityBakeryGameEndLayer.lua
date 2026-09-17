local ActivityBakeryGameEndLayer = class("ActivityBakeryGameEndLayer", (require("view.Layer.BaseUILayer")))
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local flyChessUtility = require("view.Layer.flyChess.flyChessUtility")

require("view.Sprite.ItemSprite")

function ActivityBakeryGameEndLayer:ctor()
	ActivityBakeryGameEndLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function ActivityBakeryGameEndLayer:create(arg_2_1)
	self.activityId = arg_2_1.activityId
	self.resPath = "ActivityBakeryGameEndLayer/"

	local var_2_0 = ActivityBakeryGameEndLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityBakeryGameEndLayer:onEnter()
	ActivityBakeryGameEndLayer.super.onEnter(self)
end

function ActivityBakeryGameEndLayer:onExit()
	ActivityBakeryGameEndLayer.super.onExit(self)
end

function ActivityBakeryGameEndLayer:init(arg_5_1)
	self:initLayer(arg_5_1)
	self:initListener(arg_5_1)

	return true
end

function ActivityBakeryGameEndLayer:initLayer(arg_6_1)
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	var_6_0:_addEvent(function()
		return
	end)

	local var_6_1 = ccui.ImageView:create(self.resPath .. "bg.png", var_0_3)

	var_6_0:addChild(var_6_1)
	var_6_1:setPosition(320, 700)

	if arg_6_1.result == "win" then
		local var_6_2 = ccui.ImageView:create(self.resPath .. "title_win.png", var_0_3)

		var_6_1:addChild(var_6_2)
		var_6_2:setPosition(245, 500)

		self.dropListView = ccui.ListView:create()

		self.dropListView:setDirection(ccui.ListViewDirection.horizontal)
		self.dropListView:setItemsMargin(20)
		self.dropListView:setAnchorPoint(cc.p(0, 0))
		self.dropListView:setPosition(40, 280)
		self.dropListView:setContentSize(cc.size(460, 100))
		var_6_1:addChild(self.dropListView)

		if arg_6_1.drop then
			for iter_6_0, iter_6_1 in pairs(drop_manager:getDropMsg(arg_6_1.drop).equips) do
				local var_6_3 = ccui.Layout:create()

				var_6_3:setContentSize(cc.size(80, 80))

				local var_6_4 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_3)

				var_6_4:setPosition(cc.p(50, 40))

				local var_6_5, var_6_6 = create_item_icon(nil, true, iter_6_1.dropid, iter_6_1.dropNum)

				var_6_5:setPosition(40, 45)
				var_6_5:setScale(var_6_5:getScale() * 0.5)
				var_6_4:addChild(var_6_5)
				var_6_3:addChild(var_6_4)

				local var_6_7 = ccui.ImageView:create(self.resPath .. "label_bg.png", var_0_3)

				var_6_7:setAnchorPoint(0, 0)
				var_6_4:addChild(var_6_7)

				local var_6_8 = cc.Label:createWithTTF("x" .. var_6_6, FONT_DES, 14)

				var_6_8:setPosition(42, 10)
				var_6_7:addChild(var_6_8)
				self.dropListView:pushBackCustomItem(var_6_3)
			end
		end

		local var_6_9 = ccui.Button:create(self.resPath .. "btn_next_level.png", nil, self.resPath .. "btn_next_level.png", var_0_3)

		var_6_9:setPosition(245, 180)
		var_6_1:addChild(var_6_9)

		self.btn_next_level = var_6_9
	else
		local var_6_10 = ccui.ImageView:create(self.resPath .. "title_failed.png", var_0_3)

		var_6_1:addChild(var_6_10)
		var_6_10:setPosition(245, 500)

		local var_6_11 = cc.Label:createWithTTF("第" .. arg_6_1.level .. "关", FONT_TITLE, 32)

		var_6_1:addChild(var_6_11)
		var_6_11:setPosition(245, 370)
		var_6_11:setColor(cc.c3b(154, 74, 67))

		local var_6_12 = cc.Label:createWithTTF("本次得分: " .. arg_6_1.gold, FONT_TITLE, 30)

		var_6_1:addChild(var_6_12)
		var_6_12:setPosition(245, 310)
		var_6_12:setColor(cc.c3b(154, 74, 67))

		local var_6_13 = ccui.Button:create(self.resPath .. "btn_again.png", nil, self.resPath .. "btn_again.png", var_0_3)

		var_6_13:setPosition(245, 180)
		var_6_1:addChild(var_6_13)

		self.btn_again = var_6_13
	end

	local var_6_14 = ccui.Button:create(self.resPath .. "btn_close.png", nil, self.resPath .. "btn_close.png", var_0_3)

	var_6_14:setPosition(450, 630)
	var_6_1:addChild(var_6_14)

	self.btn_close = var_6_14
end

function ActivityBakeryGameEndLayer:initListener(arg_8_1)
	if self.btn_next_level then
		self.btn_next_level:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()

			if arg_8_1.callback then
				arg_8_1.callback()
			end
		end)
	end

	if self.btn_again then
		self.btn_again:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()

			if arg_8_1.callback then
				arg_8_1.callback()
			end
		end)
	end

	if self.btn_close then
		self.btn_close:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end
end

function ActivityBakeryGameEndLayer:updateLayer()
	return
end

function ActivityBakeryGameEndLayer:updateRed()
	return
end

return ActivityBakeryGameEndLayer
