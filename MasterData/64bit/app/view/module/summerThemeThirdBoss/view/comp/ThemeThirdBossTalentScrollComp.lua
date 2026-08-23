local ThemeThirdBossLineConfig = require("app.view.module.summerThemeThirdBoss.const.ThemeThirdBossLineConfig")
local var_0_1 = 442
local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local ThemeThirdBossTalentScrollComp = class("ThemeThirdBossTalentScrollComp", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossTalentScrollComp"))

function ThemeThirdBossTalentScrollComp:ctor()
	self._curShowIconDict = {}
	self._allTalentPosData = {}
	self._allColDataList = {}
	self._lastPos = -display.width
	self._scrollComp = self:getScrollPane()
	self._finalPlaceComp = nil
	self._maxPosWidth = 0
	self._hasCanUpdate = true
	self._iconPool = NodePool.new(self, "summerThemeThirdBoss", "ThemeThirdBossTalentComp", 30)
	self._linePool = NodePool.new(self, "summerThemeThirdBoss", "ThemeThirdBossTalentLine", 30)
	self._clickId = 0
	self._treeData = nil

	self:initView()
end

function ThemeThirdBossTalentScrollComp:setThemeBossData(arg_2_1)
	self._treeData = arg_2_1

	self:_updateScrollComp()
end

function ThemeThirdBossTalentScrollComp:initView()
	self:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScrollPanel))

	local var_3_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_3_0.x > 0 then
		var_0_1 = var_0_1 + var_3_0.x
	end
end

