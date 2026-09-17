ActivitySignLayer_4_1 = class("ActivitySignLayer_4_1", function()
	return cc.Layer:create()
end)

require("view.Sprite.ItemSprite")

local item_data = require("data.item_data")
local drop_data = require("data.drop_data")
local activity_sign_data = require("data.activity_sign_data")
local activity_conf_data = require("data.activity_conf_data")
local activity_explore_data = require("data.activity_explore_data")
local shop_data = require("data.shop_data")
local activity_manager = require("controller.activity_manager")
local alert_manager = require("controller.alert_manager")
local shop_manager = require("controller.shop_manager")
local item_manager = require("controller.item_manager")
local var_0_10 = require("controller.item_manager")
local network = require("network.network")
local var_0_12 = "activitiesRes/activity2/effect/flow_000%02d.png"
local playermodel = require("model.playermodel")
local time_check_manager = require("controller.time_check_manager")
local var_0_15
local var_0_16 = config._DEBUG and 0 or 1

local function var_0_19()
	local var_2_1 = os.date("*t", playermodel.create_time < os.time(parse_time("2020-9-19 00:00:00")) and os.time(parse_time("2020-9-19 00:00:00")) + 1209600 or playermodel.create_time + 1209600)

	return string.format("%d-%02d-%02d %02d:%02d:%02d", var_2_1.year, var_2_1.month, var_2_1.day, var_2_1.hour, var_2_1.min, var_2_1.sec)
end

function ActivitySignLayer_4_1.getInstance()
	return var_0_15
end

function ActivitySignLayer_4_1.create(arg_4_0)
	local var_4_0 = ActivitySignLayer_4_1.new()

	require("controller.texture_manager"):loadPopLayerTextures({
		"Activity_LiuLiActivity",
		"Activity_DaKaActivity"
	})
	var_4_0:init()
	var_4_0:setName("ActivitySignLayer_4_1")
	activity_manager:fireEvent(activity_manager.activityEventId.POP_LAYER_OPEMED)

	return var_4_0
end

function ActivitySignLayer_4_1:initData(arg_5_1)
	var_0_15 = self
	arg_5_1.initParam = arg_5_1.initParam or {}
	self.signData = arg_5_1.signData
	self.signTag = arg_5_1.signTag
	self.callback = arg_5_1.initParam.callback
	self.otherData = arg_5_1.otherData
	self.activityId = 4
	self.cansign = arg_5_1.signdate
	self.signstats = arg_5_1.signstats
	self.activitySingCallback = arg_5_1.activitySingCallback
	self.endTime = arg_5_1.otherData.endTime
	self.returnLayerCallback = arg_5_1.initParam.returnLayerCallback
	self.activity = activity_manager:getActivityObj(self.activityId)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Activity_Sign_4_1.json" or "Activity_Sign_4_1.ExportJson")

	self:addChild(self.rootLayer)

	local var_5_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_back")

	var_5_0:setContentSize(GameDisplay.getScreenSize())
	var_5_0:setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "sign_bg"):loadTexture("mainScenebg/activity/branch4/active_4_1_bg.jpg")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_29"):setVisible(false)

	self.awards_list = ccui.Helper:seekWidgetByName(self.rootLayer, "awards_list")

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_62"):setString(L_ACTIVITY_SIGN_TIPS)

	self.curAwardsIndex = self:getCurDayAwards()
	self.itemPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_Item")
	self.startBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_start")

	self:getSpecialExploreConfig(function(arg_6_0)
		self:updateStartBtn(arg_6_0)
		self.startBtn:addTouchEventListener(self:getStartBtnHandel(arg_6_0))
		self:updateTicketNum(arg_6_0)
	end)
	self:createActivityExploreIcon()
	self:initUI()
	self:initDisplayValue(self.rootLayer)
	self:intoLayerAni()
	self:registerEventListener()
end

function ActivitySignLayer_4_1:init()
	activity_manager:getActivityObj(4):getActivitySignData(function(arg_8_0)
		self:initData(arg_8_0)
	end)
	self:registerScriptHandler(function(arg_9_0)
		if arg_9_0 == "exit" then
			if self.callback then
				self.callback()
			end

			var_0_15 = nil

			activity_manager:releaseEventListenerByName("ActivitySignLayer_4_1")
		end
	end)
end

function ActivitySignLayer_4_1.registerEventListener(arg_10_0)
	activity_manager:registerEventListener("ActivitySignLayer_4_1", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function()
		if activity_manager:getAlertStatus(arg_10_0.activityId, "sign") then
			global_add_alert_tag(arg_10_0.signBtn, cc.p(120, 70))
		end
	end)
end

function ActivitySignLayer_4_1:getCurDayAwards()
	while activity_sign_data[self.activityId .. "-" .. 1] do
		if self:isAlikeDay(1) then
			return 1
		end
	end
end

function ActivitySignLayer_4_1:updateTicketNum(arg_13_1)
	self.ownNum1 = arg_13_1.needTbl[1].ownNum
	self.needNum1 = arg_13_1.needTbl[1].needNum
	self.ownNum2 = arg_13_1.needTbl[2].ownNum
	self.needNum2 = arg_13_1.needTbl[2].needNum
	self.ticketItem1 = arg_13_1.needTbl[1].itemid
	self.ticketItem2 = arg_13_1.needTbl[2].itemid

	self:updateGetAward()
end

