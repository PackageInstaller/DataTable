local var_0_0 = class("MatrixSelectAffixView", ReduxView)
local var_0_1 = {}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.affixRegularList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexAffixWeekItem), arg_2_0.m_weekList, MatrixAffixLongItem)
	arg_2_0.affixGroupList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexGroupItem), arg_2_0.m_list, MatrixAffixGroupItem)
	arg_2_0.affixHeroGroupList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexGroupHeroIitem), arg_2_0.m_heroList, MatrixAffixGroupItem)
	arg_2_0.lockController = ControllerUtil.GetController(arg_2_0.transform_, "lock")
	arg_2_0.customData = {}
end

function var_0_0.Reset(arg_3_0)
	arg_3_0.customData = {}

	arg_3_0:ClearItems()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	local var_4_0 = MatrixData:GetReadyDifficultyData(arg_4_1)

	arg_4_0.regularData = var_4_0:GetRegularAffix()

	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = var_4_0:GetAllCustomAffix()

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		local var_4_4 = ActivityAffixPoolCfg[iter_4_1].affix
		local var_4_5 = var_4_4[1]

		if var_4_4[3] == 3 then
			if not var_4_2[var_4_5] then
				var_4_2[var_4_5] = {}
			end

			table.insert(var_4_2[var_4_5], iter_4_1)
		else
			if not var_4_1[var_4_5] then
				var_4_1[var_4_5] = {}
			end

			table.insert(var_4_1[var_4_5], iter_4_1)
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.regularData) do
		local var_4_6 = ActivityAffixPoolCfg[iter_4_3].affix
		local var_4_7 = var_4_6[1]

		if var_4_6[3] == 3 then
			if not var_4_2[var_4_7] then
				var_4_2[var_4_7] = {}
			end

			table.insert(var_4_2[var_4_7], iter_4_3)
		else
			if not var_4_1[var_4_7] then
				var_4_1[var_4_7] = {}
			end

			table.insert(var_4_1[var_4_7], iter_4_3)
		end
	end

	arg_4_0.chooseData = {}
	arg_4_0.chooseData_hero = {}

	for iter_4_4, iter_4_5 in pairs(var_4_1) do
		table.sort(iter_4_5, function(arg_5_0, arg_5_1)
			return arg_5_1 < arg_5_0
		end)
		table.insert(arg_4_0.chooseData, {
			id = iter_4_4,
			list = iter_4_5
		})
	end

	for iter_4_6, iter_4_7 in pairs(var_4_2) do
		table.sort(iter_4_7, function(arg_6_0, arg_6_1)
			return arg_6_1 < arg_6_0
		end)
		table.insert(arg_4_0.chooseData_hero, {
			id = iter_4_6,
			list = iter_4_7
		})
	end

	arg_4_0:Refresh(true)

	if not IsConditionAchieved(MatrixConst.MATRIX_UNLOCK_CUSTOM_AFFIX_CONDITION) then
		arg_4_0.lockController:SetSelectedIndex(1)
	else
		arg_4_0.lockController:SetSelectedIndex(0)
	end
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.affixRegularList_:StartScroll(#arg_7_0.regularData)
		arg_7_0.affixGroupList_:StartScroll(#arg_7_0.chooseData)
		arg_7_0.affixHeroGroupList_:StartScroll(#arg_7_0.chooseData_hero)
	else
		arg_7_0.affixRegularList_:StartScrollByPosition(#arg_7_0.regularData, arg_7_0.affixRegularList_:GetScrolledPosition())
		arg_7_0.affixGroupList_:Refresh()
		arg_7_0.affixHeroGroupList_:Refresh()
	end

	local var_7_0 = 0
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.regularData) do
		local var_7_2 = ActivityAffixPoolCfg[iter_7_1]

		var_7_0 = var_7_0 + var_7_2.point
		var_7_1 = var_7_1 + var_7_2.multiple
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.customData) do
		local var_7_3 = ActivityAffixPoolCfg[iter_7_3]

		var_7_0 = var_7_0 + var_7_3.point
		var_7_1 = var_7_1 + var_7_3.multiple
	end

	local var_7_4 = var_7_1 / 10

	arg_7_0.m_scoreLab.text = "" .. var_7_0
	arg_7_0.m_retaLab.text = string.format(GetTips("MATRIX_AFFIX_RATE"), var_7_4 .. "%")

	if not arg_7_1 then
		arg_7_0:RefreshItems()
	end
end

function var_0_0.IndexAffixWeekItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.regularData[arg_8_1]
	local var_8_1 = ActivityAffixPoolCfg[var_8_0].affix

	arg_8_2:Refresh(var_8_1, 2)
end

function var_0_0.IndexAffixOptionalItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.customData[arg_9_1]
	local var_9_1 = ActivityAffixPoolCfg[var_9_0].affix

	arg_9_2:Refresh(var_9_1, 2)
end

function var_0_0.IndexGroupItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.chooseData[arg_10_1]

	arg_10_2:Refresh(var_10_0, arg_10_0.regularData, arg_10_0.customData)
	arg_10_2:RegistCallBack(handler(arg_10_0, arg_10_0.OnChooseCallBack))
end

function var_0_0.IndexGroupHeroIitem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.chooseData_hero[arg_11_1]

	arg_11_2:Refresh(var_11_0, arg_11_0.regularData, arg_11_0.customData)
	arg_11_2:RegistCallBack(handler(arg_11_0, arg_11_0.OnChooseCallBack))
end

function var_0_0.OnChooseCallBack(arg_12_0, arg_12_1)
	local var_12_0 = ActivityAffixPoolCfg[arg_12_1].affix[1]

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.regularData) do
		if var_12_0 == ActivityAffixPoolCfg[iter_12_1].affix[1] then
			return
		end
	end

	local var_12_1 = false

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.customData) do
		if iter_12_3 == arg_12_1 then
			table.remove(arg_12_0.customData, iter_12_2)

			var_12_1 = true

			break
		end

		if var_12_0 == ActivityAffixPoolCfg[iter_12_3].affix[1] then
			arg_12_0.customData[iter_12_2] = arg_12_1
			var_12_1 = true

			break
		end
	end

	if not var_12_1 then
		table.insert(arg_12_0.customData, 1, arg_12_1)
	end

	arg_12_0:Refresh()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.affixRegularList_:Dispose()
	arg_13_0.affixGroupList_:Dispose()
	arg_13_0.affixHeroGroupList_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

