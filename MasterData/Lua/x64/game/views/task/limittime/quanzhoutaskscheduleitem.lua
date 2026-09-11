local QuanZhouTaskScheduleItem = class("QuanZhouTaskScheduleItem", ReduxView)

function QuanZhouTaskScheduleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function QuanZhouTaskScheduleItem:Init()
	self:InitUI()
end

function QuanZhouTaskScheduleItem:InitUI()
	self:BindCfgUI()

	self.item_ = CommonItemView.New(self.itemGo_, true)
end

function QuanZhouTaskScheduleItem:SetData(arg_4_1, arg_4_2)
	self.taskID_ = arg_4_1
	self.callback_ = arg_4_2

	self:UpdateView()
end

function QuanZhouTaskScheduleItem:UpdateView()
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = AssignmentCfg[self.taskID_].reward[1][1]
	var_5_0.number = AssignmentCfg[self.taskID_].reward[1][2]
	var_5_0.pointRewardData = AssignmentCfg[self.taskID_].reward
	var_5_0.taskID = self.taskID_
	var_5_0.clickFun = self.callback_

	self.item_:SetData(var_5_0)

	self.numText_.text = tostring(AssignmentCfg[self.taskID_].need)
end

function QuanZhouTaskScheduleItem:GetTaskID()
	return self.taskID_
end

function QuanZhouTaskScheduleItem:RefreshSlider(arg_7_1, arg_7_2)
	self.slider_.value = arg_7_1 / arg_7_2

	if arg_7_2 <= arg_7_1 then
		SetActive(self.pointGo_, true)
	else
		SetActive(self.pointGo_, false)
	end
end

function QuanZhouTaskScheduleItem:RefreshCompleted(arg_8_1)
	self.item_:RefreshCompleted(arg_8_1)
end

function QuanZhouTaskScheduleItem:RefreshHighLight(arg_9_1)
	self.item_:RefreshHighLight(arg_9_1)
end

function QuanZhouTaskScheduleItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)

	if arg_10_1 then
		-- block empty
	end
end

function QuanZhouTaskScheduleItem:OnExit()
	return
end

function QuanZhouTaskScheduleItem:Dispose()
	self.item_:Dispose()
	QuanZhouTaskScheduleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return QuanZhouTaskScheduleItem
