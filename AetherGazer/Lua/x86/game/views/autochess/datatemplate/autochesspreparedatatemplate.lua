local var_0_0 = class("AutoChessPrepareDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameType = AutoChessConst.GAME_TYPE.PVE
	arg_1_0.playerData = nil
	arg_1_0.enemyData = nil
	arg_1_0.shopListByUniqueId = {}
	arg_1_0.chessGoodDataList = {}
	arg_1_0.rewardGoodDataList = {}
	arg_1_0.propGoodDataList = {}
	arg_1_0.heroUpgradeInfo = {}
	arg_1_0.buffDataList = {}
	arg_1_0.attributeList = {}
	arg_1_0.prepareReadyNum = 0
	arg_1_0.prepareTotalNum = 0
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameType = arg_2_2 or arg_2_1.game_type
	arg_2_0.pveRestartTimes = arg_2_1.pve_restart_times

	arg_2_0:InitBuffDataList(arg_2_1.buff_list)
	arg_2_0:InitPlayerData(arg_2_1.auto_chessboard_info)
	arg_2_0:InitShopData(arg_2_1)
	arg_2_0:InitHeroUpgradeInfo(arg_2_1.hero_upgrade_info)
	arg_2_0:UpdateAttrData(arg_2_1.attr_list)
	arg_2_0:UpdatePrepareReadyData(arg_2_1.close_opt)

	arg_2_0.uuid = arg_2_1.uuid
end

function var_0_0.InitPlayerData(arg_3_0, arg_3_1)
	arg_3_0.playerData = AutoChessPlayerDataTemplate.New()

	arg_3_0.playerData:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)
	arg_3_0.playerData:Init(arg_3_1)
end

function var_0_0.InitEnemyData(arg_4_0, arg_4_1)
	arg_4_0.enemyData = AutoChessPlayerDataTemplate.New()

	arg_4_0.enemyData:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
	arg_4_0.enemyData:Init(arg_4_1)
end

function var_0_0.InitShopData(arg_5_0, arg_5_1)
	arg_5_0:UpdateShopData(arg_5_1.shop_items)
end

