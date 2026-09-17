ActivityExploreLayer = class("ActivityExploreLayer", function()
	return cc.Layer:create()
end)

local drop_manager = require("controller.drop_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local activity_explore_data = require("data.activity_explore_data")
local activity_conf_data = require("data.activity_conf_data")
local item_data = require("data.item_data")
local playermodel = require("model.playermodel")
local var_0_9 = config._DEBUG and 0 or 1
local var_0_10
local var_0_11 = 5
local var_0_12 = 5
local var_0_13 = 50
local var_0_14 = {
	wind = "explore/wind_long.png",
	water = "explore/water_long.png",
	fire = "explore/fire_long.png",
	light = "explore/light_long.png",
	dark = "explore/dark_long.png"
}

function ActivityExploreLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityExploreLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityExploreLayer.getInstance()
	return var_0_10
end

function ActivityExploreLayer:init(arg_4_1)
	var_0_10 = self

	if not arg_4_1 then
		local var_4_0 = 4

		activity_manager:getActivityObj(4):get_activity_explore(function(arg_5_0, arg_5_1)
			if arg_5_0.result == 1 then
				if not ActivityExploreLayer.getInstance() then
					return
				end

				arg_4_1 = {
					activityid = var_4_0,
					explore_info = arg_5_0.explore_info
				}
				self.activityid = arg_4_1.activityid
				self.total_daily_times = arg_5_0.total_daily_times or 0
				self.buy_times = arg_5_0.buy_times or 0
				self.uiName = "ActivitySignLayer_4_1"

				self:initActivityExploreInfo(arg_4_1.explore_info)
				self:initUI()
				self:initList()
			else
				global_ShowBlockWords(L_ACTIVITY_EXPLORE_END)
				LayerManager:switchShowLayer("ActivitySignLayer_4_1")
			end
		end)
	else
		self.activityid = arg_4_1.activityid
		self.total_daily_times = arg_4_1.total_daily_times or 0
		self.buy_times = arg_4_1.buy_times or 0
		self.uiName = arg_4_1.ui_name

		self:initActivityExploreInfo(arg_4_1.explore_info)
		self:initUI()
		self:initList()
	end

	playermodel:getServerTime()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			var_0_10 = nil
		end
	end)
end

function ActivityExploreLayer:initActivityExploreInfo(arg_7_1)
	self.nextLockId = 2
	self.exploreConfig = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if activity_explore_data[iter_7_1.id] and activity_explore_data[iter_7_1.id].type == 2 then
			self.exploreConfig[iter_7_1.id] = {
				id = iter_7_1.id,
				finish_times = iter_7_1.finish_times,
				daily_times = iter_7_1.daily_times,
				order = activity_explore_data[iter_7_1.id].order
			}
		end
	end
end

