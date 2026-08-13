class = var_0_10000

local var_0_0 = var_0_10000("EnemyCellView")

function var_0_0.Ctor(arg_1_0)
	arg_1_0._extraEffectList = {}

	return
end

function var_0_0.SetPoolType(arg_2_0, arg_2_1)
	arg_2_0.poolType = arg_2_1

	return
end

function var_0_0.GetPoolType(arg_3_0)
	return arg_3_0.poolType
end

function var_0_0.ClearExtraEffects(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0._extraEffectList) do
		IsNil = var_1_10006

		if not var_1_10006(iter_4_1) then
			Destroy = var_1_10006

			var_1_10006(iter_4_1)
		end
	end

	table = var_1

	var_1.clear(arg_4_0._extraEffectList)

	return
end

function var_0_0.LoadExtraEffects(arg_5_0, arg_5_1)
	if arg_5_1 and #arg_5_1 > 0 then
		local var_5_0 = "effect/" .. arg_5_1
		local var_5_1 = arg_5_0:GetLoader()

		var_3.LoadPrefab(var_5_1, var_5_0, arg_5_1, function(arg_6_0)
			arg_5_0._extraEffectList[var_5_0] = arg_6_0

			local var_6_0 = arg_6_0.transform.localScale

			setParent = var_2

			var_2(arg_6_0, arg_5_0.tf, false)

			arg_6_0.transform.localScale = var_6_0

			local var_6_1 = arg_5_0

			var_2.ResetCanvasOrder(var_6_1)

			return
		end)
	end

	return
end

function var_0_0.RefreshEnemyTplIcons(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.tf

	if not var_3.Find(var_7_0, "random_buff_container") then
		return
	end

	local var_7_1 = {}

	if arg_7_1.icon_type == 1 then
		local var_7_2 = arg_7_1.type

		ChapterConst = var_1_10007

		if var_1_10007.EnemySize[var_7_2] ~= 1 then
			ChapterConst = var_7

			if not var_7.EnemySize[var_7_2] then
				table = var_7

				var_7.insert(var_7_1, "xiao")
			else
				ChapterConst = var_7

				if var_7.EnemySize[var_7_2] == 2 then
					table = var_7

					var_7.insert(var_7_1, "zhong")
				else
					ChapterConst = var_7

					if var_7.EnemySize[var_7_2] == 3 then
						table = var_7

						var_7.insert(var_7_1, "da")
					end
				end
			end

			if arg_7_1.bufficon and #arg_7_1.bufficon > 0 then
				table = var_6

				var_6.insertto(var_7_1, arg_7_1.bufficon)
			end

			underscore = var_6

			local var_7_3 = var_6(arg_7_2:GetWeather(arg_7_0.line.row, arg_7_0.line.column))
			local var_7_4 = var_6.chain(var_7_3)
			local var_7_5 = var_6.filter(var_7_4, function(arg_8_0)
				ChapterConst = var_2_10001

				return arg_8_0 == var_2_10001.FlagWeatherFog
			end)

			var_6.each(var_7_5, function(arg_9_0)
				table = var_2_10001

				local var_9_0 = var_2_10001.insert
				local var_9_1 = var_7_1

				pg = var_2_10004

				var_9_0(var_9_1, var_2_10004.weather_data_template[arg_9_0].buff_icon)

				return
			end)

			setActive = var_6

			var_6(var_3, true)

			LevelGrid = var_6

			var_6.AlignListContainer(var_3, #var_7_1)

			ipairs = var_6

			for iter_7_0, iter_7_1 in var_6(var_7_1) do
				if #iter_7_1 > 0 then
					local var_7_6 = var_3:GetChild(iter_7_0 - 1)
					local var_7_7 = arg_7_0:GetLoader()

					var_12.GetSpriteQuiet(var_7_7, "ui/share/ship_gizmos_atlas", iter_7_1, var_7_6)
				end
			end

			return
		end
	end
end

function var_0_0.Clear(arg_10_0)
	LevelCellView = var_1_10001

	var_1_10001.Clear(arg_10_0)
	arg_10_0.ClearExtraEffects(arg_10_0)

	return
end

return var_0_0
