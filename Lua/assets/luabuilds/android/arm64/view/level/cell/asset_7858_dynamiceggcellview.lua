local DynamicCellView = import(".DynamicCellView")
local EggCellView = import(".EggCellView")
local DynamicEggCellView = class("DynamicEggCellView", DecorateClass(DynamicCellView, EggCellView))

function DynamicEggCellView:Ctor(arg_1_1)
	DynamicCellView.Ctor(self, arg_1_1)
	EggCellView.Ctor(self)
	EggCellView.InitEggCellTransform(self)

	return
end

function DynamicEggCellView:GetOrder()
	return ChapterConst.CellPriorityEnemy
end

function DynamicEggCellView:SetActive(arg_3_1)
	setActive(self.go, arg_3_1)

	return
end

function DynamicEggCellView:LoadIcon(arg_4_1, arg_4_2, arg_4_3)
	if self.lastPrefab == arg_4_1 then
		existCall(arg_4_3)

		return
	end

	self.lastPrefab = arg_4_1

	EggCellView.StartEggCellView(self, arg_4_2, arg_4_3)

	return
end

function DynamicEggCellView:UpdateChampionCell(arg_5_1, arg_5_2, arg_5_3)
	EggCellView.UpdateEggCell(self, arg_5_1, arg_5_2, arg_5_2:getConfigTable(), arg_5_3)
	self:RefreshLinePosition(arg_5_1, arg_5_2)

	return
end

return DynamicEggCellView
