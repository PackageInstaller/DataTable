local RegressionTiliTaskContent = class("RegressionTiliTaskContent", (import("game.views.regressionNew.pageViews.RegressionTaskContent")))

function RegressionTiliTaskContent:InitNode()
	self:AddBtnListener(self.goBtn_, nil, function()
		self.isGoToChapter = true

		JumpTools.OpenPageByJump("/chapterMap", {
			chapterToggle = BattleConst.TOGGLE.RESOURCE
		})
	end)
end

function RegressionTiliTaskContent:GetSelectParams()
	if not self.isGoToChapter then
		return nil, nil
	end

	self.isGoToChapter = false

	return 1, 4
end

function RegressionTiliTaskContent:RefreshUI()
	local var_4_0, var_4_1, var_4_2 = RegressionDataNew:GetMultipleValue()

	self.descTxt_.text = GetTips("NEW_REGRESSION_TILI_DESC")
	self.ratioTxt_.text = "X" .. var_4_2 / 100
	self.remainCountTxt_.text = string.format(GetTips("NEW_REGRESSION_DOUBLE_REWARD_DESC"), var_4_0, var_4_1)
end

function RegressionTiliTaskContent:RefreshTime(arg_5_1)
	self.countDownTxt_.text = manager.time:GetLostTimeStrWith2Unit(arg_5_1)
end

function RegressionTiliTaskContent:Dispose()
	RegressionTiliTaskContent.super.Dispose(self)
end

return RegressionTiliTaskContent
