local ActivityMainBasePanel = class("ActivityMainBasePanel", ReduxView)

function ActivityMainBasePanel:GetUIName()
	return
end

function ActivityMainBasePanel:Ctor(arg_2_1, arg_2_2)
	self:GetRealActivityId(arg_2_2)

	self.gameObject_ = Object.Instantiate(Asset.Load(self:GetUIName()), arg_2_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityMainBasePanel:PreBtnClickCheck(arg_3_1, arg_3_2, arg_3_3)
	if ActivityTools.CheckActivityIsSuspended(self.activityID_) then
		return false
	end

	return true
end

function ActivityMainBasePanel:AddBtnListener(arg_4_1, arg_4_2, arg_4_3, ...)
	local var_4_0 = {
		...
	}
	local var_4_1 = (arg_4_1 == nil or type(arg_4_1) == "string") and self:FindCom(typeof(Button), arg_4_1, arg_4_2) or arg_4_1

	if type(arg_4_3) == "string" then
		var_4_1.onClick:AddListener(function()
			if self:PreBtnClickCheck(var_4_1, arg_4_1, arg_4_2) then
				self:RecordOperation(var_4_1)
				self[arg_4_3](self, unpack(var_4_0))
			end
		end)
	else
		var_4_1.onClick:AddListener(function()
			if self:PreBtnClickCheck(var_4_1, arg_4_1, arg_4_2) then
				self:RecordOperation(var_4_1)
				arg_4_3(unpack(var_4_0))
			end
		end)
	end

	self:SetListener(var_4_1.onClick)
end

function ActivityMainBasePanel:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function ActivityMainBasePanel:OnEnter()
	local var_8_0 = ActivityData:GetActivityData(self.activityID_)

	self.startTime_ = var_8_0.startTime
	self.stopTime_ = var_8_0.stopTime

	self:AddTimer()
	self:HideRedPoint()
	self:UpdateTitleShow()
end

function ActivityMainBasePanel:UpdatePreview()
	if self.preRewardListGo_ == nil then
		self.preRewardListGo_ = self:FindGo("panel/middle_adapt/Activity_Com_list03/content/UIList")
	end

	if self.preRewardListGo_ and self.preRewardList_ == nil then
		self.preRewards_ = {}
		self.preRewardList_ = LuaList.New(handler(self, self.IndexPreviewItem), self.preRewardListGo_, CommonItemView)
	end

	local var_9_0 = ActivityCfg[self.activityID_]

	if ActivityCfg[self.activityID_] and var_9_0.reward_show and var_9_0.reward_show ~= "" and self.preRewardList_ and self.preRewardListGo_ then
		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0.reward_show) do
			table.insert(var_9_1, rewardToItemTemplate({
				id = iter_9_1
			}, nil, true))
		end

		self.preRewards_ = ItemTools.SortRewardItemList(var_9_1)

		self.preRewardList_:StartScroll(#self.preRewards_)
	end
end

function ActivityMainBasePanel:IndexPreviewItem(arg_10_1, arg_10_2)
	arg_10_2:SetData(self.preRewards_[arg_10_1])
end

local var_0_1 = {
	"panel/middle_adapt/Activity_Com_tittle01/root/title/content/textTittle",
	"panel/middle_adapt/Activity_Com_tittle02/root/title/content/textTittle",
	"panel/middle_adapt/Activity_Com_tittle03/root/title/content/textTittle",
	"panel/middle_adapt/Activity_Com_tittle04/root/title/content/textTittle"
}
local var_0_2 = {
	"panel/middle_adapt/Activity_Com_tittle01/root/title/textcontent",
	"panel/middle_adapt/Activity_Com_tittle02/root/textcontent/Viewport/Content/text",
	"panel/middle_adapt/Activity_Com_tittle03/root/title/textcontent",
	"panel/middle_adapt/Activity_Com_tittle04/root/textcontent/Viewport/Content/text"
}

function ActivityMainBasePanel:UpdateTitleShow()
	local var_11_0

	if ActivityToggleCfg.get_id_list_by_activity_id[self.toggleActivityID_] then
		var_11_0 = ActivityToggleCfg.get_id_list_by_activity_id[self.toggleActivityID_][1]
	end

	if not var_11_0 then
		return
	end

	if not self.descText_ then
		for iter_11_0, iter_11_1 in pairs(var_0_2) do
			local var_11_1 = self:FindGo(iter_11_1)

			if var_11_1 then
				self.descText_ = var_11_1:GetComponent(typeof(Text))

				break
			end
		end
	end

	if not self.titleTxt_ then
		for iter_11_2, iter_11_3 in pairs(var_0_1) do
			local var_11_2 = self:FindGo(iter_11_3)

			if var_11_2 then
				self.titleTxt_ = var_11_2:GetComponent(typeof(Text))

				break
			end
		end
	end

	local var_11_3 = ActivityToggleCfg[var_11_0]

	if ActivityToggleCfg[var_11_0] and var_11_3.name ~= "" and self.titleTxt_ then
		self.titleTxt_.text = GetI18NText(var_11_3.name)
	end

	if var_11_3 and var_11_3.desc ~= "" and self.descText_ then
		self.descText_.text = GetI18NText(var_11_3.desc)
	end
end

function ActivityMainBasePanel:OnExit()
	self:StopTimer()
end

function ActivityMainBasePanel:OnTop()
	return
end

function ActivityMainBasePanel:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityMainBasePanel:Dispose()
	ActivityMainBasePanel.super.Dispose(self)

	if self.preRewardList_ then
		self.preRewardList_:Dispose()

		self.preRewardList_ = nil
	end

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ActivityMainBasePanel:AddListeners()
	return
end

function ActivityMainBasePanel:Show(arg_17_1)
	SetActive(self.gameObject_, arg_17_1)

	if arg_17_1 then
		self:UpdatePreview()
	end
end

function ActivityMainBasePanel:HideRedPoint()
	return
end

function ActivityMainBasePanel:AddTimer()
	self:StopTimer()
	self:RefreshTimeText()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self:RefreshTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function ActivityMainBasePanel:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityMainBasePanel:RefreshTimeText()
	if self.timeText_ then
		if not self:isHasLeftTimeDes() then
			local var_22_0, var_22_1 = self:CheckAdvanceOpenTime()

			self.timeText_.text = var_22_1

			self:RefreshAcvanceStatus(not var_22_0)
		else
			self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
		end
	end
end

function ActivityMainBasePanel:isHasLeftTimeDes()
	return false
end

function ActivityMainBasePanel:IsActivityTime()
	if manager.time:GetServerTime() < self.startTime_ then
		ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStrWith2Unit(self.startTime_, true)))

		return false
	end

	if manager.time:GetServerTime() >= self.stopTime_ then
		ShowTips("TIME_OVER")

		return false
	end

	return true
