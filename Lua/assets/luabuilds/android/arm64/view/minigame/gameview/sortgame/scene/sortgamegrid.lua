local var_0_0 = class("SortGameGrid")
local var_0_1 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._ad = findTF(arg_1_0._tf, "ad")
	arg_1_0._gridEventTriggerList = {}
	arg_1_0._index = arg_1_3
	arg_1_0._itemsTF = {}
	arg_1_0._itemsAnimator = {}
	arg_1_0._itemsDftEvent = {}

	for iter_1_0 = 1, var_0_1 do
		local var_1_0 = iter_1_0
		local var_1_1 = findTF(arg_1_0._tf, "ad/" .. iter_1_0)

		table.insert(arg_1_0._itemsTF, var_1_1)
		table.insert(arg_1_0._gridEventTriggerList, (GetOrAddComponent(findTF(var_1_1, "trigger"), typeof(EventTriggerListener))))
		table.insert(arg_1_0._itemsAnimator, (GetOrAddComponent(var_1_1, typeof(Animator))))

		local var_1_2 = GetOrAddComponent(var_1_1, typeof(DftAniEvent))

		var_1_2:SetEndEvent(function()
			if arg_1_0._removeDic and arg_1_0._removeDic[var_1_0] then
				arg_1_0._removeDic[var_1_0] = nil
				arg_1_0._itemIdDic[var_1_0][1] = 0

				if not arg_1_0:MoveItemToBottom() then
					arg_1_0:UpdateItem(var_1_0)
				elseif arg_1_0._moveBottomCallback then
					arg_1_0._moveBottomCallback(arg_1_0._index)
				end
			end

			return
		end)
		table.insert(arg_1_0._itemsDftEvent, var_1_2)
		arg_1_0:SetItemSelect(iter_1_0, false)
		arg_1_0:SetItemLock(iter_1_0, false)
	end

	arg_1_0._currentInputCount = 0
	arg_1_0._left, arg_1_0._middle, arg_1_0._right = {}, {}, {}
	arg_1_0._itemIdDic = {
		arg_1_0._left,
		arg_1_0._middle,
		arg_1_0._right
	}

	for iter_1_1 = 1, SortGameConst.grid_max_layer do
		table.insert(arg_1_0._left, 0)
		table.insert(arg_1_0._middle, 0)
		table.insert(arg_1_0._right, 0)
	end

	return
end

function var_0_0.SetRemoveEventCallback(arg_3_0, arg_3_1)
	arg_3_0._itemRemoveCallback = arg_3_1

	return
end

function var_0_0.SetMoveBottomCallback(arg_4_0, arg_4_1)
	arg_4_0._moveBottomCallback = arg_4_1

	return
end

function var_0_0.SetScoreCallback(arg_5_0, arg_5_1)
	arg_5_0._scoreCallback = arg_5_1

	return
end

function var_0_0.SetType(arg_6_0, arg_6_1)
	arg_6_0._gridType = arg_6_1

	arg_6_0:UpdateUI()

	return
end

function var_0_0.GetType(arg_7_0)
	return arg_7_0._gridType
end

function var_0_0.GetInputLayerCount(arg_8_0)
	return arg_8_0._currentInputCount
end

function var_0_0.HasInputEmptyLayer(arg_9_0)
	if arg_9_0._gridType == SortGameConst.grid_type_empty then
		return false
	end

	return arg_9_0:GetInputEmptyLayer() <= SortGameConst.grid_max_layer
end

function var_0_0.GetInputEmptyLayer(arg_10_0)
	local var_10_0 = 1

	for iter_10_0 = 1, SortGameConst.grid_max_layer do
		local var_10_1 = false

		for iter_10_1 = 1, var_0_1 do
			if arg_10_0._itemIdDic[iter_10_1][iter_10_0] ~= 0 then
				var_10_1 = true

				break
			end
		end

		if var_10_1 then
			var_10_0 = iter_10_0 + 1
		end
	end

	return var_10_0
end

function var_0_0.UpdateUI(arg_11_0)
	if arg_11_0._gridType == SortGameConst.grid_type_empty then
		arg_11_0:SetVisible(false)
	else
		arg_11_0:SetVisible(true)
	end

	for iter_11_0 = 1, var_0_1 do
		if arg_11_0._gridType == SortGameConst.grid_type_out then
			arg_11_0:SetItemLock(iter_11_0, iter_11_0 ~= 2)
		else
			arg_11_0:SetItemLock(iter_11_0, false)
		end
	end

	return
