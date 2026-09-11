local BattleBaseStageTemplate = class("BattleBaseStageTemplate")

function BattleBaseStageTemplate:Ctor(arg_1_1)
	self.roleDataInLua = {}
	self.multiple_ = 1
	self.comboSkillID_ = 0
	self.maxRaceID_ = 0
	self.maxRacePlayerCount_ = 1
	self.serverTeamPlayer = nil
end

function BattleBaseStageTemplate:Init()
	return
end

function BattleBaseStageTemplate:InitHeroList()
	self.heroList_, _, _, self.heroTrialList_ = ReserveTools.GetHeroList(self:GetReserveParams())
end

function BattleBaseStageTemplate:GetDest()
	return 0
end

function BattleBaseStageTemplate:GetStageId()
	return 0
end

function BattleBaseStageTemplate:GetType()
	return BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
end

function BattleBaseStageTemplate:GetMap()
	return 0, false
end

function BattleBaseStageTemplate:GetAILevel()
	return 0
end

function BattleBaseStageTemplate:GetEnemyLevel()
	return 0
end

function BattleBaseStageTemplate:GetStageAffix()
	return {}, {}, {}
end

function BattleBaseStageTemplate:GetBattleStageAffix()
	if self.affixIDList == nil or self.levelIDList == nil or self.targetTypeList == nil then
		self.affixIDList, self.levelIDList, self.targetTypeList = self:GetStageAffix()
	end

	return self.affixIDList, self.levelIDList, self.targetTypeList
end

function BattleBaseStageTemplate:GetSettingShowAffix()
	local var_12_0 = {}
	local var_12_1, var_12_2, var_12_3 = self:GetBattleStageAffix()

	for iter_12_0 = 1, #var_12_1 do
		table.insert(var_12_0, {
			var_12_1[iter_12_0],
			var_12_2[iter_12_0],
			var_12_3[iter_12_0]
		})
	end

	return var_12_0
end

function BattleBaseStageTemplate:GetRevive()
	return false, 0, 0, 0
end

function BattleBaseStageTemplate:GetMultiple()
	return self.multiple_ or 1
end

function BattleBaseStageTemplate:SetMultiple(arg_15_1)
	self.multiple_ = arg_15_1
end

function BattleBaseStageTemplate:GetClearTime()
	return 0
end

function BattleBaseStageTemplate:GetHeroTeam()
	return {}, {}
end

function BattleBaseStageTemplate:GetAssistHeroOwnerList()
	return {}
end

function BattleBaseStageTemplate:GetSystemHeroTeam()
	return {}
end

function BattleBaseStageTemplate:GetRoleDatas()
	return self.roleDataInLua
end

function BattleBaseStageTemplate:GetThreeStar()
	return {}
end

function BattleBaseStageTemplate:GetAddUserExp()
	return 0
end

function BattleBaseStageTemplate:GetAddHeroExp()
	return 0
end

function BattleBaseStageTemplate:GetCost()
	return 0
end

