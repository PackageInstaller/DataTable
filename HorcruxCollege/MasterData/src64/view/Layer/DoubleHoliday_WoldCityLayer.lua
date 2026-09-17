DoubleHoliday_WoldCityLayer = class("DoubleHoliday_WoldCityLayer", function()
	return cc.Layer:create()
end)

require("view.Sprite.BottomBtnList")
require("controller.goto_system_manager")

local activity_manager = require("controller.activity_manager")
local playermodel = require("model.playermodel")
local activity_conf_data = require("data.activity_conf_data")
local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")
local activity_doubleholiday_manager = require("controller.activity_doubleholiday_manager")
local var_0_6 = require("controller.time_check_manager")
local aiattack_manager = require("controller.aiattack_manager")
local level_manager = require("controller.level_manager")
local var_0_9
local levelmode_data = require("data.levelmode_data")
local activity_plague_message_data = require("data.activity_plague_message_data")
local activity_plague_city_data = require("data.activity_plague_city_data")
local activity_plague_data = require("data.activity_plague_data")
local var_0_14 = require("data.levelmode_data")
local item_manager = require("controller.item_manager")
local item_doubleholiday_data = require("data.item_doubleholiday_data")
local item_data = require("data.item_data")
local activity_plague_other_data = require("data.activity_plague_other_data")
local ItemSprite = require("view.Sprite.ItemSprite")
local var_0_21 = {
	201912003,
	201912002,
	201912001
}
local var_0_22 = {
	"Activity_doubleholiday/chengjiu.png",
	"Activity_doubleholiday/ai.png",
	"Activity_doubleholiday/sd_bdkg.png"
}
local var_0_24 = config._DEBUG and 0 or 1

function DoubleHoliday_WoldCityLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = DoubleHoliday_WoldCityLayer.new()

	var_2_0:init(arg_2_1)
	activity_manager:fireEvent(activity_manager.activityEventId.POP_LAYER_OPEMED)

	return var_2_0
end

function DoubleHoliday_WoldCityLayer.getInstance()
	return var_0_9
end

