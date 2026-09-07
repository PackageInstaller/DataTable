local GuildTechnologyGroup = class("GuildTechnologyGroup", import("..BaseVO"))

GuildTechnologyGroup.STATE_STOP = 0
GuildTechnologyGroup.STATE_START = 1

function GuildTechnologyGroup:Ctor(arg_1_1)
	self.id = arg_1_1.id

	local var_1_0 = self:bindConfigTable().get_id_list_by_group[self.id][1]

	self:update({
		progress = 0,
		state = 0,
		id = var_1_0,
		fake_id = var_1_0
	})

	return
end

function GuildTechnologyGroup:update(arg_2_1)
	self.pid = arg_2_1.id
	self.configId = self.pid
	self.state = arg_2_1.state or 0
	self.progress = arg_2_1.progress or 0
	self.fakeId = arg_2_1.fake_id or self.fakeId or arg_2_1.id

	return
end

function GuildTechnologyGroup:AddProgress(arg_3_1)
	self.progress = self.progress + arg_3_1

	if self:GetTargetProgress() <= self.progress then
		self:LevelUp()
	end

	return
end

function GuildTechnologyGroup:LevelUp()
	self:update({
		progress = 0,
		id = self:GetNextId(),
		state = self.state,
		fake_id = self.fakeId
	})

	return
end

function GuildTechnologyGroup:GetNextId()
	local var_5_0 = self:getConfig("next_tech")

	if var_5_0 == 0 then
		return self.pid
	else
		return var_5_0
	end

	return
end

function GuildTechnologyGroup:GetState()
	return self.state
end

function GuildTechnologyGroup:GetTargetProgress()
	return self:getConfig("exp")
end

function GuildTechnologyGroup:GetProgress()
	return self.progress
end

function GuildTechnologyGroup:GetFakeLevel()
	return self:bindConfigTable()[self.fakeId].level
end

function GuildTechnologyGroup:GetLevel()
	return self:getConfig("level")
end

function GuildTechnologyGroup:GetMaxLevel()
	return self:getConfig("level_max")
end

function GuildTechnologyGroup:isMaxLevel()
	return self:GetLevel() >= self:GetMaxLevel()
end

function GuildTechnologyGroup:bindConfigTable()
	return pg.guild_technology_template
end

function GuildTechnologyGroup:GuildMemberCntType()
	return self:getConfig("effect_args")[1] == GuildConst.TYPE_GUILD_MEMBER_CNT
end

function GuildTechnologyGroup:isStarting()
	return self.state == GuildTechnologyGroup.STATE_START
end

function GuildTechnologyGroup:GetDesc()
	local var_16_0 = self:bindConfigTable()

	assert(var_16_0[self.pid].next_tech, self.pid)

	if var_16_0[self.pid].next_tech == 0 then
		return GuildConst.GET_TECHNOLOGY_GROUP_DESC(var_16_0[self.pid].effect_args, var_16_0[self.pid].num, var_16_0[self.pid].num)
	else
		return GuildConst.GET_TECHNOLOGY_GROUP_DESC(var_16_0[self.pid].effect_args, var_16_0[self.pid].num, var_16_0[var_16_0[self.pid].next_tech].num)
	end

	return
end

function GuildTechnologyGroup:Stop()
	self.state = GuildTechnologyGroup.STATE_STOP

	return
end

function GuildTechnologyGroup:Start()
	self.state = GuildTechnologyGroup.STATE_START

	return
end

return GuildTechnologyGroup
