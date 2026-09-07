local GuildTechnology = class("GuildTechnology", import("..BaseVO"))

GuildTechnology.UPGRADE_TYPE_SELF = 1
GuildTechnology.UPGRADE_TYPE_PUBLIC = 2

function GuildTechnology:Ctor(arg_1_1)
	self:Update(self:bindConfigTable().get_id_list_by_group[arg_1_1.id][1], arg_1_1)

	return
end

function GuildTechnology:Update(arg_2_1, arg_2_2)
	self.group = arg_2_2
	self.id = self.group:GuildMemberCntType() and self.group.pid or arg_2_1
	self.configId = self.id
	self.level = self:getConfig("level")

	return
end

function GuildTechnology:GetShipAttrAddition(arg_3_1, arg_3_2)
	local var_3_0 = self:getConfig("effect_args")

	if var_3_0[1] == arg_3_1 and table.contains(var_3_0[2], arg_3_2) then
		return self:getConfig("num")
	else
		return 0
	end

	return
end

function GuildTechnology:GetTargetLivness()
	local var_4_0 = self:GetNextLevelId()

	if var_4_0 == 0 then
		return 0
	else
		return pg.guild_technology_template[var_4_0].need_guild_active
	end

	return
end

function GuildTechnology:ReachTargetLiveness(arg_5_1)
	return arg_5_1:GetLiveness() >= self:GetTargetLivness()
end

function GuildTechnology:_ReachTargetLiveness_()
	return self:ReachTargetLiveness((getProxy(GuildProxy):getRawData():getMemberById(getProxy(PlayerProxy):getRawData().id)))
end

function GuildTechnology:levelUp()
	local var_7_0 = self:GetNextLevelId()

	if var_7_0 ~= 0 then
		self:Update(var_7_0, self.group)
	end

	return
end

function GuildTechnology:GetNextLevelId()
	return self:getConfig("next_tech")
end

function GuildTechnology:GetLevel()
	return self.level
end

function GuildTechnology:isMaxLevel()
	return self:GetLevel() >= self:GetMaxLevel()
end

function GuildTechnology:CanUpgradeBySelf()
	local var_11_0 = self:_ReachTargetLiveness_()
	local var_11_1 = self:GetLevel() < self:GetMaxLevel()

	return var_11_0 and var_11_1, var_11_0, var_11_1
end

function GuildTechnology:GetLivenessOffset()
	local var_12_0 = getProxy(PlayerProxy)

	return self:GetTargetLivness() - getProxy(GuildProxy):getRawData():getMemberById(var_12_0:getRawData().id).GetLiveness(var_12_0)
end

function GuildTechnology:GetUpgradeType()
	if self:CanUpgradeBySelf() then
		return GuildTechnology.UPGRADE_TYPE_SELF
	else
		local var_13_0 = self.group:GetFakeLevel()
		local var_13_1 = self:GetMaxLevel()

		if var_13_0 > self:GetLevel() then
			return GuildTechnology.UPGRADE_TYPE_PUBLIC
		end
	end

	return false
end

function GuildTechnology:CanUpgrade()
	return self:GetUpgradeType() ~= false
end

function GuildTechnology:GetMaxLevel()
	return self.group:GetLevel()
end

function GuildTechnology:bindConfigTable()
	return pg.guild_technology_template
end

function GuildTechnology:GetDesc()
	return GuildConst.GET_TECHNOLOGY_DESC(self:getConfig("effect_args"), (self:getConfig("num")))
end

function GuildTechnology:getAddition()
	if self:GetLevel() > 0 then
		return self:getConfig("num")
	else
		return 0
	end

	return
end

function GuildTechnology:GetConsume()
	local var_19_0 = self:getConfig("contribution_consume")
	local var_19_1 = self:getConfig("gold_consume")

	if self:IsRiseInPrice() then
		local var_19_2 = self:getConfig("contribution_multiple")

		return var_19_0 * var_19_2, var_19_1 * var_19_2
	else
		return var_19_0, var_19_1
	end

	return
end

function GuildTechnology:IsRiseInPrice()
	return self:GetUpgradeType() == GuildTechnology.UPGRADE_TYPE_PUBLIC
end

function GuildTechnology:IsGuildMember()
	return self:getConfig("group") == 1
end

return GuildTechnology
