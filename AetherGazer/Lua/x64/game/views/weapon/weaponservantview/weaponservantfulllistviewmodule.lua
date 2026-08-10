local var_0_0 = class("WeaponServantFullListViewModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.InitDropDown(arg_2_0)
	arg_2_0.dropDown_ = arg_2_0.dropDonwObj_:GetComponent("UIDropDown")

	arg_2_0.dropDown_.options:Clear()
	arg_2_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_UPGRADE"), nil))
	arg_2_0.dropDown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(GetTips("TIP_RARE"), nil))
	arg_2_0.dropDown_:RefreshShownValue()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.controller = {
		state = {
			switchState = {
				Down = "down",
				name = "switchState",
				Up = "up",
				comps = arg_3_0.rootController_:GetController("switchState")
			}
		}
	}
	arg_3_0.filterController_ = arg_3_0.filterColorController_:GetController("color")
	arg_3_0.staticVar = {
		scrollHelper = LuaList.New(handler(arg_3_0, arg_3_0.OnRenderItem), arg_3_0.selectviewGo_, WeaponServantHeadItem),
		sortLangMap = {
			GetTips("SERVANT_DETAIL_STAR_LEVEL"),
			(GetTips("SERVANT_DETAIL_TRAIN"))
		}
	}

	arg_3_0:InitContext()
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitDropDown()
	arg_4_0:BuildContext()
	arg_4_0:AddUIListener()
end

function var_0_0.InitContext(arg_5_0)
	local var_5_0 = WeaponServantData:GetSortConfig()

	arg_5_0.context = {
		itemCount = 0,
		curSelectIndex = 0,
		curSelectServantUID = 0,
		itemList = {},
		itemEntity = {},
		itemMap = {},
		servantMap = ServantTools.GetServantMap(),
		curSortBaseIdx = var_5_0[1],
		sortDescOrder = var_5_0[2] == 0
	}
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.openSortBtn_, nil, function()
		arg_6_0:OnOpenSortClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.switchBtn_, nil, function()
		arg_6_0:OnBtnSwitchClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.decomposeBtn_, nil, function()
		arg_6_0:OnDecomposeBtnClick()
	end)
	arg_6_0:AddToggleListener(arg_6_0.dropDown_, function(arg_10_0)
		arg_6_0:OnDropDonwTabClick(arg_10_0 + 1)
	end)
end

function var_0_0.AddEventListener(arg_11_0)
	arg_11_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_11_0, arg_11_0.OnFilterChange))
	arg_11_0:RegistEventListener(SERVANT_REPLACE, handler(arg_11_0, arg_11_0.OnServantReplaced))
	arg_11_0:RegistEventListener(SERVANT_LOCK, handler(arg_11_0, arg_11_0.OnServantLock))
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:AddEventListener()
	arg_12_0:RenderHoldCount()
	arg_12_0:RenderFlterBtn()
end

function var_0_0.OnExit(arg_13_0)
	CommonFilterData:ClearFilter(Filter_Root_Define.Servant_Filter_List.filter_id)
	manager.windowBar:HideBar()
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0:RemoveAllListeners()
	arg_14_0:RemoveAllEventListener()
	arg_14_0.staticVar.scrollHelper:Dispose()

	arg_14_0.filterController_ = nil
	arg_14_0.controller = nil

	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.RefreshList(arg_15_0, arg_15_1)
	local var_15_0 = ServantTools.GetWeaponShowData()
	local var_15_1 = ServantTools:GetServantList(arg_15_1.heroId, var_15_0, true, nil, nil, Filter_Root_Define.Servant_Filter_List.filter_id)
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if iter_15_1.uid and iter_15_1.uid ~= 0 then
			var_15_2[iter_15_1.uid] = iter_15_0
		end
	end

	arg_15_0:InitContext()

	arg_15_0.context.heroId = arg_15_1.heroId

	local var_15_3 = #var_15_1

	arg_15_0.context.itemList = var_15_1
	arg_15_0.context.itemCount = var_15_3
	arg_15_0.context.itemMap = var_15_2

	local var_15_4 = arg_15_0:GetSelectIndex(arg_15_1)

	arg_15_0.staticVar.scrollHelper:StartScroll(var_15_3, var_15_4)
	arg_15_0:SelectIndexItem(var_15_4)
	arg_15_0:SelectServant(var_15_1[var_15_4])
