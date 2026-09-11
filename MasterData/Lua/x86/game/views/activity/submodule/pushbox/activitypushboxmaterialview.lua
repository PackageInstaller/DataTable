local ActivityPushBoxMaterialView = class("ActivityPushBoxMaterialView", ReduxView)

function ActivityPushBoxMaterialView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/JapanRegionUI_2_10MaterialCollectionUI"
end

function ActivityPushBoxMaterialView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityPushBoxMaterialView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxMaterialView:InitUI()
	self:BindCfgUI()

	self.materialPreviewTbl_ = {
		"CAKE_INDEX_MATERIAL_1",
		"CAKE_INDEX_MATERIAL_2",
		"CAKE_INDEX_MATERIAL_3",
		"CAKE_INDEX_MATERIAL_4",
		"CAKE_INDEX_MATERIAL_5",
		"CAKE_INDEX_MATERIAL_6",
		"CAKE_INDEX_MATERIAL_7"
	}

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(ActivityCelebrationOrderCfg.get_id_list_by_main_activity[self.params_.activityID]) do
		var_4_0 = ActivityCelebrationOrderCfg[iter_4_1].index < var_4_0 and var_4_0 or ActivityCelebrationOrderCfg[iter_4_1].index
	end

	self.eventItem_ = {}

	for iter_4_2 = 1, var_4_0 do
		if self["eventItemGo_" .. iter_4_2] == nil then
			error("场景布置数量不足")
		end

		self.eventItem_[iter_4_2] = ActivityPushBoxEventItem.New(self["eventItemGo_" .. iter_4_2])

		self.eventItem_[iter_4_2]:RegistClickFunc(function(arg_5_0, arg_5_1)
			self:ClickEvent(arg_5_0, arg_5_1)
		end)
	end

	self.materialGo_ = {}
	self.materialTxt_ = {}
	self.materialIcon_ = {}

	for iter_4_3 = 1, 3 do
		self.materialGo_[iter_4_3] = self["materialGo_" .. iter_4_3]
		self.materialTxt_[iter_4_3] = self["materialTxt_" .. iter_4_3]
		self.materialIcon_[iter_4_3] = self["materialIcon_" .. iter_4_3]
	end

	self.idleCon_ = ControllerUtil.GetController(self.transform_, "idle")
	self.refreshCon_ = ControllerUtil.GetController(self.transform_, "refresh")
	self.materialCon_ = ControllerUtil.GetController(self.transform_, "material")
	self.sectionView_ = ActivityPushBoxSectionView.New(self.scetionGo_)
end

function ActivityPushBoxMaterialView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:SetSelectItem(0)
		self.sectionView_:Show(false)
		SetActive(self.bgBtn_.gameObject, false)
	end)
	self:AddBtnListener(self.refreshBtn_, nil, function()
		local var_8_0 = ActivityPushBoxData:GetRefreshTime(self.activityID_)

		if var_8_0 > 0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ORDER_REFRESH_TIPS1") .. "\n" .. GetTips("ORDER_REFRESH_TIPS2") .. var_8_0,
				OkCallback = function()
					ActivityPushBoxAction.ResetEvent(self.activityID_)
				end
			})
		end
	end)
end

function ActivityPushBoxMaterialView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshData()
	self:RefreshTime()
	self:RefreshMaterial()
	self:RefreshEventMap()
	self.sectionView_:Show(false)
	SetActive(self.bgBtn_.gameObject, false)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_PUSH_BOX_FATIGUE .. "_" .. self.activityID_, 0)
	self:RegistEventListener(MATERIAL_MODIFY, handler(self, self.RefreshMaterial))
end

function ActivityPushBoxMaterialView:RefreshData()
	self.activityData_ = ActivityData:GetActivityData(self.activityID_)
	self.startTime_ = self.activityData_.startTime
	self.stopTime_ = self.activityData_.stopTime
end

function ActivityPushBoxMaterialView:RefreshTime()
	self:StopTimer()

	local var_12_0 = manager.time:GetServerTime()

	if var_12_0 < self.startTime_ then
		self.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		self.timer_ = Timer.New(function()
			if self.startTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end
		end, 1, -1)

		self.timer_:Start()
	elseif var_12_0 < self.stopTime_ then
		self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
		self.timer_ = Timer.New(function()
			if self.stopTime_ <= manager.time:GetServerTime() then
				self:StopTimer()
				self:RefreshTime()

				return
			end

			self.timeLable_.text = manager.time:GetLostTimeStr2(self.stopTime_)
		end, 1, -1)

		self.timer_:Start()
	else
		self.timeLable_.text = GetTips("TIME_OVER")
	end
end

