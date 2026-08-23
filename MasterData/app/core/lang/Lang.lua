local var_0_0 = {}
local var_0_1 = g.core.config.language_info
local LangTemplate = import(".LangTemplate")
local LangRet = import(".LangRet")
local var_0_5 = string.find
local var_0_6 = table.concat
local var_0_7 = g.core.common.Color

function var_0_0.isLangExist(arg_1_0, arg_1_1)
	return LangTemplate[arg_1_1] ~= nil
end

function var_0_0:get(arg_2_1, arg_2_2)
	local var_2_0 = LangTemplate[arg_2_1]

	if var_0_1.fetch(tostring(arg_2_1)) then
		var_2_0 = var_0_1.get(tostring(arg_2_1))
		var_2_0 = var_2_0.value
	end

	if var_2_0 == nil then
		print("cannot get lang for key :" .. tostring(arg_2_1))

		return arg_2_1
	end

	return self:getByString(var_2_0, arg_2_2)
end

function var_0_0:getByString(arg_3_1, arg_3_2)
	if arg_3_1 == nil then
		print("cannot get lang without text")

		return ""
	end

	if arg_3_2 ~= nil then
		for iter_3_0, iter_3_1 in pairs(arg_3_2) do
			if string.find(iter_3_1, "%", 1, true) then
				iter_3_1 = table.concat(string.split(iter_3_1, "%"), "%%")
			end

			iter_3_1 = self:bigNumberToString(iter_3_1)
			arg_3_1 = string.gsub(arg_3_1, var_0_6({
				"#",
				iter_3_0,
				"#"
			}), iter_3_1)
		end
	end

	return arg_3_1
end

function var_0_0.bigNumberToString(arg_4_0, arg_4_1)
	if type(arg_4_1) == "number" and arg_4_1 >= math.pow(10, 14) then
		local MultilingualMgr = require("app.core.lang.MultilingualMgr")

		if MultilingualMgr.calcElem then
			for iter_4_0, iter_4_1 in ipairs(g.core.model.User.translateData:getTranslateLangNum((MultilingualMgr:getUseLang())).calcElem) do
				if arg_4_1 >= math.pow(10, iter_4_1.up) then
					arg_4_1 = string.format("%." .. iter_4_1.pointEx .. "f", arg_4_1 / math.pow(10, iter_4_1.calc))
					arg_4_1 = arg_4_1 .. iter_4_1.tail

					break
				end
			end
		elseif arg_4_1 >= math.pow(10, 20) then
			arg_4_1 = string.format("%.0f", arg_4_1 / math.pow(10, 18))
			arg_4_1 = arg_4_1 .. g.core.lang:get(143)
		elseif arg_4_1 >= math.pow(10, 17) then
			arg_4_1 = string.format("%.0f", arg_4_1 / math.pow(10, 15))
			arg_4_1 = arg_4_1 .. g.core.lang:get(142)
		end
	end

	return arg_4_1
end

function var_0_0:getRet(arg_5_1)
	local var_5_0 = g.core.config.net_msg_error.fetch(arg_5_1)

	if var_5_0 then
		return var_5_0.error_msg
	end

	local var_5_1 = LangRet[var_0_6({
		"RET_",
		arg_5_1
	})]

	if var_5_1 == nil then
		print("cannot get ret information for id :" .. tostring(arg_5_1))

		return self:get(1002, {
			ret = arg_5_1
		})
	end

	return var_5_1
end

