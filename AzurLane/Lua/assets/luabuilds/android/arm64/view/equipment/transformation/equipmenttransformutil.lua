local var_0_0 = {}

var_0_0.__name = "EquipmentTransformUtil"

function var_0_0.SameDrop(arg_1_0, arg_1_1)
	if arg_1_0.type ~= arg_1_1.type then
		return false
	end

	local var_1_0 = arg_1_0.type

	DROP_TYPE_EQUIP = var_3

	if var_1_0 == var_3 then
		EquipmentProxy = var_1_0

		return var_1_0.SameEquip(arg_1_0.template, arg_1_1.template)
	else
		return arg_1_0.id == arg_1_1.id
	end

	return
end

function var_0_0.CheckEquipmentFormulasSucceed(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)

	getProxy = var_1_10003
	BagProxy = var_1_10005

	local var_2_1 = var_1_10003(var_1_10005)
	local var_2_2 = {}
	local var_2_3 = arg_2_1

	ipairs = var_1_10006

	for iter_2_0, iter_2_1 in var_1_10006(arg_2_0) do
		pg = var_1_10011
		var_1_10011 = var_1_10011.equip_upgrade_data[iter_2_1]
		Equipment = var_1_10012
		var_1_10012 = var_1_10012.GetRevertRewardsStatic(var_2_3)
		assert = var_1_10013
		Equipment = var_1_10015

		var_1_10013(var_1_10015.CanInBag(var_2_3), "Missing equip_data_template ID: " .. (var_2_3 or "NIL"))

		Equipment = var_1_10013

		if var_1_10013.CanInBag(var_2_3) then
			Equipment = var_1_10013

			if not var_1_10013.getConfigData(var_2_3).destory_gold then
				var_1_10013 = 0
			end

			Equipment = var_14
			var_2_3 = var_14.GetEquipRootStatic(var_2_3)
			assert = var_14

			var_14(var_1_10011 and var_1_10011.upgrade_from == var_2_3, "Transform a non formula equipment, formula " .. (iter_2_1 or -1) .. " equipment " .. (var_2_3 or -1))

			local var_2_4 = var_1_10011.material_consume

			ipairs = var_1_10015

			for iter_2_2, iter_2_3 in var_1_10015(var_2_4) do
				local var_2_5 = iter_2_3[1]
				local var_2_6 = iter_2_3[2]
				local var_2_7

				if not var_2_2[var_2_5] and not var_2_1:getItemCountById(var_2_5) then
					var_2_7 = 0
				end

				var_2_2[var_2_5] = var_2_7 - var_2_6

				if var_2_2[var_2_5] < 0 then
					Item = var_23

					local var_2_8 = var_23.getConfigData(var_2_5)

					return false, var_2_8 and var_2_8.name
				end
			end

			if not var_2_2.gold and not var_2_0:getRawData().gold then
				var_1_10015 = 0
			end

			var_2_2.gold = var_1_10015 - var_1_10011.coin_consume

			if var_2_2.gold < 0 then
				var_1_10015 = false
				Drop = var_16

				local var_2_9 = var_16.New
				local var_2_10 = {}

				DROP_TYPE_RESOURCE = iter_2_3
				var_2_10.type = iter_2_3
				PlayerConst = iter_2_3
				var_2_10.id = iter_2_3.ResGold

				local var_2_11 = var_2_9(var_2_10)
				local var_2_12 = var_16.getName(var_2_11)

				return
			end

			pairs = var_1_10015

			for iter_2_4, iter_2_5 in var_1_10015(var_1_10012) do
				if iter_2_4 ~= "gold" then
					local var_2_13

					if not var_2_2[iter_2_4] then
						var_2_13 = 0
					end

					var_2_2[iter_2_4] = var_2_13 + iter_2_5
				end
			end

			if not var_2_2.gold then
				var_1_10015 = 0
			end

			var_2_2.gold = var_1_10015 + var_1_10013
			var_2_3 = var_1_10011.target_id
		end
	end

	return true
end

