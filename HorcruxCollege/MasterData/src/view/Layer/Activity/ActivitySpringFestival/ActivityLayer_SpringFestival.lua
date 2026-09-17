ActivityLayer_SpringFestival = class("ActivityLayer_SpringFestival", function()
	return cc.Layer:create()
end)

local spring_manager = require("controller.spring_manager")
local activity_manager = require("controller.activity_manager")
local autopop_manager = require("controller.autopop_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")
local alert_manager = require("controller.alert_manager")
local playermodel = require("model.playermodel")
local activity_springfestival_data = require("data.activity_springfestival_data")
local var_0_8 = config._DEBUG and 0 or 1
local var_0_9 = {}
local var_0_10 = {
	267,
	362,
	270,
	364,
	263,
	368,
	275
}
local var_0_11 = {
	[1] = "Activity_Spring_Festival/Activity_MainEnter/activity_btn_bottom.png",
	[2] = "Activity_Spring_Festival/Activity_MainEnter/share_btn.png"
}
local var_0_12 = {
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_1.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_1.png"
	},
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_2.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_2.png"
	},
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_3_dark.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_3.png"
	},
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_4_dark.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_4.png"
	},
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_5_dark.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_5.png"
	},
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_6_dark.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_6.png"
	},
	{
		dark = "Activity_Spring_Festival/Activity_MainEnter/list_7_dark.png",
		light = "Activity_Spring_Festival/Activity_MainEnter/list_7.png"
	}
}
local var_0_13 = {
	cc.c3b(255, 186, 113),
	(cc.c3b(191, 178, 149))
}

function ActivityLayer_SpringFestival.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLayer_SpringFestival.new()

	var_2_0:init(arg_2_1)
	activity_manager:fireEvent(activity_manager.activityEventId.POP_LAYER_OPEMED)

	return var_2_0
end

function ActivityLayer_SpringFestival.getInstance()
	return springInstance
end

local var_0_14 = "sign_id1"
local var_0_15 = {}
local var_0_16 = {
	ActivitySignLayer_100_1 = {
		Name = "ActivitySignLayer_100_1",
		type = "PopLayer",
		createLayer = function(...)
			require("controller.sign_manager"):createActivitySignLayer(...)
		end
	}
}

function ActivityLayer_SpringFestival:init()
	springInstance = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivitySpringLayer.json" or "ActivitySpringLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.title_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_title")
	self.btn_panel = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_btn")
	self.info = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_21")
	self.tile = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_39")
	self.share_di = ccui.Helper:seekWidgetByName(self.rootLayer, "wenhao_di")
	self.scrollView = ccui.Helper:seekWidgetByName(self.rootLayer, "ScrollView_24")

	self.scrollView:setContentSize(cc.size(640, 800 + 2 * GameDisplay.fix_y))
	self.share_di:setVisible(false)

	self.btn_sign = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_1")
	self.btn_word = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_5")
	self.btn_fortunebag = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_2")
	self.btn_monster = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_6")
	self.btn_special = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_4")
	self.btn_redbag = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_7")
	self.btn_twist = ccui.Helper:seekWidgetByName(self.btn_panel, "btn_3")

	self.btn_sign:getChildByName("Label_time"):setFontSize(20)

	self.buttons = {
		self.btn_sign,
		self.btn_fortunebag,
		self.btn_twist,
		self.btn_special,
		self.btn_word,
		self.btn_monster,
		self.btn_redbag
	}

	self:addBtnIDTag()
	self:registerTimeCheckEvent()
	self:palyAinEnterorOut(true)
	spring_manager:get_subsystem_time(function(arg_6_0)
		self:initUI(arg_6_0)
	end)
	self:initBottomBtnList()
	self:fullScreen()
	self:autoPopSign()
	self:addRedot()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			if self.callback then
				self.callback()
			end

			springInstance = nil

			activity_manager:releaseEventListenerByName("ActivityLayer_SpringFestival")
		end
	end)
end

function ActivityLayer_SpringFestival.registerActivityEventListener(arg_8_0)
	activity_manager:registerEventListener("ActivityLayer_SpringFestival", activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function()
		arg_8_0:redrawActivityAlert()
	end)
end

