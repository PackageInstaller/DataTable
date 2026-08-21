local var_0_0 = class("SortGameGridController")
local var_0_1 = 3
local var_0_2 = 4
local var_0_3 = 3
local var_0_4 = Vector2(0, -25)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runtimeData = arg_1_3
	arg_1_0._gridTpl = findTF(arg_1_0._tf, "grids/grid_tpl")

	setActive(arg_1_0._gridTpl, false)

	arg_1_0._dragGridTF = findTF(arg_1_0._tf, "drag_grid")

	setActive(arg_1_0._dragGridTF, false)

	arg_1_0._contentAniamtor = arg_1_0._tf:GetComponent(typeof(Animator))
	arg_1_0._contentDftEvent = arg_1_0._tf:GetComponent(typeof(DftAniEvent))

	arg_1_0._contentDftEvent:SetEndEvent(function()
		arg_1_0:ResetGrid()

		return
	end)

	arg_1_0._grids = {}

	for iter_1_0 = 1, var_0_1 * var_0_2 do
		local var_1_1 = findTF(arg_1_0._tf, "grids/grid_" .. iter_1_0)

		setParent(var_1_1, arg_1_0._gridTpl.parent)
		setActive(var_1_1, true)

		local var_1_2 = SortGameGrid.New(var_1_1, arg_1_0._event, iter_1_0)

		arg_1_0._grids[iter_1_0] = var_1_2

		arg_1_0._grids[iter_1_0]:SetRemoveEventCallback(function(arg_3_0, arg_3_1)
			arg_1_0:removeItemIds(arg_3_1)
			arg_1_0:checkGameOver()

			return
		end)
		arg_1_0._grids[iter_1_0]:SetMoveBottomCallback(function(arg_4_0)
			arg_1_0:checkGridInput(arg_1_0._grids[arg_4_0])

			return
		end)
		arg_1_0._grids[iter_1_0]:SetScoreCallback(function(arg_5_0, arg_5_1)
			arg_1_0._comboIndex = arg_1_0._comboIndex and arg_1_0._comboIndex + 1 or 0
			arg_1_0._comboTime = SortGameConst.combo_time
			arg_1_0._waitTime = 0

			arg_1_0._event:emit(SimpleMGEvent.ADD_SCORE, {
				num = arg_1_0:GetScore(arg_5_1),
				combo = arg_1_0._comboIndex,
				position = arg_1_0._grids[arg_5_0]:GetPosition()
			})

			if arg_1_0._wantedItem and arg_1_0._wantedItem == arg_5_1 then
				arg_1_0._wantedItem = nil
				arg_1_0._wantedStepTime = nil

				arg_1_0._event:emit(SortGameView.WANTED_ITEM_REFRESH, {})
				arg_1_0._event:emit(SortGameView.PLAYER_SPEAK, arg_1_0._runtimeData:GetSpeakData(SortGameConst.sort_conifg_type_chat, (arg_1_0._runtimeData:GetPlayerName(arg_1_0._runtimeData:GetPlayerIdByItem(arg_5_1)))))
			end

			if table.contains(SortGameConst.combo_speak_num, arg_1_0._comboIndex) then
				arg_1_0._event:emit(SortGameView.PLAYER_SPEAK, arg_1_0._runtimeData:GetSpeakData(SortGameConst.sort_conifg_type_combo))
			end

			return
		end)
		var_1_2:AddItemEventCallback(function(arg_6_0, arg_6_1, arg_6_2)
			arg_1_0:onGridDrag(arg_6_0, arg_6_1, arg_6_2)

			return
		end, function(arg_7_0, arg_7_1, arg_7_2)
			arg_1_0:onGridDragEnd(arg_7_0, arg_7_1, arg_7_2)

			return
		end, function(arg_8_0, arg_8_1, arg_8_2)
			arg_1_0:onGridEnter(arg_8_0, arg_8_1, arg_8_2)

			return
		end, function(arg_9_0, arg_9_1, arg_9_2)
			arg_1_0:onGridExit(arg_9_0, arg_9_1, arg_9_2)

			return
		end)
	end

	arg_1_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))

	return
