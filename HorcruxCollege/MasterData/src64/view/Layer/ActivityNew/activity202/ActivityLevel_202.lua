ActivityLevel_202 = class("ActivityLevel_202", function()
	return cc.Layer:create()
end)

local var_0_4 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local levelmode_data = require("data.levelmode_data")
local activity_main_conf = require("data.activity_modules.activity_main_conf")

function ActivityLevel_202.create(arg_2_0, arg_2_1)
	local var_2_0 = ActivityLevel_202.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function ActivityLevel_202:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "ActivityLevel_202.json" or "ActivityLevel_202.ExportJson")

	self:addChild(self.rootLayer)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:get_activity_level_info(202)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			activity_manager:releaseEventListenerByName("ActivityLevel_202")
		end
	end)
end

function ActivityLevel_202.registerActivityEventListener(arg_5_0)
	activity_manager:registerEventListener("ActivityLevel_202", activity_manager.activityEventId.ACTIVITY_LEVEL_INFO_UPDATE, function(arg_6_0)
		arg_5_0:upDateUI(arg_6_0)
	end)
end

function ActivityLevel_202:initUI()
	self:initBtnReturn()
	self:initTitle()
	self:initPanelBook()
	self:initPanelBuff()
end

function ActivityLevel_202:initBtnReturn()
	self.returnPanel = self.rootLayer:getChildByName("return_bg")
	self.btnReturn = self.returnPanel:getChildByName("btn_return")

	self.btnReturn:setAnchorPoint(cc.p(0.5, 0))
	self.btnReturn:setPositionY(-GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.returnPanel:setPositionY(self.returnPanel:getPositionY() - GameDisplay.fix_y)
	self.btnReturn:setPositionY(0)

	self.lblFightNum = self.returnPanel:getChildByName("lbl_num")

	local var_8_0 = ccui.ImageView:create("public/button/add8_new.png", var_0_4)

	var_8_0:setPosition(cc.p(610, 40))
	var_8_0:setScale(0.65)
	self.returnPanel:addChild(var_8_0)
	var_8_0:setTouchEnabled(true)
	var_8_0:addTouchEventListener(function(arg_10_0, arg_10_1)
		local var_10_1
		local var_10_0

		if arg_10_1 ~= ccui.TouchEventType.ended then
			do return end

			var_10_0 = {
				surecallback = function()
					activity_manager:add_activity_level_time(202)
				end
			}
			var_10_1 = {
				titleNewImage = "public/title/title_exchange.png",
				button = L_BUTTON_TEXT.Sure
			}
		end

		var_10_1.des = string.format(L_ACTIVITY_ADV_2, (activity_manager:get_activity_level_buy_time_cost(202)))
		var_10_0.labels = var_10_1

		LayerManager:pushInLayer("PopDoLayer", var_10_0)
	end)
end

function ActivityLevel_202:initTitle()
	self.btnDetail = self.rootLayer:getChildByName("title")

	self.btnDetail:setTouchEnabled(true)
	self.btnDetail:setPositionY(self.btnDetail:getPositionY() + GameDisplay.fix_y)
	self.btnDetail:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = "ActivityLevel_202"
		})
	end)
end

function ActivityLevel_202.initPanelBook(arg_14_0)
	return
end

function ActivityLevel_202:initPanelBuff()
	local var_15_0 = self.rootLayer:getChildByName("buff")

	var_15_0:setPositionY(var_15_0:getPositionY() + GameDisplay.fix_y)

	self.buff1 = var_15_0:getChildByName("buff_1")
	self.buff2 = var_15_0:getChildByName("buff_2")

	self.buff1:setString(L_ACTIVITY_LEVEL_BUFF)
	self.buff2:setString("")
	var_15_0:setTouchEnabled(true)
	var_15_0:addTouchEventListener(function(arg_16_0, arg_16_1)
		if arg_16_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSubScoreUpLayer", {
			activityid = 202,
			uplist = {
				{
					servantid = 27620
				},
				{
					servantid = 27720
				},
				{
					servantid = 27820
				}
			}
		})
	end)
end

function ActivityLevel_202:upDateUI(arg_17_1)
	self.lblFightNum:setString(L_ACTIVITY_LEVEL_NUM .. arg_17_1.less_fight .. "/10")
	self.lblFightNum:setFontSize(26)

	for iter_17_0 = 1, 5 do
		local var_17_0 = self.rootLayer:getChildByName("Button_" .. iter_17_0)
		local var_17_1 = var_17_0:getChildByName("level")

		if iter_17_0 > arg_17_1.cur_level then
			var_17_0:loadTextures("ActivityLevel_202/level_lock.png", nil, "ActivityLevel_202/level_lock.png", var_0_4)
			var_17_1:setColor(cc.c3b(64, 65, 67))
		else
			var_17_0:loadTextures("ActivityLevel_202/level.png", nil, "ActivityLevel_202/level.png", var_0_4)
			var_17_1:setColor(cc.c3b(90, 108, 246))
		end

		var_17_0:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			if arg_17_1.less_fight <= 0 then
				global_ShowBlockWords(L_ARENA_WARNING.Begin_Fight[3])

				return
			end

			if iter_17_0 > arg_17_1.cur_level then
				return
			end

			local var_18_0 = {
				data = levelmode_data[arg_17_1.cur_mode],
				times = arg_17_1.less_fight,
				showlevel = iter_17_0,
				show_time = iter_17_0 == arg_17_1.cur_level
			}

			RoleDefault:getInstance():setIntegerForKey("AdventureEnterIndex", 2020)
			LayerManager:pushInLayer("AdventureNewDetailLayer", var_18_0)
		end)
	end
end
