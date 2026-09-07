local var_0_0 = {}

local function var_0_1(arg_1_0)
	return ReflectionHelp.RefGetField(typeof("UnityEngine.UILineInfo"), "startCharIdx", arg_1_0)
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
	return function(arg_5_0, arg_5_1)
		if not ReflectionHelp.RefCallMethod(typeof("VerticalText"), "IsActive", arg_5_0) then
			return
		end

		local var_5_0 = GetComponent(ReflectionHelp.RefGetProperty(typeof("VerticalText"), "gameObject", arg_5_0), typeof(Text))

		ReflectionHelp.RefSetField(typeof("VerticalText"), "lineSpacing", arg_5_0, var_5_0.fontSize * var_5_0.lineSpacing)
		ReflectionHelp.RefSetField(typeof("VerticalText"), "textSpacing", arg_5_0, var_5_0.fontSize * ReflectionHelp.RefGetField(typeof("VerticalText"), "spacing", arg_5_0))
		ReflectionHelp.RefSetField(typeof("VerticalText"), "xOffset", arg_5_0, var_5_0.rectTransform.sizeDelta.x / 2 - var_5_0.fontSize / 2)
		ReflectionHelp.RefSetField(typeof("VerticalText"), "yOffset", arg_5_0, var_5_0.rectTransform.sizeDelta.y / 2 - var_5_0.fontSize / 2)

		local var_5_1 = ReflectionHelp.RefGetProperty(typeof("UnityEngine.TextGenerator"), "lines", var_5_0.cachedTextGenerator)
		local var_5_2 = ReflectionHelp.RefCallStaticMethod(typeof("UnityEngine.UI.RichText"), "RichStringProjection", {
			typeof("System.String")
		}, {
			var_5_0.text
		})

		for iter_5_0 = 0, var_5_1.Count - 1 do
			local var_5_3 = 0

			for iter_5_1 = var_0_1(var_5_1[iter_5_0]), (var_5_1.Count > iter_5_0 + 1 and var_0_1(var_5_1[iter_5_0 + 1]) or utf8_len(var_5_0.text)) - 1 do
				if var_5_2[iter_5_1] >= 0 then
					ReflectionHelp.RefCallMethod(typeof("VerticalText"), "modifyText", arg_5_0, {
						typeof("UnityEngine.UI.VertexHelper"),
						typeof("System.Int32"),
						typeof("System.Int32"),
						typeof("System.Int32")
					}, {
						arg_5_1,
						var_5_2[iter_5_1],
						var_5_3,
						iter_5_0
					})
				end

				var_5_3 = var_5_3 + 1
			end
		end

		return
	end, LuaInterface.InjectType.Replace
end

InjectByName("VerticalText", var_0_0)

return
