PopSkinGetLayer_286 = class("PopSkinGetLayer_286", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1
local activity_calendar_data = require("data.activity_calendar_data")
local time_check_manager = require("controller.time_check_manager")
local var_0_3 = 1
local var_0_4 = 2

function PopSkinGetLayer_286.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSkinGetLayer_286.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSkinGetLayer_286:init(arg_3_1)
	print("open poplayer : PopSkinGetLayer_286")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopSkinGetLayer_286.json" or "PopSkinGetLayer_286.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(-GameDisplay.fix_y)
	self:addChild(self.rootLayer)

	arg_3_1 = arg_3_1 or {}

	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and arg_3_1.callback then
			arg_3_1.callback()
		end
	end)
end

function PopSkinGetLayer_286:initUI()
	self:initExitTouchEvent()
	self:initSwitchBtn()
	self:initBtns()
	self:playJoinInEffect()
end

function PopSkinGetLayer_286:initExitTouchEvent()
	self.rootLayer:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_7_0:isBright() then
			return
		end

		arg_7_0:setBright(false)
		self:exit()
	end)

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setTouchEnabled(true)
	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
	self.bg:getChildByName("btn_close"):addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_8_0:isBright() then
			return
		end

		arg_8_0:setBright(false)
		self:exit()
	end)
end

local function var_0_5(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or 0.4

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
			iter_9_1:setOpacity(0)
			iter_9_1:setVisible(true)
			iter_9_1:runAction(cc.Sequence:create(cc.DelayTime:create(arg_9_2), cc.FadeIn:create(arg_9_2)))
		end
	else
		for iter_9_2, iter_9_3 in ipairs(arg_9_0) do
			iter_9_3:runAction(cc.Sequence:create(cc.FadeOut:create(arg_9_2), cc.CallFunc:create(function()
				iter_9_3:setVisible(false)
			end)))
		end
	end
end

function PopSkinGetLayer_286:initSwitchBtn()
	self.btnRole = self.bg:getChildByName("role"):getChildByName("btn_role")

	self.btnRole:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showType == var_0_4 then
			return
		end

		self.showType = var_0_4

		var_0_5(self.skinBtns, false)
		var_0_5(self.roleBtns, true)
		self.btnRole:loadTextures("PopSkinGetLayer_286/btn_role_on.png", nil, "PopSkinGetLayer_286/btn_role_on.png", var_0_0)
		self.btnSkin:loadTextures("PopSkinGetLayer_286/btn_skin_off.png", nil, "PopSkinGetLayer_286/btn_skin_off.png", var_0_0)
	end)

	self.btnSkin = self.bg:getChildByName("role"):getChildByName("btn_skin")

	self.btnSkin:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		if self.showType == var_0_3 then
			return
		end

		var_0_5(self.roleBtns, false)
		var_0_5(self.skinBtns, true)

		self.showType = var_0_3

		self.btnSkin:loadTextures("PopSkinGetLayer_286/btn_skin_on.png", nil, "PopSkinGetLayer_286/btn_skin_on.png", var_0_0)
		self.btnRole:loadTextures("PopSkinGetLayer_286/btn_role_off.png", nil, "PopSkinGetLayer_286/btn_role_off.png", var_0_0)
	end)
	self.bg:getChildByName("btn_all"):addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		local alert_manager = require("controller.alert_manager")
		local notice_manager = require("controller.notice_manager")
		local var_14_2 = notice_manager:get_notice_url()

		if not var_14_2 then
			return
		end

		if DeviceManager.platform == "windows" then
			DeviceManager.openURL(var_14_2)
		else
			self:openNoticeWithWebView(var_14_2)
		end

		notice_manager:update_notice_version()
		alert_manager:unregister_alert(ALERT_NEW_NOTICE, true)
	end)
end