function DoubleHoliday_WoldCityLayer:init(arg_4_1)
	var_0_9 = self
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "DoubleHoliday_WorldCityLayer.json" or "DoubleHoliday_WorldCityLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.title = ccui.Helper:seekWidgetByName(self.rootLayer, "image_title")
	self.title_name = ccui.Helper:seekWidgetByName(self.rootLayer, "Label_activityname")
	self.btn_info = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_info")
	self.panel_ml = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_mindle_l")
	self.panel_mr = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_mindle_r")
	self.panel_city = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_city")
	self.panel_explore = ccui.Helper:seekWidgetByName(self.rootLayer, "panel_tanxian")
	self.btn_broadcast = ccui.Helper:seekWidgetByName(self.rootLayer, "Button_30")
	self.btn_explore = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_tanxian")
	self.btn_addnum = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_add")
	self.label_guaji = ccui.Helper:seekWidgetByName(self.panel_ml, "Label_28")
	self.shop_btn = ccui.Helper:seekWidgetByName(self.panel_explore, "Button_100")
	self.title_yinzi = ccui.Helper:seekWidgetByName(self.title, "Image_23")
	self.vir_add = ccui.Helper:seekWidgetByName(self.title, "Button_62")
	self.ai_create_btn = ccui.Helper:seekWidgetByName(self.panel_explore, "Button_112")
	self.add_kuozhan = ccui.Helper:seekWidgetByName(self.rootLayer, "Panel_114")

	self.panel_city:setVisible(false)
	self.title:setLocalZOrder(5)
	self.panel_ml:setLocalZOrder(5)
	self.btn_addnum:getChildByName("Label_241"):setPositionY(15)
	self:createTimeLable()
	self:registerTimeCheckEvent()
	self:updateTime()
	GuideListener.lockGuideTrigger(false)
	self:playFirstEnterTalk(function(...)
		activity_doubleholiday_manager:get_chiris_level_config(function(arg_6_0)
			if arg_6_0.result == 0 then
				cclog(L_EXPLORE_BY_ACTIVITY[0])
			elseif arg_6_0.result == 1 then
				self.activityExploreData = activity_doubleholiday_manager:getActivityExploreConfData()

				if arg_6_0.finish_step == 0 then
					explore_manager:begin_explore({
						activityid = 12,
						activity_explore_id = 1,
						frameType = "yellow",
						type = "activity",
						failReturnUiLayer = "MainLayer",
						returnLayer = "DoubleHoliday_WoldCityLayer",
						cancelCallback = function(arg_7_0)
							if arg_7_0 == 2 then
								global_ShowBlockWords(L_ACTIVITY_CLOSE)
							elseif arg_7_0 == 3 then
								global_ShowBlockWords(L_ACTIVITY_ALL_FINISHED)
							elseif arg_7_0 == 4 then
								global_ShowBlockWords(L_ACTIVITY_DATA_ERROR)
							elseif arg_7_0 == 5 then
								global_ShowBlockWords(L_ACTIVITY_DATA_ERROR)
							elseif arg_7_0 == 0 then
								global_ShowBlockWords(L_EXPLORE_BY_ACTIVITY[0])
							end
						end
					})
				end
			else
				GuideListener.lockGuideTrigger(true)
			end
		end)
	end)

	if arg_4_1 then
		self.callback = arg_4_1.callback
	end

	self.btn_info:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_8_0:setBright(false)

		local var_8_0 = {
			callback = function()
				if var_0_9 then
					arg_8_0:setBright(true)
				end
			end
		}

		var_8_0.key = "activity_12_qsl"

		LayerManager:pushInLayer("PopActivityDetail", var_8_0)
	end)
	self.btn_broadcast:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_10_0:setBright(false)
		LayerManager:pushInLayer("PopDroadcastLayer", {
			callback = function()
				if var_0_9 then
					arg_10_0:setBright(true)
				end
			end
		})
	end)
	self.btn_explore:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_12_0 = aiattack_manager:get_levelmode_id()

		if not item_manager:isHaveItemByType(KITEM_AI_MONSTER) then
			global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.SIMULATED_INTRUSION)
			arg_12_0:setBright(true)

			return
		end

		LayerManager:pushInLayer("AdventureNewDetailLayer", {
			data = var_0_14[var_12_0],
			times = self.ai_attack_times
		})
	end)
	self.btn_addnum:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_13_0:isBright() then
			return
		end

		arg_13_0:setBright(false)

		local var_13_0 = var_0_14[aiattack_manager:get_levelmode_id()].modetype

		local function var_13_1()
			arg_13_0:setBright(true)
		end

		local function var_13_2()
			level_manager:buyAdventureDailyTime(var_13_0, function(arg_16_0, arg_16_1, arg_16_2)
				if arg_16_0 == 1 then
					global_ShowBlockWords(L_BUY_TIMES_SUCCESS)

					self.ai_attack_times = arg_16_2

					self:updateAIAttackTimes(arg_16_2)
				elseif arg_16_0 == 2 then
					global_ShowBlockWords(L_DIAMOND_LACK)
				elseif arg_16_0 == 3 then
					global_ShowBlockWords(L_BUY_TIMES_LIMITED)
				end

				if var_13_1 then
					var_13_1()
				end
			end)
		end

		level_manager:getBuyAdventureDailyTimeInfo(var_13_0, function(arg_17_0, arg_17_1, arg_17_2)
			if arg_17_0 == 1 then
				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = var_13_2,
					cancelcallback = function()
						if var_13_1 then
							var_13_1()
						end
					end,
					cost = arg_17_1,
					own = playermodel.diamond,
					labels = {
						titleImage = "title_more_adventure_times.png",
						button = L_BUY_TIMES_MSG.button,
						des = string.format(L_BUY_TIMES_MSG.des, arg_17_1),
						more = string.format(L_BUY_TIMES_MSG.more, arg_17_1)
					}
				})
			else
				global_ShowBlockWords(L_BUY_TIMES_LIMITED)

				if var_13_1 then
					var_13_1()
				end
			end
		end)
	end)
	self.add_kuozhan:addTouchEventListener(function(arg_19_0, arg_19_1)
		if arg_19_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_19_0:isBright() then
			return
		end

		arg_19_0:setBright(false)

		local var_19_0 = var_0_14[aiattack_manager:get_levelmode_id()].modetype

		local function var_19_1()
			arg_19_0:setBright(true)
		end

		local function var_19_2()
			level_manager:buyAdventureDailyTime(var_19_0, function(arg_22_0, arg_22_1, arg_22_2)
				if arg_22_0 == 1 then
					global_ShowBlockWords(L_BUY_TIMES_SUCCESS)

					self.ai_attack_times = arg_22_2

					self:updateAIAttackTimes(arg_22_2)
				elseif arg_22_0 == 2 then
					global_ShowBlockWords(L_DIAMOND_LACK)
				elseif arg_22_0 == 3 then
					global_ShowBlockWords(L_BUY_TIMES_LIMITED)
				end

				if var_19_1 then
					var_19_1()
				end
			end)
		end

		level_manager:getBuyAdventureDailyTimeInfo(var_19_0, function(arg_23_0, arg_23_1, arg_23_2)
			if arg_23_0 == 1 then
				LayerManager:pushInLayer("PopDoLayer", {
					costtype = "diamond",
					surecallback = var_19_2,
					cancelcallback = function()
						if var_19_1 then
							var_19_1()
						end
					end,
					cost = arg_23_1,
					own = playermodel.diamond,
					labels = {
						titleImage = "title_more_adventure_times.png",
						button = L_BUY_TIMES_MSG.button,
						des = string.format(L_BUY_TIMES_MSG.des, arg_23_1),
						more = string.format(L_BUY_TIMES_MSG.more, arg_23_1)
					}
				})
			else
				global_ShowBlockWords(L_BUY_TIMES_LIMITED)

				if var_19_1 then
					var_19_1()
				end
			end
		end)
	end)
	self.ai_create_btn:addTouchEventListener(function(arg_25_0, arg_25_1)
		if arg_25_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("AITwistLayer", {
			returnLayer = "DoubleHoliday_WoldCityLayer"
		})
	end)
	self.shop_btn:addTouchEventListener(function(arg_26_0, arg_26_1)
		if arg_26_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_26_0 = cc.EventCustom:new("switchShowLayer")

		var_26_0.layerName = "MarketLayer"
		var_26_0.initparam = {
			showType = "1-26",
			returnLayer = "DoubleHoliday_WoldCityLayer",
			singleMarket = {
				"1-26",
				"1-25",
				"1-24",
				"1-27"
			}
		}

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_26_0)
	end)
	self.vir_add:addTouchEventListener(function(arg_27_0, arg_27_1)
		local var_27_0

		if arg_27_1 ~= ccui.TouchEventType.ended then
			do return end

			var_27_0 = {
				itemid = 201912006
			}
		end

		function var_27_0.callback()
			if var_0_9 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[3])))
			end
		end

		LayerManager:pushInLayer("PopNodeOperationLayer", var_27_0)
	end)
	self.title_yinzi:addTouchEventListener(function(arg_29_0, arg_29_1)
		local var_29_0

		if arg_29_1 ~= ccui.TouchEventType.ended then
			do return end

			var_29_0 = {
				itemid = 201912006
			}
		end

		function var_29_0.callback()
			if var_0_9 then
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[3])))
			end
		end

		LayerManager:pushInLayer("PopNodeOperationLayer", var_29_0)
	end)
	self:getDataFromServer()
	self:initBottomBtnList()
	self:fullScreen()
	self:initTitleBtnTouchListener()
	self:initAIAttackTimes()

	self.next_round_time = -1
	self.actScheduler = self.actScheduler or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		self:getNextRoundTimeFromServer()
	end, 2, false)

	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_32_0)
		if arg_32_0 == "exit" then
			if self.actScheduler then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.actScheduler)

				self.actScheduler = nil
			end

			var_0_9 = nil

			if self.callback then
				self.callback()
			end

			activity_manager:releaseEventListenerByName("DoubleHoliday_WoldCityLayer")
		end
	end)
