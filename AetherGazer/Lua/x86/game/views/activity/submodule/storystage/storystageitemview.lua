local var_0_0 = class("StoryStageItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
	arg_1_0.clearController_ = ControllerUtil.GetController(arg_1_0.transform_, "clear")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.selectChapterID_ = arg_2_2
	arg_2_0.stageID_ = arg_2_1

	arg_2_0:RefreshLockData(arg_2_1, arg_2_2)
	arg_2_0:RefreshClearData(arg_2_1)
	arg_2_0:RefreshUI()
end

function var_0_0.RefreshClearData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = StoryStageActivityData:GetStageData(arg_3_2)[arg_3_1]

	if var_3_0 and var_3_0.clear_times > 0 then
		arg_3_0.isClear_ = true
	else
		arg_3_0.isClear_ = false
	end
end

function var_0_0.RefreshLockData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.isLock_ = false

	for iter_4_0, iter_4_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_4_1[1][1] == arg_4_2 and iter_4_1[1][2] == arg_4_1 then
			for iter_4_2, iter_4_3 in ipairs(iter_4_1[2]) do
				arg_4_0.isLock_ = ChessTools.GetChapterProgress(iter_4_3) < 100

				if arg_4_0.isLock_ then
					arg_4_0.preStageID_ = iter_4_3

					return
				end
			end

			return
		end
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.button_, nil, function()
		arg_6_0:OnClick()
	end)
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = BattleActivityStoryStageCfg[arg_8_0.stageID_]
	local var_8_1 = var_8_0.position

	arg_8_0.transform_.localPosition = Vector3(var_8_1[1], var_8_1[2], 0)
	arg_8_0.textName_.text = GetI18NText(var_8_0.name)

	arg_8_0:RefreshClear()
	arg_8_0:Show(true)
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)
end

function var_0_0.GetLocalPosition(arg_10_0)
	return arg_10_0.transform_.localPosition
end

function var_0_0.OnClick(arg_11_0)
	if arg_11_0.isLock_ then
		local var_11_0 = WarchessLevelCfg[arg_11_0.preStageID_]
		local var_11_1 = var_11_0.type

		ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityCfg[var_11_1].remark, var_11_0.name_level))
	else
		StoryStageActivityData:SaveHistoryStage(arg_11_0.selectChapterID_, arg_11_0.stageID_)
		arg_11_0:Go("storyStageInfoActivity", {
			chapterID = arg_11_0.selectChapterID_,
			section = arg_11_0.stageID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY
		})
	end
end

function var_0_0.SelectorItem(arg_12_0, arg_12_1)
	if arg_12_0.stageID_ == arg_12_1 and arg_12_0:IsOpenSectionInfo() then
		arg_12_0.controller_:SetSelectedState("Select")
	else
		arg_12_0.controller_:SetSelectedState("normal")
	end
end

function var_0_0.RefreshClear(arg_13_0)
	if arg_13_0.isClear_ then
		arg_13_0.clearController_:SetSelectedState("on")
	else
		arg_13_0.clearController_:SetSelectedState("off")
	end
end

function var_0_0.IsOpenSectionInfo(arg_14_0)
	return arg_14_0:IsOpenRoute("storyStageInfoActivity")
end

return var_0_0
