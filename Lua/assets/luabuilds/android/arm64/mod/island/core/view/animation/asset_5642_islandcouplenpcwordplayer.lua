local IslandCoupleNpcWordPlayer = class("IslandCoupleNpcWordPlayer", import("..IslandBaseUnit"))

function IslandCoupleNpcWordPlayer:Ctor(arg_1_1)
	IslandCoupleNpcWordPlayer.super.Ctor(self, arg_1_1)

	self.delayTime = pg.island_set.couple_word_cd.key_value_int
	self.schedule = {}

	return
end

function IslandCoupleNpcWordPlayer:Play(arg_2_1)
	if table.contains(self.schedule, arg_2_1) then
		return
	end

	table.insert(self.schedule, arg_2_1)

	if #self.schedule == 1 then
		self:Start()
	end

	return
end

function IslandCoupleNpcWordPlayer:Start()
	local var_3_0

	if not self.schedule or #self.schedule <= 0 then
		do return end

		var_3_0 = IslandCoupleNpcWordTask.New(self.schedule[1], self:GetView())
	end

	var_3_0:Execute(self.schedule[1], function()
		self.player = nil

		table.remove(self.schedule, 1)
		self:DelayStart()

		return
	end)

	self.player = var_3_0

	return
end

function IslandCoupleNpcWordPlayer:DelayStart()
	self:RemoveTimer()

	if #self.schedule <= 0 then
		return
	end

	self.timer = Timer.New(function()
		self:Start()

		return
	end, self.delayTime, 1)

	self.timer:Start()

	return
end

function IslandCoupleNpcWordPlayer:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function IslandCoupleNpcWordPlayer:Stop(arg_8_1)
	if table.contains(self.schedule, arg_8_1) then
		table.removebyvalue(self.schedule, arg_8_1)
	end

	if self.player and self.player:IsCurrentTask(arg_8_1) then
		self.player:Stop()

		self.player = nil

		self:DelayStart()
	end

	return
end

function IslandCoupleNpcWordPlayer:OnDispose()
	if self.player then
		self.player:Stop()
		self.player:Dispose()

		self.player = nil
	end

	self.schedule = nil

	self:RemoveTimer()

	return
end

return IslandCoupleNpcWordPlayer
