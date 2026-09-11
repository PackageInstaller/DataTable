local var_0_0 = {}
local var_0_1 = {
	[1001] = function(arg_1_0)
		local var_1_0 = DormInfomationData:GetParams(arg_1_0)
		local var_1_1 = {}

		if not BackhomeContentNoticeCfg[arg_1_0].marquee then
			return {}
		end

		if var_1_0[1] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[1], HeroTools.GetHeroFullName(var_1_0[1])))
		end

		if var_1_0[2] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[2], BackHomeCanteenFoodCfg[var_1_0[2]].name))
		end

		if var_1_0[3] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[3], var_1_0[3]))
		end

		if var_1_0[4] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[4], var_1_0[4]))
		end

		if var_1_0[5] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[5], var_1_0[5]))
		end

		if var_1_0[6] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[6], var_1_0[6]))
		end

		if var_1_0[7] ~= -1 then
			table.insert(var_1_1, string.format(BackhomeContentNoticeCfg[arg_1_0].marquee[7], var_1_0[7]))
		end

		return var_1_1
	end,
	[2001] = function(arg_2_0)
		local var_2_0 = DormInfomationData:GetParams(arg_2_0)
		local var_2_1 = {}

		if not BackhomeContentNoticeCfg[arg_2_0].marquee then
			return {}
		end

		if var_2_0[1] ~= -1 then
			table.insert(var_2_1, string.format(BackhomeContentNoticeCfg[arg_2_0].marquee[1], HeroTools.GetHeroFullName(var_2_0[1]), var_2_0[2]))
		end

		if var_2_0[3] ~= -1 then
			table.insert(var_2_1, string.format(BackhomeContentNoticeCfg[arg_2_0].marquee[2], var_2_0[3]))
		end

		if var_2_0[4] ~= -1 then
			table.insert(var_2_1, string.format(BackhomeContentNoticeCfg[arg_2_0].marquee[3], var_2_0[4]))
		end

		if var_2_0[5] ~= -1 then
			table.insert(var_2_1, string.format(BackhomeContentNoticeCfg[arg_2_0].marquee[4], var_2_0[5]))
		end

		return var_2_1
	end,
	[3001] = function(arg_3_0)
		local var_3_0 = DormInfomationData:GetParams(arg_3_0)
		local var_3_1 = {}

		if not BackhomeContentNoticeCfg[arg_3_0].marquee then
			return {}
		end

		local var_3_2 = ""

		if var_3_0 ~= "" then
			for iter_3_0, iter_3_1 in ipairs(var_3_0) do
				var_3_2 = iter_3_0 == 1 and var_3_2 .. ItemCfg[iter_3_1].name or "、" .. var_3_2 .. ItemCfg[iter_3_1].name
			end
		end

		table.insert(var_3_1, string.format(BackhomeContentNoticeCfg[arg_3_0].marquee[1], var_3_2))

		return var_3_1
	end,
	[4001] = function(arg_4_0)
		local var_4_0 = DormInfomationData:GetParams(arg_4_0)
		local var_4_1 = {}

		if not BackhomeContentNoticeCfg[arg_4_0].marquee then
			return {}
		end

		local var_4_2 = ""

		if var_4_0 ~= "" then
			for iter_4_0, iter_4_1 in ipairs(var_4_0) do
				var_4_2 = iter_4_0 == 1 and var_4_2 .. HeroTools.GetHeroFullName(iter_4_1) or "、" .. var_4_2 .. HeroTools.GetHeroFullName(iter_4_1)
			end
		end

		table.insert(var_4_1, string.format(BackhomeContentNoticeCfg[arg_4_0].marquee[1], var_4_2))

		return var_4_1
	end,
	[5001] = function(arg_5_0)
		local var_5_0 = DormInfomationData:GetParams(arg_5_0)
		local var_5_1 = {}

		if not BackhomeContentNoticeCfg[arg_5_0].marquee then
			return {}
		end

		local var_5_2 = ""

		if var_5_0 ~= "" then
			for iter_5_0, iter_5_1 in ipairs(var_5_0) do
				var_5_2 = iter_5_0 == 1 and var_5_2 .. IdolDanceDIYActionCfg[iter_5_1].name or "、" .. var_5_2 .. IdolDanceDIYActionCfg[iter_5_1].name
			end
		end

		table.insert(var_5_1, string.format(BackhomeContentNoticeCfg[arg_5_0].marquee[1], var_5_2))

		return var_5_1
	end,
	[6001] = function(arg_6_0)
		local var_6_0 = DormInfomationData:GetParams(arg_6_0)
		local var_6_1 = {}

		if not BackhomeContentNoticeCfg[arg_6_0].marquee then
			return {}
		end

		local var_6_2 = ""

		if var_6_0 ~= "" then
			for iter_6_0, iter_6_1 in ipairs(var_6_0) do
				var_6_2 = iter_6_0 == 1 and var_6_2 .. HeroTools.GetHeroFullName(iter_6_1) or "、" .. var_6_2 .. HeroTools.GetHeroFullName(iter_6_1)
			end
		end

		table.insert(var_6_1, string.format(BackhomeContentNoticeCfg[arg_6_0].marquee[1], var_6_2))

		return var_6_1
	end
}

function var_0_0.GetContent(arg_7_0, arg_7_1)
	if var_0_1[arg_7_1] then
		return var_0_1[arg_7_1](arg_7_1)
	end

	return {}
end

return var_0_0
