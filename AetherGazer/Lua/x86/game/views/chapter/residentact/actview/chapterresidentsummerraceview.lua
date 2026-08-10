local var_0_0 = import("game.views.chapter.residentAct.ChapterResidentActBaseView")
local var_0_1 = class("ChapterResidentSummerRaceView", var_0_0)

function var_0_1.RefreshProgressUI(arg_1_0)
	local var_1_0, var_1_1, var_1_2 = ChapterResidentTools.GetResidentActProgress(arg_1_0.activityID)

	if arg_1_0.progressValueTxt_ then
		if var_1_2 then
			arg_1_0.progressValueTxt_.text = var_1_2
		else
			arg_1_0.progressValueTxt_.text = var_1_0 .. "/" .. var_1_1
		end
	end

	if arg_1_0.processImg_ then
		local var_1_3 = 0
		local var_1_4 = tonumber(var_1_1) or 0

		if var_1_4 > 0 then
			var_1_3 = var_1_0 / var_1_4
		end

		arg_1_0.processImg_.fillAmount = math.min(math.max(var_1_3, 0), 1)
	end
end

return var_0_1
