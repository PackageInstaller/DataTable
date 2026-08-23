local var_0_0 = g.core.const.ConstMgr.NewSlgConst.REPORT
local NewSlgEnemyIcon = class("NewSlgEnemyIcon")

function NewSlgEnemyIcon:updateEnemyIcon(arg_1_1)
	self:getChild("Comp_star"):setVisible(false)

	if arg_1_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_MONSTER then
		self:getChild("Comp_icon"):setIcon("pic/new_slg/head/monster/" .. g.core.config.new_slg_monster_info.get(arg_1_1.def_id, g.core.model.User.newSlgData:getSlgInfo().monster_group).pic .. ".png")
	elseif arg_1_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_TEAM then
		self:getChild("Comp_icon"):setIcon("pic/new_slg/head/boss/" .. g.core.config.new_slg_boss_info.get(arg_1_1.def_id).pic .. ".png")
	elseif arg_1_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY then
		local var_1_0 = arg_1_1.enemyTeam or {}

		if var_1_0.user and var_1_0.user.is_robot then
			self:getChild("Comp_icon"):setIcon("pic/new_slg/head/boss/10103.png")
		else
			local var_1_1 = var_1_0.characters and var_1_0.characters[1]

			if var_1_1 and var_1_1.base_id and var_1_1.base_id > 0 then
				self:getChild("Comp_icon"):updateIcon({
					type = g.core.common.Goods.TYPE_KNIGHT,
					value = var_1_1.base_id
				})
			else
				self:getChild("Comp_icon"):setIcon("pic/new_slg/head/boss/10103.png")
			end
		end
	end
end

return NewSlgEnemyIcon
