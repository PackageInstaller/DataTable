class = var_0_10000

local var_0_0 = "CityRebuildData"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..vo.BaseVO"))

pg = var_0_10001

local var_0_2 = var_0_10001.activity_ninja_city

pg = var_0_0

local var_0_3 = var_0_0.activity_ninja_building

pg = var_3

local var_0_4 = var_3.activity_ninja_buff

pg = var_0_10004

local var_0_5 = var_0_10004.activity_ninja_enemy

var_0_1.Thousand = 1000
var_0_1.Million = 1000000
var_0_1.Billion = 0
var_0_1.MaxGold = 99999999999

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.isInited = arg_1_1.is_inited
	arg_1_0.pt = arg_1_1.pt.k + arg_1_1.pt.m * var_0_1.Million + arg_1_1.pt.b * var_0_1.Billion
	arg_1_0.buildings = arg_1_1.builds
	arg_1_0.roles = arg_1_1.roles
	arg_1_0.recruiting = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.recruits) do
		arg_1_0.recruiting[iter_1_1.id] = iter_1_1.start_time
	end

	arg_1_0.buffs = arg_1_1.buffs
	arg_1_0.buffLevels = {}
	ipairs = var_2

	for iter_1_2, iter_1_3 in var_2(arg_1_0.buffs) do
		local var_1_0 = var_0_4[iter_1_3]

		var_1_10008 = arg_1_0.buffLevels
		var_1_10008[var_1_0.group] = var_1_0.level
	end

	arg_1_0.maxLevel = arg_1_1.max_level
	arg_1_0.curLevel = arg_1_1.cur_level
	arg_1_0.maxChooseLevel = arg_1_1.max_display
	arg_1_0.startTime = arg_1_1.adjust.time
	arg_1_0.leftHp = arg_1_1.adjust.left_hp.k + arg_1_1.adjust.left_hp.m * var_0_1.Million + arg_1_1.adjust.left_hp.b * var_0_1.Billion
	arg_1_0.summaryPt = arg_1_1.summary_pt.k + arg_1_1.summary_pt.m * var_0_1.Million + arg_1_1.summary_pt.b * var_0_1.Billion
	arg_1_0.cityLevel = 1
	arg_1_0.allBuildingIds = {}
	arg_1_0.allCharaIds = {}
	ipairs = var_2

	for iter_1_4, iter_1_5 in var_2(var_0_3.all) do
		if var_0_3[iter_1_5].type == 1 then
			table = var_1_10008

			var_1_10008.insert(arg_1_0.allBuildingIds, iter_1_5)
		elseif var_7 == 2 then
			table = var_1_10008

			var_1_10008.insert(arg_1_0.allCharaIds, iter_1_5)
		end
	end

	Clone = var_2
	arg_1_0.unlockBuildingOrCharaIds = var_2(var_0_2[1].include)

	arg_1_0:TryUpgradeCityLevel(true)

	arg_1_0.Levelbuildings = {}
	arg_1_0.Levelcharas = {}

	arg_1_0:SetLevelDatas()

	return
end

