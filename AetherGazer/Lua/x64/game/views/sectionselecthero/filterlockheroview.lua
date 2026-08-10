local var_0_0 = class("FilterLockHeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Formation/FormationEliminatePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.heroListGo_, FilterLockHeroItem)
	arg_4_0.typeController_ = arg_4_0.controllerEx_:GetController("type")
	arg_4_0.skipController_ = arg_4_0.controllerEx_:GetController("skip")
end

function var_0_0.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.comfirmBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.backMaskBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.skinBtn_, nil, function()
		arg_5_0.skipFlag_ = not arg_5_0.skipFlag_

		if arg_5_0.skipFlag_ then
			SectionSelectHeroTools.SetSkipDisplayFilterLockHeroTime(manager.time:GetServerTime())
		else
			SectionSelectHeroTools.SetSkipDisplayFilterLockHeroTime(0)
		end

		arg_5_0:RefreshSkip()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.skipFlag_ = false

	arg_9_0:RefreshType()
	arg_9_0:RefreshSkip()
	arg_9_0:RefreshHeroItem()
	arg_9_0:RefreshLockTips()
end

function var_0_0.RefreshType(arg_10_0)
	arg_10_0.typeController_:SetSelectedState(arg_10_0.params_.type)

	if arg_10_0.params_.type == SectionSelectHeroConst.DISPLAY_FILTER_LOCK_HERO_TYPE.NORMAL then
		arg_10_0.titleText_.text = GetTips("DEFAULT_TEAM_CHARACTER_HAS_LOCKED_TITLE")
	else
		arg_10_0.titleText_.text = GetTips("TEAM_CHARACTER_HAS_LOCKED_TITLE")
	end
end

function var_0_0.RefreshSkip(arg_11_0)
	arg_11_0.skipController_:SetSelectedState(tostring(arg_11_0.skipFlag_))
end

function var_0_0.RefreshHeroItem(arg_12_0)
	arg_12_0.heroIDList_ = arg_12_0.params_.heroIDList

	arg_12_0.heroItemList_:StartScroll(#arg_12_0.heroIDList_)
end

function var_0_0.RefreshLockTips(arg_13_0)
	local var_13_0 = ""

	for iter_13_0 = 1, #arg_13_0.heroIDList_ do
		local var_13_1

		if HeroStandardSystemCfg[arg_13_0.heroIDList_[iter_13_0]] then
			var_13_1 = HeroStandardSystemCfg[arg_13_0.heroIDList_[iter_13_0]].hero_id
		else
			var_13_1 = arg_13_0.heroIDList_[iter_13_0]
		end

		var_13_0 = var_13_0 .. string.format("「%s」", HeroTools.GetHeroFullName(var_13_1))
	end

	arg_13_0.lockHeroTips_.text = string.format(GetTips("TEAM_CHARACTER_HAS_LOCKED"), var_13_0)
end

function var_0_0.IndexItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.heroIDList_[arg_14_1])
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.heroItemList_:Dispose()

	arg_15_0.heroItemList_ = nil

	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