function ThemeThirdBossTalentScrollComp:_onScrollPanel(arg_4_1, arg_4_2)
	local var_4_0 = self._scrollComp:getPosX() + display.cx

	if not arg_4_2 then
		if not self._hasCanUpdate then
			return
		end

		if math.abs(self._lastPos - var_4_0) < ThemeThirdBossLineConfig.maxWidthLine * 2 then
			return
		end
	end

	self._lastPos = var_4_0

	for iter_4_0, iter_4_1 in pairs(self._curShowIconDict) do
		if math.abs(self._allTalentPosData[iter_4_0].posX - var_4_0) >= display.width then
			self._iconPool:recoveryCompInPool(iter_4_1.iconComp)
			self._linePool:recoveryCompInPool(iter_4_1.lineComp)

			self._curShowIconDict[iter_4_0] = nil
		end
	end

	local var_4_1 = self:getCenterGridX(var_4_0, 1, #self._allColDataList)
	local var_4_2 = self._treeData:getTalentXList()

	for iter_4_2 = var_4_1, 1, -1 do
		local var_4_3 = true

		for iter_4_3, iter_4_4 in ipairs(var_4_2[iter_4_2] or {}) do
			local var_4_4 = self._allTalentPosData[iter_4_4:getId()]

			var_4_3 = math.abs(var_4_4.posX - var_4_0) >= display.width

			if not var_4_3 and not self._curShowIconDict[iter_4_4:getId()] then
				local var_4_5 = self._iconPool:takeOutCompInPool()

				var_4_5:setPosition(var_4_4.posX, var_4_4.posY)
				var_4_5:updateCompByStruct(iter_4_4, self._clickId)
				self.m_iconParent:addChild(var_4_5)

				local var_4_6 = self._linePool:takeOutCompInPool()

				var_4_6:setPosition(var_4_4.posX, var_4_4.posY)
				var_4_6:updateCompByStruct(iter_4_4)
				self.m_lineParent:addChild(var_4_6)

				self._curShowIconDict[iter_4_4:getId()] = {
					iconComp = var_4_5,
					lineComp = var_4_6
				}
			end
		end

		if var_4_3 then
			break
		end
	end

	for iter_4_5 = var_4_1 + 1, #var_4_2 do
		local var_4_7 = true

		for iter_4_6, iter_4_7 in ipairs(var_4_2[iter_4_5] or {}) do
			local var_4_8 = self._allTalentPosData[iter_4_7:getId()]

			var_4_7 = math.abs(var_4_8.posX - var_4_0) >= display.width

			if not var_4_7 and not self._curShowIconDict[iter_4_7:getId()] then
				local var_4_9 = self._iconPool:takeOutCompInPool()

				var_4_9:setPosition(var_4_8.posX, var_4_8.posY)
				var_4_9:updateCompByStruct(iter_4_7, self._clickId)
				self.m_iconParent:addChild(var_4_9)

				local var_4_10 = self._linePool:takeOutCompInPool()

				var_4_10:setPosition(var_4_8.posX, var_4_8.posY)
				var_4_10:updateCompByStruct(iter_4_7)
				self.m_lineParent:addChild(var_4_10)

				self._curShowIconDict[iter_4_7:getId()] = {
					iconComp = var_4_9,
					lineComp = var_4_10
				}
			end
		end

		if var_4_7 then
			break
		end
	end
end

function ThemeThirdBossTalentScrollComp:getCenterGridX(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = math.floor((arg_5_3 + arg_5_2) / 2)
	local var_5_1 = false

	if self._allColDataList[var_5_0] then
		if math.abs(self._allColDataList[var_5_0].posX - arg_5_1) <= ThemeThirdBossLineConfig.maxWidthLine then
			return self._allColDataList[var_5_0].gridX
		end

		var_5_1 = self._allColDataList[var_5_0].posX < arg_5_1
	end

	if self._allColDataList[var_5_0 + 1] then
		if math.abs(self._allColDataList[var_5_0 + 1].posX - arg_5_1) <= ThemeThirdBossLineConfig.maxWidthLine then
			return self._allColDataList[var_5_0 + 1].gridX
		end

		var_5_1 = self._allColDataList[var_5_0 + 1].posX < arg_5_1
	end

	if arg_5_3 - arg_5_2 <= 1 then
		return arg_5_2
	end

	return self:getCenterGridX(arg_5_1, var_5_1 and var_5_0 or arg_5_2, var_5_1 and arg_5_3 or var_5_0)
end

function ThemeThirdBossTalentScrollComp:_updateScrollComp()
	self._allTalentPosData = {}
	self._allColDataList = {}

	local var_6_0 = 0
	local var_6_1 = ThemeThirdBossLineConfig.maxWidthLine

	for iter_6_0, iter_6_1 in ipairs((self._treeData:getTalentXList())) do
		var_6_1 = var_6_1 + iter_6_1[1]:getPreLineWidth()
		var_6_1 = var_6_1 + iter_6_1[1]:getNextLineWidth()
		self._allColDataList[iter_6_0] = {
			gridX = iter_6_0,
			posX = var_6_1
		}

		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			self._allTalentPosData[iter_6_3:getId()] = {
				posX = var_6_1,
				posY = ThemeThirdBossLineConfig.heightY[iter_6_3:getInfo().pot_location],
				talentStruct = iter_6_3
			}

			if iter_6_3:isActive() then
				var_6_0 = var_6_1
			end
		end
	end

	if not self._finalPlaceComp then
		local var_6_4 = fgui.GComponent:create()

		self._finalPlaceComp = var_6_4

		self:addChild(var_6_4)
	end

	self._maxPosWidth = var_6_1 + ThemeThirdBossLineConfig.maxWidthLine

	self._finalPlaceComp:setPosition(self._maxPosWidth, display.cy)
	self._scrollComp:setPosX(math.max(1, var_6_0 - display.cx))
	self._scrollComp:setMouseWheelEnabled(false)
end

function ThemeThirdBossTalentScrollComp:updateScrollView()
	for iter_7_0, iter_7_1 in pairs(self._curShowIconDict) do
		iter_7_1.iconComp:refreshComp()
		iter_7_1.lineComp:refreshComp()
	end
end

function ThemeThirdBossTalentScrollComp:onClickIcon(arg_8_1, arg_8_2)
	local var_8_0 = self._treeData:getTalentById(self._clickId)

	if var_8_0 then
		local var_8_1 = self:getIconComp(var_8_0)

		if var_8_1 then
			var_8_1:setClickState(false)
		end
	end

	local var_8_2 = self._treeData:getTalentById(arg_8_1.id)

	if var_8_2 then
		self._clickId = arg_8_1.id

		local var_8_3 = self:getIconComp(var_8_2)

		if not var_8_3 then
			return
		end

		var_8_3:setClickState(true)

		if arg_8_2 then
			self:dispatchCompEvent("ThemeThirdBossTalentScrollComp_scrollComp_show_info", {
				id = arg_8_1.id
			})
		else
			local var_8_4 = var_8_3:displayObject()
			local var_8_5 = var_8_4:convertToWorldSpace(cc.p(0, 0)).x
			local var_8_6 = var_8_3:getWidth()
			local var_8_7 = display.width - var_8_4 - var_8_3:getNextLineWidth()

			if var_8_7 <= var_8_5 then
				self._scrollComp:setPosX(var_8_3:getX() - var_8_7)

				var_8_5 = var_8_7
			elseif var_8_5 <= var_8_6 / 2 then
				self._scrollComp:setPosX(var_8_3:getX() - var_8_6)

				var_8_5 = var_8_6
			end

			self:dispatchCompEvent("ThemeThirdBossTalentScrollComp_scrollComp_show_info", {
				id = arg_8_1.id,
				compWorldPosX = var_8_5
			})

			if (display.width - var_0_1) / 2 < var_8_5 then
				self:setScrollPosX(((display.width - var_0_1) / 2 - var_8_5 < display.width - var_0_1 - display.width or nil) and display.width - var_0_1 + 30 - display.width, true)
			end
		end
	end
end

function ThemeThirdBossTalentScrollComp:getIconComp(arg_9_1)
	if self._curShowIconDict[arg_9_1:getId()] then
		return self._curShowIconDict[arg_9_1:getId()].iconComp
	end

	return nil
end

function ThemeThirdBossTalentScrollComp:setScrollPosX(arg_10_1, arg_10_2)
	local var_10_0 = self._scrollComp:getPosX() - arg_10_1

	if var_10_0 > self._maxPosWidth - display.width then
		self._hasCanUpdate = false

		self._finalPlaceComp:setX(self._maxPosWidth + display.width)
		self._scrollComp:setPosX(var_10_0, arg_10_2)
	else
		self._hasCanUpdate = true

		self:resetScrollPane()
		self._scrollComp:setPosX(var_10_0, arg_10_2)
	end
end

function ThemeThirdBossTalentScrollComp:resetScrollPane()
	if self._finalPlaceComp then
		self._finalPlaceComp:setX(self._maxPosWidth)
		self._scrollComp:setPosX(self._scrollComp:getPosX(), false)

		self._hasCanUpdate = true

		self:_onScrollPanel(nil, true)
	end
end

function ThemeThirdBossTalentScrollComp:checkCompIsClick(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(self._curShowIconDict) do
		local var_12_0 = iter_12_1.iconComp:displayObject():convertToWorldSpace(cc.p(0, 0)).x

		if var_12_0 >= -iter_12_1.iconComp:getWidth() and var_12_0 <= arg_12_2 and iter_12_1.iconComp:containPoint(arg_12_1) then
			return iter_12_1.iconComp:getId()
		end
	end

	return 0
end

function ThemeThirdBossTalentScrollComp:onS2CTalentActive(arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if self._curShowIconDict[iter_13_1] then
			self._curShowIconDict[iter_13_1].iconComp:showActiveEff()
		end
	end
end

return ThemeThirdBossTalentScrollComp
