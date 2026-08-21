local var_0_0 = class("BattleBaseCooperationTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.room = CooperationData:GetRoomData()
	arg_1_0.roomId = arg_1_0.room.room_id
	arg_1_0.heroList = {}
	arg_1_0.heroTrialList = {}
	arg_1_0.serverTeamPlayer = {}
	arg_1_0.playerList = {}
end

function var_0_0.UpdateRoleDatas(arg_2_0)
	arg_2_0.roleDataInLua = {}
	arg_2_0.heroList = {}
	arg_2_0.heroTrialList = {}
	arg_2_0.heroInfoList = {}
	arg_2_0.playerList = {}

	local var_2_0 = arg_2_0:GetSystemHeroTeam()
	local var_2_1 = arg_2_0.room

	if not var_2_1 then
		return
	end

	local var_2_2 = var_2_1:GetRoomPlayerIdList()

	for iter_2_0, iter_2_1 in ipairs(var_2_2) do
		local var_2_3 = var_2_1:GetRoomPlayerData(iter_2_1)

		for iter_2_2, iter_2_3 in ipairs(var_2_3.heroList) do
			local var_2_4 = iter_2_3.trialID ~= 0 and iter_2_3.trialID or var_2_0[iter_2_2] or 0
			local var_2_5 = BattleController.GetInstance():SetHeroData(iter_2_3, var_2_4, var_2_3.playerID, var_2_3.level)

			table.insert(arg_2_0.roleDataInLua, var_2_5)
			table.insert(arg_2_0.heroList, iter_2_3.id)
			table.insert(arg_2_0.heroTrialList, iter_2_3.trialID)
			table.insert(arg_2_0.heroInfoList, iter_2_3)
		end

		table.insert(arg_2_0.playerList, var_2_3)
	end

	arg_2_0:SetMaxRaceData()
end

function var_0_0.GetHeroTeam(arg_3_0)
	return arg_3_0.heroList, arg_3_0.heroTrialList
end

function var_0_0.GetHeroDataByPos(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = arg_4_0:GetHeroTeam()
	local var_4_2 = arg_4_0:GetSystemHeroTeam()

	if var_4_0[arg_4_1] and var_4_0[arg_4_1] ~= 0 then
		if var_4_2[arg_4_1] or var_4_1[arg_4_1] and var_4_1[arg_4_1] ~= 0 then
			local var_4_3 = var_4_2[arg_4_1] or var_4_1[arg_4_1]

			return GetVirtualData(var_4_3)
		else
			local var_4_4 = arg_4_0.heroInfoList and arg_4_0.heroInfoList[arg_4_1]

			if var_4_4 == nil then
				return nil
			end

			return (GetPracticalData(var_4_4))
		end
	end

	return nil
end

function var_0_0.GetIsCooperation(arg_5_0)
	return true, arg_5_0.playerList
end

function var_0_0.GetChipList(arg_6_0)
	return {}
end

function var_0_0.GetComboSkillID(arg_7_0)
	return 0
end

function var_0_0.GetComboSkillLevel(arg_8_0)
	return 0
end

function var_0_0.GetResurrectImmediately(arg_9_0)
	return true
end

return var_0_0
