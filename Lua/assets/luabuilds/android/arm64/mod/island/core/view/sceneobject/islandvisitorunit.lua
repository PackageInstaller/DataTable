local var_0_0 = class("IslandVisitorUnit", import(".IslandNavigableUnit"))

function var_0_0.OnUpdate(arg_1_0)
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

function var_0_0.OnStart(arg_2_0)
	arg_2_0.behaviourTreeOwner.graph.blackboard:SetVariableValue("playerId", tostring(arg_2_0.id))

	return
end

function var_0_0.OnLaterAttach(arg_3_0, arg_3_1)
	var_0_0.super.OnLaterAttach(arg_3_0, arg_3_1)

	arg_3_0.delayTime = 0
	arg_3_0.syncData = nil

	return
end

function var_0_0.UpdateSyncData(arg_4_0, arg_4_1)
	arg_4_0.syncData = arg_4_1
	arg_4_0.delayTime = IslandConst.SYNC_TIME_INTERVAL

	return
end

function var_0_0.Sleep(arg_5_0)
	arg_5_0.isSleeping = true

	return
end

function var_0_0.WakeUp(arg_6_0)
	arg_6_0.isSleeping = false

	return
end

function var_0_0.MoveHandle(arg_7_0)
	local var_7_0
	local var_7_1

	if arg_7_0.delayTime - Time.deltaTime > 0 then
		var_7_0 = Vector3.Lerp(arg_7_0:GetLocalPosition(), arg_7_0.syncData.pos, Time.deltaTime / arg_7_0.delayTime)
		var_7_1 = Quaternion.Lerp(arg_7_0:GetRotation(), arg_7_0:GetSyncDataRotation(), Time.deltaTime / arg_7_0.delayTime)
		arg_7_0.delayTime = arg_7_0.delayTime - Time.deltaTime
	else
		var_7_0 = arg_7_0.syncData.pos
		var_7_1 = arg_7_0:GetSyncDataRotation()
		arg_7_0.delayTime = 0
	end

	local var_7_2 = (var_7_0 - arg_7_0:GetLocalPosition()) / Time.deltaTime

	arg_7_0.speed = Vector2(var_7_2.x, var_7_2.z).magnitude

	arg_7_0:SetLocalPosition(var_7_0)
	arg_7_0:SetRotation(var_7_1)

	return
end

function var_0_0.AnimHandle(arg_8_0)
	if arg_8_0.speed > 0.1 then
		arg_8_0.speed = 5
	end

	local var_8_0 = arg_8_0:GetAnimator()

	var_8_0:SetFloat(IslandConst.SPEED_FLAG_HASH, arg_8_0.speed)

	for iter_8_0 = 1, var_8_0.layerCount do
		if not var_8_0:IsInTransition(iter_8_0 - 1) then
			if var_8_0:GetCurrentAnimatorStateInfo(iter_8_0 - 1).shortNameHash ~= arg_8_0.syncData.status[iter_8_0] then
				var_8_0:CrossFadeInFixedTime(arg_8_0.syncData.status[iter_8_0], 0.25, iter_8_0 - 1)
			end
		end
	end

	return
end

function var_0_0.GetSyncDataRotation(arg_9_0)
	return arg_9_0.syncData.dir
end

function var_0_0.GetLocalPosition(arg_10_0)
	return arg_10_0._go.transform.localPosition
end

function var_0_0.GetRotation(arg_11_0)
	return arg_11_0._go.transform.rotation
end

function var_0_0.SetLocalPosition(arg_12_0, arg_12_1)
	arg_12_0._go.transform.localPosition = arg_12_1

	return
end

function var_0_0.SetRotation(arg_13_0, arg_13_1)
	arg_13_0._go.transform.rotation = arg_13_1

	return
end

function var_0_0.SetShipDressHelper(arg_14_0, arg_14_1)
	arg_14_0.shipDressHelper = arg_14_1

	return
end

function var_0_0.OnDetach(arg_15_0)
	if arg_15_0.shipDressHelper then
		arg_15_0.shipDressHelper:Destroy()
	end

	return
end

function var_0_0.OnChangeDress(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		if iter_16_1.changedDressColorId then
			if not iter_16_1.changeedDressId then
				arg_16_0.shipDressHelper:ChangeCommanderPartColor(iter_16_0, iter_16_1.changedDressColorId)
			else
				arg_16_0.shipDressHelper:ChangeDressByType(iter_16_0, {
					id = iter_16_1.changeedDressId,
					colorId = iter_16_1.changedDressColorId
				})
			end
		end
	end

	return
end

return var_0_0
