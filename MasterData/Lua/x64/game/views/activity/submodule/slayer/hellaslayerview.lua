local HellaSlayerView = class("HellaSlayerView", ReduxView)

function HellaSlayerView:UIName()
	return "UI/VersionUI/HellaUI/Slayer/HellaSlayerUI"
end

function HellaSlayerView:UIParent()
	return manager.ui.uiMain.transform
end

function HellaSlayerView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HellaSlayerView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, HellaSlayerItem)
end

function HellaSlayerView:AddUIListener()
	self:AddBtnListener(self.m_talentBtn, nil, function()
		local var_6_0 = TalentTreeTools.GetActivityIdByTheme((ActivityTools.GetActivityTheme(self.slayer_activity_id)))

		if var_6_0 then
			JumpTools.OpenPageByJump("/talentTree", {
				activityId = var_6_0
			})
		end
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = self.slayer_activity_id
		})
	end)
	self:AddBtnListener(self.m_bgBtn, nil, function()
		if self:IsOpenSectionInfo() then
			self:SetSelectIndex(0)
			JumpTools.Back()
		end
	end)
	self.m_scrollEvent:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function(arg_9_0, arg_9_1)
		if self:IsOpenSectionInfo() then
			self:SetSelectIndex(0)
			JumpTools.Back()
		end
	end))
end

function HellaSlayerView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_HELLA_SLAYER_DESCRIPE")
	manager.windowBar:RegistBackCallBack(function()
		if self:IsOpenSectionInfo() then
			self:SetSelectIndex(0)
		end

		JumpTools.Back()
	end)
end

function HellaSlayerView:OnEnter()
	self.slayer_activity_id = self.params_.slayer_activity_id or 0

	if ActivityCfg[self.slayer_activity_id] then
		self.regionList = ActivityCfg[self.slayer_activity_id].sub_activity_list or {}
	end

	self.selectIndex = SlayerData:GetSelectIndex(self.slayer_activity_id) or 0

	self.list:StartScroll(#self.regionList, (self.selectIndex > 0 or nil) and (self.selectIndex - 1 or 0))
	self:SetSelectIndex(0)
	self:RefreshSelecteRedPoint()
	manager.redPoint:bindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.slayer_activity_id))
	self:RefrenTime()

	self.timer = Timer.New(function()
		self:OnTimerEvent()
	end, 1, -1)

	self.timer:Start()
end

function HellaSlayerView:OnExit()
	self:RemoveTween()
	manager.redPoint:unbindUIandKey(self.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, self.slayer_activity_id))
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function HellaSlayerView:OnTimerEvent()
	self:RefrenTime()

	for iter_15_0, iter_15_1 in ipairs((self.list:GetItemList())) do
		iter_15_1:RefreshTime()
	end
end

function HellaSlayerView:RefrenTime()
	local var_16_0 = ActivityData:GetActivityData(self.slayer_activity_id)

	self.m_timeLab.text = var_16_0 and var_16_0:IsActivitying() and manager.time:GetLostTimeStr(var_16_0.stopTime) or GetTips("TIME_OVER")
end

function HellaSlayerView:IndexItem(arg_17_1, arg_17_2)
	arg_17_2:SetData(arg_17_1, self.slayer_activity_id, self.regionList[arg_17_1], arg_17_1 == #self.regionList)
	arg_17_2:SetSelectedIndex(self.selectIndex)
	arg_17_2:RegistCallBack(handler(self, self.SetSelectIndex))
end

function HellaSlayerView:SetSelectIndex(arg_18_1)
	if arg_18_1 == self.selectIndex then
		return
	end

	if arg_18_1 ~= 0 then
		if not ActivityData:GetActivityIsOpen(self.regionList[arg_18_1]) then
			local var_18_0 = ActivityData:GetActivityData(self.regionList[arg_18_1])

			if var_18_0 and manager.time:GetServerTime() < var_18_0.startTime then
				ShowTips(string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(var_18_0.startTime)))
			else
				ShowTips("TIME_OVER")
			end

			return
		end

		SlayerData:SetSelectIndex(self.slayer_activity_id, arg_18_1)
	end

	self.selectIndex = arg_18_1

	local var_18_1 = self.list:GetItemList()

	if var_18_1[self.selectIndex] then
		self.m_scrollCom.horizontal = false

		self:RemoveTween()

		self.tween_ = LeanTween.value(self.m_scrollContent, self.m_scrollContent.transform.localPosition.x, -var_18_1[self.selectIndex].transform_.localPosition.x + self.m_scrollViewTrans.rect.width / 2 - var_18_1[self.selectIndex].transform_.rect.width / 2, 0.2):setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
			self.m_scrollContent.transform.localPosition = Vector3(arg_19_0, 0, 0)
		end))
	else
		self.m_scrollCom.horizontal = true
	end

	for iter_18_0, iter_18_1 in pairs(var_18_1) do
		iter_18_1:SetSelectedIndex(self.selectIndex)
	end

	if self.selectIndex ~= 0 and self.regionList[self.selectIndex] then
		self:Go("slayerSctionInfo", {
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			section = ActivitySlayerCfg[self.regionList[self.selectIndex]].stage_id,
			region_activity_id = self.regionList[self.selectIndex],
			slayer_activity_id = self.slayer_activity_id
		})
	end
end

function HellaSlayerView:RemoveTween()
	if self.tween_ then
		self.tween_:setOnUpdate(nil)
		LeanTween.cancel(self.m_scrollContent)

		self.tween_ = nil
	end
end

function HellaSlayerView:IsOpenSectionInfo()
	return self:IsOpenRoute("slayerSctionInfo")
end

function HellaSlayerView:Dispose()
	self.list:Dispose()
	HellaSlayerView.super.Dispose(self)
end

function HellaSlayerView:RefreshSelecteRedPoint()
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.slayer_activity_id)) then
		for iter_23_0, iter_23_1 in ipairs(ActivityCfg[self.slayer_activity_id].sub_activity_list) do
			SlayerAction.SetSlayerRead(iter_23_1)
		end
	end
end

return HellaSlayerView
