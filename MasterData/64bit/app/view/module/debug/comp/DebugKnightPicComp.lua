local DebugConst = require("app.view.module.debug.const.DebugConst")
local DebugKnightPicComp = class("DebugKnightPicComp", require("app.fairyGUI.debug.UI_DebugKnightPicComp"))

function DebugKnightPicComp:ctor()
	self._resId = 900020
	self._curScale = 1

	self:_initView()
	self:_initArea()
end

function DebugKnightPicComp:onLoad()
	self._initHolderPos = self.m_knightHolderComp:getPosition()
	self._initTouchPos = self.m_touchPos:getPosition()
	self._initImagePos = self.m_knightHolderComp:getKnightImg():getPosition()

	self:resetKnightPos()
end

function DebugKnightPicComp:_initView()
	self.m_searchInfoComp:updatePaths("knightPicInfo")
	self:addListen(self.m_searchInfoComp)
	self.m_touchPos:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_touchPos:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_touchPos:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_scaleSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self.m_scaleAddBtn:addClickListener(handler(self, self._onScaleAddClick))
	self.m_scaleMinBtn:addClickListener(handler(self, self._onScaleMinClick))
	self.m_xMinBtn:addClickListener(handler(self, self._onxMinClick))
	self.m_xAddBtn:addClickListener(handler(self, self._onxAddClick))
	self.m_yMinBtn:addClickListener(handler(self, self._onyMinClick))
	self.m_yAddBtn:addClickListener(handler(self, self._onyAddClick))
end

function DebugKnightPicComp:_initArea()
	self.m_areaSquare:setSize(DebugConst.KNIGHT_PIC_AREA_WIDTH, DebugConst.KNIGHT_PIC_AREA_HEIGHT)
	self.m_headSquare:setSize(DebugConst.KNIGHT_HEAD_WIDTH, DebugConst.KNIGHT_HEAD_WIDTH)
	self.m_headSquare:setPosition(self.m_headSquare:getPosition().x, self.m_knightHolderComp:getPosition().y - DebugConst.KNIGHT_PIC_HEAD_OFF_Y)
	self.m_tipsText:setText("框尺寸：" .. DebugConst.KNIGHT_PIC_AREA_WIDTH .. "x" .. DebugConst.KNIGHT_PIC_AREA_HEIGHT .. "\n头尺寸：" .. DebugConst.KNIGHT_HEAD_WIDTH .. "x" .. DebugConst.KNIGHT_HEAD_WIDTH .. "\n头中心距框中心：" .. DebugConst.KNIGHT_PIC_HEAD_OFF_Y)
end

function DebugKnightPicComp:updateMainKnight()
	local var_5_0 = self.m_knightHolderComp:getKnightImg()

	var_5_0:setURL(g.core.common.Path:getKnightPicById(self._resId))
	self.m_knightHolderComp:setAlphaRect(nil)
	self:resetKnightPos()

	local var_5_1 = g.core.config.knight_base_info.get(self._resId)

	var_5_0:setPosition(self._initImagePos.x + var_5_1.pic_pos_x, self._initImagePos.y + var_5_1.pic_pos_y)
	self.m_cfgPosText:setText("表中偏移：" .. var_5_1.pic_pos_x .. "x" .. var_5_1.pic_pos_y)
end

function DebugKnightPicComp:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		local var_6_0
		local var_6_1

		if arg_6_2 == "knightPicInfo" then
			var_6_0, var_6_1 = self.m_searchInfoComp:getShowText()
		end

		if var_6_0 then
			self._resId = var_6_1

			self:updateMainKnight()
		end
	end
end

function DebugKnightPicComp:_onTouchBegin(arg_7_1)
	arg_7_1:captureTouch()

	local var_7_0 = arg_7_1:getInput():getPosition()

	self._curTouchX = var_7_0.x
	self._curTouchY = var_7_0.y
end

