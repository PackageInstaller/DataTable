local DrawKnight = require("app.view.common.DrawKnight")
local DrawSuccuba = require("app.view.common.DrawSuccuba")
local DebugConst = require("app.view.module.debug.const.DebugConst")
local KsMath = require("app.core.utils.KsMath")
local var_0_4 = {
	ITEM = 2,
	SPINE = 1
}
local DebugStoryGameComp = class("DebugStoryGameComp", require("app.fairyGUI.debug.UI_DebugStoryGameComp"))

function DebugStoryGameComp:ctor()
	self._opMode = var_0_4.SPINE
	self._opObjectPos = nil
	self._readCfg = false
	self._itemNodes = {}
	self._opItemNode = nil
	self._centerPos = cc.p(display.width / 2, display.height / 2)

	self.m_knightHolderComp:setPosition(self._centerPos)
	self.m_touchHolderComp:setPosition(self._centerPos)
	self:_initView()
end

function DebugStoryGameComp:_initView()
	self.m_searchBgComp:updatePaths("storyBg")
	self.m_searchInfoComp:updatePaths("knightInfo")
	self.m_searchPicComp:updatePaths("knightSpine")
	self.m_searchSuccubaComp:updatePaths("succubaSpine")
	self:addListen(self.m_searchBgComp)
	self:addListen(self.m_searchInfoComp)
	self:addListen(self.m_searchPicComp)
	self:addListen(self.m_searchSuccubaComp)
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onKnightTouchBegin))
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onKnightTouchMove))
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onKnightTouchEnd))
	self.m_scaleSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_scaleAddBtn:addClickListener(handler(self, self._onScaleAddClick))
	self.m_scaleMinBtn:addClickListener(handler(self, self._onScaleMinClick))
	self.m_checkbox:addClickListener(handler(self, self._onCheckboxChanged))
	self.m_checkReadCfg:addClickListener(handler(self, self._onCheckReadCfg))
	self.m_addItemBtn:addClickListener(handler(self, self._onAddItem))
	self.m_radius:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRadiusChanged))
	self.m_resetBtn:addClickListener(handler(self, self._onClickReset))
	self:updateModeView()
end

function DebugStoryGameComp:_onClickReset()
	if self._showKnight then
		self.m_scaleSlider:setValue(100 / (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN))
		self._showKnight:setScale(1)
		self.m_scaleText:setText(1)
		self._showKnight:setPosition(0, 0)
		self:updateSpineParams()
	elseif self._showSuccuba then
		self.m_scaleSlider:setValue(100 / (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN))
		self._showSuccuba:setScale(1)
		self.m_scaleText:setText(1)
		self._showSuccuba:setPosition(display.width / 2, display.height / 2)
		self:updateSpineParams()
	end
end

