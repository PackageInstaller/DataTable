local NewSlgSupplyFarmGainComp = class("NewSlgSupplyFarmGainComp")

function NewSlgSupplyFarmGainComp:ctor()
	self._compAward = self:getChild("Comp_award")
	self._txtName = self:getChild("Txt_name")
	self._isEmptyCtrl = self:getController("isempty")

	self:getChild("Btn_go"):addClickListener(handler(self, self._onClickGo))
end

function NewSlgSupplyFarmGainComp:updateCell(arg_2_1)
	if not arg_2_1 then
		self._isEmptyCtrl:setSelectedIndex(1)

		return
	end

	self._data = arg_2_1

	local var_2_0 = g.core.model.User.newSlgDevelopData:getSupplyProductionItem()
	local var_2_1 = arg_2_1.rent_num == 0
	local var_2_2 = arg_2_1.rent_num ~= 0 and not g.core.model.User.newSlgData:isFarmRentLimit()

	self._isEmptyCtrl:setSelectedIndex(0)
	self._compAward:updateIcon({
		type = var_2_0.type,
		value = var_2_0.value,
		size = arg_2_1.rent_num,
		effect = var_2_2,
		emptyTxt = g.core.lang:get("NEW_SLG_FARM_RENT_NO"),
		empty = var_2_1
	})

	local var_2_3 = g.core.config.new_slg_farm_info.get(self._data.farm_id)

	self._txtName:setText(g.core.lang:get("LEVEL_FORMAT", {
		level = var_2_3.level
	}) .. " " .. var_2_3.name .. "·" .. g.core.config.new_slg_city_info.get(var_2_3.belong).name)

	if var_2_1 then
		self._compAward:setClick(function()
			return
		end)
	elseif var_2_2 then
		self._compAward:setClick(handler(self, self._onClickFarmAward))
	end
end

function NewSlgSupplyFarmGainComp:_onClickFarmAward()
	local var_4_0 = g.core.model.User.newSlgDevelopData:getSupplyProductionItem()

	if g.core.model.User.newSlgDevelopData:getSupplyCfg().storage_limit <= g.model.bag:getOwnNum(var_4_0.type, var_4_0.value) then
		g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_PRODUCT_CALL_FULL_TIPS"))

		return
	end

	if g.core.model.User.newSlgData:isFarmRentLimit() then
		g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_FARM_LIMIT_TIP"))

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserFarmAward({
		farm_id = self._data.farm_id
	})
end

function NewSlgSupplyFarmGainComp:_onClickGo()
	local var_5_0 = g.core.model.User.newSlgData:getFarmComponentById(self._data.farm_id)

	g.core.model.User.newSlgData:setJumpPos({
		x = var_5_0.anchor_x,
		y = var_5_0.anchor_y
	})
	self:dispatchCompEvent("NewSlgSupply_goto_farm")
end

return NewSlgSupplyFarmGainComp
