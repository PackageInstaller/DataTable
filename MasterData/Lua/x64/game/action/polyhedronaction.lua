local var_0_0 = {}

manager.net:Bind(18001, function(arg_1_0)
	local var_1_0 = {}

	if PolyhedronData:GetPolyhedronInfo() ~= nil then
		var_1_0 = PolyhedronData:GetPolyhedronInfo():GetFightHeroList()
	end

	PolyhedronData:InitPolyhedronGameData(arg_1_0)
	manager.notify:CallUpdateFunc(POLYHEDRON_GAME_UPDATE)

	local var_1_1 = PolyhedronData:GetPolyhedronInfo():GetFightHeroList()

	if #var_1_0 ~= #var_1_1 then
		local var_1_2 = ComboSkillTools.GetRecommendSkillID(var_1_1, true)

		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), var_1_2)
		manager.notify:Invoke(COMBO_SKILL_SELECT, var_1_2)
	else
		local var_1_3 = arg_1_0.game.progress.cooperate_unique_skill_id

		if not SkillTools.CanUseComboSkill(arg_1_0.game.progress.cooperate_unique_skill_id, var_1_1) then
			local var_1_4 = ComboSkillTools.GetRecommendSkillID(var_1_1, true)

			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), var_1_4)
			manager.notify:Invoke(COMBO_SKILL_SELECT, var_1_4)
		elseif BattleTeamData:GetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID()) ~= var_1_3 then
			BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, PolyhedronData:GetActivityID(), var_1_3)
			manager.notify:Invoke(COMBO_SKILL_SELECT, var_1_3)
		end
	end

	var_0_0.RefreshPolicyRedPoint()
	var_0_0.CheckBeaconRedPoint()
	var_0_0.CheckTerminalRedPoint()
	var_0_0:RefreshHeroesRedPoint()
	var_0_0.CheckNewRed()
end)

function var_0_0.UpdatePolyhedronNewRed()
	if PolyhedronData:GetIsNewRed() then
		manager.net:SendWithLoadingNew(18034, {}, 18035, var_0_0.UpdatePolyhedronNewRedBack)
	end
end

function var_0_0:UpdatePolyhedronNewRedBack()
	if isSuccess(self.result) then
		PolyhedronData:SetNewRedValue(0)
		var_0_0.CheckNewRed()
	else
		ShowTips(self.result)
	end
end

manager.net:Bind(18003, function(arg_4_0)
	PolyhedronData:UpdatePolyhedronProcess(arg_4_0)
	manager.notify:CallUpdateFunc(POLYHEDRON_PROCESS_UPDATE)
end)
manager.net:Bind(18005, function(arg_5_0)
	PolyhedronData:UpdatePolyhedronSettlement(arg_5_0)
	var_0_0.RefreshPolicyRedPoint()
end)
manager.notify:RegistListener(CURRENCY_UPDATE, function(arg_6_0)
	if arg_6_0 == CurrencyConst.CURRENCY_TYPE_POLYHEDRON_TERMINAL_EXP then
		PolyhedronData:UpdateTerminalLevel()

		if PolyhedronData:GetTerminalLevel() ~= PolyhedronData:GetTerminalLevel() then
			var_0_0.CheckTerminalRedPoint()
		end
	end

	if arg_6_0 == CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS then
		var_0_0:RefreshHeroesRedPoint()
	end
end)
manager.notify:RegistListener(NEW_DAY, function()
	PolyhedronData.ResetAlreadyChallengeTimes()
end)
manager.notify:RegistListener(SYSTEM_OPEN_OR_LOCK, function()
	var_0_0:CheckNewRed()
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function()
	var_0_0:RefreshHeroesRedPoint()
end)
manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0:RefreshHeroesRedPoint()
	var_0_0:CheckBeaconRedPoint()
end)

function var_0_0.CommonQuitTips()
	if PolyhedronData:GetPolyhedronInfo():GetState() == PolyhedronConst.STATE_TYPE.SETTLEMENT then
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})

		return true
	end

	return false
end

