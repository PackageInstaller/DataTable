local AshILLWeaponModule = class("AshILLWeaponModule", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/WeaponItem"

function AshILLWeaponModule:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.from = arg_1_3 or "DEFAULT"

	if not arg_1_2 then
		self.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
		self.transform_ = self.gameObject_.transform
		self.transform_.parent = arg_1_1
		self.transform_.localPosition = Vector3.zero
		self.transform_.localRotation = Quaternion.identity
		self.transform_.localScale = Vector3.one
		self.isCustomObj = false
	else
		self.gameObject_ = arg_1_2
		self.transform_ = self.gameObject_.transform
		self.isCustomObj = true
	end

	self.callback = nil

	self:Init()
end

function AshILLWeaponModule:Init()
	self:BindCfgUI()

	self.lockController = self.controller_:GetController("lock")
	self.tipController = self.controller_:GetController("tips")

	self:ShowProp(false)
	self:ShowTip(false)
	self:AddBtnListener(self.maskBtn_, nil, function()
		if self.from == "PREPARE" then
			if self.weaponCfg.unlockRate > AshSystemData:GetHomologyRate() then
				ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), self.weaponCfg.unlockRate))

				if self.callback then
					self.callback()
				end
			elseif self.callback then
				self.callback(self.weaponCfg.id)
			end

			return
		end

		if self.weaponCfg.unlockRate > AshSystemData:GetHomologyRate() then
			ShowTips(string.format(GetTips("ASH_UNLOCK_TIP"), self.weaponCfg.unlockRate))
		else
			self:ShowProp(not self.isShowProp)
		end
	end)
end

function AshILLWeaponModule:ShowTip(arg_4_1)
	if arg_4_1 ~= self.isShowTip then
		self.tipController:SetSelectedIndex(arg_4_1 and 1 or 0)

		self.isShowTip = arg_4_1
	end
end

function AshILLWeaponModule:ShowProp(arg_5_1)
	if arg_5_1 ~= self.isShowProp then
		SetActive(self.propObj_, arg_5_1)

		self.isShowProp = arg_5_1
	end
end

function AshILLWeaponModule:Render(arg_6_1)
	self.weaponCfg = arg_6_1

	if not self.weaponCfg then
		self.lockController:SetSelectedState("true")

		return
	end

	local var_6_0 = self.weaponCfg.cfg

	self.icon_.sprite = pureGetSpriteWithoutAtlas(self.weaponCfg.cfg.icon)
	self.nameTxt_.text = GetI18NText(var_6_0.name)
	self.descTxt_.text = GetI18NText(var_6_0.desc)
	self.atkTxt_.text = GetI18NText(var_6_0.atk)
	self.criTxt_.text = GetI18NText(var_6_0.crit)
	self.speedTxt_.text = GetI18NText(var_6_0.rate_of_fire)
	self.tipnameTxt_.text = GetI18NText(var_6_0.name)
	self.tipdescTxt_.text = GetI18NText(var_6_0.desc)
	self.tipatkTxt_.text = GetI18NText(var_6_0.atk)
	self.tipcriTxt_.text = GetI18NText(var_6_0.crit)
	self.tipspeedTxt_.text = GetI18NText(var_6_0.rate_of_fire)

	self:RenderLock()

	if self.weaponCfg.unlockRate > AshSystemData:GetHomologyRate() or self.from == "PREPARE" then
		self:ShowProp(false)
	else
		self:ShowProp(true)
	end
end

function AshILLWeaponModule:RenderLock()
	if self.weaponCfg.unlockRate > AshSystemData:GetHomologyRate() then
		self.lockController:SetSelectedState("true")
	else
		self.lockController:SetSelectedState("false")

		if self.aniTimer_ then
			self.aniTimer_:Stop()

			self.aniTimer_ = nil
		end

		if not getData("ash", "CowbotWeaponModuleLock" .. self.from .. self.weaponCfg.id) then
			saveData("ash", "CowbotWeaponModuleLock" .. self.from .. self.weaponCfg.id, true)
			FrameTimer.New(function()
				self.aniTimer_ = Timer.New(function()
					if self.lockAnim_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
						if self.aniTimer_ then
							self.aniTimer_:Stop()

							self.aniTimer_ = nil
						end

						manager.ui:UIEventEnabled(true)
					end
				end, 0.033, -1)

				manager.ui:UIEventEnabled(false)
				self.lockAnim_:Play("WeaponItem_unlock", 0, 0)
				self.aniTimer_:Start()
			end, 1, 1):Start()
		end
	end
end

function AshILLWeaponModule:SetCallback(arg_10_1)
	self.callback = arg_10_1
end

function AshILLWeaponModule:CheckID(arg_11_1)
	if not arg_11_1 then
		return false
	end

	return arg_11_1 == self.weaponCfg.id
end

function AshILLWeaponModule:Dispose()
	if self.aniTimer_ then
		self.aniTimer_:Stop()

		self.aniTimer_ = nil
	end

	if not self.isCustomObj then
		GameObject.DestroyImmediate(self.gameObject_)
		Asset.Unload(var_0_1)
	end

	self.super.Dispose(self)
end

return AshILLWeaponModule
