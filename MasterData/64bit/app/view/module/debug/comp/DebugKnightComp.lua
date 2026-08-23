local DrawSuccuba = require("app.view.common.DrawSuccuba")
local DrawKnight = require("app.view.common.DrawKnight")
local DebugConst = require("app.view.module.debug.const.DebugConst")
local DebugKnightComp = class("DebugKnightComp", require("app.fairyGUI.debug.UI_DebugKnightComp"))

function DebugKnightComp:ctor()
	self._resId = 900020
	self._isFromInfo = false
	self._showBg = false
	self._readCfg = false
	self._curScale = 1

	self:_initView()
	self:_initArea()
end

function DebugKnightComp:onLoad()
	self._initHolderPos = self.m_knightHolderComp:getPosition()
	self._initTouchPos = self.m_touchPos:getPosition()

	self:resetKnightPos()
end

function DebugKnightComp:_initView()
	self.m_searchInfoComp:updatePaths("knightInfo")
	self.m_searchPicComp:updatePaths("knightSpine")
	self.m_searchSuccubaComp:updatePaths("succubaSpine")
	self:addListen(self.m_searchInfoComp)
	self:addListen(self.m_searchPicComp)
	self:addListen(self.m_searchSuccubaComp)
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
	self.m_alphaXSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAlphaSliderChanged))
	self.m_alphaYSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAlphaSliderChanged))
	self.m_alphaWSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAlphaSliderChanged))
	self.m_alphaHSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAlphaSliderChanged))
	self.m_alphaDisSlider:addEventListener(fgui.UIEventType.Changed, handler(self, self._onAlphaSliderChanged))
	self.m_reverseCheckBtn:addClickListener(handler(self, self._onReverseCheckBtnClick))
	self.m_bgShowController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onBgShowSelChanged))
	self.m_readCfgController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onReadCfgSelChanged))
end

function DebugKnightComp:_initArea()
	self.m_areaSquare:setSize(DebugConst.KNIGHT_AREA_WIDTH, DebugConst.KNIGHT_AREA_HEIGHT)
	self.m_headSquare:setSize(DebugConst.KNIGHT_HEAD_WIDTH, DebugConst.KNIGHT_HEAD_WIDTH)
	self.m_headSquare:setPosition(self.m_headSquare:getPosition().x, self.m_knightHolderComp:getPosition().y - DebugConst.KNIGHT_HEAD_OFF_Y)
	self.m_tipsText:setText("框尺寸：" .. DebugConst.KNIGHT_AREA_WIDTH .. "x" .. DebugConst.KNIGHT_AREA_HEIGHT .. "\n头尺寸：" .. DebugConst.KNIGHT_HEAD_WIDTH .. "x" .. DebugConst.KNIGHT_HEAD_WIDTH .. "\n头中心距框中心：" .. DebugConst.KNIGHT_HEAD_OFF_Y)
end

function DebugKnightComp:updateMainKnight(arg_5_1)
	self.m_knightHolderComp:removeChildren()

	if self._knightSpineBg then
		self._knightSpineBg:dispose()

		self._knightSpineBg = nil
	end

	self._isFromInfo = arg_5_1

	local var_5_0 = {}

	if arg_5_1 then
		if self._resId > 999999 then
			var_5_0.skinId = self._resId
		else
			var_5_0.resId = self._resId
		end

		var_5_0.isShowBg = self._showBg
		var_5_0.ignorePosByCfg = not self._readCfg
	else
		var_5_0.dir_res = self._resId

		if cc.FileUtils:getInstance():isFileExist(g.core.common.Path:getSpineKnightPath(self._resId) .. "_bg.skel") then
			local var_5_1 = {
				resId = self._resId,
				path = g.core.common.Path:getSpineKnightBgPath(self._resId)
			}

			var_5_1.anim = "bg"
			var_5_1.isLoop = true
			self._knightSpineBg = require("app.view.common.SpineBase").new(var_5_1)

			self.m_knightHolderComp:addNode(self._knightSpineBg, -1)
		end
	end

	var_5_0.isAlphaNode = true
	self._showKnight = DrawKnight.new(var_5_0)

	self.m_knightHolderComp:addChild(self._showKnight)
	self:resetKnightPos()

	if arg_5_1 then
		local var_5_2, var_5_3 = self._showKnight:getKnightSpine():getPosition()

		self.m_cfgPosText:setText("表中偏移：" .. var_5_2 .. "x" .. var_5_3)
	end
end

