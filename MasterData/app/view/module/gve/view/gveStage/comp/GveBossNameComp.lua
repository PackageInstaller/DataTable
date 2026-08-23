local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.config.monster_info
local var_0_2 = g.core.common.Path
local GveBossNameComp = class("GveBossNameComp", require("app.fairyGUI.gve.UI_GveBossNameComp"))

function GveBossNameComp:updateByBossData(arg_1_1)
	local var_1_0 = arg_1_1:getInfo().boss_team_elite
	local var_1_1 = arg_1_1:getBossData().monsterTeamInfo["monster_" .. var_1_0]
	local var_1_3 = math.ceil(((var_1_1 > 0 or nil) and var_0_1.get(var_1_1).initial_hp) / arg_1_1:getInfo().health_bar)

	self.m_hpBar:setMax(var_1_3)

	local var_1_4 = arg_1_1:getBossData().hpList[var_1_0] or 0

	self.m_hpBar:setValue(var_1_4 % var_1_3 == 0 and var_1_3 or var_1_4 % var_1_3)
	self.m_hpText:setText("x" .. math.max(math.ceil(var_1_4 / var_1_3), 0))
	self.m_finalBossNameText:setText(arg_1_1:getInfo().name)
	self.m_sealLevelText:setText(arg_1_1:getInfo().boss_equip_lv)
	self.m_bossImgComp:setIcon(var_0_2:getKnightIconById(arg_1_1:getInfo().image))
	self.m_sealLoader:setURL((var_0_2:getHalidomResourceById(var_0_0:getGveBagData():getBranchCfgByBranchId(0).small_grey_icon)))
end

return GveBossNameComp
