local ActivityInviteMainView = class("ActivityInviteMainView", ReduxView)

function ActivityInviteMainView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionInvitationUI"
end

function ActivityInviteMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityInviteMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityInviteMainView:InitUI()
	self:BindCfgUI()

	self.itemViewList = {}
	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, ActivityInviteHeadItem)
	self.drawController = ControllerUtil.GetController(self.drawGo_.transform, "state")
end

function ActivityInviteMainView:SetItem(arg_5_1, arg_5_2)
	arg_5_2:SetData({
		heroId = self.heroPlotList[arg_5_1][1].hero_id,
		image = self.heroPlotList[arg_5_1][1].hero_image_route
	}, arg_5_1, handler(self, self.SelectListener), self.selectIndex)
end

function ActivityInviteMainView:AddUIListener()
	local function var_6_0()
		if not InviteData:GetDataByPara("completeHeroTable")[self.heroPlotList[self.selectIndex][1].id] then
			InviteAction.CompletePlot(InviteData:GetDataByPara("activityId"), self.heroPlotList[self.selectIndex][1].id)
		end
	end

	self:AddBtnListener(self.drawBtn_, nil, function()
		JumpTools.GoToSystem("/draw", {
			poolId = InviteData:GetDataByPara("poolID")
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	self:AddBtnListener(self.inviteBtn_, nil, function()
		if self:SafeCheck() then
			self:Back()
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = self.selectIndex
			})

			return
		end

		if InviteData:GetDataByPara("inviteTimes") == 0 then
			ShowTips("ACTIVITY_INVITE_TIME_NOT_ENOUGH")

			return
		end

		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_INVITE_CONFIRM_TIPS"), (GetI18NText(HeroCfg[self.heroPlotList[self.selectIndex][1].hero_id].suffix))),
			OkCallback = var_6_0
		})
	end)
end

function ActivityInviteMainView:SelectListener(arg_10_1)
	if self.list:GetItemList()[arg_10_1]:GetFinishController():GetSelectedState() == "2" then
		self:Back()
		JumpTools.GoToSystem("/ActivityInviteRegionView", {
			selectIndex = arg_10_1
		})

		return
	end

	for iter_10_0, iter_10_1 in ipairs(self.list:GetItemList()) do
		if iter_10_1:GetFinishController() ~= "2" then
			self.selectIndex = arg_10_1

			iter_10_1:GetController():SetSelectedState(iter_10_0 == self.selectIndex and "true" or "false")
		end
	end

	self:UpdateRefreshView()
end

function ActivityInviteMainView:UpdateDefaultView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	self.activityId = InviteData:GetDataByPara("activityId")
	self.heroPlotList = InviteData:GetDataByPara("heroPlotList")
	self.drawItemId = InviteData:GetDataByPara("drawItemId")

	self.list:StartScroll(#self.heroPlotList)

	local var_11_0 = ActivityData:GetActivityData(self.activityId)

	self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_11_0.stopTime, nil, true)
	self.updateTimer_ = Timer.New(function()
		self.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_11_0.stopTime, nil, true)
	end, 1, var_11_0.stopTime, 1)
end

function ActivityInviteMainView:UpdateRefreshView()
	self.nameTxt_.text = GetI18NText(HeroCfg[self.heroPlotList[self.selectIndex][1].hero_id].suffix)
	self.roleImg.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. tostring(self.heroPlotList[self.selectIndex][1].hero_image_route))

	self:UpdateDrawController()
end

function ActivityInviteMainView:UpdateFreeDraw()
	self:UpdateDrawController()
end

function ActivityInviteMainView:UpdateDrawController()
	local var_15_0 = ItemTools.getItemNum(self.drawItemId)
	local var_15_1 = InviteData:GetDataByPara("inviteTimes")

	self.inviteTimeTxt_.text = string.format(GetTips("ACTIVITY_INVITE_TIME"), var_15_1)
	self.inviteTxt_.text = string.format(GetTips("ACTIVITY_INVITE_REWARD_TIME"), GameSetting.activity_invite_daily_opportunities.value[1])

	if var_15_0 > 0 then
		self.drawController:SetSelectedState("2")
	elseif var_15_1 == 0 and var_15_0 == 0 or InviteData:GetDataByPara("allComplete") then
		self.drawController:SetSelectedState("3")
	else
		self.drawController:SetSelectedState("1")
	end
end

function ActivityInviteMainView:OnEnter()
	self.selectIndex = self.params_.selectIndex or self:GetDefaultSelect()

	self:UpdateDefaultView()
	self:UpdateRefreshView()
	self:BindRedPoint()
end

function ActivityInviteMainView:SafeCheck()
	self.heroPlotList = InviteData:GetDataByPara("heroPlotList")

	if InviteData:GetDataByPara("completeHeroTable")[self.heroPlotList[self.selectIndex][1].hero_id] then
		return true
	end

	return false
end

function ActivityInviteMainView:GetDefaultSelect()
	self.heroPlotList = InviteData:GetDataByPara("heroPlotList")

	local var_18_0 = InviteData:GetDataByPara("completeHeroTable")

	for iter_18_0, iter_18_1 in ipairs(self.heroPlotList) do
		if var_18_0[iter_18_1[1].hero_id] == nil then
			return iter_18_0
		end
	end
end

function ActivityInviteMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.drawGo_.transform, RedPointConst.INVITE_DRAW, {
		x = 50,
		y = 70
	})
	manager.redPoint:bindUIandKey(self.inviteBtn_.transform, RedPointConst.INVITE_PLOT, {
		x = 150,
		y = 35
	})
end

function ActivityInviteMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.drawGo_.transform, RedPointConst.INVITE_DRAW)
	manager.redPoint:unbindUIandKey(self.inviteBtn_.transform, RedPointConst.INVITE_PLOT)
end

function ActivityInviteMainView:OnInviteUpdate()
	self:Back()
	JumpTools.GoToSystem("/ActivityInviteRegionView", {
		selectIndex = self.selectIndex
	})
end

function ActivityInviteMainView:OnExit()
	self:UnbindRedPoint()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function ActivityInviteMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_INVITE_DESCRIPTION")
end

function ActivityInviteMainView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	ActivityInviteMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return ActivityInviteMainView