function BattleBaseStageTemplate:GetAttributeFactor()
	local var_25_0 = BattleStageTools.GetStageCfg(self:GetType(), self:GetStageId())

	if var_25_0.attribute_factor and var_25_0.attribute_factor[3] then
		return Vector3.New(var_25_0.attribute_factor[1] / 1000, var_25_0.attribute_factor[2] / 1000, var_25_0.attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function BattleBaseStageTemplate:UpdateRoleDatas(arg_26_1)
	self.serverTeamPlayer = arg_26_1
	self.roleDataInLua = {}

	local var_26_0 = self:GetSystemHeroTeam()

	for iter_26_0, iter_26_1 in ipairs(arg_26_1.heroList) do
		table.insert(self.roleDataInLua, (BattleController.GetInstance():SetHeroData(iter_26_1, (iter_26_1.trialID ~= 0 or nil) and (iter_26_1.trialID or var_26_0[iter_26_0] or 0), arg_26_1.playerID, arg_26_1.level)))
	end

	self:SetMaxRaceData()
end

function BattleBaseStageTemplate:GetHeroDataByPos(arg_27_1)
	local var_27_0, var_27_1 = self:GetHeroTeam()
	local var_27_2 = self:GetSystemHeroTeam()

	if var_27_0[arg_27_1] and var_27_0[arg_27_1] ~= 0 then
		if var_27_2[arg_27_1] or var_27_1[arg_27_1] and var_27_1[arg_27_1] ~= 0 then
			return GetVirtualData(var_27_2[arg_27_1] or var_27_1[arg_27_1])
		else
			local var_27_5 = self.serverTeamPlayer and self.serverTeamPlayer.heroList[arg_27_1]

			if var_27_5 == nil then
				return nil
			end

			return (GetPracticalData(var_27_5))
		end
	end

	return nil
end

function BattleBaseStageTemplate:GetIsStoryTag()
	return self.storyTag or false
end

function BattleBaseStageTemplate:SetIsStoryTag(arg_29_1)
	self.storyTag = arg_29_1
end

function BattleBaseStageTemplate:GetIsCooperation()
	return false, {}
end

function BattleBaseStageTemplate:InitComboSkillID()
	self.comboSkillID_ = ReserveTools.GetComboSkillID(self:GetReserveParams())
end

function BattleBaseStageTemplate:GetComboSkillID()
	return self.comboSkillID_
end

function BattleBaseStageTemplate:GetComboSkillLevel()
	return ComboSkillData:GetCurComboSkillLevel((self:GetComboSkillID()))
end

function BattleBaseStageTemplate:InitChipData()
	local var_34_0 = BattleStageTools.GetStageCfg(self:GetType(), self:GetStageId())
	local var_34_1 = {}
	local var_34_2, var_34_3, var_34_4, var_34_5, var_34_6 = BattleStageTools.GetStageFixedChipInfo(self:GetType(), self:GetStageId())

	if var_34_2 then
		self.chipManagerID_ = var_34_3
		var_34_1 = var_34_4
		self.charChipBaseID_ = var_34_5
		self.charChipExtraIDList_ = var_34_6
	else
		var_34_1 = self:GetBaseChipData()
		self.charChipBaseID_ = nil
		self.charChipExtraIDList_ = nil
	end

	self.chipList_ = self:GetHeroChipData(var_34_1)
end

function BattleBaseStageTemplate:GetBaseChipData()
	local var_35_1

	self.chipManagerID_, var_35_1 = ReserveTools.GetMimirData(self:GetReserveParams())

	return (not self.chipManagerID_ or self.chipManagerID_ == 0 or nil) and {}
end

function BattleBaseStageTemplate:GetHeroChipData(arg_36_1)
	local var_36_0, var_36_1 = self:GetHeroTeam()

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if iter_36_1 ~= 0 then
			if var_36_1[iter_36_0] and var_36_1[iter_36_0] ~= 0 then
				table.insertto(arg_36_1, HeroStandardSystemCfg[var_36_1[iter_36_0]].using_hero_chip)
			else
				for iter_36_2, iter_36_3 in pairs(ChipData:GetEnableHeroChipIdByHeroId(iter_36_1) or {}) do
					if iter_36_3 > 0 then
						table.insert(arg_36_1, iter_36_3)
					end
				end
			end
		end
	end

	return arg_36_1
end

function BattleBaseStageTemplate:GetChipManagerID()
	return self.chipManagerID_ or 0
end

function BattleBaseStageTemplate:GetChipList()
	return self.chipList_ or {}
end

function BattleBaseStageTemplate:GetChipOfHeroDic()
	return {}
end

function BattleBaseStageTemplate:SetMaxRaceData()
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(self.roleDataInLua) do
		var_40_0[#var_40_0 + 1] = SkinCfg[iter_40_1.ID].hero
	end

	self.maxRaceID_, self.maxRacePlayerCount_ = BattleTools.GetMaxRaceData(var_40_0)
end

function BattleBaseStageTemplate:GetMaxRaceData()
	return self.maxRaceID_, self.maxRacePlayerCount_
end

function BattleBaseStageTemplate:GetPathList()
	return {}
end

function BattleBaseStageTemplate:GetActivityID()
	return self.activityID_ or 0
end

function BattleBaseStageTemplate:GetServerExtant()
	return 0
end

function BattleBaseStageTemplate:GetBattleTime()
	return 0
end

function BattleBaseStageTemplate:GetResurrectHP()
	return 0
end

function BattleBaseStageTemplate:GetResurrectImmediately()
	return false
end

function BattleBaseStageTemplate:GetTargetEnemyID()
	return 0
end

function BattleBaseStageTemplate:SetReserveParams(arg_49_1)
	self.reserveParams_ = arg_49_1 or ReserveTools.GetReserveParams(self:GetType(), self:GetStageId(), self:GetActivityID())
	self.contID_ = self.reserveParams_.contID
	self.teamIndex_ = self.reserveParams_.teamIndex
	self.customReserveParams_ = self.reserveParams_.customData
end

function BattleBaseStageTemplate:GetReserveParams()
	self.reserveParams_ = self.reserveParams_ or ReserveTools.GetReserveParams(self:GetType(), self:GetStageId(), self:GetActivityID())

	return self.reserveParams_
end

function BattleBaseStageTemplate:GetContID()
	return self.contID_ or ReserveTools.GetContID(self:GetType(), self:GetStageId())
end

function BattleBaseStageTemplate:GetTeamIndex()
	return self.teamIndex_ or ReserveConst.DEFAULT_TEAM_INDEX
end

function BattleBaseStageTemplate:GetCustomReserveParams()
	return self.customReserveParams_ or {}
end

function BattleBaseStageTemplate:GetActivityReforgeSkillList()
	return {}
end

function BattleBaseStageTemplate:GetBattleParams()
	return 0
end

function BattleBaseStageTemplate:GetCharChipBaseID()
	return self.charChipBaseID_ or ReserveTools.GetCharChipBaseID(self:GetReserveParams())
end

function BattleBaseStageTemplate:GetCharChipIDList()
	if self.charChipBaseID_ then
		if self.charChipBaseID_ == 0 then
			return {}
		end

		local var_57_0 = {
			self.charChipBaseID_
		}

		table.insertto(var_57_0, self.charChipExtraIDList_)

		return var_57_0
	end

	return ReserveTools.GetCharChipIDList(self:GetReserveParams())
end

function BattleBaseStageTemplate:GetCharChipExtraIDList()
	return self.charChipExtraIDList_ or ReserveTools.GetCharChipExtraIDList(self:GetReserveParams())
end

function BattleBaseStageTemplate:GetOpts()
	return {}
end

return BattleBaseStageTemplate
