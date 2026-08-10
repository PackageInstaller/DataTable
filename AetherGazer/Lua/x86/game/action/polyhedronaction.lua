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

		if not SkillTools.CanUseComboSkill(var_1_3, var_1_1) then
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

function var_0_0.UpdatePolyhedronNewRedBack(arg_3_0)
	if isSuccess(arg_3_0.result) then
		PolyhedronData:SetNewRedValue(0)
		var_0_0.CheckNewRed()
	else
		ShowTips(arg_3_0.result)
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
		local var_6_0 = PolyhedronData:GetTerminalLevel()

		PolyhedronData:UpdateTerminalLevel()

		if var_6_0 ~= PolyhedronData:GetTerminalLevel() then
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

function var_0_0.QueryStartPolyhedron(arg_12_0, arg_12_1, arg_12_2)
	if PolyhedronData:GetIsNewRed() then
		JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronLobby", {})

		return
	end

	local var_12_0, var_12_1 = pcall(function()
		manager.net:SendWithLoadingNew(18010, {
			hero_id_list = arg_12_0,
			beacon_id_list = arg_12_1,
			difficulty = arg_12_2
		}, 18011, var_0_0.StartPolyhedronCallBack)
	end)

	if var_12_1 then
		local var_12_2 = ""

		if arg_12_0 ~= nil then
			for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
				var_12_2 = var_12_2 .. arg_12_0[iter_12_0]

				if iter_12_0 ~= #arg_12_0 then
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

function var_0_0.StartPolyhedronCallBack(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		var_0_0.LaunchPolyhedronBattle()
	else
		ShowTips(arg_14_0.result)
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

function var_0_0.RewardPolyhedronCallBack(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		local var_16_0 = PolyhedronData:GetPolyhedronInfo():GetSavePoint()

		if PolyhedronConst.SAVE_POINT_TYPE.REWARD == var_16_0 then
			gameContext:Go("polyhedronReward")
		else
			JumpTools.OpenPageByJump("/polyhedronBlank/polyhedronBattle")
			DoPolyhedronNextTrigger()
		end
	elseif arg_16_0.result == TipsCfg.get_id_list_by_define.ERROR_ADMIN_ACTIVTY_BLOCK then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips(arg_16_0.result),
			OkCallback = function()
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
			end
		})
	else
		local var_16_1 = PolyhedronData:GetPolyhedronInfo():GetSavePoint()

		if PolyhedronConst.SAVE_POINT_TYPE.UNDEFINED == var_16_1 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end

		ShowTips(arg_16_0.result)
	end
end

function var_0_0.QueryResetRewardPolyhedron()
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18030, {}, 18031, var_0_0.ResetRewardPolyhedronCallBack)
end

function var_0_0.ResetRewardPolyhedronCallBack(arg_19_0)
	if isSuccess(arg_19_0.result) then
		gameContext:Go("polyhedronReward")
	else
		ShowTips(arg_19_0.result)
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

function var_0_0.SelectStagePolyhedronCallBack(arg_21_0, arg_21_1)
	if isSuccess(arg_21_0.result) then
		var_0_0.LaunchPolyhedronBattle()
	else
		local var_21_0 = PolyhedronData:GetPolyhedronInfo():GetSavePoint()

		if PolyhedronConst.SAVE_POINT_TYPE.UNDEFINED == var_21_0 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end

		ShowTips(arg_21_0.result)
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

function var_0_0.UnlockHeroCallBack(arg_23_0, arg_23_1)
	if isSuccess(arg_23_0.result) then
		PolyhedronData:UnlockHero(arg_23_1.hero_id)
		var_0_0:RefreshHeroesRedPoint()
		manager.notify:CallUpdateFunc(POLYHEDRON_HERO_UNLOCK)
	else
		ShowTips(arg_23_0.result)
	end
end

function var_0_0.QueryPolyhedronReset()
	manager.net:SendWithLoadingNew(18016, {}, 18017, var_0_0.PolyhedronResetCallBack)
end

function var_0_0.PolyhedronResetCallBack(arg_25_0)
	if isSuccess(arg_25_0.result) then
		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, 0)
		manager.notify:Invoke(COMBO_SKILL_SELECT, 0)
		OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
	else
		ShowTips(arg_25_0.result)
	end
end

function var_0_0.QueryPolyhedronGiveUp(arg_26_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18018, {}, 18019, arg_26_0)
end