function ActivityLayer_SpringFestival:addRedot()
	if activity_manager:getAlertStatus(100, "sign") then
		global_add_alert_tag(self.btn_sign, {
			x = 530,
			y = 141
		})

		var_0_9.sign = {
			self.btn_sign
		}
	end
end

function ActivityLayer_SpringFestival.redrawActivityAlert(arg_11_0)
	local var_11_1 = {
		x = 530,
		y = 141
	}
	local var_11_2 = activity_manager:getActivityListData()[100].list

	for iter_11_0 = 1, #var_11_2 do
		if string.match(var_11_2[iter_11_0].activity_type, "sign") then
			if (activity_manager.alertactivity.sign and activity_manager.alertactivity.sign[100] or nil) and true and #var_0_9.sign == 1 then
				global_add_alert_tag(var_0_9.sign[1], var_11_1)
			elseif #var_0_9.sign == 1 then
				global_remove_alert_tag(var_0_9.sign[1])
			end
		end
	end
end

function ActivityLayer_SpringFestival:initUI(arg_12_1)
	self:addTimeLable(arg_12_1)
	self:updateBtnTexture()

	if spring_manager:can_share() then
		self.share_di:setVisible(true)
		self:createShareButton()
	else
		self.share_di:setVisible(false)
	end

	self.info:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_13_0:setBright(false)

		local var_13_0 = {
			callback = function()
				if springInstance then
					arg_13_0:setBright(true)
				end
			end
		}

		var_13_0.key = "activity_100"

		LayerManager:pushInLayer("PopActivityDetail", var_13_0)
	end)
	self.tile:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_15_0:setBright(false)

		local var_15_0 = {
			callback = function()
				if springInstance then
					arg_15_0:setBright(true)
				end
			end
		}

		var_15_0.key = "activity_100"

		LayerManager:pushInLayer("PopActivityDetail", var_15_0)
	end)
	self.btn_sign:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsTime(arg_17_0.tag) then
			self:pushInLayer((self:getAutoPopLayerConfig({
				activityID = 100
			})))
		end
	end)
	self.btn_fortunebag:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsTime(arg_18_0.tag) then
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_18_0 = cc.EventCustom:new("switchShowLayer")

			var_18_0.layerName = "MarketLayer"
			var_18_0.initparam = {
				showType = "1-10001",
				returnLayer = "ActivityLayer_SpringFestival",
				singleMarket = {
					"1-10001",
					"1-10002",
					"1-10003"
				}
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_18_0)
		end
	end)
	self.btn_monster:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_19_0.isLock then
			return
		end

		arg_19_0.isLock = true

		if self:checkIsTime(arg_19_0.tag) then
			spring_manager:get_nianshou_info(function(arg_20_0)
				if arg_20_0.result == 1 then
					LayerManager:pushInLayer("ActivityNianShou", arg_20_0)
				end

				arg_19_0.isLock = false
			end)
		else
			arg_19_0.isLock = false
		end
	end)
	self.btn_special:addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsTime(arg_21_0.tag) then
			LayerManager:switchShowLayer("BattlePassSpringLayer")
		end
	end)

	local var_12_0 = cc.p(580, 160)

	if activity_manager:getAlertStatus(100, "task") then
		global_add_alert_tag(self.btn_special, var_12_0)
	elseif activity_manager:getAlertStatus(100, "proceed") then
		global_add_alert_tag(self.btn_special, var_12_0)
	else
		global_remove_alert_tag(self.btn_special)
	end

	self.btn_redbag:addTouchEventListener(function(arg_22_0, arg_22_1)
		if arg_22_1 ~= ccui.TouchEventType.ended then
			return
		end

		spring_manager:check_red_packet(function(arg_23_0, arg_23_1)
			if arg_23_0 == 1 and arg_23_1 ~= 3 then
				LayerManager:pushInLayer("PopBachelorWelfareLayer", {
					stat = arg_23_1
				})
			else
				global_ShowBlockWords(L_REDBAG_OVERTIME)
			end
		end)
	end)
	self.btn_twist:addTouchEventListener(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self:checkIsTime(arg_24_0.tag) then
			local var_24_0 = cc.EventCustom:new("switchShowLayer")

			var_24_0.layerName = "TwisteggLayer"
			var_24_0.initparam = {
				initTwisType = 100,
				returnLayer = "ActivityLayer_SpringFestival"
			}

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_24_0)
		end
	end)
