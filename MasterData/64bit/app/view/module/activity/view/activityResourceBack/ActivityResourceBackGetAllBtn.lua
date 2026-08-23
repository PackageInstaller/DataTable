local var_0_0 = g.core.const.ConstMgr.ResourceBackConst
local ActivityResourceBackGetAllBtn = class("ActivityResourceBackGetAllBtn", require("app.fairyGUI.activity.UI_ActivityResourceBackGetAllBtn"))

function ActivityResourceBackGetAllBtn:updateAllCostInfo(arg_1_1, arg_1_2)
	self.m_allCostLoader:setURL((arg_1_2 == var_0_0.NORMAL_TYPE and g.core.common.Goods:convert(var_0_0.NORMAL_COST) or g.core.common.Goods:convert(var_0_0.GOLD_COST)).icon_mini)
	self.m_allCostCountTxt:setText(arg_1_1)
end

return ActivityResourceBackGetAllBtn