function ActivitySignLayer_4_1:updateGetAward()
	self.ownNum1 = var_0_10:getItemNumber(self.ticketItem1)
	self.ownNum2 = var_0_10:getItemNumber(self.ticketItem2)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_ticket1"):loadTexture("equipment/" .. item_data[self.ticketItem1].image_id .. ".png")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_ticket2"):loadTexture("equipment/" .. item_data[self.ticketItem2].image_id .. ".png")
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_ticket1"):setString(self.ownNum1 .. "/" .. self.needNum1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_ticket2"):setString(self.ownNum2 .. "/" .. self.needNum2)

	if self.ownNum1 < self.needNum1 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_ticket1"):setColor(cc.c3b(255, 83, 136))
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_ticket1"):setColor(cc.c3b(255, 255, 255))
	end

	if self.ownNum2 < self.needNum2 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_ticket2"):setColor(cc.c3b(255, 83, 136))
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_ticket2"):setColor(cc.c3b(255, 255, 255))
	end
end

function ActivitySignLayer_4_1:updateSignbtn()
	if self.signstats[self.curAwardsIndex] == true then
		self.signBtn:setVisible(false)
	end

	self:setSignBtnPos()
end

function ActivitySignLayer_4_1.getStartBtnHandel(arg_16_0, arg_16_1)
	return function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_16_1 then
			global_ShowBlockWords(L_ACTIVITY_EXPLORE_END)

			return
		elseif time_check_manager:getCurTime() < arg_16_1.starttime then
			global_ShowBlockWords(L_ACTIVITY_START_TIME)

			return
		elseif arg_16_1.completeCount > 0 then
			global_ShowBlockWords(L_ACTIVITY_HAD_JOINED)

			return
		end

		arg_16_0:showTricketPop(arg_16_1)
	end
end

function ActivitySignLayer_4_1:updateStartBtn(arg_18_1)
	if not arg_18_1 then
		self.startBtn:loadTextures("Activity_LiuLiActivity/startbtn1.png", "Activity_LiuLiActivity/startbtn1_on.png", "Activity_LiuLiActivity/startbtn1.png", var_0_16)
	elseif time_check_manager:getCurTime() < arg_18_1.starttime then
		self.startBtn:loadTextures("Activity_LiuLiActivity/startbtn1.png", "Activity_LiuLiActivity/startbtn1_on.png", "Activity_LiuLiActivity/startbtn1.png", var_0_16)
	elseif arg_18_1.completeCount > 0 then
		self.startBtn:loadTextures("Activity_LiuLiActivity/startbtn1.png", "Activity_LiuLiActivity/startbtn1_on.png", "Activity_LiuLiActivity/startbtn1.png", var_0_16)
	else
		self.startBtn:loadTextures("Activity_LiuLiActivity/startbtn2.png", "Activity_LiuLiActivity/startbtn2_on.png", "Activity_LiuLiActivity/startbtn2.png", var_0_16)
	end
end

function ActivitySignLayer_4_1:initUI()
	self:playFirstEnterTalk()
	self:registerReturnEvent()
	self:initSignBtn()
	self:updateCountDown()
	self:initMarketGiftBtn()
	self:createAwards()
	self:updateTime()
	self:updateFinishtime()
end

local function var_0_20(arg_20_0)
	local var_20_5 = global_get_time_by_date(arg_20_0) - time_check_manager:getCurTime()

	if var_20_5 < 0 then
		return "-1"
	end

	local var_20_6 = math.floor(var_20_5 / 24 / 3600)
	local var_20_7 = math.floor((var_20_5 - var_20_6 * 24 * 3600) / 3600)
	local var_20_8 = math.floor((var_20_5 - var_20_6 * 24 * 3600 - var_20_7 * 3600) / 60)

	return "剩余时间：" .. (var_20_6 ~= 0 and string.format(L_TIME_TEXT[1], var_20_6, var_20_7) or var_20_7 ~= 0 and string.format(L_TIME_TEXT[2], var_20_7, var_20_8) or string.format(L_TIME_TEXT[3], var_20_8))
end

function ActivitySignLayer_4_1:updateFinishtime(...)
	if not self.finishtimelabel then
		self.finishtimelabel = cc.Label:createWithTTF(var_0_20(var_0_19(4)), FONT_NAME, 24)

		self.finishtimelabel:setColor(cc.c3b(255, 255, 255))
		self.finishtimelabel:setAnchorPoint(cc.p(0, 0.5))
		self.finishtimelabel:setPosition(cc.p(10, 1000 + GameDisplay.fix_y))
		self.rootLayer:addChild(self.finishtimelabel, 1001)

		self.finishtimelabelbg = cc.Label:createWithTTF(var_0_20(var_0_19(4)), FONT_NAME, 24)

		self.finishtimelabelbg:setColor(cc.c3b(0, 0, 0))
		self.finishtimelabelbg:setAnchorPoint(cc.p(0, 0.5))
		self.finishtimelabelbg:setPosition(cc.p(9, 999 + GameDisplay.fix_y))
		self.rootLayer:addChild(self.finishtimelabelbg, 1000)
	end

	self.finishtimelabel:setString(var_0_20(var_0_19(4)))
	self.finishtimelabelbg:setString(var_0_20(var_0_19(4)))
end

function ActivitySignLayer_4_1:registerReturnEvent()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_return"):addTouchEventListener(function(arg_23_0, arg_23_1)
		if arg_23_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
end

