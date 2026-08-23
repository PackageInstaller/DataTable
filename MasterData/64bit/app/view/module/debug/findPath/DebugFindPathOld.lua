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
	return arg_1_0.x .. "_" .. arg_1_0.y
end

local KsMath = require("app.core.utils.KsMath")
local DebugFingPath = class("DebugFingPath", require("app.fairyGUI.debug.UI_DebugFindPathOld"))

function DebugFingPath:ctor()
	self._width = 50
	self._height = 30
	self._rootNode = display.newNode()

	self:addNode(self._rootNode)
	self._rootNode:setPosition(0, 0)

	self._rootPos = cc.p(0, 0)
	self._allSprite = {}
	self._lineRoot = fgui.GComponent:create()

	self:addChild(self._lineRoot)

	self._lineRootPos = self._lineRoot:getPosition()
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

function DebugFingPath:_onTouchBegin(arg_6_1)
	self._beginPos = arg_6_1:getInput():getPosition()

	arg_6_1:captureTouch()

	self._isTouch = false
end

function DebugFingPath:_onTouchMove(arg_7_1)
	if arg_7_1:getInput():getButton() == 1 then
		return
	end

	local var_7_0 = arg_7_1:getInput():getPosition()

	if self._isTouch then
		self._rootNode:setPosition(self._rootPos.x + (var_7_0.x - self._startMovePos.x), self._rootPos.y - (var_7_0.y - self._startMovePos.y))
		self._lineRoot:setPosition(self._lineRootPos.x + (var_7_0.x - self._startMovePos.x), self._lineRootPos.y + (var_7_0.y - self._startMovePos.y))
	elseif KsMath.calculateDistance2(self._beginPos, var_7_0) > 500 then
		self._isTouch = true
		self._startMovePos = var_7_0
	end
end

function DebugFingPath:_onTouchEnd(arg_8_1)
	if self._isTouch then
		self._rootPos = cc.p(self._rootNode:getPositionX(), self._rootNode:getPositionY())
	else
		local var_8_0 = arg_8_1:getInput():getPosition()

		var_8_0.y = display.height - var_8_0.y

		local var_8_1 = self:_posToGrid((self._rootNode:convertToNodeSpace(var_8_0)))

		if self:_isInMap(var_8_1) then
			if arg_8_1:getInput():getButton() == 1 then
				if self:isDark(var_8_1) then
					self:setDark(var_8_1, false)
				end

				if self._btnState == 1 then
					self._startGrid = var_8_1
				else
					self._goalGrid = var_8_1
				end
			elseif self:isDark(var_8_1) then
				self:setDark(var_8_1, false)
			else
				self:setDark(var_8_1, true)
			end

			self:updateMapView()
		end
	end
end

function DebugFingPath:setDark(arg_9_1, arg_9_2)
	self._darkList[arg_9_1.x] = self._darkList[arg_9_1.x] or {}
	self._darkList[arg_9_1.x][arg_9_1.y] = arg_9_2
end

function DebugFingPath:isDark(arg_10_1)
	if self._darkList[arg_10_1.x] then
		return self._darkList[arg_10_1.x][arg_10_1.y] == true
	end

	return false
end

function DebugFingPath:_isInMap(arg_11_1)
	if self._allSprite[arg_11_1.x] then
		return self._allSprite[arg_11_1.x][arg_11_1.y] ~= nil
	end

	return false
end

function DebugFingPath:_gridToPos(arg_12_1)
	return cc.p(self._gridSize.width * (arg_12_1.x - 1), self._gridSize.height * (arg_12_1.y - 1))
end

function DebugFingPath:_posToGrid(arg_13_1)
	return cc.p(math.floor(arg_13_1.x / self._gridSize.width + 0.5) + 1, math.floor(arg_13_1.y / self._gridSize.height + 0.5) + 1)
end

