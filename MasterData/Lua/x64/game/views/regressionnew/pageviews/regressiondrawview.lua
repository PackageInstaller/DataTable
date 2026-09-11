local RegressionDrawView = class("RegressionDrawView", ReduxView)

function RegressionDrawView:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnThree/RT3rd_DrawUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionDrawView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionDrawView:InitUI()
	self:BindCfgUI()

	self.finishStateController = self.controller_:GetController("finish")
end

function RegressionDrawView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		self.isGoToDraw = true

		local var_5_0 = ActivityDrawPoolCfg[ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_draw_pool].config_list[1]

		OperationRecorder.RecordButtonTouch("homepage_regression_draw_" .. var_5_0)
		JumpTools.GoToSystem("/draw", {
			isFirst = true,
			poolId = var_5_0
		}, ViewConst.SYSTEM_ID.DRAW)
		saveData("Regression", "DrawPool" .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end)
end

function RegressionDrawView:GetSelectParams()
	if not self.isGoToDraw then
		return nil, nil
	end

	self.isGoToDraw = false

	return 2, 1
end

function RegressionDrawView:SetData()
	self.descTxt_.text = GetTips("NEW_REGRESSION_DRAW_POOL_DESC")

	if RegressionDataNew.GetDrawOverSign() then
		self.finishStateController:SetSelectedState("true")

		self.drawTxt_.text = string.format("%s/%s %s", 70, 70, GetTips("DRAW_POOL_PROBABILITY_S_4"))
	else
		local var_7_1 = DrawData:GetDrawRecord(ActivityDrawPoolCfg[ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_draw_pool].config_list[1])

		if var_7_1 then
			self.drawTxt_.text = string.format("%s/%s %s", var_7_1.ssr_draw_times, 70, GetTips("DRAW_POOL_PROBABILITY_S_4"))
		end

		self.finishStateController:SetSelectedState("false")
	end

	manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
end

function RegressionDrawView:OnTaskListChange()
	self:SetData()
end

function RegressionDrawView:OnExit()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
end

function RegressionDrawView:SetActive(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function RegressionDrawView:Dispose()
	RegressionDrawView.super.Dispose(self)
end

return RegressionDrawView
