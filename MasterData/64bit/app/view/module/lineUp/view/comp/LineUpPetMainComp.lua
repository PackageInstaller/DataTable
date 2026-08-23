local var_0_0 = g.core.event.enum
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.LineUpConst
local var_0_3 = g.core.event.EventManager
local DrawPet = require("app.view.common.DrawPet")
local var_0_5 = g.core.model.User.petsData
local LineUpPetMainComp = class("LineUpPetMainComp", require("app.fairyGUI.lineUp.UI_LineUpPetMainComp"))

function LineUpPetMainComp:ctor()
	self._pos = 1
	self._petSid = 0
	self._waitState = false

	self.m_addBtn:addClickListener(handler(self, self.onClickAddBtn))
	self.m_addComp:addClickListener(handler(self, self.onClickAddBtn))
	self.m_enterTransition:setHook("enterBegin", handler(self, self._onEnterBegin))
	self.m_enterTransition:setHook("enterEnd", handler(self, self._onEnterEnd))
	self.m_effDadComp:addEffectSpine({
		name = "eff_ui_lineup_sence",
		isLoop = true
	})
end

function LineUpPetMainComp:onUnload()
	if self._waitState then
		self._waitState = false

		var_0_3:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end
end

function LineUpPetMainComp:_onEnterBegin()
	if self._waitState then
		self._waitState = false

		var_0_3:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end

	self._waitState = true

	var_0_3:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)
end

function LineUpPetMainComp:_onEnterEnd()
	self._waitState = false

	var_0_3:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
end

function LineUpPetMainComp:onClickAddBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.LINE_UP_CHOOSE_PET, {
		pos = self._pos,
		petSid = self._petSid
	})
end

function LineUpPetMainComp:updateComp(arg_6_1, arg_6_2)
	self._pos = arg_6_1
	arg_6_2 = arg_6_2 or 0
	self._petSid = arg_6_2

	if arg_6_2 > 0 then
		self.m_emptyController:setSelectedIndex(0)

		local var_6_0 = var_0_5:getPetBySid(arg_6_2)

		if self._petSid ~= arg_6_2 then
			self.m_spineDadComp:removeChildren()
			self.m_spineDadComp:addChild((DrawPet.new({
				isShowBg = true,
				scale = 1.4,
				advId = var_6_0:getAdvanceId()
			})))
		end

		self.m_nameComp:updateComp(var_6_0)
		self.m_infoComp:updateComp(arg_6_1, arg_6_2)
		self.m_addBtn:stopAllFGActions()
	else
		self.m_spineDadComp:removeChildren()
		self.m_emptyController:setSelectedIndex(1)
		g.core.utils.Action.playBlinkAction(self.m_addBtn, 1, 0)
		self:onClickAddBtn()
	end
end

function LineUpPetMainComp:playEnterAni(arg_7_1)
	local var_7_0 = handler(self, function()
		self:dispatchCompEvent("COMP_EVENT_ENTER_ANI_END")
	end)

	if arg_7_1 == var_0_1.LineUpConst.EnterAniType.ENTER_FROM_CULTIVATE then
		self.m_enter_knightTransition:play(var_7_0)
	elseif arg_7_1 == var_0_1.LineUpConst.EnterAniType.SWITCH then
		self.m_switchTransition:play(var_7_0)
		self.m_infoComp:showEnterCutTransition()
	else
		self.m_enterTransition:play(var_7_0)
		self.m_infoComp:showEnterTransition()
	end
end

function LineUpPetMainComp:_getLineupFuncId(arg_9_1, arg_9_2)
	return var_0_1.FUNCTION_TYPE[(arg_9_1 == var_0_2.LineupType.PET and var_0_2.PET_LINE_UP_FUNC_ID_PRE_KEY or var_0_2.KNIGHT_LINE_UP_FUNC_ID_PRE_KEY) .. arg_9_2]
end

return LineUpPetMainComp
