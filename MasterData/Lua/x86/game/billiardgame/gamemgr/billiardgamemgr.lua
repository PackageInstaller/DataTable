local var_0_0 = {}
local var_0_1 = false
local var_0_2
local var_0_3 = {
	hungryVal = 3,
	turn = 3,
	id = 1,
	monsterKilled = 2,
	hero = {
		{
			id = 122,
			cooldown = 4,
			hp = 123,
			buffId = {
				1
			}
		},
		{
			id = 123,
			cooldown = 4,
			hp = 123,
			buffId = {
				1
			}
		},
		{
			id = 124,
			cooldown = 4,
			hp = 123,
			buffId = {
				1
			}
		}
	}
}

function var_0_0:BuildContext(arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	self:SetGameType(BilliardGameConst.GameType.BALL)

	self.curRound = 0
	self.context = {
		levelID = arg_1_1,
		stageId = arg_1_2,
		hero = {
			arg_1_3,
			arg_1_4,
			arg_1_5
		}
	}
end

function var_0_0:BuildVehicleContext(arg_2_1, arg_2_2)
	self:SetGameType(BilliardGameConst.GameType.VEHICLE)

	self.vehicleContext = {
		stageId = arg_2_1,
		hero = arg_2_2
	}
	self.startTime_ = manager.time:GetServerTime()

	self:CheckStageSkill()
	self:ResetVehicleParams()
	self:CreateMergeBuffKV()
end

function var_0_0:ResetVehicleParams()
	self.newBuffUnlockList_ = {}
	self.killMonsterCount_ = 0
	self.buffSelectList_ = {}
	self.effectBuffList_ = {}
	self.mergedBuffList_ = {}

	for iter_3_0, iter_3_1 in ipairs(MergeBallBuffCfg.all) do
		local var_3_0 = MergeBallBuffCfg[iter_3_1]

		if MergeBallBuffCfg[iter_3_1].type == BilliardGameConst.MergeBallBuffType.PASSIVE or var_3_0.type == BilliardGameConst.MergeBallBuffType.BASIC then
			table.insert(self.buffSelectList_, iter_3_1)
		end

		if var_3_0.type == BilliardGameConst.MergeBallBuffType.EFFECT and not table.indexof(BilliardGameConst.FixedBuffIdList, iter_3_1) then
			table.insert(self.effectBuffList_, iter_3_1)
		end

		if var_3_0.formula and #var_3_0.formula > 0 then
			if var_3_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
				if BilliardGameTools.GetIsUltimateSkillUnlocked() then
					table.insert(self.mergedBuffList_, iter_3_1)
				end
			else
				table.insert(self.mergedBuffList_, iter_3_1)
			end
		end
	end

	self.allSelectedSkillDic_ = {}
	self.activeSelectSkillList_ = {}

	for iter_3_2 = 1, BilliardGameConst.ActiveSkillCount + self.addActiveSkillCount_ do
		self.activeSelectSkillList_[iter_3_2] = {}
	end

	self.passiveSelectSkillList_ = {}

	for iter_3_3 = 1, BilliardGameConst.PassiveSkillCount do
		self.passiveSelectSkillList_[iter_3_3] = {}
	end

	self.activeSelectSkillCount = 0
	self.passiveSelectSkillCount = 0
	self.curRound = 0
	self.randomSelectCount = 0
	self.mergerSelectCount = 0
	self.canSelectSkillList_ = {}
	self.beforeSelectSkillList_ = {}
	self.levelUpedSkillList_ = {}
	self.trackBuffId_ = nil
	self.addAnimBuffIdList_ = {}
	self.removeAnimBuffIdList_ = {}
	self.roundBuffIdList_ = {}
end

function var_0_0:TestAddActiveSkill(arg_4_1, arg_4_2)
	self:AddSelectedSkill(arg_4_1, arg_4_2)
end

function var_0_0.TestAddMergeProcess(arg_5_0, arg_5_1)
	manager.notify:Invoke(BilliardGameEvent.TEST, arg_5_1)
end

function var_0_0:Restart()
	if self.gameType == BilliardGameConst.GameType.BALL then
		LaunchBilliardGame(self.context.levelID, self.context.stageId, self.context.hero)
	else
		LaunchBilliardGame_5_1(self.vehicleContext.stageId, self.vehicleContext.hero)
	end
end

function var_0_0.IsInBilliardGame(arg_7_0)
	return var_0_1
end

function var_0_0.Init(arg_8_0)
	return
end

function var_0_0.SetGameType(arg_9_0, arg_9_1)
	arg_9_0.gameType = arg_9_1
end

function var_0_0:GetGameType()
	return self.gameType
end

function var_0_0.UpdateLogicData(arg_11_0)
	manager.notify:Invoke(BilliardGameEvent.BILLIARD_UPDATE_VIEW)
end

function var_0_0.GetLogicData(arg_12_0)
	return var_0_3
end

function var_0_0.EnterGame(arg_13_0)
	var_0_1 = true
	var_0_2 = BilliardGameLuaBridge.GetStageData()
end

function var_0_0:GetStageId()
	if self.gameType == BilliardGameConst.GameType.BALL then
		return self.context.stageId
	else
		return self.vehicleContext.stageId
	end
end

function var_0_0:GetLevelId()
	if self.gameType == BilliardGameConst.GameType.BALL then
		return self.context.levelID
	else
		return nil
	end
end

function var_0_0:GetHero()
	if self.gameType == BilliardGameConst.GameType.BALL then
		return self.context.hero
	else
		return self.vehicleContext.hero
	end
end

function var_0_0:OnRoundBegin()
	self.curRound = self.curRound + 1

	self:ClearAnimBuffIdList()

	self.roundBuffIdList_ = {}
end

function var_0_0:GetCurRound()
	return self.curRound
end

function var_0_0:OnGameSceneLoaded()
	self:UpdateLogicData()
end

function var_0_0.ExitGame(arg_20_0)
	var_0_2 = nil
	var_0_1 = false
end

function var_0_0.OverGame(arg_21_0)
	var_0_1 = false
end

function var_0_0:GetRoundSelectBuffList()
	local var_22_0, var_22_1 = self:GetRandomSelectBuffId()

	self.canSelectSkillList_ = {
		var_22_0,
		var_22_1
	}
	self.beforeSelectSkillList_ = self:GetAllSelectBuffList()

	for iter_22_0 = 1, 2 do
		table.insert(self.roundBuffIdList_, self.canSelectSkillList_[iter_22_0])
	end

	return self.canSelectSkillList_
end

function var_0_0:CheckStageForceSelectBuff()
	for iter_23_0, iter_23_1 in ipairs(MergeBallStageCfg[self:GetStageId()].designated_buff) do
		if iter_23_1[1] == self.randomSelectCount then
			return true, iter_23_1[2], iter_23_1[3]
		end
	end

	return false
end

function var_0_0:GetRandomSelectBuffId()
	self.randomSelectCount = self.randomSelectCount + 1

	local var_24_0, var_24_1, var_24_2 = self:CheckStageForceSelectBuff()

	if var_24_0 then
		return var_24_1, var_24_2
	end

	if #self.buffSelectList_ < 2 then
		if #self.buffSelectList_ == 1 then
			return self.buffSelectList_[1], self:GetRandomEffectBuffId(1)
		else
			return self:GetRandomEffectBuffId(2)
		end
	end

	local var_24_3 = self:GetCanUpgradeSkillList()

	if #self.passiveSelectSkillList_ - self.passiveSelectSkillCount + (#self.activeSelectSkillList_ - self.activeSelectSkillCount) <= 0 then
		if #var_24_3 <= 0 then
			return self:GetRandomEffectBuffId(2)
		elseif #var_24_3 == 1 then
			return var_24_3[1].mainBuffId, self:GetRandomEffectBuffId(1)
		else
			local var_24_4 = {}

			for iter_24_0, iter_24_1 in ipairs(var_24_3) do
				table.insert(var_24_4, iter_24_1.mainBuffId)
			end

			return self:GetTwoRandomBuff(var_24_4)
		end
	else
		local var_24_5 = self:GetCanSelectBuffList(#self.activeSelectSkillList_ - self.activeSelectSkillCount, #self.passiveSelectSkillList_ - self.passiveSelectSkillCount)

		if math.random(1, 100) <= GameSetting.mergeball_upgrade_up_rate.value[1] and #var_24_3 > 0 then
			local var_24_6 = var_24_3[math.random(1, #var_24_3)].mainBuffId
			local var_24_7 = table.indexof(var_24_5, var_24_6)

			if var_24_7 then
				table.remove(var_24_5, var_24_7)
			end

			if #var_24_5 > 0 then
				return var_24_6, var_24_5[math.random(1, #var_24_5)]
			else
				return var_24_6, self:GetRandomEffectBuffId(1)
			end
		else
			return self:GetTwoRandomBuff(var_24_5)
		end
	end
end

function var_0_0:GetCanSelectBuffList(arg_25_1, arg_25_2)
	local var_25_0 = clone(self.buffSelectList_)
	local var_25_1 = {}

	for iter_25_0 = 1, #var_25_0 do
		if self.allSelectedSkillDic_[var_25_0[iter_25_0]] and self.allSelectedSkillDic_[var_25_0[iter_25_0]].level >= BilliardGameConst.WuluoVehicleSkillMaxLevel or arg_25_1 <= 0 and MergeBallBuffCfg[var_25_0[iter_25_0]].type == BilliardGameConst.MergeBallBuffType.BASIC or arg_25_2 <= 0 and MergeBallBuffCfg[var_25_0[iter_25_0]].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			table.insert(var_25_1, iter_25_0)
		end
	end

	for iter_25_1 = #var_25_1, 1, -1 do
		table.remove(var_25_0, var_25_1[iter_25_1])
	end

	return (self:RemoveRoundShownBuff(var_25_0, 2))
end

function var_0_0:GetRandomEffectBuffId(arg_26_1)
	local var_26_0 = self:RemoveRoundShownBuff(clone(self.effectBuffList_), arg_26_1)

	if arg_26_1 == 1 then
		return var_26_0[math.random(1, #var_26_0)]
	elseif arg_26_1 == 2 then
		return self:GetTwoRandomBuff(var_26_0)
	end
end

function var_0_0:RemoveRoundShownBuff(arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or 0

	local var_27_0 = clone(arg_27_1)

	for iter_27_0 = #var_27_0, 1, -1 do
		if arg_27_2 >= #var_27_0 then
			break
		end

		if table.indexof(self.roundBuffIdList_, var_27_0[iter_27_0]) then
			table.remove(var_27_0, iter_27_0)
		end
	end

	return var_27_0
end

function var_0_0.GetTwoRandomBuff(arg_28_0, arg_28_1)
	local var_28_0 = math.random(1, #arg_28_1)

	table.remove(arg_28_1, var_28_0)

	return arg_28_1[var_28_0], arg_28_1[math.random(1, #arg_28_1)]
end

function var_0_0:AddSelectedSkill(arg_29_1, arg_29_2)
	local var_29_1 = arg_29_2 or 1

	if self.addFirstSelectLevel_ ~= 0 then
		var_29_1 = var_29_1 + self.addFirstSelectLevel_

		table.insert(self.levelUpedSkillList_, arg_29_1)

		self.addFirstSelectLevel_ = 0
	end

	local var_29_2 = MergeBallBuffCfg[arg_29_1]

	if not MergeBallBuffCfg[arg_29_1] then
		print("Invalid mainBuffId: " .. tostring(arg_29_1))

		return
	end

	if var_29_2.type == BilliardGameConst.MergeBallBuffType.EFFECT then
		self:OnAddEffectSkill(arg_29_1)
		manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)

		return
	end

	local var_29_3

	if var_29_2.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
		var_29_3 = self.passiveSelectSkillList_ or self.activeSelectSkillList_
	end

	for iter_29_0, iter_29_1 in ipairs(var_29_3) do
		if iter_29_1 and iter_29_1.mainBuffId == arg_29_1 then
			iter_29_1:AddLevel(1)
			manager.notify:Invoke(BilliardGameEvent.SINGLE_SKILL_UPGRADE, iter_29_1)
			BilliardGameLuaBridge.AddBuff(iter_29_1.graphId, self:GetHero())
			self:UpdateVehicleSkill()
			self:OnSkillChange(BilliardGameConst.ChangeSkillType.LEVEL_UP, BilliardGameConst.ChangeSkillOpt.SELECT, iter_29_1.buffIdList, {
				iter_29_1
			})
			manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)

			return
		end
	end

	self:FindEmptySkillSlotAndAdd(false, var_29_3, {
		buffIdList = {
			arg_29_1
		},
		addLevel = var_29_1
	})
	manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)
end

function var_0_0:RemoveSelectedSkill(arg_30_1, arg_30_2)
	local var_30_0 = MergeBallBuffCfg[arg_30_1]

	if not MergeBallBuffCfg[arg_30_1] then
		print("Trying to remove invalid buffId: " .. tostring(arg_30_1))

		return
	end

	local var_30_1 = var_30_0.type == BilliardGameConst.MergeBallBuffType.PASSIVE
	local var_30_2

	if var_30_0.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
		var_30_2 = self.passiveSelectSkillList_ or self.activeSelectSkillList_
	end

	for iter_30_0, iter_30_1 in ipairs(var_30_2) do
		if iter_30_1 and iter_30_1.mainBuffId == arg_30_1 then
			var_30_2[iter_30_0] = {}

			if var_30_1 then
				self.passiveSelectSkillCount = self.passiveSelectSkillCount - 1
			else
				self.activeSelectSkillCount = self.activeSelectSkillCount - 1
			end

			self.allSelectedSkillDic_[arg_30_1] = nil

			if not arg_30_2 then
				BilliardGameLuaBridge.RemoveBuff(iter_30_1.graphId, self:GetHero())

				local var_30_3 = table.indexof(self.levelUpedSkillList_, iter_30_1.mainBuffId)

				if var_30_3 then
					table.remove(self.levelUpedSkillList_, var_30_3)
				end
			end

			self:UpdateVehicleSkill()

			break
		end
	end
end

function var_0_0:FindAvailableMergeSkills()
	self.mergerSelectCount = self.mergerSelectCount + 1
	self.beforeSelectSkillList_ = self:GetAllSelectBuffList()

	local var_31_0 = {}
	local var_31_1 = {}

	for iter_31_0, iter_31_1 in ipairs(self.mergedBuffList_) do
		local var_31_2 = true

		for iter_31_2, iter_31_3 in ipairs(MergeBallBuffCfg[iter_31_1].formula) do
			if self.allSelectedSkillDic_[iter_31_3] == nil or self.allSelectedSkillDic_[iter_31_3].isCombine_ or self.allSelectedSkillDic_[iter_31_3].level < BilliardGameConst.WuluoVehicleSkillMaxLevel then
				var_31_2 = false

				break
			end
		end

		if var_31_2 then
			local var_31_3 = false

			for iter_31_4, iter_31_5 in ipairs(self.activeSelectSkillList_) do
				if iter_31_5 and iter_31_5.mainBuffId == iter_31_1 then
					var_31_3 = true

					break
				end
			end

			if not var_31_3 then
				local var_31_4 = BilliardVehicleSkillDataTemplate.New()

				var_31_4:Init({
					level = 1,
					buffIdList = {
						iter_31_1
					}
				})
				table.insert(var_31_0, var_31_4)
				table.insert(var_31_1, iter_31_1)
			end
		end
	end

	for iter_31_6, iter_31_7 in ipairs((self:GetCombinableSkills(var_31_1))) do
		table.insert(var_31_0, iter_31_7)
	end

	table.sort(var_31_0, function(arg_32_0, arg_32_1)
		return MergeBallBuffCfg[arg_32_0.mainBuffId].type > MergeBallBuffCfg[arg_32_1.mainBuffId].type
	end)

	if #self:GetCanUpgradeSkillList() > 0 then
		table.insert(var_31_0, {})
	end

	local var_31_5, var_31_6 = self:GetMergeEffectBuff()

	table.insert(var_31_0, var_31_5)
	table.insert(var_31_0, var_31_6)

	self.canSelectSkillList_ = var_31_0

	return var_31_0
end

function var_0_0:GetMergeEffectBuff()
	local var_33_0 = BilliardGameConst.FixedBuffIdList
	local var_33_3
	local var_33_2
	local var_33_1

	if not BilliardGameConst.FixedBuffIdList then
		var_33_0 = {}
		var_33_1 = BilliardVehicleSkillDataTemplate.New()
		var_33_2 = {
			level = 1
		}
		var_33_3 = {}
	end

	var_33_3[1] = var_33_0[math.random(1, #var_33_0)]
	var_33_2.buffIdList = var_33_3

	var_33_1:Init(var_33_2)

	local var_33_4 = BilliardVehicleSkillDataTemplate.New()

	var_33_4:Init({
		level = 1,
		buffIdList = {
			self.effectBuffList_[math.random(1, #self.effectBuffList_)]
		}
	})

	return var_33_1, var_33_4
end

function var_0_0:GetCombinableSkills(arg_34_1)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(self.activeSelectSkillList_) do
		if iter_34_1.mainBuffId and not iter_34_1.isCombine_ and iter_34_1.level >= BilliardGameConst.WuluoVehicleSkillMaxLevel then
			table.insert(var_34_1, iter_34_1.mainBuffId)
		end
	end

	for iter_34_2 = 1, #var_34_1 do
		for iter_34_3 = iter_34_2 + 1, #var_34_1 do
			local var_34_2 = {
				var_34_1[iter_34_2],
				var_34_1[iter_34_3]
			}

			table.sort(var_34_2)

			if not self.blockedPairs_[table.concat(var_34_2, ",")] then
				if MergeBallBuffCfg[var_34_1[iter_34_2]].type ~= BilliardGameConst.MergeBallBuffType.BASIC then
					if MergeBallBuffCfg[var_34_1[iter_34_3]].type == BilliardGameConst.MergeBallBuffType.BASIC then
						local var_34_3 = BilliardVehicleSkillDataTemplate.New()
						local var_34_4 = {
							level = 2
						}

						var_34_4.buffIdList = self:DetermineMainAndSubBuff(var_34_1[iter_34_2], var_34_1[iter_34_3])

						var_34_3:Init(var_34_4)
						table.insert(var_34_0, var_34_3)
					end
				end
			end
		end
	end

	return var_34_0
end

function var_0_0:CreateMergeBuffKV()
	self.blockedPairs_ = {}

	for iter_35_0, iter_35_1 in ipairs(MergeBallBuffCfg.all) do
		if MergeBallBuffCfg[iter_35_1].formula and #MergeBallBuffCfg[iter_35_1].formula > 0 then
			local var_35_0 = {}

			for iter_35_2, iter_35_3 in ipairs(MergeBallBuffCfg[iter_35_1].formula) do
				table.insert(var_35_0, iter_35_3)
			end

			table.sort(var_35_0)

			self.blockedPairs_[table.concat(var_35_0, ",")] = true
		end
	end
end

function var_0_0.GetBuffWeight(arg_36_0, arg_36_1)
	if not MergeBallBuffCfg[arg_36_1] or not MergeBallBuffCfg[arg_36_1].merge_weight then
		return 0
	end

	return MergeBallBuffCfg[arg_36_1].merge_weight
end

function var_0_0:DetermineMainAndSubBuff(arg_37_1, arg_37_2)
	if self:GetBuffWeight(arg_37_1) >= self:GetBuffWeight(arg_37_2) then
		return {
			arg_37_1,
			arg_37_2
		}
	else
		return {
			arg_37_2,
			arg_37_1
		}
	end
end

function var_0_0:FindEmptySkillSlotAndAdd(arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = 0

	for iter_38_0, iter_38_1 in ipairs(arg_38_2) do
		if iter_38_1.mainBuffId == nil then
			var_38_0 = iter_38_0

			break
		end
	end

	if var_38_0 >= 0 then
		if arg_38_1 then
			arg_38_2[var_38_0] = arg_38_3.skill
		else
			arg_38_2[var_38_0] = BilliardVehicleSkillDataTemplate.New()

			arg_38_2[var_38_0]:Init({
				buffIdList = arg_38_3.buffIdList,
				level = arg_38_3.addLevel,
				index = var_38_0
			})
		end

		local var_38_1 = arg_38_2[var_38_0].mainBuffId

		self:CheckNewBuffUnlock(arg_38_2[var_38_0].mainBuffId)

		if MergeBallBuffCfg[var_38_1].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			self.passiveSelectSkillCount = self.passiveSelectSkillCount + 1
		else
			self.activeSelectSkillCount = self.activeSelectSkillCount + 1
		end

		self.allSelectedSkillDic_[var_38_1] = arg_38_2[var_38_0]

		self:AddAnimBuffIdList(true, var_38_1)

		if arg_38_2[var_38_0].isCombine_ then
			self:CheckIsSaveCombineGroup(arg_38_2[var_38_0].buffIdList)
		else
			BilliardGameLuaBridge.AddBuff(arg_38_2[var_38_0].graphId, self:GetHero())

			if self:GetTrackBuffId() == var_38_1 then
				self:SetTrackBuffId(nil)
			end
		end

		self:UpdateVehicleSkill()

		local var_38_2 = BilliardGameConst.ChangeSkillType.ADD

		if arg_38_2[var_38_0].isCombine_ then
			var_38_2 = BilliardGameConst.ChangeSkillType.COMBINE
		elseif MergeBallBuffCfg[var_38_1].type == BilliardGameConst.MergeBallBuffType.ADVANCE or MergeBallBuffCfg[var_38_1].type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
			var_38_2 = BilliardGameConst.ChangeSkillType.MERGE
		end

		self:OnSkillChange(var_38_2, BilliardGameConst.ChangeSkillOpt.SELECT, arg_38_2[var_38_0].buffIdList)
	end
end

function var_0_0:CheckIsSaveCombineGroup(arg_39_1)
	if #arg_39_1 <= 1 then
		return
	end

	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		table.insert(var_39_0, MergeBallBuffCfg[iter_39_1])
	end

	if var_39_0[1].merge_weight ~= 0 or var_39_0[2].merge_weight ~= 0 and var_39_0[1].merge_weight ~= var_39_0[2].merge_weight then
		if var_39_0[1].combine_buff_ID ~= 0 then
			local var_39_1 = var_39_0[1].combine_buff_ID or var_39_0[1].skill_id[2]

			if var_39_0[2].combine_buff_ID ~= 0 then
				local var_39_2 = var_39_0[2].combine_buff_ID or var_39_0[2].skill_id[2]

				if var_39_1 ~= var_39_2 then
					BilliardGameLuaBridge.SaveMergeGroup({
						var_39_1,
						var_39_2
					}, self:GetHero())
				end
			end
		end
	end
end

function var_0_0:CheckNewBuffUnlock(arg_40_1)
	local var_40_0 = VehicleBallData:GetUnlockBuffList()

	if var_40_0 and not var_40_0[arg_40_1] then
		VehicleBallAction.UnlockBuff({
			buffID = arg_40_1
		})
		VehicleBallData:UpdateUnlockBuffList(arg_40_1, true)
		table.insert(self.newBuffUnlockList_, arg_40_1)
	end
end

function var_0_0:OnMergeSkill(arg_41_1)
	if MergeBallBuffCfg[arg_41_1.mainBuffId] and MergeBallBuffCfg[arg_41_1.mainBuffId].type == BilliardGameConst.MergeBallBuffType.EFFECT then
		self:OnAddEffectSkill(arg_41_1.mainBuffId)

		return false
	end

	self:AddAnimBuffIdList(true, arg_41_1.mainBuffId)

	if arg_41_1.isCombine_ then
		for iter_41_0, iter_41_1 in ipairs(arg_41_1.buffIdList) do
			self:RemoveSelectedSkill(iter_41_1, true)

			if iter_41_0 ~= 1 then
				self:AddAnimBuffIdList(false, iter_41_1)
			end
		end
	else
		for iter_41_2, iter_41_3 in ipairs(MergeBallBuffCfg[arg_41_1.mainBuffId].formula) do
			self:RemoveSelectedSkill(iter_41_3)
			self:AddAnimBuffIdList(false, iter_41_3)
		end
	end

	self:FindEmptySkillSlotAndAdd(true, self.activeSelectSkillList_, {
		skill = arg_41_1
	})

	return true
end

function var_0_0:CheckForceUpgradeCount()
	local var_42_0 = MergeBallStageCfg[self:GetStageId()].designated_upgrade_count

	if #var_42_0 > 0 then
		for iter_42_0, iter_42_1 in ipairs(var_42_0) do
			if iter_42_1[1] == self.mergerSelectCount then
				return iter_42_1[2]
			end
		end
	end
end

function var_0_0:OnUpgradeRandomSkill()
	local var_43_0 = self:GetCanUpgradeSkillList()
	local var_43_1 = self:CheckForceUpgradeCount() or math.min(math.random(1, BilliardGameConst.RandomUpgradeSkillMaxCount), #var_43_0)
	local var_43_2 = {}

	if var_43_1 > 0 then
		for iter_43_0 = 1, var_43_1 do
			if #var_43_0 == 0 then
				break
			end

			local var_43_3 = math.random(1, #var_43_0)

			var_43_0[var_43_3]:AddLevel(1)
			BilliardGameLuaBridge.AddBuff(var_43_0[var_43_3].graphId, self:GetHero())
			table.remove(var_43_0, var_43_3)
			table.insert(var_43_2, var_43_0[var_43_3])
		end

		self:UpdateVehicleSkill()
		self:OnSkillChange(BilliardGameConst.ChangeSkillType.RANDOM_LEVEL_UP, BilliardGameConst.ChangeSkillOpt.SELECT, {}, var_43_2)

		return var_43_2
	end
end

function var_0_0:OnAddEffectSkill(arg_44_1)
	BilliardGameLuaBridge.AddBuff(MergeBallBuffCfg[arg_44_1] and MergeBallBuffCfg[arg_44_1].skill_id[1], self:GetHero())
	self:OnSkillChange(BilliardGameConst.ChangeSkillType.ADD, BilliardGameConst.ChangeSkillOpt.SELECT, {
		arg_44_1
	})
end

function var_0_0.UpdateVehicleSkill(arg_45_0)
	manager.notify:Invoke(BilliardGameEvent.UPDATE_VEHICLE_SKILL)
end

function var_0_0:GetActiveSelectSkillList()
	return self.activeSelectSkillList_
end

function var_0_0:GetPassiveSelectSkillList()
	return self.passiveSelectSkillList_
end

function var_0_0:GetSkillByMainBuffId(arg_48_1)
	return self.allSelectedSkillDic_[arg_48_1]
end

function var_0_0:GetAllSelectBuffList()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(self.allSelectedSkillDic_) do
		table.insert(var_49_0, iter_49_1.buffIdList)
	end

	return var_49_0
end

function var_0_0:GetIsSelectedBuff(arg_50_1)
	for iter_50_0, iter_50_1 in pairs(self.allSelectedSkillDic_) do
		if table.indexof(iter_50_1.buffIdList, arg_50_1) then
			return true
		end
	end

	return false
end

function var_0_0:GetCanUpgradeSkillList()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(self.activeSelectSkillList_) do
		if iter_51_1.mainBuffId and iter_51_1.level < BilliardGameConst.WuluoVehicleSkillMaxLevel then
			table.insert(var_51_0, iter_51_1)
		end
	end

	for iter_51_2, iter_51_3 in ipairs(self.passiveSelectSkillList_) do
		if iter_51_3.mainBuffId and iter_51_3.level < BilliardGameConst.WuluoVehicleSkillMaxLevel then
			table.insert(var_51_0, iter_51_3)
		end
	end

	return var_51_0
end

function var_0_0:GetNewBuffUnlockList()
	return self.newBuffUnlockList_
end

function var_0_0.UpdateKillMonsterCount(arg_53_0, arg_53_1)
	arg_53_0.killMonsterCount_ = arg_53_1
end

function var_0_0:GetKillMonsterCount()
	return self.killMonsterCount_
end

function var_0_0:GetMergeSkillCount()
	return self.mergerSelectCount
end

function var_0_0:CheckStageSkill()
	self.refreshCount_ = 0
	self.addActiveSkillCount_ = 0
	self.addFirstSelectLevel_ = 0

	for iter_56_0, iter_56_1 in ipairs((VehicleBallData:GetPassedStageList())) do
		if iter_56_1 == BilliardGameConst.PassStageSkill.ADDREFRESHCOUNT then
			self:SetRefreshCount(BilliardGameConst.PassStageParams.ADDREFRESHCOUNT)
		elseif iter_56_1 == BilliardGameConst.PassStageSkill.ADDACTIVESKILLCOUNT then
			self.addActiveSkillCount_ = BilliardGameConst.PassStageParams.ADDACTIVESKILLCOUNT
		elseif iter_56_1 == BilliardGameConst.PassStageSkill.FIRSTSELECTLEVELUP then
			self.addFirstSelectLevel_ = BilliardGameConst.PassStageParams.FIRSTSELECTLEVELUP
		end
	end
end

function var_0_0:GetRefreshCount()
	return self.refreshCount_
end

function var_0_0.SetRefreshCount(arg_58_0, arg_58_1)
	arg_58_0.refreshCount_ = arg_58_1
end

function var_0_0:GetAddActiveSkillCount()
	return self.addActiveSkillCount_
end

function var_0_0:GetLevelUpedSkillList()
	return self.levelUpedSkillList_
end

function var_0_0:GetTrackBuffId()
	return self.trackBuffId_
end

function var_0_0.SetTrackBuffId(arg_62_0, arg_62_1)
	arg_62_0.trackBuffId_ = arg_62_1
end

function var_0_0:AddAnimBuffIdList(arg_63_1, arg_63_2)
	if arg_63_1 then
		table.insert(self.addAnimBuffIdList_, arg_63_2)
	else
		table.insert(self.removeAnimBuffIdList_, arg_63_2)
	end
end

function var_0_0:GetAnimBuffIdList()
	return self.addAnimBuffIdList_, self.removeAnimBuffIdList_
end

function var_0_0.ClearAnimBuffIdList(arg_65_0)
	arg_65_0.addAnimBuffIdList_ = {}
	arg_65_0.removeAnimBuffIdList_ = {}
end

function var_0_0:OnSkillChange(arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_1 = {}

	for iter_66_0, iter_66_1 in ipairs(self.canSelectSkillList_) do
		if type(iter_66_1) == "table" and iter_66_1.buffIdList then
			table.insert(var_66_1, iter_66_1.buffIdList)
		elseif type(iter_66_1) == "number" then
			table.insert(var_66_1, {
				iter_66_1
			})
		end
	end

	for iter_66_2, iter_66_3 in ipairs(arg_66_4 or {}) do
		table.insert(self.levelUpedSkillList_, iter_66_3.mainBuffId)
	end

	local var_66_2 = ""

	var_66_2 = (arg_66_1 == BilliardGameConst.ChangeSkillType.RANDOM_LEVEL_UP or arg_66_1 == BilliardGameConst.ChangeSkillType.LEVEL_UP) and table.toString(self.levelUpedSkillList_) or table.toString(arg_66_3)

	SDKTools.SendMessageToSDK("activity_currency_opt", {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		stage_id = self:GetStageId(),
		start_time = self.startTime_,
		battle_times = self.curRound,
		type = arg_66_1,
		opt = arg_66_2,
		params_list = table.toString(var_66_1),
		params_select = var_66_2,
		buff_list = table.toString(self:GetAllSelectBuffList()),
		extra_data = table.toString(self.levelUpedSkillList_),
		other_data = table.toString(self.beforeSelectSkillList_)
	})
end

return var_0_0
