PopDailyRechargeLayer = class("PopDailyRechargeLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_calendar_data = require("data.activity_calendar_data")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")

function PopDailyRechargeLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopDailyRechargeLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopDailyRechargeLayer:init(arg_3_1)
	print("open poplayer : PopDailyRechargeLayer")

	self.layerName = "PopDailyRechargeLayer_" .. arg_3_1.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	self.activityId = arg_3_1.activityId

	self:initUI()
	self:updateDataFormSever()
	self:registerActivityEventListener()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

function PopDailyRechargeLayer:registerActivityEventListener()
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("purchase_success", function(arg_6_0)
		self:updateDataFormSever()
	end), self)
end

function PopDailyRechargeLayer:initUI()
	self:initExitTouchEvent()
	self:initBtns()
	self:playJoinInEffect()
end

function PopDailyRechargeLayer:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_9_0:isBright() then
			return
		end

		arg_9_0:setBright(false)
		self:exit()
	end)

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setTouchEnabled(true)
	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
end

function PopDailyRechargeLayer:initBtns()
	self.bg:getChildByName("back"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_11_0:isBright() then
			return
		end

		arg_11_0:setBright(false)
		self:exit()
	end)

	self.preBg = self.bg:getChildByName("pre_bg")
	self.pre = self.preBg:getChildByName("pre")
	self.maskDaily = self.bg:getChildByName("mask_daily")
	self.maskWeek = self.bg:getChildByName("mask_week")
	self.maskDailyGot = self.bg:getChildByName("mask_daily_got")
	self.points = {}

	for iter_10_0 = 1, 10 do
		local var_10_0 = self.preBg:getChildByName("point_" .. iter_10_0)

		if var_10_0 then
			self.points[iter_10_0] = var_10_0
		else
			break
		end
	end

	self.dailySpine = L2Skeleton:create(UI_SPINE_PATH .. "daily_recharge/skeleton.json", UI_SPINE_PATH .. "daily_recharge/skeleton.atlas")

	self.dailySpine:refreshSkeleton()
	self.dailySpine.skeletonAnimation:setPositionX(self.maskDaily:getPositionX())
	self.dailySpine.skeletonAnimation:setPositionY(self.maskDaily:getPositionY() - 30)
	self.dailySpine:setName("dailySpine")
	self.dailySpine:play("animation", true)
	self.dailySpine:setVisible(false)
	self.bg:addChild(self.dailySpine, 10000)

	self.weekSpine = L2Skeleton:create(UI_SPINE_PATH .. "daily_recharge/skeleton.json", UI_SPINE_PATH .. "daily_recharge/skeleton.atlas")

	self.weekSpine:refreshSkeleton()
	self.weekSpine.skeletonAnimation:setPositionX(self.maskWeek:getPositionX())
	self.weekSpine.skeletonAnimation:setPositionY(self.maskWeek:getPositionY() - 30)
	self.weekSpine:setName("weekSpine")
	self.weekSpine:play("animation", true)
	self.weekSpine:setVisible(false)
	self.bg:addChild(self.weekSpine, 10000)

	self.btnSure = self.bg:getChildByName("btn_sure")
	self.sureLbl = self.btnSure:getChildByName("label")

	self.btnSure:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = 160
		})
	end)
end

function PopDailyRechargeLayer:updateDataFormSever()
	activity_manager:getActivityTaskList(self.activityId, nil, function(arg_14_0, arg_14_1)
		print(dump(arg_14_1))
		self:updateDailyUI(arg_14_0, arg_14_1)
	end, false, nil, "daily_recharge", "total_recharge")
	activity_manager:getActivityTaskList(self.activityId, nil, function(arg_15_0, arg_15_1)
		print(dump(arg_15_1))
		self:updateDayUI(arg_15_0, arg_15_1)
	end, false, "recharge_day", "recharge_day", nil)
end

