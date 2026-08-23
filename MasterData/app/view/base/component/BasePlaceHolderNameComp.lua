local var_0_0 = g.core.const.ConstMgr.SpineConst
local BasePlaceHolderNameComp = class("BasePlaceHolderNameComp", require("app.fairyGUI.base.UI_BasePlaceHolderNameComp"))

BasePlaceHolderNameComp.MOVE_SPEED = 150
BasePlaceHolderNameComp.STAY_TIME_MIN = 2000
BasePlaceHolderNameComp.STAY_TIME_MAX = 4000
BasePlaceHolderNameComp.MOVE_RANGE = {
	max = 80,
	min = -120
}

function BasePlaceHolderNameComp:ctor()
	self._knight = nil
	self._knightName = nil
	self._params = nil
	self._isMain = false
	self._maxLength = 0
	self._originalPos = {}
	self._roleAction = {}
	self._playerAction = {}
	self._moveAction = {}
	self._beginX = 0
	self._moveTime = 0
	self._isLineUp = false
	self._titlePic = nil
	self._isMoving = false
	self._hightLightEffect = nil

	self.m_showStarController:setSelectedIndex(0)

	self._knightScale = 1

	self.m_showStarController:setSelectedPage(tostring(self._knightScale))
end

function BasePlaceHolderNameComp:updateMainRole(arg_2_1, arg_2_2)
	self._isMain = true
	self._isLineUp = arg_2_1 or false
	self._originalPos = self:getPosition()

	local var_2_0 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot((g.core.model.User:packUser()))

	var_2_0.callback = handler(self, self._onClickKnight)
	self._knight = require("app.view.common.CommonKnight").new(var_2_0)

	self.m_playerComp:removeChildren()
	self.m_playerComp:addChild(self._knight)

	local var_2_1 = g.core.config.knight_info.get((g.core.model.User:getBaseId()))
	local var_2_2 = g.core.model.User:getName()
	local var_2_3, var_2_4 = g.core.model.User.knightsData:getMainKnight():getAdvStageAndLevel()

	if arg_2_2 then
		if var_2_3 > 0 then
			var_2_2 = var_2_2 .. "+" .. var_2_3
		end

		self.m_showStarController:setSelectedIndex(var_2_1.star > 0 and 1 or 0)
		self.m_starTxt:setText(var_2_1.star)
	else
		self.m_lordImg:setVisible(false)
	end

	self.m_nameTxt:setText(var_2_2)
	self.m_pheffect:removeAllEffect()
	self.m_pheffect:addEffectSpine({
		name = "battle_guanghuan"
	})
end

function BasePlaceHolderNameComp:showServerByUser(arg_3_1)
	local var_3_0, var_3_1 = g.core.lang:getFormatServerName(arg_3_1.server_name)

	self.m_serverTxt:setText(var_3_1)
end

function BasePlaceHolderNameComp:setHightLight(arg_4_1)
	if arg_4_1 then
		if self._hightLightEffect == nil then
			self._hightLightEffect = self.m_effectNode:addEffectSpine({
				isLoop = false,
				name = "eff_ui_easterEgg_notice"
			})

			self.m_effectNode:setPosition(54, 113)
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_APPEAR)
		end

		if not self._hightLightEffect:isVisible() then
			self._hightLightEffect:setAnimation(0, "play", false)
			self._hightLightEffect:setVisible(true)
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.EASTER_EGG_APPEAR)
		end
	elseif self._hightLightEffect ~= nil then
		self._hightLightEffect:setVisible(false)
	end
end

function BasePlaceHolderNameComp:_initRolePlayAction()
	self._playerAction = {}

	table.insert(self._playerAction, var_0_0.LOOP_ACTION.IDLE)
	table.insert(self._playerAction, var_0_0.ACTION.SHOW)

	self._moveAction = {}

	table.insert(self._moveAction, var_0_0.LOOP_ACTION.RUN)
	table.insert(self._moveAction, var_0_0.LOOP_ACTION.RUN)
end

function BasePlaceHolderNameComp:playStaticAction()
	self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)
end

function BasePlaceHolderNameComp:playShowAction()
	self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)
end

function BasePlaceHolderNameComp:stopCurActions()
	self:stopAllFGActions()
	self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)
end

