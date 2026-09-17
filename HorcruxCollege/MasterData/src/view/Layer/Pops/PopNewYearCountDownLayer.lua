PopNewYearCountDownLayer = class("PopNewYearCountDownLayer", function()
	return PopBaseLayer:create()
end)

require("view.Layer.PopLayer")

local var_0_0 = config._DEBUG and 0 or 1

function PopNewYearCountDownLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = PopNewYearCountDownLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function PopNewYearCountDownLayer:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self.rootLayer:setTouchEnabled(true)
	self.rootLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.rootLayer:setAnchorPoint(cc.p(0, 0))
	self.rootLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.rootLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.rootLayer:setBackGroundColor(cc.c3b(2, 5, 24))
	self:addChild(self.rootLayer)

	self.sec = 5
	self.numimg = ccui.ImageView:create("PopNewYearCountDownLayer/5.png", var_0_0)

	self.numimg:setPositionX(self.rootLayer:getContentSize().width / 2)
	self.numimg:setPositionY(self.rootLayer:getContentSize().height / 2)
	self.rootLayer:addChild(self.numimg)
	self:runTimer()
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.callback then
			self.callback()
		end
	end)
end

function PopNewYearCountDownLayer:setNumimg()
	self.numimg:setVisible(false)

	if self.sec == 0 then
		global_ShowBlockWords("礼花！")
	elseif self.sec <= -3 then
		LayerManager:removePopLayer(self.__queueindex)
	elseif self.sec > 0 then
		self.numimg:setVisible(true)
		self.numimg:setScale(1.05)
		self.numimg:runAction(cc.ScaleTo:create(0.1, 1, 1))
		self.numimg:loadTexture("PopNewYearCountDownLayer/" .. self.sec .. ".png", var_0_0)
	end
end

function PopNewYearCountDownLayer:runTimer()
	local var_6_0 = cc.Node:create()

	self:addChild(var_6_0)
	var_6_0:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.DelayTime:create(1), cc.CallFunc:create(function(...)
		self.sec = self.sec - 1

		self:setNumimg()
	end))))
end

function PopNewYearCountDownLayer:exit()
	if self.sec <= -3 then
		LayerManager:removePopLayer(self.__queueindex)
	end
end