function var_0_0:QueryStartPolyhedron(arg_12_1, arg_12_2)
	if PolyhedronData:GetIsNewRed() then
		JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronLobby", {})

		return
	end

	local var_12_0, var_12_1 = pcall(function()
		manager.net:SendWithLoadingNew(18010, {
			hero_id_list = self,
			beacon_id_list = arg_12_1,
			difficulty = arg_12_2
		}, 18011, var_0_0.StartPolyhedronCallBack)
	end)

	if var_12_1 then
		local var_12_2 = ""

		if self ~= nil then
			for iter_12_0, iter_12_1 in ipairs(self) do
				var_12_2 = var_12_2 .. self[iter_12_0]

				if iter_12_0 ~= #self then
					var_12_2 = var_12_2 .. ","
				end
			end
		else
			var_12_2 = "nil"
		end

		local var_12_3 = ""

		if arg_12_1 ~= nil then
			for iter_12_2, iter_12_3 in ipairs(arg_12_1) do
				var_12_3 = var_12_3 .. arg_12_1[iter_12_2]

				if iter_12_2 ~= #arg_12_1 then
					var_12_3 = var_12_3 .. ","
				end
			end
		else
			var_12_2 = "nil"
		end

		error(string.format("发给服务端的数据错误：hero_id_list = {%s}, beacon_id_list = {%s}, difficulty = %s", var_12_2, var_12_3, tostring(arg_12_2)))
	end
end

function var_0_0:StartPolyhedronCallBack(arg_14_1)
	if isSuccess(self.result) then
		var_0_0.LaunchPolyhedronBattle()
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryRewardPolyhedron(arg_15_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18012, {
		index = arg_15_0
	}, 18013, var_0_0.RewardPolyhedronCallBack)
end

function var_0_0:RewardPolyhedronCallBack(arg_16_1)
	if isSuccess(self.result) then
		if PolyhedronConst.SAVE_POINT_TYPE.REWARD == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
			gameContext:Go("polyhedronReward")
		else
			JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle")
			DoPolyhedronNextTrigger()
		end
	elseif self.result == TipsCfg.get_id_list_by_define.ERROR_ADMIN_ACTIVTY_BLOCK then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips(self.result),
			OkCallback = function()
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		})
	else
		if PolyhedronConst.SAVE_POINT_TYPE.UNDEFINED == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end

		ShowTips(self.result)
	end
end

function var_0_0.QueryResetRewardPolyhedron()
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18030, {}, 18031, var_0_0.ResetRewardPolyhedronCallBack)
end

function var_0_0:ResetRewardPolyhedronCallBack()
	if isSuccess(self.result) then
		gameContext:Go("polyhedronReward")
	else
		ShowTips(self.result)
	end
end

function var_0_0.QuerySelectStagePolyhedron(arg_20_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18014, {
		index = arg_20_0
	}, 18015, var_0_0.SelectStagePolyhedronCallBack)
end

function var_0_0:SelectStagePolyhedronCallBack(arg_21_1)
	if isSuccess(self.result) then
		var_0_0.LaunchPolyhedronBattle()
	else
		if PolyhedronConst.SAVE_POINT_TYPE.UNDEFINED == PolyhedronData:GetPolyhedronInfo():GetSavePoint() then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end

		ShowTips(self.result)
	end
end

function var_0_0.QueryUnlockHero(arg_22_0)
	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) > 0 then
		manager.net:SendWithLoadingNew(66036, {
			hero_id = arg_22_0
		}, 66037, var_0_0.UnlockHeroCallBack)
	else
		ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
	end
end

function var_0_0:UnlockHeroCallBack(arg_23_1)
	if isSuccess(self.result) then
		PolyhedronData:UnlockHero(arg_23_1.hero_id)
		var_0_0:RefreshHeroesRedPoint()
		manager.notify:CallUpdateFunc(POLYHEDRON_HERO_UNLOCK)
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryPolyhedronReset()
	manager.net:SendWithLoadingNew(18016, {}, 18017, var_0_0.PolyhedronResetCallBack)
end

function var_0_0:PolyhedronResetCallBack()
	if isSuccess(self.result) then
		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, 0)
		manager.notify:Invoke(COMBO_SKILL_SELECT, 0)
		OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryPolyhedronGiveUp(arg_26_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18018, {}, 18019, arg_26_0)
end

local var_0_1

function var_0_0:QueryEnlistHero()
	if var_0_0.CommonQuitTips() then
		return
	end

	var_0_1 = self.enlist_type

	manager.net:SendWithLoadingNew(18020, {
		hero_id = self.heroId
	}, 18021, var_0_0.EnlistHeroCallBack)
end

function var_0_0:EnlistHeroCallBack()
	if isSuccess(self.result) then
		if var_0_1 == PolyhedronConst.ENLIST_TYPE.BATTLE then
			DoPolyhedronNextBattleTrigger()
		else
			DoPolyhedronNextTrigger()
		end

		gameContext:Go("/polyhedronBlank")
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryBuyShopItem(arg_29_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18022, {
		index = arg_29_0
	}, 18023, var_0_0.BuyShopItemCallBack)
end

