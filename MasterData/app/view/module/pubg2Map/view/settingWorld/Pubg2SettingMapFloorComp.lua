local MeshNode = require("app.view.module.debug.Navmesh2D_Delaunay.Navmesh2D.MeshNode")
local Vector2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Vector2")
local Delaunay = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Delaunay")
local Triangle2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Triangle2")
local var_0_4 = math.floor
local var_0_5 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityBuff = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBuff")
local Pubg2EntityMonster = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityMonster")
local Pubg2EntityUser = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityUser")
local Pubg2EntityObstacle = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityObstacle")
local Pubg2EntityObstaclePoint = require("app.view.module.pubg2Map.view.settingWorld.entity.Pubg2EntityObstaclePoint")
local Pubg2EntityObstacleTriangle = require("app.view.module.pubg2Map.view.settingWorld.entity.Pubg2EntityObstacleTriangle")
local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local QuadTree = require("app.view.module.pubg2Map.quadtree.QuadTree")
local Pubg2SettingMapFloorComp = class("Pubg2SettingMapFloorComp", require("app.fairyGUI.pubg.UI_Pubg2SettingMapFloorComp"))

function Pubg2SettingMapFloorComp:ctor()
	self._mapId = 0
	self._allShowEntity = {}
	self._allSettingEntity = {}
	self._applyEntityDict = {}
	self._myEntity = nil
	self._allShowUserComp = {}
	self._userEntityDict = {}
	self._mountainConfig = {}
	self._compPool = {
		[var_0_5.entity.obstacle] = {},
		[var_0_5.entity.user] = {},
		[var_0_5.entity.monster] = {},
		[var_0_5.entity.buff] = {},
		[var_0_5.entity.obstacle_point] = {}
	}
	self._averageDuration = 16
	self._tree = nil
	self._allObstaclePointList = {}
	self._allObstacleTriangleDict = {}
	self._pointTree = nil
	self._delaunay = Delaunay.new(false)
	self._allLine = {}
	self._triangleTree = nil
	self._allGraph = {}
	self._loaded = false

	local var_1_0 = math.min(display.cx, display.cy)

	self._checkUpdatePosLen2 = var_1_0 * var_1_0
	self._curPos = cc.p(0, 0)
	self._lastUpdatePos = cc.p(-100000, -100000)
end

function Pubg2SettingMapFloorComp:loadConfig(arg_2_1, arg_2_2, arg_2_3)
	self._mapId = arg_2_1
	self._tree = QuadTree.new(-arg_2_2 * 0.5, 0, arg_2_2, arg_2_3, 4, 4)
	self._mountainConfig = require((string.format("app.view.module.pubg2Map.view.mapWorld.mapConfig.Pubg2MountainConfig_%d", arg_2_1)))

	for iter_2_0, iter_2_1 in pairs(self._mountainConfig) do
		local var_2_0, var_2_1 = PubgMapHelp.getPos(iter_2_0)
		local var_2_2, var_2_3 = PubgMapHelp.coordToPixel2(var_2_0, var_2_1)
		local var_2_4 = Pubg2EntityObstacle.new(iter_2_0, iter_2_1)

		var_2_4.x = var_2_2
		var_2_4.y = var_2_3
		var_2_4.renderDependWidth = 280
		var_2_4.renderDependHeight = 280

		self._tree:insert(var_2_4)
		self._tree:addDirty(var_2_4)
	end

	self._tree:refreshRender()

	self._osTime = os.clock()
	var_0_5.fsm.Time.lowDuration = 0
	self._loaded = true

	self:addUser(g.core.model.User:getId(), 0, 0)

	self._pointTree = QuadTree.new(-arg_2_2 * 0.5, 0, arg_2_2, arg_2_3, 4, 4)
	self._triangleTree = QuadTree.new(-arg_2_2 * 0.5, 0, arg_2_2, arg_2_3, 4, 4)
end

function Pubg2SettingMapFloorComp:clearConfig(arg_3_1)
	self._mountainConfig = {}
	package.loaded[string.format("app.view.module.pubg.view.pubgMap.mapWorld.mapConfig.PubgMountainConfig_%d", arg_3_1)] = nil
	self._loaded = false

	self:displayObject():unscheduleUpdate()
end

