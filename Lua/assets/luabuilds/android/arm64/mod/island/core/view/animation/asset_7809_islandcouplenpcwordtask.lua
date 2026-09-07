local IslandCoupleNpcWordTask = class("IslandCoupleNpcWordTask", import("..IslandBaseUnit"))

function IslandCoupleNpcWordTask:Ctor(arg_1_1, arg_1_2)
	IslandCoupleNpcWordTask.super.Ctor(self, arg_1_2)

	self.id = arg_1_1
	self.view = arg_1_2
	self.delayTime = pg.island_set.couple_word_cd.key_value_int
	self.currPlayStory = nil
	self.members = {}

	return
end

function IslandCoupleNpcWordTask:IsCurrentTask(arg_2_1)
	return self.id == arg_2_1 or table.contains(self.members, arg_2_1)
end

function IslandCoupleNpcWordTask:Execute(arg_3_1, arg_3_2)
	self.stopping = false
	self.callback = arg_3_2

	local var_3_0 = self:CollectWords(arg_3_1, (self:GetView():GetUnitListByKey(IslandConst.UNIT_LIST_FOLLOW)))

	shuffle(var_3_0)

	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(var_3_1, function(arg_4_0)
			self:PlayStory(iter_3_1, arg_4_0)

			return
		end)
	end

	seriesAsyncExtend(var_3_1, function()
		self:Stop(true)

		if self.callback then
			onNextTick(self.callback)
		end

		return
	end)

	self.funcs = var_3_1

	return
end

function IslandCoupleNpcWordTask:CollectWords(arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(pg.island_couple_word.all) do
		if pg.island_couple_word[iter_6_1].type == 1 and self:CheckShipCouple(pg.island_couple_word[iter_6_1].param, arg_6_1) and self:IsHappen(pg.island_couple_word[iter_6_1].weight) and self:CoupleShipInTeam(pg.island_couple_word[iter_6_1].param, arg_6_2) then
			table.insert(var_6_0, pg.island_couple_word[iter_6_1].story)
		elseif pg.island_couple_word[iter_6_1].type == 2 and table.contains(pg.island_couple_word[iter_6_1].param, arg_6_1) and self:IsHappen(pg.island_couple_word[iter_6_1].weight) then
			table.insert(var_6_0, pg.island_couple_word[iter_6_1].story)
		end
	end

	return var_6_0
end

function IslandCoupleNpcWordTask:CheckShipCouple(arg_7_1, arg_7_2)
	local var_7_0 = self:GetView():GetUnitModuleWithType(IslandConst.UNIT_LIST_FOLLOW, arg_7_2):GetDataVO():GetShipId()

	return _.any(arg_7_1, function(arg_8_0)
		return arg_8_0 == var_7_0
	end)
end

function IslandCoupleNpcWordTask:IsHappen(arg_9_1)
	return arg_9_1 >= math.random(0, 10000)
end

function IslandCoupleNpcWordTask:CoupleShipInTeam(arg_10_1, arg_10_2)
	return _.all(arg_10_1, function(arg_11_0)
		return _.any(arg_10_2, function(arg_12_0)
			return arg_12_0:GetDataVO():IsSameShip(arg_11_0)
		end)
	end)
end

function IslandCoupleNpcWordTask:PlayStory(arg_13_1, arg_13_2)
	if self.stopping then
		arg_13_2()

		return
	end

	local var_13_0 = self:WarpStory(arg_13_1, (require("Mod.Island.CoupleWord." .. arg_13_1)))
	local var_13_1 = IslandStory.New(var_13_0, self:GetView():GetAllUnits(), IslandStory.MODE_BUBBLE)

	if not self:IsVaildStory(var_13_1) then
		arg_13_2()

		return
	end

	self:FullMembers(var_13_1)
	self:NotifiyCore(ISLAND_EVT.RAW_PLAY_BUBBLE, {
		info = var_13_0,
		callback = function()
			self.members = {}

			self:AddDelayTimer(arg_13_2)

			return
		end
	})

	self.currPlayStory = var_13_0

	return
end

function IslandCoupleNpcWordTask:FullMembers(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1.steps) do
		table.insert(self.members, iter_15_1:GetUnitData().id)
	end

	return
end

function IslandCoupleNpcWordTask:IsVaildStory(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_1.steps) do
		local var_16_0 = iter_16_1:GetUnitData()

		if not self:GetView():GetUnitModuleWithType(var_16_0.type, var_16_0.id) then
			return false
		end
	end

	return true
end

function IslandCoupleNpcWordTask:WarpStory(arg_17_1, arg_17_2)
	local var_17_0 = {}
	local var_17_1 = {}
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_2) do
		var_17_2[iter_17_1.characterId] = true

		table.insert(var_17_1, iter_17_1)
	end

	for iter_17_2, iter_17_3 in pairs(var_17_2) do
		table.insert(var_17_0, {
			iter_17_2,
			iter_17_2,
			IslandConst.UNIT_LIST_FOLLOW
		})
	end

	return {
		mode = 9,
		id = arg_17_1,
		map = var_17_0,
		scripts = var_17_1
	}
end

function IslandCoupleNpcWordTask:AddDelayTimer(arg_18_1)
	self:RemoveTimer()

	self.timer = Timer.New(arg_18_1, self.delayTime, 1)

	self.timer:Start()

	return
end

function IslandCoupleNpcWordTask:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandCoupleNpcWordTask:Stop(arg_20_1)
	if not arg_20_1 then
		self.callback = nil

		self:StopBubbule()
	end

	self.stopping = true
	self.funcs = {}

	self:RemoveTimer()

	self.currPlayStory = nil
	self.members = nil

	return
end

function IslandCoupleNpcWordTask:StopBubbule()
	if not self.currPlayStory then
		return
	end

	self:NotifiyCore(ISLAND_EVT.RAW_STOP_BUBBLE, {
		info = Clone(self.currPlayStory)
	})

	return
end

return IslandCoupleNpcWordTask