function ActivityExploreLayer:initUI()
	self.bg = cc.Sprite:create("mainScenebg/explore/explore_bg.jpg")

	self.bg:setPosition(320, GameDisplay.height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg)

	self.layout = ccui.Layout:create()

	self.layout:setContentSize(cc.size(640, GameDisplay.height))
	self.layout:setTouchEnabled(true)
	self.layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.layout:setBackGroundColor(cc.c3b(0, 0, 0))
	self.layout:setBackGroundColorOpacity(120)
	self.layout:setCascadeOpacityEnabled(false)
	self.layout:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.layout)

	self.bottomList = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchReturnLayer(self.uiName)
	end)

	self.layout:addChild(self.bottomList, 99)

	self.scrollView = ccui.ScrollView:create()

	self.scrollView:setContentSize(cc.size(640, 900 + GameDisplay.height - 1136))
	self.scrollView:setName("scrollView")
	self.scrollView:setInnerContainerSize(cc.size(640, table.nums(self.exploreConfig) * 240))
	self.scrollView:setAnchorPoint(cc.p(0, 0))
	self.scrollView:setPosition(0, 60)
	self.layout:addChild(self.scrollView)

	local var_8_0 = os.time(parse_time(activity_conf_data[self.activityid].finishtime)) - os.time()
	local var_8_1 = ccui.ImageView:create("explore/activity_time_bg.png", var_0_9)

	var_8_1:setAnchorPoint(cc.p(0, 0.5))
	var_8_1:setPosition(380, GameDisplay.height - 110)
	self.layout:addChild(var_8_1)

	self.timeLabel = cc.Label:createWithTTF(string.format(L_TIME_FORMAT_DAYNHOUR, math.floor(var_8_0 / 86400), math.floor(var_8_0 % 86400 / 3600)), FONT_TITLE, 28)

	self.timeLabel:setPosition(170, var_8_1:getContentSize().height / 2)
	var_8_1:addChild(self.timeLabel)

	local var_8_2 = ccui.ImageView:create("explore/daily_time_bg.png", var_0_9)

	var_8_2:setAnchorPoint(cc.p(0, 0.5))
	var_8_2:setPosition(380, GameDisplay.height - 155)
	self.layout:addChild(var_8_2)

	self.dailyTimeLabel = cc.Label:createWithTTF(self.buy_times + var_0_11 - self.total_daily_times, FONT_TITLE, 28)

	self.dailyTimeLabel:setColor(cc.c3b(0, 255, 102))
	self.dailyTimeLabel:setPosition(var_8_2:getContentSize().width + 5, var_8_2:getContentSize().height / 2)
	var_8_2:addChild(self.dailyTimeLabel)

	self.addDailyTimeBnt = ccui.Button:create("explore/activity_add_bnt.png", nil, "explore/activity_add_bnt.png", var_0_9)

	self.addDailyTimeBnt:setPosition(self.dailyTimeLabel:getPositionX() + 30, self.dailyTimeLabel:getPositionY())
	var_8_2:addChild(self.addDailyTimeBnt)
	self.addDailyTimeBnt:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_10_0.isLock then
			return
		end

		arg_10_0.isLock = true

		LayerManager:pushInLayer("PopDoLayer", {
			costtype = "diamond",
			surecallback = function()
				self:buyDailyTimes(function()
					arg_10_0.isLock = false
				end)
			end,
			cancelcallback = function()
				arg_10_0.isLock = false
			end,
			own = playermodel.diamond,
			cost = var_0_13 * (self.buy_times + 1),
			labels = {
				titleImage = "title_get_times.png",
				des = string.format(L_ACTIVITY_EXPLORE_BUY_TIMES, var_0_13 * (self.buy_times + 1), 1),
				button = L_ACTIVITY_EXPLORE_BUY_TIMES.button
			}
		})
	end)

	if self.buy_times + var_0_11 - self.total_daily_times == 0 and self.buy_times < var_0_12 then
		self.addDailyTimeBnt:setVisible(true)
	else
		self.addDailyTimeBnt:setVisible(false)
	end

	local var_8_3 = ccui.ImageView:create("explore/city_name201.png", var_0_9)

	var_8_3:setAnchorPoint(cc.p(0, 0.5))
	var_8_3:setPosition(10, GameDisplay.height - 130)
	self.layout:addChild(var_8_3)

	local var_8_4 = ccui.ImageView:create("explore/city_name_bg.png", var_0_9)

	var_8_4:setPosition(var_8_3:getContentSize().width / 2, var_8_3:getContentSize().height / 2)
	var_8_3:addChild(var_8_4, -1)

	local var_8_5 = ccui.Button:create("explore/shop_img.png", nil, "explore/shop_img.png", var_0_9)

	var_8_5:setAnchorPoint(cc.p(1, 0.5))
	var_8_5:setPosition(640, 44)
	self.bottomList:addChild(var_8_5)
	var_8_5:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_14_0 = cc.EventCustom:new("switchShowLayer")

		var_14_0.layerName = "MarketLayer"
		var_14_0.initparam = {
			singleMarket = "1-8",
			returnLayer = "ActivityExploreLayer"
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_14_0)
	end)
	var_8_1:setPositionX(640)
	var_8_2:setPositionX(640)
	var_8_3:setPositionX(-200)
	var_8_1:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(380, var_8_1:getPositionY()))))
	var_8_2:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(380, var_8_2:getPositionY()))))
	var_8_3:runAction(cc.Sequence:create(cc.MoveTo:create(0.3, cc.p(10, var_8_3:getPositionY()))))
