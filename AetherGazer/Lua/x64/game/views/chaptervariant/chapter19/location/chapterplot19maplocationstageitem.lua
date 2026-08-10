local var_0_0 = class("ChapterPlot19MapLocationStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stageTypeController_ = arg_1_0.controllerEx_:GetController("type")
	arg_1_0.clearController_ = arg_1_0.controllerEx_:GetController("clear")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.chapterID_ = arg_2_1
	arg_2_0.stageInfo_ = arg_2_2

	arg_2_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_3_0)
	local var_3_0 = arg_3_0.stageInfo_
	local var_3_1 = var_3_0.stageType

	if var_3_1 == BattleConst.PLOT_19_STAGE_TYPE.EVENT then
		local var_3_2 = var_3_0.id
		local var_3_3 = StageArchiveCfg[var_3_2]

		arg_3_0.nameText_.text = var_3_3.name

		arg_3_0.stageTypeController_:SetSelectedState("event")
		arg_3_0.clearController_:SetSelectedState(tostring(BattleStageData:HasReadLocationEvent(var_3_2) ~= nil))

		if ChapterTools.IsUnlockEvent(var_3_2) then
			arg_3_0:Show(true)
		else
			arg_3_0:Show(false)
		end
	else
		local var_3_4 = var_3_0.id
		local var_3_5 = BattleStageTools.GetStageCfg(ChapterCfg[arg_3_0.chapterID_].type, var_3_4)

		arg_3_0.nameText_.text = var_3_5.name

		if var_3_1 == BattleConst.PLOT_19_STAGE_TYPE.MAIN_STORY then
			arg_3_0.stageTypeController_:SetSelectedState("main")
		else
			arg_3_0.stageTypeController_:SetSelectedState("side")
		end

		local var_3_6 = BattleStageData:GetStageData()[var_3_4]
		local var_3_7 = false

		if var_3_6 then
			arg_3_0:Show(true)

			if var_3_6.clear_times > 0 then
				var_3_7 = true
			end
		else
			arg_3_0:Show(false)
		end

		arg_3_0.clearController_:SetSelectedState(tostring(var_3_7))
	end
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		local var_5_0 = arg_4_0.stageInfo_

		if var_5_0.stageType == BattleConst.PLOT_19_STAGE_TYPE.EVENT then
			BattleStageAction.UpdateLocationEvent(var_5_0.id)

			local var_5_1 = StageArchiveCfg[var_5_0.id]

			JumpTools.OpenPageByJump("gameHelpLong", {
				title = var_5_1.name,
				content = formatText(var_5_1.desc)
			})
		else
			arg_4_0:Go("chapter19SectionInfo", {
				section = var_5_0.id,
				sectionType = ChapterCfg[arg_4_0.chapterID_].type
			})
		end
	end)
end

function var_0_0.Show(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)

	if arg_6_1 then
		arg_6_0.transform_:SetAsLastSibling()
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)

	arg_7_0.gameObject_ = nil
	arg_7_0.transform_ = nil
end

return var_0_0