end

function ActivityMainBasePanel:CheckAdvanceOpenTime()
	local var_25_0 = 0
	local var_25_1 = 0
	local var_25_2 = ActivityData:GetActivityData(self.activityID_)

	if self.isAdvanceActivity_ then
		var_25_1 = var_25_2.startTime
		var_25_0 = var_25_2.startTime - manager.time:GetServerTime()
	end

	local var_25_3 = self.isAdvanceActivity_ and var_25_0 > 0

	if var_25_3 then
		self.stopTime_ = var_25_2.startTime or var_25_2.stopTime
	end

	return var_25_3, (var_25_3 or nil) and (string.format(GetTips("AFTER_TIME"), manager.time:GetLostTimeStrWith2Unit(var_25_1)) or manager.time:GetLostTimeStrWith2UnitWithPrefix(var_25_2.stopTime))
end

function ActivityMainBasePanel:GetRealActivityId(arg_26_1)
	local var_26_0 = ActivityData:GetActivityData(arg_26_1)

	self.isAdvanceActivity_ = var_26_0.template == ActivityTemplateConst.ACTIVITY_ADVANCE_OPEN or var_26_0.template == ActivityTemplateConst.ACTIVITY_ADVANCE_PRE_OPEN
	self.toggleActivityID_ = arg_26_1

	if self.isAdvanceActivity_ then
		self.activityID_ = var_26_0.subActivityIdList[1] or arg_26_1
	end
end

function ActivityMainBasePanel:RefreshAcvanceStatus(arg_27_1)
	return
end

function ActivityMainBasePanel:BindHelpBtn(arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or self.tipsBtn_

	if isNil(arg_28_2) then
		return
	end

	local var_28_0 = type(arg_28_1)
	local var_28_1

	if var_28_0 == "function" then
		var_28_1 = arg_28_1
	else
		local var_28_2
		local var_28_3

		if var_28_0 == "string" then
			var_28_3 = {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(arg_28_1),
				key = arg_28_1
			}
			var_28_2 = "gameHelp"
		elseif var_28_0 == "table" then
			var_28_3 = arg_28_1.params
			var_28_2 = arg_28_1.view
		end

		if var_28_2 then
			function var_28_1()
				JumpTools.OpenPageByJump(var_28_2, var_28_3)
			end
		end
	end

	self:AddBtnListenerScale(arg_28_2, nil, var_28_1)
end

return ActivityMainBasePanel
