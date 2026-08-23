local var_0_1 = g.core.const.ConstMgr.FurnitureConst
local var_0_2 = g.core.common.Path
local FurnitureFloorComp = class("FurnitureFloorComp", require("app.fairyGUI.furniture.UI_FurnitureFloorComp"))

function FurnitureFloorComp:ctor()
	self._floorFurnitureStruct = nil
	self._wallFurnitureStruct = nil
end

function FurnitureFloorComp:updateWithFurnitureStruct(arg_2_1)
	local var_2_0 = var_0_2:getFurniturePicByRes(arg_2_1:getInfo().res)

	if arg_2_1:getFurnitureType() == var_0_1.FURNITURE_TYPE.FLOOR then
		self.m_floorLoader:setURL(var_2_0, true)

		self._floorFurnitureStruct = arg_2_1
	else
		self.m_rightWallComp:updateWallGloader(var_2_0)
		self.m_leftWallComp:updateWallGloader(var_2_0)

		self._wallFurnitureStruct = arg_2_1
	end
end

function FurnitureFloorComp:getGridPos()
	return 0, 0
end

function FurnitureFloorComp:getFloorEditId()
	return self._floorFurnitureStruct:getEditId()
end

function FurnitureFloorComp:getWallEditId()
	return self._wallFurnitureStruct:getEditId()
end

function FurnitureFloorComp:getFloorId()
	return self._floorFurnitureStruct.furniture_id
end

function FurnitureFloorComp:getWallId()
	return self._wallFurnitureStruct.furniture_id
end

return FurnitureFloorComp