function var_0_0.UpdateAttrData(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if iter_6_1.key then
			arg_6_0.attributeList[iter_6_1.key] = iter_6_1.value
		end
	end
end

function var_0_0.UpdatePrepareReadyData(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.prepareReadyNum = arg_7_1.prepare_num or 0
		arg_7_0.prepareTotalNum = arg_7_1.all_num or 0
	else
		arg_7_0.prepareReadyNum = 0
		arg_7_0.prepareTotalNum = 0
	end
end

function var_0_0.UpdateShopData(arg_8_0, arg_8_1)
	arg_8_0.chessGoodDataList = {}
	arg_8_0.rewardGoodDataList = {}
	arg_8_0.propGoodDataList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1 or {}) do
		local var_8_0 = AutoChessShopItemDataTemplate.New()

		var_8_0:Init(iter_8_1)

		arg_8_0.shopListByUniqueId[var_8_0.uniqueId] = var_8_0

		if iter_8_1.shop_type == AutoChessConst.SHOP_TYPE.NORMAL then
			arg_8_0.chessGoodDataList[var_8_0.index] = var_8_0
		elseif iter_8_1.shop_type == AutoChessConst.SHOP_TYPE.REWARD then
			arg_8_0.rewardGoodDataList[var_8_0.index] = var_8_0
		elseif iter_8_1.shop_type == AutoChessConst.SHOP_TYPE.PROP then
			arg_8_0.propGoodDataList[var_8_0.index] = var_8_0
		end
	end
end

function var_0_0.UpdateShopLock(arg_9_0, arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		local var_9_0 = iter_9_1.shop_type
		local var_9_1 = iter_9_1.uid_list
		local var_9_2 = {}
		local var_9_3 = {}

		if var_9_0 == AutoChessConst.SHOP_TYPE.NORMAL then
			var_9_2 = arg_9_0.chessGoodDataList
		elseif var_9_0 == AutoChessConst.SHOP_TYPE.REWARD then
			var_9_2 = arg_9_0.rewardGoodDataList
		elseif var_9_0 == AutoChessConst.SHOP_TYPE.PROP then
			var_9_2 = arg_9_0.propGoodDataList
		end

		for iter_9_2, iter_9_3 in ipairs(var_9_1) do
			var_9_2[arg_9_0.shopListByUniqueId[iter_9_3].index].isLock = arg_9_1
		end
	end
end

function var_0_0.RemoveShopItemByUniqueId(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = arg_10_0.shopListByUniqueId[iter_10_1]

		arg_10_0.shopListByUniqueId[iter_10_1] = nil

		if var_10_0.shopType == AutoChessConst.SHOP_TYPE.NORMAL then
			arg_10_0.chessGoodDataList[var_10_0.index] = nil
		elseif var_10_0.shopType == AutoChessConst.SHOP_TYPE.REWARD then
			arg_10_0.rewardGoodDataList[var_10_0.index] = nil
		elseif var_10_0.shopType == AutoChessConst.SHOP_TYPE.PROP then
			arg_10_0.propGoodDataList[var_10_0.index] = nil
		end
	end
end

function var_0_0.UpdateChessTeamDataList(arg_11_0, arg_11_1)
	arg_11_0.playerData:UpdateChessTeamDataList(arg_11_1)
end

function var_0_0.ClearPlayerChessData(arg_12_0)
	arg_12_0.playerData:ClearPlayerChessData()
end

function var_0_0.RemoveChess(arg_13_0, arg_13_1)
	arg_13_0.playerData:RemoveChess(arg_13_1)
end

function var_0_0.InitHeroUpgradeInfo(arg_14_0, arg_14_1)
	if arg_14_1 and (arg_14_1.old_level ~= arg_14_1.new_level or arg_14_1.type == AutoChessConst.CHESS_UPGRADE_TYPE.BRAHMA) then
		arg_14_0.heroUpgradeInfo.oldLevel = arg_14_1.old_level
		arg_14_0.heroUpgradeInfo.newLevel = arg_14_1.new_level
		arg_14_0.heroUpgradeInfo.type = arg_14_1.type
		arg_14_0.heroUpgradeInfo.heroAttrs = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_1.hero_upgrade_attrs or {}) do
			arg_14_0.heroUpgradeInfo.heroAttrs[iter_14_1.index] = {
				hp = 0,
				atk = 0
			}

			for iter_14_2, iter_14_3 in ipairs(iter_14_1.attr_list) do
				if iter_14_3.key == AutoChessConst.CHESS_ATTRI_KEY.ATK then
					arg_14_0.heroUpgradeInfo.heroAttrs[iter_14_1.index].atk = iter_14_3.value
				elseif iter_14_3.key == AutoChessConst.CHESS_ATTRI_KEY.HP then
					arg_14_0.heroUpgradeInfo.heroAttrs[iter_14_1.index].hp = iter_14_3.value
				end
			end
		end

		arg_14_0.heroUpgradeInfo.heroBuffs = {}

		for iter_14_4, iter_14_5 in ipairs(arg_14_1.hero_upgrade_buffs or {}) do
			arg_14_0.heroUpgradeInfo.heroBuffs[iter_14_5.index] = iter_14_5.buff_ids[1]
		end
	end
end

function var_0_0.InitBuffDataList(arg_15_0, arg_15_1)
	arg_15_0.buffDataList = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = AutoChessBuffDataTemplate.New()

		var_15_0:Init(iter_15_1)
		table.insert(arg_15_0.buffDataList, var_15_0)
	end
end

function var_0_0.UpdatePrepareActionList(arg_16_0, arg_16_1)
	if #arg_16_1 > 0 then
		local var_16_0 = AutoChessBattleSimulator.GetInstance()

		if var_16_0:IsPlaying() then
			arg_16_0.actionGroupId = arg_16_0.actionGroupId == nil and 1 or arg_16_0.actionGroupId + 1

			var_16_0:AddPrepareActionNode(arg_16_0.actionGroupId, arg_16_1)
		else
			arg_16_0.actionGroupId = 1

			local var_16_1 = AutoChessRoundBattleDataTemplate.New()

			var_16_1:Init({
				group_id = arg_16_0.actionGroupId,
				action_list = arg_16_1
			})

			arg_16_0.roundPrepareData = var_16_1

			var_16_0:StartBattleSimulator()
		end
	end
end

function var_0_0.GetBuffDataList(arg_17_0)
	return arg_17_0.buffDataList
end

function var_0_0.AddBuffDataList(arg_18_0, arg_18_1)
	if arg_18_0.buffDataList[arg_18_1.buffId] then
		return
	end

	table.insert(arg_18_0.buffDataList, arg_18_1)
end

function var_0_0.RemoveBuffDataList(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.buffDataList) do
		if iter_19_1:GetBuffID() == arg_19_1:GetBuffID() then
			table.remove(arg_19_0.buffDataList, iter_19_0)

			return
		end
	end
end

function var_0_0.ContainBuff(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.buffDataList) do
		if iter_20_1:GetBuffID() == arg_20_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetRoundPrepareData(arg_21_0)
	return arg_21_0.roundPrepareData
end

function var_0_0.GetAttributeList(arg_22_0)
	return arg_22_0.attributeList
end

function var_0_0.GetHeroUpgradeInfo(arg_23_0)
	return arg_23_0.heroUpgradeInfo
end

function var_0_0.ResetHeroUpgradeInfo(arg_24_0)
	arg_24_0.heroUpgradeInfo = {}
end

function var_0_0.GetChessGoodDataList(arg_25_0)
	return arg_25_0.chessGoodDataList, arg_25_0.rewardGoodDataList, arg_25_0.propGoodDataList
end

function var_0_0.GetPlayerData(arg_26_0)
	return arg_26_0.playerData
end

function var_0_0.GetEnemyData(arg_27_0)
	return arg_27_0.enemyData
end

function var_0_0.GetTeamDataList(arg_28_0)
	return arg_28_0.playerData:GetTeamDataList()
end

function var_0_0.GetStageId(arg_29_0)
	return arg_29_0.playerData:GetStageId()
end

function var_0_0.GetIsBrahmaBoss(arg_30_0)
	return arg_30_0.playerData:GetIsBrahmaBoss()
end

function var_0_0.GetCurRound(arg_31_0)
	return arg_31_0.playerData:GetCurRound()
end

function var_0_0.GetPveRestartTimes(arg_32_0)
	return arg_32_0.pveRestartTimes
end

function var_0_0.GetShopChessDataByByUniqueId(arg_33_0, arg_33_1)
	return arg_33_0.shopListByUniqueId[arg_33_1]
end

function var_0_0.GetChessNum(arg_34_0)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(arg_34_0:GetTeamDataList()) do
		var_34_0 = var_34_0 + 1
	end

	return var_34_0
end

function var_0_0.GetShopAndRewardChessNum(arg_35_0)
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in pairs(arg_35_0.rewardGoodDataList) do
		var_35_0 = var_35_0 + 1
	end

	for iter_35_2, iter_35_3 in pairs(arg_35_0.chessGoodDataList) do
		var_35_0 = var_35_0 + 1
	end

	return var_35_0
end

function var_0_0.GetShopChessNum(arg_36_0)
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in pairs(arg_36_0.chessGoodDataList) do
		var_36_0 = var_36_0 + 1
	end

	return var_36_0
end

function var_0_0.GetUUID(arg_37_0)
	return arg_37_0.uuid
end

return var_0_0
