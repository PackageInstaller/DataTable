local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local var_0_1 = g.core.const.ConstMgr.FurnitureConst.FURNITURE_TYPE
local var_0_2 = g.core.const.ConstMgr.FurnitureConst.CAN_PLACE_CTRL_IDX
local var_0_3 = g.core.const.ConstMgr.FurnitureConst.PLACE_END_CTRL_IDX
local var_0_4 = g.core.const.ConstMgr.FurnitureConst.ROLE_ACTION
local FurnitureFriendItemComp = class("FurnitureFriendItemComp", require("app.fairyGUI.furniture.UI_FurnitureFriendItemComp"))

function FurnitureFriendItemComp:ctor()
	self._isUse = false
	self._furnitureStruct = nil
end

function FurnitureFriendItemComp:initInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	self:updateWithFurnitureStruct(arg_2_1)
	self:setTouchable(false)
end

function FurnitureFriendItemComp:updateWithFurnitureStruct(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._furnitureStruct = clone(arg_3_1)

	self.m_furnitureCell:updateFurnitureCell((arg_3_1:getInfo()))

	local var_3_0 = arg_3_1:isSpin()

	self.m_furnitureCell:setScaleX(var_3_0 and -1 or 1)
	self.m_furnitureCell:setSpinImg(var_3_0)
end

function FurnitureFriendItemComp:getFurnitureStruct()
	return self._furnitureStruct
end

function FurnitureFriendItemComp:getInfo()
	return self._furnitureStruct:getInfo()
end

function FurnitureFriendItemComp:getFurnitureId()
	return self._furnitureStruct.furniture_id
end

function FurnitureFriendItemComp:setSpin(arg_7_1)
	self._furnitureStruct:setSpin(arg_7_1)
	self.m_furnitureCell:setScaleX(arg_7_1 and -1 or 1)
	self.m_furnitureCell:setSpinImg(arg_7_1)
end

function FurnitureFriendItemComp:isSpin()
	return self._furnitureStruct:isSpin()
end

function FurnitureFriendItemComp:getGridPos()
	return self._furnitureStruct.x, self._furnitureStruct.y
end

function FurnitureFriendItemComp:setGridPos(arg_10_1, arg_10_2)
	self._furnitureStruct:setGridPos(arg_10_1, arg_10_2)
end

function FurnitureFriendItemComp:getFurnitureEditId()
	return self._furnitureStruct:getEditId()
end

function FurnitureFriendItemComp:getPlaceLevel()
	return self._furnitureStruct.level
end

function FurnitureFriendItemComp:setHighLight(arg_13_1)
	self.m_furnitureCell:setFurnitureLightImg(arg_13_1)
end

function FurnitureFriendItemComp:isRoleCanRunSpecialAction(arg_14_1)
	if arg_14_1 ~= nil then
		if self.m_furnitureCell:isSpineResource() and not self.m_furnitureCell:getFurnitureSpine() then
			return false
		end

		if arg_14_1 ~= var_0_0.ROLE_ACTION.EMPTY then
			return math.random(1000) <= self._furnitureStruct:getInfo().probability
		end
	elseif self:isUsing() then
		return false
	else
		return self:getSpecialAction() ~= var_0_4.EMPTY
	end
end

function FurnitureFriendItemComp:isInFurniture(arg_15_1)
	local var_15_0 = self:getHoldOnGrid()

	for iter_15_0 = 1, #var_15_0 do
		if var_15_0[iter_15_0].order == arg_15_1 then
			return true
		end
	end
end

function FurnitureFriendItemComp:getFurnitureType()
	return self._furnitureStruct:getFurnitureType()
end

function FurnitureFriendItemComp:getSpecialAction()
	local var_17_0 = var_0_0.ROLE_ACTION.EMPTY

	if self._furnitureStruct:getInfo().probability > 0 then
		local var_17_1 = self._furnitureStruct:getFurnitureType()

		if var_17_1 == var_0_1.BED then
			var_17_0 = var_0_0.ROLE_ACTION.REST
		elseif var_17_1 == var_0_1.SOFA or var_17_1 == var_0_1.TABLE_CHAIR then
			var_17_0 = var_0_0.ROLE_ACTION.SIT
		elseif var_17_1 == var_0_1.BATH_CROCK then
			var_17_0 = var_0_0.ROLE_ACTION.BATH
		end
	end

	return var_17_0
end

function FurnitureFriendItemComp:getPosList()
	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = self._furnitureStruct:getInfo()

	if self:isSpin() then
		var_18_1 = var_18_2.width
		var_18_0 = var_18_2.length
	else
		var_18_1 = var_18_2.length
		var_18_0 = var_18_2.width
	end

	if self._furnitureStruct:getFurnitureType() == var_0_0.FURNITURE_TYPE.WALL_DECORATION then
		local var_18_3 = {}

		table.insert(var_18_3, {
			x = 0,
			y = 0
		})

		return var_18_3
	end

	local var_18_4 = {}
	local var_18_5, var_18_6 = self:getGridPos()

	for iter_18_0 = 1, var_18_0 do
		for iter_18_1 = 1, var_18_1 do
			table.insert(var_18_4, {
				x = var_18_5 + iter_18_1 - 1,
				y = var_18_6 + iter_18_0 - 1
			})
		end
	end

	return var_18_4
end

function FurnitureFriendItemComp:getHoldOnGrid()
	local var_19_0 = {}
	local var_19_1 = self:isSpin()
	local var_19_2, var_19_3 = self:getGridPos()
	local var_19_4 = self._furnitureStruct:getFurnitureType()
	local var_19_5 = var_19_3 * var_0_0.FURNITURE_GROUND_W_GRID + var_19_2 + 1
	local var_19_6 = 0
	local var_19_7 = 0
	local var_19_8 = self._furnitureStruct:getInfo()

	if var_19_1 and var_19_4 ~= var_0_1.WALL_DECORATION then
		var_19_6 = var_19_8.length
		var_19_7 = var_19_8.width
	else
		var_19_6 = var_19_8.width
		var_19_7 = var_19_8.length
	end

	if var_19_4 == var_0_1.WALL_DECORATION then
		var_19_7 = var_19_6
		var_19_6 = var_19_7
	end

	for iter_19_0 = 1, var_19_6 do
		for iter_19_1 = 1, var_19_7 do
			table.insert(var_19_0, {
				order = var_0_0.FURNITURE_GROUND_W_GRID * (iter_19_0 - 1) + var_19_5 + (iter_19_1 - 1) + ((var_19_4 == var_0_1.WALL_DECORATION or nil) and (var_19_1 and 20000 or 10000))
			})
		end
	end

	return var_19_0
end

function FurnitureFriendItemComp:setCanPlace(arg_20_1)
	if arg_20_1 ~= self:isCanPlace() then
		self.m_canPlaceController:setSelectedIndex((arg_20_1 or nil) and (var_0_2.YES or var_0_2.NO))
	end
end

function FurnitureFriendItemComp:getPlaceState()
	return self.m_canPlaceController:getSelectedIndex() ~= 0
end

function FurnitureFriendItemComp:setPlaceEnd(arg_22_1)
	if self:isPlaceEnd() ~= arg_22_1 then
		self.m_placeEndController:setSelectedIndex((arg_22_1 or nil) and (var_0_3.YES or var_0_3.NO))
	end
end

function FurnitureFriendItemComp:isCanPlace()
	return self.m_canPlaceController:getSelectedIndex() == var_0_0.CAN_PLACE_CTRL_IDX.YES
end

function FurnitureFriendItemComp:isPlaceEnd()
	return self.m_placeEndController:getSelectedIndex() == var_0_0.PLACE_END_CTRL_IDX.YES
end

function FurnitureFriendItemComp:isUsing()
	return self._using
end

function FurnitureFriendItemComp:startUsing()
	local var_26_0 = self:getSpecialAction()

	if var_26_0 == var_0_4.EMPTY then
		self._using = false
	elseif var_26_0 == var_0_4.BATH then
		self._using = true

		self:setTouchable(false)
		self.m_furnitureCell:setAnimation("play")

		if not self._bathingEffNode then
			local var_26_1 = self._furnitureStruct:getInfo()
			local var_26_2 = self.m_furnitureCell:getX()
			local var_26_3 = self.m_furnitureCell:getY()
			local var_26_4 = 25
			local var_26_5 = {
				name = "jiayuan_zhedang",
				isLoop = true,
				remove = false
			}

			if self:isSpin() then
				var_26_5.x = var_26_2 - var_26_1.x2 or var_26_2 + var_26_1.x2
			end

			var_26_5.y = var_26_3 - var_26_1.y2 - var_26_4
			self._bathingEffNode = self:addEffectSpine(var_26_5)
		end
	else
		self._using = true
	end
end

function FurnitureFriendItemComp:stopUsing()
	if self:getSpecialAction() == var_0_4.BATH then
		self:setTouchable(true)
		self.m_furnitureCell:setAnimation("idle")

		if self._bathingEffNode then
			self._bathingEffNode:removeFromParent(true)

			self._bathingEffNode = nil
		end
	end

	self._using = false
end

function FurnitureFriendItemComp:getNames()
	return self._furnitureStruct:getNames()
end

function FurnitureFriendItemComp:isRoleCanAutoRunSpecialAction()
	if self:isUsing() then
		return false
	end

	if self:getSpecialAction() == var_0_4.EMPTY then
		return false
	end

	if self.m_furnitureCell:isSpineResource() and not self.m_furnitureCell:getFurnitureSpine() then
		return false
	end

	local var_29_0

	if self:getFurnitureType() == var_0_1.BATH_CROCK and self._furnitureStruct:isCDOver() then
		do return false end

		var_29_0 = math.random(1000)
	end

	return var_29_0 <= self:getInfo().probability
end

function FurnitureFriendItemComp:addKnightSpineToRoleSlotNode(arg_30_1)
	self.m_furnitureCell:addKnightSpineToRoleSlotNode(arg_30_1)
end

function FurnitureFriendItemComp:isExistSpineRoleSlotNode()
	return self.m_furnitureCell:isExistSpineRoleSlotNode()
end

function FurnitureFriendItemComp:clearSpineRoleSlot()
	self.m_furnitureCell:clearSpineRoleSlot()
end

return FurnitureFriendItemComp
