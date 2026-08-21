local var_0_0 = import("game.views.pop.PopLevelUpBaseView")
local var_0_1 = class("HeroBreakSuccessView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_arrt/HeroArrtBreakPopUI"
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

	local var_5_0, var_5_1, var_5_2 = SkillTools.GetAttr({
		HeroConst.HERO_ATTRIBUTE.CRITICAL,
		0
	})

	arg_5_0.propName_.text = GetI18NText(var_5_0)
	arg_5_0.iconImg_.sprite = var_5_2
end

function var_0_1.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btnBack_, nil, function()
		arg_6_0:Back()

		if arg_6_0.callBack_ then
			local var_7_0 = arg_6_0.callBack_

			arg_6_0.callBack_ = nil
			arg_6_0.params_.callBack = nil

			var_7_0()
		end
	end)
end

function var_0_1.OnEnter(arg_8_0)
	arg_8_0:CheckBack()

	arg_8_0.heroInfo_ = HeroData:GetHeroList()[arg_8_0.params_.heroId]
	arg_8_0.heroCfg_ = HeroCfg[arg_8_0.params_.heroId]
	arg_8_0.breakCfg_ = HeroTools.GetHeroBreakConfig(arg_8_0.heroCfg_.race, arg_8_0.params_.breakLevel)
	arg_8_0.oldBreakCfg_ = HeroTools.GetHeroBreakConfig(arg_8_0.heroCfg_.race, arg_8_0.params_.breakLevel - 1)
	arg_8_0.heroViewProxy_ = arg_8_0.params_.proxy
	arg_8_0.callBack_ = arg_8_0.params_.callBack

	arg_8_0:UpdateView()
end

function var_0_1.UpdateView(arg_9_0)
	arg_9_0.levelFromText_.text = tostring(arg_9_0.oldBreakCfg_.max_level)
	arg_9_0.levelTopText_.text = tostring(arg_9_0.breakCfg_.max_level)
	arg_9_0.fromCritText_.text = string.format("%.2f", arg_9_0.params_.oldCrit / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")

	local var_9_0 = HeroTools.CaculateHeroAttribute(arg_9_0.heroInfo_, {})

	HeroTools.CalFinalAttribute(var_9_0)

	arg_9_0.toCritText_.text = string.format("%.2f", var_9_0[HeroConst.HERO_ATTRIBUTE.CRITICAL] / 10) .. (PublicAttrCfg[HeroConst.HERO_ATTRIBUTE.CRITICAL].percent == 1 and "%" or "")
end

function var_0_1.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_1.super.Dispose(arg_10_0)
end

return var_0_1