function Pubg2SettingMapFloorComp:tickUpdate()
	if not self._loaded then
		return
	end

	if self._tree:refreshRender() then
		self:_updateCurPos(self._curPos.x, self._curPos.y)
	end

	local var_4_0 = var_0_5.fsm.Time.deltaT

	for iter_4_0, iter_4_1 in pairs(self._allShowUserComp) do
		iter_4_1:tickUpdate(var_4_0)
	end

	if var_4_0 > var_0_5.fsm.Time.averageDuration then
		-- block empty
	else
		local var_4_1 = 0

		for iter_4_2, iter_4_3 in pairs(self._applyEntityDict) do
			if self._allShowEntity[iter_4_2] then
				self:applyEntityComp(iter_4_3)

				self._applyEntityDict[iter_4_2] = nil
				var_4_1 = var_4_1 + 1
			end

			if var_4_1 > 1 then
				break
			end
		end
	end
end

function Pubg2SettingMapFloorComp:addUser(arg_5_1, arg_5_2, arg_5_3)
	if self._tree then
		local var_5_0 = Pubg2EntityUser.new(arg_5_1)

		var_5_0.x = arg_5_2
		var_5_0.y = arg_5_3
		var_5_0.renderDependWidth = 280
		var_5_0.renderDependHeight = 280

		self._tree:insert(var_5_0)

		if arg_5_1 == g.core.model.User:getId() then
			self._myEntity = var_5_0
		end

		self._userEntityDict[arg_5_1] = var_5_0
	end
end

function Pubg2SettingMapFloorComp:addMonster(arg_6_1, arg_6_2, arg_6_3)
	if self._tree then
		local var_6_0 = Pubg2EntityMonster.new(arg_6_1)

		var_6_0.x = arg_6_2
		var_6_0.y = arg_6_3

		self._tree:insert(var_6_0)
	end
end

function Pubg2SettingMapFloorComp:addBuff(arg_7_1, arg_7_2, arg_7_3)
	if self._tree then
		local var_7_0 = Pubg2EntityBuff.new(arg_7_1)

		var_7_0.x = arg_7_2
		var_7_0.y = arg_7_3

		self._tree:insert(var_7_0)
	end
end

function Pubg2SettingMapFloorComp:updateCurPos(arg_8_1, arg_8_2)
	self._curPos = cc.p(arg_8_1, arg_8_2)

	if cc.pDistanceSQ(self._curPos, self._lastUpdatePos) < self._checkUpdatePosLen2 then
		return
	else
		self._lastUpdatePos = cc.p(arg_8_1, arg_8_2)
	end

	self:_updateCurPos(arg_8_1, arg_8_2)
end

function Pubg2SettingMapFloorComp:_updateCurPos(arg_9_1, arg_9_2)
	local var_9_0, var_9_1 = self._tree:queryRenderList(arg_9_1 - display.cx * 1.5, arg_9_2 - display.cy * 1.5, display.width * 1.5, display.height * 1.5)

	for iter_9_0, iter_9_1 in pairs(self._allShowEntity) do
		if not var_9_1[iter_9_1.oid] then
			self._allShowEntity[iter_9_1.oid] = nil
			self._applyEntityDict[iter_9_1.oid] = nil

			self:recycleEntityComp(iter_9_1)
		end
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_0) do
		if not self._allShowEntity[iter_9_3.oid] then
			self:addEntityComp(iter_9_3, iter_9_2 - 1, self.m_renderHolder)

			if self._myEntity and self._myEntity:isInVisual(iter_9_3) then
				self:applyEntityComp(iter_9_3)
			else
				self._applyEntityDict[iter_9_3.oid] = iter_9_3
			end

			self._allShowEntity[iter_9_3.oid] = iter_9_3
		elseif iter_9_3.renderComp then
			self.m_renderHolder:setChildIndex(iter_9_3.renderComp, iter_9_2 - 1)
		end
	end

	local var_9_2 = os.clock() - os.clock()

	var_0_5.fsm.Time.updateCurPosConsume = var_9_2 .. "/" .. #var_9_0
	var_0_5.fsm.Time.updateCurPosConsumeMax = math.max(var_0_5.fsm.Time.updateCurPosConsumeMax, var_9_2)

	self:_updateObstaclePointCurPos(arg_9_1, arg_9_2)
	self:updateObstacleTriangle()
end

function Pubg2SettingMapFloorComp:_updateObstaclePointCurPos(arg_10_1, arg_10_2)
	local var_10_0, var_10_1 = self._pointTree:queryRect(arg_10_1 - display.cx * 1.5, arg_10_2 - display.cy * 1.5, display.width * 1.5, display.height * 1.5)

	for iter_10_0, iter_10_1 in pairs(self._allSettingEntity) do
		if not var_10_1[iter_10_1.oid] then
			self._allSettingEntity[iter_10_1.oid] = nil
			self._applyEntityDict[iter_10_1.oid] = nil

			self:recycleEntityComp(iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_0) do
		if not self._allSettingEntity[iter_10_3.oid] then
			self:addEntityComp(iter_10_3, iter_10_2 - 1, self.m_settingHolder)
			self:applyEntityComp(iter_10_3)

			self._allSettingEntity[iter_10_3.oid] = iter_10_3
		elseif iter_10_3.renderComp then
			self.m_settingHolder:setChildIndex(iter_10_3.renderComp, iter_10_2 - 1)
		end
	end
