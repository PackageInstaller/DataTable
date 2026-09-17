ActivityMainLayerBaseLayer = class("ActivityMainLayerBaseLayer", function()
	return cc.Layer:create()
end)

local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local test_fight_manager = require("controller.test_fight_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local var_0_11 = config._DEBUG and 0 or 1
local var_0_12
local var_0_13
local var_0_14 = {}
local var_0_15
local var_0_16 = {
	list = {}
}

function var_0_16.register(arg_2_0, arg_2_1)
	var_0_16.list[arg_2_0] = var_0_16.list[arg_2_0] or {}

	table.insert(var_0_16.list[arg_2_0], arg_2_1)
end

function var_0_16.dispath(arg_3_0, ...)
	if var_0_16.list[arg_3_0] and next(var_0_16.list[arg_3_0]) then
		for iter_3_0, iter_3_1 in pairs(var_0_16.list[arg_3_0]) do
			iter_3_1(...)
		end
	end
end

local var_0_17 = {
	["270051"] = true,
	palmpi = true,
	["270001"] = true,
	["270049"] = true,
	["270050"] = true
}
local var_0_18 = {
	btnDailyLevel = "daily_level",
	btnFlop = "flop",
	btnQuestion1 = "question1",
	btnRoulette = "roulette",
	btnExplore = "freeexplorer",
	btnSign = "sign",
	btnPt = "pt",
	btnQuestion2 = "question2",
	btnStory = "story",
	btnQuestion3 = "question3",
	btnQuestion4 = "question4",
	btnPassLevel = "pass_level",
	btnMultipt = "multi_pt",
	btnLevel1 = "daily_level"
}

function ActivityMainLayerBaseLayer.create(arg_4_0, ...)
	local var_4_0 = ActivityMainLayerBaseLayer.new(...)

	var_4_0:_init(...)

	return var_4_0
end

function ActivityMainLayerBaseLayer:_init(arg_5_1)
	assert(arg_5_1, "需要一个id来进行初始化")
	assert(arg_5_1.activityid, "需要一个id来进行初始化")

	var_0_13 = arg_5_1.activityid
	self.id = arg_5_1.activityid
	self._touchlock = false
	self._defaultTouchEventEnable = {}
	self._debugreddot = false
	self._path = string.format("activitiesRes/activity%d/main/", self.id)
	self._roleList, self._curRoleIdx = self:_get_role_list()

	self:registerActivityEventListener()
	self:registerShareDispath()
	self:registerScriptHandler(function(arg_6_0)
		if arg_6_0 == "exit" then
			RoleDefault:getInstance():setIntegerForKey("ACTMLayerIndex_" .. self.id, self._curRoleIdx)
			activity_manager:releaseEventListenerByName("ActivityMainLayerBaseLayer_" .. self.id)

			var_0_16.list = {}

			if self.showgirlLayer and next(self._roleList) and self.showgirlLayer:getChildByName("showgirlLayer") then
				self.showgirlLayer:getChildByName("showgirlLayer"):resetCurTalkConfig(self._roleList[self._curRoleIdx])
			end
		end
	end)

	var_0_15 = self

	AnalyticManager.ActivityMainLayer({
		event_name = "on_into_activitymainlayer",
		activityid = self.id
	})
	hx_print("UI文件夹:" .. self._path, CONSOLE_COLOR_LIGHT_GOLD)
end

function ActivityMainLayerBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener("ActivityMainLayerBaseLayer_" .. self.id, activity_manager.activityEventId.UPDATE_ACTIVITY_STATUS_ALERT, function(arg_8_0)
		if result == 1 and self.btnShare then
			self.btnShare:setVisible(true)
		end

		self:_updateBtnReddot()
	end)
	activity_manager:registerEventListener("ActivityMainLayerBaseLayer_" .. self.id, activity_manager.activityEventId.CHANGE_TEST_A_FIGHT_ARRAY_SUCCESS, function(arg_9_0)
		LayerManager:switchShowLayer("TestFightLayer")
	end)
end

function ActivityMainLayerBaseLayer:call_base_func(...)
	if self.btnExplore then
		activity_manager:get_activity_explore(self.id, function(arg_11_0)
			activity_manager:update_alert(self.id, "freeexplorer", arg_11_0)
		end)
	end

	self:_register_btn_default_touch_event()
	self:_set_label_str()
	self:_updateBtnReddot()
end

function ActivityMainLayerBaseLayer:_get_role_list()
	if not activity_main_conf[self.id] then
		return
	end

	local var_12_0 = {}

	while activity_main_conf[self.id]["showgirl_model_" .. 1] do
		table.insert(var_12_0, activity_main_conf[self.id]["showgirl_model_" .. 1])
	end

	local var_12_2 = RoleDefault:getInstance():getIntegerForKey("ACTMLayerIndex_" .. self.id, 0)

	if var_12_2 < 1 then
		var_12_2 = math.random(1, #var_12_0)
	else
		var_12_2 = var_12_2 + 1
		var_12_2 = var_12_2 <= #var_12_0 and var_12_2 or 1
	end

	return var_12_0, var_12_2
end

function ActivityMainLayerBaseLayer._create_showgirl_layer(arg_13_0)
	local var_13_0 = ccui.Layout:create()

	function var_13_0:update()
		assert(arg_13_0._roleList, "活动主界面配置表未配置showgirl_model_1")

		if not next(arg_13_0._roleList) then
			print("活动主界面配置表未配置showgirl_model_1")

			arg_13_0._roleList = {
				"202420"
			}
		end

		if not arg_13_0._roleList then
			return
		end

		if not next(arg_13_0._roleList) then
			return
		end

		local var_14_0 = arg_13_0._roleList[arg_13_0._curRoleIdx] or "109755"

		if not self:getChildByName("showgirlLayer") then
			local var_14_1 = ShowGirlLayer:create(var_14_0, 3)

			var_14_1:setName("showgirlLayer")
			var_14_1:resetCurTalkConfig(var_14_0)
			var_14_1:setTalkEnabled(true)
			var_14_1:setLive2DPlayStayEnabled(true)
			self:addChild(var_14_1, 2)
		end

		self:getChildByName("showgirlLayer"):update(var_14_0)

		local var_14_2 = 1

		if model_data[var_14_0].is_own_full_screen_background == 1 then
			var_14_2 = 2
		end

		if not model_data[var_14_0].backgroundid_main then
			-- block empty
		end

		local var_14_4

		if var_14_4 then
			if not self:getChildByName("backGroundLayer") then
				local var_14_5 = BackGroundLayer:create(var_14_4, var_14_2)

				var_14_5:setName("backGroundLayer")
				self:addChild(var_14_5, 1)
			end

			self:getChildByName("backGroundLayer"):update(var_14_4, var_14_2)
		end
	end

	var_13_0:update()

	return var_13_0
end

local function var_0_19()
	local item_manager = require("controller.item_manager")
	local var_41_1 = ccui.Layout:create()

	var_41_1:setTouchEnabled(true)
	var_41_1:setContentSize(cc.Director:getInstance():getVisibleSize())
	var_41_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_41_1:setPosition(cc.p(cc.Director:getInstance():getVisibleSize().width / 2, cc.Director:getInstance():getVisibleSize().height / 2 - GameDisplay.fix_y))
	var_41_1:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_41_1:setBackGroundColor(cc.c3b(0, 0, 0))
	var_41_1:setBackGroundColorOpacity(180)
	var_0_15:addChild(var_41_1, 10)
	var_41_1:addTouchEventListener(function(arg_42_0, arg_42_1)
		if arg_42_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_41_1:runAction(cc.RemoveSelf:create())
	end)

	local var_41_2 = ccui.ImageView:create("activitiesRes/activity464/main/head_bg.png")

	var_41_2:setPosition(cc.p(320, GameDisplay.height * 0.65 - GameDisplay.fix_y))
	var_41_2:setTouchEnabled(true)
	var_41_1:addChild(var_41_2, 9999)

	local var_41_3 = 108001059
	local var_41_4 = 70887031
	local var_41_5 = "activitiesRes/activity464/main/btn_get.png"

	if item_manager:haveItem(108001059) then
		var_41_5 = "activitiesRes/activity464/main/btn_got.png"
	end

	local var_41_6 = ccui.Button:create(var_41_5, nil, var_41_5)

	var_41_6:addTouchEventListener(function(arg_43_0, arg_43_1)
		if arg_43_1 ~= ccui.TouchEventType.ended then
			return
		end

		if item_manager:haveItem(var_41_3) then
			return
		end

		activity_manager:getTaskReward(708, var_41_4, function(arg_44_0, arg_44_1)
			if arg_44_0 == 1 then
				global_gain(arg_44_1)
				var_41_1:runAction(cc.RemoveSelf:create())
				activity_manager:updateActivityAlert("total_recharge", 708, false)
			else
				local var_44_0 = {}

				function var_44_0.surecallback()
					goto_complete_system({
						jump_to_system = 1770801
					})
				end

				var_44_0.labels = {
					button = L_GO_BUY_DIAMOND.button,
					des = L_FOOL_RECHARGE
				}

				LayerManager:pushInLayer("PopDoLayer", var_44_0)
			end
		end)
	end)
	var_41_6:setPosition(cc.p(230, 86))
	var_41_2:addChild(var_41_6, 999)
end

local var_0_22 = {
	sign = function(arg_15_0)
		if arg_15_0 == 286 then
			require("network.network"):rpc("get_activity_pop_drop_stat", {
				id = 206320
			}, function(arg_16_0)
				if arg_16_0.stat and arg_16_0.stat == 0 then
					LayerManager:pushInLayer("ActivityPopBaseLayer", {
						id = 206320
					})
				else
					goto_complete_system({
						jump_to_system = 2000000 + arg_15_0
					})
				end
			end)
		else
			goto_complete_system({
				jump_to_system = ((require("data.activity_modules.activity_sign_conf")[arg_15_0].signtype >= 4 or nil) and 4007000) + arg_15_0
			})
		end
	end,
	shop = function(arg_17_0)
		assert(activity_main_conf[arg_17_0], "activityMainConf 没填 " .. arg_17_0)

		local var_17_0 = {}
		local var_17_1 = activity_main_conf[arg_17_0].into_shop or activity_main_conf[arg_17_0].into_shop_1

		assert(var_17_1, "activityMainConf " .. arg_17_0 .. " 没填into_shop1")

		if string.find(var_17_1, ",") then
			for iter_17_0, iter_17_1 in pairs(split(var_17_1, ",")) do
				table.insert(var_17_0, "1-" .. tonumber(iter_17_1) % 1500000)
			end
		else
			var_17_0[1] = "1-" .. tonumber(var_17_1) % 1500000
		end

		local var_17_2 = var_17_0[1]

		var_0_12("shop", arg_17_0)
		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_17_0,
			showType = var_17_2
		})
	end,
	shop2 = function(arg_18_0)
		assert(activity_main_conf[arg_18_0], "activityMainConf 没填 " .. arg_18_0)

		local var_18_0 = {}

		assert(activity_main_conf[arg_18_0].into_shop_2, "activityMainConf " .. arg_18_0 .. " 没填into_shop")

		if string.find(activity_main_conf[arg_18_0].into_shop_2, ",") then
			for iter_18_0, iter_18_1 in pairs(split(activity_main_conf[arg_18_0].into_shop_2, ",")) do
				table.insert(var_18_0, "1-" .. tonumber(iter_18_1) % 1500000)
			end
		else
			var_18_0[1] = "1-" .. tonumber(activity_main_conf[arg_18_0].into_shop_2) % 1500000
		end

		local var_18_1 = var_18_0[1]

		var_0_12("shop", arg_18_0)
		LayerManager:switchShowLayer("MarketLayer", {
			singleMarket = var_18_0,
			showType = var_18_1
		})
	end,
	twist = function(arg_19_0)
		var_0_12("twist", arg_19_0)
		goto_complete_system({
			jump_to_system = (arg_19_0 == 430 and global_get_time_by_date("2023-01-24 00:00:00") < time_check_manager:getCurTime() or nil) and 1800453 or 180
		})
	end,
	twist2 = function(arg_20_0)
		local var_20_0 = activity_main_conf[arg_20_0] and activity_main_conf[arg_20_0].into_twist_2

		var_0_12("twist", arg_20_0)
		goto_complete_system({
			jump_to_system = var_20_0 or 180
		})
	end,
	roulette = function(arg_21_0)
		Global_save_day_end_time("activity_reddot_roulette_" .. arg_21_0)
		LayerManager:switchShowLayer("ActivityRouletteBaseLayer", {
			activityId = arg_21_0
		})
	end,
	bp = function(arg_22_0)
		LayerManager:switchShowLayer("ActivityGeneralBPLayer", {
			activityId = arg_22_0
		})
	end,
	adventure = function(arg_23_0)
		LayerManager:switchShowLayer("AdventurerVisualLayer", {
			activityId = arg_23_0,
			returnbacklayer = "ActivityMainLayer_" .. arg_23_0
		})
	end,
	share = function(arg_24_0, arg_24_1)
		LayerManager:pushInLayer("PopActivityShareLayer", {
			activityid = arg_24_0
		})

		local var_24_0 = os.date("*t", (time_check_manager:getCurTime()))
		local var_24_1 = RoleDefault:getInstance():setIntegerForKey("shareReddotTime", (os.time({
			hour = 23,
			min = 59,
			sec = 59,
			year = var_24_0.year,
			month = var_24_0.month,
			day = var_24_0.day
		})))

		activity_manager:fireEvent(activity_manager.activityEventId.BTN_SHARE_SHOW_UPDATE)
	end,
	pt = function(arg_25_0)
		goto_complete_system({
			jump_to_system = 2400000 + arg_25_0
		})
	end,
	level = function(arg_26_0)
		LayerManager:switchShowLayer("ActivityLevelBaseLayer", {
			activityid = arg_26_0
		})
	end,
	dailyLevel = function(arg_27_0)
		Global_save_day_end_time("activity_reddot_daily_level_" .. arg_27_0)
		LayerManager:switchShowLayer("ActivityDailyLevelLayer", {
			activityid = arg_27_0
		})
	end,
	explore = function(arg_28_0)
		ErrorCodeManager:check({
			systemname = "ActivityExploreLayer",
			id = arg_28_0
		})

		if activity_manager:isHasExploreMapLayer(arg_28_0) then
			if require("controller.layerconfig.pop_layer_infos")["ActivityExploreLayer_" .. arg_28_0] then
				LayerManager:switchShowLayer("ActivityExploreLayer_" .. arg_28_0, {
					activityid = arg_28_0
				})
			else
				LayerManager:switchShowLayer("ActivityExploreDefaultLayer", {
					activityid = arg_28_0
				})
			end
		else
			activity_manager:get_activity_explore(arg_28_0, function(arg_29_0)
				if arg_29_0.result == 1 then
					explore_manager:begin_explore({
						type = "activity",
						activityid = arg_28_0,
						returnLayer = "ActivityMainLayer_" .. arg_28_0,
						cancelCallback = function(arg_30_0)
							if arg_30_0 == 2 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[2])
							elseif arg_30_0 == 3 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[3])
							elseif arg_30_0 == 4 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[4])
							elseif arg_30_0 == 5 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[5])
							elseif arg_30_0 == 0 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[6])
							elseif arg_30_0 then
								global_ShowBlockWords(L_EXPLORE_ERROR_NEW[arg_30_0])
							end
						end,
						activity_explore_id = activity_manager:getCurExploreId(arg_28_0)
					})
				end
			end)
		end
	end,
	art = function(arg_31_0)
		LayerManager:switchShowLayer("ActivityArtBaseLayer", {
			activityid = arg_31_0
		})
	end,
	vote = function(arg_32_0)
		print(debug.traceback())
		print("活动应援这里写")
	end,
	infinite = function(arg_33_0)
		LayerManager:switchShowLayer("AdventurerInfiniteLayer")
	end,
	flop = function(arg_34_0)
		if arg_34_0 >= 457 and arg_34_0 ~= 458 then
			LayerManager:switchShowLayer("ActivityFlipBaseLayer", {
				activityId = arg_34_0
			})

			return
		end

		if not require("controller.layerconfig.ui_layer_infos")["ActivityFlopLayer_" .. arg_34_0] then
			LayerManager:switchShowLayer("ActivityFlopDefaultLayer", {
				activityid = arg_34_0
			})
		else
			LayerManager:switchShowLayer("ActivityFlopLayer_" .. arg_34_0, {
				activityid = arg_34_0
			})
		end
	end,
	collect = function(arg_35_0)
		LayerManager:switchShowLayer("ActivityWordCollectionBaseLayer", {
			activityId = arg_35_0
		})
	end,
	detail = function(arg_36_0)
		if arg_36_0 == 176 then
			return
		end

		var_0_12("detail", arg_36_0)
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityMain_" .. arg_36_0
		})
	end,
	btnreturn = function(arg_37_0)
		KeyCodeManager:onKeyReleasedCallFunc()
	end,
	randfight = function(arg_38_0)
		local var_38_0 = ACTIVITY_ID_TO_MODETYPE_FUNC.boss_fight(arg_38_0)

		if arg_38_0 < 500 then
			LayerManager:switchShowLayer("AdventurerRandomLayer", {
				modetype = (arg_38_0 == 173 or nil) and 2010
			})
		elseif arg_38_0 == 576 then
			LayerManager:switchShowLayer("ActivityNewBossFightBaseLayer", {
				activityId = arg_38_0
			})
		else
			LayerManager:switchShowLayer("ActivityBossFightBaseLayer", {
				activityId = arg_38_0
			})
		end

		RoleDefault:getInstance():setBoolForKey("act_alert_randfight_" .. arg_38_0, false)
	end,
	role = function(arg_39_0, arg_39_1, arg_39_2)
		arg_39_1:runAction(cc.Sequence:create(cc.MoveBy:create(0.06, cc.p(0, 6)), cc.MoveBy:create(0.06 * 2, cc.p(0, -6 * 2)), cc.MoveBy:create(0, cc.p(0, 6))))
	end,
	passlevel = function(arg_40_0)
		LayerManager:pushInLayer("ActivityPassLevelTaskTemplateLayer", {
			activityid = arg_40_0
		})
	end,
	totaltask = function(arg_46_0)
		if arg_46_0 == 708 then
			var_0_19()

			return
		end

		LayerManager:pushInLayer("ActivityRechargeTemplate", {
			activityID = arg_46_0
		})
	end,
	recharge = function(arg_47_0)
		local var_47_0 = {}

		var_47_0.jump_to_system = activity_main_conf[arg_47_0].into_recharge or activity_main_conf[arg_47_0].into_recharge_1

		goto_complete_system(var_47_0)
	end,
	recharge2 = function(arg_48_0)
		local var_48_0 = {}

		var_48_0.jump_to_system = activity_main_conf[arg_48_0].into_recharge or activity_main_conf[arg_48_0].into_recharge_2

		goto_complete_system(var_48_0)
	end,
	showlist = function(arg_49_0)
		LayerManager:pushInLayer("PopActivityDropInfoLayer", {
			activityId = arg_49_0
		})
	end,
	getrole = function(arg_50_0)
		assert(activity_main_conf[arg_50_0].get_role, string.format("活动主界面表%s没有填get_role", arg_50_0))
		goto_complete_system({
			jump_to_system = activity_main_conf[arg_50_0].get_role
		})
	end,
	warlevel = function(arg_51_0)
		print(arg_51_0)

		if arg_51_0 == 453 then
			LayerManager:switchShowLayer("LimitTowerDefenceLevelLayer", {
				activityid = 453
			})

			return
		end

		LayerManager:switchShowLayer("TowerDefenceLevelLayer", {
			activityid = 1021
		})
		AnalyticManager.towerDefenceEntrnace({
			entranceid = 2
		})
		RoleDefault:getInstance():setIntegerForKey("act_alert_war_" .. arg_51_0, os.date("*t", (time_check_manager:getCurTime())).day)
	end,
	question = function(arg_52_0, arg_52_1)
		LayerManager:pushInLayer("PopAnswerQuestionLayer", {
			activityid = arg_52_0,
			arrayid = arg_52_1.arrayid
		})
	end,
	leftrole = function(arg_53_0, arg_53_1, arg_53_2)
		assert(next(arg_53_2._roleList), "活动主界面配置表未配置showgirl_model_1")

		arg_53_2._curRoleIdx = arg_53_2._curRoleIdx - 1

		if arg_53_2._curRoleIdx == 0 then
			arg_53_2._curRoleIdx = #arg_53_2._roleList
		end

		arg_53_2._curRoleIdx = (arg_53_2._curRoleIdx - 1) % #arg_53_2._roleList + 1

		assert(arg_53_2.showgirlLayer, "未配置showgirlLayer")

		if arg_53_2.showgirlLayer then
			arg_53_2.showgirlLayer:update()
		end
	end,
	rightrole = function(arg_54_0, arg_54_1, arg_54_2)
		assert(next(arg_54_2._roleList), "活动主界面配置表未配置showgirl_model_1")

		arg_54_2._curRoleIdx = arg_54_2._curRoleIdx + 1
		arg_54_2._curRoleIdx = (arg_54_2._curRoleIdx - 1) % #arg_54_2._roleList + 1

		assert(arg_54_2.showgirlLayer, "未配置showgirlLayer")

		if arg_54_2.showgirlLayer then
			arg_54_2.showgirlLayer:update()
		end
	end,
	roleinfo = function(arg_55_0)
		return
	end,
	falselevelinfo = function(arg_56_0, arg_56_1, arg_56_2)
		var_0_12("falselevelinfo", arg_56_0)
		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityMain_RoleFalseLevel_" .. arg_56_0
		})
		RoleDefault:getInstance():setIntegerForKey("activity_reddot_false_level_" .. arg_56_0, 1)
		arg_56_2:_updateBtnReddot()
	end,
	seemore = function(arg_57_0, arg_57_1, arg_57_2)
		arg_57_2:showSeeMoreLayer()
	end,
	story = function(arg_60_0, arg_60_1, arg_60_2)
		if arg_60_0 == 465 then
			global_basic_scene:addChild(TalkLayer:create(202210, nil, 1, "", nil))

			return
		end

		LayerManager:switchShowLayer("ActivityStoryLayer_" .. arg_60_0)
	end,
	monopoly = function(arg_61_0, arg_61_1, arg_61_2)
		LayerManager:switchShowLayer("MonopolyNewLayer", {
			activityid = arg_61_0
		})
	end,
	multipt = function(arg_62_0, arg_62_1, arg_62_2)
		LayerManager:switchShowLayer("ActivityMultiPtLayer", {
			activityId = arg_62_0
		})
	end,
	explore_offer = function(arg_63_0, arg_63_1, arg_63_2)
		LayerManager:switchShowLayer("ExploreOfferLayer", {
			init_class = "special"
		})
	end,
	testFight = function(arg_64_0)
		test_fight_manager:changeTestFightArray(pvpArray, {
			{
				servantid = activity_main_conf[arg_64_0].servant,
				modelid = servant_data[activity_main_conf[arg_64_0].servant].modelid
			},
			{},
			{},
			{},
			{}
		})
	end,
	skinGet = function(arg_65_0)
		if require("controller.layerconfig.pop_layer_infos")["PopSkinGetLayer_" .. arg_65_0] then
			LayerManager:pushInLayer("PopSkinGetLayer_" .. arg_65_0)
		else
			LayerManager:pushInLayer("PopSkinAccessLayer", {
				activityId = arg_65_0
			})
		end
	end,
	fightCollection = function(arg_66_0)
		LayerManager:switchShowLayer("ActivityFightCollectionLayer", {
			activityId = arg_66_0
		})
	end,
	jump = function(arg_67_0)
		goto_complete_system({
			jump_to_system = activity_main_conf[arg_67_0].jump_1
		})
	end,
	autochess = function(arg_68_0)
		if arg_68_0 == 333 then
			LayerManager:switchShowLayer("AutoChessBaseLayer", {
				activityId = 323
			})

			return
		end

		LayerManager:switchShowLayer("AutoChessBaseLayer", {
			activityId = arg_68_0
		})
	end,
	btnUdefense = function(arg_69_0)
		LayerManager:switchShowLayer("UrbanDefenseLayer", {
			activityId = arg_69_0
		})
	end,
	jumpTower = function(arg_70_0)
		LayerManager:switchShowLayer("ActivityJumptowerBaseLayer", {
			activityId = arg_70_0
		})
	end,
	swim = function(arg_71_0)
		LayerManager:switchShowLayer("SwimMainLayer", {
			activityId = arg_71_0
		})
	end,
	bachelor = function(arg_72_0)
		LayerManager:switchShowLayer("ActivityBachelorBaseLayer", {
			activityId = arg_72_0
		})
	end,
	dailyRecharge = function(arg_73_0)
		LayerManager:pushInLayer("PopDailyRechargeLayer", {
			activityId = arg_73_0
		})
	end,
	groupFight = function(arg_74_0)
		LayerManager:switchShowLayer("ActivityGroupFightLayer", {
			activityId = arg_74_0
		})
	end,
	airPlane = function()
		LayerManager:switchShowLayer("AirPlaneLayer")
	end,
	flyChess = function(arg_76_0)
		LayerManager:switchShowLayer("flyChessMainLayer", {
			activityId = arg_76_0
		})
	end
}

