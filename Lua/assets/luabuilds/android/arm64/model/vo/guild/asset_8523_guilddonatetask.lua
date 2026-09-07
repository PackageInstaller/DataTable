local GuildDonateTask = class("GuildDonateTask", import("..BaseVO"))

function GuildDonateTask:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id

	return
end

function GuildDonateTask:bindConfigTable()
	return pg.guild_contribution_template
end

function GuildDonateTask:getCommitItem()
	return {
		self:getConfig("type"),
		self:getConfig("type_id"),
		self:getConfig("consume")
	}
end

function GuildDonateTask:getCapital()
	return self:getConfig("award_capital")
end

function GuildDonateTask:GetLivenessAddition()
	return self:getConfig("guild_active")
end

function GuildDonateTask:canCommit()
	local var_6_0 = self:getCommitItem()

	if var_6_0[1] == DROP_TYPE_RESOURCE then
		if getProxy(PlayerProxy):getData()[id2res(var_6_0[2])] < var_6_0[3] then
			return false
		end
	elseif var_6_0[1] == DROP_TYPE_ITEM then
		if getProxy(BagProxy):getItemCountById(var_6_0[2]) < var_6_0[3] then
			return false
		end
	else
		assert(false)
	end

	return true
end

return GuildDonateTask
