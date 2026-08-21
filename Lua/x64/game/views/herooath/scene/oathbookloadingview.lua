local var_0_0 = class("OathBookLoadingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathCommon/HeroOathLoadingPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:GotoBook()
	end)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.super.Dispose(arg_6_0)
	arg_6_0:RemoveAllListeners()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.heroID = arg_7_0.params_.heroID
	arg_7_0.sprite = arg_7_0.params_.sprite

	arg_7_0:RefreshUI()
	arg_7_0:AddAniTimer()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.adminImg_.sprite = OathTools.GetOathHeadSprite(OathConst.OATH_ADMIN_ID)
	arg_8_0.roleImg_.sprite = OathTools.GetOathHeadSprite(WeddingCfg[arg_8_0.heroID].skin_id)
end

function var_0_0.DelAniTimer(arg_9_0)
	if arg_9_0.anitimer then
		arg_9_0.anitimer:Stop()

		arg_9_0.anitimer = nil
	end
end

function var_0_0.AddAniTimer(arg_10_0)
	arg_10_0:DelAniTimer()

	arg_10_0.anitimer = Timer.New(function()
		if arg_10_0.ani_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_10_0:GotoBook()
		end
	end, 0.1, -1)

	arg_10_0.anitimer:Start()
end

function var_0_0.GotoBook(arg_12_0)
	arg_12_0:Back()
	JumpTools.OpenPageByJump("/oathBookView", {
		heroID = arg_12_0.heroID,
		sprite = arg_12_0.sprite
	})
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:DelAniTimer()
end

return var_0_0
