local var_0_0 = class("LuaItemPool")
local var_0_1 = 30

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.uselessParent_ = GameObject.Find("/Pool").transform
	arg_1_0._templatePath = arg_1_2
	arg_1_0._class = arg_1_1
	arg_1_0._pool = {}
end

function var_0_0.LoadItem(arg_2_0, arg_2_1)
	arg_2_0._template = Asset.Load(arg_2_0._templatePath)

	for iter_2_0 = 1, arg_2_1 do
		arg_2_0:AddPool()
	end
end

function var_0_0.AddPool(arg_3_0, arg_3_1)
	if not arg_3_0._template then
		arg_3_0._template = Asset.Load(arg_3_0._templatePath)
	end

	local var_3_0

	if arg_3_1 then
		var_3_0 = Object.Instantiate(arg_3_0._template, arg_3_1.transform)
	else
		var_3_0 = Object.Instantiate(arg_3_0._template, arg_3_0.uselessParent_.transform)
	end

	arg_3_0._pool[#arg_3_0._pool + 1] = arg_3_0._class.New(var_3_0)
end

function var_0_0.Get(arg_4_0, arg_4_1)
	if #arg_4_0._pool >= 1 then
		local var_4_0 = arg_4_0._pool[#arg_4_0._pool]

		arg_4_0._pool[#arg_4_0._pool] = nil

		var_4_0.gameObject_.transform:SetParent(arg_4_1.transform, false)

		return var_4_0
	end

	arg_4_0:AddPool(arg_4_1)

	local var_4_1 = arg_4_0._pool[#arg_4_0._pool]

	arg_4_0._pool[#arg_4_0._pool] = nil

	return var_4_1
end

function var_0_0.Release(arg_5_0, arg_5_1)
	arg_5_1.transform_:SetParent(arg_5_0.uselessParent_, false)

	arg_5_0._pool[#arg_5_0._pool + 1] = arg_5_1
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._pool) do
		Object.Destroy(iter_6_1.gameObject_)
		iter_6_1:Dispose()
	end

	arg_6_0._pool = nil
	arg_6_0._template = nil
end

return var_0_0
