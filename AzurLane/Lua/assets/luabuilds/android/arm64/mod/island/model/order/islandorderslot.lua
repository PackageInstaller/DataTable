local var_0_0 = class("IslandOrderSlot")

var_0_0.STATE_EMPTY = 1
var_0_0.STATE_NORMAL = 2
var_0_0.STATE_LOADING = 3
var_0_0.STATE_CAN_FINISH = 4
var_0_0.SHOW_FLAG_TODAY = 0
var_0_0.SHOW_FLAG_TOMORROW = 1
var_0_0.TENDENCY_TYPE_COMMON = 0
var_0_0.TENDENCY_TYPE_EASY = 1
var_0_0.TENDENCY_TYPE_HARD = 2

function var_0_0.TENDENCY2TIP(arg_1_0)
	var_0_0.TENDENCY_2_TIP = var_0_0.TENDENCY_2_TIP or {
		i18n("island_order_desc_1"),
		i18n("island_order_desc_2"),
		i18n("island_order_desc_3")
	}

	return var_0_0.TENDENCY_2_TIP[arg_1_0 + 1]
end

function var_0_0.TENDENCY2CN(arg_2_0)
	var_0_0.TENDENCY_2_CN = var_0_0.TENDENCY_2_CN or {
		i18n("island_order_difficulty_1"),
		i18n("island_order_difficulty_2"),
		i18n("island_order_difficulty_3")
	}

	return var_0_0.TENDENCY_2_CN[arg_2_0 + 1]
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0:Flush(arg_3_1)

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1.id
	arg_4_0.position = arg_4_1.position
	arg_4_0.order = arg_4_0:GenOrder(arg_4_1)

	return
end

function var_0_0.GenOrder(arg_5_0, arg_5_1)
	if arg_5_1.type == IslandOrder.TYPE_NORMAL then
		return IslandOrder.New(arg_5_1)
	elseif arg_5_1.type == IslandOrder.TYPE_URGENCY then
		return IslandUrgencyOrder.New(arg_5_1)
	elseif arg_5_1.type == IslandOrder.TYPE_FORM then
		if pg.island_order[arg_5_1.id].type == IslandFirmOrder.FIRM_ORDER_TYPE_URGENCY then
			return IslandFirmUrgencyOrder.New(arg_5_1)
		elseif pg.island_order[arg_5_1.id].type == IslandFirmOrder.FIRM_ORDER_TYPE_ACT then
			return IslandFirmActivityOrder.New(arg_5_1)
		elseif pg.island_order[arg_5_1.id].type == IslandFirmOrder.FIRM_ORDER_TYPE_COMMON then
			return IslandFirmOrder.New(arg_5_1)
		else
			assert(false, "typ is nil" .. pg.island_order[arg_5_1.id].type)
		end
	end

	assert(false, "order should be exist" .. arg_5_1.type)

	return
end

function var_0_0.GetPosition(arg_6_0)
	if pg.island_order_position[arg_6_0.position] then
		local var_6_0 = arg_6_0.position or 1

		return Vector3(pg.island_order_position[var_6_0].position[1], pg.island_order_position[var_6_0].position[2], 0)
	end
end

function var_0_0.GetState(arg_7_0)
	if arg_7_0:IsLoading() then
		return var_0_0.STATE_LOADING
	end

	if arg_7_0:IsEmpty() then
		return var_0_0.STATE_EMPTY
	end

	if arg_7_0:CanSubmit() then
		return var_0_0.STATE_CAN_FINISH
	end

	return var_0_0.STATE_NORMAL
end

function var_0_0.GetCanSubmitTime(arg_8_0)
	return arg_8_0.order:GetCanSubmitTime()
end

function var_0_0.GetDisappearTime(arg_9_0)
	return arg_9_0.order:GetDisappearTime()
end

function var_0_0.GetTotalTime(arg_10_0)
	return arg_10_0.order:GetTotalTime()
end

function var_0_0.CanSubmit(arg_11_0)
	if arg_11_0:IsEmpty() then
		return false
	end

	if arg_11_0:IsLoading() then
		return false
	end

	return arg_11_0.order:CanFinish()
end

function var_0_0.IsEmpty(arg_12_0)
	return arg_12_0.order:IsEmpty()
end

function var_0_0.IsLoading(arg_13_0)
	return arg_13_0.order:IsLoading()
end

function var_0_0.CanReplace(arg_14_0)
	return arg_14_0.order:CanReplace()
end

function var_0_0.GetOrder(arg_15_0)
	return arg_15_0.order
end

function var_0_0.SetReduceTime(arg_16_0, arg_16_1)
	arg_16_0.order:SetReduceTime(arg_16_1)

	return
end

function var_0_0.AddReduceTime(arg_17_0, arg_17_1)
	arg_17_0.order:AddReduceTime(arg_17_1)

	return
end

return var_0_0
