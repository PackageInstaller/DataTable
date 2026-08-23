local NewSlgSupplyFarmComp = class("NewSlgSupplyFarmComp")

function NewSlgSupplyFarmComp:ctor()
	self._btnGet = self:getChild("Btn_get")

	self._btnGet:addClickListener(handler(self, self._onClickBtnGet))

	self._txtGain = self:getChild("Txt_gain")
	self._listAward = self:getChild("List_award")

	self._listAward:setVirtual(self)
	self._listAward:setItemRenderer(handler(self, self._onRenderListAwardCell))

	self._isEmptyCtrl = self:getController("is_empty")
	self._compAward = self:getChild("Comp_award")
	self._txtEmpty1 = self:getChild("Txt_empty1")

	self._txtEmpty1:setText(g.core.lang:get("NEW_SLG_FARM_GAIN_NO_TIP"))

	self._titleComp = self:getChild("Comp_title")
	self._txtHonor = self:getChild("Txt_honor")
	self._farmsArr = {}
end

function NewSlgSupplyFarmComp:onLoad()
	self:updateView()
	self:_updateHonor(0)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserFarmInfo({})
end

function NewSlgSupplyFarmComp:updateView()
	self:_updateAwards()
	self._txtGain:setText(g.core.model.User.newSlgData:hasGetFarmRentAwards() .. "/" .. g.core.model.User.newSlgDevelopData:getFarmRentLimit())

	local var_3_0 = g.core.model.User.newSlgData:getFarmMaxLimit()

	self._titleComp:setTitle(g.core.lang:get("NEW_SLG_FARM_HAS_TITLE", {
		num1 = #self._farmsArr,
		num2 = var_3_0
	}))
	self._listAward:setNumItems(var_3_0)
	self._btnGet:removeBtnEffect()

	if not g.core.model.User.newSlgData:canGetFarmAward() then
		self._btnGet:setStyleWithGrayTip(2, g.core.lang:get("NEW_SLG_FARM_GAIN_NO"))
	else
		self._btnGet:setStyleWithGrayTip(0)
		self._btnGet:addBtnEffect()
	end
end

function NewSlgSupplyFarmComp:_updateHonor(arg_4_1)
	self._txtHonor:setText(arg_4_1 .. "/" .. g.core.model.User.newSlgDevelopData:getSupplyCfg().farm_contribution_num)
end

function NewSlgSupplyFarmComp:_updateAwards()
	local var_5_0 = g.core.model.User.newSlgDevelopData:getSupplyProductionItem()
	local var_5_1 = g.core.model.User.newSlgData:canGetFarmOccupyAwards()

	self._compAward:updateIcon({
		effect = true,
		type = var_5_0.type,
		value = var_5_0.value,
		size = var_5_1
	})
	self._compAward:setClick(handler(self, self._onClickFarmAward))
	self._isEmptyCtrl:setSelectedIndex(var_5_1 > 0 and 0 or 1)
end

function NewSlgSupplyFarmComp:onRcvGetFarmInfo(arg_6_1)
	self._farmsArr = arg_6_1.farms or {}

	self:updateView()

	if arg_6_1.daily_farm_kill_score then
		self:_updateHonor(arg_6_1.daily_farm_kill_score)
	end
end

function NewSlgSupplyFarmComp:_checkFull()
	local var_7_0 = g.core.model.User.newSlgDevelopData:getSupplyProductionItem()

	if g.core.model.User.newSlgDevelopData:getSupplyCfg().storage_limit <= g.model.bag:getOwnNum(var_7_0.type, var_7_0.value) then
		g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_PRODUCT_CALL_FULL_TIPS"))

		return true
	end

	return false
end

function NewSlgSupplyFarmComp:_sendCall1()
	if not self._btnGet:getIsGray() then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserFarmAward({
			is_one_key = true
		})
	end
end

function NewSlgSupplyFarmComp:_sendCall2()
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserFarmAward({
		is_farm = true
	})
end

function NewSlgSupplyFarmComp:_onClickBtnGet()
	if self:_checkFull() then
		return
	end

	if g.core.model.User.newSlgData:canGetFarmOccupyAwards() == 0 and g.core.model.User.newSlgData:isFarmRentLimit() then
		g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_FARM_LIMIT_TIP"))

		return
	end

	self:_sendCall1()
end

function NewSlgSupplyFarmComp:_onClickFarmAward()
	if self:_checkFull() then
		return
	end

	self:_sendCall2()
end

function NewSlgSupplyFarmComp:_onRenderListAwardCell(arg_12_1, arg_12_2)
	arg_12_2:updateCell(self._farmsArr[arg_12_1 + 1])
end

return NewSlgSupplyFarmComp
