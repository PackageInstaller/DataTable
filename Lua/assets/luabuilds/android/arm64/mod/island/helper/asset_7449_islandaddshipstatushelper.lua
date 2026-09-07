local IslandAddShipStatusHelper = class("IslandAddShipStatusHelper")

function IslandAddShipStatusHelper:CheckAddStatus(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = pg.island_buff_template[arg_1_2]

	assert(pg.island_buff_template[arg_1_2], arg_1_2)

	IslandAddShipStatusHelper.tipList = {}

	seriesAsync({
		function(arg_2_0)
			IslandAddShipStatusHelper.CheckType(self, arg_1_1, var_1_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			onNextTick(arg_3_0)

			return
		end,
		function(arg_4_0)
			IslandAddShipStatusHelper.CheckSpecific(self, arg_1_1, var_1_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick(arg_5_0)

			return
		end,
		function(arg_6_0)
			IslandAddShipStatusHelper.CheckLevelInSameGroup(self, arg_1_1, var_1_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			IslandAddShipStatusHelper.tipList = {}

			arg_7_0()

			return
		end
	}, arg_1_3)

	return
end

function IslandAddShipStatusHelper:IsTip()
	return table.contains(IslandAddShipStatusHelper.tipList, self)
end

function IslandAddShipStatusHelper:CheckType(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2.type_duel
	local var_9_1 = _.detect(arg_9_1:GetVaildStatus(), function(arg_10_0)
		return table.contains(var_9_0, arg_10_0:GetGroup())
	end)

	if var_9_1 and not IslandAddShipStatusHelper.IsTip(var_9_1.id) then
		self:ShowMsgBox({
			content = i18n("island_ship_buff_cover"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_9_1,
			onYes = arg_9_3
		})
		table.insert(IslandAddShipStatusHelper.tipList, var_9_1.id)
	else
		arg_9_3()
	end

	return
end

function IslandAddShipStatusHelper:CheckSpecific(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_2.buff_duel
	local var_11_1 = _.detect(arg_11_1:GetVaildStatus(), function(arg_12_0)
		return table.contains(var_11_0, arg_12_0.id)
	end)

	if var_11_1 and not IslandAddShipStatusHelper.IsTip(var_11_1.id) then
		self:ShowMsgBox({
			content = i18n("island_ship_buff_cover_1"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_11_1,
			onYes = arg_11_3
		})
		table.insert(IslandAddShipStatusHelper.tipList, var_11_1.id)
	else
		arg_11_3()
	end

	return
end

function IslandAddShipStatusHelper:CheckLevelInSameGroup(arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1:GetVaildStatusByGroup(arg_13_2.buff_group)
	local var_13_1 = _.detect(var_13_0, function(arg_14_0)
		return arg_14_0:GetLevel() > arg_13_2.buff_level
	end)

	if var_13_1 and not IslandAddShipStatusHelper.IsTip(var_13_1.id) then
		self:ShowMsgBox({
			content = i18n("island_ship_buff_cover_2"),
			type = IslandMsgBox.TYPE_SHIP_STATUS_MSG,
			buff = var_13_1,
			onYes = arg_13_3
		})
	elseif #var_13_0 > 0 and _.all(var_13_0, function(arg_15_0)
		return arg_15_0:GetLevel() < arg_13_2.buff_level
	end) and not IslandAddShipStatusHelper.IsTip(var_13_0[1].id) then
		self:ShowMsgBox({
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

return IslandAddShipStatusHelper