function ActivityPushBoxMaterialView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPushBoxMaterialView:RefreshMaterial()
	local var_16_0 = ActivityPushBoxData:GetCurIndex(self.activityID_)
	local var_16_1

	if var_16_0 >= #ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_] then
		self.materialListText_.text = GetTips(self.materialPreviewTbl_[var_16_0])
		var_16_1 = ActivityCelebrationCakeCfg[ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_][var_16_0]]
	else
		self.materialListText_.text = GetTips(self.materialPreviewTbl_[var_16_0 + 1])
		var_16_1 = ActivityCelebrationCakeCfg[ActivityCelebrationCakeCfg.get_id_list_by_activity_id[self.activityID_][var_16_0 + 1]]
	end

	local var_16_2 = var_16_1.cost_list

	for iter_16_0, iter_16_1 in ipairs(var_16_1.cost_list) do
		local var_16_3 = ItemTools.getItemNum(iter_16_1[1])

		self.materialIcon_[iter_16_0].sprite = ItemTools.getItemSprite(iter_16_1[1])
		self.materialTxt_[iter_16_0].text = iter_16_1[2] <= var_16_3 and var_16_3 .. "/" .. iter_16_1[2] or string.format("<color=#FF0000>%d</color>", var_16_3) .. "/" .. iter_16_1[2]
	end

	self.materialCon_:SetSelectedState(#var_16_2)
end

function ActivityPushBoxMaterialView:RefreshEventMap()
	local var_17_0 = ActivityPushBoxData:GetMapEventList(self.activityID_)

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		return ActivityCelebrationOrderCfg[arg_18_0].index < ActivityCelebrationOrderCfg[arg_18_1].index
	end)

	for iter_17_0, iter_17_1 in ipairs(self.eventItem_) do
		if not var_17_0[1] then
			break
		end

		local var_17_1

		if iter_17_0 == ActivityCelebrationOrderCfg[var_17_0[1]].index then
			iter_17_1:Show(true)
			iter_17_1:SetData(var_17_0[1])

			var_17_1 = 1 + 1
		else
			iter_17_1:Show(false)
		end
	end

	for iter_17_2 = ActivityCelebrationOrderCfg[var_17_0[#var_17_0]].index + 1, #self.eventItem_ do
		self.eventItem_[iter_17_2]:Show(false)
	end

	for iter_17_3, iter_17_4 in ipairs((ActivityPushBoxData:GetPushBoxEmptyList(self.activityID_))) do
		self.eventItem_[ActivityCelebrationOrderCfg[iter_17_4].index]:Show(true)
		self.eventItem_[ActivityCelebrationOrderCfg[iter_17_4].index]:RefreshCountDown(iter_17_4)
	end

	local var_17_2 = ActivityPushBoxData:GetRefreshTime(self.activityID_)

	self.refreshText_.text = GetTips("ACTIVITY_PUSH_BOX_REFRESH") .. var_17_2

	self.refreshCon_:SetSelectedState(var_17_2 > 0 and "true" or "false")
	self:SetSelectItem(0)
end

function ActivityPushBoxMaterialView:SetSelectItem(arg_19_1)
	self.idleCon_:SetSelectedState(arg_19_1 == 0 and "true" or "false")

	for iter_19_0, iter_19_1 in ipairs(self.eventItem_) do
		iter_19_1:SetSelect(arg_19_1)
	end
end

function ActivityPushBoxMaterialView:ClickEvent(arg_20_1, arg_20_2)
	self:SetSelectItem(arg_20_1)
	self.sectionView_:Show(true)
	self.sectionView_:SetData(arg_20_1, arg_20_2)
	SetActive(self.bgBtn_.gameObject, true)
end

function ActivityPushBoxMaterialView:OnPushBoxMapRefresh()
	self.ani_:Play("JapanRegionUI_2_10MaterialCollectionUI", -1, 0)
	self:RefreshEventMap()
	self.sectionView_:Show(false)
end

function ActivityPushBoxMaterialView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		ACTIVITY_COIN
	})
	manager.windowBar:SetActivityId(ACTIVITY_COIN, self.activityID_)
end

function ActivityPushBoxMaterialView:OnExit()
	self:StopTimer()
	self.sectionView_:OnExit()
	manager.windowBar:HideBar()

	for iter_23_0, iter_23_1 in ipairs(self.eventItem_) do
		iter_23_1:OnExit()
	end

	self:RemoveAllEventListener()
end

function ActivityPushBoxMaterialView:Dispose()
	self:RemoveAllListeners()
	self.sectionView_:Dispose()

	for iter_24_0, iter_24_1 in ipairs(self.eventItem_) do
		iter_24_1:Dispose()
	end

	self.super.Dispose(self)
end

return ActivityPushBoxMaterialView