function PopDailyRechargeLayer:updateDailyUI(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.list[1]

	self.btnSure:addTouchEventListener(function(arg_17_0, arg_17_1)
		if arg_17_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not self.weeklyData then
			return
		end

		if var_16_0.status < 1 and var_16_0.need <= var_16_0.finished then
			activity_manager:getTaskReward(self.activityId, var_16_0.taskid, function(arg_18_0, arg_18_1)
				if arg_18_0 == 1 then
					global_gain(arg_18_1)
					self:updateDataFormSever()
					activity_manager:updateActivityAlert("daily_recharge", self.activityId, false)
				end
			end)
		elseif self.activityId == 550 then
			goto_complete_system({
				jump_to_system = 1755001
			})
		else
			goto_complete_system({
				jump_to_system = 160
			})
		end

		if self.weeklyData.status < 1 and self.weeklyData.need <= self.weeklyData.finished then
			activity_manager:getTaskReward(self.activityId, self.weeklyData.taskid, function(arg_19_0, arg_19_1)
				if arg_19_0 == 1 then
					global_gain(arg_19_1)
					self:updateDataFormSever()
				end
			end)
		end
	end)

	if arg_16_2.list[1].status >= 1 then
		self.maskDaily:setVisible(true)
		self.maskDailyGot:setVisible(true)
		self.dailySpine:setVisible(false)
		self.sureLbl:setString(L_GO_BUY_DIAMOND.button)
		self.btnSure:loadTextures(self.layerName .. "/btn_blue.png", nil, self.layerName .. "/btn_blue.png", var_0_0)
	elseif arg_16_2.list[1].need <= arg_16_2.list[1].finished then
		self.maskDaily:setVisible(false)
		self.maskDailyGot:setVisible(false)
		self.dailySpine:setVisible(true)
		self.sureLbl:setString(L_SWIM_WEEK_RECORE[2])
		self.btnSure:loadTextures(self.layerName .. "/btn_yellow.png", nil, self.layerName .. "/btn_yellow.png", var_0_0)
	else
		self.maskDaily:setVisible(true)
		self.maskDailyGot:setVisible(false)
		self.dailySpine:setVisible(false)
		self.sureLbl:setString(L_GO_BUY_DIAMOND.button)
		self.btnSure:loadTextures(self.layerName .. "/btn_blue.png", nil, self.layerName .. "/btn_blue.png", var_0_0)
	end
end

function PopDailyRechargeLayer:updateDayUI(arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.list[1]

	self.weeklyData = arg_20_2.list[1]

	if var_20_0.status < 1 and var_20_0.need <= var_20_0.finished then
		self.maskWeek:setVisible(false)
		self.weekSpine:setVisible(false)
	else
		self.maskWeek:setVisible(true)
		self.weekSpine:setVisible(false)
	end

	for iter_20_0 = 1, #self.points do
		print(self.points)

		if iter_20_0 / #self.points <= var_20_0.finished / var_20_0.need then
			self.points[iter_20_0]:loadTexture(self.layerName .. "/point_on.png", var_0_0)
		else
			self.points[iter_20_0]:loadTexture(self.layerName .. "/point_off.png", var_0_0)
		end
	end

	self.pre:setScaleX(({
		0,
		0.16,
		0.33,
		0.5,
		0.66,
		0.82,
		1
	})[var_20_0.finished] or 0)
end

function PopDailyRechargeLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopDailyRechargeLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopDailyRechargeLayer:initBg(arg_24_1)
	local var_24_0 = ccui.Layout:create()

	var_24_0:setTouchEnabled(true)
	var_24_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_24_0:setAnchorPoint(cc.p(0, 0))
	var_24_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_24_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_24_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_24_0:setOpacity(0)
	self:addChild(var_24_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_25_0)
		self:addChild(arg_25_0, -2)
		arg_25_0:setPositionY(arg_25_0:getPositionY() - GameDisplay.fix_y)

		local var_25_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_25_0:setAnchorPoint(cc.p(0, 0))
		var_25_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_25_0, -1)
		self:init(arg_24_1)
		var_24_0:setOpacity(102)
		var_24_0:setTouchEnabled(false)
	end)
end
