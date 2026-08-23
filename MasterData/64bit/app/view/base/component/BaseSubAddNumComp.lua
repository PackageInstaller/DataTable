local var_0_0 = 0.5
local var_0_1 = 0.05
local var_0_2 = {
	SUB_ONE = 1,
	ADD_TEN = 4,
	ADD_ONE = 3,
	SUB_TEN = 2
}
local BaseSubAddNumComp = class("BaseSubAddNumComp", require("app.fairyGUI.base_new.UI_BaseSubAddNumComp"))

local function var_0_4(arg_1_0)
	return math.floor(arg_1_0 + 0.5)
end

function BaseSubAddNumComp:ctor()
	self._minNum = 1
	self._maxNum = 0
	self._curNum = 0
	self._aroundMiniSize = 1
	self._exMaxLimitCheckFunc = nil
	self._callBack = nil
	self._reachMaxAddTipGetFunc = nil
	self._scheduleId = nil
	self._scheduleUpdateId = nil
	self._isTouching = false
	self._operationType = nil

	self:_initBtn()
end

function BaseSubAddNumComp:_initBtn()
	local var_3_0 = {}

	self.m_subMinBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onSubMinClick))
	self.m_subTenBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onSubTenClick))
	table.insert(var_3_0, self.m_subTenBtn)
	self.m_subOneBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onSubOneClick))
	table.insert(var_3_0, self.m_subOneBtn)
	self.m_addOneBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onAddOneClick))
	table.insert(var_3_0, self.m_addOneBtn)

	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_addTenBtn:addClickListener(handler(self, self._onAddTenClick))
	else
		self.m_addTenBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onAddTenClick))
	end

	table.insert(var_3_0, self.m_addTenBtn)
	self.m_addMaxBtn:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onAddMaxClick))
	self.m_inputText:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onInputTextBegin))
	self.m_inputText:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputTextChanged))
	self.m_inputText:addEventListener(fgui.UIEventType.Submit, handler(self, self._onInputTextEnd))

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		if iter_3_1 then
			iter_3_1:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onLongPressOperation))
		end
	end
end