function var_0_0:BuyShopItemCallBack()
	if isSuccess(self.result) then
		ShowTips("TRANSACTION_SUCCESS")
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryRefreshShop()
	if var_0_0.CommonQuitTips() then
		return
	end

	local var_31_0 = PolyhedronData:GetPolyhedronInfo()
	local var_31_1 = var_31_0:GetShopRefreshTimes()
	local var_31_2 = var_31_0:GetShopFressRefreshTimes()

	if var_31_1 < var_31_0:GetShopMaxRefreshTimes() then
		if var_31_2 <= var_31_1 then
			if var_31_0:GetCoinCount() < var_31_0:GetShopRefreshCost(var_31_1 - var_31_2 + 1) then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

				return
			end

			manager.net:SendWithLoadingNew(18024, {}, 18025, var_0_0.RefreshShopCallBack)
		else
			manager.net:SendWithLoadingNew(18024, {}, 18025, var_0_0.RefreshShopCallBack)
		end
	end
end

function var_0_0:RefreshShopCallBack()
	if isSuccess(self.result) then
		-- block empty
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryShopBloodReturn()
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18026, {}, 18027, var_0_0.ShopBloodReturnCallBack)
end

function var_0_0:ShopBloodReturnCallBack()
	if isSuccess(self.result) then
		UpdatePolyhedronBattleHpUI()
	else
		ShowTips(self.result)
	end
end

function var_0_0.QuerySwitchTeamHero(arg_35_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18028, {
		fight_id_list = arg_35_0
	}, 18029, var_0_0.SwitchTeamHeroCallBack)
end

function var_0_0:SwitchTeamHeroCallBack(arg_36_1)
	if isSuccess(self.result) then
		local var_36_0 = ComboSkillTools.GetRecommendSkillID(arg_36_1.fight_id_list, true)

		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, var_36_0)
		manager.notify:Invoke(COMBO_SKILL_SELECT, var_36_0)
		manager.notify:CallUpdateFunc(POLYHEDRON_SWITCH_HERO)
	else
		ShowTips(self.result)
	end
end

function var_0_0.LaunchPolyhedronBattle()
	BattleController.GetInstance():LaunchBattle((BattlePolyhedronStageTemplate.New((PolyhedronData:GetPolyhedronInfo():GetStageId()))))
end

function var_0_0.QuerySetTerminal(arg_38_0)
	manager.net:SendWithLoadingNew(18032, {
		upgrade_id_list = arg_38_0
	}, 18033, var_0_0.SetTerminalCallBack)
end

function var_0_0:SetTerminalCallBack(arg_39_1)
	if isSuccess(self.result) then
		PolyhedronData:SetTerminalGift(arg_39_1.upgrade_id_list)
		var_0_0.CheckTerminalRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.QueryUnlockBeacon(arg_40_0)
	manager.net:SendWithLoadingNew(66034, {
		beacon_id = arg_40_0
	}, 66035, var_0_0.UnlockBeaconCallBack)
end

function var_0_0:UnlockBeaconCallBack(arg_41_1)
	if isSuccess(self.result) then
		PolyhedronData:AddUnlockBeacon(arg_41_1.beacon_id)
		manager.notify:CallUpdateFunc(POLYHEDRON_BEACON_UNLOCK)
		ShowTips(GetTips("POLYHEDRON_BEACON_UNLOCK_SUCCESS"))
		var_0_0.CheckBeaconRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.CheckBeaconRedPoint(arg_42_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

		return
	end

	if not ActivityData:GetActivityIsOpen((PolyhedronData:GetActivityID())) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

		return
	end

	for iter_42_0, iter_42_1 in ipairs(PolyhedronBeaconCfg.all) do
		if PolyhedronData:GetBeaconIsLock(iter_42_1) and PolyhedronTools.GetBeaconIsUnlockCondition(iter_42_1) then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)
end

function var_0_0.CheckTerminalRedPoint(arg_43_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return false
	end

	if not ActivityData:GetActivityIsOpen((PolyhedronData:GetActivityID())) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return
	end

	local var_43_0 = PolyhedronData:GetTerminalGift()
	local var_43_1 = 0

	for iter_43_0, iter_43_1 in pairs(var_43_0) do
		var_43_1 = var_43_1 + PolyhedronTerminalCfg[iter_43_1].cost
	end

	local var_43_2 = PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point - var_43_1

	if var_43_2 <= 0 then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return false
	end

	for iter_43_2, iter_43_3 in ipairs(PolyhedronTerminalCfg.all) do
		if not table.indexof(var_43_0, iter_43_3) then
			for iter_43_4, iter_43_5 in ipairs(PolyhedronTerminalCfg[iter_43_3].pre_id_list) do
				if (iter_43_5 == 0 or table.indexof(var_43_0, iter_43_5)) and var_43_2 >= PolyhedronTerminalCfg[iter_43_3].cost then
					manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 1)

					return
				end
			end
		end
	end

	manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

	return false