function DebugKnightPicComp:_onTouchMove(arg_8_1)
	local var_8_0 = arg_8_1:getInput():getPosition()
	local var_8_1, var_8_2 = self:getMovePosByLength(var_8_0.x - self._curTouchX, var_8_0.y - self._curTouchY)

	self.m_touchPos:setPosition(self._initTouchPos.x + var_8_1, self._initTouchPos.y + var_8_2)

	local var_8_3 = math.floor(self._initHolderPos.x + var_8_1 * DebugConst.MOVE_PIC_GAP)
	local var_8_4 = math.floor(self._initHolderPos.y + var_8_2 * DebugConst.MOVE_PIC_GAP)

	self.m_knightHolderComp:setPosition(var_8_3, var_8_4)
	self.m_posText:setText(var_8_3 - self._initHolderPos.x .. "," .. var_8_4 - self._initHolderPos.y)
end

function DebugKnightPicComp:_onTouchEnd(arg_9_1)
	local var_9_0 = arg_9_1:getInput():getPosition()

	if var_9_0.x - self._curTouchX == 0 and var_9_0.y - self._curTouchY == 0 then
		self:resetKnightPos()
	end
end

function DebugKnightPicComp:resetKnightPos()
	self.m_touchPos:setPosition(self._initTouchPos.x, self._initTouchPos.y)
	self.m_knightHolderComp:setPosition(self._initHolderPos.x, self._initHolderPos.y)
	self.m_posText:setText("0,0")
	self.m_scaleSlider:setValue(100 / (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN))

	self._curScale = 1

	self.m_knightHolderComp:setScale(1)
	self.m_scaleText:setText(1)
end

function DebugKnightPicComp:_onSliderChanged()
	local var_11_0 = DebugConst.SCALE_MIN + (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN) * math.floor(self.m_scaleSlider:getValue()) / 100

	self._curScale = var_11_0

	self.m_knightHolderComp:setScale(var_11_0)
	self.m_scaleText:setText(var_11_0)
end

function DebugKnightPicComp:getMovePosByLength(arg_12_1, arg_12_2)
	local var_12_0 = math.sqrt(arg_12_1 * arg_12_1 + arg_12_2 * arg_12_2)

	if var_12_0 > DebugConst.MOVE_TOUCH_MAX then
		arg_12_1 = arg_12_1 * DebugConst.MOVE_TOUCH_MAX / var_12_0
		arg_12_2 = arg_12_2 * DebugConst.MOVE_TOUCH_MAX / var_12_0
	end

	return arg_12_1, arg_12_2
end

function DebugKnightPicComp:_onScaleAddClick()
	self:updateKnightScale(DebugConst.SCALE_STEP)
end

function DebugKnightPicComp:_onScaleMinClick()
	self:updateKnightScale(-DebugConst.SCALE_STEP)
end

function DebugKnightPicComp:_onxMinClick()
	self:updateKnightPos(-DebugConst.MOVE_X_STEP, 0)
end

function DebugKnightPicComp:_onxAddClick()
	self:updateKnightPos(DebugConst.MOVE_X_STEP, 0)
end

function DebugKnightPicComp:_onyMinClick()
	self:updateKnightPos(0, DebugConst.MOVE_Y_STEP)
end

function DebugKnightPicComp:_onyAddClick()
	self:updateKnightPos(0, -DebugConst.MOVE_Y_STEP)
end

function DebugKnightPicComp:updateKnightScale(arg_19_1)
	self._curScale = g.core.utils.Number.formatNumberByLimit(self._curScale + arg_19_1, 0, 5)

	self.m_knightHolderComp:setScale(self._curScale)
	self.m_scaleText:setText(self._curScale)
	self.m_scaleSlider:setValue(self._curScale * 100 / (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN))
end

function DebugKnightPicComp:updateKnightPos(arg_20_1, arg_20_2)
	local var_20_0 = self.m_knightHolderComp:getPosition()

	self.m_knightHolderComp:setPosition(var_20_0.x + arg_20_1, var_20_0.y + arg_20_2)
	self.m_posText:setText(var_20_0.x + arg_20_1 - self._initHolderPos.x .. "," .. var_20_0.y + arg_20_2 - self._initHolderPos.y)
	self.m_touchPos:setPosition(self._initTouchPos.x + (var_20_0.x + arg_20_1 - self._initHolderPos.x) / DebugConst.MOVE_PIC_GAP, self._initTouchPos.y + (var_20_0.y + arg_20_2 - self._initHolderPos.y) / DebugConst.MOVE_PIC_GAP)
end

return DebugKnightPicComp
