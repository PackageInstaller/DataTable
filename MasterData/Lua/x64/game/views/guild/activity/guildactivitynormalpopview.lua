local GuildActivityNormalPopView = class("GuildActivityNormalPopView", ReduxView)

function GuildActivityNormalPopView:UIName()
	return "UI/GuildActivityUI/GuildActivityNormalPopUI"
end

function GuildActivityNormalPopView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildActivityNormalPopView:OnCtor()
	return
end

function GuildActivityNormalPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildActivityNormalPopView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
end

function GuildActivityNormalPopView:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_8_0 = GuildActivityData:GetNodeData(self.params_.nodeId)

		if var_8_0.occupied_num + var_8_0.processing_num >= 10 then
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

function GuildActivityNormalPopView:TipsOkCallBack()
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

function GuildActivityNormalPopView:AddEventListeners()
	self:RegistEventListener(UPDATE_GRIDS_DATA, function(arg_17_0)
		if table.indexof(arg_17_0, self.params_.nodeId) then
			self:UpdateView()
		end
	end)
end

function GuildActivityNormalPopView:OnTop()
	self:UpdateBar()
end

function GuildActivityNormalPopView:OnBehind()
	return
end

function GuildActivityNormalPopView:UpdateBar()
	return
end

function GuildActivityNormalPopView:OnEnter()
	self:AddEventListeners()

	self.nodeCfg_ = ActivityClubCfg[self.params_.nodeId]

	self:UpdateView()
end

function GuildActivityNormalPopView:OnExit()
	self:RemoveAllEventListener()

	if self.delayTimer_ then
		self.delayTimer_:Stop()
	end
end

function GuildActivityNormalPopView:UpdateView()
	local var_23_0 = GuildActivityData:GetNodeData(self.params_.nodeId)

	self.titleLabel_.text = GetI18NText(BattleClubActivityCfg[self.nodeCfg_.stage_id].name)
	self.levelLabel_.text = "Lv." .. self.nodeCfg_.level
	self.cdLabel_.text = "+" .. GetI18NText(self.nodeCfg_.token_get)

	local var_23_1 = 10 - var_23_0.history_occupied_num

	if 10 - var_23_0.history_occupied_num < 1 then
		var_23_1 = 1
	end

	self.dangerousLabel_.text = string.format(GetTips("ACTIVITY_CLUB_DANGEROUS_DESC"), tostring(var_23_1))
	self.difficultyReduceLabel_.text = tostring(100 - var_23_1 * 10) .. "%"
	self.detailLabel_.text = string.format(GetTips("ACTIVITY_CLUB_ATTACK_DESC"), var_23_0.occupied_num, var_23_0.processing_num)
	self.energyCostLabel_.text = self.nodeCfg_.vitality_cost

	if GuildActivityData:IsMyOccupiedNode(self.params_.nodeId) then
		self.statusController_:SetSelectedState("occupied")
	elseif var_23_0.occupied_num + var_23_0.processing_num >= 10 then
		self.statusController_:SetSelectedState("full")
	elseif GuildActivityData:IsNodeCanReach(self.params_.nodeId) then
		self.statusController_:SetSelectedState("unoccupy")
	else
		self.statusController_:SetSelectedState("unreach")
	end
end

function GuildActivityNormalPopView:OnMainHomeViewTop()
	return
end

function GuildActivityNormalPopView:Dispose()
	GuildActivityNormalPopView.super.Dispose(self)
end

return GuildActivityNormalPopView
