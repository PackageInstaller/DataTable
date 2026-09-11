local VehicleSelectItemView = class("VehicleSelectItemView", ReduxView)

function VehicleSelectItemView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function VehicleSelectItemView:Init()
	self:InitUI()
	self:AddUIListener()
end

function VehicleSelectItemView:InitUI()
	self:BindCfgUI()

	self.statusController_ = self.transCon_:GetController("status")
end

function VehicleSelectItemView:RefreshUI(arg_4_1, arg_4_2, arg_4_3)
	self.vehicleId_ = arg_4_1
	self.vehicleCfg_ = MergeBallVehicleCfg[self.vehicleId_]
	self.icon_.sprite = pureGetSpriteWithoutAtlas(self.vehicleCfg_.icon)
	self.isLock_ = arg_4_2
	self.isSelect_ = arg_4_3

	if self.isLock_ then
		self.statusController_:SetSelectedState("lock")
	else
		self:ShowSelect(self.isSelect_)
	end
end

function VehicleSelectItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips("MERGE_BALL_VEHICLE_LOCKED")

			return
		end

		self:clickFunc_()
	end)
end

function VehicleSelectItemView:RegisterClickListener(arg_7_1)
	self.clickFunc_ = arg_7_1
end

function VehicleSelectItemView:Dispose()
	VehicleSelectItemView.super.Dispose(self)
end

function VehicleSelectItemView:ShowSelect(arg_9_1)
	self.isSelect_ = arg_9_1

	self.statusController_:SetSelectedState(self.isSelect_ and "select" or "normal")
end

return VehicleSelectItemView
