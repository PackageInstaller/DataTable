local var_0_0 = import("game.views.regressionNew.pageViews.RegressionTaskContent")
local var_0_1 = class("RegressionTiliTaskContent", var_0_0)

function var_0_1.InitNode(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.goBtn_, nil, function()
		arg_1_0.isGoToChapter = true

		JumpTools.OpenPageByJump("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.RESOURCE
		})
	end)
end

function var_0_1.GetSelectParams(arg_3_0)
	if not arg_3_0.isGoToChapter then
		return nil, nil
	end

	arg_3_0.isGoToChapter = false

	return 1, 4
end

function var_0_1.RefreshUI(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = RegressionDataNew:GetMultipleValue()

	arg_4_0.descTxt_.text = GetTips("NEW_REGRESSION_TILI_DESC")
	arg_4_0.ratioTxt_.text = "X" .. var_4_2 / 100
	arg_4_0.remainCountTxt_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_4_0, var_4_1)
end

function var_0_1.RefreshTime(arg_5_0, arg_5_1)
	arg_5_0.countDownTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_5_1)
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)
end

return var_0_1