setmetatable(var_0_22, {
	__index = function(arg_77_0, arg_77_1)
		return function()
			print(arg_77_1 .. "未注册预定义点击事件")
		end
	end
})

local var_0_23 = {
	imgTime = true,
	textFinishtime = true
}
local var_0_24 = {
	btnSign = {
		event_key = "on_touch_sign",
		iseffect = false,
		handler = var_0_22.sign
	},
	btnShop = {
		event_key = "on_touch_shop",
		iseffect = true,
		handler = var_0_22.shop
	},
	btnShop2 = {
		event_key = "on_touch_shop2",
		iseffect = true,
		handler = var_0_22.shop2
	},
	btnTwist = {
		event_key = "on_touch_twist",
		iseffect = true,
		handler = var_0_22.twist
	},
	btnTwist2 = {
		event_key = "on_touch_twist_2",
		iseffect = true,
		handler = var_0_22.twist2
	},
	btnRoulette = {
		event_key = "on_touch_roulette",
		iseffect = true,
		handler = var_0_22.roulette
	},
	btnBp = {
		event_key = "on_touch_bp",
		iseffect = true,
		handler = var_0_22.bp
	},
	btnAdventure = {
		event_key = "on_touch_adventure",
		iseffect = true,
		handler = var_0_22.adventure
	},
	btnShare = {
		event_key = "on_touch_share",
		iseffect = false,
		handler = var_0_22.share
	},
	btnPt = {
		event_key = "on_touch_pt",
		iseffect = true,
		handler = var_0_22.pt
	},
	btnLevel = {
		event_key = "on_touch_level",
		iseffect = true,
		handler = var_0_22.level
	},
	btnLevel1 = {
		event_key = "on_touch_level",
		iseffect = true,
		handler = var_0_22.level
	},
	btnDailyLevel = {
		event_key = "on_touch_dailylevel",
		iseffect = true,
		handler = var_0_22.dailyLevel
	},
	btnExplore = {
		event_key = "on_touch_explore",
		iseffect = activity_manager:isHasExploreMapLayer(),
		handler = var_0_22.explore
	},
	btnArt = {
		event_key = "on_touch_art",
		iseffect = true,
		handler = var_0_22.art
	},
	btnVote = {
		event_key = "on_touch_vote",
		iseffect = true,
		handler = var_0_22.vote
	},
	btnInfinite = {
		event_key = "on_touch_infinite",
		iseffect = true,
		handler = var_0_22.infinite
	},
	btnFlop = {
		event_key = "on_touch_flop",
		iseffect = true,
		handler = var_0_22.flop
	},
	btnCollect = {
		event_key = "on_touch_collect",
		iseffect = true,
		handler = var_0_22.collect
	},
	btnDetail = {
		event_key = "on_touch_detail",
		iseffect = false,
		handler = var_0_22.detail
	},
	btnReturn = {
		event_key = "on_touch_return",
		iseffect = true,
		handler = var_0_22.btnreturn
	},
	btnRandfight = {
		event_key = "on_touch_randfight",
		iseffect = true,
		handler = var_0_22.randfight
	},
	btnRole = {
		event_key = "on_touch_role",
		iseffect = false,
		handler = var_0_22.role
	},
	btnPassLevel = {
		event_key = "on_touch_passlevel",
		iseffect = false,
		handler = var_0_22.passlevel
	},
	btnTotalTask = {
		event_key = "on_touch_totaltask",
		iseffect = false,
		handler = var_0_22.totaltask
	},
	btnRecharge = {
		event_key = "on_touch_recharge",
		iseffect = false,
		handler = var_0_22.recharge
	},
	btnRecharge2 = {
		event_key = "on_touch_recharge2",
		iseffect = false,
		handler = var_0_22.recharge2
	},
	btnShowlist = {
		event_key = "on_touch_showlist",
		iseffect = false,
		handler = var_0_22.showlist
	},
	btnGetRole = {
		event_key = "on_touch_getrole",
		iseffect = false,
		handler = var_0_22.getrole
	},
	btnWar = {
		event_key = "on_touch_war",
		iseffect = false,
		handler = var_0_22.warlevel
	},
	btnQuestion1 = {
		event_key = "on_touch_question",
		iseffect = false,
		handler = var_0_22.question
	},
	btnQuestion2 = {
		event_key = "on_touch_question",
		iseffect = false,
		handler = var_0_22.question
	},
	btnQuestion3 = {
		event_key = "on_touch_question",
		iseffect = false,
		handler = var_0_22.question
	},
	btnQuestion4 = {
		event_key = "on_touch_question",
		iseffect = false,
		handler = var_0_22.question
	},
	btnLeftRole = {
		event_key = "on_touch_leftrole",
		iseffect = true,
		handler = var_0_22.leftrole
	},
	btnRightRole = {
		event_key = "on_touch_rightrole",
		iseffect = true,
		handler = var_0_22.rightrole
	},
	btnRoleinfo = {
		event_key = "on_touch_roleinfo",
		iseffect = false,
		handler = var_0_22.roleinfo
	},
	btnFalseLevelInfo = {
		event_key = "on_touch_falselevelinfo",
		iseffect = false,
		handler = var_0_22.falselevelinfo
	},
	btnSeeMore = {
		event_key = "on_touch_seemore",
		iseffect = false,
		handler = var_0_22.seemore
	},
	btnStory = {
		event_key = "on_touch_story",
		iseffect = false,
		handler = var_0_22.story
	},
	btnMonopoly = {
		event_key = "on_touch_monopoly",
		iseffect = false,
		handler = var_0_22.monopoly
	},
	btnMultipt = {
		event_key = "on_touch_multipt",
		iseffect = true,
		handler = var_0_22.multipt
	},
	btnClothes = {
		event_key = "on_touch_clothes",
		iseffect = true,
		handler = var_0_22.clothes
	},
	btnExploreOffer = {
		event_key = "on_touch_exploreoffer",
		iseffect = true,
		handler = var_0_22.explore_offer
	},
	btnEmptyRoulette = {
		event_key = "on_touch_emptyroulette",
		iseffect = true,
		handler = var_0_22.EmptyRoulette
	},
	btnTestFight = {
		event_key = "on_touch_testFight",
		iseffect = true,
		handler = var_0_22.testFight
	},
	btnSkinGet = {
		event_key = "on_touch_skinGet",
		iseffect = false,
		handler = var_0_22.skinGet
	},
	btnFightCollection = {
		event_key = "on_touch_fightCollection",
		iseffect = true,
		handler = var_0_22.fightCollection
	},
	btnJump = {
		event_key = "on_touch_jump",
		iseffect = false,
		handler = var_0_22.jump
	},
	btnAutoChess = {
		event_key = "on_touch_jump",
		iseffect = true,
		handler = var_0_22.autochess
	},
	btnUdefense = {
		event_key = "on_touch_udefense",
		iseffect = true,
		handler = var_0_22.btnUdefense
	},
	btnJumpTower = {
		event_key = "on_touch_jumpTower",
		iseffect = true,
		handler = var_0_22.jumpTower
	},
	btnSwim = {
		event_key = "on_touch_swim",
		iseffect = true,
		handler = var_0_22.swim
	},
	btnBachelor = {
		event_key = "on_touch_swim",
		iseffect = true,
		handler = var_0_22.bachelor
	},
	btnDailyRecharge = {
		event_key = "on_touch_dailyRecharge",
		iseffect = false,
		handler = var_0_22.dailyRecharge
	},
	btnGroupFight = {
		event_key = "on_touch_groupFight",
		iseffect = true,
		handler = var_0_22.groupFight
	},
	btnAirPlane = {
		event_key = "on_touch_airPlane",
		iseffect = true,
		handler = var_0_22.airPlane
	},
	btnFlyChess = {
		event_key = "on_touch_flyChess",
		iseffect = true,
		handler = var_0_22.flyChess
	}
}