function var_0_1.TryUpgradeCityLevel(arg_2_0, arg_2_1)
	local var_2_0 = true

	while var_2_0 do
		local var_2_1
		local var_2_2

		ipairs = var_1_10005

		for iter_2_0, iter_2_1 in var_1_10005(var_0_2.all) do
			var_1_10010 = var_0_2[iter_2_1]

			if var_2_1 then
				var_2_2 = var_1_10010

				break
			end

			if var_1_10010.level == arg_2_0.cityLevel then
				var_2_1 = var_1_10010
			end
		end

		if not var_2_1 or not var_2_2 then
			return
		end

		ipairs = var_1_10005

		for iter_2_2, iter_2_3 in var_1_10005(var_2_1.include) do
			table = var_1_10010

			if not var_1_10010.contains(arg_2_0.buildings, iter_2_3) then
				table = var_1_10010

				if not var_1_10010.contains(arg_2_0.roles, iter_2_3) then
					var_2_0 = false

					break
				end
			end
		end

		if var_2_0 then
			arg_2_0.cityLevel = arg_2_0.cityLevel + 1
			table = var_1_10005

			var_1_10005.insertto(arg_2_0.unlockBuildingOrCharaIds, var_2_2.include)

			ipairs = var_1_10005

			for iter_2_4, iter_2_5 in var_1_10005(var_2_2.include) do
				if var_0_3[iter_2_5].default_state == 2 then
					type = var_11

					if var_11 == 1 then
						table = var_11

						if not var_11.contains(arg_2_0.buildings, iter_2_5) then
							table = var_11

							var_11.insert(arg_2_0.buildings, iter_2_5)

							goto label_2_0
						end
					end

					type = var_11

					if var_11 == 2 then
						table = var_11

						if not var_11.contains(arg_2_0.roles, iter_2_5) then
							table = var_11

							var_11.insert(arg_2_0.roles, iter_2_5)
						end
					end
				end

				::label_2_0::
			end

			if arg_2_1 and var_2_2.story ~= "" then
				pg = var_1_10005

				local var_2_3 = var_1_10005.NewStoryMgr.GetInstance()

				var_1_10005.Play(var_2_3, var_2_2.story)
			end
		end
	end

	return
end

