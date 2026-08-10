local var_0_0 = class("NewHeroArchiveView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/HeroArchive/ArchiveStoryMainUI_new"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.type_ = 1
	arg_3_0.index_ = 0
	arg_3_0.itemIndex_ = 0

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0.dropDown_.options:Clear()
	arg_4_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("HERO_ARCHIVES_TYPE_1"), nil))
	arg_4_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("HERO_ARCHIVES_TYPE_2"), nil))

	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.heroList_, NewHeroArchiveHeroItemView)
	arg_4_0.allBtnController_ = ControllerUtil.GetController(arg_4_0.allBtn_.transform, "state")

	arg_4_0:InitFillterItem()
end

function var_0_0.InitFillterItem(arg_5_0)
	local var_5_0 = {}

	if not arg_5_0.fillterBtnList_ then
		arg_5_0.fillterBtnList_ = {}
	end

	for iter_5_0, iter_5_1 in pairs(RaceEffectCfg.all) do
		table.insert(var_5_0, RaceEffectCfg[iter_5_1])
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		if not arg_5_0.fillterBtnList_[iter_5_2] then
			local var_5_1 = Object.Instantiate(arg_5_0.fillterItem_)
			local var_5_2 = NewHeroArchiveHeroFillterItemView.New(var_5_1, iter_5_2)

			var_5_2.transform_:SetParent(arg_5_0.btnList_, false)
			var_5_2:SetData(iter_5_3, iter_5_2)
			var_5_2:SetClickCallBack(handler(arg_5_0, arg_5_0.ClickFillterBtn))
			SetActive(var_5_2.gameObject_, true)
			table.insert(arg_5_0.fillterBtnList_, var_5_2)
		end
	end
end

function var_0_0.ClickFillterBtn(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.index_ == arg_6_2 then
		return
	end

	arg_6_0.index_ = arg_6_2

	if arg_6_0.type_ == 1 then
		arg_6_0.archiveList_ = ArchiveData:GetContinuousHeartArchiveListByType(arg_6_1)
	elseif arg_6_0.type_ == 2 then
		arg_6_0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveListByType(arg_6_1)
	end

	arg_6_0.itemIndex_ = 0

	arg_6_0:RefreshUI()
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.archiveList_[arg_7_1], arg_7_0.type_)
	arg_7_2:SetClickCallBack(function()
		arg_7_0.itemIndex_ = arg_7_1
	end)
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.allBtn_, nil, function()
		if arg_9_0.index_ == 0 then
			return
		end

		arg_9_0.index_ = 0
		arg_9_0.itemIndex_ = 0

		if arg_9_0.type_ == 1 then
			arg_9_0.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		else
			arg_9_0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end

		arg_9_0:RefreshUI()
	end)
	arg_9_0:AddToggleListener(arg_9_0.dropDown_, function(arg_11_0)
		arg_9_0.itemIndex_ = 0

		if arg_11_0 == 0 then
			arg_9_0.type_ = 1
		else
			arg_9_0.type_ = 2
		end

		arg_9_0.index_ = 0

		if arg_9_0.type_ == 1 then
			arg_9_0.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		else
			arg_9_0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end

		arg_9_0:RefreshUI()
	end)
end

function var_0_0.OnEnter(arg_12_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_12_0.scrollPosX = arg_12_0:DynamicDivision(arg_12_0.uiList_:GetScrolledPosition().x)
	arg_12_0.timer = Timer.New(function()
		local var_13_0 = arg_12_0:DynamicDivision(arg_12_0.uiList_:GetScrolledPosition().x)

		arg_12_0.filmAni_:SetFloat("floatSpeed", (var_13_0 - arg_12_0.scrollPosX) * 10)

		arg_12_0.scrollPosX = var_13_0
	end, 0.1, -1, true)

	arg_12_0.timer:Start()
	arg_12_0:RefreshUI()
end

function var_0_0.DynamicDivision(arg_14_0, arg_14_1)
	local var_14_0 = 10
	local var_14_1 = 1

	if arg_14_1 < 0 then
		var_14_1 = -1
		arg_14_1 = -arg_14_1
	end

	while arg_14_1 > 1 do
		arg_14_1 = arg_14_1 / var_14_0
		var_14_0 = var_14_0 * 10
	end

	return arg_14_1 * var_14_1
end

function var_0_0.RefreshUI(arg_15_0)
	if not arg_15_0.archiveList_ then
		if arg_15_0.type_ == 1 then
			arg_15_0.archiveList_ = ArchiveData:GetContinuousHeartArchiveList()
		elseif arg_15_0.type_ == 2 then
			arg_15_0.archiveList_ = ArchiveData:GetContinuousSuperHeartArchiveList()
		end
	end

	ArchiveData:SortHeartArchiveList(arg_15_0.archiveList_)

	if arg_15_0.index_ == 0 then
		arg_15_0.allBtnController_:SetSelectedState("selected")
	else
		arg_15_0.allBtnController_:SetSelectedState("unselected")
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_0.fillterBtnList_) do
		iter_15_1:RefreshUI(arg_15_0.type_, arg_15_0.index_)
	end

	arg_15_0.listTimer = Timer.New(function()
		if arg_15_0.heroList_.gameObject.activeInHierarchy == true then
			arg_15_0.uiList_:StartScroll(#arg_15_0.archiveList_)
			arg_15_0.uiList_:ScrollToIndex(arg_15_0.itemIndex_, true, false)
			arg_15_0.listTimer:Stop()

			arg_15_0.listTimer = nil
		end
	end, 0.1, -1, true)

	arg_15_0.listTimer:Start()
end

function var_0_0.OnExit(arg_17_0)
	manager.windowBar:HideBar()

	if arg_17_0.timer then
		arg_17_0.timer:Stop()

		arg_17_0.timer = nil
	end

	if arg_17_0.listTimer then
		arg_17_0.listTimer:Stop()

		arg_17_0.listTimer = nil
	end
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.fillterBtnList_ then
		for iter_18_0, iter_18_1 in pairs(arg_18_0.fillterBtnList_) do
			iter_18_1:Dispose()
		end
	end

	if arg_18_0.uiList_ then
		arg_18_0.uiList_:Dispose()

		arg_18_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
