class = var_0_10000

local var_0_0 = var_0_10000("MainEffectView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1
	arg_1_0.loading = false
	arg_1_0.caches = {}

	return
end

function var_0_0.GetEffect(arg_2_0, arg_2_1)
	if arg_2_1.propose then
		return "jiehuntexiao"
	end

	return nil
end

function var_0_0.Init(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:GetEffect(arg_3_1)

	arg_3_0:Load(var_3_0)

	return
end

function var_0_0.Refresh(arg_4_0, arg_4_1)
	if arg_4_0:GetEffect(arg_4_1) and arg_4_0.loading then
		arg_4_0:SetDirty(var_2)

		return
	end

	arg_4_0:Load(var_2)

	return
end

function var_0_0.Load(arg_5_0, arg_5_1)
	if arg_5_0.effectName and not arg_5_1 then
		arg_5_0:Clear()

		return
	end

	if not arg_5_1 or arg_5_1 == arg_5_0.effectName then
		return
	end

	arg_5_0:Clear()

	arg_5_0.loading = true

	arg_5_0:LoadEffect(arg_5_1, function(arg_6_0)
		arg_5_0.loading = false

		local var_6_0 = arg_6_0.transform

		Vector3 = var_2
		var_6_0.localPosition = var_2.zero

		local var_6_1 = arg_6_0.transform

		Vector3 = var_2
		var_6_1.localScale = var_2.one
		arg_5_0.effectGo = arg_6_0
		arg_5_0.effectName = arg_5_1

		return
	end)

	arg_5_0.dirty = nil

	return
end

function var_0_0.LoadEffect(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0

	if arg_7_0.caches[arg_7_1] then
		var_7_0 = arg_7_0.caches[arg_7_1]
		setActive = var_1_10004

		var_1_10004(var_7_0, true)
		arg_7_2(var_7_0)
	else
		ResourceMgr = var_7_0

		local var_7_1 = var_7_0.Inst
		local var_7_2 = var_3.getAssetAsync
		local var_7_3 = "Effect/" .. arg_7_1
		local var_7_4 = ""

		UnityEngine = var_1_10007

		var_7_2(var_7_1, var_7_3, var_7_4, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
			if arg_7_0.exited then
				return
			end

			local var_8_0 = arg_7_0

			if var_1.IsDirty(var_8_0) then
				local var_8_1 = arg_7_0

				var_1.Load(var_8_1, arg_7_0.dirty)

				return
			end

			Object = var_1

			local var_8_2 = var_1.Instantiate(arg_8_0, arg_7_0.tr)

			arg_7_0.caches[arg_7_1] = var_8_2

			arg_7_2(var_8_2)

			return
		end), true, true)
	end

	return
end

function var_0_0.SetDirty(arg_9_0, arg_9_1)
	arg_9_0.dirty = arg_9_1

	return
end

function var_0_0.IsDirty(arg_10_0)
	return arg_10_0.dirty ~= nil
end

function var_0_0.Clear(arg_11_0)
	if arg_11_0.effectGo then
		setActive = var_1

		var_1(arg_11_0.effectGo, false)

		arg_11_0.effectGo = nil
	end

	arg_11_0.effectName = nil
	arg_11_0.loading = nil

	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:Clear()

	pairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0.caches) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_12_1)
	end

	arg_12_0.caches = nil
	arg_12_0.exited = true
	arg_12_0.dirty = nil

	return
end

return var_0_0