end

function var_0_0.OnRenderItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.context.itemList[arg_16_1]

	arg_16_0.context.itemEntity[arg_16_1] = arg_16_2

	arg_16_2:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_16_0.uid,
		id = var_16_0.id,
		number = var_16_0.stage,
		index = arg_16_1
	})
	arg_16_2:ShowSelect(arg_16_1 == arg_16_0.context.curSelectIndex)
	arg_16_2:ShowLock(var_16_0.locked == 1)
	arg_16_2:RegistCallBack(function(arg_17_0)
		arg_16_0:OnItemClick(arg_17_0)
	end)
	arg_16_2:ShowMask(var_16_0.isRecommend or false)

	local var_16_1 = false

	if arg_16_0.context.heroId and arg_16_0.context.heroId > 0 then
		local var_16_2 = WeaponServantCfg[var_16_0.id].effect[1]
		local var_16_3 = 0

		if var_16_2 > 0 then
			var_16_3 = WeaponEffectCfg[var_16_2].spec_char[1]
		end

		if var_16_3 and var_16_3 > 0 and var_16_3 == arg_16_0.context.heroId then
			arg_16_2:ShowRecommendTag(true)

			var_16_1 = true
		end
	end

	if not var_16_1 then
		arg_16_2:ShowRecommendTag(false)
	end

	if var_16_0.uid and var_16_0.uid ~= 0 then
		local var_16_4 = arg_16_0.context.servantMap[var_16_0.uid]

		if var_16_4 then
			arg_16_2:RenderEquipStatus(true, var_16_4)
		else
			arg_16_2:RenderEquipStatus(false)
		end
	else
		arg_16_2:RenderEquipStatus(false)
	end
end

function var_0_0.RenderHoldCount(arg_18_0)
	local var_18_0 = ServantTools.GetServantShowCount()
	local var_18_1 = GameSetting.max_weapon_servant.value[1]

	arg_18_0.haveTxt_.text = table.concat({
		GetTips("ALREADY_GET"),
		": ",
		var_18_0,
		"/",
		var_18_1
	})
end

function var_0_0.RenderFlterBtn(arg_19_0)
	if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Servant_Filter_List.filter_id) then
		arg_19_0.filterController_:SetSelectedState("orange")
	else
		arg_19_0.filterController_:SetSelectedState("normal")
	end
end

function var_0_0.SelectIndexItem(arg_20_0, arg_20_1)
	arg_20_0:HideIndexItem(arg_20_0.context.curSelectIndex)
	arg_20_0:ShowIndexItem(arg_20_1)

	arg_20_0.context.curSelectIndex = arg_20_1

	if arg_20_0.context.itemList[arg_20_1] then
		arg_20_0.context.curSelectServantUID = arg_20_0.context.itemList[arg_20_1].uid
	else
		arg_20_0.context.curSelectServantUID = 0
	end
end

function var_0_0.HideIndexItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.context.itemEntity[arg_21_1]

	if var_21_0 and var_21_0:GetIndex() == arg_21_1 then
		var_21_0:ShowSelect(false)
	end
end

function var_0_0.ShowIndexItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.context.itemEntity[arg_22_1]

	if var_22_0 and var_22_0:GetIndex() == arg_22_1 then
		var_22_0:ShowSelect(true)
	end
end

function var_0_0.GetSelectIndex(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.jumpUid

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.context.itemList) do
			if iter_23_1.uid == var_23_0 then
				return iter_23_0
			end
		end
	end

	return 1
end

function var_0_0.RegisterClickCallback(arg_24_0, arg_24_1)
	arg_24_0.staticVar.clickCallback = arg_24_1