end

function DoubleHoliday_WoldCityLayer.registerActivityEventListener(arg_33_0)
	activity_manager:registerEventListener("DoubleHoliday_WoldCityLayer", activity_manager.activityEventId.TECHNOLOGY_TREE_DATA_UPDATE, function(arg_34_0)
		arg_33_0:updateTecNumber()
	end)
	activity_manager:registerEventListener("DoubleHoliday_WoldCityLayer", activity_manager.activityEventId.TECHNOLOGY_LEVEL_UP_SECCESS, function(arg_35_0)
		arg_33_0:updateTecNumber()
	end)
end

function DoubleHoliday_WoldCityLayer:updateTecNumber()
	ccui.Helper:seekWidgetByName(self.title, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[2])))
end

function DoubleHoliday_WoldCityLayer.updateUI(arg_37_0)
	return
end

function DoubleHoliday_WoldCityLayer:getNextRoundTimeFromServer()
	local var_38_0 = var_0_6:getCurTime()

	if self.next_round_time == -1 then
		-- block empty
	elseif var_38_0 >= self.next_round_time then
		self:getDataFromServer()
	end

	self.next_recover_time = activity_doubleholiday_manager:get_recover_time() or activity_doubleholiday_manager:get_recover_time() or 0

	if var_38_0 >= self.next_recover_time then
		activity_doubleholiday_manager:recover_virus(12, function(arg_39_0)
			if arg_39_0.result ~= 0 then
				global_get({
					items = {
						arg_39_0.virus
					}
				})
				ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[3])))
			end
		end)
	end
end

