local var_0_0 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_1 = g.core.const.ConstMgr.FurnitureConst.FURNITURE_TYPE
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.config.skin_info
local var_0_4 = g.core.config.knight_info
local var_0_5 = g.core.const.ConstMgr.FurnitureConst
local var_0_6 = g.core.config.furniture_info
local var_0_7 = 999999
local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local var_0_10 = g.core.model.User.knightsData
local var_0_11 = g.core.model.User.furnitureData
local FurnitureRoomGird = require("app.view.module.furniture.view.sub.FurnitureRoomGird")
local FurnitureFriendRoomComp = class("FurnitureFriendRoomComp", require("app.fairyGUI.furniture.UI_FurnitureFriendRoomComp"))

function FurnitureFriendRoomComp:ctor()
	self._dormId = 1
	self._roomBgEditId = nil
	self._bgFurnitureId = nil
	self._selectedFItemCompName = ""
	self._sFurnitureData = {}
	self._editIdArr = {}
	self._furnitureItemCompDict = {}
	self._friendId = 0

	self:_initGroundGird()

	self._tempCanUseCoord = nil
	self._tempCanUseArr = nil

	self.m_sweepBtn:addClickListener(handler(self, self._onClickSweepBtn))
end

function FurnitureFriendRoomComp:_initGroundGird()
	self._ground = FurnitureRoomGird.new(self, true, var_0_5.FURNITURE_GROUND_H_GRID, var_0_5.FURNITURE_GROUND_W_GRID, var_0_5.FURNITURE_WALL_H_GRID)

	self._ground:setEditMode(false)
	self.m_girdNodePos:addNode(self._ground)
end

function FurnitureFriendRoomComp:setFloorId(arg_3_1)
	self:_clearAllFurnitureItemComp()
	self.m_back_1Transition:play(handler(self, function()
		self:_updateFloorView(arg_3_1)
		self.m_enter_1Transition:play()
	end))
end

function FurnitureFriendRoomComp:_updateFloorView(arg_5_1)
	self._dormId = arg_5_1 or 1

	self:updateFurnitureComp()
end

