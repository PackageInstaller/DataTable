local DebugKMeansTestComp = class("DebugKMeansTestComp", require("app.fairyGUI.debug.UI_DebugKMeansTestComp"))

function DebugKMeansTestComp:ctor()
	self._allLine = {}
	self._allPointList = {}
	self._groupNum = 10
	self._groupList = {}
	self._lastGroupCenterDict = {}
	self._centerPos = {}
	self._originPos = self.m_origin:getPosition()

	self.m_startBtn:addClickListener(handler(self, self.onClickStart))
	self.m_randomPosBtn:addClickListener(handler(self, self._randomPosList))
end

function DebugKMeansTestComp:setAllLine(arg_2_1)
	for iter_2_0, iter_2_1 in pairs(self._allLine) do
		if arg_2_1 then
			iter_2_1:setAlpha(arg_2_1)
		else
			iter_2_1:setVisible(false)
		end
	end
end

function DebugKMeansTestComp:_randomPosList()
	self:setAllLine()

	self._groupList = {}
	self._centerPos = {}

	local var_3_0 = tonumber((self.m_posInput:getText())) or 100
	local var_3_1 = display.width - self._originPos.x
	local var_3_2 = self._originPos.y - self.m_bg:getPosition().y

	for iter_3_0 = 1, math.max(var_3_0, #self._originPos) do
		if not self._allPointList[iter_3_0] then
			local var_3_3 = fgui.UIPackage:createObject("debug", "DebugKMeansTestPos")

			self.m_origin:addChild(var_3_3)
			var_3_3:setTitle(iter_3_0)
			var_3_3:setPosition(math.random(var_3_1), -math.random(var_3_2))
			table.insert(self._allPointList, {
				comp = var_3_3,
				pos = var_3_3:getPosition()
			})
		elseif var_3_0 < iter_3_0 then
			self._allPointList[iter_3_0].comp:removeFromParent()

			self._allPointList[iter_3_0] = nil
		else
			self._allPointList[iter_3_0].comp:setPosition(math.random(var_3_1), -math.random(var_3_2))

			self._allPointList[iter_3_0].pos = self._allPointList[iter_3_0].comp:getPosition()
		end
	end
end

function DebugKMeansTestComp:onClickStart()
	self._groupNum = tonumber((self.m_groupInput:getText())) or 10

	if #self._allPointList <= self._groupNum then
		self:log("组数量高于了点数量")

		return
	end

	self:setAllLine()

	if next(self._groupList) then
		self:doGrouping()
	else
		self:initGrouping()
	end
end

function DebugKMeansTestComp:initGrouping()
	self._groupList = {}

	while 1 <= self._groupNum do
		local var_5_0 = math.random(#self._allPointList)
		local var_5_1

		if not table.keyof(self._groupList, var_5_0) then
			self._groupList[1] = {}
			self._centerPos[1] = self._allPointList[var_5_0].pos
			var_5_1 = 1 + 1
		end
	end

	for iter_5_0, iter_5_1 in ipairs(self._allPointList) do
		self._groupList[self:getMinLengthGroup(iter_5_1.pos)][iter_5_0] = true
	end

	self:updateGroupLines()
	self:log("分组中")
	self:newScheduleOnce(handler(self, self.doGrouping), 1)
end

function DebugKMeansTestComp:doGrouping()
	self:log("分组中")

	self._lastGroupCenterDict = clone(self._groupList)
	self._groupList = {}

	for iter_6_0, iter_6_1 in pairs(self._lastGroupCenterDict) do
		self._centerPos[iter_6_0] = self:getCenterPos(iter_6_1)
		self._groupList[iter_6_0] = {}
	end

	for iter_6_2, iter_6_3 in ipairs(self._allPointList) do
		self._groupList[self:getMinLengthGroup(iter_6_3.pos)][iter_6_2] = true
	end

	self:updateGroupLines()

	for iter_6_4, iter_6_5 in pairs(self._lastGroupCenterDict) do
		for iter_6_6, iter_6_7 in pairs(iter_6_5) do
			if not self._groupList[iter_6_4][iter_6_6] then
				self:newScheduleOnce(handler(self, self.doGrouping), 1)

				return
			end
		end
	end

	self:doingEnd()
end

function DebugKMeansTestComp:doingEnd()
	self:log("分组完成")
	self:setAllLine(0.5)
end

function DebugKMeansTestComp:getMinLengthGroup(arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in pairs(self._centerPos) do
		local var_8_1 = cc.pDistanceSQ(iter_8_1, arg_8_1)
		local var_8_2

		if not var_8_0 or var_8_1 < 0 then
			var_8_0 = iter_8_0
			var_8_2 = var_8_1
		end
	end

	return var_8_0
end

function DebugKMeansTestComp:log(arg_9_1)
	self.m_logText:setText(arg_9_1)
end

function DebugKMeansTestComp:getCenterPos(arg_10_1)
	local var_10_0 = 0
	local var_10_1 = 0
	local var_10_2 = 99999999
	local var_10_3 = 99999999

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		if var_10_0 < self._allPointList[iter_10_0].pos.x then
			var_10_0 = self._allPointList[iter_10_0].pos.x
		end

		if var_10_2 > self._allPointList[iter_10_0].pos.x then
			var_10_2 = self._allPointList[iter_10_0].pos.x
		end

		if var_10_1 < self._allPointList[iter_10_0].pos.y then
			var_10_1 = self._allPointList[iter_10_0].pos.y
		end

		if var_10_3 > self._allPointList[iter_10_0].pos.y then
			var_10_3 = self._allPointList[iter_10_0].pos.y
		end
	end

	return (cc.p((var_10_0 + var_10_2) / 2, (var_10_1 + var_10_3) / 2))
end

function DebugKMeansTestComp:updateGroupLines()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(self._groupList) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			var_11_0 = var_11_0 + 1

			local var_11_1 = self._allLine[var_11_0]

			if not self._allLine[var_11_0] then
				var_11_1 = fgui.UIPackage:createObject("debug", "DebugKMeansTestLine")
				self._allLine[var_11_0] = var_11_1

				self.m_lineRoot:addChild(var_11_1)
			end

			var_11_1:setVisible(true)
			var_11_1:setPosition(self._centerPos[iter_11_0])

			local var_11_2 = cc.pSub(self._allPointList[iter_11_2].pos, self._centerPos[iter_11_0])

			var_11_1:setWidth(cc.pGetLength(var_11_2))
			var_11_1:setRotation(math.radian2angle(cc.pToAngleSelf(var_11_2)))
		end
	end

	for iter_11_4 = var_11_0 + 1, #self._allLine do
		self._allLine[iter_11_4]:setVisible(false)
	end
end

return DebugKMeansTestComp
