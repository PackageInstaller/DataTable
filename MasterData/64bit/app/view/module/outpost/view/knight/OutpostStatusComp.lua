local var_0_0 = g.core.config.outpost_parameter_info
local var_0_1 = g.core.const.ConstMgr.outpostConst
local var_0_2 = g.core.config.outpost_status_text_info
local OutpostStatusComp = class("OutpostStatusComp", require("app.fairyGUI.outpost.UI_OutpostStatusComp"))

function OutpostStatusComp:updateStatusPanel(arg_1_1)
	self.m_descTxt:setText(var_0_2.get(arg_1_1.type).des)

	local var_1_0 = math.floor(arg_1_1.struct:getKnightStateValue(arg_1_1.type) + 0.5)

	if arg_1_1.type == var_0_1.STATE_ENUM.KNIGHT_DEMONIC then
		self.m_valueTxt:setText(var_1_0 .. "/" .. var_0_0.get(var_0_1.WorldParam.DemonicEnergyMax).parameter)
	else
		local var_1_1 = arg_1_1.struct:getCfg()

		if arg_1_1.type == var_0_1.STATE_ENUM.KNIGHT_HUNGER then
			self.m_valueTxt:setText(var_1_0 .. "/" .. var_1_1.hunger)
		elseif arg_1_1.type == var_0_1.STATE_ENUM.KNIGHT_FATIGUE then
			self.m_valueTxt:setText(var_1_0 .. "/" .. var_1_1.fatigue)
		elseif arg_1_1.type == var_0_1.STATE_ENUM.KNIGHT_MOOD then
			self.m_valueTxt:setText(var_1_0 .. "/" .. var_1_1.mood)
		end
	end
end

return OutpostStatusComp