function ActivitySignLayer_4_1:initSignBtn()
	self.signBtn = ccui.Helper:seekWidgetByName(self.rootLayer, "button_signBtn")

	if self.curAwardsIndex and self.curAwardsIndex >= 5 then
		self.signBtn:setVisible(false)
	end

	self.imgArm = ccui.ImageView:create(string.format(var_0_12, 0))

	self.imgArm:setPosition(self.signBtn:getPositionX(), self.signBtn:getPositionY() + 108)
	self.imgArm:setScale(0.55)
	self.signBtn:getParent():addChild(self.imgArm, 100)
	;(function()
		local var_25_0 = 0

		self:scheduleUpdateWithPriorityLua(function(arg_26_0)
			if var_25_0 > 19 then
				var_25_0 = 0
			end

			self.imgArm:loadTexture(string.format(var_0_12, var_25_0))

			var_25_0 = var_25_0 + 0.5
		end, 0)
	end)()

	if activity_manager:getAlertStatus(self.activityId, "sign") then
		global_add_alert_tag(self.signBtn, cc.p(120, 70))
	end

	self:updateSignbtn()
	self.signBtn:addTouchEventListener(function(arg_27_0, arg_27_1)
		if arg_27_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_27_0:isBright() then
			return
		end

		arg_27_0:setBright(false)

		if self.activitySingCallback then
			if not self.curAwardsIndex then
				global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Nil)
				arg_27_0:setBright(true)
			end

			if self.signstats[self.curAwardsIndex] == true then
				global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Nil)
				arg_27_0:setBright(true)
			end

			self.activitySingCallback(self.curAwardsIndex, function(arg_28_0)
				if arg_28_0 == 1 then
					global_remove_alert_tag(self.signBtn)
					self:activitySign(self.curAwardsIndex)

					self.signstats[self.curAwardsIndex] = true

					self:updateSignbtn()
					self:updateGetAward()
					AnalyticManager.sing_liuli({
						itemid = self.rewardList[self.curAwardsIndex]
					})
				elseif arg_28_0 == 7 then
					global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Error)
				end

				arg_27_0:setBright(true)
			end)
		end
	end)
end

function ActivitySignLayer_4_1:initMarketGiftBtn()
	self.marketGift = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_marketGift")

	self.marketGift:setVisible(false)
	self:saveShopId(function()
		self:updateMarketGiftBtn()
	end)
	self.marketGift:addTouchEventListener(self:getBuyGiftHandle())
end

function ActivitySignLayer_4_1.updateMarketGiftBtn(arg_31_0)
	return
end

function ActivitySignLayer_4_1:updateCountDown()
	if self:activityIsOpen() then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(false)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_countDownBg"):loadTexture("Activity_LiuLiActivity/countdown_off_bg.png", var_0_16)
	else
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(true)
	end
end

function ActivitySignLayer_4_1.activityIsOpen(arg_33_0)
	local var_33_0 = parse_time(var_0_19(4))

	return time_check_manager:getCurTime() > os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_33_0.year,
		month = var_33_0.month,
		day = var_33_0.day - 10
	})
end

local function var_0_21(arg_34_0)
	local var_34_0 = ccui.ImageView:create("Activity_DaKaActivity/item_bg.png", var_0_16)

	var_34_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_34_0:setScale(arg_34_0:getContentSize().width * 0.95 / var_34_0:getContentSize().width)
	var_34_0:setPosition(cc.p(arg_34_0:getContentSize().width / 2, arg_34_0:getContentSize().height / 2 + 2))
	arg_34_0:addChild(var_34_0)
end

function ActivitySignLayer_4_1:createAwards()
	self.rewardList = {}

	local var_35_0 = -14
	local var_35_1 = 84
	local var_35_2 = self.itemPanel:getContentSize().width - 14
	local var_35_4 = 1

	while var_35_4 <= #self.otherData.drops do
		local var_35_5

		if not self.awards_list:getChildByName("award" .. var_35_4) then
			var_35_5 = self.itemPanel:clone()

			self.awards_list:addChild(var_35_5, 10 - var_35_4)
			var_35_5:setName("award" .. var_35_4)
		else
			var_35_5 = self.awards_list:getChildByName("award" .. var_35_4)
		end

		var_35_5:setVisible(true)
		var_35_5:setAnchorPoint(cc.p(0, 0.5))
		var_35_5:setPosition(cc.p(var_35_0 + (var_35_4 - 1) * var_35_2 + var_35_4, var_35_1))

		local var_35_6 = tonumber(split(activity_sign_data[self.activityId .. "-" .. var_35_4].timing, "-")[2])
		local var_35_7 = tonumber(split(activity_sign_data[self.activityId .. "-" .. var_35_4].timing, "-")[3])
		local var_35_8
		local var_35_9

		if drop_data[self.otherData.drops[var_35_4]].drop_id1 then
			var_35_9 = drop_data[self.otherData.drops[var_35_4]].drop_num1
			var_35_8 = drop_data[self.otherData.drops[var_35_4]].drop_id1
		elseif drop_data[self.otherData.drops[var_35_4]].diamond then
			var_35_9 = drop_data[self.otherData.drops[var_35_4]].diamond
			var_35_8 = "diamond"
		elseif drop_data[self.otherData.drops[var_35_4]].gold then
			var_35_9 = drop_data[self.otherData.drops[var_35_4]].gold
			var_35_8 = "gold"
		end

		if not var_35_5:getChildByName("icon") then
			local var_35_10 = ItemSprite:createNewWithItemId(var_35_8, var_35_9, nil, nil, nil, 1)

			var_35_10:setAnchorPoint(cc.p(0.5, 0.5))
			var_35_10:setPosition(cc.p(var_35_5:getContentSize().width / 2, var_35_5:getContentSize().height / 2 + 7))
			var_35_5:addChild(var_35_10)
			var_35_10:setName("icon")
			var_35_10:setScale(0.53)

			self.rewardList[var_35_4] = var_35_8
		end

		var_35_5.itemid = var_35_8
		var_35_5.index = var_35_4

		if var_35_8 ~= "gold" and var_35_8 ~= "diamond" then
			var_35_5.item_type = "item"
		end

		var_35_5:addTouchEventListener(self:getItemTouchHandle())

		if self:isAlikeDay(var_35_4) then
			var_35_5:getChildByName("Image_imageItem"):loadTexture("Activity_LiuLiActivity/frame_cur.png", var_0_16)
			var_35_5:getChildByName("Label_day"):setString("点击领取")
		else
			var_35_5:getChildByName("Label_day"):setString("第" .. L_NUMBER_TEXT[var_35_4] .. "天")
		end

		var_35_5:getChildByName("Image_mend"):setVisible(self:isMendSign(var_35_4))

		var_35_4 = var_35_4 + 1
	end

	self:createLastAward()
	self:getAwards()
