local CultureGravureEquipPopItem = class("CultureGravureEquipPopItem", ReduxView)

function CultureGravureEquipPopItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function CultureGravureEquipPopItem:Init()
	self:InitUI()
end

function CultureGravureEquipPopItem:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.itemControl_:GetController("state")
	self.previewItems = {}

	for iter_3_0 = 1, 2 do
		self.previewItems[iter_3_0] = CultureGravureEquipPreviewItem.New(self["previewItem_" .. iter_3_0])
	end
end

function CultureGravureEquipPopItem:SetData(arg_4_1, arg_4_2)
	self.previewItems[1]:SetData(arg_4_1.equipedData, arg_4_1.state, false, arg_4_2)
	self.previewItems[2]:SetData(arg_4_1.recommendData, arg_4_1.state, true, arg_4_2)
	self.stateController_:SetSelectedState(arg_4_1.state == "had" and "had" or "nothad")
end

function CultureGravureEquipPopItem:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.previewItems) do
		iter_5_1:Dispose()
	end

	self.previewItems = nil

	CultureGravureEquipPopItem.super.Dispose(self)
end

return CultureGravureEquipPopItem
