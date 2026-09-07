local ShipExpressionHelper = class("ShipExpressionHelper")
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
	local var_2_0 = var_0_2[arg_2_0]

	local function var_2_1()
		local var_3_0

		if arg_2_1 then
			var_3_0 = var_2_0[arg_2_1] or nil
		end

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

	local function var_2_2(arg_4_0)
		if var_2_0.main_ex and var_2_0.main_ex ~= "" then
			local var_4_0

			for iter_4_0, iter_4_1 in ipairs(var_2_0.main_ex) do
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

	return (var_0_2[arg_2_0] or nil) and (arg_2_3 and string.find(arg_2_1, "main") and (function()
		local var_5_0 = string.split(arg_2_1, "_")[2]

		if not var_5_0 then
			return nil
		end

		local var_5_1 = tonumber(var_5_0) - ShipWordHelper.GetMainSceneWordCnt(arg_2_3)

		if var_5_1 > 0 then
			return var_2_2(var_5_1)
		else
			return var_2_1()
		end

		return
	end)() or var_2_1())
end

function ShipExpressionHelper:GetExpression(arg_6_1, arg_6_2, arg_6_3)
	var_0_4("name:", self, " - kind:", arg_6_1, " - favor:", arg_6_2)

	local var_6_0 = var_0_1[self]

	if not var_0_1[self] then
		return nil
	end

	local var_6_1

	if arg_6_1 then
		var_6_1 = var_6_0[arg_6_1] or nil

		if arg_6_2 then
			local var_6_2 = var_0_5(self, arg_6_1, arg_6_2, arg_6_3)

			if var_6_2 then
				var_0_4("get expression form ex:", var_6_2)

				var_6_1 = var_6_2
			end
		end

		if not var_6_1 or var_6_1 == "" then
			var_6_1 = var_6_0.default

			var_0_4("get expression form default:", var_6_0.default)
		end
	end

	var_0_4("get express :", var_6_1)

	return var_6_1
end

function ShipExpressionHelper:SetExpression(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	return ShipExpressionHelper.UpdateExpression(self, arg_7_1, (ShipExpressionHelper.GetExpression(arg_7_1, arg_7_2, arg_7_3, arg_7_4)))
end

function ShipExpressionHelper:UpdateExpression(arg_8_1, arg_8_2)
	local var_8_0 = tf(self):Find("face")

	if not var_8_0 then
		return false, nil
	end

	local var_8_1 = arg_8_1

	if not arg_8_2 or arg_8_2 == "" then
		var_8_1 = string.gsub(arg_8_1, "_n", "")

		if ShipExpressionHelper.DefaultFaceless(var_8_1) then
			arg_8_2 = ShipExpressionHelper.GetDefaultFace(var_8_1)
		end
	end

	if not arg_8_2 or arg_8_2 == "" then
		setActive(var_8_0, false)

		return false, nil
	end

	ShipExpressionHelper._UpdateExpression(var_8_0, var_8_1, arg_8_2)

	return true, arg_8_2
end

function ShipExpressionHelper:_UpdateExpression(arg_9_1, arg_9_2)
	setImageSprite(self, (GetSpriteFromAtlas("paintingface/" .. arg_9_1, arg_9_2)))
	setActive(self, true)

	local var_9_0 = findTF(self, "face_sub")

	if var_9_0 then
		local var_9_1 = GetSpriteFromAtlas("paintingface/" .. arg_9_1, arg_9_2 .. "_sub")

		setActive(var_9_0, var_9_1)

		if var_9_1 then
			setImageSprite(var_9_0, var_9_1)
		end
	end

	return
end

function ShipExpressionHelper:DefaultFaceless()
	return var_0_1[self] and var_0_1[self].default ~= ""
end

function ShipExpressionHelper:GetDefaultFace()
	return var_0_1[self].default
end

return ShipExpressionHelper
