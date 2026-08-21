local var_0_0 = class("GuildActivitySPSmallBossPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPSmallBossPopUI"
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
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		if GuildActivitySPData:GetNodeData(arg_6_0.nodeCfg_.id).health <= 0 then
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

		local var_10_0 = GuildActivitySPData:GetCurRunActivityID()

		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = var_10_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.bossInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("bossInfo", {
			bossID = arg_6_0.nodeCfg_.boss_id,
			spritePath = SpritePathCfg.CollectBoss.path .. arg_6_0.nodeCfg_.boss_id
		})
	end)
end

function var_0_0.AddEventListeners(arg_13_0)
	arg_13_0:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function(arg_14_0)
		if table.indexof(arg_14_0, arg_13_0.params_.nodeId) then
			arg_13_0:UpdateView()
		end
	end)
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:UpdateBar()
end

function var_0_0.OnBehind(arg_16_0)
	return
end

function var_0_0.UpdateBar(arg_17_0)
	return
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:AddEventListeners()

	arg_18_0.nodeCfg_ = ActivityClubSPCfg[arg_18_0.params_.nodeId]

	arg_18_0:UpdateView()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveAllEventListener()
end

function var_0_0.UpdateView(arg_20_0)
	arg_20_0.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_BOSS_FIRST_BONUS_DESC"))

	local var_20_0 = GuildActivitySPData:GetNodeData(arg_20_0.params_.nodeId)

	arg_20_0.titleLabel_.text = BattleClubActivitySPCfg[arg_20_0.nodeCfg_.stage_id].name

	local var_20_1 = arg_20_0.nodeCfg_.boss_score
	local var_20_2 = var_20_0.health

	arg_20_0.hpLabel_.text = string.format("%d/%d", var_20_2, var_20_1)

	local var_20_3 = var_20_2 / var_20_1

	arg_20_0.hpProgressBar_.value = var_20_3
	arg_20_0.bossNameLabel_.text = GetMonsterName({
		arg_20_0.nodeCfg_.boss_id
	})
	arg_20_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. arg_20_0.nodeCfg_.boss_id)

	local var_20_4 = GuildActivitySPData:GetCurMainActivityID()

	arg_20_0.costLabel_.text = arg_20_0.nodeCfg_.vitality_cost

	local var_20_5 = BattleClubActivitySPCfg[arg_20_0.nodeCfg_.stage_id].drop_lib_id

	if var_20_5 ~= nil and var_20_5 > 0 then
		local var_20_6 = DropCfg[var_20_5].base_drop[1]

		arg_20_0.nodeRewardImg.sprite = ItemTools.getItemSprite(var_20_6[1])
		arg_20_0.firstRecoverLabel_.text = var_20_6[2]
	else
		arg_20_0.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_20_4, 2))
		arg_20_0.firstRecoverLabel_.text = ""
	end

	local var_20_7 = GuildActivitySPData:IsNodeCanReach(arg_20_0.params_.nodeId)

	if var_20_0.health <= 0 then
		arg_20_0.statusController_:SetSelectedState("win")
	elseif var_20_7 then
		arg_20_0.statusController_:SetSelectedState("occupy")
	else
		arg_20_0.statusController_:SetSelectedState("unreachable")
	end
end

function var_0_0.OnMainHomeViewTop(arg_21_0)
	return
end

function var_0_0.Dispose(arg_22_0)
	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.OnQueryRank(arg_23_0)
	JumpTools.OpenPageByJump("guildActivitySPRank")
end

return var_0_0
