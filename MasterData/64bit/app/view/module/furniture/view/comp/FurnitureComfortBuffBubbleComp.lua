local var_0_0 = 4
local var_0_1 = g.core.model.User.furnitureData
local var_0_2 = g.core.common.Scheduler
local FurnitureComfortBuffBubbleComp = class("FurnitureComfortBuffBubbleComp", require("app.fairyGUI.furniture.UI_FurnitureComfortBuffBubbleComp"))

function FurnitureComfortBuffBubbleComp:ctor()
	self._timer = nil
	self._comfortDict = {}
	self._newActivatedAttributeSumArr = {}
	self._activatedAttributeSumDict = {}

	self:_initData()
	self.m_buffList:setIniter()
	self.m_buffList:doFairyBatching(true)
	self.m_buffList:setItemRenderer(handler(self, self._onAttributeListRenderer))
end

function FurnitureComfortBuffBubbleComp:_initData()
	for iter_2_0 = 1, var_0_1:getDormMaxNum() do
		self._comfortDict[iter_2_0] = var_0_1:getRoomInfo(iter_2_0):getComfort()
	end
end

function FurnitureComfortBuffBubbleComp:onUnload()
	self:_onCDEnd()
end

function FurnitureComfortBuffBubbleComp:_onAttributeListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._newActivatedAttributeSumArr[arg_4_1 + 1].attributeType, self._activatedAttributeSumDict[self._newActivatedAttributeSumArr[arg_4_1 + 1].attributeType] or 0, self._newActivatedAttributeSumArr[arg_4_1 + 1].attributeValue)
end

function FurnitureComfortBuffBubbleComp:_onCDEnd()
	self:setVisible(false)
	self:_cancelTimer()
end

function FurnitureComfortBuffBubbleComp:checkShow(arg_6_1)
	local var_6_0 = var_0_1:getRoomInfo(arg_6_1)
	local var_6_1 = var_6_0:getComfort()

	self._comfortDict[arg_6_1] = var_6_1

	if var_6_1 <= self._comfortDict[arg_6_1] then
		return
	end

	local var_6_2 = var_6_0:getNewActivatedAttributeArr(self._comfortDict[arg_6_1])

	if #var_6_2 > 0 then
		self.m_comfortTxt:setText(var_6_1)

		self._activatedAttributeSumDict = var_6_0:getAttributesSumDict((var_6_0:getActivatedAttributeArr()))
		self._newActivatedAttributeSumArr = var_6_0:getAttributesSumArr(var_6_2)

		self.m_buffList:setNumItems(#self._newActivatedAttributeSumArr)
		self.m_buffList:resizeToFit(#self._newActivatedAttributeSumArr)
		self:setVisible(true)
		self:_startTimer()
	end
end

function FurnitureComfortBuffBubbleComp:_startTimer()
	self:_cancelTimer()

	self._timer = var_0_2:newScheduleOnce(handler(self, self._onCDEnd), var_0_0)
end

function FurnitureComfortBuffBubbleComp:_cancelTimer()
	if self._timer then
		var_0_2:cancelSchedule(self._timer)

		self._timer = nil
	end
end

return FurnitureComfortBuffBubbleComp
