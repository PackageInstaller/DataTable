local var_0_0 = g.core.const.ConstMgr.EchoLabConst
local var_0_1 = g.core.model.User.echoLabData
local var_0_2 = g.core.config.palace_info
local EchoLabSlotCell = class("EchoLabSlotCell", require("app.fairyGUI.echoLab.UI_EchoLabSlotCell"))

function EchoLabSlotCell:updateSlotCell(arg_1_1, arg_1_2, arg_1_3)
	if arg_1_1 > var_0_2.get((var_0_1:getPalaceId()))[var_0_0.EMBRYO_SLOT_FIELDS[arg_1_2].name .. "_slot_num"] then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(var_0_1:isLineUpByTypeAndPos(arg_1_3, arg_1_1) and 0 or 1)
	end
end

return EchoLabSlotCell
