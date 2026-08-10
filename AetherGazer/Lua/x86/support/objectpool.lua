local var_0_0 = class("ObjectPool")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.uselessParent_ = GameObject.Find("/Pool").transform
	arg_1_0.freeDic_ = {}

	arg_1_0:Preload()
end

function var_0_0.Preload(arg_2_0)
	return
end

function var_0_0.Create(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Asset.Load(arg_3_1)

	arg_3_0:CheckToInitList(arg_3_1)

	for iter_3_0 = 1, arg_3_2 do
		local var_3_1 = Object.Instantiate(var_3_0, arg_3_0.uselessParent_)

		table.insert(arg_3_0.freeDic_[arg_3_1], var_3_1)
	end
end

function var_0_0.Get(arg_4_0, arg_4_1)
	arg_4_0:CheckToInitList(arg_4_1)

	if #arg_4_0.freeDic_[arg_4_1] == 0 then
		arg_4_0:Create(arg_4_1, 1)
	end

	local var_4_0 = arg_4_0.freeDic_[arg_4_1]
	local var_4_1 = var_4_0[#var_4_0]

	table.remove(var_4_0, #var_4_0)

	return var_4_1
end

function var_0_0.Return(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:CheckToInitList(arg_5_1)
	arg_5_2.transform:SetParent(arg_5_0.uselessParent_, false)
	table.insert(arg_5_0.freeDic_[arg_5_1], arg_5_2)
end

function var_0_0.CheckToInitList(arg_6_0, arg_6_1)
	if not arg_6_0.freeDic_[arg_6_1] then
		arg_6_0.freeDic_[arg_6_1] = {}
	end
end

function var_0_0.IsRecycleAssetPath(arg_7_0, arg_7_1)
	if arg_7_1 == "UI/Common/CommonItem" then
		return true
	end

	return false
end

function var_0_0.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.freeDic_) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
			Object.Destroy(iter_8_3)
		end
	end

	arg_8_0.freeDic_ = {}
end

return var_0_0