function DoubleHoliday_WoldCityLayer:initUI(arg_40_1)
	if not self.data then
		return
	end

	self.panel_city:setVisible(true)
	self:isGameOver()
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_24"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[1])))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_25"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[2])))
	ccui.Helper:seekWidgetByName(self.rootLayer, "Label_26"):setString(global_trans_number(item_manager:getItemNumber(var_0_21[3])))
	self.label_guaji:setString("+" .. self.data.output .. "/h")
	self:updateCityBtn()
	self:updateBroadCastPanel(self.data.news)
	self:updateCityPanel(self.data.cities)

	self.citys_data = self.data.cities

	for iter_40_0 = 2, 8 do
		ccui.Helper:seekWidgetByName(self.panel_city, "city_" .. iter_40_0 - 1):addTouchEventListener(function(arg_41_0, arg_41_1)
			if arg_41_1 ~= ccui.TouchEventType.ended then
				return
			end

			if not arg_41_0:isBright() then
				return
			end

			arg_41_0:setBright(false)

			arg_41_0.tag = iter_40_0

			for iter_41_0, iter_41_1 in pairs(self.citys_data) do
				if iter_41_1.cityid == arg_41_0.tag then
					arg_41_0.data = iter_41_1
				end
			end

			self:updateCityPanel(self.citys_data)

			if not arg_41_0.data then
				global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.UNLOCK)
			elseif arg_41_0.data.story then
				LayerManager:switchShowLayer("DoubleHoliday_CityNodeLayer", {
					city = arg_41_0.tag,
					callback = function()
						if var_0_9 then
							arg_41_0:setBright(true)
						end
					end
				})
			elseif arg_41_0.data.damage ~= 100 then
				if not self:isUnlockCity(arg_41_0.tag) then
					global_ShowBlockWords(L_DOUBLEHOLIDAY_WOLDCITYLAYER.UNLOCK)
					arg_41_0:setBright(true)

					return
				else
					local var_41_0 = {
						city = arg_41_0.tag
					}

					function var_41_0.callback()
						if var_0_9 then
							arg_41_0:setBright(true)
						end
					end

					LayerManager:switchShowLayer("DoubleHoliday_CityNodeLayer", var_41_0)
				end
			else
				local function var_41_1()
					if var_0_9 then
						arg_41_0:setBright(true)
					end
				end

				local function var_41_2(arg_45_0)
					if var_41_1 then
						var_41_1()
					end

					self:addCityNews(arg_41_0)
					activity_doubleholiday_manager:finish_citystory(12, arg_41_0.tag, function(arg_46_0)
						if arg_46_0.result ~= 0 then
							self:getDataFromServer()
						end
					end)
				end

				print(":::::::::::::::TalkLayer::::::::::::", arg_41_0.tag)

				if activity_plague_city_data[arg_41_0.tag].classification then
					global_basic_scene:addChild(TalkLayer:create(activity_plague_city_data[arg_41_0.tag].classification, nil, TALK_TYPE_TRAVEL, "", var_41_2), ZORDER_TALKLAYER)
				elseif var_41_2 then
					var_41_2()
				end
			end
		end)
	end
end

function DoubleHoliday_WoldCityLayer:initAIAttackTimes()
	self.btn_explore:setVisible(false)
	self.btn_explore:setOpacity(0)
	level_manager:getAdventureDailytimeByModeType(var_0_14[aiattack_manager:get_levelmode_id()].modetype, function(arg_48_0, arg_48_1)
		if arg_48_0 == 1 then
			self.ai_attack_times = arg_48_1

			self:updateAIAttackTimes()
			self.btn_explore:runAction(cc.Sequence:create(cc.Show:create(), cc.FadeIn:create(0.5)))
		end
	end)
end

function DoubleHoliday_WoldCityLayer:updateAIAttackTimes()
	self.btn_addnum:getChildByName("Label_241"):setString(self.ai_attack_times .. "/" .. var_0_14[aiattack_manager:get_levelmode_id()].dailytime)
end