end

function var_0_0.RefreshHeroesRedPoint(arg_44_0)
	if not ActivityData:GetActivityIsOpen((PolyhedronData:GetActivityID())) or JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, 0)

		return
	end

	manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, (var_0_0:GetPolyhedronHeroesRedPointCount()))
end

function var_0_0.GetPolyhedronHeroesRedPointCount(arg_45_0)
	local var_45_0 = PolyhedronData.GetHeroIDList()

	if not var_45_0 then
		return 0
	end

	for iter_45_0, iter_45_1 in ipairs(var_45_0) do
		if var_0_0:GetPolyhedronHeroRedPointCount(iter_45_1) > 0 then
			return 1
		end
	end

	return 0
end

function var_0_0.GetPolyhedronHeroRedPointCount(arg_46_0, arg_46_1)
	if not HeroTools.GetHeroIsUnlock(arg_46_1) then
		return 0
	end

	if PolyhedronData:GetPolyhedronHeroUnlock(arg_46_1) then
		return 0
	end

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) < 1 then
		return 0
	end

	return PolyhedronData:GetHeroClicked(arg_46_1) and 0 or 1
end

function var_0_0.QueryPolicyReward(arg_47_0, arg_47_1)
	local var_47_0 = {
		type = arg_47_0
	}

	if arg_47_0 == 2 then
		var_47_0.level = arg_47_1
	end

	manager.net:SendWithLoadingNew(66000, var_47_0, 66001, var_0_0.QueryPolicyRewardCallBack)
end

function var_0_0:QueryPolicyRewardCallBack(arg_48_1)
	if isSuccess(self.result) then
		sortMergeGetReward(self.reward_list)

		local var_48_0 = {}

		if arg_48_1.type == 1 then
			local var_48_1, var_48_2 = PolyhedronTools.PolyhedronPolicyExpToLevel()
			local var_48_3 = PolyhedronData:GetPolicyApplyList()

			for iter_48_0 = 1, var_48_1 do
				if var_48_3[iter_48_0] == nil then
					var_48_0[#var_48_0 + 1] = iter_48_0
				end
			end
		else
			var_48_0[#var_48_0 + 1] = arg_48_1.level
		end

		PolyhedronData:SetPolicyApplyList(var_48_0)
		manager.notify:CallUpdateFunc(POLYHEDRON_POLICY_REWARD_RECEIVE)
		var_0_0.RefreshPolicyRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.RefreshPolicyRedPoint()
	if not ActivityData:GetActivityIsOpen((PolyhedronData:GetActivityID())) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 0)

		return
	end

	local var_49_0, var_49_1 = PolyhedronTools.PolyhedronPolicyExpToLevel()
	local var_49_2 = PolyhedronData:GetPolicyApplyList()

	for iter_49_0 = 1, var_49_0 do
		if var_49_2[iter_49_0] == nil then
			manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 0)
end

local var_0_2 = PolyhedronConst.RANK_TYPE.ALL
local var_0_3 = PolyhedronConst.RANK_SUB_TYPE.SCORE
local var_0_4

function var_0_0.ResetRankCache()
	var_0_2 = PolyhedronConst.RANK_TYPE.ALL
	var_0_3 = PolyhedronConst.RANK_SUB_TYPE.SCORE
	var_0_4 = nil
end

function var_0_0.QueryCurRank(arg_51_0, arg_51_1)
	RankAction.QueryOwnCommonRank(RankConst.RANK_ID.POLYHERON, arg_51_0 == PolyhedronConst.RANK_SUB_TYPE.HERO and PolyhedronData.GetHeroIDList() or {
		0
	}, arg_51_1)
end

function var_0_0.QueryOpenRankView()
	local var_52_0 = GuildData:GetGuildInfo()

	if var_52_0 == nil or var_52_0.id == nil then
		var_0_2 = PolyhedronConst.RANK_TYPE.ALL
	end

	if PolyhedronConst.RANK_TYPE.GUILD == var_0_2 then
		var_0_0.QueryGuildRankList(var_0_3, var_0_4)
	else
		var_0_0.QueryRankList(var_0_3, var_0_4)
	end
end

function var_0_0.QueryRankList(arg_53_0, arg_53_1)
	RankAction.QueryCommonRank(RankConst.RANK_ID.POLYHERON, arg_53_0 == PolyhedronConst.RANK_SUB_TYPE.HERO and arg_53_1 or 0, function()
		var_0_2 = PolyhedronConst.RANK_TYPE.ALL
		var_0_3 = arg_53_0
		var_0_4 = arg_53_1

		JumpTools.OpenPageByJump("/polyhedronRank", {
			type = var_0_2,
			subType = var_0_3,
			heroID = var_0_4
		})
	end)
end

function var_0_0.QueryGuildRankList(arg_55_0, arg_55_1)
	RankAction.QueryGuildCommonRank(RankConst.RANK_ID.POLYHERON, arg_55_0 == PolyhedronConst.RANK_SUB_TYPE.HERO and arg_55_1 or 0, function()
		var_0_2 = PolyhedronConst.RANK_TYPE.GUILD
		var_0_3 = arg_55_0
		var_0_4 = arg_55_1

		JumpTools.OpenPageByJump("/polyhedronRank", {
			type = var_0_2,
			subType = var_0_3,
			heroID = var_0_4
		})
	end)
end

function var_0_0.ResetTerminal(arg_57_0)
	manager.net:SendWithLoadingNew(66002, {}, 66003, function(arg_58_0, arg_58_1)
		var_0_0.OnResetTerminalCallback(arg_58_0, arg_58_1, arg_57_0)
	end)
end

function var_0_0:OnResetTerminalCallback(arg_59_1, arg_59_2)
	if isSuccess(self.result) then
		if arg_59_2 then
			arg_59_2()
		end

		PolyhedronData:ResetTerminalCallback()
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.AstrolabeEquip(arg_60_0, arg_60_1)
	local var_60_0 = {}

	for iter_60_0, iter_60_1 in ipairs((PolyhedronData:GetUseAstrolabe(arg_60_0))) do
		table.insert(var_60_0, iter_60_1)
	end

	table.insert(var_60_0, arg_60_1)
	manager.net:SendWithLoadingNew(66004, {
		hero_id = arg_60_0,
		astrolabe_id_list = var_60_0
	}, 66005, var_0_0.OnAstrolabeEquip)
end

function var_0_0:OnAstrolabeEquip(arg_61_1)
	if isSuccess(self.result) then
		PolyhedronData:SetUseAstrolabe(arg_61_1.hero_id, arg_61_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, self, arg_61_1)
end

function var_0_0.AstrolabeEquipAll(arg_62_0, arg_62_1)
	manager.net:SendWithLoadingNew(66004, {
		hero_id = arg_62_0,
		astrolabe_id_list = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[arg_62_1]
	}, 66005, var_0_0.OnAstrolabeEquipAll)
end

function var_0_0:OnAstrolabeEquipAll(arg_63_1)
	if isSuccess(self.result) then
		PolyhedronData:SetUseAstrolabe(arg_63_1.hero_id, arg_63_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, self, arg_63_1)
end

function var_0_0.AstrolabeUnload(arg_64_0, arg_64_1)
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in ipairs((PolyhedronData:GetUseAstrolabe(arg_64_0))) do
		if HeroAstrolabeCfg[iter_64_1].hero_astrolabe_suit_id ~= HeroAstrolabeCfg[arg_64_1].hero_astrolabe_suit_id or iter_64_1 < arg_64_1 then
			table.insert(var_64_0, iter_64_1)
		end
	end

	manager.net:SendWithLoadingNew(66004, {
		hero_id = arg_64_0,
		astrolabe_id_list = var_64_0
	}, 66005, var_0_0.OnAstrolabeUnload)
end

function var_0_0:OnAstrolabeUnload(arg_65_1)
	if isSuccess(self.result) then
		PolyhedronData:SetUseAstrolabe(arg_65_1.hero_id, arg_65_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, self, arg_65_1)
end

function var_0_0.AstrolabeUnloadAll(arg_66_0)
	manager.net:SendWithLoadingNew(66004, {
		hero_id = arg_66_0,
		astrolabe_id_list = {}
	}, 66005, var_0_0.OnAstrolabeUnloadAll)
end

function var_0_0:OnAstrolabeUnloadAll(arg_67_1)
	if isSuccess(self.result) then
		PolyhedronData:SetUseAstrolabe(arg_67_1.hero_id, arg_67_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, self, arg_67_1)
end

function var_0_0.CheckNewRed(arg_68_0)
	if not SystemData:ServerSystemIsLocked(ViewConst.SYSTEM_ID.MATRIX) and PolyhedronData:GetIsNewRed() then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_NEW_SECTION, 1, RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_NEW_SECTION, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

return var_0_0
