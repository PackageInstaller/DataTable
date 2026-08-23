local var_0_0 = g.core.model.User.teamBattleData
local TeamBattleMapCommon = require("app.view.module.teamBattle.common.TeamBattleMapCommon")
local TeamBattleMapFloorComp = class("TeamBattleMapFloorComp")

function TeamBattleMapFloorComp:ctor()
	self._curPosX = 0
	self._curPosY = 0
	self._createCnt = 0
	self._effectCallBack = nil
	self._compPool = {}
	self._floatPool = {
		TeamBattleTiledShopNameComp = {},
		TeamBattleMapKnightComp = {}
	}
	self._compDic = {}
	self._groundCompDic = {}
	self._effectComp = nil
	self._effectMirrorComp = nil
	self._effectMirrorSpine = nil
	self._showPosDic = {}
	self._roleCompPool = {}
	self._roleCompPosMap = {}

	self:_initCompPool()
end

function TeamBattleMapFloorComp:_initCompPool()
	self._compPool.TeamBattleMapTiledComp = {}
	self._compPool.TeamBattleMapGroundComp = {}
	self._effectComp = fgui.UIPackage:createObject("base_new", "BasePlaceHolderComp")

	self._effectComp:setSize(cc.size(0, 0))
	self:addChild(self._effectComp)
	self._effectComp:displayObject():setLocalZOrder(1005)

	self._roleCompPool = {}

	for iter_2_0, iter_2_1 in ipairs(g.core.model.User.teamBattleData:getTeamUpData():getMyTeam().members) do
		local var_2_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleMapKnightComp")

		self:addChild(var_2_0)
		var_2_0:setVisible(false)

		self._roleCompPool[iter_2_1] = var_2_0
	end
end

function TeamBattleMapFloorComp:getRoleComp(arg_3_1)
	if not self._roleCompPool[arg_3_1]:isInitRole() then
		self._roleCompPool[arg_3_1]:updateRole((g.core.model.User.teamBattleData:getMapData():getPlayerStruct(arg_3_1)))
		self:_initRole(arg_3_1)
	end

	self._roleCompPool[arg_3_1]:checkRoleSpine()

	return self._roleCompPool[arg_3_1]
end

function TeamBattleMapFloorComp:_createCompByType(arg_4_1)
	if arg_4_1 == "barrier" then
		self:_createBarrierComp()
	elseif arg_4_1 == "ground" then
		self:_createGroundComp()
	elseif arg_4_1 == "build" then
		self:_createBuildComp()
	end

	self._createCnt = self._createCnt + 1
end