end

function ActivitySignLayer_4_1:setSignBtnPos()
	local var_36_0 = {
		78,
		183,
		293,
		397
	}
	local var_36_1 = true

	for iter_36_0 = 1, 4 do
		local var_36_2 = self.awards_list:getChildByName("award" .. iter_36_0)

		if self:isAlikeDay(iter_36_0) then
			self.imgArm:setPositionX(var_36_0[iter_36_0])

			var_36_1 = false

			if var_36_2 then
				var_36_2:getChildByName("Label_day"):setString("点击领取")
			end
		elseif var_36_2 then
			var_36_2:getChildByName("Label_day"):setString("第" .. L_NUMBER_TEXT[iter_36_0] .. "天")
		end
	end

	self.signBtn:setVisible(false)

	if var_36_1 then
		self.imgArm:setVisible(false)
	end
end

function ActivitySignLayer_4_1:updateAwards()
	local var_37_1 = 1

	while var_37_1 < #self.otherData.drops do
		local var_37_2 = self.awards_list:getChildByName("award" .. var_37_1)

		if self:isAlikeDay(var_37_1) then
			var_37_2:getChildByName("Image_imageItem"):loadTexture("Activity_LiuLiActivity/frame_cur.png", var_0_16)
		else
			var_37_2:getChildByName("Image_imageItem"):loadTexture("Activity_LiuLiActivity/frame.png", var_0_16)
		end

		var_37_2:getChildByName("Image_mend"):setVisible(self:isMendSign(var_37_1))

		var_37_1 = var_37_1 + 1
	end
end

function ActivitySignLayer_4_1.isMendSign(arg_38_0, arg_38_1)
	return false
end

function ActivitySignLayer_4_1.getItemTouchHandle(arg_39_0)
	return function(arg_40_0, arg_40_1)
		if arg_40_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_39_0:isAlikeDay(arg_40_0.index) then
			if arg_39_0.activitySingCallback then
				print(arg_39_0.curAwardsIndex, arg_39_0.signstats[arg_39_0.curAwardsIndex])

				if not arg_39_0.curAwardsIndex then
					global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Nil)

					return
				end

				if arg_39_0.signstats[arg_39_0.curAwardsIndex] == true then
					global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Nil)

					return
				end

				arg_39_0.activitySingCallback(arg_39_0.curAwardsIndex, function(arg_41_0)
					if arg_41_0 == 1 then
						global_remove_alert_tag(arg_39_0.signBtn)
						arg_39_0:activitySign(arg_39_0.curAwardsIndex)

						arg_39_0.signstats[arg_39_0.curAwardsIndex] = true

						arg_39_0:updateSignbtn()
						arg_39_0:updateGetAward()
					elseif arg_41_0 == 7 then
						global_ShowBlockWords(L_ACTIVITY_SIGN_TODAY.Error)
					end
				end)
			end

			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			hideGainButton = true,
			itemid = arg_40_0.itemid
		})
	end
end

function ActivitySignLayer_4_1:createLastAward()
	local var_42_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_lastItem")
	local var_42_1 = 1301820

	var_42_0:getChildByName("Label_day"):setString("琉璃")
	var_42_0:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:showAwardsDetails(var_42_1, "item")
	end)
end

