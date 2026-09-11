local BattleNewWarChessStageTemplate = class("BattleNewWarChessStageTemplate", BattleBaseStageTemplate)

function BattleNewWarChessStageTemplate:Ctor(arg_1_1, arg_1_2)
	BattleNewWarChessStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.activityID_ = arg_1_2
	self.cfg = BattleNewWarChessStageCfg[arg_1_1]
end

function BattleNewWarChessStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleNewWarChessStageTemplate:InitChipData()
	local var_3_1

	self.chipManagerID_, var_3_1 = ReserveTools.GetMimirData(self:GetReserveParams())

	if not self.chipManagerID_ or self.chipManagerID_ == 0 then
		var_3_1 = {}
	end

	local var_3_2, var_3_3 = self:GetHeroTeam()
	local var_3_4 = {}

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

	self.chipList_ = ChipData:GetEnableAllChipList(self.chipManagerID_, var_3_4, var_3_1)
end

function BattleNewWarChessStageTemplate:GetDest()
	return self.id
end

function BattleNewWarChessStageTemplate:GetStageId()
	return self.id
end

function BattleNewWarChessStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_NEWWARCHESS
end

function BattleNewWarChessStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleNewWarChessStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleNewWarChessStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleNewWarChessStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleNewWarChessStageTemplate:GetStageAffix()
	local var_11_0 = {}
	local var_11_1 = {}
	local var_11_2 = {}

	for iter_11_0, iter_11_1 in pairs((type(self.cfg.affix_type) == "table" or nil) and (self.cfg.affix_type or {}) or {}) do
		table.insert(var_11_0, iter_11_1[1])
		table.insert(var_11_1, iter_11_1[2])
		table.insert(var_11_2, iter_11_1[3])
	end

	for iter_11_2, iter_11_3 in pairs(manager.NewChessManager:GetCurBattleAffix() or {}) do
		table.insert(var_11_0, iter_11_3[1])
		table.insert(var_11_1, iter_11_3[2])
		table.insert(var_11_2, iter_11_3[3])
	end

	return var_11_0, var_11_1, var_11_2
end

function BattleNewWarChessStageTemplate:UpdateRoleDatas(arg_12_1)
	self.serverTeamPlayer = arg_12_1
	self.roleDataInLua = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetNewWarChessHeroData(iter_12_1, iter_12_1.trialID ~= 0 and iter_12_1.trialID, arg_12_1.playerID, arg_12_1.level)))
	end

	self:SetMaxRaceData()
end

return BattleNewWarChessStageTemplate
