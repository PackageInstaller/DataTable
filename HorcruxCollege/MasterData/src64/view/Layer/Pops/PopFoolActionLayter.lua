PopFoolActionLayter = class("PopFoolActionLayter", function()
	return PopBaseLayer:create()
end)

local activity_main_conf = require("data.activity_modules.activity_main_conf")

function PopFoolActionLayter.create(arg_2_0, arg_2_1)
	local var_2_0 = PopFoolActionLayter.new()

	var_2_0:initBg(arg_2_1)

	return var_2_0
end

function PopFoolActionLayter:init(arg_3_1)
	print("open poplayer : PopFoolActionLayter")

	self.rootLayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "PopFoolActionLayter.json" or "PopFoolActionLayter.ExportJson")

	self.rootLayer:setContentSize(GameDisplay:getScreenSize())
	self.rootLayer:setPositionY(0)
	self:addChild(self.rootLayer)
	self:initUI()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" then
			-- block empty
		end
	end)
end

function PopFoolActionLayter:initUI()
	self:initExitTouchEvent()
	self:initBtns()
	self:playJoinInEffect()
end

function PopFoolActionLayter:initExitTouchEvent()
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
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_exit"):addTouchEventListener(function(arg_8_0, arg_8_1)
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

function PopFoolActionLayter:initBtns()
	ccui.Helper:seekWidgetByName(self.rootLayer, "bg"):setTouchEnabled(true)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_head_list"):addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.activityJumpTo({
			module = "btn_xingdong_head_collect",
			activityid = 464
		})
		LayerManager:pushInLayer("PopFoolHeadCollectLayter")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_room"):addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.activityJumpTo({
			module = "btn_xingdong_drom",
			activityid = 464
		})
		LayerManager:switchShowLayer("DormitoryLayer")
	end)
	ccui.Helper:seekWidgetByName(self.rootLayer, "btn_shop"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		AnalyticManager.activityJumpTo({
			module = "btn_Fight",
			activityid = 464
		})
		LayerManager:switchShowLayer("FightLayer")
	end)
end

function PopFoolActionLayter:playJoinInEffect()
	self.rootLayer:setOpacity(0)
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.2)))
end

function PopFoolActionLayter:exit()
	self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
		LayerManager:removePopLayer(self.__queueindex)
	end)))
end

function PopFoolActionLayter:initBg(arg_16_1)
	local var_16_0 = ccui.Layout:create()

	var_16_0:setTouchEnabled(true)
	var_16_0:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_16_0:setAnchorPoint(cc.p(0, 0))
	var_16_0:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_16_0:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	var_16_0:setBackGroundColor(cc.c3b(2, 5, 24))
	var_16_0:setOpacity(0)
	self:addChild(var_16_0, -1)
	require("controller.l2utils"):captureScreenGaussBlur(function(arg_17_0)
		self:addChild(arg_17_0, -2)
		arg_17_0:setPositionY(arg_17_0:getPositionY() - GameDisplay.fix_y)

		local var_17_0 = ccui.ImageView:create("mainScenebg/blur_mask.png")

		var_17_0:setAnchorPoint(cc.p(0, 0))
		var_17_0:setPositionY(-GameDisplay.fix_y)
		self:addChild(var_17_0, -1)
		self:init(arg_16_1)
		var_16_0:setOpacity(102)
		var_16_0:setTouchEnabled(false)
	end)
end