function ActivityMainLayerBaseLayer.get_touchevent_handler(arg_79_0, ...)
	return
end

function ActivityMainLayerBaseLayer:is_open_entrance(arg_80_1, arg_80_2)
	local var_80_0 = arg_80_2 or var_0_18[arg_80_1]

	if not (arg_80_2 or var_0_18[arg_80_1]) then
		return true
	end

	local var_80_1 = activity_manager:get_module_starttime(self.id, var_80_0)
	local var_80_2 = activity_manager:get_module_finishtime(self.id, var_80_0)

	if var_80_1 and time_check_manager:getCurTime() < os.time(parse_time(var_80_1)) then
		global_ShowBlockWords(L_LAMIYA_CHAPTER.activity_no_open)

		return false
	end

	if var_80_2 and os.time(parse_time(var_80_2)) < time_check_manager:getCurTime() then
		global_ShowBlockWords(L_LAMIYA_CHAPTER.activity_end)

		return false
	end

	return true
end

function ActivityMainLayerBaseLayer:_register_btn_default_touch_event()
	local function var_81_0(arg_82_0)
		if arg_82_0 ~= nil and arg_82_0.open_reddot == "once" then
			if RoleDefault:getInstance():getIntegerForKey(var_0_13 .. arg_82_0:getName() .. "reddot", 0) ~= 1 then
				return
			end
		end

		local var_82_0 = arg_82_0:getName()

		RoleDefault:getInstance():setIntegerForKey(var_0_13 .. var_82_0 .. "reddot", 2)
		global_remove_alert_tag(arg_82_0)
		activity_manager:updateActivityAlert(var_82_0, var_0_13, false)
	end

	for iter_81_0, iter_81_1 in pairs(var_0_24) do
		local var_81_1 = self[iter_81_0]

		if self[iter_81_0] and (self._defaultTouchEventEnable[iter_81_0] == nil or self._defaultTouchEventEnable[iter_81_0] or true) then
			self[iter_81_0].id = self.id

			self[iter_81_0]:addTouchEventListener(function(arg_83_0, arg_83_1)
				if config._DEBUG and ActivityUIConfigMode then
					self:UINodeConfigHandle(arg_83_0, arg_83_1)

					return
				end

				if arg_83_1 ~= ccui.TouchEventType.ended then
					return
				end

				if not self:is_open_entrance(iter_81_0, var_81_1.activitymodule) then
					return
				end

				if self._touchlock then
					return
				end

				if arg_83_0.locktime and time_check_manager:getCurTime() < os.time(parse_time(arg_83_0.locktime)) then
					global_ShowBlockWords(arg_83_0.locktime .. "解锁")

					return
				end

				if arg_83_0.iseffect or iter_81_1.iseffect then
					self:playOutEffect(function(...)
						iter_81_1.handler(self.id, arg_83_0, self)
						var_0_16.dispath(iter_81_0, self, arg_83_0)
						var_81_0(arg_83_0)

						if iter_81_1.event_key then
							AnalyticManager.ActivityMainLayer({
								activityid = self.id,
								event_name = iter_81_1.event_key
							})
						end
					end)
				else
					iter_81_1.handler(self.id, arg_83_0, self)
					var_0_16.dispath(iter_81_0, self, arg_83_0)
					var_81_0(arg_83_0)

					if iter_81_1.event_key then
						AnalyticManager.ActivityMainLayer({
							activityid = self.id,
							event_name = iter_81_1.event_key
						})
					end
				end
			end)
		end
	end
