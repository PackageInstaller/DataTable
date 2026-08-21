local var_0_0 = class("ShipExpressionHelper")
local var_0_1 = pg.ship_skin_expression
local var_0_2 = pg.ship_skin_expression_ex
local var_0_3 = false

local function var_0_4(...)
	if var_0_3 and IsUnityEditor then
		print(...)
	end

	return
end

local function var_0_5(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local function var_2_0()
		if arg_2_1 then
			local var_3_0 = var_0[arg_2_1] or nil
			local var_3_1

			if var_3_0 and var_3_0 ~= "" then
				for iter_3_0, iter_3_1 in ipairs(var_3_0) do
					if arg_2_2 >= iter_3_1[1] then
						var_3_1 = iter_3_1[2]
					end
				end
			end

			return var_3_1
		end
	end

	local function var_2_1(arg_4_0)
		if var_0.main_ex and var_0.main_ex ~= "" then
			local var_4_0

			for iter_4_0, iter_4_1 in ipairs(var_0.main_ex) do
				if arg_2_2 >= iter_4_1[1] then
					var_4_0 = iter_4_1[2]
				end
			end

			if var_4_0 then
				return string.split(var_4_0, "|")[arg_4_0]
			end
		end

		return nil
	end

	local var_2_2

	if var_0_2[arg_2_0] then
		var_2_2 = arg_2_3 and string.find(arg_2_1, "main") and (function()
			local var_5_0 = string.split(arg_2_1, "_")[2]

			if not var_5_0 then
				return nil
			end

			local var_5_1 = tonumber(var_5_0) - ShipWordHelper.GetMainSceneWordCnt(arg_2_3)

			if var_5_1 > 0 then
				return var_2_1(var_5_1)
			else
				return var_2_0()
			end

			return
		end)() or (function()
			if arg_2_1 then
				local var_3_0 = var_0[arg_2_1] or nil
				local var_3_1

				if var_3_0 and var_3_0 ~= "" then
					for iter_3_0, iter_3_1 in ipairs(var_3_0) do
						if arg_2_2 >= iter_3_1[1] then
							var_3_1 = iter_3_1[2]
						end
					end
				end

				return var_3_1
			end
		end)()
	end

	return var_2_2
end

function var_0_0.GetExpression(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_4("name:", arg_6_0, " - kind:", arg_6_1, " - favor:", arg_6_2)

	local var_6_0 = var_0_1[arg_6_0]

	if not var_0_1[arg_6_0] then
		return nil
	end

	if arg_6_1 then
		local var_6_1 = var_6_0[arg_6_1] or nil

		if arg_6_2 then
			local var_6_2 = var_0_5(arg_6_0, arg_6_1, arg_6_2, arg_6_3)

			if var_6_2 then
				var_0_4("get expression form ex:", var_6_2)

				var_6_1 = var_6_2
			end
		end

		if not var_6_1 or var_6_1 == "" then
			var_6_1 = var_6_0.default

			var_0_4("get expression form default:", var_6_0.default)
		end

		var_0_4("get express :", var_6_1)

		return var_6_1
	end
end

function var_0_0.SetExpression(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return var_0_0.UpdateExpression(arg_7_0, arg_7_1, (var_0_0.GetExpression(arg_7_1, arg_7_2, arg_7_3, arg_7_4)))
end

function var_0_0.UpdateExpression(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = tf(arg_8_0):Find("face")

	if not var_8_0 then
		return false, nil
	end

	local var_8_1 = arg_8_1

	if not arg_8_2 or arg_8_2 == "" then
		var_8_1 = string.gsub(arg_8_1, "_n", "")

		if var_0_0.DefaultFaceless(var_8_1) then
			arg_8_2 = var_0_0.GetDefaultFace(var_8_1)
		end
	end

	if not arg_8_2 or arg_8_2 == "" then
		setActive(var_8_0, false)

		return false, nil
	end

	var_0_0._UpdateExpression(var_8_0, var_8_1, arg_8_2)

	return true, arg_8_2
end

function var_0_0._UpdateExpression(arg_9_0, arg_9_1, arg_9_2)
	setImageSprite(arg_9_0, (GetSpriteFromAtlas("paintingface/" .. arg_9_1, arg_9_2)))
	setActive(arg_9_0, true)

	local var_9_0 = findTF(arg_9_0, "face_sub")

	if var_9_0 then
		local var_9_1 = GetSpriteFromAtlas("paintingface/" .. arg_9_1, arg_9_2 .. "_sub")

		setActive(var_9_0, var_9_1)

		if var_9_1 then
			setImageSprite(var_9_0, var_9_1)
		end
	end

	return
end

function var_0_0.DefaultFaceless(arg_10_0)
	return var_0_1[arg_10_0] and var_0_1[arg_10_0].default ~= ""
end

function var_0_0.GetDefaultFace(arg_11_0)
	return var_0_1[arg_11_0].default
end

return var_0_0
