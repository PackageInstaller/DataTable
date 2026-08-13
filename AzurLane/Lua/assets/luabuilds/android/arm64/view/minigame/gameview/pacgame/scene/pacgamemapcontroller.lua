class = var_0_10000

local var_0_0 = var_0_10000("PacGameMapController")
local var_0_1 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._sceneMask = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._runningData = arg_1_3
	findTF = var_1_10004
	arg_1_0._mapTF = var_1_10004(arg_1_0._sceneMask, "sceneContainer/scene/content/map")
	arg_1_0._grids = {}
	arg_1_0._gridDic = {}
	arg_1_0._mapTFDic = {}

	for iter_1_0 = 0, arg_1_0._mapTF.childCount - 1 do
		local var_1_0 = arg_1_0._mapTF
		local var_1_1 = var_8.GetChild(var_1_0, iter_1_0)

		arg_1_0._mapTFDic[iter_1_0 + 1] = var_1_1
	end

	return
end

function var_0_0.SetParent(arg_2_0)
	return
end

function var_0_0.SetPosition(arg_3_0)
	return
end

function var_0_0.SetScale(arg_4_0)
	return
end

function var_0_0.SetGridIndex(arg_5_0)
	return
end

function var_0_0.Prepare(arg_6_0)
	local var_6_0 = arg_6_0._runningData

	arg_6_0._mapData = var_1.GetMapData(var_6_0)
	arg_6_0._activeScoreCount = 0
	arg_6_0._ignoreScore = arg_6_0._mapData.ignore_score

	arg_6_0:prepareMap()

	return
end

function var_0_0.Start(arg_7_0)
	local var_7_0 = arg_7_0._runningData

	arg_7_0._player = var_1.GetPlayer(var_7_0)

	local var_7_1 = arg_7_0._runningData

	arg_7_0._scoreCount = var_1.GetScoreCount(var_7_1)
	arg_7_0._delayReflashScoreTime = nil

	local var_7_2 = arg_7_0._runningData

	arg_7_0._roles = var_1.GetRoles(var_7_2)

	arg_7_0:reflashGridScore()

	return
end

function var_0_0.Step(arg_8_0, arg_8_1)
	arg_8_0._deltaTime = arg_8_1

	arg_8_0:udateScoreGrid()
	arg_8_0:updateRoleLayer()
	arg_8_0:updateReflashTime()

	return
end

function var_0_0.updateReflashTime(arg_9_0)
	if arg_9_0._delayReflashScoreTime and arg_9_0._delayReflashScoreTime >= 0 then
		arg_9_0._delayReflashScoreTime = arg_9_0._delayReflashScoreTime - arg_9_0._deltaTime

		if arg_9_0._delayReflashScoreTime <= 0 then
			arg_9_0._delayReflashScoreTime = nil

			arg_9_0:reflashGridScore()
		end
	end

	return
end

function var_0_0.Clear(arg_10_0)
	for iter_10_0 = 1, #arg_10_0._grids do
		local var_10_0 = arg_10_0._grids[iter_10_0]

		var_5.Dispose(var_10_0)
	end

	arg_10_0._roles = {}
	arg_10_0._grids = {}
	arg_10_0._gridDic = {}
	arg_10_0._player = nil
	arg_10_0._delayReflashScoreTime = nil
	arg_10_0._scoreCount = 0

	return
end

function var_0_0.Stop(arg_11_0)
	return
end

