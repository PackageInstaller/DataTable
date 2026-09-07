local IconFrame = class("IconFrame", import(".AttireFrame"))

function IconFrame:GetIcon()
	return "IconFrame/" .. self
end

function IconFrame:bindConfigTable()
	return pg.item_data_frame
end

function IconFrame:getType()
	return AttireConst.TYPE_ICON_FRAME
end

function IconFrame:getDropType()
	return DROP_TYPE_ICON_FRAME
end

function IconFrame:getPrefabName()
	return self:getConfig("id")
end

function IconFrame:getIcon()
	return IconFrame.GetIcon(self:getPrefabName())
end

return IconFrame
