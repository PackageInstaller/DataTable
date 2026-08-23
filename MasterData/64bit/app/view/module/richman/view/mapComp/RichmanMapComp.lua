local var_0_0 = g.core.model.User.richmanData
local RichmanTools = require("app.view.module.richman.const.RichmanTools")
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local RichmanMapComp = class("RichmanMapComp", require("app.fairyGUI.richman.UI_RichmanMapComp"))

function RichmanMapComp:ctor()
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
	self._curRichNum = 0
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

function RichmanMapComp:initStartPos(arg_2_1)
	local var_2_0 = self.m_diceHolder:globalToLocal(cc.p(arg_2_1.x, display.height - arg_2_1.y))

	self._diceStartX = var_2_0.x

	local var_2_1, var_2_2 = RichmanTools.findParabolaCoefficients(var_2_0, 1.5)

	self._A_B = {
		A = var_2_1,
		B = var_2_2
	}
end

function RichmanMapComp:updateMapState(arg_3_1, arg_3_2)
	self.m_worldComp:updateMapState()

	if arg_3_1 then
		self._lockActionState = true
		self._animFinishCF = arg_3_2

		self:setMoveWithRole(false)
		self:checkBuildLevelUpAnim(handler(self, self.onMoveAnimEnd))
	end
end

function RichmanMapComp:_onDebugBtnClick()
	self:roleMove(tonumber(self.m_debugTxt:getText()) or 1)
end

function RichmanMapComp:onLoad()
	self._richmanMoveScheduler = self._richmanMoveScheduler or self:newSchedule(handler(self, self.onTickUpdate), 0)
end

function RichmanMapComp:_onTouchBegin(arg_6_1)
	self._lastPos = arg_6_1:getInput():getPosition()

	arg_6_1:captureTouch()
end

function RichmanMapComp:_onTouchMove(arg_7_1)
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

function RichmanMapComp:_onTouchEnd()
	self._lastPos = nil
end

function RichmanMapComp:onMoveAnimEnd()
	self._lockActionState = false

	var_0_0:setInDiceAnim(false)

	if self._animFinishCF then
		self._animFinishCF()

		self._animFinishCF = nil
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RICH_MAN_ROLL_FINISH)
end

function RichmanMapComp:startRich(arg_10_1, arg_10_2)
	if self._richEff then
		return
	end

	self._animFinishCF = arg_10_2
	self._curRichNum = arg_10_1
	self._curDicePosX = self._diceStartX
	self._speedAdd = 0
	self._richEff = self.m_diceHolder:addEffectSpine({
		anim = "turn",
		scale = 0.3,
		isLoop = true,
		name = "dice",
		x = self._curDicePosX,
		y = self:getDiceYPos(self._curDicePosX)
	})
end

function RichmanMapComp:getDiceYPos(arg_11_1)
	return self._A_B.A * arg_11_1 * arg_11_1 + self._A_B.B * arg_11_1
end

function RichmanMapComp:_onAnimationEnd(arg_12_1)
	if arg_12_1.type == "complete" then
		self:roleMove(self._curRichNum)

		self._curRichNum = 0

		self._richEff:removeFromParent()

		self._richEff = nil
	end
end

function RichmanMapComp:roleMove(arg_13_1)
	self._lockActionState = true

	self:setMoveWithRole(false)

	local var_13_0 = self.m_worldComp:getRolePos()
	local var_13_1 = {}
	local var_13_2 = self:fitPositionInRange(cc.p(display.cx - var_13_0.x, display.cy - var_13_0.y))

	table.insert(var_13_1, fgui.FMoveTo:create(cc.pGetDistance(self.m_worldComp:getPosition(), var_13_2) / 1200, var_13_2))
	table.insert(var_13_1, fgui.FCallFunc:create(handler(self, function(arg_14_0)
		arg_14_0:setMoveWithRole(true)
		arg_14_0.m_worldComp:roleMove(arg_13_1, handler(arg_14_0, arg_14_0.onMoveAnimEnd))
	end)))
	self.m_worldComp:runFGAction(fgui.FSequence:create(var_13_1))
end

