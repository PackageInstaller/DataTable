local DynamicCellView = import(".DynamicCellView")
local ChampionCellView = import(".ChampionCellView")
local DynamicChampionCellView = class("DynamicChampionCellView", DecorateClass(DynamicCellView, ChampionCellView))

function DynamicChampionCellView:Ctor(arg_1_1)
	DynamicCellView.Ctor(self, arg_1_1)
	ChampionCellView.Ctor(self)
	ChampionCellView.InitChampionCellTransform(self)

	return
end

function DynamicChampionCellView:GetOrder()
	return ChapterConst.CellPriorityEnemy
end

function DynamicChampionCellView:SetActive(arg_3_1)
	self:SetActiveModel(arg_3_1)

	return
end

function DynamicChampionCellView:SetActiveModel(arg_4_1)
	self:SetSpineVisible(arg_4_1)
	setActive(self.tfShadow, arg_4_1)

	for iter_4_0, iter_4_1 in pairs(self._extraEffectList) do
		if not IsNil(iter_4_1) then
			setActive(iter_4_1, arg_4_1)
		end
	end

	return
end

function DynamicChampionCellView.PlayShuiHua()
	return
end

function DynamicChampionCellView:UpdateChampionCell(arg_6_1, arg_6_2, arg_6_3)
	ChampionCellView.UpdateChampionCell(self, arg_6_1, arg_6_2, arg_6_3)
	self:RefreshLinePosition(arg_6_1, arg_6_2)

	return
end

function DynamicChampionCellView:TweenShining(arg_7_1)
	self:StopTween()

	local var_7_0 = self:GetSpineRole()

	if not var_7_0 then
		return
	end

	var_7_0:TweenShining(0.5, arg_7_1, 0, 1, Color.New(0, 0, 0, 0), Color.New(1, 1, 1, 1), true, true)

	return
end

function DynamicChampionCellView:StopTween()
	if not self.tweenId then
		return
	end

	LeanTween.cancel(self.tweenId, true)

	self.tweenId = nil

	return
end

function DynamicChampionCellView:Clear()
	self:StopTween()

	if self.go then
		LeanTween.cancel(self.go)
	end

	ChampionCellView.Clear(self)

	return
end

return DynamicChampionCellView
