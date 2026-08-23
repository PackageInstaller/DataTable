local var_0_0 = g.core.const.ConstMgr.ChatConst
local AllianceHallSendMsgComp = class("AllianceHallSendMsgComp", require("app.fairyGUI.alliance.UI_AllianceHallSendMsgComp"))

function AllianceHallSendMsgComp:ctor()
	return
end

function AllianceHallSendMsgComp:updateView()
	self.m_allianceName:setText(g.core.lang:get(428553, {
		name = g.core.model.User.allianceData:getAllianceName()
	}))
end

function AllianceHallSendMsgComp:getSendChannel()
	local var_3_0 = {}

	if self.m_localBtn:isSelected() then
		table.insert(var_3_0, var_0_0.WORLD)
	end

	if self.m_crossBtn:isSelected() then
		table.insert(var_3_0, var_0_0.AREA)
	end

	if #var_3_0 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428606))

		return var_3_0
	end

	return var_3_0
end

return AllianceHallSendMsgComp