function BasePlaceHolderNameComp:playActionFromLeft()
	self:stopAllFGActions()
	self._knight:playAction(var_0_0.LOOP_ACTION.RUN)

	local var_9_0 = self:displayObject():getPositionX()

	self._knight:setScaleX(self._knightScale)
	self._knight:setScaleX(self._knightScale)
	self:runFGAction((fgui.FSequence:create(fgui.FMoveTo:create((self._maxLength + 200) / self:_getRandomSpeed(), cc.p(self._maxLength + 200, self._originalPos.y)), fgui.FCallFunc:create(handler(self, function()
		self:removeFromParent()
	end)))))
end

function BasePlaceHolderNameComp:onMove(arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	local function var_11_1()
		if arg_11_1 and #arg_11_1 > 0 then
			self:playActionFromTarget(table.remove(arg_11_1, 1), var_11_1)
		elseif arg_11_2 then
			arg_11_2()
		end
	end

	table.remove(arg_11_1, 1)
	var_11_1()
end

function BasePlaceHolderNameComp:playActionFromTarget(arg_13_1, arg_13_2)
	self:stopAllFGActions()

	self._isMoving = false

	if not arg_13_1 then
		return
	end

	local var_13_0 = self:getX()
	local var_13_1 = cc.pGetDistance(cc.p(var_13_0, (self:getY())), cc.p(arg_13_1.x, arg_13_1.y))

	if var_13_1 < 2 then
		return
	end

	local var_13_2 = var_13_1 / 400

	if var_13_0 < arg_13_1.x then
		self._knight:setScaleX(1)

		if self._hightLightEffect then
			self.m_effectNode:setPosition(74, 113)
			self.m_effectNode:setRotation(-15)
		end
	elseif var_13_0 > arg_13_1.x then
		self._knight:setScaleX(-1)

		if self._hightLightEffect then
			self.m_effectNode:setPosition(34, 113)
			self.m_effectNode:setRotation(15)
		end
	end

	if not self._isMoving then
		self._knight:playAction(var_0_0.LOOP_ACTION.RUN)

		self._isMoving = true

		self:dispatchCompEvent("MainRoleMoving")
	end

	self:runFGAction((fgui.FSequence:create(fgui.FMoveTo:create(var_13_2, cc.p(arg_13_1.x, arg_13_1.y)), fgui.FCallFunc:create(handler(self, function()
		if arg_13_2 then
			self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)

			self._isMoving = false

			arg_13_2()
		end

		if self._hightLightEffect then
			self.m_effectNode:setPosition(54, 113)
			self.m_effectNode:setRotation(0)
		end

		self:dispatchCompEvent("MainRoleMove_stop")
	end)))))
end

function BasePlaceHolderNameComp:playActionFromRight()
	self:stopAllFGActions()
	self._knight:playAction(var_0_0.LOOP_ACTION.RUN)

	local var_15_0 = self:displayObject():getPositionX()

	self._knight:setScaleX(-self._knightScale)
	self._knight:setScaleX(-self._knightScale)
	self:runFGAction((fgui.FSequence:create(fgui.FMoveTo:create((display.width + 200) / self:_getRandomSpeed(), cc.p(-100, self._originalPos.y)), fgui.FCallFunc:create(handler(self, function()
		self:removeFromParent()
	end)))))
end

