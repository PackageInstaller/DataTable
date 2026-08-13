class = var_0_10000

local var_0_0 = var_0_10000("PacGameItemController")
local var_0_1 = 5
local var_0_2 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3
	findTF = var_1_10004
	arg_1_0._content = var_1_10004(arg_1_0._sceneMask, "sceneContainer/scene/content/map")

	return
end

function var_0_0.Prepare(arg_2_0)
	local var_2_0 = arg_2_0._runningData

	arg_2_0._itemConfig = var_1.GetMapConfig(var_2_0, "item")

	local var_2_1 = arg_2_0._runningData

	arg_2_0._gridDic = var_1.GetGridDic(var_2_1)

	local var_2_2 = arg_2_0._runningData

	arg_2_0._mapTFDic = var_1.GetMapTFDic(var_2_2)

	local var_2_3 = arg_2_0._runningData

	arg_2_0._player = var_1.GetPlayer(var_2_3)

	return
end

function var_0_0.Start(arg_3_0)
	PacGameConst = var_1_10001
	arg_3_0._createItemTime = var_1_10001.item_time
	arg_3_0._items = {}

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0._deltaTime = arg_4_1

	local var_4_0 = arg_4_0._runningData

	if var_2.GetEditor(var_4_0) then
		return
	end

	if arg_4_0._createItemTime and arg_4_0._createItemTime > 0 then
		arg_4_0._createItemTime = arg_4_0._createItemTime - arg_4_1

		if arg_4_0._createItemTime <= 0 then
			arg_4_0:tryCreateItem()

			PacGameConst = var_2
			arg_4_0._createItemTime = var_2.item_time
		end
	end

	local var_4_1 = arg_4_0._player
	local var_4_2 = var_2.GetGridIndex(var_4_1)

	for iter_4_0 = #arg_4_0._items, 1, -1 do
		local var_4_3 = arg_4_0._items[iter_4_0]
		local var_4_4 = var_7.GetIndex(var_4_3)
		local var_4_5 = var_7:GetConfig("effect")
		local var_4_6 = var_7:GetConfig("effect_time")

		if var_4_4 == var_4_2 then
			arg_4_0:SetItemEffect(var_4_5, var_4_6)
			var_7:Dispose()

			table = var_11

			var_11.remove(arg_4_0._items, iter_4_0)
		end
	end

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0._player = nil

	for iter_5_0 = #arg_5_0._items, 1, -1 do
		local var_5_0 = arg_5_0._items[iter_5_0]

		var_5.Dispose(var_5_0)
	end

	arg_5_0._items = {}

	return
end

function var_0_0.Stop(arg_6_0)
	return
end

function var_0_0.Resume(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	return
end

function var_0_0.SetItemEffect(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._player then
		return
	end

	if arg_9_1 == var_0_2 then
		local var_9_0 = arg_9_0._player

		var_3.SetRush(var_9_0, true, arg_9_2)
	end

	return
end

function var_0_0.tryCreateItem(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = arg_10_0._player
	local var_10_2 = var_2.GetGridIndex(var_10_1)

	pairs = var_10_1

	for iter_10_0, iter_10_1 in var_10_1(arg_10_0._gridDic) do
		if iter_10_1:GetPassAble() and not iter_10_1:GetScoreFlag() and iter_10_1:GetIndex() ~= var_10_2 then
			table = var_8

			local var_10_3 = var_8.insert
			local var_10_4 = var_10_0

			var_1_10011 = iter_10_1

			var_10_3(var_10_4, iter_10_1.GetIndex(var_1_10011))
		end
	end

	local var_10_5 = #arg_10_0._items

	PacGameConst = var_4

	if var_10_5 <= var_4.max_item_count then
		local var_10_6 = #var_10_0

		if 10 <= var_10_6 then
			math = var_10_6

			local var_10_7 = var_10_6.random()

			PacGameConst = var_4

			if var_10_7 <= var_4.item_rate then
				math = var_10_7

				local var_10_8 = var_10_0[var_10_7.random(1, #var_10_0)]
				local var_10_9 = arg_10_0._gridDic[var_10_8]
				local var_10_10 = var_4.GetIndex(var_10_9)
				local var_10_11 = var_4:GetPosition()
				local var_10_12, var_10_13 = var_4:GetVH()
				local var_10_14 = arg_10_0._mapTFDic[var_10_12]
				local var_10_15 = arg_10_0._itemConfig

				math = var_1_10011

				local var_10_16 = var_10_15[var_1_10011.random(1, #arg_10_0._itemConfig)]
				local var_10_17 = arg_10_0:createItem(var_10_16, var_10_10, var_10_14)

				var_11.SetPosition(var_10_17, var_10_11)

				table = var_12

				var_12.insert(arg_10_0._items, var_11)
			end
		end
	end

	return
end

function var_0_0.createItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	PacGameConst = var_1_10004

	local var_11_0 = var_1_10004.item_data[arg_11_1].prefab
	local var_11_1 = arg_11_0._runningData
	local var_11_2 = var_6.GetTplItemFromPool(var_11_1, var_11_0, arg_11_3)

	PacGameItem = var_11_1

	return (var_11_1.New(var_11_2, arg_11_2, var_4))
end

return var_0_0
