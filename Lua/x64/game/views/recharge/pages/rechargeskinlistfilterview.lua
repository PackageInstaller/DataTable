local var_0_0 = class("RechargeSkinListFilterView", ReduxView)
local var_0_1 = {
	STATE = 2,
	HERO = 1
}

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Recharge/RechargeFliterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.heroUIList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.heroListGo_, HeroLongHead)
	arg_4_0.filterBottomList_ = {}
	arg_4_0.tabController_ = arg_4_0.tabControllerEx_:GetController("tab")
	arg_4_0.selectController_ = arg_4_0.mainConttollerEx_:GetController("type")
	arg_4_0.heroController_ = arg_4_0.mainConttollerEx_:GetController("select")
	arg_4_0.typeController_ = {}
	arg_4_0.buyController_ = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.typeController_[iter_4_0] = arg_4_0["typeControllerEx_" .. iter_4_0]:GetController("select")
		arg_4_0.buyController_[iter_4_0] = arg_4_0["buyControllerEx_" .. iter_4_0]:GetController("select")
	end

	arg_4_0.heroIDList_ = {}
	arg_4_0.selectList_ = {}
	arg_4_0.selectType_ = ShopConst.FILTER_HERO_TYPE.ALL
	arg_4_0.selectBuy_ = ShopConst.FILTER_STATE_TYPE.ALL
	arg_4_0.selectPanelType_ = var_0_1.HERO
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.filterParams_ = clone(arg_5_0.params_.filterParams)

	arg_5_0:InitHeroDataList()
	arg_5_0:InitSelectList()
	arg_5_0.heroUIList_:StartScroll(#arg_5_0.heroIDList_)
	arg_5_0:RefreshFilterBottom()
	arg_5_0:RefreshPanel()
end

function var_0_0.RefreshFilterBottom(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.selectList_) do
		local var_6_0 = arg_6_0.filterBottomList_[iter_6_0]

		if var_6_0 == nil then
			local var_6_1 = Object.Instantiate(arg_6_0.filterBottomItemGo_, arg_6_0.filterBottomContent_)

			var_6_0 = CommonFilterBottomItem.New(var_6_1)
			arg_6_0.filterBottomList_[iter_6_0] = var_6_0
		end

		var_6_0:Refresh({
			name = HeroTools.GetHeroFullName(iter_6_1)
		})
	end

	for iter_6_2 = #arg_6_0.selectList_ + 1, #arg_6_0.filterBottomList_ do
		SetActive(arg_6_0.filterBottomList_[iter_6_2].gameObject_, false)
	end
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.heroUIList_:Dispose()

	arg_8_0.heroUIList_ = nil

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.filterBottomList_) do
		iter_8_1:Dispose()
	end

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btnConfirm_, nil, function()
		manager.notify:Invoke(RECHARGE_SKIN_LIST_FILTER_APPLY, {
			heroIDList = arg_9_0.selectList_,
			goodType = arg_9_0.selectType_,
			stateType = arg_9_0.selectBuy_
		})
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.heroBtn_, nil, function()
		arg_9_0:SwitchPanel(var_0_1.HERO)
	end)
	arg_9_0:AddBtnListener(arg_9_0.stateBtn_, nil, function()
		arg_9_0:SwitchPanel(var_0_1.STATE)
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnMask_, nil, function()
		arg_9_0:Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.buttomBtn_, nil, function()
		arg_9_0:ClearSelect()
	end)

	for iter_9_0 = 1, 3 do
		arg_9_0:AddBtnListener(arg_9_0["typeBtn_" .. iter_9_0], nil, function()
			if arg_9_0.selectType_ == iter_9_0 then
				return
			end

			arg_9_0.selectType_ = iter_9_0

			arg_9_0:RefreshPanel()
		end)
	end

	for iter_9_1 = 1, 3 do
		arg_9_0:AddBtnListener(arg_9_0["buyBtn_" .. iter_9_1], nil, function()
			if arg_9_0.selectBuy_ == iter_9_1 then
				return
			end

			arg_9_0.selectBuy_ = iter_9_1

			arg_9_0:RefreshPanel()
		end)
	end
end

