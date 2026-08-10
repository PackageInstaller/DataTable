local var_0_0 = class("TeamHeroShortHead", HeroShortHead)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.isBattlePanel_ = true
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.selfBtn_, nil, function()
		if arg_2_0.clickListener_ ~= nil then
			arg_2_0.clickListener_(arg_2_0.heroCfg_.id)
		end
	end)
end

return var_0_0
