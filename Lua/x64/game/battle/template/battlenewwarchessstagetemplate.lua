local var_0_0 = class("BattleNewWarChessStageTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2
	arg_1_0.cfg = BattleNewWarChessStageCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitChipData(arg_3_0)
	local var_3_0 = {}
	local var_3_1

	arg_3_0.chipManagerID_, var_3_1 = ReserveTools.GetMimirData(arg_3_0:GetReserveParams())

	if not arg_3_0.chipManagerID_ or arg_3_0.chipManagerID_ == 0 then
		var_3_1 = {}
	end

	local var_3_2, var_3_3 = arg_3_0:GetHeroTeam()
	local var_3_4 = {}
	local var_3_5 = false

	for iter_3_0, iter_3_1 in pairs(var_3_2) do
		local var_3_6 = false

		for iter_3_2, iter_3_3 in pairs(var_3_3) do
			if iter_3_1 == (iter_3_3 - iter_3_3 % 100) / 100 then
				var_3_6 = true
			end
		end

		if var_3_6 == false then
			table.insert(var_3_4, iter_3_1)
		end
	end

	arg_3_0.chipList_ = ChipData:GetEnableAllChipList(arg_3_0.chipManagerID_, var_3_4, var_3_1)
end

function var_0_0.GetDest(arg_4_0)
	return arg_4_0.id
end

function var_0_0.GetStageId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.GetType(arg_6_0)
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS
end

function var_0_0.GetMap(arg_7_0)
	return arg_7_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_8_0)
	return arg_8_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_9_0)
	return arg_9_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_10_0)
	return arg_10_0.heroList_, arg_10_0.heroTrialList_
end

function var_0_0.GetStageAffix(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}
	local var_11_3 = type(arg_11_0.cfg.affix_type) == "table" and arg_11_0.cfg.affix_type or {}

	for iter_11_0, iter_11_1 in pairs(var_11_3 or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	local var_11_4 = manager.NewChessManager:GetCurBattleAffix()

	for iter_11_2, iter_11_3 in pairs(var_11_4 or {}) do
		table.insert(var_11_0, iter_11_3[1])
		table.insert(var_11_1, iter_11_3[2])
		table.insert(var_11_2, iter_11_3[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.UpdateRoleDatas(arg_12_0, arg_12_1)
	arg_12_0.serverTeamPlayer = arg_12_1
	arg_12_0.roleDataInLua = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.heroList) do
		local var_12_0 = iter_12_1.trialID ~= 0 and iter_12_1.trialID
		local var_12_1 = BattleController.GetInstance():SetNewWarChessHeroData(iter_12_1, var_12_0, arg_12_1.playerID, arg_12_1.level)

		table.insert(arg_12_0.roleDataInLua, var_12_1)
	end

	arg_12_0:SetMaxRaceData()
end

return var_0_0
