local var_0_0 = g.core.model.User.monopolyDataMgr
local RichmanTools = require("app.view.module.richman.const.RichmanTools")
local MonopolyConst = require("app.view.module.monopoly.const.MonopolyConst")
local MonopolyMapComp = class("MonopolyMapComp", require("app.fairyGUI.monopoly.UI_MonopolyMapComp"))

function MonopolyMapComp:ctor()
	self._lockActionState = false

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))

	self._moveRange = {
		maxX = 0,
		maxY = 0,
		mimX = display.width - self.m_worldComp:getWidth(),
		minY = display.height - self.m_worldComp:getHeight()
	}
	self._monopolyData = var_0_0:getMonopolyData()
	self._curRunNum = 0
	self._curRichEvents = nil
	self._curRunDice = 0
	self._curDicePosX = 0
	self._diceStartX = 0
	self._A_B = {
		A = 0,
		B = 0
	}

	self:setMoveWithRole(true)
	self.m_debugBtn:addClickListener(handler(self, self._onDebugBtnClick))

	local var_1_0 = self.m_worldComp:getRolePos()

	self:movePosition(cc.p(display.cx - var_1_0.x, display.cy - var_1_0.y))
end

function MonopolyMapComp:initStartPos(arg_2_1)
	local var_2_0 = self.m_diceHolder:globalToLocal(cc.p(arg_2_1.x, display.height - arg_2_1.y))

	self._diceStartX = var_2_0.x

	local var_2_1, var_2_2 = RichmanTools.findParabolaCoefficients(var_2_0, 1.5)

	self._A_B = {
		A = var_2_1,
		B = var_2_2
	}
end

function MonopolyMapComp:updateMapState(arg_3_1, arg_3_2)
	self.m_worldComp:updateMapState()

	if arg_3_1 then
		self._lockActionState = true
		self._animFinishCF = arg_3_2

		self:setMoveWithRole(false)
	end
end

function MonopolyMapComp:_onDebugBtnClick()
	return
end

function MonopolyMapComp:onLoad()
	self._MonopolyMoveScheduler = self._MonopolyMoveScheduler or self:newSchedule(handler(self, self.onTickUpdate), 0)
end

function MonopolyMapComp:_onTouchBegin(arg_6_1)
	self._lastPos = arg_6_1:getInput():getPosition()

	arg_6_1:captureTouch()
end

function MonopolyMapComp:_onTouchMove(arg_7_1)
	if self._lockActionState then
		return
	end

	if not self._lastPos then
		return
	end

	self:setMoveWithRole(false)

	local var_7_0 = arg_7_1:getInput():getPosition()
	local var_7_1 = cc.p(0, 0)

	var_7_1.x = var_7_0.x - self._lastPos.x
	var_7_1.y = var_7_0.y - self._lastPos.y
	self._lastPos = var_7_0

	self:movePositionDir(var_7_1)
end

function MonopolyMapComp:_onTouchEnd()
	self._lastPos = nil
end

function MonopolyMapComp:onMoveAnimEnd()
	self:checkDiceAnim()
end

function MonopolyMapComp:startRich(arg_10_1, arg_10_2)
	if self._richEff then
		return
	end

	self._animFinishCF = arg_10_2
	self._curRunNum = 0
	self._curRichEvents = arg_10_1
	self._allAnimList = self._monopolyData:getAnimListByRollResult(arg_10_1)

	self:checkDiceAnim()
end

function MonopolyMapComp:checkDiceAnim()
	self._curRunNum = self._curRunNum + 1

	if self._allAnimList[self._curRunNum] then
		self:checkAndPlayAnim(self._allAnimList[self._curRunNum])
	end
end

function MonopolyMapComp:checkAndPlayAnim(arg_12_1)
	if arg_12_1.type == "runDice" then
		self:doRunDice(arg_12_1)
		self:dispatchCompEvent("MONOPOLY_RUN_DICE", arg_12_1)
	elseif arg_12_1.type == "addExp" then
		self:doAddExp(arg_12_1)
	elseif arg_12_1.type == "exMove" then
		self:doExMove(arg_12_1)
	elseif arg_12_1.type == "animStartPos" then
		self:doStartAnim(arg_12_1)
	elseif arg_12_1.type == "reward" then
		self:doGetReward(arg_12_1)
	elseif arg_12_1.type == "boxRefresh" then
		self:doBoxRefresh(arg_12_1)
	elseif arg_12_1.type == "animEnd" then
		if self._animFinishCF then
			self._animFinishCF()

			self._animFinishCF = nil
			self._lockActionState = false

			self._monopolyData:setInDiceAnim(false)
		end

		self:dispatchCompEvent("MONOPOLY_RUN_DICE_FINISH")
	end
end

function MonopolyMapComp:setAnimSkip()
	self._allAnimList = {}

	if self._richEff then
		self._curRunDice = 0

		self._richEff:removeFromParent()

		self._richEff = nil
	end

	self.m_worldComp:stopAllFAction()
	self.m_worldComp:setAnimSkip()
	self:checkAndPlayAnim({
		type = "animEnd"
	})
end

function MonopolyMapComp:doBoxRefresh(arg_14_1)
	self.m_worldComp:playBoxRewardAndChangeAnim(handler(self, self.checkDiceAnim), arg_14_1)