end

function ActivityMainLayerBaseLayer:setDefaultEnable(arg_85_1, arg_85_2)
	self._defaultTouchEventEnable[arg_85_1] = arg_85_2
end

function ActivityMainLayerBaseLayer:playOutEffect(arg_86_1)
	local var_86_0 = cc.Node:create()

	self:addChild(var_86_0)
	var_86_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		if arg_86_1 then
			arg_86_1()
		end
	end)))

	local var_86_1 = {}

	table.merge(var_86_1, var_0_24)
	table.merge(var_86_1, var_0_23)

	for iter_86_0, iter_86_1 in pairs(var_86_1) do
		if self[iter_86_0] then
			self[iter_86_0]:runAction(cc.FadeOut:create(0.2))
		end
	end
end

function ActivityMainLayerBaseLayer:playInEffect()
	self._touchlock = true

	local var_88_0 = cc.Node:create()

	self:addChild(var_88_0)
	var_88_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.4), cc.CallFunc:create(function()
		self._touchlock = false
	end)))

	local var_88_1 = {}

	table.merge(var_88_1, var_0_24)
	table.merge(var_88_1, var_0_23)

	for iter_88_0, iter_88_1 in pairs(var_88_1) do
		if self[iter_88_0] then
			self[iter_88_0]:setOpacity(0.4)
			self[iter_88_0]:runAction(cc.FadeIn:create(0.4))
		end
	end

	if self.id == 442 then
		local var_88_2 = L2Skeleton:create("spine/activity/" .. self.id .. "/tail/skeleton.json", "spine/activity/" .. self.id .. "/tail/skeleton.atlas")

		var_88_2:refreshSkeleton()
		var_88_2:play("animation", true)
		var_88_2:setLocalZOrder(3)
		self.rootLayer:addChild(var_88_2)
		var_88_2:setPosition(cc.p(290, 580))

		local var_88_3 = L2Skeleton:create("spine/activity/" .. self.id .. "/bg/skeleton.json", "spine/activity/" .. self.id .. "/bg/skeleton.atlas")

		var_88_3:refreshSkeleton()
		var_88_3:play("animation", true)
		var_88_3:setLocalZOrder(1)
		self.rootLayer:addChild(var_88_3)
		var_88_3:setPosition(cc.p(320, 640))

		if not var_0_14[self.id] then
			var_0_14[self.id] = 1

			local var_88_4 = L2Skeleton:create("spine/activity/" .. self.id .. "/loading/skeleton.json", "spine/activity/" .. self.id .. "/loading/skeleton.atlas")

			var_88_4:refreshSkeleton()
			var_88_4:play("animation", false)
			var_88_4:setLocalZOrder(999)
			self.rootLayer:addChild(var_88_4)
			var_88_4:setPosition(cc.p(320, GameDisplay.getUiScreenSize().height / 2 - 70))
		end
	end