function DebugKnightComp:updateSuccuba(arg_6_1)
	self.m_succubaHolderComp:removeChildren()

	self._isFromInfo = arg_6_1

	local var_6_0 = {
		resId = self._resId
	}

	var_6_0.isAlphaNode = true
	self._showSuccuba = DrawSuccuba.new(var_6_0)

	self._showSuccuba:playAction("idle_A", nil, nil, true)
	self.m_succubaHolderComp:addChild(self._showSuccuba)
	self:resetKnightPos()

	if arg_6_1 then
		local var_6_1, var_6_2 = self._showSuccuba:getSuccubaSpine():getPosition()

		self.m_cfgPosText:setText("表中偏移：" .. var_6_1 .. "x" .. var_6_2)
	end
end

function DebugKnightComp:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "EVENT_DEBUG_INPUT_CHANGE" then
		local var_7_0
		local var_7_1

		if arg_7_2 == "knightInfo" then
			var_7_0, var_7_1 = self.m_searchInfoComp:getShowText()
		elseif arg_7_2 == "knightSpine" then
			var_7_0, var_7_1 = self.m_searchPicComp:getShowText()
		elseif arg_7_2 == "succubaSpine" then
			var_7_0, var_7_1 = self.m_searchSuccubaComp:getShowText()

			if var_7_0 then
				self._resId = var_7_1

				self:updateSuccuba(true)
			end

			return
		end

		if var_7_0 then
			self._resId = var_7_1

			self:updateMainKnight(arg_7_2 == "knightInfo")
		end
	end
end

function DebugKnightComp:_onTouchBegin(arg_8_1)
	arg_8_1:captureTouch()

	local var_8_0 = arg_8_1:getInput():getPosition()

	self._curTouchX = var_8_0.x
	self._curTouchY = var_8_0.y
end

function DebugKnightComp:_onTouchMove(arg_9_1)
	local var_9_0 = arg_9_1:getInput():getPosition()
	local var_9_1, var_9_2 = self:getMovePosByLength(var_9_0.x - self._curTouchX, var_9_0.y - self._curTouchY)

	self.m_touchPos:setPosition(self._initTouchPos.x + var_9_1, self._initTouchPos.y + var_9_2)

	local var_9_3 = math.floor(self._initHolderPos.x + var_9_1 * DebugConst.MOVE_SPINE_GAP)
	local var_9_4 = math.floor(self._initHolderPos.y + var_9_2 * DebugConst.MOVE_SPINE_GAP)

	self.m_knightHolderComp:setPosition(var_9_3, var_9_4)
	self.m_succubaHolderComp:setPosition(var_9_3, var_9_4)
	self.m_posText:setText(var_9_3 - self._initHolderPos.x .. "," .. self._initHolderPos.y - var_9_4)
end

function DebugKnightComp:_onTouchEnd(arg_10_1)
	local var_10_0 = arg_10_1:getInput():getPosition()

	if var_10_0.x - self._curTouchX == 0 and var_10_0.y - self._curTouchY == 0 then
		self:resetKnightPos()
	end
end

function DebugKnightComp:resetKnightPos()
	self.m_touchPos:setPosition(self._initTouchPos.x, self._initTouchPos.y)
	self.m_knightHolderComp:setPosition(self._initHolderPos.x, self._initHolderPos.y)
	self.m_succubaHolderComp:setPosition(self._initHolderPos.x, self._initHolderPos.y)
	self.m_posText:setText("0,0")
	self.m_scaleSlider:setValue(100 / (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN))

	self._curScale = 1

	self.m_knightHolderComp:setScale(1)
	self.m_succubaHolderComp:setScale(1)
	self.m_scaleText:setText(1)
end

function DebugKnightComp:_onSliderChanged()
	local var_12_0 = DebugConst.SCALE_MIN + (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN) * math.floor(self.m_scaleSlider:getValue()) / 100

	self._curScale = var_12_0

	self.m_knightHolderComp:setScale(var_12_0)
	self.m_succubaHolderComp:setScale(var_12_0)
	self.m_scaleText:setText(var_12_0)
end

function DebugKnightComp:_onAlphaSliderChanged()
	self:_onUpdateShowKnightAlpha()
end

