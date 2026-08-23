local NewSlgSkillTreePointArrayCell = class("NewSlgSkillTreePointArrayCell", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreePointArrayCell"))

function NewSlgSkillTreePointArrayCell:updateSkillTreePoint(arg_1_1, arg_1_2)
	self.m_has_bgController:setSelectedIndex(arg_1_2 % 2 == 0 and 0 or 1)
	self.m_Txt_name:setText(arg_1_1.name)
	self.m_Txt_star_num:setText(arg_1_1.star)
	self.m_Txt_rule:setText(g.core.lang:get(429730, {
		name = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.const.ConstMgr.NewSlgConst.TECHNOLOGY_POINT_VALUE
		}).name,
		num = arg_1_1.point
	}))
end

return NewSlgSkillTreePointArrayCell
