local var_0_0 = {
	{
		0,
		1
	},
	{
		0,
		-1
	},
	{
		-1,
		0
	},
	{
		1,
		0
	},
	{
		-1,
		1
	},
	{
		1,
		1
	},
	{
		1,
		-1
	},
	{
		-1,
		-1
	}
}

local function var_0_1(arg_1_0)
	return arg_1_0.x * 100000 + arg_1_0.y
end

local KsMath = require("app.core.utils.KsMath")
local DebugFingPath = class("DebugFingPath", require("app.fairyGUI.debug.UI_DebugFindPath"))

function DebugFingPath:ctor()
	self._width = 40
	self._height = 30
	self._rootNode = display.newNode()

	self:addNode(self._rootNode)
	self._rootNode:setPosition(0, 0)

	self._rootPos = cc.p(0, 0)
	self._allSprite = {}
	self._lineRoot = fgui.GComponent:create()

	self:addChild(self._lineRoot)

	self._lineRootPos = self._lineRoot:getPosition()

	self._lineRoot:setVisible(false)

	self._allLine = {}
	self._isTouch = false
	self._beginPos = cc.p(0, 0)
	self._startMovePos = cc.p(0, 0)
	self._gridSize = cc.size(0, 0)
	self._whiteTexture = cc.Director:getInstance():getTextureCache():addImage("ui_cocos/findPath/white.png")
	self._emptyTexture = cc.Director:getInstance():getTextureCache():addImage("ui_cocos/findPath/empty.png")
	self._darkTexture = cc.Director:getInstance():getTextureCache():addImage("ui_cocos/findPath/dark.png")
	self._redTexture = cc.Director:getInstance():getTextureCache():addImage("ui_cocos/findPath/red.png")
	self._greenTexture = cc.Director:getInstance():getTextureCache():addImage("ui_cocos/findPath/green.png")
	self._btnState = 1
	self._darkList = {}
	self._startGrid = nil
	self._goalGrid = nil
	self._pathGridDict = {}
	self._findPathList = {}
	self._aStar = require("app.core.utils.KsAStar")
end

function DebugFingPath:onUnload()
	return
end

function DebugFingPath:onLoad()
	self:updateMapView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_startBtn:addClickListener(handler(self, self._onClickStart))
	self.m_goalBtn:addClickListener(handler(self, self._onClickGoal))
end

function DebugFingPath:_onClickStart()
	self.m_tipText:setText("当前：设置起点")

	self._btnState = 1
end

function DebugFingPath:_onClickGoal()
	self.m_tipText:setText("当前：设置终点")

	self._btnState = 2
end

function DebugFingPath:_addTestFindGrid(arg_7_1)
	self._testFindGrid[var_0_1(arg_7_1)] = not self._testFindGrid[var_0_1(arg_7_1)] and 1 or self._testFindGrid[var_0_1(arg_7_1)] + 1
end

function DebugFingPath:_dumpTestFindGrid()
	return
end

function DebugFingPath:_onTouchBegin(arg_9_1)
	self._beginPos = arg_9_1:getInput():getPosition()

	arg_9_1:captureTouch()

	self._isTouch = false
end

function DebugFingPath:_onTouchMove(arg_10_1)
	if arg_10_1:getInput():getButton() == 1 then
		return
	end

	local var_10_0 = arg_10_1:getInput():getPosition()

	if self._isTouch then
		self._rootNode:setPosition(self._rootPos.x + (var_10_0.x - self._startMovePos.x), self._rootPos.y - (var_10_0.y - self._startMovePos.y))
		self._lineRoot:setPosition(self._lineRootPos.x + (var_10_0.x - self._startMovePos.x), self._lineRootPos.y + (var_10_0.y - self._startMovePos.y))
	elseif KsMath.calculateDistance2(self._beginPos, var_10_0) > 500 then
		self._isTouch = true
		self._startMovePos = var_10_0
	end
end

