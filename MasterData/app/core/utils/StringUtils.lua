return {
	getCostNumRichText = function(arg_1_0, arg_1_1)
		return (arg_1_0 < arg_1_1 or nil) and "[color=#d24b44]" .. arg_1_0 .. "[/color]/" .. arg_1_1
	end,
	getChineseDonut = function()
		return "、"
	end,
	strNumToRGB = function(arg_3_0)
		local var_3_0 = string.len(arg_3_0) == 6 and arg_3_0 or string.sub(arg_3_0, 1, 7)

		return {
			r = tonumber(string.sub(var_3_0, 1, 2), 16),
			g = tonumber(string.sub(var_3_0, 3, 4), 16),
			b = tonumber(string.sub(var_3_0, 5, 6), 16)
		}
	end,
	splitStringToList = function(arg_4_0)
		local var_4_0 = {}
		local var_4_1 = 1

		while var_4_1 <= #arg_4_0 do
			local var_4_2 = string.byte(arg_4_0, var_4_1)
			local var_4_3 = 1

			if var_4_2 > 0 and var_4_2 <= 127 then
				var_4_3 = 1
			elseif var_4_2 > 192 and var_4_2 <= 223 then
				var_4_3 = 2
			elseif var_4_2 > 224 and var_4_2 <= 239 then
				var_4_3 = 3
			elseif var_4_2 > 240 and var_4_2 <= 247 then
				var_4_3 = 4
				var_4_1 = var_4_1 + var_4_3
			end

			var_4_0[#var_4_0 + 1] = string.sub(arg_4_0, var_4_1, var_4_1 + var_4_3 - 1)
		end

		return var_4_0
	end,
	splitString = function(arg_5_0, arg_5_1)
		arg_5_0 = arg_5_0 or ""

		local var_5_0 = {}
		local var_5_1 = 1
		local var_5_2 = 0
		local var_5_3 = ""

		while var_5_1 <= #arg_5_0 do
			local var_5_4 = string.byte(arg_5_0, var_5_1)
			local var_5_5 = 1

			if var_5_4 >= 48 and var_5_4 <= 57 or var_5_4 >= 65 and var_5_4 <= 90 or var_5_4 >= 97 and var_5_4 <= 122 then
				var_5_5 = 1
				var_5_2 = var_5_2 + 1
			elseif var_5_4 > 192 and var_5_4 <= 223 then
				var_5_5 = 2
				var_5_2 = 0
			elseif var_5_4 > 224 and var_5_4 <= 239 then
				var_5_5 = 3
				var_5_2 = 0
			elseif var_5_4 > 240 and var_5_4 <= 247 then
				var_5_5 = 4
				var_5_2 = 0
			else
				var_5_5 = 1
				var_5_2 = 0
			end

			local var_5_6 = string.sub(arg_5_0, var_5_1, var_5_1 + var_5_5 - 1)

			var_5_1 = var_5_1 + var_5_5
			var_5_0[#var_5_0 + 1] = var_5_6
			var_5_3 = var_5_3 .. var_5_6

			if var_5_2 > 18 then
				if var_5_6 == " " then
					var_5_2 = 0
				end

				if arg_5_1 and arg_5_1:getTextSize().width > 257 then
					var_5_2 = 0
					var_5_3 = var_5_3 .. " "
				end
			end
		end

		return var_5_3
	end,
	dealMailStr = function(arg_6_0, arg_6_1)
		local var_6_0 = "#(.-)#"
		local var_6_1 = "#(.-)|(.-_info)|(.-)#"

		arg_6_0 = string.gsub(arg_6_0, "#.-#", function(arg_7_0)
			local var_7_0, var_7_1, var_7_2, var_7_3, var_7_4 = string.find(arg_7_0, var_6_1)

			if var_7_0 then
				return g.core.config[var_7_3].get(tonumber(arg_6_1[var_7_2]))[var_7_4]
			else
				local var_7_5, var_7_6, var_7_7 = string.find(arg_7_0, var_6_0)

				return arg_6_1[var_7_7]
			end
		end)

		return arg_6_0
	end,
	convertStrToEmoji = function(arg_8_0)
		if arg_8_0 then
			arg_8_0 = string.gsub(arg_8_0, "*(%d+).png", function(arg_9_0)
				return "<img src = '" .. g.core.common.Path:getChatEmojiIcon(arg_9_0) .. "' width='30'height='30'/>"
			end)

			return arg_8_0
		end

		return ""
	end,
	serverName = function(arg_10_0)
		local var_10_0, var_10_1, var_10_2 = string.find(arg_10_0, "(%(.+%d+%))")

		var_10_2 = var_10_2 or arg_10_0

		return var_10_2
	end,
	splitStringByChar = function(arg_11_0, arg_11_1)
		local var_11_0 = {}

		while true do
			local var_11_1 = string.find(arg_11_0, arg_11_1)

			if not var_11_1 then
				var_11_0[#var_11_0 + 1] = arg_11_0

				break
			end

			var_11_0[#var_11_0 + 1] = string.sub(arg_11_0, 1, var_11_1 - 1)
			arg_11_0 = string.sub(arg_11_0, var_11_1 + 1, #arg_11_0)
		end

		return var_11_0
	end,
	formatText = function(arg_12_0, arg_12_1)
		if not arg_12_0 or type(arg_12_1) ~= "table" then
			return ""
		end

		local var_12_0 = arg_12_0

		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			var_12_0 = string.gsub(var_12_0, "#" .. iter_12_0 .. "#", iter_12_1)
		end

		return var_12_0
	end,
	autoNewLine = function(arg_13_0, arg_13_1, arg_13_2)
		arg_13_2 = arg_13_2 or 0

		local var_13_0 = ""
		local var_13_1 = {}

		if not arg_13_0 or arg_13_1 < 1 then
			return var_13_0
		end

		arg_13_1 = arg_13_1 * 3

		while arg_13_1 < #arg_13_0 do
			var_13_0 = var_13_0 .. string.sub(arg_13_0, 1, arg_13_1) .. "\n"

			table.insert(var_13_1, string.sub(arg_13_0, 1, arg_13_1))

			arg_13_0 = string.sub(arg_13_0, arg_13_1 + 1, #arg_13_0)
		end

		local var_13_2 = var_13_0 .. arg_13_0

		table.insert(var_13_1, arg_13_0)

		if arg_13_2 == 0 then
			return var_13_2
		else
			return var_13_1
		end
	end,
	stringToCharList = function(arg_14_0, arg_14_1)
		local var_14_0 = {}

		for iter_14_0 in string.gfind(arg_14_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
			var_14_0[#var_14_0 + 1] = iter_14_0

			if arg_14_1 <= #var_14_0 then
				break
			end
		end

		return var_14_0
	end,
	checkSpecialSign = function(arg_15_0)
		local var_15_0 = {
			" ",
			"'",
			"\"",
			"\\",
			"~",
			"`",
			"<",
			">",
			",",
			"%%",
			"_"
		}

		for iter_15_0 = 1, #var_15_0 do
			if string.find(arg_15_0, var_15_0[iter_15_0]) then
				return true
			end
		end

		return false
	end,
	trim = function(arg_16_0)
		return (string.gsub(arg_16_0, "^%s*(.-)%s*$", "%1"))
	end,
	formatSkillDesc = function(arg_17_0)
		local var_17_0 = g.core.config.skill_info.get(arg_17_0)

		if not var_17_0 then
			return ""
		end

		return (g.core.utils.String.formatCfgDescByPattern(var_17_0.description, var_17_0, "skill_info"))
	end,
	formatSkillEnchantInfoDesc = function(arg_18_0, arg_18_1)
		if arg_18_1 == 1 then
			local var_18_0 = g.core.config.skill_info.get(arg_18_0)

			if not var_18_0 then
				return ""
			end

			return g.core.utils.String.formatCfgDescByPattern(var_18_0.description, var_18_0, "skill_info"), ""
		elseif arg_18_1 == 4 then
			local var_18_1 = g.core.config.skill_enchant_info.get(arg_18_0)

			if not var_18_1 then
				return ""
			end

			return g.core.utils.String.formatCfgDescByPattern(var_18_1.description, var_18_1, "skill_enchant_info"), (var_18_1.split_description_2 > 0 or nil) and g.core.utils.String.formatBuffDesc(var_18_1.split_description_2)
		end

		return "", ""
	end,
	formatSkillSplitDesc = function(arg_19_0)
		local var_19_0 = g.core.config.skill_info.get(arg_19_0)

		if not var_19_0 then
			return ""
		end

		local var_19_1 = var_19_0.split_description_2
		local var_19_2 = {}

		for iter_19_0, iter_19_1 in ipairs((string.split(var_19_0.split_description_2, ";"))) do
			if tonumber(iter_19_1) and tonumber(iter_19_1) > 0 then
				table.insert(var_19_2, g.core.utils.String.formatBuffDesc(tonumber(iter_19_1)))
			end
		end

		if #var_19_2 > 0 then
			return table.concat(var_19_2, "\n")
		else
			return g.core.utils.String.paintDescColorful(var_19_1)
		end
	end,
	formatPassiveSkillDesc = function(arg_20_0)
		if arg_20_0 == 0 then
			return "", ""
		end

		local var_20_0 = g.core.config.passive_skill_info.get(arg_20_0)

		if not var_20_0 then
			return "", ""
		end

		if var_20_0.passive_skill_type == 1 and var_20_0.passive_skill_value > 0 then
			return g.core.utils.String.formatSkillDesc(var_20_0.passive_skill_value), (g.core.utils.String.formatSkillSplitDesc(var_20_0.passive_skill_value))
		end

		return g.core.utils.String.paintDescColorful(var_20_0.description), ""
	end,
	formatBuffDesc = function(arg_21_0)
		local var_21_0 = g.core.config.buff_info.get(arg_21_0)

		if not var_21_0 then
			return ""
		end

		return (g.core.utils.String.formatCfgDescByPattern(var_21_0.buff_name, var_21_0, "buff_info"))
	end,
	formatCfgDescByPattern = function(arg_22_0, arg_22_1, arg_22_2)
		if not arg_22_0 or not arg_22_1 or not arg_22_2 then
			return arg_22_0
		end

		local var_22_0 = {}

		for iter_22_0 in string.gmatch(arg_22_0, "#[%w_]+#") do
			local var_22_1 = string.match(iter_22_0, "[%w_]+")

			if var_22_1 then
				local var_22_2 = string.sub(var_22_1, 1, -2)
				local var_22_3 = string.sub(var_22_1, -1, -1)

				if g.core.config[arg_22_2].hasKey(var_22_2) then
					if var_22_3 == "N" then
						var_22_0[var_22_1] = arg_22_1[var_22_2]

						if g.core.const.ConstMgr.BASE_CONST.SKILL_AUTO_COLOR then
							var_22_0[var_22_1] = "[color=#" .. g.core.config.skill_colour_info.indexOf(1).keywords_colour .. "]" .. arg_22_1[var_22_2] .. "[/color]"
						end
					elseif var_22_3 == "P" then
						var_22_0[var_22_1] = tostring(arg_22_1[var_22_2] / 10) .. "%"
					elseif var_22_3 == "B" then
						if arg_22_1[var_22_2] > 0 then
							var_22_0[var_22_1] = g.core.utils.String.formatBuffDesc(arg_22_1[var_22_2])
						end
					else
						dump("errrrrrrrror pattern")
					end
				elseif var_22_3 == "S" then
					local var_22_4 = tonumber(var_22_2)

					if type(var_22_4) == "number" and var_22_4 > 0 and g.core.config.skill_info.fetch(var_22_4) then
						var_22_0[var_22_1] = g.core.utils.String.formatSkillDesc(var_22_4)
					end
				else
					dump("errrrrrrrror cfgId")
				end
			end
		end

		if next(var_22_0) then
			arg_22_0 = g.core.lang:getByString(arg_22_0, var_22_0)
		end

		return g.core.utils.String.paintDescColorful(arg_22_0)
	end,
	paintDescColorful = function(arg_23_0)
		if g.core.const.ConstMgr.BASE_CONST.SKILL_AUTO_COLOR then
			local var_23_0 = g.core.config.skill_colour_info.indexOf(1).keywords_colour

			arg_23_0 = string.gsub(arg_23_0, "%d*%.?%d+%%", function(arg_24_0)
				return "[color=#" .. var_23_0 .. "]" .. arg_24_0 .. "[/color]"
			end)
			arg_23_0 = string.gsub(arg_23_0, "【", function(arg_25_0)
				return "[color=#" .. var_23_0 .. "]" .. arg_25_0
			end)
			arg_23_0 = string.gsub(arg_23_0, "】", function(arg_26_0)
				return arg_26_0 .. "[/color]"
			end)

			local var_23_1 = {}

			for iter_23_0 = 2, g.core.config.skill_colour_info.getLength() do
				local var_23_2 = g.core.config.skill_colour_info.indexOf(iter_23_0)

				table.insert(var_23_1, {
					desc = var_23_2.keywords,
					color = "[color=#" .. var_23_2.keywords_colour .. "]"
				})
			end

			for iter_23_1 = 1, #var_23_1 do
				arg_23_0 = string.gsub(arg_23_0, var_23_1[iter_23_1].desc, function(arg_27_0)
					return var_23_1[iter_23_1].color .. arg_27_0 .. "[/color]"
				end)
			end
		end

		return arg_23_0
	end,
	paintDescGreyColorful = function(arg_28_0)
		if g.core.const.ConstMgr.BASE_CONST.SKILL_AUTO_COLOR then
			for iter_28_0 = 1, g.core.config.skill_colour_info.getLength() do
				local var_28_0 = g.core.config.skill_colour_info.indexOf(iter_28_0)

				arg_28_0 = string.gsub(arg_28_0, var_28_0.keywords_colour, var_28_0.grey_colour)
			end
		end

		return arg_28_0
	end,
	transRobotName = function(self)
		if not self then
			return ""
		end

		local var_29_0 = self.name or ""

		if self.robot_type and self.robot_type ~= 0 or self.robotId and self.robotId > 0 or self.checkStr and string.match(var_29_0, "_name") then
			var_29_0 = g.core.config.language_info.get(var_29_0).value
		end

		return var_29_0
	end,
	getCharactersNum = function(arg_30_0, arg_30_1)
		arg_30_1 = arg_30_1 or 2

		local function var_30_0(arg_31_0)
			local var_31_0 = {
				0,
				192,
				224,
				240
			}

			for iter_31_0 = #var_31_0, 1, -1 do
				if arg_31_0 >= var_31_0[iter_31_0] then
					return iter_31_0
				end
			end

			return 1
		end

		local var_30_1 = 1
		local var_30_2 = 0

		while var_30_1 <= #arg_30_0 do
			local var_30_3 = var_30_0(string.byte(arg_30_0, var_30_1))

			var_30_2 = var_30_2 + (arg_30_1 < var_30_3 and arg_30_1 or var_30_3)
			var_30_1 = var_30_1 + var_30_3
		end

		return var_30_2
	end,
	subStringByShow = function(arg_32_0, arg_32_1)
		local var_32_0 = 0
		local var_32_1 = 0

		for iter_32_0 in string.gmatch(arg_32_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
			var_32_0 = #iter_32_0 ~= 1 and var_32_0 + 2 or var_32_0 + 1

			if var_32_0 <= arg_32_1 then
				var_32_1 = var_32_1 + #iter_32_0
			else
				return string.sub(arg_32_0, 1, var_32_1)
			end
		end

		return arg_32_0
	end,
	checkChannelStr = function(arg_33_0)
		if g.core.platform.PlatformProxy:isChannelOfKr() or config.PUBLISH_REGION == 6 then
			if string.find(arg_33_0, "^[ \t\n\r]+") or string.find(arg_33_0, "[ \t\n\r]+$") then
				return g.core.lang:get(100302)
			end

			local var_33_0 = 0
			local var_33_1 = 0

			for iter_33_0 = 1, string.len(arg_33_0) do
				if string.sub(arg_33_0, iter_33_0, iter_33_0) == " " then
					var_33_0 = var_33_0 + 1

					if var_33_0 > 1 then
						return g.core.lang:get(100301)
					else
						var_33_1 = var_33_1 + 1
					end
				else
					var_33_0 = 0
				end
			end

			if var_33_1 > 4 then
				return g.core.lang:get(100303)
			else
				return nil, var_33_1
			end
		else
			return nil, 0
		end
	end
}