end

function var_0_0.checkGameOver(arg_10_0)
	if #arg_10_0._itemIds == 0 and #arg_10_0._itemIdsPool == 0 then
		arg_10_0._event:emit(SortGameView.GAME_OVER_TIME)
	end

	return
end

function var_0_0.removeItemIds(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0._itemIds do
		if arg_11_0._itemIds[iter_11_0] == arg_11_1 then
			print("item_id = " .. arg_11_1 .. " 被消除了")
			table.remove(arg_11_0._itemIds, iter_11_0)

			return
		end
	end

	warning("没有在格子中找到这个id = " .. arg_11_1)

	return
end

function var_0_0.onGridDrag(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0._dragGridIndex ~= nil and arg_12_0._dragGridIndex ~= arg_12_1 then
		return
	end

	if not arg_12_0._grids[arg_12_1] then
		return
	end

	if not arg_12_0._dragGridIndex then
		arg_12_0._startDragPos = arg_12_3.position
		arg_12_0._dragGridStartPos = arg_12_0._tf:InverseTransformPoint(arg_12_0._uiCamera:ScreenToWorldPoint(arg_12_0._startDragPos))

		setActive(arg_12_0._dragGridTF, true)

		arg_12_0._dragGridIndex = arg_12_1
		arg_12_0._dragGridItemIndex = arg_12_2

		local var_12_1 = var_12_0:GetItemBottomId(arg_12_2)

		var_12_0:SetItemAlpha(arg_12_2, true)

		if var_12_1 and var_12_1 > 0 then
			GetSpriteFromAtlasAsync(SortGameConst.ui_atlas, "item_" .. var_12_1, function(arg_13_0)
				setImageSprite(arg_12_0._dragGridTF, arg_13_0, true)

				return
			end)
		end

		arg_12_0._dragScreenRate = arg_12_0:GetScreentScaleRate()
	end

	arg_12_0._dragGridTF.anchoredPosition = Vector2(arg_12_0._dragGridStartPos.x + (var_0_4.x + (arg_12_3.position.x - arg_12_0._startDragPos.x)) * arg_12_0._dragScreenRate.x, arg_12_0._dragGridStartPos.y + (var_0_4.y + (arg_12_3.position.y - arg_12_0._startDragPos.y)) * arg_12_0._dragScreenRate.y)

	return
end

function var_0_0.Start(arg_14_0)
	return
end

function var_0_0.onGridDragEnd(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_0._dragGridIndex then
		return
	end

	setActive(arg_15_0._dragGridTF, false)

	local var_15_0 = false

	if arg_15_0._dragGridIndex and arg_15_0._enterGridIndex then
		if arg_15_0._dragGridIndex == arg_15_0._enterGridIndex and arg_15_0._dragGridItemIndex ~= arg_15_0._enterGridItemIndex then
			var_15_0 = true
		elseif arg_15_0._dragGridIndex ~= arg_15_0._enterGridIndex then
			var_15_0 = true
		end
	end

	arg_15_0._grids[arg_15_1]:SetItemAlpha(arg_15_2, false)

	if var_15_0 then
		arg_15_0._grids[arg_15_0._dragGridIndex]:InSertItem(arg_15_0._dragGridItemIndex, (arg_15_0._grids[arg_15_0._enterGridIndex]:GetItemBottomId(arg_15_0._enterGridItemIndex)))
		arg_15_0._grids[arg_15_0._enterGridIndex]:InSertItem(arg_15_0._enterGridItemIndex, (arg_15_0._grids[arg_15_0._dragGridIndex]:GetItemBottomId(arg_15_0._dragGridItemIndex)))
		arg_15_0._grids[arg_15_0._dragGridIndex]:CheckMoveBottom()
		arg_15_0._grids[arg_15_0._enterGridIndex]:CheckMoveBottom()
	end

	if arg_15_0._enterGridIndex and arg_15_0._grids[arg_15_0._enterGridIndex] then
		arg_15_0._grids[arg_15_0._enterGridIndex]:SetItemSelect(arg_15_0._enterGridItemIndex, false)
	end

	if arg_15_0._dragGridIndex and arg_15_0._grids[arg_15_0._dragGridIndex] and arg_15_0._grids[arg_15_0._dragGridIndex]:GetType() == SortGameConst.grid_type_out and arg_15_0._grids[arg_15_0._dragGridIndex]:GetInputEmptyLayer() == 1 then
		arg_15_0._grids[arg_15_0._dragGridIndex]:SetItemLock(2, true)
	end

	arg_15_0._dragGridIndex = nil
	arg_15_0._enterGridIndex = nil
	arg_15_0._dragGridItemIndex = nil
	arg_15_0._enterGridItemIndex = nil

	return
end

function var_0_0.onGridEnter(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not arg_16_0._dragGridIndex then
		return
	end

	if arg_16_0._dragGridIndex == arg_16_1 and arg_16_0._dragGridItemIndex == arg_16_2 then
		return
	end

	if arg_16_0._enterGridIndex and arg_16_0._grids[arg_16_0._enterGridIndex] then
		arg_16_0._grids[arg_16_0._enterGridIndex]:SetItemSelect(arg_16_0._enterGridItemIndex, false)
	end

	arg_16_0._enterGridIndex = arg_16_1
	arg_16_0._enterGridItemIndex = arg_16_2

	if arg_16_1 and arg_16_0._grids[arg_16_1] then
		arg_16_0._grids[arg_16_0._enterGridIndex]:SetItemSelect(arg_16_2, true)
	end

	return
end

function var_0_0.onGridExit(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0._dragGridIndex then
		return
	end

	if not arg_17_0._enterGridIndex then
		return
	end

	if arg_17_0._enterGridIndex == arg_17_1 and arg_17_0._enterGridItemIndex == arg_17_2 then
		if arg_17_0._enterGridIndex and arg_17_0._grids[arg_17_0._enterGridIndex] then
			arg_17_0._grids[arg_17_0._enterGridIndex]:SetItemSelect(arg_17_0._enterGridItemIndex, false)
		end

		arg_17_0._enterGridIndex = nil
		arg_17_0._enterGridItemIndex = nil
	end

	return
end

function var_0_0.checkGridInput(arg_18_0, arg_18_1)
	if arg_18_1:GetInputLayerCount() < arg_18_0._itemLayerMax and arg_18_1:GetInputEmptyLayer() <= SortGameConst.grid_max_layer then
		arg_18_0:InPutGrid(arg_18_1, true)

		arg_18_0._checkLockTime = 0

		return true
	end

	return false
end

function var_0_0.GetItemIdList(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = Clone(arg_19_1)

	for iter_19_0 = 1, arg_19_2 do
		for iter_19_1 = 1, var_0_3 * arg_19_3 do
			table.insert({}, var_19_0[1])
		end
	end

	return {}
end

function var_0_0.ShuffleList(arg_20_0, arg_20_1, arg_20_2)
	randomRange = arg_20_2 and math.min(arg_20_2, #arg_20_1) or #arg_20_1

	for iter_20_0 = randomRange, 2, -1 do
		local var_20_0 = math.random(1, iter_20_0)

		arg_20_1[iter_20_0], arg_20_1[var_20_0] = arg_20_1[var_20_0], arg_20_1[iter_20_0]
	end

	return
end

function var_0_0.InPutGrid(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 0

	if arg_21_1:GetType() > 0 then
		local var_21_1 = arg_21_0:GetGridIdMap(arg_21_1, arg_21_0._normalItemWeight)
		local var_21_2

		if arg_21_2 then
			var_21_2 = arg_21_0:GetIdsDic(arg_21_0._itemIds)
		end

		for iter_21_0 = 1, #var_21_1 do
			if var_21_1[iter_21_0] ~= 0 and #arg_21_0._itemIdsPool > 0 then
				local var_21_3
				local var_21_4

				if iter_21_0 == 3 and ({})[1] == ({})[2] and ({})[1] ~= 0 then
					print("当前第三个格子需要优先匹配前两个格子的id，id = " .. ({})[1])

					var_21_3 = ({})[1]
					var_21_0 = var_21_0 + 1
					var_21_4 = {}
				end

				table.insert({}, (arg_21_0:GetIdFromPool(var_21_2, var_21_3)))
			else
				table.insert({}, 0)
			end
		end

		print("插入id列表 = " .. table.concat({}, ","))
		arg_21_1:InputIds({})
	end

	return var_21_0
end

function var_0_0.GetIdFromPool(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0._itemIdsPool and #arg_22_0._itemIdsPool > 0 then
		if arg_22_1 then
			if arg_22_0:GetPassItemCount(arg_22_1) <= SortGameConst.pass_limit_num then
				local var_22_0

				for iter_22_0, iter_22_1 in pairs(arg_22_1) do
					local var_22_1

					if 0 < iter_22_1 and arg_22_0:checkIdExist(arg_22_0._itemIdsPool, iter_22_0) and iter_22_0 ~= arg_22_2 then
						var_22_1 = iter_22_1
						var_22_0 = iter_22_0
					end
				end

				if var_22_0 then
					for iter_22_2 = 1, #arg_22_0._itemIdsPool do
						if arg_22_0._itemIdsPool[iter_22_2] == var_22_0 then
							table.insert(arg_22_0._itemIds, (table.remove(arg_22_0._itemIdsPool, iter_22_2)))

							arg_22_1[var_22_0] = arg_22_1[var_22_0] + 1

							print("匹配成功，匹配id = " .. var_22_0)

							return var_22_0
						end
					end
				end
			else
				print("本次从池子中取不到元素， 长度 = " .. #arg_22_0._itemIdsPool)
			end
		end

		local var_22_2 = table.remove(arg_22_0._itemIdsPool, 1)

		table.insert(arg_22_0._itemIds, var_22_2)

		return var_22_2
	end

	warning("id池已经没有id了")

	return 0
end

function var_0_0.checkIdExist(arg_23_0, arg_23_1, arg_23_2)
	return table.contains(arg_23_1, arg_23_2)
end

function var_0_0.GetScreentScaleRate(arg_24_0)
	local var_24_0 = tf(GameObject.Find("UICamera/Canvas"))

	return Vector2(var_24_0.sizeDelta.x / UnityEngine.Screen.width, var_24_0.sizeDelta.y / UnityEngine.Screen.height)
end

function var_0_0.GetGridIdMap(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		0,
		0,
		0
	}
	local var_25_1 = arg_25_1:GetType()

	if var_25_1 == SortGameConst.grid_type_empty then
		var_25_0 = {
			0,
			0,
			0
		}
	elseif var_25_1 == SortGameConst.grid_type_normal then
		local var_25_2 = math.random()
		local var_25_3 = 1

		for iter_25_0 = 1, #arg_25_2 do
			if iter_25_0 == 1 then
				if var_25_2 <= arg_25_2[iter_25_0] then
					var_25_3 = iter_25_0
				end
			elseif var_25_2 > arg_25_2[iter_25_0 - 1] and var_25_2 <= arg_25_2[iter_25_0] then
				var_25_3 = iter_25_0

				break
			end
		end

		var_25_0 = var_25_3 == 1 and {
			1,
			0,
			0
		} or var_25_3 == 2 and {
			1,
			1,
			0
		} or {
			1,
			1,
			1
		}

		arg_25_0:shuffleArray(var_25_0)
	elseif var_25_1 == SortGameConst.grid_type_two then
		var_25_0 = {
			1,
			1,
			0
		}

		arg_25_0:shuffleArray({
			1,
			1,
			0
		})
	elseif var_25_1 == SortGameConst.grid_type_out then
		var_25_0 = {
			0,
			1,
			0
		}
	end

	return var_25_0
end

function var_0_0.shuffleArray(arg_26_0, arg_26_1)
	for iter_26_0 = #arg_26_1, 2, -1 do
		local var_26_0 = math.random(1, iter_26_0)

		arg_26_1[iter_26_0], arg_26_1[var_26_0] = arg_26_1[var_26_0], arg_26_1[iter_26_0]
	end

	return
end

function var_0_0.CalculateWeight(arg_27_0, arg_27_1)
	local var_27_0 = 0

	for iter_27_0 = 1, #arg_27_1 do
		var_27_0 = var_27_0 + arg_27_1[iter_27_0]
	end

	local var_27_1 = 0

	for iter_27_1 = 1, #arg_27_1 do
		var_27_1 = var_27_1 + arg_27_1[iter_27_1]

		table.insert({}, var_27_1 / var_27_0)
	end

	return {}
end

function var_0_0.GetScore(arg_28_0, arg_28_1)
	if arg_28_0._wantedItem and arg_28_1 == arg_28_0._wantedItem then
		local var_28_0 = SortGameConst.wanted_score_num or SortGameConst.score_num

		if not arg_28_0._comboIndex or arg_28_0._comboIndex == 0 then
			return var_28_0
		else
			for iter_28_0 = 1, #SortGameConst.combo_rate do
				if arg_28_0._comboIndex >= SortGameConst.combo_rate[iter_28_0].range[1] and arg_28_0._comboIndex <= SortGameConst.combo_rate[iter_28_0].range[2] then
					return math.floor(var_28_0 * SortGameConst.combo_rate[iter_28_0].rate)
				end
			end

			return var_28_0
		end

		return
	end
end

function var_0_0.Prepare(arg_29_0)
	arg_29_0._dragGridIndex = nil
	arg_29_0._enterGridIndex = nil
	arg_29_0._dragGridItemIndex = nil
	arg_29_0._enterGridItemIndex = nil
	arg_29_0._waitTime = 0
	arg_29_0._comboIndex = 0
	arg_29_0._comboTime = nil

	local var_29_0 = arg_29_0._runtimeData:GetPlayers()
	local var_29_1 = arg_29_0._runtimeData:GetChapterConfig("player_own_item_count") or 1

	arg_29_0._normalItemWeight = arg_29_0:CalculateWeight((arg_29_0._runtimeData:GetChapterConfig("grid_weight")))

	local var_29_2 = arg_29_0:GetItemIdList(arg_29_0._runtimeData:GetComonItems(), arg_29_0._runtimeData:GetChapterConfig("item_count"), (arg_29_0._runtimeData:GetChapterConfig("item_rate")))

	for iter_29_0 = 1, #var_29_0 do
		local var_29_3 = arg_29_0._runtimeData:GetPlayerItems(var_29_0[iter_29_0])

		for iter_29_1 = 1, #var_29_3 do
			table.insert({}, var_29_3[iter_29_1])
		end
	end

	local var_29_4 = arg_29_0:GetItemIdList({}, var_29_1, 1)

	arg_29_0._itemIdsPool = {}

	for iter_29_2 = 1, #var_29_2 do
		table.insert(arg_29_0._itemIdsPool, var_29_2[iter_29_2])
	end

	for iter_29_3 = 1, #var_29_4 do
		table.insert(arg_29_0._itemIdsPool, var_29_4[iter_29_3])
	end

	arg_29_0._itemIds = {}

	for iter_29_4 = 1, SortGameConst.init_pass_num do
		local var_29_5 = arg_29_0._itemIdsPool[math.random(1, #arg_29_0._itemIdsPool)]
		local var_29_6 = 0

		for iter_29_5 = #arg_29_0._itemIdsPool, 1, -1 do
			if arg_29_0._itemIdsPool[iter_29_5] == var_29_5 then
				table.insert({}, table.remove(arg_29_0._itemIdsPool, iter_29_5))

				var_29_6 = var_29_6 + 1

				if var_29_6 == 3 then
					break
				end
			end
		end
	end

	arg_29_0:ShuffleList(arg_29_0._itemIdsPool)

	if #{} > 0 then
		for iter_29_6 = 1, #{} do
			table.insert(arg_29_0._itemIdsPool, 1, ({})[iter_29_6])
		end
	end

	arg_29_0:ShuffleList(arg_29_0._itemIdsPool, 18)

	arg_29_0._activeGridCount = 0
	arg_29_0._boundsData = arg_29_0._runtimeData:GetBoundConfig()
	arg_29_0._offsetData = arg_29_0._runtimeData:GetOffsetConfig()
	arg_29_0._itemLayerMax = arg_29_0._runtimeData:GetChapterConfig("item_layer_max")

	for iter_29_7 = 1, #arg_29_0._boundsData do
		local var_29_9 = arg_29_0._boundsData[iter_29_7]

		for iter_29_8 = 1, #arg_29_0._boundsData[iter_29_7] do
			if var_29_9[iter_29_8] > 0 then
				arg_29_0._activeGridCount = arg_29_0._activeGridCount + 1 or arg_29_0._activeGridCount

				arg_29_0._grids[var_29_11]:SetType(var_29_9[iter_29_8])
			end
		end
	end

	for iter_29_9 = 1, #arg_29_0._offsetData do
		if arg_29_0._grids[iter_29_9] then
			arg_29_0._grids[iter_29_9]:SetOffset(arg_29_0._offsetData[iter_29_9])
		end
	end

	for iter_29_10 = 1, SortGameConst.grid_max_layer do
		for iter_29_11 = 1, #arg_29_0._grids do
			arg_29_0:InPutGrid(arg_29_0._grids[iter_29_11], false)
		end
	end

	arg_29_0._wantedStepTime = nil
	arg_29_0._wantedItem = nil
	arg_29_0._wantedRefreshTime = nil
	arg_29_0._checkLockTime = 0

	return
end

function var_0_0.Step(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0._gameTime = arg_30_2

	if arg_30_0._comboTime and arg_30_0._comboTime >= 0 then
		arg_30_0._comboTime = arg_30_0._comboTime - arg_30_1

		if arg_30_0._comboTime <= 0 then
			arg_30_0._comboIndex = nil
			arg_30_0._comboTime = nil
		end
	end

	arg_30_0._waitTime = arg_30_0._waitTime + arg_30_1

	if arg_30_0._waitTime >= SortGameConst.wait_speak_time then
		arg_30_0._waitTime = 0

		arg_30_0._event:emit(SortGameView.PLAYER_SPEAK, arg_30_0._runtimeData:GetSpeakData(SortGameConst.sort_conifg_type_wait))
	end

	if not arg_30_0._wantedStepTime then
		arg_30_0._wantedRefreshTime = arg_30_0._wantedRefreshTime or SortGameConst.wanted_refresh_time

		if arg_30_0._wantedRefreshTime >= 0 then
			arg_30_0._wantedRefreshTime = arg_30_0._wantedRefreshTime - arg_30_1

			if arg_30_0._wantedRefreshTime <= 0 then
				if math.random() < SortGameConst.wanted_rate then
					arg_30_0._wantedItem = arg_30_0._runtimeData:GetRandomWantedItem(arg_30_0:GetAllBottomIds())

					if arg_30_0._wantedItem then
						arg_30_0._event:emit(SortGameView.WANTED_ITEM_REFRESH, {
							item_id = arg_30_0._wantedItem,
							player_prefab = SortGameConst.player_data[arg_30_0._runtimeData:GetPlayerIdByItem(arg_30_0._wantedItem)].prefab
						})

						arg_30_0._wantedStepTime = SortGameConst.wanted_step_time
					end
				end

				arg_30_0._wantedRefreshTime = nil
			end
		end
	elseif arg_30_0._wantedStepTime >= 0 then
		arg_30_0._wantedStepTime = arg_30_0._wantedStepTime - arg_30_1

		if arg_30_0._wantedStepTime <= 0 then
			arg_30_0._wantedItem = nil
			arg_30_0._wantedStepTime = nil

			arg_30_0._event:emit(SortGameView.WANTED_ITEM_REFRESH, {})
		end
	end

	if arg_30_0._wantedItem then
		if arg_30_0._wantedStepIndexCheck == nil then
			arg_30_0._wantedStepIndexCheck = 30
		end

		arg_30_0._wantedStepIndexCheck = arg_30_0._wantedStepIndexCheck - 1

		if arg_30_0._wantedStepIndexCheck <= 0 then
			arg_30_0._wantedStepIndexCheck = nil

			if not arg_30_0:checkIdExist(arg_30_0:GetAllBottomIds(), arg_30_0._wantedItem) then
				arg_30_0._wantedStepTime = 0
			end
		end
	end

	arg_30_0._checkLockTime = arg_30_0._checkLockTime + arg_30_1

	if arg_30_0._checkLockTime >= 1.3 then
		local var_30_0 = 0

		for iter_30_0 = 1, #arg_30_0._grids do
			var_30_0 = var_30_0 + arg_30_0._grids[iter_30_0]:GetInputEmptyCount()
		end

		local var_30_1 = arg_30_0:GetPassItemCount((arg_30_0:GetIdsDic(arg_30_0:GetAllBottomIds())))

		if var_30_0 == 0 or var_30_0 == 1 and var_30_1 == 0 or var_30_0 == 2 and var_30_1 == 0 then
			arg_30_0._contentAniamtor:SetTrigger("reset")
		end

		arg_30_0._checkLockTime = 0
	end

	return
end

function var_0_0.ResetGrid(arg_31_0)
	arg_31_0._dragGridIndex = nil
	arg_31_0._enterGridIndex = nil
	arg_31_0._dragGridItemIndex = nil
	arg_31_0._enterGridItemIndex = nil

	setActive(arg_31_0._dragGridTF, false)

	for iter_31_0 = 1, #arg_31_0._grids do
		arg_31_0._grids[iter_31_0]:ClearItems()
	end

	for iter_31_1 = #arg_31_0._itemIds, 1, -1 do
		table.insert(arg_31_0._itemIdsPool, arg_31_0._itemIds[iter_31_1])
	end

	arg_31_0:shuffleArray(arg_31_0._itemIdsPool)

	arg_31_0._itemIds = {}

	for iter_31_2 = 1, #arg_31_0._grids do
		for iter_31_3 = 1, SortGameConst.grid_max_layer do
			arg_31_0:checkGridInput(arg_31_0._grids[iter_31_2])
		end

		arg_31_0._grids[iter_31_2]:SetShowAniamtion()
	end

	arg_31_0._wantedItem = nil
	arg_31_0._wantedStepTime = nil

	arg_31_0._event:emit(SortGameView.WANTED_ITEM_REFRESH, {})

	return
end

function var_0_0.GetPassItemCount(arg_32_0, arg_32_1)
	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		if iter_32_1 >= 3 then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function var_0_0.GetAllBottomIds(arg_33_0)
	for iter_33_0 = 1, #arg_33_0._grids do
		for iter_33_1, iter_33_2 in ipairs((arg_33_0._grids[iter_33_0]:GetBottomIds())) do
			if iter_33_2 and iter_33_2 > 0 then
				table.insert({}, iter_33_2)
			end
		end
	end

	return {}
end

function var_0_0.GetIdsDic(arg_34_0, arg_34_1)
	for iter_34_0 = 1, #arg_34_1 do
		if arg_34_1[iter_34_0] and arg_34_1[iter_34_0] > 0 then
			if not ({})[arg_34_1[iter_34_0]] then
				({})[arg_34_1[iter_34_0]] = 1
			else
				({})[arg_34_1[iter_34_0]] = ({})[arg_34_1[iter_34_0]] + 1
			end
		end
	end

	return {}
end

function var_0_0.Stop(arg_35_0)
	for iter_35_0 = 1, #arg_35_0._grids do
		arg_35_0._grids[iter_35_0]:Stop()
	end

	return
end

function var_0_0.Resume(arg_36_0)
	for iter_36_0 = 1, #arg_36_0._grids do
		arg_36_0._grids[iter_36_0]:Resume()
	end

	return
end

function var_0_0.Dispose(arg_37_0)
	for iter_37_0 = 1, #arg_37_0._grids do
		arg_37_0._grids[iter_37_0]:Dispose()
	end

	return
end

function var_0_0.Clear(arg_38_0)
	arg_38_0._dragGridIndex = nil
	arg_38_0._enterGridIndex = nil
	arg_38_0._dragGridItemIndex = nil
	arg_38_0._enterGridItemIndex = nil

	for iter_38_0 = 1, #arg_38_0._grids do
		arg_38_0._grids[iter_38_0]:Clear()
	end

	return
end

return var_0_0