function DoubleHoliday_WoldCityLayer:updateCityPanel(arg_50_1)
	if not arg_50_1 or not next(arg_50_1) then
		return
	end

	for iter_50_0 = 2, 8 do
		local var_50_0 = ccui.Helper:seekWidgetByName(self.panel_city, "city_" .. iter_50_0 - 1)
		local var_50_1

		for iter_50_1, iter_50_2 in pairs(arg_50_1) do
			if iter_50_2.cityid == iter_50_0 then
				var_50_1 = iter_50_2
			end
		end

		var_50_0.tag = iter_50_0

		if not var_50_1 then
			var_50_0:getChildByName("Label_decipher"):setVisible(false)
			var_50_0:getChildByName("Label_Infected"):setVisible(false)
			self:updateCityStatusImg(var_50_0, 1)
		elseif var_50_1.damage ~= 100 then
			if not self:isUnlockCity(iter_50_0) then
				var_50_0:getChildByName("Label_decipher"):setVisible(false)
				var_50_0:getChildByName("Label_Infected"):setVisible(false)
				self:updateCityStatusImg(var_50_0, 1)
			else
				self:updateCityStatusImg(var_50_0, 3)

				if var_50_1.damage and var_50_1.damage >= 0 then
					var_50_0:getChildByName("Label_Infected"):setVisible(true)
					ccui.Helper:seekWidgetByName(var_50_0:getChildByName("Label_Infected"), "ProgressBar_1"):setPercent(var_50_1.damage)
					ccui.Helper:seekWidgetByName(var_50_0:getChildByName("Label_Infected"), "label_percent"):setString("" .. var_50_1.damage .. "%")
				else
					var_50_0:getChildByName("Label_Infected"):setVisible(false)
				end

				if var_50_1.decode and var_50_1.decode >= 0 then
					var_50_0:getChildByName("Label_decipher"):setVisible(true)
					ccui.Helper:seekWidgetByName(var_50_0:getChildByName("Label_decipher"), "ProgressBar_1"):setPercent(var_50_1.decode)
					ccui.Helper:seekWidgetByName(var_50_0:getChildByName("Label_decipher"), "label_percent"):setString("" .. var_50_1.decode .. "%")
				else
					var_50_0:getChildByName("Label_decipher"):setVisible(false)
				end
			end
		elseif var_50_1.damage == 100 then
			var_50_0:setBright(true)
			self:updateCityStatusImg(var_50_0, 2)
		end
	end
end

