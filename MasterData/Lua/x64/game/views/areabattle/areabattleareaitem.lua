local AreaBattleAreaItem = class("AreaBattleAreaItem", ReduxView)

function AreaBattleAreaItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AreaBattleAreaItem:Init()
	self:InitUI()
end

function AreaBattleAreaItem:InitUI()
	self:BindCfgUI()

	self.controller = self.controller_:GetController("state")

	self:AddBtnListener(self.clickBtn_, nil, function()
		JumpTools.GoToSystem("/AreaBattleMapView", {
			selectIndex = 999,
			index = self.index,
			activityID = self.activityID,
			mainActivityID = self.mainActivityID
		})
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, self.activityID), 0)
		saveData("AREA_BATTLE", string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA_NEW, self.activityID), "1")
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		ShowTips(string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(self.startTime_)))
	end)
end

function AreaBattleAreaItem:SetData(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self.index = arg_6_1
	self.cfg = ActivityAreaBattleCfg[arg_6_2]
	self.data = arg_6_3
	self.activityID = arg_6_2
	self.mainActivityID = arg_6_4

	self:AddTimer()
	self:UpdateView()
	self:BindRedPoint()
end

function AreaBattleAreaItem:BindRedPoint()
	manager.redPoint:bindUIandKey(self.gameObject_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA, self.activityID))
end

function AreaBattleAreaItem:AddTimer()
	local var_8_0 = ActivityData:GetActivityData(self.activityID)

	self.stopTime_ = var_8_0.stopTime
	self.startTime_ = var_8_0.startTime
	self.lockTxt_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(self.startTime_))
	self.timer = Timer.New(function()
		self:UpdateController()
	end, 1, -1)

	self.timer:Start()
end

function AreaBattleAreaItem:UpdateController()
	if manager.time:GetServerTime() >= self.startTime_ then
		self.lockTxt_.text = GetTips("TIME_OVER")

		self.controller:SetSelectedState("normal")

		local var_10_0, var_10_1 = TaskTools.GetCompleteTaskNumInfo(self.activityID)

		if var_10_1 <= var_10_0 then
			self.controller:SetSelectedState("complete")
		end

		return
	end

	self.lockTxt_.text = string.format(GetTips("ACTIVITY_AREA_BATTLE_UNLOCK_TIME"), manager.time:GetLostTimeStr(self.startTime_))

	self.controller:SetSelectedState("lock")
end

function AreaBattleAreaItem:UpdateView()
	self:UpdateController()

	self.areaTxt_.text = self.cfg.name

	local var_11_0, var_11_1 = TaskTools.GetCompleteTaskNumInfo(self.activityID)

	self.rewardTxt_.text = var_11_0 .. "/" .. var_11_1
	self.areaNameTxt_.text = self.cfg.name
end

function AreaBattleAreaItem:OnEnter()
	self:UpdateView()
end

function AreaBattleAreaItem:OnExit()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:UnbindRedPoint()
end

function AreaBattleAreaItem:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.gameObject_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_AREA_BATTLE_AREA, self.activityID))
end

function AreaBattleAreaItem:Dispose()
	AreaBattleAreaItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleAreaItem
