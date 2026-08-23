local NewSlgFarmCountDownBtn = class("NewSlgFarmCountDownBtn", require("app.fairyGUI.newSlg.UI_NewSlgFarmCountDownBtn"))

function NewSlgFarmCountDownBtn:ctor()
	self._txtCountDown = self:getChild("Txt_countDown")
	self._buttonCtrl = self:getController("button")
	self._farmTypeCtrl = self:getController("farm_type")

	local var_1_0, var_1_1 = g.core.model.User.newSlgData:isFarmPeriod()

	if var_1_0 then
		self._farmTypeCtrl:setSelectedIndex(1)
	else
		self._farmTypeCtrl:setSelectedIndex(0)
	end

	self:setVisible(false)
end

function NewSlgFarmCountDownBtn:onLoad()
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgFarmCountDownBtn_updateSch"
	})
	g.core.event.EventManager:addEventListener(g.core.event.enum.SLG_BASE_USER_INFO_BACK, handler(self, self.updateFarmLimitDesc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USEFARMTOKEN, handler(self, self.updateFarmLimitDesc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMAWARD, handler(self, self.updateFarmLimitDesc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgFarmCountDownBtn:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3.key == "NewSlgFarmCountDownBtn_updateSch" then
		self:_updateCountDown()
	end
end

function NewSlgFarmCountDownBtn:_updateCountDown()
	local var_4_0, var_4_1 = g.core.model.User.newSlgData:isFarmPeriod()

	if var_4_1 <= 0 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)
	self._txtCountDown:setText(g.core.common.ServerTime:secondToHMSString(var_4_1))

	if var_4_0 and self._farmTypeCtrl:getSelectedIndex() == 0 then
		self._farmTypeCtrl:setSelectedIndex(1)
	elseif not var_4_0 and self._farmTypeCtrl:getSelectedIndex() == 1 then
		self._farmTypeCtrl:setSelectedIndex(0)
	end
end

function NewSlgFarmCountDownBtn:updateFarmLimitDesc()
	local var_5_0, var_5_1 = g.core.model.User.newSlgData:getCurDayFarmRewardCount()
	local var_5_2, var_5_3 = g.core.model.User.newSlgData:getCurDayFarmKillScore()

	self.m_farmIcon1:setURL(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = g.core.common.Goods.ITEM.TYPE_SLG_SUPPLY_PRODUCTION_ITEM
	}).icon_mini)
	self.m_farmIcon2:setURL(g.core.common.Goods:convert({
		value = 111,
		type = 1
	}).icon_mini)
	self.m_farmRewardLimitTxt1:setText(g.core.lang:get(105014, {
		num1 = var_5_0,
		num2 = var_5_1
	}))
	self.m_farmRewardLimitTxt2:setText(g.core.lang:get(105014, {
		num1 = var_5_2,
		num2 = var_5_3
	}))
end

return NewSlgFarmCountDownBtn
