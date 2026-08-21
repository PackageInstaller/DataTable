local var_0_0 = class("IslandCoupleNpcWordTask", import("..IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.id = arg_1_1
	arg_1_0.view = arg_1_2
	arg_1_0.delayTime = pg.island_set.couple_word_cd.key_value_int
	arg_1_0.currPlayStory = nil
	arg_1_0.members = {}

	return
end

function var_0_0.IsCurrentTask(arg_2_0, arg_2_1)
	return arg_2_0.id == arg_2_1 or table.contains(arg_2_0.members, arg_2_1)
end

function var_0_0.Execute(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.stopping = false
	arg_3_0.callback = arg_3_2

	local var_3_0 = arg_3_0:CollectWords(arg_3_1, (arg_3_0:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW)))

	shuffle(var_3_0)

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert({}, function(arg_4_0)
			arg_3_0:PlayStory(iter_3_1, arg_4_0)

			return
		end)
	end

	seriesAsyncExtend({}, function()
		arg_3_0:Stop(true)

		if arg_3_0.callback then
			onNextTick(arg_3_0.callback)
		end

		return
	end)

	arg_3_0.funcs = {}

	return
end

function var_0_0.CollectWords(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(pg.island_couple_word.all) do
		if pg.island_couple_word[iter_6_1].type == 1 and arg_6_0:CheckShipCouple(pg.island_couple_word[iter_6_1].param, arg_6_1) and arg_6_0:IsHappen(pg.island_couple_word[iter_6_1].weight) and arg_6_0:CoupleShipInTeam(pg.island_couple_word[iter_6_1].param, arg_6_2) then
			table.insert({}, pg.island_couple_word[iter_6_1].story)
		elseif pg.island_couple_word[iter_6_1].type == 2 and table.contains(pg.island_couple_word[iter_6_1].param, arg_6_1) and arg_6_0:IsHappen(pg.island_couple_word[iter_6_1].weight) then
			table.insert({}, pg.island_couple_word[iter_6_1].story)
		end
	end

	return {}
end

function var_0_0.CheckShipCouple(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_FOLLOW, arg_7_2):GetDataVO():GetShipId()

	return _.any(arg_7_1, function(arg_8_0)
		return arg_8_0 == var_7_0
	end)
end

function var_0_0.IsHappen(arg_9_0, arg_9_1)
	return arg_9_1 >= math.random(0, 10000)
end

function var_0_0.CoupleShipInTeam(arg_10_0, arg_10_1, arg_10_2)
	return _.all(arg_10_1, function(arg_11_0)
		return _.any(arg_10_2, function(arg_12_0)
			return arg_12_0:GetDataVO():IsSameShip(arg_11_0)
		end)
	end)
end

function var_0_0.PlayStory(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.stopping then
		arg_13_2()

		return
	end

	local var_13_0 = arg_13_0:WarpStory(arg_13_1, (require("Mod.Island.CoupleWord." .. arg_13_1)))
	local var_13_1 = IslandStory.New(var_13_0, arg_13_0:GetView():GetAllUnits(), IslandStory.MODE_BUBBLE)

	if not arg_13_0:IsVaildStory(var_13_1) then
		arg_13_2()

		return
	end

	arg_13_0:FullMembers(var_13_1)
	arg_13_0:NotifiyCore(ISLAND_EVT.RAW_PLAY_BUBBLE, {
		info = var_13_0,
		callback = function()
			arg_13_0.members = {}

			arg_13_0:AddDelayTimer(arg_13_2)

			return
		end
	})

	arg_13_0.currPlayStory = var_13_0

	return
end

function var_0_0.FullMembers(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.steps) do
		table.insert(arg_15_0.members, iter_15_1:GetUnitData().id)
	end

	return
end

function var_0_0.IsVaildStory(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.steps) do
		local var_16_0 = iter_16_1:GetUnitData()
		local var_16_1 = arg_16_0:GetView()

		if not var_16_1:GetUnitModuleWithType(var_16_0.type, var_16_0.id) then
			return false
		end
	end

	return true
end

function var_0_0.WarpStory(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		({})[iter_17_1.characterId] = true

		table.insert({}, iter_17_1)
	end

	for iter_17_2, iter_17_3 in pairs({}) do
		table.insert({}, {
			iter_17_2,
			iter_17_2,
			IslandConst.UNIT_LIST_FOLLOW
		})
	end

	return {
		mode = 9,
		id = arg_17_1,
		map = {},
		scripts = {}
	}
end

function var_0_0.AddDelayTimer(arg_18_0, arg_18_1)
	arg_18_0:RemoveTimer()

	arg_18_0.timer = Timer.New(arg_18_1, arg_18_0.delayTime, 1)

	arg_18_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_19_0)
	if arg_19_0.timer then
		arg_19_0.timer:Stop()

		arg_19_0.timer = nil
	end

	return
end

function var_0_0.Stop(arg_20_0, arg_20_1)
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

function var_0_0.StopBubbule(arg_21_0)
	if not arg_21_0.currPlayStory then
		return
	end

	arg_21_0:NotifiyCore(ISLAND_EVT.RAW_STOP_BUBBLE, {
		info = Clone(arg_21_0.currPlayStory)
	})

	return
end

return var_0_0