end

local function var_0_25(arg_90_0, arg_90_1)
	return activity_manager:getAlertStatus(arg_90_0, arg_90_1)
end

local function var_0_32(arg_105_0, arg_105_1, arg_105_2)
	local var_105_0 = ""

	if arg_105_1 == "daily_level" then
		var_105_0 = "btnLevel1"
	elseif arg_105_1 == "question1" then
		var_105_0 = "btnQuestion1"
	elseif arg_105_1 == "question2" then
		var_105_0 = "btnQuestion2"
	elseif arg_105_1 == "question3" then
		var_105_0 = "btnQuestion3"
	elseif arg_105_1 == "question4" then
		var_105_0 = "btnQuestion4"
	end

	return RoleDefault:getInstance():getIntegerForKey(var_0_13 .. var_105_0 .. "reddot", 0) == 1 and os.time(parse_time(arg_105_2[var_105_0].locktime)) <= time_check_manager:getCurTime()
end

local function var_0_33(arg_106_0)
	if require("data.levelmode_data")[ACTIVITY_ID_TO_MODETYPE_FUNC.daily_level(arg_106_0)] then
		return self.btnDailyLevel == nil
	else
		return false
	end
end

local var_0_34 = {
	btnSign = {
		func = var_0_25
	},
	btnRoulette = {
		func = function(arg_100_0)
			return RoleDefault:getInstance():getIntegerForKey("activity_reddot_roulette_" .. arg_100_0, 0) < time_check_manager:getCurTime()
		end
	},
	btnBp = {
		func = function(arg_99_0)
			return var_0_25(arg_99_0, "bp") or var_0_25(arg_99_0, "bp_proceed")
		end
	},
	btnShare = {
		func = function(...)
			local var_92_0 = RoleDefault:getInstance():getIntegerForKey("shareReddotTime", 0)

			if var_92_0 and time_check_manager:getCurTime() < var_92_0 then
				return
			end

			return true
		end
	},
	btnPt = {
		func = function(arg_93_0)
			return var_0_25(arg_93_0, "pt") or var_0_25(arg_93_0, "pt_proceed")
		end
	},
	btnArt = {
		func = function(arg_95_0)
			return activity_manager:isArtNeedAlert(arg_95_0) or activity_manager:getAlertStatus(arg_95_0, "art")
		end
	},
	btnFlop = {
		func = var_0_25
	},
	btnPassLevel = {
		func = var_0_25
	},
	btnExplore = {
		func = var_0_25
	},
	btnTotalTask = {
		func = function(arg_101_0)
			if arg_101_0 == 464 then
				return false
			end

			if activity_task_conf[arg_101_0] then
				while activity_task_conf[arg_101_0]["module" .. 1] do
					local var_101_0 = not (activity_task_conf[arg_101_0]["starttime" .. 1] and time_check_manager:getCurTime() < os.time(parse_time(activity_task_conf[arg_101_0]["starttime" .. 1])))

					if (activity_task_conf[arg_101_0]["finishtime" .. 1] and os.time(parse_time(activity_task_conf[arg_101_0]["finishtime" .. 1])) < time_check_manager:getCurTime() or nil) and false and var_0_25(arg_101_0, activity_task_conf[arg_101_0]["module" .. 1]) then
						return true
					end
				end
			end
		end
	},
	btnStory = {
		func = var_0_25
	},
	btnLevel = {
		func = var_0_25
	},
	btnRandfight = {
		func = function(arg_103_0)
			return RoleDefault:getInstance():getBoolForKey("act_alert_randfight_" .. arg_103_0, true)
		end
	},
	btnWar = {
		func = function(arg_104_0)
			return RoleDefault:getInstance():getIntegerForKey("act_alert_war_" .. arg_104_0, 0) ~= os.date("*t", (time_check_manager:getCurTime())).day
		end
	},
	btnMultipt = {
		func = function(arg_109_0)
			return var_0_25(arg_109_0, "multi_proceed") or var_0_25(arg_109_0, "multi_pt")
		end
	},
	btnLevel1 = {
		func = var_0_32
	},
	btnQuestion1 = {
		func = var_0_32
	},
	btnQuestion2 = {
		func = var_0_32
	},
	btnQuestion3 = {
		func = var_0_32
	},
	btnQuestion4 = {
		func = var_0_32
	},
	btnFightCollection = {
		func = function(arg_107_0)
			return var_0_25(arg_107_0, "freeexplorer") or var_0_33(arg_107_0) and RoleDefault:getInstance():getIntegerForKey("activity_reddot_daily_level_" .. arg_107_0, 0) < time_check_manager:getCurTime()
		end
	},
	btnMonopoly = {
		func = function(arg_108_0)
			return (RoleDefault:getInstance():getBoolForKey("monopoly_red_status_" .. arg_108_0, true))
		end
	}
}

