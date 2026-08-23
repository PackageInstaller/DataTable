local var_0_0 = g.core.model.User.activityGetStaminaData
local ActivityGetStamina = class("ActivityGetStamina", require("app.fairyGUI.activity.UI_ActivityGetStaminaComp"))

function ActivityGetStamina:ctor()
	self._activityValue = nil
	self._timeEventList = var_0_0:getTimeEventList()

	self:_initView()
end

function ActivityGetStamina:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_INFO, self._onRcvGetStaminaInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_STAMINA_GET, self._onRcvGetStaminaGet, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, self._onQuarterMinuteUpdate, self)
	self:_reqGetStaminaInfo()
end

function ActivityGetStamina:_initView()
	self.m_list:setVirtual()
	self.m_list:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_list:setNumItems(#self._timeEventList)

	local var_3_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_3_0.x > 0 then
		self.m_list:setWidth(self.m_list:getWidth() - var_3_0.x)
	end

	if #self._timeEventList == 2 then
		self.m_list:setColumnGap(self.m_list:getWidth() * 0.08)
	end
end

function ActivityGetStamina:_reqGetStaminaInfo()
	g.core.network.GameNetProxy:send_C2S_GetStamina_Info({})
end

function ActivityGetStamina:_onRcvGetStaminaInfo(arg_5_1)
	self:updateComp()
end

function ActivityGetStamina:_onRcvGetStaminaGet(arg_6_1, arg_6_2)
	g.core.module.ModuleManager:awardSummary(arg_6_2.awards)
	self:updateComp()
end

function ActivityGetStamina:_onQuarterMinuteUpdate(arg_7_1, arg_7_2)
	self:checkRefreshWithHHMM(arg_7_2)
end

function ActivityGetStamina:checkRefreshWithHHMM(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._timeEventList) do
		if arg_8_1 == self:_getHHMMWithSecond(iter_8_1.open_time) or arg_8_1 == self:_getHHMMWithSecond(iter_8_1.end_time) then
			self:_reqGetStaminaInfo()

			break
		end
	end
end

function ActivityGetStamina:_onItemRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateCell(self._timeEventList[arg_9_1 + 1])
end

function ActivityGetStamina:updateCD()
	return
end

function ActivityGetStamina:updateComp(arg_11_1)
	if arg_11_1 and arg_11_1 ~= self._activityValue then
		self._activityValue = arg_11_1
	end

	self._timeEventList = var_0_0:getTimeEventList()

	self.m_list:setNumItems(#self._timeEventList)
end

function ActivityGetStamina:playEnterAni()
	self.m_enterTransition:play()
	self.m_list:transitionShowCells("listCardAUiLeftIn", 0.03)
	self:_playCellsEnterAni()
end

function ActivityGetStamina:playCloseAni()
	self.m_backTransition:play()
end

function ActivityGetStamina:_playCellsEnterAni()
	for iter_14_0 = 0, #self._timeEventList - 1 do
		local var_14_0 = self.m_list:getChildAt(iter_14_0)

		if var_14_0 then
			var_14_0:playCellEnterAni(0.03 * iter_14_0)
		else
			break
		end
	end
end

function ActivityGetStamina:_getHHMMWithSecond(arg_15_1)
	return math.floor(arg_15_1 / 3600) * 100 + math.ceil(arg_15_1 / 60) % 60
end

return ActivityGetStamina
