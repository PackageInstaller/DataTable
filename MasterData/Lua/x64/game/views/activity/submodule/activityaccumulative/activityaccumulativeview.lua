ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityAccumulativeView = class("ActivityAccumulativeView", ActivityMainBasePanel)

function ActivityAccumulativeView:GetUIName()
	return "Widget/Version/Alone_AccumulateUI/Alone_AccumulateUI"
end

function ActivityAccumulativeView:Init()
	ActivityAccumulativeView.super.Init(self)

	self.nodeList = {}
	self.drawIndex = 0
	self.taskUpdateHandler_ = handler(self, self.TaskUpdate)
	self.controller_ = self.lastControllerexcollection_:GetController("default0")
	self.taskScroll_ = LuaList.New(handler(self, self.RefreshItem), self.uilistUilist_, AccumulativeGachaItem)
end

function ActivityAccumulativeView:RefreshItem(arg_3_1, arg_3_2)
	arg_3_2:SetData(self.tasklist[arg_3_1], arg_3_1)

	if not self.tasklist[arg_3_1] or not self.tasklist[arg_3_1].state then
		-- block empty
	end
end

function ActivityAccumulativeView:OnEnter()
	ActivityAccumulativeView.super.OnEnter(self)
	self:TaskUpdate()

	self.contentTrs_.localPosition = Vector3.New(-222 * self.drawIndex, 0, 0)

	manager.notify:RegistListener(ACCUMULATIVEGACHA_UPDATE, self.taskUpdateHandler_)
end

function ActivityAccumulativeView:OnExit()
	ActivityAccumulativeView.super.OnExit(self)
	manager.notify:RemoveListener(ACCUMULATIVEGACHA_UPDATE, self.taskUpdateHandler_)
end

function ActivityAccumulativeView:Dispose()
	self.taskUpdateHandler_ = nil

	self.taskScroll_:Dispose()

	for iter_6_0, iter_6_1 in pairs(self.nodeList) do
		iter_6_1:Dispose()
	end

	ActivityAccumulativeView.super.Dispose(self)
end

function ActivityAccumulativeView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.GoToSystem("/draw", nil, ViewConst.SYSTEM_ID.DRAW)
	end)
	self:AddBtnListener(self.descbtnBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_ACCUMULATIVE_INSTRUCTIONS",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_ACCUMULATIVE_INSTRUCTIONS")
		})
	end)
end

function ActivityAccumulativeView:RefreshTimeText()
	if self.texttimeText_ then
		if self:isHasLeftTimeDes() then
			local var_10_0, var_10_1 = self:CheckAdvanceOpenTime()

			self.texttimeText_.text = var_10_1

			self:RefreshAcvanceStatus(not var_10_0)
		else
			self.texttimeText_.text = manager.time:GetLostTimeStrWith2Unit(self.stopTime_, true)
		end
	end
end

function ActivityAccumulativeView:isHasLeftTimeDes()
	return true
end

function ActivityAccumulativeView:TaskUpdate()
	self.tasklist = ActivityAccumulativeData:GetList(self.activityID_)

	self.taskScroll_:StartScroll(#self.tasklist)

	self.descnumTxt_.text = ActivityAccumulativeData:GetNum()

	local var_12_1 = 0
	local var_12_2 = 0
	local var_12_3 = 0
	local var_12_4 = ActivityAccumulativeData:GetNum()
	local var_12_5 = 0

	for iter_12_0 = 1, #self.tasklist do
		self.nodeList[iter_12_0] = self.nodeList[iter_12_0] or AccumulativeGachaPoint.New(self[string.format("point%sGo_", iter_12_0)])

		local var_12_6 = self.tasklist[iter_12_0]
		local var_12_7 = ActivityPointRewardCfg[self.tasklist[iter_12_0].id]

		var_12_1 = math.max(var_12_1, (ActivityPointRewardCfg[self.tasklist[iter_12_0].id] or nil) and (var_12_7.need or 0))

		if var_12_4 >= var_12_7.need then
			var_12_5 = iter_12_0
			var_12_3 = var_12_7.need
			var_12_2 = self.tasklist[iter_12_0 + 1] and ActivityPointRewardCfg[self.tasklist[iter_12_0 + 1].id].need or 0
		end

		if var_12_7 then
			if var_12_6.state == 2 then
				self.drawIndex = math.max(iter_12_0, self.drawIndex)
			end

			if ActivityAccumulativeData:GetNum() >= var_12_7.need then
				self.nodeList[iter_12_0]:SetIsDraw(true)
			else
				self.nodeList[iter_12_0]:SetIsDraw(false)
			end
		end
	end

	if var_12_1 ~= 0 then
		self.sliderSlr_.value = math.max(0, math.min(1, var_12_2 == 0 and 1 or var_12_5 == 0 and var_12_4 / var_12_2 * 0.061483739837398375 or 0.061483739837398375 + (var_12_5 - 1) * 0.10569105691056911 + (var_12_4 - var_12_3) / (var_12_2 - var_12_3) * 0.10569105691056911))
	end
end

return ActivityAccumulativeView
