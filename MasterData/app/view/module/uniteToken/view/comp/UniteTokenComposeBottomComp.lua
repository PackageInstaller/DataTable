local UniteTokenComposeBottomComp = class("UniteTokenComposeBottomComp", require("app.fairyGUI.uniteToken.UI_UniteTokenComposeBottomComp"))
local var_0_1 = g.core.model.User.uniteTokenData

function UniteTokenComposeBottomComp:ctor()
	return
end

function UniteTokenComposeBottomComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = var_0_1:getTokenBaseInfo((arg_2_1:getBaseId()))

	self.m_skillIcon:updateIcon(var_2_0.skillInfo)
	self.m_name:setText(var_2_0.skillInfo.cfg.curtain_name)
	self.m_dec:setTitle(var_2_0.skillInfo.desc)
end

return UniteTokenComposeBottomComp
