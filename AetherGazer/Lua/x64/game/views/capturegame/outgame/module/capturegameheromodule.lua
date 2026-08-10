local var_0_0 = class("CaptureGameHeroModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RenderView(arg_4_0, arg_4_1)
	SetActive(arg_4_0.emptyObj_, arg_4_1 == -1)
	SetActive(arg_4_0.headObj_, arg_4_1 ~= -1)

	if arg_4_1 ~= -1 then
		local var_4_0 = SkinCfg[arg_4_1]

		arg_4_0.headIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. var_4_0.picture_id)
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
