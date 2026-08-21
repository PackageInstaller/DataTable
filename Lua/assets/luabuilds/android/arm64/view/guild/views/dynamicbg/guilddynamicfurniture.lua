local var_0_0 = class("GuildDynamicFurniture")

var_0_0.INTERACTION_MODE_SIT = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1.go
	arg_1_0._tf = GetOrAddComponent(arg_1_1.go, typeof(RectTransform))
	arg_1_0.size = arg_1_1.size
	arg_1_0.path = arg_1_1.path
	arg_1_0.offset = arg_1_1.offset
	arg_1_0.mode = arg_1_1.mode
	arg_1_0.interactionDir = arg_1_1.interactionDir or 1
	arg_1_0.interactionPosition = arg_1_1.interactionPosition

	arg_1_0:SetPosition(arg_1_1.grid)

	arg_1_0.islock = false

	return
end

function var_0_0.SetPosition(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetLocalPosition()

	arg_2_0._tf.localPosition = Vector3(var_2_0.x + arg_2_0.offset.x, var_2_0.y + arg_2_0.offset.y, 0)
	arg_2_0.grid = arg_2_1

	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetOccupyGrid())) do
		iter_2_1:Lock()
	end

	return
end

function var_0_0.GetOccupyGrid(arg_3_0)
	for iter_3_0 = 0, arg_3_0.size.x - 1 do
		for iter_3_1 = 0, arg_3_0.size.y - 1 do
			table.insert({}, arg_3_0.path[arg_3_0.grid.position.x + iter_3_0][arg_3_0.grid.position.y + iter_3_1])
		end
	end

	return {}
end

function var_0_0.Lock(arg_4_0)
	arg_4_0.islock = true

	return
end

function var_0_0.Unlock(arg_5_0)
	arg_5_0.islock = false

	return
end

function var_0_0.BeLock(arg_6_0)
	return arg_6_0.islock == true
end

function var_0_0.GetInterActionPos(arg_7_0)
	return arg_7_0.interactionPosition
end

function var_0_0.GetInterActionMode(arg_8_0)
	return arg_8_0.mode
end

function var_0_0.SetAsLastSibling(arg_9_0)
	arg_9_0._tf:SetAsLastSibling()

	return
end

function var_0_0.GetInteractionDir(arg_10_0)
	return arg_10_0.interactionDir
end

function var_0_0.Dispose(arg_11_0)
	return
end

return var_0_0
