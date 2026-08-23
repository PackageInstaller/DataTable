local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.event.EventManager
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = g.core.const.ConstMgr.KNIGHT_CONST
local LineUpKnightMainComp = class("LineUpKnightMainComp", require("app.fairyGUI.lineUp.UI_LineUpKnightMainComp"))

function LineUpKnightMainComp:ctor()
	self._pos = 1
	self._knightId = 0
	self._lastSkinId = 0
	self._waitState = false
	self._knightSpine = nil
	self._knightStruct = nil

	self.m_addBtn:addClickListener(handler(self, self.onClickAddBtn))
	self.m_enterTransition:setHook("enterBegin", handler(self, self._onEnterBegin))
	self.m_enterTransition:setHook("enterEnd", handler(self, self._onEnterEnd))
	self.m_effDadComp:addEffectSpine({
		isLoop = true,
		name = "eff_ui_lineup_sence"
	})
end

function LineUpKnightMainComp:onUnload()
	if self._waitState then
		self._waitState = false

		var_0_2:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end
end

function LineUpKnightMainComp:_onEnterBegin()
	if self._waitState then
		var_0_2:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end

	self._waitState = true

	var_0_2:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)
end

function LineUpKnightMainComp:_onEnterEnd()
	self._waitState = false

	var_0_2:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
end

function LineUpKnightMainComp:onClickAddBtn()
	local var_5_0 = self._pos

	for iter_5_0, iter_5_1 in ipairs((var_0_4:getFormationKnights())) do
		if iter_5_1 == 0 then
			var_5_0 = math.min(iter_5_0, self._pos)

			break
		end
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP_CHOOSE, {
		index = var_5_0,
		knightSid = self._knightId
	})
end

function LineUpKnightMainComp:updateComp(arg_6_1, arg_6_2)
	self:_stopPlaySpecialAction()

	self._knightSpine = nil
	self._pos = arg_6_1
	arg_6_2 = arg_6_2 or 0
	self._knightId = arg_6_2

	if self._knightId > 0 then
		self.m_emptyController:setSelectedIndex(0)

		self._knightStruct = var_0_4:getKnight({
			id = arg_6_2
		})

		local var_6_0 = self._knightStruct:getSkin()

		if self._knightId ~= arg_6_2 then
			self._knightSpine = DrawKnight.new({
				isShowBg = true,
				knight = self._knightStruct
			})

			self.m_spineDadComp:removeChildren()
			self.m_spineDadComp:addChild(self._knightSpine)
		elseif var_6_0 ~= self._lastSkinId then
			self._knightSpine = DrawKnight.new({
				isShowBg = true,
				knight = self._knightStruct
			})

			self.m_spineDadComp:removeChildren()
			self.m_spineDadComp:addChild(self._knightSpine)
		end

		self:playKnightSpecialAction()

		self._lastSkinId = var_6_0

		self.m_nameComp:updateComp(self._knightStruct)
		self.m_infoComp:updateComp(arg_6_1, arg_6_2)
		self.m_addBtn:stopAllFGActions()
	else
		self.m_emptyController:setSelectedIndex(1)
		self.m_spineDadComp:removeChildren()
		g.core.utils.Action.playBlinkAction(self.m_addBtn, 1, 0)
		self:onClickAddBtn()
	end
end

function LineUpKnightMainComp:playEnterAni(arg_7_1)
	local var_7_0 = handler(self, function()
		self:dispatchCompEvent("COMP_EVENT_ENTER_ANI_END")
	end)

	if arg_7_1 == var_0_1.LineUpConst.EnterAniType.ENTER_FROM_CULTIVATE then
		self.m_enter_knightTransition:play(var_7_0)
	elseif arg_7_1 == var_0_1.LineUpConst.EnterAniType.SWITCH then
		self.m_switchTransition:play(var_7_0)
	else
		self.m_enterTransition:play(var_7_0)
	end
end

function LineUpKnightMainComp:playKnightSpecialAction()
	if self._knightStruct and self._knightSpine and self._knightStruct:getVideoShowType() == var_0_5.VIDEO_SHOW_TYPE.ALL then
		self._knightSpine:playSpecialShowAction(self.m_knightMovieComp, nil, nil, handler(self, self._showTransEffect))
	end
end

function LineUpKnightMainComp:_showTransEffect()
	self.m_effectComp:addEffectSpine({
		isLoop = false,
		name = "eff_ui_home_trans",
		remove = true
	})
end

function LineUpKnightMainComp:_stopPlaySpecialAction()
	if self._knightStruct and self._knightSpine then
		self._knightSpine:removeSpecialShowAction()
		self.m_knightMovieComp:removeChildren()
	end
end

function LineUpKnightMainComp:onUnload()
	self:_stopPlaySpecialAction()
end

return LineUpKnightMainComp
