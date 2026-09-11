local AccumulativeGachaPoint = class("AccumulativeGachaPoint", ReduxView)

function AccumulativeGachaPoint:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.controller_ = self.lastControllerexcollection_:GetController("default0")
end

function AccumulativeGachaPoint:SetIsDraw(arg_2_1)
	if arg_2_1 then
		self.controller_:SetSelectedState("light")
	else
		self.controller_:SetSelectedState("normal")
	end
end

function AccumulativeGachaPoint:SetPosX(arg_3_1)
	if self.gameObject_ then
		self.transform_.localPosition = Vector3.New(arg_3_1, 0, 0)
	end
end

function AccumulativeGachaPoint:Dispose()
	AccumulativeGachaPoint.super.Dispose(self)
end

return AccumulativeGachaPoint