end

function MonopolyMapComp:doRunDice(arg_15_1)
	self._curDicePosX = self._diceStartX
	self._speedAdd = 0
	self._curRunDice = arg_15_1.step
	self._richEff = self.m_diceHolder:addEffectSpine({
		scale = 0.3,
		isLoop = true,
		name = "monopoly_succuba",
		anim = "turn",
		x = self._curDicePosX,
		y = self:getDiceYPos(self._curDicePosX)
	})
end

function MonopolyMapComp:doAddExp(arg_16_1)
	self.m_worldComp:playGridLevelUpAnim(arg_16_1.grid, handler(self, self.checkDiceAnim), arg_16_1)
end

function MonopolyMapComp:doExMove(arg_17_1)
	self.m_worldComp:playExMoveEff(arg_17_1)
	self.m_worldComp:roleMove({
		start = self._allAnimList[self._curRunNum].startPos,
		step = self._allAnimList[self._curRunNum].step
	}, handler(self, self.checkDiceAnim))
end

function MonopolyMapComp:doStartAnim(arg_18_1)
	self:checkDiceAnim()
end

function MonopolyMapComp:doGetReward(arg_19_1)
	self.m_worldComp:playAwardEff(arg_19_1, handler(self, self.checkDiceAnim))
end

function MonopolyMapComp:getDiceYPos(arg_20_1)
	return self._A_B.A * arg_20_1 * arg_20_1 + self._A_B.B * arg_20_1
end

function MonopolyMapComp:_onAnimationEnd(arg_21_1)
	if arg_21_1.type == "complete" then
		if self._allAnimList[self._curRunNum] then
			self:roleMove({
				start = self._allAnimList[self._curRunNum].startPos,
				step = self._allAnimList[self._curRunNum].moveStep
			})
		end

		self._curRunDice = 0

		self._richEff:removeFromParent()

		self._richEff = nil
	end
end

function MonopolyMapComp:roleMove(arg_22_1)
	self._lockActionState = true

	self:setMoveWithRole(false)
	self:setMoveWithRole(true)
	self.m_worldComp:roleMove(arg_22_1, handler(self, self.onMoveAnimEnd))
end

function MonopolyMapComp:fitPositionInRange(arg_23_1)
	local var_23_0 = arg_23_1.x
	local var_23_1 = arg_23_1.y

	if arg_23_1.x > self._moveRange.maxX then
		var_23_0 = self._moveRange.maxX
	elseif var_23_0 < self._moveRange.mimX then
		var_23_0 = self._moveRange.mimX
	end

	if var_23_1 > self._moveRange.maxY then
		var_23_1 = self._moveRange.maxY
	elseif var_23_1 < self._moveRange.minY then
		var_23_1 = self._moveRange.minY
	end

	return cc.p(var_23_0, var_23_1)
end

function MonopolyMapComp:movePositionDir(arg_24_1)
	local var_24_0 = self.m_worldComp:getPosition()

	self:movePosition(cc.p(var_24_0.x + arg_24_1.x, var_24_0.y + arg_24_1.y))
end

function MonopolyMapComp:movePosition(arg_25_1)
	return
end

function MonopolyMapComp:setMoveWithRole(arg_26_1)
	self._followRole = arg_26_1
end

function MonopolyMapComp:onTickUpdate(arg_27_1, arg_27_2)
	if self._followRole then
		local var_27_0 = self.m_worldComp:getRolePos()

		self:movePosition(cc.p(display.cx - var_27_0.x, display.cy - var_27_0.y))
	end

	if not self._lastCheckPos or cc.pGetDistance(self._lastCheckPos, self.m_worldComp:getPosition()) > 100 then
		self._lastCheckPos = self.m_worldComp:getPosition()

		self.m_worldComp:checkVisibleGrid()
	end

	if self._curDicePosX > 0 and self._richEff and self._curRunDice > 0 then
		self._curDicePosX = math.max(0, self._curDicePosX - (MonopolyConst.RUN_DICE_SPEED * arg_27_2 + self._speedAdd))
		self._speedAdd = self._speedAdd + MonopolyConst.RUN_DICE_SPEED_ADD * arg_27_2 * (self:getDiceYPos(self._curDicePosX) > self._richEff:getPositionY() and 1 or -1)

		self._richEff:setPosition(self._curDicePosX, self:getDiceYPos(self._curDicePosX))

		if self._curDicePosX == 0 then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Touzi)
			self._richEff:setAnimation(0, tostring(self._curRunDice), false)
			self._richEff:addSpineEventListener(handler(self, self._onAnimationEnd))
		end
	end
end

function MonopolyMapComp:showPlayerHeardReward(arg_28_1)
	self.m_worldComp:showPlayerHeardReward(arg_28_1)
end

function MonopolyMapComp:showBuildHeardReward(arg_29_1, arg_29_2)
	self.m_worldComp:showBuildHeardReward(arg_29_1, arg_29_2)
end

function MonopolyMapComp:onUnload()
	if self._MonopolyMoveScheduler then
		self:cancelSchedule(self._MonopolyMoveScheduler)

		self._MonopolyMoveScheduler = nil
	end
end

return MonopolyMapComp
