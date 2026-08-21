local var_0_0 = class("AtlasMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:OnCtor()
end

function var_0_0.OnCtor(arg_2_0)
	arg_2_0.spritePool_ = {}
end

function var_0_0.GetSprite(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1 .. arg_3_2

	if not arg_3_0.spritePool_[var_3_0] then
		arg_3_0.spritePool_[var_3_0] = getSprite(arg_3_1, arg_3_2)
	end

	return arg_3_0.spritePool_[var_3_0]
end

function var_0_0.UnloadSprite(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.spritePool_) do
		if string.find(iter_4_0, arg_4_1) then
			Object.Destroy(iter_4_1)

			arg_4_0.spritePool_[iter_4_0] = nil
		end
	end
end

function var_0_0.UnloadAllSprite(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.spritePool_) do
		Object.Destroy(iter_5_1)

		arg_5_0.spritePool_[iter_5_0] = nil
	end

	arg_5_0.spritePool_ = {}
end

return var_0_0
