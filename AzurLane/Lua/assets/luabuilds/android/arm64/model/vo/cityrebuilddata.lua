local var_0_0 = class("CityRebuildData", import("..vo.BaseVO"))
local var_0_1 = pg.activity_ninja_city
local var_0_2 = pg.activity_ninja_building
local var_0_3 = pg.activity_ninja_buff

var_0_0.Thousand = 1000
var_0_0.Million = 1000000
var_0_0.Billion = 0
var_0_0.MaxGold = 99999999999

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.isInited = arg_1_1.is_inited
	arg_1_0.pt = arg_1_1.pt.k + arg_1_1.pt.m * var_0_0.Million + arg_1_1.pt.b * var_0_0.Billion
	arg_1_0.buildings = arg_1_1.builds
	arg_1_0.roles = arg_1_1.roles
	arg_1_0.recruiting = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.recruits) do
		arg_1_0.recruiting[iter_1_1.id] = iter_1_1.start_time
	end

	arg_1_0.buffs = arg_1_1.buffs
	arg_1_0.buffLevels = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_0.buffs) do
		arg_1_0.buffLevels[var_0_3[iter_1_3].group] = var_0_3[iter_1_3].level
	end

	arg_1_0.maxLevel = arg_1_1.max_level
	arg_1_0.curLevel = arg_1_1.cur_level
	arg_1_0.maxChooseLevel = arg_1_1.max_display
	arg_1_0.startTime = arg_1_1.adjust.time
	arg_1_0.leftHp = arg_1_1.adjust.left_hp.k + arg_1_1.adjust.left_hp.m * var_0_0.Million + arg_1_1.adjust.left_hp.b * var_0_0.Billion
	arg_1_0.summaryPt = arg_1_1.summary_pt.k + arg_1_1.summary_pt.m * var_0_0.Million + arg_1_1.summary_pt.b * var_0_0.Billion
	arg_1_0.cityLevel = 1
	arg_1_0.allBuildingIds = {}
	arg_1_0.allCharaIds = {}

	for iter_1_4, iter_1_5 in ipairs(var_0_2.all) do
		if var_0_2[iter_1_5].type == 1 then
			table.insert(arg_1_0.allBuildingIds, iter_1_5)
		elseif var_0_2[iter_1_5].type == 2 then
			table.insert(arg_1_0.allCharaIds, iter_1_5)
		end
	end

	arg_1_0.unlockBuildingOrCharaIds = Clone(var_0_1[1].include)

	arg_1_0:TryUpgradeCityLevel(true)

	arg_1_0.Levelbuildings = {}
	arg_1_0.Levelcharas = {}

	arg_1_0:SetLevelDatas()

	return
end

function var_0_0.TryUpgradeCityLevel(arg_2_0, arg_2_1)
	local var_2_0 = true

	while var_2_0 do
		local var_2_1
		local var_2_2

		for iter_2_0, iter_2_1 in ipairs(var_0_1.all) do
			if var_2_1 then
				var_2_2 = var_0_1[iter_2_1]

				break
			end

			if var_0_1[iter_2_1].level == arg_2_0.cityLevel then
				var_2_1 = var_0_1[iter_2_1]
			end
		end

		if not var_2_1 or not var_2_2 then
			return
		end

		for iter_2_2, iter_2_3 in ipairs(var_2_1.include) do
			if not table.contains(arg_2_0.buildings, iter_2_3) and not table.contains(arg_2_0.roles, iter_2_3) then
				var_2_0 = false

				break
			end
		end

		if var_2_0 then
			arg_2_0.cityLevel = arg_2_0.cityLevel + 1

			table.insertto(arg_2_0.unlockBuildingOrCharaIds, var_2_2.include)

			for iter_2_4, iter_2_5 in ipairs(var_2_2.include) do
				if var_0_2[iter_2_5].default_state == 2 then
					if type == 1 and not table.contains(arg_2_0.buildings, iter_2_5) then
						table.insert(arg_2_0.buildings, iter_2_5)
					elseif type == 2 and not table.contains(arg_2_0.roles, iter_2_5) then
						table.insert(arg_2_0.roles, iter_2_5)
					end
				end
			end

			if arg_2_1 and var_2_2.story ~= "" then
				pg.NewStoryMgr.GetInstance():Play(var_2_2.story)
			end
		end
	end

	return
end

function var_0_0.RebuildDone(arg_3_0, arg_3_1)
	table.insert(arg_3_0.buildings, arg_3_1)
	arg_3_0:TryUpgradeCityLevel(true)

	return
end

