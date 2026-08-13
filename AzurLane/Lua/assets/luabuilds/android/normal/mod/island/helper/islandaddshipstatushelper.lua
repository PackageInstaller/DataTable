class = var_0_10000

local var_0_0 = var_0_10000("IslandAddShipStatusHelper")

function var_0_0.CheckAddStatus(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	pg = var_1_10004

	local var_1_0 = var_1_10004.island_buff_template[arg_1_2]

	assert = var_1_10005

	var_1_10005(var_1_0, arg_1_2)

	local var_1_1 = var_0_0

	var_1_1.tipList = {}
	seriesAsync = var_1_1

	var_1_1({
		function(arg_2_0)
			var_0_0.CheckType(arg_1_0, arg_1_1, var_1_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick = var_2_10001

			var_2_10001(arg_3_0)

			return
		end,
		function(arg_4_0)
			var_0_0.CheckSpecific(arg_1_0, arg_1_1, var_1_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick = var_2_10001

			var_2_10001(arg_5_0)

			return
		end,
		function(arg_6_0)
			var_0_0.CheckLevelInSameGroup(arg_1_0, arg_1_1, var_1_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			var_0_0.tipList = {}

			arg_7_0()

			return
		end
	}, arg_1_3)

	return
end

function var_0_0.IsTip(arg_8_0)
	table = var_1_10001

	return var_1_10001.contains(var_0_0.tipList, arg_8_0)
end

function var_0_0.CheckType(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2.type_duel
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.GetVaildStatus(var_9_1)

	_ = var_9_1

	if var_9_1.detect(var_9_2, function(arg_10_0)
		table = var_2_10001

		return var_2_10001.contains(var_9_0, arg_10_0:GetGroup())
	end) and not var_0_0.IsTip(var_6.id) then
		local var_9_3 = arg_9_0
		local var_9_4 = arg_9_0.ShowMsgBox
		local var_9_5 = {}

		i18n = var_1_10010
		var_9_5.content = var_1_10010("island_ship_buff_cover")
		IslandMsgBox = var_10
		var_9_5.type = var_10.TYPE_SHIP_STATUS_MSG
		var_9_5.buff = var_6
		var_9_5.onYes = arg_9_3

		var_9_4(var_9_3, var_9_5)

		table = var_9_4

		var_9_4.insert(var_0_0.tipList, var_6.id)
	else
		arg_9_3()
	end

	return
end

function var_0_0.CheckSpecific(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2.buff_duel
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.GetVaildStatus(var_11_1)

	_ = var_11_1

	if var_11_1.detect(var_11_2, function(arg_12_0)
		table = var_2_10001

		return var_2_10001.contains(var_11_0, arg_12_0.id)
	end) and not var_0_0.IsTip(var_6.id) then
		local var_11_3 = arg_11_0
		local var_11_4 = arg_11_0.ShowMsgBox
		local var_11_5 = {}

		i18n = var_1_10010
		var_11_5.content = var_1_10010("island_ship_buff_cover_1")
		IslandMsgBox = var_10
		var_11_5.type = var_10.TYPE_SHIP_STATUS_MSG
		var_11_5.buff = var_6
		var_11_5.onYes = arg_11_3

		var_11_4(var_11_3, var_11_5)

		table = var_11_4

		var_11_4.insert(var_0_0.tipList, var_6.id)
	else
		arg_11_3()
	end

	return
end

function var_0_0.CheckLevelInSameGroup(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.GetVaildStatusByGroup(var_13_0, arg_13_2.buff_group)

	_ = var_13_0

	if var_13_0.detect(var_13_1, function(arg_14_0)
		return arg_14_0:GetLevel() > arg_13_2.buff_level
	end) and not var_0_0.IsTip(var_5.id) then
		local var_13_2 = arg_13_0
		local var_13_3 = arg_13_0.ShowMsgBox
		local var_13_4 = {}

		i18n = var_1_10009
		var_13_4.content = var_1_10009("island_ship_buff_cover_2")
		IslandMsgBox = var_1_10009
		var_13_4.type = var_1_10009.TYPE_SHIP_STATUS_MSG
		var_13_4.buff = var_5
		var_13_4.onYes = arg_13_3

		var_13_3(var_13_2, var_13_4)
	else
		if #var_13_1 > 0 then
			_ = var_6

			if var_6.all(var_13_1, function(arg_15_0)
				return arg_15_0:GetLevel() < arg_13_2.buff_level
			end) and not var_0_0.IsTip(var_13_1[1].id) then
				local var_13_5 = arg_13_0
				local var_13_6 = arg_13_0.ShowMsgBox
				local var_13_7 = {}

				i18n = var_1_10009
				var_13_7.content = var_1_10009("island_ship_buff_cover_3")
				IslandMsgBox = var_9
				var_13_7.type = var_9.TYPE_SHIP_STATUS_MSG
				var_13_7.buff = var_13_1[1]
				var_13_7.onYes = arg_13_3

				var_13_6(var_13_5, var_13_7)

				goto label_13_0
			end
		end

		arg_13_3()
	end

	::label_13_0::

	return
end

return var_0_0
