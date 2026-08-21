local var_0_0 = class("HeroAstrolabeBaseInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.Dispose(arg_5_0)
	if arg_5_0.itemS_ then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemS_) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1) do
				iter_5_3:Dispose()
			end
		end
	end

	arg_5_0.itemSGo_ = nil
	arg_5_0.itemS_ = nil
	arg_5_0.astrolabeInfo_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
