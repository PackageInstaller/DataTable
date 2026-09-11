local WeaponServantWakeUpView = class("WeaponServantWakeUpView", ReduxView)

function WeaponServantWakeUpView:UIName()
	return "Widget/System/Hero_servant/HeroServantCallNameUI"
end

function WeaponServantWakeUpView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponServantWakeUpView:Init()
	self:InitUI()
	self:AddUIListener()
end

function WeaponServantWakeUpView:InitUI()
	self:BindCfgUI()

	self.characterImg_.immediate = true
	self.iconImg_.immediate = true
end

function WeaponServantWakeUpView:AddUIListener()
	self:AddBtnListener(self.checkBtn_, nil, function()
		ServantAction.ServantMerge(self.servantID_, {
			self.uid_
		})
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function WeaponServantWakeUpView:OnServantMergeResult(arg_8_1, arg_8_2)
	self:Go("/weaponServantMergeResultView", {
		servantID = self.servantID_,
		uid = tonumber(arg_8_1.servant_uid),
		backThrice = self.backThrice_,
		HeroId = self.params_.HeroId,
		race = self.params_.race
	})
end

function WeaponServantWakeUpView:OnEnter()
	self.servantID_ = self.params_.servantID
	self.uid_ = self.params_.uid
	self.backThrice_ = self.params_.backThrice

	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)

	local var_9_0 = ServantTools.GetServantSpecHero(self.servantID_)

	self.characterImg_.spriteSync = SpritePathCfg.HeroLittleIcon.path .. var_9_0
	self.heronameText_.text = GetI18NText(HeroCfg[var_9_0].name)
	self.servantnameText_.text = ItemTools.getItemName(self.servantID_)

	self:UpdateImg()
	self:UpdateTips()
end

function WeaponServantWakeUpView:UpdateImg()
	self.iconImg_.spriteSync = "TextureConfig/WeaponServant/Portrait/" .. self.servantID_
end

function WeaponServantWakeUpView:UpdateTips()
	local var_12_0 = WeaponServantData:GetServantSByID(self.servantID_)
	local var_12_1 = 0
	local var_12_2 = 0

	if var_12_0 then
		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_3 = WeaponServantData:GetServantDataByUID(iter_12_0)

			if var_12_1 < var_12_3.stage then
				var_12_1 = var_12_3.stage
			end

			var_12_2 = var_12_2 + 1
		end
	end

	local var_12_4 = var_12_1 + var_12_2 - 1

	if var_12_2 > 0 then
		SetActive(self.tipsGo_, true)

		var_12_4 = GameSetting.weapon_promote_max.value[WeaponServantCfg[self.servantID_].starlevel] + 1 < var_12_4 and GameSetting.weapon_promote_max.value[WeaponServantCfg[self.servantID_].starlevel] + 1 or var_12_4
		self.tipsText_.text = string.format(GetTips("SERVANT_TRANSCEND_PROMPT"), tostring(var_12_4))
	else
		SetActive(self.tipsGo_, false)
	end
end

function WeaponServantWakeUpView:OnExit()
	return
end

return WeaponServantWakeUpView
