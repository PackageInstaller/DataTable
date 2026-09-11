local WeaponBreakView = class("WeaponBreakView", (import("game.views.pop.PopLevelUpBaseView")))

function WeaponBreakView:UIName()
	return "Widget/System/Hero_key/HeroKeyBreakPopUI"
end

function WeaponBreakView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponBreakView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponBreakView:InitUI()
	self:BindCfgUI()
end

function WeaponBreakView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()

		if self.params_.callback then
			self.params_.callback()
		end
	end)
end

function WeaponBreakView:OnEnter()
	self:CheckBack()
	self:RefreshBreakSuccess(self.params_.heroID, self.params_.breakthrough)
end

function WeaponBreakView:OnExit()
	return
end

function WeaponBreakView:RefreshBreakSuccess(arg_9_1, arg_9_2)
	local var_9_0, var_9_1 = SkillTools.GetAttr(HeroCfg[arg_9_1].weapon_break_attribute[arg_9_2 + 1])
	local var_9_2, var_9_3 = SkillTools.GetAttr(HeroCfg[arg_9_1].weapon_break_attribute[arg_9_2 + 2])

	self.crinameText_.text = var_9_2
	self.descChangeText_.text = GameSetting.weapon_exp_limit.value[arg_9_2 + 1]
	self.desctextText_.text = GameSetting.weapon_exp_limit.value[arg_9_2 + 2]
	self.atkoriText_.text = string.format("%d", WeaponTools.WeaponAtk(GameSetting.weapon_exp_limit.value[arg_9_2 + 1], arg_9_2))
	self.atkafterText_.text = string.format("%d", WeaponTools.WeaponAtk(GameSetting.weapon_exp_limit.value[arg_9_2 + 1], arg_9_2 + 1))
	self.crioriText_.text = var_9_1
	self.criafterText_.text = var_9_3
end

function WeaponBreakView:Dispose()
	self:RemoveAllListeners()
	WeaponBreakView.super.Dispose(self)
end

function WeaponBreakView:Cacheable()
	return false
end

return WeaponBreakView