function var_0_0.StartScroll(arg_14_0)
	return
end

function var_0_0.StartScrollByPosition(arg_15_0)
	return
end

function var_0_0.RefreshItems(arg_16_0)
	local var_16_0 = arg_16_0.m_content.childCount

	print(var_16_0)

	for iter_16_0 = 0, var_16_0 - 1 do
		arg_16_0.m_content:GetChild(iter_16_0).gameObject:SetActive(false)
	end

	local var_16_1 = #arg_16_0.customData

	print(var_16_0)

	local var_16_2

	if var_16_0 < var_16_1 then
		for iter_16_1 = 1, var_16_1 - var_16_0 do
			Object.Instantiate(arg_16_0.m_item.gameObject, arg_16_0.m_content.transform):SetActive(true)
		end
	end

	local var_16_3 = 0
	local var_16_4

	for iter_16_2, iter_16_3 in pairs(arg_16_0.customData) do
		local var_16_5 = arg_16_0.m_content:GetChild(var_16_3).gameObject

		var_16_3 = var_16_3 + 1

		var_16_5:SetActive(true)

		local var_16_6 = MatrixAffixLongItem.New(var_16_5)
		local var_16_7 = ActivityAffixPoolCfg[iter_16_3].affix

		var_16_6:Refresh(var_16_7, 2)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.m_content:GetComponent("RectTransform"))

	for iter_16_4 = 0, var_16_0 - 1 do
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.m_content:GetChild(iter_16_4))
	end
end

function var_0_0.ClearItems(arg_17_0)
	local var_17_0 = arg_17_0.m_content.childCount

	print(var_17_0)

	for iter_17_0 = 0, var_17_0 - 1 do
		arg_17_0.m_content:GetChild(iter_17_0).gameObject:SetActive(false)
	end
end

return var_0_0