end

function var_0_0.SetItemLock(arg_12_0, arg_12_1, arg_12_2)
	setActive(findTF(arg_12_0._itemsTF[arg_12_1], "lock"), arg_12_2)

	return
end

function var_0_0.PassItem(arg_13_0)
	arg_13_0._removeDic = {}

	for iter_13_0 = 1, #arg_13_0._itemsAnimator do
		arg_13_0._removeDic[iter_13_0] = true

		arg_13_0._itemsAnimator[iter_13_0]:SetTrigger("pass")
	end

	if arg_13_0._scoreCallback then
		arg_13_0._scoreCallback(arg_13_0._index, arg_13_0._itemIdDic[1][1])
	end

	return
end

function var_0_0.GetPosition(arg_14_0)
	return arg_14_0._tf.position
end

function var_0_0.SetVisible(arg_15_0, arg_15_1)
	setActive(arg_15_0._ad, arg_15_1)

	return
end

function var_0_0.GetEmptyLayerFirst(arg_16_0)
	local var_16_0 = 0

	for iter_16_0 = 1, SortGameConst.grid_max_layer do
		local var_16_1 = false

		for iter_16_1 = 1, var_0_1 do
			if arg_16_0._itemIdDic[iter_16_1][iter_16_0] ~= 0 then
				var_16_1 = true

				break
			end
		end

		if not var_16_1 then
			var_16_0 = iter_16_0

			break
		end
	end

	return var_16_0
end

function var_0_0.GetLayerEmptyFlag(arg_17_0, arg_17_1)
	if arg_17_1 > SortGameConst.grid_max_layer then
		return true
	end

	local var_17_0 = false

	for iter_17_0 = 1, var_0_1 do
		if arg_17_0._itemIdDic[iter_17_0][arg_17_1] ~= 0 then
			var_17_0 = true

			break
		end
	end

	return not var_17_0
end

function var_0_0.GetBottomIds(arg_18_0)
	for iter_18_0 = 1, var_0_1 do
		table.insert({}, arg_18_0._itemIdDic[iter_18_0][1])
	end

	return {}
end

function var_0_0.GetBottomId(arg_19_0, arg_19_1)
	return arg_19_0._itemIdDic[arg_19_1][1]
end

function var_0_0.GetAllIds(arg_20_0)
	for iter_20_0 = 1, var_0_1 do
		for iter_20_1 = 1, SortGameConst.grid_max_layer do
			table.insert({}, arg_20_0._itemIdDic[iter_20_0][iter_20_1])
		end
	end

	return {}
end

function var_0_0.SetOffset(arg_21_0, arg_21_1)
	arg_21_0._offset = arg_21_1
	arg_21_0._ad.anchoredPosition = Vector2(arg_21_1[1] * SortGameConst.grid_bound[1], arg_21_1[2] * SortGameConst.grid_bound[2])

	return
end

function var_0_0.checkItemPass(arg_22_0)
	if arg_22_0._gridType == SortGameConst.grid_type_empty or arg_22_0._gridType == SortGameConst.grid_type_out then
		return false
	end

	local var_22_0 = arg_22_0:GetItemBottomId(1)
	local var_22_1 = arg_22_0:GetItemBottomId(2)
	local var_22_2 = arg_22_0:GetItemBottomId(3)

	if var_22_0 and var_22_1 and var_22_2 and var_22_0 ~= 0 and var_22_1 ~= 0 and var_22_2 ~= 0 and var_22_0 == var_22_1 and var_22_1 == var_22_2 then
		if arg_22_0._itemRemoveCallback then
			arg_22_0._itemRemoveCallback(arg_22_0._index, var_22_0)
			arg_22_0._itemRemoveCallback(arg_22_0._index, var_22_1)
			arg_22_0._itemRemoveCallback(arg_22_0._index, var_22_2)
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SortGameConst.SFX_PASS)
		arg_22_0:PassItem()
	end

	return
end

