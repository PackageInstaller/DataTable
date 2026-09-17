local ActivityBakeryLevelUpLayer = class("ActivityBakeryLevelUpLayer", (require("view.Layer.BaseUILayer")))
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

local var_0_11 = {
	cake = {
		device_levelup = {
			"oven_num",
			"tray_num",
			"oventime",
			"burningtime",
			"choptime",
			"fruitPoolNum",
			"chopping_num"
		},
		bakery_levelup = {
			"cake_prize",
			"cream_prize",
			"fruit_prize_1",
			"fruit_prize_2",
			"fruit_prize_3"
		}
	},
	milktea = {
		device_levelup = {
			"milktea_num",
			"milkteatime"
		},
		bakery_levelup = {
			"pearl_prize",
			"milktea_prize"
		}
	},
	taroballs = {
		device_levelup = {
			"taroballs_num",
			"taroballstime"
		},
		bakery_levelup = {
			"taroballs_prize",
			"excipients_prize_1",
			"excipients_prize_2"
		}
	}
}
local var_0_12 = {
	tray_num = "tray.png",
	chopping_num = "zb.png",
	milkteatime = "ncj.png",
	cream_prize = "ny.png",
	milktea_num = "ncj.png",
	fruit_prize_3 = "bl.png",
	fruitPoolNum = "fruitpool.png",
	oven_num = "oven.png",
	taroballs_num = "yyw.png",
	taroballs_prize = "yy.png",
	excipients_prize_1 = "hd.png",
	fruit_prize_2 = "cm.png",
	excipients_prize_2 = "mg.png",
	pearl_prize = "zz.png",
	taroballstime = "yyw.png",
	fruit_prize_1 = "lm.png",
	milktea_prize = "nc.png",
	cake_prize = "dg.png",
	choptime = "knife.png",
	oventime = "oven.png",
	burningtime = "oven.png"
}

function ActivityBakeryLevelUpLayer:ctor()
	ActivityBakeryLevelUpLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function ActivityBakeryLevelUpLayer:create(arg_2_1)
	self.activityId = arg_2_1.activityId
	self.resPath = "ActivityBakeryLevelUpLayer/"

	local var_2_0 = ActivityBakeryLevelUpLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityBakeryLevelUpLayer:onEnter()
	ActivityBakeryLevelUpLayer.super.onEnter(self)
end

function ActivityBakeryLevelUpLayer:onExit()
	ActivityBakeryLevelUpLayer.super.onExit(self)
end

function ActivityBakeryLevelUpLayer:init(arg_5_1)
	self.equipment_level = activity_manager:activity_get_bakery_cur_data(self.activityId).equipment_level

	self:initLayer(arg_5_1)
	self:initListener(arg_5_1)
	self:updateLayer()

	return true
end

function ActivityBakeryLevelUpLayer:initLayer(arg_6_1)
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
	var_6_1:setPosition(320, 640)

	self.bg = var_6_1
	self.module = "cake"

	local var_6_2 = ccui.Button:create(self.resPath .. "btn_cake_off.png", nil, self.resPath .. "btn_cake_off.png", var_0_3)

	var_6_2:setPosition(110, 20)
	var_6_1:addChild(var_6_2)

	self.btn_cake = var_6_2

	local var_6_3 = ccui.Button:create(self.resPath .. "btn_milktea_off.png", nil, self.resPath .. "btn_milktea_off.png", var_0_3)

	var_6_3:setPosition(260, 20)
	var_6_1:addChild(var_6_3)

	self.btn_milktea = var_6_3

	local var_6_4 = ccui.Button:create(self.resPath .. "btn_taroballs_off.png", nil, self.resPath .. "btn_taroballs_off.png", var_0_3)

	var_6_4:setPosition(410, 20)
	var_6_1:addChild(var_6_4)

	self.btn_taroballs = var_6_4

	local var_6_5 = ccui.Button:create(self.resPath .. "btn_close.png", nil, self.resPath .. "btn_close.png", var_0_3)

	var_6_5:setPosition(540, 1000)
	var_6_1:addChild(var_6_5)

	self.btn_close = var_6_5

	local var_6_6 = ccui.ListView:create()

	var_6_6:setDirection(ccui.ScrollViewDir.vertical)
	var_6_6:setContentSize(cc.size(520, 870))
	var_6_6:setPosition(cc.p(40, 80))
	var_6_1:addChild(var_6_6)
	var_6_6:setBackGroundColorOpacity(100)
	var_6_6:setBounceEnabled(true)

	self.listView = var_6_6
