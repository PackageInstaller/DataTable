local var_0_0 = g.core.const.ConstMgr.ResourceBackConst
local ActivityResourceBackBtn = class("ActivityResourceBackBtn", require("app.fairyGUI.activity.UI_ActivityResourceBackBtn"))

function ActivityResourceBackBtn:updateBtnInfo(arg_1_1, arg_1_2)
	local var_1_0
	local var_1_1 = 0

	if arg_1_2 == var_0_0.NORMAL_TYPE then
		var_1_0 = g.core.common.Goods:convert(var_0_0.NORMAL_COST)
		var_1_1 = arg_1_1.cfg.normal_cost
	else
		var_1_0 = g.core.common.Goods:convert(var_0_0.GOLD_COST)
		var_1_1 = arg_1_1.cfg.buy_cost
	end

	self.m_costLoader:setURL(var_1_0.icon_mini)
	self.m_costCountTxt:setText(var_1_1 * arg_1_1.svrData.retrieveDays)
end

return ActivityResourceBackBtn
