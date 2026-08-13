class = var_0_10000

local var_0_0 = "IslandCoupleNpcWordTask"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.id = arg_1_1
	arg_1_0.view = arg_1_2
	pg = var_3
	arg_1_0.delayTime = var_3.island_set.couple_word_cd.key_value_int
	arg_1_0.currPlayStory = nil
	arg_1_0.members = {}

	return
end

function var_0_1.IsCurrentTask(arg_2_0, arg_2_1)
	local var_2_0

	if arg_2_0.id ~= arg_2_1 then
		table = var_2
		var_2_0 = var_2.contains(arg_2_0.members, arg_2_1)

		if false then
			var_2_0 = false
		end
	else
		var_2_0 = true
	end

	return var_2_0
end

function var_0_1.Execute(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.stopping = false

	local var_3_0 = arg_3_0:GetView()
	local var_3_1 = var_3.GetUnitListByKey

	IslandConst = var_1_10005

	local var_3_2 = var_3_1(var_3_0, var_1_10005.UNIT_LIST_FOLLOW)

	arg_3_0.callback = arg_3_2

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.CollectWords(var_3_3, arg_3_1, var_3_2)

	shuffle = var_3_3

	var_3_3(var_3_4)

	local var_3_5 = {}

	ipairs = var_6

	for iter_3_0, iter_3_1 in var_6(var_3_4) do
		table = var_1_10011

		var_1_10011.insert(var_3_5, function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.PlayStory(var_4_0, iter_3_1, arg_4_0)

			return
		end)
	end

	seriesAsyncExtend = var_6

	var_6(var_3_5, function()
		local var_5_0 = arg_3_0

		var_0.Stop(var_5_0, true)

		if arg_3_0.callback then
			onNextTick = var_0

			var_0(arg_3_0.callback)
		end

		return
	end)

	arg_3_0.funcs = var_3_5

	return
end

function var_0_1.CollectWords(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10004(var_1_10005.island_couple_word.all) do
		pg = var_1_10009

		if var_1_10009.island_couple_word[iter_6_1].type == 1 and arg_6_0:CheckShipCouple(var_1_10009.param, arg_6_1) and arg_6_0:IsHappen(var_1_10009.weight) and arg_6_0:CoupleShipInTeam(var_1_10009.param, arg_6_2) then
			table = var_10

			var_10.insert(var_6_0, var_1_10009.story)
		elseif var_1_10009.type == 2 then
			table = var_10

			if var_10.contains(var_1_10009.param, arg_6_1) and arg_6_0:IsHappen(var_1_10009.weight) then
				table = var_10

				var_10.insert(var_6_0, var_1_10009.story)
			end
		end
	end

	return var_6_0
end

function var_0_1.CheckShipCouple(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetView()
	local var_7_1 = var_3.GetUnitModuleWithType

	IslandConst = var_1_10005

	local var_7_2 = var_7_1(var_7_0, var_1_10005.UNIT_LIST_FOLLOW, arg_7_2)
	local var_7_3 = var_3.GetDataVO(var_7_2)
	local var_7_4 = var_4.GetShipId(var_7_3)

	_ = var_7_3

	return var_7_3.any(arg_7_1, function(arg_8_0)
		return arg_8_0 == var_7_4
	end)
end

function var_0_1.IsHappen(arg_9_0, arg_9_1)
	math = var_1_10002

	return arg_9_1 >= var_1_10002.random(0, 10000)
end

function var_0_1.CoupleShipInTeam(arg_10_0, arg_10_1, arg_10_2)
	_ = var_1_10003

	return var_1_10003.all(arg_10_1, function(arg_11_0)
		_ = var_2_10001

		return var_2_10001.any(arg_10_2, function(arg_12_0)
			local var_12_0 = arg_12_0:GetDataVO()

			return var_1.IsSameShip(var_12_0, arg_11_0)
		end)
	end)
end

function var_0_1.PlayStory(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.stopping then
		arg_13_2()

		return
	end

	require = var_3

	local var_13_0 = var_3("Mod.Island.CoupleWord." .. arg_13_1)
	local var_13_1 = arg_13_0:WarpStory(arg_13_1, var_13_0)
	local var_13_2 = arg_13_0:GetView()
	local var_13_3 = var_5.GetAllUnits(var_13_2)

	IslandStory = var_13_2

	local var_13_4 = var_13_2.New
	local var_13_5 = var_13_1
	local var_13_6 = var_13_3

	IslandStory = var_1_10009

	local var_13_7 = var_13_4(var_13_5, var_13_6, var_1_10009.MODE_BUBBLE)

	if not arg_13_0:IsVaildStory(var_13_7) then
		arg_13_2()

		return
	end

	arg_13_0:FullMembers(var_13_7)

	local var_13_8 = arg_13_0
	local var_13_9 = arg_13_0.NotifiyCore

	ISLAND_EVT = var_9

	var_13_9(var_13_8, var_9.RAW_PLAY_BUBBLE, {
		info = var_13_1,
		callback = function()
			arg_13_0.members = {}

			local var_14_0 = arg_13_0

			var_0.AddDelayTimer(var_14_0, arg_13_2)

			return
		end
	})

	arg_13_0.currPlayStory = var_13_1

	return
end

function var_0_1.FullMembers(arg_15_0, arg_15_1)
	ipairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_1.steps) do
		local var_15_0 = iter_15_1
		local var_15_1 = iter_15_1.GetUnitData(var_15_0)

		table = var_15_0

		var_15_0.insert(arg_15_0.members, var_15_1.id)
	end

	return
end

function var_0_1.IsVaildStory(arg_16_0, arg_16_1)
	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_1.steps) do
		local var_16_0 = iter_16_1:GetUnitData()
		local var_16_1 = arg_16_0:GetView()

		if not var_8.GetUnitModuleWithType(var_16_1, var_16_0.type, var_16_0.id) then
			return false
		end
	end

	return true
end

function var_0_1.WarpStory(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = {}

	ipairs = var_1_10006

	for iter_17_0, iter_17_1 in var_1_10006(arg_17_2) do
		var_17_2[iter_17_1.characterId] = true
		table = var_1_10011

		var_1_10011.insert(var_17_1, iter_17_1)
	end

	pairs = var_6

	for iter_17_2, iter_17_3 in var_6(var_17_2) do
		table = var_1_10011
		var_1_10011 = var_1_10011.insert

		local var_17_3 = var_17_0
		local var_17_4 = {
			iter_17_2,
			iter_17_2
		}

		IslandConst = var_1_10014
		var_17_4[3] = var_1_10014.UNIT_LIST_FOLLOW

		var_1_10011(var_17_3, var_17_4)
	end

	return {
		mode = 9,
		id = arg_17_1,
		map = var_17_0,
		scripts = var_17_1
	}
end

function var_0_1.AddDelayTimer(arg_18_0, arg_18_1)
	arg_18_0:RemoveTimer()

	Timer = var_2
	arg_18_0.timer = var_2.New(arg_18_1, arg_18_0.delayTime, 1)

	local var_18_0 = arg_18_0.timer

	var_2.Start(var_18_0)

	return
end

function var_0_1.RemoveTimer(arg_19_0)
	if arg_19_0.timer then
		local var_19_0 = arg_19_0.timer

		var_1.Stop(var_19_0)

		arg_19_0.timer = nil
	end

	return
end

function var_0_1.Stop(arg_20_0, arg_20_1)
	if not arg_20_1 then
		arg_20_0.callback = nil

		arg_20_0:StopBubbule()
	end

	arg_20_0.stopping = true
	arg_20_0.funcs = {}

	arg_20_0:RemoveTimer()

	arg_20_0.currPlayStory = nil
	arg_20_0.members = nil

	return
end

function var_0_1.StopBubbule(arg_21_0)
	if not arg_21_0.currPlayStory then
		return
	end

	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.NotifiyCore

	ISLAND_EVT = var_1_10003

	local var_21_2 = var_1_10003.RAW_STOP_BUBBLE
	local var_21_3 = {}

	Clone = var_1_10005
	var_21_3.info = var_1_10005(arg_21_0.currPlayStory)

	var_21_1(var_21_0, var_21_2, var_21_3)

	return
end

return var_0_1
