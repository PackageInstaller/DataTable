local NewSlgS2PeriodComp = class("NewSlgS2PeriodComp", require("app.fairyGUI.newSlg.UI_NewSlgS2PeriodComp"))
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.model.User.newSlgData

function NewSlgS2PeriodComp:ctor()
	self._compPeriodTitle = self:getChild("Comp_periodTitle")
	self._periodCtrl = self._compPeriodTitle:getController("period")
	self._txtTime = self:getChild("Txt_time")

	self.m_tipsBtn:addClickListener(handler(self, self._onTipsClick))
	self:setVisible(false)

	self._period = var_0_1.Slg2CityState.none
end

function NewSlgS2PeriodComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, handler(self, self.updateCityNum), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF, handler(self, self.updateCityNum), self)
end

function NewSlgS2PeriodComp:_onTipsClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
		id = 377
	}), {
		touchDisappear = true
	})
end

function NewSlgS2PeriodComp:updateView()
	if var_0_2:getSName() == "S1" then
		return
	end

	local var_4_0, var_4_1, var_4_2 = var_0_2:getCityPeriod()

	if var_4_0 ~= var_0_1.Slg2CityState.none then
		self._txtTime:setText((g.core.common.ServerTime:getLeftHMSFormat(var_4_2)))
	end

	if self._period == var_4_0 then
		return
	end

	self._period = var_4_0

	if self._period == var_0_1.Slg2CityState.none then
		self:setVisible(false)
	else
		self:setVisible(true)
		self.m_stageTxt:setText(g.core.lang:get(429041 + self._period))
		self._periodCtrl:setSelectedIndex(self._period - 1)
		self:updateCityNum()
	end
end

function NewSlgS2PeriodComp:updateCityNum()
	if self._period == var_0_1.Slg2CityState.declare_war then
		self.m_cityCountTxt:setText(g.core.lang:get(429671, {
			num1 = #var_0_2:getSelfDeclaredCities(),
			num2 = var_0_2:getDeclaredCityMaxCnt()
		}) .. "     " .. g.core.lang:get(429756, {
			level = var_0_2:getMaxCanDeclareCityLevel()
		}))
	else
		self.m_cityCountTxt:setText("")
	end
end

return NewSlgS2PeriodComp