function DebugFingPath:updateMapView()
	self._pathGridDict = {}
	self._findPathList = {}

	local var_14_0 = self:findPath(self._startGrid, self._goalGrid)

	if var_14_0 then
		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			self._pathGridDict[var_0_1(iter_14_1)] = true
		end

		self._findPathList = var_14_0

		local var_14_1 = self._rootNode:getPosition()
		local var_14_2 = 2

		while var_14_0[var_14_2] do
			local var_14_3 = self._allLine[var_14_2]

			if not self._allLine[var_14_2] then
				var_14_3 = fgui.UIPackage:createObject("debug", "DebugKMeansTestLine")
				self._allLine[var_14_2] = var_14_3

				self._lineRoot:addChild(var_14_3)
			end

			var_14_3:setVisible(true)

			local var_14_4 = self._rootNode:convertToWorldSpace((self:_gridToPos(cc.p(var_14_0[var_14_2 - 1]))))

			var_14_4.y = display.height - var_14_4.y

			var_14_3:setPosition(var_14_4)

			local var_14_5 = self._rootNode:convertToWorldSpace((self:_gridToPos(cc.p(var_14_0[var_14_2]))))

			var_14_5.y = display.height - var_14_5.y

			local var_14_6 = cc.pSub(var_14_5, var_14_4)

			var_14_3:setWidth(cc.pGetLength(var_14_6))
			var_14_3:setRotation(math.radian2angle(cc.pToAngleSelf(var_14_6)))

			var_14_2 = var_14_2 + 1
		end

		for iter_14_2 = var_14_2 + 1, #self._allLine do
			self._allLine[iter_14_2]:setVisible(false)
		end

		while self._allLine[var_14_2] do
			self._allLine[var_14_2]:setVisible(false)

			var_14_2 = var_14_2 + 1
		end
	else
		local var_14_7, var_14_8 = next(self._allLine)

		while var_14_8 do
			var_14_8:setVisible(false)

			var_14_7 = var_14_7 + 1
			var_14_8 = self._allLine[var_14_7]
		end
	end

	self._gridSize = self._emptyTexture:getContentSize()

	for iter_14_3 = 1, math.max(self._width, #self._allSprite) do
		self._allSprite[iter_14_3] = self._allSprite[iter_14_3] or {}

		for iter_14_4 = 1, math.max(self._height, #self._allSprite[iter_14_3]) do
			local var_14_9 = self._allSprite[iter_14_3][iter_14_4]
			local var_14_10 = iter_14_3 <= self._width and iter_14_4 <= self._height

			if self._allSprite[iter_14_3][iter_14_4] then
				var_14_9:setVisible(var_14_10)
			end

			if not var_14_10 then
				break
			end

			local var_14_11 = cc.p(iter_14_3, iter_14_4)

			if not var_14_9 then
				var_14_9 = cc.Sprite:createWithTexture(self:getGridTexture(var_14_11))

				self._rootNode:addChild(var_14_9)

				self._allSprite[iter_14_3][iter_14_4] = var_14_9
			end

			var_14_9:setTexture(self:getGridTexture(var_14_11))
			var_14_9:setPosition(self:_gridToPos(var_14_11))
		end
	end
end

function DebugFingPath:getGridTexture(arg_15_1)
	if not self:_isInMap(arg_15_1) then
		return self._emptyTexture
	end

	if self:isDark(arg_15_1) then
		return self._darkTexture
	end

	if self:isGoal(arg_15_1) then
		return self._redTexture
	end

	if self:isStart(arg_15_1) then
		return self._whiteTexture
	end

	if self:isInPath(arg_15_1) then
		return self._greenTexture
	end

	return self._emptyTexture
end

local var_0_4 = false

function DebugFingPath:findPath(arg_16_1, arg_16_2)
	if not arg_16_1 or not arg_16_2 then
		return nil
	end

	local var_16_0 = {}
	local var_16_1 = {}

	var_0_4 = not var_0_4
	var_16_0[var_0_1(arg_16_1)] = {
		g = 0,
		x = arg_16_1.x,
		y = arg_16_1.y,
		h = self:getHeuristic(arg_16_1, arg_16_2)
	}

	while next(var_16_0) do
		local var_16_2, var_16_3 = self:getMinCostNode(var_16_0)

		if var_16_2.x == arg_16_2.x and var_16_2.y == arg_16_2.y then
			return self:backtrack(var_16_2)
		end

		var_16_0[var_16_3] = nil
		var_16_1[var_16_3] = true

		for iter_16_0, iter_16_1 in ipairs((self:getJumpPointList(var_16_2, var_16_1))) do
			local var_16_4 = var_0_1(iter_16_1)

			if not var_16_1[var_16_4] then
				local var_16_5 = var_16_2.g + KsMath.calculateDistance(var_16_2, iter_16_1)
				local var_16_6 = self:getHeuristic(iter_16_1, arg_16_2)

				if not var_16_0[iter_16_1] or var_16_5 + var_16_6 < var_16_0[var_16_4].g + var_16_0[var_16_4].h then
					var_16_0[var_16_4] = {
						x = iter_16_1.x,
						y = iter_16_1.y,
						g = var_16_5,
						h = var_16_6,
						parent = var_16_2
					}
				end
			end
		end
	end

	return nil
end

function DebugFingPath:isGoal(arg_17_1)
	if not self._goalGrid then
		return false
	end

	return self._goalGrid.x == arg_17_1.x and self._goalGrid.y == arg_17_1.y
end

function DebugFingPath:isStart(arg_18_1)
	if not self._startGrid then
		return false
	end

	return self._startGrid.x == arg_18_1.x and self._startGrid.y == arg_18_1.y
end

function DebugFingPath:isInPath(arg_19_1)
	return self._pathGridDict[var_0_1(arg_19_1)] == true
end

function DebugFingPath:getJumpPointList(arg_20_1)
	local var_20_0 = {}

	if not arg_20_1.parent then
		for iter_20_0 = 1, 4 do
			local var_20_1 = cc.p(arg_20_1.x + var_0_0[iter_20_0][1], arg_20_1.y + var_0_0[iter_20_0][2])

			while self:_isInMap(var_20_1) do
				if self:isGoal(var_20_1) then
					table.insert(var_20_0, cc.p(var_20_1.x, var_20_1.y))

					return var_20_0
				end

				if self:isDark(var_20_1) then
					break
				end

				if self:checkHVForceNeighbour(cc.p(var_20_1.x, var_20_1.y), var_0_0[iter_20_0]) then
					table.insert(var_20_0, cc.p(var_20_1.x, var_20_1.y))
				end

				if self:isGoal(var_20_1) then
					return var_20_0
				else
					var_20_1.x = var_20_1.x + var_0_0[iter_20_0][1]
					var_20_1.y = var_20_1.y + var_0_0[iter_20_0][2]
				end
			end
		end

		for iter_20_1 = 5, 8 do
			local var_20_2 = cc.p(arg_20_1.x + var_0_0[iter_20_1][1], arg_20_1.y + var_0_0[iter_20_1][2])

			while self:_isInMap(var_20_2) do
				if self:isGoal(var_20_2) then
					table.insert(var_20_0, cc.p(var_20_2.x, var_20_2.y))

					return var_20_0
				end

				if self:isDark(var_20_2) then
					break
				end

				if self:checkHVForceNeighbour(cc.p(var_20_2.x, var_20_2.y), {
					[1] = 0,
					[2] = var_0_0[iter_20_1][2]
				}) then
					table.insert(var_20_0, cc.p(var_20_2.x, var_20_2.y))

					break
				elseif self:checkHVForceNeighbour(cc.p(var_20_2.x, var_20_2.y), {
					var_0_0[iter_20_1][1],
					[2] = 0
				}) then
					table.insert(var_20_0, cc.p(var_20_2.x, var_20_2.y))

					break
				else
					var_20_2.x = var_20_2.x + var_0_0[iter_20_1][1]
					var_20_2.y = var_20_2.y + var_0_0[iter_20_1][2]
				end
			end
		end
	else
		local var_20_3 = arg_20_1.x - arg_20_1.parent.x

		if arg_20_1.x - arg_20_1.parent.x ~= 0 then
			local var_20_5 = {
				var_20_3 / math.abs(var_20_3),
				0
			}
			local var_20_6 = cc.p(arg_20_1.x + var_20_5[1], arg_20_1.y + var_20_5[2])

			while self:_isInMap(var_20_6) do
				if self:isGoal(var_20_6) then
					table.insert(var_20_0, cc.p(var_20_6.x, var_20_6.y))

					return var_20_0
				end

				if self:isDark(var_20_6) then
					break
				end

				if self:checkHVForceNeighbour(cc.p(var_20_6.x, var_20_6.y), var_20_5) then
					table.insert(var_20_0, cc.p(var_20_6.x, var_20_6.y))
				end

				if self:isGoal(var_20_6) then
					return var_20_0
				else
					var_20_6.x = var_20_6.x + var_20_5[1]
					var_20_6.y = var_20_6.y + var_20_5[2]
				end
			end
		end
	end

	return var_20_0
end

function DebugFingPath:checkHVForceNeighbour(arg_21_1, arg_21_2)
	if arg_21_2[1] ~= 0 then
		while true do
			if self:isGoal(arg_21_1) then
				return true
			end

			if self:isDark(arg_21_1) then
				break
			end

			if not self:_isInMap(arg_21_1) then
				break
			end

			local var_21_0 = {
				x = arg_21_1.x,
				y = arg_21_1.y + 1
			}

			if self:isDark(var_21_0) then
				local var_21_1 = {
					x = var_21_0.x + arg_21_2[1],
					y = var_21_0.y
				}

				if not self:isDark(var_21_1) and self:_isInMap(var_21_1) then
					return true
				end
			end

			local var_21_2 = {
				x = arg_21_1.x,
				y = arg_21_1.y - 1
			}

			if self:isDark(var_21_2) then
				local var_21_3 = {
					x = var_21_2.x + arg_21_2[1],
					y = var_21_2.y
				}

				if not self:isDark(var_21_3) and self:_isInMap(var_21_3) then
					return true
				end
			end

			arg_21_1.x = arg_21_1.x + arg_21_2[1]
		end
	elseif arg_21_2[2] ~= 0 then
		while true do
			if self:isGoal(arg_21_1) then
				return true
			end

			if self:isDark(arg_21_1) then
				break
			end

			if not self:_isInMap(arg_21_1) then
				break
			end

			local var_21_4 = {
				x = arg_21_1.x + 1,
				y = arg_21_1.y
			}

			if self:isDark(var_21_4) then
				local var_21_5 = {
					x = var_21_4.x,
					y = arg_21_1.y + arg_21_2[2]
				}

				if not self:isDark(var_21_5) and self:_isInMap(var_21_5) then
					return true
				end
			end

			local var_21_6 = {
				x = arg_21_1.x - 1,
				y = arg_21_1.y
			}

			if self:isDark(var_21_6) then
				local var_21_7 = {
					x = var_21_6.x,
					y = arg_21_1.y + arg_21_2[2]
				}

				if not self:isDark(var_21_7) and self:_isInMap(var_21_7) then
					return true
				end
			end

			arg_21_1.y = arg_21_1.y + arg_21_2[2]
		end
	end

	return false
end

function DebugFingPath:getMinCostNode(arg_22_1)
	local var_22_0

	for iter_22_0, iter_22_1 in pairs(arg_22_1) do
		local var_22_1, var_22_2

		if iter_22_1.g + iter_22_1.h < math.huge then
			var_22_1 = iter_22_1.g + iter_22_1.h
			var_22_0 = iter_22_1
			var_22_2 = iter_22_0
		end
	end

	return var_22_0, nil
end

function DebugFingPath:getHeuristic(arg_23_1, arg_23_2)
	return KsMath.calculateDistance2(arg_23_1, arg_23_2)
end

function DebugFingPath:backtrack(arg_24_1)
	local var_24_0 = {}

	while arg_24_1 do
		table.insert(var_24_0, 1, {
			x = arg_24_1.x,
			y = arg_24_1.y
		})

		arg_24_1 = arg_24_1.parent
	end

	return var_24_0
end

return DebugFingPath
