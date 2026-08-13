class = var_0_10000

local var_0_0 = "MapWeatherCellView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StaticCellView"))

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	arg_1_0.weatherPrefabs = {}

	return
end

function var_0_1.GetOrder(arg_2_0)
	ChapterConst = var_1_10001

	return var_1_10001.CellPriorityUpperEffect
end

function var_0_1.Update(arg_3_0, arg_3_1)
	IsNil = var_1_10002

	if var_1_10002(arg_3_0.go) then
		arg_3_0:PrepareBase("weathers" .. arg_3_0.line.row .. "_" .. arg_3_0.line.column)
	end

	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		if not arg_3_0.weatherPrefabs[iter_3_1] then
			var_1_10007 = arg_3_0.weatherPrefabs
			var_1_10007[iter_3_1] = true
			pg = var_1_10007

			if var_1_10007.weather_data_template[iter_3_1].icon and #var_8 > 0 then
				local var_3_0 = arg_3_0:GetLoader()

				var_1_10009.GetPrefab(var_3_0, "ui/" .. var_8, var_8, function(arg_4_0)
					setParent = var_2_10001

					var_2_10001(arg_4_0, arg_3_0.tf)

					setActive = var_2_10001

					var_2_10001(arg_4_0, true)

					local var_4_0 = arg_3_0

					var_1.OnLoadedPrefab(var_4_0, arg_4_0, iter_3_1)

					return
				end, "Weather" .. iter_3_1)
			else
				IsUnityEditor = var_1_10009

				if var_1_10009 then
					GameObject = var_1_10009
					var_1_10009 = var_1_10009("weatherID_" .. iter_3_1)

					local var_3_1 = arg_3_0:GetLoader()

					var_10.RegisterLoaded(var_3_1, "Weather" .. iter_3_1, var_1_10009)

					setParent = var_10

					var_10(var_1_10009, arg_3_0.tf)

					setActive = var_10

					var_10(var_1_10009, true)
				end
			end
		end
	end

	pairs = var_2

	for iter_3_2, iter_3_3 in var_2(arg_3_0.weatherPrefabs) do
		table = var_1_10007

		if not var_1_10007.contains(arg_3_1, iter_3_2) then
			local var_3_2 = arg_3_0:GetLoader()

			var_1_10007.ClearRequest(var_3_2, "Weather" .. iter_3_2)

			var_1_10007 = arg_3_0.weatherPrefabs
			var_1_10007[iter_3_2] = nil
		end
	end

	return
end

function var_0_1.OnLoadedPrefab(arg_5_0, arg_5_1, arg_5_2)
	ChapterConst = var_1_10003

	local var_5_0

	if arg_5_2 == var_1_10003.FlagWeatherFog then
		tf = var_5_0
		var_5_0 = var_5_0(arg_5_1).childCount
		math = var_4

		local var_5_1 = var_4.random(1, var_5_0)

		for iter_5_0 = 1, var_5_0 do
			setActive = var_1_10009
			tf = var_1_10010

			local var_5_2 = var_1_10010(arg_5_1)

			var_1_10009(var_1_10010.GetChild(var_5_2, iter_5_0 - 1), iter_5_0 == var_5_1)
		end
	else
		ChapterConst = var_5_0

		if arg_5_2 == var_5_0.FlagWeatherFogVisible then
			WorldConst = var_3

			local var_5_3 = var_3.Pos2FogRes(arg_5_0.line.row, arg_5_0.line.column)

			eachChild = var_4
			tf = var_5

			var_4(var_5(arg_5_1), function(arg_6_0, arg_6_1)
				setActive = var_2_10002

				var_2_10002(arg_6_0, arg_6_0.name == var_5_3)

				return
			end)
		end
	end

	return
end

return var_0_1
