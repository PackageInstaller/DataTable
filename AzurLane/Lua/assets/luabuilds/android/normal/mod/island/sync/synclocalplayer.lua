class = var_0_10000

local var_0_0 = var_0_10000("SyncLocalPlayer")

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
	local var_2_0 = {}

	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0.ANIMATOR_LAYER) do
		local var_2_1 = arg_2_0.animator

		var_2_0[iter_2_0] = var_7.GetCurrentAnimatorStateInfo(var_2_1, iter_2_1).shortNameHash
	end

	return var_2_0
end

function var_0_0.IsLoaded(arg_3_0)
	local var_3_1

	if arg_3_0.sceneObject then
		local var_3_0 = arg_3_0.sceneObject

		var_3_1 = var_1.IsLoaded(var_3_0)
	end

	return var_3_1
end

function var_0_0.SetInTimeline(arg_4_0, arg_4_1)
	arg_4_0.inTimeline = arg_4_1

	return
end

function var_0_0.InTimeline(arg_5_0)
	return arg_5_0.inTimeline
end

function var_0_0.CreateSyncData(arg_6_0)
	SyncUnitData = var_1_10001

	return (var_1_10001.New({
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