function var_0_0.InputIds(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:GetInputEmptyLayer()

	if var_23_0 <= SortGameConst.grid_max_layer then
		print("插入层数 = " .. var_23_0)

		for iter_23_0 = 1, var_0_1 do
			arg_23_0._itemIdDic[iter_23_0][var_23_0] = arg_23_1[iter_23_0]

			arg_23_0:UpdateItem(iter_23_0)
		end

		setActive(arg_23_0._ad, true)

		arg_23_0._currentInputCount = arg_23_0._currentInputCount + 1
	else
		warning("插入失败！数据对齐出问题，需要排查")
	end

	return
end

function var_0_0.ReplaceId(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0._itemIdDic[arg_24_1][1] = arg_24_2

	arg_24_0:UpdateItem(arg_24_1)

	return
end

function var_0_0.UpdateItem(arg_25_0, arg_25_1)
	if arg_25_0._itemIdDic[arg_25_1][1] ~= 0 then
		arg_25_0:SetItemIcon(arg_25_1, arg_25_0._itemIdDic[arg_25_1][1], "top")
	end

	if arg_25_0._itemIdDic[arg_25_1][2] ~= 0 then
		arg_25_0:SetItemIcon(arg_25_1, arg_25_0._itemIdDic[arg_25_1][2], "bottom")
	end

	setActive(findTF(arg_25_0._itemsTF[arg_25_1], "top"), arg_25_0._itemIdDic[arg_25_1][1] ~= 0)
	setActive(findTF(arg_25_0._itemsTF[arg_25_1], "bottom"), arg_25_0._itemIdDic[arg_25_1][2] ~= 0)

	return
end

function var_0_0.MoveItemToBottom(arg_26_0, arg_26_1)
	if arg_26_1 then
		local var_26_0 = arg_26_1 + 1 or 1
		local var_26_1 = arg_26_0:GetEmptyLayerFirst()

		if var_26_1 >= 1 and not arg_26_0:GetLayerEmptyFlag(var_26_1 + 1) then
			for iter_26_0 = 1, var_0_1 do
				arg_26_0._itemIdDic[iter_26_0][var_26_1] = arg_26_0._itemIdDic[iter_26_0][var_26_1 + 1]
				arg_26_0._itemIdDic[iter_26_0][var_26_1 + 1] = 0
			end

			return arg_26_0:MoveItemToBottom(var_26_0)
		end

		if var_26_0 > 1 then
			for iter_26_1 = 1, var_0_1 do
				arg_26_0:UpdateItem(iter_26_1)
				arg_26_0._itemsAnimator[iter_26_1]:SetTrigger("show")
			end
		end

		return var_26_0 > 1
	end
end

function var_0_0.SetShowAniamtion(arg_27_0)
	for iter_27_0 = 1, var_0_1 do
		arg_27_0._itemsAnimator[iter_27_0]:SetTrigger("show")
	end

	return
end

function var_0_0.GetItemBottomId(arg_28_0, arg_28_1)
	return arg_28_0._itemIdDic[arg_28_1][1]
end

function var_0_0.InSertItem(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_0._itemIdDic and arg_29_0._itemIdDic[arg_29_1] then
		arg_29_0._itemIdDic[arg_29_1][1] = arg_29_2

		arg_29_0:UpdateItem(arg_29_1)
	end

	if not arg_29_0:checkItemPass() then
		arg_29_0:UpdateItem(arg_29_1)
	end

	return
end

function var_0_0.CheckMoveBottom(arg_30_0)
	if arg_30_0:MoveItemToBottom() and arg_30_0._moveBottomCallback then
		arg_30_0._moveBottomCallback(arg_30_0._index)
	end

	return
end

function var_0_0.SetItemAlpha(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0._itemsAnimator[arg_31_1]:SetTrigger(arg_31_2 and "alpha" or "normal")
	print("set alpha " .. arg_31_1 .. " " .. tostring(arg_31_2))

	return
end

function var_0_0.SetItemSelect(arg_32_0, arg_32_1, arg_32_2)
	setActive(findTF(arg_32_0._itemsTF[arg_32_1], "select"), arg_32_2)

	return
end

function var_0_0.SetItemIcon(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	setActive(findTF(arg_33_0._itemsTF[arg_33_1], arg_33_3 .. "/icon"), false)
	GetSpriteFromAtlasAsync(SortGameConst.ui_atlas, "item_" .. arg_33_2, function(arg_34_0)
		if var_0 then
			setImageSprite(var_0, arg_34_0, true)
			setActive(var_0, true)
		end

		return
	end)

	return
end

function var_0_0.AddItemEventCallback(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	for iter_35_0 = 1, var_0_1 do
		if arg_35_0._gridEventTriggerList[iter_35_0] then
			arg_35_0._gridEventTriggerList[iter_35_0]:AddDragFunc(function(arg_36_0, arg_36_1)
				if arg_35_0._itemIdDic[var_0][1] == 0 then
					return
				end

				if arg_35_1 then
					arg_35_1(arg_35_0._index, var_0, arg_36_1)
				end

				return
			end)
			arg_35_0._gridEventTriggerList[iter_35_0]:AddDragEndFunc(function(arg_37_0, arg_37_1)
				if arg_35_0._itemIdDic[var_0][1] == 0 then
					return
				end

				if arg_35_2 then
					arg_35_2(arg_35_0._index, var_0, arg_37_1)
				end

				setActive(arg_35_0._itemsTF[var_0], true)

				return
			end)
			arg_35_0._gridEventTriggerList[iter_35_0]:AddPointEnterFunc(function(arg_38_0, arg_38_1)
				if arg_35_0._gridType == SortGameConst.grid_type_out then
					return
				end

				if arg_35_0._itemIdDic[var_0][1] ~= 0 then
					return
				end

				if arg_35_3 then
					arg_35_3(arg_35_0._index, var_0, arg_38_1)
				end

				return
			end)
			arg_35_0._gridEventTriggerList[iter_35_0]:AddPointExitFunc(function(arg_39_0, arg_39_1)
				if arg_35_0._gridType == SortGameConst.grid_type_out then
					return
				end

				if arg_35_0._itemIdDic[var_0][1] ~= 0 then
					return
				end

				if arg_35_4 then
					arg_35_4(arg_35_0._index, var_0, arg_39_1)
				end

				return
			end)
		end
	end

	return
end

function var_0_0.ClearItems(arg_40_0)
	arg_40_0._currentInputCount = 0

	for iter_40_0 = 1, var_0_1 do
		for iter_40_1 = 1, SortGameConst.grid_max_layer do
			arg_40_0._itemIdDic[iter_40_0][iter_40_1] = 0
		end

		arg_40_0:UpdateItem(iter_40_0)
	end

	return
end

function var_0_0.GetInputEmptyCount(arg_41_0)
	local var_41_0 = 0

	for iter_41_0 = 1, var_0_1 do
		if arg_41_0._gridType ~= SortGameConst.grid_type_out and arg_41_0._gridType ~= SortGameConst.grid_type_empty and arg_41_0._itemIdDic[iter_41_0][1] == 0 then
			var_41_0 = var_41_0 + 1
		end
	end

	return var_41_0
end

function var_0_0.Stop(arg_42_0)
	for iter_42_0 = 1, #arg_42_0._itemsAnimator do
		arg_42_0._itemsAnimator[iter_42_0].speed = 0
	end

	return
end

function var_0_0.Resume(arg_43_0)
	for iter_43_0 = 1, #arg_43_0._itemsAnimator do
		arg_43_0._itemsAnimator[iter_43_0].speed = 1
	end

	return
end

function var_0_0.Clear(arg_44_0)
	arg_44_0._currentInputCount = 0

	for iter_44_0 = 1, #arg_44_0._itemsAnimator do
		arg_44_0._itemsAnimator[iter_44_0].speed = 1
	end

	for iter_44_1 = 1, var_0_1 do
		for iter_44_2 = 1, SortGameConst.grid_max_layer do
			arg_44_0._itemIdDic[iter_44_1][iter_44_2] = 0
		end

		arg_44_0:SetItemSelect(iter_44_1, false)
	end

	setActive(arg_44_0._ad, false)

	for iter_44_3 = 1, var_0_1 do
		arg_44_0:UpdateItem(iter_44_3)
	end

	arg_44_0._removeDic = {}

	return
end

function var_0_0.Dispose(arg_45_0)
	for iter_45_0 = 1, #arg_45_0._gridEventTriggerList do
		ClearEventTrigger(arg_45_0._gridEventTriggerList[iter_45_0])
	end

	return
end

return var_0_0