function ActivitySignLayer_4_1:updateLastAward()
	itemPanel = ccui.Helper:seekWidgetByName(self.rootLayer, "award" .. #self.otherData.drops)

	itemPanel:getChildByName("Image_mend"):setVisible(self:isMendSign(#self.otherData.drops))
end

function ActivitySignLayer_4_1:getAwards()
	local function var_45_0(arg_46_0)
		local var_46_0

		if config._DEBUG then
			var_46_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
		end

		var_46_0:setScale(0.7)
		var_46_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_46_0:setPosition(cc.p(arg_46_0:getContentSize().width * 3 / 4 - 10, arg_46_0:getContentSize().height / 4))
		var_46_0:setName("success")
		arg_46_0:addChild(var_46_0, 10)
		var_0_21(arg_46_0)
	end

	for iter_45_0, iter_45_1 in pairs(self.signstats) do
		local var_45_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "award" .. iter_45_0)

		if iter_45_1 then
			if not var_45_1:getChildByName("success") then
				var_45_0(var_45_1)
			end

			var_45_1:getChildByName("success"):setVisible(true)
		elseif var_45_1:getChildByName("success") then
			var_45_1:getChildByName("success"):setVisible(false)
		end
	end
end

function ActivitySignLayer_4_1:activitySign(arg_47_1)
	if self.signstats[arg_47_1] == false then
		local function var_47_0(arg_48_0)
			local var_48_0

			if config._DEBUG then
				var_48_0 = cc.Sprite:create("public/panelbg/fragment_tic_new.png") or cc.Sprite:createWithSpriteFrameName("public/panelbg/fragment_tic_new.png")
			end

			var_48_0:setScale(3.5)
			var_48_0:setAnchorPoint(cc.p(0.5, 0.5))
			var_48_0:setPosition(cc.p(arg_48_0:getContentSize().width * 3 / 4 - 10, arg_48_0:getContentSize().height / 4))
			var_48_0:setName("success")
			arg_48_0:addChild(var_48_0, 10)
			var_0_21(arg_48_0)
			var_48_0:runAction(cc.ScaleTo:create(0.5, 0.7))
		end

		local var_47_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "award" .. arg_47_1)

		var_47_1:getChildByName("Image_mend"):setVisible(self:isMendSign(arg_47_1))

		if var_47_1.itemid ~= "gold" and var_47_1.itemid ~= "diamond" then
			if item_data[var_47_1.itemid].bag_item_type == kITEM_HERO then
				require("view.Layer.GetRoleAnimationLayer")
				cc.Director:getInstance():getRunningScene():addChild(GetRoleAnimationLayer:create(var_47_1.itemid, function()
					var_47_0(var_47_1)
				end), 999)
			else
				var_47_0(var_47_1)
			end
		else
			var_47_0(var_47_1)
		end
	end
end

function ActivitySignLayer_4_1.exitCallback(arg_50_0, arg_50_1)
	KeyCodeManager:onKeyReleasedCallFunc()
end

function ActivitySignLayer_4_1.showAwardsDetails(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_2 == "item" then
		if item_data[arg_51_1].bag_item_type == kITEM_HORCRUX then
			local var_51_0 = -1
			local var_51_1 = require("data.horcrux_data")[arg_51_1].horcruxtype

			for iter_51_0, iter_51_1 in pairs((require("data.photofile_HelpGirl_data"))) do
				if arg_51_1 == iter_51_1.item_id then
					var_51_0 = iter_51_0

					break
				end
			end

			if var_51_0 == -1 then
				print("did not find id")

				return
			end

			LayerManager:pushInLayer("DetailsofHelpGirlLayer", {
				id = var_51_0,
				itemid = arg_51_1,
				callback = callback
			})
		elseif item_data[arg_51_1].bag_item_type == kITEM_HERO then
			LayerManager:pushInLayer("SoulsLayer", {
				showListButton = true,
				showtype = 6,
				layertype = "DropDetailsLayer",
				cursoul = item_data[arg_51_1].servant
			})
		else
			LayerManager:pushInLayer("PopItemLayer", {
				hideGainButton = true,
				itemid = arg_51_1
			})
		end
	elseif arg_51_2 == "gold" then
		-- block empty
	elseif arg_51_2 == "diamond" then
		-- block empty
	end
end

function ActivitySignLayer_4_1:updateTime()
	local var_52_5 = parse_time(var_0_19(4))
	local var_52_6 = os.time({
		hour = 0,
		min = 0,
		sec = 0,
		year = var_52_5.year,
		month = var_52_5.month,
		day = var_52_5.day - 10
	}) - playermodel.onlineTime

	if var_52_6 < 0 then
		ccui.Helper:seekWidgetByName(self.rootLayer, "Image_countDownBg"):loadTexture("Activity_LiuLiActivity/countdown_off_bg.png", var_0_16)
		ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setVisible(false)
	end

	local var_52_7 = math.floor(var_52_6 / 24 / 3600)
	local var_52_8 = math.floor((var_52_6 - var_52_7 * 24 * 3600) / 3600)
	local var_52_9 = math.floor((var_52_6 - var_52_7 * 24 * 3600 - var_52_8 * 3600) / 60)

	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time"):setString(var_52_7 ~= 0 and string.format(L_TIME_FORMAT[1], var_52_7, var_52_8) or var_52_8 ~= 0 and string.format(L_TIME_TEXT[2], var_52_8, var_52_9) or string.format(L_TIME_TEXT[3], var_52_9))
end

function ActivitySignLayer_4_1:isAlikeDay(arg_53_1)
	local var_53_0 = 1

	for iter_53_0, iter_53_1 in pairs(self.signstats) do
		if iter_53_1 then
			var_53_0 = iter_53_0 + 1
		end
	end

	if not self.cansign then
		var_53_0 = var_53_0 - 1
	end

	return arg_53_1 == var_53_0
end

function ActivitySignLayer_4_1.getBuyGiftHandle(arg_54_0)
	return function(arg_55_0, arg_55_1)
		if arg_55_1 ~= ccui.TouchEventType.ended then
			return
		end

		local function var_55_0()
			arg_54_0:showShopPop()
		end

		if not arg_54_0.shopitem then
			arg_54_0:saveShopId(var_55_0)
		else
			var_55_0()
		end
	end
end

function ActivitySignLayer_4_1:saveShopId(arg_57_1)
	self.activity:get_activity_shopitem(function(arg_58_0, arg_58_1)
		if arg_58_0 == 1 then
			self.shopitem = arg_58_1

			if arg_57_1 then
				arg_57_1()
			end
		end
	end)
end

function ActivitySignLayer_4_1:showShopPop()
	AnalyticManager.click_liuli_giftpackage()

	local var_59_0 = ccui.Layout:create()

	var_59_0:setTouchEnabled(true)
	var_59_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_59_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_59_0:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_59_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_59_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_59_0:setBackGroundColorOpacity(180)
	self:addChild(var_59_0, 10)

	local var_59_1 = ccui.ImageView:create("mainScenebg/market/" .. item_data[self.shopitem.itemtype].image_id .. ".png")

	var_59_1:setPosition(cc.p(var_59_0:getContentSize().width / 2, var_59_0:getContentSize().height / 2))
	var_59_0:addChild(var_59_1)

	local var_59_2 = ccui.Layout:create()

	var_59_2:setContentSize(cc.size(var_59_1:getContentSize().width, 30))
	var_59_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_59_2:setPosition(cc.p(var_59_1:getContentSize().width / 2, -var_59_2:getContentSize().height / 2))
	var_59_2:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_59_2:setBackGroundColor(cc.c3b(0, 0, 0))
	var_59_2:setBackGroundColorOpacity(220)
	var_59_1:addChild(var_59_2, 10)

	local var_59_3 = cc.Label:createWithTTF(item_data[self.shopitem.itemtype].name, FONT_DES, 22)

	var_59_3:setPosition(cc.p(var_59_2:getContentSize().width / 2, var_59_2:getContentSize().height / 2))
	var_59_2:addChild(var_59_3)

	local var_59_4 = ccui.ImageView:create("public/currency/" .. item_data[GIFT_TICKET].image_id .. ".png", var_0_16)

	var_59_4:setPositionX(var_59_1:getContentSize().width / 2 - 20)
	var_59_4:setPositionY(-150)
	var_59_1:addChild(var_59_4)

	local var_59_5 = cc.Label:createWithTTF(self.shopitem.discount, FONT_DES, 23)

	var_59_5:setAnchorPoint(cc.p(0, 0.5))
	var_59_5:setPositionX(var_59_4:getPositionX() + var_59_4:getContentSize().width / 2 + 5)
	var_59_5:setPositionY(var_59_4:getPositionY())
	var_59_1:addChild(var_59_5)

	local var_59_6 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y.png", var_0_16)
	local var_59_7 = cc.Label:createWithTTF(L_BUTTON_TEXT.Buy, FONT_BUTTON, 26)

	var_59_7:setColor(cc.c3b(12, 12, 12))
	var_59_6:setScale9Enabled(true)
	var_59_6:setCapInsets(cc.rect(90, 30, 20, 20))
	var_59_6:setContentSize(cc.size(500, var_59_6:getContentSize().height))
	var_59_6:setPosition(cc.p(var_59_1:getContentSize().width / 2, -100))
	var_59_7:setPosition(cc.p(var_59_6:getContentSize().width / 2, var_59_6:getContentSize().height / 2))
	var_59_6:addChild(var_59_7)
	var_59_1:addChild(var_59_6)
	var_59_6:addTouchEventListener(function(arg_60_0, arg_60_1)
		if arg_60_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:ShopSlider(arg_60_0, arg_60_1, function()
			var_59_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
				var_59_0:runAction(cc.RemoveSelf:create())
			end)))
		end)
	end)
	var_59_1:setScaleY(0)
	var_59_1:runAction(cc.ScaleTo:create(0.2, 1))
	var_59_0:addTouchEventListener(function(arg_63_0, arg_63_1)
		var_59_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.2, 1, 0), cc.CallFunc:create(function()
			var_59_0:runAction(cc.RemoveSelf:create())
		end)))
	end)
