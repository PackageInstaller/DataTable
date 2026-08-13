class = var_0_10000

local var_0_0 = var_0_10000("ShipExpressionHelper")

pg = var_0_10001

local var_0_1 = var_0_10001.ship_skin_expression

pg = var_2

local var_0_2 = var_2.ship_skin_expression_ex
local var_0_3 = false

local function var_0_4(...)
	if var_0_3 then
		IsUnityEditor = var_0

		if var_0 then
			print = var_0

			var_0(...)
		end
	end

	return
end

local function var_0_5(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_2[arg_2_0]

	local function var_2_1()
		local var_3_0

		if not arg_2_1 or not var_2_0[arg_2_1] then
			var_3_0 = nil
		end

		local var_3_1

		if var_3_0 and var_3_0 ~= "" then
			ipairs = var_2_10002

			for iter_3_0, iter_3_1 in var_2_10002(var_3_0) do
				if arg_2_2 >= iter_3_1[1] then
					var_3_1 = iter_3_1[2]
				end
			end
		end

		return var_3_1
	end

	local function var_2_2(arg_4_0)
		if var_2_0.main_ex and var_1 ~= "" then
			local var_4_0

			ipairs = var_2_10003

			for iter_4_0, iter_4_1 in var_2_10003(var_1) do
				if arg_2_2 >= iter_4_1[1] then
					var_4_0 = iter_4_1[2]
				end
			end

			if var_4_0 then
				string = var_3

				return var_3.split(var_4_0, "|")[arg_4_0]
			end
		end

		return nil
	end

	local function var_2_3()
		string = var_2_10000

		if not var_2_10000.split(arg_2_1, "_")[2] then
			return nil
		end

		tonumber = var_2

		local var_5_0 = var_2(var_1)

		ShipWordHelper = var_2

		if var_5_0 - var_2.GetMainSceneWordCnt(arg_2_3) > 0 then
			return var_2_2(var_3)
		else
			return var_2_1()
		end

		return
	end

	local var_2_4

	if var_2_0 then
		if arg_2_3 then
			string = var_1_10009

			if var_1_10009.find(arg_2_1, "main") then
				var_2_4 = var_2_3()

				goto label_2_0
			end
		end

		var_2_4 = var_2_1()
	end

	::label_2_0::

	return var_2_4
end

function var_0_0.GetExpression(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_4("name:", arg_6_0, " - kind:", arg_6_1, " - favor:", arg_6_2)

	if not var_0_1[arg_6_0] then
		return nil
	end

	local var_6_0

	if not arg_6_1 or not var_4[arg_6_1] then
		var_6_0 = nil
	end

	if arg_6_2 and var_0_5(arg_6_0, arg_6_1, arg_6_2, arg_6_3) then
		var_0_4("get expression form ex:", var_6)

		var_6_0 = var_6
	end

	if not var_6_0 or var_6_0 == "" then
		var_6_0 = var_4.default

		var_0_4("get expression form default:", var_6_0)
	end

	var_0_4("get express :", var_6_0)

	return var_6_0
end

function var_0_0.SetExpression(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = var_0_0.GetExpression(arg_7_1, arg_7_2, arg_7_3, arg_7_4)

	return var_0_0.UpdateExpression(arg_7_0, arg_7_1, var_7_0)
end

function var_0_0.UpdateExpression(arg_8_0, arg_8_1, arg_8_2)
	tf = var_1_10003

	local var_8_0 = var_1_10003(arg_8_0)

	if not var_3.Find(var_8_0, "face") then
		return false, nil
	end

	local var_8_1 = arg_8_1

	if not arg_8_2 or arg_8_2 == "" then
		string = var_8_0
		var_8_1 = var_8_0.gsub(arg_8_1, "_n", "")

		if var_0_0.DefaultFaceless(var_8_1) then
			arg_8_2 = var_0_0.GetDefaultFace(var_8_1)
		end
	end

	if not arg_8_2 or arg_8_2 == "" then
		setActive = var_8_0

		var_8_0(var_3, false)

		return false, nil
	end

	var_0_0._UpdateExpression(var_3, var_8_1, arg_8_2)

	return true, arg_8_2
end

function var_0_0._UpdateExpression(arg_9_0, arg_9_1, arg_9_2)
	GetSpriteFromAtlas = var_1_10003

	local var_9_0 = var_1_10003("paintingface/" .. arg_9_1, arg_9_2)

	setImageSprite = var_1_10004

	var_1_10004(arg_9_0, var_9_0)

	setActive = var_1_10004

	var_1_10004(arg_9_0, true)

	findTF = var_1_10004

	if var_1_10004(arg_9_0, "face_sub") then
		GetSpriteFromAtlas = var_5

		local var_9_1 = var_5("paintingface/" .. arg_9_1, arg_9_2 .. "_sub")

		setActive = var_6

		var_6(var_4, var_9_1)

		if var_9_1 then
			setImageSprite = var_6

			var_6(var_4, var_9_1)
		end
	end

	return
end

function var_0_0.DefaultFaceless(arg_10_0)
	return var_0_1[arg_10_0] and var_1.default ~= ""
end

function var_0_0.GetDefaultFace(arg_11_0)
	return var_0_1[arg_11_0].default
end

return var_0_0
