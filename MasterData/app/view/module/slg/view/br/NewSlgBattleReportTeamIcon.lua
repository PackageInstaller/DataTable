local var_0_0 = g.core.const.ConstMgr.NewSlgConst.REPORT
local NewSlgBattleReportTeamIcon = class("NewSlgBattleReportTeamIcon", require("app.fairyGUI.newSlg.UI_NewSlgBattleReportTeamIcon"))

function NewSlgBattleReportTeamIcon:ctor()
	self._teamInfo = nil
end

function NewSlgBattleReportTeamIcon:updateIcon(arg_2_1, arg_2_2)
	self._teamInfo = arg_2_1

	self.m_typeComp:updateView({
		armyType = arg_2_1.troop_type
	})

	if arg_2_1.characters then
		self.m_iconBtn:updateView({
			character = arg_2_1.characters[1]
		})
		self.m_isEnemyController:setSelectedIndex(0)

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_1.characters) do
			local var_2_1 = g.core.config.knight_info.get(iter_2_1.base_id)

			if var_2_1.classical ~= 0 then
				var_2_0[#var_2_0 + 1] = var_2_1.classical
			end
		end

		local var_2_2 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_2_0)

		if var_2_2 ~= 0 then
			self.m_iconBtn:setElement(var_2_2)
		end
	else
		self:updateEnemyIcon(arg_2_2)
		self.m_isEnemyController:setSelectedIndex(1)
	end
end

function NewSlgBattleReportTeamIcon:updateEnemyIcon(arg_3_1)
	if arg_3_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_MONSTER then
		self.m_enemyIcon:setURL("pic/new_slg/head/monster/" .. g.core.config.new_slg_monster_info.get(arg_3_1.def_id, g.core.model.User.newSlgData:getSlgInfo().monster_group).pic .. ".png")
	elseif arg_3_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_TEAM then
		local var_3_0 = g.core.config.new_slg_boss_info.get(arg_3_1.def_id)
		local var_3_1 = ""

		if var_3_0.boss_army_type == 1 then
			var_3_1 = 101
		elseif var_3_0.boss_army_type == 2 then
			var_3_1 = 109
		elseif var_3_0.boss_army_type == 3 then
			var_3_1 = 105
		end

		self.m_enemyIcon:setURL("pic/new_slg/head/monster/" .. var_3_1 .. ".png")
	elseif arg_3_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY then
		self.m_enemyIcon:setURL("pic/new_slg/head/monster/113.png")
	elseif arg_3_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_FARM then
		self.m_enemyIcon:setURL("pic/new_slg/head/monster/113.png")
	end
end

return NewSlgBattleReportTeamIcon
