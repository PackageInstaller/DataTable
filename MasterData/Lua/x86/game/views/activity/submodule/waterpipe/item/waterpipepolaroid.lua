local WaterPipePolaroid = class("WaterPipePolaroid", ReduxView)

function WaterPipePolaroid:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1

	self:InitUI()
end

function WaterPipePolaroid:InitUI()
	self:BindCfgUI()

	self.stateController = self.controllerexcollection_:GetController("state")
end

function WaterPipePolaroid:RefreshUI(arg_3_1)
	self.normalImg_.sprite = WaterPipeData:GetPipePolaroidImg(arg_3_1, false)
	self.finishImg_.sprite = WaterPipeData:GetPipePolaroidImg(arg_3_1, true)

	if WaterPipeData:GetStageInfoByStageID(arg_3_1) then
		self.stateController:SetSelectedState("finish")
	else
		self.stateController:SetSelectedState("normal")
	end
end

function WaterPipePolaroid:Dispose()
	WaterPipePolaroid.super.Dispose(self)
end

return WaterPipePolaroid
