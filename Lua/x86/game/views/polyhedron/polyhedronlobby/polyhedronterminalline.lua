local var_0_0 = class("PolyhedronTerminalLine", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	local var_1_0 = string.split(arg_1_2, "_")

	arg_1_0.id_list = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		table.insert(arg_1_0.id_list, tonumber(iter_1_1))
	end

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.id_list) do
		if iter_3_1 ~= 0 and not table.indexof(arg_3_1, iter_3_1) then
			arg_3_0.stateController:SetSelectedIndex(0)

			return
		end
	end

	arg_3_0.stateController:SetSelectedIndex(1)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
