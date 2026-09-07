local MapWeatherCellView = class("MapWeatherCellView", import(".StaticCellView"))

function MapWeatherCellView:Ctor(...)
	MapWeatherCellView.super.Ctor(self, ...)

	self.weatherPrefabs = {}

	return
end

function MapWeatherCellView:GetOrder()
	return ChapterConst.CellPriorityUpperEffect
end

function MapWeatherCellView:Update(arg_3_1)
	if IsNil(self.go) then
		self:PrepareBase("weathers" .. self.line.row .. "_" .. self.line.column)
	end

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not self.weatherPrefabs[iter_3_1] then
			self.weatherPrefabs[iter_3_1] = true

			if pg.weather_data_template[iter_3_1].icon and #pg.weather_data_template[iter_3_1].icon > 0 then
				self:GetLoader():GetPrefab("ui/" .. pg.weather_data_template[iter_3_1].icon, pg.weather_data_template[iter_3_1].icon, function(arg_4_0)
					setParent(arg_4_0, self.tf)
					setActive(arg_4_0, true)
					self:OnLoadedPrefab(arg_4_0, iter_3_1)

					return
				end, "Weather" .. iter_3_1)
			elseif IsUnityEditor then
				local var_3_0 = GameObject("weatherID_" .. iter_3_1)

				self:GetLoader():RegisterLoaded("Weather" .. iter_3_1, var_3_0)
				setParent(var_3_0, self.tf)
				setActive(var_3_0, true)
			end
		end
	end

	for iter_3_2, iter_3_3 in pairs(self.weatherPrefabs) do
		if not table.contains(arg_3_1, iter_3_2) then
			self:GetLoader():ClearRequest("Weather" .. iter_3_2)

			self.weatherPrefabs[iter_3_2] = nil
		end
	end

	return
end

function MapWeatherCellView:OnLoadedPrefab(arg_5_1, arg_5_2)
	if arg_5_2 == ChapterConst.FlagWeatherFog then
		local var_5_0 = tf(arg_5_1).childCount
		local var_5_1 = math.random(1, var_5_0)

		for iter_5_0 = 1, var_5_0 do
			setActive(tf(arg_5_1):GetChild(iter_5_0 - 1), iter_5_0 == var_5_1)
		end
	elseif arg_5_2 == ChapterConst.FlagWeatherFogVisible then
		local var_5_2 = WorldConst.Pos2FogRes(self.line.row, self.line.column)

		eachChild(tf(arg_5_1), function(arg_6_0, arg_6_1)
			setActive(arg_6_0, arg_6_0.name == var_5_2)

			return
		end)
	end

	return
end

return MapWeatherCellView