end

function ActivityLayer_SpringFestival:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:palyAinEnterorOut(false, function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end, nil, "public/panelbg/under_bottom_spring.png", {
		img = "public/button/bottom_return_btn_spring.png"
	})

	self:addChild(self.bottomlist, 5)
	self:initBottomAddPanel()
end

function ActivityLayer_SpringFestival:updateBtnTexture()
	local function var_28_0(arg_29_0)
		local var_29_0 = spring_manager:getSystemTime()

		if not var_29_0 or not next(var_29_0) then
			return false
		end

		local var_29_1

		for iter_29_0, iter_29_1 in pairs(var_29_0) do
			if iter_29_1.id == arg_29_0 then
				var_29_1 = iter_29_1
			end
		end

		if var_29_1 then
			local var_29_2 = time_check_manager:getCurTime()
			local var_29_3 = global_get_time_by_date(var_29_1.starttime)

			if var_29_2 < var_29_3 then
				return false
			elseif var_29_3 <= var_29_2 and var_29_2 <= global_get_time_by_date(var_29_1.finishtime) then
				return true
			else
				return true
			end
		else
			return false
		end
	end

	for iter_28_0, iter_28_1 in ipairs(self.buttons) do
		if var_28_0(iter_28_1.tag) then
			iter_28_1:loadTextures(var_0_12[iter_28_0].light, nil, var_0_12[iter_28_0].light, var_0_8)
			iter_28_1:getChildByName("Label_time"):setColor(var_0_13[1])
		else
			iter_28_1:loadTextures(var_0_12[iter_28_0].dark, nil, var_0_12[iter_28_0].dark, var_0_8)
			iter_28_1:getChildByName("Label_time"):setColor(var_0_13[2])
		end
	end
end

