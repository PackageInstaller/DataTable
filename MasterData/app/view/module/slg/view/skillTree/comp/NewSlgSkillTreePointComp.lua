local var_0_0 = {
	[g.core.common.Goods.TYPE_KNIGHT] = "m_knight",
	[g.core.common.Goods.TYPE_UNITETOKEN] = "m_unitetoken",
	[g.core.common.Goods.TYPE_ARTIFACT] = "m_artifact",
	[g.core.common.Goods.TYPE_SUCCUBA] = "m_succuba",
	[g.core.common.Goods.TYPE_PET] = "m_pet"
}
local NewSlgSkillTreePointComp = class("NewSlgSkillTreePointComp", require("app.fairyGUI.newSlg.UI_NewSlgSkillTreePointComp"))

function NewSlgSkillTreePointComp:updatePointDetail()
	local var_1_0 = g.core.model.User.newSlgSkillTreeData:getPointDetail()
	local var_1_1 = var_1_0.point
	local var_1_2 = clone(var_0_0)

	for iter_1_0, iter_1_1 in ipairs(var_1_0.embryos or {}) do
		var_1_2[iter_1_1.tp] = nil
		var_1_1 = var_1_1 - self[var_0_0[iter_1_1.tp]]:updatePointDetail(iter_1_1.embryo_points, iter_1_1.tp)
	end

	for iter_1_2, iter_1_3 in pairs(var_1_2) do
		self[iter_1_3]:setItemNull()
	end

	self.m_otherTxt:setText(g.core.lang:get(429731, {
		num = var_1_1 or 0
	}))
end

return NewSlgSkillTreePointComp
