local var_0_0 = class("HardLevelBaseView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.hardLevelItems_ = {}

	arg_1_0:InitUI()
	arg_1_0:AddListeners()
end

function var_0_0.OnEnter(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.hardLevelItems_) do
		iter_2_1:OnEnter()
	end

	arg_2_0:ShowDifficultPanel(false)
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:StopTimer()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.hardLevelItems_) do
		iter_3_1:OnExit()
	end

	arg_3_0:ShowDifficultPanel(false)
end

function var_0_0.Dispose(arg_4_0)
	if arg_4_0.hardLevelItems_ then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.hardLevelItems_) do
			iter_4_1:Dispose()
		end

		arg_4_0.hardLevelItems_ = nil
	end

	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	for iter_5_0 = 1, BattleConst.HARD_CNT do
		arg_5_0.hardLevelItems_[iter_5_0] = arg_5_0:GetHardLevelItem().New(arg_5_0["hardLevelGo" .. iter_5_0 .. "_"], iter_5_0)
	end

	arg_5_0.hardController_ = arg_5_0.btnControllerEx_:GetController("hard")
	arg_5_0.hideController_ = arg_5_0.controllerEx_:GetController("hide")
end

function var_0_0.GetHardLevelItem(arg_6_0)
	return HardLevelBaseItem
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.selectDifficultBtn_, nil, function()
		arg_7_0:ShowDifficultPanel(true)
		arg_7_0:ClickListener()
	end)
end

function var_0_0.RefreshSelectDifficult(arg_9_0)
	if arg_9_0.hardLevel_ == 1 then
		arg_9_0.hardController_:SetSelectedState("hard1")
	elseif arg_9_0.hardLevel_ == 2 then
		arg_9_0.hardController_:SetSelectedState("hard2")
	end

	arg_9_0.difficultText_.text = GetTips(BattleConst.HARD_LANGUAGE[arg_9_0.hardLevel_])
end

function var_0_0.ShowDifficultPanel(arg_10_0, arg_10_1)
	arg_10_0.hideController_:SetSelectedState(tostring(not arg_10_1))
end

function var_0_0.ClickListener(arg_11_0)
	if not arg_11_0.clickTimer_ then
		arg_11_0.buttonUp_ = 0
		arg_11_0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function()
			if Input.GetMouseButtonUp(0) then
				arg_11_0.buttonUp_ = arg_11_0.buttonUp_ + 1

				if arg_11_0.buttonUp_ >= 2 then
					arg_11_0:ShowDifficultPanel(false)
					FuncTimerManager.inst:RemoveFuncTimer(arg_11_0.clickTimer_)

					arg_11_0.clickTimer_ = nil
				end
			end
		end, -1, true)
	end
end

function var_0_0.StopTimer(arg_13_0)
	if arg_13_0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_13_0.clickTimer_)

		arg_13_0.clickTimer_ = nil
	end
end

function var_0_0.SetData(arg_14_0, arg_14_1)
	arg_14_0.hardLevel_ = arg_14_1

	arg_14_0:RefreshSelectDifficult()
end

return var_0_0