function DebugStoryGameComp:_onAddItem()
	local var_4_0 = fgui.UIPackage:createObject("debug", "DebugStoryGameItem")

	var_4_0:addClickListener(handler(self, self._onItemClicked))
	var_4_0:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onKnightTouchBegin))
	var_4_0:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onKnightTouchMove))
	var_4_0:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onKnightTouchEnd))
	self.m_touchHolderComp:addChild(var_4_0)
	var_4_0:setPosition(0, 0)

	self._itemNodes[#self._itemNodes + 1] = var_4_0
end

function DebugStoryGameComp:_onItemClicked(arg_5_1)
	self._opItemNode = arg_5_1:getSender()

	self:cancelItemClick()

	if self._opMode == var_0_4.ITEM then
		self:updateItemParams()
		self._opItemNode:getController("active"):setSelectedIndex(1)
	end
end

function DebugStoryGameComp:cancelItemClick()
	for iter_6_0 = 1, #self._itemNodes do
		self._itemNodes[iter_6_0]:getController("active"):setSelectedIndex(0)
	end
end

function DebugStoryGameComp:_onRadiusChanged()
	if self._opMode ~= var_0_4.ITEM then
		return
	end

	local var_7_0 = self.m_radius:getText()

	if not var_7_0 or not self._opItemNode or var_7_0 == "" then
		return
	end

	self._opItemNode:getChild("radius"):setWidth(tonumber(var_7_0) * 2)
	self._opItemNode:getChild("radius"):setHeight(tonumber(var_7_0) * 2)
end

function DebugStoryGameComp:_onKnightTouchBegin(arg_8_1)
	self._localTouchPos = arg_8_1:getInput():getPosition()

	self:recordPosition()
	arg_8_1:captureTouch()
end

function DebugStoryGameComp:_onKnightTouchMove(arg_9_1)
	if self._localTouchPos then
		self:updateMove((cc.pSub(arg_9_1:getInput():getPosition(), self._localTouchPos)))
	end
end

function DebugStoryGameComp:_onKnightTouchEnd()
	self._localTouchPos = nil
	self._moveDistance = 0
end

function DebugStoryGameComp:_onScaleAddClick()
	return
end

function DebugStoryGameComp:_onScaleMinClick()
	return
end

function DebugStoryGameComp:recordPosition()
	if self._opMode == var_0_4.SPINE then
		self._opObjectPos = nil

		if self._showKnight then
			self._opObjectPos = self._showKnight:getPosition()
		elseif self._showSuccuba then
			self._opObjectPos = self._showSuccuba:getPosition()
		end
	elseif self._opItemNode then
		self._opObjectPos = self._opItemNode:getPosition()
	end
end

function DebugStoryGameComp:updateMove(arg_14_1)
	if self._opMode == var_0_4.SPINE then
		if self._showKnight then
			self._showKnight:setPosition(cc.pAdd(self._opObjectPos, arg_14_1))
		elseif self._showSuccuba then
			self._showSuccuba:setPosition(cc.pAdd(self._opObjectPos, arg_14_1))
		end

		self:updateSpineParams()
	elseif self._opItemNode and self._opObjectPos then
		self._opItemNode:setPosition(cc.pAdd(self._opObjectPos, arg_14_1))
		self:updateItemParams()
	end
end

function DebugStoryGameComp:_onCheckReadCfg(arg_15_1)
	self._readCfg = arg_15_1:getSender():isSelected(), arg_15_1:stopPropagation()
end

function DebugStoryGameComp:_onCheckboxChanged(arg_16_1)
	arg_16_1:stopPropagation()

	self._opMode = arg_16_1:getSender():isSelected() and var_0_4.ITEM or var_0_4.SPINE

	self:updateModeView()
	self:cancelItemClick()

	self._opItemNode = nil
end

function DebugStoryGameComp:updateModeView()
	if self._opMode == var_0_4.SPINE then
		self.m_modeController:setSelectedIndex(0)
	else
		self.m_modeController:setSelectedIndex(1)
	end
end

function DebugStoryGameComp:receiveCompEvent(arg_18_1, arg_18_2)
	if arg_18_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		local var_18_0
		local var_18_1
		local var_18_2

		if arg_18_2 == "knightInfo" then
			var_18_0, var_18_1 = self.m_searchInfoComp:getShowText()
		elseif arg_18_2 == "knightSpine" then
			var_18_0, var_18_1 = self.m_searchPicComp:getShowText()
		elseif arg_18_2 == "succubaSpine" then
			var_18_0, var_18_1 = self.m_searchSuccubaComp:getShowText()
		elseif arg_18_2 == "storyBg" then
			var_18_0, var_18_2 = self.m_searchBgComp:getShowText()
		end

		if (arg_18_2 == "knightInfo" or arg_18_2 == "knightSpine") and var_18_0 then
			self._resId = var_18_1

			self:updateMainKnight(arg_18_2 == "knightInfo")
		end

		if arg_18_2 == "succubaSpine" and var_18_0 then
			self._resId = var_18_1

			self:updateSuccuba(false)
		end

		if arg_18_2 == "storyBg" and var_18_0 then
			self._bgId = var_18_2

			self:updateBg(self._bgId)
		end
	end
end

function DebugStoryGameComp:updateMainKnight(arg_19_1)
	self.m_knightHolderComp:removeChildren()

	if self._knightSpineBg then
		self._knightSpineBg:dispose()

		self._knightSpineBg = nil
	end

	self._isFromInfo = arg_19_1

	local var_19_0 = {}

	if arg_19_1 then
		var_19_0.resId = self._resId
		var_19_0.isShowBg = self._showBg
	else
		var_19_0.dir_res = self._resId
	end

	var_19_0.ignorePosByCfg = not self._readCfg
	var_19_0.isAlphaNode = true
	self._showKnight = DrawKnight.new(var_19_0)

	self._showKnight:setScale(DebugConst.SCALE_MIN + (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN) * math.floor(self.m_scaleSlider:getValue()) / 100)
	self._showKnight:setPosition(0, 0)
	self.m_knightHolderComp:addChild(self._showKnight)
	self:updateSpineParams()
end

function DebugStoryGameComp:updateSuccuba(arg_20_1)
	self.m_succubaHolderComp:removeChildren()

	self._isFromInfo = arg_20_1
	self._showSuccuba = DrawSuccuba.new({
		resId = self._resId
	})

	self._showSuccuba:setScale(DebugConst.SCALE_MIN + (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN) * math.floor(self.m_scaleSlider:getValue()) / 100)
	self._showSuccuba:setPosition(display.width / 2, display.height / 2)
	self._showSuccuba:playAction("idle_A", nil, nil, true)
	self.m_succubaHolderComp:addChild(self._showSuccuba)
	self:updateSpineParams()
end

function DebugStoryGameComp:updateBg(arg_21_1)
	if self._commonBg then
		self._commonBg:removeFromParent()

		self._commonBg = nil
	end

	self:addBg("bg/" .. arg_21_1, true)
end

function DebugStoryGameComp:_onSliderChanged()
	if self._opMode == var_0_4.SPINE then
		local var_22_0 = DebugConst.SCALE_MIN + (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN) * math.floor(self.m_scaleSlider:getValue()) / 100

		if self._showKnight then
			self._showKnight:setScale(var_22_0)
		elseif self._showSuccuba then
			self._showSuccuba:setScale(var_22_0)
		end

		self.m_scaleText:setText(var_22_0)
		self:updateSpineParams()
	end
end

function DebugStoryGameComp:updateSpineParams()
	local var_23_0

	if self._showKnight then
		var_23_0 = self._showKnight:getPosition()
	elseif self._showSuccuba then
		var_23_0 = self._showSuccuba:getPosition()
	end

	local var_23_1

	if self._showKnight then
		var_23_1 = self._showKnight:getKnightSpine():getScale()
	elseif self._showSuccuba then
		var_23_1 = self._showSuccuba:getSuccubaSpine():getScale()
	end

	self.m_spineX:setText(var_23_0.x)
	self.m_spineY:setText(var_23_0.y)
	self.m_spineScale:setText(string.format("%.3f", var_23_1))
end

function DebugStoryGameComp:updateItemParams()
	if not self._opItemNode then
		return
	end

	local var_24_0 = self._opItemNode:getPosition()

	if self._showSuccuba then
		var_24_0 = cc.pAdd(var_24_0, cc.p(-64, -64))
	end

	self.m_itemX:setText(var_24_0.x)
	self.m_itemY:setText(var_24_0.y)
	self.m_radius:setText(self._opItemNode:getChild("radius"):getWidth() / 2)
end

return DebugStoryGameComp
