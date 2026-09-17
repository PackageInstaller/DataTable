SchoolSwimLayer = class("SchoolSwimLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local school_swim_manager = require("controller.school_swim_manager")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local theater_director = require("controller.theater_director")
local model_data = require("data.model_data")
local var_0_6 = 4
local var_0_9 = 1
local var_0_10 = 6400
local var_0_11 = 10000
local var_0_15 = "SchoolSwimLayer/pool_up_img.png"
local var_0_16 = "SchoolSwimLayer/pool_lower_img.png"

function SchoolSwimLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = SchoolSwimLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function SchoolSwimLayer:init(arg_3_1)
	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "SchoolSwimLayer.json" or "SchoolSwimLayer.ExportJson")

	self:addChild(self.rootLayer)

	self.initconfig = arg_3_1 or {}
	self.swimId = self.initconfig.swimId

	self:initUI()
	self:fullScreen()
	self:initShowSwimData()
	self:showCountdownEffect(function()
		self:showCompetitionProceed()
	end)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" and self.poolSchdule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.poolSchdule)

			self.poolSchdule = nil
		end
	end)
end

function SchoolSwimLayer:initUI()
	self:initPoolsUI()
	self:initBottomList()
end

function SchoolSwimLayer:initPoolsUI()
	self.pools = {}
	self.imgPoolUps = {
		{},
		{},
		{},
		{}
	}
	self.imgPoolLowers = {
		{},
		{},
		{},
		{}
	}
	self.panls = {}

	for iter_7_0 = 1, var_0_6 do
		local var_7_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. iter_7_0)

		for iter_7_1 = 1, 2 do
			local var_7_1 = var_7_0:getChildByName("img_pool_up_" .. iter_7_1)
			local var_7_2 = var_7_0:getChildByName("img_pool_lower_" .. iter_7_1)

			var_7_1:setPositionX(320 + 640 * (iter_7_1 - 1))
			var_7_1:loadTexture(var_0_15, var_0_0)
			var_7_2:setPositionX(320 + 640 * (iter_7_1 - 1))
			var_7_2:loadTexture(var_0_16, var_0_0)

			self.pools[iter_7_0] = var_7_0
			self.imgPoolUps[iter_7_0][iter_7_1] = var_7_1
			self.imgPoolLowers[iter_7_0][iter_7_1] = var_7_2
		end

		local var_7_3 = ccui.Layout:create()

		var_7_3:setContentSize(cc.size(var_0_10, var_7_0:getContentSize().height))
		var_7_3:setAnchorPoint(cc.p(0, 0))
		var_7_3:setPosition(cc.p(0, 0))
		var_7_3:setName("panl")
		var_7_0:addChild(var_7_3, 0)

		for iter_7_2 = 1, 5 do
			local var_7_4 = ccui.ImageView:create("SchoolSwimLayer/distance_other_bg.png", var_0_0)

			if iter_7_2 == 1 then
				var_7_4:setPosition(cc.p(var_0_10 / 5 + 260, 160))
			elseif iter_7_2 == 5 then
				var_7_4:setPosition(cc.p(var_0_10 + 520, 160))
			else
				var_7_4:setPosition(cc.p(var_0_10 / 5 * iter_7_2 + 260, 160))
			end

			var_7_3:addChild(var_7_4)

			local var_7_5 = cc.Label:createWithTTF(20 * iter_7_2, FONT_NAME, 18)
			local var_7_6 = cc.Label:createWithTTF("m", FONT_NAME, 19)

			var_7_5:setPosition(cc.p(var_7_4:getContentSize().width / 2, var_7_4:getContentSize().height / 2 + 8))
			var_7_6:setPosition(cc.p(var_7_4:getContentSize().width / 2, var_7_4:getContentSize().height / 2 - 8))
			var_7_4:addChild(var_7_5)
			var_7_4:addChild(var_7_6)

			if iter_7_2 == 5 then
				var_7_5:setString("终")
				var_7_6:setString("点")
				var_7_4:loadTexture("SchoolSwimLayer/distance_end_bg.png", var_0_0)
			end
		end

		self.panls[iter_7_0] = var_7_3
	end
end