function TeamBattleMapFloorComp:_createGroundComp()
	local var_5_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleMapGroundComp")

	self:addChildWithListen(var_5_0)

	local var_5_1 = self._compPool[var_5_0:getName()]

	var_5_1[#var_5_1 + 1] = var_5_0
end

function TeamBattleMapFloorComp:_createBarrierComp()
	local var_6_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleMapTiledComp")

	self:addChildWithListen(var_6_0)

	local var_6_1 = self._compPool[var_6_0:getName()]

	var_6_1[#var_6_1 + 1] = var_6_0
end

function TeamBattleMapFloorComp:_createBuildComp()
	local var_7_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleMapTiledComp")

	self:addChildWithListen(var_7_0)

	local var_7_1 = self._compPool[var_7_0:getName()]

	var_7_1[#var_7_1 + 1] = var_7_0
end

function TeamBattleMapFloorComp:_popComp(arg_8_1)
	local var_8_0 = ({
		barrier = "TeamBattleMapTiledComp",
		build = "TeamBattleMapTiledComp",
		ground = "TeamBattleMapGroundComp"
	})[arg_8_1]
	local var_8_1 = self._compPool[var_8_0]

	if not self._compPool[var_8_0] then
		var_8_1 = {}
		self._compPool[var_8_0] = var_8_1
	end

	if #var_8_1 == 0 then
		self:_createCompByType(arg_8_1)
	end

	return table.remove(var_8_1, 1)
end

function TeamBattleMapFloorComp:_pushComp(arg_9_1)
	local var_9_0 = self._compPool[arg_9_1:getName()]

	var_9_0[#var_9_0 + 1] = arg_9_1

	arg_9_1:setVisible(false)
end

function TeamBattleMapFloorComp:_createFloatNode(arg_10_1)
	local var_10_0

	if arg_10_1.type == "TeamBattleTiledShopNameComp" then
		var_10_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleTiledShopNameComp")

		self:addChild(var_10_0)
	elseif arg_10_1.type == "TeamBattleMapKnightComp" then
		var_10_0 = fgui.UIPackage:createObject("teamBattle", "TeamBattleMapKnightComp")

		self:addChild(var_10_0)
	end

	return var_10_0
end

function TeamBattleMapFloorComp:_popFloatNode(arg_11_1)
	local var_11_0

	if arg_11_1.type == "TeamBattleTiledShopNameComp" then
		var_11_0 = table.remove(self._floatPool[arg_11_1.type], 1)
	elseif arg_11_1.type == "TeamBattleMapKnightComp" then
		local var_11_1 = self._floatPool[arg_11_1.type][arg_11_1.info.resId]

		if not self._floatPool[arg_11_1.type][arg_11_1.info.resId] then
			var_11_1 = {}
			self._floatPool[arg_11_1.type][arg_11_1.info.resId] = var_11_1
		end

		var_11_0 = table.remove(var_11_1, 1)
	end

	var_11_0 = var_11_0 or self:_createFloatNode(arg_11_1)

	var_11_0:setVisible(true)

	return var_11_0
end

function TeamBattleMapFloorComp:_pushFloatNode(arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:getName()

	arg_12_1:setVisible(false)

	if var_12_0 == "TeamBattleTiledShopNameComp" then
		self._floatPool[var_12_0][#self._floatPool[var_12_0] + 1] = arg_12_1
	elseif var_12_0 == "TeamBattleMapKnightComp" then
		self._floatPool[var_12_0][arg_12_2.info.resId][#self._floatPool[var_12_0][arg_12_2.info.resId] + 1] = arg_12_1
	end
end

function TeamBattleMapFloorComp:onUnload()
	self._effectMirrorSpine = nil
end

function TeamBattleMapFloorComp:updateCurPos(arg_14_1, arg_14_2)
	local var_14_0 = TeamBattleMapCommon.getMapTiledSize()
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in pairs((var_0_0:getMapData():getPlayerMap())) do
		self:getRoleComp(iter_14_0)

		local var_14_2 = self:getRoleCompCoordinate(iter_14_0)

		var_14_1[var_14_2.x .. "_" .. var_14_2.y] = var_14_1[var_14_2.x .. "_" .. var_14_2.y] or {}
		var_14_1[var_14_2.x .. "_" .. var_14_2.y][#var_14_1[var_14_2.x .. "_" .. var_14_2.y] + 1] = iter_14_0
	end

	local var_14_3, var_14_4 = TeamBattleMapCommon.getGlobalCoordinateByWorldPos({
		x = -arg_14_1,
		y = arg_14_2
	})
	local var_14_5 = math.ceil(display.width / (2 * var_14_0.width)) + 3 + 1
	local var_14_6 = math.ceil(display.height / (2 * var_14_0.height)) + 3 + 1
	local var_14_7 = var_14_4 + var_14_5 - var_14_6
	local var_14_8 = {}

	for iter_14_2 = 1, 2 * var_14_5 do
		for iter_14_3 = 1, 2 * var_14_6 do
			local var_14_9 = var_14_3 - var_14_5 - var_14_6 + iter_14_2 + iter_14_3

			if var_14_3 - var_14_5 - var_14_6 + iter_14_2 + iter_14_3 < self._checkRect.x then
				var_14_9 = self._checkRect.x
			elseif var_14_9 > self._checkRect.x + self._checkRect.width then
				var_14_9 = self._checkRect.x + self._checkRect.width
			end

			local var_14_10 = var_14_7 - iter_14_2 + iter_14_3

			if var_14_7 - iter_14_2 + iter_14_3 < self._checkRect.y then
				var_14_10 = self._checkRect.y
			elseif var_14_10 > self._checkRect.y + self._checkRect.height then
				var_14_10 = self._checkRect.y + self._checkRect.height
			end

			self:checkTempPos(var_14_9, var_14_10, var_14_8)

			local var_14_11 = table.concat({
				var_14_9,
				var_14_10
			}, "_")

			for iter_14_4, iter_14_5 in ipairs(var_14_1[var_14_11] or {}) do
				self:getRoleComp(iter_14_5):setVisible(true)
			end

			var_14_1[var_14_11] = nil

			local var_14_12 = var_14_10 - 1

			if var_14_10 - 1 < self._checkRect.y then
				var_14_12 = self._checkRect.y
			elseif var_14_12 > self._checkRect.y + self._checkRect.height then
				var_14_12 = self._checkRect.y + self._checkRect.height
			end

			self:checkTempPos(var_14_9, var_14_12, var_14_8)

			local var_14_13 = table.concat({
				var_14_9,
				var_14_12
			}, "_")

			for iter_14_6, iter_14_7 in ipairs(var_14_1[var_14_13] or {}) do
				self:getRoleComp(iter_14_7):setVisible(true)
			end

			var_14_1[var_14_13] = nil
		end
	end

	if math.abs(self._curPosX - arg_14_1) < 0.5 * var_14_0.width and math.abs(self._curPosY - arg_14_2) < 0.5 * var_14_0.height then
		return
	end

	local var_14_14 = cc.p(TeamBattleMapCommon.getWorldPosByGlobalCoordinate(cc.p(var_14_3, var_14_4)))

	self._curPosX = -var_14_14.x
	self._curPosY = var_14_14.y

	for iter_14_8, iter_14_9 in pairs(var_14_1) do
		for iter_14_10, iter_14_11 in ipairs(iter_14_9) do
			self:getRoleComp(iter_14_11):setVisible(false)
		end
	end

	local var_14_16 = {}
	local var_14_17 = {}

	for iter_14_12, iter_14_13 in pairs(var_14_8) do
		if not self._showPosDic[iter_14_12] then
			table.insert(var_14_16, iter_14_12)
		else
			self._showPosDic[iter_14_12] = nil
		end
	end

	for iter_14_14, iter_14_15 in pairs(self._showPosDic) do
		table.insert(var_14_17, iter_14_14)
	end

	for iter_14_16, iter_14_17 in ipairs(var_14_17) do
		local var_14_18 = iter_14_17:split("_")
		local var_14_19 = {
			x = tonumber(var_14_18[1]),
			y = tonumber(var_14_18[2])
		}

		if self._compDic[var_14_19.x .. "_" .. var_14_19.y] then
			self._compDic[var_14_19.x .. "_" .. var_14_19.y]:clearFloatInfo()
			self:_pushComp(self._compDic[var_14_19.x .. "_" .. var_14_19.y])

			self._compDic[var_14_19.x .. "_" .. var_14_19.y] = nil
		end

		if self._groundCompDic[var_14_19.x .. "_" .. var_14_19.y] then
			self:_pushComp(self._groundCompDic[var_14_19.x .. "_" .. var_14_19.y])

			self._groundCompDic[var_14_19.x .. "_" .. var_14_19.y] = nil
		end
	end

	for iter_14_18, iter_14_19 in ipairs(var_14_16) do
		local var_14_20 = iter_14_19:split("_")
		local var_14_21 = {
			x = tonumber(var_14_20[1]),
			y = tonumber(var_14_20[2])
		}
		local var_14_22 = var_0_0:getMapData():getTiledInfo(var_14_21)
		local var_14_23 = var_0_0:getMapData():getGroundInfo(var_14_21)

		if var_14_22 then
			local var_14_24 = self:_popComp(var_14_22.type)

			self:setCompPosition(var_14_24, var_14_21, nil, -math.floor(var_14_24:getIconTiledSize().width / 2))
			var_14_24:updateCompView(var_14_22)

			self._compDic[var_14_21.x .. "_" .. var_14_21.y] = var_14_24

			local var_14_25 = var_14_24:getFloatInfo()

			if var_14_25.isDirty then
				var_14_24:setAndUpdateFloatComp(self:_popFloatNode(var_14_25.param), var_14_25.param)
			end

			if var_14_22.ground then
				local var_14_26, var_14_27 = var_0_0:getMapData():getRoomStructAndLocalCoordinate(var_14_21)
				local var_14_28 = self:_popComp("ground")

				self:setCompPosition(var_14_28, var_14_21, nil, -9)
				var_14_28:updateGround(var_14_22, var_14_21)

				self._groundCompDic[var_14_21.x .. "_" .. var_14_21.y] = var_14_28

				var_14_26:removeTiledFormChangeDic(nil, var_14_27)
			end
		elseif var_14_23 then
			local var_14_29, var_14_30 = var_0_0:getMapData():getRoomStructAndLocalCoordinate(var_14_21)
			local var_14_31 = self:_popComp("ground")

			self:setCompPosition(var_14_31, var_14_21, nil, -9)
			var_14_31:updateGround(var_14_23, var_14_21)

			self._groundCompDic[var_14_21.x .. "_" .. var_14_21.y] = var_14_31

			var_14_29:removeTiledFormChangeDic(nil, var_14_30)
		end
	end

	self._showPosDic = var_14_8

	self:updateCurComp()
end

function TeamBattleMapFloorComp:checkTempPos(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 + arg_15_2 <= 0 then
		return
	end

	arg_15_3[arg_15_1 .. "_" .. arg_15_2] = true
end

function TeamBattleMapFloorComp:setCompPosition(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_3 = arg_16_3 or cc.p(TeamBattleMapCommon.coordToCompPos(arg_16_2))

	arg_16_1:setPosition(arg_16_3)

	local var_16_0 = arg_16_2.x + arg_16_2.y

	if arg_16_4 then
		var_16_0 = var_16_0 + arg_16_4
	end

	arg_16_1:displayObject():setLocalZOrder(var_16_0)
end

function TeamBattleMapFloorComp:updateCurComp()
	local var_17_0 = var_0_0:getMapData():getMineRoom()

	for iter_17_0, iter_17_1 in pairs(self._compDic) do
		local var_17_1 = iter_17_0:split("_")
		local var_17_2 = var_0_0:getMapData():getTiledInfo((cc.p(tonumber(var_17_1[1]), tonumber(var_17_1[2]))))

		if var_17_2 then
			iter_17_1:updateCompView(var_17_2)

			local var_17_3 = iter_17_1:getFloatInfo()

			if var_17_3.isDirty then
				iter_17_1:setAndUpdateFloatComp(self:_popFloatNode(var_17_3.param), var_17_3.param)
			end
		end
	end

	for iter_17_2, iter_17_3 in pairs(self._groundCompDic) do
		local var_17_4 = iter_17_2:split("_")
		local var_17_5 = cc.p(tonumber(var_17_4[1]), tonumber(var_17_4[2]))
		local var_17_6 = var_0_0:getMapData():getTiledInfo(var_17_5)
		local var_17_7 = var_0_0:getMapData():getGroundInfo(var_17_5)

		if var_17_6 then
			iter_17_3:updateGround(var_17_6, var_17_5)

			local var_17_8, var_17_9 = TeamBattleMapCommon.getRoomCoordinateAndCoordinateByGlobalCoordinate(var_17_5)

			var_17_0:removeTiledFormChangeDic(nil, var_17_9)
		elseif var_17_7 then
			local var_17_10, var_17_11 = var_0_0:getMapData():getRoomStructAndLocalCoordinate(var_17_5)

			iter_17_3:updateGround(var_17_7, var_17_5)
		end
	end
end

function TeamBattleMapFloorComp:onSingleClick(arg_18_1, arg_18_2, arg_18_3)
	if self._compDic[arg_18_1 .. "_" .. arg_18_2] then
		self._compDic[arg_18_1 .. "_" .. arg_18_2]:onSingleClick(arg_18_3)
	end
end

function TeamBattleMapFloorComp:receiveCompEvent(arg_19_1, arg_19_2)
	if arg_19_1 == "pushFloatComp" then
		self:_pushFloatNode(arg_19_2.node, arg_19_2.param)

		return true
	elseif arg_19_1 == "knightDiedPlayEnd" then
		self:updateCurComp()

		return true
	end

	return false
end

function TeamBattleMapFloorComp:playEventEffect(arg_20_1, arg_20_2, arg_20_3)
	self._effectComp:setPosition(self._compDic[arg_20_1 .. "_" .. arg_20_2]:getPosition())
	self._effectComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_explorationMap_cell",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._onPlayEventEffectHandler)
	})
	self._effectComp:setVisible(true)

	self._effectCallBack = arg_20_3
end

function TeamBattleMapFloorComp:_onPlayEventEffectHandler(arg_21_1, arg_21_2)
	if arg_21_1.type == "complete" then
		self._effectComp:setVisible(false)

		if self._effectCallBack then
			self._effectCallBack()
		end
	end
end

function TeamBattleMapFloorComp:updateRoleDir(arg_22_1, arg_22_2)
	self:getRoleComp(arg_22_2):setInnerDir(arg_22_1)
end

function TeamBattleMapFloorComp:updateRoleCoordinate(arg_23_1, arg_23_2)
	self:setCompPosition(self:getRoleComp(arg_23_2), arg_23_1, nil)

	self._roleCompPosMap[arg_23_2] = cc.p(arg_23_1.x, arg_23_1.y)
end

function TeamBattleMapFloorComp:updateRoleCompPos(arg_24_1, arg_24_2)
	self:setCompPosition(self:getRoleComp(arg_24_2), cc.p(TeamBattleMapCommon.compPosToCoord(arg_24_1)), arg_24_1)
end

function TeamBattleMapFloorComp:_initRole(arg_25_1)
	self:updateRoleCoordinate(var_0_0:getMapData():getRoleCoordinate(arg_25_1), arg_25_1)
end

function TeamBattleMapFloorComp:getRoleCompCoordinate(arg_26_1)
	return self._roleCompPosMap[arg_26_1]
end

function TeamBattleMapFloorComp:getRolePos(arg_27_1)
	return self:getRoleComp(arg_27_1):getPosition()
end

function TeamBattleMapFloorComp:onRoleStartRun(arg_28_1)
	self:getRoleComp(arg_28_1):playInnerAction("run")
end

function TeamBattleMapFloorComp:onRoleStopRun(arg_29_1)
	self:updateRoleCoordinate(var_0_0:getMapData():getRoleCoordinate(arg_29_1), arg_29_1)
	self:getRoleComp(arg_29_1):playInnerAction("idle")
end

function TeamBattleMapFloorComp:onRoleJumpToCoordinate(arg_30_1, arg_30_2)
	self:updateRoleCoordinate(arg_30_1, arg_30_2)
	self:getRoleComp(arg_30_2):playJumpEffect()
end

function TeamBattleMapFloorComp:getFloorChildComp(arg_31_1)
	return self._compDic[arg_31_1.x .. "_" .. arg_31_1.y]
end

function TeamBattleMapFloorComp:setCurCheckPos(arg_32_1, arg_32_2)
	local var_32_0 = TeamBattleMapCommon.getRoomSize()

	self._checkRect = {
		x = var_32_0.width * (arg_32_1 - 1),
		y = var_32_0.height * (arg_32_2 - 1),
		width = var_32_0.width - 1,
		height = var_32_0.height - 1
	}
end

function TeamBattleMapFloorComp:updateRole()
	for iter_33_0, iter_33_1 in pairs(self._roleCompPool) do
		iter_33_1:updateSelf()
	end
end

return TeamBattleMapFloorComp
