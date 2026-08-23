local KsMath = require("app.core.utils.KsMath")
local MapGround = import(".MapGround")
local MapConst = import(".MapConst")
local TouchOne = import(".touch.TouchOne")
local MapTouch = import(".touch.MapTouch")
local EntityFactory = import(".entity.EntityFactory")
local MapField = import(".entity.MapField")
local MapWorld = class("MapWorld", function()
	return cc.Node:create()
end)

function MapWorld:ctor(arg_2_1, arg_2_2)
	self._fatherStage = arg_2_1
	self._vislGround = nil
	self._worldId = arg_2_2
	self._minMoveX = 0
	self._maxMoveX = 0
	self._minMoveY = 0
	self._maxMoveY = 0
	self._entityFieldDict = nil
	self._lastPosSC = cc.p(-1000, -1000)
	self._mapTouch = nil
	self._orgCoord = nil

	if self._autoRoleSkin == nil then
		self._autoRoleSkin = true
	end

	self:initWorld()
end

function MapWorld:onEnter()
	self:scheduleUpdate(handler(self, self.tickUpdate))
end

function MapWorld:onExit()
	self:unscheduleUpdate()
end

function MapWorld:onCleanup()
	self:disableNodeEvents()
end

function MapWorld:tickUpdate(arg_6_1)
	self:_doTickUpdate(arg_6_1)
end

function MapWorld:initWorld()
	self._orgCoord = cc.p(0, 0)
	self._vislGround = self:_doCreateGround()

	self:addChild(self._vislGround)
	self:_initMoveRange()

	local var_7_0 = self:_doCreateTouch()

	if var_7_0 then
		self:startObserver(var_7_0)
	end

	self:_doInitTouchMatch()
	self:deserializeField()
	self:onNodeEvent()
end

function MapWorld:startObserver(arg_8_1)
	arg_8_1:startListen(self)
end

function MapWorld:stopObserver(arg_9_1)
	arg_9_1:startListen(nil)
end

function MapWorld:getMapGround()
	return self._vislGround
end

function MapWorld:getMapStage()
	return self._fatherStage
end

function MapWorld:getMapId()
	return self._worldId
end

function MapWorld:setOrgCoord(arg_13_1)
	self._orgCoord = arg_13_1
end

function MapWorld:getOrgCoord()
	return self._orgCoord
end

function MapWorld:moveWorld(arg_15_1)
	local var_15_0, var_15_1 = self:getPosition()
	local var_15_2, var_15_3 = KsMath.rangeIn(var_15_0 + arg_15_1.x, self._minMoveX, self._maxMoveX)
	local var_15_4, var_15_5 = KsMath.rangeIn(var_15_1 + arg_15_1.y, self:_resetMoveRangeY(var_15_2))

	self:setPosition(var_15_2, var_15_4)

	return var_15_3, var_15_5
end

function MapWorld:movePA2PB(arg_16_1, arg_16_2)
	return self:moveWorld((cc.p(arg_16_2.x - arg_16_1.x, arg_16_2.y - arg_16_1.y)))
end

function MapWorld:convertScreenCenter()
	return self:convertToNodeSpace(display.center)
end

function MapWorld:movePA2SC(arg_18_1)
	self:movePA2PB(arg_18_1, (self:convertScreenCenter()))
end

function MapWorld:moveCell2SC(arg_19_1)
	local var_19_0, var_19_1 = self:getMapGround():coordToPixel(arg_19_1.x, arg_19_1.y)

	self:movePA2SC(cc.p(var_19_0, var_19_1))
end

function MapWorld:addEntity(arg_20_1)
	local var_20_0 = arg_20_1:getAttachName()
	local var_20_1 = self._entityFieldDict[var_20_0]

	if self._entityFieldDict[var_20_0] == nil then
		var_20_1 = MapField.new()
		self._entityFieldDict[var_20_0] = var_20_1
	end

	var_20_1:addElement(arg_20_1:getUnified(), arg_20_1)
	arg_20_1:setAutoRoleSkin(self._autoRoleSkin)
	arg_20_1:enterWorld(self)
	self:_doAddEntity(arg_20_1)
end