setmetatable(var_0_34, {
	__index = function(arg_110_0, arg_110_1)
		return {
			func = function()
				if config._DEBUG then
					print(arg_110_1 .. "未注册红点刷新函数")
				end
			end
		}
	end
})

function ActivityMainLayerBaseLayer:_is_show_reddot(arg_112_1, arg_112_2)
	if self._debugreddot then
		return true
	end

	local var_112_0 = var_0_34[arg_112_1].func(self.id, arg_112_2 or var_0_18[arg_112_1], self)

	if config.packagechannel == "palmpi" then
		hx_print(arg_112_1 .. "  红点状态  " .. (var_112_0 and "存在" or "无"), CONSOLE_COLOR_YELLO)
	end

	return var_112_0
end

function ActivityMainLayerBaseLayer:_updateBtnReddot(...)
	for iter_113_0, iter_113_1 in pairs(var_0_24) do
		if self[iter_113_0] then
			if self[iter_113_0]:getChildByName("reddot") then
				self[iter_113_0]:getChildByName("reddot"):setVisible(false)
			end

			if not self[iter_113_0]:getChildByName("reddot") then
				local var_113_1 = ccui.ImageView:create(self[iter_113_0].reddotpath or "public/reddot/reddot2.png", var_0_11)

				var_113_1:setPosition(self[iter_113_0].reddotpos or cc.p(var_113_1:getContentSize().width, var_113_1:getContentSize().height))
				var_113_1:setScale(self[iter_113_0].reddotscale or 1)
				var_113_1:setName("reddot")
				self[iter_113_0]:addChild(var_113_1)
			end

			if self:_is_show_reddot(iter_113_0, self[iter_113_0].activitymodule) then
				self[iter_113_0]:getChildByName("reddot"):setVisible(true)
			else
				self[iter_113_0]:getChildByName("reddot"):setVisible(false)
			end
		end
	end
end

local function var_0_35(arg_114_0)
	local var_114_0 = activity_manager:getActivityObj(arg_114_0).finishtime

	if not var_114_0 then
		return ""
	end

	local var_114_1 = global_get_time_by_date(var_114_0) - time_check_manager:getCurTime()

	if var_114_1 < 0 then
		return ""
	end

	local var_114_7 = math.floor(var_114_1 / 24 / 3600)
	local var_114_8 = math.floor((var_114_1 - var_114_7 * 24 * 3600) / 3600)
	local var_114_9 = math.floor((var_114_1 - var_114_7 * 24 * 3600 - var_114_8 * 3600) / 60)

	return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_114_7, var_114_8) or var_114_8 ~= 0 and string.format(L_TIME_TEXT[2], var_114_8, var_114_9) or string.format(L_TIME_TEXT[3], var_114_9)
end

local var_0_36 = {
	textFinishtime = var_0_35,
	textFinishtime1 = var_0_35
}

setmetatable(var_0_36, {
	__index = function(arg_115_0, arg_115_1)
		return function()
			return ""
		end
	end
})

function ActivityMainLayerBaseLayer:_set_label_str()
	for iter_117_0, iter_117_1 in pairs(var_0_36) do
		if self[iter_117_0] then
			self[iter_117_0]:setString((self[iter_117_0].fontstr or "") .. iter_117_1(self.id))
		end
	end
end

function ActivityMainLayerBaseLayer:_getPath(arg_118_1)
	if not arg_118_1 then
		return arg_118_1
	end

	if arg_118_1:find("mainScenebg") or arg_118_1:find("GUI") or arg_118_1:find("effect/") then
		return arg_118_1
	end

	return self._path .. arg_118_1
end

local function var_0_37(arg_119_0)
	local var_119_0 = {
		jump = function(...)
			return (cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, 16 * 1)), cc.MoveBy:create(0.15, cc.p(0, -24 * 1)), cc.MoveBy:create(0.05, cc.p(0, 8 * 1)), cc.DelayTime:create(0.8))))
		end,
		shake = function(...)
			return (cc.RepeatForever:create(cc.Sequence:create(cc.RotateBy:create(0.1, 10), cc.RotateBy:create(0.1, -10), cc.RotateBy:create(0.1, -10), cc.RotateBy:create(0.1, 10), cc.DelayTime:create(0.8))))
		end,
		scale = function(...)
			return (cc.RepeatForever:create(cc.Sequence:create(cc.ScaleTo:create(0.2, 1.2, 1.2), cc.ScaleTo:create(0.15, 0.9, 0.9), cc.ScaleTo:create(0.05, 1, 1), cc.DelayTime:create(0.8))))
		end,
		fade = function(...)
			return (cc.RepeatForever:create(cc.Sequence:create(cc.FadeOut:create(0.5), cc.FadeIn:create(0.5), cc.DelayTime:create(1.2))))
		end
	}

	if var_119_0[arg_119_0] then
		return var_119_0[arg_119_0]()
	end
end

