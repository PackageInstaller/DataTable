local WeaponDetailView = class("WeaponDetailView", ReduxView)

function WeaponDetailView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:Init()
end

function WeaponDetailView:Init()
	self.constVar = {
		sliderBarWidth = 387
	}
end

function WeaponDetailView:OnEnter()
	return
end

function WeaponDetailView:OnExit()
	return
end

function WeaponDetailView:ShowWeaponInfo(arg_5_1, arg_5_2, arg_5_3)
	self.weaponnameText_.text = HeroCfg[arg_5_1].weapon_name
	self.nowlevelText_.text = arg_5_2.level
	self.toplevelText_.text = "/" .. GameSetting.weapon_exp_limit.value[arg_5_2.breakthrough + 1] or HeroConst.WEAPON_LV_MAX
	self.weaponstoryText_.text = HeroCfg[arg_5_1].weapon_desc
	self.atknumText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_5_2.level, arg_5_2.breakthrough)))

	local var_5_0, var_5_1 = SkillTools.GetAttr(HeroCfg[arg_5_1].weapon_break_attribute[arg_5_2.breakthrough + 1])

	self.dcrinameText_.text = var_5_0
	self.crinumText_.text = var_5_1

	local var_5_2, var_5_3, var_5_4 = WeaponTools.AddWeaponExp(arg_5_2.exp, arg_5_2.breakthrough, 0)

	self.realExpTrans_:SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, (var_5_3 == HeroConst.WEAPON_LV_MAX or nil) and self.constVar.sliderBarWidth)

	self.expShowTxt_.text = arg_5_2.level >= HeroConst.WEAPON_LV_MAX and "-/-" or var_5_2 .. "/" .. GameLevelSetting[arg_5_2.level].weapon_level_exp
end

function WeaponDetailView:Dispose()
	self:RemoveAllListeners()
	WeaponDetailView.super.Dispose(self)
end

return WeaponDetailView
