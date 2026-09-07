local GuildReport = class("GuildReport", import("...BaseVO"))

GuildReport.SCORE_TYPE_S = 1
GuildReport.SCORE_TYPE_A = 2
GuildReport.SCORE_TYPE_B = 3

function GuildReport:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.eventId = arg_1_1.event_id
	self.configId = self.eventId
	self.score = arg_1_1.score
	self.state = GuildConst.REPORT_STATE_LOCK
	self.nodeAwards = {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.nodes) do
		local var_1_2 = Clone(pg.guild_event_node[iter_1_1.id])

		for iter_1_2, iter_1_3 in ipairs(iter_1_1.status == 1 and var_1_2.success_award or var_1_2.fail_award) do
			if not var_1_0[iter_1_3[2]] then
				var_1_0[iter_1_3[2]] = iter_1_3
			else
				var_1_0[iter_1_3[2]][3] = var_1_0[iter_1_3[2]][3] + iter_1_3[3]
			end
		end
	end

	for iter_1_4, iter_1_5 in pairs(var_1_0) do
		table.insert(self.nodeAwards, iter_1_5)
	end

	self:SetStatus(arg_1_1.status)

	return
end

function GuildReport:SetStatus(arg_2_1)
	self.state = arg_2_1

	return
end

function GuildReport:IsBoss()
	return false
end

function GuildReport:IsLock()
	return self.state == GuildConst.REPORT_STATE_LOCK
end

function GuildReport:IsUnlock()
	return self.state > GuildConst.REPORT_STATE_LOCK
end

function GuildReport:CanSubmit()
	return self.state == GuildConst.REPORT_STATE_UNlOCK
end

function GuildReport:IsSubmited()
	return self.state == GuildConst.REPORT_STATE_SUBMITED
end

function GuildReport:Submit()
	if self:CanSubmit() then
		self.state = GuildConst.REPORT_STATE_SUBMITED
	end

	return
end

function GuildReport:bindConfigTable()
	return pg.guild_base_event
end

function GuildReport:GetReportDesc()
	return self:getConfig("report")[self.score]
end

function GuildReport:IsPerfectFinish()
	return self.score == GuildReport.SCORE_TYPE_S
end

function GuildReport:GetSelfDrop()
	if self.score == GuildReport.SCORE_TYPE_S then
		return self:getConfig("award_list_report")
	else
		return {}
	end

	return
end

function GuildReport:GetNodeDrop()
	return self.nodeAwards
end

function GuildReport:GetDrop()
	local var_14_0 = {}
	local var_14_1 = self:GetSelfDrop()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		table.insert(var_14_0, iter_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs((self:GetNodeDrop())) do
		table.insert(var_14_0, iter_14_3)
	end

	return var_14_0, #var_14_1
end

function GuildReport:GetType()
	return self:getConfig("type")
end

return GuildReport
