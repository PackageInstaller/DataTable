local var_0_0 = class("IndiaNianStageInfoView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0:InitUI()
end

function var_0_0.UIName(arg_2_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaNianUI/IndiaNianStageInforUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.itemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.dropList_, CommonItem)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:Back()
		arg_5_0.params_.callback()
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		if arg_5_0.cost_ > ItemTools.getItemNum(IndiaNianData:GetSelectedStageCost()[1]) then
			arg_5_0:PopCurrencyWindow()
		else
			arg_5_0:OnClickBtn()
		end
	end)
end

function var_0_0.IndexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.rewardList_[arg_8_1]
	local var_8_1 = rewardToItemTemplate(var_8_0)

	arg_8_2:RefreshData(var_8_1)
	arg_8_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_8_1)
	end)
end

function var_0_0.OnClickBtn(arg_10_0)
	local var_10_0 = arg_10_0.stageID_
	local var_10_1 = BattleIndiaNianCfg[arg_10_0.stageID_]
	local var_10_2 = IndiaNianData:GetActivityID()
	local var_10_3 = IndiaNianData:GetSelectedDestID()

	arg_10_0:Go("/sectionSelectHero", {
		section = var_10_0,
		sectionType = arg_10_0.stageType_,
		activityID = var_10_2,
		destID = var_10_3
	})
end

function var_0_0.PopCurrencyWindow(arg_11_0)
	ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemCfg[IndiaNianData:GetSelectedStageCost()[1]].name))
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.stageID_ = arg_12_0.params_.section
	arg_12_0.stageType_ = arg_12_0.params_.sectionType

	manager.windowBar:RegistBackCallBack(function()
		if arg_12_0.params_.callback then
			arg_12_0:Back()
			arg_12_0.params_.callback()
		end
	end)
	arg_12_0:RefreshData()
end

function var_0_0.RefreshData(arg_14_0)
	arg_14_0.drop_lib_id_ = BattleIndiaNianCfg[arg_14_0.stageID_].drop_lib_id
	arg_14_0.isFirstClear_ = true
	arg_14_0.cost_ = IndiaNianData:GetSelectedStageCost()[2] or 0
	arg_14_0.rewardList_ = getRewardFromDropCfg(arg_14_0.drop_lib_id_, arg_14_0.isFirstClear_)

	arg_14_0:RefreshStageInfo()
end

function var_0_0.RefreshStageInfo(arg_15_0)
	local var_15_0 = BattleIndiaNianCfg[arg_15_0.stageID_]

	if arg_15_0.oldCfgID_ ~= var_15_0.id then
		local var_15_1 = IndiaNianData:GetSelectedStageCost()[1]

		arg_15_0.sectionName_.text = var_15_0.name
		arg_15_0.textStory_.text = var_15_0.tips
		arg_15_0.oldCfgID_ = var_15_0.id
		arg_15_0.costImg_.sprite = ItemTools.getItemLittleSprite(var_15_1)
		arg_15_0.costText_.text = "x" .. arg_15_0.cost_
	end

	arg_15_0.itemList_:StartScroll(#arg_15_0.rewardList_)
end

function var_0_0.Dispose(arg_16_0)
	var_0_0.super.Dispose(arg_16_0)

	if arg_16_0.itemList_ then
		arg_16_0.itemList_:Dispose()

		arg_16_0.itemList_ = nil
	end
end

return var_0_0
