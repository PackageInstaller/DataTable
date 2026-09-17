local RoleOffsetLayer = class("RoleOffsetLayer", (require("view.Layer.BaseUILayer")))
local TempWidget = require("view.Sprite.TempWidget")
local var_0_4 = 1
local var_0_5 = 1 + 1

function RoleOffsetLayer:ctor()
	RoleOffsetLayer.super.ctor(self)
	self:setAutoAdapt(true)

	self.manager = require("controller.role_offset_manager"):getInstance()
	self.image = nil
	self.bubbleImage = nil
end

function RoleOffsetLayer:create(arg_2_1)
	local var_2_0 = RoleOffsetLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function RoleOffsetLayer:onEnter()
	RoleOffsetLayer.super.onEnter(self)
end

function RoleOffsetLayer:onExit()
	RoleOffsetLayer.super.onExit(self)
end

function RoleOffsetLayer:init(arg_5_1)
	self:initLayer()
	self:initListener()

	return true
end

function RoleOffsetLayer:initLayer()
	self._root = TempWidget:CreateTempLayout(self)

	self._root:setContentSize(GameDisplay.getUiScreenSize())

	local var_6_0 = TempWidget:CreateTempLayout(self._root)

	var_6_0:setContentSize(cc.size(80, 80))
	var_6_0:_setBack()
	var_6_0:_addEvent(function()
		var_6_0:runAction(cc.CallFunc:create(function()
			self.manager:removeLayer()
		end))
	end)
	var_6_0:align(cc.p(1, 1), self._root:property().right_top)
	var_6_0:setLocalZOrder(99)
	TempWidget:CreateTempLabel("关闭", FONT_NAME, 30, var_6_0):center()
	self:initImage()
	self:initBubbleImage()
	self:initMoveLayout()
end

function RoleOffsetLayer:initListener()
	self._root:_addEvent(function()
		return
	end)
end

function RoleOffsetLayer:initImage()
	local var_11_0 = self.manager:getImagePath()

	if var_11_0 then
		self.image = TempWidget:CreateTempImg(var_11_0, self._root, 0)

		self.image:setAnchorPoint(self.manager:getImageAnchorPoint())
		self.image:setLocalZOrder(var_0_4)
		self:updateImagePos()
	end
end

function RoleOffsetLayer:initBubbleImage()
	local var_12_0 = self.manager:getBubblePath()

	if var_12_0 then
		self.bubbleImage = TempWidget:CreateTempImg(var_12_0, self._root, 0)

		self.bubbleImage:setLocalZOrder(var_0_5)
		self:updateBubblePos()
	end
end

function RoleOffsetLayer:initMoveLayout()
	local var_13_0 = TempWidget:CreateTempLayout(self)

	var_13_0:setContentSize(self._root:size())

	local var_13_1 = cc.EventListenerTouchOneByOne:create()

	var_13_1:registerScriptHandler(function(arg_14_0, arg_14_1)
		return true
	end, cc.Handler.EVENT_TOUCH_BEGAN)
	var_13_1:registerScriptHandler(function(arg_15_0, arg_15_1)
		if self.image then
			local var_15_0 = arg_15_0:getLocation()
			local var_15_1 = arg_15_0:getPreviousLocation()
			local var_15_2 = arg_15_0:getStartLocation()
			local var_15_3 = {
				x = var_15_0.x - var_15_1.x,
				y = var_15_0.y - var_15_1.y
			}
			local var_15_4 = self.manager:getMoveType()

			if var_15_4 == self.manager.MoveType.Image then
				local var_15_5 = self.manager:getImagePos()

				self.manager:setImagePos(cc.p(var_15_5.x + var_15_3.x, var_15_5.y + var_15_3.y))
				self:updateImagePos()
			elseif var_15_4 == self.manager.MoveType.Bubble then
				local var_15_6 = self.manager:getBubblePos()

				self.manager:setBubblePos(cc.p(var_15_6.x + var_15_3.x, var_15_6.y + var_15_3.y))
				self:updateBubblePos()
			end

			return true
		end

		return false
	end, cc.Handler.EVENT_TOUCH_MOVED)
	var_13_1:registerScriptHandler(function(arg_16_0, arg_16_1)
		return false
	end, cc.Handler.EVENT_TOUCH_ENDED)
	var_13_0:getEventDispatcher():addEventListenerWithSceneGraphPriority(var_13_1, var_13_0)
end

function RoleOffsetLayer:updateLayer()
	return
end

function RoleOffsetLayer:updateRed()
	return
end

function RoleOffsetLayer:updateImage()
	local var_19_0 = self.manager:getImagePath()

	if not self.image then
		self.image = TempWidget:CreateTempImg(var_19_0, self._root, 0)

		self.image:setAnchorPoint(self.manager:getImageAnchorPoint())
		self.image:setLocalZOrder(var_0_4)
	else
		self.image:loadTexture(var_19_0)
	end

	self:updateImagePos()
end

function RoleOffsetLayer:updateImagePos()
	if self.image then
		self.image:move(self.manager:getImagePos())
	end
end

function RoleOffsetLayer:updateBubblePos()
	if self.bubbleImage then
		self.bubbleImage:move(self.manager:getBubblePos())
	end
end

return RoleOffsetLayer
