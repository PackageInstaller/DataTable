local var_0_0 = class("SubPlotNoahSectionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		arg_3_0:OnClick()
	end)
end

function var_0_0.OnClick(arg_5_0)
	if arg_5_0.isLock_ then
		-- block empty
	else
		arg_5_0:Go("subPlotSectionInfo", {
			section = arg_5_0.stageID_,
			chapterID = arg_5_0.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.selectController_ = arg_6_0.controller_:GetController("select")
	arg_6_0.lockController_ = arg_6_0.controller_:GetController("lock")
	arg_6_0.threeStarBarList_ = {}

	for iter_6_0 = 1, 3 do
		arg_6_0.threeStarBarList_[iter_6_0] = SectionThreeStarBar.New(arg_6_0[string.format("starGo%s_", iter_6_0)])
	end
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.chapterID_ = arg_7_1
	arg_7_0.stageID_ = arg_7_2

	arg_7_0:UpdateData()
	arg_7_0:RefreshUI()
end

function var_0_0.UpdateData(arg_8_0)
	local var_8_0 = BattleStageData:GetStageData()[arg_8_0.stageID_]
	local var_8_1 = ChapterCfg[arg_8_0.chapterID_]

	if var_8_0 then
		arg_8_0.isLock_ = false
		arg_8_0.clearTimes_ = var_8_0.clear_times
	else
		arg_8_0.clearTimes_ = 0

		if table.keyof(var_8_1.section_id_list, arg_8_0.stageID_) == 1 then
			arg_8_0.isLock_ = false
		elseif arg_8_0:IsUnlockPreStage() then
			arg_8_0.isLock_ = false
		else
			arg_8_0.isLock_ = true
		end

		arg_8_0.clearTimes_ = 0
	end
end

function var_0_0.IsUnlockPreStage(arg_9_0)
	local var_9_0 = BattleStageData:GetStageData()
	local var_9_1 = BattleActivityStoryStageCfg[arg_9_0.stageID_]

	if var_9_1.pre_show_id_list == nil then
		print(string.format("关卡 %s 未配置前置关卡", arg_9_0.stageID_))

		return true
	end

	for iter_9_0, iter_9_1 in pairs(var_9_1.pre_show_id_list) do
		if var_9_0[iter_9_1] and var_9_0[iter_9_1].clear_times > 0 then
			return true
		end
	end

	return false
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshText()
	arg_10_0:RefreshStar()
	arg_10_0:RefreshLock()
end

function var_0_0.RefreshStar(arg_11_0)
	if arg_11_0.clearTimes_ >= 1 then
		for iter_11_0 = 1, 3 do
			arg_11_0.threeStarBarList_[iter_11_0]:SetData(true)
		end
	else
		for iter_11_1 = 1, 3 do
			arg_11_0.threeStarBarList_[iter_11_1]:SetData(false)
		end
	end
end

function var_0_0.RefreshText(arg_12_0)
	if arg_12_0.stageID_ then
		arg_12_0.nameText_.text = GetI18NText(BattleActivityStoryStageCfg[arg_12_0.stageID_].name)
	end
end

function var_0_0.RefreshLock(arg_13_0)
	arg_13_0.lockController_:SetSelectedState(arg_13_0.isLock_ and "lock" or "normal")
end

function var_0_0.SelectorItem(arg_14_0, arg_14_1)
	if arg_14_0.stageID_ == arg_14_1 and arg_14_0:IsOpenSectionInfo() then
		arg_14_0.selectController_:SetSelectedState("state1")
	else
		arg_14_0.selectController_:SetSelectedState("state0")
	end
end

function var_0_0.OnExit(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.threeStarBarList_) do
		iter_16_1:Dispose()
	end

	arg_16_0.threeStarBarList_ = nil

	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.IsOpenSectionInfo(arg_17_0)
	return arg_17_0:IsOpenRoute("subPlotSectionInfo")
end

return var_0_0
