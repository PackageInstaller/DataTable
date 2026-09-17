PopPushOpenLayer = class("PopPushOpenLayer", function()
	return PopBaseLayer:create()
end)

local var_0_0 = config._DEBUG and 0 or 1

function PopPushOpenLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopPushOpenLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopPushOpenLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(GameDisplay.getScreenSize())
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	self:addChild(self.rootLayer)
	self.rootLayer:addTouchEventListener(function(arg_4_0, arg_4_1)
		if arg_4_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)

	local var_3_0 = ccui.ImageView:create("PopPushOpenLayer/bg.png", var_0_0)

	var_3_0:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_0:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2))
	var_3_0:setName("bg")
	var_3_0:setTouchEnabled(true)
	self.rootLayer:addChild(var_3_0)

	local var_3_1 = ccui.ImageView:create("PopPushOpenLayer/btn_go.png", var_0_0)

	var_3_1:setName("btn_go")
	var_3_1:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_1:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - 60))
	var_3_1:setTouchEnabled(true)
	self.rootLayer:addChild(var_3_1)
	var_3_1:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("SettingLayer")
	end)

	local var_3_2 = ccui.ImageView:create("PopPushOpenLayer/btn_close.png", var_0_0)

	var_3_2:setName("btn_close")
	var_3_2:setAnchorPoint(cc.p(0.5, 0.5))
	var_3_2:setPosition(cc.p(610, GameDisplay.height / 2 + 210))
	var_3_2:setTouchEnabled(true)
	self.rootLayer:addChild(var_3_2)
	var_3_2:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:exit()
	end)
	self:registerScriptHandler(function(arg_7_0)
		if arg_7_0 == "exit" then
			-- block empty
		end
	end)
end

function PopPushOpenLayer:exit()
	if self.rootLayer then
		self.rootLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function()
			LayerManager:removePopLayer(self.__queueindex)
		end)))
	end
end
