local var_0_0 = class("IlluWorldView", ReduxView)
local var_0_1 = {
	71500,
	71501,
	71502,
	71503,
	71504,
	71505,
	71506
}
local var_0_2 = false

function var_0_0.UIName(arg_1_0)
	return "Widget/System/IllustratedHandbook/IlluWorldViewUI"
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

	arg_4_0.itemScroll_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uilistGo_, IlluWorldIViewItem)
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

	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.gameObject_.transform, "conName")
end

function var_0_0.OnGroupSelect(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0.selectToggle_ == arg_5_1 then
		return
	end

	arg_5_0.selectToggle_ = arg_5_1

	arg_5_0:UpdateItemData(arg_5_0.selectToggle_, 1)

	if arg_5_0.itemList_[1] then
		arg_5_0.itemList_[1].isFirst = var_0_2
	end

	arg_5_0.itemScroll_:StartScroll(#arg_5_0.itemList_)
	arg_5_0:SetSelectItem(1)
end

function var_0_0.SetSelectItem(arg_6_0, arg_6_1)
	if arg_6_0.itemList_[arg_6_0.selectItem_] then
		arg_6_0.itemList_[arg_6_0.selectItem_].select = false
	end

	arg_6_0.selectItem_ = arg_6_1

	if arg_6_0.itemList_[arg_6_0.selectItem_] then
		arg_6_0.itemList_[arg_6_0.selectItem_].select = true
	end

	local var_6_0 = arg_6_0.itemScroll_:GetItemList()

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		iter_6_1:ShowSelect(arg_6_1 == iter_6_0)
	end

	arg_6_0:RefreshInfo(arg_6_0.itemList_[arg_6_0.selectItem_])
end

function var_0_0.UpdateToggleData(arg_7_0)
	arg_7_0.toggleList_ = {}

	table.insert(arg_7_0.toggleList_, TipsCfg[var_0_1[1]].desc)

	for iter_7_0, iter_7_1 in ipairs(CollectWordCfg.get_id_list_by_type) do
		table.insert(arg_7_0.toggleList_, TipsCfg[var_0_1[iter_7_0 + 1]].desc)
	end
end

function var_0_0.UpdateItemData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.itemList_ = {}

	local var_8_0 = IllustratedData:GetAffixInfo()
	local var_8_1 = 1

	if arg_8_1 == 1 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			table.insert(arg_8_0.itemList_, {
				id = iter_8_0,
				isRead = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, iter_8_0)
			})

			var_8_1 = var_8_1 + 1
		end
	else
		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			if CollectWordCfg[iter_8_2].type == arg_8_1 - 1 then
				table.insert(arg_8_0.itemList_, {
					id = iter_8_2,
					isRead = IllustratedData:GetInfoIsView(CollectConst.WORLDVIEW, iter_8_2)
				})

				var_8_1 = var_8_1 + 1
			end
		end
	end

	table.sort(arg_8_0.itemList_, function(arg_9_0, arg_9_1)
		if arg_9_0.isRead ~= arg_9_1.isRead then
			return arg_9_0.isRead < arg_9_1.isRead
		end

		return arg_9_0.id < arg_9_1.id
	end)

	for iter_8_4 = 1, #arg_8_0.itemList_ do
		arg_8_0.itemList_[iter_8_4].select = iter_8_4 == arg_8_2
	end
end

function var_0_0.indexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:RegisterBtnListener(handler(arg_10_0, arg_10_0.SetSelectItem))
	arg_10_2:RefreshUI(arg_10_1, arg_10_0.itemList_[arg_10_1])
end

function var_0_0.AddUIListener(arg_11_0)
	return
end

function var_0_0.RefreshInfo(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0.controller_:SetSelectedState("1")

		arg_12_0.describetextText_.text = GetI18NText(CollectWordCfg[arg_12_1.id].desc)
		arg_12_0.nameText_.text = GetI18NText(CollectWordCfg[arg_12_1.id].name)
	else
		arg_12_0.controller_:SetSelectedState("0")
	end
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	arg_13_0.selectToggle_ = 0
	arg_13_0.selectItem_ = 1
	var_0_2 = true

	arg_13_0.tree_:SelectGroup(1)

	var_0_2 = false
end

function var_0_0.OnExit(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.itemScroll_:Dispose()
	arg_15_0.tree_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