local function var_0_38(arg_124_0, arg_124_1)
	local var_124_0 = {
		pos = function(self, arg_125_1)
			if arg_125_1[2] then
				self:setPositionX(arg_125_1[1].x)
				self:setPositionY(arg_125_1[1].y + arg_125_1[2] * GameDisplay.fix_y)
			else
				self:setPosition(arg_125_1)
			end
		end,
		visible = function(self, arg_126_1)
			self:setVisible(arg_126_1)
		end,
		size = function(self, arg_127_1)
			self:setFontSize(arg_127_1)
		end,
		anchorpoint = function(self, arg_128_1)
			self:setAnchorPoint(arg_128_1)
		end,
		color = function(self, arg_129_1)
			self:setColor(arg_129_1)
		end,
		zorder = function(self, arg_130_1)
			self:setLocalZOrder(arg_130_1)
		end,
		scale = function(self, arg_131_1)
			self:setScale(arg_131_1)
		end,
		action = function(self, arg_132_1)
			self:runAction(var_0_37(arg_132_1))
		end,
		rotation = function(self, arg_133_1)
			self:setRotation(arg_133_1)
		end,
		widget = function(self, arg_134_1)
			if arg_134_1 == "up" then
				self.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.UP, math.abs(config._DESIGN_HEIGHT - self:getPositionY()), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

				self:setPositionY(self.full_posY)
			elseif arg_134_1 == "down" then
				self.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self:getPositionY(), TRANSFORM_UNIT.PX) + GameDisplay.fix_y

				self:setPositionY(self.full_posY)
			end
		end,
		open_reddot = function(self, arg_135_1)
			if arg_135_1 == "once" then
				local var_135_0 = self:getName()
				local var_135_1 = RoleDefault:getInstance():getIntegerForKey(var_0_13 .. var_135_0 .. "reddot", 0)

				if var_135_1 == 0 then
					if self.locktime and time_check_manager:getCurTime() < os.time(parse_time(self.locktime)) then
						activity_manager:updateActivityAlert(var_135_0, var_0_13, false)
					else
						RoleDefault:getInstance():setIntegerForKey(var_0_13 .. var_135_0 .. "reddot", 1)
						activity_manager:updateActivityAlert(var_135_0, var_0_13, true)
					end
				elseif var_135_1 == 1 then
					activity_manager:updateActivityAlert(var_135_0, var_0_13, true)
				elseif var_135_1 == 2 then
					activity_manager:updateActivityAlert(var_135_0, var_0_13, false)
				end
			end
		end
	}

	for iter_124_0, iter_124_1 in pairs(arg_124_1) do
		arg_124_0[iter_124_0] = iter_124_1
	end

	for iter_124_2, iter_124_3 in pairs(arg_124_1) do
		if var_124_0[iter_124_2] then
			var_124_0[iter_124_2](arg_124_0, iter_124_3)
		end
	end
end

function ActivityMainLayerBaseLayer._createNode(arg_136_0, arg_136_1, arg_136_2)
	if arg_136_2.channels and not var_0_17[DeviceManager:getChannelID()] then
		return
	end

	local var_136_0

	for iter_136_0, iter_136_1 in pairs({
		img = function(...)
			return ccui.ImageView:create(arg_136_0:_getPath(arg_136_2.path))
		end,
		text = function(...)
			return ccui.Text:create(arg_136_2.str or arg_136_1, arg_136_2.font or FONT_DES, arg_136_2.fontsize or 20)
		end,
		btn = function(...)
			return ccui.Button:create(arg_136_0:_getPath(arg_136_2.path), arg_136_0:_getPath(arg_136_2.path_on), arg_136_0:_getPath(arg_136_2.path))
		end,
		particle = function(...)
			return cc.ParticleSystemQuad:create(arg_136_0:_getPath(arg_136_2.path))
		end,
		showgirl = function(...)
			return arg_136_0:_create_showgirl_layer()
		end
	}) do
		if string.find(arg_136_1, iter_136_0) then
			var_136_0 = iter_136_1()
		end
	end

	if not var_136_0 then
		print(arg_136_1 .. "没有找对对应的预定义类型")

		var_136_0 = cc.Node:create()
	end

	var_136_0:setName(arg_136_1)

	return var_136_0
end

local var_0_39 = {
	btnGetRole = function(arg_142_0, arg_142_1)
		var_0_16.register("btnRole", function()
			arg_142_0:setVisible(true)

			arg_142_0.hide_count_down = 5

			arg_142_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function(...)
				arg_142_0.hide_count_down = arg_142_0.hide_count_down - 0.1

				if arg_142_0.hide_count_down <= 0 then
					arg_142_0:stopAllActions()
					arg_142_0:setVisible(false)
				end
			end))))
		end)
	end,
	btnTwist = function(arg_145_0, arg_145_1)
		var_0_16.register("btnRole", function()
			arg_145_0:runAction(cc.Sequence:create(cc.MoveBy:create(0.06, cc.p(0, 6)), cc.MoveBy:create(0.06 * 2, cc.p(0, -6 * 2)), cc.MoveBy:create(0, cc.p(0, 6))))
		end)
	end
}

function ActivityMainLayerBaseLayer:buildUiFromConf(arg_147_1)
	local var_147_0 = self.id or arg_147_1
	local var_147_1 = require("data.activity_main.uiconfig.activity_main_uiconfig_" .. var_147_0 .. "_data")

	if var_147_0 == 430 and global_get_time_by_date("2023-01-24 00:00:00") < time_check_manager:getCurTime() then
		var_147_1.imgBg.path = "img_bg2.png"
		var_147_1.btnTwist.path = "btn_twist_3.png"
	end

	if var_147_0 == 838 and time_check_manager:getCurTime() > global_get_time_by_date("2025-10-03 00:00:00") and time_check_manager:getCurTime() < global_get_time_by_date("2025-10-09 23:59:59") then
		var_147_1.btnTwistChoose1.path = "btn_twist_replace.png"
	end

	for iter_147_0, iter_147_1 in pairs(var_147_1) do
		local var_147_2 = self:_createNode(iter_147_0, iter_147_1)

		if var_147_2 then
			var_0_38(var_147_2, iter_147_1)

			self[iter_147_0] = var_147_2

			self.rootLayer:addChild(var_147_2)
		else
			print("not find register create function:", iter_147_0)
		end

		if self.btnShare then
			self.btnShare:setVisible(false)
		end

		if var_0_39[iter_147_0] then
			var_0_39[iter_147_0](var_147_2, self)
		end
	end
end

local var_0_40 = {
	honor = true
}

function ActivityMainLayerBaseLayer:registerShareDispath(...)
	activity_manager:registerEventListener("ActivityMainLayerBaseLayer_" .. self.id, activity_manager.activityEventId.BTN_SHARE_SHOW_UPDATE, function(arg_149_0)
		if arg_149_0 == 1 then
			if DeviceManager.platform == "android" then
				if self.btnShare then
					self.btnShare:setVisible(not var_0_40[DeviceManager.getPackageChannel()])
				end
			elseif self.btnShare then
				self.btnShare:setVisible(true)
			end
		end

		self:_updateBtnReddot()
	end)
	share_manager:get_activity_share_data(self.id, function(arg_150_0, arg_150_1)
		if arg_150_0 == 1 then
			activity_manager:fireEvent(activity_manager.activityEventId.BTN_SHARE_SHOW_UPDATE, arg_150_0)
		end
	end)
end

