local var_0_0 = class("IslandAddShipStatusHelper")

function var_0_0.CheckAddStatus(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert(pg.island_buff_template[arg_1_2], arg_1_2)

	var_0_0.tipList = {}

	seriesAsync({
		function(arg_2_0)
			var_0_0.CheckType(arg_1_0, arg_1_1, var_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			var_0_0.CheckSpecific(arg_1_0, arg_1_1, var_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick(arg_5_0)

			return
		end,
		function(arg_6_0)
			var_0_0.CheckLevelInSameGroup(arg_1_0, arg_1_1, var_0, arg_6_0)

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
	return table.contains(var_0_0.tipList, arg_8_0)
end

function var_0_0.CheckType(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2.type_duel
	local var_9_1 = _.detect(arg_9_1:GetVaildStatus(), function(arg_10_0)
		return table.contains(var_9_0, arg_10_0:GetGroup())
	end)

	if var_9_1 and not var_0_0.IsTip(var_9_1.id) then
		arg_9_0:ShowMsgBox({
			content = i18n("island_ship_buff_cover"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_9_1,
			onYes = arg_9_3
		})
		table.insert(var_0_0.tipList, var_9_1.id)
	else
		arg_9_3()
	end

	return
end

function var_0_0.CheckSpecific(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2.buff_duel
	local var_11_1 = _.detect(arg_11_1:GetVaildStatus(), function(arg_12_0)
		return table.contains(var_11_0, arg_12_0.id)
	end)

	if var_11_1 and not var_0_0.IsTip(var_11_1.id) then
		arg_11_0:ShowMsgBox({
			content = i18n("island_ship_buff_cover_1"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_11_1,
			onYes = arg_11_3
		})
		table.insert(var_0_0.tipList, var_11_1.id)
	else
		arg_11_3()
	end

	return
end

function var_0_0.CheckLevelInSameGroup(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetVaildStatusByGroup(arg_13_2.buff_group)
	local var_13_1 = _.detect(var_13_0, function(arg_14_0)
		return arg_14_0:GetLevel() > arg_13_2.buff_level
	end)

	if var_13_1 and not var_0_0.IsTip(var_13_1.id) then
		arg_13_0:ShowMsgBox({
			content = i18n("island_ship_buff_cover_2"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_13_1,
			onYes = arg_13_3
		})
	elseif #var_13_0 > 0 and _.all(var_13_0, function(arg_15_0)
		return arg_15_0:GetLevel() < arg_13_2.buff_level
	end) and not var_0_0.IsTip(var_13_0[1].id) then
		arg_13_0:ShowMsgBox({
			content = i18n("island_ship_buff_cover_3"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_13_0[1],
			onYes = arg_13_3
		})
	else
		arg_13_3()
	end

	return
end

return var_0_0
