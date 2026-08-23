local var_0_0 = g.core.model.User.redCliffData
local var_0_1 = g.core.const.ConstMgr.RedCliffConst
local RedCliffMapCommon = require("app.view.module.redCliff.common.RedCliffMapCommon")
local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local BattleConst = require("app.view.battle.const.BattleConst")
local MapConst = require("app.core.ksmap.MapConst")
local var_0_6 = "ROBOT_"
local var_0_7 = 1000
local RedCliffFloorComp = class("RedCliffFloorComp", require("app.fairyGUI.redCliff.UI_RedCliffFloorComp"))

function RedCliffFloorComp:ctor()
	self._curPosX = 0
	self._curPosY = 0
	self._createCnt = 0
	self._mainRoleCoordinate = cc.p(0, 0)
	self._effectCallBack = nil
	self._robotIndex = 1
	self._robotPool = NodePool.new(self, "redCliff", "RedCliffRobotKnightComp", 10)
	self._tilePool = NodePool.new(self, "redCliff", "RedCliffMapTiledComp", 25)
	self._compQueue = {}
	self._bigEditorComp = nil
	self._compDict = {}
	self._compCoord = {}
	self._showPosDict = {}
	self._robotDict = {}
	self._removeDict = {}
	self._existRobotNum = 0
	self._robotMaxNum = var_0_0:getRobotMaxNum()
end

function RedCliffFloorComp:updateOccupyView(arg_2_1)
	local var_2_0 = self:_getCoordKey((var_0_0:getEditorStructByComponentId(arg_2_1):getVertexCoord()))

	if self._showPosDict[var_2_0] then
		self._compCoord[var_2_0]:updateOccupyPlayer(true)
		self._compCoord[var_2_0]:updateCountDown()
	end

	if var_0_0:getMyPlayerStruct():getComponentId() == arg_2_1 then
		self.m_mainRole:setVisible(false)
	end
end

function RedCliffFloorComp:_updateEditorCdByComponentId(arg_3_1)
	if self._compDict[arg_3_1] then
		if self._showPosDict[self:_getCoordKey((self._compDict[arg_3_1]:getStruct():getVertexCoord()))] then
			self._compDict[arg_3_1]:updateCountDown()
		end
	end
end

function RedCliffFloorComp:updateEditorCd()
	for iter_4_0, iter_4_1 in pairs(self._compDict) do
		if iter_4_1:getEditorType() ~= var_0_1.EDITOR_TYPE.BARRIER then
			if self._showPosDict[self:_getCoordKey((iter_4_1:getStruct():getVertexCoord()))] then
				iter_4_1:updateCountDown()
			end
		end
	end
end

function RedCliffFloorComp:updateMapRoleCd()
	self.m_mainRole:updateMapRoleCountDown()
end

function RedCliffFloorComp:setCompPosition(arg_6_1, arg_6_2, arg_6_3)
	arg_6_3 = arg_6_3 or cc.p(RedCliffMapCommon.coordToCompPos(arg_6_2))

	arg_6_1:setPosition(arg_6_3)
	arg_6_1:displayObject():setLocalZOrder(arg_6_2.x + arg_6_2.y)
end

function RedCliffFloorComp:updateCurShowComp()
	for iter_7_0, iter_7_1 in pairs(self._compCoord) do
		iter_7_1:updateOccupyPlayer(false)
	end
end