local var_0_1

function var_0_0.QueryEnlistHero(arg_27_0)
	if var_0_0.CommonQuitTips() then
		return
	end

	var_0_1 = arg_27_0.enlist_type

	manager.net:SendWithLoadingNew(18020, {
		hero_id = arg_27_0.heroId
	}, 18021, var_0_0.EnlistHeroCallBack)
end

function var_0_0.EnlistHeroCallBack(arg_28_0)
	if isSuccess(arg_28_0.result) then
		if var_0_1 == PolyhedronConst.ENLIST_TYPE.BATTLE then
			DoPolyhedronNextBattleTrigger()
		else
			DoPolyhedronNextTrigger()
		end

		gameContext:Go("/polyhedronBlank")
	else
		ShowTips(arg_28_0.result)
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

function var_0_0.BuyShopItemCallBack(arg_30_0)
	if isSuccess(arg_30_0.result) then
		ShowTips("TRANSACTION_SUCCESS")
	else
		ShowTips(arg_30_0.result)
	end
end

function var_0_0.QueryRefreshShop()
	if var_0_0.CommonQuitTips() then
		return
	end

	local var_31_0 = PolyhedronData:GetPolyhedronInfo()
	local var_31_1 = var_31_0:GetShopRefreshTimes()
	local var_31_2 = var_31_0:GetShopMaxRefreshTimes()
	local var_31_3 = var_31_0:GetShopFressRefreshTimes()
	local var_31_4 = var_31_0:GetCoinCount()

	if var_31_1 < var_31_2 then
		if var_31_3 <= var_31_1 then
			local var_31_5 = var_31_1 - var_31_3

			if var_31_4 < var_31_0:GetShopRefreshCost(var_31_5 + 1) then
				ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")

				return
			end

			manager.net:SendWithLoadingNew(18024, {}, 18025, var_0_0.RefreshShopCallBack)
		else
			manager.net:SendWithLoadingNew(18024, {}, 18025, var_0_0.RefreshShopCallBack)
		end
	end
end

function var_0_0.RefreshShopCallBack(arg_32_0)
	if isSuccess(arg_32_0.result) then
		-- block empty
	else
		ShowTips(arg_32_0.result)
	end
end

function var_0_0.QueryShopBloodReturn()
	if var_0_0.CommonQuitTips() then
		return
	end

	manager.net:SendWithLoadingNew(18026, {}, 18027, var_0_0.ShopBloodReturnCallBack)
end

function var_0_0.ShopBloodReturnCallBack(arg_34_0)
	if isSuccess(arg_34_0.result) then
		UpdatePolyhedronBattleHpUI()
	else
		ShowTips(arg_34_0.result)
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

function var_0_0.SwitchTeamHeroCallBack(arg_36_0, arg_36_1)
	if isSuccess(arg_36_0.result) then
		local var_36_0 = ComboSkillTools.GetRecommendSkillID(arg_36_1.fight_id_list, true)

		BattleFieldAction.SetComboInfo(BattleConst.STAGE_TYPE_NEW.POLYHEDRON, 0, var_36_0)
		manager.notify:Invoke(COMBO_SKILL_SELECT, var_36_0)
		manager.notify:CallUpdateFunc(POLYHEDRON_SWITCH_HERO)
	else
		ShowTips(arg_36_0.result)
	end
end

function var_0_0.LaunchPolyhedronBattle()
	local var_37_0 = PolyhedronData:GetPolyhedronInfo():GetStageId()
	local var_37_1 = BattlePolyhedronStageTemplate.New(var_37_0)

	BattleController.GetInstance():LaunchBattle(var_37_1)
end

function var_0_0.QuerySetTerminal(arg_38_0)
	manager.net:SendWithLoadingNew(18032, {
		upgrade_id_list = arg_38_0
	}, 18033, var_0_0.SetTerminalCallBack)
end

function var_0_0.SetTerminalCallBack(arg_39_0, arg_39_1)
	if isSuccess(arg_39_0.result) then
		PolyhedronData:SetTerminalGift(arg_39_1.upgrade_id_list)
		var_0_0.CheckTerminalRedPoint()
	else
		ShowTips(arg_39_0.result)
	end
end

function var_0_0.QueryUnlockBeacon(arg_40_0)
	manager.net:SendWithLoadingNew(66034, {
		beacon_id = arg_40_0
	}, 66035, var_0_0.UnlockBeaconCallBack)
