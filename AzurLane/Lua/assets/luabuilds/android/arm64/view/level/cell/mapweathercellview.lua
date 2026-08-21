local var_0_0 = class("MapWeatherCellView", import(".StaticCellView"))

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.weatherPrefabs = {}

	return
end

function var_0_0.GetOrder(arg_2_0)
	return ChapterConst.CellPriorityUpperEffect
end

function var_0_0.Update(arg_3_0, arg_3_1)
	if IsNil(arg_3_0.go) then
		arg_3_0:PrepareBase("weathers" .. arg_3_0.line.row .. "_" .. arg_3_0.line.column)
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not arg_3_0.weatherPrefabs[iter_3_1] then
			arg_3_0.weatherPrefabs[iter_3_1] = true

			if pg.weather_data_template[iter_3_1].icon and #pg.weather_data_template[iter_3_1].icon > 0 then
				arg_3_0:GetLoader():GetPrefab("ui/" .. pg.weather_data_template[iter_3_1].icon, pg.weather_data_template[iter_3_1].icon, function(arg_4_0)
					setParent(arg_4_0, arg_3_0.tf)
					setActive(arg_4_0, true)
					arg_3_0:OnLoadedPrefab(arg_4_0, iter_3_1)

					return
				end, "Weather" .. iter_3_1)
			elseif IsUnityEditor then
				local var_3_0 = GameObject("weatherID_" .. iter_3_1)

				arg_3_0:GetLoader():RegisterLoaded("Weather" .. iter_3_1, var_3_0)
				setParent(var_3_0, arg_3_0.tf)
				setActive(var_3_0, true)
			end
		end
	end

	for iter_3_2, iter_3_3 in pairs(arg_3_0.weatherPrefabs) do
		if not table.contains(arg_3_1, iter_3_2) then
			arg_3_0:GetLoader():ClearRequest("Weather" .. iter_3_2)

			arg_3_0.weatherPrefabs[iter_3_2] = nil
		end
	end

	return
end

function var_0_0.OnLoadedPrefab(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == ChapterConst.FlagWeatherFog then
		local var_5_0 = tf(arg_5_1).childCount
		local var_5_1 = math.random(1, var_5_0)

		for iter_5_0 = 1, var_5_0 do
			local var_5_2 = tf(arg_5_1)

			setActive(var_5_2:GetChild(iter_5_0 - 1), iter_5_0 == var_5_1)
		end
	elseif arg_5_2 == ChapterConst.FlagWeatherFogVisible then
		local var_5_3 = WorldConst.Pos2FogRes(arg_5_0.line.row, arg_5_0.line.column)

		eachChild(tf(arg_5_1), function(arg_6_0, arg_6_1)
			setActive(arg_6_0, arg_6_0.name == var_5_3)

			return
		end)
	end

	return
end

return var_0_0