function RedCliffFloorComp:updateCurPos(arg_8_1, arg_8_2)
	local var_8_0 = var_0_0:getMyPlayerStruct()

	if not self.m_mainRole:isVisible() and var_8_0 and not var_8_0:isOccupy() then
		self:_initMainRole()
	end

	local var_8_1 = RedCliffMapCommon.getMapTiledSize()
	local var_8_2, var_8_3 = RedCliffMapCommon.getGlobalCoordinateByWorldPos({
		x = -arg_8_1,
		y = arg_8_2
	})
	local var_8_4 = cc.p(RedCliffMapCommon.getWorldPosByGlobalCoordinate(cc.p(var_8_2, var_8_3)))

	self._curPosX = -var_8_4.x
	self._curPosY = var_8_4.y

	local var_8_5 = math.ceil(display.width / (2 * var_8_1.width)) + 2 + 1
	local var_8_6 = math.ceil(display.height / (2 * var_8_1.height)) + 2 + 1
	local var_8_7 = {}

	for iter_8_0 = 1, 2 * var_8_5 do
		for iter_8_1 = 1, 2 * var_8_6 do
			local var_8_8 = math.max(0, var_8_2 - var_8_5 - var_8_6 - 1 + iter_8_0 + iter_8_1)
			local var_8_9 = math.max(0, var_8_3 + var_8_5 - var_8_6 - 1 - iter_8_0 + iter_8_1)

			self:checkTempPos(var_8_8, var_8_9, var_8_7)
			self:checkTempPos(var_8_8, math.max(0, var_8_9 - 1), var_8_7)
		end
	end

	local var_8_10 = {}
	local var_8_11 = {}

	for iter_8_2, iter_8_3 in pairs(var_8_7) do
		if not self._showPosDict[iter_8_2] then
			table.insert(var_8_10, iter_8_2)
		else
			self._showPosDict[iter_8_2] = nil
		end
	end

	for iter_8_4, iter_8_5 in pairs(self._showPosDict) do
		table.insert(var_8_11, iter_8_4)
	end

	for iter_8_6, iter_8_7 in ipairs(var_8_11) do
		local var_8_12 = iter_8_7:split("_")
		local var_8_13 = cc.p(tonumber(var_8_12[1]), tonumber(var_8_12[2]))

		if self._compCoord[var_8_13.x .. "_" .. var_8_13.y] and self._compCoord[var_8_13.x .. "_" .. var_8_13.y]:getEditorType() ~= var_0_1.EDITOR_TYPE.BIG then
			self:_pushCompToQueue(self._compCoord[var_8_13.x .. "_" .. var_8_13.y])

			self._compCoord[var_8_13.x .. "_" .. var_8_13.y] = nil
		end
	end

	for iter_8_8, iter_8_9 in ipairs(var_8_10) do
		local var_8_14 = iter_8_9:split("_")
		local var_8_15 = var_0_0:getEditorStructByCoord((cc.p(tonumber(var_8_14[1]), tonumber(var_8_14[2]))))
		local var_8_16 = var_8_15:getEditorType()
		local var_8_17 = var_8_15:getComponentId()
		local var_8_18 = var_8_15:getVertexCoord()

		if not self._compCoord[var_8_18.x .. "_" .. var_8_18.y] then
			if var_8_16 == var_0_1.EDITOR_TYPE.BIG then
				if not self._bigEditorComp then
					local var_8_19 = fgui.UIPackage:createObject("redCliff", "RedCliffBigEditorComp")

					self._bigEditorComp = var_8_19

					self:addChild(var_8_19)

					self._compCoord[var_8_18.x .. "_" .. var_8_18.y] = var_8_19
					self._compDict[var_8_17] = var_8_19

					var_8_19:updateCompView(var_8_15)
					self:setCompPosition(var_8_19, var_8_18)
					var_8_19:setVisible(true)
				end
			else
				local var_8_20 = self:_popCompFromQueue()

				var_8_20:updateCompView(var_8_15)
				self:setCompPosition(var_8_20, var_8_18)

				self._compCoord[var_8_18.x .. "_" .. var_8_18.y] = var_8_20
				self._compDict[var_8_17] = var_8_20

				var_8_20:setVisible(true)
			end
		elseif var_8_16 == var_0_1.EDITOR_TYPE.BIG then
			self._compCoord[var_8_18.x .. "_" .. var_8_18.y]:updateCompView(var_8_15)
		end
	end

	self._showPosDict = var_8_7
end

