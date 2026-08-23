local var_0_0 = g.core.model.User.explorationData
local ExplorationMapCommon = require("app.view.module.exploration.common.ExplorationMapCommon")
local ExplorationFloorComp = class("ExplorationFloorComp", require("app.fairyGUI.exploration.UI_ExplorationFloorComp"))

function ExplorationFloorComp:ctor()
	self._curPosX = 0
	self._curPosY = 0
	self._createCnt = 0
	self._mainRoleCoordinate = cc.p(0, 0)
	self._effectCallBack = nil
	self._compPool = {}
	self._floatPool = {
		ExplorationTiledNameComp = {},
		ExplorationMapKnightComp = {}
	}
	self._compDic = {}
	self._effectComp = nil
	self._effectMirrorComp = nil
	self._effectMirrorSpine = nil
	self._showPosDic = {}

	self:_initCompPool()
end

function ExplorationFloorComp:_initCompPool()
	self._compPool.ExplorationMapTiledComp = {}
	self._effectComp = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

	self._effectComp:setSize(cc.size(0, 0))
	self:addChild(self._effectComp)
	self._effectComp:displayObject():setLocalZOrder(1005)

	self._effectMirrorComp = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

	self._effectMirrorComp:setSize(cc.size(0, 0))
	self:addChild(self._effectMirrorComp)
	self._effectMirrorComp:displayObject():setLocalZOrder(1005)
end

function ExplorationFloorComp:_createCompByType(arg_3_1)
	if arg_3_1 == "barrier" then
		self:_createBarrierComp()
	elseif arg_3_1 == "build" then
		self:_createBuildComp()
	end

	self._createCnt = self._createCnt + 1
end

