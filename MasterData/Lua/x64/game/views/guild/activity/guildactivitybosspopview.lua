local GuildActivityBossPopView = class("GuildActivityBossPopView", ReduxView)

function GuildActivityBossPopView:UIName()
	return "UI/GuildActivityUI/GuildActivityBossPopUI"
end

function GuildActivityBossPopView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityBossPopView:OnCtor()
	return
end

function GuildActivityBossPopView:Init()
	self.queryRankHandler_ = handler(self, self.OnQueryRank)

	self:InitUI()
	self:AddUIListener()
end

function GuildActivityBossPopView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.finalReachableController_ = ControllerUtil.GetController(self.gameObject_.transform, "finalReachable")
end

function GuildActivityBossPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		GuildActivityAction.QueryRankList(self.params_.nodeId, self.queryRankHandler_)
	end)
	self:AddBtnListener(self.recordBtn_, nil, function()
		GuildActivityAction.GetFightRecord(self.params_.nodeId, function(arg_10_0)
			JumpTools.OpenPageByJump("guildActivityRecord", {
				dataList = arg_10_0
			})
		end)
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = self.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = self.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		if GuildActivityData:GetNodeData(self.nodeCfg_.id).health <= 0 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("BOSS_BE_KILLED_TIP"),
				OkCallback = function()
					self:UpdateView()
					self:TipsOkCallBack()
				end
			})

			return
		end

		self:Go("/sectionSelectHero", {
			section = self.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = self.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	self:AddBtnListener(self.nextFloorBtn_, nil, function()
		if table.indexof(ActivityClubMapCfg.all, self.nodeCfg_.map_id) < #GuildActivityData:GetSpawnIdList() then
			manager.notify:CallUpdateFunc(GUILD_ACTIVITY_ENTER_NEW_LEVEL)
		else
			GuildActivityAction.EnterNext(self.nodeCfg_.id)
		end
	end)
end

function GuildActivityBossPopView:TipsOkCallBack()
	GuildActivityLuaBridge.GetManager():SetOnWarField(false)

	manager.ui.mainCameraCom_.orthographic = true

	if self.delayTimer_ then
		self.delayTimer_:Stop()
	end

	self.delayTimer_ = FrameTimer.New(function()
		GuildActivityLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityLuaBridge.GetManager():SetOnWarField(true)
	end, 1, 1)

	self.delayTimer_:Start()
end

function GuildActivityBossPopView:AddEventListeners()
	self:RegistEventListener(UPDATE_GRIDS_DATA, function(arg_18_0)
		if table.indexof(arg_18_0, self.params_.nodeId) then
			self:UpdateView()
		end
	end)
end

function GuildActivityBossPopView:OnTop()
	self:UpdateBar()
end

function GuildActivityBossPopView:OnBehind()
	return
end

function GuildActivityBossPopView:UpdateBar()
	return
end

function GuildActivityBossPopView:OnEnter()
	self:AddEventListeners()

	self.nodeCfg_ = ActivityClubCfg[self.params_.nodeId]

	self:UpdateView()
end

function GuildActivityBossPopView:OnExit()
	self:RemoveAllEventListener()

	if self.delayTimer_ then
		self.delayTimer_:Stop()
	end
end

function GuildActivityBossPopView:UpdateView()
	local var_24_0 = GuildActivityData:GetNodeData(self.params_.nodeId)
	local var_24_1 = table.indexof(ActivityClubMapCfg.all, self.nodeCfg_.map_id)

	self.titleLabel_.text = GetI18NText(BattleClubActivityCfg[self.nodeCfg_.stage_id].name)
	self.hpLabel_.text = string.format("%d/%d", var_24_0.health, self.nodeCfg_.boss_score)
	self.hpProgressBar_.value = var_24_0.health / self.nodeCfg_.boss_score
	self.bossNameLabel_.text = GetI18NText(self.nodeCfg_.boss_name)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.ActivityClubBossHeadIcon.path .. self.nodeCfg_.boss_icon)
	self.costLabel_.text = self.nodeCfg_.vitality_cost

	local var_24_2 = GuildActivityData:IsNodeCanReach(self.params_.nodeId)

	if var_24_0.health <= 0 then
		if self.params_.nodeId == GuildActivityData:GetMaxNodeId() then
			self.statusController_:SetSelectedState("finalLevel")

			if var_24_2 then
				self.finalReachableController_:SetSelectedState("true")
			else
				self.finalReachableController_:SetSelectedState("false")
			end
		else
			self.statusController_:SetSelectedState("nextLevel")
		end
	elseif var_24_2 then
		self.statusController_:SetSelectedState("alive")
	else
		self.statusController_:SetSelectedState("unreach")
	end
end

function GuildActivityBossPopView:OnMainHomeViewTop()
	return
end

function GuildActivityBossPopView:Dispose()
	GuildActivityBossPopView.super.Dispose(self)
end

function GuildActivityBossPopView:OnQueryRank()
	JumpTools.OpenPageByJump("guildActivityRank")
end

return GuildActivityBossPopView