function PopSkinGetLayer_286.openNoticeWithWebView(arg_15_0, arg_15_1)
	local var_15_0 = ccui.Layout:create()

	var_15_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_15_0:setTouchEnabled(true)
	var_15_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_15_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_15_0:setBackGroundColorOpacity(150)
	global_basic_scene:addChild(var_15_0, 999)

	local var_15_1 = cc.Sprite:create("mainScenebg/noticebg.jpg")

	var_15_1:setAnchorPoint(cc.p(0.5, 1))
	var_15_1:setPosition(cc.p(GameDisplay.cx, GameDisplay.height))
	var_15_0:addChild(var_15_1)
	var_15_0:runAction(cc.Sequence:create(cc.DelayTime:create(0.1), cc.CallFunc:create(function()
		local var_16_0 = ccexp.WebView:create()

		var_16_0:setVisible(true)
		var_16_0:setScalesPageToFit(true)
		var_16_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height - 50))
		var_16_0:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy - 25))
		var_16_0:loadURL(arg_15_1)
		var_16_0:setOnDidFinishLoading(function(arg_17_0, arg_17_1)
			return
		end)
		var_15_0:addChild(var_16_0, 10)

		local var_16_1 = ccui.Button:create("equipment/closebtn.png", nil, "equipment/closebtn.png")

		var_16_1:setScale(0.5)
		var_16_1:setPosition(cc.p(GameDisplay.width - 40, GameDisplay.height - 25))
		var_15_0:addChild(var_16_1, 100)
		var_16_1:addTouchEventListener(function(arg_18_0, arg_18_1)
			if arg_18_1 ~= ccui.TouchEventType.ended then
				return
			end

			var_15_0:runAction(cc.RemoveSelf:create())
		end)
	end)))
end

function PopSkinGetLayer_286:initBtns()
	self.skinBtns = {}

	local var_19_0 = {
		2500286,
		2000286,
		3900286,
		1728607
	}

	for iter_19_0 = 1, 4 do
		local var_19_1 = self.bg:getChildByName("skin_" .. iter_19_0)

		var_19_1:addTouchEventListener(function(arg_20_0, arg_20_1)
			if arg_20_1 ~= ccui.TouchEventType.ended then
				return
			end

			goto_complete_system({
				jump_to_system = var_19_0[iter_19_0]
			})
			AnalyticManager.activityJumpTo({
				activityid = 286,
				module = var_19_0[iter_19_0]
			})
		end)

		self.skinBtns[iter_19_0] = var_19_1
	end

	self.roleBtns = {}

	local var_19_2 = {
		3900286,
		2000286,
		2500286,
		4004286
	}

	for iter_19_1 = 1, 4 do
		local var_19_3 = self.bg:getChildByName("role_" .. iter_19_1)

		var_19_3:setOpacity(0)
		var_19_3:setVisible(false)
		var_19_3:addTouchEventListener(function(arg_21_0, arg_21_1)
			if arg_21_1 ~= ccui.TouchEventType.ended then
				return
			end

			goto_complete_system({
				jump_to_system = var_19_2[iter_19_1]
			})
			AnalyticManager.activityJumpTo({
				activityid = 286,
				module = var_19_2[iter_19_1]
			})
		end)

		self.roleBtns[iter_19_1] = var_19_3
	end

	self.showType = var_0_4

	var_0_5(self.skinBtns, false, 0)
	var_0_5(self.roleBtns, true, 0)
end

function PopSkinGetLayer_286:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopSkinGetLayer_286:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSkinGetLayer_286:initBg(arg_25_1)
	local var_25_0 = ccui.Layout:create()

	var_25_0:setTouchEnabled(true)
	var_25_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_25_0:setAnchorPoint(cc.p(0, 0))
	var_25_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_25_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_25_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_25_0:setOpacity(0)
	self:addChild(var_25_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_26_0)
		self:addChild(arg_26_0, -2)
		arg_26_0:setPositionY(arg_26_0:getPositionY() - GameDisplay.fix_y)

		local var_26_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_26_0:setAnchorPoint(cc.p(0, 0))
		var_26_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_26_0, -1)
		self:init(arg_25_1)
		var_25_0:setOpacity(102)
		var_25_0:setTouchEnabled(false)
	end)
end
