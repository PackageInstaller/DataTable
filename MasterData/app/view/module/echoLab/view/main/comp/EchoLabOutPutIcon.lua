local var_0_0 = g.core.common.Path
local EchoLabOutPutIcon = class("EchoLabOutPutIcon", require("app.fairyGUI.echoLab.UI_EchoLabOutPutIcon"))

function EchoLabOutPutIcon:updateOutPutIcon(arg_1_1, arg_1_2)
	self.m_isFullController:setSelectedIndex(arg_1_2 == 100 and 1 or 0)
	self.m_iconLoader:setIcon(var_0_0:getIconByTypeValue(arg_1_1.type, arg_1_1.value, true))

	local var_1_0 = g.core.lang:get(408537, {
		num = tonumber(arg_1_2)
	})

	self:setTitle(var_1_0)
	self.m_title1:setText(var_1_0)
	self.m_effOutput:removeAllEffect()
	self.m_effOutput:addEffectSpine({
		anim = "play",
		name = "eff_ui_echoLab_Output",
		isLoop = true
	})
end

function EchoLabOutPutIcon:playGetAwardEff()
	self.m_effOutput:removeAllEffect()
	self.m_effOutput:addEffectSpine({
		anim = "play2",
		name = "eff_ui_echoLab_Output",
		isLoop = false
	})
end

return EchoLabOutPutIcon
