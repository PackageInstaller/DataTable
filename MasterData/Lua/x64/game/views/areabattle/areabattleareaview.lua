local AreaBattleAreaView = class("AreaBattleAreaView", ReduxView)

function AreaBattleAreaView:UIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.params_.activityId) .. "NormalfightingAreaUI"
end

function AreaBattleAreaView:UIParent()
	return manager.ui.uiMain.transform
end

function AreaBattleAreaView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AreaBattleAreaView:InitUI()
	self:BindCfgUI()

	self.itemList = {}
end

function AreaBattleAreaView:AddUIListener()
	return
end

function AreaBattleAreaView:UpdateView()
	for iter_6_0 = 1, 4 do
		local var_6_0 = self.itemList[iter_6_0]

		if not self.itemList[iter_6_0] then
			var_6_0 = AreaBattleAreaItem.New(self["item" .. iter_6_0 .. "Go_"])
			self.itemList[iter_6_0] = var_6_0
		end

		var_6_0:SetData(iter_6_0, ActivityCfg[self.activityID].sub_activity_list[iter_6_0], self.data[ActivityCfg[self.activityID].sub_activity_list[iter_6_0]], self.activityID)
	end

	self.titleTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_NAME")
end

function AreaBattleAreaView:UpdateData()
	self.activityID = self.params_.activityId
	self.data = ActivityAreaBattleData:GetDataByActivityID(self.activityID) or {}
end

function AreaBattleAreaView:AddTimer()
	self.stopTime_ = ActivityData:GetActivityData(self.activityID).stopTime
	self.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true))
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= self.stopTime_ then
			self.remainTxt_.text = GetTips("TIME_OVER")

			return
		end

		self.remainTxt_.text = string.format(GetTips("LEFT_TIME"), manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true))
	end, 1, -1)

	self.timer_:Start()
end

function AreaBattleAreaView:OnEnter()
	self:UpdateData()
	self:UpdateView()
	self:AddTimer()
end

function AreaBattleAreaView:OnExit()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	for iter_11_0, iter_11_1 in pairs(self.itemList) do
		iter_11_1:OnExit()
	end

	manager.windowBar:HideBar()
end

function AreaBattleAreaView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_AREA_BATTLE_DESCRIBE")
end

function AreaBattleAreaView:Dispose()
	for iter_13_0, iter_13_1 in pairs(self.itemList) do
		iter_13_1:Dispose()
	end

	self.itemList = {}

	AreaBattleAreaView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleAreaView
