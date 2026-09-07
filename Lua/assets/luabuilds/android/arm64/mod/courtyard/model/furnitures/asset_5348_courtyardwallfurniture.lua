local CourtYardWallFurniture = class("CourtYardWallFurniture", import(".CourtYardFurniture"))

function CourtYardWallFurniture:Ctor(arg_1_1, arg_1_2)
	pg.furniture_data_template[arg_1_2.configId or arg_1_2.id].size[2] = 1

	CourtYardWallFurniture.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function CourtYardWallFurniture:Init(arg_2_1)
	self:UpdatePosition(arg_2_1)

	return
end

function CourtYardWallFurniture:UpdatePosition(arg_3_1)
	self:SetPosition(arg_3_1)
	self:SetDir(self:GetDirection())

	return
end

function CourtYardWallFurniture:GetInitSize()
	if self:RightDirectionLimited() then
		return {
			{
				self.sizeY,
				self.sizeX
			}
		}
	elseif self:LeftDirectionLimited() then
		return {
			{
				self.sizeX,
				self.sizeY
			}
		}
	else
		return {
			{
				self.sizeX,
				self.sizeY
			},
			{
				self.sizeY,
				self.sizeX
			}
		}
	end

	return
end

function CourtYardWallFurniture:_GetDirection(arg_5_1)
	if self:RightDirectionLimited() then
		return 2
	elseif self:LeftDirectionLimited() then
		return 1
	elseif arg_5_1.y - arg_5_1.x >= 1 then
		return 1
	else
		return 2
	end

	return
end

function CourtYardWallFurniture:GetWidth()
	return self.config.size[1]
end

function CourtYardWallFurniture:GetDirection()
	return self:_GetDirection((self:GetPosition()))
end

function CourtYardWallFurniture:Rotate()
	return
end

function CourtYardWallFurniture:InActivityRange(arg_9_1)
	local var_9_0 = self:GetHost():GetStorey():GetRange()

	return (arg_9_1.x == var_9_0.x or arg_9_1.y == var_9_0.y) and arg_9_1.x ~= arg_9_1.y
end

function CourtYardWallFurniture:LeftDirectionLimited()
	return self.config.belong == 3
end

function CourtYardWallFurniture:RightDirectionLimited()
	return self.config.belong == 4
end

function CourtYardWallFurniture:NormalizePosition(arg_12_1, arg_12_2)
	local var_12_0 = self:GetHost():GetStorey()
	local var_12_1 = var_12_0:GetRange().x
	local var_12_2 = self:_GetDirection(arg_12_1) == 1
	local var_12_3 = var_12_2 and Vector2(arg_12_1.x, arg_12_1.y) or Vector2(arg_12_1.y, arg_12_1.x)
	local var_12_4 = math.max(arg_12_2, (math.min(var_12_0.x, var_12_1 - self:GetWidth())))
	local var_12_5 = var_12_2 and Vector2(var_12_4, var_12_1) or Vector2(var_12_1, var_12_4)

	self:SetDir(self:_GetDirection(var_12_5))

	return var_12_5
end

function CourtYardWallFurniture:SetDir(arg_13_1)
	CourtYardWallFurniture.super.SetDir(self, arg_13_1)
	self:DispatchEvent(CourtYardEvent.ROTATE_FURNITURE, self.dir)

	return
end

function CourtYardWallFurniture:CanPutChild()
	return false
end

return CourtYardWallFurniture
