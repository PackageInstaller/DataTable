local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.model.User.echoLabData
local EchoLabCommonBtn = class("EchoLabCommonBtn", require("app.fairyGUI.echoLab.UI_EchoLabTerminalBtn"))

function EchoLabCommonBtn:onLoad()
	local var_1_0 = self:getChild("redPointComp")

	if var_1_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = var_1_0
		})
	end
end

function EchoLabCommonBtn:updateBtnState(arg_2_1)
	self.m_isLockController:setSelectedIndex(0)

	if arg_2_1 == var_0_0.TERMINAL then
		local var_2_0, var_2_1 = var_0_1:isUnlockEchoLabTerminal()

		self.m_isLockController:setSelectedIndex(var_2_0 and 0 or 1)
	end
end

function EchoLabCommonBtn:playEnterTransition(arg_3_1)
	self.m_effEnter:removeAllEffect()

	if arg_3_1 == var_0_0.COLLECT then
		self.m_effEnter:addEffectSpine({
			anim = "play",
			name = "eff_ui_echoLab_CollectBtn",
			isLoop = false
		})
	elseif arg_3_1 == var_0_0.DATATREE then
		self.m_effEnter:addEffectSpine({
			anim = "play",
			name = "eff_ui_echoLab_DataTreeBtn",
			isLoop = false
		})
	elseif arg_3_1 == var_0_0.TERMINAL then
		local var_3_0, var_3_1 = var_0_1:isUnlockEchoLabTerminal()

		if var_3_0 then
			self.m_effEnter:addEffectSpine({
				anim = "play",
				name = "eff_ui_echoLab_TerminalBtn",
				isLoop = false
			})
		end
	end
end

return EchoLabCommonBtn