function var_0_0.SwitchPanel(arg_17_0, arg_17_1)
	if arg_17_0.selectPanelType_ ~= arg_17_1 then
		arg_17_0.selectPanelType_ = arg_17_1

		arg_17_0:RefreshPanel()
	end
end

function var_0_0.RefreshPanel(arg_18_0)
	if arg_18_0.selectPanelType_ == var_0_1.HERO then
		arg_18_0.selectController_:SetSelectedIndex(0)
		arg_18_0.tabController_:SetSelectedIndex(0)
	else
		arg_18_0.selectController_:SetSelectedIndex(1)
		arg_18_0.tabController_:SetSelectedIndex(1)
	end

	arg_18_0.heroUIList_:StartScroll(#arg_18_0.heroIDList_)

	for iter_18_0 = 1, 3 do
		arg_18_0.typeController_[iter_18_0]:SetSelectedIndex(arg_18_0.selectType_ == iter_18_0 and 1 or 0)
		arg_18_0.buyController_[iter_18_0]:SetSelectedIndex(arg_18_0.selectBuy_ == iter_18_0 and 1 or 0)
	end
end

function var_0_0.InitHeroDataList(arg_19_0)
	arg_19_0.heroIDList_ = HeroCfg.get_id_list_by_private[0]

	table.sort(arg_19_0.heroIDList_, function(arg_20_0, arg_20_1)
		local var_20_0 = HeroData:GetHeroData(arg_20_0)
		local var_20_1 = HeroData:GetHeroData(arg_20_1)
		local var_20_2 = getBattlePower(var_20_0)
		local var_20_3 = getBattlePower(var_20_1)

		if var_20_0.unlock ~= var_20_1.unlock then
			return var_20_0.unlock > var_20_1.unlock
		end

		local var_20_4 = HeroData:IsFavorite(arg_20_0)
		local var_20_5 = HeroData:IsFavorite(arg_20_1)

		if var_20_4 ~= var_20_5 and (not var_20_4 or not var_20_5) then
			return var_20_4 ~= false
		end

		if var_20_2 ~= var_20_3 then
			return var_20_3 < var_20_2
		end

		return arg_20_1 < arg_20_0
	end)
end

function var_0_0.IndexHeroItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.heroIDList_[arg_21_1]

	arg_21_2.gameObject_.name = tostring(var_21_0)

	arg_21_2:SetProxy(arg_21_0.heroViewProxy_)
	arg_21_2:SetHeroId(var_21_0, HeroConst.HERO_DATA_TYPE.DEFAULT)

	arg_21_2.nameText_.text = GetI18NText(HeroCfg[var_21_0].name)

	local var_21_1 = false

	if table.keyof(arg_21_0.selectList_, var_21_0) ~= nil then
		var_21_1 = true
	end

	arg_21_2:SetSelected(var_21_1)
	arg_21_2:RegisterClickListener(function()
		local var_22_0 = true

		if table.keyof(arg_21_0.selectList_, var_21_0) ~= nil then
			var_22_0 = false
		end

		arg_21_2:SetSelected(var_22_0)

		if var_22_0 then
			table.insert(arg_21_0.selectList_, var_21_0)
		else
			table.removebyvalue(arg_21_0.selectList_, var_21_0)
		end

		arg_21_0:RefreshSelectHeroList()
	end)
	arg_21_2:SetUnlockDisplay(false)
	arg_21_2:SetFavor(false)
end

function var_0_0.RefreshSelectHeroList(arg_23_0)
	arg_23_0.heroUIList_:Refresh()

	if #arg_23_0.selectList_ <= 0 then
		arg_23_0.heroController_:SetSelectedState("off")
	else
		arg_23_0.heroController_:SetSelectedState("on")
		arg_23_0:RefreshFilterBottom()
	end
end

function var_0_0.ClearSelect(arg_24_0)
	arg_24_0.selectList_ = {}

	arg_24_0:RefreshSelectHeroList()
end

function var_0_0.InitSelectList(arg_25_0)
	arg_25_0.selectList_ = arg_25_0.filterParams_.heroIDList
	arg_25_0.selectType_ = arg_25_0.filterParams_.goodType
	arg_25_0.selectBuy_ = arg_25_0.filterParams_.stateType

	arg_25_0:RefreshSelectHeroList()
end

return var_0_0
