local AutoChessPrepareDataTemplate = class("AutoChessPrepareDataTemplate")

function AutoChessPrepareDataTemplate:Ctor()
	self.gameType = AutoChessConst.GAME_TYPE.PVE
	self.playerData = nil
	self.enemyData = nil
	self.shopListByUniqueId = {}
	self.chessGoodDataList = {}
	self.rewardGoodDataList = {}
	self.propGoodDataList = {}
	self.heroUpgradeInfo = {}
	self.buffDataList = {}
	self.attributeList = {}
	self.prepareReadyNum = 0
	self.prepareTotalNum = 0
end

function AutoChessPrepareDataTemplate:Init(arg_2_1, arg_2_2)
	self.gameType = arg_2_2 or arg_2_1.game_type
	self.pveRestartTimes = arg_2_1.pve_restart_times

	self:InitBuffDataList(arg_2_1.buff_list)
	self:InitPlayerData(arg_2_1.auto_chessboard_info)
	self:InitShopData(arg_2_1)
	self:InitHeroUpgradeInfo(arg_2_1.hero_upgrade_info)
	self:UpdateAttrData(arg_2_1.attr_list)
	self:UpdatePrepareReadyData(arg_2_1.close_opt)

	self.uuid = arg_2_1.uuid
end

function AutoChessPrepareDataTemplate:InitPlayerData(arg_3_1)
	self.playerData = AutoChessPlayerDataTemplate.New()

	self.playerData:SetPlayerType(AutoChessConst.PLAYER_TYPE.SELF)
	self.playerData:Init(arg_3_1)
end

function AutoChessPrepareDataTemplate:InitEnemyData(arg_4_1)
	self.enemyData = AutoChessPlayerDataTemplate.New()

	self.enemyData:SetPlayerType(AutoChessConst.PLAYER_TYPE.OPPONENT)
	self.enemyData:Init(arg_4_1)
end

function AutoChessPrepareDataTemplate:InitShopData(arg_5_1)
	self:UpdateShopData(arg_5_1.shop_items)
end

function AutoChessPrepareDataTemplate:UpdateAttrData(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if iter_6_1.key then
			self.attributeList[iter_6_1.key] = iter_6_1.value
		end
	end
end

function AutoChessPrepareDataTemplate:UpdatePrepareReadyData(arg_7_1)
	if arg_7_1 then
		self.prepareReadyNum = arg_7_1.prepare_num or 0
		self.prepareTotalNum = arg_7_1.all_num or 0
	else
		self.prepareReadyNum = 0
		self.prepareTotalNum = 0
	end
end

function AutoChessPrepareDataTemplate:UpdateShopData(arg_8_1)
	self.chessGoodDataList = {}
	self.rewardGoodDataList = {}
	self.propGoodDataList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1 or {}) do
		local var_8_0 = AutoChessShopItemDataTemplate.New()

		var_8_0:Init(iter_8_1)

		self.shopListByUniqueId[var_8_0.uniqueId] = var_8_0

		if iter_8_1.shop_type == AutoChessConst.SHOP_TYPE.NORMAL then
			self.chessGoodDataList[var_8_0.index] = var_8_0
		elseif iter_8_1.shop_type == AutoChessConst.SHOP_TYPE.REWARD then
			self.rewardGoodDataList[var_8_0.index] = var_8_0
		elseif iter_8_1.shop_type == AutoChessConst.SHOP_TYPE.PROP then
			self.propGoodDataList[var_8_0.index] = var_8_0
		end
	end
end

function AutoChessPrepareDataTemplate:UpdateShopLock(arg_9_1, arg_9_2)
	for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
		local var_9_0 = {}

		if iter_9_1.shop_type == AutoChessConst.SHOP_TYPE.NORMAL then
			var_9_0 = self.chessGoodDataList
		elseif iter_9_1.shop_type == AutoChessConst.SHOP_TYPE.REWARD then
			var_9_0 = self.rewardGoodDataList
		elseif iter_9_1.shop_type == AutoChessConst.SHOP_TYPE.PROP then
			var_9_0 = self.propGoodDataList
		end

		for iter_9_2, iter_9_3 in ipairs(iter_9_1.uid_list) do
			var_9_0[self.shopListByUniqueId[iter_9_3].index].isLock = arg_9_1
		end
	end
end

