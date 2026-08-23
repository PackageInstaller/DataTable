local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local var_0_1 = g.core.model.User.echoLabData
local EchoLabTreeLineConfig = require("app.view.module.echoLab.const.EchoLabTreeLineConfig")
local var_0_3 = math.floor(display.width / EchoLabTreeLineConfig.maxWidthLine)
local var_0_4 = 30
local var_0_5 = 442
local EchoLabTreeScrollComp = class("EchoLabTreeScrollComp", require("app.fairyGUI.echoLab.UI_EchoLabTreeScrollComp"))

function EchoLabTreeScrollComp:ctor()
	self._treeData = var_0_1:getTreeData()
	self._allPlaceCompDict = {}
	self._curShowIconDict = {}
	self._allColDataList = {}
	self._lastPos = -display.width
	self._scrollComp = self:getScrollPane()
	self._finalPlaceComp = nil
	self._maxPosWidth = 0
	self._hasCanUpdate = true
	self._iconPool = NodePool.new(self, "echoLab", "EchoLabTreeTalentComp", var_0_4)
	self._linePool = NodePool.new(self, "echoLab", "EchoLabTreeLineComp", var_0_4)
	self._clickId = 0

	self:initScrollComp()
	self:initView()
end

function EchoLabTreeScrollComp:onClickIcon(arg_2_1, arg_2_2)
	local var_2_0 = self._treeData:getTalentById(self._clickId)

	if var_2_0 then
		local var_2_1 = self:getIconComp(var_2_0:getGridX(), var_2_0:getGridY())

		if var_2_1 then
			var_2_1:setClickState(false)
		end
	end

	local var_2_2 = self._treeData:getTalentById(arg_2_1.id)

	if var_2_2 then
		self._clickId = arg_2_1.id

		local var_2_3 = self:getIconComp(var_2_2:getGridX(), var_2_2:getGridY())

		if not var_2_3 then
			return
		end

		var_2_3:setClickState(true)

		if arg_2_2 then
			self:dispatchCompEvent("scrollComp_show_info", {
				id = arg_2_1.id
			})
		else
			local var_2_4 = var_2_3:displayObject()
			local var_2_5 = var_2_4:convertToWorldSpace(cc.p(0, 0)).x
			local var_2_6 = var_2_3:getWidth()
			local var_2_7 = display.width - var_2_4 - var_2_3:getNextLineWidth()

			if var_2_7 <= var_2_5 then
				self._scrollComp:setPosX(var_2_3:getX() - var_2_7)

				var_2_5 = var_2_7
			elseif var_2_5 <= var_2_6 / 2 then
				self._scrollComp:setPosX(var_2_3:getX() - var_2_6)

				var_2_5 = var_2_6
			end

			self:dispatchCompEvent("scrollComp_show_info", {
				id = arg_2_1.id,
				compWorldPosX = var_2_5
			})

			if (display.width - var_0_5) / 2 < var_2_5 then
				self:setScrollPosX(((display.width - var_0_5) / 2 - var_2_5 < display.width - var_0_5 - display.width or nil) and display.width - var_0_5 + 30 - display.width, true)
			end
		end
	end
end

function EchoLabTreeScrollComp:getIconComp(arg_3_1, arg_3_2)
	return ((self._curShowIconDict[arg_3_1] or nil) and self._curShowIconDict[arg_3_1][arg_3_2]).comp
end

function EchoLabTreeScrollComp:initScrollComp()
	local var_4_0 = self._treeData:getTalentSortList()
	local var_4_1 = #var_4_0 * EchoLabTreeLineConfig.maxWidthLine
	local var_4_2 = EchoLabTreeLineConfig.maxWidthLine
	local var_4_3 = EchoLabTreeLineConfig.maxWidthLine

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_4 = iter_4_1:getGridX()
		local var_4_5

		if var_4_4 ~= 0 then
			var_4_5 = var_4_4
			var_4_2 = var_4_2 + iter_4_1:getPreLineWidth()
			var_4_3 = var_4_2
			var_4_2 = var_4_2 + iter_4_1:getNextLineWidth()
		end

		local var_4_6 = EchoLabTreeLineConfig.heightY[iter_4_1:getGridY()]
		local var_4_7 = fgui.GComponent:create()

		self:addChild(var_4_7)
		var_4_7:setSize(1, 1)
		var_4_7:setPosition(var_4_3, var_4_6)

		if not iter_4_1:isActive() and var_4_3 <= var_4_1 then
			var_4_1 = var_4_3
		end

		self._allPlaceCompDict[var_4_4] = self._allPlaceCompDict[var_4_4] or {}
		self._allPlaceCompDict[var_4_4][iter_4_1:getGridY()] = var_4_7
		self._allColDataList[iter_4_0] = {
			gridX = var_4_4,
			posX = var_4_3
		}
	end

	local var_4_8 = fgui.GComponent:create()

	self._finalPlaceComp = var_4_8

	self:addChild(var_4_8)
	var_4_8:setSize(1, 1)

	self._maxPosWidth = var_4_2 + EchoLabTreeLineConfig.maxWidthLine

	var_4_8:setPosition(self._maxPosWidth, display.cy)
	self._scrollComp:setPosX(math.max(0, var_4_1 - display.cx))
	self._scrollComp:setMouseWheelEnabled(false)
end

