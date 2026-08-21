local var_0_0 = class("SyncLocalPlayer")

var_0_0.ANIMATOR_LAYER = {
	0,
	1,
	2
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.sceneObject = arg_1_2
	arg_1_0.animator = arg_1_2:GetAnimator()
	arg_1_0.inTimeline = false

	return
end

function var_0_0.GetStatus(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.ANIMATOR_LAYER) do
		({})[iter_2_0] = arg_2_0.animator:GetCurrentAnimatorStateInfo(iter_2_1).shortNameHash
	end

	return {}
end

function var_0_0.IsLoaded(arg_3_0)
	return arg_3_0.sceneObject and arg_3_0.sceneObject:IsLoaded()
end

function var_0_0.SetInTimeline(arg_4_0, arg_4_1)
	arg_4_0.inTimeline = arg_4_1

	return
end

function var_0_0.InTimeline(arg_5_0)
	return arg_5_0.inTimeline
end

function var_0_0.CreateSyncData(arg_6_0)
	return (SyncUnitData.New({
		id = arg_6_0.id,
		pos = arg_6_0:GetLocalPosition(),
		dir = arg_6_0:GetRotation(),
		status = arg_6_0:GetStatus()
	}))
end

function var_0_0.GetLocalPosition(arg_7_0)
	return arg_7_0.sceneObject._go.transform.localPosition
end

function var_0_0.GetRotation(arg_8_0)
	return arg_8_0.sceneObject._go.transform.rotation
end

return var_0_0
