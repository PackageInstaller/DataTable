local var_0_0 = g.core.const.ConstMgr.FurnitureConst
local var_0_1 = g.core.const.ConstMgr.FurnitureConst.FURNITURE_TYPE
local var_0_2 = g.core.const.ConstMgr.FurnitureConst.CAN_PLACE_CTRL_IDX
local var_0_3 = g.core.const.ConstMgr.FurnitureConst.PLACE_END_CTRL_IDX
local var_0_4 = g.core.const.ConstMgr.FurnitureConst.ROLE_ACTION
local FurnitureItemComp = class("FurnitureItemComp", require("app.fairyGUI.furniture.UI_FurnitureItemComp"))

function FurnitureItemComp:ctor()
	self._using = false
	self._furnitureStruct = nil

	self:addClickListener(handler(self, self._onClickFurnitureItem))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function FurnitureItemComp:initInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	self:updateWithFurnitureStruct(arg_2_1)
	self:setTouchable(arg_2_1:getFurnitureType() == var_0_0.FURNITURE_TYPE.BATH_CROCK)
	self:_updateBathCrockCDComp()
end

function FurnitureItemComp:updateWithFurnitureStruct(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._furnitureStruct = clone(arg_3_1)

	self.m_furnitureCell:updateFurnitureCell((arg_3_1:getInfo()))

	local var_3_0 = arg_3_1:isSpin()

	self.m_furnitureCell:setScaleX(var_3_0 and -1 or 1)
	self.m_furnitureCell:setSpinImg(var_3_0)
end

function FurnitureItemComp:getFurnitureStruct()
	return self._furnitureStruct
end

function FurnitureItemComp:getInfo()
	return self._furnitureStruct:getInfo()
end

function FurnitureItemComp:getFurnitureId()
	return self._furnitureStruct.furniture_id
end

function FurnitureItemComp:setSpin(arg_7_1)
	self._furnitureStruct:setSpin(arg_7_1)
	self.m_furnitureCell:setScaleX(arg_7_1 and -1 or 1)
	self.m_furnitureCell:setSpinImg(arg_7_1)
end

function FurnitureItemComp:isSpin()
	return self._furnitureStruct:isSpin()
end

function FurnitureItemComp:getGridPos()
	return self._furnitureStruct.x, self._furnitureStruct.y
end

function FurnitureItemComp:setGridPos(arg_10_1, arg_10_2)
	self._furnitureStruct:setGridPos(arg_10_1, arg_10_2)
end

function FurnitureItemComp:getFurnitureEditId()
	return self._furnitureStruct:getEditId()
end

function FurnitureItemComp:getPlaceLevel()
	return self._furnitureStruct.level
end

function FurnitureItemComp:setHighLight(arg_13_1)
	self.m_furnitureCell:setFurnitureLightImg(arg_13_1)
end

function FurnitureItemComp:getFurnitureType()
	return self._furnitureStruct:getFurnitureType()
end

function FurnitureItemComp:getSpecialAction()
	if self:getInfo().probability > 0 then
		local var_15_0 = self._furnitureStruct:getFurnitureType()

		if var_15_0 == var_0_1.BED then
			return var_0_4.REST
		elseif var_15_0 == var_0_1.SOFA or var_15_0 == var_0_1.TABLE_CHAIR then
			return var_0_4.SIT
		elseif var_15_0 == var_0_1.BATH_CROCK then
			return var_0_4.BATH
		else
			return var_0_4.EMPTY
		end
	else
		return var_0_4.EMPTY
	end
end

function FurnitureItemComp:isRoleCanAutoRunSpecialAction()
	if self:isUsing() then
		return false
	end

	if self:getSpecialAction() == var_0_4.EMPTY then
		return false
	end

	if self.m_furnitureCell:isSpineResource() and not self.m_furnitureCell:getFurnitureSpine() then
		return false
	end

	local var_16_0

	if self:getFurnitureType() == var_0_1.BATH_CROCK and self._furnitureStruct:isCDOver() then
		do return false end

		var_16_0 = math.random(1000)
	end

	return var_16_0 <= self:getInfo().probability
end

function FurnitureItemComp:isRoleCanRunSpecialAction()
	if self:isUsing() then
		return false
	else
		return self:getSpecialAction() ~= var_0_4.EMPTY
	end
end

function FurnitureItemComp:getPosList()
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
			y = 0,
			x = 0
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

function FurnitureItemComp:getHoldOnGrid()
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

function FurnitureItemComp:isInFurniture(arg_20_1)
	local var_20_0 = self:getHoldOnGrid()

	for iter_20_0 = 1, #var_20_0 do
		if var_20_0[iter_20_0].order == arg_20_1 then
			return true
		end
	end
end

function FurnitureItemComp:setCanPlace(arg_21_1)
	if arg_21_1 ~= self:isCanPlace() then
		self.m_canPlaceController:setSelectedIndex((arg_21_1 or nil) and (var_0_2.YES or var_0_2.NO))
	end
end

function FurnitureItemComp:getPlaceState()
	return self.m_canPlaceController:getSelectedIndex() ~= 0
end

function FurnitureItemComp:onClickRotateBtn()
	self:setSpin(not (self.m_furnitureCell:getScaleX() == -1))
end

function FurnitureItemComp:setPlaceEnd(arg_24_1)
	if self:isPlaceEnd() ~= arg_24_1 then
		self.m_placeEndController:setSelectedIndex((arg_24_1 or nil) and (var_0_3.YES or var_0_3.NO))

		if not arg_24_1 then
			self.m_furnitureCell:initFurnitureGird()
		end
	end

	self:_updateBathCrockCDComp()
end

function FurnitureItemComp:initFurnitureCellGird()
	self.m_furnitureCell:initFurnitureGird()
end

function FurnitureItemComp:_onTouchBegin()
	self:dispatchCompEvent("DRAG_FURNITURE_ITEM_START", self:getName())
end

function FurnitureItemComp:_onClickFurnitureItem()
	self:dispatchCompEvent("CLICK_FURNITURE_ITEM_COMP", self:getName())
end

function FurnitureItemComp:isCanPlace()
	return self.m_canPlaceController:getSelectedIndex() == var_0_0.CAN_PLACE_CTRL_IDX.YES
end

function FurnitureItemComp:isPlaceEnd()
	return self.m_placeEndController:getSelectedIndex() == var_0_0.PLACE_END_CTRL_IDX.YES
end

function FurnitureItemComp:isUsing()
	return self._using
end

function FurnitureItemComp:startUsing()
	local var_31_0 = self:getSpecialAction()

	if var_31_0 == var_0_4.EMPTY then
		self._using = false
	elseif var_31_0 == var_0_4.BATH then
		self._using = true

		self:setTouchable(false)
		self.m_bathCrockCDComp:setVisible(false)
		self.m_furnitureCell:setAnimation("play")

		if not self._bathingEffNode then
			local var_31_1 = self._furnitureStruct:getInfo()
			local var_31_2 = self.m_furnitureCell:getX()
			local var_31_3 = self.m_furnitureCell:getY()
			local var_31_4 = 25
			local var_31_5 = {
				isLoop = true,
				remove = false,
				name = "jiayuan_zhedang"
			}

			if self:isSpin() then
				var_31_5.x = var_31_2 - var_31_1.x2 or var_31_2 + var_31_1.x2
			end

			var_31_5.y = var_31_3 - var_31_1.y2 - var_31_4
			self._bathingEffNode = self:addEffectSpine(var_31_5)
		end
	else
		self._using = true
	end
end

function FurnitureItemComp:stopUsing()
	if self:getSpecialAction() == var_0_4.BATH then
		self:setTouchable(true)
		self:_updateBathCrockCDComp()
		self.m_furnitureCell:setAnimation("idle")

		if self._bathingEffNode then
			self._bathingEffNode:removeFromParent(true)

			self._bathingEffNode = nil
		end
	end

	self._using = false
end

function FurnitureItemComp:getNames()
	return self._furnitureStruct:getNames()
end

function FurnitureItemComp:_updateBathCrockCDComp()
	if self._furnitureStruct:getFurnitureType() == var_0_1.BATH_CROCK then
		self.m_bathCrockCDComp:startCD(self._furnitureStruct:getCDTotalTime(), (self._furnitureStruct:getCDEndTime()))
		self.m_bathCrockCDComp:setVisible(true)

		local var_34_0 = self.m_furnitureCell:getX()
		local var_34_1 = self.m_furnitureCell:getY()
		local var_34_2 = self._furnitureStruct:getInfo()
		local var_34_3 = cc.p(var_34_0 + var_34_2.x2, var_34_1 + var_34_2.y2 + -160)

		self.m_bathCrockCDComp:setPosition((self:isSpin() or nil) and cc.p(var_34_0 - var_34_2.x2, var_34_1 + var_34_2.y2 + -160))

		if not self._furnitureStruct:isCDOver() then
			self.m_bathCrockCDComp:stopAllFGActions()
			self.m_bathCrockCDComp:runFGAction(fgui.FSequence:create({
				fgui.FDelayTime:create(1),
				fgui.FFadeTo:create(0.5, 100)
			}))
		end
	else
		self.m_bathCrockCDComp:setVisible(false)
	end
end

function FurnitureItemComp:setShareStatus(arg_35_1)
	if arg_35_1 then
		self.m_bathCrockCDComp:setVisible(false)
	else
		self:_updateBathCrockCDComp()
	end
end

function FurnitureItemComp:isExistSpineRoleSlotNode()
	return self.m_furnitureCell:isExistSpineRoleSlotNode()
end

function FurnitureItemComp:addKnightSpineToRoleSlotNode(arg_37_1)
	self.m_furnitureCell:addKnightSpineToRoleSlotNode(arg_37_1)
end

function FurnitureItemComp:clearSpineRoleSlot()
	self.m_furnitureCell:clearSpineRoleSlot()
end

return FurnitureItemComp