function BasePlaceHolderNameComp:randomMoveActions()
	self:stopAllFGActions()

	local var_17_0 = self:displayObject():getPositionX()
	local var_17_1 = self:_generateRandomX()

	self._knight:setScaleX((var_17_0 < var_17_1 or nil) and (self._knightScale or -self._knightScale))
	self._knight:playAction(self._moveAction[math.random(1, #self._moveAction)])

	local var_17_2 = self._playerAction[math.random(1, #self._playerAction)]
	local var_17_3 = {}

	table.insert(var_17_3, (fgui.FMoveTo:create(math.abs(var_17_1 - var_17_0) / BasePlaceHolderNameComp.MOVE_SPEED, {
		x = var_17_1,
		y = self._originalPos.y
	})))
	table.insert(var_17_3, (fgui.FCallFunc:create(handler(self, function()
		self._knight:playAction(var_17_2, handler(self, function()
			self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)
		end))
	end))))
	table.insert(var_17_3, (fgui.FDelayTime:create(math.random(BasePlaceHolderNameComp.STAY_TIME_MIN, BasePlaceHolderNameComp.STAY_TIME_MAX) / 1000)))
	table.insert(var_17_3, (fgui.FCallFunc:create(handler(self, self.randomMoveActions))))
	self:runFGAction((fgui.FSequence:create(var_17_3)))
end

function BasePlaceHolderNameComp:_generateRandomX()
	local var_20_0 = self._originalPos.x + BasePlaceHolderNameComp.MOVE_RANGE.min
	local var_20_1

	if self._originalPos.x + BasePlaceHolderNameComp.MOVE_RANGE.min < 0 then
		var_20_1 = -var_20_0 or 0
	end

	return math.random(var_20_0 + var_20_1, self._originalPos.x + BasePlaceHolderNameComp.MOVE_RANGE.max + var_20_1) - var_20_1
end

function BasePlaceHolderNameComp:_getRandomMoveX()
	return math.random(-display.width / 2, display.width / 2) + self:getPosition().x
end

function BasePlaceHolderNameComp:_getRandomSpeed()
	return (math.random(250, 300))
end

function BasePlaceHolderNameComp:playRandomMoveActions()
	self:runFGAction(self._roleAction[math.random(1, 3)])
end

function BasePlaceHolderNameComp:_onClickKnight()
	if not self._isMain then
		self:dispatchCompEvent("PlayerKnightClick", self._params.user.id)
	elseif self._isLineUp then
		self:dispatchCompEvent("MainRoleClick")
	end
end

function BasePlaceHolderNameComp:getCurClickedKnightId()
	return self._params.user.id
end

function BasePlaceHolderNameComp:getClickUserSnapshot()
	return self._params.user
end

function BasePlaceHolderNameComp:setRolePosition(arg_27_1)
	local var_27_0 = self:getPosition()

	self:setPosition(var_27_0.x + arg_27_1, var_27_0.y)
end

function BasePlaceHolderNameComp:getRolePosition()
	return self:getPosition()
end

function BasePlaceHolderNameComp:setMainRoleX(arg_29_1)
	self:setX(arg_29_1)
end

function BasePlaceHolderNameComp:getMainRoleX()
	return self:displayObject():getPositionX()
end

function BasePlaceHolderNameComp:getCurMoveTime()
	return self._moveTime
end

function BasePlaceHolderNameComp:playRunAction(arg_32_1)
	self._knight:setScale(arg_32_1 * self._knightScale, self._knightScale)

	if self._knight:checkAction(var_0_0.LOOP_ACTION.RUN) then
		self._knight:playAction(var_0_0.LOOP_ACTION.RUN)
	else
		self._knight:playAction(var_0_0.LOOP_ACTION.RUN)
	end
end

function BasePlaceHolderNameComp:isPlayRunAction()
	return self._knight:getActionName() == var_0_0.LOOP_ACTION.RUN
end

function BasePlaceHolderNameComp:playReadyAction(arg_34_1)
	self._knight:setScale(arg_34_1 * self._knightScale, self._knightScale)

	if self._knight:checkAction(var_0_0.LOOP_ACTION.IDLE) then
		self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)
	else
		self._knight:playAction(var_0_0.LOOP_ACTION.IDLE)
	end
end

function BasePlaceHolderNameComp:getCurActionName()
	return self._knight:getActionName()
end

function BasePlaceHolderNameComp:checkAction(arg_36_1)
	return self._knight:checkAction(arg_36_1)
end

function BasePlaceHolderNameComp:setKnightScale(arg_37_1)
	self._knight:setScale(arg_37_1, arg_37_1)
end

function BasePlaceHolderNameComp:getKnightScale()
	local var_38_0 = self._knight:getScale()

	return var_38_0.x, var_38_0.y
end

function BasePlaceHolderNameComp:playAction(arg_39_1, arg_39_2, arg_39_3)
	self._knight:playAction(arg_39_1, arg_39_2, arg_39_3)
end

function BasePlaceHolderNameComp:setDefineScale(arg_40_1)
	self._knightScale = arg_40_1

	self.m_scaleController:setSelectedPage(tostring(arg_40_1))
end

function BasePlaceHolderNameComp:setKnightScaleX(arg_41_1)
	self._knight:setScaleX(arg_41_1)
end

function BasePlaceHolderNameComp:showSelfHint(arg_42_1)
	self:setCtrlState("show_selfHint", {
		index = checkbool(arg_42_1) and 1 or 0
	})
end

function BasePlaceHolderNameComp:showLord(arg_43_1)
	self.m_lordImg:setVisible(arg_43_1)
end

function BasePlaceHolderNameComp:getSpineAnimName()
	return self._knight:getKnightSpine():getCurAnimationName()
end

return BasePlaceHolderNameComp
