local PathInPolygon = require("app.core.utils.PathInPolygon")
local DebugMarblesPathComp = class("DebugMarblesPathComp", require("app.fairyGUI.debug.UI_DebugMarblesPathComp"))

function DebugMarblesPathComp:ctor()
	self._width = self.m_marbleComp:getWidth()
	self._height = self.m_marbleComp:getHeight()
	self._startX = 450
	self._startY = 20
	self._pathList = {}
	self._lineList = {}
	self._kuangList = {
		{
			from = {
				x = 0,
				y = 0
			},
			to = {
				y = 0,
				x = self._width
			}
		},
		{
			from = {
				x = 0,
				y = 0
			},
			to = {
				x = 0,
				y = self._height
			}
		},
		{
			from = {
				y = 0,
				x = self._width
			},
			to = {
				x = self._width,
				y = self._height
			}
		},
		{
			isFinal = true,
			from = {
				x = 0,
				y = self._height
			},
			to = {
				x = self._width,
				y = self._height
			}
		}
	}
	self._circleList = {
		{
			x = 200,
			radius = 8,
			y = 50
		},
		{
			x = 400,
			radius = 8,
			y = 50
		},
		{
			x = 600,
			radius = 8,
			y = 50
		},
		{
			x = 800,
			radius = 8,
			y = 50
		},
		{
			x = 100,
			radius = 12,
			y = 100
		},
		{
			x = 300,
			radius = 12,
			y = 100
		},
		{
			x = 500,
			radius = 12,
			y = 100
		},
		{
			x = 700,
			radius = 12,
			y = 100
		},
		{
			x = 200,
			radius = 8,
			y = 150
		},
		{
			x = 400,
			radius = 8,
			y = 150
		},
		{
			x = 600,
			radius = 8,
			y = 150
		},
		{
			x = 800,
			radius = 8,
			y = 150
		},
		{
			x = 100,
			radius = 12,
			y = 200
		},
		{
			x = 300,
			radius = 12,
			y = 200
		},
		{
			x = 500,
			radius = 12,
			y = 200
		},
		{
			x = 700,
			radius = 12,
			y = 200
		},
		{
			x = 200,
			radius = 8,
			y = 250
		},
		{
			x = 400,
			radius = 8,
			y = 250
		},
		{
			x = 600,
			radius = 8,
			y = 250
		},
		{
			x = 800,
			radius = 8,
			y = 250
		},
		{
			x = 100,
			radius = 12,
			y = 300
		},
		{
			x = 300,
			radius = 12,
			y = 300
		},
		{
			x = 500,
			radius = 12,
			y = 300
		},
		{
			x = 700,
			radius = 12,
			y = 300
		},
		{
			x = 200,
			radius = 8,
			y = 350
		},
		{
			x = 400,
			radius = 8,
			y = 350
		},
		{
			x = 600,
			radius = 8,
			y = 350
		},
		{
			x = 800,
			radius = 8,
			y = 350
		},
		{
			x = 100,
			radius = 12,
			y = 400
		},
		{
			x = 300,
			radius = 12,
			y = 400
		},
		{
			x = 500,
			radius = 12,
			y = 400
		},
		{
			x = 700,
			radius = 12,
			y = 400
		},
		{
			x = 200,
			radius = 8,
			y = 450
		},
		{
			x = 400,
			radius = 8,
			y = 450
		},
		{
			x = 600,
			radius = 8,
			y = 450
		},
		{
			x = 800,
			radius = 8,
			y = 450
		}
	}
	self._pathInPolygon = PathInPolygon.new({
		mapId = 0
	})

	self:_initView()
	self:_initCircleDots()
end

function DebugMarblesPathComp:onLoad()
	return
end

function DebugMarblesPathComp:onUnload()
	return
end

function DebugMarblesPathComp:_initView()
	self.m_marbleComp:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_marbleComp:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_marbleComp:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self.m_resetBtn:addClickListener(handler(self, self._onResetClick))
	self.m_randomBtn:addClickListener(handler(self, self._onRandomClick))
end

function DebugMarblesPathComp:_initCircleDots()
	for iter_5_0 = 1, #self._circleList do
		local var_5_0 = fgui.UIPackage:createObject("debug", "DebugCircleComp")

		var_5_0:setPosition(self._circleList[iter_5_0].x, self._circleList[iter_5_0].y)
		var_5_0:setSize(self._circleList[iter_5_0].radius * 2, self._circleList[iter_5_0].radius * 2)
		self.m_marbleComp:addChild(var_5_0)
	end
