local var_0_0 = class("AshILLSkillPage", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.canvasGroup = arg_1_1:GetComponent(typeof(CanvasGroup))

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.modules = {}

	local var_2_0 = AshSystemData:GetSkillList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		table.insert(arg_2_0.modules, AshILLSkillModule.New(arg_2_0.transform_, "SKILL"))
	end
end

function var_0_0.EnterPanel(arg_3_0, arg_3_1)
	arg_3_0.canvasGroup.alpha = 1
	arg_3_0.canvasGroup.blocksRaycasts = true

	local var_3_0 = AshSystemData:GetSkillList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		arg_3_0.modules[iter_3_0]:Render(iter_3_1)
	end
end

function var_0_0.ExitPanel(arg_4_0, arg_4_1)
	arg_4_0.canvasGroup.alpha = 0
	arg_4_0.canvasGroup.blocksRaycasts = false
end

function var_0_0.Render(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.modules) do
		iter_6_1:Dispose()
	end

	arg_6_0.modules = nil

	arg_6_0.super.Dispose(arg_6_0)
end

return var_0_0
