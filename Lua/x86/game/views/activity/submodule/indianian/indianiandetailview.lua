local var_0_0 = class("IndiaNianDetailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianExplainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.stageItemList_ = {}

	for iter_3_0 = 1, 8 do
		local var_3_0 = arg_3_0["stageGo_" .. iter_3_0]
		local var_3_1 = IndiaNianStageDescItem.New(var_3_0)

		table.insert(arg_3_0.stageItemList_, var_3_1)
	end

	arg_3_0.iconController_ = ControllerUtil.GetController(arg_3_0.transform_, "icon")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bossBtn_, nil, function()
		_G.IndiaNianDescSelectedIndex = 0
		arg_5_0.selectedIndex_ = 0

		IndiaNianData:SetSelectedDescIndex(arg_5_0.selectedIndex_)
		arg_5_0:RefreshBossUI()
	end)
end

function var_0_0.OnDataUpdate(arg_7_0)
	arg_7_0:RefreshData()
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshData(arg_8_0)
	arg_8_0.bossCfgIDList_ = IndiaNianCfg.get_id_list_by_activity_id[arg_8_0.activityID_]
	arg_8_0.round = IndiaNianData:GetRound()

	local var_8_0 = {}
	local var_8_1 = 1

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.bossCfgIDList_) do
		local var_8_2 = IndiaNianCfg[iter_8_1]

		if var_8_2.group_id == 100 and not var_8_0[var_8_2.group_id] then
			arg_8_0.bossCfg_ = var_8_2

			IndiaNianData:SetSelectedStage(arg_8_0.bossCfg_.stage_id)
		elseif not var_8_0[var_8_2.group_id] then
			arg_8_0.stageItemList_[var_8_1]:SetData(var_8_1, var_8_2)
			arg_8_0.stageItemList_[var_8_1]:SetCallBack(function(arg_9_0)
				_G.IndiaNianDescSelectedIndex = arg_9_0
				arg_8_0.selectedIndex_ = arg_9_0

				arg_8_0:RefreshUI()
			end)

			var_8_1 = var_8_1 + 1
		end

		var_8_0[var_8_2.group_id] = true
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.activityID_ = IndiaNianData:GetActivityID()
	arg_10_0.selectedIndex_ = _G.IndiaNianDescSelectedIndex or 0

	arg_10_0:RefreshData()
	arg_10_0:RefreshUI()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.stageItemList_ then
		for iter_11_0 = 1, 8 do
			arg_11_0.stageItemList_[iter_11_0]:OnExit()
		end
	end
end

function var_0_0.RefreshUI(arg_12_0)
	if arg_12_0.selectedIndex_ == 0 then
		arg_12_0:RefreshBossUI()

		return
	end

	local var_12_0 = arg_12_0.stageItemList_[arg_12_0.selectedIndex_].cfg_

	arg_12_0.descText_.text = var_12_0.desc
	arg_12_0.nameText_.text = var_12_0.name

	arg_12_0.iconController_:SetSelectedState("subBoss")

	arg_12_0.titleImg_.sprite = getSprite("Atlas/IndiaUI_2_8", var_12_0.icon)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.stageItemList_) do
		iter_12_1:RefreshState()
	end
end

function var_0_0.RefreshBossUI(arg_13_0)
	local var_13_0 = arg_13_0.bossCfg_

	arg_13_0.descText_.text = var_13_0.desc
	arg_13_0.nameText_.text = var_13_0.name

	arg_13_0.iconController_:SetSelectedState("boss")

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.stageItemList_) do
		iter_13_1:RefreshState()
	end
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.stageItemList_) do
		iter_14_1:Dispose()
	end

	arg_14_0.stageItemList_ = nil
end

return var_0_0
