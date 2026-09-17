PopRechargeIconLayer = class("PopRechargeIconLayer", function()
	return PopBaseLayer:create()
end)

require("view.Sprite.ItemSprite")
require("view.Sprite.AvatarSprite")

local audio_manager = require("controller.audio_manager")
local playermodel = require("model.playermodel")
local drop_manager = require("controller.drop_manager")
local level_manager = require("controller.level_manager")
local component_manager = require("controller.component_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local supermarket_manager = require("controller.supermarket_manager")
local item_data = require("data.item_data")
local novice_award_data = require("data.novice_award_data")
local var_0_11 = require("controller.activity_manager")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local var_0_13 = require("controller.time_check_manager")
local recharge_data = require("data.recharge_data")

function PopRechargeIconLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopRechargeIconLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopRechargeIconLayer:init(arg_3_1)
	self.initParam = arg_3_1
	self.defaultsys = arg_3_1.defaultsys
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(GameDisplay.getScreenSize())
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_4_0:isBright() then
			return
		end

		arg_4_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initData()
	self:initUI()
	self:updateUI()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" and arg_3_1 and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

function PopRechargeIconLayer:initData()
	print(dump(self.initParam))

	self.big_group = self.initParam and self.initParam.big_group
	self.entranceList = self:getEntranceList()

	local var_7_0

	if self.entranceList[3] then
		var_7_0 = self.entranceList[3].jump

		if not self.entranceList[3].jump then
			if self.entranceList[2] then
				var_7_0 = self.entranceList[2].jump or self.entranceList[1].jump
			end
		end
	end

	self.jumpid = var_7_0

	for iter_7_0, iter_7_1 in pairs(self.entranceList) do
		if self.defaultsys == iter_7_1.jump then
			self.jumpid = self.defaultsys
		end
	end
end

function PopRechargeIconLayer:initUI()
	for iter_8_0, iter_8_1 in pairs(self.entranceList) do
		local var_8_0 = self:createEntranceIcon(iter_8_1)

		self:createBirthBtnTime(var_8_0:getChildByName("timeLabel"), iter_8_1.finishtime)
		var_8_0:setPositionX(100)
		var_8_0:setPositionY(1080 + GameDisplay.fix_y / 2)
		self.rootpanel:addChild(var_8_0)
	end

	local var_8_2 = ccui.Button:create("mainScenebg/activity/shoptimelimit/btn_close_" .. self.big_group .. ".png", nil, nil)

	var_8_2:setTouchEnabled(false)
	var_8_2:setPosition(580, 1070 + GameDisplay.fix_y / 2)
	self.rootpanel:addChild(var_8_2)
end

function PopRechargeIconLayer:getParam(...)
	return {
		list = supermarket_manager:getAllShopTimeLimitList()[self.jumpid % 100000]
	}
end

function PopRechargeIconLayer:updateUI()
	if self.shoptimelimitLayer then
		self.shoptimelimitLayer:runAction(cc.RemoveSelf:create())

		self.shoptimelimitLayer = nil
	end

	if self.signLayer then
		self.signLayer:runAction(cc.RemoveSelf:create())

		self.signLayer = nil
	end

	if self.jumpid >= 1700000 and self.jumpid <= 1799999 then
		require("view.Layer.Pops.PopBaseLayer")

		self.shoptimelimitLayer = PopShopTimeLimitRechargeIconLayer:create((self:getParam()))

		self.shoptimelimitLayer:setScale(0.9)
		self.shoptimelimitLayer:setPositionY(-40)
		self.rootpanel:addChild(self.shoptimelimitLayer)
	else
		require("view.Layer.Pops.PopBaseLayer")

		self.signLayer = ActivitySignTemplateSpLayer:create({
			activityid = self.jumpid % 100000
		})

		self.signLayer:setScale(1)
		self.signLayer:setPositionY(-40)
		self.rootpanel:addChild(self.signLayer)
	end
end

function PopRechargeIconLayer:getEntranceList()
	local var_11_0 = var_0_11:getActivityEntranceList() or {}
	local var_11_1 = {}

	local function var_11_2(arg_12_0)
		local var_12_0 = var_0_13:getCurTime()

		if arg_12_0.starttime and var_12_0 < os.time(parse_time(arg_12_0.starttime)) then
			return false
		end

		if arg_12_0.finishtime and var_12_0 > os.time(parse_time(arg_12_0.finishtime)) then
			return false
		end

		return true
	end

	local function var_11_3(arg_13_0)
		if not self.big_group then
			return true
		end

		local var_13_0 = arg_13_0.jump % 100000

		for iter_13_0, iter_13_1 in pairs(shop_timelimit_data) do
			if iter_13_1.group == var_13_0 and self.big_group == iter_13_1.big_group then
				return true
			end
		end
	end

	local function var_11_4(arg_14_0)
		if self.big_group == 3100001 then
			return arg_14_0.id == 152001
		end
	end

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1.isinactivitylayer and var_11_2(iter_11_1) and var_11_3(iter_11_1) or var_11_4(iter_11_1) then
			table.insert(var_11_1, iter_11_1)
		end
	end

	table.sort(var_11_1, function(arg_15_0, arg_15_1)
		return arg_15_0.order < arg_15_1.order
	end)

	if not next(var_11_1) and self.big_group then
		local var_11_5 = false

		for iter_11_2, iter_11_3 in pairs(shop_timelimit_data) do
			if self.big_group == iter_11_3.big_group then
				var_11_5 = true
			end
		end

		if not var_11_5 then
			print("在shopTimelimitData中没找到%s为%s的行", big_group, self.big_group)
		else
			local var_11_6 = {}

			for iter_11_4, iter_11_5 in pairs(shop_timelimit_data) do
				if self.big_group == iter_11_5.big_group then
					var_11_6[iter_11_5.group] = true
				end
			end

			for iter_11_6, iter_11_7 in pairs(var_11_0) do
				var_11_6[iter_11_7.jump % 100000] = nil
			end

			for iter_11_8, iter_11_9 in pairs(var_11_6) do
				print(string.format("没有在活动入口表(entranceList)中找到jump为%s的行", 1700000 + iter_11_8))
			end
		end
	end

	return var_11_1
end

local function var_0_15(arg_16_0)
	if not arg_16_0 then
		return ""
	end

	if arg_16_0 > 86400 then
		return string.format(L_TIME_SINGLE.Day, math.floor(arg_16_0 / 3600 / 24))
	elseif arg_16_0 >= 3600 then
		return string.format(L_TIME_SINGLE.Hour, math.floor(arg_16_0 / 3600))
	elseif arg_16_0 >= 60 then
		return string.format(L_TIME_SINGLE.Minute, math.floor(arg_16_0 % 3600 / 60))
	else
		return string.format(L_TIME_SINGLE.Minute, 1)
	end
end

function PopRechargeIconLayer:createBirthBtnTime(arg_17_1, arg_17_2)
	if not arg_17_1 or not arg_17_2 then
		return
	end

	local function var_17_0(arg_18_0)
		if arg_17_1 and arg_17_1.id then
			arg_17_1:setString((var_0_15(arg_18_0)))

			if arg_18_0 <= 0 and arg_17_1 and self.scheduler and self.scheduler[arg_17_1.id] then
				var_0_13:removeUpdatePool(self.scheduler[arg_17_1.id])

				self.scheduler[arg_17_1.id] = nil
			end
		end
	end

	local var_17_1 = global_get_time_by_date(arg_17_2) - var_0_13:getCurTime()

	if not var_17_1 then
		return
	end

	var_17_0(var_17_1)

	self.scheduler = self.scheduler or {}
	self.scheduler[arg_17_1.id] = var_0_13:addUpdatePool((var_0_13:createTimeCountDownHandler(var_17_1, var_17_0)))
end

function PopRechargeIconLayer.createEntranceIcon(arg_19_0, arg_19_1)
	local var_19_0 = (function(arg_20_0)
		if not arg_20_0 then
			return
		end

		return string.gsub(arg_20_0, "@", "/")
	end)(arg_19_1.door_img_path) or MENU_ICON
	local var_19_1 = ccui.Button:create(var_19_0, nil, var_19_0)

	var_19_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_19_1:setScale(0.78)
	var_19_1:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_19_0.jumpid = arg_19_1.jump

		arg_19_0:updateUI()
	end)

	local var_19_2 = ccui.Text:create("", FONT_BUTTON, 20)

	var_19_2:setName("timeLabel")
	var_19_2:setColor(cc.c3b(254, 242, 242))
	var_19_2:setPosition(cc.p(var_19_1:getContentSize().width / 2, var_19_1:getContentSize().height - 44))

	var_19_2.id = arg_19_1.id

	var_19_1:addChild(var_19_2)

	return var_19_1
end

function PopRechargeIconLayer:initBg(arg_22_1)
	local var_22_0 = ccui.Layout:create()

	var_22_0:setTouchEnabled(true)
	var_22_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_22_0:setAnchorPoint(cc.p(0, 0))
	var_22_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_22_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_22_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_22_0:setOpacity(0)
	self:addChild(var_22_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_23_0)
		self:addChild(arg_23_0, -2)
		arg_23_0:setPositionY(arg_23_0:getPositionY() - GameDisplay.fix_y)

		local var_23_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_23_0:setAnchorPoint(cc.p(0, 0))
		var_23_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_23_0, -1)
		self:init(arg_22_1)
		var_22_0:setOpacity(102)
		var_22_0:setTouchEnabled(false)
	end)
end

function PopRechargeIconLayer:exit()
	self.hideActions.shrinkVertical(self, function()
		if self.exitcallback then
			self.exitcallback(0)
		end

		LayerManager:removePopLayer(self.__queueindex)
	end)
end
