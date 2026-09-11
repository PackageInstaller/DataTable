local GuildActivitySPElitePopView = class("GuildActivitySPElitePopView", ReduxView)

function GuildActivitySPElitePopView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPElitePopUI"
end

function GuildActivitySPElitePopView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivitySPElitePopView:OnCtor()
	return
end

function GuildActivitySPElitePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivitySPElitePopView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.isBeginController_ = ControllerUtil.GetController(self.gameObject_.transform, "isBegin")
end

function GuildActivitySPElitePopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.goonBtn_, nil, function()
		self:Back()
		JumpTools.OpenPageByJump("guildActivitySPDispatch", {
			nodeId = self.params_.nodeId
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = self.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY_SP,
			nodeId = self.nodeCfg_.id,
			activityID = GuildActivitySPData:GetCurRunActivityID()
		})
	end)
	self:AddBtnListener(self.giveupBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_SP_CANCEL_DISPATCH_CONFIRM_TIP"),
			OkCallback = function()
				GuildActivitySPAction.CancelDispatch(self.nodeCfg_.id)
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function GuildActivitySPElitePopView:AddEventListeners()
	self:RegistEventListener(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, function(arg_14_0)
		if table.indexof(arg_14_0, self.params_.nodeId) then
			self:UpdateView()
		end
	end)
	self:RegistEventListener(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, function(arg_15_0)
		if arg_15_0 == self.params_.id then
			self:Back()
		end
	end)
end

function GuildActivitySPElitePopView:OnTop()
	self:UpdateBar()
end

function GuildActivitySPElitePopView:OnBehind()
	return
end

function GuildActivitySPElitePopView:UpdateBar()
	return
end

function GuildActivitySPElitePopView:OnEnter()
	self:AddEventListeners()

	self.nodeCfg_ = ActivityClubSPCfg[self.params_.nodeId]

	self:UpdateView()
end

function GuildActivitySPElitePopView:OnExit()
	self:RemoveAllEventListener()
end

function GuildActivitySPElitePopView:UpdateView()
	local var_21_0 = GuildActivitySPData:GetNodeData(self.params_.nodeId)

	self.titleLabel_.text = BattleClubActivitySPCfg[self.nodeCfg_.stage_id].name
	self.levelLabel_.text = "Lv." .. self.nodeCfg_.level

	local var_21_1 = GuildActivitySPData:GetCurMainActivityID()

	self.recoverImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_21_1, 1))
	self.recoverLabel_.text = "+" .. self.nodeCfg_.token_get

	local var_21_2 = 10 - var_21_0.occupied_num

	if 10 - var_21_0.occupied_num < 1 then
		var_21_2 = 1
	end

	self.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(var_21_2))
	self.difficultyReduceLabel_.text = tostring(100 - var_21_2 * 10) .. "%"
	self.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_FIRST_BONUS_DESC"))
	self.nodeRewardImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_21_1, 2))
	self.firstRecoverLabel_.text = BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id ~= nil and BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id > 0 and DropCfg[BattleClubActivitySPCfg[self.nodeCfg_.stage_id].drop_lib_id].base_drop[1][2] or "0"
	self.energyCostLabel_.text = self.nodeCfg_.vitality_cost
	self.informationLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_DISPATCH_INFO_TIP"), var_21_0.dispatch_num, 10)

	if GuildActivitySPData:IsMyOccupiedNode(self.params_.nodeId) then
		if GuildActivitySPData:IsDispatched(self.params_.nodeId) then
			self.statusController_:SetSelectedState("cancel")

			local var_21_3 = GuildActivitySPData:GetSelfNodeData(self.params_.nodeId)
		elseif GuildActivitySPData:IsDispatchMax(self.params_.nodeId) then
			self.statusController_:SetSelectedState("upper_limit")
		else
			self.statusController_:SetSelectedState("dispatch")
		end

		self.isBeginController_:SetSelectedState("false")
	else
		local var_21_4 = GuildActivitySPData:GetSelfNodeData(self.params_.nodeId)

		if GuildActivitySPData:IsNodeCanReach(self.params_.nodeId) then
			self.statusController_:SetSelectedState("occupy")
		else
			self.statusController_:SetSelectedState("unreachable")
		end

		if var_21_4 then
			self.isBeginController_:SetSelectedState("true")

			local var_21_5 = math.floor(100 - var_21_4.elite_health_rate)

			self.attackingProgressLabel_.text = tostring(var_21_5) .. "%"
			self.progressImage_.fillAmount = var_21_5 / 100
			self.slider_.value = var_21_5 / 100
		else
			self.isBeginController_:SetSelectedState("false")

			self.attackingProgressLabel_.text = "0%"
			self.progressImage_.fillAmount = 0
			self.slider_.value = 0
		end
	end
end

function GuildActivitySPElitePopView:OnMainHomeViewTop()
	return
end

function GuildActivitySPElitePopView:Dispose()
	GuildActivitySPElitePopView.super.Dispose(self)
end

return GuildActivitySPElitePopView
