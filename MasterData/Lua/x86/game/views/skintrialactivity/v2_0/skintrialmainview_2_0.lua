local SkinTrialMainView_2_0 = class("SkinTrialMainView_2_0", ReduxView)

function SkinTrialMainView_2_0:Ctor(arg_1_1, arg_1_2)
	self.activityID_ = arg_1_2
	self.gameObject_ = Object.Instantiate(Asset.Load(self:UIName()), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SkinTrialMainView_2_0:Init()
	self:BindCfgUI()
	self:AddListener()

	self.scrollList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, self:GetItemClass())
	self.outOfDataHandler_ = handler(self, self.OnOutOfData)
end

function SkinTrialMainView_2_0:UIName()
	return SkinTrialTools.GetMainViewUIName(self.activityID_)
end

function SkinTrialMainView_2_0:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SkinTrialMainView_2_0:AddListener()
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKIN_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")
		})
	end)
end

function SkinTrialMainView_2_0:OnEnter()
	self.stopTime_ = ActivityData:GetActivityData(self.activityID_).stopTime

	SkinTrialData:SaveSkinTrialMainScrollPos(nil, "Global")
end

function SkinTrialMainView_2_0:OnExit()
	self:StopTimer()

	self.scrollPos_ = self.scrollList_:GetScrolledPosition()

	SkinTrialData:SaveSkinTrialMainScrollPos(self.scrollPos_, "Global")
end

function SkinTrialMainView_2_0:Dispose()
	SkinTrialMainView_2_0.super.Dispose(self)
	self:StopTimer()

	self.outOfDataHandler_ = nil

	self.scrollList_:Dispose()

	self.scrollList_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function SkinTrialMainView_2_0:RefreshUI()
	self.skinTrialIDList_ = self:GetskinTrialIDList()

	self:RefreshSkinItem()
end

function SkinTrialMainView_2_0:GetskinTrialIDList()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(ActivityData:GetActivityData(self.activityID_).subActivityIdList) do
		if ActivityData:GetActivityIsOpen(iter_11_1) then
			for iter_11_2, iter_11_3 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[iter_11_1]) do
				table.insert(var_11_0, iter_11_3)
			end
		end
	end

	return var_11_0
end

function SkinTrialMainView_2_0:RefreshSkinItem()
	local var_12_0 = self.scrollPos_

	if SkinTrialData:GetSkinTrialMainScrollPos("Back") then
		var_12_0 = SkinTrialData:GetSkinTrialMainScrollPos("Back")

		SkinTrialData:SaveSkinTrialMainScrollPos(nil, "Back")
	end

	self.scrollList_:StartScrollByPosition(#self.skinTrialIDList_, var_12_0)
end

function SkinTrialMainView_2_0:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetSkinTrialID(self.skinTrialIDList_[arg_13_1])
	arg_13_2:SetOutOfDataHandler(self.outOfDataHandler_)
end

function SkinTrialMainView_2_0:GetItemClass()
	return SkinTrialSelectItem_2_0
end

function SkinTrialMainView_2_0:AddTimer()
	if manager.time:GetServerTime() >= self.stopTime_ then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(self.scrollList_:GetItemList()) do
		iter_15_1:RefreshTime()
	end

	self:StopTimer()

	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self:StopTimer()

			return
		end

		for iter_16_0, iter_16_1 in ipairs(self.scrollList_:GetItemList()) do
			iter_16_1:RefreshTime()
		end
	end, 1, -1)

	self.timer_:Start()
end

function SkinTrialMainView_2_0:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function SkinTrialMainView_2_0:Show(arg_18_1)
	SetActive(self.gameObject_, arg_18_1)

	if arg_18_1 == true then
		self:AddTimer()
		self:RefreshUI()
	else
		self:StopTimer()
	end
end

function SkinTrialMainView_2_0:OnOutOfData()
	self:RefreshUI()
	self:AddTimer()
end

return SkinTrialMainView_2_0