end

function var_0_0.UnlockBeaconCallBack(arg_41_0, arg_41_1)
	if isSuccess(arg_41_0.result) then
		PolyhedronData:AddUnlockBeacon(arg_41_1.beacon_id)
		manager.notify:CallUpdateFunc(POLYHEDRON_BEACON_UNLOCK)
		ShowTips(GetTips("POLYHEDRON_BEACON_UNLOCK_SUCCESS"))
		var_0_0.CheckBeaconRedPoint()
	else
		ShowTips(arg_41_0.result)
	end
end

function var_0_0.CheckBeaconRedPoint(arg_42_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

		return
	end

	local var_42_0 = PolyhedronData:GetActivityID()

	if not ActivityData:GetActivityIsOpen(var_42_0) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_BEACON_UNLOCK, 0)

		return
	end

	local var_42_1 = PolyhedronBeaconCfg.all

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
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

	local var_43_0 = PolyhedronData:GetActivityID()

	if not ActivityData:GetActivityIsOpen(var_43_0) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return
	end

	local var_43_1 = PolyhedronData:GetTerminalGift()
	local var_43_2 = 0

	for iter_43_0, iter_43_1 in pairs(var_43_1) do
		var_43_2 = var_43_2 + PolyhedronTerminalCfg[iter_43_1].cost
	end

	local var_43_3 = PolyhedronData:GetTerminalLevel()
	local var_43_4 = PolyhedronTerminalLevelCfg[var_43_3].point - var_43_2

	if var_43_4 <= 0 then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_TERMINAL_GIFT, 0)

		return false
	end

	for iter_43_2, iter_43_3 in ipairs(PolyhedronTerminalCfg.all) do
		if not table.indexof(var_43_1, iter_43_3) then
			local var_43_5 = PolyhedronTerminalCfg[iter_43_3]
			local var_43_6 = var_43_5.pre_id_list

			for iter_43_4, iter_43_5 in ipairs(var_43_6) do
				if (iter_43_5 == 0 or table.indexof(var_43_1, iter_43_5)) and var_43_4 >= var_43_5.cost then
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
	local var_44_0 = PolyhedronData:GetActivityID()

	if not ActivityData:GetActivityIsOpen(var_44_0) or JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MATRIX) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, 0)

		return
	end

	local var_44_1 = var_0_0:GetPolyhedronHeroesRedPointCount()

	manager.redPoint:setTip(RedPointConst.POLYHEDRON_HERO_UNLOCK, var_44_1)
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

function var_0_0.QueryPolicyRewardCallBack(arg_48_0, arg_48_1)
	if isSuccess(arg_48_0.result) then
		sortMergeGetReward(arg_48_0.reward_list)

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
		ShowTips(arg_48_0.result)
	end
end

