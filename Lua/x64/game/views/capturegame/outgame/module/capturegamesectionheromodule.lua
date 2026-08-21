local var_0_0 = class("CaptureGameSectionHeroModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.slots = {
		{
			entity = CaptureGameHeroModule.New(arg_3_0.headModule1_)
		},
		{
			entity = CaptureGameHeroModule.New(arg_3_0.headModule2_)
		},
		{
			entity = CaptureGameHeroModule.New(arg_3_0.headModule3_)
		},
		{
			entity = CaptureGameHeroModule.New(arg_3_0.headModule4_)
		}
	}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
end

function var_0_0.RenderView(arg_5_0, arg_5_1)
	local var_5_0 = CaptureGameTools:GetCaptureHeroList(arg_5_1)

	for iter_5_0 = 1, 4 do
		arg_5_0.slots[iter_5_0].entity:RenderView(var_5_0[iter_5_0] or -1)
	end
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.slots) do
		if iter_6_1.entity then
			iter_6_1.entity:Dispose()

			iter_6_1.entity = nil
		end
	end

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
