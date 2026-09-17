ActivityArtBaseLayer = class("ActivityArtBaseLayer", function()
	return cc.Layer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local item_data = require("data.item_data")
local l2utils = require("controller.l2utils")

local function var_0_7(arg_2_0)
	if arg_2_0 >= 86400 then
		return string.format(L_TIME_TEXT[1], math.floor(arg_2_0 / 86400), math.floor(arg_2_0 % 86400 / 3600))
	elseif arg_2_0 >= 3600 then
		return string.format(L_TIME_TEXT[2], math.floor(arg_2_0 / 3600), math.floor(arg_2_0 % 3600 / 60))
	else
		return string.format(L_TIME_TEXT[3], math.floor(arg_2_0 / 60), math.floor(arg_2_0 % 60))
	end
end

function ActivityArtBaseLayer.create(arg_3_0, arg_3_1)
	local var_3_0 = ActivityArtBaseLayer.new()

	var_3_0:init(arg_3_1)

	return var_3_0
end

function ActivityArtBaseLayer:init(arg_4_1)
	if arg_4_1 then
		self.activityId = arg_4_1.activityid or 208
	end

	self._imagePath = "ActivityArt_" .. self.activityId

	TextureManager:loadLayerTextures({
		self._imagePath
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self._imagePath .. ".json" or self._imagePath .. ".ExportJson"))

	self:addChild(self.rootLayer)

	self.bg = ccui.ImageView:create("mainScenebg/activity/branch" .. self.activityId .. "/art.png")

	self.bg:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2 - GameDisplay.fix_y)
	self:addChild(self.bg, -1)
	self:initUI()
	self:registerActivityEventListener()
	activity_manager:getArtInfo(self.activityId)
	self:registerScriptHandler(function(arg_5_0)
		if arg_5_0 == "exit" then
			if self.activityScheduler then
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end

			TextureManager:removeLayerTextures({
				self._imagePath
			})
			activity_manager:releaseEventListenerByName(self._imagePath)
		end
	end)
end

function ActivityArtBaseLayer:registerActivityEventListener()
	activity_manager:registerEventListener(self._imagePath, activity_manager.activityEventId.ART_INFO_UPDATE, function(arg_7_0)
		self:updateUI(arg_7_0)
		self:updateUIAlert()
	end)
end

function ActivityArtBaseLayer:initUI()
	self:initBottomList()
	self:playJoinAni()
end

function ActivityArtBaseLayer:initBottomList()
	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return")

	self.btnReturn:setTouchEnabled(true)
	self.btnReturn:setPositionY(self.btnReturn:getPositionY() - GameDisplay.fix_y)
	self.btnReturn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:playOutAni(function()
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end)

	self.btnDraw = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_draw")

	self.btnDraw:setPositionY(self.btnDraw:getPositionY() - GameDisplay.fix_y * 0.5)
	self.btnDraw:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if activity_manager:isArtFinished(self.activityId) then
			global_ShowBlockWords(L_ACTIVITY_ART_CHOOSE[3])

			return
		end

		if activity_manager:getArtItemNumber(self.activityId) <= 0 then
			LayerManager:pushInLayer("PopArtTaskLayer", {
				activityId = self.activityId
			})

			return
		end

		activity_manager:activityArtDraw(self.activityId)
	end)

	self.btnDetial = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_detail")

	self.btnDetial:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self._imagePath
		})
	end)

	self.btnTitle = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_title")

	self.btnTitle:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopActivityDetail", {
			key = self._imagePath
		})
	end)

	self.btnItem = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_item")

	self.btnItem:setPositionY(self.btnItem:getPositionY() - GameDisplay.fix_y * 0.5)
	self.btnItem:addTouchEventListener(function(arg_15_0, arg_15_1)
		if arg_15_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:pushInLayer("PopArtTaskLayer", {
			activityId = self.activityId
		})
	end)

	self.lblItemNum = self.btnItem:getChildByName("lbl_item_num")

	self.lblItemNum:setString("X" .. activity_manager:getArtItemNumber(self.activityId))

	self.timeLbl = ccui.Helper:seekWidgetByName(self.rootLayer, "lbl_time")

	local var_9_0 = activity_manager:getArtEndTime(self.activityId)

	if not var_9_0 or var_9_0 == 0 then
		self.timeLbl:setString(0)
	else
		self.activityScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(var_9_0, function(arg_16_0)
			self.timeLbl:setString(var_0_7(arg_16_0))

			if arg_16_0 <= 0 and self.activityScheduler then
				LayerManager:switchShowLayer("MainLayer")
				time_check_manager:removeUpdatePool(self.activityScheduler)

				self.activityScheduler = nil
			end
		end)))
	end