function DoubleHoliday_WoldCityLayer.updateCityStatusImg(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1:getChildByName("name_node") then
		arg_51_1:getChildByName("name_node"):removeFromParent()
	end

	if arg_51_2 == 1 then
		arg_51_1:getChildByName("Image_32"):setVisible(false)
		arg_51_1:getChildByName("Image_33"):setVisible(false)
		arg_51_1:getChildByName("Image_89"):setVisible(true)
	elseif arg_51_2 == 2 then
		arg_51_1:getChildByName("Image_32"):setVisible(true)
		arg_51_1:getChildByName("Image_33"):setVisible(false)
		arg_51_1:getChildByName("Image_89"):setVisible(false)

		if arg_51_1:getChildByName("name_node") then
			arg_51_1:getChildByName("name_node"):removeFromParent()
		end

		local var_51_0 = cc.Label:createWithTTF(glabal_trans_text_horizontal_to_vertical(activity_plague_city_data[arg_51_1.tag].name), "fonts/name.ttf", 20)

		var_51_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_51_0:setPosition(cc.p(arg_51_1:getContentSize().width / 2 - 70, arg_51_1:getContentSize().height / 2))
		var_51_0:setName("name_node")
		arg_51_1:addChild(var_51_0, 100)
	elseif arg_51_2 == 3 then
		arg_51_1:getChildByName("Image_32"):setVisible(false)
		arg_51_1:getChildByName("Image_33"):setVisible(true)
		arg_51_1:getChildByName("Image_89"):setVisible(false)
	else
		arg_51_1:getChildByName("Image_32"):setVisible(false)
		arg_51_1:getChildByName("Image_33"):setVisible(false)
		arg_51_1:getChildByName("Image_89"):setVisible(false)
	end
end

function DoubleHoliday_WoldCityLayer.getDataFromServer(arg_52_0)
	activity_doubleholiday_manager:get_worldcity_info(12, function(arg_53_0)
		if arg_53_0.result ~= 0 then
			arg_52_0.data = arg_53_0

			local var_53_0 = {}

			for iter_53_0, iter_53_1 in pairs(arg_52_0.data.cities) do
				if iter_53_1.next_round_time and iter_53_1.next_round_time ~= -1 then
					table.insert(var_53_0, iter_53_1.next_round_time)
				end
			end

			arg_52_0.next_round_time = next(var_53_0) and (function(arg_54_0)
				local var_54_0 = arg_54_0[1]

				for iter_54_0 = 2, #arg_54_0 do
					if var_54_0 > arg_54_0[iter_54_0] then
						var_54_0 = arg_54_0[iter_54_0]
					end
				end

				return var_54_0
			end)(var_53_0) or -1

			arg_52_0:initUI(arg_52_0.data)
		end
	end)
end

local function var_0_25(arg_55_0)
	if not arg_55_0 then
		return
	end

	if arg_55_0 >= 86400 then
		return string.format(L_TIME_FORMAT[1], math.floor(arg_55_0 / 86400), math.floor(arg_55_0 % 86400 / 3600))
	elseif arg_55_0 >= 3600 then
		return string.format(L_TIME_FORMAT[2], math.floor(arg_55_0 / 3600), math.floor(arg_55_0 % 3600 / 60))
	else
		return string.format(L_TIME_FORMAT[3], math.floor(arg_55_0 / 60))
	end
end

function DoubleHoliday_WoldCityLayer:updateBroadCastPanel(arg_56_1)
	local var_56_0 = ccui.Helper:seekWidgetByName(self.panel_mr, "Label_31")

	var_56_0:getVirtualRenderer():setMaxLineWidth(216)

	local var_56_1 = L_DOUBLEHOLIDAY_WOLDCITYLAYER.NONEWS
	local var_56_2 = {
		cityname = function(arg_57_0)
			return activity_plague_city_data[arg_57_0].name
		end,
		nodename = function(arg_58_0)
			local var_58_0 = ""

			if type(arg_58_0) == "number" then
				var_58_0 = activity_plague_data[arg_58_0].nodename
			elseif type(arg_58_0) == "table" then
				for iter_58_0, iter_58_1 in ipairs(arg_58_0) do
					var_58_0 = var_58_0 .. activity_plague_data[iter_58_1].nodename .. ((iter_58_0 == #arg_58_0 or nil) and "")
				end
			end

			return var_58_0
		end,
		date = function(arg_59_0)
			return (var_0_25(arg_59_0))
		end,
		value = function(arg_60_0)
			return global_trans_number(arg_60_0)
		end
	}

	if arg_56_1 and next(arg_56_1) then
		var_56_1 = string.gsub(activity_plague_message_data[arg_56_1.id].msg, "(%w+)|(%w+)", function(arg_61_0, arg_61_1)
			return var_56_2[arg_61_0] and arg_56_1[arg_61_1] and var_56_2[arg_61_0](arg_56_1[arg_61_1]) or arg_56_1[arg_61_1]
		end)

		if arg_56_1.new then
			var_56_1 = "【NEW】" .. var_56_1
		end
	end

	var_56_0:setString(var_56_1)
end

function DoubleHoliday_WoldCityLayer:updateCityBtn()
	for iter_62_0 = 2, 8 do
		local var_62_0 = ccui.Helper:seekWidgetByName(self.panel_city, "city_" .. iter_62_0 - 1)
		local var_62_1

		for iter_62_1, iter_62_2 in pairs(self.data.cities) do
			if iter_62_2.cityid == iter_62_0 then
				var_62_1 = iter_62_2
			end
		end

		if var_62_1 then
			if not self:isUnlockCity(iter_62_0) then
				var_62_0:getChildByName("Label_decipher"):setVisible(false)
				var_62_0:getChildByName("Label_Infected"):setVisible(false)
				self:addCityNews(var_62_0)

				return
			elseif var_62_1.story then
				self:addCityNews(var_62_0)
			else
				if var_62_1.damage and var_62_1.damage >= 0 then
					var_62_0:getChildByName("Label_Infected"):setVisible(true)
					ccui.Helper:seekWidgetByName(var_62_0:getChildByName("Label_Infected"), "ProgressBar_1"):setPercent(var_62_1.damage)
					ccui.Helper:seekWidgetByName(var_62_0:getChildByName("Label_Infected"), "label_percent"):setString("" .. var_62_1.damage .. "%")

					if var_62_1.damage == 100 and not var_62_1.story then
						self:addCityNews(var_62_0, true)
					else
						self:addCityNews(var_62_0)
					end
				else
					var_62_0:getChildByName("Label_Infected"):setVisible(false)
					self:addCityNews(var_62_0)
				end

				if var_62_1.decode and var_62_1.decode >= 0 then
					var_62_0:getChildByName("Label_decipher"):setVisible(true)
					ccui.Helper:seekWidgetByName(var_62_0:getChildByName("Label_decipher"), "ProgressBar_1"):setPercent(var_62_1.decode)
					ccui.Helper:seekWidgetByName(var_62_0:getChildByName("Label_decipher"), "label_percent"):setString("" .. var_62_1.decode .. "%")
				else
					var_62_0:getChildByName("Label_decipher"):setVisible(false)
				end
			end
		else
			var_62_0:getChildByName("Label_decipher"):setVisible(false)
			var_62_0:getChildByName("Label_Infected"):setVisible(false)
			self:addCityNews(var_62_0)
		end
	end
end

function DoubleHoliday_WoldCityLayer:isUnlockCity(arg_63_1)
	local var_63_0 = false

	for iter_63_0, iter_63_1 in pairs(self.data.cities) do
		if iter_63_1.cityid == arg_63_1 then
			var_63_0 = true

			break
		end
	end

	return var_63_0
end

function DoubleHoliday_WoldCityLayer:initBottomBtnList()
	self.bottomlist = BottomBtnList:create(function(arg_65_0, arg_65_1)
		if arg_65_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()

		if callback then
			callback()
		end
	end, {})

	self:addChild(self.bottomlist, 5)
	self:initBottomAddPanel()
end

function DoubleHoliday_WoldCityLayer:initBottomAddPanel()
	local var_66_0 = ccui.Layout:create()

	var_66_0:setPosition(cc.p(320, 30))
	var_66_0:setName("bottomAddPanel")
	self.bottomlist:addChild(var_66_0)

	local var_66_1 = ccui.Button:create(var_0_22[1], nil, var_0_22[1], var_0_24)

	var_66_1:setPosition(cc.p(-60, 0))
	var_66_0:addChild(var_66_1)

	self.btn_finalrank = var_66_1

	local var_66_2 = ccui.Button:create(var_0_22[2], nil, var_0_22[2], var_0_24)

	var_66_2:setPosition(cc.p(self.btn_finalrank:getPositionX() + self.btn_finalrank:getContentSize().width + 20, 0))
	var_66_0:addChild(var_66_2)

	self.btn_aicard = var_66_2

	local var_66_3 = ccui.Button:create(var_0_22[3], nil, var_0_22[3], var_0_24)

	var_66_3:setPosition(cc.p(self.btn_aicard:getPositionX() + self.btn_aicard:getContentSize().width + 20, 0))
	var_66_0:addChild(var_66_3)

	self.btn_virsicene = var_66_3

	self.btn_aicard:addTouchEventListener(function(arg_67_0, arg_67_1)
		if arg_67_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("BagLayer", {
			bagType = 19,
			returnLayer = "DoubleHoliday_WoldCityLayer",
			createType = 1
		})
	end)
	self.btn_virsicene:addTouchEventListener(function(arg_68_0, arg_68_1)
		if arg_68_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopTechnologyTree")
	end)
	self.btn_finalrank:addTouchEventListener(function(arg_69_0, arg_69_1)
		if arg_69_1 ~= ccui.TouchEventType.ended then
			return
		end

		arg_69_0:setBright(false)
		LayerManager:switchShowLayer("DoubleHoliday_AchievementLayer", {
			callback = function()
				if var_0_9 then
					arg_69_0:setBright(true)
				end
			end
		})
	end)
end

function DoubleHoliday_WoldCityLayer.updateReddot(arg_71_0)
	return
end

function DoubleHoliday_WoldCityLayer:fullScreen()
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.title:setPositionY(self.title:getPositionY() + GameDisplay.fix_y)
	self.panel_ml:setPositionY(self.panel_ml:getPositionY() + GameDisplay.fix_y)
	self.panel_mr:setPositionY(self.panel_mr:getPositionY() + GameDisplay.fix_y)
	self.panel_explore:setPositionY(self.panel_explore:getPositionY() - GameDisplay.fix_y)

	self.bottomlist.full_posY = GameDisplay.pos_transform(TRANSFORM_REFERENCE.DOWN, self.bottomlist:getPositionY(), TRANSFORM_UNIT.PX)

	self.bottomlist:setPositionY(self.bottomlist.full_posY)
end

function DoubleHoliday_WoldCityLayer:initTitleBtnTouchListener()
	local var_73_0 = self.rootLayer:getChildByName("image_title")
	local var_73_1 = var_73_0:getChildByName("Image_21")

	var_73_1:setTouchEnabled(true)
	var_73_1:addTouchEventListener(function(arg_74_0, arg_74_1)
		if arg_74_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = 201912003
		})
	end)

	local var_73_2 = var_73_0:getChildByName("Image_22")

	var_73_2:setTouchEnabled(true)
	var_73_2:addTouchEventListener(function(arg_75_0, arg_75_1)
		if arg_75_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopItemLayer", {
			itemid = 201912002
		})
	end)

	local var_73_3 = ccui.Helper:seekWidgetByName(self.rootLayer, "Image_27")

	var_73_3:setTouchEnabled(true)
	var_73_3:addTouchEventListener(function(arg_76_0, arg_76_1)
		if arg_76_1 ~= ccui.TouchEventType.ended then
			return
		end

		global_show_data_bubble(var_73_3, self, nil, require("data.detail_data").activity_12_gj.text, 380, 205, 360, 200)
	end)