function ActivityMainLayerBaseLayer:showSeeMoreLayer()
	if not self.seeMoreLayer then
		self.seeMoreLayer = ccui.Layout:create()

		self.seeMoreLayer:setTouchEnabled(true)
		self.seeMoreLayer:setContentSize(cc.Director:getInstance():getVisibleSize())
		self.seeMoreLayer:setAnchorPoint(cc.p(0, 0))
		self.seeMoreLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
		self.seeMoreLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
		self.seeMoreLayer:setBackGroundColor(cc.c3b(0, 0, 0))
		self.seeMoreLayer:setBackGroundColorOpacity(0)
		self.rootLayer:addChild(self.seeMoreLayer, 10001)

		local var_151_0 = activity_main_conf[self.id].servant

		assert(activity_main_conf[self.id].servant, string.format("activity_conf_data[%d].servant is nil", self.id))

		local var_151_1 = {
			function(...)
				LayerManager:pushInLayer("PhotoFileRoleFileLayer", {
					PhotoFileLayer = 1,
					contentType = {
						contentType = "file_player"
					},
					id = model_data[servant_data[var_151_0].modelid].photofile_model,
					modelid = servant_data[var_151_0].modelid,
					servantid = var_151_0
				})
				AnalyticManager.ActivityMainLayer({
					event_name = "on_touch_seemore_file",
					activityid = self.id
				})
			end,
			function(...)
				LayerManager:pushInLayer("SoulsLayer", {
					showtype = SHOW_TYPE_TWISTEGG_PREVIEW,
					cursoul = var_151_0
				})
				AnalyticManager.ActivityMainLayer({
					event_name = "on_touch_seemore_role",
					activityid = self.id
				})
			end,
			function(...)
				LayerManager:pushInLayer("BondLayer")
				AnalyticManager.ActivityMainLayer({
					event_name = "on_touch_seemore_bond",
					activityid = self.id
				})
			end,
			function(...)
				LayerManager:switchShowLayer("DormitoryLayer")
				AnalyticManager.ActivityMainLayer({
					event_name = "on_touch_seemore_dorm",
					activityid = self.id
				})
			end
		}

		self.seeMoreLayer:addTouchEventListener(function(arg_156_0, arg_156_1)
			if arg_156_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_156_0 = arg_156_0:getTouchEndPosition()
			local var_156_1 = var_156_0.y
			local var_156_2 = self.btnSeeMore:getPositionY() + GameDisplay.fix_y
			local var_156_3 = var_156_0.x
			local var_156_4 = self.btnSeeMore:getPositionX()
			local var_156_5 = math.sqrt(math.pow(var_156_0.y - var_156_2, 2) + math.pow(var_156_0.x - var_156_4, 2))

			if 50 < var_156_5 and var_156_5 < 150 then
				var_151_1[var_156_1 - var_156_2 > 0 and var_156_3 - var_156_4 > 0 and 1 or var_156_1 - var_156_2 > 0 and var_156_3 - var_156_4 < 0 and 2 or var_156_1 - var_156_2 < 0 and var_156_3 - var_156_4 < 0 and 3 or 4]()
			elseif self.seeMoreLayer:isVisible() then
				self.seeMoreLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.3), cc.Hide:create()))
				self.seeMoreLayer:getChildByName("seeMoreSpine"):play("2", false)
			end
		end)

		local var_151_2 = L2Skeleton:create(self._path .. "anniu.json", self._path .. "anniu.atlas")

		var_151_2:refreshSkeleton()
		print(self.btnSeeMore:getPositionX(), self.btnSeeMore:getPositionY())
		var_151_2.skeletonAnimation:setPositionX(self.btnSeeMore:getPositionX())
		var_151_2.skeletonAnimation:setPositionY(self.btnSeeMore:getPositionY() + GameDisplay.fix_y - 140)
		var_151_2:setName("seeMoreSpine")
		self.seeMoreLayer:addChild(var_151_2)
	end

	self.seeMoreLayer:setVisible(true)
	self.seeMoreLayer:getChildByName("seeMoreSpine"):play("1", false)
end

function ActivityMainLayerBaseLayer.debug_set_test_reddot_pos_enabled(arg_157_0, arg_157_1)
	arg_157_0._debugreddot = arg_157_1
end

function ActivityMainLayerBaseLayer:debug_create_default_ui()
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
	self:buildUiFromConf("example")
end

function ActivityMainLayerBaseLayer:_test(...)
	if config._DEBUG then
		local function var_159_0(arg_160_0)
			require(arg_160_0)

			if not package.loaded[arg_160_0] then
				print(" fuck ! can't find mod!")
			end

			arg_160_0 = string.gsub(arg_160_0, "%.", "/")

			local var_160_1 = io.open("./src/" .. arg_160_0 .. ".lua")

			var_160_1:close()

			for iter_160_0, iter_160_1 in pairs(package.loaded[arg_160_0]) do
				package.loaded[arg_160_0][iter_160_0] = nil
			end

			for iter_160_2, iter_160_3 in pairs((loadstring((var_160_1:read("*a")))())) do
				package.loaded[arg_160_0][iter_160_2] = iter_160_3
			end

			return ret
		end

		for iter_159_0, iter_159_1 in pairs(var_0_24) do
			if self[iter_159_0] then
				local var_159_1 = self[iter_159_0].activitymodule or var_0_18[iter_159_0]

				if var_159_1 then
					local var_159_2 = activity_manager:get_module_starttime(self.id, var_159_1)
					local var_159_3 = activity_manager:get_module_finishtime(self.id, var_159_1)

					if not var_159_2 then
						if var_159_3 then
							print((string.format("按钮 " .. iter_159_0 .. " %s  %s", var_159_2 or "", var_159_3 or "")))
						end
					end
				end
			end
		end

		self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("f1_updateData", function(arg_161_0)
			var_159_0("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data")

			for iter_161_0, iter_161_1 in pairs((require("data.activity_main.uiconfig.activity_main_uiconfig_" .. (self.id or activityid) .. "_data"))) do
				var_0_38(self[iter_161_0], iter_161_1)
			end
		end), self)
	end
end

function var_0_12(arg_162_0, arg_162_1)
	if config._DEBUG then
		local var_162_0 = {
			sign = function(...)
				hx_print("\n点击签到按钮\n跳转至:" .. 2000000 + arg_162_1, CONSOLE_COLOR_GREEN)
			end,
			shop = function(...)
				local var_164_0 = {}
				local var_164_1 = activity_main_conf[arg_162_1].into_shop or activity_main_conf[arg_162_1].into_shop_1

				if string.find(var_164_1, ",") then
					for iter_164_0, iter_164_1 in pairs(split(var_164_1, ",")) do
						table.insert(var_164_0, "1-" .. tonumber(iter_164_1) % 1500000)
					end
				else
					var_164_0[1] = "1-" .. tonumber(var_164_1) % 1500000
				end

				hx_print("\n点击商城按钮\n跳转至商城包含以下页签：" .. var_164_1 .. ",默认页签为:" .. var_164_0[1] .. "\n填写：活动主界面配置表配置行【" .. arg_162_1 .. "】,列【into_shop】导出类型2", CONSOLE_COLOR_GREEN)
			end,
			twist = function(...)
				hx_print("\n点击扭蛋按钮\n跳转至蛋池：" .. ((activity_main_conf[arg_162_1] or nil) and (activity_main_conf[arg_162_1].into_twist or "")) .. "\n填写：活动主界面配置表配置行【" .. arg_162_1 .. "】,列【into_twist】", CONSOLE_COLOR_GREEN)
			end,
			detail = function(...)
				hx_print("\n点击活动说明按钮\n填写:活动与通知\\【主城】导表_说明表\\导表_说明表 配置" .. "ActivityMain_" .. arg_162_1, CONSOLE_COLOR_GREEN)
			end,
			falselevelinfo = function(...)
				hx_print("\n点击活动说明按钮\n填写:活动与通知\\【主城】导表_说明表\\导表_说明表 配置" .. "ActivityMain_RoleFalseLevel_" .. arg_162_1, CONSOLE_COLOR_GREEN)
			end
		}

		if var_162_0[arg_162_0] then
			hx_print("------------------------------------------", CONSOLE_COLOR_GREEN)
			var_162_0[arg_162_0]()
			hx_print("------------------------------------------", CONSOLE_COLOR_GREEN)
		end
	end
end

function ActivityMainLayerBaseLayer:UINodeConfigHandle(arg_168_1, arg_168_2)
	local var_168_0 = require("data.activity_main.uiconfig.activity_main_uiconfig_" .. self.id .. "_data")

	if arg_168_2 == ccui.TouchEventType.began then
		-- block empty
	elseif arg_168_2 == ccui.TouchEventType.moved then
		arg_168_1:setPosition((self.rootLayer:convertToNodeSpace(arg_168_1:getTouchMovePosition())))
	end

	local var_168_1 = var_168_0[arg_168_1:getName()].pos[2] and var_168_0[arg_168_1:getName()].pos[2] or 0

	var_168_0[arg_168_1:getName()].pos[1] = {
		y = arg_168_1:getPositionY() - var_168_1 * GameDisplay.fix_y,
		x = arg_168_1:getPositionX()
	}
end
