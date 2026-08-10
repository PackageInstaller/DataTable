local var_0_0 = class("IlluServantManual", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluServantUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.tree_ = LuaTree.New(arg_4_0.uitreeGo_)

	arg_4_0.tree_:SetSelectedHandler(handler(arg_4_0, arg_4_0.OnGroupSelect), nil)

	local var_4_0 = UITreeData.New()

	arg_4_0:UpdateToggleData()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.toggleList_) do
		local var_4_1 = UITreeGroupData.New()

		var_4_1.id = iter_4_0
		var_4_1.text = GetI18NText(iter_4_1)

		var_4_0.groupDatas:Add(var_4_1)
	end

	arg_4_0.tree_:SetData(var_4_0)

	arg_4_0.itemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluServantManualItem)
end

function var_0_0.OnGroupSelect(arg_5_0, arg_5_1)
	arg_5_0.selectIndex_ = arg_5_1
	arg_5_0.params_.index = arg_5_0.selectIndex_

	arg_5_0:UpdateItemData(arg_5_0.selectIndex_)
	arg_5_0.itemScroll_:StartScroll(#arg_5_0.itemList_)
	arg_5_0:RefreshCollectNum(arg_5_1)
end

function var_0_0.UpdateToggleData(arg_6_0)
	local var_6_0 = GetTips("ALL")

	arg_6_0.toggleList_ = {
		var_6_0
	}
	arg_6_0.raceList_ = {}

	for iter_6_0, iter_6_1 in pairs(WeaponServantCfg.get_id_list_by_race) do
		table.insert(arg_6_0.raceList_, iter_6_0)
	end

	table.sort(arg_6_0.raceList_, function(arg_7_0, arg_7_1)
		return arg_7_0 < arg_7_1
	end)

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.raceList_) do
		table.insert(arg_6_0.toggleList_, RaceEffectCfg[iter_6_3].name)
	end
end

function var_0_0.AddItem(arg_8_0, arg_8_1)
	if not ServantTools.GetIsHide(arg_8_1) then
		local var_8_0 = ServantTools.GetServantIsUnlock(arg_8_1)

		table.insert(arg_8_0.itemList_, {
			name = ItemTools.getItemName(arg_8_1),
			id = arg_8_1,
			isUnlock = var_8_0
		})

		arg_8_0.maxNum_ = arg_8_0.maxNum_ + 1
	end
end

function var_0_0.UpdateItemData(arg_9_0, arg_9_1)
	arg_9_0.itemList_ = {}
	arg_9_0.maxNum_ = 0

	if arg_9_1 == 1 then
		for iter_9_0, iter_9_1 in ipairs(WeaponServantCfg.all) do
			arg_9_0:AddItem(iter_9_1)
		end
	else
		local var_9_0 = arg_9_0.raceList_[arg_9_1 - 1]

		for iter_9_2, iter_9_3 in ipairs(WeaponServantCfg.get_id_list_by_race[var_9_0]) do
			arg_9_0:AddItem(iter_9_3)
		end
	end

	table.sort(arg_9_0.itemList_, function(arg_10_0, arg_10_1)
		if arg_10_0.isUnlock and not arg_10_1.isUnlock then
			return true
		end

		if arg_10_1.isUnlock and not arg_10_0.isUnlock then
			return false
		end

		if ItemCfg[arg_10_0.id].rare ~= ItemCfg[arg_10_1.id].rare then
			return ItemCfg[arg_10_0.id].rare > ItemCfg[arg_10_1.id].rare
		end

		return arg_10_0.id > arg_10_1.id
	end)
end

function var_0_0.indexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(arg_11_0.itemList_[arg_11_1])
end

function var_0_0.AddUIListener(arg_12_0)
	return
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_13_0.selectIndex_ = arg_13_0.params_.index or 1
	arg_13_0.params_.index = arg_13_0.selectIndex_

	arg_13_0.tree_:SelectGroup(arg_13_0.selectIndex_)

	if arg_13_0.params_.scrollPos_ then
		arg_13_0.itemScroll_:StartScrollByPosition(#arg_13_0.itemList_, arg_13_0.params_.scrollPos_)
	end
end

function var_0_0.RefreshCollectNum(arg_14_0, arg_14_1)
	local var_14_0 = #arg_14_0.itemList_
	local var_14_1 = 0

	if arg_14_1 == 1 then
		var_14_1 = table.length(IllustratedData:GetServantInfo())
	else
		local var_14_2 = arg_14_0.raceList_[arg_14_1 - 1]

		for iter_14_0, iter_14_1 in ipairs(WeaponServantCfg.get_id_list_by_race[var_14_2]) do
			if IllustratedData:GetServantInfo()[iter_14_1] then
				var_14_1 = var_14_1 + 1
			end
		end
	end

	arg_14_0.collectnumText_.text = var_14_1 .. "/" .. arg_14_0.maxNum_
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()

	arg_15_0.params_.scrollPos_ = arg_15_0.itemScroll_:GetScrolledPosition()
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.itemScroll_:Dispose()
	arg_16_0.tree_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