end

function DoubleHoliday_WoldCityLayer:playFirstEnterTalk(arg_77_1)
	if self:isFirstEnterActivity() then
		self:addChild(TalkLayer:create(8200017, nil, TALK_TYPE_NORMAL, L_ACTIVITY_FIRST_ENTER, arg_77_1, 1), 100)
	else
		arg_77_1()
	end
end

function DoubleHoliday_WoldCityLayer.isFirstEnterActivity(arg_78_0)
	if RoleDefault:getInstance():getIntegerForKey("is_entered_activity_12", 0) == 0 then
		RoleDefault:getInstance():setIntegerForKey("is_entered_activity_12", 1)

		return true
	end

	return false
end

function DoubleHoliday_WoldCityLayer:isGameOver()
	if not self.data or not next(self.data) then
		return
	end

	local var_79_0 = true

	for iter_79_0, iter_79_1 in pairs(self.data.cities) do
		if not iter_79_1.story then
			var_79_0 = false

			break
		end
	end

	if self.panel_city:getChildByName("yuanzhang") then
		self.panel_city:getChildByName("yuanzhang"):removeFromParent()
	end

	if var_79_0 then
		if not RoleDefault:getInstance():getBoolForKey("FirstGameOver") then
			local var_79_1 = ccui.Button:create("roleimage/role1/1.png", nil, "roleimage/role1/1.png")

			var_79_1:setName("yuanzhang")
			var_79_1:setPosition(cc.p(1051, 195))
			var_79_1:setScale(0.5)
			self.panel_city:addChild(var_79_1)

			local var_79_2 = ccui.ImageView:create("public/reddot/plot_remind.png", var_0_24)

			var_79_2:setPosition(cc.p(var_79_1:getContentSize().width / 2 + 50 + 40, var_79_1:getContentSize().height / 2 + 60))
			var_79_2:setName("qipao1")
			var_79_2:setScale(2)
			var_79_1:addChild(var_79_2, 10)
			var_79_1:addTouchEventListener(function(arg_80_0, arg_80_1)
				if arg_80_1 ~= ccui.TouchEventType.ended then
					return
				end

				global_basic_scene:addChild(TalkLayer:create(8200023, nil, TALK_TYPE_TRAVEL, "", function()
					if var_0_9 and self.panel_city:getChildByName("yuanzhang") then
						self.panel_city:getChildByName("yuanzhang"):removeFromParent()
						RoleDefault:getInstance():setBoolForKey("FirstGameOver", true)
					end
				end), ZORDER_TALKLAYER)
			end)
		end
	end
