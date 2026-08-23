local var_0_0 = g.core.model.User.gveDataMgr
local GveGiveUpConfirmComp = class("GveGiveUpConfirmComp", require("app.fairyGUI.gve.UI_GveGiveUpConfirmComp"))

function GveGiveUpConfirmComp:update(arg_1_1)
	self.m_titleDesc:setText(g.core.lang:get(309138, {
		name = arg_1_1.cfg.base_name
	}))
	self.m_desc:setText(g.core.lang:get(309139, {
		sec = var_0_0:getGveBaseCfg().base_quit_time
	}))
end

return GveGiveUpConfirmComp
