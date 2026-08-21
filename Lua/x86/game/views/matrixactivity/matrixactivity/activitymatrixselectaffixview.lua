local var_0_0 = class("ActivityMatrixSelectAffixView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityMatrixSelectAffixUI"
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

	arg_4_0.affixRegularList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexAffixWeekItem), arg_4_0.m_weekList, MatrixAffixLongItem)
	arg_4_0.affixGroupList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexGroupItem), arg_4_0.m_list, MatrixAffixGroupItem)
	arg_4_0.affixHeroGroupList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexGroupHeroIitem), arg_4_0.m_heroList, MatrixAffixGroupItem)
	arg_4_0.lockController = ControllerUtil.GetController(arg_4_0.transform_, "lock")
	arg_4_0.customData = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_okBtn, nil, function()
		local var_6_0 = arg_5_0.params_.select_hero_list

		ActivityMatrixAction.QueryStartMatrix(var_6_0, arg_5_0.matrix_activity_id, arg_5_0.customData)
	end)
end

function var_0_0.Reset(arg_7_0)
	arg_7_0.customData = {}

	arg_7_0:ClearItems()
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.customData = {}

	arg_9_0:Reset()

	arg_9_0.matrix_activity_id = arg_9_0.params_.matrix_activity_id

	local var_9_0 = ActivityMatrixCfg[arg_9_0.matrix_activity_id]

	arg_9_0.regularData = {}

	local var_9_1 = {}
	local var_9_2 = {}
	local var_9_3 = var_9_0.custom_affix

	for iter_9_0, iter_9_1 in ipairs(var_9_3) do
		local var_9_4 = ActivityAffixPoolCfg[iter_9_1].affix
		local var_9_5 = var_9_4[1]

		if var_9_4[3] == 3 then
			if not var_9_2[var_9_5] then
				var_9_2[var_9_5] = {}
			end

			table.insert(var_9_2[var_9_5], iter_9_1)
		else
			if not var_9_1[var_9_5] then
				var_9_1[var_9_5] = {}
			end

			table.insert(var_9_1[var_9_5], iter_9_1)
		end
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0.regularData) do
		local var_9_6 = ActivityAffixPoolCfg[iter_9_3].affix
		local var_9_7 = var_9_6[1]

		if var_9_6[3] == 3 then
			if not var_9_2[var_9_7] then
				var_9_2[var_9_7] = {}
			end

			table.insert(var_9_2[var_9_7], iter_9_3)
		else
			if not var_9_1[var_9_7] then
				var_9_1[var_9_7] = {}
			end

			table.insert(var_9_1[var_9_7], iter_9_3)
		end
	end

	arg_9_0.chooseData = {}
	arg_9_0.chooseData_hero = {}

	for iter_9_4, iter_9_5 in pairs(var_9_1) do
		table.sort(iter_9_5, function(arg_10_0, arg_10_1)
			return arg_10_1 < arg_10_0
		end)
		table.insert(arg_9_0.chooseData, {
			id = iter_9_4,
			list = iter_9_5
		})
	end

	for iter_9_6, iter_9_7 in pairs(var_9_2) do
		table.sort(iter_9_7, function(arg_11_0, arg_11_1)
			return arg_11_1 < arg_11_0
		end)
		table.insert(arg_9_0.chooseData_hero, {
			id = iter_9_6,
			list = iter_9_7
		})
	end

	arg_9_0:Refresh(true)
	arg_9_0.lockController:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Refresh(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.affixRegularList_:StartScroll(#arg_13_0.regularData)
		arg_13_0.affixGroupList_:StartScroll(#arg_13_0.chooseData)
		arg_13_0.affixHeroGroupList_:StartScroll(#arg_13_0.chooseData_hero)
	else
		arg_13_0.affixRegularList_:StartScrollByPosition(#arg_13_0.regularData, arg_13_0.affixRegularList_:GetScrolledPosition())
		arg_13_0.affixGroupList_:Refresh()
		arg_13_0.affixHeroGroupList_:Refresh()
	end

	local var_13_0 = 0
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.regularData) do
		local var_13_2 = ActivityAffixPoolCfg[iter_13_1]

		var_13_0 = var_13_0 + var_13_2.point
		var_13_1 = var_13_1 + var_13_2.multiple
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.customData) do
		local var_13_3 = ActivityAffixPoolCfg[iter_13_3]

		var_13_0 = var_13_0 + var_13_3.point
		var_13_1 = var_13_1 + var_13_3.multiple
	end

	local var_13_4 = var_13_1 / 10

	arg_13_0.m_scoreLab.text = "" .. var_13_0
	arg_13_0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_13_4 .. "%")

	if not arg_13_1 then
		arg_13_0:RefreshItems()
	end
end

function var_0_0.IndexAffixWeekItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.regularData[arg_14_1]
	local var_14_1 = ActivityAffixPoolCfg[var_14_0].affix

	arg_14_2:Refresh(var_14_1, 2)
end

function var_0_0.IndexAffixOptionalItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.customData[arg_15_1]
	local var_15_1 = ActivityAffixPoolCfg[var_15_0].affix

	arg_15_2:Refresh(var_15_1, 2)
end

function var_0_0.IndexGroupItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.chooseData[arg_16_1]

	arg_16_2:Refresh(var_16_0, arg_16_0.regularData, arg_16_0.customData)
	arg_16_2:RegistCallBack(handler(arg_16_0, arg_16_0.OnChooseCallBack))
end

function var_0_0.IndexGroupHeroIitem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.chooseData_hero[arg_17_1]

	arg_17_2:Refresh(var_17_0, arg_17_0.regularData, arg_17_0.customData)
	arg_17_2:RegistCallBack(handler(arg_17_0, arg_17_0.OnChooseCallBack))
end

function var_0_0.OnChooseCallBack(arg_18_0, arg_18_1)
	local var_18_0 = ActivityAffixPoolCfg[arg_18_1].affix[1]

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.regularData) do
		if var_18_0 == ActivityAffixPoolCfg[iter_18_1].affix[1] then
			return
		end
	end

	local var_18_1 = false

	for iter_18_2, iter_18_3 in ipairs(arg_18_0.customData) do
		if iter_18_3 == arg_18_1 then
			table.remove(arg_18_0.customData, iter_18_2)

			var_18_1 = true

			break
		end

		if var_18_0 == ActivityAffixPoolCfg[iter_18_3].affix[1] then
			arg_18_0.customData[iter_18_2] = arg_18_1
			var_18_1 = true

			break
		end
	end

	if not var_18_1 then
		table.insert(arg_18_0.customData, 1, arg_18_1)
	end

	arg_18_0:Refresh()
end

function var_0_0.StartScroll(arg_19_0)
	return
end

function var_0_0.StartScrollByPosition(arg_20_0)
	return
end

function var_0_0.RefreshItems(arg_21_0)
	local var_21_0 = arg_21_0.m_content.childCount

	print(var_21_0)

	for iter_21_0 = 0, var_21_0 - 1 do
		arg_21_0.m_content:GetChild(iter_21_0).gameObject:SetActive(false)
	end

	local var_21_1 = #arg_21_0.customData

	print(var_21_0)

	local var_21_2

	if var_21_0 < var_21_1 then
		for iter_21_1 = 1, var_21_1 - var_21_0 do
			Object.Instantiate(arg_21_0.m_item.gameObject, arg_21_0.m_content.transform):SetActive(true)
		end
	end

	local var_21_3 = 0
	local var_21_4

	for iter_21_2, iter_21_3 in pairs(arg_21_0.customData) do
		local var_21_5 = arg_21_0.m_content:GetChild(var_21_3).gameObject

		var_21_3 = var_21_3 + 1

		var_21_5:SetActive(true)

		local var_21_6 = MatrixAffixLongItem.New(var_21_5)
		local var_21_7 = ActivityAffixPoolCfg[iter_21_3].affix

		var_21_6:Refresh(var_21_7, 2)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.m_content:GetComponent("RectTransform"))

	for iter_21_4 = 0, var_21_0 - 1 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_0.m_content:GetChild(iter_21_4))
	end
end

function var_0_0.ClearItems(arg_22_0)
	local var_22_0 = arg_22_0.m_content.childCount

	print(var_22_0)

	for iter_22_0 = 0, var_22_0 - 1 do
		arg_22_0.m_content:GetChild(iter_22_0).gameObject:SetActive(false)
	end
end

function var_0_0.Dispose(arg_23_0)
	arg_23_0.affixRegularList_:Dispose()
	arg_23_0.affixGroupList_:Dispose()
	arg_23_0.affixHeroGroupList_:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