function var_0_0.Resume(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0._roles = {}
	arg_13_0._grids = {}
	arg_13_0._gridDic = {}

	return
end

function var_0_0.prepareMap(arg_14_0)
	local var_14_0 = arg_14_0._mapData.grid_list
	local var_14_1 = arg_14_0._mapData.grid_width
	local var_14_2 = arg_14_0._mapData.grid_height
	local var_14_3 = arg_14_0._mapData.map_bound
	local var_14_4 = arg_14_0._mapData.horizontal
	local var_14_5 = arg_14_0._mapData.vertical
	local var_14_6 = arg_14_0._mapData.offset
	local var_14_7 = arg_14_0._mapTF

	Vector2 = var_1_10009
	var_14_7.anchoredPosition = var_1_10009(-var_14_3[1] / 2 + var_14_1 / 2 + var_14_6[1], var_14_3[2] / 2 - var_14_2 / 2 + var_14_6[2])

	for iter_14_0 = 1, #var_14_0 do
		local var_14_8 = var_14_0[iter_14_0]

		for iter_14_1 = 1, #var_14_8 do
			local var_14_9

			if var_14_8[iter_14_1] == 0 then
				PacGameConst = var_1_10018
				var_14_9 = var_1_10018.default_grid
			end

			PacGameConst = var_1_10018
			var_1_10018 = var_1_10018.grid_data[var_14_9]

			local var_14_10 = arg_14_0._runningData
			local var_14_11 = var_19.GetTplItemFromPool(var_14_10, var_1_10018.prefab, arg_14_0._mapTFDic[iter_14_0])
			local var_14_12 = var_14_4 * (iter_14_0 - 1) + iter_14_1
			local var_14_13 = var_14_8[iter_14_1]

			PacGameGrid = var_22

			local var_14_14 = var_22.New(var_14_11, var_14_12, var_14_13)

			Vector2 = var_23

			local var_14_15 = var_23((iter_14_1 - 1) * var_14_1, -(iter_14_0 - 1) * var_14_2)

			var_14_14:SetPosition(var_14_15)
			var_14_14:SetActive(true)
			var_14_14:SetVH(iter_14_0, iter_14_1)

			table = var_24

			var_24.insert(arg_14_0._grids, var_14_14)

			arg_14_0._gridDic[var_14_12] = var_14_14
		end
	end

	local var_14_16 = arg_14_0._runningData

	var_8.SetGrids(var_14_16, arg_14_0._grids, arg_14_0._gridDic)

	local var_14_17 = arg_14_0._runningData

	var_8.SetMapTFDic(var_14_17, arg_14_0._mapTFDic)

	return
end

function var_0_0.reflashGridScore(arg_15_0)
	local var_15_0 = arg_15_0._runningData

	if var_1.GetEditor(var_15_0) then
		return
	end

	arg_15_0._activeScoreCount = 0

	for iter_15_0 = 1, #arg_15_0._grids do
		local var_15_1 = arg_15_0._grids[iter_15_0]
		local var_15_2 = var_5.GetIndex(var_15_1)

		if var_5:HasScore() then
			table = var_7

			if not var_7.contains(arg_15_0._ignoreScore, var_15_2) then
				arg_15_0._activeScoreCount = arg_15_0._activeScoreCount + 1

				var_5:SetScoreFlag(true)
			else
				var_5:SetScoreFlag(false)
			end
		end
	end

	return
end

function var_0_0.udateScoreGrid(arg_16_0)
	if arg_16_0._activeScoreCount <= 0 and not arg_16_0._delayReflashScoreTime then
		arg_16_0._delayReflashScoreTime = 2
	end

	if arg_16_0._delayCheckReflashCount == nil then
		arg_16_0._delayCheckReflashCount = 10
	end

	if arg_16_0._delayCheckReflashCount and not arg_16_0._delayReflashScoreTime then
		arg_16_0._delayCheckReflashCount = arg_16_0._delayCheckReflashCount - arg_16_0._deltaTime

		if arg_16_0._delayCheckReflashCount <= 0 then
			arg_16_0._delayCheckReflashCount = nil

			if arg_16_0._gridDic then
				local var_16_0 = 0

				pairs = var_2

				for iter_16_0, iter_16_1 in var_2(arg_16_0._gridDic) do
					if iter_16_1 and iter_16_1:GetScoreFlag() then
						var_16_0 = var_16_0 + 1
					end
				end

				if var_16_0 == 0 then
					warning = var_2

					var_2("吃完所有珠子，准备刷新")

					arg_16_0._delayReflashScoreTime = 2
				end
			end
		end
	end

	local var_16_1 = arg_16_0._player
	local var_16_2 = var_1.GetGridIndex(var_16_1)

	if arg_16_0._gridDic[var_16_2] and var_2:GetScoreFlag() then
		local var_16_3 = var_2

		var_2.SetScoreFlag(var_16_3, false)

		arg_16_0._activeScoreCount = arg_16_0._activeScoreCount - 1

		local var_16_4 = arg_16_0._event

		PacGameScene = var_16_3

		var_16_4(var_16_3.GET_SCORE, var_2:GetScore(), nil)
	end

	return
end

function var_0_0.updateRoleLayer(arg_17_0)
	for iter_17_0 = 1, #arg_17_0._roles do
		local var_17_0 = arg_17_0._roles[iter_17_0]
		local var_17_1 = var_5.GetGridIndexNext(var_17_0)

		if arg_17_0._gridDic[var_17_1] then
			local var_17_2, var_17_3 = var_7:GetVH()

			if var_5:GetParent() ~= arg_17_0._mapTFDic[var_17_2] then
				var_5:SetParent(arg_17_0._mapTFDic[var_17_2])
			end
		end
	end

	return
end

return var_0_0
