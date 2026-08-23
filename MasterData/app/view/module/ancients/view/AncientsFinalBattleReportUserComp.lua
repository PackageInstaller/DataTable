local AncientsFinalBattleReportUserComp = class("AncientsFinalBattleReportUserComp", require("app.fairyGUI.ancients.UI_AncientsFinalBattleReportUserComp"))

function var_0_0:ctor()
	self._compAtkIcons = {
		self.m_Comp_atk_icon1,
		self.m_Comp_atk_icon2,
		self.m_Comp_atk_icon3
	}
	self._compAtkNames = {
		self.m_Comp_atk_name1,
		self.m_Comp_atk_name2,
		self.m_Comp_atk_name3
	}
	self._compDefIcons = {
		self.m_Comp_def_icon1,
		self.m_Comp_def_icon2,
		self.m_Comp_def_icon3
	}
	self._compDefNames = {
		self.m_Comp_def_name1,
		self.m_Comp_def_name2,
		self.m_Comp_def_name3
	}
end

function var_0_0:updateView(arg_2_1)
	self.m_atk_user_countController:setSelectedIndex(#arg_2_1.atkUserIds)
	self.m_def_user_countController:setSelectedIndex(#arg_2_1.defUserIds)

	for iter_2_0 = 1, #arg_2_1.atkUserIds do
		local var_2_1 = g.core.utils.Tools.ancientsFunc.getSnapshot(arg_2_1.atkUserIds[iter_2_0])

		if var_2_1 then
			self._compAtkIcons[iter_2_0]:updateAsUser(var_2_1)
			self._compAtkNames[iter_2_0]:setText(var_2_1.name)
		end
	end

	for iter_2_1 = 1, #arg_2_1.defUserIds do
		local var_2_2 = g.core.utils.Tools.ancientsFunc.getSnapshot(arg_2_1.defUserIds[iter_2_1])

		if var_2_2 then
			self._compDefIcons[iter_2_1]:updateAsUser(var_2_2)
			self._compDefNames[iter_2_1]:setText(var_2_2.name)
		end
	end
end

return var_0_0
