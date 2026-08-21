local var_0_0 = class("SummerStageBaseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.controllerTransform_, "name")
	arg_2_0.clearController_ = ControllerUtil.GetController(arg_2_0.controllerTransform_, "getn")
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

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.stageID_ = arg_6_1
	arg_6_0.chapterID_ = arg_6_2

	arg_6_0:RefreshLockData(arg_6_1, arg_6_2)
	arg_6_0:RefreshData()
	arg_6_0:RefreshUI()
end

function var_0_0.RefreshLockData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.isLock_ = false

	for iter_7_0, iter_7_1 in pairs(GameSetting.activity_plot_unlock.value) do
		if iter_7_1[1][1] == arg_7_2 and iter_7_1[1][2] == arg_7_1 then
			for iter_7_2, iter_7_3 in ipairs(iter_7_1[2]) do
				arg_7_0.isLock_ = ChessTools.GetChapterProgress(iter_7_3) < 100

				if arg_7_0.isLock_ then
					arg_7_0.preStageID_ = iter_7_3

					return
				end
			end

			return
		end
	end
end

function var_0_0.IsOpenSectionInfo(arg_8_0)
	return arg_8_0:IsOpenRoute("storyStageInfoActivity")
end

function var_0_0.GetPosition(arg_9_0)
	local var_9_0 = BattleActivityStoryStageCfg[arg_9_0.stageID_]

	return var_9_0 and var_9_0.position or {
		0,
		0
	}
end

function var_0_0.RefreshData(arg_10_0)
	local var_10_0 = StoryStageActivityData:GetStageData(arg_10_0.chapterID_)[arg_10_0.stageID_]

	if var_10_0 then
		arg_10_0.clearTimes_ = var_10_0.clear_times
	else
		arg_10_0.clearTimes_ = 0
	end
end

function var_0_0.OnClick(arg_11_0)
	if arg_11_0.isLock_ then
		ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
	else
		StoryStageActivityData:SaveHistoryStage(arg_11_0.chapterID_, arg_11_0.stageID_)
		arg_11_0:Go("storyStageInfoActivity", {
			sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_STORY,
			section = arg_11_0.stageID_,
			chapterID = arg_11_0.chapterID_
		})
	end
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = arg_12_0:GetPosition()

	arg_12_0.transform_.localPosition = Vector3(var_12_0[1], var_12_0[2], 0)

	arg_12_0:RefreshText()

	if arg_12_0.isLock_ then
		arg_12_0.controller_:SetSelectedState("off")
	else
		arg_12_0.controller_:SetSelectedState("on")
	end

	if arg_12_0.clearTimes_ > 0 then
		arg_12_0.clearController_:SetSelectedState("get")
	else
		arg_12_0.clearController_:SetSelectedState("nor")
	end

	arg_12_0:Show(true)
end

function var_0_0.GetLocalPosition(arg_13_0)
	return arg_13_0.transform_.localPosition
end

function var_0_0.SelectorItem(arg_14_0, arg_14_1)
	if arg_14_0.stageID_ == arg_14_1 and arg_14_0:IsOpenSectionInfo() then
		arg_14_0.controller_:SetSelectedState("selected")
	elseif arg_14_0.isLock_ then
		arg_14_0.controller_:SetSelectedState("off")
	else
		arg_14_0.controller_:SetSelectedState("on")
	end
end

function var_0_0.Show(arg_15_0, arg_15_1)
	SetActive(arg_15_0.gameObject_, arg_15_1)
end

function var_0_0.RefreshText(arg_16_0)
	return
end

return var_0_0
