local var_0_0 = class("SubPlotBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.clearController_ = ControllerUtil.GetController(arg_1_0.transform_, "clear")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.stageID_ = arg_2_1
	arg_2_0.chapterID_ = arg_2_2

	local var_2_0 = BattleStageData:GetStageData()[arg_2_1]

	if var_2_0 and var_2_0.clear_times > 0 then
		arg_2_0.isClear_ = true
	else
		arg_2_0.isClear_ = false
	end

	arg_2_0:RefreshUI()
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		arg_4_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_6_0)
	BattleFieldData:SetCacheStage(arg_6_0.chapterID_, arg_6_0.stageID_)
	arg_6_0:Go("subPlotSectionInfo", {
		section = arg_6_0.stageID_,
		chapterID = arg_6_0.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function var_0_0.IsOpenSectionInfo(arg_7_0)
	return arg_7_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0:GetPosition()

	arg_8_0.transform_.localPosition = Vector3(var_8_0[1], var_8_0[2], 0)

	arg_8_0:Show(true)
	arg_8_0:RefreshCustomUI()
	arg_8_0:RefreshClear()
end

function var_0_0.RefreshCustomUI(arg_9_0)
	return
end

function var_0_0.SelectorItem(arg_10_0, arg_10_1)
	if arg_10_0.stageID_ == arg_10_1 and arg_10_0:IsOpenSectionInfo() then
		arg_10_0.selectController_:SetSelectedState("on")
	else
		arg_10_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshClear(arg_11_0)
	if arg_11_0.isClear_ then
		arg_11_0.clearController_:SetSelectedState("on")
	else
		arg_11_0.clearController_:SetSelectedState("off")
	end
end

function var_0_0.GetPosition(arg_12_0)
	local var_12_0 = BattleActivityStoryStageCfg[arg_12_0.stageID_]

	return var_12_0 and var_12_0.position or {
		0,
		0
	}
end

function var_0_0.GetLocalPosition(arg_13_0)
	return arg_13_0.transform_.localPosition
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

return var_0_0
