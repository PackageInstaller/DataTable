local ChallengeRogueTeamRelicData = class("ChallengeRogueTeamRelicData")

function ChallengeRogueTeamRelicData:ExportMethod()
	return {
		"EventUpdate",
		"EventGetCurrentID",
		"EventGetCurrrentOptionList",
		"GetOptionData",
		"EventGetTriggerType",
		"EventSetTriggerType"
	}
end

function ChallengeRogueTeamRelicData:Init()
	self.currentEventID_ = 0
	self.currentOptionList_ = {}
	self.triggerType_ = 0
end

function ChallengeRogueTeamRelicData:EventUpdate(arg_3_1)
	self.currentEventID_ = arg_3_1.event_id

	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.opt_list) do
		local var_3_1 = {}

		for iter_3_2, iter_3_3 in ipairs(iter_3_1.item_id_list) do
			table.insert(var_3_1, {
				id = iter_3_3.id,
				rare = iter_3_3.rare
			})
		end

		local var_3_2 = {
			isLock = false,
			id = iter_3_1.opt_id,
			itemList = var_3_1
		}

		var_3_2.stageID = iter_3_1.stage_id or 0
		var_3_2.jumpRoomID = iter_3_1.jump_battle_room_id or 0
		var_3_0[iter_3_1.opt_id] = var_3_2
	end

	local var_3_3 = {}

	if arg_3_1.event_id == 0 then
		self.currentOptionList_ = var_3_3

		return
	end

	local var_3_4 = RogueTeamEventCfg[arg_3_1.event_id]

	if RogueTeamEventCfg[arg_3_1.event_id].option_list == "" then
		self.currentOptionList_ = var_3_3

		return
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_4.option_list) do
		if var_3_0[iter_3_5] then
			table.insert(var_3_3, var_3_0[iter_3_5])
		else
			table.insert(var_3_3, {
				isLock = true,
				id = iter_3_5
			})
		end
	end

	self.currentOptionList_ = var_3_3

	self:EventSetTriggerType(arg_3_1.trigger_type)
end

function ChallengeRogueTeamRelicData:EventGetCurrentID()
	return self.currentEventID_
end

function ChallengeRogueTeamRelicData:EventGetCurrrentOptionList()
	return self.currentOptionList_
end

function ChallengeRogueTeamRelicData:GetOptionData(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self.currentOptionList_) do
		if iter_6_1.id == arg_6_1 then
			return iter_6_1
		end
	end

	return {
		id = 0
	}
end

function ChallengeRogueTeamRelicData:EventSetTriggerType(arg_7_1)
	self.triggerType_ = arg_7_1
end

function ChallengeRogueTeamRelicData:EventGetTriggerType()
	return self.triggerType_
end

return ChallengeRogueTeamRelicData
