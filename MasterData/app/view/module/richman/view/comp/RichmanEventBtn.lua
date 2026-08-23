local var_0_0 = g.core.model.User.richmanData
local var_0_1 = g.core.common.ServerTime
local RichmanConst = require("app.view.module.richman.const.RichmanConst")
local var_0_3 = {
	[RichmanConst.EVENT_TYPE.GAME_TURNCARD] = 0,
	[RichmanConst.EVENT_TYPE.GAME_REDPACKET] = 1,
	[RichmanConst.EVENT_TYPE.GAME_TURNTABLE] = 2,
	[RichmanConst.EVENT_TYPE.STEAL_OTHER] = 3
}
local RichmanEventBtn = class("RichmanEventBtn", require("app.fairyGUI.richman.UI_RichmanEventBtn"))

function RichmanEventBtn:ctor()
	self:addClickListener(handler(self, self._onClickRichmanEventBtn))
end

function RichmanEventBtn:updateEventShow(arg_2_1)
	self._eventData = arg_2_1

	self.m_typeController:setSelectedIndex(var_0_3[arg_2_1.type] or 0)
	self.m_numTxt:setText(#arg_2_1.list)

	if arg_2_1.type == RichmanConst.EVENT_TYPE.STEAL_OTHER and var_0_0:isNeedStealAnim() then
		var_0_0:setNeedStealAnim(false)
		self.m_eff:addEffectSpine({
			remove = true,
			name = "eff_ui_richman_newIcon",
			isLoop = false
		})

		if not self._type or self._type ~= arg_2_1.type then
			self.m_enter3Transition:play()
		end
	end

	self._type = arg_2_1.type

	self:refreshEventTime()
end

function RichmanEventBtn:refreshEventTime()
	self.m_timeTxt:setText((var_0_1:getLeftSecondsString(self._eventData.list[1].finishTime or 0)))
end

function RichmanEventBtn:_onClickRichmanEventBtn()
	if self._eventData then
		if self._eventData.type == RichmanConst.EVENT_TYPE.GAME_TURNCARD or self._eventData.type == RichmanConst.EVENT_TYPE.GAME_TURNTABLE or self._eventData.type == RichmanConst.EVENT_TYPE.GAME_REDPACKET then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.richman.view.game.RichmanTickGamePop").new(self._eventData.list[1]), {
				touchDisappear = true,
				hideContinue = true
			})
		elseif self._eventData.type == RichmanConst.EVENT_TYPE.STEAL_OTHER then
			g.core.module.ModuleManager:pushPopup((require("app.view.module.richman.view.pop.RichmanStealPop").new(self._eventData.list[1])))
		end
	end
end

return RichmanEventBtn
