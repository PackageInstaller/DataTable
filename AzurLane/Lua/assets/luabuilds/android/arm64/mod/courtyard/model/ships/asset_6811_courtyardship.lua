class = var_0_10000

local var_0_0 = "CourtYardShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..map.CourtYardDepthItem"))

var_0_1.STATE_IDLE = 0
var_0_1.STATE_MOVE = 1
var_0_1.STATE_MOVING_ZERO = 2
var_0_1.STATE_MOVING_HALF = 3
var_0_1.STATE_MOVING_ONE = 4
var_0_1.STATE_DRAG = 5
var_0_1.STATE_TOUCH = 6
var_0_1.STATE_GETAWARD = 7
var_0_1.STATE_STOP = 8
var_0_1.STATE_INTERACT = 9
var_0_1.STATE_CANCEL_INTERACT = 10

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.id = arg_1_2.id
	arg_1_0.configId = arg_1_2.configId
	arg_1_0.prefab = arg_1_2:getPrefab()
	arg_1_0.attachments = arg_1_2:getAttachmentPrefab()
	arg_1_0.inimacy = arg_1_4 or 0
	arg_1_0.coin = arg_1_3 or 0
	arg_1_0.skinId = arg_1_2.skinId
	arg_1_0.groupId = arg_1_2.groupId
	pg = var_5
	arg_1_0.config = var_5.ship_data_statistics[arg_1_0.configId]
	math = var_5
	arg_1_0.moveTime = var_5.floor(1 / arg_1_0.config.backyard_speed)

	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_0.id, 1, 1)

	arg_1_0.state = var_0_1.STATE_IDLE
	arg_1_0.moveCnt = 0
	arg_1_0.sideIndex = 0

	return
end

function var_0_1.GetLevel(arg_2_0)
	return 2
end

function var_0_1.GetSkinID(arg_3_0)
	return arg_3_0.skinId
end

function var_0_1.GetGroupID(arg_4_0)
	return arg_4_0.groupId
end

function var_0_1.GetObjType(arg_5_0)
	CourtYardConst = var_1_10001

	return var_1_10001.OBJ_TYPE_SHIP
end

function var_0_1.SetPosition(arg_6_0, arg_6_1)
	var_0_1.super.SetPosition(arg_6_0, arg_6_1)

	local var_6_0 = arg_6_0.state

	CourtYardShip = var_1_10003

	if var_6_0 == var_1_10003.STATE_MOVING_HALF then
		return
	end

	local var_6_1 = arg_6_0
	local var_6_2 = arg_6_0.DispatchEvent

	CourtYardEvent = var_5

	var_6_2(var_6_1, var_5.SHIP_POSITION_CHANGE, arg_6_1, arg_6_0:GetOffset())

	return
end

