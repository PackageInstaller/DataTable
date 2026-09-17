PopRechargeDailyPrizeLayer = class("PopRechargeDailyPrizeLayer", function()
	return PopBaseLayer:create()
end)

local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local var_0_4 = require("controller.time_check_manager")
local drop_manager = require("controller.drop_manager")
local item_data = require("data.item_data")
local network = require("network.network")
local var_0_9 = 775
local dailyrechargewinprizes_conf_data = require("data.dailyrechargewinprizes_conf_data")

function PopRechargeDailyPrizeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopRechargeDailyPrizeLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopRechargeDailyPrizeLayer:initBg(arg_3_1)
	local var_3_0 = ccui.Layout:create()

	var_3_0:setTouchEnabled(true)
	var_3_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_3_0:setAnchorPoint(cc.p(0, 0))
	var_3_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_3_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_3_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_3_0:setOpacity(0)
	self:addChild(var_3_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_4_0)
		self:addChild(arg_4_0, -2)
		arg_4_0:setPositionY(arg_4_0:getPositionY() - GameDisplay.fix_y)

		local var_4_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_4_0:setAnchorPoint(cc.p(0, 0))
		var_4_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_4_0, -1)
		self:init(arg_3_1)
		var_3_0:setOpacity(102)
		var_3_0:setTouchEnabled(false)
		self:initData()
	end)
end

function PopRechargeDailyPrizeLayer:init(arg_5_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(false)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootLayer:setPosition(cc.p(GameDisplay.getScreenSize().width / 2, GameDisplay.getScreenSize().height / 2 + GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer, 2)

	self.rootpanel = ccui.Layout:create()

	self.rootpanel:setContentSize(GameDisplay.getScreenSize())
	self.rootpanel:setAnchorPoint(cc.p(0.5, 0.5))
	self.rootpanel:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.rootpanel:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.rootpanel)
	self.showActions.extendVertical(self)
	self:createFullScreenMask(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_6_0:isBright() then
			return
		end

		arg_6_0:setBright(false)
		self.hideActions.shrinkVertical(self, function()
			if self.exitcallback then
				self.exitcallback(0)
			end

			LayerManager:removePopLayer(self.__queueindex)
		end)
	end, 0)
	self:initUI()
	self:registerScriptHandler(function(arg_8_0)
		if arg_8_0 == "exit" then
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end
	end)
end

function PopRechargeDailyPrizeLayer:initUI(arg_9_1)
	local var_9_0 = ccui.ImageView:create("mainScenebg/pop_recharge_daily_prize.png")

	var_9_0:setPosition(cc.p(320, 660 - GameDisplay.fix_y))
	var_9_0:setTouchEnabled(true)
	self.rootpanel:addChild(var_9_0)

	local var_9_1 = cc.Label:createWithTTF("暂未开启", FONT_NAME, 18)

	var_9_1:setColor(cc.c3b(173, 134, 131))
	var_9_1:setName("time_label")
	var_9_1:setPosition(cc.p(var_9_0:getContentSize().width / 2 + 83, var_9_0:getContentSize().height / 2 + 110))
	var_9_0:addChild(var_9_1)

	self.time_label = var_9_1

	local var_9_2 = cc.Label:createWithTTF("未拥有", FONT_NAME, 18)

	var_9_2:setColor(cc.c3b(173, 134, 131))
	var_9_2:setName("canjoin_label")
	var_9_2:setPosition(cc.p(var_9_0:getContentSize().width / 2 + 160, var_9_0:getContentSize().height / 2 - 40))
	var_9_0:addChild(var_9_2)

	self.canjoin_label = var_9_2

	local var_9_3 = cc.Label:createWithTTF("无", FONT_NAME, 18)

	var_9_3:setColor(cc.c3b(31, 202, 67))
	var_9_3:setName("playername")
	var_9_3:setPosition(cc.p(var_9_0:getContentSize().width / 2 + 160, var_9_0:getContentSize().height / 2 - 90))
	var_9_0:addChild(var_9_3)

	self.playername = var_9_3
end

function PopRechargeDailyPrizeLayer:initData()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(dailyrechargewinprizes_conf_data) do
		local var_10_1, var_10_2, var_10_3, var_10_4, var_10_5 = string.match(iter_10_0, "(%d+)-((%d+)-(%d+)-(%d+))")

		table.insert(var_10_0, {
			timestring = var_10_2,
			time = os.time({
				year = var_10_3,
				month = var_10_4,
				day = var_10_5
			})
		})
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		return arg_11_0.time < arg_11_1.time
	end)
	self.time_label:setString(var_10_0[1].timestring .. "~" .. var_10_0[#var_10_0].timestring)
	network:rpc("get_dailyrecharge_win_prizes_data", {
		activityid = var_0_9
	}, function(arg_12_0)
		if tolua.isnull(self) then
			return
		end

		if arg_12_0.result == 1 then
			self.canjoin_label:setString(arg_12_0.eligibility and "已拥有" or "未拥有")
			self.playername:setString((arg_12_0.winners or nil) and (arg_12_0.winners[1] or "无"))
			self.canjoin_label:setColor(arg_12_0.eligibility and cc.c3b(31, 202, 67) or cc.c3b(173, 134, 131))
			self.playername:setColor(arg_12_0.winners and arg_12_0.winners[1] and cc.c3b(31, 202, 67) or cc.c3b(173, 134, 131))
		else
			global_ShowBlockWords("illegal error!!!")
		end
	end)
end