end

function DoubleHoliday_WoldCityLayer.addCityNews(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_1:getChildByName("qipao") then
		arg_82_1:getChildByName("qipao"):removeFromParent()
	end

	if arg_82_2 then
		local var_82_0 = ccui.ImageView:create("public/reddot/plot_remind.png", var_0_24)

		var_82_0:setPosition(cc.p(arg_82_1:getContentSize().width / 2 + 50 + 40, arg_82_1:getContentSize().height / 2 + 40))
		var_82_0:setName("qipao")
		arg_82_1:addChild(var_82_0, 10)
	end
end

function DoubleHoliday_WoldCityLayer:createTimeLable()
	local var_83_0 = ccui.ImageView:create("Activity_doubleholiday/time_end.png", var_0_24)

	var_83_0:setPosition(cc.p(self.btn_broadcast:getPositionX(), self.btn_broadcast:getPositionY() - self.btn_broadcast:getContentSize().height / 2 - 30))
	self.panel_mr:addChild(var_83_0, 10)

	local var_83_1 = cc.Label:createWithTTF("", "fonts/name.ttf", 18)

	var_83_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_83_1:setPosition(cc.p(var_83_0:getContentSize().width / 2, var_83_0:getContentSize().height / 2))
	var_83_0:addChild(var_83_1)

	self.surplusTime = var_83_1
end

function DoubleHoliday_WoldCityLayer:updateTime()
	local var_84_5 = global_get_time_by_date((activity_plague_other_data.step1_finishtime or nil) and (activity_plague_other_data.step1_finishtime.rule or "2020-1-7 23:59:59")) - var_0_6:getCurTime()

	if var_84_5 < 0 then
		self.surplusTime:setVisible(false)

		self.istimeover = true

		LayerManager:switchShowLayer("DoubleHoliday_WoldCityLayer_2")
	end

	local var_84_6 = math.floor(var_84_5 / 24 / 3600)
	local var_84_7 = math.floor((var_84_5 - var_84_6 * 24 * 3600) / 3600)
	local var_84_8 = math.floor((var_84_5 - var_84_6 * 24 * 3600 - var_84_7 * 3600) / 60)

	self.surplusTime:setString(L_LEFT_TIME_SPACE .. (var_84_6 ~= 0 and string.format(L_TIME_TEXT[1], var_84_6, var_84_7) or var_84_7 ~= 0 and string.format(L_TIME_TEXT[2], var_84_7, var_84_8) or string.format(L_TIME_TEXT[3], var_84_8)))
end

function DoubleHoliday_WoldCityLayer:registerTimeCheckEvent()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("timeCheckManagerEvent", function(arg_86_0)
		if arg_86_0.eventType == NEXT_DAY then
			playermodel:getServerTime(function()
				self:updateTime()
			end)
		end
	end), self)
end
