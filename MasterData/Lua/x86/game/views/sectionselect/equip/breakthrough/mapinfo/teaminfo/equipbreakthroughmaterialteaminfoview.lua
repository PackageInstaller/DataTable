local EquipBreakThroughMaterialTeamInfoView = class("EquipBreakThroughMaterialTeamInfoView", ReduxView)

function EquipBreakThroughMaterialTeamInfoView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.itemList_ = {}
end

function EquipBreakThroughMaterialTeamInfoView:OnEnter()
	for iter_2_0 = 1, 3 do
		if self.itemList_[iter_2_0] == nil then
			self.itemList_[iter_2_0] = EquipBreakThroughMaterialTeamInfoItem.New(self.itemGo_, self.itemParent_, iter_2_0)
		end

		self.itemList_[iter_2_0]:OnEnter()
	end
end

function EquipBreakThroughMaterialTeamInfoView:OnEixt()
	for iter_3_0, iter_3_1 in ipiars(itemList_) do
		iter_3_1:OnExit()
	end
end

function EquipBreakThroughMaterialTeamInfoView:Dispose()
	EquipBreakThroughMaterialTeamInfoView.super.Dispose(self)

	for iter_4_0, iter_4_1 in ipairs(self.itemList_) do
		iter_4_1:Dispose()
	end

	self.itemList_ = nil
end

return EquipBreakThroughMaterialTeamInfoView