end

function ActivityExploreLayer:initList()
	for iter_15_0, iter_15_1 in pairs(self.exploreConfig) do
		local var_15_0 = ccui.ImageView:create("explore/map_cover_bg.png", var_0_9)

		var_15_0:setOpacity(0)
		var_15_0:setName("coverBg")
		var_15_0:setAnchorPoint(cc.p(0.5, 0))

		local var_15_1 = activity_explore_data[iter_15_1.id].order

		var_15_0:setPosition(self.scrollView:getContentSize().width / 2, self.scrollView:getInnerContainerSize().height - (activity_explore_data[iter_15_1.id].order - 1) * 15 - activity_explore_data[iter_15_1.id].order * var_15_0:getContentSize().height)
		self.scrollView:addChild(var_15_0)

		local var_15_2

		if activity_explore_data[iter_15_1.id].cover then
			var_15_2 = "mainScenebg/explore/" .. activity_explore_data[iter_15_1.id].cover .. ".png" or "mainScenebg/explore/floor_cover7.png"
		end

		local var_15_3 = ccui.Button:create(var_15_2, nil, var_15_2)

		var_15_3:setName("coverBnt" .. iter_15_1.id)
		var_15_3:setAnchorPoint(cc.p(0, 0.5))
		var_15_3:setPosition(20, var_15_0:getContentSize().height / 2)
		var_15_0:addChild(var_15_3)

		local var_15_4 = ccui.ImageView:create("mainScenebg/explore/" .. (activity_explore_data[iter_15_1.id].name_img or "txt_0-1") .. ".png")

		var_15_4:setAnchorPoint(cc.p(1, 0))
		var_15_4:setPosition(var_15_3:getContentSize().width, 0)
		var_15_3:addChild(var_15_4)
		var_15_3:addTouchEventListener(function(arg_16_0, arg_16_1)
			if arg_16_1 ~= ccui.TouchEventType.ended then
				return
			end

			if activity_explore_data[iter_15_1.id].starttime and os.time(parse_time(activity_explore_data[iter_15_1.id].starttime)) > time_check_manager:getCurTime() then
				global_ShowBlockWords(L_ACTIVITY_EXPLORE_CLOSE)

				return
			end

			if activity_explore_data[iter_15_1.id].is_once and iter_15_1.finish_times > 0 then
				global_ShowBlockWords(L_ACTIVITY_EXPLORE_ONCE)

				return
			end

			if not var_15_3:isBright() then
				return
			end

			var_15_3:setBright(false)
			explore_manager:begin_explore({
				type = "activity",
				returnLayer = "ActivityExploreLayer",
				activity_explore_id = iter_15_1.id,
				activityid = self.activityid,
				cancelCallback = function(arg_17_0)
					var_15_3:setBright(true)

					if arg_17_0 == 2 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[2])
					elseif arg_17_0 == 3 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[3])
					elseif arg_17_0 == 4 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[4])
					elseif arg_17_0 == 5 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[5])
					elseif arg_17_0 == 6 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[6])
					elseif arg_17_0 == 7 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[7])
					elseif arg_17_0 == 8 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[8])
					elseif arg_17_0 == 0 then
						global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[0])
					end
				end
			})
		end)

		if (activity_explore_data[iter_15_1.id].is_once and iter_15_1.finish_times > 0 or nil) and false then
			var_15_3:setOpacity(255)
		else
			var_15_3:setOpacity(100)
		end

		if activity_explore_data[iter_15_1.id].starttime and os.time(parse_time(activity_explore_data[iter_15_1.id].starttime)) > os.time() then
			var_15_3:setOpacity(100)

			local var_15_6 = os.time(parse_time(activity_explore_data[iter_15_1.id].starttime)) - os.time()
			local var_15_8 = cc.Label:createWithTTF(string.format(L_ACTIVITY_EXPLORE_START, var_15_6 > 86400 and string.format(L_TIME_FORMAT_DAYNHOUR, math.floor(var_15_6 / 86400), math.floor(var_15_6 % 86400 / 3600)) or string.format(L_TIME_FORMAT[2], math.floor(var_15_6 / 3600), math.floor(var_15_6 % 3600 / 60))), FONT_NAME, 30)

			var_15_8:setPosition(var_15_3:getPositionX() + var_15_3:getContentSize().width / 2, var_15_3:getPositionY())
			var_15_8:enableOutline(cc.c4b(10, 10, 10, 255), 1)
			var_15_0:addChild(var_15_8)
		end

		local var_15_9 = ccui.ImageView:create(var_0_14[activity_explore_data[iter_15_1.id].ele or "water"], var_0_9)

		var_15_9:setName("eleImg")
		var_15_9:setScale9Enabled(true)
		var_15_9:setCapInsets(cc.rect(2, 2, 2, 2))
		var_15_9:setContentSize(cc.size(var_15_9:getContentSize().width, var_15_3:getContentSize().height))
		var_15_9:setAnchorPoint(cc.p(0, 0.5))
		var_15_9:setPosition(0, var_15_3:getContentSize().height / 2 + 3)
		var_15_3:addChild(var_15_9)

		if activity_explore_data[iter_15_1.id].needspower then
			local var_15_10 = ccui.ImageView:create("explore/cover_name_bg.png", var_0_9)

			var_15_10:setName("levelBg")
			var_15_10:setAnchorPoint(cc.p(0, 1))
			var_15_10:setPosition(12, var_15_0:getContentSize().height - var_15_10:getContentSize().height / 2 + 4)
			var_15_0:addChild(var_15_10)

			local var_15_11 = cc.Label:createWithTTF(L_FIGHT_CAPACITY_MSG.Recommend_Capacity .. global_trans_number(activity_explore_data[iter_15_1.id].needspower), FONT_NAME, 20)

			var_15_11:setName("leveLabel")
			var_15_11:setPosition(var_15_10:getContentSize().width / 2, var_15_10:getContentSize().height / 2)
			var_15_10:addChild(var_15_11)
		end

		local var_15_12 = ccui.ListView:create()

		var_15_12:setDirection(ccui.ListViewDirection.horizontal)
		var_15_12:setItemsMargin(0)
		var_15_12:setAnchorPoint(cc.p(0, 0))
		var_15_12:setPosition(370, 50)
		var_15_12:setContentSize(cc.size(260, 130))
		var_15_0:addChild(var_15_12)

		local var_15_13 = activity_explore_data[iter_15_1.id].dropid or "EX201MB5201"
		local var_15_14 = drop_manager:getEquipAllDrops(var_15_13)

		if var_15_14 then
			for iter_15_2, iter_15_3 in pairs(var_15_14) do
				if iter_15_2 <= 3 then
					local var_15_15 = ccui.ImageView:create("public/box/" .. item_data[iter_15_3.dropid].equip_quality .. ".png", var_0_9)

					var_15_15:setScale(0.9)

					local var_15_16

					if item_data[iter_15_3.dropid].bag_item_type == kITEM_COMPONENT then
						var_15_16 = require("controller.component_manager"):create_component_icon(item_data[iter_15_3.dropid].id)
					else
						assert(item_data[iter_15_3.dropid].image_id, item_data[iter_15_3.dropid].id)

						var_15_16 = ccui.ImageView:create("equipment/" .. item_data[iter_15_3.dropid].image_id .. ".png")
					end

					var_15_16:setPosition(var_15_15:getContentSize().width / 2, var_15_15:getContentSize().height / 2)
					var_15_16:setScale(80 / var_15_16:getContentSize().width)
					var_15_15:addChild(var_15_16)
					var_15_12:pushBackCustomItem(var_15_15)
				end
			end
		end

		local var_15_17 = ccui.Button:create("explore/more_drop.png", nil, "explore/more_drop.png", var_0_9)

		var_15_17:setAnchorPoint(cc.p(0, 0))
		var_15_17:setPosition(368, 28)
		var_15_0:addChild(var_15_17)
		var_15_17:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			LayerManager:pushInLayer("PopDropPreviewLayer", {
				dropid = var_15_13
			})
		end)

		local var_15_18 = ccui.ImageView:create("explore/list_cost_bg.png", var_0_9)

		var_15_18:setPosition(500, 193)
		var_15_0:addChild(var_15_18)

		local var_15_19 = cc.Label:createWithTTF("", FONT_NAME, 25)

		var_15_19:setAnchorPoint(cc.p(0.5, 0.5))
		var_15_19:setPosition(var_15_18:getContentSize().width / 2, var_15_18:getContentSize().height / 2)
		var_15_18:addChild(var_15_19)

		if activity_explore_data[iter_15_1.id].is_daily then
			var_15_19:setString(L_ACTIVITY_EXPLORE_COST.Times)

			local var_15_20 = cc.Label:createWithTTF("1", FONT_NAME, 25)

			var_15_19:setPositionX(var_15_19:getPositionX() - var_15_20:getContentSize().width)
			var_15_20:setColor(cc.c3b(0, 239, 248))
			var_15_20:setAnchorPoint(cc.p(0, 0.5))
			var_15_20:setPosition(var_15_19:getPositionX() + var_15_19:getContentSize().width / 2, var_15_19:getPositionY())
			var_15_18:addChild(var_15_20)
		elseif activity_explore_data[iter_15_1.id].need_item1 then
			var_15_19:setAnchorPoint(cc.p(0, 0.5))
			var_15_19:setPositionX(0)
			var_15_19:setString(L_ACTIVITY_EXPLORE_COST.Ticket)

			local var_15_21 = ccui.ImageView:create("equipment/" .. item_data[activity_explore_data[iter_15_1.id].need_item1].image_id .. ".png")

			var_15_21:setAnchorPoint(cc.p(0, 0.5))
			var_15_21:setPosition(var_15_19:getPositionX() + var_15_19:getContentSize().width, var_15_19:getPositionY())
			var_15_21:setScale(0.4)
			var_15_18:addChild(var_15_21)

			local var_15_22 = cc.Label:createWithTTF(item_manager:getItemNumber(activity_explore_data[iter_15_1.id].need_item1) .. "/" .. activity_explore_data[iter_15_1.id].need_num1, FONT_NAME, 25)

			var_15_22:setColor(cc.c3b(0, 239, 248))
			var_15_22:setAnchorPoint(cc.p(0, 0.5))
			var_15_22:setPosition(var_15_21:getPositionX() + var_15_21:getBoundingBox().width, var_15_21:getPositionY())
			var_15_18:addChild(var_15_22)
		elseif activity_explore_data[iter_15_1.id].is_once then
			var_15_19:setString(L_ACTIVITY_EXPLORE_COST.Is_Once)
		end

		local var_15_23 = ccui.Layout:create()

		var_15_23:setVisible(false)
		var_15_23:setPosition(0, var_15_0:getPositionY())
		var_15_23:setContentSize(var_15_0:getContentSize().width, var_15_0:getContentSize().height)
		var_15_23:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
		var_15_23:setBackGroundColor(cc.c3b(255, 255, 255))
		var_15_23:setBackGroundColorOpacity(204)
		self.scrollView:addChild(var_15_23)
		var_15_23:runAction(cc.Sequence:create(cc.DelayTime:create(var_15_1 * 0.15), cc.Show:create(), cc.FadeOut:create(0.2), cc.RemoveSelf:create()))
		var_15_0:runAction(cc.Sequence:create(cc.DelayTime:create(var_15_1 * 0.15), cc.FadeIn:create(0.2)))
	end