function AutoChessPrepareDataTemplate:RemoveShopItemByUniqueId(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		self.shopListByUniqueId[iter_10_1] = nil

		if self.shopListByUniqueId[iter_10_1].shopType == AutoChessConst.SHOP_TYPE.NORMAL then
			self.chessGoodDataList[self.shopListByUniqueId[iter_10_1].index] = nil
		elseif self.shopListByUniqueId[iter_10_1].shopType == AutoChessConst.SHOP_TYPE.REWARD then
			self.rewardGoodDataList[self.shopListByUniqueId[iter_10_1].index] = nil
		elseif self.shopListByUniqueId[iter_10_1].shopType == AutoChessConst.SHOP_TYPE.PROP then
			self.propGoodDataList[self.shopListByUniqueId[iter_10_1].index] = nil
		end
	end
end

function AutoChessPrepareDataTemplate:UpdateChessTeamDataList(arg_11_1)
	self.playerData:UpdateChessTeamDataList(arg_11_1)
end

function AutoChessPrepareDataTemplate:ClearPlayerChessData()
	self.playerData:ClearPlayerChessData()
end

function AutoChessPrepareDataTemplate:RemoveChess(arg_13_1)
	self.playerData:RemoveChess(arg_13_1)
end

function AutoChessPrepareDataTemplate:InitHeroUpgradeInfo(arg_14_1)
	if arg_14_1 and (arg_14_1.old_level ~= arg_14_1.new_level or arg_14_1.type == AutoChessConst.CHESS_UPGRADE_TYPE.BRAHMA) then
		self.heroUpgradeInfo.oldLevel = arg_14_1.old_level
		self.heroUpgradeInfo.newLevel = arg_14_1.new_level
		self.heroUpgradeInfo.type = arg_14_1.type
		self.heroUpgradeInfo.heroAttrs = {}

		for iter_14_0, iter_14_1 in ipairs(arg_14_1.hero_upgrade_attrs or {}) do
			self.heroUpgradeInfo.heroAttrs[iter_14_1.index] = {
				hp = 0,
				atk = 0
			}

			for iter_14_2, iter_14_3 in ipairs(iter_14_1.attr_list) do
				if iter_14_3.key == AutoChessConst.CHESS_ATTRI_KEY.ATK then
					self.heroUpgradeInfo.heroAttrs[iter_14_1.index].atk = iter_14_3.value
				elseif iter_14_3.key == AutoChessConst.CHESS_ATTRI_KEY.HP then
					self.heroUpgradeInfo.heroAttrs[iter_14_1.index].hp = iter_14_3.value
				end
			end
		end

		self.heroUpgradeInfo.heroBuffs = {}

		for iter_14_4, iter_14_5 in ipairs(arg_14_1.hero_upgrade_buffs or {}) do
			self.heroUpgradeInfo.heroBuffs[iter_14_5.index] = iter_14_5.buff_ids[1]
		end
	end
end

function AutoChessPrepareDataTemplate:InitBuffDataList(arg_15_1)
	self.buffDataList = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = AutoChessBuffDataTemplate.New()

		var_15_0:Init(iter_15_1)
		table.insert(self.buffDataList, var_15_0)
	end
end

function AutoChessPrepareDataTemplate:UpdatePrepareActionList(arg_16_1)
	if #arg_16_1 > 0 then
		local var_16_0 = AutoChessBattleSimulator.GetInstance()

		if var_16_0:IsPlaying() then
			self.actionGroupId = self.actionGroupId == nil and 1 or self.actionGroupId + 1

			var_16_0:AddPrepareActionNode(self.actionGroupId, arg_16_1)
		else
			self.actionGroupId = 1

			local var_16_1 = AutoChessRoundBattleDataTemplate.New()

			var_16_1:Init({
				group_id = self.actionGroupId,
				action_list = arg_16_1
			})

			self.roundPrepareData = var_16_1

			var_16_0:StartBattleSimulator()
		end
	end
end

function AutoChessPrepareDataTemplate:GetBuffDataList()
	return self.buffDataList
end

function AutoChessPrepareDataTemplate:AddBuffDataList(arg_18_1)
	if self.buffDataList[arg_18_1.buffId] then
		return
	end

	table.insert(self.buffDataList, arg_18_1)
end

function AutoChessPrepareDataTemplate:RemoveBuffDataList(arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(self.buffDataList) do
		if iter_19_1:GetBuffID() == arg_19_1:GetBuffID() then
			table.remove(self.buffDataList, iter_19_0)

			return
		end
	end
end

function AutoChessPrepareDataTemplate:ContainBuff(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.buffDataList) do
		if iter_20_1:GetBuffID() == arg_20_1 then
			return true
		end
	end

	return false
end

function AutoChessPrepareDataTemplate:GetRoundPrepareData()
	return self.roundPrepareData
end

function AutoChessPrepareDataTemplate:GetAttributeList()
	return self.attributeList
end

function AutoChessPrepareDataTemplate:GetHeroUpgradeInfo()
	return self.heroUpgradeInfo
end

function AutoChessPrepareDataTemplate:ResetHeroUpgradeInfo()
	self.heroUpgradeInfo = {}
end

function AutoChessPrepareDataTemplate:GetChessGoodDataList()
	return self.chessGoodDataList, self.rewardGoodDataList, self.propGoodDataList
end

function AutoChessPrepareDataTemplate:GetPlayerData()
	return self.playerData
end

function AutoChessPrepareDataTemplate:GetEnemyData()
	return self.enemyData
end

function AutoChessPrepareDataTemplate:GetTeamDataList()
	return self.playerData:GetTeamDataList()
end

function AutoChessPrepareDataTemplate:GetStageId()
	return self.playerData:GetStageId()
end

function AutoChessPrepareDataTemplate:GetIsBrahmaBoss()
	return self.playerData:GetIsBrahmaBoss()
end

function AutoChessPrepareDataTemplate:GetCurRound()
	return self.playerData:GetCurRound()
end

function AutoChessPrepareDataTemplate:GetPveRestartTimes()
	return self.pveRestartTimes
end

function AutoChessPrepareDataTemplate:GetShopChessDataByByUniqueId(arg_33_1)
	return self.shopListByUniqueId[arg_33_1]
end

function AutoChessPrepareDataTemplate:GetChessNum()
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(self:GetTeamDataList()) do
		var_34_0 = var_34_0 + 1
	end

	return var_34_0
end

function AutoChessPrepareDataTemplate:GetShopAndRewardChessNum()
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in pairs(self.rewardGoodDataList) do
		var_35_0 = var_35_0 + 1
	end

	for iter_35_2, iter_35_3 in pairs(self.chessGoodDataList) do
		var_35_0 = var_35_0 + 1
	end

	return var_35_0
end

function AutoChessPrepareDataTemplate:GetShopChessNum()
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in pairs(self.chessGoodDataList) do
		var_36_0 = var_36_0 + 1
	end

	return var_36_0
end

function AutoChessPrepareDataTemplate:GetUUID()
	return self.uuid
end

return AutoChessPrepareDataTemplate