function ExplorationFloorComp:_createBarrierComp()
	local var_4_0 = fgui.UIPackage:createObject("exploration", "ExplorationMapTiledComp")

	self:addChildWithListen(var_4_0)

	local var_4_1 = self._compPool[var_4_0:getName()]

	var_4_1[#var_4_1 + 1] = var_4_0
end

function ExplorationFloorComp:_createBuildComp()
	local var_5_0 = fgui.UIPackage:createObject("exploration", "ExplorationMapTiledComp")

	self:addChildWithListen(var_5_0)

	local var_5_1 = self._compPool[var_5_0:getName()]

	var_5_1[#var_5_1 + 1] = var_5_0
end

function ExplorationFloorComp:_popComp(arg_6_1)
	local var_6_0 = ({
		barrier = "ExplorationMapTiledComp",
		build = "ExplorationMapTiledComp"
	})[arg_6_1]
	local var_6_1 = self._compPool[var_6_0]

	if not self._compPool[var_6_0] then
		var_6_1 = {}
		self._compPool[var_6_0] = var_6_1
	end

	if #var_6_1 == 0 then
		self:_createCompByType(arg_6_1)
	end

	return table.remove(var_6_1, 1)
end

function ExplorationFloorComp:_pushComp(arg_7_1)
	local var_7_0 = self._compPool[arg_7_1:getName()]

	var_7_0[#var_7_0 + 1] = arg_7_1

	arg_7_1:setVisible(false)
end

function ExplorationFloorComp:_createFloatNode(arg_8_1)
	local var_8_0

	if arg_8_1.type == "ExplorationTiledNameComp" then
		var_8_0 = fgui.UIPackage:createObject("exploration", "ExplorationTiledNameComp")

		self:addChild(var_8_0)
	elseif arg_8_1.type == "ExplorationMapKnightComp" then
		var_8_0 = fgui.UIPackage:createObject("exploration", "ExplorationMapKnightComp")

		self:addChild(var_8_0)
	end

	return var_8_0
end

function ExplorationFloorComp:_popFloatNode(arg_9_1)
	local var_9_0

	if arg_9_1.type == "ExplorationTiledNameComp" then
		var_9_0 = table.remove(self._floatPool[arg_9_1.type], 1)
	elseif arg_9_1.type == "ExplorationMapKnightComp" then
		local var_9_1 = self._floatPool[arg_9_1.type][arg_9_1.info.resId]

		if not self._floatPool[arg_9_1.type][arg_9_1.info.resId] then
			var_9_1 = {}
			self._floatPool[arg_9_1.type][arg_9_1.info.resId] = var_9_1
		end

		var_9_0 = table.remove(var_9_1, 1)
	end

	var_9_0 = var_9_0 or self:_createFloatNode(arg_9_1)

	var_9_0:setVisible(true)

	return var_9_0
end

function ExplorationFloorComp:_pushFloatNode(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:getName()

	arg_10_1:setVisible(false)

	if var_10_0 == "ExplorationTiledNameComp" then
		self._floatPool[var_10_0][#self._floatPool[var_10_0] + 1] = arg_10_1
	elseif var_10_0 == "ExplorationMapKnightComp" then
		self._floatPool[var_10_0][arg_10_2.info.resId][#self._floatPool[var_10_0][arg_10_2.info.resId] + 1] = arg_10_1
	end
end

function ExplorationFloorComp:onUnload()
	self._effectMirrorSpine = nil
end

function ExplorationFloorComp:updateCurPos(arg_12_1, arg_12_2)
	local var_12_0 = ExplorationMapCommon.getMapTiledSize()

	if not self.m_mainRole:isVisible() then
		self:_initMainRole()
	end

	local var_12_1, var_12_2 = ExplorationMapCommon.getGlobalCoordinateByWorldPos({
		x = -arg_12_1,
		y = arg_12_2
	})

	if math.abs(self._curPosX - arg_12_1) < 0.5 * var_12_0.width and math.abs(self._curPosY - arg_12_2) < 0.5 * var_12_0.height then
		return
	end

	local var_12_3 = cc.p(ExplorationMapCommon.getWorldPosByGlobalCoordinate(cc.p(var_12_1, var_12_2)))

	self._curPosX = -var_12_3.x
	self._curPosY = var_12_3.y

	local var_12_4 = math.ceil(display.width / (2 * var_12_0.width)) + 2 + 1
	local var_12_5 = math.ceil(display.height / (2 * var_12_0.height)) + 2 + 1
	local var_12_6 = {}

	for iter_12_0 = 1, 2 * var_12_4 do
		for iter_12_1 = 1, 2 * var_12_5 do
			local var_12_7 = math.max(0, var_12_1 - var_12_4 - var_12_5 - 1 + iter_12_0 + iter_12_1)
			local var_12_8 = math.max(0, var_12_2 + var_12_4 - var_12_5 - 1 - iter_12_0 + iter_12_1)

			self:checkTempPos(var_12_7, var_12_8, var_12_6)
			self:checkTempPos(var_12_7, math.max(0, var_12_8 - 1), var_12_6)
		end
	end

	local var_12_9 = {}
	local var_12_10 = {}

	for iter_12_2, iter_12_3 in pairs(var_12_6) do
		if not self._showPosDic[iter_12_2] then
			table.insert(var_12_9, iter_12_2)
		else
			self._showPosDic[iter_12_2] = nil
		end
	end

	for iter_12_4, iter_12_5 in pairs(self._showPosDic) do
		table.insert(var_12_10, iter_12_4)
	end

	local var_12_11 = var_0_0:getMapData():getMirrorCoordinate()

	for iter_12_6, iter_12_7 in ipairs(var_12_10) do
		local var_12_12 = iter_12_7:split("_")
		local var_12_13 = {
			x = tonumber(var_12_12[1]),
			y = tonumber(var_12_12[2])
		}

		if self._compDic[var_12_13.x .. "_" .. var_12_13.y] then
			self:_pushComp(self._compDic[var_12_13.x .. "_" .. var_12_13.y])

			self._compDic[var_12_13.x .. "_" .. var_12_13.y] = nil
		end

		if var_12_11.x == var_12_13.x and var_12_11.y == var_12_13.y then
			self._effectMirrorComp:setVisible(false)
		end
	end

	for iter_12_8, iter_12_9 in ipairs(var_12_9) do
		local var_12_14 = iter_12_9:split("_")
		local var_12_15 = {
			x = tonumber(var_12_14[1]),
			y = tonumber(var_12_14[2])
		}
		local var_12_16 = var_0_0:getMapData():getTiledInfo(var_12_15)

		if var_12_16 then
			local var_12_17 = self:_popComp(var_12_16.type)

			self:setCompPosition(var_12_17, var_12_15)
			var_12_17:updateCompView(var_12_16)
			var_12_17:setVisible(true)

			self._compDic[var_12_15.x .. "_" .. var_12_15.y] = var_12_17

			local var_12_18 = var_12_17:getFloatInfo()

			if var_12_18.isDirty then
				var_12_17:setAndUpdateFloatComp(self:_popFloatNode(var_12_18.param), var_12_18.param)
			end
		end
	end

	self._showPosDic = var_12_6
end

function ExplorationFloorComp:checkTempPos(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_1 + arg_13_2 <= 0 then
		return
	end

	arg_13_3[arg_13_1 .. "_" .. arg_13_2] = true
end

function ExplorationFloorComp:setCompPosition(arg_14_1, arg_14_2, arg_14_3)
	arg_14_3 = arg_14_3 or cc.p(ExplorationMapCommon.coordToCompPos(arg_14_2))

	arg_14_1:setPosition(arg_14_3)
	arg_14_1:displayObject():setLocalZOrder(arg_14_2.x + arg_14_2.y)
end

function ExplorationFloorComp:updateChildCompByCoordinate(arg_15_1)
	self._compDic[arg_15_1.x .. "_" .. arg_15_1.y]:updateCompView((var_0_0:getMapData():getTiledInfo(arg_15_1)))

	local var_15_0 = self._compDic[arg_15_1.x .. "_" .. arg_15_1.y]:getFloatInfo()

	if var_15_0.isDirty then
		self._compDic[arg_15_1.x .. "_" .. arg_15_1.y]:setAndUpdateFloatComp(self:_popFloatNode(var_15_0.param), var_15_0.param)
	end
end

function ExplorationFloorComp:updateCurComp()
	for iter_16_0, iter_16_1 in pairs(self._compDic) do
		local var_16_0 = iter_16_0:split("_")
		local var_16_1 = var_0_0:getMapData():getTiledInfo((cc.p(tonumber(var_16_0[1]), tonumber(var_16_0[2]))))

		if var_16_1 then
			iter_16_1:updateCompView(var_16_1)

			local var_16_2 = iter_16_1:getFloatInfo()

			if var_16_2.isDirty then
				iter_16_1:setAndUpdateFloatComp(self:_popFloatNode(var_16_2.param), var_16_2.param)
			end
		end
	end
end

function ExplorationFloorComp:onSingleClick(arg_17_1, arg_17_2, arg_17_3)
	if self._compDic[arg_17_1 .. "_" .. arg_17_2] then
		self._compDic[arg_17_1 .. "_" .. arg_17_2]:onSingleClick(arg_17_3)
	end
end

function ExplorationFloorComp:receiveCompEvent(arg_18_1, arg_18_2)
	if arg_18_1 == "pushFloatComp" then
		self:_pushFloatNode(arg_18_2.node, arg_18_2.param)

		return true
	elseif arg_18_1 == "knightDiedPlayEnd" then
		self:updateCurComp()

		return true
	elseif arg_18_1 == "updateMirrorEffect" then
		if var_0_0:getMapData():canGetMirror() then
			self:playMirrorEffect()
		else
			self._effectMirrorComp:setVisible(false)
		end
	end

	return false
end

function ExplorationFloorComp:playEventEffect(arg_19_1, arg_19_2, arg_19_3)
	self._effectComp:setPosition(self._compDic[arg_19_1 .. "_" .. arg_19_2]:getPosition())
	self._effectComp:addEffectSpine({
		isLoop = false,
		anim = "play",
		remove = true,
		name = "eff_ui_explorationMap_cell",
		eventHandler = handler(self, self._onPlayEventEffectHandler)
	})
	self._effectComp:setVisible(true)

	self._effectCallBack = arg_19_3
end

function ExplorationFloorComp:_onPlayEventEffectHandler(arg_20_1, arg_20_2)
	if arg_20_1.type == "complete" then
		self._effectComp:setVisible(false)

		if self._effectCallBack then
			self._effectCallBack()
		end
	end
end

function ExplorationFloorComp:playMirrorEffect()
	local var_21_0 = var_0_0:getMapData():getMirrorCoordinate()

	self._effectMirrorComp:setPosition(self._compDic[var_21_0.x .. "_" .. var_21_0.y]:getPosition())
	self._effectMirrorComp:displayObject():setLocalZOrder(self._compDic[var_21_0.x .. "_" .. var_21_0.y]:displayObject():getLocalZOrder() + 1)

	self._effectMirrorSpine = self._effectMirrorSpine or self._effectMirrorComp:addEffectSpine({
		isLoop = true,
		anim = "play",
		remove = false,
		name = "exploration_map_155_effect",
		eventHandler = handler(self, self._onPlayMirrorEffectHandler)
	})

	self._effectMirrorComp:setVisible(true)
end

function ExplorationFloorComp:_onPlayMirrorEffectHandler(arg_22_1, arg_22_2)
	return
end

function ExplorationFloorComp:updateMainRole()
	self.m_mainRole:updateMainRole()
end

function ExplorationFloorComp:updateMainRoleDir(arg_24_1)
	self.m_mainRole:setInnerDir(arg_24_1)
end

function ExplorationFloorComp:updateMainRoleCoordinate(arg_25_1)
	self:setCompPosition(self.m_mainRole, arg_25_1)

	self._mainRoleCoordinate = cc.p(arg_25_1.x, arg_25_1.y)
end

function ExplorationFloorComp:updateMainRoleCompPos(arg_26_1)
	self:setCompPosition(self.m_mainRole, cc.p(ExplorationMapCommon.compPosToCoord(arg_26_1)), arg_26_1)
end

function ExplorationFloorComp:_initMainRole()
	self.m_mainRole:updateMainRole()
	self:updateMainRoleCoordinate((var_0_0:getMapData():getMainRoleCoordinate()))
	self.m_mainRole:setVisible(true)
end

function ExplorationFloorComp:getMainRoleCompCoordinate()
	return self._mainRoleCoordinate
end

function ExplorationFloorComp:getMainRolePos()
	return self.m_mainRole:getPosition()
end

function ExplorationFloorComp:mainRoleStartRun()
	self.m_mainRole:playInnerAction("run")
end

function ExplorationFloorComp:mainRoleStopRun()
	self:updateMainRoleCoordinate((var_0_0:getMapData():getMainRoleCoordinate()))
	self.m_mainRole:playInnerAction("idle")
end

function ExplorationFloorComp:mainRoleJumpToCoordinate(arg_32_1)
	self:updateMainRoleCoordinate(arg_32_1)
	self.m_mainRole:playJumpEffect()
end

function ExplorationFloorComp:getFloorChildComp(arg_33_1)
	return self._compDic[arg_33_1.x .. "_" .. arg_33_1.y]
end

return ExplorationFloorComp
