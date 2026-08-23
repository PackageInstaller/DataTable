local MeshNode = require("app.view.module.debug.Navmesh2D_Delaunay.Navmesh2D.MeshNode")
local Vector2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Vector2")
local Triangle2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Triangle2")
local Pubg2EntityObstacleTriangle = require("app.view.module.pubg2Map.view.settingWorld.entity.Pubg2EntityObstacleTriangle")
local var_0_4 = math.floor
local var_0_5 = g.core.const.ConstMgr.PubgConst
local Pubg2EntityBuff = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityBuff")
local Pubg2EntityMonster = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityMonster")
local Pubg2EntityUser = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityUser")
local Pubg2EntityObstacle = require("app.view.module.pubg2Map.view.mapWorld.entity.Pubg2EntityObstacle")
local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local QuadTree = require("app.view.module.pubg2Map.quadtree.QuadTree")
local Pubg2MapFloorComp = class("Pubg2MapFloorComp", require("app.fairyGUI.pubg.UI_Pubg2MapFloorComp"))

function Pubg2MapFloorComp:ctor()
	self._allShowEntity = {}
	self._isAsyncLoad = false
	self._applyEntityDict = {}
	self._myEntity = nil
	self._allShowUserComp = {}
	self._userEntityDict = {}
	self._mountainConfig = {}
	self._compPool = {
		[var_0_5.entity.obstacle] = {},
		[var_0_5.entity.user] = {},
		[var_0_5.entity.monster] = {},
		[var_0_5.entity.buff] = {}
	}
	self._averageDuration = 16
	self._tree = nil
	self._loaded = false

	local var_1_0 = math.min(display.cx, display.cy)

	self._checkUpdatePosLen2 = var_1_0 * var_1_0
	self._curPos = cc.p(0, 0)
	self._lastUpdatePos = cc.p(-100000, -100000)
	self._isShowObstacle = false
	self._obstacleTree = nil
	self._allGraph = {}
end

function Pubg2MapFloorComp:loadConfig(arg_2_1, arg_2_2, arg_2_3)
	self._tree = QuadTree.new(-arg_2_2 * 0.5, 0, arg_2_2, arg_2_3, 5, 5)
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

	self._obstacleTree = QuadTree.new(-arg_2_2 * 0.5, 0, arg_2_2, arg_2_3, 5, 5)

	local var_2_5 = cc.FileUtils:getInstance():getStringFromFile((string.format("maps/pubg2/obstacle_%s.csv", arg_2_1)))

	var_2_5 = var_2_5 or ""

	for iter_2_2, iter_2_3 in ipairs(string.split(var_2_5, "\n")) do
		if iter_2_3 ~= "" then
			local var_2_6 = string.split(iter_2_3, ",")
			local var_2_7 = Triangle2.new(Vector2.new(tonumber(var_2_6[1]), tonumber(var_2_6[2])), Vector2.new(tonumber(var_2_6[3]), tonumber(var_2_6[4])), (Vector2.new(tonumber(var_2_6[5]), tonumber(var_2_6[6]))))
			local var_2_8 = Pubg2EntityObstacleTriangle.new(iter_2_2, var_2_7)
			local var_2_9 = var_2_7:getTrianglePoint()

			var_2_8.x = var_0_4(var_2_9.x)
			var_2_8.y = var_0_4(var_2_9.y)

			var_2_8:setObstacle(true)
			self._obstacleTree:insert(var_2_8)
		end
	end

	self._osTime = os.clock()
	var_0_5.fsm.Time.lowDuration = 0

	dump(string.format("Pubg2MapFloorComp:loadConfig耗时: %f秒", self._osTime - os.clock()), "debug")

	self._loaded = true

	self:addUser(g.core.model.User:getId(), 1000, 1000)
end

function Pubg2MapFloorComp:clearConfig(arg_3_1)
	self._mountainConfig = {}
	package.loaded[string.format("app.view.module.pubg.view.pubgMap.mapWorld.mapConfig.PubgMountainConfig_%d", arg_3_1)] = nil
	self._loaded = false

	self:displayObject():unscheduleUpdate()
end

function Pubg2MapFloorComp:tickUpdate()
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
	elseif self._isAsyncLoad then
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

function Pubg2MapFloorComp:addUser(arg_5_1, arg_5_2, arg_5_3)
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

function Pubg2MapFloorComp:addMonster(arg_6_1, arg_6_2, arg_6_3)
	if self._tree then
		local var_6_0 = Pubg2EntityMonster.new(arg_6_1)

		var_6_0.x = arg_6_2
		var_6_0.y = arg_6_3

		self._tree:insert(var_6_0)
	end
end

