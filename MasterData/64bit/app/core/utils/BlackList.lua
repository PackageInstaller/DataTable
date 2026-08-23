local var_0_0 = {}

function var_0_0.isMatchText(arg_1_0, arg_1_1, arg_1_2)
	if g.core.const.ConstMgr.PlatformConst.CLOSE_BLACK_FILTER and not arg_1_2 then
		return false
	end

	return var_0_0:isMatch(arg_1_1, "app.core.utils.black.black_units") or var_0_0:isMatch(arg_1_1, "app.core.utils.black.black_units_lang", true)
end

function var_0_0.isMatch(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local Utf8 = require("app.core.utils.Utf8")
	local var_2_1 = require(arg_2_2)

	if arg_2_1 == nil or type(arg_2_1) ~= "string" then
		assert("传入值为空或非string类型")

		return false
	end

	for iter_2_0 = 1, Utf8.utf8len(arg_2_1) do
		local var_2_2, var_2_3 = Utf8.utf8sub(arg_2_1, iter_2_0, iter_2_0)
		local var_2_4 = var_2_1:get(var_2_2)

		if var_2_4 and #var_2_4 > 0 then
			for iter_2_1, iter_2_2 in ipairs(var_2_4) do
				for iter_2_3 in string.gmatch(arg_2_1, iter_2_2) do
					if arg_2_3 then
						if var_0_0:isTextCharMatch(arg_2_1, iter_2_3) then
							return true
						end
					else
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_0.isTextCharMatch(arg_3_0, arg_3_1, arg_3_2)
	local Utf8 = require("app.core.utils.Utf8")
	local var_3_1 = string.find(arg_3_1, arg_3_2)

	if not var_3_1 then
		return false
	end

	local var_3_2 = Utf8.utf8len(arg_3_1)
	local var_3_3 = Utf8.utf8len(arg_3_2)
	local var_3_4 = var_3_1 == 1

	if var_3_1 ~= 1 and Utf8.utf8sub(arg_3_1, var_3_1 - 1, var_3_1 - 1) == " " then
		var_3_4 = true
	end

	local var_3_5 = var_3_1 + var_3_3 - 1

	return var_3_4 and (var_3_1 + var_3_3 - 1 ~= var_3_2 and Utf8.utf8sub(arg_3_1, var_3_5 + 1, var_3_5 + 1) == " " or nil) and true
end

function var_0_0.filterBlack(arg_4_0, arg_4_1)
	if g.core.const.ConstMgr.PlatformConst.CLOSE_BLACK_FILTER then
		return arg_4_1
	end

	local Utf8 = require("app.core.utils.Utf8")

	if arg_4_1 == nil or type(arg_4_1) ~= "string" then
		assert("传入值为空或非string类型")

		return arg_4_1
	end

	local var_4_1, var_4_2, var_4_3 = Utf8.breakString(arg_4_1)
	local black_units = require("app.core.utils.black.black_units")
	local black_units_lang = require("app.core.utils.black.black_units_lang")
	local var_4_6 = {}

	for iter_4_0, iter_4_1 in ipairs((black_units:getWhite())) do
		local var_4_8, var_4_9 = string.find(var_4_1, iter_4_1)

		while var_4_8 and var_4_9 do
			local var_4_10 = Utf8.utf8len(iter_4_1)
			local var_4_11 = ""

			for iter_4_2 = 1, var_4_10 do
				var_4_11 = var_4_11 .. "*"
			end

			local var_4_12 = string.sub(var_4_1, 1, var_4_8 - 1)
			local var_4_13 = string.sub(var_4_1, var_4_9 + 1, #var_4_1)
			local var_4_14 = Utf8.utf8len(var_4_12)
			local var_4_15 = Utf8.utf8len(var_4_13)

			var_4_6[var_4_14 + 1 .. "_" .. var_4_14 + var_4_10] = iter_4_1
			var_4_1 = var_4_12 .. var_4_11 .. var_4_13
			var_4_8, var_4_9 = string.find(var_4_12 .. var_4_11 .. var_4_13, iter_4_1)
		end
	end

	for iter_4_3 = 1, Utf8.utf8len(var_4_1) do
		local var_4_16, var_4_17 = Utf8.utf8sub(var_4_1, iter_4_3, iter_4_3)
		local var_4_18 = black_units:get(var_4_16)

		if var_4_18 and #var_4_18 > 0 then
			for iter_4_4, iter_4_5 in ipairs(var_4_18) do
				for iter_4_6 in string.gmatch(var_4_1, iter_4_5) do
					local var_4_19 = ""

					for iter_4_7 = 1, Utf8.utf8len(iter_4_5) do
						var_4_19 = var_4_19 .. "*"
					end

					var_4_1 = string.gsub(var_4_1, iter_4_5, var_4_19)
				end
			end
		end

		local var_4_20 = black_units_lang:get(var_4_16)

		if var_4_20 and #var_4_20 > 0 then
			for iter_4_8, iter_4_9 in ipairs(var_4_20) do
				for iter_4_10 in string.gmatch(var_4_1, iter_4_9) do
					if var_0_0:isTextCharMatch(var_4_1, iter_4_10) then
						local var_4_21 = ""

						for iter_4_11 = 1, Utf8.utf8len(iter_4_9) do
							var_4_21 = var_4_21 .. "*"
						end

						var_4_1 = string.gsub(var_4_1, iter_4_9, var_4_21)
					end
				end
			end
		end
	end

	for iter_4_12, iter_4_13 in pairs(var_4_6) do
		local var_4_22 = string.split(iter_4_12, "_")

		var_4_1 = Utf8.utf8replaceByPos(var_4_1, tonumber(var_4_22[1]), tonumber(var_4_22[2]), iter_4_13)
	end

	return (Utf8.rebuildString(var_4_1, var_4_2, var_4_3))
end

function var_0_0.filterBlackOnInput(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		return
	end

	if string.sub(tolua.type(arg_5_1), 6) ~= "GTextInput" then
		return
	end

	if arg_5_1 and arg_5_1.addEventListener then
		arg_5_1:addEventListener(fgui.UIEventType.Submit, function()
			local var_6_0 = arg_5_1:getText()

			if var_6_0 == "" then
				return
			end

			arg_5_1:setText((arg_5_0:filterBlack(var_6_0)))
		end)
	end
end

return var_0_0
