local var_0_0 = g.core.config.monster_info
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.gveDataMgr
local GveBossEnemyComp = class("GveBossEnemyComp", require("app.fairyGUI.gve.UI_GveBossEnemyComp"))

function GveBossEnemyComp:updateByMonsterData(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_1.showPos
	local var_1_1

	if arg_1_1.showPos == 0 then
		var_1_0 = 1
		var_1_1 = {
			hideSkin = true
		}
	end

	var_1_1.baseId = var_0_0.fetch(arg_1_1.monsterTeamInfo["monster_" .. var_1_0]).res_id

	self.m_knightIcon:updateIcon(var_1_1)
	self.m_hpBar:setMax(arg_1_1.maxTotalHp)
	self.m_hpBar:setValue(arg_1_1.curTotalHp)
	self.m_itemIcon:setURL((var_0_1:getHalidomResourceById(var_0_2:getGveBagData():getBranchCfgByBranchId(0).small_grey_icon)))
	self.m_levelTxt:setText(arg_1_2:getInfo().guard_equip_lv)
	self.m_monsterNameText:setText(g.core.lang:get(309003, {
		index = arg_1_1.guardIndex
	}))

	if arg_1_1.curTotalHp <= 0 then
		self.m_stateController:setSelectedIndex(1)
		self:setTouchable(false)
	else
		self.m_stateController:setSelectedIndex(0)
		self:setTouchable(true)
	end
end

return GveBossEnemyComp
