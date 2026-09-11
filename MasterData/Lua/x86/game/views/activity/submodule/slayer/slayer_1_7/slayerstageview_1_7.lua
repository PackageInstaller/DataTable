local SplayerStageView_1_7 = class("SplayerStageView_1_7", (import("game.views.activity.Submodule.slayer.volume.VolumeSlayerView")))

function SplayerStageView_1_7:InitUI()
	self:BindCfgUI()

	self.list = LuaList.New(handler(self, self.IndexItem), self.m_list, SlayerStageItem_1_7)
end

function SplayerStageView_1_7:AddUIListener()
	self:AddBtnListener(self.m_entrustBtn, nil, function()
		self:Go("/sectionSelectHero", {
			section = ActivitySlayerCfg[self.regionList[self.selectIndex]].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SLAYER,
			region_activity_id = self.regionList[self.selectIndex],
			activityID = self.slayer_activity_id
		})
	end)
end

function SplayerStageView_1_7:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SOLO_SLAYER_DESCRIPE")
end

function SplayerStageView_1_7:OnEnter()
	self.slayer_activity_id = self.params_.slayer_activity_id or 0

	if ActivityCfg[self.slayer_activity_id] then
		self.regionList = ActivityCfg[self.slayer_activity_id].sub_activity_list or {}
	end

	if self.params_.init_tag and not ActivityData:GetActivityIsOpen(self.regionList[self.selectIndex]) then
		self.params_.init_tag = nil

		for iter_5_0, iter_5_1 in ipairs(self.regionList) do
			if ActivityData:GetActivityIsOpen(iter_5_1) then
				self.selectIndex = iter_5_0

				break
			end
		end
	end

	if self.params_.region_activity_id then
		self.selectIndex = table.indexof(self.regionList, self.params_.region_activity_id) or 1
		self.params_.region_activity_id = nil
	else
		self.selectIndex = SlayerData:GetSelectIndex(self.slayer_activity_id) or 1
	end

	self.list:StartScroll(#self.regionList, self.selectIndex, true)
	SlayerAction.SetSlayerRead(self.regionList[self.selectIndex])

	self.timer = Timer.New(function()
		self:OnTimerEvent()
	end, 1, -1)

	self.timer:Start()
	self:Refresh()
end

function SplayerStageView_1_7:Refresh()
	for iter_7_0, iter_7_1 in pairs((self.list:GetItemList())) do
		iter_7_1:SetSelectedIndex(self.selectIndex)
	end

	local var_7_0 = self.regionList[self.selectIndex]
	local var_7_1 = ActivitySlayerCfg[self.regionList[self.selectIndex]]
	local var_7_2

	if ActivitySlayerCfg[self.regionList[self.selectIndex]] then
		var_7_2 = var_7_1.buff_desc or {}
	end

	local var_7_3 = ""

	for iter_7_2, iter_7_3 in ipairs(var_7_2) do
		var_7_3 = var_7_3 .. iter_7_3 .. "\n"
	end

	self.m_buffDes.text = GetI18NText(var_7_3)
	self.m_title.text = GetI18NText(BattleSlayerStageCfg[var_7_1.stage_id].name)
	self.m_des.text = GetI18NText(BattleSlayerStageCfg[var_7_1.stage_id].tips)

	self:RefreshReward(var_7_0)
end

function SplayerStageView_1_7:RefreshReward(arg_8_1)
	if self.m_rewardView == nil then
		self.m_rewardView = SlayerTools.GetRewardItemClass(self.slayer_activity_id).New(self.m_rewardPanelGo)
	end

	self.m_rewardView:SetData(self.slayer_activity_id, arg_8_1)
	self.m_rewardView:SetActive(true)
end

function SplayerStageView_1_7:SetSelectIndex(arg_9_1)
	if arg_9_1 == self.selectIndex then
		return
	end

	if arg_9_1 ~= 0 then
		if not ActivityTools.GetActivityIsOpenWithTip(self.regionList[arg_9_1], true) then
			return
		end

		SlayerAction.SetSlayerRead(self.regionList[arg_9_1])
	end

	self.selectIndex = arg_9_1

	self:Refresh()
	SlayerData:SetSelectIndex(self.slayer_activity_id, arg_9_1)
end

function SplayerStageView_1_7:Dispose()
	self.m_rewardView:Dispose()

	self.m_rewardView = nil

	SplayerStageView_1_7.super.Dispose(self)
end

return SplayerStageView_1_7
