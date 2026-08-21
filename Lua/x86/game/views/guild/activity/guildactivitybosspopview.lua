local var_0_0 = class("GuildActivityBossPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityBossPopUI"
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
	arg_6_0:AddBtnListener(arg_6_0.rankBtn_, nil, function()
		GuildActivityAction.QueryRankList(arg_6_0.params_.nodeId, arg_6_0.queryRankHandler_)
	end)
	arg_6_0:AddBtnListener(arg_6_0.recordBtn_, nil, function()
		GuildActivityAction.GetFightRecord(arg_6_0.params_.nodeId, function(arg_10_0)
			JumpTools.OpenPageByJump("guildActivityRecord", {
				dataList = arg_10_0
			})
		end)
	end)
	arg_6_0:AddBtnListener(arg_6_0.challengeBtn_, nil, function()
		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.goBtn_, nil, function()
		if GuildActivityData:GetNodeData(arg_6_0.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function()
					arg_6_0:UpdateView()
					arg_6_0:TipsOkCallBack()
				end
			})

			return
		end

		arg_6_0:Go("/sectionSelectHero", {
			section = arg_6_0.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = arg_6_0.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.nextFloorBtn_, nil, function()
		local var_14_0 = arg_6_0.nodeCfg_.map_id

		if table.indexof(ActivityClubMapCfg.all, var_14_0) < #GuildActivityData:GetSpawnIdList() then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_NEW_LEVEL)
		else
			GuildActivityAction.EnterNext(arg_6_0.nodeCfg_.id)
		end
	end)
end

function var_0_0.TipsOkCallBack(arg_15_0)
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	if arg_15_0.delayTimer_ then
		arg_15_0.delayTimer_:Stop()
	end

	arg_15_0.delayTimer_ = FrameTimer.New(function()
		GuildActivityLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	end, 1, 1)

	arg_15_0.delayTimer_:Start()
end

function var_0_0.AddEventListeners(arg_17_0)
	arg_17_0:RegistEventListener(UPDATE_GRIDS_DATA, function(arg_18_0)
		if table.indexof(arg_18_0, arg_17_0.params_.nodeId) then
			arg_17_0:UpdateView()
		end
	end)
end

function var_0_0.OnTop(arg_19_0)
	arg_19_0:UpdateBar()
end

function var_0_0.OnBehind(arg_20_0)
	return
end

function var_0_0.UpdateBar(arg_21_0)
	return
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0:AddEventListeners()

	arg_22_0.nodeCfg_ = ActivityClubCfg[arg_22_0.params_.nodeId]

	arg_22_0:UpdateView()
end

function var_0_0.OnExit(arg_23_0)
	arg_23_0:RemoveAllEventListener()

	if arg_23_0.delayTimer_ then
		arg_23_0.delayTimer_:Stop()
	end
end

function var_0_0.UpdateView(arg_24_0)
	local var_24_0 = GuildActivityData:GetNodeData(arg_24_0.params_.nodeId)
	local var_24_1 = arg_24_0.nodeCfg_.map_id
	local var_24_2 = table.indexof(ActivityClubMapCfg.all, var_24_1)

	arg_24_0.titleLabel_.text = GetI18NText(BattleClubActivityCfg[arg_24_0.nodeCfg_.stage_id].name)

	local var_24_3 = arg_24_0.nodeCfg_.boss_score
	local var_24_4 = var_24_0.health

	arg_24_0.hpLabel_.text = string.format("%d/%d", var_24_4, var_24_3)

	local var_24_5 = var_24_4 / var_24_3

	arg_24_0.hpProgressBar_.value = var_24_5
	arg_24_0.bossNameLabel_.text = GetI18NText(arg_24_0.nodeCfg_.boss_name)
	arg_24_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.ActivityClubBossHeadIcon.path .. arg_24_0.nodeCfg_.boss_icon)
	arg_24_0.costLabel_.text = arg_24_0.nodeCfg_.vitality_cost

	local var_24_6 = GuildActivityData:IsNodeCanReach(arg_24_0.params_.nodeId)

	if var_24_0.health <= 0 then
		if arg_24_0.params_.nodeId == GuildActivityData:GetMaxNodeId() then
			arg_24_0.statusController_:SetSelectedState("finalLevel")

			if var_24_6 then
				arg_24_0.finalReachableController_:SetSelectedState("true")
			else
				arg_24_0.finalReachableController_:SetSelectedState("false")
			end
		else
			arg_24_0.statusController_:SetSelectedState("nextLevel")
		end
	elseif var_24_6 then
		arg_24_0.statusController_:SetSelectedState("alive")
	else
		arg_24_0.statusController_:SetSelectedState("unreach")
	end
end

function var_0_0.OnMainHomeViewTop(arg_25_0)
	return
end

function var_0_0.Dispose(arg_26_0)
	var_0_0.super.Dispose(arg_26_0)
end

function var_0_0.OnQueryRank(arg_27_0)
	JumpTools.OpenPageByJump("guildActivityRank")
end

return var_0_0
