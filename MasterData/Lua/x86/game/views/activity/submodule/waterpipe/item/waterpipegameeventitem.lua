local WaterPipeGameEventItem = class("WaterPipeGameEventItem", ReduxView)

function WaterPipeGameEventItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function WaterPipeGameEventItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.controllerexcollection_:GetController("state")
end

function WaterPipeGameEventItem:RefreshUI(arg_3_1)
	self.eventID = arg_3_1
	self.descText_.text = ActivityWaterPipeEventCfg[arg_3_1].event_desc

	self:ChangeState(false)
end

function WaterPipeGameEventItem:GetEventID()
	return self.eventID
end

function WaterPipeGameEventItem:SetOrder(arg_5_1)
	self.order = arg_5_1

	local var_5_0 = WaterPipeData:GetOrderImg(arg_5_1)

	if var_5_0 then
		self.indexImg_.sprite = var_5_0
	end
end

function WaterPipeGameEventItem:SetSiblingIndex()
	self.gameObject_.transform:SetSiblingIndex(self.order - 1)
end

function WaterPipeGameEventItem:ChangeState(arg_7_1)
	self.isFinish = arg_7_1

	self.stateController_:SetSelectedState(arg_7_1 and "finish" or "normal")
end

function WaterPipeGameEventItem:GetSDKStr()
	if self.isFinish then
		return self.eventID
	else
		return nil
	end
end

function WaterPipeGameEventItem:Dispose()
	WaterPipeGameEventItem.super.Dispose(self)
end

return WaterPipeGameEventItem
