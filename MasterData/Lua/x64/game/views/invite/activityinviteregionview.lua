local ActivityInviteRegionView = class("ActivityInviteRegionView", ReduxView)

function ActivityInviteRegionView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionCarteUI"
end

function ActivityInviteRegionView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityInviteRegionView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ActivityInviteRegionView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.SetItem), self.listGo_, ActivityInviteHeadItem)
	self.drawController = ControllerUtil.GetController(self.drawGo_.transform, "state")
	self.listController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.regionItem = {}

	for iter_4_0 = 1, 6 do
		self.regionItem[iter_4_0] = ActivityInviteRegionItem.New(self["regionGo" .. iter_4_0 .. "_"])
	end
end

function ActivityInviteRegionView:SetItem(arg_5_1, arg_5_2)
	local var_5_0 = InviteData:GetDataByPara("heroPlotList")

	arg_5_2:SetData({
		heroId = var_5_0[arg_5_1][1].hero_id,
		image = var_5_0[arg_5_1][1].hero_image_route
	}, arg_5_1, handler(self, self.SelectListener), self.selectIndex)
end

function ActivityInviteRegionView:SelectListener(arg_6_1, arg_6_2)
	if arg_6_1 == self.selectIndex then
		return
	end

	if self.completeHeroTable[arg_6_2] then
		self.selectIndex = arg_6_1

		self:UpdateView()
	else
		self.selectIndex = nil

		self:Back()
		JumpTools.GoToSystem("/ActivityInviteMain", {
			needBack = false,
			selectIndex = arg_6_1
		})
	end
end

function ActivityInviteRegionView:AddUIListener()
	self:AddBtnListener(self.drawBtn_, nil, function()
		JumpTools.GoToSystem("/draw", {
			poolId = InviteData:GetDataByPara("poolID")
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function ActivityInviteRegionView:UpdateView()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	local var_9_0 = InviteData:GetDataByPara("heroPlotList")

	self.inviteTimes = InviteData:GetDataByPara("inviteTimes")
	self.completeHeroTable = InviteData:GetDataByPara("completeHeroTable")
	self.heroPlotList = var_9_0[self.selectIndex]
	self.heroId = self.heroPlotList[1].hero_id
	self.InviteTime_.text = string.format(GetTips("ACTIVITY_INVITE_TIME"), self.inviteTimes)
	self.inviteTxt_.text = string.format(GetTips("ACTIVITY_INVITE_REWARD_TIME"), GameSetting.activity_invite_daily_opportunities.value[1] - (#self.completeHeroTable[self.heroId] - 1) % 3)
	self.activityId = InviteData:GetDataByPara("activityId")
	self.roleIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. self.heroPlotList[1].hero_image_route)
	self.nameTxt_.text = GetI18NText(HeroCfg[self.heroId].suffix)

	for iter_9_0 = 1, 6 do
		self.regionItem[iter_9_0]:SetData(self.heroPlotList[iter_9_0 + 1].id, iter_9_0)
	end

	SetActive(self.headListGo_, #self.completeHeroTable[self.heroId] == 7)
	self.listController:SetSelectedState(#self.completeHeroTable[self.heroId] == 7 and "2" or "1")

	if #self.completeHeroTable[self.heroId] == 7 then
		self.list:StartScroll(#var_9_0)
	end

	self:UpdateDrawController()

	local var_9_1 = ActivityData:GetActivityData(self.activityId)

	self.remainTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_9_1.stopTime, nil, true)
	self.updateTimer_ = Timer.New(function()
		self.remainTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(var_9_1.stopTime, nil, true)
	end, 1, var_9_1.stopTime, 1)

	self.updateTimer_:Start()
end

function ActivityInviteRegionView:UpdateFreeDraw()
	self:UpdateDrawController()
end

function ActivityInviteRegionView:UpdateDrawController()
	local var_12_0 = ItemTools.getItemNum((InviteData:GetDataByPara("drawItemId")))

	if var_12_0 > 0 then
		self.drawController:SetSelectedState("2")
	elseif InviteData:GetDataByPara("inviteTimes") == 0 and var_12_0 == 0 or InviteData:GetDataByPara("allComplete") then
		self.drawController:SetSelectedState("3")
	else
		self.drawController:SetSelectedState("1")
	end
end

function ActivityInviteRegionView:OnInviteUpdate(arg_13_1)
	self:UpdateView()

	if arg_13_1 == nil then
		return
	end

	JumpTools.GoToSystem("ActivityInvitePlotView", {
		id = arg_13_1,
		haveReward = self.getReward
	})

	self.getReward = nil
end

function ActivityInviteRegionView:OnInviteGetReward(arg_14_1)
	self.getReward = arg_14_1 ~= nil
end

function ActivityInviteRegionView:OnEnter()
	self.selectHeroIndex = 1
	self.selectIndex = self.selectIndex or self.params_.selectIndex
	self.params_.selectIndex = nil

	manager.redPoint:bindUIandKey(self.drawGo_.transform, RedPointConst.INVITE_DRAW, {
		x = 50,
		y = 70
	})
	self:UpdateView()
end

function ActivityInviteRegionView:OnExit()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.drawGo_.transform, RedPointConst.INVITE_DRAW)
	manager.windowBar:HideBar()
end

function ActivityInviteRegionView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityInviteRegionView:Dispose()
	ActivityInviteRegionView.super.Dispose(self)

	for iter_18_0, iter_18_1 in pairs(self.regionItem) do
		iter_18_1:Dispose()
	end

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	Object.Destroy(self.gameObject_)
end

return ActivityInviteRegionView
