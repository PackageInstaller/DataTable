local var_0_0 = g.core.config.furniture_info
local var_0_1 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.config.skin_info
local var_0_4 = g.core.config.knight_info
local var_0_5 = 999999
local var_0_6 = g.core.const.ConstMgr
local var_0_7 = g.core.const.ConstMgr.FurnitureConst
local var_0_8 = g.core.const.ConstMgr.FurnitureConst.FURNITURE_TYPE
local var_0_9 = g.core.utils.Table
local KsAStar = require("app.core.utils.KsAStar")
local KsMath = require("app.core.utils.KsMath")
local var_0_12 = g.core.model.User.furnitureData
local var_0_13 = g.core.model.User.knightsData
local FurnitureRoomGird = require("app.view.module.furniture.view.sub.FurnitureRoomGird")
local FurnitureStruct = require("app.view.module.furniture.model.FurnitureStruct")
local var_0_16 = g.core.module.ModuleManager
local FurnitureRoomComp = class("FurnitureRoomComp", require("app.fairyGUI.furniture.UI_FurnitureRoomComp"))

function FurnitureRoomComp:ctor()
	self._dormId = 1
	self._roomBgEditId = nil
	self._bgFurnitureId = nil
	self._lookMode = false
	self._offXRange = (self:getWidth() - display.width) / 2
	self._offYRange = (self:getHeight() - display.height) / 2
	self._selectedFItemCompName = ""
	self._selectedRoleCompName = ""
	self._editMode = false
	self._sFurnitureData = {}
	self._furnitureItemCompDict = {}

	self:_initGroundGird()

	self._tempCanUseCoord = nil
	self._tempCanUseArr = nil
end

function FurnitureRoomComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, handler(self, self._onForceGuideEnd), self)
end

function FurnitureRoomComp:_initGroundGird()
	self._ground = FurnitureRoomGird.new(self, true, var_0_7.FURNITURE_GROUND_H_GRID, var_0_7.FURNITURE_GROUND_W_GRID, var_0_7.FURNITURE_WALL_H_GRID)

	self._ground:setEditMode(false)
	self.m_girdNodePos:addNode(self._ground)
end

function FurnitureRoomComp:setFloorId(arg_4_1)
	self:cancelAllSchedule()
	self.m_uiComp:initUI()
	self:_clearAllFurnitureItemComp()
	self.m_back_1Transition:play(handler(self, function()
		self:_updateFloorView(arg_4_1)
		self.m_enter_1Transition:play()
	end))
end

function FurnitureRoomComp:_updateFloorView(arg_6_1)
	self._dormId = arg_6_1 or 1

	self:updateFurnitureComp()
end

function FurnitureRoomComp:onBathCrockCDOver()
	if self._editMode then
		return
	end

	for iter_7_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_7_0 = self:_getRoleCompWithIdx(iter_7_0)

		if var_7_0 and var_7_0:getRoleActionType() == var_0_7.ROLE_ACTION.BATH then
			self:setSingleRoleNormalBehavior(var_7_0)

			break
		end
	end
end

