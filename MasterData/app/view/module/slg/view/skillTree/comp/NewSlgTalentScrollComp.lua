local NewSlgLineConfig = require("app.view.module.slg.const.NewSlgLineConfig")
local var_0_1 = 442
local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local NewSlgTalentScrollComp = class("NewSlgTalentScrollComp", require("app.fairyGUI.newSlg.UI_NewSlgTalentScrollComp"))

function NewSlgTalentScrollComp:ctor()
	self._treeType = 1
	self._curShowIconDict = {}
	self._allTalentPosData = {}
	self._allColDataList = {}
	self._lastPos = -display.width
	self._scrollComp = self:getScrollPane()
	self._finalPlaceComp = nil
	self._maxPosWidth = 0
	self._hasCanUpdate = true
	self._iconPool = NodePool.new(self, "newSlg", "NewSlgTalentComp", 30)
	self._linePool = NodePool.new(self, "newSlg", "NewSlgTalentLine", 30)
	self._clickId = 0
	self._treeData = nil

	self:initView()
end

function NewSlgTalentScrollComp:setNewSlgSkillTreeType(arg_2_1)
	self._treeType = arg_2_1
end

function NewSlgTalentScrollComp:setNewSlgSkillTreeData(arg_3_1)
	self._treeData = arg_3_1

	self:_updateScrollComp()
end

function NewSlgTalentScrollComp:initView()
	self:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScrollPanel))

	local var_4_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_4_0.x > 0 then
		var_0_1 = var_0_1 + var_4_0.x
	end
end