end

function ActivitySignLayer_4_1:ShopSlider(arg_65_1, arg_65_2, arg_65_3)
	if arg_65_2 ~= ccui.TouchEventType.ended then
		return
	end

	arg_65_1:setTouchEnabled(false)
	shop_manager:shop_buy(shop_data[self.shopitem.shopid].shop_type, self.shopitem.shopid, function(arg_66_0)
		if arg_66_0 == 1 then
			self:updateMarketGiftBtn()
			AnalyticManager.buy_liuli_giftpackage()
		elseif arg_66_0 == 2 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[2])
		elseif arg_66_0 == 3 then
			global_ShowBlockWords(L_MARKET_BUY_WARNING[3])
		else
			global_ShowBlockWords(L_MARKET_BUY_WARNING[4])
			LayerManager:pushInLayer("PopGoBuyGiftTicketLayer", {
				targetlayer = "PopSupermarketLayer"
			})
		end

		if arg_65_3 then
			arg_65_3(arg_66_0)
		end
	end)
end

function ActivitySignLayer_4_1:playFirstEnterTalk()
	if RoleDefault:getInstance():getIntegerForKey("is_entered_activity_4_1", 0) == 0 then
		RoleDefault:getInstance():setIntegerForKey("is_entered_activity_4_1", self.activityId)

		local var_67_0 = TalkLayer:create(activity_conf_data[self.activityId].Start_conversation, nil, TALK_TYPE_NORMAL, L_ACTIVITY_FIRST_ENTER, nil, 1)

		var_67_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_67_0, 1000000)
	end
end

function ActivitySignLayer_4_1:isLastAward(arg_68_1, arg_68_2)
	if arg_68_1 == 5 then
		local var_68_0 = TalkLayer:create(activity_conf_data[self.activityId].specail_talkid, nil, TALK_TYPE_NORMAL, L_ACTIVITY_HAD_OPEND, arg_68_2, 1)

		var_68_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_68_0, 1000000)
	else
		arg_68_2()
	end
end

function ActivitySignLayer_4_1:showConfirmDialogPop()
	local var_69_0 = L_ACTIVITY_SIGN_CONFIRM.Des
	local var_69_1 = L_ACTIVITY_SIGN_CONFIRM.Title
	local var_69_2 = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "Pop_Chapter_require.json" or "Pop_Chapter_require.ExportJson")
	local var_69_3 = string.len(L_ACTIVITY_SIGN_CONFIRM.Des) * 8 + 10 > 320 and 320 or string.len(var_69_0) * 8 + 10
	local var_69_5 = ccui.Helper:seekWidgetByName(var_69_2, "Panel")

	var_69_5:setPositionY(var_69_5:getPositionY() - GameDisplay.fix_y)
	var_69_5:setContentSize(GameDisplay.getUiScreenSize())

	local var_69_6 = ccui.Helper:seekWidgetByName(var_69_2, "box")

	var_69_6:setPositionY(var_69_6:getPositionY() + GameDisplay.fix_y - GameDisplay.notch_height)
	ccui.Helper:seekWidgetByName(var_69_2, "description"):setContentSize(var_69_3, 60)
	ccui.Helper:seekWidgetByName(var_69_2, "title"):setString(var_69_1)
	ccui.Helper:seekWidgetByName(var_69_2, "description"):setString(var_69_0)
	ccui.Helper:seekWidgetByName(var_69_2, "image_Q"):loadTexture("roleimage/role1/100.png")

	local var_69_7 = ccui.Helper:seekWidgetByName(var_69_2, "button")

	var_69_7:getChildByName("button_label"):setString(L_BUTTON_TEXT.Sure)
	var_69_7:addTouchEventListener(function(arg_70_0, arg_70_1)
		if arg_70_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_69_2:runAction(cc.RemoveSelf:create())
	end)
	var_69_2:addTouchEventListener(function(arg_71_0, arg_71_1)
		if arg_71_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_69_2:runAction(cc.RemoveSelf:create())
	end)
	self.rootLayer:addChild(var_69_2, 100)