function RichmanMapComp:checkBuildLevelUpAnim(arg_15_1)
	local var_15_0 = {}
	local var_15_1 = var_0_0:getMapLevel()
	local var_15_2 = var_0_0:getBuildData()

	for iter_15_0, iter_15_1 in ipairs(RichmanConst.BUILD) do
		local var_15_3 = RichmanConst.BUILD_TYPE[iter_15_1]

		if var_15_2:getBuildLevelByMapLvAndType(var_15_1 - 1, RichmanConst.BUILD_TYPE[iter_15_1]) < var_15_2:getBuildLevelByMapLvAndType(var_15_1, RichmanConst.BUILD_TYPE[iter_15_1]) then
			local var_15_4 = self.m_worldComp:getBuildPosByType(RichmanConst.BUILD_TYPE[iter_15_1])

			table.insert(var_15_0, fgui.FMoveTo:create(0.5, (self:fitPositionInRange(cc.p(display.cx - var_15_4.x, display.cy - var_15_4.y)))))
			table.insert(var_15_0, fgui.FCallFunc:create(handler(self, function(arg_16_0)
				arg_16_0:playBuildLevelUpAnim(var_15_3)
			end)))
			table.insert(var_15_0, fgui.FDelayTime:create(1))
		end
	end

	table.insert(var_15_0, fgui.FCallFunc:create(handler(self, function(arg_17_0)
		arg_15_1()
		arg_17_0:playAllGridLevelUpAnim()
	end)))
	self.m_worldComp:runFGAction(fgui.FSequence:create(var_15_0))
end

function RichmanMapComp:playAllGridLevelUpAnim()
	self.m_worldComp:playAllGridLevelUpAnim()
end

function RichmanMapComp:playBuildLevelUpAnim(arg_19_1)
	self.m_worldComp:playBuildLevelUpAnim(arg_19_1)
end

function RichmanMapComp:fitPositionInRange(arg_20_1)
	local var_20_0 = arg_20_1.x
	local var_20_1 = arg_20_1.y

	if arg_20_1.x > self._moveRange.maxX then
		var_20_0 = self._moveRange.maxX
	elseif var_20_0 < self._moveRange.mimX then
		var_20_0 = self._moveRange.mimX
	end

	if var_20_1 > self._moveRange.maxY then
		var_20_1 = self._moveRange.maxY
	elseif var_20_1 < self._moveRange.minY then
		var_20_1 = self._moveRange.minY
	end

	return cc.p(var_20_0, var_20_1)
end

function RichmanMapComp:movePositionDir(arg_21_1)
	local var_21_0 = self.m_worldComp:getPosition()

	self:movePosition(cc.p(var_21_0.x + arg_21_1.x, var_21_0.y + arg_21_1.y))
end

function RichmanMapComp:movePosition(arg_22_1)
	self.m_worldComp:setPosition((self:fitPositionInRange(arg_22_1)))
end

function RichmanMapComp:setMoveWithRole(arg_23_1)
	self._followRole = arg_23_1
end

function RichmanMapComp:onTickUpdate(arg_24_1, arg_24_2)
	if self._followRole then
		local var_24_0 = self.m_worldComp:getRolePos()

		self:movePosition(cc.p(display.cx - var_24_0.x, display.cy - var_24_0.y))
	end

	if not self._lastCheckPos or cc.pGetDistance(self._lastCheckPos, self.m_worldComp:getPosition()) > 100 then
		self._lastCheckPos = self.m_worldComp:getPosition()

		self.m_worldComp:checkVisibleGrid()
	end

	if self._curDicePosX > 0 and self._richEff and self._curRichNum > 0 then
		self._curDicePosX = math.max(0, self._curDicePosX - (RichmanConst.RUN_DICE_SPEED * arg_24_2 + self._speedAdd))
		self._speedAdd = self._speedAdd + RichmanConst.RUN_DICE_SPEED_ADD * arg_24_2 * (self:getDiceYPos(self._curDicePosX) > self._richEff:getPositionY() and 1 or -1)

		self._richEff:setPosition(self._curDicePosX, self:getDiceYPos(self._curDicePosX))

		if self._curDicePosX == 0 then
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Touzi)
			self._richEff:setAnimation(0, tostring(self._curRichNum), false)
			self._richEff:addSpineEventListener(handler(self, self._onAnimationEnd))
		end
	end

	if not self._lastUpdateRewardTime or g.core.common.ServerTime:getTime() - self._lastUpdateRewardTime > RichmanConst.HANG_UP_UPDATE_TIME then
		self._lastUpdateRewardTime = g.core.common.ServerTime:getTime()

		self.m_worldComp:updateMapBuild()
	end
end

function RichmanMapComp:showPlayerHeardReward(arg_25_1)
	self.m_worldComp:showPlayerHeardReward(arg_25_1)
end

function RichmanMapComp:showBuildHeardReward(arg_26_1, arg_26_2)
	self.m_worldComp:showBuildHeardReward(arg_26_1, arg_26_2)
end

function RichmanMapComp:playTickEventEffect(arg_27_1)
	self.m_worldComp:playTickEventEffect(arg_27_1)
end

function RichmanMapComp:onUnload()
	if self._richmanMoveScheduler then
		self:cancelSchedule(self._richmanMoveScheduler)

		self._richmanMoveScheduler = nil
	end
end

return RichmanMapComp
