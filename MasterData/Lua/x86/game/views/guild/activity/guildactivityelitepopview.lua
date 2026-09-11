local GuildActivityElitePopView = class("GuildActivityElitePopView", ReduxView)

function GuildActivityElitePopView:UIName()
	return "UI/GuildActivityUI/GuildActivityElitePopUI"
end

function GuildActivityElitePopView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityElitePopView:OnCtor()
	return
end

function GuildActivityElitePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityElitePopView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.isBeginController_ = ControllerUtil.GetController(self.gameObject_.transform, "isBegin")
end

function GuildActivityElitePopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.giveupLockedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_ELITE_GRID_GIVEUP_CONFIRM"),
			OkCallback = function()
				GuildActivityAction.UnlockNode(self.params_.nodeId)
				self:Back()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_11_0 = GuildActivityData:GetNodeData(self.params_.nodeId)

		if var_11_0.occupied_num + var_11_0.processing_num >= 10 then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("ACTIVITY_CLUB_GRID_OCCUPY_MAX"),
				OkCallback = function()
					self:TipsOkCallBack()
				end
			})

			return
		end

		if GuildActivityData:GetMyOccupiedNum() >= GuildActivityData:GetMaxOccupyCount() then
			ShowMessageBox({
				ButtonType = "SingleBtn",
				isTop = true,
				content = GetTips("ACTIVITY_CLUB_SELF_OCCUPY_MAX"),
				OkCallback = function()
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
		GuildActivityAction.LockNode(self.params_.nodeId)
	end)
	self:AddBtnListener(self.goonBtn_, nil, function()
		self:Go("/sectionSelectHero", {
			section = self.nodeCfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_ACTIVITY,
			nodeId = self.nodeCfg_.id,
			activityID = ActivityConst.GUILD_ACTIVITY_START
		})
	end)
	self:AddBtnListener(self.giveupBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("ACTIVITY_CLUB_NORMAL_GRID_GIVEUP_CONFIRM"),
			OkCallback = function()
				self:TipsOkCallBack()
				GuildActivityAction.GiveUpNode(self.nodeCfg_.id)
				self:Back()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function GuildActivityElitePopView:TipsOkCallBack()
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

function GuildActivityElitePopView:AddEventListeners()
	self:RegistEventListener(UPDATE_GRIDS_DATA, function(arg_21_0)
		if table.indexof(arg_21_0, self.params_.nodeId) then
			self:UpdateView()
			self:UpdateTimer()
		end
	end)
end

function GuildActivityElitePopView:OnTop()
	self:UpdateBar()
end

function GuildActivityElitePopView:OnBehind()
	return
end

function GuildActivityElitePopView:UpdateBar()
	return
end

function GuildActivityElitePopView:OnEnter()
	self:AddEventListeners()

	self.nodeCfg_ = ActivityClubCfg[self.params_.nodeId]

	self:UpdateView()
	self:StartTimer()
	self:UpdateTimer()
end

function GuildActivityElitePopView:OnExit()
	self:RemoveAllEventListener()
	self:StopTimer()

	if self.delayTimer_ then
		self.delayTimer_:Stop()
	end
end

function GuildActivityElitePopView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function GuildActivityElitePopView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivityElitePopView:UpdateTimer()
	local var_30_0 = GuildActivityData:GetSelfNodeData(self.params_.nodeId)

	if var_30_0 ~= nil then
		local var_30_1 = manager.time:GetServerTime()

		if var_30_0.processing_type == 3 and var_30_0.processing_timestamp > 0 and var_30_1 < var_30_0.processing_timestamp then
			SetActive(self.countdownLabel_.gameObject, true)

			self.countdownLabel_.text = manager.time:DescCDTime(var_30_0.processing_timestamp - var_30_1)
		else
			SetActive(self.countdownLabel_.gameObject, false)
		end
	else
		SetActive(self.countdownLabel_.gameObject, false)
	end
end

function GuildActivityElitePopView:UpdateView()
	local var_31_0 = GuildActivityData:GetNodeData(self.params_.nodeId)

	self.titleLabel_.text = GetI18NText(BattleClubActivityCfg[self.nodeCfg_.stage_id].name)
	self.levelLabel_.text = "Lv." .. self.nodeCfg_.level
	self.recoverLabel_.text = "+" .. GetI18NText(self.nodeCfg_.token_get)

	local var_31_1 = 10 - var_31_0.history_occupied_num

	if 10 - var_31_0.history_occupied_num < 1 then
		var_31_1 = 1
	end

	self.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(var_31_1))
	self.difficultyReduceLabel_.text = tostring(100 - var_31_1 * 10) .. "%"
	self.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_ATTACK_DESC"), var_31_0.occupied_num, var_31_0.processing_num)
	self.energyCostLabel_.text = self.nodeCfg_.vitality_cost

	if GuildActivityData:IsMyOccupiedNode(self.params_.nodeId) then
		self.statusController_:SetSelectedState("occupied")
		self.isBeginController_:SetSelectedState("false")
	else
		local var_31_2 = GuildActivityData:GetSelfNodeData(self.params_.nodeId)

		if var_31_2 ~= nil and var_31_2.processing_timestamp > 0 and manager.time:GetServerTime() < var_31_2.processing_timestamp then
			self.statusController_:SetSelectedState("continue")
		elseif var_31_0.occupied_num + var_31_0.processing_num >= 10 then
			self.statusController_:SetSelectedState("full")
		elseif GuildActivityData:IsNodeCanReach(self.params_.nodeId) then
			self.statusController_:SetSelectedState("unoccupy")
		else
			self.statusController_:SetSelectedState("unreach")
		end

		if var_31_2 then
			self.isBeginController_:SetSelectedState("true")

			local var_31_3 = math.floor(100 - var_31_2.elite_health_rate)

			self.attackingProgressLabel_.text = tostring(var_31_3) .. "%"
			self.progressImage_.fillAmount = var_31_3 / 100
		else
			self.isBeginController_:SetSelectedState("false")

			self.attackingProgressLabel_.text = "0%"
			self.progressImage_.fillAmount = 0
		end
	end
end

function GuildActivityElitePopView:OnMainHomeViewTop()
	return
end

function GuildActivityElitePopView:Dispose()
	GuildActivityElitePopView.super.Dispose(self)
end

return GuildActivityElitePopView
