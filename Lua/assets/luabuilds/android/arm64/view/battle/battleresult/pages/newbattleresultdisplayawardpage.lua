local var_0_0 = class("NewBattleResultDisplayAwardPage", import("view.base.BaseEventLogic"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1

	var_0_0.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.contextData = arg_1_3

	return
end

function var_0_0.ExecuteAction(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0[arg_2_1](arg_2_0, arg_2_2)

	return
end

function var_0_0.SetUp(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:CollectDrops()

	seriesAsync({
		function(arg_4_0)
			arg_3_0:ShowAwards(var_3_0, var_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_3_0:ShowShips(var_3_0, arg_5_0)

			return
		end
	}, arg_3_1)

	return
end

function var_0_0.ShowShips(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = getProxy(BayProxy):getNewShip(true)
	local var_6_1 = {}

	_.each(var_6_0, function(arg_8_0)
		if arg_8_0:isMetaShip() then
			table.insert(var_6_1, arg_8_0.configId)
		end

		return
	end)
	_.each(arg_6_1, function(arg_9_0)
		local var_9_0 = arg_9_0.configId or arg_9_0.id

		if Ship.isMetaShipByConfigID(var_9_0) then
			local var_9_1 = table.indexof(var_6_1, var_9_0)

			if var_9_1 then
				table.remove(var_6_1, var_9_1)
			else
				local var_9_2 = Ship.New({
					configId = var_9_0
				})
				local var_9_3 = getProxy(BayProxy):getMetaTransItemMap(var_9_2.configId)

				if var_9_3 then
					var_9_2:setReMetaSpecialItemVO(var_9_3)
				end

				table.insert(var_6_0, var_9_2)
			end
		end

		return
	end)

	local var_6_2 = {}

	for iter_6_0 = math.max(1, #var_6_0 - #_.filter(arg_6_1, function(arg_7_0)
		return arg_7_0.type == DROP_TYPE_SHIP
	end) + 1), #var_6_0 do
		local var_6_3 = var_6_0[iter_6_0]

		if PlayerPrefs.GetInt(DISPLAY_SHIP_GET_EFFECT) ~= 1 then
			local var_6_4 = var_6_0[iter_6_0].virgin

			if not var_6_0[iter_6_0].virgin then
				if var_6_0[iter_6_0]:getRarity() < ShipRarity.Purple then
					var_6_4 = false

					goto label_6_0
				end

				var_6_4 = true
			end

			::label_6_0::

			if var_6_4 then
				local var_6_5 = arg_6_0.contextData.system == SYSTEM_SCENARIO and arg_6_0.contextData.autoSkipFlag

				table.insert(var_6_2, function(arg_10_0)
					arg_6_0:emit(NewBattleResultMediator.GET_NEW_SHIP, var_6_3, arg_10_0, var_6_5 and not var_6_3.virgin and 3 or nil)

					return
				end)
			end
		end
	end

	seriesAsync(var_6_2, arg_6_2)

	return
end

function var_0_0.ShowAwards(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if #arg_11_1 > 0 then
		arg_11_0:emit(BaseUI.ON_AWARD, {
			items = arg_11_1,
			extraBonus = arg_11_2,
			removeFunc = arg_11_3,
			closeOnCompleted = arg_11_0.contextData.autoSkipFlag
		})
	else
		arg_11_3()
	end

	return
end

function var_0_0.CollectDrops(arg_12_0)
	local var_12_0 = false
	local var_12_1 = arg_12_0.contextData.drops or {}

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		if not table.contains(NewBattleResultYumiaMaterialPage.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_12_1.type) then
			table.insert({}, iter_12_1)
		end
	end

	local var_12_2 = arg_12_0.contextData.extraDrops or {}

	for iter_12_2, iter_12_3 in ipairs(var_12_2) do
		iter_12_3.riraty = true

		if not table.contains(NewBattleResultYumiaMaterialPage.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_12_3.type) then
			table.insert({}, iter_12_3)
		end
	end

	for iter_12_4, iter_12_5 in ipairs(arg_12_0.contextData.extraBuffList or {}) do
		if pg.benefit_buff_template[iter_12_5].benefit_type == Chapter.OPERATION_BUFF_TYPE_REWARD then
			var_12_0 = true

			break
		end
	end

	return {}, var_12_0
end

function var_0_0.Destroy(arg_13_0)
	arg_13_0.exited = true

	return
end

return var_0_0
