local var_0_0 = class("PuzzleNewCheckPoint", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.statusConst_ = {
		RECEIVED = 2,
		FINISH = 1,
		UNFINISH = 0
	}

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if PuzzleNewData:GetCurCheckList(arg_4_0.activityID_)[arg_4_0.id_] == true and PuzzleNewData:GetSelecteCheckPoint(arg_4_0.activityID_, arg_4_0.id_) then
			PuzzleNewData:SetSelecteCheckPoint(arg_4_0.activityID_, arg_4_0.id_, false)
			AnimatorTools.PlayAnimatorWithCallback(arg_4_0.animator_, "puzzleClueTemplate_close", function()
				arg_4_0:RefreshStatus()
			end)

			return
		end

		PuzzleNewAction.Operation(arg_4_0.activityID_, PuzzleNewAction.OPERATION_TYPE.CHECK, function()
			PuzzleNewData:SetSelecteCheckPoint(arg_4_0.activityID_, arg_4_0.id_, true)
			arg_4_0:RefreshStatus()
			arg_4_0.animator_:Play("puzzleClueTemplate", -1, 0)
			arg_4_0.animator_:Update(0)

			if arg_4_0.clickCallback_ then
				arg_4_0.clickCallback_(arg_4_0.id_)
			end
		end, arg_4_0.id_)
	end)
end

function var_0_0.SetActive(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)

	if arg_8_1 == false and arg_8_0.descRebuildTimer_ then
		arg_8_0.descRebuildTimer_:Stop()

		arg_8_0.descRebuildTimer_ = nil
	end
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.clickCallback_ = nil
	arg_9_0.gameObject_ = nil
	arg_9_0.transform_ = nil

	if arg_9_0.descRebuildTimer_ then
		arg_9_0.descRebuildTimer_:Stop()

		arg_9_0.descRebuildTimer_ = nil
	end

	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.SetData(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.activityID_ = arg_10_1
	arg_10_0.id_ = arg_10_2
	arg_10_0.descText_.text = PuzzleNewClueCfg[arg_10_0.id_].clue_desc

	arg_10_0:RebuildDescLayout()
	arg_10_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_11_0)
	local var_11_0 = PuzzleNewData:GetCurCheckList(arg_11_0.activityID_)
	local var_11_1 = PuzzleNewData:GetCheckTipsList(arg_11_0.activityID_)

	if var_11_0[arg_11_0.id_] == true then
		if PuzzleNewData:GetSelecteCheckPoint(arg_11_0.activityID_, arg_11_0.id_) then
			arg_11_0.statusController_:SetSelectedState("finish")
			arg_11_0.animator_:Play("puzzleClueTemplate", -1, 99999)
		else
			arg_11_0.statusController_:SetSelectedState("tips")
		end
	elseif var_11_1[arg_11_0.id_] == true then
		arg_11_0.statusController_:SetSelectedState("tips")
	else
		arg_11_0.statusController_:SetSelectedState("none")
	end
end

function var_0_0.RegistClickCallback(arg_12_0, arg_12_1)
	arg_12_0.clickCallback_ = arg_12_1
end

function var_0_0.RebuildDescLayout(arg_13_0)
	if arg_13_0.descRebuildTimer_ then
		arg_13_0.descRebuildTimer_:Stop()

		arg_13_0.descRebuildTimer_ = nil
	end

	arg_13_0.descRebuildTimer_ = FrameTimer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.descContentTrans_)

		if arg_13_0.descRebuildTimer_ then
			arg_13_0.descRebuildTimer_:Stop()

			arg_13_0.descRebuildTimer_ = nil
		end
	end, 1, 1)

	arg_13_0.descRebuildTimer_:Start()
end

return var_0_0
