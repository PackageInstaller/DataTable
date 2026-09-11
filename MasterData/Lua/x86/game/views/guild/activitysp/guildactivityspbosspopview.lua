local GuildActivitySPBossPopView = class("GuildActivitySPBossPopView", ReduxView)

function GuildActivitySPBossPopView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPBossPopUI"
end

function GuildActivitySPBossPopView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPBossPopView:OnCtor()
	return
end

function GuildActivitySPBossPopView:Init()
	self.queryRankHandler_ = handler(self, self.OnQueryRank)

	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPBossPopView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.finalReachableController_ = ControllerUtil.GetController(self.gameObject_.transform, "finalReachable")
	self.boss_statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "boss_status")
	self.affixrScroll_ = LuaList.New(handler(self, self.indexAffix), self.affixUiList, GuildActivitySpAffixItem)
end

function GuildActivitySPBossPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		GuildActivitySPAction.GetFightRecord(self.params_.nodeId, function(arg_9_0)
			JumpTools.OpenPageByJump("guildActivitySPRecord", {
				dataList = arg_9_0
			})
		end)
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = self.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = self.nodeCfg_.id,
			activityID = GuildActivitySPData:GetCurRunActivityID()
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_11_0

		if self.params_.nodeId ~= GuildActivitySPData:GetMaxNodeId() and GuildActivitySPData:GetNodeData(self.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function()
					self:UpdateView()
				end
			})

			do return end

			var_11_0 = {
				section = self.nodeCfg_.stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
				nodeId = self.nodeCfg_.id
			}
		end

		var_11_0.activityID = GuildActivitySPData:GetCurRunActivityID()

		self:Go("/sectionSelectHero", var_11_0)
	end)
	self:AddBtnListener(self.nextFloorBtn_, nil, function()
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], self.nodeCfg_.map_id) < #GuildActivitySPData:GetSpawnIdList() then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_SP_ENTER_NEW_LEVEL)
		else
			GuildActivitySPAction.EnterNext(self.nodeCfg_.id)
		end
	end)
	self:AddBtnListener(self.bossInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("bossInfo", {
			bossID = self.nodeCfg_.boss_id,
			spritePath = SpritePathCfg.CollectBoss.path .. self.nodeCfg_.boss_id
		})
	end)
end

function GuildActivitySPBossPopView:AddEventListeners()
	self:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function(arg_16_0)
		if table.indexof(arg_16_0, self.params_.nodeId) then
			self:UpdateView()
		end
	end)
end

function GuildActivitySPBossPopView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPBossPopView:OnBehind()
	return
end

function GuildActivitySPBossPopView:UpdateBar()
	return
end

function GuildActivitySPBossPopView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivitySPBossPopView:UpdateTimer()
	local var_21_2 = BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type

	self.stageLevel = ActivityData:GetActivityData((GuildActivitySPData:GetCurRunActivityID())).startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() and 2 or 1

	if var_21_2 and var_21_2 ~= "" then
		if self.nodeCfg_.id == GuildActivitySPData:GetMaxNodeId() then
			if self.stageLevel == 2 then
				self.boss_statusController_:SetSelectedIndex(1)
			else
				self.boss_statusController_:SetSelectedIndex(0)
			end
		else
			self.boss_statusController_:SetSelectedIndex(2)
		end
	else
		self.boss_statusController_:SetSelectedIndex(2)
	end
end

function GuildActivitySPBossPopView:OnEnter()
	self:AddEventListeners()

	self.nodeCfg_ = ActivityClubSPCfg[self.params_.nodeId]

	self:UpdateTimer()
	self:UpdateView()
end

function GuildActivitySPBossPopView:OnExit()
	self:RemoveAllEventListener()
	self:StopTimer()
end

function GuildActivitySPBossPopView:UpdateView()
	self.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_BOSS_FIRST_BONUS_DESC"))

	local var_24_0 = GuildActivitySPData:GetNodeData(self.params_.nodeId)
	local var_24_1 = self.nodeCfg_.map_id
	local var_24_2 = table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], self.nodeCfg_.map_id)

	self.titleLabel_.text = BattleClubActivitySPCfg[self.nodeCfg_.stage_id].name
	self.hpLabel_.text = string.format("%d/%d", var_24_0.health, self.nodeCfg_.boss_score)
	self.hpProgressBar_.value = var_24_0.health / self.nodeCfg_.boss_score
	self.bossNameLabel_.text = GetMonsterName({
		self.nodeCfg_.boss_id
	})
	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. self.nodeCfg_.boss_id)
	self.costLabel_.text = self.nodeCfg_.vitality_cost

	if BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id ~= nil and BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id > 0 then
		self.nodeRewardImg.sprite = ItemTools.getItemSprite(DropCfg[BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id].base_drop[1][1])
		self.firstRecoverLabel_.text = DropCfg[BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id].base_drop[1][2]
	else
		self.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 2))
		self.firstRecoverLabel_.text = ""
	end

	local var_24_3 = GuildActivitySPData:IsNodeCanReach(self.params_.nodeId)

	if GuildActivitySPData:IsAllLittleBossPass(var_24_1) == 0 then
		self.statusController_:SetSelectedState("lock")
	elseif var_24_0.health <= 0 then
		if self.params_.nodeId == GuildActivitySPData:GetMaxNodeId() then
			if var_24_3 then
				self.statusController_:SetSelectedState("occupy")
				self.finalReachableController_:SetSelectedState("true")
			else
				self.statusController_:SetSelectedState("unreachable")
				self.finalReachableController_:SetSelectedState("false")
			end
		else
			self.statusController_:SetSelectedState("value_5")
		end
	elseif var_24_3 then
		self.statusController_:SetSelectedState("occupy")
	else
		self.statusController_:SetSelectedState("unreachable")
	end

	self:RefreshAffixType()
end

function GuildActivitySPBossPopView:OnMainHomeViewTop()
	return
end

function GuildActivitySPBossPopView:RefreshAffixType()
	self:UpdateTimer()

	self.affixList = {}

	if BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type ~= nil and BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type ~= "" then
		for iter_26_0, iter_26_1 in ipairs(BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type) do
			table.insert(self.affixList, iter_26_1)
		end

		self.affixrScroll_:StartScroll(#self.affixList)
	else
		self.affixrScroll_:StartScroll(0)
	end
end

function GuildActivitySPBossPopView:indexAffix(arg_27_1, arg_27_2)
	arg_27_2:SetClickCallBack(handler(self, function(arg_28_0)
		if BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type == nil or BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type == "" then
			return
		end

		JumpTools.OpenPageByJump("affixDetail", {
			affixList = BattleClubActivitySPCfg[self.nodeCfg_.stage_id].affix_type
		})
	end))

	if self.stageLevel == 2 then
		arg_27_2:RefreshUI(self.affixList[arg_27_1], true)
	else
		arg_27_2:RefreshUI(self.affixList[arg_27_1], false)
	end
end

function GuildActivitySPBossPopView:Dispose()
	if self.affixrScroll_ then
		self.affixrScroll_:Dispose()
	end

	GuildActivitySPBossPopView.super.Dispose(self)
end

function GuildActivitySPBossPopView:OnQueryRank()
	JumpTools.OpenPageByJump("guildActivitySPRank")
end

return GuildActivitySPBossPopView