function RedCliffFloorComp:_pushCompToQueue(arg_9_1, arg_9_2)
	self._compQueue[#self._compQueue + 1] = arg_9_1

	arg_9_1:setVisible(false)
end

function RedCliffFloorComp:_popCompFromQueue()
	if #self._compQueue > 0 then
		table.remove(self._compQueue, 1)

		return self._compQueue[1]
	end

	local var_10_0 = fgui.UIPackage:createObject("redCliff", "RedCliffMapTiledComp")

	self:addChild(var_10_0)

	return var_10_0
end

function RedCliffFloorComp:checkTempPos(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 + arg_11_2 <= 0 then
		return
	end

	if var_0_0:getEditorStructByCoord(cc.p(arg_11_1, arg_11_2)) then
		arg_11_3[arg_11_1 .. "_" .. arg_11_2] = true
	end
end

function RedCliffFloorComp:getCompByComponentId(arg_12_1)
	return self._compDict[arg_12_1]
end

function RedCliffFloorComp:updateFertile()
	for iter_13_0, iter_13_1 in pairs((var_0_0:getEditorStructIdMap())) do
		local var_13_0 = self:_getCoordKey((iter_13_1:getVertexCoord()))

		if self._showPosDict[var_13_0] then
			if self._compCoord[var_13_0] then
				self._compCoord[var_13_0]:updateFertile()
			end
		end
	end
end

function RedCliffFloorComp:_getCoordKey(arg_14_1)
	return arg_14_1.x .. "_" .. arg_14_1.y
end

function RedCliffFloorComp:_initMainRole()
	local var_15_0 = var_0_0:getMyPlayerStruct()

	self.m_mainRole:initMapRole(var_15_0)
	self:updateMainRoleCoordinate((var_0_0:getEditorStructByComponentId((var_15_0:getComponentId())):getVertexCoord()))
	self.m_mainRole:setVisible(true)
end

function RedCliffFloorComp:updateEditorRole()
	local var_16_0 = var_0_0:getMyPlayerStruct()

	self.m_mainRole:updateEditorRole(var_16_0)
	self.m_mainRole:setVisible(not var_16_0:isOccupy())
end

function RedCliffFloorComp:updateMainRoleDir(arg_17_1)
	self.m_mainRole:setInnerDir(arg_17_1)
end

function RedCliffFloorComp:updateMainRoleCoordinate(arg_18_1)
	self:_setRoleCoordinate(self.m_mainRole, arg_18_1)

	self._mainRoleCoordinate = cc.p(arg_18_1.x, arg_18_1.y)
end

function RedCliffFloorComp:_setRoleCoordinate(arg_19_1, arg_19_2)
	if var_0_0:isMainRoleZOrderHigh(arg_19_2) then
		arg_19_1:setPosition((cc.p(RedCliffMapCommon.coordToCompPos(arg_19_2))))
		arg_19_1:displayObject():setLocalZOrder(var_0_7)
	else
		self:setCompPosition(arg_19_1, arg_19_2)
	end
end

function RedCliffFloorComp:updateMapRole()
	self.m_mainRole:setVisible(not var_0_0:getMyPlayerStruct():isOccupy())
	self.m_mainRole:updateMapRole()
end

function RedCliffFloorComp:getMainRoleCompCoordinate()
	return self._mainRoleCoordinate
end

function RedCliffFloorComp:getMainRolePos()
	return self.m_mainRole:getPosition()
end

function RedCliffFloorComp:mapRoleStartRun()
	self.m_mainRole:playInnerAction("run")
end

function RedCliffFloorComp:mapRoleStopRun()
	self.m_mainRole:playInnerAction("idle")
end

function RedCliffFloorComp:mapRolePlayInnerAction(arg_25_1)
	self.m_mainRole:playInnerAction(arg_25_1)
end

function RedCliffFloorComp:playAttackAnimation(arg_26_1, arg_26_2)
	self.m_mainRole:playAttackAnimation(arg_26_1, arg_26_2)
end

function RedCliffFloorComp:generateRandomPlayer(arg_27_1)
	for iter_27_0 = 1, arg_27_1 do
		if self._robotMaxNum > self._existRobotNum then
			local var_27_0 = self._robotPool:takeOutFirstCompInPool()

			var_27_0:updateRobot(var_0_6 .. self._robotIndex)

			local var_27_1 = var_27_0:getRobotPath()

			if var_27_1 then
				self:addChild(var_27_0)

				self._robotIndex = self._robotIndex + 1
				self._robotDict[var_0_6 .. self._robotIndex] = var_27_0
				self._existRobotNum = self._existRobotNum + 1

				self:_setRoleCoordinate(var_27_0, var_27_1[1])
				var_27_0:setVisible(true)
				var_27_0:playInnerAction(BattleConst.SPINE_ACTION_TYPE.RUN)
			else
				var_27_0:resetRobot()
				self._robotPool:recoveryCompInPool(var_27_0)
			end
		end
	end
end

function RedCliffFloorComp:updateRobotCompPosition()
	for iter_28_0, iter_28_1 in pairs(self._robotDict) do
		local var_28_0 = iter_28_1:getLastCoord()
		local var_28_1 = iter_28_1:getCurCoord()

		if var_28_1 then
			if var_28_0 then
				self:_setRunDir(iter_28_1, var_28_0, var_28_1)
			end

			self:_setRoleCoordinate(iter_28_1, var_28_1)
		else
			self._robotDict[iter_28_0] = nil
			self._removeDict[iter_28_0] = iter_28_1

			iter_28_1:playRobotAttackAnim(handler(self, self._onRobotDeadFinish), iter_28_0)
		end
	end
end

function RedCliffFloorComp:_onRobotDeadFinish(arg_29_1)
	if self._removeDict[arg_29_1] then
		self._removeDict[arg_29_1]:resetRobot()
		self._removeDict[arg_29_1]:removeFromParent()
		self._robotPool:recoveryCompInPool(self._removeDict[arg_29_1])

		self._robotDict[arg_29_1] = nil
		self._existRobotNum = self._existRobotNum - 1
	end
end

function RedCliffFloorComp:_setRunDir(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0, var_30_1 = RedCliffMapCommon.coordToCompPos(arg_30_2)
	local var_30_2, var_30_3 = RedCliffMapCommon.coordToCompPos(arg_30_3)

	if math.abs(var_30_2 - var_30_0) > 0.001 then
		if var_30_0 < var_30_2 then
			arg_30_1:setInnerDir(MapConst.DIRECTION.RIGHT)
		elseif var_30_2 < var_30_0 then
			arg_30_1:setInnerDir(MapConst.DIRECTION.LEFT)
		end
	end
end

function RedCliffFloorComp:onUnload()
	self._robotPool:clearPool()
	self._tilePool:clearPool()
end

return RedCliffFloorComp
