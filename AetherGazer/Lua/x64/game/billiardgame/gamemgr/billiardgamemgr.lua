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

function var_0_0.BuildContext(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0:SetGameType(BilliardGameConst.GameType.BALL)

	arg_1_0.curRound = 0
	arg_1_0.context = {
		levelID = arg_1_1,
		stageId = arg_1_2,
		hero = {
			arg_1_3,
			arg_1_4,
			arg_1_5
		}
	}
end

function var_0_0.BuildVehicleContext(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:SetGameType(BilliardGameConst.GameType.VEHICLE)

	arg_2_0.vehicleContext = {
		stageId = arg_2_1,
		hero = arg_2_2
	}
	arg_2_0.startTime_ = manager.time:GetServerTime()

	arg_2_0:CheckStageSkill()
	arg_2_0:ResetVehicleParams()
	arg_2_0:CreateMergeBuffKV()
end

function var_0_0.ResetVehicleParams(arg_3_0)
	arg_3_0.newBuffUnlockList_ = {}
	arg_3_0.killMonsterCount_ = 0
	arg_3_0.buffSelectList_ = {}
	arg_3_0.effectBuffList_ = {}
	arg_3_0.mergedBuffList_ = {}

	for iter_3_0, iter_3_1 in ipairs(MergeBallBuffCfg.all) do
		local var_3_0 = MergeBallBuffCfg[iter_3_1]

		if var_3_0.type == BilliardGameConst.MergeBallBuffType.PASSIVE or var_3_0.type == BilliardGameConst.MergeBallBuffType.BASIC then
			table.insert(arg_3_0.buffSelectList_, iter_3_1)
		end

		if var_3_0.type == BilliardGameConst.MergeBallBuffType.EFFECT and not table.indexof(BilliardGameConst.FixedBuffIdList, iter_3_1) then
			table.insert(arg_3_0.effectBuffList_, iter_3_1)
		end

		if var_3_0.formula and #var_3_0.formula > 0 then
			if var_3_0.type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
				if BilliardGameTools.GetIsUltimateSkillUnlocked() then
					table.insert(arg_3_0.mergedBuffList_, iter_3_1)
				end
			else
				table.insert(arg_3_0.mergedBuffList_, iter_3_1)
			end
		end
	end

	arg_3_0.allSelectedSkillDic_ = {}
	arg_3_0.activeSelectSkillList_ = {}

	for iter_3_2 = 1, BilliardGameConst.ActiveSkillCount + arg_3_0.addActiveSkillCount_ do
		arg_3_0.activeSelectSkillList_[iter_3_2] = {}
	end

	arg_3_0.passiveSelectSkillList_ = {}

	for iter_3_3 = 1, BilliardGameConst.PassiveSkillCount do
		arg_3_0.passiveSelectSkillList_[iter_3_3] = {}
	end

	arg_3_0.activeSelectSkillCount = 0
	arg_3_0.passiveSelectSkillCount = 0
	arg_3_0.curRound = 0
	arg_3_0.randomSelectCount = 0
	arg_3_0.mergerSelectCount = 0
	arg_3_0.canSelectSkillList_ = {}
	arg_3_0.beforeSelectSkillList_ = {}
	arg_3_0.levelUpedSkillList_ = {}
	arg_3_0.trackBuffId_ = nil
	arg_3_0.addAnimBuffIdList_ = {}
	arg_3_0.removeAnimBuffIdList_ = {}
	arg_3_0.roundBuffIdList_ = {}
end

function var_0_0.TestAddActiveSkill(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:AddSelectedSkill(arg_4_1, arg_4_2)
end

function var_0_0.TestAddMergeProcess(arg_5_0, arg_5_1)
	manager.notify:Invoke(BilliardGameEvent.TEST, arg_5_1)
end

function var_0_0.Restart(arg_6_0)
	if arg_6_0.gameType == BilliardGameConst.GameType.BALL then
		LaunchBilliardGame(arg_6_0.context.levelID, arg_6_0.context.stageId, arg_6_0.context.hero)
	else
		LaunchBilliardGame_5_1(arg_6_0.vehicleContext.stageId, arg_6_0.vehicleContext.hero)
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

function var_0_0.GetGameType(arg_10_0)
	return arg_10_0.gameType
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

function var_0_0.GetStageId(arg_14_0)
	if arg_14_0.gameType == BilliardGameConst.GameType.BALL then
		return arg_14_0.context.stageId
	else
		return arg_14_0.vehicleContext.stageId
	end
end

function var_0_0.GetLevelId(arg_15_0)
	if arg_15_0.gameType == BilliardGameConst.GameType.BALL then
		return arg_15_0.context.levelID
	else
		return nil
	end
end

function var_0_0.GetHero(arg_16_0)
	if arg_16_0.gameType == BilliardGameConst.GameType.BALL then
		return arg_16_0.context.hero
	else
		return arg_16_0.vehicleContext.hero
	end
end

function var_0_0.OnRoundBegin(arg_17_0)
	arg_17_0.curRound = arg_17_0.curRound + 1

	arg_17_0:ClearAnimBuffIdList()

	arg_17_0.roundBuffIdList_ = {}
end

function var_0_0.GetCurRound(arg_18_0)
	return arg_18_0.curRound
end

function var_0_0.OnGameSceneLoaded(arg_19_0)
	arg_19_0:UpdateLogicData()
end

function var_0_0.ExitGame(arg_20_0)
	var_0_2 = nil
	var_0_1 = false
end

function var_0_0.OverGame(arg_21_0)
	var_0_1 = false
end

function var_0_0.GetRoundSelectBuffList(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0:GetRandomSelectBuffId()

	arg_22_0.canSelectSkillList_ = {
		var_22_0,
		var_22_1
	}
	arg_22_0.beforeSelectSkillList_ = arg_22_0:GetAllSelectBuffList()

	for iter_22_0 = 1, 2 do
		table.insert(arg_22_0.roundBuffIdList_, arg_22_0.canSelectSkillList_[iter_22_0])
	end

	return arg_22_0.canSelectSkillList_
end

function var_0_0.CheckStageForceSelectBuff(arg_23_0)
	local var_23_0 = arg_23_0:GetStageId()
	local var_23_1 = MergeBallStageCfg[var_23_0].designated_buff

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if iter_23_1[1] == arg_23_0.randomSelectCount then
			return true, iter_23_1[2], iter_23_1[3]
		end
	end

	return false
end

function var_0_0.GetRandomSelectBuffId(arg_24_0)
	arg_24_0.randomSelectCount = arg_24_0.randomSelectCount + 1

	local var_24_0, var_24_1, var_24_2 = arg_24_0:CheckStageForceSelectBuff()

	if var_24_0 then
		return var_24_1, var_24_2
	end

	if #arg_24_0.buffSelectList_ < 2 then
		if #arg_24_0.buffSelectList_ == 1 then
			return arg_24_0.buffSelectList_[1], arg_24_0:GetRandomEffectBuffId(1)
		else
			return arg_24_0:GetRandomEffectBuffId(2)
		end
	end

	local var_24_3 = arg_24_0:GetCanUpgradeSkillList()
	local var_24_4 = #arg_24_0.passiveSelectSkillList_ - arg_24_0.passiveSelectSkillCount
	local var_24_5 = #arg_24_0.activeSelectSkillList_ - arg_24_0.activeSelectSkillCount

	if var_24_4 + var_24_5 <= 0 then
		if #var_24_3 <= 0 then
			return arg_24_0:GetRandomEffectBuffId(2)
		elseif #var_24_3 == 1 then
			return var_24_3[1].mainBuffId, arg_24_0:GetRandomEffectBuffId(1)
		else
			local var_24_6 = {}

			for iter_24_0, iter_24_1 in ipairs(var_24_3) do
				table.insert(var_24_6, iter_24_1.mainBuffId)
			end

			return arg_24_0:GetTwoRandomBuff(var_24_6)
		end
	else
		local var_24_7 = arg_24_0:GetCanSelectBuffList(var_24_5, var_24_4)

		if math.random(1, 100) <= GameSetting.mergeball_upgrade_up_rate.value[1] and #var_24_3 > 0 then
			local var_24_8 = var_24_3[math.random(1, #var_24_3)].mainBuffId
			local var_24_9 = table.indexof(var_24_7, var_24_8)

			if var_24_9 then
				table.remove(var_24_7, var_24_9)
			end

			if #var_24_7 > 0 then
				local var_24_10 = math.random(1, #var_24_7)

				return var_24_8, var_24_7[var_24_10]
			else
				return var_24_8, arg_24_0:GetRandomEffectBuffId(1)
			end
		else
			return arg_24_0:GetTwoRandomBuff(var_24_7)
		end
	end
end

function var_0_0.GetCanSelectBuffList(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = clone(arg_25_0.buffSelectList_)
	local var_25_1 = {}

	for iter_25_0 = 1, #var_25_0 do
		local var_25_2 = arg_25_0.allSelectedSkillDic_[var_25_0[iter_25_0]]
		local var_25_3 = MergeBallBuffCfg[var_25_0[iter_25_0]]

		if var_25_2 and var_25_2.level >= BilliardGameConst.WuluoVehicleSkillMaxLevel or arg_25_1 <= 0 and var_25_3.type == BilliardGameConst.MergeBallBuffType.BASIC or arg_25_2 <= 0 and var_25_3.type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			table.insert(var_25_1, iter_25_0)
		end
	end

	for iter_25_1 = #var_25_1, 1, -1 do
		table.remove(var_25_0, var_25_1[iter_25_1])
	end

	return (arg_25_0:RemoveRoundShownBuff(var_25_0, 2))
end

function var_0_0.GetRandomEffectBuffId(arg_26_0, arg_26_1)
	local var_26_0 = clone(arg_26_0.effectBuffList_)
	local var_26_1 = arg_26_0:RemoveRoundShownBuff(var_26_0, arg_26_1)

	if arg_26_1 == 1 then
		return var_26_1[math.random(1, #var_26_1)]
	elseif arg_26_1 == 2 then
		return arg_26_0:GetTwoRandomBuff(var_26_1)
	end
end

function var_0_0.RemoveRoundShownBuff(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2 = arg_27_2 or 0

	local var_27_0 = clone(arg_27_1)

	for iter_27_0 = #var_27_0, 1, -1 do
		if arg_27_2 >= #var_27_0 then
			break
		end

		if table.indexof(arg_27_0.roundBuffIdList_, var_27_0[iter_27_0]) then
			table.remove(var_27_0, iter_27_0)
		end
	end

	return var_27_0
end

function var_0_0.GetTwoRandomBuff(arg_28_0, arg_28_1)
	local var_28_0 = math.random(1, #arg_28_1)
	local var_28_1 = arg_28_1[var_28_0]

	table.remove(arg_28_1, var_28_0)

	local var_28_2 = arg_28_1[math.random(1, #arg_28_1)]

	return var_28_1, var_28_2
end

function var_0_0.AddSelectedSkill(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1
	local var_29_1 = arg_29_2 or 1

	if arg_29_0.addFirstSelectLevel_ ~= 0 then
		var_29_1 = var_29_1 + arg_29_0.addFirstSelectLevel_

		table.insert(arg_29_0.levelUpedSkillList_, arg_29_1)

		arg_29_0.addFirstSelectLevel_ = 0
	end

	local var_29_2 = MergeBallBuffCfg[var_29_0]

	if not var_29_2 then
		print("Invalid mainBuffId: " .. tostring(var_29_0))

		return
	end

	if var_29_2.type == BilliardGameConst.MergeBallBuffType.EFFECT then
		arg_29_0:OnAddEffectSkill(var_29_0)
		manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)

		return
	end

	local var_29_3 = var_29_2.type == BilliardGameConst.MergeBallBuffType.PASSIVE and arg_29_0.passiveSelectSkillList_ or arg_29_0.activeSelectSkillList_

	for iter_29_0, iter_29_1 in ipairs(var_29_3) do
		if iter_29_1 and iter_29_1.mainBuffId == var_29_0 then
			iter_29_1:AddLevel(1)
			manager.notify:Invoke(BilliardGameEvent.SINGLE_SKILL_UPGRADE, iter_29_1)
			BilliardGameLuaBridge.AddBuff(iter_29_1.graphId, arg_29_0:GetHero())
			arg_29_0:UpdateVehicleSkill()
			arg_29_0:OnSkillChange(BilliardGameConst.ChangeSkillType.LEVEL_UP, BilliardGameConst.ChangeSkillOpt.SELECT, iter_29_1.buffIdList, {
				iter_29_1
			})
			manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)

			return
		end
	end

	arg_29_0:FindEmptySkillSlotAndAdd(false, var_29_3, {
		buffIdList = {
			arg_29_1
		},
		addLevel = var_29_1
	})
	manager.notify:Invoke(BilliardGameEvent.MAIN_POP_END)
end

function var_0_0.RemoveSelectedSkill(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = MergeBallBuffCfg[arg_30_1]

	if not var_30_0 then
		print("Trying to remove invalid buffId: " .. tostring(arg_30_1))

		return
	end

	local var_30_1 = var_30_0.type == BilliardGameConst.MergeBallBuffType.PASSIVE
	local var_30_2 = var_30_1 and arg_30_0.passiveSelectSkillList_ or arg_30_0.activeSelectSkillList_

	for iter_30_0, iter_30_1 in ipairs(var_30_2) do
		if iter_30_1 and iter_30_1.mainBuffId == arg_30_1 then
			var_30_2[iter_30_0] = {}

			if var_30_1 then
				arg_30_0.passiveSelectSkillCount = arg_30_0.passiveSelectSkillCount - 1
			else
				arg_30_0.activeSelectSkillCount = arg_30_0.activeSelectSkillCount - 1
			end

			arg_30_0.allSelectedSkillDic_[arg_30_1] = nil

			if not arg_30_2 then
				BilliardGameLuaBridge.RemoveBuff(iter_30_1.graphId, arg_30_0:GetHero())

				local var_30_3 = table.indexof(arg_30_0.levelUpedSkillList_, iter_30_1.mainBuffId)

				if var_30_3 then
					table.remove(arg_30_0.levelUpedSkillList_, var_30_3)
				end
			end

			arg_30_0:UpdateVehicleSkill()

			break
		end
	end
end

function var_0_0.FindAvailableMergeSkills(arg_31_0)
	arg_31_0.mergerSelectCount = arg_31_0.mergerSelectCount + 1
	arg_31_0.beforeSelectSkillList_ = arg_31_0:GetAllSelectBuffList()

	local var_31_0 = {}
	local var_31_1 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0.mergedBuffList_) do
		local var_31_2 = MergeBallBuffCfg[iter_31_1]
		local var_31_3 = true

		for iter_31_2, iter_31_3 in ipairs(var_31_2.formula) do
			if arg_31_0.allSelectedSkillDic_[iter_31_3] == nil or arg_31_0.allSelectedSkillDic_[iter_31_3].isCombine_ or arg_31_0.allSelectedSkillDic_[iter_31_3].level < BilliardGameConst.WuluoVehicleSkillMaxLevel then
				var_31_3 = false

				break
			end
		end

		if var_31_3 then
			local var_31_4 = false

			for iter_31_4, iter_31_5 in ipairs(arg_31_0.activeSelectSkillList_) do
				if iter_31_5 and iter_31_5.mainBuffId == iter_31_1 then
					var_31_4 = true

					break
				end
			end

			if not var_31_4 then
				local var_31_5 = BilliardVehicleSkillDataTemplate.New()

				var_31_5:Init({
					level = 1,
					buffIdList = {
						iter_31_1
					}
				})
				table.insert(var_31_0, var_31_5)
				table.insert(var_31_1, iter_31_1)
			end
		end
	end

	local var_31_6 = arg_31_0:GetCombinableSkills(var_31_1)

	for iter_31_6, iter_31_7 in ipairs(var_31_6) do
		table.insert(var_31_0, iter_31_7)
	end

	table.sort(var_31_0, function(arg_32_0, arg_32_1)
		local var_32_0 = MergeBallBuffCfg[arg_32_0.mainBuffId]
		local var_32_1 = MergeBallBuffCfg[arg_32_1.mainBuffId]

		return var_32_0.type > var_32_1.type
	end)

	if #arg_31_0:GetCanUpgradeSkillList() > 0 then
		table.insert(var_31_0, {})
	end

	local var_31_7, var_31_8 = arg_31_0:GetMergeEffectBuff()

	table.insert(var_31_0, var_31_7)
	table.insert(var_31_0, var_31_8)

	arg_31_0.canSelectSkillList_ = var_31_0

	return var_31_0
end

function var_0_0.GetMergeEffectBuff(arg_33_0)
	local var_33_0 = BilliardGameConst.FixedBuffIdList or {}
	local var_33_1 = var_33_0[math.random(1, #var_33_0)]
	local var_33_2 = arg_33_0.effectBuffList_[math.random(1, #arg_33_0.effectBuffList_)]
	local var_33_3 = BilliardVehicleSkillDataTemplate.New()

	var_33_3:Init({
		level = 1,
		buffIdList = {
			var_33_1
		}
	})

	local var_33_4 = BilliardVehicleSkillDataTemplate.New()

	var_33_4:Init({
		level = 1,
		buffIdList = {
			var_33_2
		}
	})

	return var_33_3, var_33_4
end

function var_0_0.GetCombinableSkills(arg_34_0, arg_34_1)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(arg_34_0.activeSelectSkillList_) do
		if iter_34_1.mainBuffId and not iter_34_1.isCombine_ and iter_34_1.level >= BilliardGameConst.WuluoVehicleSkillMaxLevel then
			table.insert(var_34_1, iter_34_1.mainBuffId)
		end
	end

	for iter_34_2 = 1, #var_34_1 do
		for iter_34_3 = iter_34_2 + 1, #var_34_1 do
			local var_34_2 = var_34_1[iter_34_2]
			local var_34_3 = var_34_1[iter_34_3]
			local var_34_4 = {
				var_34_2,
				var_34_3
			}

			table.sort(var_34_4)

			local var_34_5 = table.concat(var_34_4, ",")

			if not arg_34_0.blockedPairs_[var_34_5] and (MergeBallBuffCfg[var_34_2].type == BilliardGameConst.MergeBallBuffType.BASIC or MergeBallBuffCfg[var_34_3].type == BilliardGameConst.MergeBallBuffType.BASIC) then
				local var_34_6 = arg_34_0:DetermineMainAndSubBuff(var_34_2, var_34_3)
				local var_34_7 = BilliardVehicleSkillDataTemplate.New()

				var_34_7:Init({
					level = 2,
					buffIdList = var_34_6
				})
				table.insert(var_34_0, var_34_7)
			end
		end
	end

	return var_34_0
end

function var_0_0.CreateMergeBuffKV(arg_35_0)
	arg_35_0.blockedPairs_ = {}

	for iter_35_0, iter_35_1 in ipairs(MergeBallBuffCfg.all) do
		local var_35_0 = MergeBallBuffCfg[iter_35_1]

		if var_35_0.formula and #var_35_0.formula > 0 then
			local var_35_1 = {}

			for iter_35_2, iter_35_3 in ipairs(var_35_0.formula) do
				table.insert(var_35_1, iter_35_3)
			end

			table.sort(var_35_1)

			local var_35_2 = table.concat(var_35_1, ",")

			arg_35_0.blockedPairs_[var_35_2] = true
		end
	end
end

function var_0_0.GetBuffWeight(arg_36_0, arg_36_1)
	local var_36_0 = MergeBallBuffCfg[arg_36_1]

	if not var_36_0 or not var_36_0.merge_weight then
		return 0
	end

	return var_36_0.merge_weight
end

function var_0_0.DetermineMainAndSubBuff(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_0:GetBuffWeight(arg_37_1) >= arg_37_0:GetBuffWeight(arg_37_2) then
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

function var_0_0.FindEmptySkillSlotAndAdd(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
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

		arg_38_0:CheckNewBuffUnlock(var_38_1)

		if MergeBallBuffCfg[var_38_1].type == BilliardGameConst.MergeBallBuffType.PASSIVE then
			arg_38_0.passiveSelectSkillCount = arg_38_0.passiveSelectSkillCount + 1
		else
			arg_38_0.activeSelectSkillCount = arg_38_0.activeSelectSkillCount + 1
		end

		arg_38_0.allSelectedSkillDic_[var_38_1] = arg_38_2[var_38_0]

		arg_38_0:AddAnimBuffIdList(true, var_38_1)

		if arg_38_2[var_38_0].isCombine_ then
			arg_38_0:CheckIsSaveCombineGroup(arg_38_2[var_38_0].buffIdList)
		else
			BilliardGameLuaBridge.AddBuff(arg_38_2[var_38_0].graphId, arg_38_0:GetHero())

			if arg_38_0:GetTrackBuffId() == var_38_1 then
				arg_38_0:SetTrackBuffId(nil)
			end
		end

		arg_38_0:UpdateVehicleSkill()

		local var_38_2 = BilliardGameConst.ChangeSkillType.ADD

		if arg_38_2[var_38_0].isCombine_ then
			var_38_2 = BilliardGameConst.ChangeSkillType.COMBINE
		elseif MergeBallBuffCfg[var_38_1].type == BilliardGameConst.MergeBallBuffType.ADVANCE or MergeBallBuffCfg[var_38_1].type == BilliardGameConst.MergeBallBuffType.ULTIMATE then
			var_38_2 = BilliardGameConst.ChangeSkillType.MERGE
		end

		arg_38_0:OnSkillChange(var_38_2, BilliardGameConst.ChangeSkillOpt.SELECT, arg_38_2[var_38_0].buffIdList)
	end
end

function var_0_0.CheckIsSaveCombineGroup(arg_39_0, arg_39_1)
	if #arg_39_1 <= 1 then
		return
	end

	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
		table.insert(var_39_0, MergeBallBuffCfg[iter_39_1])
	end

	if var_39_0[1].merge_weight ~= 0 or var_39_0[2].merge_weight ~= 0 and var_39_0[1].merge_weight ~= var_39_0[2].merge_weight then
		local var_39_1 = var_39_0[1].combine_buff_ID ~= 0 and var_39_0[1].combine_buff_ID or var_39_0[1].skill_id[2]
		local var_39_2 = var_39_0[2].combine_buff_ID ~= 0 and var_39_0[2].combine_buff_ID or var_39_0[2].skill_id[2]

		if var_39_1 ~= var_39_2 then
			BilliardGameLuaBridge.SaveMergeGroup({
				var_39_1,
				var_39_2
			}, arg_39_0:GetHero())
		end
	end
end

function var_0_0.CheckNewBuffUnlock(arg_40_0, arg_40_1)
	local var_40_0 = VehicleBallData:GetUnlockBuffList()

	if var_40_0 and not var_40_0[arg_40_1] then
		VehicleBallAction.UnlockBuff({
			buffID = arg_40_1
		})
		VehicleBallData:UpdateUnlockBuffList(arg_40_1, true)
		table.insert(arg_40_0.newBuffUnlockList_, arg_40_1)
	end
end

function var_0_0.OnMergeSkill(arg_41_0, arg_41_1)
	local var_41_0 = MergeBallBuffCfg[arg_41_1.mainBuffId]

	if var_41_0 and var_41_0.type == BilliardGameConst.MergeBallBuffType.EFFECT then
		arg_41_0:OnAddEffectSkill(arg_41_1.mainBuffId)

		return false
	end

	arg_41_0:AddAnimBuffIdList(true, arg_41_1.mainBuffId)

	if arg_41_1.isCombine_ then
		for iter_41_0, iter_41_1 in ipairs(arg_41_1.buffIdList) do
			arg_41_0:RemoveSelectedSkill(iter_41_1, true)

			if iter_41_0 ~= 1 then
				arg_41_0:AddAnimBuffIdList(false, iter_41_1)
			end
		end
	else
		local var_41_1 = MergeBallBuffCfg[arg_41_1.mainBuffId].formula

		for iter_41_2, iter_41_3 in ipairs(var_41_1) do
			arg_41_0:RemoveSelectedSkill(iter_41_3)
			arg_41_0:AddAnimBuffIdList(false, iter_41_3)
		end
	end

	arg_41_0:FindEmptySkillSlotAndAdd(true, arg_41_0.activeSelectSkillList_, {
		skill = arg_41_1
	})

	return true
end

function var_0_0.CheckForceUpgradeCount(arg_42_0)
	local var_42_0 = arg_42_0:GetStageId()
	local var_42_1 = MergeBallStageCfg[var_42_0].designated_upgrade_count

	if #var_42_1 > 0 then
		for iter_42_0, iter_42_1 in ipairs(var_42_1) do
			if iter_42_1[1] == arg_42_0.mergerSelectCount then
				return iter_42_1[2]
			end
		end
	end
end

function var_0_0.OnUpgradeRandomSkill(arg_43_0)
	local var_43_0 = arg_43_0:CheckForceUpgradeCount()
	local var_43_1 = arg_43_0:GetCanUpgradeSkillList()
	local var_43_2 = math.random(1, BilliardGameConst.RandomUpgradeSkillMaxCount)
	local var_43_3 = var_43_0 or math.min(var_43_2, #var_43_1)
	local var_43_4 = {}

	if var_43_3 > 0 then
		for iter_43_0 = 1, var_43_3 do
			if #var_43_1 == 0 then
				break
			end

			local var_43_5 = math.random(1, #var_43_1)
			local var_43_6 = var_43_1[var_43_5]

			var_43_6:AddLevel(1)
			BilliardGameLuaBridge.AddBuff(var_43_6.graphId, arg_43_0:GetHero())
			table.remove(var_43_1, var_43_5)
			table.insert(var_43_4, var_43_6)
		end

		arg_43_0:UpdateVehicleSkill()
		arg_43_0:OnSkillChange(BilliardGameConst.ChangeSkillType.RANDOM_LEVEL_UP, BilliardGameConst.ChangeSkillOpt.SELECT, {}, var_43_4)

		return var_43_4
	end
end

function var_0_0.OnAddEffectSkill(arg_44_0, arg_44_1)
	local var_44_0 = MergeBallBuffCfg[arg_44_1]
	local var_44_1 = var_44_0 and var_44_0.skill_id[1]

	BilliardGameLuaBridge.AddBuff(var_44_1, arg_44_0:GetHero())
	arg_44_0:OnSkillChange(BilliardGameConst.ChangeSkillType.ADD, BilliardGameConst.ChangeSkillOpt.SELECT, {
		arg_44_1
	})
end

function var_0_0.UpdateVehicleSkill(arg_45_0)
	manager.notify:Invoke(BilliardGameEvent.UPDATE_VEHICLE_SKILL)
end

function var_0_0.GetActiveSelectSkillList(arg_46_0)
	return arg_46_0.activeSelectSkillList_
end

function var_0_0.GetPassiveSelectSkillList(arg_47_0)
	return arg_47_0.passiveSelectSkillList_
end

function var_0_0.GetSkillByMainBuffId(arg_48_0, arg_48_1)
	return arg_48_0.allSelectedSkillDic_[arg_48_1]
end

function var_0_0.GetAllSelectBuffList(arg_49_0)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(arg_49_0.allSelectedSkillDic_) do
		table.insert(var_49_0, iter_49_1.buffIdList)
	end

	return var_49_0
end

function var_0_0.GetIsSelectedBuff(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_0.allSelectedSkillDic_) do
		if table.indexof(iter_50_1.buffIdList, arg_50_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetCanUpgradeSkillList(arg_51_0)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs(arg_51_0.activeSelectSkillList_) do
		if iter_51_1.mainBuffId and iter_51_1.level < BilliardGameConst.WuluoVehicleSkillMaxLevel then
			table.insert(var_51_0, iter_51_1)
		end
	end

	for iter_51_2, iter_51_3 in ipairs(arg_51_0.passiveSelectSkillList_) do
		if iter_51_3.mainBuffId and iter_51_3.level < BilliardGameConst.WuluoVehicleSkillMaxLevel then
			table.insert(var_51_0, iter_51_3)
		end
	end

	return var_51_0
end

function var_0_0.GetNewBuffUnlockList(arg_52_0)
	return arg_52_0.newBuffUnlockList_
end

function var_0_0.UpdateKillMonsterCount(arg_53_0, arg_53_1)
	arg_53_0.killMonsterCount_ = arg_53_1
end

function var_0_0.GetKillMonsterCount(arg_54_0)
	return arg_54_0.killMonsterCount_
end

function var_0_0.GetMergeSkillCount(arg_55_0)
	return arg_55_0.mergerSelectCount
end

function var_0_0.CheckStageSkill(arg_56_0)
	local var_56_0 = VehicleBallData:GetPassedStageList()

	arg_56_0.refreshCount_ = 0
	arg_56_0.addActiveSkillCount_ = 0
	arg_56_0.addFirstSelectLevel_ = 0

	for iter_56_0, iter_56_1 in ipairs(var_56_0) do
		if iter_56_1 == BilliardGameConst.PassStageSkill.ADDREFRESHCOUNT then
			arg_56_0:SetRefreshCount(BilliardGameConst.PassStageParams.ADDREFRESHCOUNT)
		elseif iter_56_1 == BilliardGameConst.PassStageSkill.ADDACTIVESKILLCOUNT then
			arg_56_0.addActiveSkillCount_ = BilliardGameConst.PassStageParams.ADDACTIVESKILLCOUNT
		elseif iter_56_1 == BilliardGameConst.PassStageSkill.FIRSTSELECTLEVELUP then
			arg_56_0.addFirstSelectLevel_ = BilliardGameConst.PassStageParams.FIRSTSELECTLEVELUP
		end
	end
end

function var_0_0.GetRefreshCount(arg_57_0)
	return arg_57_0.refreshCount_
end

function var_0_0.SetRefreshCount(arg_58_0, arg_58_1)
	arg_58_0.refreshCount_ = arg_58_1
end

function var_0_0.GetAddActiveSkillCount(arg_59_0)
	return arg_59_0.addActiveSkillCount_
end

function var_0_0.GetLevelUpedSkillList(arg_60_0)
	return arg_60_0.levelUpedSkillList_
end

function var_0_0.GetTrackBuffId(arg_61_0)
	return arg_61_0.trackBuffId_
end

function var_0_0.SetTrackBuffId(arg_62_0, arg_62_1)
	arg_62_0.trackBuffId_ = arg_62_1
end

function var_0_0.AddAnimBuffIdList(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_1 then
		table.insert(arg_63_0.addAnimBuffIdList_, arg_63_2)
	else
		table.insert(arg_63_0.removeAnimBuffIdList_, arg_63_2)
	end
end

function var_0_0.GetAnimBuffIdList(arg_64_0)
	return arg_64_0.addAnimBuffIdList_, arg_64_0.removeAnimBuffIdList_
end

function var_0_0.ClearAnimBuffIdList(arg_65_0)
	arg_65_0.addAnimBuffIdList_ = {}
	arg_65_0.removeAnimBuffIdList_ = {}
end

function var_0_0.OnSkillChange(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0 = {}
	local var_66_1 = {}

	for iter_66_0, iter_66_1 in ipairs(arg_66_0.canSelectSkillList_) do
		if type(iter_66_1) == "table" and iter_66_1.buffIdList then
			table.insert(var_66_1, iter_66_1.buffIdList)
		elseif type(iter_66_1) == "number" then
			table.insert(var_66_1, {
				iter_66_1
			})
		end
	end

	for iter_66_2, iter_66_3 in ipairs(arg_66_4 or {}) do
		table.insert(arg_66_0.levelUpedSkillList_, iter_66_3.mainBuffId)
	end

	local var_66_2 = ""

	if arg_66_1 == BilliardGameConst.ChangeSkillType.RANDOM_LEVEL_UP or arg_66_1 == BilliardGameConst.ChangeSkillType.LEVEL_UP then
		var_66_2 = table.toString(arg_66_0.levelUpedSkillList_)
	else
		var_66_2 = table.toString(arg_66_3)
	end

	local var_66_3 = {
		activity_id = ActivityConst.ACTIVITY_WULO_VEHICLE_BALL_MAIN,
		stage_id = arg_66_0:GetStageId(),
		start_time = arg_66_0.startTime_,
		battle_times = arg_66_0.curRound,
		type = arg_66_1,
		opt = arg_66_2,
		params_list = table.toString(var_66_1),
		params_select = var_66_2,
		buff_list = table.toString(arg_66_0:GetAllSelectBuffList()),
		extra_data = table.toString(arg_66_0.levelUpedSkillList_),
		other_data = table.toString(arg_66_0.beforeSelectSkillList_)
	}

	SDKTools.SendMessageToSDK("activity_currency_opt", var_66_3)
end

return var_0_0
