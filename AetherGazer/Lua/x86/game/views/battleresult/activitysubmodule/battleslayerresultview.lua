local var_0_0 = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
local var_0_1 = class("BattleSlayerResultView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/BattleResult/BattleSlayer/ShashwatWinUI"
end

function var_0_1.ShowContent(arg_2_0)
	arg_2_0:RefreshSummerUI()
end

function var_0_1.RefreshSummerUI(arg_3_0)
	local var_3_0 = arg_3_0.stageData:GetActivityID()
	local var_3_1 = arg_3_0.stageData:GetDest()
	local var_3_2 = SlayerData:GetOldGetPoint(var_3_0, var_3_1)
	local var_3_3 = 0
	local var_3_4 = {}
	local var_3_5 = 0
	local var_3_6 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas

	if var_3_6 then
		local var_3_7 = ActivitySlayerSkillPointCfg.all

		for iter_3_0, iter_3_1 in ipairs(var_3_7) do
			local var_3_8 = ActivitySlayerSkillPointCfg[iter_3_1]
			local var_3_9
			local var_3_10 = iter_3_1

			if var_3_6:TryGetValue(var_3_10, var_3_9) then
				local var_3_11 = var_3_6[var_3_10]

				var_3_3 = var_3_3 + var_3_8.point * var_3_11
				var_3_5 = var_3_5 + var_3_11

				if not var_3_4[var_3_8.tyep] then
					var_3_4[var_3_8.tyep] = 0
				end

				var_3_4[var_3_8.tyep] = var_3_4[var_3_8.tyep] + var_3_11
			end
		end
	end

	arg_3_0.m_slayerCur.text = var_3_3

	if var_3_2 < var_3_3 then
		SetActive(arg_3_0.m_slayerNew, true)

		arg_3_0.m_slayerMax.text = var_3_3
	else
		SetActive(arg_3_0.m_slayerNew, false)

		arg_3_0.m_slayerMax.text = var_3_2
	end

	arg_3_0.m_slayerRecord1.text = var_3_4[1] or 0
	arg_3_0.m_slayerRecord2.text = var_3_4[2] or 0
	arg_3_0.m_slayerRecord3.text = var_3_4[3] or 0
	arg_3_0.m_slayerRecordAll.text = var_3_5
end

return var_0_1
