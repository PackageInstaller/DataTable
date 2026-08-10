local var_0_0 = import("game.views.pop.PopLevelUpBaseView")
local var_0_1 = class("HeroUpgradeSuccessView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_arrt/HeroLevelUpUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.OnCtor(arg_3_0)
	return
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.fromPropValueTexts_ = {
		arg_5_0.fromValue1_,
		arg_5_0.fromValue2_,
		arg_5_0.fromValue3_
	}
	arg_5_0.toPropValueTexts_ = {
		arg_5_0.toValue1_,
		arg_5_0.toValue2_,
		arg_5_0.toValue3_
	}
	arg_5_0.propNames_ = {
		arg_5_0.propName1_,
		arg_5_0.propName2_,
		arg_5_0.propName3_
	}
	arg_5_0.propIndexes_ = {
		1,
		2,
		3
	}

	for iter_5_0 = 1, 3 do
		arg_5_0.propNames_[iter_5_0].text = GetI18NText(PublicAttrCfg[arg_5_0.propIndexes_[iter_5_0]].name)
	end
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBack_, nil, function()
		arg_6_0:Back()

		if arg_6_0.params_.callback then
			local var_7_0 = arg_6_0.params_.callback

			arg_6_0.params_.callBack = nil

			var_7_0()
		end
	end)
end

function var_0_1.OnEnter(arg_8_0)
	arg_8_0:CheckBack()

	arg_8_0.oldLv_ = arg_8_0.params_.oldLv
	arg_8_0.oldAttr_ = arg_8_0.params_.oldAttr
	arg_8_0.heroViewProxy_ = arg_8_0.params_.proxy
	arg_8_0.heroInfo_ = HeroData:GetHeroList()[arg_8_0.params_.heroId]
	arg_8_0.newAttr_ = arg_8_0.heroViewProxy_:GetHeroAllAttribute(arg_8_0.heroInfo_.id)

	arg_8_0:UpdateView()
end

function var_0_1.UpdateView(arg_9_0)
	arg_9_0.fromLevelText_.text = string.format("%d", arg_9_0.oldLv_)
	arg_9_0.toLevelText_.text = string.format("%d", arg_9_0.heroInfo_.level)

	for iter_9_0 = 1, 3 do
		arg_9_0.fromPropValueTexts_[iter_9_0].text = string.format("%d", arg_9_0.oldAttr_[iter_9_0])
		arg_9_0.toPropValueTexts_[iter_9_0].text = string.format("%d", arg_9_0.newAttr_[iter_9_0])
	end

	arg_9_0:PlayHeroTalk(arg_9_0.heroInfo_.id)
end

function var_0_1.PlayHeroTalk(arg_10_0, arg_10_1)
	if arg_10_0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_10_1, "expup")

	arg_10_0.isTalkCD_ = true
	arg_10_0.talkCDTimer_ = Timer.New(function()
		arg_10_0.isTalkCD_ = false
	end, HeroConst.LEVEL_UPGRADE_VOICE_CD, 1)

	arg_10_0.talkCDTimer_:Start()
end

function var_0_1.OnExit(arg_12_0)
	return
end

function var_0_1.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()

	if arg_13_0.talkCDTimer_ then
		arg_13_0.talkCDTimer_:Stop()

		arg_13_0.talkCDTimer_ = nil
	end

	arg_13_0.isTalkCD_ = nil

	var_0_1.super.Dispose(arg_13_0)
end

return var_0_1
