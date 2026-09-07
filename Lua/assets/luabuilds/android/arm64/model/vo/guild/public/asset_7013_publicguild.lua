local PublicGuild = class("PublicGuild", import("..base.BaseGuild"))
local var_0_1 = pg.guild_technology_template

function PublicGuild:Ctor(arg_1_1)
	self.technologyGroups = {}
	self.technologys = {}

	for iter_1_0, iter_1_1 in pairs(var_0_1.get_id_list_by_group) do
		local var_1_0 = GuildTechnologyGroup.New({
			id = iter_1_0
		})

		self.technologyGroups[iter_1_0] = var_1_0
		self.technologys[iter_1_0] = PublicGuildTechnology.New(var_1_0)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.technologys or {}) do
		self.technologyGroups[var_0_1[iter_1_3.id].group]:update(iter_1_3)
	end

	self.maxDonateCntPreDay = pg.guildset.contribution_task_num.key_value

	return
end

function PublicGuild:InitUser(arg_2_1)
	self.donateCount = arg_2_1.donate_count
	self.donateTasks = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.donate_tasks or {}) do
		table.insert(self.donateTasks, (GuildDonateTask.New({
			id = iter_2_1
		})))
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.tech_id or {}) do
		self.technologys[var_0_1[iter_2_3].group]:Update(iter_2_3, self.technologyGroups[var_0_1[iter_2_3].group])
	end

	return
end

function PublicGuild:GetTechnologyGroups()
	return self.technologyGroups
end

function PublicGuild:GetDonateTasks()
	return self.donateTasks
end

function PublicGuild:GetTechnologys()
	return self.technologys
end

function PublicGuild:GetTechnologyById(arg_6_1)
	return self.technologys[arg_6_1]
end

function PublicGuild:GetDonateCount()
	return self.donateCount
end

function PublicGuild:GetDonateTaskById(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self.donateTasks) do
		if iter_8_1.id == arg_8_1 then
			return iter_8_1
		end
	end

	return
end

function PublicGuild:HasDonateCnt()
	return self:GetRemainDonateCnt() > 0
end

function PublicGuild:UpdateDonateTasks(arg_10_1)
	self.donateTasks = arg_10_1

	return
end

function PublicGuild:IncDonateCount()
	self.donateCount = self.donateCount + 1

	return
end

function PublicGuild:GetRemainDonateCnt()
	return self.maxDonateCntPreDay - self.donateCount
end

function PublicGuild:ResetDonateCnt()
	self.donateCount = 0

	return
end

return PublicGuild