function FurnitureRoomComp:setSingleRoleNormalBehavior(arg_8_1)
	local var_8_0 = self:_getFurnitureItemComp((arg_8_1:getFurnitureNamePlaced()))

	if var_8_0 then
		var_8_0:stopUsing()
		var_8_0:clearSpineRoleSlot()
	end

	arg_8_1:clearFurnitureNamePlaced()

	if not self._editMode then
		arg_8_1:setVisible(true)
	end

	self:refreshUnOccupyCoord()

	local var_8_1 = KsMath.unified2Coord(tonumber(self._tempCanUseArr[math.random(1, #self._tempCanUseArr)]))

	arg_8_1:setRolePlaceCoordXY(var_8_1.x, var_8_1.y)

	if arg_8_1:getRoleActionType() == var_0_7.ROLE_ACTION.BATH then
		self:closeBathBubble()
	end

	local var_8_2, var_8_3 = self._ground:changeCoordToPixelTop(2, var_8_1.x, var_8_1.y)

	arg_8_1:setPosition(var_8_2, -var_8_3)

	if math.random(10) < 3 then
		local var_8_4 = self:createRoleWalkRoute(arg_8_1, var_8_1.x, var_8_1.y)

		if var_8_4 then
			arg_8_1:setRoleCompRouteArray(var_8_4)
			arg_8_1:setRoleBehavior(var_0_7.ROLE_ACTION.RUN)
		end
	else
		arg_8_1:setRoleBehavior(var_0_7.ROLE_ACTION.IDLE)
	end

	self:rankFurnitureZOrder()
end

function FurnitureRoomComp:createRoleWalkRoute(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = KsMath.unified2Coord(tonumber(self._tempCanUseArr[math.random(1, #self._tempCanUseArr)]))
	local var_9_1 = self:getSearchPath(cc.p(arg_9_2, arg_9_3), cc.p(var_9_0.x, var_9_0.y))

	if var_9_1 and #var_9_1 > 0 then
		for iter_9_0 = 1, #var_9_1 do
			local var_9_2, var_9_3 = self._ground:changeCoordToPixelTop(2, var_9_1[iter_9_0].x, var_9_1[iter_9_0].y)

			var_9_1[iter_9_0].x = var_9_2
			var_9_1[iter_9_0].y = -var_9_3
		end
	end

	return var_9_1
end

function FurnitureRoomComp:doCanMoveAStar(arg_10_1, arg_10_2)
	return self._tempCanUseCoord[KsMath.coord2Unified(arg_10_2.x, arg_10_2.y)]
end

function FurnitureRoomComp:getSearchPath(arg_11_1, arg_11_2)
	if KsMath.IsSameCoord(arg_11_1, arg_11_2) then
		return nil
	end

	return (KsAStar.searchPath(arg_11_1, arg_11_2, self))
end

function FurnitureRoomComp:setEditMode(arg_12_1)
	self._editMode = arg_12_1

	self._ground:setEditMode(arg_12_1)
	self:setFurnitureCompTouchable(arg_12_1)

	for iter_12_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_12_0 = self:_getRoleCompWithIdx(iter_12_0)

		if var_12_0 then
			var_12_0:setVisible(not arg_12_1)
		end
	end

	for iter_12_1 = 1, tonumber(var_0_2.get(var_0_1.FURNITURE_VISIT_MAX).parameter) do
		local var_12_1 = self:_getVisitRoleCompWithIdx(iter_12_1)

		if var_12_1 then
			var_12_1:setVisible(not arg_12_1)
		end
	end
end

function FurnitureRoomComp:updateRoomRoleComps()
	self._selectedRoleCompName = ""

	for iter_13_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_13_0 = self:_getRoleCompWithIdx(iter_13_0)

		if var_13_0 then
			local var_13_1 = self:_getFurnitureItemComp((var_13_0:getFurnitureNamePlaced()))

			if var_13_1 then
				var_13_1:stopUsing()
				var_13_1:clearSpineRoleSlot()
			end

			var_13_0:clearFurnitureNamePlaced()
			self.m_furnitureComp:removeChild(var_13_0)
		end
	end

	local var_13_2 = self:_getFNameArrRoleCanAutoRunSpecialAction()
	local var_13_3 = {}

	for iter_13_1, iter_13_2 in ipairs((var_0_12:getCheckInKnightIdsWithDormId(self._dormId))) do
		table.insert(var_13_3, {
			weight = math.random(10000),
			sId = iter_13_2
		})
	end

	if #var_13_3 > 1 then
		table.sort(var_13_3, function(arg_14_0, arg_14_1)
			return arg_14_0.weight > arg_14_1.weight
		end)
	end

	local function var_13_4(arg_15_0, arg_15_1)
		if tolua.isnull(self) then
			return
		end

		local var_15_0 = self:_createRoleComp(arg_15_0, arg_15_1)

		self.m_furnitureComp:addChildBase(var_15_0)

		if self._editMode then
			var_15_0:setVisible(false)
		end

		if var_13_2[arg_15_0] then
			self:setRoleActionOnFurniture(var_15_0, var_13_2[arg_15_0])
		else
			self:setSingleRoleNormalBehavior(var_15_0)
		end
	end

	for iter_13_3, iter_13_4 in ipairs(var_13_3) do
		self:newScheduleOnce(handler(self, function()
			var_13_4(iter_13_3, iter_13_4.sId)
		end, iter_13_3 / 30))
	end

	self:updateRoomVisitRoleComps()
end

function FurnitureRoomComp:updateRoomVisitRoleComps()
	for iter_17_0 = 1, tonumber(var_0_2.get(var_0_1.FURNITURE_VISIT_MAX).parameter) do
		local var_17_0 = self:_getVisitRoleCompWithIdx(iter_17_0)

		if var_17_0 then
			self.m_furnitureComp:removeChild(var_17_0)
		end
	end

	local function var_17_1(arg_18_0, arg_18_1)
		if tolua.isnull(self) then
			return
		end

		local var_18_0 = self:_createVisitRoleComp(arg_18_0, arg_18_1)

		self.m_furnitureComp:addChildBase(var_18_0)

		if self._editMode then
			var_18_0:setVisible(false)
		end

		self:setSingleRoleNormalBehavior(var_18_0)
	end

	for iter_17_1, iter_17_2 in ipairs((var_0_12:getVisitData())) do
		self:newScheduleOnce(handler(self, function()
			var_17_1(iter_17_1, iter_17_2.user)
		end, iter_17_1 / 30))
	end
end

function FurnitureRoomComp:updateFurnitureComp(arg_20_1)
	local var_20_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if var_20_0 then
		self._selectedFItemCompName = ""

		var_20_0:setPlaceEnd(true)
		self.m_uiComp:setPlaceEnd(true)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self.m_uiComp:initUI()
	self:_clearAllFurnitureItemComp()

	self._roomBgEditId = nil
	self._bgFurnitureId = nil

	self:dispatchCompEvent("CHANGE_ROOM_BG_RES")

	for iter_20_0, iter_20_1 in ipairs((var_0_12:getFurnitureListWithDormId(self._dormId))) do
		self:_createFurniture(iter_20_1)
	end

	if not arg_20_1 then
		self:updateRoomRoleComps()
	end

	self:rankFurnitureZOrder()
	self:setFurnitureCompTouchable(self._editMode)
	self:_checkSpeWeakGuide()
end

function FurnitureRoomComp:_createFurniture(arg_21_1, arg_21_2)
	if not arg_21_1 then
		return
	end

	local var_21_0 = arg_21_1:getFurnitureType()

	if var_21_0 == var_0_8.WALL or var_21_0 == var_0_8.FLOOR then
		self.m_floorComp:updateWithFurnitureStruct(arg_21_1)

		if arg_21_2 then
			self:dispatchCompEvent("CLICK_PLACE_FURNITURE_BTN")
		end
	elseif var_21_0 == var_0_8.ROOM_BG then
		self._bgFurnitureId = arg_21_1.furniture_id
		self._roomBgEditId = tonumber(self._bgFurnitureId .. 0 .. var_0_7.SVR_DEFINITION_LEVEL.FURNITURE_BACKGROUND .. 0 .. 0)

		self:dispatchCompEvent("CHANGE_ROOM_BG_RES", self._bgFurnitureId)
	else
		local var_21_1 = fgui.UIPackage:createObject("furniture", "FurnitureItemComp", self)

		var_21_1:initInfo(arg_21_1)

		local var_21_2 = self:_getFurnitureItemCompNameForCreate(var_21_0)

		var_21_1:setName(var_21_2)

		local var_21_3, var_21_4 = self._ground:changeCoordToPixelTop(self:_getFurniturePlaneByCfg(arg_21_1.furniture_id, arg_21_1:isSpin()), arg_21_1.x, arg_21_1.y)

		var_21_1:setPosition(var_21_3, -var_21_4)
		self.m_uiComp:updatePosWithFurniturePos(var_21_1:getPosition())
		table.insert(self._furnitureItemCompDict[var_21_0], var_21_1)

		if var_21_0 == var_0_8.GROUND_ADORNMENT then
			self.m_groundDecorateComp:addChildBase(var_21_1)
		else
			self.m_furnitureComp:addChildBase(var_21_1)
		end

		if arg_21_2 then
			local var_21_5 = self:_getFurnitureItemComp(self._selectedFItemCompName)

			if var_21_5 then
				var_21_5:setPlaceEnd(true)
			end

			self._selectedFItemCompName = var_21_2

			var_21_1:setTouchable(true)
			var_21_1:setSortingOrder(var_0_5)
			var_21_1:initFurnitureCellGird()
			self.m_uiComp:setPlaceEnd(false)
			self:dragMoveEndFurnitureComp()
		else
			var_21_1:setPlaceEnd(true)
			self.m_uiComp:setPlaceEnd(true)

			self._selectedFItemCompName = ""
		end
	end
end

function FurnitureRoomComp:_createRoleComp(arg_22_1, arg_22_2)
	local var_22_0 = fgui.UIPackage:createObject("furniture", "FurnitureRoleComp", self)

	var_22_0:updateRoleComp((var_0_13:getKnightById(arg_22_2)))
	var_22_0:setName((self:_getRoleCompNameWithIdx(arg_22_1)))

	return var_22_0
end

function FurnitureRoomComp:_createVisitRoleComp(arg_23_1, arg_23_2)
	local var_23_0 = fgui.UIPackage:createObject("furniture", "FurnitureVisitRoleComp", self)
	local var_23_1 = var_0_4.get(arg_23_2.base_id).res_id
	local var_23_2 = arg_23_2.skin or 0

	if var_23_2 > 0 then
		local var_23_3 = var_0_3.get(var_23_2).res
	end

	var_23_0:updateRoleComp(arg_23_2)
	var_23_0:setName((self:_getVisitRoleCompNameWithIdx(arg_23_1)))

	return var_23_0
end

function FurnitureRoomComp:rankFurnitureZOrder()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self._furnitureItemCompDict) do
		for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
			if iter_24_0 ~= var_0_8.GROUND_ADORNMENT then
				table.insert(var_24_0, iter_24_3)
			end
		end
	end

	for iter_24_4 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_24_1 = self:_getRoleCompWithIdx(iter_24_4)

		if var_24_1 and var_24_1:getRoleActionType() <= var_0_7.ROLE_ACTION.IDLE then
			table.insert(var_24_0, var_24_1)
		end
	end

	for iter_24_5 = 1, tonumber(var_0_2.get(var_0_1.FURNITURE_VISIT_MAX).parameter) do
		local var_24_2 = self:_getVisitRoleCompWithIdx(iter_24_5)

		if var_24_2 and var_24_2:getRoleActionType() <= var_0_7.ROLE_ACTION.IDLE then
			table.insert(var_24_0, var_24_2)
		end
	end

	if #var_24_0 > 1 then
		g.core.common.GlobalFunc.sortGridObjZOder(var_24_0)
	end

	self:rankOnFurnitureRoleZOrder()
end

function FurnitureRoomComp:rankOnFurnitureRoleZOrder()
	for iter_25_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_25_0 = self:_getRoleCompWithIdx(iter_25_0)

		if var_25_0 then
			local var_25_1 = self:_getFurnitureItemComp((var_25_0:getFurnitureNamePlaced()))

			if var_25_1 then
				var_25_0:setSortingOrder(var_25_1:getSortingOrder() + 1)
			end
		end
	end

	for iter_25_1 = 1, tonumber(var_0_2.get(var_0_1.FURNITURE_VISIT_MAX).parameter) do
		local var_25_2 = self:_getVisitRoleCompWithIdx(iter_25_1)

		if var_25_2 and var_25_2 then
			local var_25_3 = self:_getFurnitureItemComp((var_25_2:getFurnitureNamePlaced()))

			if var_25_3 then
				var_25_2:setSortingOrder(var_25_3:getSortingOrder() + 1)
			end
		end
	end
end

function FurnitureRoomComp:addFurniture(arg_26_1)
	local var_26_0, var_26_1 = self:getRandomPlacePos(arg_26_1)

	self:_createFurniture(FurnitureStruct.new({
		is_spin = 0,
		furniture_id = arg_26_1,
		x = var_26_0,
		y = var_26_1,
		level = var_0_12:getSvrDefLevelForNewFurniture(arg_26_1)
	}), true)
end

function FurnitureRoomComp:getRandomPlacePos(arg_27_1)
	local var_27_0 = var_0_0.get(arg_27_1)
	local var_27_1 = {
		col = var_27_0.width,
		row = var_27_0.length,
		thick = var_27_0.height
	}
	local var_27_2 = {
		right = false,
		coordX = 1,
		coordY = 1
	}

	if self:_getFurniturePlaneByCfg(arg_27_1) < var_0_7.PlaneType.GROUND then
		var_27_2.coordX = math.random(0, var_0_7.FURNITURE_GROUND_W_GRID - var_27_1.col)
		var_27_2.coordY = math.random(0, var_0_7.FURNITURE_WALL_H_GRID - var_27_1.row)
	else
		var_27_2.coordX = math.random(0, 15)
		var_27_2.coordY = math.random(0, 15)
	end

	return var_27_2.coordX, var_27_2.coordY
end

function FurnitureRoomComp:_removeFurnitureItemComp()
	local var_28_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if not var_28_0 then
		return
	end

	local var_28_1 = var_28_0:getFurnitureType()

	table.removebyvalue(self._furnitureItemCompDict[var_28_1], var_28_0, false)
	var_28_0:removeFromParent()
	self:_reNameFurnitureByType(var_28_1)

	self._selectedFItemCompName = ""
end

function FurnitureRoomComp:_reNameFurnitureByType(arg_29_1)
	if next(self._furnitureItemCompDict[arg_29_1]) then
		for iter_29_0 = 1, #self._furnitureItemCompDict[arg_29_1] do
			if self._furnitureItemCompDict[arg_29_1][iter_29_0] then
				self._furnitureItemCompDict[arg_29_1][iter_29_0]:setName((string.format("furnitureItemComp_%d_%d", arg_29_1, iter_29_0)))
			end
		end
	end
end

function FurnitureRoomComp:_getFurniturePlaneByCfg(arg_30_1, arg_30_2)
	local var_30_0 = var_0_0.get(arg_30_1)

	return (var_30_0 and var_30_0.type == var_0_8.WALL_DECORATION or nil) and (arg_30_2 and var_0_7.PlaneType.RIGHT_WALL or var_0_7.PlaneType.LEFT_WALL)
end

function FurnitureRoomComp:sendSaveSettingRoom2S()
	local var_31_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if var_31_0 then
		if not var_31_0:getPlaceState() then
			var_0_16:tip(g.core.lang:get(112549))

			return
		end

		var_31_0:setPlaceEnd(true)
		self.m_uiComp:setPlaceEnd(true)

		self._selectedFItemCompName = ""
	end

	local var_31_1 = self:_turnAddFurnitureParam((self:getAddFurnitureData()))
	local var_31_2 = self:_turnDeleteFurnitureParam((self:getDeleteFurnitureData()))

	if #var_31_1 > 0 or #var_31_2 > 0 then
		g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Place({
			room_id = self._dormId,
			add_furniture = var_31_1,
			del_furniture = var_31_2
		})
	else
		self:dispatchCompEvent("SAVE_BUT_NO_CHANGE")
	end
end

function FurnitureRoomComp:onClickFurnitureItemComp(arg_32_1)
	local var_32_0 = self:_getFurnitureItemComp(arg_32_1)

	if not var_32_0 then
		return
	end

	if self._editMode then
		if self._selectedFItemCompName == arg_32_1 then
			return
		end

		local var_32_1 = self:_getFurnitureItemComp(self._selectedFItemCompName)

		if var_32_1 then
			if not var_32_1:getPlaceState() then
				var_0_16:tip(g.core.lang:get(112549))

				return
			end

			var_32_1:setPlaceEnd(true)
			self.m_uiComp:setPlaceEnd(true)
		end

		self._selectedFItemCompName = arg_32_1

		var_32_0:setPlaceEnd(false)
		self.m_uiComp:setPlaceEnd(false)
		var_32_0:setSortingOrder(var_0_5)
		self:dragMoveEndFurnitureComp()
	elseif var_32_0:getFurnitureType() == var_0_8.BATH_CROCK then
		self:_onClickBathCrock(arg_32_1)
	end
end

function FurnitureRoomComp:_onClickBathCrock(arg_33_1)
	local var_33_0 = self:_getFurnitureItemComp(arg_33_1)

	if not var_33_0 then
		return
	elseif var_33_0:isUsing() then
		return
	end

	if self:getRoleActionCountByType(var_0_7.ROLE_ACTION.BATH) < self:getCurRoomFurnitureCountByType(var_0_8.BATH_CROCK) then
		if var_33_0:getFurnitureStruct():isCDOver() then
			var_0_16:pushPopup(require("app.view.module.furniture.view.pop.FurnitureChooseBathPersonnelPop").new(self._dormId), {
				touchDisappear = false
			})
		end
	end
end

function FurnitureRoomComp:getFurnitureByNames(arg_34_1, arg_34_2)
	for iter_34_0, iter_34_1 in pairs(self._furnitureItemCompDict) do
		for iter_34_2, iter_34_3 in ipairs(iter_34_1) do
			if iter_34_3:getNames() == arg_34_1 then
				return iter_34_3
			end
		end
	end
end

function FurnitureRoomComp:getRoleCompByKnightId(arg_35_1)
	for iter_35_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_35_0 = self:_getRoleCompWithIdx(iter_35_0)

		if var_35_0 and var_35_0:getRoleServerId() == arg_35_1 then
			return var_35_0
		end
	end
end

function FurnitureRoomComp:getBathingRoleComp()
	for iter_36_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_36_0 = self:_getRoleCompWithIdx(iter_36_0)

		if var_36_0 and var_36_0:getRoleActionType() == var_0_7.ROLE_ACTION.BATH then
			return var_36_0
		end
	end
end

function FurnitureRoomComp:saveFurniturePos()
	local var_37_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if var_37_0 then
		var_37_0:setPlaceEnd(true)
		self.m_uiComp:setPlaceEnd(true)
		self:rankFurnitureZOrder()
	end

	self._selectedFItemCompName = ""
end

function FurnitureRoomComp:onDragRoleStart(arg_38_1)
	local var_38_0 = self:_getRoleComp(arg_38_1)

	if not var_38_0 then
		return
	end

	local var_38_1 = self:_getFurnitureItemComp((var_38_0:getFurnitureNamePlaced()))

	if var_38_1 then
		var_38_1:stopUsing()
		var_38_1:clearSpineRoleSlot()
	end

	var_38_0:clearFurnitureNamePlaced()
end

function FurnitureRoomComp:dragTouchMoveRole(arg_39_1)
	local var_39_0 = self:_getRoleComp(arg_39_1)

	if not var_39_0 then
		return
	end

	self._selectedRoleCompName = arg_39_1

	if var_39_0:getRoleActionType() == var_0_7.ROLE_ACTION.BATH then
		self:closeBathBubble()
	end

	local var_39_1, var_39_2, var_39_3 = self._ground:changePixelToCoord(var_39_0:getX(), -var_39_0:getY(), 2)

	if var_39_1 == var_0_7.PlaneType.GROUND then
		local var_39_4, var_39_5 = self:checkCanPutOnGroundByIndex({
			right = false,
			coordX = var_39_2,
			coordY = var_39_3
		}, {
			row = 1,
			thick = 0,
			col = 1
		}, false)
		local var_39_6 = self:_getFurnitureItemComp(var_39_5)

		var_39_0:setRolePlaceCoordXY(var_39_2, var_39_3)

		if var_39_4 then
			self:closeFurnitureLight()
			var_39_0:setRoleCanPutState(var_39_4)
		elseif var_39_6 then
			local var_39_7 = var_39_6:isRoleCanRunSpecialAction()

			var_39_0:setRoleCanPutState(var_39_7)
			var_39_6:setHighLight(var_39_7)
		else
			var_39_0:setRoleCanPutState(false)
		end
	else
		var_39_0:setRoleCanPutState(false)
	end

	var_39_0:setSortingOrder(var_0_5)
end

function FurnitureRoomComp:dragMoveFurnitureComp(arg_40_1)
	local var_40_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if not var_40_0 then
		return
	end

	var_40_0:setSortingOrder(var_0_5)

	local var_40_1 = var_40_0:getPosition()

	var_40_1.x = var_40_1.x + arg_40_1.x
	var_40_1.y = var_40_1.y - arg_40_1.y

	local var_40_2, var_40_3, var_40_4 = self._ground:changePixelToCoord(var_40_1.x, -var_40_1.y, (self:_getFurniturePlaneByCfg(var_40_0:getFurnitureId(), false)))
	local var_40_5, var_40_6 = self._ground:changeCoordToPixelTop(var_40_2, var_40_3, var_40_4)
	local var_40_7 = {
		right = false,
		coordX = var_40_3,
		coordY = var_40_4
	}
	local var_40_8 = var_40_0:getInfo()
	local var_40_9 = {
		col = var_40_8.width,
		row = var_40_8.length,
		thick = var_40_8.height
	}

	if self:checkPlaneCanPlace(var_40_2) == 0 then
		local var_40_10 = true

		if var_40_2 == var_0_7.PlaneType.LEFT_WALL then
			var_40_0:setSpin(false)

			var_40_10 = self:_isOnWall(var_40_7, var_40_9)
		elseif var_40_2 == var_0_7.PlaneType.RIGHT_WALL then
			var_40_0:setSpin(true)

			var_40_7.right = true
			var_40_10 = self:_isOnWall(var_40_7, var_40_9)
		else
			local var_40_11 = {
				col = var_40_8.length,
				row = var_40_8.width,
				thick = var_40_8.height
			}

			var_40_7.right = var_40_0:isSpin()
			var_40_10 = self:_isOnGround(var_40_7, var_40_11)
		end

		if var_40_10 then
			var_40_0:setPosition(var_40_1.x, var_40_1.y)
			self.m_uiComp:updatePosWithFurniturePos(var_40_1)
		end
	end
end

function FurnitureRoomComp:dragMoveEndFurnitureComp()
	if self:_getFurnitureItemComp(self._selectedFItemCompName) then
		self:_moveFurnitureComp()

		return
	end

	local var_41_0 = self:_getRoleComp(self._selectedRoleCompName)

	if not var_41_0 then
		return
	end

	local var_41_1, var_41_2, var_41_3 = self._ground:changePixelToCoord(var_41_0:getX(), -var_41_0:getY(), 2)

	if var_41_1 == var_0_7.PlaneType.GROUND then
		local var_41_4, var_41_5 = self:checkCanPutOnGroundByIndex({
			right = false,
			coordX = var_41_2,
			coordY = var_41_3
		}, {
			row = 1,
			thick = 0,
			col = 1
		}, false)
		local var_41_6 = self:_getFurnitureItemComp(var_41_5)

		if var_41_4 then
			local var_41_7, var_41_8 = self._ground:changeCoordToPixelTop(var_41_1, var_41_2, var_41_3)

			var_41_0:setRolePlaceCoordXY(var_41_2, var_41_3)
			var_41_0:setPosition(var_41_7, -var_41_8)
			self:rankFurnitureZOrder()
		elseif var_41_6 then
			if var_41_6:isRoleCanRunSpecialAction() then
				self:_putRoleOnFurniture(var_41_6)
			else
				self:forbidPlaceKnightArea()
			end

			self:closeFurnitureLight()
		else
			self:forbidPlaceKnightArea()
		end
	else
		self:forbidPlaceKnightArea()
	end
end

function FurnitureRoomComp:forbidPlaceKnightArea()
	local var_42_0 = self:_getRoleComp(self._selectedRoleCompName)

	if not var_42_0 then
		return
	end

	self:refreshUnOccupyCoord()

	local var_42_1 = KsMath.unified2Coord(tonumber(self._tempCanUseArr[math.random(1, #self._tempCanUseArr)]))

	var_42_0:setRolePlaceCoordXY(var_42_1.x, var_42_1.y)

	local var_42_2, var_42_3 = self._ground:changeCoordToPixelTop(2, var_42_1.x, var_42_1.y)

	var_42_0:setPosition(var_42_2, -var_42_3)
	self:rankFurnitureZOrder()
end

function FurnitureRoomComp:_putRoleOnFurniture(arg_43_1)
	local var_43_0 = self:_getRoleComp(self._selectedRoleCompName)

	if not var_43_0 then
		return
	end

	if arg_43_1:getSpecialAction() == var_0_7.ROLE_ACTION.BATH then
		if arg_43_1:getFurnitureStruct():isCDOver() and not var_43_0:isVisitRoleType() then
			if var_43_0:isMobilityFull() then
				var_0_16:pushPopup((require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(112543),
					desc = g.core.lang:get(112544),
					onConfirm = handler(self, self.sendRoleToBathReq),
					onCancel = handler(self, self.forbidPlaceKnightArea)
				})))
			else
				self:sendRoleToBathReq()
			end
		else
			self:setRoleActionOnFurniture(var_43_0, arg_43_1:getName())
		end
	else
		self:setRoleActionOnFurniture(var_43_0, arg_43_1:getName())
	end
end

function FurnitureRoomComp:sendRoleToBathReq()
	local var_44_0 = self:_getRoleComp(self._selectedRoleCompName)
	local var_44_1 = self:_getBathCrockComp()

	if not var_44_0 or not var_44_1 then
		return
	end

	local var_44_2, var_44_3 = var_44_1:getGridPos()

	g.core.network.GameNetProxy:send_C2S_FurnitureRoom_Bath({
		room_id = self._dormId,
		knight_id = var_44_0:getRoleServerId(),
		bathtbu_id = var_44_1:getFurnitureId(),
		x = var_44_2,
		y = var_44_3,
		level = var_0_7.SVR_DEFINITION_LEVEL.FLOOR_FURNITURE
	})
end

function FurnitureRoomComp:startBathing(arg_45_1)
	if self._dormId ~= arg_45_1.room_id then
		return
	end

	local var_45_0 = self:getBathingRoleComp()

	if var_45_0 then
		self._selectedRoleCompName = var_45_0:getName()

		var_45_0:setRoleBehavior(var_0_7.ROLE_ACTION.IDLE)
		self:forbidPlaceKnightArea()
	end

	local var_45_1 = self:getRoleCompByKnightId(arg_45_1.knight_id)
	local var_45_2 = self:_getBathCrockComp()

	if var_45_1 and var_45_2 then
		var_45_1:startBathing()
		var_45_1:setActionBarVisible(true)
		var_45_2:updateWithFurnitureStruct((var_0_12:getFurnitureInfoWithDormIdFId(self._dormId, arg_45_1.bathtub.furniture_id)))
		var_45_2:startUsing()
		self:setRoleActionOnFurniture(var_45_1, var_45_2:getName())
	end
end

function FurnitureRoomComp:outOfBathing(arg_46_1)
	local var_46_0 = var_0_12:getFurnitureInfo(self._dormId, var_0_8.BATH_CROCK)

	if var_46_0 then
		local var_46_1 = self:getFurnitureByNames(var_46_0:getNames(), true)

		if var_46_1 then
			var_46_1:stopUsing()
		end
	end

	local var_46_2 = self:_getRoleComp(arg_46_1)

	if var_46_2 then
		if self._lookMode then
			var_46_2:setActionBarVisible(false)
		end

		self:setSingleRoleNormalBehavior(var_46_2)
	end
end

function FurnitureRoomComp:_moveFurnitureComp()
	local var_47_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)
	local var_47_1 = var_47_0:getPosition()
	local var_47_2, var_47_3, var_47_4 = self._ground:changePixelToCoord(var_47_1.x, -var_47_1.y, (self:_getFurniturePlaneByCfg(var_47_0:getFurnitureId(), false)))
	local var_47_5, var_47_6 = self._ground:changeCoordToPixelTop(var_47_2, var_47_3, var_47_4)
	local var_47_7 = {
		right = false,
		coordX = var_47_3,
		coordY = var_47_4
	}
	local var_47_8 = var_47_0:getInfo()
	local var_47_9 = {
		col = var_47_8.width,
		row = var_47_8.length,
		thick = var_47_8.height
	}
	local var_47_10 = self:checkPlaneCanPlace(var_47_2)

	if var_47_10 == 0 then
		local var_47_11 = false

		if var_47_2 == var_0_7.PlaneType.LEFT_WALL then
			var_47_0:setSpin(false)

			var_47_11 = self:checkCanPutOnWallByIndex(var_47_7, var_47_9)
		elseif var_47_2 == var_0_7.PlaneType.RIGHT_WALL then
			var_47_0:setSpin(true)

			var_47_7.right = true
			var_47_11 = self:checkCanPutOnWallByIndex(var_47_7, var_47_9)
		else
			local var_47_12 = {
				col = var_47_8.length,
				row = var_47_8.width,
				thick = var_47_8.height
			}

			var_47_7.right = var_47_0:isSpin()
			var_47_11 = self:checkCanPutOnGroundByIndex(var_47_7, var_47_12, var_47_0:getFurnitureType() == var_0_8.GROUND_ADORNMENT)
		end

		var_47_0:setGridPos(var_47_3, var_47_4)
		var_47_0:setCanPlace(var_47_11)
		var_47_0:setPosition(var_47_5, -var_47_6)
		self.m_uiComp:setCanPlace(var_47_11)
		self.m_uiComp:updatePosWithFurniturePos(var_47_0:getPosition())
	else
		var_47_0:setCanPlace(false)
		self.m_uiComp:setCanPlace(false)

		if var_47_10 == 1 then
			var_0_16:tip(g.core.lang:get(112525))
		else
			var_0_16:tip(g.core.lang:get(112526))
		end
	end
end

function FurnitureRoomComp:setRoleActionOnFurniture(arg_48_1, arg_48_2)
	local var_48_0 = self:_getFurnitureItemComp(arg_48_2)

	if not arg_48_1 or not var_48_0 then
		return
	end

	local var_48_1 = var_48_0:getSpecialAction()

	if var_48_0:isExistSpineRoleSlotNode() then
		var_48_0:addKnightSpineToRoleSlotNode((arg_48_1:createKnightSpineForSlot(var_48_1, (var_48_0:isSpin()))))
		arg_48_1:setVisible(false)
	end

	var_48_0:startUsing()
	arg_48_1:setSpin(1)

	local var_48_2 = var_48_0:getInfo()
	local var_48_3 = var_48_0:getPosition()
	local var_48_4 = {
		x = var_48_3.x + var_48_2.x2,
		y = var_48_3.y + var_48_2.y2
	}

	if var_48_0:isSpin() then
		arg_48_1:setSpin(-1)

		var_48_4 = {
			x = var_48_3.x - var_48_2.x2,
			y = var_48_3.y + var_48_2.y2
		}
	else
		arg_48_1:setSpin(1)
	end

	arg_48_1:setPosition(var_48_4)
	arg_48_1:setFurnitureNamePlaced(arg_48_2)

	local var_48_5, var_48_6 = var_48_0:getGridPos()

	arg_48_1:setRolePlaceCoordXY(var_48_5 + 1, var_48_6 + 1)
	arg_48_1:setRoleBehavior(var_48_1)
	arg_48_1:getController("isPlace"):setSelectedIndex(0)
	arg_48_1:setSortingOrder(var_48_0:getSortingOrder() + 1)

	self._selectedRoleCompName = ""
end

function FurnitureRoomComp:checkPlaneCanPlace(arg_49_1)
	local var_49_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if not var_49_0 then
		return
	end

	local var_49_1 = 0
	local var_49_2 = var_49_0:getFurnitureType()

	if arg_49_1 == var_0_7.PlaneType.GROUND then
		if var_49_2 == var_0_8.WALL_DECORATION then
			var_49_1 = 2
		end
	elseif var_49_2 > var_0_8.WALL_DECORATION then
		var_49_1 = 1
	end

	return var_49_1
end

function FurnitureRoomComp:_turnAddFurnitureParam(arg_50_1)
	local var_50_0 = {}

	for iter_50_0 = 1, #arg_50_1 do
		local var_50_1 = self:getNamesWithEditId(arg_50_1[iter_50_0].id)
		local var_50_2 = self:getFurnitureByNames(var_50_1, true) or self:getFurnitureByNames(var_50_1, false)

		if var_50_2 then
			local var_50_3, var_50_4 = var_50_2:getGridPos()

			table.insert(var_50_0, {
				furniture_id = var_50_2:getFurnitureId(),
				x = var_50_3,
				y = var_50_4,
				is_spin = var_50_2:isSpin() and 1 or 0,
				level = var_50_2:getPlaceLevel()
			})
		elseif arg_50_1[iter_50_0].isFloor then
			table.insert(var_50_0, {
				y = 0,
				is_spin = 0,
				x = 0,
				furniture_id = arg_50_1[iter_50_0].furnitureId,
				level = var_0_7.SVR_DEFINITION_LEVEL.FLOOR_LAND
			})
		elseif arg_50_1[iter_50_0].isWall then
			table.insert(var_50_0, {
				y = 0,
				is_spin = 0,
				x = 0,
				furniture_id = arg_50_1[iter_50_0].furnitureId,
				level = var_0_7.SVR_DEFINITION_LEVEL.WALL_LAND_LEFT
			})
		elseif arg_50_1[iter_50_0].isRoomBg then
			table.insert(var_50_0, {
				y = 0,
				is_spin = 0,
				x = 0,
				furniture_id = arg_50_1[iter_50_0].furnitureId,
				level = var_0_7.SVR_DEFINITION_LEVEL.FURNITURE_BACKGROUND
			})
		end
	end

	return var_50_0
end

function FurnitureRoomComp:_turnDeleteFurnitureParam(arg_51_1)
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in ipairs((var_0_12:getFurnitureListWithDormId(self._dormId))) do
		if var_0_9.isContains(arg_51_1, (iter_51_1:getEditId())) then
			table.insert(var_51_0, iter_51_1:getDataFormatSvrNeed())
		end
	end

	return var_51_0
end

function FurnitureRoomComp:getAddFurnitureData()
	local var_52_0 = {}
	local var_52_1 = var_0_12:getEditIdArr(self._dormId)
	local var_52_2 = self.m_floorComp:getFloorEditId()
	local var_52_3 = self.m_floorComp:getWallEditId()

	if not var_0_9.isContains(var_52_1, var_52_2) then
		table.insert(var_52_0, {
			isFloor = true,
			id = var_52_2,
			furnitureId = self.m_floorComp:getFloorId()
		})
	end

	if not var_0_9.isContains(var_52_1, var_52_3) then
		table.insert(var_52_0, {
			isWall = true,
			id = var_52_3,
			furnitureId = self.m_floorComp:getWallId()
		})
	end

	if self._roomBgEditId and not var_0_9.isContains(var_52_1, self._roomBgEditId) then
		table.insert(var_52_0, {
			isRoomBg = true,
			id = self._roomBgEditId,
			furnitureId = self._bgFurnitureId
		})
	end

	for iter_52_0, iter_52_1 in pairs(self._furnitureItemCompDict) do
		for iter_52_2, iter_52_3 in ipairs(iter_52_1) do
			local var_52_4 = iter_52_3:getFurnitureEditId()

			if not var_0_9.isContains(var_52_1, var_52_4) then
				table.insert(var_52_0, {
					id = var_52_4
				})
			end
		end
	end

	return var_52_0
end

function FurnitureRoomComp:getDeleteFurnitureData()
	local var_53_0 = {}
	local var_53_1 = {}

	for iter_53_0, iter_53_1 in pairs(self._furnitureItemCompDict) do
		for iter_53_2, iter_53_3 in ipairs(iter_53_1) do
			table.insert(var_53_1, (iter_53_3:getFurnitureEditId()))
		end
	end

	local var_53_2 = self.m_floorComp:getFloorEditId()
	local var_53_3 = self.m_floorComp:getWallEditId()
	local var_53_4 = self._roomBgEditId or 0
	local var_53_5 = var_0_12:getEditIdArr(self._dormId)

	for iter_53_4 = 1, #var_53_5 do
		if not var_0_9.isContains(var_53_1, var_53_5[iter_53_4]) and var_53_5[iter_53_4] ~= var_53_2 and var_53_5[iter_53_4] ~= var_53_3 and var_53_5[iter_53_4] ~= var_53_4 then
			table.insert(var_53_0, var_53_5[iter_53_4])
		end
	end

	return var_53_0
end

function FurnitureRoomComp:collectAllFurniture()
	self.m_uiComp:setEditBtnGroupVisible(false)
	self:_clearAllFurnitureItemComp()
end

function FurnitureRoomComp:_isOnGround(arg_55_1, arg_55_2)
	local var_55_0 = arg_55_2.col
	local var_55_1 = arg_55_2.row

	if arg_55_1.right then
		var_55_1 = arg_55_2.col
		var_55_0 = arg_55_2.row
	end

	if arg_55_1.coordX + var_55_0 > var_0_7.FURNITURE_GROUND_W_GRID then
		return false
	elseif arg_55_1.coordY + var_55_1 > var_0_7.FURNITURE_GROUND_H_GRID then
		return false
	else
		return true
	end
end

function FurnitureRoomComp:checkCanPutOnGroundByIndex(arg_56_1, arg_56_2, arg_56_3)
	if not self:_isOnGround(arg_56_1, arg_56_2) then
		return false
	end

	local var_56_0 = arg_56_2.col
	local var_56_1 = arg_56_2.row

	if arg_56_1.right then
		var_56_1 = arg_56_2.col
		var_56_0 = arg_56_2.row
	end

	for iter_56_0 = arg_56_1.coordX, arg_56_1.coordX + var_56_0 - 1 do
		for iter_56_1 = arg_56_1.coordY, arg_56_1.coordY + var_56_1 - 1 do
			local var_56_2 = self:findFurnitureWithCoord(iter_56_0, iter_56_1, arg_56_3)

			if #var_56_2 > 0 then
				return false, var_56_2
			end
		end
	end

	return true
end

function FurnitureRoomComp:_isOnWall(arg_57_1, arg_57_2)
	if arg_57_1.coordX + arg_57_2.col > var_0_7.FURNITURE_GROUND_W_GRID then
		return false
	elseif arg_57_1.coordY + arg_57_2.row > var_0_7.FURNITURE_WALL_H_GRID then
		return false
	else
		return true
	end
end

function FurnitureRoomComp:checkCanPutOnWallByIndex(arg_58_1, arg_58_2)
	if not self:_isOnWall(arg_58_1, arg_58_2) then
		return false
	end

	local var_58_0 = arg_58_1.coordX

	for iter_58_0 = arg_58_1.coordX, arg_58_1.coordX + arg_58_2.col - 1 do
		for iter_58_1 = arg_58_1.coordY, arg_58_1.coordY + arg_58_2.row - 1 do
			if not self:checkWallSingleCoordCanPut(arg_58_1.right, iter_58_0, iter_58_1) then
				return false
			end
		end
	end

	if arg_58_2.thick > 0 and arg_58_1.right then
		if not self:checkCanPutOnGroundByIndex(arg_58_1.right and {
			coordY = 0,
			coordX = var_58_0
		} or {
			coordX = 0,
			coordY = var_58_0
		}, {
			col = arg_58_2.col,
			row = arg_58_2.thick
		}, false) then
			return false
		end
	end

	return true
end

function FurnitureRoomComp:findFurnitureWithCoord(arg_59_1, arg_59_2, arg_59_3)
	arg_59_3 = checkbool(arg_59_3)

	local var_59_0 = arg_59_2 * var_0_7.FURNITURE_GROUND_W_GRID + arg_59_1 + 1

	for iter_59_0, iter_59_1 in pairs(self._furnitureItemCompDict) do
		if arg_59_3 == (iter_59_0 == var_0_8.GROUND_ADORNMENT) then
			for iter_59_2, iter_59_3 in ipairs(iter_59_1) do
				local var_59_1 = iter_59_3:getName()

				if var_59_1 ~= self._selectedFItemCompName and iter_59_3:isInFurniture(var_59_0) then
					return var_59_1
				end
			end
		end
	end

	return ""
end

function FurnitureRoomComp:checkWallSingleCoordCanPut(arg_60_1, arg_60_2, arg_60_3)
	local var_60_0 = arg_60_3 * var_0_7.FURNITURE_GROUND_W_GRID + arg_60_2 + 1

	var_60_0 = arg_60_1 and var_60_0 + 20000 or var_60_0 + 10000

	for iter_60_0, iter_60_1 in pairs(self._furnitureItemCompDict) do
		for iter_60_2, iter_60_3 in ipairs(iter_60_1) do
			if iter_60_0 ~= var_0_8.GROUND_ADORNMENT and self._selectedFItemCompName ~= iter_60_3:getName() and iter_60_3:isInFurniture(var_60_0) then
				return false
			end
		end
	end

	return true
end

function FurnitureRoomComp:_getFNameArrRoleCanAutoRunSpecialAction()
	local var_61_0 = {}

	for iter_61_0, iter_61_1 in pairs(self._furnitureItemCompDict) do
		for iter_61_2, iter_61_3 in ipairs(iter_61_1) do
			if iter_61_0 ~= var_0_8.GROUND_ADORNMENT and iter_61_3:isRoleCanAutoRunSpecialAction() then
				table.insert(var_61_0, iter_61_3:getName())
			end
		end
	end

	return var_61_0
end

function FurnitureRoomComp:getCurRoomAllPlaceFurniture()
	local var_62_0 = {}

	table.insert(var_62_0, self.m_floorComp:getFloorId())
	table.insert(var_62_0, self.m_floorComp:getWallId())

	if self._bgFurnitureId then
		table.insert(var_62_0, self._bgFurnitureId)
	end

	for iter_62_0, iter_62_1 in pairs(self._furnitureItemCompDict) do
		for iter_62_2, iter_62_3 in ipairs(iter_62_1) do
			table.insert(var_62_0, iter_62_3:getFurnitureId())
		end
	end

	return var_62_0
end

function FurnitureRoomComp:setFurnitureCompTouchable(arg_63_1)
	for iter_63_0, iter_63_1 in pairs(self._furnitureItemCompDict) do
		for iter_63_2, iter_63_3 in ipairs(iter_63_1) do
			if iter_63_0 == var_0_8.BATH_CROCK then
				iter_63_3:setTouchable(true)
			else
				iter_63_3:setTouchable(arg_63_1)
			end

			iter_63_3:clearSpineRoleSlot()
		end
	end
end

function FurnitureRoomComp:closeFurnitureLight()
	for iter_64_0, iter_64_1 in pairs(self._furnitureItemCompDict) do
		for iter_64_2, iter_64_3 in ipairs(iter_64_1) do
			if iter_64_0 ~= var_0_8.GROUND_ADORNMENT then
				iter_64_3:setHighLight(false)
			end
		end
	end
end

function FurnitureRoomComp:closeBathBubble()
	for iter_65_0, iter_65_1 in pairs(self._furnitureItemCompDict) do
		for iter_65_2, iter_65_3 in ipairs(iter_65_1) do
			if iter_65_0 == var_0_8.BATH_CROCK then
				iter_65_3:stopUsing()
			end
		end
	end
end

function FurnitureRoomComp:getNamesWithEditId(arg_66_1)
	return var_0_7.FURNITURE_NAMES_PREFIX .. arg_66_1
end

function FurnitureRoomComp:getRoleActionCountByType(arg_67_1)
	local var_67_0 = 0

	for iter_67_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_67_1 = self:_getRoleCompWithIdx(iter_67_0)

		if var_67_1 and var_67_1:getRoleActionType() == arg_67_1 then
			var_67_0 = var_67_0 + 1
		end
	end

	return var_67_0
end

function FurnitureRoomComp:getCurRoomFurnitureCountByType(arg_68_1)
	local var_68_0 = 0

	for iter_68_0, iter_68_1 in pairs(self._furnitureItemCompDict) do
		if iter_68_0 == arg_68_1 then
			var_68_0 = var_68_0 + #iter_68_1
		end
	end

	return var_68_0
end

function FurnitureRoomComp:updateRolesMobility()
	for iter_69_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_69_0 = self:_getRoleCompWithIdx(iter_69_0)

		if var_69_0 then
			var_69_0:updateMobility()
		else
			break
		end
	end
end

function FurnitureRoomComp:setLookMode(arg_70_1)
	self._lookMode = arg_70_1

	for iter_70_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_70_0 = self:_getRoleCompWithIdx(iter_70_0)

		if var_70_0 then
			var_70_0:setActionBarVisible(not arg_70_1 or var_70_0:isRoleInBathing())
		else
			break
		end
	end
end

function FurnitureRoomComp:_onForceGuideEnd()
	self:_checkSpeWeakGuide()
end

function FurnitureRoomComp:_checkSpeWeakGuide()
	if g.core.model.User.guideData:getServerDataById(var_0_6.GuideConst.SAVE_SERVER_DATA_IDS.HOME_LAND_HOME_SHOWER) then
		return false
	end

	local var_72_0 = var_0_12:getFurnitureInfo(self._dormId, var_0_8.BATH_CROCK)

	if not var_72_0 then
		return
	elseif not var_72_0:isCDOver() then
		return
	end

	local var_72_1 = self:getFurnitureByNames(var_72_0:getNames(), true)

	if var_72_1 then
		for iter_72_0, iter_72_1 in ipairs((var_0_12:getCheckInKnightIdsWithDormId(self._dormId))) do
			local var_72_2 = var_0_13:getKnightById(iter_72_1)

			if var_72_2:getMobilityVal() / var_72_2:getMaxMobility() <= 0.2 then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
					key = "GUIDE_HOME_SHOWER_WEAK_FINGER",
					targetBtn = var_72_1
				})

				break
			end
		end
	end
end

function FurnitureRoomComp:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function FurnitureRoomComp:onClickPlaceFurnitureBtn()
	local var_74_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)

	if not var_74_0 then
		return
	end

	if var_74_0:isCanPlace() then
		self:saveFurniturePos()
	else
		var_0_16:tip(g.core.lang:get(112528))
	end
end

function FurnitureRoomComp:onClickDeleteFurnitureBtn()
	self:_removeFurnitureItemComp()
	self.m_uiComp:setPlaceEnd(true)
end

function FurnitureRoomComp:onClickRotateFurnitureBtn()
	local var_76_0 = self:_getFurnitureItemComp(self._selectedFItemCompName)
	local var_76_1 = var_76_0:getInfo()
	local var_76_2, var_76_3 = var_76_0:getGridPos()
	local var_76_4 = {
		right = false,
		coordX = var_76_2,
		coordY = var_76_3
	}

	var_76_4.right = not var_76_0:isSpin()

	if var_76_0 and self:_isOnGround(var_76_4, {
		col = var_76_1.length,
		row = var_76_1.width,
		thick = var_76_1.height
	}) then
		var_76_0:onClickRotateBtn()
		self:dragMoveEndFurnitureComp()
	else
		var_0_16:tip(g.core.lang:get(111055))

		return
	end
end

function FurnitureRoomComp:getAllOccupyCoord()
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in pairs(self._furnitureItemCompDict) do
		for iter_77_2, iter_77_3 in ipairs(iter_77_1) do
			if iter_77_0 ~= var_0_8.GROUND_ADORNMENT then
				local var_77_1 = iter_77_3:getPosList()

				for iter_77_4 = 1, #var_77_1 do
					table.insert(var_77_0, var_77_1[iter_77_4])
				end
			end
		end
	end

	return var_77_0
end

function FurnitureRoomComp:refreshUnOccupyCoord()
	self._tempCanUseCoord = {}
	self._tempCanUseArr = {}

	for iter_78_0 = 1, var_0_7.FURNITURE_MOVE_H_GRID do
		for iter_78_1 = 1, var_0_7.FURNITURE_MOVE_W_GRID do
			local var_78_0 = KsMath.coord2Unified(iter_78_0 - 1, iter_78_1 - 1)

			self._tempCanUseCoord[var_78_0] = true

			table.insert(self._tempCanUseArr, var_78_0)
		end
	end

	for iter_78_2, iter_78_3 in pairs(self._furnitureItemCompDict) do
		for iter_78_4, iter_78_5 in ipairs(iter_78_3) do
			if iter_78_2 ~= var_0_8.GROUND_ADORNMENT then
				for iter_78_6, iter_78_7 in ipairs((iter_78_5:getPosList())) do
					local var_78_1 = KsMath.coord2Unified(iter_78_7.x, iter_78_7.y)

					self._tempCanUseCoord[var_78_1] = nil

					KsMath.arrayDelete(self._tempCanUseArr, var_78_1)
				end
			end
		end
	end
end

function FurnitureRoomComp:getUnOccupyCoord()
	local var_79_0 = {}

	for iter_79_0 = 1, var_0_7.FURNITURE_MOVE_H_GRID do
		for iter_79_1 = 1, var_0_7.FURNITURE_MOVE_W_GRID do
			table.insert(var_79_0, {
				x = iter_79_0 - 1,
				y = iter_79_1 - 1
			})
		end
	end

	local var_79_1 = self:getAllOccupyCoord()

	if #var_79_1 > 0 then
		for iter_79_2 = 1, #var_79_1 do
			for iter_79_3 = #var_79_0, 1, -1 do
				if var_79_1[iter_79_2].x == var_79_0[iter_79_3].x and var_79_1[iter_79_2].y == var_79_0[iter_79_3].y then
					table.remove(var_79_0, iter_79_3)
				end
			end
		end
	end

	return var_79_0
end

function FurnitureRoomComp:_getFurnitureItemCompNameForCreate(arg_80_1)
	self._furnitureItemCompDict[arg_80_1] = self._furnitureItemCompDict[arg_80_1] or {}

	return (string.format("furnitureItemComp_%d_%d", arg_80_1, #self._furnitureItemCompDict[arg_80_1] + 1))
end

function FurnitureRoomComp:_getFurnitureItemComp(arg_81_1)
	if type(arg_81_1) == "string" and #arg_81_1 > 0 then
		local var_81_0 = self.m_furnitureComp:getChild(arg_81_1)

		if var_81_0 then
			return var_81_0
		else
			return self.m_groundDecorateComp:getChild(arg_81_1)
		end
	end
end

function FurnitureRoomComp:_getRoleCompNameWithIdx(arg_82_1)
	return var_0_7.ROLE_COMP_PREFIX_NAME .. arg_82_1
end

function FurnitureRoomComp:_getVisitRoleCompNameWithIdx(arg_83_1)
	return var_0_7.ROLE_VISIT_COMP_NAME .. arg_83_1
end

function FurnitureRoomComp:_getRoleCompWithIdx(arg_84_1)
	return self:_getRoleComp((self:_getRoleCompNameWithIdx(arg_84_1)))
end

function FurnitureRoomComp:_getVisitRoleCompWithIdx(arg_85_1)
	return self:_getRoleComp((self:_getVisitRoleCompNameWithIdx(arg_85_1)))
end

function FurnitureRoomComp:_getRoleComp(arg_86_1)
	if type(arg_86_1) == "string" and #arg_86_1 > 0 then
		return self.m_furnitureComp:getChild(arg_86_1)
	end
end

function FurnitureRoomComp:setShareStatus(arg_87_1)
	for iter_87_0 = 1, var_0_7.FURNITURE_KNIGHT_MAX do
		local var_87_0 = self:_getRoleCompWithIdx(iter_87_0)

		if var_87_0 and var_87_0.setShareStatus then
			var_87_0:setShareStatus(arg_87_1)
		end
	end

	for iter_87_1, iter_87_2 in pairs(self._furnitureItemCompDict) do
		for iter_87_3, iter_87_4 in ipairs(iter_87_2) do
			if iter_87_4.setShareStatus then
				iter_87_4:setShareStatus(arg_87_1)
			end
		end
	end
end

function FurnitureRoomComp:_clearAllFurnitureItemComp()
	self.m_groundDecorateComp:removeChildren()
	self.m_furnitureComp:removeChildren()

	self._furnitureItemCompDict = {}
end

function FurnitureRoomComp:_getBathCrockComp()
	for iter_89_0, iter_89_1 in pairs(self._furnitureItemCompDict) do
		if iter_89_0 == var_0_8.BATH_CROCK then
			return iter_89_1[1]
		end
	end
end

return FurnitureRoomComp