function var_0_1.RebuildDone(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.insert(arg_3_0.buildings, arg_3_1)
	arg_3_0:TryUpgradeCityLevel(true)

	return
end

function var_0_1.StartRecruit(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.recruiting

	pg = var_1_10003

	local var_4_1 = var_1_10003.TimeMgr.GetInstance()

	var_4_0[arg_4_1] = var_3.GetServerTime(var_4_1)

	return
end

function var_0_1.RecruitDone(arg_5_0, arg_5_1)
	ipairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1) do
		local var_5_0 = arg_5_0.recruiting

		var_5_0[iter_5_1] = nil
		table = var_5_0

		var_5_0.insert(arg_5_0.roles, iter_5_1)
	end

	arg_5_0:TryUpgradeCityLevel(true)

	return
end

function var_0_1.UpgradeBuff(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_4.get_id_list_by_group[arg_6_1]

	table = var_1_10004

	var_1_10004.sort(var_6_0, function(arg_7_0, arg_7_1)
		return var_0_4[arg_7_0].level < var_0_4[arg_7_1].level
	end)

	local var_6_1 = 0

	ipairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(arg_6_0.buffs) do
		if var_0_4[iter_6_1].group == arg_6_1 then
			var_6_1 = iter_6_1
			table = var_10

			var_10.remove(arg_6_0.buffs, iter_6_0)

			break
		end
	end

	table = var_5

	local var_6_2 = var_6_0[var_5.indexof(var_6_0, var_6_1) + arg_6_2]

	table = var_7

	var_7.insert(arg_6_0.buffs, var_6_2)

	arg_6_0.buffLevels[arg_6_1] = var_5

	return
end

function var_0_1.Result(arg_8_0, arg_8_1)
	arg_8_0.pt = arg_8_0.pt + arg_8_1.summary_pt.k + arg_8_1.summary_pt.m * var_0_1.Million + arg_8_1.summary_pt.b * var_0_1.Billion

	arg_8_0:Adjust(arg_8_1.adjust)

	arg_8_0.summaryPt = 0

	return
end

function var_0_1.ConsumePt(arg_9_0, arg_9_1)
	arg_9_0.pt = arg_9_0.pt - arg_9_1

	return
end

function var_0_1.AddPt(arg_10_0, arg_10_1)
	arg_10_0.pt = arg_10_0.pt + arg_10_1

	return
end

function var_0_1.Adjust(arg_11_0, arg_11_1)
	arg_11_0.startTime = arg_11_1.time
	arg_11_0.leftHp = arg_11_1.left_hp.k + arg_11_1.left_hp.m * var_0_1.Million + arg_11_1.left_hp.b * var_0_1.Billion
	arg_11_0.maxLevel = arg_11_1.max_level

	return
end

function var_0_1.IsRepairedOrRecruited(arg_12_0, arg_12_1)
	table = var_1_10002

	local var_12_0

	if not var_1_10002.contains(arg_12_0.buildings, arg_12_1) then
		table = var_12_0
		var_12_0 = var_12_0.contains(arg_12_0.roles, arg_12_1)
	end

	return var_12_0
end

function var_0_1.IsUnlock(arg_13_0, arg_13_1)
	table = var_1_10002

	return var_1_10002.contains(arg_13_0.unlockBuildingOrCharaIds, arg_13_1)
end

function var_0_1.UpdateChooseLevel(arg_14_0, arg_14_1)
	arg_14_0.curLevel = arg_14_1

	if arg_14_1 > arg_14_0.maxChooseLevel then
		arg_14_0.maxChooseLevel = arg_14_1
	end

	return
end

function var_0_1.SetLevelDatas(arg_15_0)
	arg_15_0.Levelbuildings = {}
	arg_15_0.Levelcharas = {}
	ipairs = var_1

	for iter_15_0, iter_15_1 in var_1(var_0_2.all) do
		arg_15_0.Levelbuildings[iter_15_0] = {}

		local var_15_0 = arg_15_0.Levelcharas

		var_15_0[iter_15_0] = {}
		ipairs = var_15_0

		for iter_15_2, iter_15_3 in var_15_0(var_0_2[iter_15_1].include) do
			if var_0_3[iter_15_3].type == 1 then
				table = var_1_10012

				var_1_10012.insert(arg_15_0.Levelbuildings[iter_15_0], iter_15_3)
			elseif var_11 == 2 then
				table = var_1_10012

				var_1_10012.insert(arg_15_0.Levelcharas[iter_15_0], iter_15_3)
			end
		end
	end

	return
end

function var_0_1.KeepDecimal(arg_16_0, arg_16_1)
	math = var_1_10002

	return var_1_10002.floor(10^arg_16_1 * arg_16_0) / 10^arg_16_1
end

var_0_1.SHOW_NUM_CNT = 4

function var_0_1.PtToShow(arg_17_0)
	if arg_17_0 >= var_0_1.MaxGold then
		return 99.99 .. "B"
	end

	if arg_17_0 >= var_0_1.Billion then
		if arg_17_0 % var_0_1.Billion == 0 then
			return arg_17_0 / var_0_1.Billion .. "B"
		end

		local var_17_0 = arg_17_0 / var_0_1.Billion
		local var_17_1 = var_0_1.SHOW_NUM_CNT

		tostring = var_1_10003
		math = var_1_10005

		local var_17_2 = var_17_1 - #var_1_10003(var_1_10005.floor(var_17_0))

		return var_0_1.KeepDecimal(var_17_0, var_17_2) .. "B"
	elseif arg_17_0 >= var_0_1.Million then
		if arg_17_0 % var_0_1.Million == 0 then
			return arg_17_0 / var_0_1.Million .. "M"
		end

		local var_17_3 = arg_17_0 / var_0_1.Million
		local var_17_4 = var_0_1.SHOW_NUM_CNT

		tostring = var_1_10003
		math = var_1_10005

		local var_17_5 = var_17_4 - #var_1_10003(var_1_10005.floor(var_17_3))

		return var_0_1.KeepDecimal(var_17_3, var_17_5) .. "M"
	elseif arg_17_0 >= var_0_1.Thousand then
		if arg_17_0 % var_0_1.Thousand == 0 then
			return arg_17_0 / var_0_1.Thousand .. "K"
		end

		local var_17_6 = arg_17_0 / var_0_1.Thousand
		local var_17_7 = var_0_1.SHOW_NUM_CNT

		tostring = var_1_10003
		math = var_1_10005

		local var_17_8 = var_17_7 - #var_1_10003(var_1_10005.floor(var_17_6))

		return var_0_1.KeepDecimal(var_17_6, var_17_8) .. "K"
	end

	return arg_17_0
end

return var_0_1