function var_0_1.InActivityRange(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:GetHost()
	local var_7_1 = var_2.GetStorey(var_7_0)
	local var_7_2 = var_2.GetRange(var_7_1)

	return arg_7_1.x < var_7_2.x and arg_7_1.y < var_7_2.y and arg_7_1.x >= 0 and arg_7_1.y >= 0
end

function var_0_1.GetDeathType(arg_8_0)
	CourtYardConst = var_1_10001

	return var_1_10001.DEPTH_TYPE_SHIP
end

function var_0_1.GetShipType(arg_9_0)
	CourtYardConst = var_1_10001

	return var_1_10001.SHIP_TYPE_SELF
end

function var_0_1._ChangeState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.state = arg_10_1

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.DispatchEvent

	CourtYardEvent = var_1_10006

	var_10_1(var_10_0, var_1_10006.SHIP_STATE_CHANGE, arg_10_1, arg_10_2)

	return
end

function var_0_1.ChangeState(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0:Clear()

	if arg_11_1 == var_0_1.STATE_IDLE then
		arg_11_0:OnStateIdle()
	elseif arg_11_1 == var_0_1.STATE_MOVING_ONE then
		arg_11_0:OnStateMoveOne()
	elseif (arg_11_1 == var_0_1.STATE_STOP or arg_11_1 == var_0_1.STATE_TOUCH or arg_11_1 == var_0_1.STATE_GETAWARD) and arg_11_0.state == var_0_1.STATE_INTERACT then
		-- block empty
	elseif arg_11_1 == var_0_1.STATE_INTERACT then
		arg_11_0:OnInterAction(arg_11_2)
	else
		arg_11_0:_ChangeState(arg_11_1)
	end

	return
end

function var_0_1.ShouldResetPosition(arg_12_0)
	return arg_12_0.state == var_0_1.STATE_STOP or arg_12_0.state == var_0_1.STATE_CANCEL_INTERACT
end

function var_0_1.WillInteraction(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.DispatchEvent

	CourtYardEvent = var_1_10004

	local var_13_2 = var_1_10004.SHIP_WILL_INTERACTION

	slot = var_1_10005

	var_13_1(var_13_0, var_13_2, var_1_10005)

	return
end

function var_0_1.StartInteraction(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 then
		arg_14_0.interactionSlot = arg_14_1
	else
		local var_14_0 = arg_14_0
		local var_14_1 = arg_14_0.ChangeState

		CourtYardShip = var_1_10006

		var_14_1(var_14_0, var_1_10006.STATE_INTERACT, arg_14_1)
	end

	return
end

function var_0_1.OnPreheatActionEnd(arg_15_0)
	return
end

function var_0_1.UpdateInteraction(arg_16_0, ...)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.DispatchEvent

	CourtYardEvent = var_1_10004

	var_16_1(var_16_0, var_1_10004.SHIP_UPDATE_INTERACTION, ...)

	return
end

function var_0_1.ClearInteraction(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0.interactionSlot = nil

	if not arg_17_3 then
		arg_17_0:ChangeState(var_0_1.STATE_CANCEL_INTERACT)

		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.DispatchEvent

		CourtYardEvent = var_7

		var_17_1(var_17_0, var_7.SHIP_STOP_INTERACTION, arg_17_1)
	end

	return
end

function var_0_1.OnStateIdle(arg_18_0)
	arg_18_0:_ChangeState(var_0_1.STATE_IDLE)

	Timer = var_1

	local var_18_0 = var_1.New

	local function var_18_1()
		local var_19_0 = arg_18_0

		math = var_2_10001
		var_19_0.moveCnt = var_2_10001.random(1, 5)

		local var_19_1 = arg_18_0

		var_0._ChangeState(var_19_1, var_0_1.STATE_MOVE)

		return
	end

	math = var_4
	arg_18_0.timer = var_18_0(var_18_1, var_4.random(10, 20), 1)

	local var_18_2 = arg_18_0.timer

	var_1.Start(var_18_2)

	return
end

function var_0_1.OnStateMoveOne(arg_20_0)
	arg_20_0:_ChangeState(var_0_1.STATE_MOVING_ONE)
	arg_20_0:ClearMarkPosition()

	Timer = var_1
	arg_20_0.timer = var_1.New(function()
		arg_20_0.moveCnt = arg_20_0.moveCnt - 1

		if arg_20_0.moveCnt <= 0 then
			local var_21_0 = arg_20_0

			var_0.ChangeState(var_21_0, var_0_1.STATE_IDLE)
		else
			local var_21_1 = arg_20_0

			var_0._ChangeState(var_21_1, var_0_1.STATE_MOVE)
		end

		return
	end, arg_20_0.moveTime * 0.5, 1)

	local var_20_0 = arg_20_0.timer

	var_1.Start(var_20_0)

	return
end

function var_0_1.OnInterAction(arg_22_0, arg_22_1)
	arg_22_0.interactionSlot = arg_22_1

	arg_22_0:_ChangeState(var_0_1.STATE_INTERACT)

	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.DispatchEvent

	CourtYardEvent = var_5

	var_22_1(var_22_0, var_5.SHIP_START_INTERACTION, arg_22_1)

	return
end

function var_0_1.GetInterActionData(arg_23_0)
	return arg_23_0.interactionSlot
end

function var_0_1.Move(arg_24_0, arg_24_1)
	arg_24_0:MarkPosition(arg_24_1)
	arg_24_0:ChangeState(var_0_1.STATE_MOVING_ZERO)

	Timer = var_2
	arg_24_0.timer = var_2.New(function()
		local var_25_0 = arg_24_0

		var_0.ChangeState(var_25_0, var_0_1.STATE_MOVING_HALF)

		return
	end, arg_24_0.moveTime * 0.5, 1)

	local var_24_0 = arg_24_0.timer

	var_2.Start(var_24_0)

	local var_24_1 = arg_24_0
	local var_24_2 = arg_24_0.DispatchEvent

	CourtYardEvent = var_5

	var_24_2(var_24_1, var_5.SHIP_MOVE, arg_24_1, arg_24_0:GetOffset())

	return
end

function var_0_1.GetState(arg_26_0)
	return arg_26_0.state
end

function var_0_1.GetPrefab(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.ship_skin_template[arg_27_0.skinId]

	assert = var_2

	var_2(var_27_0, "ship_skin_template not exist: " .. arg_27_0.configId .. " " .. arg_27_0.skinId)

	if var_27_0.double_char and var_27_0.double_char == 1 and arg_27_0.sideIndex and arg_27_0.sideIndex ~= 0 then
		local var_27_1

		if arg_27_0.sideIndex == 1 then
			return arg_27_0.prefab .. "_L"
		elseif arg_27_0.sideIndex == 2 then
			return arg_27_0.prefab .. "_R"
		end
	end

	return arg_27_0.prefab
end

function var_0_1.getPrefab(arg_28_0)
	return arg_28_0:GetPrefab()
end

function var_0_1.SetSide(arg_29_0, arg_29_1)
	arg_29_0.sideIndex = arg_29_1

	return
end

function var_0_1.GetSide(arg_30_0, arg_30_1)
	return arg_30_0.sideIndex
end

function var_0_1.IsDoubleSkin(arg_31_0)
	pg = var_1_10001

	local var_31_0 = var_1_10001.ship_skin_template[arg_31_0.skinId]

	assert = var_2

	var_2(var_31_0, "ship_skin_template not exist: " .. arg_31_0.configId .. " " .. arg_31_0.skinId)

	return var_31_0.double_char and var_31_0.double_char == 1 or false
end

function var_0_1.getAttachmentPrefab(arg_32_0)
	return arg_32_0.attachments
end

function var_0_1.GetMoveTime(arg_33_0)
	return arg_33_0.moveTime
end

function var_0_1.Clear(arg_34_0)
	if arg_34_0.timer then
		local var_34_0 = arg_34_0.timer

		var_1.Stop(var_34_0)

		arg_34_0.timer = nil
	end

	return
end

function var_0_1.ChangeInimacy(arg_35_0, arg_35_1)
	arg_35_0.inimacy = arg_35_1

	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_35_1(var_35_0, var_1_10005.SHIP_INIMACY_CHANGE, arg_35_1)

	return
end

function var_0_1.ChangeCoin(arg_36_0, arg_36_1)
	arg_36_0.coin = arg_36_1

	local var_36_0 = arg_36_0
	local var_36_1 = arg_36_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_36_1(var_36_0, var_1_10005.SHIP_COIN_CHANGE, arg_36_1)

	return
end

function var_0_1.ClearInimacy(arg_37_0)
	if arg_37_0.inimacy <= 0 then
		return
	end

	arg_37_0:ChangeInimacy(0)
	arg_37_0:ChangeState(var_0_1.STATE_GETAWARD)

	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.DispatchEvent

	CourtYardEvent = var_5

	var_37_1(var_37_0, var_5.SHIP_GET_AWARD, var_1, 2)

	return
end

function var_0_1.ClearCoin(arg_38_0)
	if arg_38_0.coin <= 0 then
		return
	end

	arg_38_0:ChangeCoin(0)
	arg_38_0:ChangeState(var_0_1.STATE_GETAWARD)

	local var_38_0 = arg_38_0
	local var_38_1 = arg_38_0.DispatchEvent

	CourtYardEvent = var_5

	var_38_1(var_38_0, var_5.SHIP_GET_AWARD, var_1, 1)

	return
end

function var_0_1.AddExp(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0
	local var_39_1 = arg_39_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_39_1(var_39_0, var_1_10005.SHIP_GET_AWARD, arg_39_1, 3)

	return
end

function var_0_1.GetInterActionBgm(arg_40_0)
	return nil
end

function var_0_1.Dispose(arg_41_0)
	var_0_1.super.Dispose(arg_41_0)
	arg_41_0:Clear()

	if arg_41_0:GetInterActionData() then
		var_1:Stop()
	end

	return
end

return var_0_1