function SchoolSwimLayer:initBottomList()
	self.bottomList = BottomBtnList:create(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end, {
		{
			name = "support",
			word = "应 援",
			handler = function(arg_10_0, arg_10_1)
				if arg_10_1 ~= ccui.TouchEventType.ended then
					return
				end

				LayerManager:pushInLayer("PopSchoolSwimResultLayer")
			end
		}
	})

	self.bottomList:setName("bottomlist")
	self.rootLayer:addChild(self.bottomList, 1000)

	local var_8_0 = ccui.ImageView:create("GirlSelectLayer/infoBtn.png", var_0_0)

	var_8_0:setPositionX(180)
	var_8_0:setPositionY(self.bottomList:getContentSize().height / 2)
	var_8_0:setTouchEnabled(true)
	var_8_0:setName("tips_btn")
	self.bottomList:addChild(var_8_0, 100)
	var_8_0:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopSchoolSwimExplainLayer")
	end)
	self.bottomList:getChildByName("support"):setVisible(false)
	self.bottomList:getChildByName("tips_btn"):setVisible(false)
end

function SchoolSwimLayer:initShowSwimData()
	self.swimData = school_swim_manager:getSwimDataById(self.swimId)
end

local function var_0_18(arg_13_0)
	local var_13_0 = {}

	var_13_0.time = 1000

	for iter_13_0 = 1, #arg_13_0 do
		if arg_13_0[iter_13_0].proceed.time < var_13_0.time then
			var_13_0.key = iter_13_0
			var_13_0.time = arg_13_0[iter_13_0].proceed.time
		end
	end

	return var_13_0.key
end

local function var_0_19(arg_14_0, arg_14_1)
	local swim_node_data = require("data.summer.swim_node_data")
	local var_14_1 = arg_14_0.start_speed or 500
	local var_14_2 = 1

	while arg_14_0["buff" .. var_14_2] do
		if arg_14_1 < arg_14_0["value" .. var_14_2] then
			return var_14_1
		end

		if arg_14_1 <= arg_14_0["value" .. var_14_2] + (var_14_1 + swim_node_data[arg_14_0["buff" .. var_14_2]].speed_add) * swim_node_data[arg_14_0["buff" .. var_14_2]].time then
			return swim_node_data[arg_14_0["buff" .. var_14_2]].speed_add + var_14_1
		end

		var_14_2 = var_14_2 + 1
	end

	return var_14_1
end

function SchoolSwimLayer:showCompetitionProceed()
	self.poolSchdules = {}
	self.poolMoved = 0

	local var_15_0 = self.swimData.record
	local var_15_1 = self.swimData.record[self.swimData.vote or var_0_18(self.swimData.record)].proceed

	self.poolSchdule = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_16_0)
		local var_16_0 = var_0_19(var_15_1, self.poolMoved)

		for iter_16_0, iter_16_1 in pairs(var_15_0) do
			self.panls[iter_16_0]:setPositionX(self.panls[iter_16_0]:getPositionX() - arg_16_0 * var_16_0 * var_0_10 / var_0_11)

			for iter_16_2 = 1, 2 do
				self.imgPoolUps[iter_16_0][iter_16_2]:setPositionX(self.imgPoolUps[iter_16_0][iter_16_2]:getPositionX() - arg_16_0 * var_16_0 * var_0_10 / var_0_11)
				self.imgPoolLowers[iter_16_0][iter_16_2]:setPositionX(self.imgPoolLowers[iter_16_0][iter_16_2]:getPositionX() - arg_16_0 * var_16_0 * var_0_10 / var_0_11 * var_0_9)

				if self.imgPoolUps[iter_16_0][iter_16_2]:getPositionX() < -320 then
					self.imgPoolUps[iter_16_0][iter_16_2]:setPositionX(((iter_16_2 == 1 or nil) and self.imgPoolUps[iter_16_0][2]:getPositionX()) + self.imgPoolUps[iter_16_0][2]:getContentSize().width - 15)
				end

				if self.imgPoolLowers[iter_16_0][iter_16_2]:getPositionX() < -320 then
					self.imgPoolLowers[iter_16_0][iter_16_2]:setPositionX(((iter_16_2 == 1 or nil) and self.imgPoolLowers[iter_16_0][2]:getPositionX()) + self.imgPoolLowers[iter_16_0][2]:getContentSize().width - 15)
				end
			end
		end

		self.poolMoved = self.poolMoved + arg_16_0 * var_16_0

		if self.poolMoved > 10000 and self.poolSchdule then
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.poolSchdule)

			self.poolSchdule = nil
		end
	end, 0, false)

	for iter_15_0, iter_15_1 in pairs(self.swimData.record) do
		self.actors[iter_15_0]:startSwim(var_15_1, iter_15_1.proceed, var_0_11, function()
			self:addRankSignAtPool(iter_15_0, iter_15_1.proceed.rank, iter_15_1.model)
		end)
	end
end

