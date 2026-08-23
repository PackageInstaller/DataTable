local var_0_0 = g.core.const.ConstMgr.PreciousConst
local PreciousMainComp = class("PreciousMainComp", require("app.fairyGUI.precious.UI_PreciousMainComp"))

function PreciousMainComp:updateMainComp(arg_1_1, arg_1_2)
	if arg_1_2 then
		self._ignoreTouch = arg_1_2.ignoreTouch
		self._ignoreRedPoint = arg_1_2.ignoreRedPoint
	end

	local var_1_0 = arg_1_1:getPreciousStatus()

	self.m_stateController:setSelectedIndex(var_1_0)

	if var_1_0 == var_0_0.PRECIOUS_STATUS.NOGET or var_1_0 == var_0_0.PRECIOUS_STATUS.CANCOMPOSE then
		local var_1_1, var_1_2, var_1_3 = arg_1_1:isCanCompose()

		self.m_numTxt:setText(var_1_3 .. "/" .. var_1_2)
	end

	self.m_baseComp:updatePrecious(arg_1_1)

	if self._ignoreRedPoint then
		self.m_redPointComp:setVisible(false)
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				advId = arg_1_1:getAdvId()
			}
		})
	end
end

function PreciousMainComp:setSelected(arg_2_1)
	self.m_baseComp:setSelected(arg_2_1)
end

return PreciousMainComp