function Pubg2MapFloorComp:addBuff(arg_7_1, arg_7_2, arg_7_3)
	if self._tree then
		local var_7_0 = Pubg2EntityBuff.new(arg_7_1)

		var_7_0.x = arg_7_2
		var_7_0.y = arg_7_3

		self._tree:insert(var_7_0)
	end
end

function Pubg2MapFloorComp:updateCurPos(arg_8_1, arg_8_2)
	self._curPos = cc.p(arg_8_1, arg_8_2)

	if cc.pDistanceSQ(self._curPos, self._lastUpdatePos) < self._checkUpdatePosLen2 then
		return
	else
		self._lastUpdatePos = cc.p(arg_8_1, arg_8_2)
	end

	self:_updateCurPos(arg_8_1, arg_8_2)

	if self._isShowObstacle then
		self:updateObstacleTriangle()
	end
end

function Pubg2MapFloorComp:_updateCurPos(arg_9_1, arg_9_2)
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
			self:addEntityComp(iter_9_3, iter_9_2 - 1)

			if not self._isAsyncLoad then
				self:applyEntityComp(iter_9_3)
			elseif self._myEntity and self._myEntity:isInVisual(iter_9_3) then
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
end

function Pubg2MapFloorComp:addEntityComp(arg_10_1, arg_10_2)
	local var_10_0

	if arg_10_1:isObstacle() then
		var_10_0 = table.remove(self._compPool[var_0_5.entity.obstacle]) or fgui.UIPackage:createObject("pubg", "Pubg2GridMountain")

		var_10_0:setPosition(arg_10_1.x, arg_10_1.y)
	elseif arg_10_1:isUser() then
		var_10_0 = table.remove(self._compPool[var_0_5.entity.user]) or fgui.UIPackage:createObject("pubg", "Pubg2GridUser")

		var_10_0:setCompPos(cc.p(arg_10_1.x, arg_10_1.y))
		var_10_0:setServerPos(arg_10_1.x, arg_10_1.y)

		self._allShowUserComp[arg_10_1.oid] = var_10_0
	elseif arg_10_1:isMonster() then
		var_10_0 = table.remove(self._compPool[var_0_5.entity.monster])

		if not var_10_0 then
			-- block empty
		end

		var_10_0:setPosition(arg_10_1.x, arg_10_1.y)
	elseif arg_10_1:isBuff() then
		var_10_0 = table.remove(self._compPool[var_0_5.entity.buff])

		if not var_10_0 then
			-- block empty
		end

		var_10_0:setPosition(arg_10_1.x, arg_10_1.y)
	end

	arg_10_1.renderComp = var_10_0

	self.m_renderHolder:addChildAt(var_10_0, arg_10_2)
end

function Pubg2MapFloorComp:applyEntityComp(arg_11_1)
	if not arg_11_1.renderComp then
		return
	end

	if arg_11_1:isObstacle() then
		arg_11_1.renderComp:getChild("icon"):setURL("ui://pubg/" .. arg_11_1:getResId(), true)
		arg_11_1.renderComp:setTitle(arg_11_1.oid)
	elseif arg_11_1:isUser() then
		arg_11_1.renderComp:setPosition(arg_11_1.x, arg_11_1.y)
		arg_11_1.renderComp:updateShowKnight()
		arg_11_1.renderComp:setOId(arg_11_1.oid)
		arg_11_1.renderComp:setUId(arg_11_1:getId())
	elseif arg_11_1:isMonster() then
		-- block empty
	elseif arg_11_1:isBuff() then
		-- block empty
	end

	arg_11_1.renderComp:setVisible(true)
end

function Pubg2MapFloorComp:recycleEntityComp(arg_12_1)
	if arg_12_1.renderComp then
		arg_12_1.renderComp = nil

		arg_12_1.renderComp:setVisible(false)

		if arg_12_1:isObstacle() then
			table.insert(self._compPool[var_0_5.entity.obstacle], arg_12_1.renderComp)
		elseif arg_12_1:isUser() then
			table.insert(self._compPool[var_0_5.entity.user], arg_12_1.renderComp)

			self._allShowUserComp[arg_12_1.oid] = nil
		elseif arg_12_1:isMonster() then
			table.insert(self._compPool[var_0_5.entity.monster], arg_12_1.renderComp)
		elseif arg_12_1:isBuff() then
			table.insert(self._compPool[var_0_5.entity.buff], arg_12_1.renderComp)
		end
	end
end

function Pubg2MapFloorComp:getMyUser()
	return self._myEntity
end

function Pubg2MapFloorComp:getMyCompPos()
	if self._myEntity and self._myEntity.renderComp then
		return (self._myEntity.renderComp:getPosition())
	else
		return cc.p(self._myEntity.x, -self._myEntity.y)
	end
end

function Pubg2MapFloorComp:getMyPos()
	if self._myEntity then
		return cc.p(self._myEntity.x, self._myEntity.y)
	end
