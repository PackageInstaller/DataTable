local var_0_0 = class("MatrixMgr")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.ShowPopItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_0.popItemView_ then
		arg_2_0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	arg_2_0.popItemView_:SetActive(true)
	arg_2_0.popItemView_:SetWorldPosition(arg_2_3)
	arg_2_0.popItemView_:RefreshText(arg_2_1, arg_2_2)
	arg_2_0:AddClickTimer()
end

function var_0_0.ShowMatrixPopItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if not arg_3_0.popItemView_ then
		arg_3_0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	arg_3_0.popItemView_:SetActive(true)
	arg_3_0.popItemView_:SetWorldPosition(arg_3_2)
	arg_3_0.popItemView_:Refresh(arg_3_1, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0:AddClickTimer()
end

function var_0_0.ShowMatrixAiffixPopItem(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.popItemView_ then
		arg_4_0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	arg_4_0.popItemView_:SetActive(true)
	arg_4_0.popItemView_:SetWorldPosition(arg_4_2)
	arg_4_0.popItemView_:RefreshAffix(arg_4_1)
	arg_4_0:AddClickTimer()
end

function var_0_0.ShowMatrixBeaconPopItem(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.popItemView_ then
		arg_5_0.popItemView_ = MatrixItemInfoView.New(manager.ui.uiMain.transform)
	end

	arg_5_0.popItemView_:SetActive(true)
	arg_5_0.popItemView_:SetWorldPosition(arg_5_2)
	arg_5_0.popItemView_:RefreshBeacon(arg_5_1)
	arg_5_0:AddClickTimer()
end

function var_0_0.HideItem(arg_6_0)
	arg_6_0.popItemView_:SetActive(false)
end

function var_0_0.AddClickTimer(arg_7_0)
	arg_7_0:StopTimer()

	arg_7_0.buttonUp_ = 0
	arg_7_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		if Input.GetMouseButtonUp(0) then
			arg_7_0.buttonUp_ = arg_7_0.buttonUp_ + 1

			if arg_7_0.buttonUp_ >= 2 then
				arg_7_0:HideItem()
				FuncTimerManager.inst:RemoveFuncTimer(arg_7_0.clickTimer_)

				arg_7_0.clickTimer_ = nil
			end
		end
	end, -1, true)
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_9_0.clickTimer_)

		arg_9_0.clickTimer_ = nil
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:StopTimer()

	if arg_10_0.popItemView_ then
		arg_10_0.popItemView_:Dispose()

		arg_10_0.popItemView_ = nil
	end
end

return var_0_0
