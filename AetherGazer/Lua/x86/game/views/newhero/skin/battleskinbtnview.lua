local var_0_0 = class("BattleSkinBtnView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController_ = arg_3_0.conEx_:GetController("select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.callBack_ then
			arg_4_0.callBack_(arg_4_0.heroID_)
		end

		if arg_4_0.usingBattleSkin_ and arg_4_0.usingBattleSkin_ == arg_4_0.skinID_ then
			HeroAction.ChangeBattleSkin(arg_4_0.heroID_, 0, function()
				arg_4_0:RefreshUI(arg_4_0.heroID_, arg_4_0.skinID_)
				ShowTips("HERO_SKIN_BATTLE_CANCEL")
			end)
		else
			HeroAction.ChangeBattleSkin(arg_4_0.heroID_, arg_4_0.skinID_, function()
				arg_4_0:RefreshUI(arg_4_0.heroID_, arg_4_0.skinID_)
				ShowTips("HERO_SKIN_BATTLE_SET")
			end)
		end
	end)
end

function var_0_0.SetCallBack(arg_8_0, arg_8_1)
	arg_8_0.callBack_ = arg_8_1
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.heroID_ = arg_9_1
	arg_9_0.heroData = HeroData:GetHeroData(arg_9_0.heroID_)
	arg_9_0.usingBattleSkin_ = arg_9_0.heroData.battle_using_skin
	arg_9_0.heroDataUsingSkin_ = arg_9_0.heroData.using_skin
	arg_9_0.skinID_ = arg_9_2

	arg_9_0:RefreshController()
end

function var_0_0.RefreshController(arg_10_0)
	if arg_10_0.usingBattleSkin_ and arg_10_0.usingBattleSkin_ == arg_10_0.skinID_ then
		arg_10_0.stateController_:SetSelectedState("on")
	else
		arg_10_0.stateController_:SetSelectedState("off")
	end
end

function var_0_0.GetIsBattleSkin(arg_11_0)
	return arg_11_0.usingBattleSkin_ and arg_11_0.usingBattleSkin_ == arg_11_0.skinID_, arg_11_0.usingBattleSkin_
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_.transform.parent.gameObject, arg_12_1)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