end

function Pubg2MapFloorComp:setMoving(arg_16_1)
	if self._myEntity and self._myEntity.renderComp then
		self._myEntity.renderComp:setMoving(arg_16_1)
	end
end

function Pubg2MapFloorComp:setUserMovePosTo(arg_17_1)
	if not self._userEntityDict[arg_17_1.user_id] then
		return
	end

	self._tree:update(self._userEntityDict[arg_17_1.user_id], arg_17_1.x, arg_17_1.y)
	self._tree:addDirty(self._userEntityDict[arg_17_1.user_id])
	self._userEntityDict[arg_17_1.user_id]:setMovePosTo(arg_17_1)
end

function Pubg2MapFloorComp:getFinalPos(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = cc.p(arg_18_1, arg_18_2)
	local var_18_1 = cc.p(arg_18_3, arg_18_4)
	local var_18_2 = cc.pSub(var_18_1, var_18_0)
	local var_18_3
	local var_18_4 = display.width
	local var_18_5 = false
	local var_18_6 = self._obstacleTree:queryRect(arg_18_3 - display.cx, arg_18_4 - display.cy, display.width, display.height)

	for iter_18_0, iter_18_1 in ipairs(var_18_6) do
		local var_18_7 = iter_18_1:getTriangle()
		local var_18_8 = var_18_7.e1:pointDistance2(var_18_0)

		if var_18_8 < var_18_4 then
			var_18_3 = var_18_7.e1
			var_18_4 = var_18_8
		end

		local var_18_9 = var_18_7.e2:pointDistance2(var_18_0)

		if var_18_9 < var_18_4 then
			var_18_3 = var_18_7.e2
			var_18_4 = var_18_9
		end

		local var_18_10 = var_18_7.e3:pointDistance2(var_18_0)

		if var_18_10 < var_18_4 then
			var_18_3 = var_18_7.e3
			var_18_4 = var_18_10
		end

		if var_18_7:isIn(var_18_1) then
			var_18_5 = true
		end
	end

	if var_18_5 and var_18_3 then
		if math.abs(((var_18_3.u.x - var_18_3.w.x) * var_18_2.x + (var_18_3.u.y - var_18_3.w.y) * var_18_2.y) / (arg_18_5 * var_18_3.len) * arg_18_5) > 0 then
			arg_18_3 = arg_18_1 + ((var_18_3.u.x - var_18_3.w.x) * var_18_2.x + (var_18_3.u.y - var_18_3.w.y) * var_18_2.y) / (arg_18_5 * var_18_3.len) * arg_18_5 * (var_18_3.u.x - var_18_3.w.x) / var_18_3.len
			arg_18_4 = arg_18_2 + ((var_18_3.u.x - var_18_3.w.x) * var_18_2.x + (var_18_3.u.y - var_18_3.w.y) * var_18_2.y) / (arg_18_5 * var_18_3.len) * arg_18_5 * (var_18_3.u.y - var_18_3.w.y) / var_18_3.len
		end

		local var_18_11 = cc.p(arg_18_3, arg_18_4)

		for iter_18_2, iter_18_3 in ipairs(var_18_6) do
			if iter_18_3:getTriangle():isIn(var_18_11) then
				return arg_18_1, arg_18_2
			end
		end
	end

	return arg_18_3, arg_18_4
end

function Pubg2MapFloorComp:updateObstacleTriangle()
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs((self._obstacleTree:queryRect(self._curPos.x - display.cx * 1.5, self._curPos.y - display.cy * 1.5, display.width * 1.5, display.height * 1.5))) do
		local var_19_1 = MeshNode.new(iter_19_1:getTriangle())

		var_19_1:setObstacle(true)

		local var_19_2 = self._allGraph[iter_19_0]

		if not self._allGraph[iter_19_0] then
			var_19_2 = fgui.GGraph:create()

			self.m_triangleMeshRoot:addChild(var_19_2)

			self._allGraph[iter_19_0] = var_19_2
		end

		var_19_2:setVisible(true)
		var_19_1:drawPolygonWithGraph(var_19_2)

		var_19_0 = var_19_0 + 1
	end

	for iter_19_2 = var_19_0 + 1, #self._allGraph do
		self._allGraph[iter_19_2]:setVisible(false)
	end
end

function Pubg2MapFloorComp:setAsyncLoad(arg_20_1)
	self._isAsyncLoad = arg_20_1
end

function Pubg2MapFloorComp:setShowObstacle(arg_21_1)
	self._isShowObstacle = arg_21_1

	if arg_21_1 then
		self:updateObstacleTriangle()
	end

	self.m_triangleMeshRoot:setVisible(arg_21_1)
end

return Pubg2MapFloorComp
