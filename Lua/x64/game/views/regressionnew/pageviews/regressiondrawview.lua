local var_0_0 = class("RegressionDrawView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnThree/RT3rd_DrawUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.finishStateController = arg_3_0.controller_:GetController("finish")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		arg_4_0.isGoToDraw = true

		local var_5_0 = ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_draw_pool
		local var_5_1 = ActivityDrawPoolCfg[var_5_0].config_list[1]

		OperationRecorder.RecordButtonTouch("homepage_regression_draw_" .. var_5_1)
		JumpTools.GoToSystem("/draw", {
			isFirst = true,
			poolId = var_5_1
		}, ViewConst.SYSTEM_ID.DRAW)
		saveData("Regression", "DrawPool" .. RegressionDataNew:GetRegressionEndTime(), true)
		manager.redPoint:setTip(RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG, 0, RedPointStyle.SHOW_NEW_TAG)
	end)
end

function var_0_0.GetSelectParams(arg_6_0)
	if not arg_6_0.isGoToDraw then
		return nil, nil
	end

	arg_6_0.isGoToDraw = false

	return 2, 1
end

function var_0_0.SetData(arg_7_0)
	arg_7_0.descTxt_.text = GetTips("NEW_REGRESSION_DRAW_POOL_DESC")

	if RegressionDataNew.GetDrawOverSign() then
		arg_7_0.finishStateController:SetSelectedState("true")

		arg_7_0.drawTxt_.text = string.format("%s/%s %s", 70, 70, GetTips("DRAW_POOL_PROBABILITY_S_4"))
	else
		local var_7_0 = ReturnCfg[RegressionDataNew:GetRegressionSystemID()].return_draw_pool
		local var_7_1 = ActivityDrawPoolCfg[var_7_0].config_list[1]
		local var_7_2 = DrawData:GetDrawRecord(var_7_1)

		if var_7_2 then
			local var_7_3 = DrawPoolCfg[var_7_1]

			arg_7_0.drawTxt_.text = string.format("%s/%s %s", var_7_2.ssr_draw_times, 70, GetTips("DRAW_POOL_PROBABILITY_S_4"))
		end

		arg_7_0.finishStateController:SetSelectedState("false")
	end

	manager.redPoint:bindUIandKey(arg_7_0.goBtn_.transform, RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
end

function var_0_0.OnTaskListChange(arg_8_0)
	arg_8_0:SetData()
end

function var_0_0.OnExit(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.goBtn_.transform, RedPointConst.NEW_REGRESSION_DRAW_NEW_TAG)
end

function var_0_0.SetActive(arg_10_0, arg_10_1)
	SetActive(arg_10_0.gameObject_, arg_10_1)
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
