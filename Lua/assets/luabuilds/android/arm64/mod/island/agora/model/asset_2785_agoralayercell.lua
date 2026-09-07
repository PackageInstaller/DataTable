local AgoraLayerCell = class("AgoraLayerCell")

function AgoraLayerCell:Ctor(arg_1_1)
	self.position = arg_1_1
	self.id = 0
	self.shapeId = -1

	return
end

function AgoraLayerCell:Fill(arg_2_1, arg_2_2)
	self.id = arg_2_1
	self.shapeId = arg_2_2

	return
end

function AgoraLayerCell:IsEmpty()
	return self.id == 0 or self.shapeId < 0
end

function AgoraLayerCell:IsSameValue(arg_4_1, arg_4_2)
	return self.id == arg_4_1 and self.shapeId == arg_4_2
end

function AgoraLayerCell:GetPosition()
	return self.position
end

function AgoraLayerCell:GetShapeId()
	return self.shapeId
end

function AgoraLayerCell:GetID()
	return self.id
end

function AgoraLayerCell:GetModel()
	if self:IsEmpty() then
		return ""
	end

	return pg.island_furniture_template[math.floor(self.id / 100)].model
end

function AgoraLayerCell:Clear()
	self.id = 0
	self.shapeId = -1

	return
end

function AgoraLayerCell:ToPlacementData()
	local var_10_0 = self:GetPosition()

	return {
		x = var_10_0.x,
		y = var_10_0.y,
		id = self.id,
		shapeId = self:GetShapeId()
	}
end

function AgoraLayerCell:IsSame(arg_11_1)
	return self.id == arg_11_1.id and self.shapeId == arg_11_1.shapeId
end

return AgoraLayerCell