function var_0_0.RefreshPolicyRedPoint()
	local var_49_0 = PolyhedronData:GetActivityID()

	if not ActivityData:GetActivityIsOpen(var_49_0) then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_POLICY_LEVEL_REWARD, 0)

		return
	end

	local var_49_1, var_49_2 = PolyhedronTools.PolyhedronPolicyExpToLevel()
	local var_49_3 = PolyhedronData:GetPolicyApplyList()

	for iter_49_0 = 1, var_49_1 do
		if var_49_3[iter_49_0] == nil then
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
	local var_51_0

	if arg_51_0 == PolyhedronConst.RANK_SUB_TYPE.HERO then
		var_51_0 = PolyhedronData.GetHeroIDList()
	else
		var_51_0 = {
			0
		}
	end

	RankAction.QueryOwnCommonRank(RankConst.RANK_ID.POLYHERON, var_51_0, arg_51_1)
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
	local var_53_0 = 0

	if arg_53_0 == PolyhedronConst.RANK_SUB_TYPE.HERO then
		var_53_0 = arg_53_1
	else
		var_53_0 = 0
	end

	RankAction.QueryCommonRank(RankConst.RANK_ID.POLYHERON, var_53_0, function()
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
	local var_55_0 = 0

	if arg_55_0 == PolyhedronConst.RANK_SUB_TYPE.HERO then
		var_55_0 = arg_55_1
	else
		var_55_0 = 0
	end

	RankAction.QueryGuildCommonRank(RankConst.RANK_ID.POLYHERON, var_55_0, function()
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
	local var_57_0 = {}

	manager.net:SendWithLoadingNew(66002, var_57_0, 66003, function(arg_58_0, arg_58_1)
		var_0_0.OnResetTerminalCallback(arg_58_0, arg_58_1, arg_57_0)
	end)
end

function var_0_0.OnResetTerminalCallback(arg_59_0, arg_59_1, arg_59_2)
	if isSuccess(arg_59_0.result) then
		if arg_59_2 then
			arg_59_2()
		end

		PolyhedronData:ResetTerminalCallback()
	else
		ShowTips(GetTips(arg_59_0.result))
	end
end

function var_0_0.AstrolabeEquip(arg_60_0, arg_60_1)
	local var_60_0 = PolyhedronData:GetUseAstrolabe(arg_60_0)
	local var_60_1 = {}

	for iter_60_0, iter_60_1 in ipairs(var_60_0) do
		table.insert(var_60_1, iter_60_1)
	end

	table.insert(var_60_1, arg_60_1)

	local var_60_2 = {
		hero_id = arg_60_0,
		astrolabe_id_list = var_60_1
	}

	manager.net:SendWithLoadingNew(66004, var_60_2, 66005, var_0_0.OnAstrolabeEquip)
end

function var_0_0.OnAstrolabeEquip(arg_61_0, arg_61_1)
	if isSuccess(arg_61_0.result) then
		PolyhedronData:SetUseAstrolabe(arg_61_1.hero_id, arg_61_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, arg_61_0, arg_61_1)
end

function var_0_0.AstrolabeEquipAll(arg_62_0, arg_62_1)
	local var_62_0 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[arg_62_1]
	local var_62_1 = {
		hero_id = arg_62_0,
		astrolabe_id_list = var_62_0
	}

	manager.net:SendWithLoadingNew(66004, var_62_1, 66005, var_0_0.OnAstrolabeEquipAll)
end

function var_0_0.OnAstrolabeEquipAll(arg_63_0, arg_63_1)
	if isSuccess(arg_63_0.result) then
		PolyhedronData:SetUseAstrolabe(arg_63_1.hero_id, arg_63_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_EQUIP, arg_63_0, arg_63_1)
end

function var_0_0.AstrolabeUnload(arg_64_0, arg_64_1)
	local var_64_0 = PolyhedronData:GetUseAstrolabe(arg_64_0)
	local var_64_1 = {}
	local var_64_2 = HeroAstrolabeCfg[arg_64_1].hero_astrolabe_suit_id

	for iter_64_0, iter_64_1 in ipairs(var_64_0) do
		if HeroAstrolabeCfg[iter_64_1].hero_astrolabe_suit_id ~= var_64_2 or iter_64_1 < arg_64_1 then
			table.insert(var_64_1, iter_64_1)
		end
	end

	local var_64_3 = {
		hero_id = arg_64_0,
		astrolabe_id_list = var_64_1
	}

	manager.net:SendWithLoadingNew(66004, var_64_3, 66005, var_0_0.OnAstrolabeUnload)
end

function var_0_0.OnAstrolabeUnload(arg_65_0, arg_65_1)
	if isSuccess(arg_65_0.result) then
		PolyhedronData:SetUseAstrolabe(arg_65_1.hero_id, arg_65_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, arg_65_0, arg_65_1)
end

function var_0_0.AstrolabeUnloadAll(arg_66_0)
	local var_66_0 = {
		hero_id = arg_66_0,
		astrolabe_id_list = {}
	}

	manager.net:SendWithLoadingNew(66004, var_66_0, 66005, var_0_0.OnAstrolabeUnloadAll)
end

function var_0_0.OnAstrolabeUnloadAll(arg_67_0, arg_67_1)
	if isSuccess(arg_67_0.result) then
		PolyhedronData:SetUseAstrolabe(arg_67_1.hero_id, arg_67_1.astrolabe_id_list)
	end

	manager.notify:CallUpdateFunc(ASTROLABE_UNLOAD, arg_67_0, arg_67_1)
end

function var_0_0.CheckNewRed(arg_68_0)
	if not SystemData:ServerSystemIsLocked(ViewConst.SYSTEM_ID.MATRIX) and PolyhedronData:GetIsNewRed() then
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_NEW_SECTION, 1, RedPointStyle.SHOW_NEW_TAG)
	else
		manager.redPoint:setTip(RedPointConst.POLYHEDRON_NEW_SECTION, 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

return var_0_0
