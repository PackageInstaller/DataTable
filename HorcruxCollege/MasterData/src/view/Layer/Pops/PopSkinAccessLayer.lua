PopSkinAccessLayer = class("PopSkinAccessLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0
local activity_calendar_data = require("data.activity_calendar_data")
local time_check_manager = require("controller.time_check_manager")

function PopSkinAccessLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopSkinAccessLayer.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopSkinAccessLayer:init(arg_3_1)
	print("open poplayer : PopSkinAccessLayer", dump(arg_3_1))

	arg_3_1 = arg_3_1 or {}
	self.activityId = arg_3_1.activityId or var_0_0
	self.layerName = "PopSkinAccessLayer_" .. self.activityId

	TextureManager:loadLayerTextures({
		self.layerName
	})

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile((config._DEBUG or nil) and (self.layerName .. ".json" or self.layerName .. ".ExportJson"))

	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height + GameDisplay.fix_y))
	self.rootLayer:setPositionY(self.rootLayer:getPositionY() - GameDisplay.fix_y)
	self:addChild(self.rootLayer)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			var_0_0 = self.activityId

			if arg_3_1.callback then
				arg_3_1.callback()
			end
		end
	end)
end

function PopSkinAccessLayer:initUI()
	self:initExitTouchEvent()
	self:initBtns()
	self:playJoinInEffect()
end

function PopSkinAccessLayer:initExitTouchEvent()
	self.rootLayer:setTouchEnabled(true)
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

	self.btnReturn = ccui.Helper:seekWidgetByName(self.rootLayer, "btn_return") or ccui.Helper:seekWidgetByName(self.rootLayer, "btn_close") or ccui.Helper:seekWidgetByName(self.rootLayer, "btn_back")

	if self.btnReturn then
		self.btnReturn:addTouchEventListener(function(arg_8_0, arg_8_1)
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

	self.bg = self.rootLayer:getChildByName("bg")

	self.bg:setTouchEnabled(true)
	self.bg:setPositionY(self.bg:getPositionY() + GameDisplay.fix_y)
end

function PopSkinAccessLayer:initBtns()
	local activity_skin_access_data = require("data.activity_skin_access_data")

	for iter_9_0, iter_9_1 in ipairs(activity_skin_access_data[self.activityId]) do
		ccui.Helper:seekWidgetByName(self.bg, "btn" .. iter_9_0):addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			if activity_skin_access_data.lockTime[iter_9_1] and global_get_time_by_date(activity_skin_access_data.lockTime[iter_9_1]) > time_check_manager:getCurTime() then
				global_ShowBlockWords(string.format(L_ACTIVITY_EXPLORE_START, activity_skin_access_data.lockTime[iter_9_1]))

				return
			end

			goto_complete_system({
				jump_to_system = iter_9_1
			})
			AnalyticManager.activityJumpTo({
				form = "PopSkinAccessLayer",
				activityid = self.activityId,
				module = iter_9_1
			})
		end)
	end
end

function PopSkinAccessLayer:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopSkinAccessLayer:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopSkinAccessLayer:initBg(arg_14_1)
	local var_14_0 = ccui.Layout:create()

	var_14_0:setTouchEnabled(true)
	var_14_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_14_0:setAnchorPoint(cc.p(0, 0))
	var_14_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_14_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_14_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_14_0:setOpacity(0)
	self:addChild(var_14_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_15_0)
		self:addChild(arg_15_0, -2)
		arg_15_0:setPositionY(arg_15_0:getPositionY() - GameDisplay.fix_y)

		local var_15_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_15_0:setAnchorPoint(cc.p(0, 0))
		var_15_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_15_0, -1)
		self:init(arg_14_1)
		var_14_0:setOpacity(102)
		var_14_0:setTouchEnabled(false)
	end)
end