function var_0_0.getAttrValue(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = "%d"

	if arg_6_2 then
		local var_6_1 = arg_6_2

		if g.core.config.attribute_info.get(arg_6_1).value_format == 2 then
			arg_6_2 = arg_6_2 / 10
			var_6_0 = arg_6_2 == math.floor(var_6_1 / 10) and "%d%%" or "%.1f%%"
		end

		if not arg_6_3 and var_6_1 > 0 then
			var_6_0 = var_0_6({
				"+",
				var_6_0
			})
		end
	end

	return (arg_6_2 or nil) and string.format(var_6_0, arg_6_2)
end

function var_0_0:getAttr(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_1 <= 0 then
		return "", ""
	end

	return g.core.config.attribute_info.get(arg_7_1).name, (self:getAttrValue(arg_7_1, arg_7_2, arg_7_3))
end

function var_0_0:getAttrDelta(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_1 <= 0 then
		return "", ""
	end

	local var_8_0 = g.core.config.attribute_info.get(arg_8_1).name
	local var_8_1
	local var_8_2
	local var_8_3

	if arg_8_2 and arg_8_3 then
		var_8_1 = self:getAttrValue(arg_8_1, arg_8_2, arg_8_4)
		var_8_2 = self:getAttrValue(arg_8_1, arg_8_3, arg_8_4)
		var_8_3 = self:getAttrValue(arg_8_1, arg_8_3 - arg_8_2, arg_8_4)
	end

	return var_8_0, var_8_1, var_8_2, var_8_3
end

function var_0_0.getBroadCastString(arg_9_0, arg_9_1)
	if arg_9_1.id == nil or arg_9_1.id == 0 then
		return "", {}
	end

	local var_9_0 = arg_9_1.params or {}
	local var_9_1 = arg_9_1.awards or {}
	local var_9_2 = arg_9_1.isLightColor
	local var_9_3 = {}
	local var_9_4 = g.core.common.Goods
	local var_9_5 = g.core.config.notice_info.get(arg_9_1.id)

	if arg_9_1.isLightColor then
		-- block empty
	end

	local var_9_8 = {}

	for iter_9_0 = 1, #var_9_0 do
		if var_9_0[iter_9_0].key == "baseid" and tonumber(var_9_0[iter_9_0].value) ~= 0 then
			local var_9_9 = g.core.config.knight_info.get(tonumber(var_9_0[iter_9_0].value))

			if var_9_2 then
				-- block empty
			end

			break
		end
	end

	for iter_9_1 = 1, #var_9_0 do
		if var_9_0[iter_9_1].key ~= "baseid" then
			local var_9_12 = var_9_0[iter_9_1].key
			local var_9_13 = ""

			if var_9_0[iter_9_1].key == "name" then
				var_9_13 = "[color=#008d0a][" .. var_9_0[iter_9_1].value .. "][/color]"
			elseif var_9_12 == "mine" then
				local var_9_14 = g.core.config.mine_map_info.get(tonumber(var_9_0[iter_9_1].value))

				var_9_13 = "[color=#" .. ((var_9_2 or nil) and g.core.common.Color.qualityEx[var_9_14.quality]) .. "]" .. var_9_14.name .. "[/color]"
			elseif var_9_12 == "wrest" then
				local var_9_16 = g.core.config.wrest_city_info.get(tonumber(var_9_0[iter_9_1].value))

				var_9_13 = "[color=#" .. ((var_9_2 or nil) and g.core.common.Color.qualityEx[var_9_16.quality]) .. "]" .. var_9_16.name .. "[/color]"
			elseif var_9_12 == "union" then
				var_9_13 = g.core.lang:get(1280 + tonumber(var_9_0[iter_9_1].value))
			elseif var_9_12 == "build_name" then
				var_9_13 = g.core.lang:get(var_9_0[iter_9_1].value)
			elseif var_9_12 == "recruit_base_id" then
				var_9_12 = "pondname"
				var_9_13 = g.core.lang:get(1299)

				for iter_9_2, iter_9_3 in g.core.config.recruit_knight_display_info.ipairs() do
					if iter_9_3.recruit_id == tonumber(var_9_0[iter_9_1].value) then
						var_9_13 = iter_9_3.name

						break
					end
				end

				local var_9_18 = {}

				for iter_9_4, iter_9_5 in ipairs(var_9_1) do
					local var_9_19 = var_9_4:convert(iter_9_5)

					if var_9_19.quality >= g.core.const.ConstMgr.QUALITY_TYPE.SSR and var_9_19.type ~= var_9_4.TYPE_ITEM and var_9_19.type ~= var_9_4.TYPE_RESOURCE and var_9_19.type ~= var_9_4.TYPE_FRAGMENT then
						table.insert(var_9_18, iter_9_5)
					end
				end

				var_9_1 = var_9_18
				var_9_3.recruitNum = #var_9_18
			elseif var_9_12 == "round" then
				var_9_13 = g.core.lang:get(1290 + tonumber(var_9_0[iter_9_1].value))
			elseif var_9_12 == "advance_id" then
				var_9_12 = "heroname"
				var_9_13 = g.core.config.knight_base_info.get(tonumber(var_9_0[iter_9_1].value)).name
			else
				var_9_13 = var_9_0[iter_9_1].value
			end

			table.insert(var_9_8, {
				[var_9_12] = var_9_13
			})
		end
	end

	local var_9_20 = var_9_5.content
	local var_9_21, var_9_22, var_9_23 = var_0_5(var_9_5.content, "#$([0-9a-zA-Z_]+s?)#")

	if var_9_23 then
		local var_9_24 = var_0_5(var_9_23, "s") == #var_9_23

		if var_0_5(var_9_23, "item_name") then
			local var_9_25 = ""

			for iter_9_6, iter_9_7 in ipairs(var_9_1) do
				local var_9_26

				if iter_9_6 ~= 1 then
					var_9_25 = var_9_25 .. "、"
					var_9_26 = var_9_25
				end

				var_9_25 = var_9_25 .. var_9_4:convert(iter_9_7).name

				if not var_9_24 then
					break
				end
			end

			local var_9_27 = {}

			var_9_27[var_9_24 and "$item_names" or "$item_name"] = var_9_25

			table.insert(var_9_8, var_9_27)
		elseif var_0_5(var_9_23, "item") then
			local var_9_28 = ""

			for iter_9_8, iter_9_9 in ipairs(var_9_1) do
				if iter_9_8 ~= 1 then
					var_9_28 = var_9_28 .. "、"
				end

				local var_9_29 = var_9_4:convert(iter_9_9)

				var_9_28 = var_9_28 .. "[color=#" .. var_0_7.getJGameQualityColorEx(var_9_29.quality) .. "]" .. var_9_29.name .. "x" .. var_9_29.size .. "[/color]"

				if not var_9_24 then
					break
				end
			end

			local var_9_30 = {}

			var_9_30[var_9_24 and "$items" or "$item"] = var_9_28

			table.insert(var_9_8, var_9_30)
		end
	end

	for iter_9_10, iter_9_11 in ipairs(var_9_8) do
		var_9_20 = g.core.lang:getByString(var_9_20, iter_9_11)
	end

	return var_9_20, var_9_3
end

function var_0_0.getFormatLongText(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		return ""
	end

	if type(arg_10_2) ~= "number" then
		return arg_10_1
	end

	if arg_10_2 >= #string.gsub(arg_10_1, "[\x80-\xBF]", "") then
		return arg_10_1
	else
		local var_10_0 = "^"

		for iter_10_0 = 1, (not arg_10_3 or nil) and arg_10_2 - 1 do
			var_10_0 = var_10_0 .. ".[\x80-\xBF]*"
		end

		local var_10_2 = string.match(arg_10_1, var_10_0)

		if arg_10_3 then
			return string.format("%s", var_10_2)
		else
			return string.format("%s...", var_10_2)
		end
	end
end

function var_0_0.getFormatNumText(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return g.core.utils.Number.transTextNumFormation(arg_11_1)
end

function var_0_0.spliteTxt(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = 1

	while var_12_1 <= string.len(arg_12_1) do
		local var_12_3 = string.byte(arg_12_1, var_12_1)
		local var_12_4 = 1
		local var_12_5, var_12_6

		if var_12_3 < 192 then
			var_12_4 = 1
		elseif var_12_3 < 224 then
			var_12_4 = 2
		elseif var_12_3 < 240 then
			var_12_4 = 3
		elseif var_12_3 < 248 then
			var_12_4 = 4
		elseif var_12_3 < 252 then
			var_12_4 = 5
			var_12_1 = var_12_1 + var_12_4
			var_12_5 = var_12_0
			var_12_6 = {
				byteNum = var_12_4
			}
		end

		var_12_6.char = string.sub(arg_12_1, var_12_1, var_12_1 + var_12_4 - 1)

		table.insert(var_12_0, var_12_6)
	end

	return var_12_0
end

function var_0_0.getCocosRealRichTxt(arg_13_0, arg_13_1)
	local var_13_0 = string.split(arg_13_1, "&")

	for iter_13_0 = 2, #var_13_0, 2 do
		local var_13_1 = tonumber(string.match(var_13_0[iter_13_0], "%d+")) or 1
		local var_13_2 = string.split(var_13_0[iter_13_0], ">")[2] or ""

		print("richTxt  " .. var_13_2)

		var_13_0[iter_13_0] = g.core.common.Color.ui[var_13_1] .. "|" .. var_13_2
	end

	return var_13_0
end

function var_0_0.getRichTxtToBasicTtx(arg_14_0, arg_14_1)
	local var_14_0 = string.split(arg_14_1, "&")

	for iter_14_0 = 2, #var_14_0, 2 do
		var_14_0[iter_14_0] = string.split(var_14_0[iter_14_0], ">")[2] or ""
	end

	return (table.concat(var_14_0))
end

function var_0_0.getRealRichTxt(arg_15_0, arg_15_1)
	local var_15_0 = string.split(arg_15_1, "&")

	for iter_15_0 = 2, #var_15_0, 2 do
		local var_15_1 = tonumber(string.match(var_15_0[iter_15_0], "%d+")) or 1
		local var_15_2 = string.split(var_15_0[iter_15_0], ">")[2] or ""

		if var_15_1 and var_15_1 > 0 then
			if g.core.common.Color.ui[var_15_1] then
				var_15_0[iter_15_0] = var_0_6({
					"[color=",
					g.core.common.Color.ui[var_15_1],
					"]",
					var_15_2,
					"[/color]"
				})
			end
		end
	end

	return (table.concat(var_15_0))
end

function var_0_0.getFormatServerName(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 or arg_16_1 == "" then
		return "", ""
	end

	local var_16_0 = ""
	local var_16_1 = string.match(arg_16_1, "%d+")

	if var_16_1 then
		var_16_0 = g.core.lang:get(1003, {
			num = var_16_1
		})
	elseif not arg_16_2 then
		var_16_0 = var_0_6({
			"（",
			arg_16_1,
			"）"
		})
	end

	return string.split(string.split(arg_16_1, "(")[1], "（")[1], var_16_0
end

function var_0_0.getServerNo(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 or arg_17_1 == "" then
		return ""
	end

	local var_17_0 = ""
	local var_17_1 = string.match(arg_17_1, "%d+")

	if var_17_1 then
		var_17_0 = g.core.lang:get(1190, {
			num = var_17_1
		})
	elseif not arg_17_2 then
		var_17_0 = arg_17_1
	end

	return var_17_0
end

function var_0_0.getNormalText(arg_18_0, arg_18_1)
	if type(arg_18_1) ~= "string" then
		return arg_18_1
	end

	arg_18_1 = string.gsub(arg_18_1, "]", "*")
	arg_18_1 = string.gsub(arg_18_1, "<", "*")
	arg_18_1 = string.gsub(arg_18_1, "#", "*")
	arg_18_1 = string.gsub(arg_18_1, "\"", "*")

	return arg_18_1
end

function var_0_0.getServerRealValue(arg_19_0, arg_19_1, arg_19_2)
	if string.find(arg_19_1, ".+L$") then
		return g.core.lang:get(arg_19_2)
	else
		return arg_19_2
	end
end

function var_0_0.getStringLength(arg_20_0, arg_20_1)
	if not arg_20_1 then
		return 0
	end

	local var_20_0 = {}

	for iter_20_0 in string.gmatch(arg_20_1, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		var_20_0[#var_20_0 + 1] = iter_20_0
	end

	return #var_20_0
end

return var_0_0
