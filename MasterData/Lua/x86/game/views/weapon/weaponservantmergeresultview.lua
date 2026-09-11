local WeaponServantWakeUpView = class("WeaponServantWakeUpView", ReduxView)

function WeaponServantWakeUpView:UIName()
	return "Widget/System/ObtainUI/Weapon/WeaponServantWakeUp_anim"
end

function WeaponServantWakeUpView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponServantWakeUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponServantWakeUpView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		local var_5_0 = self.weaponservantwakeup_animAni_:GetCurrentAnimatorStateInfo(0)

		if var_5_0.normalizedTime <= 0.0505 then
			self.weaponservantwakeup_animAni_:Play(var_5_0.fullPathHash, -1, 0.0505)
			manager.audio:StopEffect()
		else
			self:Back()
			self:Back()
			ServantTools.JumpToNormalList(self.HeroID, self.uid_)
			self:Go("/weaponServant", {
				uid = self.uid_,
				HeroID = self.HeroID
			})
		end
	end)
end

function WeaponServantWakeUpView:InitUI()
	self:BindCfgUI()

	self.sleepyiconImg_.immediate = true
	self.portrait_.immediate = true
end

function WeaponServantWakeUpView:OnEnter()
	manager.windowBar:HideBar()

	self.servantID_ = self.params_.servantID
	self.sleepyID_ = ServantTools.GetSleepyServantByServant(self.servantID_)
	self.uid_ = self.params_.uid
	self.HeroId = self.params_.HeroID
	self.name_.text = ItemTools.getItemName(self.servantID_)
	self.campImg_.sprite = getSprite("Atlas/CampItemAtlas", (string.format("icon_group_%d_c", WeaponServantCfg[self.servantID_].race)))
	self.sleepyiconImg_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. self.sleepyID_
	self.portrait_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. self.servantID_

	manager.audio:PlayEffect("ui_system", "key_awakening")
end

function WeaponServantWakeUpView:OnExit()
	return
end

function WeaponServantWakeUpView:Cacheable()
	return false
end

return WeaponServantWakeUpView
