local Edge2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Edge2")
local MeshNode = require("app.view.module.debug.Navmesh2D_Delaunay.Navmesh2D.MeshNode")
local Delaunay = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Delaunay")
local Vector2 = require("app.view.module.debug.Navmesh2D_Delaunay.DelaunayTriangle.Vector2")
local DebugNavmesh2DComp = class("DebugNavmesh2DComp", require("app.fairyGUI.debug.UI_DebugNavmesh2DComp"))

function DebugNavmesh2DComp:ctor()
	self._allLine = {}
	self._allPointList = {}
	self._debugLineList = {}
	self._showIndex = 1
	self._centerPos = {}
	self._delaunay = Delaunay.new()
	self._originPos = self.m_origin:getPosition()
	self._allMesh = {}
	self._allGraph = {}

	self.m_startBtn:addClickListener(handler(self, self.onClickStart))
	self.m_showLinesBtn:addClickListener(handler(self, self.onClickShowLinesDebug))
	self.m_randomPosBtn:addClickListener(handler(self, self._randomPosList))
	self.m_randomObstacleBtn:addClickListener(handler(self, self.onClickRandomObstacle))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_isDebugShowCheck:addClickListener(handler(self, self._onDebugShowCheckClick))

	self._startPoint = nil
	self._endPoint = nil
	self._startNode = nil
	self._endNode = nil
end