function DebugFingPath:_onTouchEnd(arg_11_1)
	if self._isTouch then
		self._rootPos = cc.p(self._rootNode:getPositionX(), self._rootNode:getPositionY())
	else
		local var_11_0 = arg_11_1:getInput():getPosition()

		var_11_0.y = display.height - var_11_0.y

		local var_11_1 = self:_posToGrid((self._rootNode:convertToNodeSpace(var_11_0)))

		if self:_isInMap(var_11_1) then
			if arg_11_1:getInput():getButton() == 1 then
				if self:isDark(var_11_1) then
					self:setDark(var_11_1, false)
				end

				if self._btnState == 1 then
					self._startGrid = var_11_1
				else
					self._goalGrid = var_11_1
				end
			elseif self:isDark(var_11_1) then
				self:setDark(var_11_1, false)
			else
				self:setDark(var_11_1, true)
			end

			self:updateMapView()
		end
	end
end

function DebugFingPath:setDark(arg_12_1, arg_12_2)
	self._darkList[arg_12_1.x] = self._darkList[arg_12_1.x] or {}
	self._darkList[arg_12_1.x][arg_12_1.y] = arg_12_2
end

function DebugFingPath:isDark(arg_13_1)
	if self._darkList[arg_13_1.x] then
		return self._darkList[arg_13_1.x][arg_13_1.y] == true
	end

	return false
end

function DebugFingPath:_isInMap(arg_14_1)
	if self._allSprite[arg_14_1.x] then
		return self._allSprite[arg_14_1.x][arg_14_1.y] ~= nil
	end

	return false
end

function DebugFingPath:_gridToPos(arg_15_1)
	return cc.p(self._gridSize.width * (arg_15_1.x - 1), self._gridSize.height * (arg_15_1.y - 1))
end

function DebugFingPath:_posToGrid(arg_16_1)
	return cc.p(math.floor(arg_16_1.x / self._gridSize.width + 0.5) + 1, math.floor(arg_16_1.y / self._gridSize.height + 0.5) + 1)
end

