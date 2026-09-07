local GuildMissionNode = class("GuildMissionNode", import("...BaseVO"))

GuildMissionNode.STATE_DOING = 0
GuildMissionNode.STATE_SUCCESS = 1
GuildMissionNode.STATE_FAILED = 2

function GuildMissionNode:Ctor(arg_1_1)
	self.id = arg_1_1.node_id
	self.configId = self.id
	self.position = arg_1_1.position
	self.status = arg_1_1.status

	return
end

function GuildMissionNode:bindConfigTable()
	return pg.guild_event_node
end

function GuildMissionNode:GetPosition()
	return self.position
end

function GuildMissionNode:IsFinish()
	return self.status > 0
end

function GuildMissionNode:IsSuccess()
	return self.status > GuildMissionNode.STATE_SUCCESS
end

function GuildMissionNode:GetIcon()
	return self:getConfig("icon")
end

function GuildMissionNode:GetAwards()
	if self.status == GuildMissionNode.STATE_SUCCESS then
		return self:getConfig("success_award")
	elseif self.status == GuildMissionNode.STATE_FAILED then
		return self:getConfig("fail_award")
	end

	return
end

function GuildMissionNode:GetLog()
	if self.status ~= GuildMissionNode.STATE_SUCCESS then
		if self.status == GuildMissionNode.STATE_FAILED then
			local var_8_0 = getDropInfo((self:GetAwards()))
			local var_8_1 = self:getConfig("fail_describe")

			return string.gsub((self.status == GuildMissionNode.STATE_SUCCESS or nil) and self:getConfig("success_describe"), "$1", var_8_0)
		end
	end

	return
end

function GuildMissionNode:IsItemType()
	return self:getConfig("item") == "box"
end

function GuildMissionNode:IsBattleType()
	return self:getConfig("item") == "sairendanchuan"
end

return GuildMissionNode