function DebugNavmesh2DComp:onClickRandomObstacle()
	local var_2_0 = math.floor((tonumber((self.m_obstacleInput:getText())) or 10) * 0.01 * #self._allMesh + 0.5)
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(self._allMesh) do
		iter_2_1:setObstacle(false)
		table.insert(var_2_1, iter_2_0)
	end

	for iter_2_2 = 1, var_2_0 do
		local var_2_2 = math.random(1, #var_2_1)

		self._allMesh[var_2_1[var_2_2]]:setObstacle(true)
		table.remove(var_2_1, var_2_2)
	end

	self:log("随机障碍物数量：" .. var_2_0)
	self:updateMeshNode()
end

function DebugNavmesh2DComp:updateMeshNode()
	for iter_3_0, iter_3_1 in ipairs(self._allMesh) do
		local var_3_0 = self._allGraph[iter_3_0]

		if not self._allGraph[iter_3_0] then
			var_3_0 = fgui.GGraph:create()

			self.m_meshRoot:addChild(var_3_0)

			self._allGraph[iter_3_0] = var_3_0
		end

		var_3_0:setVisible(true)
		iter_3_1:drawPolygonWithGraph(var_3_0)
	end

	for iter_3_2 = #self._allMesh + 1, #self._allGraph do
		self._allGraph[iter_3_2]:setVisible(false)
	end
end

function DebugNavmesh2DComp:_onDebugShowCheckClick()
	self._delaunay:setDebug(self.m_isDebugShowCheck:isSelected())
end

function DebugNavmesh2DComp:_onTouchBegin(arg_5_1)
	self._beginPos = arg_5_1:getInput():getPosition()

	arg_5_1:captureTouch()

	self._isTouch = false
end

function DebugNavmesh2DComp:_onTouchMove(arg_6_1)
	if arg_6_1:getInput():getButton() == 1 then
		return
	end
end

function DebugNavmesh2DComp:getInTriangles(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._allMesh) do
		if iter_7_1:isInNode(arg_7_1) then
			return iter_7_1
		end
	end

	return nil
end

function DebugNavmesh2DComp:_onTouchEnd(arg_8_1)
	if self._isTouch then
		-- block empty
	else
		local var_8_0 = arg_8_1:getInput()
		local var_8_1 = self.m_meshRoot:globalToLocal((var_8_0:getPosition()))

		var_8_1.y = -var_8_0.y

		if arg_8_1:getInput():getButton() == 0 then
			self._startPoint = Vector2.new(var_8_1.x, var_8_1.y)

			local var_8_2 = self:getInTriangles(self._startPoint)

			self._startNode = var_8_2

			if var_8_2 then
				self:log("起点：" .. self._startPoint.x .. "," .. self._startPoint.y)

				for iter_8_0, iter_8_1 in ipairs(self._allMesh) do
					iter_8_1:setStart(false)
					iter_8_1:setPath(false)
				end

				var_8_2:setStart(true)

				if self._endNode then
					self._endNode:setEnd(true)
				end
			else
				self:log("未找到起点所在三角形")
			end
		elseif arg_8_1:getInput():getButton() == 1 then
			self._endPoint = Vector2.new(var_8_1.x, var_8_1.y)

			local var_8_3 = self:getInTriangles(self._endPoint)

			self._endNode = var_8_3

			if var_8_3 then
				self:log("终点：" .. self._endPoint.x .. "," .. self._endPoint.y)

				for iter_8_2, iter_8_3 in ipairs(self._allMesh) do
					iter_8_3:setEnd(false)
					iter_8_3:setPath(false)
				end

				var_8_3:setEnd(true)

				if self._startNode then
					self._startNode:setStart(true)
				end
			else
				self:log("未找到终点所在三角形")
			end
		end

		if self._startNode and self._endNode then
			local var_8_4 = os.clock()
			local var_8_5, var_8_6 = self:aStart(self._startNode, self._endNode, self._startPoint, self._endPoint)

			if var_8_5 then
				self:funnelSearch2(var_8_5, var_8_6, self._startPoint, self._endPoint)

				for iter_8_4 = 2, #var_8_5 - 1 do
					var_8_5[iter_8_4]:setPath(true)
				end

				self:log("寻路耗时：" .. os.clock() - var_8_4)
			else
				self:showLines({})
				self:log("未找到路径,寻路耗时：" .. os.clock() - var_8_4)
			end
		end

		self:updateMeshNode()
	end
end

function DebugNavmesh2DComp:setAllLine(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self._allLine) do
		if arg_9_1 then
			iter_9_1:setAlpha(arg_9_1)
		else
			iter_9_1:setVisible(false)
		end
	end
end

function DebugNavmesh2DComp:_randomPosList()
	self:setAllLine()

	local var_10_0 = tonumber((self.m_posInput:getText())) or 100
	local var_10_1 = display.width - self._originPos.x
	local var_10_2 = self._originPos.y - self.m_bg:getPosition().y

	for iter_10_0 = math.max(var_10_0, #self._allPointList), 1, -1 do
		if not self._allPointList[iter_10_0] then
			local var_10_3 = fgui.UIPackage:createObject("debug", "DebugNavmesh2DPos")

			self.m_origin:addChild(var_10_3)

			local var_10_4 = math.random(var_10_1)
			local var_10_5 = math.random(var_10_2)

			var_10_3:setPosition(var_10_4, -var_10_5)
			var_10_3:setTitle(string.format("(%d,%d)", var_10_4, var_10_5))

			self._allPointList[iter_10_0] = {
				comp = var_10_3,
				pos = var_10_3:getPosition()
			}
		elseif var_10_0 < iter_10_0 then
			self._allPointList[iter_10_0].comp:removeFromParent()
			table.remove(self._allPointList, iter_10_0)
		else
			self._allPointList[iter_10_0].comp:setPosition(math.random(var_10_1), -math.random(var_10_2))

			self._allPointList[iter_10_0].pos = self._allPointList[iter_10_0].comp:getPosition()
		end
	end
end

function DebugNavmesh2DComp:onClickStart()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._allPointList) do
		table.insert(var_11_0, Vector2.new(iter_11_1.pos.x, -iter_11_1.pos.y))
	end

	self._delaunay:generalTriangulate(var_11_0)

	self._startPoint = nil
	self._endPoint = nil
	self._startNode = nil
	self._endNode = nil
	self._allMesh = {}

	local var_11_1 = {}

	for iter_11_2, iter_11_3 in ipairs(self._delaunay.triangulateList) do
		local var_11_2 = MeshNode.new(iter_11_3)

		table.insert(self._allMesh, var_11_2)

		local var_11_3 = iter_11_3.e1:getKey()

		if not var_11_1[var_11_3] then
			var_11_1[var_11_3] = var_11_2
		else
			var_11_2:setNeighbor(iter_11_3.e1, var_11_1[var_11_3])
			var_11_1[var_11_3]:setNeighbor(iter_11_3.e1, var_11_2)
		end

		local var_11_4 = iter_11_3.e2:getKey()

		if not var_11_1[var_11_4] then
			var_11_1[var_11_4] = var_11_2
		else
			var_11_2:setNeighbor(iter_11_3.e2, var_11_1[var_11_4])
			var_11_1[var_11_4]:setNeighbor(iter_11_3.e2, var_11_2)
		end

		local var_11_5 = iter_11_3.e3:getKey()

		if not var_11_1[var_11_5] then
			var_11_1[var_11_5] = var_11_2
		else
			var_11_2:setNeighbor(iter_11_3.e3, var_11_1[var_11_5])
			var_11_1[var_11_5]:setNeighbor(iter_11_3.e3, var_11_2)
		end
	end

	self:updateMeshNode()
end

function DebugNavmesh2DComp:onClickShowLinesDebug()
	if not self.m_isDebugShowCheck:isSelected() then
		self:log("请先开启debug然后重新生成")

		return
	end

	self._debugLineList = self._delaunay:getDebugAllLines()
	self._showIndex = 1
	self._showLineSchedule = self._showLineSchedule or self:newSchedule(handler(self, self.scheduleShowLines), 0.1)
end

function DebugNavmesh2DComp:scheduleShowLines()
	self:log("当前剩余线段数量：" .. #self._debugLineList - self._showIndex + 1)

	if self._showIndex > #self._debugLineList then
		self:log("所有线段已显示完毕")
		self:cancelSchedule(self._showLineSchedule)

		self._showLineSchedule = nil

		self:newScheduleOnce(handler(self, self.hideLine), 1)

		return
	end

	self:showLines(self._debugLineList[self._showIndex] or {})

	self._showIndex = self._showIndex + 1
end

function DebugNavmesh2DComp:hideLine()
	self:showLines({})
end

function DebugNavmesh2DComp:showLines(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		local var_15_0 = self._allLine[iter_15_0]

		if not self._allLine[iter_15_0] then
			var_15_0 = fgui.UIPackage:createObject("debug", "DebugNavmesh2DLine")

			self.m_lineRoot:addChild(var_15_0)

			self._allLine[iter_15_0] = var_15_0
		end

		var_15_0:setVisible(true)
		var_15_0:setPosition(iter_15_1.u.x, -iter_15_1.u.y)

		local var_15_1 = cc.pSub(iter_15_1.w, iter_15_1.u)

		var_15_0:setWidth(cc.pGetLength(var_15_1))
		var_15_0:setRotation(-math.radian2angle(cc.pToAngleSelf(var_15_1)))
	end

	for iter_15_2 = #arg_15_1 + 1, #self._allLine do
		self._allLine[iter_15_2]:setVisible(false)
	end
end

function DebugNavmesh2DComp:log(arg_16_1)
	self.m_logText:setText(arg_16_1)
end

function DebugNavmesh2DComp:aStart(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	if not arg_17_1 or not arg_17_2 or not arg_17_3 or not arg_17_4 then
		return nil
	end

	arg_17_1.g = 0
	arg_17_1.h = 0
	arg_17_1.f = arg_17_1.g + arg_17_1.h
	arg_17_1.parent = nil
	arg_17_1.parentEdge = nil

	local var_17_0 = Edge2.new(arg_17_4, arg_17_4)
	local var_17_1 = {
		arg_17_1
	}
	local var_17_2 = {}

	while #var_17_1 > 0 do
		table.sort(var_17_1, function(arg_18_0, arg_18_1)
			return arg_18_0.f < arg_18_1.f
		end)

		local var_17_3 = table.remove(var_17_1, 1)

		if var_17_3 == arg_17_2 then
			return self:reconstructPath(var_17_3)
		end

		var_17_2[var_17_3.oid] = true

		for iter_17_0, iter_17_1 in pairs(var_17_3:getNeighbor()) do
			if not iter_17_1:isObstacle() and not var_17_2[iter_17_1.oid] then
				local var_17_5 = var_17_3.g + self:getEdgeDistance(iter_17_0, var_17_3.parentEdge or Edge2.new(arg_17_3, arg_17_3))

				if var_17_5 < iter_17_1.g or not self:contains(var_17_1, iter_17_1) then
					iter_17_1.g = var_17_5
					iter_17_1.h = self:getEdgeDistance(iter_17_0, var_17_0)
					iter_17_1.f = iter_17_1.g + iter_17_1.h
					iter_17_1.parent = var_17_3
					iter_17_1.parentEdge = iter_17_0

					table.insert(var_17_1, iter_17_1)
				end
			end
		end
	end
end

function DebugNavmesh2DComp:reconstructPath(arg_19_1)
	local var_19_0 = {}
	local var_19_1 = {}
	local var_19_2 = arg_19_1

	while arg_19_1 do
		table.insert(var_19_0, 1, arg_19_1)

		if arg_19_1.parentEdge then
			table.insert(var_19_1, 1, arg_19_1.parentEdge)
		end

		var_19_2 = arg_19_1.parent
	end

	return var_19_0, var_19_1
end

function DebugNavmesh2DComp:contains(arg_20_1, arg_20_2)
	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if iter_20_1.oid == arg_20_2.oid then
			return true
		end
	end

	return false
end

function DebugNavmesh2DComp:getEdgeDistance(arg_21_1, arg_21_2)
	return cc.pDistanceSQ(arg_21_1.centerPos, arg_21_2.centerPos)
end

function DebugNavmesh2DComp:funnelSearch(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_2 == nil or #arg_22_2 < 2 then
		self:log("漏斗优化失败，公共边数量不足")

		return
	end

	local var_22_0 = {
		arg_22_2[1].u
	}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_2) do
		local var_22_2 = false

		for iter_22_2, iter_22_3 in ipairs(var_22_0) do
			if iter_22_1.u:Equal(iter_22_3) then
				table.insert(var_22_1, iter_22_1.w)

				var_22_2 = true

				break
			end

			if iter_22_1.w:Equal(iter_22_3) then
				table.insert(var_22_1, iter_22_1.u)

				var_22_2 = true

				break
			end
		end

		if not var_22_2 then
			for iter_22_4, iter_22_5 in ipairs(var_22_1) do
				if iter_22_1.u:Equal(iter_22_5) then
					table.insert(var_22_0, iter_22_1.w)

					break
				end

				if iter_22_1.w:Equal(iter_22_5) then
					table.insert(var_22_0, iter_22_1.u)

					break
				end
			end
		end
	end

	table.insert(var_22_0, arg_22_4)
	table.insert(var_22_1, arg_22_4)

	local var_22_3 = {
		arg_22_3
	}

	while not var_22_3[#var_22_3]:Equal(arg_22_4) do
		local var_22_4 = 360
		local var_22_5 = 0
		local var_22_6 = 1
		local var_22_7 = 1
		local var_22_8 = #var_22_0
		local var_22_9 = #var_22_1
		local var_22_10 = false
		local var_22_11 = {}

		for iter_22_6, iter_22_7 in ipairs(var_22_0) do
			table.insert(var_22_11, {
				disable = false,
				point = iter_22_7
			})
		end

		local var_22_12 = {}

		for iter_22_8, iter_22_9 in ipairs(var_22_1) do
			table.insert(var_22_12, {
				disable = false,
				point = iter_22_9
			})
		end

		while true do
			local var_22_13 = var_22_0[var_22_6]
			local var_22_14 = var_22_1[var_22_7]
			local var_22_15 = cc.p(var_22_0[var_22_6].x - var_22_3[#var_22_3].x, var_22_0[var_22_6].y - var_22_3[#var_22_3].y)
			local var_22_16 = cc.p(var_22_1[var_22_7].x - var_22_3[#var_22_3].x, var_22_1[var_22_7].y - var_22_3[#var_22_3].y)
			local var_22_17 = math.acos(cc.pDot(var_22_15, var_22_16) / (cc.pGetLength(var_22_15) * cc.pGetLength(var_22_16)))
			local var_22_18 = cc.pCross(var_22_15, var_22_16)
			local var_22_22

			if var_22_5 * var_22_18 <= 0 then
				local var_22_19 = var_22_10 and var_22_14 or var_22_13

				table.insert(var_22_3, var_22_10 and var_22_14 or var_22_13)

				local var_22_20

				for iter_22_10, iter_22_11 in ipairs(arg_22_2) do
					if iter_22_11.u:Equal(var_22_19) then
						var_22_20 = iter_22_11.w
					end

					if iter_22_11.w:Equal(var_22_19) then
						var_22_20 = iter_22_11.u
					end
				end

				if var_22_10 then
					for iter_22_12, iter_22_13 in ipairs(var_22_11) do
						local var_22_21

						if iter_22_13.point:Equal(var_22_20) then
							var_22_21 = iter_22_12
						end
					end

					var_22_22 = var_22_7 + 1

					break
				end

				for iter_22_14, iter_22_15 in ipairs(var_22_12) do
					if iter_22_15.point:Equal(var_22_20) then
						var_22_22 = iter_22_14
					end
				end

				var_22_21 = var_22_6 + 1

				break
			end

			if var_22_17 < var_22_4 then
				for iter_22_16, iter_22_17 in ipairs(var_22_10 and var_22_11 or var_22_12) do
					iter_22_17.disable = false
				end

				local var_22_23 = 0

				for iter_22_18, iter_22_19 in ipairs(arg_22_2) do
					var_22_23 = (iter_22_19.u:Equal(var_22_11[var_22_6].point) or iter_22_19.w:Equal(var_22_11[var_22_6].point)) and iter_22_18
				end

				local var_22_24 = 0

				for iter_22_20, iter_22_21 in ipairs(arg_22_2) do
					var_22_24 = (iter_22_21.u:Equal(var_22_12[var_22_7].point) or iter_22_21.w:Equal(var_22_12[var_22_7].point)) and iter_22_20
				end

				if var_22_23 < var_22_24 then
					var_22_10 = false

					if var_22_6 < var_22_8 then
						for iter_22_22 = var_22_6 + 1, var_22_8 do
							if not var_22_11[iter_22_22].disable then
								var_22_6 = iter_22_22
								var_22_10 = true

								break
							end
						end
					end

					if not var_22_10 then
						for iter_22_23 = var_22_7 + 1, var_22_9 do
							if not var_22_12[iter_22_23].disable then
								var_22_7 = iter_22_23

								break
							end
						end
					end
				else
					var_22_10 = true

					if var_22_7 < var_22_9 then
						for iter_22_24 = var_22_7 + 1, var_22_9 do
							if not var_22_12[iter_22_24].disable then
								var_22_7 = iter_22_24
								var_22_10 = false

								break
							end
						end
					end

					if not var_22_10 then
						for iter_22_25 = var_22_6 + 1, var_22_8 do
							if not var_22_11[iter_22_25].disable then
								var_22_6 = iter_22_25

								break
							end
						end
					end
				end

				var_22_4 = var_22_17
				var_22_5 = var_22_18
			elseif var_22_10 then
				var_22_11[var_22_6].disable = true

				while var_22_6 > 1 do
					var_22_6 = var_22_6 - 1

					if not var_22_11[var_22_6].disable then
						break
					end
				end

				local var_22_26 = var_22_11[var_22_6].point
				local var_22_27 = 0

				for iter_22_26, iter_22_27 in ipairs(arg_22_2) do
					var_22_27 = (iter_22_27.u:Equal(var_22_26) or iter_22_27.w:Equal(var_22_26)) and iter_22_26
				end

				local var_22_28 = 0

				for iter_22_28, iter_22_29 in ipairs(arg_22_2) do
					var_22_28 = (iter_22_29.u:Equal(var_22_12[var_22_7].point) or iter_22_29.w:Equal(var_22_12[var_22_7].point)) and iter_22_28
				end

				if var_22_27 < var_22_28 then
					var_22_10 = false

					if var_22_6 < var_22_8 then
						for iter_22_30 = var_22_6 + 1, var_22_8 do
							if not var_22_11[iter_22_30].disable then
								var_22_6 = iter_22_30
								var_22_10 = true

								break
							end
						end
					end

					if not var_22_10 then
						for iter_22_31 = var_22_7 + 1, var_22_9 do
							if not var_22_12[iter_22_31].disable then
								var_22_7 = iter_22_31

								break
							end
						end
					end
				else
					var_22_10 = true

					if var_22_7 < var_22_9 then
						for iter_22_32 = var_22_7 + 1, var_22_9 do
							if not var_22_12[iter_22_32].disable then
								var_22_7 = iter_22_32
								var_22_10 = false

								break
							end
						end
					end

					if not var_22_10 then
						for iter_22_33 = var_22_6 + 1, var_22_8 do
							if not var_22_11[iter_22_33].disable then
								var_22_6 = iter_22_33

								break
							end
						end
					end
				end
			else
				var_22_12[var_22_7].disable = true

				while var_22_7 > 1 do
					var_22_7 = var_22_7 - 1

					if not var_22_12[var_22_7].disable then
						break
					end
				end

				local var_22_30 = var_22_11[var_22_6].point
				local var_22_31 = 0

				for iter_22_34, iter_22_35 in ipairs(arg_22_2) do
					var_22_31 = (iter_22_35.u:Equal(var_22_30) or iter_22_35.w:Equal(var_22_30)) and iter_22_34
				end

				local var_22_32 = 0

				for iter_22_36, iter_22_37 in ipairs(arg_22_2) do
					var_22_32 = (iter_22_37.u:Equal(var_22_12[var_22_7].point) or iter_22_37.w:Equal(var_22_12[var_22_7].point)) and iter_22_36
				end

				if var_22_31 < var_22_32 then
					var_22_10 = false

					if var_22_6 < var_22_8 then
						for iter_22_38 = var_22_6 + 1, var_22_8 do
							if not var_22_11[iter_22_38].disable then
								var_22_6 = iter_22_38
								var_22_10 = true

								break
							end
						end
					end

					if not var_22_10 then
						for iter_22_39 = var_22_7 + 1, var_22_9 do
							if not var_22_12[iter_22_39].disable then
								var_22_7 = iter_22_39

								break
							end
						end
					end
				else
					var_22_10 = true

					if var_22_7 < var_22_9 then
						for iter_22_40 = var_22_7 + 1, var_22_9 do
							if not var_22_12[iter_22_40].disable then
								var_22_7 = iter_22_40
								var_22_10 = false

								break
							end
						end
					end

					if not var_22_10 then
						for iter_22_41 = var_22_6 + 1, var_22_8 do
							if not var_22_11[iter_22_41].disable then
								var_22_6 = iter_22_41

								break
							end
						end
					end
				end
			end
		end
	end

	local var_22_33 = {}

	dump(var_22_3)

	for iter_22_42, iter_22_43 in ipairs(var_22_3) do
		if iter_22_42 < #var_22_3 then
			table.insert(var_22_33, Edge2.new(iter_22_43, var_22_3[iter_22_42 + 1]))
		end
	end

	self:showLines(var_22_33)
end

function DebugNavmesh2DComp:funnelSearch2(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = {
		arg_23_3
	}

	if #arg_23_1 == 0 or #arg_23_2 <= 1 then
		table.insert(var_23_0, arg_23_4)

		return var_23_0
	end

	local function var_23_1(arg_24_0, arg_24_1, arg_24_2)
		return (arg_24_1.x - arg_24_0.x) * (arg_24_2.y - arg_24_0.y) - (arg_24_1.y - arg_24_0.y) * (arg_24_2.x - arg_24_0.x)
	end

	local var_23_2 = arg_23_3
	local var_23_3 = arg_23_2[1].u
	local var_23_4 = arg_23_2[1].w

	if var_23_1(arg_23_3, arg_23_2[1].u, arg_23_2[1].w) < 0 then
		var_23_4 = var_23_3
		var_23_3 = var_23_4
	end

	local var_23_5 = 2

	while var_23_5 <= #arg_23_2 do
		local var_23_6 = arg_23_2[var_23_5].u
		local var_23_7 = arg_23_2[var_23_5].w

		if var_23_1(var_23_2, arg_23_2[var_23_5].u, arg_23_2[var_23_5].w) < 0 then
			var_23_7 = var_23_6
			var_23_6 = var_23_7
		end

		local var_23_8 = false

		dump("判断角" .. var_23_4:toS() .. "_" .. var_23_2:toS() .. "_" .. var_23_7:toS())

		if var_23_1(var_23_2, var_23_4, var_23_7) <= 0 then
			dump("小于等于0")
			dump("判断角" .. var_23_3:toS() .. "_" .. var_23_2:toS() .. "_" .. var_23_7:toS())

			if var_23_1(var_23_2, var_23_3, var_23_7) >= 0 then
				dump("大于等于0,right点从" .. var_23_4:toS() .. "变成" .. var_23_7:toS())

				var_23_4 = var_23_7
			else
				dump("小于0，插入点" .. var_23_3:toS() .. "apex改成" .. var_23_3:toS() .. "，right点" .. var_23_7:toS() .. "left变成" .. var_23_2:toS())
				table.insert(var_23_0, var_23_3)

				var_23_2 = var_23_3
				var_23_4 = var_23_3
				var_23_3 = var_23_3
				var_23_8 = true
			end
		end

		if not var_23_8 then
			dump("判断角" .. var_23_3:toS() .. "_" .. var_23_2:toS() .. "_" .. var_23_6:toS())

			if var_23_1(var_23_2, var_23_3, var_23_6) >= 0 then
				dump("大于等于0")
				dump("判断角" .. var_23_4:toS() .. "_" .. var_23_2:toS() .. "_" .. var_23_6:toS())

				if var_23_1(var_23_2, var_23_4, var_23_6) <= 0 then
					dump("小于等于0,left点从" .. var_23_3:toS() .. "变成" .. var_23_6:toS())

					var_23_3 = var_23_6
				else
					dump("大于0，插入点" .. var_23_4:toS() .. "apex改成" .. var_23_4:toS() .. "，left点" .. var_23_6:toS() .. "right变成" .. var_23_2:toS())
					table.insert(var_23_0, var_23_4)

					var_23_2 = var_23_4
					var_23_3 = var_23_4
					var_23_4 = var_23_4
					var_23_8 = true
				end
			end
		end

		if not var_23_8 then
			dumpError("++++++++" .. var_23_5)

			var_23_5 = var_23_5 + 1
		else
			dumpError("--------重新检查" .. var_23_5)
		end
	end

	local var_23_9 = var_23_1(var_23_2, var_23_3, arg_23_4)

	if var_23_9 >= 0 and var_23_1(var_23_2, var_23_4, arg_23_4) <= 0 then
		table.insert(var_23_0, arg_23_4)
	elseif var_23_9 >= 0 then
		table.insert(var_23_0, var_23_4)
		table.insert(var_23_0, arg_23_4)
	else
		table.insert(var_23_0, var_23_3)
		table.insert(var_23_0, arg_23_4)
	end

	local var_23_10 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if iter_23_0 < #var_23_0 then
			table.insert(var_23_10, Edge2.new(iter_23_1, var_23_0[iter_23_0 + 1]))
		end
	end

	self:showLines(var_23_10)
end

function DebugNavmesh2DComp:funnelSearch3(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = {
		arg_25_3
	}

	if #arg_25_1 == 0 or #arg_25_2 <= 1 then
		table.insert(var_25_0, arg_25_4)

		return var_25_0
	end

	local function var_25_1(arg_26_0, arg_26_1, arg_26_2)
		return (arg_26_1.x - arg_26_0.x) * (arg_26_2.y - arg_26_0.y) - (arg_26_1.y - arg_26_0.y) * (arg_26_2.x - arg_26_0.x)
	end

	local var_25_2 = 1e-15

	local function var_25_3(arg_27_0, arg_27_1, arg_27_2)
		return var_25_1(arg_27_0, arg_27_1, arg_27_2) > var_25_2
	end

	local function var_25_4(arg_28_0, arg_28_1, arg_28_2)
		return var_25_1(arg_28_0, arg_28_1, arg_28_2) < -var_25_2
	end

	local var_25_5 = arg_25_3
	local var_25_6 = arg_25_2[1].u
	local var_25_7 = arg_25_2[1].w

	if var_25_4(arg_25_3, arg_25_2[1].u, arg_25_2[1].w) then
		var_25_7 = var_25_6
		var_25_6 = var_25_7
	end

	local var_25_8 = 2

	while var_25_8 <= #arg_25_2 do
		local var_25_9 = arg_25_2[var_25_8].u
		local var_25_10 = arg_25_2[var_25_8].w

		if var_25_4(var_25_5, arg_25_2[var_25_8].u, arg_25_2[var_25_8].w) then
			var_25_10 = var_25_9
			var_25_9 = var_25_10
		end

		local var_25_11 = false

		if not var_25_3(var_25_5, var_25_7, var_25_10) then
			if var_25_3(var_25_5, var_25_6, var_25_10) then
				table.insert(var_25_0, var_25_6)

				var_25_5 = var_25_6
				var_25_7 = var_25_6
				var_25_6 = var_25_6
				var_25_11 = true
			else
				var_25_7 = var_25_10
			end
		end

		if not var_25_11 and not var_25_4(var_25_5, var_25_6, var_25_9) then
			if var_25_4(var_25_5, var_25_7, var_25_9) then
				table.insert(var_25_0, var_25_7)

				var_25_5 = var_25_7
				var_25_6 = var_25_7
				var_25_7 = var_25_7
				var_25_11 = true
			else
				var_25_6 = var_25_9
			end
		end

		if not var_25_11 then
			var_25_8 = var_25_8 + 1
		end
	end

	if (function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		return not var_25_3(arg_29_0, arg_29_1, arg_29_3) and not var_25_4(arg_29_0, arg_29_2, arg_29_3)
	end)(var_25_5, var_25_6, var_25_7, arg_25_4) then
		table.insert(var_25_0, arg_25_4)
	else
		if var_25_4(var_25_5, var_25_6, arg_25_4) then
			table.insert(var_25_0, var_25_6)
		else
			table.insert(var_25_0, var_25_7)
		end

		table.insert(var_25_0, arg_25_4)
	end

	local var_25_12 = {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_0 < #var_25_0 then
			table.insert(var_25_12, Edge2.new(iter_25_1, var_25_0[iter_25_0 + 1]))
		end
	end

	self:showLines(var_25_12)
end

return DebugNavmesh2DComp