function var_0_0.StartRecruit(arg_4_0, arg_4_1)
	arg_4_0.recruiting[arg_4_1] = pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.RecruitDone(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0.recruiting[iter_5_1] = nil

		table.insert(arg_5_0.roles, iter_5_1)
	end

	arg_5_0:TryUpgradeCityLevel(true)

	return
end

function var_0_0.UpgradeBuff(arg_6_0, arg_6_1, arg_6_2)
	table.sort(var_0_3.get_id_list_by_group[arg_6_1], function(arg_7_0, arg_7_1)
		return var_0_3[arg_7_0].level < var_0_3[arg_7_1].level
	end)

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.buffs) do
		if var_0_3[iter_6_1].group == arg_6_1 then
			var_6_0 = iter_6_1

			table.remove(arg_6_0.buffs, iter_6_0)

			break
		end
	end

	local var_6_1 = table.indexof(var_0_3.get_id_list_by_group[arg_6_1], var_6_0) + arg_6_2

	table.insert(arg_6_0.buffs, var_0_3.get_id_list_by_group[arg_6_1][var_6_1])

	arg_6_0.buffLevels[arg_6_1] = var_6_1

	return
end

function var_0_0.Result(arg_8_0, arg_8_1)
	arg_8_0.pt = arg_8_0.pt + arg_8_1.summary_pt.k + arg_8_1.summary_pt.m * var_0_0.Million + arg_8_1.summary_pt.b * var_0_0.Billion

	arg_8_0:Adjust(arg_8_1.adjust)

	arg_8_0.summaryPt = 0

	return
end

function var_0_0.ConsumePt(arg_9_0, arg_9_1)
	arg_9_0.pt = arg_9_0.pt - arg_9_1

	return
end

function var_0_0.AddPt(arg_10_0, arg_10_1)
	arg_10_0.pt = arg_10_0.pt + arg_10_1

	return
end

function var_0_0.Adjust(arg_11_0, arg_11_1)
	arg_11_0.startTime = arg_11_1.time
	arg_11_0.leftHp = arg_11_1.left_hp.k + arg_11_1.left_hp.m * var_0_0.Million + arg_11_1.left_hp.b * var_0_0.Billion
	arg_11_0.maxLevel = arg_11_1.max_level

	return
end

function var_0_0.IsRepairedOrRecruited(arg_12_0, arg_12_1)
	return table.contains(arg_12_0.buildings, arg_12_1) or table.contains(arg_12_0.roles, arg_12_1)
end

function var_0_0.IsUnlock(arg_13_0, arg_13_1)
	return table.contains(arg_13_0.unlockBuildingOrCharaIds, arg_13_1)
end

function var_0_0.UpdateChooseLevel(arg_14_0, arg_14_1)
	arg_14_0.curLevel = arg_14_1

	if arg_14_1 > arg_14_0.maxChooseLevel then
		arg_14_0.maxChooseLevel = arg_14_1
	end

	return
end

function var_0_0.SetLevelDatas(arg_15_0)
	arg_15_0.Levelbuildings = {}
	arg_15_0.Levelcharas = {}

	for iter_15_0, iter_15_1 in ipairs(var_0_1.all) do
		arg_15_0.Levelbuildings[iter_15_0] = {}
		arg_15_0.Levelcharas[iter_15_0] = {}

		for iter_15_2, iter_15_3 in ipairs(var_0_1[iter_15_1].include) do
			if var_0_2[iter_15_3].type == 1 then
				table.insert(arg_15_0.Levelbuildings[iter_15_0], iter_15_3)
			elseif var_0_2[iter_15_3].type == 2 then
				table.insert(arg_15_0.Levelcharas[iter_15_0], iter_15_3)
			end
		end
	end

	return
end

function var_0_0.KeepDecimal(arg_16_0, arg_16_1)
	return math.floor(10^arg_16_1 * arg_16_0) / 10^arg_16_1
end

var_0_0.SHOW_NUM_CNT = 4

function var_0_0.PtToShow(arg_17_0)
	if arg_17_0 >= var_0_0.MaxGold then
		return 99.99 .. "B"
	end

	if arg_17_0 >= var_0_0.Billion then
		if arg_17_0 % var_0_0.Billion == 0 then
			return arg_17_0 / var_0_0.Billion .. "B"
		end

		return var_0_0.KeepDecimal(arg_17_0 / var_0_0.Billion, var_0_0.SHOW_NUM_CNT - #tostring(math.floor(arg_17_0 / var_0_0.Billion))) .. "B"
	elseif arg_17_0 >= var_0_0.Million then
		if arg_17_0 % var_0_0.Million == 0 then
			return arg_17_0 / var_0_0.Million .. "M"
		end

		return var_0_0.KeepDecimal(arg_17_0 / var_0_0.Million, var_0_0.SHOW_NUM_CNT - #tostring(math.floor(arg_17_0 / var_0_0.Million))) .. "M"
	elseif arg_17_0 >= var_0_0.Thousand then
		if arg_17_0 % var_0_0.Thousand == 0 then
			return arg_17_0 / var_0_0.Thousand .. "K"
		end

		return var_0_0.KeepDecimal(arg_17_0 / var_0_0.Thousand, var_0_0.SHOW_NUM_CNT - #tostring(math.floor(arg_17_0 / var_0_0.Thousand))) .. "K"
	end

	return arg_17_0
end

return var_0_0