end

function ActivitySignLayer_4_1:showTricketPop(arg_72_1)
	local var_72_0 = ccui.Layout:create()

	var_72_0:setTouchEnabled(true)
	var_72_0:setContentSize(GameDisplay.getScreenSize())
	var_72_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_72_0:setPosition(cc.p(self.rootLayer:getContentSize().width / 2, self.rootLayer:getContentSize().height / 2))
	var_72_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_72_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_72_0:setBackGroundColorOpacity(180)

	local var_72_1 = ccui.ImageView:create("Activity_LiuLiActivity/ticket_bg.png", var_0_16)

	var_72_1:setPositionX(var_72_0:getContentSize().width / 2)
	var_72_1:setPositionY(var_72_0:getContentSize().height / 2 + 50)
	var_72_0:addChild(var_72_1)
	var_72_1:setScaleY(0)
	var_72_1:runAction(cc.ScaleTo:create(0.2, 1, 1))
	var_72_0:addTouchEventListener(function(arg_73_0, arg_73_1)
		if arg_73_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_72_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1, 0), cc.CallFunc:create(function()
			var_72_0:runAction(cc.RemoveSelf:create())
		end)))
	end)

	local var_72_2 = arg_72_1.needTbl

	for iter_72_0, iter_72_1 in pairs(arg_72_1.needTbl) do
		if arg_72_1.needTbl[iter_72_0].itemid == self.ticketItem1 then
			arg_72_1.needTbl[iter_72_0].ownNum = self.ownNum1
			arg_72_1.needTbl[iter_72_0].needNum = self.needNum1
		end

		if arg_72_1.needTbl[iter_72_0].itemid == self.ticketItem2 then
			arg_72_1.needTbl[iter_72_0].ownNum = self.ownNum2
			arg_72_1.needTbl[iter_72_0].needNum = self.needNum2
		end

		local var_72_3 = ItemSmallSprite:createSmallItem(arg_72_1.needTbl[iter_72_0].itemid, arg_72_1.needTbl[iter_72_0].ownNum, arg_72_1.needTbl[iter_72_0].needNum)

		var_72_3:setScale(0.7)
		var_72_3:setInfoTouchEvent(true)
		var_72_3:setPositionX(var_72_1:getContentSize().width / 2 - (iter_72_0 - (#arg_72_1.needTbl + 1) / 2) * (var_72_3:getContentSize().width + 5))
		var_72_3:setPositionY(110)
		var_72_1:addChild(var_72_3)
	end

	local var_72_4 = ccui.Button:create("Activity_LiuLiActivity/start_activity_big.png", "Activity_LiuLiActivity/start_activity_big_on.png", "Activity_LiuLiActivity/start_activity_big.png", var_0_16)

	var_72_4:setPositionX(320)
	var_72_4:setPositionY(-50)
	var_72_1:addChild(var_72_4)
	var_72_4:addTouchEventListener(function(arg_75_0, arg_75_1)
		if arg_75_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not var_72_4:isBright() then
			return
		end

		for iter_75_0, iter_75_1 in pairs(var_72_2) do
			if iter_75_1.ownNum < iter_75_1.needNum then
				global_ShowBlockWords("进入演唱会的道具不足，请签到获得")

				return
			end
		end

		var_72_4:setBright(false)
		AnalyticManager.join_vocal_concert()
		require("controller.explore_manager"):begin_explore({
			type = "activity",
			returnLayer = "ActivitySignLayer_4_1",
			activity_explore_id = arg_72_1.id,
			activityid = self.activityId,
			cancelCallback = function()
				var_72_4:setBright(true)

				if msg == 2 then
					global_ShowBlockWords(L_ACTIVITY_CLOSE)
				elseif msg == 3 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[3])
				elseif msg == 4 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[4])
				elseif msg == 5 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[5])
				elseif msg == 6 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[6])
				elseif msg == 7 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[7])
				elseif msg == 8 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[8])
				elseif msg == 0 then
					global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[0])
				end
			end
		})
	end)
	self.rootLayer:addChild(var_72_0, 100)
end

function ActivitySignLayer_4_1:getSpecialExploreConfig(arg_77_1)
	local function var_77_0(arg_78_0)
		local var_78_0 = {}

		while arg_78_0["need_item" .. 1] do
			table.insert(var_78_0, {
				itemid = arg_78_0["need_item" .. 1],
				ownNum = var_0_10:getItemNumber(arg_78_0["need_item" .. 1]),
				needNum = arg_78_0["need_num" .. 1]
			})
		end

		return var_78_0
	end

	local function var_77_1(arg_79_0)
		if arg_79_0.buy_times + 5 - arg_79_0.total_daily_times > 0 then
			return true
		end
	end

	self.activity:get_activity_explore(function(arg_80_0)
		local var_80_0

		if arg_80_0.result == 1 then
			var_80_0 = {
				id = 1,
				starttime = os.time(parse_time("2019-09-23 00:00:00")),
				needTbl = var_77_0(require("data." .. activity_manager:getExplorefile(4))[1]),
				completeCount = arg_80_0.explore_info[1].finish_times
			}

			if var_77_1(arg_80_0) then
				self.is_entrance_reddot = true

				if self.ActivityExploreIcon and not self.ActivityExploreIcon:getChildByName("can_change") then
					local var_80_2 = ccui.ImageView:create("public/reddot/can_change.png", var_0_16)

					var_80_2:setPosition(cc.p(self.ActivityExploreIcon:getContentSize().width / 2 + 40, self.ActivityExploreIcon:getContentSize().height / 2 + 20))
					self.ActivityExploreIcon:addChild(var_80_2, 1000)
					var_80_2:setName("can_change")
				end
			end
		end

		if arg_77_1 then
			arg_77_1(var_80_0)
		end
	end)
