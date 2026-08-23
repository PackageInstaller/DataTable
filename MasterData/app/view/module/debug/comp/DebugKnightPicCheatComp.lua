local DebugConst = require("app.view.module.debug.const.DebugConst")
local var_0_1 = 1000
local DebugKnightPicCheatComp = class("DebugKnightPicCheatComp", require("app.fairyGUI.debug.UI_DebugKnightPicCheatComp"))

function DebugKnightPicCheatComp:ctor()
	self._resId = 900020
	self._curScale = 1
	self._isHideMask = true

	self:_initView()
end

function DebugKnightPicCheatComp:onLoad()
	self._initHolderPos = self.m_cutComp:getPosition()
	self._initImagePos = self.m_cutComp:getKnightImg():getPosition()
end

function DebugKnightPicCheatComp:_onTouchBegin(arg_3_1)
	arg_3_1:captureTouch()
	self:setCutPosition(cc.pAdd(self.m_cutComp:globalToLocal((arg_3_1:getInput():getPosition())), cc.p(display.cx, display.cy)))
end

function DebugKnightPicCheatComp:_onTouchMove(arg_4_1)
	self:setCutPosition(cc.pAdd(self.m_cutComp:globalToLocal((arg_4_1:getInput():getPosition())), cc.p(display.cx, display.cy)))
end

function DebugKnightPicCheatComp:_onTouchEnd(arg_5_1)
	self:setCutPosition(cc.pAdd(self.m_cutComp:globalToLocal((arg_5_1:getInput():getPosition())), cc.p(display.cx, display.cy)))
end

function DebugKnightPicCheatComp:setCutPosition(arg_6_1)
	self.m_clickPos:setPosition(arg_6_1)
	self.m_cutComp:setCutPos(arg_6_1)
	self.m_halfOpacityComp:setCutPos(arg_6_1)

	local var_6_0 = self.m_cutComp:getCutDir()

	self.m_tipsText:setText("相对位置:\n x = " .. var_6_0.x .. "\n y = " .. var_6_0.y)
end

function DebugKnightPicCheatComp:_initView()
	self.m_searchInfoComp:updatePaths("knightPicInfo")
	self:addListen(self.m_searchInfoComp)
	self.m_hideMaskBtn:addClickListener(handler(self, self._onHideMaskClick))
	self.m_hideMaskBtn:setSelected(self._isHideMask)
	self.m_touchGraph:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchGraph:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_inputValue:addEventListener(fgui.UIEventType.Submit, handler(self, self._onValueSubmited))
	self.m_scaleSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_inputValue:setText(self.m_cutComp:getRangeSize())
	self.m_scaleSlider:setMax(var_0_1)
	self.m_scaleSlider:setValue(self.m_cutComp:getRangeSize())
end

function DebugKnightPicCheatComp:_onSliderChanged()
	self.m_inputValue:setText((math.floor(self.m_scaleSlider:getValue())))
	self:_onValueSubmited()
end

function DebugKnightPicCheatComp:_onHideMaskClick(arg_9_1)
	arg_9_1:stopPropagation()

	self._isHideMask = self.m_hideMaskBtn:isSelected()

	self.m_cutComp:setMaskHide(self._isHideMask)
	self.m_halfOpacityComp:getChild("knightHolderComp"):setOpacity(not self._isHideMask and 255 or 127.5)
end

function DebugKnightPicCheatComp:updateMainKnight()
	self.m_cutComp:setMaskHide(self._isHideMask)
	self.m_halfOpacityComp:getChild("knightHolderComp"):setOpacity(not self._isHideMask and 255 or 127.5)
	self.m_cutComp:setPic(g.core.common.Path:getMiddleKnightPicById(self._resId))

	local var_10_0 = g.core.config.knight_base_info.get(self._resId)

	self.m_cutComp:setPicPosition(self._initImagePos.x + 0, self._initImagePos.y + 0)
	self.m_cfgPosText:setText("表中偏移：" .. 0 .. "x" .. 0)
end

function DebugKnightPicCheatComp:_onValueSubmited()
	local var_11_0 = tonumber(self.m_inputValue:getText())

	self.m_cutComp:setRangeSize(var_11_0)
	self.m_halfOpacityComp:setRangeSize(var_11_0)
	self.m_scaleSlider:setValue(self.m_cutComp:getRangeSize())
end

function DebugKnightPicCheatComp:receiveCompEvent(arg_12_1, arg_12_2)
	if arg_12_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		local var_12_0
		local var_12_1

		if arg_12_2 == "knightPicInfo" then
			var_12_0, var_12_1 = self.m_searchInfoComp:getShowText()
		end

		if var_12_0 then
			self._resId = var_12_1

			self:updateMainKnight()
		end
	end
end

return DebugKnightPicCheatComp
