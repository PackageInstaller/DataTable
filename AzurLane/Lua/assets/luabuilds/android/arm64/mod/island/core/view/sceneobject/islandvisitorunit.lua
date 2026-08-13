class = var_0_10000

local var_0_0 = "IslandVisitorUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandNavigableUnit"))

function var_0_1.OnUpdate(arg_1_0)
	if arg_1_0.delayTime == 0 then
		return
	end

	if arg_1_0.isSleeping then
		return
	end

	arg_1_0:MoveHandle()
	arg_1_0:AnimHandle()

	return
end

function var_0_1.OnStart(arg_2_0)
	local var_2_0 = arg_2_0.behaviourTreeOwner.graph.blackboard
	local var_2_1 = var_1.SetVariableValue
	local var_2_2 = "playerId"

	tostring = var_1_10005

	var_2_1(var_2_0, var_2_2, var_1_10005(arg_2_0.id))

	return
end

function var_0_1.OnLaterAttach(arg_3_0, arg_3_1)
	var_0_1.super.OnLaterAttach(arg_3_0, arg_3_1)

	arg_3_0.delayTime = 0
	arg_3_0.syncData = nil

	return
end

function var_0_1.UpdateSyncData(arg_4_0, arg_4_1)
	arg_4_0.syncData = arg_4_1
	IslandConst = var_1_10002
	arg_4_0.delayTime = var_1_10002.SYNC_TIME_INTERVAL

	return
end

function var_0_1.Sleep(arg_5_0)
	arg_5_0.isSleeping = true

	return
end

function var_0_1.WakeUp(arg_6_0)
	arg_6_0.isSleeping = false

	return
end

function var_0_1.MoveHandle(arg_7_0)
	local var_7_0 = arg_7_0.delayTime

	Time = var_1_10002

	local var_7_1 = var_7_0 - var_1_10002.deltaTime

	Time = var_2

	local var_7_2 = var_2.deltaTime / arg_7_0.delayTime
	local var_7_3
	local var_7_4

	if 0 < var_7_1 then
		Vector3 = var_5
		var_7_3 = var_5.Lerp(arg_7_0:GetLocalPosition(), arg_7_0.syncData.pos, var_7_2)
		Quaternion = var_5
		var_7_4 = var_5.Lerp(arg_7_0:GetRotation(), arg_7_0:GetSyncDataRotation(), var_7_2)
		arg_7_0.delayTime = var_7_1
	else
		var_7_3 = arg_7_0.syncData.pos
		var_7_4 = arg_7_0:GetSyncDataRotation()
		arg_7_0.delayTime = 0
	end

	local var_7_5 = var_7_3 - arg_7_0:GetLocalPosition()

	Time = var_1_10006

	local var_7_6 = var_7_5 / var_1_10006.deltaTime

	Vector2 = var_6
	arg_7_0.speed = var_6(var_7_6.x, var_7_6.z).magnitude

	arg_7_0:SetLocalPosition(var_7_3)
	arg_7_0:SetRotation(var_7_4)

	return
end

function var_0_1.AnimHandle(arg_8_0)
	if arg_8_0.speed > 0.1 then
		arg_8_0.speed = 5
	end

	local var_8_0 = arg_8_0:GetAnimator()
	local var_8_1 = var_1.SetFloat

	IslandConst = var_1_10005

	var_8_1(var_8_0, var_1_10005.SPEED_FLAG_HASH, arg_8_0.speed)

	for iter_8_0 = 1, var_1.layerCount do
		local var_8_2 = iter_8_0 - 1

		if not var_1:IsInTransition(var_8_2) then
			local var_8_3 = arg_8_0.syncData.status[iter_8_0]

			if var_1:GetCurrentAnimatorStateInfo(var_8_2).shortNameHash ~= var_8_3 then
				var_1:CrossFadeInFixedTime(var_8_3, 0.25, var_8_2)
			end
		end
	end

	return
end

function var_0_1.GetSyncDataRotation(arg_9_0)
	return arg_9_0.syncData.dir
end

function var_0_1.GetLocalPosition(arg_10_0)
	return arg_10_0._go.transform.localPosition
end

function var_0_1.GetRotation(arg_11_0)
	return arg_11_0._go.transform.rotation
end

function var_0_1.SetLocalPosition(arg_12_0, arg_12_1)
	arg_12_0._go.transform.localPosition = arg_12_1

	return
end

function var_0_1.SetRotation(arg_13_0, arg_13_1)
	arg_13_0._go.transform.rotation = arg_13_1

	return
end

function var_0_1.SetShipDressHelper(arg_14_0, arg_14_1)
	arg_14_0.shipDressHelper = arg_14_1

	return
end

function var_0_1.OnDetach(arg_15_0)
	if arg_15_0.shipDressHelper then
		local var_15_0 = arg_15_0.shipDressHelper

		var_1.Destroy(var_15_0)
	end

	return
end

function var_0_1.OnChangeDress(arg_16_0, arg_16_1)
	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_1) do
		if iter_16_1.changedDressColorId then
			if not iter_16_1.changeedDressId then
				local var_16_0 = arg_16_0.shipDressHelper

				var_7.ChangeCommanderPartColor(var_16_0, iter_16_0, iter_16_1.changedDressColorId)
			else
				local var_16_1 = arg_16_0.shipDressHelper

				var_7.ChangeDressByType(var_16_1, iter_16_0, {
					id = iter_16_1.changeedDressId,
					colorId = iter_16_1.changedDressColorId
				})
			end
		end
	end

	return
end

return var_0_1
