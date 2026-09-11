local HellaParkourEntrustView = class("HellaParkourEntrustView", ReduxView)

function HellaParkourEntrustView:UIName()
	return "UI/VersionUI/HellaUI/Parkour/HellaParkourEntrustUI"
end

function HellaParkourEntrustView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaParkourEntrustView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaParkourEntrustView:InitUI()
	self:BindCfgUI()

	self.entrustList = LuaList.New(handler(self, self.IndexEntrustItem), self.m_entrustList, HellaParkourEntrustItem)
	self.targetList = LuaList.New(handler(self, self.IndexTargetItem), self.m_targetList, HellaParkourTargetItem)
	self.specialTargetList = LuaList.New(handler(self, self.IndexSpecailTargetItem), self.m_specialTargetList, HellaParkourTargetItem)
end

function HellaParkourEntrustView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("hellaParkourReward", {
			parkour_activity_id = self.parkour_activity_id,
			entrust_activity_id = self.entrusts[self.selectIndex]
		})
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		if not ActivityData:GetActivityIsOpen(self.entrusts[self.selectIndex]) then
			ShowTips("TIP_EXPIRED")

			return
		end

		BattleController.GetInstance():LaunchBattle((BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.PARKOUR, self.entrusts[self.selectIndex], self.parkour_activity_id)))
	end)
end

function HellaParkourEntrustView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_PARKOUR_DESCRIPE")
	self:Refresh()
end

function HellaParkourEntrustView:OnEnter()
	self.parkour_activity_id = self.params_.parkour_activity_id or 0

	if ActivityCfg[self.parkour_activity_id] then
		self.entrusts = ActivityCfg[self.parkour_activity_id].sub_activity_list or {}
	end

	ParkourAction.SetParkourRead(self.parkour_activity_id)

	self.timer = Timer.New(function()
		self:OnTimerEvent()
	end, 1, -1)

	self.timer:Start()

	if self.params_.entrust_activity_id then
		local var_9_0 = table.indexof(self.entrusts, self.params_.entrust_activity_id)

		if var_9_0 and ActivityData:GetActivityIsOpen(self.params_.entrust_activity_id) then
			self:SetSelectIndex(var_9_0)
			self.entrustList:StartScroll(#self.entrusts, var_9_0)

			return
		end
	end

	for iter_9_0, iter_9_1 in ipairs(self.entrusts) do
		if ActivityData:GetActivityIsOpen(iter_9_1) then
			self:SetSelectIndex(iter_9_0)
			self.entrustList:StartScroll(#self.entrusts, iter_9_0)

			return
		end
	end

	self:SetSelectIndex(1)
	self.entrustList:StartScroll(#self.entrusts)
end

function HellaParkourEntrustView:OnExit()
	manager.windowBar:HideBar()

	self.selectIndex = nil

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function HellaParkourEntrustView:OnTimerEvent()
	for iter_12_0, iter_12_1 in ipairs((self.entrustList:GetItemList())) do
		iter_12_1:RefreshTime()
	end
end

function HellaParkourEntrustView:Refresh()
	self.m_title.text = GetI18NText(ActivityParkourCfg[self.entrusts[self.selectIndex]].name)
	self.m_des.text = GetI18NText(ActivityParkourCfg[self.entrusts[self.selectIndex]].desc)
	self.targetData = BattleParkourStageCfg[ActivityParkourCfg[self.entrusts[self.selectIndex]].stage_id].three_star_need

	self.targetList:StartScroll(3)
	self.specialTargetList:StartScroll(1)
	manager.redPoint:SetRedPointIndependent(self.m_rewardBtn.transform, (manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.PARKOUR_ENTRUST_REWARD, self.entrusts[self.selectIndex]))))
end

function HellaParkourEntrustView:IndexEntrustItem(arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_1, self.entrusts[arg_14_1])
	arg_14_2:SetSelectedIndex(self.selectIndex)
	arg_14_2:RegistCallBack(handler(self, self.SetSelectIndex))
end

function HellaParkourEntrustView:SetSelectIndex(arg_15_1)
	if arg_15_1 == self.selectIndex then
		return
	end

	if arg_15_1 ~= 0 then
		if not ActivityData:GetActivityIsOpen(self.entrusts[arg_15_1]) then
			local var_15_0 = ActivityData:GetActivityData(self.entrusts[arg_15_1])

			if var_15_0 and manager.time:GetServerTime() < var_15_0.startTime then
				ShowTips(string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_15_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			self.selectIndex = 1

			return
		end
	end

	self.selectIndex = arg_15_1

	for iter_15_0, iter_15_1 in pairs((self.entrustList:GetItemList())) do
		iter_15_1:SetSelectedIndex(self.selectIndex)
	end

	self:Refresh()
end

function HellaParkourEntrustView:IndexTargetItem(arg_16_1, arg_16_2)
	arg_16_2:SetData(arg_16_1, self.entrusts[self.selectIndex], self.targetData[arg_16_1], false)
end

function HellaParkourEntrustView:IndexSpecailTargetItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(arg_17_1 + 3, self.entrusts[self.selectIndex], self.targetData[arg_17_1 + 3], true)
end

function HellaParkourEntrustView:Dispose()
	self.entrustList:Dispose()
	self.targetList:Dispose()
	self.specialTargetList:Dispose()
	HellaParkourEntrustView.super.Dispose(self)
end

return HellaParkourEntrustView
