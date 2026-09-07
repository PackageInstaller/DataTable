local StereoCellView = class("StereoCellView", import("view.level.cell.LevelCellView"))

function StereoCellView:Ctor(arg_1_1, arg_1_2)
	StereoCellView.super.Ctor(self)

	self.assetName = nil
	self.line = {
		row = arg_1_1,
		column = arg_1_2
	}
	self.buffer = FuncBuffer.New()

	return
end

function StereoCellView:UpdateGO(arg_2_1, arg_2_2)
	local var_2_0 = self:GetLoader():GetRequestPackage("main")

	if var_2_0 and var_2_0.name == self.assetName then
		return
	end

	self.buffer:Clear()
	self.buffer:SetNotifier(nil)
	self:GetLoader():GetPrefab(arg_2_1, arg_2_2, function(arg_3_0)
		self.go = arg_3_0
		self.tf = self.go.transform

		self:OnLoaded(arg_3_0)
		self.buffer:SetNotifier(self)
		self.buffer:ExcuteAll()
		self:OverrideCanvas()
		self:ResetCanvasOrder()

		return
	end, "main")

	return
end

function StereoCellView:OnLoaded(arg_4_1)
	return
end

return StereoCellView
