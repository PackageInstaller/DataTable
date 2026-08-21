local var_0_0 = class("IslandSelectableOpView", import("Mod.Island.Core.View.IslandASynLoadAndCacheSubView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandSelectableOpUI"
end

function var_0_0.SetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().topContainer
end

function var_0_0.FirstFlush(arg_3_0)
	arg_3_0.frameTr = arg_3_0._tf:Find("list")
	arg_3_0.cotainer = arg_3_0._tf:Find("list/content")
	arg_3_0.tpl = arg_3_0._tf:Find("list/content/item")
	arg_3_0.gridLayoutGroup = arg_3_0.cotainer:GetComponent(typeof(GridLayoutGroup))
	arg_3_0.uiItemList = UIItemList.New(arg_3_0.cotainer, arg_3_0.tpl)
	arg_3_0.descPanle = IslandSelectableDescPanel.New(arg_3_0._tf:Find("desc"), arg_3_0:IsShowItemCount())

	onButton(arg_3_0, arg_3_0._tf, function()
		if arg_3_0.descPanle:IsShowing() then
			arg_3_0.descPanle:Hide()

			return
		end

		arg_3_0:Dispose()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Filter(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		assert(isa(iter_5_1, IslandItem), "v is not a IslandItem")

		if iter_5_1:GetCount() > 0 then
			table.insert({}, iter_5_1)
		end
	end

	arg_5_0:Sort({})

	return {}
end

function var_0_0.Sort(arg_6_0, arg_6_1)
	table.sort(arg_6_1, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:GetRarity()
		local var_7_1 = arg_7_1:GetRarity()

		if var_7_0 == var_7_1 then
			return arg_7_0.id > arg_7_1.id
		else
			return var_7_1 < var_7_0
		end

		return
	end)

	return
end

function var_0_0.Flush(arg_8_0)
	arg_8_0.selectedId = arg_8_0:GetSelectedId()
	arg_8_0.displays = arg_8_0:Filter(arg_8_0:GetDisplayData())

	seriesAsync({
		function(arg_9_0)
			arg_8_0:PreloadList(arg_9_0)

			return
		end
	}, function()
		arg_8_0:UpdateLayout()
		arg_8_0:UpdateList()

		return
	end)

	return
end

function var_0_0.PreloadList(arg_11_0, arg_11_1)
	if #arg_11_0.displays <= 5 then
		arg_11_1()

		return
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.displays) do
		table.insert(var_11_0, function(arg_12_0)
			cloneTplTo(arg_11_0.tpl, arg_11_0.cotainer)

			if iter_11_0 % 3 == 0 then
				onNextTick(arg_12_0)
			else
				arg_12_0()
			end

			return
		end)
	end

	seriesAsync(var_11_0, arg_11_1)

	return
end

function var_0_0.UpdateLayout(arg_13_0)
	arg_13_0.gridLayoutGroup.constraintCount = math.min(#arg_13_0.displays, (arg_13_0:GetMaxHrzCnt()))

	local var_13_0 = arg_13_0:GetTargetTr()

	arg_13_0.frameTr.position = var_0_0.TrPosition2LocalPos(var_13_0.parent, arg_13_0.frameTr.parent, var_13_0.position)

	return
end

function var_0_0.TrPosition2LocalPos(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 == arg_14_1 then
		return arg_14_2
	else
		local var_14_0 = arg_14_1:InverseTransformPoint((arg_14_0:TransformPoint(arg_14_2)))

		return Vector3(var_14_0.x, var_14_0.y, 0)
	end

	return
end

function var_0_0.UpdateList(arg_15_0)
	local var_15_0 = arg_15_0.displays

	arg_15_0.uiItemList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			arg_15_0:UpdateItem(arg_16_2, var_15_0[arg_16_1 + 1])
		end

		return
	end)
	arg_15_0.uiItemList:align(#arg_15_0.displays)
	arg_15_0:UpdateSelected()

	return
end

function var_0_0.UpdateItem(arg_17_0, arg_17_1, arg_17_2)
	assert(isa(arg_17_2, IslandItem), "islandItem is not a IslandItem")
	updateCustomDrop(arg_17_1, Drop.New({
		type = DROP_TYPE_ISLAND_ITEM,
		id = arg_17_2.id,
		count = arg_17_2:GetCount()
	}))
	setActive(arg_17_1:Find("icon_bg/count_bg"), arg_17_0:IsShowItemCount())

	local var_17_0 = false

	onButton(arg_17_0, arg_17_1, function()
		if var_17_0 then
			var_17_0 = false

			return
		end

		arg_17_0.selectedId = arg_17_2.id

		arg_17_0:UpdateSelected()
		arg_17_0:OnSelected(arg_17_2.id)
		arg_17_0:Dispose()

		return
	end, SFX_PANEL)

	local var_17_1 = GetOrAddComponent(arg_17_1, typeof(UILongPressTrigger))

	var_17_1.onLongPressed:RemoveAllListeners()
	var_17_1.onLongPressed:AddListener(function()
		var_17_0 = true

		arg_17_0.descPanle:Show(arg_17_1.position, arg_17_2)

		return
	end)

	return
end

function var_0_0.UpdateSelected(arg_20_0)
	local var_20_0 = arg_20_0.displays

	arg_20_0.uiItemList:eachActive(function(arg_21_0, arg_21_1)
		setActive(arg_21_1:Find("select"), arg_20_0.selectedId == var_20_0[arg_21_0 + 1].id)

		return
	end)

	return
end

function var_0_0.OnHide(arg_22_0)
	arg_22_0.descPanle:Hide()

	arg_22_0.selectedId = nil

	arg_22_0.uiItemList:each(function(arg_23_0, arg_23_1)
		GetOrAddComponent(arg_23_1, typeof(UILongPressTrigger)).onLongPressed:RemoveAllListeners()

		return
	end)

	return
end

function var_0_0.OnDestroy(arg_24_0)
	if arg_24_0.descPanle then
		arg_24_0.descPanle:Dispose()

		arg_24_0.descPanle = nil
	end

	return
end

function var_0_0.GetDisplayData(arg_25_0)
	assert(false, "over write me")

	return
end

function var_0_0.GetTargetTr(arg_26_0)
	assert(false, "over write me")

	return
end

function var_0_0.IsShowItemCount(arg_27_0)
	return true
end

function var_0_0.GetSelectedId(arg_28_0)
	return 0
end

function var_0_0.OnSelected(arg_29_0, arg_29_1)
	return
end

function var_0_0.GetMaxHrzCnt(arg_30_0)
	return 7
end

return var_0_0
