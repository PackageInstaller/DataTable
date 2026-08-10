ChapterResidentActBaseView = import("game.views.chapter.residentAct.ChapterResidentActBaseView")

local var_0_0 = class("ChapterResidentActSkuldView", ChapterResidentActBaseView)

function var_0_0.AddUIListener(arg_1_0)
	var_0_0.super.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.emptyDreamBtn_, nil, function()
		JumpTools.JumpToPage({
			309,
			12112
		})
	end)
end

function var_0_0.RefreshUI(arg_3_0)
	var_0_0.super.RefreshUI(arg_3_0)

	local var_3_0 = ChapterClientCfg[ChapterConst.CHAPTER_CLIENT_EMPTY_DREAM].chapter_list
	local var_3_1 = 0
	local var_3_2 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_3 = ChapterCfg[iter_3_1]

		for iter_3_2, iter_3_3 in pairs(var_3_3.section_id_list) do
			table.insert(var_3_2, iter_3_3)

			if BattleStageData:GetStageClearTimes(iter_3_3) > 0 then
				var_3_1 = var_3_1 + 1
			end
		end
	end

	arg_3_0.emptyDreamFillText_.text = math.floor(var_3_1 / #var_3_2 * 100) .. "%"
	arg_3_0.emptyDreamFillImage_.fillAmount = var_3_1 / #var_3_2
end

return var_0_0
