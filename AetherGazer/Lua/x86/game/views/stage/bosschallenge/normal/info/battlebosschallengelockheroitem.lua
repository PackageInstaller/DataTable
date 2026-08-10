local var_0_0 = class("BattleBossChallengeLockHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
end

function var_0_0.RefreshHeroItem(arg_2_0, arg_2_1)
	arg_2_0.imageIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_2_1)
end

function var_0_0.SetActive(arg_3_0, arg_3_1, arg_3_2)
	SetActive(arg_3_0.gameObject_, arg_3_1)

	if arg_3_1 then
		arg_3_0:RefreshHeroItem(arg_3_2)
	end
end

function var_0_0.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

return var_0_0
