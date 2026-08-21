local var_0_0 = class("GuildActivitySPBossPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPBossPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0.queryRankHandler_ = handler(arg_4_0, arg_4_0.OnQueryRank)

	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "status")
	arg_5_0.finalReachableController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "finalReachable")
	arg_5_0.boss_statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "boss_status")
	arg_5_0.affixrScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.indexAffix), arg_5_0.affixUiList, GuildActivitySpAffixItem)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.recordBtn_, nil, function()
		GuildActivitySPAction.GetFightRecord(arg_6_0.params_.nodeId, function(arg_9_0)
			JumpTools.OpenPageByJump("guildActivitySPRecord", {
				dataList = arg_9_0
			})
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.challengeBtn_, nil, function()
		local var_10_0 = GuildActivitySPData:GetCurRunActivityID()

		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = var_10_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		if arg_6_0.params_.nodeId ~= GuildActivitySPData:GetMaxNodeId() and GuildActivitySPData:GetNodeData(arg_6_0.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function()
					arg_6_0:UpdateView()
				end
			})

			return
		end

		local var_11_0 = GuildActivitySPData:GetCurRunActivityID()

		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = var_11_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.nextFloorBtn_, nil, function()
		local var_13_0 = arg_6_0.nodeCfg_.map_id
		local var_13_1 = GuildActivitySPData:GetCurRunActivityID()
		local var_13_2 = ActivityClubSPMapCfg.get_id_list_by_activity[var_13_1]

		if table.indexof(var_13_2, var_13_0) < #GuildActivitySPData:GetSpawnIdList() then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_ENTER_NEW_LEVEL)
		else
			GuildActivitySPAction.EnterNext(arg_6_0.nodeCfg_.id)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bossInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("bossInfo", {
			bossID = arg_6_0.nodeCfg_.boss_id,
			spritePath = SpritePathCfg.CollectBoss.path .. arg_6_0.nodeCfg_.boss_id
		})
	end)
end

function var_0_0.AddEventListeners(arg_15_0)
	arg_15_0:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function(arg_16_0)
		if table.indexof(arg_16_0, arg_15_0.params_.nodeId) then
			arg_15_0:UpdateView()
		end
	end)
end

function var_0_0.OnTop(arg_17_0)
	arg_17_0:UpdateBar()
end

function var_0_0.OnBehind(arg_18_0)
	return
end

function var_0_0.UpdateBar(arg_19_0)
	return
end

function var_0_0.StopTimer(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_21_0)
	local var_21_0 = manager.time:GetServerTime()
	local var_21_1 = GuildActivitySPData:GetCurRunActivityID()
	local var_21_2 = ActivityData:GetActivityData(var_21_1)
	local var_21_3 = var_21_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
	local var_21_4 = var_21_2.stopTime
	local var_21_5 = BattleClubActivitySPCfg[arg_21_0.nodeCfg_.stage_id].affix_type

	if var_21_3 < var_21_0 then
		arg_21_0.stageLevel = 2
	else
		arg_21_0.stageLevel = 1
	end

	if var_21_5 and var_21_5 ~= "" then
		if arg_21_0.nodeCfg_.id == GuildActivitySPData:GetMaxNodeId() then
			if arg_21_0.stageLevel == 2 then
				arg_21_0.boss_statusController_:SetSelectedIndex(1)
			else
				arg_21_0.boss_statusController_:SetSelectedIndex(0)
			end
		else
			arg_21_0.boss_statusController_:SetSelectedIndex(2)
		end
	else
		arg_21_0.boss_statusController_:SetSelectedIndex(2)
	end
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0:AddEventListeners()

	arg_22_0.nodeCfg_ = ActivityClubSPCfg[arg_22_0.params_.nodeId]

	arg_22_0:UpdateTimer()
	arg_22_0:UpdateView()
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:RemoveAllEventListener()
	arg_23_0:StopTimer()
end

