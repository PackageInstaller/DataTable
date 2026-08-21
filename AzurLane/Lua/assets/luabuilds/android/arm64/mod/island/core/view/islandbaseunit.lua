local var_0_0 = class("IslandBaseUnit")
local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.__state = var_0_1
	arg_1_0.view = arg_1_1

	return
end

function var_0_0.IsSelfIsland(arg_2_0)
	return arg_2_0.view:IsSelfIsland()
end

function var_0_0.NotifiyCore(arg_3_0, arg_3_1, ...)
	arg_3_0.view:NotifiyCore(arg_3_1, ...)

	return
end

function var_0_0.Op(arg_4_0, ...)
	arg_4_0:GetView():Op(...)

	return
end

function var_0_0.NotifiyIsland(arg_5_0, ...)
	arg_5_0:GetView():NotifiyIsland(...)

	return
end

function var_0_0.NotifiyMeditor(arg_6_0, arg_6_1, ...)
	arg_6_0:GetView():NotifiyMeditor(arg_6_1, ...)

	return
end

function var_0_0.Init(arg_7_0, ...)
	if arg_7_0:IsEmpty() then
		arg_7_0:OnInit(...)

		arg_7_0.__state = var_0_2
	else
		arg_7_0:OnAnomalyInit(...)
	end

	return
end

function var_0_0.IsEmpty(arg_8_0)
	return arg_8_0.__state == var_0_1
end

function var_0_0.IsLoaded(arg_9_0)
	return arg_9_0.__state == var_0_2
end

function var_0_0.GetView(arg_10_0)
	return arg_10_0.view
end

function var_0_0.GetPoolMgr(arg_11_0)
	return arg_11_0.view:GetPoolMgr()
end

function var_0_0.GetIsland(arg_12_0)
	return arg_12_0.view:GetIsland()
end

function var_0_0.GetSelfIsland(arg_13_0)
	return arg_13_0.view:GetSelfIsland()
end

function var_0_0.Reset(arg_14_0)
	if arg_14_0:IsLoaded() then
		arg_14_0:OnDispose()
	end

	arg_14_0:OnDestroy()

	arg_14_0.__state = var_0_1

	return
end

function var_0_0.Dispose(arg_15_0)
	if arg_15_0.__state == var_0_3 then
		return
	end

	pg.DelegateInfo.Dispose(arg_15_0)

	if arg_15_0:IsLoaded() then
		arg_15_0:OnDispose()
	end

	arg_15_0.__state = var_0_3

	arg_15_0:OnDestroy()

	arg_15_0.view = nil

	return
end

function var_0_0.Update(arg_16_0)
	if not arg_16_0:IsLoaded() then
		return
	end

	arg_16_0:OnUpdate()

	return
end

function var_0_0.LateUpdate(arg_17_0)
	if not arg_17_0:IsLoaded() then
		return
	end

	arg_17_0:OnLateUpdate()

	return
end

function var_0_0.OnInit(arg_18_0, ...)
	return
end

function var_0_0.OnAnomalyInit(arg_19_0, ...)
	return
end

function var_0_0.Start(arg_20_0)
	return
end

function var_0_0.OnUpdate(arg_21_0)
	return
end

function var_0_0.OnLateUpdate(arg_22_0)
	return
end

function var_0_0.OnDispose(arg_23_0)
	return
end

function var_0_0.OnDestroy(arg_24_0)
	return
end

return var_0_0
