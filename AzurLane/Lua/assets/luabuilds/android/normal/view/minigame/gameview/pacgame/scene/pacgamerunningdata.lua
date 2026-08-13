class = var_0_10000

local var_0_0 = var_0_10000("PacGameRunningData")

function var_0_0.Ctor(arg_1_0)
	arg_1_0._tpl = nil
	arg_1_0._tplItemPool = {}
	arg_1_0._roles = {}

	return
end

function var_0_0.SetChapterData(arg_2_0, arg_2_1)
	arg_2_0._chapterData = arg_2_1

	return
end

function var_0_0.GetConfig(arg_3_0, arg_3_1)
	return arg_3_0._chapterData[arg_3_1]
end

function var_0_0.GetMapConfig(arg_4_0, arg_4_1)
	return arg_4_0._mapData[arg_4_1]
end

function var_0_0.GetMapData(arg_5_0)
	if not arg_5_0._mapData and arg_5_0._chapterData then
		PacGameConst = var_1
		arg_5_0._mapData = var_1.map_data[arg_5_0._chapterData.map]
	end

	return arg_5_0._mapData
end

function var_0_0.GetGridRect(arg_6_0)
	return arg_6_0._mapData.grid_width, arg_6_0._mapData.grid_height
end

function var_0_0.GetGridWH(arg_7_0)
	return arg_7_0._mapData.vertical, arg_7_0._mapData.horizontal
end

function var_0_0.SetEditor(arg_8_0, arg_8_1)
	arg_8_0._editorFlag = arg_8_1

	return
end

function var_0_0.GetEditor(arg_9_0)
	return arg_9_0._editorFlag
end

function var_0_0.SetGrids(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._grids = arg_10_1
	arg_10_0._gridDic = {}
	arg_10_0._gridDic = arg_10_2

	return
end

function var_0_0.GetGrids(arg_11_0)
	return arg_11_0._grids
end

function var_0_0.GetGridDic(arg_12_0)
	return arg_12_0._gridDic
end

function var_0_0.SetPlayer(arg_13_0, arg_13_1)
	arg_13_0._player = arg_13_1
	table = var_1_10002

	var_1_10002.insert(arg_13_0._roles, arg_13_1)

	return
end

function var_0_0.GetPlayer(arg_14_0)
	return arg_14_0._player
end

function var_0_0.SetEnemys(arg_15_0, arg_15_1)
	arg_15_0._enemys = arg_15_1
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_1) do
		table = var_1_10007

		var_1_10007.insert(arg_15_0._roles, iter_15_1)
	end

	return
end

function var_0_0.SetMapTFDic(arg_16_0, arg_16_1)
	arg_16_0._mapTFDic = arg_16_1

	return
end

function var_0_0.GetMapTFDic(arg_17_0)
	return arg_17_0._mapTFDic
end

function var_0_0.GetEnemys(arg_18_0)
	return arg_18_0._enemys
end

function var_0_0.GetPlayerStartIndex(arg_19_0)
	return arg_19_0._mapData.player_start
end

function var_0_0.GetRoles(arg_20_0)
	return arg_20_0._roles
end

function var_0_0.GetPosByIndex(arg_21_0, arg_21_1)
	if not arg_21_0._gridDic then
		Vector2 = var_2

		return var_2(0, 0)
	end

	local var_21_0 = arg_21_0._gridDic[arg_21_1]

	return var_2.GetPosition(var_21_0)
end

function var_0_0.SetJoyData(arg_22_0, arg_22_1)
	arg_22_0._joyData = arg_22_1

	return
end

function var_0_0.GetJoyData(arg_23_0)
	return arg_23_0._joyData
end

function var_0_0.GetScoreCount(arg_24_0)
	if arg_24_0._scoreCount and arg_24_0._scoreCount > 0 then
		return arg_24_0._scoreCount
	end

	arg_24_0._scoreCount = 0

	if arg_24_0._gridDic then
		pairs = var_1

		for iter_24_0, iter_24_1 in var_1(arg_24_0._gridDic) do
			if iter_24_1:HasScore() then
				arg_24_0._scoreCount = arg_24_0._scoreCount + 1
			end
		end
	end

	return arg_24_0._scoreCount
end