end

function Pubg2SettingMapFloorComp:addEntityComp(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = table.remove(self._compPool[arg_11_1:getType()] or {})

	if arg_11_1:isObstacle() then
		var_11_0 = var_11_0 or fgui.UIPackage:createObject("pubg", "Pubg2GridMountain")

		var_11_0:setPosition(arg_11_1.x, arg_11_1.y)
	elseif arg_11_1:isUser() then
		var_11_0 = var_11_0 or fgui.UIPackage:createObject("pubg", "Pubg2GridUser")

		var_11_0:setCompPos(cc.p(arg_11_1.x, arg_11_1.y))
		var_11_0:setServerPos(arg_11_1.x, arg_11_1.y)

		self._allShowUserComp[arg_11_1.oid] = var_11_0
	elseif arg_11_1:isMonster() and (var_11_0 or true) then
		var_11_0:setPosition(arg_11_1.x, arg_11_1.y)
	elseif arg_11_1:isBuff() and (var_11_0 or true) then
		var_11_0:setPosition(arg_11_1.x, arg_11_1.y)
	elseif arg_11_1:isObstaclePoint() then
		var_11_0 = var_11_0 or fgui.UIPackage:createObject("pubg", "Pubg2GridObstaclePoint")

		var_11_0:setPosition(arg_11_1.x, arg_11_1.y)
	end

	arg_11_1.renderComp = var_11_0

	arg_11_3:addChildAt(var_11_0, arg_11_2)
end

function Pubg2SettingMapFloorComp:applyEntityComp(arg_12_1)
	if not arg_12_1.renderComp then
		return
	end

	if arg_12_1:isObstacle() then
		arg_12_1.renderComp:setIcon("ui://pubg/" .. arg_12_1:getResId())
		arg_12_1.renderComp:setTitle(arg_12_1.oid)
	elseif arg_12_1:isUser() then
		arg_12_1.renderComp:setPosition(arg_12_1.x, arg_12_1.y)
		arg_12_1.renderComp:updateShowKnight()
		arg_12_1.renderComp:setOId(arg_12_1.oid)
	elseif arg_12_1:isMonster() then
		-- block empty
	elseif arg_12_1:isBuff() then
		-- block empty
	end

	arg_12_1.renderComp:setVisible(true)
end

function Pubg2SettingMapFloorComp:recycleEntityComp(arg_13_1)
	if arg_13_1.renderComp then
		arg_13_1.renderComp = nil

		arg_13_1.renderComp:setVisible(false)
		table.insert(self._compPool[arg_13_1:getType()], arg_13_1.renderComp)
	end
end

function Pubg2SettingMapFloorComp:getMyUser()
	return self._myEntity
end

function Pubg2SettingMapFloorComp:getMyCompPos()
	if self._myEntity and self._myEntity.renderComp then
		return (self._myEntity.renderComp:getPosition())
	else
		return cc.p(self._myEntity.x, -self._myEntity.y)
	end
end

function Pubg2SettingMapFloorComp:getMyPos()
	if self._myEntity then
		return cc.p(self._myEntity.x, self._myEntity.y)
	end
end

function Pubg2SettingMapFloorComp:setUserMovePosTo(arg_17_1)
	if not self._userEntityDict[arg_17_1.user_id] then
		return
	end

	self._tree:update(self._userEntityDict[arg_17_1.user_id], arg_17_1.x, arg_17_1.y)
	self._tree:addDirty(self._userEntityDict[arg_17_1.user_id])
	self._userEntityDict[arg_17_1.user_id]:setMovePosTo(arg_17_1)
end

function Pubg2SettingMapFloorComp:checkSettingPoint(arg_18_1)
	arg_18_1.x = var_0_4(arg_18_1.x)
	arg_18_1.y = var_0_4(arg_18_1.y)

	if arg_18_1.y <= 0 then
		return
	end

	local var_18_0 = false
	local var_18_1 = self._pointTree:queryRange(arg_18_1.x, arg_18_1.y, 10)

	if #var_18_1 > 0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_1) do
			self._pointTree:remove(iter_18_1)
			iter_18_1:setClear(true)

			for iter_18_2, iter_18_3 in ipairs(self._allObstaclePointList) do
				if iter_18_3:Equal(iter_18_1) then
					table.remove(self._allObstaclePointList, iter_18_2)

					break
				end
			end
		end
	else
		self:_addObstaclePoint(arg_18_1)

		var_18_0 = true
	end

	self:_updateObstaclePointCurPos(self._curPos.x, self._curPos.y)

	return var_18_0
end

function Pubg2SettingMapFloorComp:getPointCount()
	return #self._allObstaclePointList
end

function Pubg2SettingMapFloorComp:getTriangleCount()
	return #self._delaunay.triangulateList
end

function Pubg2SettingMapFloorComp:delaunayTriangle()
	self._delaunay:generalTriangulate(self._allObstaclePointList)

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self._allObstacleTriangleDict) do
		if iter_21_1:isObstacle() then
			table.insert(var_21_0, iter_21_1:getTriangle())
		end
	end

	self._allObstacleTriangleDict = {}

	self._triangleTree:clearTree()

	for iter_21_2, iter_21_3 in ipairs(self._delaunay.triangulateList) do
		local var_21_1 = Pubg2EntityObstacleTriangle.new(iter_21_2, iter_21_3)
		local var_21_2 = iter_21_3:getTrianglePoint()

		var_21_1.x = var_0_4(var_21_2.x)
		var_21_1.y = var_0_4(var_21_2.y)

		self._triangleTree:insert(var_21_1)

		self._allObstacleTriangleDict[var_21_1.oid] = var_21_1

		for iter_21_4, iter_21_5 in ipairs(var_21_0) do
			if iter_21_3:Equal(iter_21_5) then
				var_21_1:setObstacle(true)

				break
			end
		end
	end

	self:updateObstacleTriangle()
