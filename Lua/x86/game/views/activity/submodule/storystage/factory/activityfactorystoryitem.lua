local var_0_0 = class("ActivityFactoryStoryItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.clearController_ = ControllerUtil.GetController(arg_1_0.transform_, "clear")
	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.lineController_ = ControllerUtil.GetController(arg_1_0.transform_, "line")
end

function var_0_0.OnExit(arg_2_0)
	if arg_2_0.archiveView_ then
		arg_2_0.archiveView_:OnExit()
	end

	arg_2_0:Show(false)
end

function var_0_0.Dispose(arg_3_0)
	if arg_3_0.archiveView_ then
		arg_3_0.archiveView_:Dispose()

		arg_3_0.archiveView_ = nil
	end

	var_0_0.super.Dispose(arg_3_0)
	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		BattleFieldData:SetCacheStage(arg_4_0.chapterID_, arg_4_0.stageID_)
		arg_4_0:Go("subPlotSectionInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT,
			chapterID = arg_4_0.chapterID_,
			section = arg_4_0.stageID_
		})
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.stageID_ = arg_6_1
	arg_6_0.chapterID_ = arg_6_2

	local var_6_0 = BattleStageData:GetStageData()[arg_6_0.stageID_]

	arg_6_0.isClear_ = false

	if var_6_0 and var_6_0.clear_times > 0 then
		arg_6_0.isClear_ = true
	end

	arg_6_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = arg_7_0:GetPosition()

	arg_7_0.transform_.localPosition = Vector3(var_7_0[1], var_7_0[2], 0)

	local var_7_1 = ChapterCfg[arg_7_0.chapterID_]
	local var_7_2 = var_7_1.activity_id
	local var_7_3 = table.keyof(var_7_1.section_id_list, arg_7_0.stageID_)

	arg_7_0.textIndex_.text = string.format("%02d", var_7_3)

	local var_7_4 = BattleActivityStoryStageCfg[arg_7_0.stageID_]

	arg_7_0.textName_.text = GetI18NText(var_7_4.name)

	arg_7_0:RefreshClear()
	arg_7_0:RefreshArchive()
	arg_7_0:Show(true)
end

function var_0_0.GetPosition(arg_8_0)
	local var_8_0 = BattleActivityStoryStageCfg[arg_8_0.stageID_]

	return var_8_0 and var_8_0.position or {
		0,
		0
	}
end

function var_0_0.SelectorItem(arg_9_0, arg_9_1)
	if arg_9_0.stageID_ == arg_9_1 and arg_9_0:IsOpenSectionInfo() then
		arg_9_0.selectController_:SetSelectedState("on")
	else
		arg_9_0.selectController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshClear(arg_10_0)
	if arg_10_0.isClear_ then
		arg_10_0.clearController_:SetSelectedState("on")
	else
		arg_10_0.clearController_:SetSelectedState("off")
	end
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.IsOpenSectionInfo(arg_12_0)
	return arg_12_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_0.RefreshArchive(arg_13_0)
	arg_13_0.lineController_:SetSelectedState("hide")
end

function var_0_0.GetLocalPosition(arg_14_0)
	return arg_14_0.transform_.localPosition
end

return var_0_0
