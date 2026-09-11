local EquipBreakThroughMaterialBuffView = class("EquipBreakThroughMaterialBuffView", ReduxView)

function EquipBreakThroughMaterialBuffView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.buffList_ = LuaList.New(handler(self, self.RefreshBuffItem), self.buffUIList_, EquipBreakThroughMaterialBuffItem)
	self.attributeList_ = LuaList.New(handler(self, self.RefreshAttributeItem), self.attributeUIList_, EquipBreakThroughMaterialAttributeItem)
end

function EquipBreakThroughMaterialBuffView:OnEnter()
	self.buffDataList_ = EquipBreakThroughMaterialData:GetBuffList()

	self.buffList_:StartScroll(#self.buffDataList_)

	self.attributeDataList_ = EquipBreakThroughMaterialData:GetAttributeList()
	self.itemIDList_ = {}

	for iter_2_0, iter_2_1 in pairs(self.attributeDataList_) do
		table.insert(self.itemIDList_, iter_2_0)
	end

	self.attributeList_:StartScroll(#self.itemIDList_)
end

function EquipBreakThroughMaterialBuffView:OnEixt()
	return
end

function EquipBreakThroughMaterialBuffView:Dispose()
	EquipBreakThroughMaterialBuffView.super.Dispose(self)
	self.buffList_:Dispose()

	self.buffList_ = nil

	self.attributeList_:Dispose()

	self.attributeList_ = nil
end

function EquipBreakThroughMaterialBuffView:RefreshBuffItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.buffDataList_[arg_5_1])
end

function EquipBreakThroughMaterialBuffView:RefreshAttributeItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.itemIDList_[arg_6_1], self.attributeDataList_[self.itemIDList_[arg_6_1]])
end

return EquipBreakThroughMaterialBuffView
