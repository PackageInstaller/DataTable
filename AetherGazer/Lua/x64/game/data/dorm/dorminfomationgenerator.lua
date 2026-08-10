local var_0_0 = {}
local var_0_1 = {
	[1001] = function(arg_1_0)
		local var_1_0 = BackhomeContentNoticeCfg[arg_1_0]
		local var_1_1 = DormInfomationData:GetParams(arg_1_0)
		local var_1_2 = {}

		if not var_1_0.marquee then
			return {}
		end

		if var_1_1[1] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[1], HeroTools.GetHeroFullName(var_1_1[1])))
		end

		if var_1_1[2] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[2], BackHomeCanteenFoodCfg[var_1_1[2]].name))
		end

		if var_1_1[3] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[3], var_1_1[3]))
		end

		if var_1_1[4] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[4], var_1_1[4]))
		end

		if var_1_1[5] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[5], var_1_1[5]))
		end

		if var_1_1[6] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[6], var_1_1[6]))
		end

		if var_1_1[7] ~= -1 then
			table.insert(var_1_2, string.format(var_1_0.marquee[7], var_1_1[7]))
		end

		return var_1_2
	end,
	[2001] = function(arg_2_0)
		local var_2_0 = BackhomeContentNoticeCfg[arg_2_0]
		local var_2_1 = DormInfomationData:GetParams(arg_2_0)
		local var_2_2 = {}

		if not var_2_0.marquee then
			return {}
		end

		if var_2_1[1] ~= -1 then
			table.insert(var_2_2, string.format(var_2_0.marquee[1], HeroTools.GetHeroFullName(var_2_1[1]), var_2_1[2]))
		end

		if var_2_1[3] ~= -1 then
			table.insert(var_2_2, string.format(var_2_0.marquee[2], var_2_1[3]))
		end

		if var_2_1[4] ~= -1 then
			table.insert(var_2_2, string.format(var_2_0.marquee[3], var_2_1[4]))
		end

		if var_2_1[5] ~= -1 then
			table.insert(var_2_2, string.format(var_2_0.marquee[4], var_2_1[5]))
		end

		return var_2_2
	end,
	[3001] = function(arg_3_0)
		local var_3_0 = BackhomeContentNoticeCfg[arg_3_0]
		local var_3_1 = DormInfomationData:GetParams(arg_3_0)
		local var_3_2 = {}

		if not var_3_0.marquee then
			return {}
		end

		local var_3_3 = ""

		if var_3_1 ~= "" then
			for iter_3_0, iter_3_1 in ipairs(var_3_1) do
				if iter_3_0 == 1 then
					var_3_3 = var_3_3 .. ItemCfg[iter_3_1].name
				else
					var_3_3 = "、" .. var_3_3 .. ItemCfg[iter_3_1].name
				end
			end
		end

		table.insert(var_3_2, string.format(var_3_0.marquee[1], var_3_3))

		return var_3_2
	end,
	[4001] = function(arg_4_0)
		local var_4_0 = BackhomeContentNoticeCfg[arg_4_0]
		local var_4_1 = DormInfomationData:GetParams(arg_4_0)
		local var_4_2 = {}

		if not var_4_0.marquee then
			return {}
		end

		local var_4_3 = ""

		if var_4_1 ~= "" then
			for iter_4_0, iter_4_1 in ipairs(var_4_1) do
				if iter_4_0 == 1 then
					var_4_3 = var_4_3 .. HeroTools.GetHeroFullName(iter_4_1)
				else
					var_4_3 = "、" .. var_4_3 .. HeroTools.GetHeroFullName(iter_4_1)
				end
			end
		end

		table.insert(var_4_2, string.format(var_4_0.marquee[1], var_4_3))

		return var_4_2
	end,
	[5001] = function(arg_5_0)
		local var_5_0 = BackhomeContentNoticeCfg[arg_5_0]
		local var_5_1 = DormInfomationData:GetParams(arg_5_0)
		local var_5_2 = {}

		if not var_5_0.marquee then
			return {}
		end

		local var_5_3 = ""

		if var_5_1 ~= "" then
			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				if iter_5_0 == 1 then
					var_5_3 = var_5_3 .. IdolDanceDIYActionCfg[iter_5_1].name
				else
					var_5_3 = "、" .. var_5_3 .. IdolDanceDIYActionCfg[iter_5_1].name
				end
			end
		end

		table.insert(var_5_2, string.format(var_5_0.marquee[1], var_5_3))

		return var_5_2
	end,
	[6001] = function(arg_6_0)
		local var_6_0 = BackhomeContentNoticeCfg[arg_6_0]
		local var_6_1 = DormInfomationData:GetParams(arg_6_0)
		local var_6_2 = {}

		if not var_6_0.marquee then
			return {}
		end

		local var_6_3 = ""

		if var_6_1 ~= "" then
			for iter_6_0, iter_6_1 in ipairs(var_6_1) do
				if iter_6_0 == 1 then
					var_6_3 = var_6_3 .. HeroTools.GetHeroFullName(iter_6_1)
				else
					var_6_3 = "、" .. var_6_3 .. HeroTools.GetHeroFullName(iter_6_1)
				end
			end
		end

		table.insert(var_6_2, string.format(var_6_0.marquee[1], var_6_3))

		return var_6_2
	end
}

function var_0_0.GetContent(arg_7_0, arg_7_1)
	if var_0_1[arg_7_1] then
		return var_0_1[arg_7_1](arg_7_1)
	end

	return {}
end

return var_0_0