function DebugFingPath:updateMapView()
	self._pathGridDict = {}
	self._findPathList = {}
	self._testFindGrid = {}

	local var_17_0 = self:findPath(self._startGrid, self._goalGrid)
	local var_17_1 = os.clock()

	dump(var_17_1 - os.clock(), "jps needTime")

	if self._startGrid and self._goalGrid then
		local var_17_2 = self._aStar.searchPath(self._startGrid, self._goalGrid, self)

		dump(os.clock() - var_17_1, "aStar needTime")
	end

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			self._pathGridDict[var_0_1(iter_17_1)] = true
		end

		self._findPathList = var_17_0

		local var_17_3 = self._rootNode:getPosition()
		local var_17_4 = 2

		while var_17_0[var_17_4] do
			local var_17_5 = self._allLine[var_17_4]

			if not self._allLine[var_17_4] then
				var_17_5 = fgui.UIPackage:createObject("debug", "DebugKMeansTestLine")
				self._allLine[var_17_4] = var_17_5

				self._lineRoot:addChild(var_17_5)
			end

			var_17_5:setVisible(true)

			local var_17_6 = self._rootNode:convertToWorldSpace((self:_gridToPos(cc.p(var_17_0[var_17_4 - 1]))))

			var_17_6.y = display.height - var_17_6.y

			var_17_5:setPosition(var_17_6)

			local var_17_7 = self._rootNode:convertToWorldSpace((self:_gridToPos(cc.p(var_17_0[var_17_4]))))

			var_17_7.y = display.height - var_17_7.y

			local var_17_8 = cc.pSub(var_17_7, var_17_6)

			var_17_5:setWidth(cc.pGetLength(var_17_8))
			var_17_5:setRotation(math.radian2angle(cc.pToAngleSelf(var_17_8)))

			var_17_4 = var_17_4 + 1
		end

		for iter_17_2 = var_17_4 + 1, #self._allLine do
			self._allLine[iter_17_2]:setVisible(false)
		end

		while self._allLine[var_17_4] do
			self._allLine[var_17_4]:setVisible(false)

			var_17_4 = var_17_4 + 1
		end
	else
		local var_17_9, var_17_10 = next(self._allLine)

		while var_17_10 do
			var_17_10:setVisible(false)

			var_17_9 = var_17_9 + 1
			var_17_10 = self._allLine[var_17_9]
		end
	end

	self._gridSize = self._emptyTexture:getContentSize()

	for iter_17_3 = 1, math.max(self._width, #self._allSprite) do
		self._allSprite[iter_17_3] = self._allSprite[iter_17_3] or {}

		for iter_17_4 = 1, math.max(self._height, #self._allSprite[iter_17_3]) do
			local var_17_11 = self._allSprite[iter_17_3][iter_17_4]
			local var_17_12 = iter_17_3 <= self._width and iter_17_4 <= self._height

			if self._allSprite[iter_17_3][iter_17_4] then
				var_17_11:setVisible(var_17_12)
			end

			if not var_17_12 then
				break
			end

			local var_17_13 = cc.p(iter_17_3, iter_17_4)

			if not var_17_11 then
				var_17_11 = cc.Sprite:createWithTexture(self:getGridTexture(var_17_13))

				self._rootNode:addChild(var_17_11)

				self._allSprite[iter_17_3][iter_17_4] = var_17_11
			end

			var_17_11:setTexture(self:getGridTexture(var_17_13))
			var_17_11:setPosition(self:_gridToPos(var_17_13))
		end
	end
end

function DebugFingPath:getGridTexture(arg_18_1)
	if not self:_isInMap(arg_18_1) then
		return self._emptyTexture
	end

	if self:isDark(arg_18_1) then
		return self._darkTexture
	end

	if self:isGoal(arg_18_1) then
		return self._redTexture
	end

	if self:isStart(arg_18_1) then
		return self._whiteTexture
	end

	if self:isInPath(arg_18_1) then
		return self._greenTexture
	end

	return self._emptyTexture
end

function DebugFingPath:aAtarFindPath()
	return
end

local var_0_4 = false

function DebugFingPath:findPath(arg_20_1, arg_20_2)
	if not arg_20_1 or not arg_20_2 then
		return nil
	end

	self._openList = {}
	self._closeList = {}
	var_0_4 = not var_0_4
	self._openList[var_0_1(arg_20_1)] = {
		g = 0,
		x = arg_20_1.x,
		y = arg_20_1.y,
		h = self:getHeuristic(arg_20_1, arg_20_2)
	}

	local var_20_0 = var_0_1(arg_20_2)

	while next(self._openList) do
		local var_20_1, var_20_2 = self:getMinCostNode(self._openList)

		if var_20_2 == var_20_0 then
			return self:backtrack(var_20_1)
		end

		self._openList[var_20_2] = nil
		self._closeList[var_20_2] = true

		for iter_20_0, iter_20_1 in ipairs((self:getJumpPointList(var_20_1))) do
			local var_20_3 = var_0_1(iter_20_1)

			if not self._closeList[var_20_3] then
				local var_20_4 = var_20_1.g + self:getHeuristic(var_20_1, iter_20_1)
				local var_20_5 = self:getHeuristic(iter_20_1, arg_20_2)

				if not self._openList[iter_20_1] or var_20_4 + var_20_5 < self._openList[var_20_3].g + self._openList[var_20_3].h then
					self._openList[var_20_3] = {
						x = iter_20_1.x,
						y = iter_20_1.y,
						g = var_20_4,
						h = var_20_5,
						parent = var_20_1
					}
				end
			end
		end
	end

	return nil
end

function DebugFingPath:isGoal(arg_21_1)
	if not self._goalGrid then
		return false
	end

	return self._goalGrid.x == arg_21_1.x and self._goalGrid.y == arg_21_1.y
end

function DebugFingPath:isStart(arg_22_1)
	if not self._startGrid then
		return false
	end

	return self._startGrid.x == arg_22_1.x and self._startGrid.y == arg_22_1.y
end

function DebugFingPath:isInPath(arg_23_1)
	return self._pathGridDict[var_0_1(arg_23_1)] == true
end

function DebugFingPath:getJumpPointList(arg_24_1)
	local var_24_0 = {}

	if arg_24_1.parent then
		if arg_24_1.x - arg_24_1.parent.x ~= 0 then
			if arg_24_1.y - arg_24_1.parent.y ~= 0 then
				local var_24_1 = {
					(arg_24_1.x - arg_24_1.parent.x) / math.abs(arg_24_1.x - arg_24_1.parent.x),
					(arg_24_1.y - arg_24_1.parent.y) / math.abs(arg_24_1.y - arg_24_1.parent.y)
				}

				table.insert(var_24_0, {
					0,
					var_24_1[2]
				})
				table.insert(var_24_0, {
					var_24_1[1],
					0
				})
				table.insert(var_24_0, var_24_1)
				self:addDiagonalDir(arg_24_1, var_24_1, var_24_0)
			else
				local var_24_2 = {
					(arg_24_1.x - arg_24_1.parent.x) / math.abs(arg_24_1.x - arg_24_1.parent.x),
					0
				}

				table.insert(var_24_0, var_24_2)

				local var_24_3 = {
					x = arg_24_1.x,
					y = arg_24_1.y + 1
				}

				if self:isDark(var_24_3) then
					local var_24_4 = {
						x = var_24_3.x + var_24_2[1],
						y = var_24_3.y
					}

					if not self:isDark(var_24_4) and self:_isInMap(var_24_4) then
						table.insert(var_24_0, {
							var_24_2[1],
							1
						})
					end
				end

				local var_24_5 = {
					x = arg_24_1.x,
					y = arg_24_1.y - 1
				}

				if self:isDark(var_24_5) then
					local var_24_6 = {
						x = var_24_5.x + var_24_2[1],
						y = var_24_5.y
					}

					if not self:isDark(var_24_6) and self:_isInMap(var_24_6) then
						table.insert(var_24_0, {
							var_24_2[1],
							-1
						})
					end
				end
			end
		elseif arg_24_1.y - arg_24_1.parent.y ~= 0 then
			local var_24_7 = {
				0,
				(arg_24_1.y - arg_24_1.parent.y) / math.abs(arg_24_1.y - arg_24_1.parent.y)
			}

			table.insert(var_24_0, var_24_7)

			local var_24_8 = {
				x = arg_24_1.x + 1,
				y = arg_24_1.y
			}

			if self:isDark(var_24_8) then
				local var_24_9 = {
					x = var_24_8.x,
					y = arg_24_1.y + var_24_7[2]
				}

				if not self:isDark(var_24_9) and self:_isInMap(var_24_9) then
					table.insert(var_24_0, {
						1,
						var_24_7[2]
					})
				end
			end

			local var_24_10 = {
				x = arg_24_1.x - 1,
				y = arg_24_1.y
			}

			if self:isDark(var_24_10) then
				local var_24_11 = {
					x = var_24_10.x,
					y = arg_24_1.y + var_24_7[2]
				}

				if not self:isDark(var_24_11) and self:_isInMap(var_24_11) then
					table.insert(var_24_0, {
						-1,
						var_24_7[2]
					})
				end
			end
		end
	else
		var_24_0 = var_0_0
	end

	local var_24_12 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		local var_24_13 = cc.p(arg_24_1.x, arg_24_1.y)

		while true do
			var_24_13 = cc.p(var_24_13.x + iter_24_1[1], var_24_13.y + iter_24_1[2])

			if self:isGoal(var_24_13) then
				table.insert(var_24_12, var_24_13)

				return var_24_12
			end

			local var_24_14 = var_0_1(var_24_13)

			if self:isDark(var_24_13) or self._closeList[var_24_14] then
				break
			end

			if not self:_isInMap(var_24_13) then
				break
			end

			if self._openList[var_24_14] then
				table.insert(var_24_12, var_24_13)

				break
			end

			if iter_24_1[2] == 0 then
				local var_24_15 = {
					x = var_24_13.x,
					y = var_24_13.y + 1
				}

				if self:isDark(var_24_15) then
					local var_24_16 = {
						x = var_24_15.x + iter_24_1[1],
						y = var_24_15.y
					}

					if not self:isDark(var_24_16) and self:_isInMap(var_24_16) then
						table.insert(var_24_12, var_24_13)

						break
					end
				end

				local var_24_17 = {
					x = var_24_13.x,
					y = var_24_13.y - 1
				}

				if self:isDark(var_24_17) then
					local var_24_18 = {
						x = var_24_17.x + iter_24_1[1],
						y = var_24_17.y
					}

					if not self:isDark(var_24_18) and self:_isInMap(var_24_18) then
						table.insert(var_24_12, var_24_13)

						break
					end
				end
			elseif iter_24_1[1] == 0 then
				local var_24_19 = {
					x = var_24_13.x + 1,
					y = var_24_13.y
				}

				if self:isDark(var_24_19) then
					local var_24_20 = {
						x = var_24_19.x,
						y = var_24_13.y + iter_24_1[2]
					}

					if not self:isDark(var_24_20) and self:_isInMap(var_24_20) then
						table.insert(var_24_12, var_24_13)

						break
					end
				end

				local var_24_21 = {
					x = var_24_13.x - 1,
					y = var_24_13.y
				}

				if self:isDark(var_24_21) then
					local var_24_22 = {
						x = var_24_21.x,
						y = var_24_13.y + iter_24_1[2]
					}

					if not self:isDark(var_24_22) and self:_isInMap(var_24_22) then
						table.insert(var_24_12, var_24_13)

						break
					end
				end
			elseif self:checkHVForceNeighbour(cc.p(var_24_13.x, var_24_13.y), {
				[1] = 0,
				[2] = iter_24_1[2]
			}) then
				table.insert(var_24_12, cc.p(var_24_13.x, var_24_13.y))
			elseif self:checkHVForceNeighbour(cc.p(var_24_13.x, var_24_13.y), {
				iter_24_1[1],
				[2] = 0
			}) then
				table.insert(var_24_12, cc.p(var_24_13.x, var_24_13.y))
			elseif self:checkDiagonalForceNeighbour(var_24_13, iter_24_1) then
				table.insert(var_24_12, cc.p(var_24_13.x, var_24_13.y))

				break
			end
		end
	end

	return var_24_12
end

function DebugFingPath:addDiagonalDir(arg_25_1, arg_25_2, arg_25_3)
	({
		{
			function()
				if self:isDark((cc.p(arg_25_1.x, arg_25_1.y - 1))) then
					local var_26_0 = cc.p(arg_25_1.x + 1, arg_25_1.y - 1)

					if self:_isInMap(var_26_0) and not self:isDark(var_26_0) then
						table.insert(arg_25_3, {
							1,
							-1
						})
					end
				end

				if self:isDark((cc.p(arg_25_1.x - 1, arg_25_1.y))) then
					local var_26_1 = cc.p(arg_25_1.x - 1, arg_25_1.y + 1)

					if self:_isInMap(var_26_1) and not self:isDark(var_26_1) then
						table.insert(arg_25_3, {
							-1,
							1
						})
					end
				end
			end,
			[-1] = function()
				if self:isDark((cc.p(arg_25_1.x, arg_25_1.y + 1))) then
					local var_27_0 = cc.p(arg_25_1.x + 1, arg_25_1.y + 1)

					if self:_isInMap(var_27_0) and not self:isDark(var_27_0) then
						table.insert(arg_25_3, {
							1,
							1
						})
					end
				end

				if self:isDark((cc.p(arg_25_1.x - 1, arg_25_1.y))) then
					local var_27_1 = cc.p(arg_25_1.x - 1, arg_25_1.y - 1)

					if self:_isInMap(var_27_1) and not self:isDark(var_27_1) then
						table.insert(arg_25_3, {
							-1,
							-1
						})
					end
				end
			end
		},
		[-1] = {
			function()
				if self:isDark((cc.p(arg_25_1.x, arg_25_1.y - 1))) then
					local var_28_0 = cc.p(arg_25_1.x - 1, arg_25_1.y - 1)

					if self:_isInMap(var_28_0) and not self:isDark(var_28_0) then
						table.insert(arg_25_3, {
							-1,
							-1
						})
					end
				end

				if self:isDark((cc.p(arg_25_1.x + 1, arg_25_1.y))) then
					local var_28_1 = cc.p(arg_25_1.x + 1, arg_25_1.y + 1)

					if self:_isInMap(var_28_1) and not self:isDark(var_28_1) then
						table.insert(arg_25_3, {
							1,
							1
						})
					end
				end
			end,
			[-1] = function()
				if self:isDark((cc.p(arg_25_1.x, arg_25_1.y + 1))) then
					local var_29_0 = cc.p(arg_25_1.x - 1, arg_25_1.y + 1)

					if self:_isInMap(var_29_0) and not self:isDark(var_29_0) then
						table.insert(arg_25_3, {
							-1,
							1
						})
					end
				end

				if self:isDark((cc.p(arg_25_1.x + 1, arg_25_1.y))) then
					local var_29_1 = cc.p(arg_25_1.x + 1, arg_25_1.y - 1)

					if self:_isInMap(var_29_1) and not self:isDark(var_29_1) then
						table.insert(arg_25_3, {
							1,
							-1
						})
					end
				end
			end
		}
	})[arg_25_2[1]][arg_25_2[2]]()
end

function DebugFingPath:checkDiagonalForceNeighbour(arg_30_1, arg_30_2)
	return ({
		{
			function()
				if self:isDark((cc.p(arg_30_1.x, arg_30_1.y - 1))) then
					local var_31_0 = cc.p(arg_30_1.x + 1, arg_30_1.y - 1)

					if self:_isInMap(var_31_0) and not self:isDark(var_31_0) then
						return true
					end
				end

				if self:isDark((cc.p(arg_30_1.x - 1, arg_30_1.y))) then
					local var_31_1 = cc.p(arg_30_1.x - 1, arg_30_1.y + 1)

					if self:_isInMap(var_31_1) and not self:isDark(var_31_1) then
						return true
					end
				end
			end,
			[-1] = function()
				if self:isDark((cc.p(arg_30_1.x, arg_30_1.y + 1))) then
					local var_32_0 = cc.p(arg_30_1.x + 1, arg_30_1.y + 1)

					if self:_isInMap(var_32_0) and not self:isDark(var_32_0) then
						return true
					end
				end

				if self:isDark((cc.p(arg_30_1.x - 1, arg_30_1.y))) then
					local var_32_1 = cc.p(arg_30_1.x - 1, arg_30_1.y - 1)

					if self:_isInMap(var_32_1) and not self:isDark(var_32_1) then
						return true
					end
				end
			end
		},
		[-1] = {
			function()
				if self:isDark((cc.p(arg_30_1.x, arg_30_1.y - 1))) then
					local var_33_0 = cc.p(arg_30_1.x - 1, arg_30_1.y - 1)

					if self:_isInMap(var_33_0) and not self:isDark(var_33_0) then
						return true
					end
				end

				if self:isDark((cc.p(arg_30_1.x + 1, arg_30_1.y))) then
					local var_33_1 = cc.p(arg_30_1.x + 1, arg_30_1.y + 1)

					if self:_isInMap(var_33_1) and not self:isDark(var_33_1) then
						return true
					end
				end
			end,
			[-1] = function()
				if self:isDark((cc.p(arg_30_1.x, arg_30_1.y + 1))) then
					local var_34_0 = cc.p(arg_30_1.x - 1, arg_30_1.y + 1)

					if self:_isInMap(var_34_0) and not self:isDark(var_34_0) then
						return true
					end
				end

				if self:isDark((cc.p(arg_30_1.x + 1, arg_30_1.y))) then
					local var_34_1 = cc.p(arg_30_1.x + 1, arg_30_1.y - 1)

					if self:_isInMap(var_34_1) and not self:isDark(var_34_1) then
						return true
					end
				end
			end
		}
	})[arg_30_2[1]][arg_30_2[2]]() == true
end

function DebugFingPath:checkHVForceNeighbour(arg_35_1, arg_35_2)
	if arg_35_2[1] ~= 0 then
		while true do
			if self:isGoal(arg_35_1) then
				return true
			end

			local var_35_0 = var_0_1(arg_35_1)

			if self:isDark(arg_35_1) or self._closeList[var_35_0] then
				break
			end

			if not self:_isInMap(arg_35_1) then
				break
			end

			if self._openList[var_35_0] then
				return true
			end

			local var_35_1 = {
				x = arg_35_1.x,
				y = arg_35_1.y + 1
			}

			if self:isDark(var_35_1) then
				local var_35_2 = {
					x = var_35_1.x + arg_35_2[1],
					y = var_35_1.y
				}

				if not self:isDark(var_35_2) and self:_isInMap(var_35_2) then
					return true
				end
			end

			local var_35_3 = {
				x = arg_35_1.x,
				y = arg_35_1.y - 1
			}

			if self:isDark(var_35_3) then
				local var_35_4 = {
					x = var_35_3.x + arg_35_2[1],
					y = var_35_3.y
				}

				if not self:isDark(var_35_4) and self:_isInMap(var_35_4) then
					return true
				end
			end

			arg_35_1.x = arg_35_1.x + arg_35_2[1]
		end
	elseif arg_35_2[2] ~= 0 then
		while true do
			if self:isGoal(arg_35_1) then
				return true
			end

			local var_35_5 = var_0_1(arg_35_1)

			if self:isDark(arg_35_1) or self._closeList[var_35_5] then
				break
			end

			if not self:_isInMap(arg_35_1) then
				break
			end

			if self._openList[var_35_5] then
				return true
			end

			local var_35_6 = {
				x = arg_35_1.x + 1,
				y = arg_35_1.y
			}

			if self:isDark(var_35_6) then
				local var_35_7 = {
					x = var_35_6.x,
					y = arg_35_1.y + arg_35_2[2]
				}

				if not self:isDark(var_35_7) and self:_isInMap(var_35_7) then
					return true
				end
			end

			local var_35_8 = {
				x = arg_35_1.x - 1,
				y = arg_35_1.y
			}

			if self:isDark(var_35_8) then
				local var_35_9 = {
					x = var_35_8.x,
					y = arg_35_1.y + arg_35_2[2]
				}

				if not self:isDark(var_35_9) and self:_isInMap(var_35_9) then
					return true
				end
			end

			arg_35_1.y = arg_35_1.y + arg_35_2[2]
		end
	end

	return false
end

function DebugFingPath:getMinCostNode(arg_36_1)
	local var_36_0

	for iter_36_0, iter_36_1 in pairs(arg_36_1) do
		local var_36_1, var_36_2

		if iter_36_1.g + iter_36_1.h < math.huge then
			var_36_1 = iter_36_1.g + iter_36_1.h
			var_36_0 = iter_36_1
			var_36_2 = iter_36_0
		end
	end

	return var_36_0, nil
end

function DebugFingPath:getHeuristic(arg_37_1, arg_37_2)
	return KsMath.calculateDistance(arg_37_1, arg_37_2)
end

function DebugFingPath:backtrack(arg_38_1)
	local var_38_0 = {}

	while arg_38_1 do
		table.insert(var_38_0, 1, {
			x = arg_38_1.x,
			y = arg_38_1.y
		})

		arg_38_1 = arg_38_1.parent
	end

	return var_38_0
end

function DebugFingPath:doCanMoveAStar(arg_39_1, arg_39_2)
	return not self:isDark(arg_39_2) and self:_isInMap(arg_39_2)
end

function DebugFingPath:doCalcEstimateAStar(arg_40_1, arg_40_2)
	return self:getHeuristic(arg_40_1, arg_40_2)
end

return DebugFingPath
