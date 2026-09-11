local var_0_0 = singletonClass("HeroGiftData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.activity_id] = arg_2_1.receive_state
end

function var_0_0.GetReceiveHeroGift(arg_3_0, arg_3_1)
	return var_0_1[arg_3_1] or 1
end

function var_0_0.SetReceiveHeroGift(arg_4_0, arg_4_1)
	var_0_1[arg_4_1] = 1
end

return var_0_0
