local WSMapItem = class("WSMapItem", import("...BaseEntity"))

WSMapItem.Fields = {
	cell = "table",
	theme = "table",
	rtArtifacts = "userdata",
	transform = "userdata"
}

function WSMapItem.GetResName()
	return "world_cell_item"
end

function WSMapItem:GetName(arg_2_1)
	return "item_" .. self .. "_" .. arg_2_1
end

function WSMapItem:Setup(arg_3_1, arg_3_2)
	self.cell = arg_3_1
	self.theme = arg_3_2

	self:Init()

	return
end

function WSMapItem:Dispose()
	self:Clear()

	return
end

function WSMapItem:Init()
	self.transform.name = WSMapItem.GetName(self.cell.row, self.cell.column)
	self.transform.anchoredPosition = self.theme:GetLinePosition(self.cell.row, self.cell.column)
	self.transform.sizeDelta = self.theme.cellSize
	self.rtArtifacts = self.transform:Find("artifacts")
	self.rtArtifacts.localEulerAngles = Vector3(-self.theme.angle, 0, 0)

	return
end

return WSMapItem
