local ActivityToggleView = class("ActivityToggleView", ReduxView)

function ActivityToggleView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")

	if arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.SIGN then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.NEWBIE_SIGN)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.TASK then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.NEWBIE_TASK)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.UPGRADE then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.NEWBIE_UPGRADE)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.DAILY_TASK then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.NEWBIE_DAILY_TASK)
	elseif arg_1_2 == ActivityConst.NEWBIE_ACTIVITY_TYPE.RECHARGE then
		manager.redPoint:bindUIandKey(self.transform_, RedPointConst.NEWBIE_RECHARGE)
	end
end

function ActivityToggleView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:Go("/activityNewbie", {
			activityType = self.index_
		})
	end)
end

function ActivityToggleView:SetSelect(arg_4_1)
	if self.index_ == arg_4_1 then
		self.controller_:SetSelectedState("0")
	else
		self.controller_:SetSelectedState("1")
	end
end

function ActivityToggleView:Dispose()
	ActivityToggleView.super.Dispose(self)
	manager.redPoint:unbindUIandKey(self.transform_)
end

return ActivityToggleView