end

function DebugMarblesPathComp:calculateLinePath(arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_2 then
		return false
	end

	local var_6_0 = {}

	for iter_6_0 = 1, #self._circleList do
		local var_6_1, var_6_2 = self._pathInPolygon:getPointToRayCross(arg_6_1, arg_6_2, self._circleList[iter_6_0])

		if var_6_1 then
			table.insert(var_6_0, var_6_2)
		end
	end

	for iter_6_1 = 1, #self._kuangList do
		local var_6_3, var_6_4 = self._pathInPolygon:getLineToRayCross(arg_6_1, arg_6_2, self._kuangList[iter_6_1])

		if var_6_3 then
			table.insert(var_6_0, var_6_4)
		end
	end

	if #var_6_0 == 0 then
		dump("errrrrrrrrrrrrrrrrrrror no cross")

		return false
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.crossLen < arg_7_1.crossLen
	end)
	table.insert(self._pathList, var_6_0[1].crossPoint)

	if var_6_0[1].circlePoint then
		local var_6_5, var_6_6 = self._pathInPolygon:getReflectToByCircle(arg_6_1, var_6_0[1].crossPoint, var_6_0[1].circlePoint)

		return self:calculateLinePath(var_6_5, var_6_6)
	elseif var_6_0[1].line then
		if var_6_0[1].line.isFinal then
			return false
		else
			local var_6_7, var_6_8 = self._pathInPolygon:getReflectToByLine(arg_6_1, var_6_0[1].crossPoint, var_6_0[1].line)

			return self:calculateLinePath(var_6_7, var_6_8)
		end
	end
end

function DebugMarblesPathComp:_onTouchBegin(arg_8_1)
	arg_8_1:captureTouch()

	local var_8_0 = arg_8_1:getInput():getPosition()
	local var_8_1 = self.m_marbleComp:getPosition()

	self._startX = var_8_0.x - var_8_1.x
	self._startY = var_8_0.y - var_8_1.y
end

function DebugMarblesPathComp:_onTouchMove(arg_9_1)
	local var_9_0 = arg_9_1:getInput():getPosition()
end

function DebugMarblesPathComp:_onTouchEnd(arg_10_1)
	local var_10_0 = arg_10_1:getInput():getPosition()
	local var_10_1 = self.m_marbleComp:getPosition()

	self:generatePathList({
		x = var_10_0.x - var_10_1.x,
		y = var_10_0.y - var_10_1.y
	})
end

function DebugMarblesPathComp:generatePathList(arg_11_1)
	if not arg_11_1 then
		return
	end

	for iter_11_0 = 1, #self._lineList do
		self._lineList[iter_11_0]:removeFromParent()
	end

	self._pathList = {}
	self._lineList = {}

	local var_11_0 = {
		x = self._startX,
		y = self._startY
	}

	table.insert(self._pathList, var_11_0)
	self:calculateLinePath(var_11_0, arg_11_1)

	for iter_11_1 = 1, #self._pathList - 1 do
		local var_11_1 = self._pathInPolygon:getTwoPointLength(self._pathList[iter_11_1], self._pathList[iter_11_1 + 1])
		local var_11_2 = self._pathInPolygon:getAngelByFromTo(self._pathList[iter_11_1], self._pathList[iter_11_1 + 1])
		local var_11_3 = fgui.UIPackage:createObject("debug", "DebugLineComp")

		var_11_3:setPosition(self._pathList[iter_11_1].x, self._pathList[iter_11_1].y)
		var_11_3:setSize(var_11_1, 1)
		var_11_3:setRotation(var_11_2)
		self.m_marbleComp:addChild(var_11_3)
		table.insert(self._lineList, var_11_3)
	end
end

function DebugMarblesPathComp:_onResetClick()
	for iter_12_0 = 1, #self._lineList do
		self._lineList[iter_12_0]:removeFromParent()
	end

	self._lineList = {}
end

function DebugMarblesPathComp:_onRandomClick()
	self:generatePathList({
		x = self._startX + math.random(-100, 100),
		y = self._startY + math.random(-100, 100)
	})
end

return DebugMarblesPathComp
