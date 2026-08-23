local NewSlgS2CityInfoComp = class("NewSlgS2CityInfoComp", require("app.fairyGUI.newSlg.UI_NewSlgS2CityInfoComp1"))
local var_0_1 = g.core.model.User.newSlgData
local var_0_3 = g.core.const.ConstMgr.NewSlgConst

function NewSlgS2CityInfoComp:ctor()
	self._addArr = {}
	self._isAddVisible = false
	self._isDecayVisible = false

	self.m_Btn_add:addClickListener(handler(self, self._onClickBtnAdd))

	self._compTop = self:getChild("Comp_top")
	self._compBottom = self:getChild("Comp_bottom")

	self:addListen(self._compBottom)
	self.m_tipsComp:updateCityView()
end

function NewSlgS2CityInfoComp:updateView(arg_2_1)
	self.m_Btn_add:setVisible(false)
	self.m_additionComp:setVisible(false)
	self.m_tipsComp:setVisible(false)

	self._isAddVisible = false
	self._isDecayVisible = false

	if not arg_2_1 then
		return
	end

	self._cityId = arg_2_1.cityId
	self._addArr = self:_getAddArr()

	self.m_Btn_add:setVisible(#self._addArr > 0)

	if #self._addArr > 0 then
		self.m_additionComp:updateView({
			addArr = self._addArr
		})
	end

	self._compTop:updateView(arg_2_1)
	self._compBottom:updateView(arg_2_1)
	self:getTransition("enter"):play()
end

function NewSlgS2CityInfoComp:_getAddArr()
	local var_3_0 = var_0_1:getCityInfoById(self._cityId)
	local var_3_1 = {}

	if var_3_0.capture_add > 0 then
		table.insert(var_3_1, {
			tp = var_0_3.Slg2CityAddType.res,
			value = var_3_0.capture_add
		})
	end

	if var_3_0.contribute_add > 0 then
		table.insert(var_3_1, {
			tp = var_0_3.Slg2CityAddType.score,
			value = var_3_0.contribute_add
		})
	end

	return var_3_1
end

function NewSlgS2CityInfoComp:_onClickBtnAdd()
	if #self._addArr == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429622))

		return
	end

	self._isAddVisible = not self._isAddVisible

	if self._isAddVisible then
		self:_setSafeShowPos()
	end

	self.m_tipsComp:setVisible(false)
	self.m_additionComp:setVisible(self._isAddVisible)
end

function NewSlgS2CityInfoComp:_setSafeShowPos()
	if self:localToGlobal(cc.p(0, 0)).x > display.cx then
		self.m_additionComp:setX(-self.m_additionComp:getWidth())
	else
		self.m_additionComp:setX(self:getWidth())
	end
end

function NewSlgS2CityInfoComp:_onCompAdditionClick()
	self._isDecayVisible = not self._isDecayVisible

	if self._isDecayVisible then
		self:_setSafeShowDecayPos()
	end

	self.m_tipsComp:setVisible(self._isDecayVisible)
	self.m_tipsComp:updateCityView()
	self.m_additionComp:setVisible(false)
end

function NewSlgS2CityInfoComp:_setSafeShowDecayPos()
	if self:localToGlobal(cc.p(0, 0)).x > display.cx then
		self.m_tipsComp:setX(-self.m_tipsComp:getWidth())
	else
		self.m_tipsComp:setX(self:getWidth())
	end
end

function NewSlgS2CityInfoComp:receiveCompEvent(arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 or {}

	if arg_8_1 == "NewSlgDecayClick" then
		self:_onCompAdditionClick()
	end
end

return NewSlgS2CityInfoComp
