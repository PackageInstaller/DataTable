local LevelCellView = class("LevelCellView")

function LevelCellView:Ctor()
	self.go = nil
	self.tf = nil
	self.orderTable = {}

	return
end

function LevelCellView:SetActive(arg_2_1)
	setActive(self.go, arg_2_1)

	return
end

function LevelCellView:GetOrder()
	return ChapterConst.CellPriorityNone
end

function LevelCellView:SetLoader(arg_4_1)
	assert(not self.loader, "repeatly Set loader")

	self.loader = arg_4_1

	return
end

function LevelCellView:GetLoader()
	self.loader = self.loader or AutoLoader.New()

	return self.loader
end

function LevelCellView:ClearLoader()
	if self.loader then
		self.loader:Clear()
	end

	return
end

function LevelCellView:GetLine()
	return self.line
end

function LevelCellView:SetLine(arg_8_1)
	self.line = {
		row = arg_8_1.row,
		column = arg_8_1.column
	}

	return
end

function LevelCellView:OverrideCanvas()
	pg.ViewUtils.SetLayer(tf(self.go), Layer.UI)

	self.canvas = GetOrAddComponent(self.go, typeof(Canvas))
	self.canvas.overrideSorting = true

	return
end

function LevelCellView:ResetCanvasOrder()
	if not self.canvas then
		return
	end

	pg.ViewUtils.SetSortingOrder(self.tf, self.line.row * ChapterConst.PriorityPerRow + self:GetOrder())
	self:OnCanvasUpDate()

	return
end

function LevelCellView:OnCanvasUpDate()
	return
end

function LevelCellView:GetCurrentOrder()
	return self.line.row * ChapterConst.PriorityPerRow + self:GetOrder()
end

function LevelCellView:AddCanvasOrder(arg_13_1, arg_13_2)
	arg_13_1 = tf(arg_13_1)

	for iter_13_0, iter_13_1 in ipairs((arg_13_1:GetComponents(typeof(Renderer)):ToTable())) do
		iter_13_1.sortingOrder = (self.orderTable[iter_13_1] or 0) + arg_13_2
	end

	local var_13_1 = arg_13_1:GetComponent(typeof(Canvas))

	if var_13_1 then
		var_13_1.sortingOrder = (self.orderTable[var_13_1] or 0) + arg_13_2
	end

	for iter_13_2 = 0, arg_13_1.childCount - 1 do
		self:AddCanvasOrder(arg_13_1:GetChild(iter_13_2), arg_13_2)
	end

	return
end

function LevelCellView:RecordCanvasOrder(arg_14_1)
	arg_14_1 = tf(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs((arg_14_1:GetComponents(typeof(Renderer)):ToTable())) do
		self.orderTable[iter_14_1] = iter_14_1.sortingOrder
	end

	local var_14_0 = arg_14_1:GetComponent(typeof(Canvas))

	if var_14_0 then
		self.orderTable[var_14_0] = var_14_0.sortingOrder
	end

	for iter_14_2 = 0, arg_14_1.childCount - 1 do
		self:RecordCanvasOrder(arg_14_1:GetChild(iter_14_2))
	end

	return
end

function LevelCellView:RefreshLinePosition(arg_15_1, arg_15_2)
	if arg_15_2 then
		self:SetLine(arg_15_2)
		self:ResetCanvasOrder()
	end

	self.tf.anchoredPosition = arg_15_1.theme:GetLinePosition(self.line.row, self.line.column)

	return
end

function LevelCellView:Clear()
	for iter_16_0, iter_16_1 in pairs(self.orderTable) do
		if not IsNil(iter_16_0) then
			iter_16_0.sortingOrder = iter_16_1
		end
	end

	table.clear(self.orderTable)
	self:ClearLoader()

	return
end

return LevelCellView