function var_0_0.CheckTransformFormulasSucceed(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	getProxy = var_1_10003
	BagProxy = var_1_10005

	local var_3_1 = var_1_10003(var_1_10005)
	local var_3_2 = {}
	local var_3_3 = var_3_0
	local var_3_4

	if not var_3_0.getRawData(var_3_3).gold then
		var_3_4 = 0
	end

	var_3_2.gold = var_3_4

	local var_3_5
	local var_3_6 = arg_3_1.type

	DROP_TYPE_EQUIP = var_3_3

	if var_3_6 == var_3_3 then
		var_3_5 = arg_3_1.id

		if not arg_3_1.template.shipId then
			getProxy = var_3_6
			EquipmentProxy = var_1_10008
			var_1_10008 = var_3_6(var_1_10008)

			if not var_3_6.getEquipmentById(var_1_10008, var_3_5) or var_3_6.count <= 0 then
				var_3_3 = false
				Equipment = var_1_10008

				return var_3_3, var_1_10008.getConfigData(var_3_5).name
			end
		end
	else
		var_3_6 = arg_3_1.type
		DROP_TYPE_ITEM = var_3_3

		if var_3_6 == var_3_3 then
			if var_3_2.gold < arg_3_1.composeCfg.gold_num then
				var_3_3 = false
				Drop = var_1_10008

				local var_3_7 = var_1_10008.New
				local var_3_8 = {}

				DROP_TYPE_RESOURCE = var_1_10011
				var_3_8.type = var_1_10011
				PlayerConst = var_1_10011
				var_3_8.id = var_1_10011.ResGold

				local var_3_9 = var_3_7(var_3_8)
				local var_3_10 = var_8.getName(var_3_9)

				return
			else
				if not var_3_1:getItemCountById(arg_3_1.composeCfg.material_id) then
					var_3_3 = 0
				end

				if var_3_3 < arg_3_1.composeCfg.material_num then
					var_3_3 = false
					Item = var_8

					return var_3_3, var_8.getConfigData(arg_3_1.composeCfg.material_id).name
				end
			end

			var_3_2.gold = var_3_2.gold - arg_3_1.composeCfg.gold_num
			var_3_5 = arg_3_1.composeCfg.equip_id
		end
	end

	assert = var_3_6

	var_3_6(var_3_5)

	local var_3_11 = var_3_5

	ipairs = var_3_3

	for iter_3_0, iter_3_1 in var_3_3(arg_3_0) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.equip_upgrade_data[iter_3_1]
		Equipment = var_1_10013
		var_1_10013 = var_1_10013.GetRevertRewardsStatic(var_3_11)
		assert = var_1_10014
		Equipment = var_1_10016

		var_1_10014(var_1_10016.CanInBag(var_3_11), "Missing equip_data_template ID: " .. (var_3_11 or "NIL"))

		Equipment = var_1_10014

		if var_1_10014.CanInBag(var_3_11) then
			Equipment = var_1_10014

			if not var_1_10014.getConfigData(var_3_11).destory_gold then
				var_1_10014 = 0
			end

			Equipment = var_15
			var_3_11 = var_15.GetEquipRootStatic(var_3_11)
			assert = var_15

			var_15(var_1_10012 and var_1_10012.upgrade_from == var_3_11, "Transform a non formula equipment, formula " .. (iter_3_1 or -1) .. " equipment " .. (var_3_11 or -1))

			local var_3_12 = var_1_10012.material_consume

			ipairs = var_1_10016

			for iter_3_2, iter_3_3 in var_1_10016(var_3_12) do
				local var_3_13 = iter_3_3[1]
				local var_3_14 = iter_3_3[2]
				local var_3_15

				if not var_3_2[var_3_13] and not var_3_1:getItemCountById(var_3_13) then
					var_3_15 = 0
				end

				var_3_2[var_3_13] = var_3_15 - var_3_14

				if var_3_2[var_3_13] < 0 then
					Item = var_24

					local var_3_16 = var_24.getConfigData(var_3_13)

					return false, var_3_16 and var_3_16.name
				end
			end

			var_3_2.gold = var_3_2.gold - var_1_10012.coin_consume

			if var_3_2.gold < 0 then
				var_1_10016 = false
				Drop = var_17

				local var_3_17 = var_17.New
				local var_3_18 = {}

				DROP_TYPE_RESOURCE = iter_3_3
				var_3_18.type = iter_3_3
				PlayerConst = iter_3_3
				var_3_18.id = iter_3_3.ResGold

				local var_3_19 = var_3_17(var_3_18)
				local var_3_20 = var_17.getName(var_3_19)

				return
			end

			pairs = var_1_10016

			for iter_3_4, iter_3_5 in var_1_10016(var_1_10013) do
				if iter_3_4 ~= "gold" then
					local var_3_21

					if not var_3_2[iter_3_4] then
						var_3_21 = var_3_1:getItemCountById(iter_3_4)
					end

					var_3_2[iter_3_4] = var_3_21 + iter_3_5
				end
			end

			if not var_3_2.gold then
				var_1_10016 = 0
			end

			var_3_2.gold = var_1_10016 + var_1_10014
			var_3_11 = var_1_10012.target_id
		end
	end

	return true
end

function var_0_0.CheckTransformEnoughGold(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)

	getProxy = var_1_10003
	BagProxy = var_1_10005

	local var_4_1 = var_1_10003(var_1_10005)
	local var_4_2

	if not var_4_0:getRawData().gold then
		var_4_2 = 0
	end

	local var_4_3 = 0
	local var_4_4 = 0
	local var_4_5 = true
	local var_4_6
	local var_4_7 = arg_4_1.type

	DROP_TYPE_EQUIP = var_1_10010

	if var_4_7 == var_1_10010 then
		var_4_6 = arg_4_1.id
	else
		var_4_7 = arg_4_1.type
		DROP_TYPE_ITEM = var_1_10010

		if var_4_7 == var_1_10010 then
			var_4_2 = var_4_2 - arg_4_1.composeCfg.gold_num
			var_4_4 = var_4_4 + arg_4_1.composeCfg.gold_num
			var_4_5 = var_4_5 and 0 <= var_4_2
			var_4_6 = arg_4_1.composeCfg.equip_id
		end
	end

	assert = var_4_7

	var_4_7(var_4_6)

	local var_4_8 = var_4_6

	ipairs = var_1_10010

	for iter_4_0, iter_4_1 in var_1_10010(arg_4_0) do
		pg = var_1_10015
		var_1_10015 = var_1_10015.equip_upgrade_data[iter_4_1]
		Equipment = var_1_10016
		var_1_10016 = var_1_10016.GetRevertRewardsStatic(var_4_8)
		assert = var_1_10017
		Equipment = var_1_10019

		var_1_10017(var_1_10019.CanInBag(var_4_8), "Missing equip_data_template ID: " .. (var_4_8 or "NIL"))

		Equipment = var_1_10017

		if var_1_10017.CanInBag(var_4_8) then
			Equipment = var_1_10017

			if not var_1_10017.getConfigData(var_4_8).destory_gold then
				var_1_10017 = 0
			end

			Equipment = var_18
			var_4_8 = var_18.GetEquipRootStatic(var_4_8)
			assert = var_18

			var_18(var_1_10015 and var_1_10015.upgrade_from == var_4_8, "Transform a non formula equipment, formula " .. (iter_4_1 or -1) .. " equipment " .. (var_4_8 or -1))

			var_4_2 = var_4_2 - var_1_10015.coin_consume
			var_4_3 = var_4_3 + var_1_10015.coin_consume
			var_4_5 = var_4_5 and 0 <= var_4_2
			pairs = var_18

			for iter_4_2, iter_4_3 in var_18(var_1_10016) do
				if iter_4_2 ~= "gold" then
					var_4_2 = var_4_2 + iter_4_3
				end
			end

			var_4_2 = var_4_2 + var_1_10017
			var_4_8 = var_1_10015.target_id
		end
	end

	return var_4_5, var_4_3, var_4_4
end

local function var_0_1(arg_5_0, arg_5_1)
	local var_5_0 = {
		{
			"icon_bg/slv"
		},
		{
			"icon_bg/frame/IconColorful(Clone)"
		},
		{
			"icon_bg/frame/Item_duang5(Clone)"
		},
		{
			"icon_bg/frame/specialFrame"
		},
		{
			"ship_type"
		},
		{
			"icon_bg/new"
		},
		{
			"icon_bg/npc"
		}
	}

	ipairs = var_3

	for iter_5_0, iter_5_1 in var_3(var_5_0) do
		var_1_10008 = arg_5_0:Find(iter_5_1[1])
		type = var_1_10009

		if var_1_10009 ~= iter_5_1[2] then
			IsNil = var_1_10009

			if not var_1_10009(var_1_10008) then
				setActive = var_1_10009

				var_1_10009(var_1_10008, false)
			end
		end
	end

	local var_5_1 = arg_5_0:Find("icon_bg/frame")
	local var_5_2 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_5_2(var_5_1, var_6(var_1_10008)).enabled = true

	return
end

return var_0_0