function DebugKnightComp:_onUpdateShowKnightAlpha()
	if self._showKnight then
		local var_14_0 = math.floor(self.m_alphaXSlider:getMax() / 2 - self.m_alphaXSlider:getValue()) * 10
		local var_14_1 = math.floor(self.m_alphaYSlider:getMax() / 2 - self.m_alphaYSlider:getValue()) * 10
		local var_14_2 = math.floor(self.m_alphaWSlider:getValue() * (display.width / self.m_alphaYSlider:getMax()))
		local var_14_3 = math.floor(self.m_alphaHSlider:getValue() * (display.height / self.m_alphaHSlider:getMax()))
		local var_14_4 = math.floor(self.m_alphaDisSlider:getValue() * 10)

		self._showKnight:setAlphaRect(3, cc.rect(var_14_0, var_14_1, var_14_2, var_14_3), var_14_4)
		self.m_alphaRectTxt:setText("Rect: " .. var_14_0 .. "," .. var_14_1 .. "," .. var_14_2 .. "," .. var_14_3)
		self.m_alphaDistanceTxt:setText("Distance:" .. var_14_4)
	end

	if self._showSuccuba then
		local var_14_5 = math.floor(self.m_alphaXSlider:getMax() / 2 - self.m_alphaXSlider:getValue()) * 10
		local var_14_6 = math.floor(self.m_alphaYSlider:getMax() / 2 - self.m_alphaYSlider:getValue()) * 10
		local var_14_7 = math.floor(self.m_alphaWSlider:getValue() * (display.width / self.m_alphaYSlider:getMax()))
		local var_14_8 = math.floor(self.m_alphaHSlider:getValue() * (display.height / self.m_alphaHSlider:getMax()))
		local var_14_9 = math.floor(self.m_alphaDisSlider:getValue() * 10)

		self._showSuccuba:setAlphaRect(3, cc.rect(var_14_5, var_14_6, var_14_7, var_14_8), var_14_9)
		self.m_alphaRectTxt:setText("Rect: " .. var_14_5 .. "," .. var_14_6 .. "," .. var_14_7 .. "," .. var_14_8)
		self.m_alphaDistanceTxt:setText("Distance:" .. var_14_9)
	end
end

function DebugKnightComp:_onReverseCheckBtnClick(arg_15_1)
	local var_15_0 = self.m_reverseCheckBtn:isSelected()

	if self._showKnight then
		self._showKnight:setFlip(not var_15_0)
	elseif self._showSuccuba then
		self._showSuccuba:setFlip(not var_15_0)
	end
end

function DebugKnightComp:getMovePosByLength(arg_16_1, arg_16_2)
	local var_16_0 = math.sqrt(arg_16_1 * arg_16_1 + arg_16_2 * arg_16_2)

	if var_16_0 > DebugConst.MOVE_TOUCH_MAX then
		arg_16_1 = arg_16_1 * DebugConst.MOVE_TOUCH_MAX / var_16_0
		arg_16_2 = arg_16_2 * DebugConst.MOVE_TOUCH_MAX / var_16_0
	end

	return arg_16_1, arg_16_2
end

function DebugKnightComp:_onBgShowSelChanged()
	self._showBg = self.m_bgShowController:getSelectedIndex() == 1

	if self._isFromInfo then
		self:updateMainKnight(true)
	end
end

function DebugKnightComp:_onReadCfgSelChanged()
	self._readCfg = self.m_readCfgController:getSelectedIndex() == 1

	if self._isFromInfo then
		self:updateMainKnight(true)
	end
end

function DebugKnightComp:_onScaleAddClick()
	self:updateKnightScale(DebugConst.SCALE_STEP)
end

function DebugKnightComp:_onScaleMinClick()
	self:updateKnightScale(-DebugConst.SCALE_STEP)
end

function DebugKnightComp:_onxMinClick()
	self:updateKnightPos(-DebugConst.MOVE_X_STEP, 0)
end

function DebugKnightComp:_onxAddClick()
	self:updateKnightPos(DebugConst.MOVE_X_STEP, 0)
end

function DebugKnightComp:_onyMinClick()
	self:updateKnightPos(0, DebugConst.MOVE_Y_STEP)
end

function DebugKnightComp:_onyAddClick()
	self:updateKnightPos(0, -DebugConst.MOVE_Y_STEP)
end

function DebugKnightComp:updateKnightScale(arg_25_1)
	self._curScale = g.core.utils.Number.formatNumberByLimit(self._curScale + arg_25_1, 0, 5)

	self.m_knightHolderComp:setScale(self._curScale)
	self.m_succubaHolderComp:setScale(self._curScale)
	self.m_scaleText:setText(self._curScale)
	self.m_scaleSlider:setValue(self._curScale * 100 / (DebugConst.SCALE_MAX - DebugConst.SCALE_MIN))
end

function DebugKnightComp:updateKnightPos(arg_26_1, arg_26_2)
	local var_26_0 = self.m_knightHolderComp:getPosition()

	self.m_knightHolderComp:setPosition(var_26_0.x + arg_26_1, var_26_0.y + arg_26_2)
	self.m_succubaHolderComp:setPosition(var_26_0.x + arg_26_1, var_26_0.y + arg_26_2)
	self.m_posText:setText(var_26_0.x + arg_26_1 - self._initHolderPos.x .. "," .. -(var_26_0.y + arg_26_2 - self._initHolderPos.y))
	self.m_touchPos:setPosition(self._initTouchPos.x + (var_26_0.x + arg_26_1 - self._initHolderPos.x) / DebugConst.MOVE_SPINE_GAP, self._initTouchPos.y + (var_26_0.y + arg_26_2 - self._initHolderPos.y) / DebugConst.MOVE_SPINE_GAP)
end

return DebugKnightComp
