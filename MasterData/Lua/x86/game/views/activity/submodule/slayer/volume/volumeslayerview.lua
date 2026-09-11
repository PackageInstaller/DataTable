local VolumeSlayerView = class("VolumeSlayerView", ReduxView)

function VolumeSlayerView:UIName()
	return SlayerTools.GetSelectUIName(self.params_.slayer_activity_id or 0)
end

function VolumeSlayerView:UIParent()
	return manager.ui.uiMain.transform
end

function VolumeSlayerView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VolumeSlayerView:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, VolumeSlayerItem)
end

function VolumeSlayerView:AddUIListener()
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("hellaSlayerReward", {
			slayer_activity_id = self.slayer_activity_id,
			region_activity_id = self.regionList[self.selectIndex]
		})
	end)
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		self:Go("/sectionSelectHero", {
			section = ActivitySlayerCfg[self.regionList[self.selectIndex]].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			region_activity_id = self.regionList[self.selectIndex],
			activityID = self.slayer_activity_id
		})
	end)
end

function VolumeSlayerView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_VOLUME_SLAYER_DESCRIPE")
end

function VolumeSlayerView:OnEnter()
	self.slayer_activity_id = self.params_.slayer_activity_id or 0

	if ActivityCfg[self.slayer_activity_id] then
		self.regionList = ActivityCfg[self.slayer_activity_id].sub_activity_list or {}
	end

	if self.params_.init_tag and not ActivityData:GetActivityIsOpen(self.regionList[self.selectIndex]) then
		self.params_.init_tag = nil

		for iter_9_0, iter_9_1 in ipairs(self.regionList) do
			if ActivityData:GetActivityIsOpen(iter_9_1) then
				self.selectIndex = iter_9_0

				break
			end
		end
	end

	if self.params_.region_activity_id then
		self.selectIndex = table.indexof(self.regionList, self.params_.region_activity_id) or 1
		self.params_.region_activity_id = nil
	end

	self.selectIndex = self.selectIndex or 1

	self.list:StartScroll(#self.regionList, self.selectIndex, true)
	self:RefreshSelecteRedPoint()

	self.timer = Timer.New(function()
		self:OnTimerEvent()
	end, 1, -1)

	self.timer:Start()
	self:Refresh()
end

function VolumeSlayerView:OnExit()
	manager.windowBar:HideBar()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function VolumeSlayerView:OnTimerEvent()
	for iter_12_0, iter_12_1 in ipairs((self.list:GetItemList())) do
		iter_12_1:RefreshTime()
	end
end

function VolumeSlayerView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(arg_13_1, self.slayer_activity_id, self.regionList[arg_13_1], arg_13_1 == #self.regionList)
	arg_13_2:SetSelectedIndex(self.selectIndex)
	arg_13_2:RegistCallBack(handler(self, self.SetSelectIndex))
end

function VolumeSlayerView:SetSelectIndex(arg_14_1)
	if arg_14_1 == self.selectIndex then
		return
	end

	if arg_14_1 ~= 0 and not ActivityTools.GetActivityIsOpenWithTip(self.regionList[arg_14_1], true) then
		return
	end

	self.selectIndex = arg_14_1

	self:Refresh()
end

function VolumeSlayerView:Refresh()
	for iter_15_0, iter_15_1 in pairs((self.list:GetItemList())) do
		iter_15_1:SetSelectedIndex(self.selectIndex)
	end

	local var_15_0 = self.regionList[self.selectIndex]
	local var_15_1 = ActivitySlayerCfg[self.regionList[self.selectIndex]]
	local var_15_2

	if ActivitySlayerCfg[self.regionList[self.selectIndex]] then
		var_15_2 = var_15_1.buff_desc or {}
	end

	local var_15_3 = ""

	for iter_15_2, iter_15_3 in ipairs(var_15_2) do
		var_15_3 = GetI18NText(var_15_3) .. GetI18NText(iter_15_3) .. "\n"
	end

	self.m_buffDes.text = GetI18NText(var_15_3)
	self.m_title.text = GetI18NText(BattleSlayerStageCfg[var_15_1.stage_id].name)
	self.m_des.text = GetI18NText(BattleSlayerStageCfg[var_15_1.stage_id].tips)

	manager.redPoint:SetRedPointIndependent(self.m_rewardBtn.transform, (SlayerAction.GetSlayerRewardState(self.slayer_activity_id, var_15_0)))
end

function VolumeSlayerView:Dispose()
	self.selectIndex = nil

	self.list:Dispose()
	VolumeSlayerView.super.Dispose(self)
end

function VolumeSlayerView:OnSlayerReward()
	self:Refresh()
end

function VolumeSlayerView:RefreshSelecteRedPoint()
	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.SLYAER_REGIONS, self.slayer_activity_id)) then
		for iter_18_0, iter_18_1 in ipairs(ActivityCfg[self.slayer_activity_id].sub_activity_list) do
			SlayerAction.SetSlayerRead(iter_18_1)
		end
	end
end

return VolumeSlayerView
