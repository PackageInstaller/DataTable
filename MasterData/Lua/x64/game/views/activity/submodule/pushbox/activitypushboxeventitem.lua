local ActivityPushBoxEventItem = class("ActivityPushBoxEventItem", ReduxView)

function ActivityPushBoxEventItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivityPushBoxEventItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxEventItem:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.levelCon_ = ControllerUtil.GetController(self.transform_, "level")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.selectCon_ = ControllerUtil.GetController(self.transform_, "select")
end

function ActivityPushBoxEventItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
			saveData("activity_push_box", tostring(self.id_), 1)
			self.stateCon_:SetSelectedState("off")
		end

		if self.clickFunc_ then
			self.clickFunc_(self.id_, self.isClose_)
		end
	end)
end

function ActivityPushBoxEventItem:OnEnter()
	return
end

function ActivityPushBoxEventItem:SetData(arg_7_1)
	self.isClose_ = false
	self.id_ = arg_7_1
	self.cfg_ = ActivityCelebrationOrderCfg[arg_7_1]

	if self.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		self:RefreshBattle()
	elseif self.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		self:RefreshBox()
	end
end

function ActivityPushBoxEventItem:RefreshBattle()
	self.typeCon_:SetSelectedState("challenge")
	self.levelCon_:SetSelectedState(self.cfg_.hard)
end

function ActivityPushBoxEventItem:RefreshBox()
	self.typeCon_:SetSelectedState("box")
	self.stateCon_:SetSelectedState((getData("activity_push_box", tostring(self.id_)) or 0) == 0 and "on" or "off")
end

function ActivityPushBoxEventItem:RefreshCountDown(arg_10_1)
	self.isClose_ = true
	self.id_ = arg_10_1
	self.cfg_ = ActivityCelebrationOrderCfg[arg_10_1]

	if ActivityPushBoxData:GetNextID(self.cfg_.main_activity, self.id_) == 0 then
		self.typeCon_:SetSelectedState("finial")

		return
	end

	self.typeCon_:SetSelectedState("rest")

	self.cfg_ = ActivityCelebrationOrderCfg[arg_10_1]

	local var_10_0 = manager.time:GetServerTime()
	local var_10_1 = manager.time:GetNextFreshTime()

	self.countDownTxt_.text = manager.time:DescCDTime(var_10_1 - var_10_0)
	self.timer_ = Timer.New(function()
		var_10_0 = manager.time:GetServerTime()
		self.countDownTxt_.text = manager.time:DescCDTime(var_10_1 - var_10_0)
	end, 1, -1)

	self.timer_:Start()
end

function ActivityPushBoxEventItem:RegistClickFunc(arg_12_1)
	self.clickFunc_ = arg_12_1
end

function ActivityPushBoxEventItem:SetSelect(arg_13_1)
	if arg_13_1 ~= self.id_ then
		self.selectCon_:SetSelectedState("no")
	elseif self.cfg_.type == PushBoxConst.EVENT_TYPE.BATTLE then
		self.selectCon_:SetSelectedState("challenge")
	elseif self.cfg_.type == PushBoxConst.EVENT_TYPE.PUSH_BOX then
		self.selectCon_:SetSelectedState("box")
	end
end

function ActivityPushBoxEventItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityPushBoxEventItem:Show(arg_15_1)
	SetActive(self.gameObject_, arg_15_1)
	self:StopTimer()
end

function ActivityPushBoxEventItem:OnExit()
	self:StopTimer()
end

function ActivityPushBoxEventItem:Dispose()
	self:RemoveAllListeners()

	self.clickFunc_ = nil

	self.super.Dispose(self)
end

return ActivityPushBoxEventItem
