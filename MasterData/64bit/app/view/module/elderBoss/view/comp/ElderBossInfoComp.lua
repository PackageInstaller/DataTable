local var_0_0 = g.core.model.User.elderBossData
local ElderBossInfoComp = class("ElderBossInfoComp", require("app.fairyGUI.elderBoss.UI_ElderBossInfoComp"))

function ElderBossInfoComp:updateElderBossUserInfo()
	self.m_buffLoader:setURL(g.core.common.Path:getElderBossBuffMiniIcon((var_0_0:getChooseBuff())))
	self.m_hightValueTxt:setText(var_0_0:getMaxHonor())

	local var_1_0 = var_0_0:getMaxHonorRank()

	self.m_hightRankTxt:setText((var_1_0 > 0 or nil) and (g.core.lang:get(303033, {
		rank = var_1_0
	}) or g.core.lang:get(429554)))
	self.m_totalValueTxt:setText(var_0_0:getTotalHonor())

	local var_1_1 = var_0_0:getTotalHonorRank()

	self.m_totalRankTxt:setText((var_1_1 > 0 or nil) and (g.core.lang:get(303033, {
		rank = var_1_1
	}) or g.core.lang:get(429554)))

	local var_1_2 = var_0_0:getGuildRank()

	self.m_guildRankTxt:setText((var_1_2 > 0 or nil) and (g.core.lang:get(303033, {
		rank = var_1_2
	}) or g.core.lang:get(429554)))
end

return ElderBossInfoComp
