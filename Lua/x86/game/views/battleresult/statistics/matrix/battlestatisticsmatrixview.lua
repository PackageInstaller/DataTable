local var_0_0 = import("..BattleStatisticsView")
local var_0_1 = class("BattleStatisticsMatrixView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.stageData = arg_1_0.params_.stageData

	local var_1_0 = arg_1_0.stageData:GetHeroTeam()

	arg_1_0.statisticsHeroItem_ = {}

	local var_1_1, var_1_2, var_1_3 = BattleTools.GetBattleStatisticsData()
	local var_1_4 = 1

	for iter_1_0 = 1, 3 do
		local var_1_5

		if var_1_0[iter_1_0] and var_1_0[iter_1_0] ~= 0 then
			var_1_5 = {
				level = 1,
				id = var_1_0[iter_1_0],
				skin_id = MatrixData:GetHeroSkin(var_1_0[iter_1_0])
			}
		end

		arg_1_0.statisticsHeroItem_[iter_1_0] = arg_1_0:GetStatisticsItem().New(arg_1_0.heroItem_[iter_1_0], var_1_5, var_1_2, var_1_3, var_1_1[var_1_4])
		var_1_4 = var_1_4 + 1
	end

	arg_1_0:SetLevelTitle()
	arg_1_0:RefreshTimeText()
end

function var_0_1.GetStatisticsItem(arg_2_0)
	return BattleStatisticsMatrixHeroItem
end

function var_0_1.SetLevelTitle(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.stageData:GetStageId()

	arg_3_0.lvText_.text = ""
	arg_3_0.stareText_.text = ""

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_3_0.titleTransform_)
end

return var_0_1