function MapWorld:delEntity(arg_21_1)
	local var_21_0 = self._entityFieldDict[arg_21_1:getAttachName()]

	if var_21_0 == nil then
		return
	end

	var_21_0:delElement(arg_21_1:getUnified(), arg_21_1)
	arg_21_1:leaveWorld()
	self:_doDelEntity(arg_21_1)
end

function MapWorld:cleanUnified(arg_22_1, arg_22_2)
	if self._entityFieldDict[arg_22_2] == nil then
		return
	end

	local var_22_0 = self._entityFieldDict[arg_22_2]:popElements(arg_22_1)

	if var_22_0 == nil then
		return
	end

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		iter_22_1:leaveWorld()
		self:_doDelEntity(iter_22_1)
	end
end

function MapWorld:deserializeEntity(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = self:doCreateFactory().createEntity(arg_23_1)

	var_23_0:setUnified(arg_23_3)
	var_23_0:setAttachName(arg_23_2)
	self:addEntity(var_23_0)
end

function MapWorld:serializeEntity(arg_24_1)
	return arg_24_1:serializeRecord()
end

function MapWorld:deserializeField()
	self._entityFieldDict = {}

	local var_25_0 = json.decodeFileIfExists(self:getMapGround():doBasePath() .. self._worldId .. "/" .. self._worldId .. ".json")

	if var_25_0 == nil then
		return
	end

	if var_25_0.initPos then
		self:setOrgCoord(var_25_0.initPos)
	end

	for iter_25_0, iter_25_1 in pairs((self:getMapGround():doAttachNode())) do
		if var_25_0[iter_25_1] then
			for iter_25_2, iter_25_3 in pairs(var_25_0[iter_25_1]) do
				for iter_25_4 = 1, #iter_25_3 do
					self:deserializeEntity(iter_25_3[iter_25_4], iter_25_1, iter_25_2)
				end
			end
		end
	end

	self:getMapGround():deserializeHold(var_25_0.holdDict)
end

function MapWorld:serializeField(arg_26_1)
	if self._entityFieldDict[arg_26_1] == nil then
		return nil
	end

	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs((self._entityFieldDict[arg_26_1]:getCoordModel())) do
		local var_26_1 = {}

		for iter_26_2 = 1, #iter_26_1 do
			table.insert(var_26_1, (self:serializeEntity(iter_26_1[iter_26_2])))
		end

		var_26_0[iter_26_0] = var_26_1
	end

	return var_26_0
end

function MapWorld:_doCreateGround()
	return MapGround.new(self)
end

function MapWorld:_doCreateTouch()
	return TouchOne.new()
end

function MapWorld:_doInitTouchMatch()
	self._mapTouch = MapTouch.new(self)
end

function MapWorld:doCreateFactory()
	return EntityFactory
end

function MapWorld:_doAddEntity(arg_31_1)
	return
end

function MapWorld:_doDelEntity(arg_32_1)
	return
end

function MapWorld:_doTickUpdate(arg_33_1)
	return
end

function MapWorld:doDragWorld(arg_34_1)
	local var_34_0, var_34_1 = self:getPosition()

	self:setPosition(var_34_0 + arg_34_1.x, var_34_1 + arg_34_1.y)
end

function MapWorld:_initMoveRange()
	local var_35_0 = self:getMapGround():getMapHeight()
	local var_35_1 = self:getMapGround()
	local var_35_2 = var_35_1:getHalfTileH()

	self._minMoveX = -var_35_1
	self._maxMoveX = self:getMapGround():getMapWidth() / 2 - display.width / 2 - display.height
	self._minMoveY = var_35_0 / 2 - var_35_2 - self._maxMoveX / 2
	self._maxMoveY = var_35_0 / 2 - var_35_2 + self._maxMoveX / 2
end

function MapWorld:_resetMoveRangeY(arg_36_1)
	local var_36_0 = math.abs(arg_36_1)

	return self._minMoveY + var_36_0 / 2, self._maxMoveY - var_36_0 / 2
end

function MapWorld:_checkEntityInView()
	local var_37_0 = self:convertScreenCenter()

	if KsMath.rectIn(self._lastPosSC, var_37_0, MapConst.PRE_LOAD_JITTER, MapConst.PRE_LOAD_JITTER / 2) then
		return
	end

	self._lastPosSC = var_37_0

	local var_37_1 = {
		x = var_37_0.x,
		y = var_37_0.y,
		width = display.width / 2 + MapConst.PRE_SHOW_DIS,
		height = display.height / 2 + MapConst.PRE_SHOW_DIS
	}

	for iter_37_0, iter_37_1 in pairs(self._entityFieldDict) do
		for iter_37_2, iter_37_3 in pairs((iter_37_1:getCoordModel())) do
			for iter_37_4, iter_37_5 in pairs(iter_37_3) do
				if not iter_37_5:isMainRole() then
					iter_37_5:setInView((iter_37_5:checkIsNeedShow(var_37_1)))
				end
			end
		end
	end
end

function MapWorld:onCoverTouchBegan(arg_38_1, arg_38_2)
	if self._mapTouch == nil then
		return false
	end

	return self._mapTouch:onMatchBegan(arg_38_1)
end

function MapWorld:onCoverTouchMoved(arg_39_1, arg_39_2)
	if self._mapTouch then
		self._mapTouch:onMatchMoved(arg_39_1)
	end
end

function MapWorld:onCoverTouchEnded(arg_40_1, arg_40_2)
	if self._mapTouch then
		self._mapTouch:onMatchEnded(arg_40_1)
	end
end

function MapWorld:onCoverClicked(arg_41_1, arg_41_2)
	if self._mapTouch then
		self._mapTouch:onMatchClicked(arg_41_1)
	end
end

function MapWorld:onCoverRightClicked(arg_42_1, arg_42_2)
	if self._mapTouch then
		self._mapTouch:onMatchRightClicked(arg_42_1)
	end
end

function MapWorld:onCoverMiddleClicked(arg_43_1, arg_43_2)
	if self._mapTouch then
		self._mapTouch:onMatchMiddleClicked(arg_43_1)
	end
end

function MapWorld:getTargetAngelFromScreenCenter(arg_44_1)
	local var_44_0 = cc.p(1, 0)
	local var_44_1 = 1

	if arg_44_1.x >= 0 and arg_44_1.y >= 0 then
		var_44_1 = 1
	elseif arg_44_1.x <= 0 and arg_44_1.y >= 0 then
		var_44_1 = 2
		var_44_0 = cc.p(-1, 0)
	elseif arg_44_1.x <= 0 and arg_44_1.y <= 0 then
		var_44_1 = 3
		var_44_0 = cc.p(-1, 0)
	elseif arg_44_1.x >= 0 and arg_44_1.y <= 0 then
		var_44_1 = 4
	end

	local var_44_3 = math.acos((arg_44_1.x * var_44_0.x + arg_44_1.y * var_44_0.y) / (math.sqrt(math.pow(arg_44_1.x, 2) + math.pow(arg_44_1.y, 2)) * math.sqrt(math.pow(var_44_0.x, 2) + math.pow(var_44_0.y, 2)))) * (180 / math.pi)
	local var_44_4

	if var_44_1 == 1 then
		var_44_3 = 360 - var_44_3
	elseif var_44_1 == 2 then
		var_44_3 = 180 + var_44_3
	elseif var_44_1 == 3 then
		var_44_3 = 180 - var_44_3
		var_44_4 = var_44_3
	end

	return var_44_4, var_44_3 >= 45 and var_44_3 < 135 and 6 or var_44_3 >= 135 and var_44_3 < 225 and 4 or var_44_3 >= 225 and var_44_3 < 315 and 2 or 0
end

function MapWorld:checkSingleEntityInView(arg_45_1)
	local var_45_0 = self:convertScreenCenter()

	if arg_45_1 and arg_45_1:checkIsNeedShow({
		x = var_45_0.x,
		y = var_45_0.y,
		width = display.width / 2 + MapConst.PRE_SHOW_DIS - 120,
		height = display.height / 2 + MapConst.PRE_SHOW_DIS - 120
	}) then
		return true
	end

	return false
end

function MapWorld:setAutoRoleSkin(arg_46_1)
	self._autoRoleSkin = arg_46_1
end

return MapWorld
