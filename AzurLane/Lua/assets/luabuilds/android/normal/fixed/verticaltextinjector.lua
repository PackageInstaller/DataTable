local var_0_0 = {}

local function var_0_1(arg_1_0)
	ReflectionHelp = var_1_10001

	local var_1_0 = var_1_10001.RefGetField

	typeof = var_1_10002

	return var_1_0(var_1_10002("UnityEngine.UILineInfo"), "startCharIdx", arg_1_0)
end

local function var_0_2(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 0, #arg_2_0 - 1 do
		var_2_0[iter_2_0] = 0
	end

	ipairs = var_2

	for iter_2_1, iter_2_2 in var_2({
		" ",
		"\n"
	}) do
		Clone = var_1_10007
		var_1_10007 = var_1_10007(arg_2_0)

		local var_2_1 = 0

		string = var_1_10009
		var_1_10009 = var_1_10009.find(var_1_10007, iter_2_2)

		while var_1_10009 do
			for iter_2_3 = 0, #iter_2_2 - 1 do
				var_2_0[var_2_1 + var_1_10009 + iter_2_3] = 3
			end

			var_2_1 = var_2_1 + var_1_10009 + #iter_2_2
			string = var_10
			var_1_10007 = var_10.sub(var_1_10007, var_1_10009 + #iter_2_2)
			string = var_10
			var_1_10009 = var_10.find(var_1_10007, iter_2_2)
		end
	end

	local var_2_2

	ipairs = var_3

	for iter_2_4, iter_2_5 in var_3({
		"b",
		"i",
		"size",
		"color",
		"material"
	}) do
		local var_2_3 = "</" .. iter_2_5 .. ">"

		string = var_9

		local var_2_4 = var_9.match(arg_2_0, "</*" .. iter_2_5 .. "[^>]*>")
		local var_2_5 = {}

		while var_2_4 do
			string = var_2_6

			local var_2_6 = var_2_6.find(arg_2_0, var_2_4)

			if var_2_4 == var_2_3 then
				local var_2_7 = #var_2_5

				if 0 < var_2_7 then
					table = var_2_7

					local var_2_8 = var_2_7.remove(var_2_5)

					for iter_2_6 = 0, #var_2_8.str - 1 do
						var_2_0[var_2_8.start + iter_2_6] = 1
					end

					for iter_2_7 = 0, #var_2_4 - 1 do
						var_2_0[var_2_6 + iter_2_7] = 2
					end
				end
			else
				local var_2_9 = {
					str = var_2_4,
					start = var_2_6
				}

				table = var_12

				var_12.insert(var_2_5, var_2_9)
			end
		end

		string = var_2_6

		local var_2_10 = var_2_6.match(arg_2_0, "</*" .. iter_2_5 .. "[^>]*>")
	end

	local var_2_11 = {}
	local var_2_12 = 0

	for iter_2_8 = 0, #arg_2_0 - 1 do
		if var_2_0[iter_2_8] == 0 then
			var_2_11[iter_2_8] = var_2_12
			var_2_12 = var_2_12 + 1
		else
			var_2_11[iter_2_8] = -2
		end
	end

	for iter_2_9 = 0, #arg_2_0 - 1 do
		if var_2_11[iter_2_9] ~= -2 or var_2_0[iter_2_9] == 0 then
			-- block empty
		elseif var_2_0[iter_2_9] == 1 then
			findRight = var_9
			var_2_11[iter_2_9] = var_9(var_2_0, var_2_11, #arg_2_0, iter_2_9 + 1)
		elseif var_2_0[iter_2_9] == 2 then
			var_2_11[iter_2_9] = var_2_11[iter_2_9 - 1]
		elseif var_2_0[iter_2_9] == 3 then
			var_2_11[iter_2_9] = -1
		end
	end

	return var_2_11
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 < arg_3_2 then
		if arg_3_0[arg_3_3] == 0 then
			return arg_3_1[arg_3_3]
		elseif arg_3_0[arg_3_3] == 1 then
			arg_3_1[arg_3_3] = var_0_3(arg_3_0, arg_3_1, arg_3_2, arg_3_3 + 1)

			return arg_3_1[arg_3_3]
		elseif arg_3_0[arg_3_3] == 2 then
			return -1
		elseif arg_3_0[arg_3_3] == 3 then
			arg_3_1[arg_3_3] = var_0_3(arg_3_0, arg_3_1, arg_3_2, arg_3_3 + 1)

			return arg_3_1[arg_3_3]
		end
	end

	return -1
end

function var_0_0.ModifyMesh()
	local function var_4_0(arg_5_0, arg_5_1)
		ReflectionHelp = var_2_10002

		local var_5_0 = var_2_10002.RefCallMethod

		typeof = var_2_10003

		if not var_5_0(var_2_10003("VerticalText"), "IsActive", arg_5_0) then
			return
		end

		GetComponent = var_2
		ReflectionHelp = var_3

		local var_5_1 = var_3.RefGetProperty

		typeof = var_4

		local var_5_2 = var_5_1(var_4("VerticalText"), "gameObject", arg_5_0)

		typeof = var_4
		Text = var_5

		local var_5_3 = var_2(var_5_2, var_4(var_5)).cachedTextGenerator

		ReflectionHelp = var_4

		local var_5_4 = var_4.RefSetField

		typeof = var_5

		var_5_4(var_5("VerticalText"), "lineSpacing", arg_5_0, var_2.fontSize * var_2.lineSpacing)

		ReflectionHelp = var_5_4

		local var_5_5 = var_5_4.RefGetField

		typeof = var_5

		local var_5_6 = var_5_5(var_5("VerticalText"), "spacing", arg_5_0)

		ReflectionHelp = var_5

		local var_5_7 = var_5.RefSetField

		typeof = var_6

		var_5_7(var_6("VerticalText"), "textSpacing", arg_5_0, var_2.fontSize * var_5_6)

		ReflectionHelp = var_5_7

		local var_5_8 = var_5_7.RefSetField

		typeof = var_6

		var_5_8(var_6("VerticalText"), "xOffset", arg_5_0, var_2.rectTransform.sizeDelta.x / 2 - var_2.fontSize / 2)

		ReflectionHelp = var_5_8

		local var_5_9 = var_5_8.RefSetField

		typeof = var_6

		var_5_9(var_6("VerticalText"), "yOffset", arg_5_0, var_2.rectTransform.sizeDelta.y / 2 - var_2.fontSize / 2)

		ReflectionHelp = var_5_9

		local var_5_10 = var_5_9.RefGetProperty

		typeof = var_6

		local var_5_11 = var_5_10(var_6("UnityEngine.TextGenerator"), "lines", var_5_3)

		ReflectionHelp = var_6

		local var_5_12 = var_6.RefCallStaticMethod

		typeof = var_7

		local var_5_13 = var_7("UnityEngine.UI.RichText")
		local var_5_14 = "RichStringProjection"
		local var_5_15 = {}

		typeof = var_10
		var_5_15[1] = var_10("System.String")

		local var_5_16 = var_5_12(var_5_13, var_5_14, var_5_15, {
			var_2.text
		})
		local var_5_17 = var_5_11.Count

		for iter_5_0 = 0, var_5_17 - 1 do
			local var_5_18

			if not (iter_5_0 + 1 < var_5_17) or not var_0_1(var_5_11[iter_5_0 + 1]) then
				utf8_len = var_5_18
				var_5_18 = var_5_18(var_2.text)
			end

			local var_5_19 = 0

			for iter_5_1 = var_0_1(var_5_11[iter_5_0]), var_5_18 - 1 do
				local var_5_20 = var_5_16[iter_5_1]

				if 0 <= var_5_20 then
					ReflectionHelp = var_5_20

					local var_5_21 = var_5_20.RefCallMethod

					typeof = var_19

					local var_5_22 = var_19("VerticalText")
					local var_5_23 = "modifyText"
					local var_5_24 = arg_5_0
					local var_5_25 = {}

					typeof = var_2_10023
					var_5_25[1] = var_2_10023("UnityEngine.UI.VertexHelper")
					typeof = var_2_10023
					var_5_25[2] = var_2_10023("System.Int32")
					typeof = var_2_10023
					var_5_25[3] = var_2_10023("System.Int32")
					typeof = var_2_10023
					var_5_25[4] = var_2_10023("System.Int32")

					var_5_21(var_5_22, var_5_23, var_5_24, var_5_25, {
						arg_5_1,
						var_5_16[iter_5_1],
						var_5_19,
						iter_5_0
					})
				end

				var_5_19 = var_5_19 + 1
			end
		end

		return
	end

	LuaInterface = var_1_10001

	return var_4_0, var_1_10001.InjectType.Replace
end

InjectByName = var_4

var_4("VerticalText", var_0_0)

return
