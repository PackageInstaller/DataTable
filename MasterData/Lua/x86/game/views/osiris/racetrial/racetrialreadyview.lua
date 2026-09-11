local RaceTrialReadyView = class("RaceTrialReadyView", ReduxView)

function RaceTrialReadyView:UIName()
	return RaceTrialTools.GetReadyUIName(self.params_.activityID)
end

function RaceTrialReadyView:UIParent()
	return manager.ui.uiMain.transform
end

function RaceTrialReadyView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function RaceTrialReadyView:InitUI()
	self:BindCfgUI()

	self.customScrollHelper_ = LuaList.New(handler(self, self.CustomIndexItem), self.customListGo_, CustomBox)
	self.customDesScrollHelper_ = LuaList.New(handler(self, self.CustomDesIndexItem), self.customDesListGo_, CustomDesItem)
end

function RaceTrialReadyView:CustomIndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.customTable_.all[arg_5_1], self.customTable_[self.customTable_.all[arg_5_1]], (self:GetSelectCustom(self.customTable_.all[arg_5_1])))
	arg_5_2:RegisterClickListener(function(arg_6_0)
		local var_6_0 = ActivityAffixPoolCfg[arg_6_0].affix[1]

		if self:GetSelectCustom(ActivityAffixPoolCfg[arg_6_0].affix[1]) ~= arg_6_0 then
			self:SetSelectCustom(var_6_0, arg_6_0)
		else
			self:SetSelectCustom(var_6_0)
		end

		arg_5_2:RefreshUI(var_6_0, self.customTable_[var_6_0], self:GetSelectCustom(var_6_0))
		self:CalculatePoint()
		self:RefreshDesList(false, arg_6_0)
	end)
end

function RaceTrialReadyView:CustomDesIndexItem(arg_7_1, arg_7_2)
	arg_7_2:RefreshUI(ActivityAffixPoolCfg[self.customSelectList_[arg_7_1]].affix)
end

function RaceTrialReadyView:AddUIListeners()
	self:AddBtnListener(self.battleBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		RaceTrialAction:SaveCustomList(self.activityID_, self.customSelectList_)
		self:Go("/sectionSelectHero", {
			section = self.activityID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.RACE_TRIAL,
			forceRace = ActivityRaceTrialCfg[self.activityID_].race,
			activityID = self.params_.activityID
		})
	end)
end

function RaceTrialReadyView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.mainActivityID_ = self.params_.mainActivityID
	self.customSelectList_ = RaceTrialData:GetCustomList(self.activityID_)

	self:CreatCustomTable()
	self:CreatCustomSelectTable()
	self:RefreshUI()
end

function RaceTrialReadyView:CreatCustomTable()
	self.customTable_ = {
		all = {}
	}

	for iter_11_0, iter_11_1 in ipairs(ActivityRaceTrialCfg[self.activityID_].pool) do
		if ActivityAffixPoolCfg[iter_11_1] then
			if not self.customTable_[ActivityAffixPoolCfg[iter_11_1].affix[1]] then
				self.customTable_[ActivityAffixPoolCfg[iter_11_1].affix[1]] = {}

				table.insert(self.customTable_.all, ActivityAffixPoolCfg[iter_11_1].affix[1])
			end

			table.insert(self.customTable_[ActivityAffixPoolCfg[iter_11_1].affix[1]], iter_11_1)
		end
	end
end

function RaceTrialReadyView:CreatCustomSelectTable()
	self.customSelectTable_ = {}

	for iter_12_0, iter_12_1 in ipairs(self.customSelectList_) do
		self.customSelectTable_[ActivityAffixPoolCfg[iter_12_1].affix[1]] = iter_12_1
	end
end

function RaceTrialReadyView:GetSelectCustom(arg_13_1)
	if self.customSelectTable_[arg_13_1] then
		return self.customSelectTable_[arg_13_1]
	end

	return nil
end

function RaceTrialReadyView:SetSelectCustom(arg_14_1, arg_14_2)
	if self.customSelectTable_[arg_14_1] then
		table.remove(self.customSelectList_, table.indexof(self.customSelectList_, self.customSelectTable_[arg_14_1]))
	end

	if arg_14_2 then
		self.customSelectTable_[arg_14_1] = arg_14_2

		table.insert(self.customSelectList_, arg_14_2)
	else
		self.customSelectTable_[arg_14_1] = nil
	end
end

function RaceTrialReadyView:RefreshUI()
	self:CalculatePoint()
	self:RefreshDesList(true)
	self.customScrollHelper_:StartScroll(#self.customTable_.all)
end

function RaceTrialReadyView:CalculatePoint()
	local var_16_1 = ActivityRaceTrialCfg[self.activityID_].base_point

	for iter_16_0, iter_16_1 in ipairs(self.customSelectList_) do
		var_16_1 = var_16_1 + ActivityAffixPoolCfg[iter_16_1].point
	end

	self.pointText_.text = string.format("<color=#FE972E>%d</color>", var_16_1)
end

function RaceTrialReadyView:RefreshDesList(arg_17_1, arg_17_2)
	if arg_17_1 then
		self.customDesScrollHelper_:StartScroll(#self.customSelectList_)
	else
		local var_17_0 = table.indexof(self.customSelectList_, arg_17_2)

		if var_17_0 then
			self.customDesScrollHelper_:StartScroll(#self.customSelectList_, var_17_0)
		else
			self.customDesScrollHelper_:StartScrollByPosition(#self.customSelectList_, self.customDesScrollHelper_:GetScrolledPosition())
		end
	end
end

function RaceTrialReadyView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		RaceTrialAction:SaveCustomList(self.activityID_, self.customSelectList_)
		self:Go("/home", nil, nil, true)
	end)
	manager.windowBar:RegistBackCallBack(function()
		RaceTrialAction:SaveCustomList(self.activityID_, self.customSelectList_)
		self:Back()
	end)
end

function RaceTrialReadyView:OnExit()
	manager.windowBar:HideBar()
end

function RaceTrialReadyView:Dispose()
	self:RemoveAllListeners()
	self.customScrollHelper_:Dispose()
	self.customDesScrollHelper_:Dispose()
	RaceTrialReadyView.super.Dispose(self)
end

return RaceTrialReadyView
