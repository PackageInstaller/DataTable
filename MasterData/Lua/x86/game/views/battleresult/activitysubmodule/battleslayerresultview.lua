local BattleSlayerResultView = class("BattleSlayerResultView", (import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")))

function BattleSlayerResultView:UIName()
	return "Widget/System/BattleResult/BattleSlayer/ShashwatWinUI"
end

function BattleSlayerResultView:ShowContent()
	self:RefreshSummerUI()
end

function BattleSlayerResultView:RefreshSummerUI()
	local var_3_0 = SlayerData:GetOldGetPoint(self.stageData:GetActivityID(), (self.stageData:GetDest()))
	local var_3_1 = 0
	local var_3_2 = {}
	local var_3_3 = 0
	local var_3_4 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

	if var_3_4 then
		for iter_3_0, iter_3_1 in ipairs(ActivitySlayerSkillPointCfg.all) do
			if var_3_4:TryGetValue(iter_3_1, nil) then
				var_3_1 = var_3_1 + ActivitySlayerSkillPointCfg[iter_3_1].point * var_3_4[iter_3_1]
				var_3_3 = var_3_3 + var_3_4[iter_3_1]
				var_3_2[ActivitySlayerSkillPointCfg[iter_3_1].tyep] = var_3_2[ActivitySlayerSkillPointCfg[iter_3_1].tyep] or 0
				var_3_2[ActivitySlayerSkillPointCfg[iter_3_1].tyep] = var_3_2[ActivitySlayerSkillPointCfg[iter_3_1].tyep] + var_3_4[iter_3_1]
			end
		end
	end

	self.m_slayerCur.text = var_3_1

	if var_3_0 < var_3_1 then
		SetActive(self.m_slayerNew, true)

		self.m_slayerMax.text = var_3_1
	else
		SetActive(self.m_slayerNew, false)

		self.m_slayerMax.text = var_3_0
	end

	self.m_slayerRecord1.text = var_3_2[1] or 0
	self.m_slayerRecord2.text = var_3_2[2] or 0
	self.m_slayerRecord3.text = var_3_2[3] or 0
	self.m_slayerRecordAll.text = var_3_3
end

return BattleSlayerResultView