function var_0_0.getDirectGrid(arg_25_0, arg_25_1, arg_25_2)
	if (arg_25_1 - 1) % arg_25_0._mapData.horizontal == 0 and arg_25_2.x == -1 then
		return nil
	elseif var_3 % arg_25_0._mapData.horizontal == arg_25_0._mapData.horizontal - 1 and arg_25_2.x == 1 then
		return nil
	elseif var_3 < arg_25_0._mapData.horizontal and arg_25_2.y == 1 then
		return nil
	elseif var_3 >= arg_25_0._mapData.horizontal * (arg_25_0._mapData.vertical - 1) and arg_25_2.y == -1 then
		return nil
	end

	local var_25_0

	if arg_25_2.x ~= 0 then
		var_25_0 = arg_25_1 + arg_25_2.x
	elseif arg_25_2.y ~= 0 then
		var_25_0 = arg_25_1 + -arg_25_2.y * arg_25_0._mapData.horizontal
	end

	if var_25_0 and arg_25_0._gridDic[var_25_0] and var_5:GetPassAble() then
		return var_5
	end

	return nil
end

function var_0_0.GetNearGridIndex(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = arg_26_0
	local var_26_2 = arg_26_0.getDirectGrid
	local var_26_3 = arg_26_1

	Vector2 = var_1_10006

	local var_26_4 = var_26_2(var_26_1, var_26_3, var_1_10006(-1, 0))
	local var_26_5 = arg_26_0
	local var_26_6 = arg_26_0.getDirectGrid
	local var_26_7 = arg_26_1

	Vector2 = var_7

	local var_26_8 = var_26_6(var_26_5, var_26_7, var_7(1, 0))
	local var_26_9 = arg_26_0
	local var_26_10 = arg_26_0.getDirectGrid
	local var_26_11 = arg_26_1

	Vector2 = var_8

	local var_26_12 = var_26_10(var_26_9, var_26_11, var_8(0, 1))
	local var_26_13 = arg_26_0
	local var_26_14 = arg_26_0.getDirectGrid
	local var_26_15 = arg_26_1

	Vector2 = var_9

	local var_26_16 = var_26_14(var_26_13, var_26_15, var_9(0, -1))

	if var_26_4 then
		table = var_26_13

		var_26_13.insert(var_26_0, var_26_4:GetIndex())
	end

	if var_26_8 then
		table = var_26_13

		var_26_13.insert(var_26_0, var_26_8:GetIndex())
	end

	if var_26_12 then
		table = var_26_13

		var_26_13.insert(var_26_0, var_26_12:GetIndex())
	end

	if var_26_16 then
		table = var_26_13

		var_26_13.insert(var_26_0, var_26_16:GetIndex())
	end

	return var_26_0
end

function var_0_0.SetTpl(arg_27_0, arg_27_1)
	arg_27_0._tpl = arg_27_1

	return
end

function var_0_0.GetTplItemFromPool(arg_28_0, arg_28_1, arg_28_2)
	if not arg_28_1 or arg_28_1 == "" then
		return nil
	end

	if not arg_28_2 then
		return nil
	end

	if arg_28_0._tplItemPool[arg_28_1] == nil then
		arg_28_0._tplItemPool[arg_28_1] = {}
	end

	local var_28_0

	if #arg_28_0._tplItemPool[arg_28_1] == 0 then
		tf = var_28_0
		instantiate = var_1_10004
		findTF = var_1_10005
		var_28_0 = var_28_0(var_1_10004(var_1_10005(arg_28_0._tpl, arg_28_1)))
		setParent = var_4

		var_4(var_28_0, arg_28_2)

		return var_28_0, true
	else
		table = var_28_0

		return var_28_0.remove(arg_28_0._tplItemPool[arg_28_1], #arg_28_0._tplItemPool[arg_28_1]), false
	end

	return nil, nil
end

function var_0_0.Clear(arg_29_0)
	arg_29_0._chapterData = nil
	arg_29_0._mapData = nil
	arg_29_0._player = nil
	arg_29_0._enemys = nil
	arg_29_0._scoreCount = 0
	arg_29_0._roles = {}

	return
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0._tpl = nil
	arg_30_0._tplItemPool = {}
	arg_30_0._chapterData = nil
	arg_30_0._mapData = nil
	arg_30_0._scoreCount = 0
	arg_30_0._gridDic = {}
	arg_30_0._grids = {}

	return
end

return var_0_0
