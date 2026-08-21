local var_0_0 = class("OsirisStoryStageItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.transform_.name = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.clearController_ = ControllerUtil.GetController(arg_1_0.transform_, "clear")

	arg_1_0:SetData(arg_1_2, arg_1_3)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.gameObject_ = nil
	arg_2_0.transform_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.stageID_ = arg_5_1
	arg_5_0.chapterID_ = arg_5_2
	arg_5_0.preStageID_ = nil

	for iter_5_0, iter_5_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_5_1[1][1] == arg_5_2 and iter_5_1[1][2] == arg_5_1 then
			arg_5_0.preStageID_ = iter_5_1[2][1]
		end
	end

	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
end

function var_0_0.IsOpenSectionInfo(arg_6_0)
	return arg_6_0:IsOpenRoute("osirisStoryStageInfo")
end

function var_0_0.GetPosition(arg_7_0)
	local var_7_0 = BattleActivityStoryStageCfg[arg_7_0.stageID_]

	return var_7_0 and var_7_0.position or {
		0,
		0
	}
end

function var_0_0.RefreshData(arg_8_0)
	local var_8_0 = StoryStageActivityData:GetStageData(arg_8_0.chapterID_)[arg_8_0.stageID_]

	if var_8_0 then
		local var_8_1 = 100

		if arg_8_0.preStageID_ then
			var_8_1 = ChessTools.GetChapterProgress(arg_8_0.preStageID_)
		end

		arg_8_0.isLock_ = false
		arg_8_0.isOpen_ = var_8_1 >= 100

		if var_8_0.clear_times > 0 then
			arg_8_0.isClear_ = true
		else
			arg_8_0.isClear_ = false
		end
	else
		arg_8_0.isLock_ = true
		arg_8_0.isOpen_ = false
		arg_8_0.isClear_ = false
	end
end

function var_0_0.OnClick(arg_9_0)
	if not arg_9_0.isOpen_ then
		local var_9_0 = WarchessLevelCfg[arg_9_0.preStageID_].type

		ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityCfg[var_9_0].remark), WarchessLevelCfg[arg_9_0.preStageID_].name_level))
	else
		StoryStageActivityData:SaveHistoryStage(arg_9_0.chapterID_, arg_9_0.stageID_)
		arg_9_0:Go("osirisStoryStageInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
			section = arg_9_0.stageID_,
			chapterID = arg_9_0.chapterID_
		})
	end
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0 = arg_10_0:GetPosition()

	arg_10_0.transform_.localPosition = Vector3(var_10_0[1], var_10_0[2], 0)

	local var_10_1 = ActivityStoryChapterCfg[arg_10_0.chapterID_]
	local var_10_2 = var_10_1.activity_id
	local var_10_3 = table.keyof(var_10_1.stage_list, arg_10_0.stageID_)

	arg_10_0.textIndex_.text = string.format("%02d", var_10_3)

	local var_10_4 = BattleActivityStoryStageCfg[arg_10_0.stageID_]

	arg_10_0.textName_.text = GetI18NText(var_10_4.name)
	arg_10_0.imageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_10_4.background_1))

	arg_10_0:Show(not arg_10_0.isLock_)
	arg_10_0:RefreshClear()
end

function var_0_0.GetLocalPosition(arg_11_0)
	return arg_11_0.transform_.localPosition
end

function var_0_0.SelectorItem(arg_12_0, arg_12_1)
	if arg_12_0.stageID_ == arg_12_1 and arg_12_0:IsOpenSectionInfo() then
		SetActive(arg_12_0.selectGo_, true)
	else
		SetActive(arg_12_0.selectGo_, false)
	end
end

function var_0_0.RefreshClear(arg_13_0)
	if arg_13_0.isClear_ then
		arg_13_0.clearController_:SetSelectedState("on")
	else
		arg_13_0.clearController_:SetSelectedState("off")
	end
end

function var_0_0.Show(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

return var_0_0
