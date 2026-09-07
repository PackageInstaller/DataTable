local WallCell = class("WallCell", StereoCellView)

function WallCell:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	WallCell.super.Ctor(self, arg_1_1, arg_1_2)

	self.direction = arg_1_3
	self.anchor = arg_1_4
	self.BanCount = 0
	self.WallPrefabs = nil
	self.girdParent = nil

	return
end

function WallCell:GetOrder()
	return ChapterConst.CellPriorityFleet
end

function WallCell:OverrideCanvas()
	pg.ViewUtils.SetLayer(tf(self.go), Layer.UI)

	return
end

function WallCell:ResetCanvasOrder()
	pg.ViewUtils.SetSortingOrder(self.tf, math.floor(self.line.row * 0.5) * ChapterConst.PriorityPerRow + self:GetOrder())

	return
end

function WallCell:RefreshDirection()
	setParent(self.tf, self.girdParent.cellRoot)

	self.tf.localRotation = Quaternion.Euler(self.direction and 0.1 or -90, 90, -90)
	self.tf.anchoredPosition3D = self.anchor

	return
end

function WallCell:SetAsset(arg_6_1)
	if not arg_6_1 or #arg_6_1 == 0 then
		return
	end

	self.assetName = arg_6_1

	self:UpdateView()

	return
end

function WallCell:UpdateView()
	self:UpdateGO("effect/" .. self.assetName, self.assetName)
	self.buffer:RefreshDirection()

	return
end

return WallCell