function var_0_0.UpdateView(arg_24_0)
	arg_24_0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_BOSS_FIRST_BONUS_DESC"))

	local var_24_0 = GuildActivitySPData:GetNodeData(arg_24_0.params_.nodeId)
	local var_24_1 = arg_24_0.nodeCfg_.map_id
	local var_24_2 = GuildActivitySPData:GetCurRunActivityID()
	local var_24_3 = ActivityClubSPMapCfg.get_id_list_by_activity[var_24_2]
	local var_24_4 = table.indexof(var_24_3, var_24_1)

	arg_24_0.titleLabel_.text = BattleClubActivitySPCfg[arg_24_0.nodeCfg_.stage_id].name

	local var_24_5 = arg_24_0.nodeCfg_.boss_score
	local var_24_6 = var_24_0.health

	arg_24_0.hpLabel_.text = string.format("%d/%d", var_24_6, var_24_5)

	local var_24_7 = var_24_6 / var_24_5

	arg_24_0.hpProgressBar_.value = var_24_7
	arg_24_0.bossNameLabel_.text = GetMonsterName({
		arg_24_0.nodeCfg_.boss_id
	})
	arg_24_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. arg_24_0.nodeCfg_.boss_id)
	arg_24_0.costLabel_.text = arg_24_0.nodeCfg_.vitality_cost

	local var_24_8 = GuildActivitySPData:GetCurMainActivityID()
	local var_24_9 = BattleClubActivitySPCfg[arg_24_0.nodeCfg_.stage_id].drop_lib_id

	if var_24_9 ~= nil and var_24_9 > 0 then
		local var_24_10 = DropCfg[var_24_9].base_drop[1]

		arg_24_0.nodeRewardImg.sprite = ItemTools.getItemSprite(var_24_10[1])
		arg_24_0.firstRecoverLabel_.text = var_24_10[2]
	else
		arg_24_0.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_24_8, 2))
		arg_24_0.firstRecoverLabel_.text = ""
	end

	local var_24_11 = GuildActivitySPData:IsNodeCanReach(arg_24_0.params_.nodeId)

	if GuildActivitySPData:IsAllLittleBossPass(var_24_1) == 0 then
		arg_24_0.statusController_:SetSelectedState("lock")
	elseif var_24_0.health <= 0 then
		if arg_24_0.params_.nodeId == GuildActivitySPData:GetMaxNodeId() then
			if var_24_11 then
				arg_24_0.statusController_:SetSelectedState("occupy")
				arg_24_0.finalReachableController_:SetSelectedState("true")
			else
				arg_24_0.statusController_:SetSelectedState("unreachable")
				arg_24_0.finalReachableController_:SetSelectedState("false")
			end
		else
			arg_24_0.statusController_:SetSelectedState("value_5")
		end
	elseif var_24_11 then
		arg_24_0.statusController_:SetSelectedState("occupy")
	else
		arg_24_0.statusController_:SetSelectedState("unreachable")
	end

	arg_24_0:RefreshAffixType()
end

function var_0_0.OnMainHomeViewTop(arg_25_0)
	return
end

function var_0_0.RefreshAffixType(arg_26_0)
	arg_26_0:UpdateTimer()

	local var_26_0 = BattleClubActivitySPCfg[arg_26_0.nodeCfg_.stage_id].affix_type

	arg_26_0.affixList = {}

	if var_26_0 ~= nil and var_26_0 ~= "" then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			table.insert(arg_26_0.affixList, iter_26_1)
		end

		arg_26_0.affixrScroll_:StartScroll(#arg_26_0.affixList)
	else
		arg_26_0.affixrScroll_:StartScroll(0)
	end
end

function var_0_0.indexAffix(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2:SetClickCallBack(handler(arg_27_0, function(arg_28_0)
		local var_28_0 = BattleClubActivitySPCfg[arg_27_0.nodeCfg_.stage_id].affix_type

		if var_28_0 == nil or var_28_0 == "" then
			return
		end

		JumpTools.OpenPageByJump("affixDetail", {
			affixList = var_28_0
		})
	end))

	if arg_27_0.stageLevel == 2 then
		arg_27_2:RefreshUI(arg_27_0.affixList[arg_27_1], true)
	else
		arg_27_2:RefreshUI(arg_27_0.affixList[arg_27_1], false)
	end
end

function var_0_0.Dispose(arg_29_0)
	if arg_29_0.affixrScroll_ then
		arg_29_0.affixrScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_29_0)
end

function var_0_0.OnQueryRank(arg_30_0)
	JumpTools.OpenPageByJump("guildActivitySPRank")
end

return var_0_0
