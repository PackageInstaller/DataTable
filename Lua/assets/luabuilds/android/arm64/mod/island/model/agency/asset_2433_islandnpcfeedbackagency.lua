local IslandNpcFeedbackAgency = class("IslandNpcFeedbackAgency", import(".IslandBaseAgency"))

IslandNpcFeedbackAgency.NPC_ACTION_CHANGE = "IslandNpcFeedbackAgency:NPC_ACTION_CHANGE"
IslandNpcFeedbackAgency.RESET_NPC_ACTIONS = "IslandNpcFeedbackAgency:RESET_NPC_ACTIONS"

function IslandNpcFeedbackAgency:OnInit(arg_1_1)
	self.npcList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.action_feedback_npc_list) do
		table.insert(self.npcList, iter_1_1)
	end

	return
end

function IslandNpcFeedbackAgency:GetNpcList()
	return self.npcList
end

function IslandNpcFeedbackAgency:AddNpc(arg_3_1)
	table.insert(self.npcList, arg_3_1)
	self:DispatchEvent(IslandNpcFeedbackAgency.NPC_ACTION_CHANGE, arg_3_1)

	return
end

function IslandNpcFeedbackAgency:UpdatePerDay()
	self.npcList = {}

	self:DispatchEvent(IslandNpcFeedbackAgency.RESET_NPC_ACTIONS)

	return
end

return IslandNpcFeedbackAgency
