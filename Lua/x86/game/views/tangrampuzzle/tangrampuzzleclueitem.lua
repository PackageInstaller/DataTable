local var_0_0 = class("PuzzleNewCheckPoint", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

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
	arg_3_0.tipsController_ = ControllerUtil.GetController(arg_3_0.transform_, "tips")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not arg_4_0.unlock_ then
			return
		end

		if TangramPuzzleData:GetCurClueDic(arg_4_0.activityID_)[arg_4_0.id_] == true then
			if TangramPuzzleData:GetSelecteClue(arg_4_0.activityID_, arg_4_0.id_) == true then
				TangramPuzzleData:SetSelecteClue(arg_4_0.activityID_, arg_4_0.id_, false)
				arg_4_0.tipsController_:SetSelectedState("off")
				arg_4_0.statusController_:SetSelectedState("on")
			else
				TangramPuzzleData:SetSelecteClue(arg_4_0.activityID_, arg_4_0.id_, true)
				arg_4_0.tipsController_:SetSelectedState("on")
				arg_4_0.statusController_:SetSelectedState("normal")
				arg_4_0.animator_:Play("puzzleClueTemplate", -1, 0)
				arg_4_0.animator_:Update(0)
			end
		else
			TangramPuzzleAction.Operation(arg_4_0.activityID_, TangramPuzzleAction.OPERATION_TYPE.CLUE, {
				clueID = arg_4_0.id_
			}, function()
				arg_4_0.statusController_:SetSelectedState("normal")
				TangramPuzzleData:SetSelecteClue(arg_4_0.activityID_, arg_4_0.id_, true)
				arg_4_0.tipsController_:SetSelectedState("on")
				arg_4_0.animator_:Play("puzzleClueTemplate", -1, 0)
				arg_4_0.animator_:Update(0)
			end)
		end
	end)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)

	if arg_7_1 == false and arg_7_0.descRebuildTimer_ then
		arg_7_0.descRebuildTimer_:Stop()

		arg_7_0.descRebuildTimer_ = nil
	end
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.SetData(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.activityID_ = arg_9_1
	arg_9_0.id_ = arg_9_2
	arg_9_0.regionType_ = PuzzleNewClueCfg[arg_9_0.id_].area_type

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.descText_.text = PuzzleNewClueCfg[arg_10_0.id_].clue_desc

	arg_10_0:RefreshStatus()
end

function var_0_0.RefreshStatus(arg_11_0)
	arg_11_0.unlock_ = TangramPuzzleTools.CheckRegionAllRightByType(arg_11_0.activityID_, arg_11_0.regionType_)

	SetActive(arg_11_0.gameObject_, arg_11_0.unlock_ == true)

	if arg_11_0.unlock_ == true then
		if TangramPuzzleData:GetCurClueDic(arg_11_0.activityID_)[arg_11_0.id_] == true then
			arg_11_0.statusController_:SetSelectedState("off")
			arg_11_0.statusController_:SetSelectedState("on")

			if TangramPuzzleData:GetSelecteClue(arg_11_0.activityID_, arg_11_0.id_) == true then
				arg_11_0.tipsController_:SetSelectedState("on")
				arg_11_0.statusController_:SetSelectedState("normal")
				arg_11_0:RebuildDescLayout()
				arg_11_0.animator_:Play("puzzleClueTemplate", -1, 99999)
			else
				arg_11_0.tipsController_:SetSelectedState("off")
			end
		else
			arg_11_0.statusController_:SetSelectedState("off")
			arg_11_0.tipsController_:SetSelectedState("off")
		end
	end
end

function var_0_0.SetTipsController(arg_12_0, arg_12_1)
	if arg_12_0.unlock_ == true and arg_12_0.tipsController_:GetSelectedState() == "on" then
		arg_12_0.tipsController_:SetSelectedState(arg_12_1 == true and "on" or "off")
		arg_12_0.statusController_:SetSelectedState(arg_12_1 == true and "normal" or "on")
		TangramPuzzleData:SetSelecteClue(arg_12_0.activityID_, arg_12_0.id_, arg_12_1)
		arg_12_0:RebuildDescLayout()
	end
end

function var_0_0.RebuildDescLayout(arg_13_0)
	if arg_13_0.descRebuildTimer_ then
		arg_13_0.descRebuildTimer_:Stop()

		arg_13_0.descRebuildTimer_ = nil
	end

	arg_13_0.descRebuildTimer_ = Timer.New(function()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.descText_.transform)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_0.descContentTrans_)

		if arg_13_0.descRebuildTimer_ then
			arg_13_0.descRebuildTimer_:Stop()

			arg_13_0.descRebuildTimer_ = nil
		end
	end, 0.1, 1)

	arg_13_0.descRebuildTimer_:Start()
end

return var_0_0