function BaseSubAddNumComp:initMinMaxNum(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self._minNum = arg_4_1.min or self._minNum
	self._maxNum = arg_4_1.max or self._maxNum
	self._curNum = arg_4_1.cur or self._curNum
	self._aroundMiniSize = arg_4_1.aroundMiniSize or self._aroundMiniSize
	self._callBack = arg_4_1.callback or self._callBack
	self._reachMaxAddTipGetFunc = arg_4_1.reachMaxAddTipGetFunc or self._reachMaxAddTipGetFunc

	self:updateCurAddNum(0)
end

function BaseSubAddNumComp:_onSubMinClick()
	self:updateCurAddNum(-self._maxNum)
end

function BaseSubAddNumComp:_onSubTenClick()
	self:_canCelLongPressOperation()
	self:updateCurAddNum(-10)
end

function BaseSubAddNumComp:_onSubOneClick()
	self:_canCelLongPressOperation()
	self:updateCurAddNum(-1)
end

function BaseSubAddNumComp:_onAddOneClick()
	self:_canCelLongPressOperation()
	self:updateCurAddNum(1, {
		isAdd = true
	})
	self:_judgeIsFullWhenClickAddOperation()
end

function BaseSubAddNumComp:_onAddTenClick()
	self:_canCelLongPressOperation()
	self:_addTenOperation()
end

function BaseSubAddNumComp:_addTenOperation()
	local var_10_0 = 10

	if self._curNum == self._minNum then
		var_10_0 = var_10_0 - self._minNum
	end

	self:updateCurAddNum(var_10_0, {
		isAdd = true
	})
	self:_judgeIsFullWhenClickAddOperation()
end

function BaseSubAddNumComp:_onAddMaxClick()
	self:updateCurAddNum(math.floor(self._maxNum / self._aroundMiniSize), {
		isAdd = true
	})
end

function BaseSubAddNumComp:updateCurAddNum(arg_12_1, arg_12_2)
	arg_12_1 = arg_12_1 or 0
	arg_12_1 = arg_12_1 * self._aroundMiniSize
	self._curNum = g.core.utils.Number.formatNumberByLimit(self._curNum + arg_12_1, self._minNum, self._maxNum)
	self._curNum = math.floor(self._curNum / self._aroundMiniSize) * self._aroundMiniSize

	self.m_curNumText:setText(self._curNum)

	if self._callBack then
		self._callBack(self._curNum, arg_12_2)
	end

	self:_updateCanAddReduceCtrl()
end

function BaseSubAddNumComp:setCurNum(arg_13_1, arg_13_2)
	self._curNum = 0

	self:updateCurAddNum(var_0_4(arg_13_1 / self._aroundMiniSize), arg_13_2)
end

function BaseSubAddNumComp:getCurNum()
	return self._curNum
end

function BaseSubAddNumComp:setMaxNum(arg_15_1)
	self._maxNum = arg_15_1

	self:_updateCanAddReduceCtrl()
end

function BaseSubAddNumComp:getMaxNum()
	return self._maxNum
end

function BaseSubAddNumComp:_onSchedulUpdateOperation()
	if self._isTouching and self._operationType then
		if self._operationType == var_0_2.ADD_TEN then
			self:_addTenOperation()
		else
			local var_17_0 = self._operationType == var_0_2.ADD_ONE and 1 or self._operationType == var_0_2.SUB_ONE and -1 or -10

			if self._operationType == var_0_2.ADD_ONE then
				self:updateCurAddNum(var_17_0, {
					isAdd = true
				})
			else
				self:updateCurAddNum(var_17_0)
			end
		end
	end
end

function BaseSubAddNumComp:_canCelLongPressOperation()
	self._isTouching = false
	self._operationType = nil

	if self._scheduleId then
		self:cancelSchedule(self._scheduleId)

		self._scheduleId = nil
	end

	if self._scheduleUpdateId then
		self:cancelSchedule(self._scheduleUpdateId)

		self._scheduleUpdateId = nil
	end
end

function BaseSubAddNumComp:_onLongPressOperation(arg_19_1)
	self._scheduleUpdateId = self:newSchedule(handler(self, self._onSchedulUpdateOperation), var_0_1)

	local var_19_0 = arg_19_1:getSender():getName()

	self._scheduleId = self:newScheduleOnce(handler(self, function()
		if var_19_0 == "addTenBtn" then
			self._operationType = var_0_2.ADD_TEN
		elseif var_19_0 == "addOneBtn" then
			self._operationType = var_0_2.ADD_ONE
		elseif var_19_0 == "subTenBtn" then
			self._operationType = var_0_2.SUB_TEN
		elseif var_19_0 == "subOneBtn" then
			self._operationType = var_0_2.SUB_ONE
		end

		self._isTouching = true
	end), var_0_0)
end

function BaseSubAddNumComp:_onInputTextBegin()
	self.m_inputText:setText(self._curNum)
	self.m_curNumText:setVisible(false)
end

function BaseSubAddNumComp:_onInputTextChanged()
	local var_22_0 = self.m_inputText:getText()
	local var_22_1 = tonumber(var_22_0)

	if var_22_0 == "" then
		var_22_1 = self._minNum
	elseif var_22_1 then
		var_22_1 = math.floor(var_22_1)

		if var_22_1 > self._maxNum then
			var_22_1 = self._maxNum

			g.core.module.ModuleManager:tip(g.core.lang:get(2056, {
				num = self._maxNum
			}))
		elseif var_22_1 < self._minNum then
			var_22_1 = self._minNum

			g.core.module.ModuleManager:tip(g.core.lang:get(2057, {
				num = self._minNum
			}))
		end
	else
		var_22_1 = self._minNum

		g.core.module.ModuleManager:tip(g.core.lang:get(2058))
	end

	self:setCurNum(var_22_1)
	self.m_inputText:setText(var_22_1)
end

function BaseSubAddNumComp:_onInputTextEnd()
	self.m_inputText:setText("")
	self.m_curNumText:setVisible(true)
end

function BaseSubAddNumComp:_judgeIsFullWhenClickAddOperation()
	if self._curNum >= self._maxNum then
		g.core.module.ModuleManager:tip((self:_getAddTipOnReachMax(self._curNum)))
	end
end

function BaseSubAddNumComp:_getAddTipOnReachMax(arg_25_1)
	local var_25_0 = g.core.lang:get(2061)

	if self._reachMaxAddTipGetFunc then
		return self._reachMaxAddTipGetFunc(arg_25_1) or var_25_0
	else
		return var_25_0
	end
end

function BaseSubAddNumComp:_updateCanAddReduceCtrl()
	self.m_canReduceController:setSelectedIndex(math.floor(self._minNum / self._aroundMiniSize) < math.floor(self._curNum / self._aroundMiniSize) and 1 or 0)
	self.m_canAddController:setSelectedIndex(math.floor(self._curNum / self._aroundMiniSize) < math.floor(self._maxNum / self._aroundMiniSize) and 1 or 0)
end

return BaseSubAddNumComp
