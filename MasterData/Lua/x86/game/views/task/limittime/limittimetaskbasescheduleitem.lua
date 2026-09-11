local LimitTimeTaskBaseScheduleItem = class("LimitTimeTaskBaseScheduleItem", ReduxView)

function LimitTimeTaskBaseScheduleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function LimitTimeTaskBaseScheduleItem:Init()
	self:InitUI()
end

function LimitTimeTaskBaseScheduleItem:InitUI()
	self:BindCfgUI()

	self.item_ = CommonItemView.New(self.itemGo_, true)
end

function LimitTimeTaskBaseScheduleItem:SetData(arg_4_1, arg_4_2)
	self.taskID_ = arg_4_1
	self.callback_ = arg_4_2

	self:UpdateView()
end

function LimitTimeTaskBaseScheduleItem:UpdateView()
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = AssignmentCfg[self.taskID_].reward[1][1]
	var_5_0.number = AssignmentCfg[self.taskID_].reward[1][2]
	var_5_0.pointRewardData = AssignmentCfg[self.taskID_].reward
	var_5_0.taskID = self.taskID_
	var_5_0.clickFun = self.callback_

	self.item_:SetData(var_5_0)

	self.numText_.text = tostring(AssignmentCfg[self.taskID_].need)
end

function LimitTimeTaskBaseScheduleItem:GetTaskID()
	return self.taskID_
end

function LimitTimeTaskBaseScheduleItem:RefreshSlider(arg_7_1, arg_7_2, arg_7_3)
	self.slider_.value = arg_7_1 / arg_7_2

	if arg_7_2 <= arg_7_1 then
		SetActive(self.pointGo_, true)

		if self.animGo_ then
			if arg_7_3 then
				SetActive(self.animGo_.gameObject, false)
			else
				SetActive(self.animGo_.gameObject, true)
				self.animGo_:Play("UI_rot_loop", 0, 0)
				self.animGo_:Update(0)
			end
		end
	else
		SetActive(self.pointGo_, false)

		if self.animGo_ then
			SetActive(self.animGo_.gameObject, false)
			self.animGo_:Update(0)
		end
	end
end

function LimitTimeTaskBaseScheduleItem:RefreshCompleted(arg_8_1)
	self.item_:RefreshCompleted(arg_8_1)
end

function LimitTimeTaskBaseScheduleItem:RefreshHighLight(arg_9_1)
	self.item_:RefreshHighLight(arg_9_1)
end

function LimitTimeTaskBaseScheduleItem:Show(arg_10_1)
	SetActive(self.gameObject_, arg_10_1)
end

function LimitTimeTaskBaseScheduleItem:OnExit()
	return
end

function LimitTimeTaskBaseScheduleItem:Dispose()
	self.item_:Dispose()
	LimitTimeTaskBaseScheduleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return LimitTimeTaskBaseScheduleItem
