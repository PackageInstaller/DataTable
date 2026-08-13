class = var_0_10000

local var_0_0 = var_0_10000("IslandOrderSlot")

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
	if not var_0_0.TENDENCY_2_TIP then
		local var_1_0 = var_0_0
		local var_1_1 = {}

		i18n = var_1_10003
		var_1_1[1] = var_1_10003("island_order_desc_1")
		i18n = var_3
		var_1_1[2] = var_3("island_order_desc_2")
		i18n = var_3
		var_1_1[3] = var_3("island_order_desc_3")
		var_1_0.TENDENCY_2_TIP = var_1_1
	end

	return var_0_0.TENDENCY_2_TIP[arg_1_0 + 1]
end

function var_0_0.TENDENCY2CN(arg_2_0)
	if not var_0_0.TENDENCY_2_CN then
		local var_2_0 = var_0_0
		local var_2_1 = {}

		i18n = var_1_10003
		var_2_1[1] = var_1_10003("island_order_difficulty_1")
		i18n = var_3
		var_2_1[2] = var_3("island_order_difficulty_2")
		i18n = var_3
		var_2_1[3] = var_3("island_order_difficulty_3")
		var_2_0.TENDENCY_2_CN = var_2_1
	end

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
	local var_5_0 = arg_5_1.type

	IslandOrder = var_1_10003

	if var_5_0 == var_1_10003.TYPE_NORMAL then
		IslandOrder = var_5_0

		return var_5_0.New(arg_5_1)
	else
		var_5_0 = arg_5_1.type
		IslandOrder = var_3

		if var_5_0 == var_3.TYPE_URGENCY then
			IslandUrgencyOrder = var_5_0

			return var_5_0.New(arg_5_1)
		else
			var_5_0 = arg_5_1.type
			IslandOrder = var_3

			if var_5_0 == var_3.TYPE_FORM then
				pg = var_5_0
				var_5_0 = var_5_0.island_order[arg_5_1.id].type
				IslandFirmOrder = var_3

				if var_5_0 == var_3.FIRM_ORDER_TYPE_URGENCY then
					IslandFirmUrgencyOrder = var_3

					return var_3.New(arg_5_1)
				else
					IslandFirmOrder = var_3

					if var_5_0 == var_3.FIRM_ORDER_TYPE_ACT then
						IslandFirmActivityOrder = var_3

						return var_3.New(arg_5_1)
					else
						IslandFirmOrder = var_3

						if var_5_0 == var_3.FIRM_ORDER_TYPE_COMMON then
							IslandFirmOrder = var_3

							return var_3.New(arg_5_1)
						else
							assert = var_3

							var_3(false, "typ is nil" .. var_5_0)
						end
					end
				end
			end
		end
	end

	assert = var_5_0

	var_5_0(false, "order should be exist" .. arg_5_1.type)

	return
end

function var_0_0.GetPosition(arg_6_0)
	pg = var_1_10001

	local var_6_0

	if not var_1_10001.island_order_position[arg_6_0.position] or not arg_6_0.position then
		var_6_0 = 1
	end

	pg = var_2

	local var_6_1 = var_2.island_order_position[var_6_0].position

	Vector3 = var_1_10003

	return var_1_10003(var_6_1[1], var_6_1[2], 0)
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
	local var_8_0 = arg_8_0.order

	return var_1.GetCanSubmitTime(var_8_0)
end

function var_0_0.GetDisappearTime(arg_9_0)
	local var_9_0 = arg_9_0.order

	return var_1.GetDisappearTime(var_9_0)
end

function var_0_0.GetTotalTime(arg_10_0)
	local var_10_0 = arg_10_0.order

	return var_1.GetTotalTime(var_10_0)
end

function var_0_0.CanSubmit(arg_11_0)
	if arg_11_0:IsEmpty() then
		return false
	end

	if arg_11_0:IsLoading() then
		return false
	end

	local var_11_0 = arg_11_0.order

	return var_1.CanFinish(var_11_0)
end

function var_0_0.IsEmpty(arg_12_0)
	local var_12_0 = arg_12_0.order

	return var_1.IsEmpty(var_12_0)
end

function var_0_0.IsLoading(arg_13_0)
	local var_13_0 = arg_13_0.order

	return var_1.IsLoading(var_13_0)
end

function var_0_0.CanReplace(arg_14_0)
	local var_14_0 = arg_14_0.order

	return var_1.CanReplace(var_14_0)
end

function var_0_0.GetOrder(arg_15_0)
	return arg_15_0.order
end

function var_0_0.SetReduceTime(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.order

	var_2.SetReduceTime(var_16_0, arg_16_1)

	return
end

function var_0_0.AddReduceTime(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.order

	var_2.AddReduceTime(var_17_0, arg_17_1)

	return
end

return var_0_0
