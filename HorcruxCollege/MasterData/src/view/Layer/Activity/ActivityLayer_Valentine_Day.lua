ActivityLayer_Valentine_Day = class("ActivityLayer_Valentine_Day", function()
	return cc.Layer:create()
end)

local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")

require("view.Sprite.BottomBtnList")

function ActivityLayer_Valentine_Day.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLayer_Valentine_Day.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLayer_Valentine_Day:init()
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityValentineLayer.json" or "ActivityValentineLayer.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:initBottomList()
	self:fullScreen()
end

function ActivityLayer_Valentine_Day:initUI()
	self.surplusTime = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_time")

	self:updateTime()
	self:initRule()
	self:btnShop()
	self:btnClothes()
	self:btnPackage()
	self:btnTwist()
	self:btnDorm()
	self:btnQuick()
	self:btnRank()
end

function ActivityLayer_Valentine_Day:btnShop()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_shop"):addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_6_0 = cc.EventCustom:new("switchShowLayer")

		var_6_0.layerName = "MarketLayer"
		var_6_0.initparam = {
			returnLayer = "ActivityLayer_Valentine_Day",
			singleMarket = {
				"1-10301"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_6_0)
	end)
end

function ActivityLayer_Valentine_Day:btnClothes()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_clothes"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_8_0 = cc.EventCustom:new("switchShowLayer")

		var_8_0.layerName = "MarketLayer"
		var_8_0.initparam = {
			returnLayer = "ActivityLayer_Valentine_Day",
			singleMarket = {
				"1-10303"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_8_0)
	end)
end

function ActivityLayer_Valentine_Day:btnPackage()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_package"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_10_0 = cc.EventCustom:new("switchShowLayer")

		var_10_0.layerName = "MarketLayer"
		var_10_0.initparam = {
			returnLayer = "ActivityLayer_Valentine_Day",
			singleMarket = {
				"1-10302"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_10_0)
	end)
end

function ActivityLayer_Valentine_Day:btnTwist()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_twist"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = cc.EventCustom:new("switchShowLayer")

		var_12_0.layerName = "TwisteggLayer"
		var_12_0.initparam = {
			initTwisType = 180103,
			returnLayer = "ActivityLayer_Valentine_Day"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_12_0)
	end)
end

function ActivityLayer_Valentine_Day:btnDorm()
	local var_13_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_dorm")

	if time_check_manager:getCurTime() > os.time({
		hour = 23,
		month = 2,
		year = 2020,
		min = 59,
		sec = 59,
		day = 14
	}) then
		var_13_0:setVisible(false)
	end

	var_13_0:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		if time_check_manager:getCurTime() > os.time({
			hour = 23,
			month = 2,
			year = 2020,
			min = 59,
			sec = 59,
			day = 14
		}) then
			global_ShowBlockWords(L_ACTIVITY_END)

			return
		end

		local var_14_0 = cc.EventCustom:new("switchShowLayer")

		var_14_0.layerName = "DormitoryLayer"
		var_14_0.initparam = {
			returnLayer = "ActivityLayer_Valentine_Day"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_14_0)
	end)
end

function ActivityLayer_Valentine_Day:btnQuick()
	local var_15_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_quick")

	if time_check_manager:getCurTime() > os.time({
		hour = 23,
		month = 2,
		year = 2020,
		min = 59,
		sec = 59,
		day = 16
	}) then
		var_15_0:setVisible(false)
	end

	var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		if time_check_manager:getCurTime() > os.time({
			hour = 23,
			month = 2,
			year = 2020,
			min = 59,
			sec = 59,
			day = 16
		}) then
			global_ShowBlockWords(L_ACTIVITY_END)

			return
		end

		LayerManager:pushInLayer("PopQuickGuaJiSure", {})
	end)
end

function ActivityLayer_Valentine_Day:btnRank()
	local var_17_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_ranking")

	if time_check_manager:getCurTime() > os.time({
		hour = 23,
		month = 2,
		year = 2020,
		min = 59,
		sec = 59,
		day = 16
	}) then
		var_17_0:setVisible(false)
	end

	var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
		if arg_18_1 ~= ccui.TouchEventType.ended then
			return
		end

		if time_check_manager:getCurTime() > os.time({
			hour = 23,
			month = 2,
			year = 2020,
			min = 59,
			sec = 59,
			day = 16
		}) then
			global_ShowBlockWords(L_ACTIVITY_END)

			return
		end

		LayerManager:pushInLayer("MajorRankListLayer")
	end)
end

function ActivityLayer_Valentine_Day:updateTime()
	local var_19_5 = global_get_time_by_date(activity_conf_data[16].finishtime) - time_check_manager:getCurTime()

	if var_19_5 < 0 then
		self.surplusTime:setVisible(false)
	end

	local var_19_6 = math.floor(var_19_5 / 24 / 3600)
	local var_19_7 = math.floor((var_19_5 - var_19_6 * 24 * 3600) / 3600)
	local var_19_8 = math.floor((var_19_5 - var_19_6 * 24 * 3600 - var_19_7 * 3600) / 60)

	self.surplusTime:setString(L_LEFT_TIME_SPACE .. (var_19_6 ~= 0 and string.format(L_TIME_TEXT[1], var_19_6, var_19_7) or var_19_7 ~= 0 and string.format(L_TIME_TEXT[2], var_19_7, var_19_8) or string.format(L_TIME_TEXT[3], var_19_8)))
end

function ActivityLayer_Valentine_Day:initRule()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Button_detail"):addTouchEventListener(function(arg_21_0, arg_21_1)
		if arg_21_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "activity_valentine_1"
		})
	end)
end

function ActivityLayer_Valentine_Day:fullScreen()
	local var_22_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_time")
	local var_22_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_down")

	var_22_0:setPositionY(var_22_0:getPositionY() + GameDisplay.fix_y)
	var_22_1:setPositionY(var_22_1:getPositionY() - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end

function ActivityLayer_Valentine_Day:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_24_0, arg_24_1)
		if arg_24_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)

	self.bottomList:setName("bottomlist")
	self:addChild(self.bottomList, 10)
end