end

function Pubg2SettingMapFloorComp:setAllLineAlpha(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self._allLine) do
		if arg_22_1 then
			iter_22_1:setAlpha(arg_22_1)
		else
			iter_22_1:setVisible(false)
		end
	end
end

function Pubg2SettingMapFloorComp:showLines(arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		local var_23_0 = self._allLine[iter_23_0]

		if not self._allLine[iter_23_0] then
			var_23_0 = fgui.UIPackage:createObject("pubg", "Pubg2Line")

			self.m_lineRoot:addChild(var_23_0)

			self._allLine[iter_23_0] = var_23_0
		end

		var_23_0:setVisible(true)
		var_23_0:setPosition(iter_23_1.u.x, iter_23_1.u.y)

		local var_23_1 = cc.pSub(iter_23_1.w, iter_23_1.u)

		var_23_0:setWidth(cc.pGetLength(var_23_1))
		var_23_0:setRotation(math.radian2angle(cc.pToAngleSelf(var_23_1)))
		var_23_0:setAlpha(arg_23_2 or 0.7)
	end

	for iter_23_2 = #arg_23_1 + 1, #self._allLine do
		self._allLine[iter_23_2]:setVisible(false)
	end
end

function Pubg2SettingMapFloorComp:changeObstacleModel(arg_24_1)
	self.m_settingHolder:setVisible(arg_24_1)
	self.m_lineRoot:setVisible(arg_24_1)
	self.m_triangleMeshRoot:setVisible(arg_24_1)
end

function Pubg2SettingMapFloorComp:checkSettingObstacleTriangle(arg_25_1)
	if not self._triangleTree then
		return
	end

	local var_25_0 = self._triangleTree:queryRect(self._curPos.x - display.cx, self._curPos.y - display.cy, display.width, display.height)

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1:getTriangle():isIn(arg_25_1) then
			iter_25_1:setObstacle(not iter_25_1:isObstacle())

			break
		end
	end

	self:updateObstacleTriangle(var_25_0)
end

function Pubg2SettingMapFloorComp:updateObstacleTriangle(arg_26_1)
	arg_26_1 = arg_26_1 or self._triangleTree:queryRect(self._curPos.x - display.cx * 1.5, self._curPos.y - display.cy * 1.5, display.width * 1.5, display.height * 1.5)

	local var_26_0 = 0

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		local var_26_1 = MeshNode.new(iter_26_1:getTriangle())

		var_26_1:setObstacle(iter_26_1:isObstacle())

		local var_26_2 = self._allGraph[iter_26_0]

		if not self._allGraph[iter_26_0] then
			var_26_2 = fgui.GGraph:create()

			self.m_triangleMeshRoot:addChild(var_26_2)

			self._allGraph[iter_26_0] = var_26_2
		end

		var_26_2:setVisible(true)
		var_26_1:drawPolygonWithGraph(var_26_2)

		var_26_0 = var_26_0 + 1
	end

	for iter_26_2 = var_26_0 + 1, #self._allGraph do
		self._allGraph[iter_26_2]:setVisible(false)
	end
end

function Pubg2SettingMapFloorComp:reloadObstacleData()
	self._allObstaclePointList = {}
	self._allObstacleTriangleDict = {}

	self._pointTree:clearTree()
	self._triangleTree:clearTree()

	local var_27_0 = cc.FileUtils:getInstance():getStringFromFile((string.format("maps/pubg2/obstacle_%s.csv", self._mapId)))

	var_27_0 = var_27_0 or ""

	for iter_27_0, iter_27_1 in ipairs(string.split(var_27_0, "\n")) do
		if iter_27_1 ~= "" then
			local var_27_1 = string.split(iter_27_1, ",")
			local var_27_2 = Vector2.new(tonumber(var_27_1[1]), tonumber(var_27_1[2]))
			local var_27_3 = false

			for iter_27_2, iter_27_3 in ipairs(self._pointTree:queryRange(var_27_2.x, var_27_2.y, 10)) do
				for iter_27_4, iter_27_5 in ipairs(self._allObstaclePointList) do
					if iter_27_5:Equal(iter_27_3) then
						var_27_3 = true

						break
					end
				end
			end

			if not var_27_3 then
				self:_addObstaclePoint(var_27_2)
			end

			local var_27_4 = Vector2.new(tonumber(var_27_1[3]), tonumber(var_27_1[4]))
			local var_27_5 = false

			for iter_27_6, iter_27_7 in ipairs(self._pointTree:queryRange(var_27_4.x, var_27_4.y, 10)) do
				for iter_27_8, iter_27_9 in ipairs(self._allObstaclePointList) do
					if iter_27_9:Equal(iter_27_7) then
						var_27_5 = true

						break
					end
				end
			end

			if not var_27_5 then
				self:_addObstaclePoint(var_27_4)
			end

			local var_27_6 = Vector2.new(tonumber(var_27_1[5]), tonumber(var_27_1[6]))
			local var_27_7 = false

			for iter_27_10, iter_27_11 in ipairs(self._pointTree:queryRange(var_27_6.x, var_27_6.y, 10)) do
				for iter_27_12, iter_27_13 in ipairs(self._allObstaclePointList) do
					if iter_27_13:Equal(iter_27_11) then
						var_27_7 = true

						break
					end
				end
			end

			if not var_27_7 then
				self:_addObstaclePoint(var_27_6)
			end

			local var_27_8 = Triangle2.new(var_27_2, var_27_4, var_27_6)
			local var_27_9 = Pubg2EntityObstacleTriangle.new(iter_27_0, var_27_8)
			local var_27_10 = var_27_8:getTrianglePoint()

			var_27_9.x = var_0_4(var_27_10.x)
			var_27_9.y = var_0_4(var_27_10.y)

			var_27_9:setObstacle(true)
			self._triangleTree:insert(var_27_9)

			self._allObstacleTriangleDict[var_27_9.oid] = var_27_9
		end
	end

	self:showLines({})
	self:_updateCurPos(self._curPos.x, self._curPos.y)
end

function Pubg2SettingMapFloorComp:_addObstaclePoint(arg_28_1)
	local var_28_0 = Pubg2EntityObstaclePoint.new(#self._allObstaclePointList, arg_28_1)

	var_28_0.x = arg_28_1.x
	var_28_0.y = arg_28_1.y

	if self._pointTree:insert(var_28_0) then
		table.insert(self._allObstaclePointList, arg_28_1)
	end
end

function Pubg2SettingMapFloorComp:saveObstacleData()
	local var_29_0 = io.open(string.format("res/common/maps/pubg2/obstacle_%s.csv", self._mapId), "w")

	for iter_29_0, iter_29_1 in pairs(self._allObstacleTriangleDict) do
		if iter_29_1:isObstacle() then
			local var_29_1 = iter_29_1:getTriangle()

			var_29_0:write(table.concat({
				var_29_1.a.x,
				var_29_1.a.y,
				var_29_1.b.x,
				var_29_1.b.y,
				var_29_1.c.x,
				var_29_1.c.y
			}, ",") .. "\n")
		end
	end

	var_29_0:close()
	self:_updateCurPos(self._curPos.x, self._curPos.y)
end

return Pubg2SettingMapFloorComp
