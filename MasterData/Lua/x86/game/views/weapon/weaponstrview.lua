local WeaponStrView = class("WeaponStrView", (import("game.views.pop.PopLevelUpBaseView")))

function WeaponStrView:UIName()
	return "Widget/System/Hero_key/HeroKeyLvupPopUI"
end

function WeaponStrView:UIParent()
	return manager.ui.uiPop.transform
end

function WeaponStrView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponStrView:InitUI()
	self:BindCfgUI()
end

function WeaponStrView:AddUIListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
		self.params_.callback()
	end)
end

function WeaponStrView:OnEnter()
	self:CheckBack()
	self:RefreshStrSuccess(self.params_.oriLv, self.params_.afterLv, self.params_.breakthrough)
end

function WeaponStrView:OnExit()
	return
end

function WeaponStrView:RefreshStrSuccess(arg_9_1, arg_9_2, arg_9_3)
	SetActive(self.lvGo_, false)
	SetActive(self.hxGo_, false)

	self.descChangeText_.text = arg_9_1
	self.desctextText_.text = arg_9_2
	self.originText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_9_1, arg_9_3)))
	self.afterText_.text = string.format("%d", (WeaponTools.WeaponAtk(arg_9_2, arg_9_3)))
end

function WeaponStrView:Cacheable()
	return false
end

function WeaponStrView:Dispose()
	self:RemoveAllListeners()
	WeaponStrView.super.Dispose(self)
end

return WeaponStrView