function ActivityLayer_SpringFestival:initBottomAddPanel()
	local var_30_0 = ccui.Layout:create()

	var_30_0:setPosition(cc.p(320, 30))
	var_30_0:setName("bottomAddPanel")

	self.bottomlayer = var_30_0

	self.bottomlist:addChild(var_30_0)

	local var_30_1 = ccui.Button:create(var_0_11[1], nil, var_0_11[1], var_0_8)

	var_30_1:setPosition(cc.p(225, 0))
	var_30_0:addChild(var_30_1)

	self.btn_shop = var_30_1

	self.btn_shop:addTouchEventListener(function(arg_31_0, arg_31_1)
		if arg_31_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_31_0 = cc.EventCustom:new("switchShowLayer")

		var_31_0.layerName = "MarketLayer"
		var_31_0.initparam = {
			showType = "1-10003",
			returnLayer = "ActivityLayer_SpringFestival",
			singleMarket = {
				"1-10001",
				"1-10002",
				"1-10003"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_31_0)
	end)
end

function ActivityLayer_SpringFestival:createShareButton()
	local var_32_0 = ccui.Button:create(var_0_11[2], nil, var_0_11[2], var_0_8)
	local var_32_1 = ccui.Helper:seekWidgetByName(self.title_panel, "wenhao_di")

	var_32_0:setPosition(cc.p(var_32_1:getPositionX() + 40, var_32_1:getPositionY() - var_32_1:getContentSize().height / 2 - 22))
	self.title_panel:addChild(var_32_0)

	self.btn_share = var_32_0

	self.btn_share:addTouchEventListener(function(arg_33_0, arg_33_1)
		if arg_33_1 ~= ccui.TouchEventType.ended then
			return
		end

		if spring_manager:can_share() then
			LayerManager:pushInLayer("PopActivityShareLayer")
		end
	end)
end

function ActivityLayer_SpringFestival:palyAinEnterorOut(arg_34_1, arg_34_2)
	if not arg_34_1 then
		for iter_34_0, iter_34_1 in pairs(self.buttons) do
			if iter_34_0 % 2 ~= 0 then
				iter_34_1:runAction(cc.MoveTo:create(0.5, cc.p(1500, iter_34_1:getPositionY())))
			else
				iter_34_1:runAction(cc.MoveTo:create(0.5, cc.p(-1500, iter_34_1:getPositionY())))
			end
		end

		if arg_34_2 then
			arg_34_2()
		end
	else
		for iter_34_2, iter_34_3 in pairs(self.buttons) do
			if iter_34_2 % 2 ~= 0 then
				iter_34_3:setPositionX(1500)
			else
				iter_34_3:setPositionX(-1500)
			end
		end

		for iter_34_4, iter_34_5 in pairs(self.buttons) do
			if iter_34_4 % 2 ~= 0 then
				iter_34_5:runAction(cc.MoveTo:create(0.5, cc.p(var_0_10[iter_34_4], iter_34_5:getPositionY())))
			else
				iter_34_5:runAction(cc.MoveTo:create(0.5, cc.p(var_0_10[iter_34_4], iter_34_5:getPositionY())))
			end
		end
	end
end

function ActivityLayer_SpringFestival:addBtnIDTag()
	self.btn_sign.tag = 1
	self.btn_word.tag = 2
	self.btn_redbag.tag = 3
	self.btn_monster.tag = 4
	self.btn_twist.tag = 5
	self.btn_fortunebag.tag = 6
	self.btn_special.tag = 7
end

function ActivityLayer_SpringFestival:addTimeLable(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(self.buttons) do
		local var_36_0 = iter_36_1:getChildByName("Label_time")

		var_36_0:setVisible(false)

		if activity_springfestival_data and next(activity_springfestival_data) then
			for iter_36_2, iter_36_3 in pairs(activity_springfestival_data) do
				if iter_36_3.id == iter_36_1.tag then
					var_36_0:setString("活动时间：" .. self:dealString(activity_springfestival_data[iter_36_2].show_starttime, activity_springfestival_data[iter_36_2].show_finishtime))
					var_36_0:setVisible(true)
				end
			end
		end
	end
end

function ActivityLayer_SpringFestival.dealString(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = os.date("*t", math.floor((global_get_time_by_date(arg_37_1))))
	local var_37_1 = os.date("*t", math.floor((global_get_time_by_date(arg_37_2))))

	return ("" .. var_37_0.month .. "月" .. var_37_0.day .. "日~") .. "" .. var_37_1.month .. "月" .. var_37_1.day .. "日"
end

function ActivityLayer_SpringFestival.checkIsTime(arg_38_0, arg_38_1)
	if not arg_38_1 then
		global_ShowBlockWords("活动暂未开放哦，敬请期待~")

		return false
	end

	local var_38_0 = spring_manager:getSystemTime()

	if not var_38_0 or not next(var_38_0) then
		global_ShowBlockWords("活动暂未开放哦，敬请期待~")

		return false
	end

	local var_38_1

	for iter_38_0, iter_38_1 in pairs(var_38_0) do
		if iter_38_1.id == arg_38_1 then
			var_38_1 = iter_38_1
		end
	end

	if var_38_1 then
		local var_38_2 = time_check_manager:getCurTime()
		local var_38_3 = global_get_time_by_date(var_38_1.starttime)

		if var_38_2 < var_38_3 then
			global_ShowBlockWords("活动暂未开放哦，敬请期待~")

			return false
		elseif var_38_3 <= var_38_2 and var_38_2 <= global_get_time_by_date(var_38_1.finishtime) then
			return true
		else
			global_ShowBlockWords("活动已结束~")
		end
	else
		global_ShowBlockWords("活动暂未开放哦，敬请期待~")

		return false
	end
end

function ActivityLayer_SpringFestival:fullScreen()
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.title_panel:setPositionY(self.title_panel:getPositionY() + GameDisplay.fix_y)
	self.scrollView:setPositionY(-454 - GameDisplay.fix_y)

	local var_39_0 = ccui.Helper:seekWidgetByName(self.btn_panel, "Image_25")

	var_39_0:setScaleY((self.scrollView:getContentSize().height - 13) / 813)
	var_39_0:setPositionY(self.scrollView:getPositionY() + var_39_0:getContentSize().height * var_39_0:getScaleY() / 2)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end

local function var_0_17(arg_40_0)
	if not arg_40_0 then
		return
	end

	return var_0_16[arg_40_0]
end

function ActivityLayer_SpringFestival.getLayerIDTbl(arg_41_0)
	local function var_41_0(arg_42_0, arg_42_1)
		while activity_conf_data[arg_42_0][arg_42_1 .. 1] do
			if arg_42_1 == "sign_id" then
				var_0_15[activity_conf_data[arg_42_0][arg_42_1 .. 1]] = "ActivitySignLayer_100_1"
			end
		end
	end

	for iter_41_0, iter_41_1 in pairs(activity_conf_data) do
		if activity_conf_data[iter_41_0].proceed and activity_conf_data[iter_41_0].proceed ~= 0 then
			var_41_0(iter_41_0, "proceed_id")
		end

		if activity_conf_data[iter_41_0].task and activity_conf_data[iter_41_0].task ~= 0 then
			var_41_0(iter_41_0, "task_id")
		end

		if activity_conf_data[iter_41_0].sign and activity_conf_data[iter_41_0].sign ~= 0 then
			var_41_0(iter_41_0, "sign_id")
		end

		if activity_conf_data[iter_41_0].levelmode and activity_conf_data[iter_41_0].levelmode ~= 0 then
			var_41_0(iter_41_0, "levelmode_id")
		end

		if activity_conf_data[iter_41_0].shoptype and activity_conf_data[iter_41_0].shoptype ~= 0 then
			var_41_0(iter_41_0, "shoptype_id")
		end

		if activity_conf_data[iter_41_0].markettype and activity_conf_data[iter_41_0].markettype ~= 0 then
			var_41_0(iter_41_0, "markettype_id")
		end

		if activity_conf_data[iter_41_0].twisttype and activity_conf_data[iter_41_0].twisttype ~= 0 then
			var_41_0(iter_41_0, "twisttype_id")
		end
	end
end

function ActivityLayer_SpringFestival:pushInLayer(arg_43_1)
	print("PopLayer", dump(arg_43_1))
	self:getLayerIDTbl()

	if not arg_43_1.id then
		print("print id dont exist")

		return layer
	end

	if not var_0_15[arg_43_1.id] then
		print("print layerID dont exist")

		return layer
	end

	print("can create layer")

	self.layerinfo = var_0_17(var_0_15[arg_43_1.id])
	self.layer_type = self.layerinfo.type

	if self.layer_type == "PopLayer" then
		print("PopLayer")
		print(dump(arg_43_1))
		self.layerinfo.createLayer(arg_43_1)
	end
end

function ActivityLayer_SpringFestival.getAutoPopLayerConfig(arg_44_0, arg_44_1)
	local var_44_0 = activity_manager:getActivityListData()[arg_44_1.activityID].list
	local var_44_1 = {}

	for iter_44_0 = 1, #var_44_0 do
		if var_44_0[iter_44_0].activity_type == var_0_14 then
			var_44_1 = var_44_0[iter_44_0]

			break
		end
	end

	var_44_1.activityID = arg_44_1.activityID
	var_44_1.isAutoPop = true

	return var_44_1
end

function ActivityLayer_SpringFestival:autoPopSign()
	local var_45_0 = cc.Node:create()

	self:addChild(var_45_0)
	var_45_0:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function(...)
		local var_46_0 = RoleDefault:getInstance():getIntegerForKey("nextSpAutoPoptime", 0)

		if var_46_0 and time_check_manager:getCurTime() < var_46_0 then
			return
		end

		self:runAction(cc.Sequence:create(cc.DelayTime:create(0), cc.CallFunc:create(function()
			local var_47_0 = self:getAutoPopLayerConfig({
				activityID = 100
			})

			var_47_0.isAutoPop = true

			self:pushInLayer(var_47_0)

			local var_47_1 = os.date("*t", (time_check_manager:getCurTime()))
			local var_47_2 = RoleDefault:getInstance():setIntegerForKey("nextSpAutoPoptime", (os.time({
				hour = 23,
				min = 59,
				sec = 59,
				year = var_47_1.year,
				month = var_47_1.month,
				day = var_47_1.day
			})))
		end)))
	end)))
end

function ActivityLayer_SpringFestival:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_49_0)
		if arg_49_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:updateBtnTexture()
			end)
		end
	end), self)
end