end

function var_0_0.SelectServant(arg_25_0, arg_25_1)
	if arg_25_0.staticVar.clickCallback then
		arg_25_0.staticVar.clickCallback(arg_25_1)
	end
end

function var_0_0.OnItemClick(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:GetIndex()
	local var_26_1 = arg_26_0.context.itemList[var_26_0]

	arg_26_0:SelectServant(var_26_1)
	arg_26_0:SelectIndexItem(var_26_0)
end

function var_0_0.OnDropDonwTabClick(arg_27_0, arg_27_1)
	arg_27_0.context.curSortBaseIdx = arg_27_1 - 1

	arg_27_0:OnSortParamChange()
end

function var_0_0.OnServantReplaced(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0.context.servantMap = ServantTools.GetServantMap()

	arg_28_0:OnServantChanged(arg_28_3)
	arg_28_0:OnServantChanged(arg_28_2.servant_id)
end

function var_0_0.OnServantLock(arg_29_0, arg_29_1)
	arg_29_0:OnServantChanged(arg_29_1)
end

function var_0_0.OnServantChanged(arg_30_0, arg_30_1)
	if not arg_30_1 or arg_30_1 == 0 then
		return
	end

	local var_30_0 = deepClone(WeaponServantData:GetServantDataByUID(arg_30_1))
	local var_30_1 = arg_30_0.context.itemMap[arg_30_1]

	if not var_30_1 then
		return
	end

	local var_30_2 = arg_30_0.context.itemList[var_30_1]

	if not var_30_2 or var_30_2.uid ~= var_30_0.uid then
		return
	end

	arg_30_0.context.itemList[var_30_1] = var_30_0

	if arg_30_0.context.curSelectIndex == var_30_1 then
		arg_30_0:SelectServant(var_30_0)
	end

	local var_30_3 = arg_30_0.context.itemEntity[var_30_1]

	if not var_30_3 or var_30_3:GetIndex() ~= var_30_1 then
		return
	end

	var_30_3:OnRender({
		isAdd = false,
		isEquip = true,
		uid = var_30_0.uid,
		id = var_30_0.id,
		number = var_30_0.stage,
		index = var_30_1
	})
	var_30_3:ShowLock(var_30_0.locked == 1)

	local var_30_4 = arg_30_0.context.servantMap[arg_30_1]

	if var_30_4 then
		var_30_3:RenderEquipStatus(true, var_30_4)
	else
		var_30_3:RenderEquipStatus(false)
	end
end

function var_0_0.RestoreListPostion(arg_31_0)
	return
end

function var_0_0.OnOpenSortClick(arg_32_0)
	JumpTools.OpenPageByJump("commonFilterView", {
		filterGroup = Filter_Root_Define.Servant_Filter_List
	})
end

function var_0_0.OnBtnSwitchClick(arg_33_0)
	local var_33_0 = arg_33_0.controller.state.switchState

	arg_33_0.context.sortDescOrder = not arg_33_0.context.sortDescOrder

	local var_33_1 = var_33_0.Down

	if not arg_33_0.context.sortDescOrder then
		var_33_1 = var_33_0.Up
	end

	var_33_0.comps:SetSelectedState(var_33_1)
	arg_33_0:OnSortParamChange()
end

function var_0_0.OnDecomposeBtnClick(arg_34_0)
	arg_34_0:Go("/weaponServantDecomposeView")
end

function var_0_0.OnFilterChange(arg_35_0)
	arg_35_0:RefreshList({
		heroId = arg_35_0.context.heroId
	})
	arg_35_0:RenderFlterBtn()
end

function var_0_0.OnSortParamChange(arg_36_0)
	local var_36_0 = 0

	if not arg_36_0.context.sortDescOrder then
		var_36_0 = 1
	end

	WeaponServantData:SetSortConfig(arg_36_0.context.curSortBaseIdx, var_36_0)
	arg_36_0:RefreshList({
		heroId = arg_36_0.context.heroId
	})
end

return var_0_0