function EchoLabTreeScrollComp:setScrollPosX(arg_5_1, arg_5_2)
	local var_5_0 = self._scrollComp:getPosX() - arg_5_1

	if var_5_0 > self._maxPosWidth - display.width then
		self._hasCanUpdate = false

		self._finalPlaceComp:setX(self._maxPosWidth + display.width)
		self._scrollComp:setPosX(var_5_0, arg_5_2)
	else
		self._hasCanUpdate = true

		self:resetScrollPane()
		self._scrollComp:setPosX(var_5_0, arg_5_2)
	end
end

function EchoLabTreeScrollComp:resetScrollPane()
	self._finalPlaceComp:setX(self._maxPosWidth)
	self._scrollComp:setPosX(self._scrollComp:getPosX(), false)

	self._hasCanUpdate = true

	self:_onScrollPanel(nil, true)
end

function EchoLabTreeScrollComp:initView()
	self:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScrollPanel))

	local var_7_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_7_0.x > 0 then
		var_0_5 = var_0_5 + var_7_0.x
	end
end

function EchoLabTreeScrollComp:updateScrollView()
	self:_onScrollPanel()
end

function EchoLabTreeScrollComp:_onScrollPanel(arg_9_1, arg_9_2)
	local var_9_0 = self._scrollComp:getPosX() + display.cx

	if not arg_9_2 then
		if not self._hasCanUpdate then
			return
		end

		if math.abs(self._lastPos - var_9_0) < EchoLabTreeLineConfig.maxWidthLine * 2 then
			return
		end
	end

	self._lastPos = var_9_0

	local var_9_1 = self:getCenterGridX(var_9_0, 1, #self._allColDataList)

	for iter_9_0, iter_9_1 in pairs(self._curShowIconDict) do
		if math.abs(var_9_1 - iter_9_0) > var_0_3 then
			for iter_9_2, iter_9_3 in pairs(iter_9_1) do
				self._iconPool:recoveryCompInPool(iter_9_3.comp)
				self._linePool:recoveryCompInPool(iter_9_3.line)
			end

			self._curShowIconDict[iter_9_0] = nil
		end
	end

	for iter_9_4 = var_9_1 - var_0_3, var_9_1 + var_0_3 do
		if self._allPlaceCompDict[iter_9_4] and not self._curShowIconDict[iter_9_4] then
			self._curShowIconDict[iter_9_4] = {}

			for iter_9_5, iter_9_6 in pairs(self._allPlaceCompDict[iter_9_4]) do
				local var_9_2 = self._iconPool:takeOutCompInPool()
				local var_9_3 = self._linePool:takeOutCompInPool()

				self._curShowIconDict[iter_9_4][iter_9_5] = {
					comp = var_9_2,
					line = var_9_3
				}

				self.m_iconParent:addChild(var_9_2)
				self.m_lineParent:addChild(var_9_3)

				local var_9_4 = iter_9_6:getPosition()

				var_9_2:setPosition(var_9_4)
				var_9_3:setPosition(var_9_4)

				local var_9_5 = self._treeData:getTalentByXY(iter_9_4, iter_9_5)

				var_9_2:updateCompByStruct(var_9_5, self._clickId)
				var_9_3:updateCompByStruct(var_9_5)
			end
		end
	end
end

function EchoLabTreeScrollComp:getCenterGridX(arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = math.floor((arg_10_3 + arg_10_2) / 2)
	local var_10_1 = false

	if self._allColDataList[var_10_0] then
		if math.abs(self._allColDataList[var_10_0].posX - arg_10_1) <= EchoLabTreeLineConfig.maxWidthLine then
			return self._allColDataList[var_10_0].gridX
		end

		var_10_1 = self._allColDataList[var_10_0].posX < arg_10_1
	end

	if self._allColDataList[var_10_0 + 1] then
		if math.abs(self._allColDataList[var_10_0 + 1].posX - arg_10_1) <= EchoLabTreeLineConfig.maxWidthLine then
			return self._allColDataList[var_10_0 + 1].gridX
		end

		var_10_1 = self._allColDataList[var_10_0 + 1].posX < arg_10_1
	end

	if arg_10_3 - arg_10_2 <= 1 then
		return arg_10_2
	end

	return self:getCenterGridX(arg_10_1, var_10_1 and var_10_0 or arg_10_2, var_10_1 and arg_10_3 or var_10_0)
end

function EchoLabTreeScrollComp:onS2CTalentActive(arg_11_1)
	for iter_11_0, iter_11_1 in pairs(self._curShowIconDict) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			iter_11_3.comp:refreshComp(arg_11_1:getId())
			iter_11_3.line:refreshComp()
		end
	end
end

function EchoLabTreeScrollComp:checkCompIsClick(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(self._curShowIconDict) do
		for iter_12_2, iter_12_3 in pairs(iter_12_1) do
			local var_12_0 = iter_12_3.comp:displayObject():convertToWorldSpace(cc.p(0, 0)).x

			if var_12_0 <= -iter_12_3.comp:getWidth() or arg_12_2 <= var_12_0 then
				break
			end

			if iter_12_3.comp:containPoint(arg_12_1) then
				return iter_12_3.comp:getId()
			end
		end
	end

	return 0
end

function EchoLabTreeScrollComp:onRemoved()
	self._iconPool:clearPool()

	self._iconPool = nil
end

return EchoLabTreeScrollComp
