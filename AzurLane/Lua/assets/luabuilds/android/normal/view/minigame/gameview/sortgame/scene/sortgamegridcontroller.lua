class = var_0_10000

local var_0_0 = var_0_10000("SortGameGridController")
local var_0_1 = 3
local var_0_2 = 4
local var_0_3 = 3

Vector2 = var_0_10004

local var_0_4 = var_0_10004(0, -25)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runtimeData = arg_1_3
	findTF = var_1_10004
	arg_1_0._gridTpl = var_1_10004(arg_1_0._tf, "grids/grid_tpl")
	setActive = var_4

	var_4(arg_1_0._gridTpl, false)

	findTF = var_4
	arg_1_0._dragGridTF = var_4(arg_1_0._tf, "drag_grid")
	setActive = var_4

	var_4(arg_1_0._dragGridTF, false)

	local var_1_0 = arg_1_0._tf
	local var_1_1 = var_4.GetComponent

	typeof = var_6
	Animator = var_1_10007
	arg_1_0._contentAniamtor = var_1_1(var_1_0, var_6(var_1_10007))

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_4.GetComponent

	typeof = var_6
	DftAniEvent = var_1_10007
	arg_1_0._contentDftEvent = var_1_3(var_1_2, var_6(var_1_10007))

	local var_1_4 = arg_1_0._contentDftEvent

	var_4.SetEndEvent(var_1_4, function()
		local var_2_0 = arg_1_0

		var_0.ResetGrid(var_2_0)

		return
	end)

	arg_1_0._grids = {}

	for iter_1_0 = 1, var_0_1 * var_0_2 do
		local var_1_5 = iter_1_0

		findTF = var_1_10009
		var_1_10009 = var_1_10009(arg_1_0._tf, "grids/grid_" .. var_1_5)
		setParent = var_10

		var_10(var_1_10009, arg_1_0._gridTpl.parent)

		setActive = var_10

		var_10(var_1_10009, true)

		SortGameGrid = var_10

		local var_1_6 = var_10.New(var_1_10009, arg_1_0._event, var_1_5)

		arg_1_0._grids[iter_1_0] = var_1_6

		local var_1_7 = arg_1_0._grids[iter_1_0]

		var_11.SetRemoveEventCallback(var_1_7, function(arg_3_0, arg_3_1)
			local var_3_0 = arg_1_0

			var_2.removeItemIds(var_3_0, arg_3_1)

			local var_3_1 = arg_1_0

			var_2.checkGameOver(var_3_1)

			return
		end)

		local var_1_8 = arg_1_0._grids[iter_1_0]

		var_11.SetMoveBottomCallback(var_1_8, function(arg_4_0)
			local var_4_0 = arg_1_0

			var_1.checkGridInput(var_4_0, arg_1_0._grids[arg_4_0])

			return
		end)

		local var_1_9 = arg_1_0._grids[iter_1_0]

		var_11.SetScoreCallback(var_1_9, function(arg_5_0, arg_5_1)
			if arg_1_0._comboIndex then
				arg_1_0._comboIndex = arg_1_0._comboIndex + 1
			else
				arg_1_0._comboIndex = 0
			end

			local var_5_0 = arg_1_0

			SortGameConst = var_2_10003
			var_5_0._comboTime = var_2_10003.combo_time
			arg_1_0._waitTime = 0

			local var_5_1 = arg_1_0._event
			local var_5_2 = var_2.emit

			SimpleMGEvent = var_2_10004

			local var_5_3 = var_2_10004.ADD_SCORE
			local var_5_4 = {}
			local var_5_5 = arg_1_0

			var_5_4.num = var_6.GetScore(var_5_5, arg_5_1)
			var_5_4.combo = arg_1_0._comboIndex

			local var_5_6 = arg_1_0._grids[arg_5_0]

			var_5_4.position = var_6.GetPosition(var_5_6)

			var_5_2(var_5_1, var_5_3, var_5_4)

			local var_5_7

			if arg_1_0._wantedItem and arg_1_0._wantedItem == arg_5_1 then
				var_5_7 = arg_1_0
				var_5_7._wantedItem = nil
				var_5_7 = arg_1_0
				var_5_7._wantedStepTime = nil
				var_5_1 = arg_1_0._event
				var_5_7 = var_5_7.emit
				SortGameView = var_5_3

				var_5_7(var_5_1, var_5_3.WANTED_ITEM_REFRESH, {})

				var_5_1 = arg_1_0._runtimeData
				var_5_7 = var_5_7.GetPlayerName

				local var_5_8 = arg_1_0._runtimeData

				var_5_7 = var_5_7(var_5_1, var_4.GetPlayerIdByItem(var_5_8, arg_5_1))

				local var_5_9 = arg_1_0._event

				var_5_1 = var_5_1.emit
				SortGameView = var_5_8

				local var_5_10 = var_5_8.PLAYER_SPEAK

				var_5_6 = arg_1_0._runtimeData

				local var_5_11 = var_6.GetSpeakData

				SortGameConst = var_8

				var_5_1(var_5_9, var_5_10, var_5_11(var_5_6, var_8.sort_conifg_type_chat, var_5_7))
			end

			table = var_5_7

			local var_5_12 = var_5_7.contains

			SortGameConst = var_5_1

			if var_5_12(var_5_1.combo_speak_num, arg_1_0._comboIndex) then
				local var_5_13 = arg_1_0._event
				local var_5_14 = var_2.emit

				SortGameView = var_4

				local var_5_15 = var_4.PLAYER_SPEAK
				local var_5_16 = arg_1_0._runtimeData
				local var_5_17 = var_5.GetSpeakData

				SortGameConst = var_5_6

				var_5_14(var_5_13, var_5_15, var_5_17(var_5_16, var_5_6.sort_conifg_type_combo))
			end

			return
		end)
		var_1_6:AddItemEventCallback(function(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = arg_1_0

			var_3.onGridDrag(var_6_0, arg_6_0, arg_6_1, arg_6_2)

			return
		end, function(arg_7_0, arg_7_1, arg_7_2)
			local var_7_0 = arg_1_0

			var_3.onGridDragEnd(var_7_0, arg_7_0, arg_7_1, arg_7_2)

			return
		end, function(arg_8_0, arg_8_1, arg_8_2)
			local var_8_0 = arg_1_0

			var_3.onGridEnter(var_8_0, arg_8_0, arg_8_1, arg_8_2)

			return
		end, function(arg_9_0, arg_9_1, arg_9_2)
			local var_9_0 = arg_1_0

			var_3.onGridExit(var_9_0, arg_9_0, arg_9_1, arg_9_2)

			return
		end)
	end

	GameObject = var_4

	local var_1_10 = var_4.Find("UICamera")
	local var_1_11 = var_4.GetComponent

	typeof = var_6
	Camera = iter_1_0
	arg_1_0._uiCamera = var_1_11(var_1_10, var_6(iter_1_0))

	return
end

function var_0_0.checkGameOver(arg_10_0)
	if #arg_10_0._itemIds == 0 and #arg_10_0._itemIdsPool == 0 then
		local var_10_0 = arg_10_0._event
		local var_10_1 = var_1.emit

		SortGameView = var_1_10003

		var_10_1(var_10_0, var_1_10003.GAME_OVER_TIME)
	end

	return
end

function var_0_0.removeItemIds(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0._itemIds do
		if arg_11_0._itemIds[iter_11_0] == arg_11_1 then
			print = var_6

			var_6("item_id = " .. arg_11_1 .. " 被消除了")

			table = var_6

			var_6.remove(arg_11_0._itemIds, iter_11_0)

			return
		end
	end

	warning = var_2

	var_2("没有在格子中找到这个id = " .. arg_11_1)

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

		local var_12_0 = arg_12_0._tf
		local var_12_1 = var_5.InverseTransformPoint
		local var_12_2 = arg_12_0._uiCamera

		arg_12_0._dragGridStartPos = var_12_1(var_12_0, var_7.ScreenToWorldPoint(var_12_2, arg_12_0._startDragPos))
		setActive = var_5

		var_5(arg_12_0._dragGridTF, true)

		arg_12_0._dragGridIndex = arg_12_1
		arg_12_0._dragGridItemIndex = arg_12_2

		local var_12_3 = var_4:GetItemBottomId(arg_12_2)
		local var_12_4 = var_4

		var_4.SetItemAlpha(var_12_4, arg_12_2, true)

		if var_12_3 and 0 < var_12_3 then
			GetSpriteFromAtlasAsync = var_6
			SortGameConst = var_12_4

			var_6(var_12_4.ui_atlas, "item_" .. var_12_3, function(arg_13_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_12_0._dragGridTF, arg_13_0, true)

				return
			end)
		end

		arg_12_0._dragScreenRate = arg_12_0:GetScreentScaleRate()
	end

	local var_12_5 = arg_12_0._dragGridStartPos.x + (var_0_4.x + (arg_12_3.position.x - arg_12_0._startDragPos.x)) * arg_12_0._dragScreenRate.x
	local var_12_6 = arg_12_0._dragGridStartPos.y + (var_0_4.y + (arg_12_3.position.y - arg_12_0._startDragPos.y)) * arg_12_0._dragScreenRate.y
	local var_12_7 = arg_12_0._dragGridTF

	Vector2 = var_8
	var_12_7.anchoredPosition = var_8(var_12_5, var_12_6)

	return
end

function var_0_0.Start(arg_14_0)
	return
end

function var_0_0.onGridDragEnd(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_0._dragGridIndex then
		return
	end

	setActive = var_4

	var_4(arg_15_0._dragGridTF, false)

	local var_15_0 = false

	if arg_15_0._dragGridIndex and arg_15_0._enterGridIndex then
		if arg_15_0._dragGridIndex == arg_15_0._enterGridIndex and arg_15_0._dragGridItemIndex ~= arg_15_0._enterGridItemIndex then
			var_15_0 = true
		elseif arg_15_0._dragGridIndex ~= arg_15_0._enterGridIndex then
			var_15_0 = true
		end
	end

	local var_15_1 = arg_15_0._grids[arg_15_1]

	var_5.SetItemAlpha(var_15_1, arg_15_2, false)

	if var_15_0 then
		local var_15_2 = arg_15_0._grids[arg_15_0._dragGridIndex]
		local var_15_3 = arg_15_0._grids[arg_15_0._enterGridIndex]
		local var_15_4 = var_15_2:GetItemBottomId(arg_15_0._dragGridItemIndex)
		local var_15_5 = var_15_3:GetItemBottomId(arg_15_0._enterGridItemIndex)

		var_15_2:InSertItem(arg_15_0._dragGridItemIndex, var_15_5)
		var_15_3:InSertItem(arg_15_0._enterGridItemIndex, var_15_4)
		var_15_2:CheckMoveBottom()
		var_15_3:CheckMoveBottom()
	end

	if arg_15_0._enterGridIndex and arg_15_0._grids[arg_15_0._enterGridIndex] then
		local var_15_6 = arg_15_0._grids[arg_15_0._enterGridIndex]

		var_6.SetItemSelect(var_15_6, arg_15_0._enterGridItemIndex, false)
	end

	if arg_15_0._dragGridIndex and arg_15_0._grids[arg_15_0._dragGridIndex] then
		local var_15_7 = arg_15_0._grids[arg_15_0._dragGridIndex]
		local var_15_8 = var_6.GetType(var_15_7)

		SortGameConst = var_15_7

		if var_15_8 == var_15_7.grid_type_out then
			local var_15_9 = arg_15_0._grids[arg_15_0._dragGridIndex]

			if var_7.GetInputEmptyLayer(var_15_9) == 1 then
				local var_15_10 = arg_15_0._grids[arg_15_0._dragGridIndex]

				var_8.SetItemLock(var_15_10, 2, true)
			end
		end
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
		local var_16_0 = arg_16_0._grids[arg_16_0._enterGridIndex]

		var_4.SetItemSelect(var_16_0, arg_16_0._enterGridItemIndex, false)
	end

	arg_16_0._enterGridIndex = arg_16_1
	arg_16_0._enterGridItemIndex = arg_16_2

	if arg_16_1 and arg_16_0._grids[arg_16_1] then
		local var_16_1 = arg_16_0._grids[arg_16_0._enterGridIndex]

		var_4.SetItemSelect(var_16_1, arg_16_2, true)
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
			local var_17_0 = arg_17_0._grids[arg_17_0._enterGridIndex]

			var_4.SetItemSelect(var_17_0, arg_17_0._enterGridItemIndex, false)
		end

		arg_17_0._enterGridIndex = nil
		arg_17_0._enterGridItemIndex = nil
	end

	return
end

function var_0_0.checkGridInput(arg_18_0, arg_18_1)
	if arg_18_1:GetInputLayerCount() < arg_18_0._itemLayerMax then
		local var_18_0 = arg_18_1
		local var_18_1 = arg_18_1.GetInputEmptyLayer(var_18_0)

		SortGameConst = var_18_0

		if var_18_1 <= var_18_0.grid_max_layer then
			arg_18_0:InPutGrid(arg_18_1, true)

			arg_18_0._checkLockTime = 0

			return true
		end
	end

	return false
end

function var_0_0.GetItemIdList(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = {}

	Clone = var_1_10005

	local var_19_1 = var_1_10005(arg_19_1)
	local var_19_2 = 1

	for iter_19_0 = 1, arg_19_2 do
		for iter_19_1 = 1, var_0_3 * arg_19_3 do
			table = var_1_10015

			var_1_10015.insert(var_19_0, var_19_1[var_19_2])
		end

		var_19_2 = var_19_2 + 1 > #var_19_1 and 1 or var_19_2 + 1
	end

	return var_19_0
end

function var_0_0.ShuffleList(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		math = var_1_10003

		if not var_1_10003.min(arg_20_2, #arg_20_1) then
			local var_20_0 = #arg_20_1
		end

		randomRange = randomRange

		for iter_20_0 = var_3, 2, -1 do
			math = var_1_10007
			arg_20_1[iter_20_0], arg_20_1[var_1_10007] = arg_20_1[var_1_10007.random(1, iter_20_0)], arg_20_1[iter_20_0]
		end

		return
	end
end

function var_0_0.InPutGrid(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = 0

	if arg_21_1:GetType() > 0 then
		local var_21_1 = {}
		local var_21_2 = arg_21_0:GetGridIdMap(arg_21_1, arg_21_0._normalItemWeight)
		local var_21_3

		if arg_21_2 then
			var_21_3 = arg_21_0:GetIdsDic(arg_21_0._itemIds)
		end

		for iter_21_0 = 1, #var_21_2 do
			local var_21_4

			if var_21_2[iter_21_0] ~= 0 and #arg_21_0._itemIdsPool > 0 then
				var_21_4 = nil

				if iter_21_0 == 3 and var_21_1[1] == var_21_1[2] and var_21_1[1] ~= 0 then
					print = var_12

					var_12("当前第三个格子需要优先匹配前两个格子的id，id = " .. var_21_1[1])

					var_21_4 = var_21_1[1]
				end

				local var_21_5 = arg_21_0
				local var_21_6 = arg_21_0.GetIdFromPool(var_21_5, var_21_3, var_21_4)

				var_21_0 = var_21_0 + 1
				table = var_21_5

				var_21_5.insert(var_21_1, var_21_6)
			else
				table = var_21_4

				var_21_4.insert(var_21_1, 0)
			end
		end

		print = var_7

		local var_21_7 = "插入id列表 = "

		table = var_9

		var_7(var_21_7 .. var_9.concat(var_21_1, ","))
		arg_21_1:InputIds(var_21_1)
	end

	return var_21_0
end

function var_0_0.GetIdFromPool(arg_22_0, arg_22_1, arg_22_2)
	local var_22_1

	if arg_22_0._itemIdsPool and #arg_22_0._itemIdsPool > 0 then
		if arg_22_1 then
			local var_22_0 = arg_22_0

			var_22_1 = arg_22_0.GetPassItemCount(var_22_0, arg_22_1)
			SortGameConst = var_22_0

			local var_22_2

			if var_22_1 <= var_22_0.pass_limit_num then
				var_22_2 = nil

				local var_22_3 = 0

				pairs = var_1_10006

				for iter_22_0, iter_22_1 in var_1_10006(arg_22_1) do
					if var_22_3 < iter_22_1 and arg_22_0:checkIdExist(arg_22_0._itemIdsPool, iter_22_0) and iter_22_0 ~= arg_22_2 then
						var_22_3 = iter_22_1
						var_22_2 = iter_22_0
					end
				end

				if var_22_2 then
					for iter_22_2 = 1, #arg_22_0._itemIdsPool do
						if arg_22_0._itemIdsPool[iter_22_2] == var_22_2 then
							table = var_10

							local var_22_4 = var_10.remove(arg_22_0._itemIdsPool, iter_22_2)

							table = var_11

							var_11.insert(arg_22_0._itemIds, var_22_4)

							arg_22_1[var_22_2] = arg_22_1[var_22_2] + 1
							print = var_11

							var_11("匹配成功，匹配id = " .. var_22_2)

							return var_22_2
						end
					end
				end
			else
				print = var_22_2

				var_22_2("本次从池子中取不到元素， 长度 = " .. #arg_22_0._itemIdsPool)
			end
		end

		table = var_22_1
		var_22_1 = var_22_1.remove(arg_22_0._itemIdsPool, 1)
		table = var_4

		var_4.insert(arg_22_0._itemIds, var_22_1)

		return var_22_1
	end

	warning = var_22_1

	var_22_1("id池已经没有id了")

	return 0
end

function var_0_0.checkIdExist(arg_23_0, arg_23_1, arg_23_2)
	table = var_1_10003

	return var_1_10003.contains(arg_23_1, arg_23_2)
end

function var_0_0.GetScreentScaleRate(arg_24_0)
	UnityEngine = var_1_10001

	local var_24_0 = var_1_10001.Screen.width

	UnityEngine = var_1_10002

	local var_24_1 = var_1_10002.Screen.height

	tf = var_1_10003
	GameObject = var_1_10004

	local var_24_2 = var_1_10003(var_1_10004.Find("UICamera/Canvas")).sizeDelta.x
	local var_24_3 = var_3.sizeDelta.y

	Vector2 = var_1_10006

	return var_1_10006(var_24_2 / var_24_0, var_24_3 / var_24_1)
end

function var_0_0.GetGridIdMap(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {
		0,
		0,
		0
	}
	local var_25_1 = arg_25_1
	local var_25_2 = arg_25_1.GetType(var_25_1)

	SortGameConst = var_25_1

	if var_25_2 == var_25_1.grid_type_empty then
		var_25_0 = {
			0,
			0,
			0
		}
	else
		SortGameConst = var_5

		local var_25_3

		if var_25_2 == var_5.grid_type_normal then
			math = var_25_3
			var_25_3 = var_25_3.random()

			local var_25_4 = 1

			for iter_25_0 = 1, #arg_25_2 do
				if iter_25_0 == 1 then
					if var_25_3 <= arg_25_2[iter_25_0] then
						var_25_4 = iter_25_0
					end
				elseif var_25_3 > arg_25_2[iter_25_0 - 1] and var_25_3 <= arg_25_2[iter_25_0] then
					var_25_4 = iter_25_0

					break
				end
			end

			if var_25_4 == 1 then
				var_25_0 = {
					1,
					0,
					0
				}
			elseif var_25_4 == 2 then
				var_25_0 = {
					1,
					1,
					0
				}
			else
				var_25_0 = {
					1,
					1,
					1
				}
			end

			arg_25_0:shuffleArray(var_25_0)
		else
			SortGameConst = var_25_3

			if var_25_2 == var_25_3.grid_type_two then
				var_25_0 = {
					1,
					1,
					0
				}

				arg_25_0:shuffleArray(var_25_0)
			else
				SortGameConst = var_5

				if var_25_2 == var_5.grid_type_out then
					var_25_0 = {
						0,
						1,
						0
					}
				end
			end
		end
	end

	return var_25_0
end

function var_0_0.shuffleArray(arg_26_0, arg_26_1)
	for iter_26_0 = #arg_26_1, 2, -1 do
		math = var_1_10006
		arg_26_1[iter_26_0], arg_26_1[var_1_10006] = arg_26_1[var_1_10006.random(1, iter_26_0)], arg_26_1[iter_26_0]
	end

	return
end

function var_0_0.CalculateWeight(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = 0

	for iter_27_0 = 1, #arg_27_1 do
		var_27_1 = var_27_1 + arg_27_1[iter_27_0]
	end

	local var_27_2 = 0

	for iter_27_1 = 1, #arg_27_1 do
		var_27_2 = var_27_2 + arg_27_1[iter_27_1]
		table = var_9

		var_9.insert(var_27_0, var_27_2 / var_27_1)
	end

	return var_27_0
end

function var_0_0.GetScore(arg_28_0, arg_28_1)
	if arg_28_0._wantedItem and arg_28_1 == arg_28_0._wantedItem then
		SortGameConst = var_28_0

		local var_28_0

		if not var_28_0.wanted_score_num then
			SortGameConst = var_28_0
			var_28_0 = var_28_0.score_num
		end

		if not arg_28_0._comboIndex or arg_28_0._comboIndex == 0 then
			return var_28_0
		else
			local var_28_1 = 1

			SortGameConst = var_1_10004

			for iter_28_0 = var_28_1, #var_1_10004.combo_rate do
				SortGameConst = var_1_10007
				var_1_10007 = var_1_10007.combo_rate[iter_28_0]

				if arg_28_0._comboIndex >= var_1_10007.range[1] and arg_28_0._comboIndex <= var_1_10007.range[2] then
					math = var_8

					return var_8.floor(var_28_0 * var_1_10007.rate)
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

	local var_29_0 = arg_29_0._runtimeData
	local var_29_1 = var_1.GetComonItems(var_29_0)
	local var_29_2 = arg_29_0._runtimeData
	local var_29_3 = var_2.GetPlayers(var_29_2)
	local var_29_4 = arg_29_0._runtimeData
	local var_29_5 = var_3.GetChapterConfig(var_29_4, "item_count")
	local var_29_6 = arg_29_0._runtimeData
	local var_29_7

	if not var_4.GetChapterConfig(var_29_6, "player_own_item_count") then
		var_29_7 = 1
	end

	local var_29_8 = arg_29_0._runtimeData
	local var_29_9 = var_5.GetChapterConfig(var_29_8, "item_rate")
	local var_29_10 = arg_29_0._runtimeData
	local var_29_11 = var_6.GetChapterConfig(var_29_10, "grid_weight")

	arg_29_0._normalItemWeight = arg_29_0:CalculateWeight(var_29_11)

	local var_29_12 = arg_29_0:GetItemIdList(var_29_1, var_29_5, var_29_9)
	local var_29_13 = {}

	for iter_29_0 = 1, #var_29_3 do
		var_1_10014 = arg_29_0._runtimeData

		local var_29_14 = var_13.GetPlayerItems(var_1_10014, var_29_3[iter_29_0])

		for iter_29_1 = 1, #var_29_14 do
			table = var_1_10018

			var_1_10018.insert(var_29_13, var_29_14[iter_29_1])
		end
	end

	local var_29_15 = arg_29_0:GetItemIdList(var_29_13, var_29_7, 1)

	arg_29_0._itemIdsPool = {}

	for iter_29_2 = 1, #var_29_12 do
		table = var_1_10014

		var_1_10014.insert(arg_29_0._itemIdsPool, var_29_12[iter_29_2])
	end

	for iter_29_3 = 1, #var_29_15 do
		table = var_1_10014

		var_1_10014.insert(arg_29_0._itemIdsPool, var_29_15[iter_29_3])
	end

	arg_29_0._itemIds = {}

	local var_29_16 = {}
	local var_29_17 = 1

	SortGameConst = var_12

	for iter_29_4 = var_29_17, var_12.init_pass_num do
		var_1_10015 = arg_29_0._itemIdsPool
		math = var_1_10016
		var_1_10015 = var_1_10015[var_1_10016.random(1, #arg_29_0._itemIdsPool)]
		var_1_10016 = 0

		for iter_29_5 = #arg_29_0._itemIdsPool, 1, -1 do
			if arg_29_0._itemIdsPool[iter_29_5] == var_1_10015 then
				table = var_21

				local var_29_18 = var_21.insert
				local var_29_19 = var_29_16

				table = var_1_10023

				var_29_18(var_29_19, var_1_10023.remove(arg_29_0._itemIdsPool, iter_29_5))

				if var_1_10016 + 1 == 3 then
					break
				end
			end
		end
	end

	arg_29_0:ShuffleList(arg_29_0._itemIdsPool)

	if #var_29_16 > 0 then
		for iter_29_6 = 1, #var_29_16 do
			table = var_1_10015

			var_1_10015.insert(arg_29_0._itemIdsPool, 1, var_29_16[iter_29_6])
		end

		local var_29_20 = {}
	end

	arg_29_0:ShuffleList(arg_29_0._itemIdsPool, 18)

	arg_29_0._activeGridCount = 0

	local var_29_21 = arg_29_0._runtimeData

	arg_29_0._boundsData = var_11.GetBoundConfig(var_29_21)

	local var_29_22 = arg_29_0._runtimeData

	arg_29_0._offsetData = var_11.GetOffsetConfig(var_29_22)

	local var_29_23 = arg_29_0._runtimeData

	arg_29_0._itemLayerMax = var_11.GetChapterConfig(var_29_23, "item_layer_max")

	for iter_29_7 = 1, #arg_29_0._boundsData do
		local var_29_24 = iter_29_7
		local var_29_25 = arg_29_0._boundsData[iter_29_7]

		for iter_29_8 = 1, #var_29_25 do
			local var_29_26 = iter_29_8
			local var_29_27 = (var_29_24 - 1) * var_0_2 + iter_29_8
			local var_29_28

			if not (var_29_25[iter_29_8] > 0) or not (arg_29_0._activeGridCount + 1) then
				var_29_28 = arg_29_0._activeGridCount
			end

			arg_29_0._activeGridCount = var_29_28

			local var_29_29 = arg_29_0._grids[var_29_27]

			var_23.SetType(var_29_29, var_29_25[iter_29_8])
		end
	end

	for iter_29_9 = 1, #arg_29_0._offsetData do
		local var_29_30 = arg_29_0._offsetData[iter_29_9]

		if arg_29_0._grids[iter_29_9] then
			var_16:SetOffset(var_29_30)
		end
	end

	local var_29_31 = 1

	SortGameConst = var_12

	for iter_29_10 = var_29_31, var_12.grid_max_layer do
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

	if arg_30_0._comboTime then
		local var_30_0 = arg_30_0._comboTime

		if 0 <= var_30_0 then
			arg_30_0._comboTime = arg_30_0._comboTime - arg_30_1

			if arg_30_0._comboTime <= 0 then
				arg_30_0._comboIndex = nil
				arg_30_0._comboTime = nil
			end
		end
	end

	arg_30_0._waitTime = arg_30_0._waitTime + arg_30_1

	local var_30_1 = arg_30_0._waitTime

	SortGameConst = var_1_10004

	if var_30_1 >= var_1_10004.wait_speak_time then
		arg_30_0._waitTime = 0

		local var_30_2 = arg_30_0._event
		local var_30_3 = var_3.emit

		SortGameView = var_1_10005
		var_1_10005 = var_1_10005.PLAYER_SPEAK

		local var_30_4 = arg_30_0._runtimeData
		local var_30_5 = var_6.GetSpeakData

		SortGameConst = var_1_10008

		var_30_3(var_30_2, var_1_10005, var_30_5(var_30_4, var_1_10008.sort_conifg_type_wait))
	end

	if not arg_30_0._wantedStepTime then
		if not arg_30_0._wantedRefreshTime then
			SortGameConst = var_3
			arg_30_0._wantedRefreshTime = var_3.wanted_refresh_time
		end

		if arg_30_0._wantedRefreshTime >= 0 then
			arg_30_0._wantedRefreshTime = arg_30_0._wantedRefreshTime - arg_30_1

			if arg_30_0._wantedRefreshTime <= 0 then
				math = var_3

				local var_30_6 = var_3.random()

				SortGameConst = var_4

				if var_30_6 < var_4.wanted_rate then
					local var_30_7 = arg_30_0._runtimeData
					local var_30_8 = var_3.GetRandomWantedItem
					local var_30_9 = arg_30_0

					arg_30_0._wantedItem = var_30_8(var_30_7, arg_30_0.GetAllBottomIds(var_30_9))

					if arg_30_0._wantedItem then
						local var_30_10 = arg_30_0._runtimeData
						local var_30_11 = var_3.GetPlayerIdByItem(var_30_10, arg_30_0._wantedItem)

						var_1_10005 = arg_30_0._event

						local var_30_12 = var_4.emit

						SortGameView = var_30_9

						local var_30_13 = var_30_9.WANTED_ITEM_REFRESH
						local var_30_14 = {
							item_id = arg_30_0._wantedItem
						}

						SortGameConst = var_8
						var_30_14.player_prefab = var_8.player_data[var_30_11].prefab

						var_30_12(var_1_10005, var_30_13, var_30_14)

						SortGameConst = var_30_12
						arg_30_0._wantedStepTime = var_30_12.wanted_step_time
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

			local var_30_15 = arg_30_0._event
			local var_30_16 = var_3.emit

			SortGameView = var_1_10005

			var_30_16(var_30_15, var_1_10005.WANTED_ITEM_REFRESH, {})
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
		local var_30_17 = 0

		for iter_30_0 = 1, #arg_30_0._grids do
			local var_30_18 = arg_30_0._grids[iter_30_0]

			var_30_17 = var_30_17 + var_8.GetInputEmptyCount(var_30_18)
		end

		local var_30_19 = arg_30_0:GetIdsDic(arg_30_0:GetAllBottomIds())
		local var_30_20 = arg_30_0:GetPassItemCount(var_30_19)

		if var_30_17 == 0 or var_30_17 == 1 and var_30_20 == 0 or var_30_17 == 2 and var_30_20 == 0 then
			local var_30_21 = arg_30_0._contentAniamtor

			var_6.SetTrigger(var_30_21, "reset")
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
	setActive = var_1

	var_1(arg_31_0._dragGridTF, false)

	for iter_31_0 = 1, #arg_31_0._grids do
		local var_31_0 = arg_31_0._grids[iter_31_0]

		var_1_10005.ClearItems(var_31_0)
	end

	for iter_31_1 = #arg_31_0._itemIds, 1, -1 do
		table = var_1_10005

		var_1_10005.insert(arg_31_0._itemIdsPool, arg_31_0._itemIds[iter_31_1])
	end

	arg_31_0:shuffleArray(arg_31_0._itemIdsPool)

	arg_31_0._itemIds = {}

	for iter_31_2 = 1, #arg_31_0._grids do
		local var_31_1 = 1

		SortGameConst = var_1_10006

		for iter_31_3 = var_31_1, var_1_10006.grid_max_layer do
			arg_31_0:checkGridInput(arg_31_0._grids[iter_31_2])
		end

		var_1_10006 = arg_31_0._grids[iter_31_2]

		var_5.SetShowAniamtion(var_1_10006)
	end

	arg_31_0._wantedItem = nil
	arg_31_0._wantedStepTime = nil

	local var_31_2 = arg_31_0._event
	local var_31_3 = var_1.emit

	SortGameView = var_3

	var_31_3(var_31_2, var_3.WANTED_ITEM_REFRESH, {})

	return
end

function var_0_0.GetPassItemCount(arg_32_0, arg_32_1)
	local var_32_0 = 0

	pairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_1) do
		if iter_32_1 >= 3 then
			var_32_0 = var_32_0 + 1
		end
	end

	return var_32_0
end

function var_0_0.GetAllBottomIds(arg_33_0)
	local var_33_0 = {}

	for iter_33_0 = 1, #arg_33_0._grids do
		local var_33_1 = arg_33_0._grids[iter_33_0]
		local var_33_2 = var_6.GetBottomIds(var_33_1)

		ipairs = var_33_1

		for iter_33_1, iter_33_2 in var_33_1(var_33_2) do
			if iter_33_2 and 0 < iter_33_2 then
				table = var_13

				var_13.insert(var_33_0, iter_33_2)
			end
		end
	end

	return var_33_0
end

function var_0_0.GetIdsDic(arg_34_0, arg_34_1)
	local var_34_0 = {}

	for iter_34_0 = 1, #arg_34_1 do
		if arg_34_1[iter_34_0] and var_7 > 0 then
			if not var_34_0[var_7] then
				var_34_0[var_7] = 1
			else
				var_34_0[var_7] = var_34_0[var_7] + 1
			end
		end
	end

	return var_34_0
end

function var_0_0.Stop(arg_35_0)
	for iter_35_0 = 1, #arg_35_0._grids do
		local var_35_0 = arg_35_0._grids[iter_35_0]

		var_5.Stop(var_35_0)
	end

	return
end

function var_0_0.Resume(arg_36_0)
	for iter_36_0 = 1, #arg_36_0._grids do
		local var_36_0 = arg_36_0._grids[iter_36_0]

		var_5.Resume(var_36_0)
	end

	return
end

function var_0_0.Dispose(arg_37_0)
	for iter_37_0 = 1, #arg_37_0._grids do
		local var_37_0 = arg_37_0._grids[iter_37_0]

		var_5.Dispose(var_37_0)
	end

	return
end

function var_0_0.Clear(arg_38_0)
	arg_38_0._dragGridIndex = nil
	arg_38_0._enterGridIndex = nil
	arg_38_0._dragGridItemIndex = nil
	arg_38_0._enterGridItemIndex = nil

	for iter_38_0 = 1, #arg_38_0._grids do
		local var_38_0 = arg_38_0._grids[iter_38_0]

		var_5.Clear(var_38_0)
	end

	return
end

return var_0_0
