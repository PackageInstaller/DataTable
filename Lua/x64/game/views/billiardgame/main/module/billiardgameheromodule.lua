local var_0_0 = class("BilliardGameHeroModuel", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.skillBtn_, nil, function()
		return
	end)
end

function var_0_0.FirstRefresh(arg_5_0, arg_5_1)
	arg_5_0.heroId = arg_5_1

	local var_5_0 = SummerPubHeroCfg[arg_5_1]
end

function var_0_0.OnDataChange(arg_6_0)
	local var_6_0 = BilliardGameMgr:GetLogicData()
	local var_6_1 = 0
	local var_6_2 = 0

	for iter_6_0, iter_6_1 in pairs(var_6_0.hero) do
		if iter_6_1.id == arg_6_0.heroId then
			var_6_1 = iter_6_1.hp

			local var_6_3 = iter_6_1.cooldown
		end
	end

	arg_6_0.hpTxt_.text = var_6_1
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