function SchoolSwimLayer:showCountdownEffect(arg_18_1)
	self.isShowCompetition = true
	self.actors = {}

	for iter_18_0, iter_18_1 in pairs(self.swimData.record) do
		local var_18_0 = ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. iter_18_0)
		local var_18_1 = var_18_0:getChildByName("swimer_parent")
		local var_18_2 = school_swim_manager:craeteCompetitionSwimer(iter_18_1.model)

		var_18_2:playAni(nil, "caishui", true)

		var_18_2.model = iter_18_1.model

		var_18_1:addChild(var_18_2)
		var_18_1:setLocalZOrder(99)

		self.actors[iter_18_0] = var_18_2

		if self.swimData.vote and self.swimData.vote == iter_18_0 then
			local var_18_3 = var_18_0:getChildByName("img_pool_up_1")
			local var_18_4 = ccui.ImageView:create("SchoolSwimLayer/support_img.png", var_0_0)

			var_18_4:setName("support_img")
			var_18_4:setPosition(cc.p(550, 230))
			var_18_3:addChild(var_18_4, 100)
			var_18_4:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
				if var_18_4:getPositionX() + var_18_4:getParent():getPositionX() <= 275 then
					var_18_4:stopAllActions()
					var_18_4:removeFromParent()
				end
			end), cc.DelayTime:create(0.1))))
		end
	end

	local var_18_5 = ccui.Layout:create()

	var_18_5:setTouchEnabled(true)
	var_18_5:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_18_5:setAnchorPoint(cc.p(0, 0))
	var_18_5:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_18_5:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_18_5:setBackGroundColor(cc.c3b(0, 0, 0))
	var_18_5:setOpacity(150)
	var_18_5:setCascadeOpacityEnabled(false)
	self.rootLayer:addChild(var_18_5)

	local var_18_6 = 4
	local var_18_7 = cc.Label:createWithTTF("", FONT_NAME, 100)

	var_18_7:setColor(cc.c3b(246, 202, 69))
	var_18_7:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2))
	var_18_5:addChild(var_18_7)
	var_18_7:setString(4)
	var_18_7:setOpacity(0)
	var_18_7:setScale(4)
	self:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		var_18_7:runAction(cc.Sequence:create(cc.Spawn:create(cc.ScaleTo:create(0.4, 1, 1), cc.FadeIn:create(0.4)), cc.Spawn:create(cc.ScaleTo:create(0.6, 0.1, 0.1), cc.FadeOut:create(0.6)), cc.CallFunc:create(function()
			var_18_6 = var_18_6 - 1

			if var_18_6 > 0 then
				var_18_7:setString(var_18_6)
			elseif var_18_6 == 0 then
				var_18_7:setString("Start!")
			else
				var_18_7:stopAllActions()
				self:stopAllActions()
				var_18_5:removeFromParent()

				if arg_18_1 then
					arg_18_1()
				end
			end

			var_18_7:setScale(4)
			var_18_7:setOpacity(0)
		end)))
	end), cc.DelayTime:create(1.1))))
end

function SchoolSwimLayer:addRankSignAtPool(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = ccui.ImageView:create("SchoolSwimLayer/rank_sign_bg.png", var_0_0)

	var_22_0:setAnchorPoint(cc.p(1, 0.5))
	var_22_0:setPosition(cc.p(500, 100))
	var_22_0:setName("rank_sign_bg_" .. arg_22_1)
	ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. arg_22_1):addChild(var_22_0)

	local var_22_1 = cc.Label:createWithTTF(model_data[arg_22_3].small_english_name or model_data[arg_22_3].name_Q, FONT_TITLE, 36)

	var_22_1:setPosition(cc.p(130, var_22_0:getContentSize().height / 2))
	var_22_0:addChild(var_22_1)

	local var_22_2 = ccui.ImageView:create("SchoolSwimLayer/rank_" .. arg_22_2 .. ".png", var_0_0)

	var_22_2:setPosition(cc.p(275, var_22_0:getContentSize().height / 2))
	var_22_0:addChild(var_22_2)
	var_22_0:setScaleX(0.1)
	var_22_0:runAction(cc.Sequence:create(cc.ScaleTo:create(0.5, 1, 1)))
end

function SchoolSwimLayer:fullScreen()
	ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. 4):setPositionY(-GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. 3):setPositionY(334 / 2 * 3 - (334 * 4 - GameDisplay.height) / 3 - GameDisplay.fix_y)
	ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. 2):setPositionY(GameDisplay.height - 334 / 2 * 3 + (334 * 4 - GameDisplay.height) / 3 - GameDisplay.fix_y + 10)
	ccui.Helper:seekWidgetByName(self.rootLayer, "pool_" .. 1):setPositionY(GameDisplay.height - GameDisplay.fix_y)
	self.bottomList:setPositionY(self.bottomList:getPositionY() - GameDisplay.fix_y)
end
