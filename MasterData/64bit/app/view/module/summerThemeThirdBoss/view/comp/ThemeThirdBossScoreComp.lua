local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local ThemeThirdBossScoreComp = class("ThemeThirdBossScoreComp", require("app.fairyGUI.summerThemeThirdBoss.UI_ThemeThirdBossScoreComp"))

function ThemeThirdBossScoreComp:ctor()
	self._startLength = 30
	self._cellLength = 150
	self._endLength = 0
	self._step = 0
	self._bossData = nil
	self._lastUpdatePos = 0
	self._showCellDict = {}
	self._compPool = NodePool.new(self, "summerThemeThirdBoss", "ThemeThirdBossScoreCell", math.ceil(self:getHeight() / self._cellLength) + 2)

	self:initComp()
end

function ThemeThirdBossScoreComp:initComp()
	self._scrollPanel = self:getScrollPane()

	self:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onScrollPanel))
end

function ThemeThirdBossScoreComp:initData(arg_3_1)
	self._bossData = arg_3_1
	self._scoreList = arg_3_1:getScoreInfoList()

	self.m_maxHeigh:setHeight(self._startLength + #self._scoreList * self._cellLength + self._endLength)
end

function ThemeThirdBossScoreComp:setCurScore(arg_4_1)
	return
end

function ThemeThirdBossScoreComp:updateCompView()
	local var_5_0 = self._bossData:getTotalScore()
	local var_5_1, var_5_2 = self._bossData:getShowAwardIndex()
	local var_5_3 = self._bossData:getScoreInfoByIndex(var_5_1)

	if var_5_0 == 0 then
		self.m_scoreStateController:setSelectedIndex(0)
		self.m_bar:setHeight(0)
	else
		if var_5_0 >= self._scoreList[#self._scoreList].integral_demand then
			self.m_scoreStateController:setSelectedIndex(2)
		else
			self.m_scoreStateController:setSelectedIndex(1)
		end

		local var_5_4 = self._bossData:getScoreInfoByIndex(var_5_1 + 1)
		local var_5_5 = 0
		local var_5_6 = 0

		if var_5_4 then
			var_5_5 = var_5_4.integral_demand - var_5_3.integral_demand
			var_5_6 = var_5_0 - var_5_3.integral_demand
		else
			var_5_5 = var_5_0
			var_5_6 = var_5_0
		end

		local var_5_7 = var_5_6 / var_5_5

		self.m_bar:setHeight((var_5_0 <= self._scoreList[1].integral_demand and self._startLength * var_5_7 or self._cellLength * var_5_7 + self._startLength) + (var_5_1 - 1) * self._cellLength + 86)
		self._scrollPanel:setPosY(self._startLength + (var_5_2 - 1) * self._cellLength)
	end

	self:_onScrollPanel(nil, true)
end

function ThemeThirdBossScoreComp:_onScrollPanel(arg_6_1, arg_6_2)
	if not self._bossData then
		return
	end

	local var_6_0 = self._scrollPanel:getPosY()

	if not arg_6_2 and math.abs(self._lastUpdatePos - var_6_0) <= self._cellLength then
		return
	end

	self._lastUpdatePos = var_6_0

	local var_6_1 = math.max(math.floor((var_6_0 - self._startLength) / self._cellLength), 1)
	local var_6_2 = math.min(math.ceil((var_6_0 + self:getHeight() - self._startLength) / self._cellLength) + 1, #self._scoreList)

	for iter_6_0, iter_6_1 in pairs(self._showCellDict) do
		if var_6_1 > iter_6_1:getIndex() or var_6_2 < iter_6_1:getIndex() then
			self._compPool:recoveryCompInPool(iter_6_1)

			self._showCellDict[iter_6_0] = nil
		end
	end

	for iter_6_2 = var_6_1, var_6_2 do
		local var_6_3 = self._showCellDict[iter_6_2]

		if not self._showCellDict[iter_6_2] then
			var_6_3 = self._compPool:takeOutCompInPool()

			self.m_cellRoot:addChild(var_6_3)
			var_6_3:setPosition(0, self._startLength + (iter_6_2 - 1) * self._cellLength)

			self._showCellDict[iter_6_2] = var_6_3

			var_6_3:updateScoreCell(self._scoreList[iter_6_2], iter_6_2, self._bossData)
		elseif arg_6_2 then
			var_6_3:updateScoreCell(self._scoreList[iter_6_2], iter_6_2, self._bossData)
		end
	end
end

return ThemeThirdBossScoreComp
