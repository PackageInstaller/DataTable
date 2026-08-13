class = var_0_10000

local var_0_0 = var_0_10000("CourtYardPedestalStructure")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.parent = arg_1_1
	arg_1_0.asset = nil
	arg_1_0.level = 0
	arg_1_0.isDirty = false
	arg_1_0.state = var_0_1

	return
end

function var_0_0.GetRect(arg_2_0)
	local var_2_0 = arg_2_0.parent
	local var_2_1 = var_1.GetView(var_2_0)

	return var_1.GetRect(var_2_1)
end

function var_0_0.IsEditModeOrIsVisit(arg_3_0)
	local var_3_0 = arg_3_0.parent
	local var_3_1 = var_1.GetController(var_3_0)

	return var_1.IsEditModeOrIsVisit(var_3_1)
end

function var_0_0.IsEmpty(arg_4_0)
	return arg_4_0.state == var_0_1
end

function var_0_0.IsLoading(arg_5_0)
	return arg_5_0.state == var_0_2
end

function var_0_0.IsLoaded(arg_6_0)
	return arg_6_0.state == var_0_4
end

function var_0_0.IsExit(arg_7_0)
	return arg_7_0.state == var_0_5
end

function var_0_0.IsDirty(arg_8_0)
	return arg_8_0.state == var_0_3
end

function var_0_0.Update(arg_9_0, arg_9_1)
	arg_9_0:UpdateLevel(arg_9_1)

	if arg_9_0:IsEmpty() then
		arg_9_0:Load()
	elseif arg_9_0:IsLoading() then
		arg_9_0:SetDirty()
	elseif arg_9_0:IsLoaded() then
		arg_9_0:ReLoad()
	end

	return
end

function var_0_0.UpdateLevel(arg_10_0, arg_10_1)
	if arg_10_0.level ~= arg_10_1 then
		arg_10_0.isDirty = true
	end

	arg_10_0.level = arg_10_1

	return
end

function var_0_0.Load(arg_11_0, arg_11_1)
	arg_11_0.state = var_0_2
	ResourceMgr = var_2

	local var_11_0 = var_2.Inst
	local var_11_1 = var_2.getAssetAsync
	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.GetAssetPath(var_11_2)
	local var_11_4 = ""

	typeof = var_11_2
	GameObject = var_1_10009

	local var_11_5 = var_11_2(var_1_10009)

	UnityEngine = var_1_10008

	var_11_1(var_11_0, var_11_3, var_11_4, var_11_5, var_1_10008.Events.UnityAction_UnityEngine_Object(function(arg_12_0)
		local var_12_0 = arg_11_0

		if not var_1.IsExit(var_12_0) then
			IsNil = var_1

			if var_1(arg_12_0) then
				return
			end

			local var_12_1 = arg_11_0

			if var_1.IsDirty(var_12_1) then
				local var_12_2 = arg_11_0

				var_1.ReLoad(var_12_2)

				return
			end

			if arg_11_1 then
				arg_11_1()
			end

			local var_12_3 = arg_11_0

			var_12_3.state = var_0_4
			Object = var_12_3

			local var_12_4 = var_12_3.Instantiate
			local var_12_5 = arg_12_0
			local var_12_6 = arg_11_0
			local var_12_7 = var_12_4(var_12_5, var_4.GetParent(var_12_6))
			local var_12_8 = arg_11_0

			var_2.OnLoaded(var_12_8, var_12_7)

			arg_11_0.asset = var_12_7

			return
		end
	end), true, true)

	return
end

function var_0_0.GetParent(arg_13_0)
	return arg_13_0.parent._tf
end

function var_0_0.SetDirty(arg_14_0)
	if arg_14_0.isDirty then
		arg_14_0.state = var_0_3
	end

	return
end

function var_0_0.ReLoad(arg_15_0)
	arg_15_0:Load(function()
		local var_16_0 = arg_15_0

		var_0.Unload(var_16_0)

		return
	end)

	return
end

function var_0_0.Unload(arg_17_0)
	IsNil = var_1_10001

	if not var_1_10001(arg_17_0.asset) then
		Object = var_1

		var_1.Destroy(arg_17_0.asset)
	end

	arg_17_0.asset = nil
	arg_17_0.state = var_0_1

	return
end

function var_0_0.Dispose(arg_18_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_18_0)
	arg_18_0:Unload()

	arg_18_0.state = var_0_5

	return
end

function var_0_0.OnLoaded(arg_19_0)
	return
end

function var_0_0.GetAssetPath(arg_20_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

return var_0_0
