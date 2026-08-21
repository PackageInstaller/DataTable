local var_0_0 = class("CoreVerificationRoleIcon", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.emptyController_ = arg_2_0.mainControllerEx_:GetController("empty")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0.emptyController_:SetSelectedState("false")

		local var_3_0 = HeroTools.HeroUsingSkinInfo(arg_3_1).id

		if var_3_0 == 0 then
			var_3_0 = arg_3_1
		end

		arg_3_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroItemshead.path .. var_3_0)
	else
		arg_3_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

return var_0_0