end

function ActivitySignLayer_4_1:createActivityExploreIcon()
	local activity_img_data = require("data.activity_img_data")
	local var_81_1 = 4
	local var_81_2 = activity_manager:getActivityObj(4)

	if not var_81_2 then
		return
	end

	print(var_81_2:getStatus(), var_81_2._explore)

	if var_81_2:getStatus() ~= 2 then
		return
	end

	if not var_81_2._explore then
		return
	end

	self.ActivityExploreIcon = ccui.Button:create("mainScenebg/activity/" .. activity_img_data[4].path .. "/explore_entrance.png", nil, "mainScenebg/activity/" .. activity_img_data[4].path .. "/explore_entrance.png")

	self.ActivityExploreIcon:setPosition(320, 33)
	self.ActivityExploreIcon:setVisible(false)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom"):addChild(self.ActivityExploreIcon, 9)

	if self.is_entrance_reddot then
		alert_manager:add_alert_by_config(self.ActivityExploreIcon, true, {
			ALERT_SHOW_REDDOT,
			"",
			cc.p(134, 48)
		})
	end

	self.ActivityExploreIcon:addTouchEventListener(function(arg_82_0, arg_82_1)
		if arg_82_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.ActivityExploreIcon:isBright() then
			return
		end

		self.ActivityExploreIcon:setBright(false)
		AnalyticManager.click_join_liuli_plot()
		var_81_2:get_activity_explore(function(arg_83_0, arg_83_1)
			if arg_83_0.result == 1 then
				if arg_83_1 then
					require("controller.explore_manager"):begin_explore({
						type = "activity",
						returnLayer = "ActivitySignLayer_4_1",
						activity_explore_id = arg_83_1,
						activityid = self.activityId,
						cancelCallback = function(arg_84_0)
							self.ActivityExploreIcon:setBright(true)

							if arg_84_0 == 2 then
								global_ShowBlockWords("活动已关闭")
							elseif arg_84_0 == 3 then
								global_ShowBlockWords("活动探险id不存在")
							elseif arg_84_0 == 4 then
								global_ShowBlockWords("该关卡只能探险一次")
							elseif arg_84_0 == 5 then
								global_ShowBlockWords("门票不足")
							elseif arg_84_0 == 6 then
								global_ShowBlockWords("开启时间未到")
							elseif arg_84_0 == 7 then
								global_ShowBlockWords("该关卡每日探险次数已用尽")
							elseif arg_84_0 == 8 then
								global_ShowBlockWords("前置关卡未通关")
							elseif arg_84_0 == 0 then
								global_ShowBlockWords("活动探险未开放")
							end
						end
					})
				else
					LayerManager:switchShowLayer("ActivityExploreLayer", {
						ui_name = "ActivitySignLayer_4_1",
						activityid = var_81_1,
						explore_info = arg_83_0.explore_info,
						total_daily_times = arg_83_0.total_daily_times,
						buy_times = arg_83_0.buy_times
					})
				end
			else
				self.ActivityExploreIcon:removeFromParent()
			end
		end)
	end)
end

function ActivitySignLayer_4_1:initDisplayValue(arg_85_1)
	self.displayPos = global_get_node_display_posy(arg_85_1, {
		Image_awardsBg = {
			focusName = "Image_awardsBg",
			reference = TRANSFORM_REFERENCE.DOWN,
			posY = 216 + GameDisplay.fix_y,
			unit = TRANSFORM_UNIT.PX
		},
		Button_marketGift = {
			posY = 0.13,
			focusName = "Button_marketGift",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PER
		},
		Image_countDownBg = {
			posY = 150,
			focusName = "Image_countDownBg",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PX
		},
		Image_16 = {
			posY = 0.36,
			focusName = "Image_16",
			reference = TRANSFORM_REFERENCE.UP,
			unit = TRANSFORM_UNIT.PER
		},
		Panel_bottom = {
			focusName = "Panel_bottom",
			reference = TRANSFORM_REFERENCE.DOWN,
			posY = GameDisplay.fix_y,
			unit = TRANSFORM_UNIT.PX
		}
	})

	for iter_85_0, iter_85_1 in pairs(self.displayPos) do
		local var_85_0 = ccui.Helper:seekWidgetByName(arg_85_1, iter_85_0)

		if var_85_0 then
			var_85_0:setPositionY(iter_85_1)
		end
	end

	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_countDownBg"):setPositionY(1060 + GameDisplay.fix_y)
end

function ActivitySignLayer_4_1:intoLayerAni()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_awardsBg"):setOpacity(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_awardsBg"):runAction(cc.FadeIn:create(0.16666666666666666))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom"):setPositionY(ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom"):getPositionY() - 100)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_bottom"):runAction(cc.MoveBy:create(0.16666666666666666, cc.p(0, 100)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_countDownBg"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Image_countDownBg"):getPositionX() - 200)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_countDownBg"):runAction(cc.MoveBy:create(0.16666666666666666, cc.p(200, 0)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_marketGift"):setPositionX(ccui.Helper:seekWidgetByName(self.rootLayer, "Button_marketGift"):getPositionX() + 200)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_marketGift"):runAction(cc.MoveBy:create(0.16666666666666666, cc.p(-200, 0)))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_16"):setOpacity(0)
	ccui.Helper:seekWidgetByName(self.rootLayer, "Image_16"):runAction(cc.Sequence:create(cc.DelayTime:create(0.03333333333333333), cc.FadeIn:create(0.16666666666666666)))
end
