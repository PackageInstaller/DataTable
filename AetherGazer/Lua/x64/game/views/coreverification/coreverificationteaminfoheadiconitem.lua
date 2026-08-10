local var_0_0 = class("CoreVerificationTeamInfoItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()

	arg_1_0.heroHeadItem_ = {}
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	SetActive(arg_4_0.icon_.gameObject, arg_4_1 and true or false)

	if arg_4_1 then
		local var_4_0 = HeroTools.HeroUsingSkinInfo(arg_4_1).id

		if var_4_0 == 0 then
			var_4_0 = arg_4_1
		end

		arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_4_0)
	end
end

function var_0_0.Dispose(arg_5_0)
	for iter_5_0 = 1, 6 do
		if arg_5_0.heroHeadItem_[iter_5_0] then
			arg_5_0.heroHeadItem_[iter_5_0]:Dispose()

			arg_5_0.heroHeadItem_[iter_5_0] = nil
		end
	end

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