end

function ActivityBakeryLevelUpLayer:initListener(arg_8_1)
	if self.btn_cake then
		self.btn_cake:addTouchEventListener(function(arg_9_0, arg_9_1)
			if arg_9_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.module == "cake" then
				return
			end

			self.module = "cake"

			self:updateLayer()
		end)
	end

	if self.btn_milktea then
		self.btn_milktea:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.module == "milktea" then
				return
			end

			self.module = "milktea"

			self:updateLayer()
		end)
	end

	if self.btn_taroballs then
		self.btn_taroballs:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			if self.module == "taroballs" then
				return
			end

			self.module = "taroballs"

			self:updateLayer()
		end)
	end

	if self.btn_close then
		self.btn_close:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_8_1.callback then
				arg_8_1.callback()
			end

			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end
end

function ActivityBakeryLevelUpLayer:updateLayer()
	self.listView:removeAllChildren()

	local var_13_0 = ccui.Layout:create()
	local var_13_1 = (math.floor(#var_0_11[self.module].device_levelup / 3 + (#var_0_11[self.module].device_levelup % 3 == 0 and 0 or 1)) + math.floor(#var_0_11[self.module].bakery_levelup / 3 + (#var_0_11[self.module].bakery_levelup % 3 == 0 and 0 or 1))) * 180 + 120

	var_13_0:setContentSize(520, var_13_1)

	local var_13_2 = ccui.ImageView:create(self.resPath .. "device_title.png", var_0_3)

	var_13_2:setAnchorPoint(0, 1)
	var_13_0:addChild(var_13_2)
	var_13_2:setPosition(0, var_13_1)

	local var_13_3 = var_13_1 - 50
	local var_13_4 = 1

	for iter_13_0, iter_13_1 in pairs(var_0_11[self.module].device_levelup) do
		var_13_0:addChild((self:createSprite(var_13_4, var_13_3, iter_13_1)))

		if var_13_4 % 3 == 0 then
			var_13_3 = var_13_3 - 180
		end

		var_13_4 = var_13_4 + 1
	end

	if var_13_4 % 3 ~= 1 then
		var_13_3 = var_13_3 - 200
	end

	local var_13_5 = ccui.ImageView:create(self.resPath .. "bakery_title.png", var_0_3)

	var_13_5:setAnchorPoint(0, 1)
	var_13_0:addChild(var_13_5)
	var_13_5:setPosition(0, var_13_3)

	local var_13_6 = var_13_3 - 50
	local var_13_7 = 1

	for iter_13_2, iter_13_3 in pairs(var_0_11[self.module].bakery_levelup) do
		var_13_0:addChild((self:createSprite(var_13_7, var_13_6, iter_13_3)))

		if var_13_7 % 3 == 0 then
			var_13_6 = var_13_6 - 180
		end

		var_13_7 = var_13_7 + 1
	end

	self.listView:pushBackCustomItem(var_13_0)
	self:updateBtn()
end

function ActivityBakeryLevelUpLayer:updateBtn()
	self.btn_cake:loadTextures(self.resPath .. "btn_cake_" .. (self.module == "cake" and "on" or "off") .. ".png", nil, self.resPath .. "btn_cake_" .. (self.module == "cake" and "on" or "off") .. ".png", var_0_3)
	self.btn_milktea:loadTextures(self.resPath .. "btn_milktea_" .. (self.module == "milktea" and "on" or "off") .. ".png", nil, self.resPath .. "btn_milktea_" .. (self.module == "milktea" and "on" or "off") .. ".png", var_0_3)
	self.btn_taroballs:loadTextures(self.resPath .. "btn_taroballs_" .. (self.module == "taroballs" and "on" or "off") .. ".png", nil, self.resPath .. "btn_taroballs_" .. (self.module == "taroballs" and "on" or "off") .. ".png", var_0_3)
end

function ActivityBakeryLevelUpLayer:createSprite(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_3)

	var_15_0:setAnchorPoint(0, 1)
	var_15_0:setPosition((arg_15_1 - 1) % 3 * 160 + 40, arg_15_2)

	local var_15_1 = ccui.ImageView:create(self.resPath .. "label_bg.png", var_0_3)

	var_15_1:setAnchorPoint(0, 0)
	var_15_0:addChild(var_15_1)

	local var_15_2, var_15_3 = activity_manager:activity_get_bakery_device_levelinfo(self.activityId, arg_15_3)
	local var_15_4 = cc.Label:createWithTTF("LV." .. var_15_2, FONT_DES, 22)

	var_15_1:addChild(var_15_4)
	var_15_4:setPosition(var_15_1:getContentSize().width / 2, 11)
	var_15_4:setColor(cc.c3b(239, 227, 189))

	local var_15_5 = ccui.ImageView:create(self.resPath .. "cost_label_bg.png", var_0_3)

	var_15_5:setAnchorPoint(0, 1)
	var_15_0:addChild(var_15_5)
	var_15_5:setPositionY(-10)

	local var_15_6 = cc.Label:createWithTTF(var_15_3["levelCost" .. var_15_2] or "已满级", FONT_DES, 20)

	var_15_5:addChild(var_15_6)
	var_15_6:setPosition(var_15_5:getContentSize().width / 2 + 10, var_15_5:getContentSize().height / 2)
	var_15_0:setTouchEnabled(true)
	var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:updateLevelupPop(arg_15_3)
	end)

	local var_15_7 = ccui.ImageView:create(self.resPath .. var_0_12[arg_15_3], var_0_3)

	var_15_7:setPosition(var_15_0:getContentSize().width / 2, var_15_0:getContentSize().height / 2 + 5)
	var_15_0:addChild(var_15_7)

	local var_15_8 = ccui.ImageView:create(self.resPath .. "des_bg.png", var_0_3)

	var_15_8:setAnchorPoint(0, 0)
	var_15_0:addChild(var_15_8)
	var_15_8:setVisible(false)

	local var_15_9 = cc.Label:createWithTTF("品质升级", FONT_DES, 16)

	var_15_8:addChild(var_15_9)
	var_15_9:setPosition(35, 105)
	var_15_9:setColor(cc.c3b(8, 37, 56))

	local var_15_10, var_15_11 = activity_manager:activity_get_bakery_device_levelinfo(self.activityId, arg_15_3)

	if var_15_11.title then
		var_15_8:setVisible(true)
		var_15_9:setString(var_15_11.title)
	end

	return var_15_0
end

function ActivityBakeryLevelUpLayer:updateLevelupPop(arg_17_1)
	if not self.levelupPop then
		local var_17_0 = ccui.Layout:create()

		var_17_0:setContentSize(cc.size(640, 1600))
		var_17_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_17_0:setCascadeOpacityEnabled(false)
		var_17_0:setBackGroundColorOpacity(122)
		var_17_0:setAnchorPoint(0.5, 0.5)
		var_17_0:setBackGroundColor(cc.c3b(0, 0, 0))
		var_17_0:setPosition(GameDisplay.cx, GameDisplay.cy)
		var_17_0:setTouchEnabled(true)
		var_17_0:setLocalZOrder(1000)
		var_17_0:setVisible(true)
		self._root:addChild(var_17_0)

		self.levelupPop = var_17_0

		var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_17_0:setVisible(false)
		end)

		local var_17_1 = ccui.ImageView:create(self.resPath .. "pop_bg.png", var_0_3)

		var_17_0:addChild(var_17_1)
		var_17_1:setPosition(320, 840)
		var_17_1:setTouchEnabled(true)

		local var_17_2 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_3)

		var_17_1:addChild(var_17_2)
		var_17_2:setPosition(var_17_1:getContentSize().width / 2, var_17_1:getContentSize().width / 2)

		local var_17_3 = ccui.ImageView:create(self.resPath .. "oven.png", var_0_3)

		var_17_2:addChild(var_17_3)
		var_17_3:setPosition(var_17_2:getContentSize().width / 2, var_17_2:getContentSize().width / 2)

		self.levelupPop.icon = var_17_3

		local var_17_4 = cc.Label:createWithTTF("2000", FONT_NAME, 25)

		var_17_1:addChild(var_17_4)
		var_17_4:setPosition(220, 180)
		var_17_4:setColor(cc.c3b(150, 68, 59))

		self.levelupPop.cost_label = var_17_4

		local var_17_5 = cc.Label:createWithTTF("LV.2", FONT_NAME, 25)

		var_17_1:addChild(var_17_5)
		var_17_5:setPosition(370, 180)
		var_17_5:setColor(cc.c3b(150, 68, 59))

		self.levelupPop.level_label = var_17_5

		local var_17_6 = cc.Label:createWithTTF("烘焙时间减少.", FONT_NAME, 29)

		var_17_1:addChild(var_17_6)
		var_17_6:setPosition(275, 130)
		var_17_6:setColor(cc.c3b(150, 68, 59))

		self.levelupPop.des_label = var_17_6

		local var_17_7 = ccui.Button:create(self.resPath .. "btn_levelup.png", nil, self.resPath .. "btn_levelup.png", var_0_3)

		var_17_7:setPosition(275, 75)
		var_17_1:addChild(var_17_7)

		self.levelupPop.btn_levelup = var_17_7

		local var_17_8 = cc.Label:createWithTTF("2000", FONT_TITLE, 29)

		var_17_7:addChild(var_17_8)
		var_17_8:setPosition(var_17_7:getContentSize().width / 2 + 20, var_17_7:getContentSize().height / 2)
		var_17_8:setColor(cc.c3b(150, 68, 59))

		self.levelupPop.btn_label = var_17_8

		local var_17_9 = ccui.Button:create(self.resPath .. "btn_close.png", nil, self.resPath .. "btn_close.png", var_0_3)

		var_17_9:setPosition(540, 400)
		var_17_1:addChild(var_17_9)
		var_17_9:addTouchEventListener(function(arg_19_0, arg_19_1)
			if arg_19_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_17_0:setVisible(false)
		end)

		self.levelupPop.btn_close = var_17_9
	end

	self.levelupPop.btn_levelup:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		activity_manager:activity_bakery_device_levelup(self.activityId, arg_17_1, function()
			global_ShowBlockWords("升级成功！")
			self:updateLayer()
		end)
		self.levelupPop:setVisible(false)
	end)

	local var_17_10, var_17_11 = activity_manager:activity_get_bakery_device_levelinfo(self.activityId, arg_17_1)

	self.levelupPop.cost_label:setString("LV." .. var_17_10)
	self.levelupPop.level_label:setString((var_17_10 < var_17_11.max_level or nil) and ("LV." .. var_17_10 + 1 or "max"))
	self.levelupPop.des_label:setString(var_17_11.des and string.format(var_17_11.des, var_17_11["levelValue" .. var_17_10]) or arg_17_1 .. "描述文本")
	self.levelupPop.btn_label:setString(var_17_11["levelCost" .. var_17_10] or "max")
	self.levelupPop.btn_levelup:setVisible(var_17_10 < var_17_11.max_level)
	self.levelupPop.icon:loadTexture(self.resPath .. var_0_12[arg_17_1], var_0_3)
	self.levelupPop:setVisible(true)
end

function ActivityBakeryLevelUpLayer:updateRed()
	return
end

return ActivityBakeryLevelUpLayer
