local var_0_0 = class("ActivityStoryStageBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.clearController_ = ControllerUtil.GetController(arg_1_0.transform_, "clear")
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if not arg_5_0.isOpen_ then
			local var_6_0 = WarchessLevelCfg[arg_5_0.preStageID_].type

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[var_6_0].remark, WarchessLevelCfg[arg_5_0.preStageID_].name_level))
		else
			StoryStageActivityData:SaveHistoryStage(arg_5_0.chapterID_, arg_5_0.stageID_)
			arg_5_0:Go("storyStageInfoActivity", {
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
				section = arg_5_0.stageID_,
				chapterID = arg_5_0.chapterID_
			})
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.stageID_ = arg_7_1
	arg_7_0.chapterID_ = arg_7_2
	arg_7_0.preStageID_ = nil

	for iter_7_0, iter_7_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_7_1[1][1] == arg_7_2 and iter_7_1[1][2] == arg_7_1 then
			arg_7_0.preStageID_ = iter_7_1[2][1]
		end
	end

	local var_7_0 = StoryStageActivityData:GetStageData(arg_7_0.chapterID_)[arg_7_0.stageID_]

	if var_7_0 then
		local var_7_1 = 100

		if arg_7_0.preStageID_ then
			var_7_1 = ChessTools.GetChapterProgress(arg_7_0.preStageID_)
		end

		arg_7_0.isLock_ = false
		arg_7_0.isOpen_ = var_7_1 >= 100

		if var_7_0.clear_times > 0 then
			arg_7_0.isClear_ = true
		else
			arg_7_0.isClear_ = false
		end
	else
		arg_7_0.isLock_ = true
		arg_7_0.isOpen_ = false
		arg_7_0.isClear_ = false
	end

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0:GetPosition()

	arg_8_0.transform_.localPosition = Vector3(var_8_0[1], var_8_0[2], 0)

	local var_8_1 = ActivityStoryChapterCfg[arg_8_0.chapterID_]
	local var_8_2 = var_8_1.activity_id
	local var_8_3 = table.keyof(var_8_1.stage_list, arg_8_0.stageID_)

	arg_8_0.textIndex_.text = string.format("%02d", var_8_3)

	local var_8_4 = BattleActivityStoryStageCfg[arg_8_0.stageID_]

	arg_8_0.textName_.text = GetI18NText(var_8_4.name)
	arg_8_0.imageBg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_8_4.background_1))

	arg_8_0:Show(not arg_8_0.isLock_)
	arg_8_0:RefreshClear()
end

function var_0_0.GetPosition(arg_9_0)
	local var_9_0 = BattleActivityStoryStageCfg[arg_9_0.stageID_]

	return var_9_0 and var_9_0.position or {
		0,
		0
	}
end

function var_0_0.SelectorItem(arg_10_0, arg_10_1)
	return
end

function var_0_0.RefreshClear(arg_11_0)
	if arg_11_0.isClear_ then
		arg_11_0.clearController_:SetSelectedState("on")
	else
		arg_11_0.clearController_:SetSelectedState("off")
	end
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.IsOpenSectionInfo(arg_13_0)
	return arg_13_0:IsOpenRoute("storyStageInfoActivity")
end

return var_0_0
