local EquipBreakThroughResultHeroView = class("EquipBreakThroughResultHeroView", ReduxView)

function EquipBreakThroughResultHeroView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.heroItemList_ = {}

	for iter_1_0 = 1, 3 do
		self.heroItemList_[iter_1_0] = EquipBreakThroughResultHeroItem.New(self[string.format("heroGo%s_", iter_1_0)], iter_1_0)
	end
end

function EquipBreakThroughResultHeroView:SetData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self.heroItemList_) do
		iter_2_1:SetData(arg_2_1)
	end
end

function EquipBreakThroughResultHeroView:OnExit()
	for iter_3_0, iter_3_1 in ipairs(self.heroItemList_) do
		iter_3_1:OnExit()
	end
end

function EquipBreakThroughResultHeroView:Dispose()
	EquipBreakThroughResultHeroView.super.Dispose(self)

	for iter_4_0, iter_4_1 in ipairs(self.heroItemList_) do
		iter_4_1:Dispose()
	end

	self.heroItemList_ = nil
end

return EquipBreakThroughResultHeroView
