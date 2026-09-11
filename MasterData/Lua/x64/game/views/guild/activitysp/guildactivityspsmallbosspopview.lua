local GuildActivitySPSmallBossPopView = class("GuildActivitySPSmallBossPopView", ReduxView)

function GuildActivitySPSmallBossPopView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPSmallBossPopUI"
end

function GuildActivitySPSmallBossPopView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPSmallBossPopView:OnCtor()
	return
end

function GuildActivitySPSmallBossPopView:Init()
	self.queryRankHandler_ = handler(self, self.OnQueryRank)

	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPSmallBossPopView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.finalReachableController_ = ControllerUtil.GetController(self.gameObject_.transform, "finalReachable")
end

function GuildActivitySPSmallBossPopView:AddUIListener()
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
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_10_0

		if GuildActivitySPData:GetNodeData(self.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function()
					self:UpdateView()
				end
			})

			do return end

			var_10_0 = {
				section = self.nodeCfg_.stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
				nodeId = self.nodeCfg_.id
			}
		end

		var_10_0.activityID = GuildActivitySPData:GetCurRunActivityID()

		self:Go("/sectionSelectHero", var_10_0)
	end)
	self:AddBtnListener(self.bossInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("bossInfo", {
			bossID = self.nodeCfg_.boss_id,
			spritePath = SpritePathCfg.CollectBoss.path .. self.nodeCfg_.boss_id
		})
	end)
end

function GuildActivitySPSmallBossPopView:AddEventListeners()
	self:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function(arg_14_0)
		if table.indexof(arg_14_0, self.params_.nodeId) then
			self:UpdateView()
		end
	end)
end

function GuildActivitySPSmallBossPopView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPSmallBossPopView:OnBehind()
	return
end

function GuildActivitySPSmallBossPopView:UpdateBar()
	return
end

function GuildActivitySPSmallBossPopView:OnEnter()
	self:AddEventListeners()

	self.nodeCfg_ = ActivityClubSPCfg[self.params_.nodeId]

	self:UpdateView()
end

function GuildActivitySPSmallBossPopView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPSmallBossPopView:UpdateView()
	self.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_BOSS_FIRST_BONUS_DESC"))

	local var_20_0 = GuildActivitySPData:GetNodeData(self.params_.nodeId)

	self.titleLabel_.text = BattleClubActivitySPCfg[self.nodeCfg_.stage_id].name
	self.hpLabel_.text = string.format("%d/%d", var_20_0.health, self.nodeCfg_.boss_score)
	self.hpProgressBar_.value = var_20_0.health / self.nodeCfg_.boss_score
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

	local var_20_1 = GuildActivitySPData:IsNodeCanReach(self.params_.nodeId)

	if var_20_0.health <= 0 then
		self.statusController_:SetSelectedState("win")
	elseif var_20_1 then
		self.statusController_:SetSelectedState("occupy")
	else
		self.statusController_:SetSelectedState("unreachable")
	end
end

function GuildActivitySPSmallBossPopView:OnMainHomeViewTop()
	return
end

function GuildActivitySPSmallBossPopView:Dispose()
	GuildActivitySPSmallBossPopView.super.Dispose(self)
end

function GuildActivitySPSmallBossPopView:OnQueryRank()
	JumpTools.OpenPageByJump("guildActivitySPRank")
end

return GuildActivitySPSmallBossPopView
