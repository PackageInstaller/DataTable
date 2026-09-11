local BattleEquipBreakThroughMaterialStageTemplate = class("BattleEquipBreakThroughMaterialStageTemplate", BattleBaseStageTemplate)

function BattleEquipBreakThroughMaterialStageTemplate:Ctor(arg_1_1)
	BattleEquipBreakThroughMaterialStageTemplate.super.Ctor(self, arg_1_1)

	self.id = arg_1_1
	self.cfg = BattleEquipBreakThroughMaterialStageCfg[arg_1_1]
	self.mapStageID_ = EquipBreakThroughMaterialData:GetChooseMapStageID()
end

function BattleEquipBreakThroughMaterialStageTemplate:Init()
	self:InitHeroList()
	self:InitComboSkillID()
	self:InitChipData()
end

function BattleEquipBreakThroughMaterialStageTemplate:GetDest()
	return self.id
end

function BattleEquipBreakThroughMaterialStageTemplate:GetStageId()
	return self.id
end

function BattleEquipBreakThroughMaterialStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL
end

function BattleEquipBreakThroughMaterialStageTemplate:GetMap()
	return self.cfg.map, false
end

function BattleEquipBreakThroughMaterialStageTemplate:GetAILevel()
	return self.cfg.ai_level
end

function BattleEquipBreakThroughMaterialStageTemplate:GetEnemyLevel()
	return self.cfg.monster_level
end

function BattleEquipBreakThroughMaterialStageTemplate:InitChipData()
	self.chipManagerID_ = EquipBreakThroughMaterialData:GetChipManagerID()
	self.chipList_ = self:GetHeroChipData(clone(EquipBreakThroughMaterialData:GetChipList()))
end

function BattleEquipBreakThroughMaterialStageTemplate:GetChipAndAIList(arg_10_1)
	local var_10_0 = {}

	if self.chipManagerID_ ~= 0 then
		table.insert(var_10_0, self.chipManagerID_)
	end

	for iter_10_0, iter_10_1 in ipairs(self.chipList_) do
		table.insert(var_10_0, iter_10_1)
	end

	if arg_10_1 ~= 0 then
		arg_10_1 = SkinCfg[arg_10_1].hero
	end

	local var_10_1, var_10_2 = self:GetHeroTeam()
	local var_10_3 = table.keyof(var_10_1, arg_10_1)

	if var_10_3 and arg_10_1 ~= 0 and var_10_2[var_10_3] == 0 then
		for iter_10_2, iter_10_3 in ipairs(ChipData:GetEnableHeroChipIdByHeroId(arg_10_1) or {}) do
			table.insert(var_10_0, iter_10_3)
		end
	end

	return var_10_0
end

function BattleEquipBreakThroughMaterialStageTemplate:GetHeroTeam()
	return self.heroList_, self.heroTrialList_
end

function BattleEquipBreakThroughMaterialStageTemplate:UpdateRoleDatas(arg_12_1)
	self.serverTeamPlayer = arg_12_1
	self.roleDataInLua = {}

	local var_12_0 = self:GetSystemHeroTeam()

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetEquipBreakThroughMaterialHeroData(iter_12_0, iter_12_1, (iter_12_1.trialID ~= 0 or nil) and (iter_12_1.trialID or var_12_0[iter_12_0] or 0), arg_12_1.playerID, arg_12_1.level)))
	end

	self:SetMaxRaceData()
end

function BattleEquipBreakThroughMaterialStageTemplate:GetMaxRaceData()
	return 0, 0
end

function BattleEquipBreakThroughMaterialStageTemplate:GetStageAffix()
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in pairs(EquipBreakThroughMaterialData:GetGlobalAffixList() or {}) do
		table.insert(var_14_0, iter_14_1[1])
		table.insert(var_14_1, iter_14_1[2])
		table.insert(var_14_2, iter_14_1[3])
	end

	for iter_14_2, iter_14_3 in pairs(EquipBreakThroughMaterialData:GetBuffList() or {}) do
		table.insert(var_14_0, EquipBreakThroughMaterialItemCfg[iter_14_3].params[1])
		table.insert(var_14_1, EquipBreakThroughMaterialItemCfg[iter_14_3].params[2])
		table.insert(var_14_2, EquipBreakThroughMaterialItemCfg[iter_14_3].params[3])
	end

	for iter_14_4, iter_14_5 in pairs(EquipBreakThroughMaterialData:GetAttributeList() or {}) do
		local var_14_3 = getAttributeAffix(iter_14_4, iter_14_5)

		table.insert(var_14_0, var_14_3[1])
		table.insert(var_14_1, var_14_3[2])
		table.insert(var_14_2, var_14_3[3])
	end

	return var_14_0, var_14_1, var_14_2
end

function BattleEquipBreakThroughMaterialStageTemplate:GetAttributeFactor()
	local var_15_0 = EquipBreakThroughMaterialDifficultyCfg[EquipBreakThroughMaterialData:GetSelectModeID()]

	return Vector3.New(var_15_0.difficult_multipliter[1] / 1000, var_15_0.difficult_multipliter[2] / 1000, var_15_0.difficult_multipliter[3] / 1000)
end

function BattleEquipBreakThroughMaterialStageTemplate:GetServerExtant()
	return self.mapStageID_
end

return BattleEquipBreakThroughMaterialStageTemplate
