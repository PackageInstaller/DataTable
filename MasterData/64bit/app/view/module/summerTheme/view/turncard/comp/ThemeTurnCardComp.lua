local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemeTurnCardComp = class("ThemeTurnCardComp", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnCardComp"))

function ThemeTurnCardComp:ctor()
	self._state = 0
	self._tagNum = nil
	self._themeValue = 0

	self:addClickListener(handler(self, self._onClickCard))
	self.m_stateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onStateCtrlChanged))
end

function ThemeTurnCardComp:_onStateCtrlChanged()
	self:_updateResIcon()
end

function ThemeTurnCardComp:updateIcon(arg_3_1, arg_3_2, arg_3_3)
	self._index = arg_3_2
	self._tagNum = arg_3_1
	self._themeValue = arg_3_3

	self.m_resLoader:setURL(g.core.common.Path:getThemeTurnCardIcon(arg_3_1, arg_3_3))
	self:setCardState(var_0_0.TURNCARD_STATE.BACK)
	self.m_bgLoader:setURL(var_0_0.TURNCARD_BG_IMG[self._themeValue])
	self:_updateResIcon()
end

function ThemeTurnCardComp:_updateResIcon()
	local var_4_0 = self.m_stateController:getSelectedIndex()

	if var_4_0 == var_0_0.TURNCARD_STATE.BACK then
		self:setIcon(var_0_0.TURNCARD_BACK_IMG[self._themeValue] or var_0_0.TURNCARD_BACK_IMG[1])
	elseif var_4_0 == var_0_0.TURNCARD_STATE.FRONT then
		self:setIcon(var_0_0.TURNCARD_FRONT_IMG[self._themeValue] or var_0_0.TURNCARD_FRONT_IMG[1])
	elseif var_4_0 == var_0_0.TURNCARD_STATE.RIGHT then
		self:setIcon(var_0_0.TURNCARD_FRONT_IMG[self._themeValue] or var_0_0.TURNCARD_FRONT_IMG[1])
	end
end

function ThemeTurnCardComp:isRight()
	return self._state == var_0_0.TURNCARD_STATE.RIGHT
end

function ThemeTurnCardComp:isBack()
	return self._state == var_0_0.TURNCARD_STATE.BACK
end

function ThemeTurnCardComp:setCardState(arg_7_1)
	self._state = arg_7_1

	self:setTouchable(arg_7_1 == var_0_0.TURNCARD_STATE.BACK)

	if arg_7_1 == var_0_0.TURNCARD_STATE.RIGHT then
		self:playRightAnimation()
	else
		self.m_stateController:setSelectedIndex(arg_7_1)
	end
end

function ThemeTurnCardComp:playFrontAnimation()
	self:setCardState(var_0_0.TURNCARD_STATE.FRONT)
	self.m_turnPlayTransition:play()
	self:_createImgOnTurnCardOnSlot("play")
end

function ThemeTurnCardComp:playWrongAnimation()
	self:setCardState(var_0_0.TURNCARD_STATE.BACK)
	self.m_turnPlay2Transition:play()
	self:_createImgOnTurnCardOnSlot("play2")
end

function ThemeTurnCardComp:_createImgOnTurnCardOnSlot(arg_10_1)
	local var_10_0 = display.newSprite((g.core.common.Path:getThemeTurnCardIcon(self._tagNum, self._themeValue)))

	var_10_0:setAnchorPoint(cc.p(0.5, 0.5))

	local var_10_1 = var_0_0.TURNCARD_TURN_EFF[self._themeValue] or var_0_0.TURNCARD_TURN_EFF[1]

	self._turnCardSpine = self.m_effTurnCard:addEffectSpine({
		remove = true,
		isLoop = false,
		name = var_10_1,
		anim = arg_10_1
	})

	self._turnCardSpine:getNodeForSlot("Spine_bone"):addChild(var_10_0)
end

function ThemeTurnCardComp:playRightAnimation()
	self.m_stateController:setSelectedIndex(var_0_0.TURNCARD_STATE.RIGHT)

	local var_11_0 = var_0_0.TURNCARD_RIGHT_EFF[self._themeValue] or var_0_0.TURNCARD_RIGHT_EFF[1]

	self.m_effRight:addEffectSpine({
		remove = true,
		isLoop = false,
		name = var_11_0
	})
	self.m_rightTransition:play()
end

function ThemeTurnCardComp:playTransition()
	self.m_enterTransition:play()
end

function ThemeTurnCardComp:_onClickCard()
	if self.m_stateController:getSelectedIndex() == var_0_0.TURNCARD_STATE.BACK then
		self:dispatchCompEvent("GUESS_CARD", {
			cardTag = self._tagNum,
			index = self._index
		})
	end
end

return ThemeTurnCardComp