end

function ActivityExploreLayer.popMapDrop(arg_19_0, arg_19_1)
	local var_19_0 = ccui.Layout:create()

	var_19_0:setTouchEnabled(true)
	var_19_0:setContentSize(cc.size(640, GameDisplay.height))
	var_19_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_19_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_19_0:setBackGroundColorOpacity(200)
	var_19_0:setCascadeOpacityEnabled(false)
	global_basic_scene:addChild(var_19_0, 999)
	var_19_0:addTouchEventListener(function(arg_20_0, arg_20_1)
		if arg_20_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_19_0:runAction(cc.RemoveSelf:create())
	end)

	local var_19_1 = cc.SpriteBatchNode:create("tilemap/pop_bg_tile.png")

	var_19_0:addChild(var_19_1)

	local var_19_2 = 30

	for iter_19_0 = 1, 10 do
		for iter_19_1 = 1, 7 do
			local var_19_3 = cc.Sprite:create("tilemap/pop_bg_tile.png")

			var_19_3:setPosition(80 + (iter_19_1 - 1) * 80, 260 + (iter_19_0 - 1) * 80 - var_19_2)
			var_19_1:addChild(var_19_3)
		end
	end

	local var_19_4 = ccui.ImageView:create("explore/pop_up.png", var_0_9)

	var_19_4:setPosition(320, 1040 - var_19_2)
	var_19_4:setScaleX(560 / var_19_4:getContentSize().width)
	var_19_0:addChild(var_19_4)

	local var_19_5 = cc.Label:createWithTTF(L_DROP_LIST, FONT_TITLE, 30)

	var_19_5:setAnchorPoint(cc.p(0, 0.5))
	var_19_5:setPosition(10, 20)
	var_19_4:addChild(var_19_5)

	local var_19_6 = ccui.ImageView:create("explore/pop_down.png", var_0_9)

	var_19_6:setPosition(320, 218 - var_19_2)
	var_19_6:setScaleX(560 / var_19_6:getContentSize().width)
	var_19_0:addChild(var_19_6)

	local var_19_7 = drop_manager:getEquipAllDrops(arg_19_1)
	local var_19_8 = ccui.ScrollView:create()

	var_19_8:setBounceEnabled(true)

	local var_19_9 = math.ceil(#var_19_7 / 3) * 250 < 800 and 800 or math.ceil(#var_19_7 / 3) * 250

	var_19_8:setInnerContainerSize(cc.size(560, var_19_9))
	var_19_8:setDirection(ccui.ScrollViewDir.vertical)
	var_19_8:setContentSize(cc.size(560, 800))
	var_19_8:setAnchorPoint(cc.p(0.5, 0))
	var_19_8:setPosition(320, 220 - var_19_2)
	var_19_0:addChild(var_19_8)

	for iter_19_2, iter_19_3 in ipairs(var_19_7) do
		local var_19_10 = ItemSprite:createNewWithItemId(iter_19_3.dropid)

		var_19_10:setAnchorPoint(cc.p(0, 0))
		var_19_10:setPosition(4 + (iter_19_2 - 1) % 3 * 189, var_19_9 - (math.floor((iter_19_2 - 1) / 3) + 1) * 250)
		var_19_8:addChild(var_19_10)
		var_19_10:setTouchEnabled(true)
		var_19_10:addSpriteTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			if math.abs(arg_21_0:getLocation().y - arg_21_0:getStartLocation().y) > 50 then
				return
			end

			PopLayer:Item({
				hideGainButton = true,
				itemid = iter_19_3.dropid
			})
		end)
	end
end

function ActivityExploreLayer.buyDailyTimes(arg_22_0, arg_22_1)
	activity_manager:getActivityObj(4):activity_buy_explore_times(function(arg_23_0, arg_23_1)
		if arg_23_0 == 1 then
			arg_22_0.buy_times = arg_23_1

			arg_22_0.dailyTimeLabel:setString(arg_22_0.buy_times + var_0_11 - arg_22_0.total_daily_times)
			arg_22_0.addDailyTimeBnt:setVisible(false)
		end

		if arg_22_1 then
			arg_22_1()
		end
	end)
end