function NewSlgTalentScrollComp:_onScrollPanel(arg_5_1, arg_5_2)
	local var_5_0 = self._scrollComp:getPosX() + display.cx

	if not arg_5_2 then
		if not self._hasCanUpdate then
			return
		end

		if math.abs(self._lastPos - var_5_0) < NewSlgLineConfig.maxWidthLine * 2 then
			return
		end
	end

	self._lastPos = var_5_0

	for iter_5_0, iter_5_1 in pairs(self._curShowIconDict) do
		if math.abs(self._allTalentPosData[iter_5_0].posX - var_5_0) >= display.width then
			self._iconPool:recoveryCompInPool(iter_5_1.iconComp)
			self._linePool:recoveryCompInPool(iter_5_1.lineComp)

			self._curShowIconDict[iter_5_0] = nil
		end
	end

	local var_5_1 = self:getCenterGridX(var_5_0, 1, #self._allColDataList)
	local var_5_2 = self._treeData:getTalentXList(self._treeType)

	for iter_5_2 = var_5_1, 1, -1 do
		local var_5_3 = true

		for iter_5_3, iter_5_4 in ipairs(var_5_2[iter_5_2] or {}) do
			local var_5_4 = self._allTalentPosData[iter_5_4:getId()]

			var_5_3 = math.abs(var_5_4.posX - var_5_0) >= display.width

			if not var_5_3 and not self._curShowIconDict[iter_5_4:getId()] then
				local var_5_5 = self._iconPool:takeOutCompInPool()

				var_5_5:setPosition(var_5_4.posX, var_5_4.posY)
				var_5_5:updateCompByStruct(iter_5_4, self._clickId)
				var_5_5:setName("talent_" .. iter_5_4:getId())
				self.m_iconParent:addChild(var_5_5)

				local var_5_6 = self._linePool:takeOutCompInPool()

				var_5_6:setPosition(var_5_4.posX, var_5_4.posY)
				var_5_6:updateCompByStruct(iter_5_4)
				self.m_lineParent:addChild(var_5_6)

				self._curShowIconDict[iter_5_4:getId()] = {
					iconComp = var_5_5,
					lineComp = var_5_6
				}
			end
		end

		if var_5_3 then
			break
		end
	end

	for iter_5_5 = var_5_1 + 1, #var_5_2 do
		local var_5_7 = true

		for iter_5_6, iter_5_7 in ipairs(var_5_2[iter_5_5] or {}) do
			local var_5_8 = self._allTalentPosData[iter_5_7:getId()]

			var_5_7 = math.abs(var_5_8.posX - var_5_0) >= display.width

			if not var_5_7 and not self._curShowIconDict[iter_5_7:getId()] then
				local var_5_9 = self._iconPool:takeOutCompInPool()

				var_5_9:setPosition(var_5_8.posX, var_5_8.posY)
				var_5_9:updateCompByStruct(iter_5_7, self._clickId)
				var_5_9:setName("talent_" .. iter_5_7:getId())
				self.m_iconParent:addChild(var_5_9)

				local var_5_10 = self._linePool:takeOutCompInPool()

				var_5_10:setPosition(var_5_8.posX, var_5_8.posY)
				var_5_10:updateCompByStruct(iter_5_7)
				self.m_lineParent:addChild(var_5_10)

				self._curShowIconDict[iter_5_7:getId()] = {
					iconComp = var_5_9,
					lineComp = var_5_10
				}
			end
		end

		if var_5_7 then
			break
		end
	end
end

function NewSlgTalentScrollComp:getCenterGridX(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = math.floor((arg_6_3 + arg_6_2) / 2)
	local var_6_1 = false

	if self._allColDataList[var_6_0] then
		if math.abs(self._allColDataList[var_6_0].posX - arg_6_1) <= NewSlgLineConfig.maxWidthLine then
			return self._allColDataList[var_6_0].gridX
		end

		var_6_1 = self._allColDataList[var_6_0].posX < arg_6_1
	end

	if self._allColDataList[var_6_0 + 1] then
		if math.abs(self._allColDataList[var_6_0 + 1].posX - arg_6_1) <= NewSlgLineConfig.maxWidthLine then
			return self._allColDataList[var_6_0 + 1].gridX
		end

		var_6_1 = self._allColDataList[var_6_0 + 1].posX < arg_6_1
	end

	if arg_6_3 - arg_6_2 <= 1 then
		return arg_6_2
	end

	return self:getCenterGridX(arg_6_1, var_6_1 and var_6_0 or arg_6_2, var_6_1 and arg_6_3 or var_6_0)
end

function NewSlgTalentScrollComp:_updateScrollComp()
	self._allTalentPosData = {}
	self._allColDataList = {}

	local var_7_0 = 0
	local var_7_1 = NewSlgLineConfig.maxWidthLine

	for iter_7_0, iter_7_1 in ipairs((self._treeData:getTalentXList(self._treeType))) do
		var_7_1 = var_7_1 + iter_7_1[1]:getPreLineWidth()
		var_7_1 = var_7_1 + iter_7_1[1]:getNextLineWidth()
		self._allColDataList[iter_7_0] = {
			gridX = iter_7_0,
			posX = var_7_1
		}

		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			self._allTalentPosData[iter_7_3:getId()] = {
				posX = var_7_1,
				posY = NewSlgLineConfig.heightY[iter_7_3:getInfo().pot_location],
				talentStruct = iter_7_3
			}

			if iter_7_3:isActive() then
				var_7_0 = var_7_1
			end
		end
	end

	if not self._finalPlaceComp then
		local var_7_4 = fgui.GComponent:create()

		self._finalPlaceComp = var_7_4

		self:addChild(var_7_4)
	end

	self._maxPosWidth = var_7_1 + NewSlgLineConfig.maxWidthLine

	self._finalPlaceComp:setPosition(self._maxPosWidth, display.cy)
	self._scrollComp:setPosX(math.max(1, var_7_0 - display.cx))
	self._scrollComp:setMouseWheelEnabled(false)
end

function NewSlgTalentScrollComp:updateScrollView()
	for iter_8_0, iter_8_1 in pairs(self._curShowIconDict) do
		iter_8_1.iconComp:refreshComp()
		iter_8_1.lineComp:refreshComp()
	end
end

function NewSlgTalentScrollComp:onClickIcon(arg_9_1, arg_9_2)
	local var_9_0 = self._treeData:getTalentById(self._clickId, nil, self._treeType)

	if var_9_0 then
		local var_9_1 = self:getIconComp(var_9_0)

		if var_9_1 then
			var_9_1:setClickState(false)
		end
	end

	local var_9_2 = self._treeData:getTalentById(arg_9_1.id, nil, self._treeType)

	if var_9_2 then
		self._clickId = arg_9_1.id

		local var_9_3 = self:getIconComp(var_9_2)

		if not var_9_3 then
			return
		end

		var_9_3:setClickState(true)

		if arg_9_2 then
			self:dispatchCompEvent("NewSlgTalentScrollComp_scrollComp_show_info", {
				id = arg_9_1.id
			})
		else
			local var_9_4 = var_9_3:displayObject()
			local var_9_5 = var_9_4:convertToWorldSpace(cc.p(0, 0)).x
			local var_9_6 = var_9_3:getWidth()
			local var_9_7 = display.width - var_9_6 - var_9_3:getNextLineWidth()

			if var_9_7 <= var_9_4 then
				self._scrollComp:setPosX(var_9_3:getX() - var_9_7)

				var_9_5 = var_9_7
			elseif var_9_5 <= var_9_6 / 2 then
				self._scrollComp:setPosX(var_9_3:getX() - var_9_6)

				var_9_5 = var_9_6
			end

			self:dispatchCompEvent("NewSlgTalentScrollComp_scrollComp_show_info", {
				id = arg_9_1.id,
				compWorldPosX = var_9_5
			})

			if (display.width - var_0_1) / 2 < var_9_5 then
				self:setScrollPosX(((display.width - var_0_1) / 2 - var_9_5 < display.width - var_0_1 - display.width or nil) and display.width - var_0_1 + 30 - display.width, true)
			end
		end
	end
end

function NewSlgTalentScrollComp:getIconComp(arg_10_1)
	if self._curShowIconDict[arg_10_1:getId()] then
		return self._curShowIconDict[arg_10_1:getId()].iconComp
	end

	return nil
end

function NewSlgTalentScrollComp:setScrollPosX(arg_11_1, arg_11_2)
	local var_11_0 = self._scrollComp:getPosX() - arg_11_1

	if var_11_0 > self._maxPosWidth - display.width then
		self._hasCanUpdate = false

		self._finalPlaceComp:setX(self._maxPosWidth + display.width)
		self._scrollComp:setPosX(var_11_0, arg_11_2)
	else
		self._hasCanUpdate = true

		self:resetScrollPane()
		self._scrollComp:setPosX(var_11_0, arg_11_2)
	end
end

function NewSlgTalentScrollComp:resetScrollPane()
	if self._finalPlaceComp then
		self._finalPlaceComp:setX(self._maxPosWidth)
		self._scrollComp:setPosX(self._scrollComp:getPosX(), true)

		self._hasCanUpdate = true

		self:_onScrollPanel(nil, true)
	end
end

function NewSlgTalentScrollComp:checkCompIsClick(arg_13_1, arg_13_2)
	for iter_13_0, iter_13_1 in pairs(self._curShowIconDict) do
		local var_13_0 = iter_13_1.iconComp:displayObject()

		if var_13_0 >= -iter_13_1.iconComp:getWidth() and var_13_0:convertToWorldSpace(cc.p(0, 0)).x <= arg_13_2 and iter_13_1.iconComp:containPoint(arg_13_1) then
			return iter_13_1.iconComp:getId()
		end
	end

	return 0
end

function NewSlgTalentScrollComp:onS2CTalentActive(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1 or {}) do
		if self._curShowIconDict[iter_14_1] then
			self._curShowIconDict[iter_14_1].iconComp:showActiveEff()
		end
	end
end

return NewSlgTalentScrollComp