end

function ActivityArtBaseLayer:playJoinAni()
	self.btnReturn:setPositionX(self.btnReturn:getPositionX() + 600)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.4, cc.p(-610, 0)), cc.MoveBy:create(0.05, cc.p(10, 0))))
	self.btnDraw:setPositionX(self.btnDraw:getPositionX() + 200)
	self.btnDraw:runAction(cc.Sequence:create(cc.EaseExponentialIn:create(cc.MoveBy:create(0.5, cc.p(-200, 0)))))
end

function ActivityArtBaseLayer:updateUI(arg_18_1)
	self:updateUseItems(arg_18_1)
	self:updatePlayerPanel(arg_18_1)
end

function ActivityArtBaseLayer:updateUseItems()
	self.lblItemNum:setString("X" .. activity_manager:getArtItemNumber(self.activityId))
end

function ActivityArtBaseLayer:updatePlayerPanel(arg_20_1)
	local var_20_0 = self.rootLayer:getChildByName("art_bg")
	local var_20_1 = 1
	local var_20_2 = var_20_0:getChildByName("icon_" .. 1)

	while var_20_2 do
		if var_20_1 > arg_20_1.stat then
			var_20_2:loadTexture(string.format("%s/%d.png", self._imagePath, var_20_1), var_0_0)
		else
			var_20_2:loadTexture(string.format("%s/%d_on.png", self._imagePath, var_20_1), var_0_0)
		end

		var_20_1 = var_20_1 + 1
		var_20_2 = var_20_0:getChildByName("icon_" .. var_20_1)
	end
end

function ActivityArtBaseLayer:updateUIAlert()
	local var_21_0 = self.rootLayer:getChildByName("btn_draw")

	if not activity_manager:isArtFinished(self.activityId) and activity_manager:isArtNeedAlert(self.activityId) then
		self:add_alert_tag(var_21_0, {
			x = var_21_0:getContentSize().width - 10,
			y = var_21_0:getContentSize().height - 10
		})
	else
		self:remove_alert_tag(var_21_0, pos)
	end

	local var_21_1 = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_item")

	if not activity_manager:isArtFinished(self.activityId) and activity_manager:getAlertStatus(self.activityId, "art") then
		self:add_alert_tag(var_21_1, {
			x = var_21_1:getContentSize().width - 10,
			y = var_21_1:getContentSize().height - 10
		})
	else
		self:remove_alert_tag(var_21_1, pos)
	end
end

function ActivityArtBaseLayer:playOutAni(arg_22_1)
	self.btnReturn:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(50, 0)), cc.MoveBy:create(0.05, cc.p(-250, 0)), cc.CallFunc:create(function()
		if arg_22_1 then
			arg_22_1()
		end

		self.isShowEffect = nil
	end)))
	self.btnDraw:runAction(cc.Sequence:create(cc.MoveBy:create(0.2, cc.p(0, -200))))
end

function ActivityArtBaseLayer.add_alert_tag(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if not arg_24_1 then
		return
	end

	if arg_24_1:getChildByName("reddot") then
		arg_24_1:getChildByName("reddot"):setVisible(true)

		return
	end

	local var_24_0 = arg_24_3 or 999
	local var_24_1 = arg_24_2 or {
		x = arg_24_1:getContentSize().width,
		y = arg_24_1:getContentSize().height
	}
	local var_24_2 = ccui.ImageView:create("public/reddot/reddot2.png", var_0_0)

	var_24_2:setName("reddot")
	var_24_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_24_2:setPosition(cc.p(var_24_1.x, var_24_1.y))
	arg_24_1:addChild(var_24_2, var_24_0)
end

function ActivityArtBaseLayer.remove_alert_tag(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if not arg_25_1 then
		return
	end

	if arg_25_1:getChildByName("reddot") then
		arg_25_1:getChildByName("reddot"):setVisible(false)
	end
end