function FurnitureFriendRoomComp:setSingleRoleNormalBehavior(arg_6_1)
	local var_6_0 = self:_getFurnitureItemComp((arg_6_1:getFurnitureNamePlaced()))

	if var_6_0 then
		var_6_0:stopUsing()
		var_6_0:clearSpineRoleSlot()
	end

	arg_6_1:clearFurnitureNamePlaced()
	self:refreshUnOccupyCoord()

	local var_6_1 = KsMath.unified2Coord(tonumber(self._tempCanUseArr[math.random(1, #self._tempCanUseArr)]))

	arg_6_1:setRolePlaceCoordXY(var_6_1.x, var_6_1.y)

	if arg_6_1:getRoleActionType() == var_0_5.ROLE_ACTION.BATH then
		self:closeBathBubble()
	end

	local var_6_2, var_6_3 = self._ground:changeCoordToPixelTop(2, var_6_1.x, var_6_1.y)

	arg_6_1:setPosition(var_6_2, -var_6_3)

	if math.random(10) < 3 then
		local var_6_4 = self:createRoleWalkRoute(arg_6_1, var_6_1.x, var_6_1.y)

		if var_6_4 then
			arg_6_1:setRoleCompRouteArray(var_6_4)
			arg_6_1:setRoleBehavior(var_0_5.ROLE_ACTION.RUN)
		end
	else
		arg_6_1:setRoleBehavior(var_0_5.ROLE_ACTION.IDLE)
	end

	self:rankFurnitureZOrder()
end

function FurnitureFriendRoomComp:closeBathBubble()
	for iter_7_0, iter_7_1 in pairs(self._furnitureItemCompDict) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			if iter_7_0 == var_0_5.FURNITURE_TYPE.BATH_CROCK then
				iter_7_3:stopUsing()
			end
		end
	end
end

function FurnitureFriendRoomComp:createRoleWalkRoute(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = KsMath.unified2Coord(tonumber(self._tempCanUseArr[math.random(1, #self._tempCanUseArr)]))
	local var_8_1 = self:getSearchPath(cc.p(arg_8_2, arg_8_3), cc.p(var_8_0.x, var_8_0.y))

	if var_8_1 and #var_8_1 > 0 then
		for iter_8_0 = 1, #var_8_1 do
			local var_8_2, var_8_3 = self._ground:changeCoordToPixelTop(2, var_8_1[iter_8_0].x, var_8_1[iter_8_0].y)

			var_8_1[iter_8_0].x = var_8_2
			var_8_1[iter_8_0].y = -var_8_3
		end
	end

	return var_8_1
end

function FurnitureFriendRoomComp:doCanMoveAStar(arg_9_1, arg_9_2)
	return self._tempCanUseCoord[KsMath.coord2Unified(arg_9_2.x, arg_9_2.y)]
end

function FurnitureFriendRoomComp:getSearchPath(arg_10_1, arg_10_2)
	if KsMath.IsSameCoord(arg_10_1, arg_10_2) then
		return nil
	end

	return (KsAStar.searchPath(arg_10_1, arg_10_2, self))
end

function FurnitureFriendRoomComp:updateRoomRoleComps()
	self._selectedRoleCompName = ""

	for iter_11_0 = 1, var_0_5.FURNITURE_KNIGHT_MAX do
		local var_11_0 = self:_getRoleCompWithIdx(iter_11_0)

		if var_11_0 then
			local var_11_1 = self:_getFurnitureItemComp((var_11_0:getFurnitureNamePlaced()))

			if var_11_1 then
				var_11_1:stopUsing()
				var_11_1:clearSpineRoleSlot()
			end

			var_11_0:clearFurnitureNamePlaced()
			self.m_furnitureComp:removeChild(var_11_0)
		end
	end

	local var_11_2 = self:_getFNameArrRoleCanAutoRunSpecialAction()
	local var_11_3 = var_0_11:getFriendCheckInKnightDressIdsWithDormId(self._dormId)

	local function var_11_4(arg_12_0, arg_12_1, arg_12_2)
		if tolua.isnull(self) then
			return
		end

		local var_12_0 = self:_createRoleCompByAdvanceId(arg_12_0, arg_12_1, false, arg_12_2)

		self.m_furnitureComp:addChildBase(var_12_0)

		if var_11_2[arg_12_0] then
			self:setRoleActionOnFurniture(var_12_0, var_11_2[arg_12_0])
		else
			self:setSingleRoleNormalBehavior(var_12_0)
		end
	end

	for iter_11_1, iter_11_2 in ipairs((var_0_11:getFriendCheckInKnightIdsWithDormId(self._dormId))) do
		self:newScheduleOnce(handler(self, function()
			var_11_4(iter_11_1, iter_11_2, var_11_3[iter_11_1])
		end, iter_11_1 / 30))
	end

	self:updateRoomRoleMyComps()
	self:updateFriendRoomVisitRoleComps()
end

function FurnitureFriendRoomComp:updateRoomRoleMyComps()
	local var_14_0 = var_0_11:getFriendCheckInKnightIdsWithDormId(self._dormId)
	local var_14_1 = self:_getRoleCompWithIdx(#var_14_0 + 1)

	if var_14_1 then
		self.m_furnitureComp:removeChild(var_14_1)
	end

	local var_14_2 = self:_createRoleComp(#var_14_0 + 1, g.core.model.User:packUser(), true)

	self.m_furnitureComp:addChildBase(var_14_2)
	self:setSingleRoleNormalBehavior(var_14_2)
end

function FurnitureFriendRoomComp:_getMainKnightResId()
	return var_0_10:getMainRoleKnight()[1]:getResInfo().fight_id
end

function FurnitureFriendRoomComp:updateFriendRoomVisitRoleComps()
	for iter_16_0 = 1, tonumber(var_0_2.get(var_0_0.FURNITURE_VISIT_MAX).parameter) do
		local var_16_0 = self:_getVisitRoleCompWithIdx(iter_16_0)

		if var_16_0 then
			self.m_furnitureComp:removeChild(var_16_0)
		end
	end

	local function var_16_1(arg_17_0, arg_17_1)
		if tolua.isnull(self) then
			return
		end

		local var_17_0 = self:_createVisitRoleComp(arg_17_0, arg_17_1)

		self.m_furnitureComp:addChildBase(var_17_0)
		self:setSingleRoleNormalBehavior(var_17_0)
	end

	for iter_16_1, iter_16_2 in ipairs((var_0_11:getVisitFriendData())) do
		self:newScheduleOnce(handler(self, function()
			var_16_1(iter_16_1, iter_16_2.user)
		end, iter_16_1 / 30))
	end
end

function FurnitureFriendRoomComp:updateFurnitureComp(arg_19_1)
	self._friendId = arg_19_1 or 0

	self:_clearAllFurnitureItemComp()

	self._roomBgEditId = nil
	self._bgFurnitureId = nil

	self:dispatchCompEvent("CHANGE_ROOM_BG_RES")

	self._sFurnitureData = var_0_11:getFriendFurnitureListWithDormId(self._dormId)

	for iter_19_0, iter_19_1 in ipairs(self._sFurnitureData) do
		self:_createFurniture(iter_19_1)
		table.insert(self._editIdArr, (iter_19_1:getEditId()))
	end

	self:updateRoomRoleComps()
	self:rankFurnitureZOrder()
	self:updateDustEffect()
end

function FurnitureFriendRoomComp:updateDustEffect()
	if self._dormId == self._canCleanDormId then
		self.m_dustEffComp:removeAllEffect()
		self.m_dustEffComp:addEffectSpine({
			scale = 1.5,
			isLoop = true,
			anim = "play",
			name = "eff_ui_furniture_dust"
		})
		self.m_sweepBtn:setVisible(true)
	else
		self.m_dustEffComp:removeAllEffect()
		self.m_sweepBtn:setVisible(false)
	end
end

function FurnitureFriendRoomComp:_createFurniture(arg_21_1)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_1:getFurnitureType()

	if var_21_0 == var_0_5.FURNITURE_TYPE.WALL or var_21_0 == var_0_5.FURNITURE_TYPE.FLOOR then
		self.m_floorComp:updateWithFurnitureStruct(arg_21_1)
	elseif var_21_0 == var_0_1.ROOM_BG then
		self._bgFurnitureId = arg_21_1.furniture_id
		self._roomBgEditId = tonumber(self._bgFurnitureId .. 0 .. var_0_5.SVR_DEFINITION_LEVEL.FURNITURE_BACKGROUND .. 0 .. 0)

		self:dispatchCompEvent("CHANGE_ROOM_BG_RES", self._bgFurnitureId)
	else
		local var_21_1 = fgui.UIPackage:createObject("furniture", "FurnitureFriendItemComp", self)

		var_21_1:initInfo(arg_21_1)
		var_21_1:setName((self:_getFurnitureItemCompNameForCreate(var_21_0)))

		local var_21_2, var_21_3 = self._ground:changeCoordToPixelTop(self:_getFurniturePlaneByCfg(arg_21_1.furniture_id, arg_21_1:isSpin()), arg_21_1.x, arg_21_1.y)

		var_21_1:setPosition(var_21_2, -var_21_3)
		var_21_1:setPlaceEnd(true)
		table.insert(self._furnitureItemCompDict[var_21_0], var_21_1)

		if var_21_0 == var_0_5.FURNITURE_TYPE.GROUND_ADORNMENT then
			self.m_groundDecorateComp:addChildBase(var_21_1)
		else
			self.m_furnitureComp:addChildBase(var_21_1)
		end
	end
end

function FurnitureFriendRoomComp:_createRoleComp(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = fgui.UIPackage:createObject("furniture", "FurnitureVisitRoleComp", self)

	var_22_0:updateRoleComp(arg_22_2)
	var_22_0:setName((self:_getRoleCompNameWithIdx(arg_22_1)))

	return var_22_0
end

function FurnitureFriendRoomComp:_createRoleCompByAdvanceId(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = fgui.UIPackage:createObject("furniture", "FurnitureVisitRoleComp", self)

	var_23_0:updateRoleCompByAdvanceId(arg_23_2, arg_23_3, arg_23_4)
	var_23_0:setName((self:_getRoleCompNameWithIdx(arg_23_1)))

	return var_23_0
end

function FurnitureFriendRoomComp:onDragRoleStart(arg_24_1)
	local var_24_0 = self:_getRoleComp(arg_24_1)

	if not var_24_0 then
		return
	end

	local var_24_1 = self:_getFurnitureItemComp((var_24_0:getFurnitureNamePlaced()))

	if var_24_1 then
		var_24_1:stopUsing()
		var_24_1:clearSpineRoleSlot()
	end

	var_24_0:clearFurnitureNamePlaced()
end

function FurnitureFriendRoomComp:dragTouchMoveRole(arg_25_1)
	local var_25_0 = self:_getRoleComp(arg_25_1)

	if not var_25_0 then
		return
	end

	self._selectedRoleCompName = arg_25_1

	if var_25_0:getRoleActionType() == var_0_5.ROLE_ACTION.BATH then
		self:closeBathBubble()
	end

	local var_25_1, var_25_2, var_25_3 = self._ground:changePixelToCoord(var_25_0:getX(), -var_25_0:getY(), 2)

	if var_25_1 == var_0_5.PlaneType.GROUND then
		local var_25_4, var_25_5 = self:checkCanPutOnGroundByIndex({
			right = false,
			coordX = var_25_2,
			coordY = var_25_3
		}, {
			thick = 0,
			row = 1,
			col = 1
		}, false)
		local var_25_6 = self:_getFurnitureItemComp(var_25_5)

		var_25_0:setRolePlaceCoordXY(var_25_2, var_25_3)

		if var_25_4 then
			var_25_0:setRoleCanPutState(var_25_4)
		elseif var_25_6 then
			local var_25_7 = var_25_6:isRoleCanRunSpecialAction()

			var_25_0:setRoleCanPutState(var_25_7)
			var_25_6:setHighLight(var_25_7)
		else
			var_25_0:setRoleCanPutState(false)
		end
	else
		var_25_0:setRoleCanPutState(false)
	end

	var_25_0:setSortingOrder(var_0_7)
end

function FurnitureFriendRoomComp:dragMoveEndFurnitureComp()
	if self:_getFurnitureItemComp(self._selectedFItemCompName) then
		self:_moveFurnitureComp()

		return
	end

	local var_26_0 = self:_getRoleComp(self._selectedRoleCompName)

	if not var_26_0 then
		return
	end

	local var_26_1, var_26_2, var_26_3 = self._ground:changePixelToCoord(var_26_0:getX(), -var_26_0:getY(), 2)

	if var_26_1 == var_0_5.PlaneType.GROUND then
		local var_26_4, var_26_5 = self:checkCanPutOnGroundByIndex({
			right = false,
			coordX = var_26_2,
			coordY = var_26_3
		}, {
			thick = 0,
			row = 1,
			col = 1
		}, false)
		local var_26_6 = self:_getFurnitureItemComp(var_26_5)

		if var_26_4 then
			local var_26_7, var_26_8 = self._ground:changeCoordToPixelTop(var_26_1, var_26_2, var_26_3)

			var_26_0:setRolePlaceCoordXY(var_26_2, var_26_3)
			var_26_0:setPosition(var_26_7, -var_26_8)
			self:rankFurnitureZOrder()
		elseif var_26_6 then
			if var_26_6:isRoleCanRunSpecialAction() then
				self:_putRoleOnFurniture(var_26_6)
			else
				self:forbidPlaceKnightArea()
			end
		else
			self:forbidPlaceKnightArea()
		end
	else
		self:forbidPlaceKnightArea()
	end
end

function FurnitureFriendRoomComp:forbidPlaceKnightArea()
	local var_27_0 = self:_getRoleComp(self._selectedRoleCompName)

	if not var_27_0 then
		return
	end

	self:refreshUnOccupyCoord()

	local var_27_1 = KsMath.unified2Coord(tonumber(self._tempCanUseArr[math.random(1, #self._tempCanUseArr)]))

	var_27_0:setRolePlaceCoordXY(var_27_1.x, var_27_1.y)

	local var_27_2, var_27_3 = self._ground:changeCoordToPixelTop(2, var_27_1.x, var_27_1.y)

	var_27_0:setPosition(var_27_2, -var_27_3)
	self:rankFurnitureZOrder()
end

function FurnitureFriendRoomComp:_putRoleOnFurniture(arg_28_1)
	local var_28_0 = self:_getRoleComp(self._selectedRoleCompName)

	if not var_28_0 then
		return
	end

	self:setRoleActionOnFurniture(var_28_0, arg_28_1:getName())
end

function FurnitureFriendRoomComp:checkCanPutOnGroundByIndex(arg_29_1, arg_29_2, arg_29_3)
	if not self:_isOnGround(arg_29_1, arg_29_2) then
		return false
	end

	local var_29_0 = arg_29_2.col
	local var_29_1 = arg_29_2.row

	if arg_29_1.right then
		var_29_1 = arg_29_2.col
		var_29_0 = arg_29_2.row
	end

	for iter_29_0 = arg_29_1.coordX, arg_29_1.coordX + var_29_0 - 1 do
		for iter_29_1 = arg_29_1.coordY, arg_29_1.coordY + var_29_1 - 1 do
			local var_29_2 = self:findFurnitureWithCoord(iter_29_0, iter_29_1, arg_29_3)

			if #var_29_2 > 0 then
				return false, var_29_2
			end
		end
	end

	return true
end

function FurnitureFriendRoomComp:_isOnGround(arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2.col
	local var_30_1 = arg_30_2.row

	if arg_30_1.right then
		var_30_1 = arg_30_2.col
		var_30_0 = arg_30_2.row
	end

	if arg_30_1.coordX + var_30_0 > var_0_5.FURNITURE_GROUND_W_GRID then
		return false
	elseif arg_30_1.coordY + var_30_1 > var_0_5.FURNITURE_GROUND_H_GRID then
		return false
	else
		return true
	end
end

function FurnitureFriendRoomComp:findFurnitureWithCoord(arg_31_1, arg_31_2, arg_31_3)
	arg_31_3 = checkbool(arg_31_3)

	local var_31_0 = arg_31_2 * var_0_5.FURNITURE_GROUND_W_GRID + arg_31_1 + 1

	for iter_31_0, iter_31_1 in pairs(self._furnitureItemCompDict) do
		if arg_31_3 == (iter_31_0 == var_0_1.GROUND_ADORNMENT) then
			for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
				local var_31_1 = iter_31_3:getName()

				if var_31_1 ~= self._selectedFItemCompName and iter_31_3:isInFurniture(var_31_0) then
					return var_31_1
				end
			end
		end
	end

	return ""
end

function FurnitureFriendRoomComp:_getFurnitureItemComp(arg_32_1)
	if type(arg_32_1) == "string" and #arg_32_1 > 0 then
		local var_32_0 = self.m_furnitureComp:getChild(arg_32_1)

		if var_32_0 then
			return var_32_0
		else
			return self.m_groundDecorateComp:getChild(arg_32_1)
		end
	end
end

function FurnitureFriendRoomComp:_createVisitRoleComp(arg_33_1, arg_33_2)
	local var_33_0 = fgui.UIPackage:createObject("furniture", "FurnitureVisitRoleComp", self)
	local var_33_1 = var_0_4.get(arg_33_2.base_id).res_id
	local var_33_2 = arg_33_2.skin or 0

	if var_33_2 > 0 then
		local var_33_3 = var_0_3.get(var_33_2).res
	end

	var_33_0:updateRoleComp(arg_33_2)
	var_33_0:setName((self:_getVisitRoleCompNameWithIdx(arg_33_1)))

	return var_33_0
end

function FurnitureFriendRoomComp:rankFurnitureZOrder()
	local var_34_0 = {}

	for iter_34_0, iter_34_1 in pairs(self._furnitureItemCompDict) do
		for iter_34_2, iter_34_3 in ipairs(iter_34_1) do
			if iter_34_0 ~= var_0_5.FURNITURE_TYPE.GROUND_ADORNMENT then
				table.insert(var_34_0, iter_34_3)
			end
		end
	end

	for iter_34_4 = 1, #var_0_11:getFriendCheckInKnightIdsWithDormId(self._dormId) + 1 do
		local var_34_1 = self:_getRoleCompWithIdx(iter_34_4)

		if var_34_1 and var_34_1:getRoleActionType() <= var_0_5.ROLE_ACTION.IDLE then
			table.insert(var_34_0, var_34_1)
		end
	end

	for iter_34_5 = 1, tonumber(var_0_2.get(var_0_0.FURNITURE_VISIT_MAX).parameter) do
		local var_34_2 = self:_getVisitRoleCompWithIdx(iter_34_5)

		if var_34_2 and var_34_2:getRoleActionType() <= var_0_5.ROLE_ACTION.IDLE then
			table.insert(var_34_0, var_34_2)
		end
	end

	if #var_34_0 > 1 then
		g.core.common.GlobalFunc.sortGridObjZOder(var_34_0)
	end

	self:rankOnFurnitureRoleZOrder()
end

function FurnitureFriendRoomComp:rankOnFurnitureRoleZOrder()
	for iter_35_0 = 1, #var_0_11:getFriendCheckInKnightIdsWithDormId(self._dormId) + 1 do
		local var_35_0 = self:_getRoleCompWithIdx(iter_35_0)

		if var_35_0 then
			local var_35_1 = self:_getFurnitureItemComp((var_35_0:getFurnitureNamePlaced()))

			if var_35_1 then
				var_35_0:setSortingOrder(var_35_1:getSortingOrder() + 1)
			end
		end
	end

	for iter_35_1 = 1, tonumber(var_0_2.get(var_0_0.FURNITURE_VISIT_MAX).parameter) do
		local var_35_2 = self:_getVisitRoleCompWithIdx(iter_35_1)

		if var_35_2 and var_35_2 then
			local var_35_3 = self:_getFurnitureItemComp((var_35_2:getFurnitureNamePlaced()))

			if var_35_3 then
				var_35_2:setSortingOrder(var_35_3:getSortingOrder() + 1)
			end
		end
	end
end

function FurnitureFriendRoomComp:_getFurniturePlaneByCfg(arg_36_1, arg_36_2)
	local var_36_0 = var_0_6.get(arg_36_1)

	return (var_36_0 and var_36_0.type == var_0_5.FURNITURE_TYPE.WALL_DECORATION or nil) and (arg_36_2 and var_0_5.PlaneType.RIGHT_WALL or var_0_5.PlaneType.LEFT_WALL)
end

function FurnitureFriendRoomComp:setRoleActionOnFurniture(arg_37_1, arg_37_2)
	local var_37_0 = self:_getFurnitureItemComp(arg_37_2)

	if not arg_37_1 or not var_37_0 then
		return
	end

	local var_37_1 = var_37_0:getSpecialAction()

	if var_37_0:isExistSpineRoleSlotNode() then
		var_37_0:addKnightSpineToRoleSlotNode((arg_37_1:createKnightSpineForSlot(var_37_1, (var_37_0:isSpin()))))
		arg_37_1:setVisible(false)
	end

	var_37_0:startUsing()
	arg_37_1:setSpin(1)

	local var_37_2 = var_37_0:getInfo()
	local var_37_3 = var_37_0:getPosition()
	local var_37_4 = {
		x = var_37_3.x + var_37_2.x2,
		y = var_37_3.y + var_37_2.y2
	}

	if var_37_0:isSpin() then
		arg_37_1:setSpin(-1)

		var_37_4 = {
			x = var_37_3.x - var_37_2.x2,
			y = var_37_3.y + var_37_2.y2
		}
	else
		arg_37_1:setSpin(1)
	end

	arg_37_1:setPosition(var_37_4)
	arg_37_1:setFurnitureNamePlaced(arg_37_2)

	local var_37_5, var_37_6 = var_37_0:getGridPos()

	arg_37_1:setRolePlaceCoordXY(var_37_5 + 1, var_37_6 + 1)
	arg_37_1:setRoleBehavior(var_37_1)
	arg_37_1:getController("isPlace"):setSelectedIndex(0)
	arg_37_1:setSortingOrder(var_37_0:getSortingOrder() + 1)

	self._selectedRoleCompName = ""
end

function FurnitureFriendRoomComp:_getFNameArrRoleCanAutoRunSpecialAction()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in pairs(self._furnitureItemCompDict) do
		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			if iter_38_0 ~= var_0_1.GROUND_ADORNMENT and iter_38_3:isRoleCanAutoRunSpecialAction() then
				table.insert(var_38_0, iter_38_3:getName())
			end
		end
	end

	return var_38_0
end

function FurnitureFriendRoomComp:getAllOccupyCoord()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(self._furnitureItemCompDict) do
		for iter_39_2, iter_39_3 in ipairs(iter_39_1) do
			if iter_39_0 ~= var_0_5.FURNITURE_TYPE.GROUND_ADORNMENT then
				local var_39_1 = iter_39_3:getPosList()

				for iter_39_4 = 1, #var_39_1 do
					table.insert(var_39_0, var_39_1[iter_39_4])
				end
			end
		end
	end

	return var_39_0
end

function FurnitureFriendRoomComp:refreshUnOccupyCoord()
	self._tempCanUseCoord = {}
	self._tempCanUseArr = {}

	for iter_40_0 = 1, var_0_5.FURNITURE_MOVE_H_GRID do
		for iter_40_1 = 1, var_0_5.FURNITURE_MOVE_W_GRID do
			local var_40_0 = KsMath.coord2Unified(iter_40_0 - 1, iter_40_1 - 1)

			self._tempCanUseCoord[var_40_0] = true

			table.insert(self._tempCanUseArr, var_40_0)
		end
	end

	for iter_40_2, iter_40_3 in pairs(self._furnitureItemCompDict) do
		for iter_40_4, iter_40_5 in ipairs(iter_40_3) do
			if iter_40_2 ~= var_0_5.FURNITURE_TYPE.GROUND_ADORNMENT then
				for iter_40_6, iter_40_7 in ipairs((iter_40_5:getPosList())) do
					local var_40_1 = KsMath.coord2Unified(iter_40_7.x, iter_40_7.y)

					self._tempCanUseCoord[var_40_1] = nil

					KsMath.arrayDelete(self._tempCanUseArr, var_40_1)
				end
			end
		end
	end
end

function FurnitureFriendRoomComp:getUnOccupyCoord()
	local var_41_0 = {}

	for iter_41_0 = 1, var_0_5.FURNITURE_MOVE_H_GRID do
		for iter_41_1 = 1, var_0_5.FURNITURE_MOVE_W_GRID do
			table.insert(var_41_0, {
				x = iter_41_0 - 1,
				y = iter_41_1 - 1
			})
		end
	end

	local var_41_1 = self:getAllOccupyCoord()

	if #var_41_1 > 0 then
		for iter_41_2 = 1, #var_41_1 do
			for iter_41_3 = #var_41_0, 1, -1 do
				if var_41_1[iter_41_2].x == var_41_0[iter_41_3].x and var_41_1[iter_41_2].y == var_41_0[iter_41_3].y then
					table.remove(var_41_0, iter_41_3)
				end
			end
		end
	end

	return var_41_0
end

function FurnitureFriendRoomComp:_getFurnitureItemCompNameForCreate(arg_42_1)
	self._furnitureItemCompDict[arg_42_1] = self._furnitureItemCompDict[arg_42_1] or {}

	return (string.format("furnitureItemComp_%d_%d", arg_42_1, #self._furnitureItemCompDict[arg_42_1] + 1))
end

function FurnitureFriendRoomComp:_getRoleCompNameWithIdx(arg_43_1)
	return var_0_5.ROLE_COMP_PREFIX_NAME .. arg_43_1
end

function FurnitureFriendRoomComp:_getVisitRoleCompNameWithIdx(arg_44_1)
	return var_0_5.ROLE_VISIT_COMP_NAME .. arg_44_1
end

function FurnitureFriendRoomComp:_getRoleCompWithIdx(arg_45_1)
	return self:_getRoleComp((self:_getRoleCompNameWithIdx(arg_45_1)))
end

function FurnitureFriendRoomComp:_getVisitRoleCompWithIdx(arg_46_1)
	return self:_getRoleComp((self:_getVisitRoleCompNameWithIdx(arg_46_1)))
end

function FurnitureFriendRoomComp:_getRoleComp(arg_47_1)
	if type(arg_47_1) == "string" and #arg_47_1 > 0 then
		return self.m_furnitureComp:getChild(arg_47_1)
	end
end

function FurnitureFriendRoomComp:_clearAllFurnitureItemComp()
	self.m_groundDecorateComp:removeChildren()
	self.m_furnitureComp:removeChildren()

	self._editIdArr = {}
	self._furnitureItemCompDict = {}
end

function FurnitureFriendRoomComp:setDormIdCanSweep(arg_49_1)
	self._canCleanDormId = arg_49_1
end

function FurnitureFriendRoomComp:_onClickSweepBtn()
	self.m_sweepEffComp:removeAllEffect()
	self.m_sweepBtn:setVisible(false)
	self.m_sweepEffComp:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = "eff_ui_furniture_sweep"
	})
	self:newScheduleOnce(handler(self, function()
		self:dispatchCompEvent("CLICK_PLACE_SWEEP_BTN")
	end), 2)
end

function FurnitureFriendRoomComp:hideSweepEffect()
	self.m_dustEffComp:removeAllEffect()
	self.m_sweepEffComp:removeAllEffect()
	self:updateDustEffect()
end

function FurnitureFriendRoomComp:updateFurnitureCompWithDailyReport()
	self:_clearAllFurnitureItemComp()

	self._sFurnitureData = var_0_11:getFriendFurnitureListWithDormId(self._dormId)

	for iter_53_0, iter_53_1 in ipairs(self._sFurnitureData) do
		self:_createFurniture(iter_53_1)
		table.insert(self._editIdArr, (iter_53_1:getEditId()))
	end

	self:rankFurnitureZOrder()
	self.m_sweepBtn:setVisible(false)
end

return FurnitureFriendRoomComp
