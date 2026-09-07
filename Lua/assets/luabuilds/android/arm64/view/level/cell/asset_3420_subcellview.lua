local DynamicCellView = import(".DynamicCellView")
local SpineCellView = import(".SpineCellView")
local SubCellView = class("SubCellView", DecorateClass(DynamicCellView, SpineCellView))

function SubCellView:Ctor(arg_1_1)
	DynamicCellView.Ctor(self, arg_1_1)
	SpineCellView.Ctor(self)
	SpineCellView.InitCellTransform(self)

	self.tfAmmo = self.tf:Find("ammo")
	self.tfAmmoText = self.tfAmmo:Find("text")
	self.showFlag = true
	self.shuihuaLoader = AutoLoader.New()

	self:LoadEffectShuihua()

	return
end

function SubCellView:GetOrder()
	return ChapterConst.CellPriorityFleet
end

function SubCellView:OverrideCanvas()
	SubCellView.super.OverrideCanvas(self)

	self.markCanvas = GetOrAddComponent(self.tf:Find("mark"), typeof(Canvas))
	self.markCanvas.overrideSorting = true

	return
end

function SubCellView:ResetCanvasOrder()
	SubCellView.super.ResetCanvasOrder(self)

	if not self.markCanvas then
		return
	end

	pg.ViewUtils.SetSortingOrder(self.markCanvas, self.line.row * ChapterConst.PriorityPerRow + ChapterConst.CellPriorityTopMark)

	return
end

function SubCellView:LoadEffectShuihua()
	self.shuihuaLoader:GetPrefab("Effect/" .. "qianting_01", "qianting_01", function(arg_6_0)
		self.effect_shuihua = arg_6_0

		tf(arg_6_0):SetParent(self.tf)

		tf(arg_6_0).localPosition = Vector3.zero

		setActive(arg_6_0, false)

		return
	end, "Shuihua")

	return
end

function SubCellView:PlayShuiHua()
	if not self.effect_shuihua then
		return
	end

	setActive(self.effect_shuihua, false)
	setActive(self.effect_shuihua, true)

	return
end

function SubCellView:SetActive(arg_8_1)
	self:SetActiveModel(arg_8_1)

	return
end

function SubCellView:SetActiveModel(arg_9_1)
	setActive(self.tfShadow, arg_9_1)
	self:SetSpineVisible(arg_9_1)

	return
end

function SubCellView:Clear()
	self.showFlag = nil

	self.shuihuaLoader:Clear()
	SpineCellView.ClearSpine(self)
	DynamicCellView.Clear(self)

	return
end

return SubCellView
