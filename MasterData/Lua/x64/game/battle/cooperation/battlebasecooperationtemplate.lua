local BattleBaseCooperationTemplate = class("BattleBaseCooperationTemplate", BattleBaseStageTemplate)

function BattleBaseCooperationTemplate:Ctor()
	BattleBaseCooperationTemplate.super.Ctor(self)

	self.room = CooperationData:GetRoomData()
	self.roomId = self.room.room_id
	self.heroList = {}
	self.heroTrialList = {}
	self.serverTeamPlayer = {}
	self.playerList = {}
end

function BattleBaseCooperationTemplate:UpdateRoleDatas()
	self.roleDataInLua = {}
	self.heroList = {}
	self.heroTrialList = {}
	self.heroInfoList = {}
	self.playerList = {}

	local var_2_0 = self:GetSystemHeroTeam()

	if not self.room then
		return
	end

	for iter_2_0, iter_2_1 in ipairs((self.room:GetRoomPlayerIdList())) do
		local var_2_1 = self.room:GetRoomPlayerData(iter_2_1)

		for iter_2_2, iter_2_3 in ipairs(var_2_1.heroList) do
			table.insert(self.roleDataInLua, (BattleController.GetInstance():SetHeroData(iter_2_3, (iter_2_3.trialID ~= 0 or nil) and (iter_2_3.trialID or var_2_0[iter_2_2] or 0), var_2_1.playerID, var_2_1.level)))
			table.insert(self.heroList, iter_2_3.id)
			table.insert(self.heroTrialList, iter_2_3.trialID)
			table.insert(self.heroInfoList, iter_2_3)
		end

		table.insert(self.playerList, var_2_1)
	end

	self:SetMaxRaceData()
end

function BattleBaseCooperationTemplate:GetHeroTeam()
	return self.heroList, self.heroTrialList
end

function BattleBaseCooperationTemplate:GetHeroDataByPos(arg_4_1)
	local var_4_0, var_4_1 = self:GetHeroTeam()
	local var_4_2 = self:GetSystemHeroTeam()

	if var_4_0[arg_4_1] and var_4_0[arg_4_1] ~= 0 then
		if var_4_2[arg_4_1] or var_4_1[arg_4_1] and var_4_1[arg_4_1] ~= 0 then
			return GetVirtualData(var_4_2[arg_4_1] or var_4_1[arg_4_1])
		else
			local var_4_4 = self.heroInfoList and self.heroInfoList[arg_4_1]

			if var_4_4 == nil then
				return nil
			end

			return (GetPracticalData(var_4_4))
		end
	end

	return nil
end

function BattleBaseCooperationTemplate:GetIsCooperation()
	return true, self.playerList
end

function BattleBaseCooperationTemplate:GetChipList()
	return {}
end

function BattleBaseCooperationTemplate:GetComboSkillID()
	return 0
end

function BattleBaseCooperationTemplate:GetComboSkillLevel()
	return 0
end

function BattleBaseCooperationTemplate:GetResurrectImmediately()
	return true
end

return BattleBaseCooperationTemplate
