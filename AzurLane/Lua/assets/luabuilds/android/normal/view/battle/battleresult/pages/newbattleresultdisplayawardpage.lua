class = var_0_10000

local var_0_0 = "NewBattleResultDisplayAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseEventLogic"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1

	var_0_1.super.Ctor(arg_1_0, arg_1_2)

	arg_1_0.contextData = arg_1_3

	return
end

function var_0_1.ExecuteAction(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0[arg_2_1](arg_2_0, arg_2_2)

	return
end

function var_0_1.SetUp(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = arg_3_0:CollectDrops()

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.ShowAwards(var_4_0, var_3_0, var_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.ShowShips(var_5_0, var_3_0, arg_5_0)

			return
		end
	}, arg_3_1)

	return
end

function var_0_1.ShowShips(arg_6_0, arg_6_1, arg_6_2)
	_ = var_1_10003

	local var_6_0 = #var_1_10003.filter(arg_6_1, function(arg_7_0)
		local var_7_0 = arg_7_0.type

		DROP_TYPE_SHIP = var_2_10002

		return var_7_0 == var_2_10002
	end)

	getProxy = var_4
	BayProxy = var_5

	local var_6_1 = var_4(var_5)
	local var_6_2 = var_4.getNewShip(var_6_1, true)
	local var_6_3 = {}

	_ = var_6

	var_6.each(var_6_2, function(arg_8_0)
		if arg_8_0:isMetaShip() then
			table = var_1

			var_1.insert(var_6_3, arg_8_0.configId)
		end

		return
	end)

	_ = var_6

	var_6.each(arg_6_1, function(arg_9_0)
		local var_9_0

		if not arg_9_0.configId then
			var_9_0 = arg_9_0.id
		end

		Ship = var_2_10002

		if var_2_10002.isMetaShipByConfigID(var_9_0) then
			table = var_2

			if var_2.indexof(var_6_3, var_9_0) then
				table = var_3

				var_3.remove(var_6_3, var_2)
			else
				Ship = var_3

				local var_9_1 = var_3.New({
					configId = var_9_0
				})

				getProxy = var_4
				BayProxy = var_2_10005

				local var_9_2 = var_4(var_2_10005)

				if var_4.getMetaTransItemMap(var_9_2, var_9_1.configId) then
					var_9_1:setReMetaSpecialItemVO(var_4)
				end

				table = var_9_2

				var_9_2.insert(var_6_2, var_9_1)
			end
		end

		return
	end)

	local var_6_4 = {}

	math = var_7

	for iter_6_0 = var_7.max(1, #var_6_2 - var_6_0 + 1), #var_6_2 do
		local var_6_5 = var_6_2[iter_6_0]

		PlayerPrefs = var_1_10012
		var_1_10012 = var_1_10012.GetInt
		DISPLAY_SHIP_GET_EFFECT = var_1_10013

		if var_1_10012(var_1_10013) ~= 1 then
			if not var_6_5.virgin then
				var_1_10013 = var_6_5
				var_1_10012 = var_6_5.getRarity(var_1_10013)
				ShipRarity = var_1_10013

				if not (var_1_10013.Purple <= var_1_10012) then
					var_1_10012 = false

					goto label_6_0
				end

				var_1_10012 = true
			end

			::label_6_0::

			if var_1_10012 then
				var_1_10013 = arg_6_0.contextData.system
				SYSTEM_SCENARIO = var_1_10014
				var_1_10013 = var_1_10013 == var_1_10014 and arg_6_0.contextData.autoSkipFlag
				table = var_1_10014

				var_1_10014.insert(var_6_4, function(arg_10_0)
					local var_10_0 = var_1_10013 and not var_6_5.virgin and 3 or nil
					local var_10_1 = arg_6_0
					local var_10_2 = var_2.emit

					NewBattleResultMediator = var_2_10004

					var_10_2(var_10_1, var_2_10004.GET_NEW_SHIP, var_6_5, arg_10_0, var_10_0)

					return
				end)
			end
		end
	end

	seriesAsync = var_7

	var_7(var_6_4, arg_6_2)

	return
end

function var_0_1.ShowAwards(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.contextData.autoSkipFlag

	if #arg_11_1 > 0 then
		local var_11_1 = arg_11_0
		local var_11_2 = arg_11_0.emit

		BaseUI = var_1_10007

		var_11_2(var_11_1, var_1_10007.ON_AWARD, {
			items = arg_11_1,
			extraBonus = arg_11_2,
			removeFunc = arg_11_3,
			closeOnCompleted = var_11_0
		})
	else
		arg_11_3()
	end

	return
end

function var_0_1.CollectDrops(arg_12_0)
	local var_12_0 = false
	local var_12_1 = {}

	NewBattleResultYumiaMaterialPage = var_1_10003

	local var_12_2 = var_1_10003.YUMIA_MATERIAL_DROP_TYPE_LIST

	ipairs = var_1_10004

	local var_12_3

	if not arg_12_0.contextData.drops then
		var_12_3 = {}
	end

	for iter_12_0, iter_12_1 in var_1_10004(var_12_3) do
		table = var_1_10009

		if not var_1_10009.contains(var_12_2, iter_12_1.type) then
			table = var_1_10009

			var_1_10009.insert(var_12_1, iter_12_1)
		end
	end

	ipairs = var_4

	local var_12_4

	if not arg_12_0.contextData.extraDrops then
		var_12_4 = {}
	end

	for iter_12_2, iter_12_3 in var_4(var_12_4) do
		iter_12_3.riraty = true
		table = var_9

		if not var_9.contains(var_12_2, iter_12_3.type) then
			table = var_9

			var_9.insert(var_12_1, iter_12_3)
		end
	end

	local var_12_5 = arg_12_0.contextData.extraBuffList

	ipairs = var_5

	for iter_12_4, iter_12_5 in var_5(var_12_5 or {}) do
		pg = var_1_10010

		local var_12_6 = var_1_10010.benefit_buff_template[iter_12_5].benefit_type

		Chapter = var_1_10012

		if var_12_6 == var_1_10012.OPERATION_BUFF_TYPE_REWARD then
			var_12_0 = true

			break
		end
	end

	return var_12_1, var_12_0
end

function var_0_1.Destroy(arg_13_0)
	arg_13_0.exited = true

	return
end

return var_0_1
