ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattleSkillView = class("BattleSkillView")
ys.Battle.BattleSkillView.__name = "BattleSkillView"

function ys.Battle.BattleSkillView:Ctor(arg_1_1)
	var_0_0.EventListener.AttachEventListener(self)

	self._mediator = arg_1_1
	self._ui = arg_1_1._ui

	self:InitBtns()
	self:EnableWeaponButton(false)

	return
end

function ys.Battle.BattleSkillView:EnableWeaponButton(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(self._skillBtnList) do
		iter_2_1:Enabled(arg_2_1)
	end

	return
end

function ys.Battle.BattleSkillView:DisableWeapnButton()
	for iter_3_0, iter_3_1 in ipairs(self._skillBtnList) do
		iter_3_1:Disable()
	end

	return
end

function ys.Battle.BattleSkillView:JamSkillButton(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self._skillBtnList) do
		iter_4_1:SetJam(arg_4_1)
	end

	return
end

function ys.Battle.BattleSkillView:ShiftSubmarineManualButton(arg_5_1)
	if arg_5_1 == var_0_0.Battle.OxyState.STATE_FREE_FLOAT then
		self._diveBtn:SetActive(true)
		self._floatBtn:SetActive(false)
	elseif arg_5_1 == var_0_0.Battle.OxyState.STATE_FREE_DIVE then
		self._diveBtn:SetActive(false)
		self._floatBtn:SetActive(true)
	end

	return
end

function ys.Battle.BattleSkillView:InitBtns()
	self._skillBtnList = {}
	self._activeBtnList = {}
	self._delayAnimaList = {}
	self._fleetVO = self._mediator._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
	self._buttonContainer = self._ui._tf:Find("Weapon_button_container")
	self._buttonRes = self._ui._tf:Find("Weapon_button_Resource")

	local function var_6_0()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end

	local function var_6_1()
		return
	end

	self._chargeBtn = self:generateCommonButton(1)

	self._chargeBtn:ConfigCallback(function()
		if self._main_cannon_sound then
			self._main_cannon_sound:Stop(true)
		end

		self._main_cannon_sound = pg.CriMgr.GetInstance():PlaySE_V3("battle-cannon-main-prepared")

		self._fleetVO:CastChargeWeapon()

		return
	end, function()
		self._fleetVO:UnleashChrageWeapon()

		return
	end, function()
		if self._main_cannon_sound then
			self._main_cannon_sound:Stop(true)
		end

		self._fleetVO:CancelChargeWeapon()

		return
	end, var_6_0)
	self._chargeBtn:SetProgressInfo((self._fleetVO:GetChargeWeaponVO()))

	local function var_6_2()
		self._fleetVO:CastTorpedo()

		return
	end

	local function var_6_3()
		self._fleetVO:UnleashTorpedo()

		return
	end

	local function var_6_4()
		self._fleetVO:CancelTorpedo()

		return
	end

	self._torpedoBtn = self:generateCommonButton(2)

	self._torpedoBtn:ConfigCallback(var_6_2, var_6_3, var_6_4, var_6_0)

	local var_6_5 = self._fleetVO:GetTorpedoWeaponVO()

	self._torpedoBtn:SetProgressInfo(var_6_5)

	self._airStrikeBtn = self:generateCommonButton(3)

	self._airStrikeBtn:ConfigCallback(var_6_1, function()
		self._fleetVO:UnleashAllInStrike(true)

		return
	end, var_6_1, var_6_0)
	self._airStrikeBtn:SetProgressInfo((self._fleetVO:GetAirAssistVO()))

	self._diveBtn = self:generateSubmarineFuncButton(5)

	self._diveBtn:ConfigCallback(var_6_1, function()
		self._fleetVO:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_DIVE, true)

		return
	end, var_6_1, var_6_0)
	self._diveBtn:SetProgressInfo((self._fleetVO:GetSubFreeDiveVO()))
	self._diveBtn:SetActive(false)

	self._floatBtn = self:generateSubmarineFuncButton(6)

	self._floatBtn:ConfigCallback(var_6_1, function()
		self._fleetVO:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_FLOAT, true)

		return
	end, var_6_1, var_6_0)
	self._floatBtn:SetProgressInfo((self._fleetVO:GetSubFreeFloatVO()))
	self._floatBtn:SetActive(false)

	self._boostBtn = self:generateSubmarineFuncButton(7)

	self._boostBtn:ConfigCallback(var_6_1, function()
		self._fleetVO:SubmarinBoost()

		return
	end, var_6_1, var_6_0)
	self._boostBtn:SetProgressInfo((self._fleetVO:GetSubBoostVO()))

	self._specialBtn = self:generateSubmarineButton(9)

	self._specialBtn:ConfigCallback(var_6_1, function()
		self._fleetVO:UnleashSubmarineSpecial()

		return
	end, var_6_1, var_6_0)
	self._specialBtn:SetProgressInfo((self._fleetVO:GetSubSpecialVO()))

	self._shiftBtn = self:generateSubmarineFuncButton(8)

	self._shiftBtn:ConfigCallback(var_6_1, function()
		self._fleetVO:ShiftManualSub()

		return
	end, var_6_1, var_6_0)
	self._shiftBtn:SetProgressInfo((self._fleetVO:GetSubShiftVO()))

	if self._fleetVO._submarineVO:GetUseable() and self._fleetVO._submarineVO:GetCount() > 0 then
		self._subStriveBtn = self:generateSubmarineButton(4)

		self.SetSkillButtonPreferences(self._subStriveBtn:GetSkin(), 4)
		self._subStriveBtn:ConfigCallback(var_6_1, function()
			self._mediator._dataProxy:SubmarineStrike(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

			return
		end, var_6_1, var_6_0)
		self._subStriveBtn:SetProgressInfo(self._fleetVO._submarineVO)
		table.insert(self._activeBtnList, self._subStriveBtn)
	end

	local var_6_6 = var_0_0.Battle.BattleWeaponButton.New()
	local var_6_7 = cloneTplTo(self._progressSkin, self._buttonContainer)

	self.SetSkillButtonPreferences(var_6_7, 2)
	var_6_6:ConfigSkin(var_6_7)
	var_6_6:SwitchIcon(10)
	var_6_6:SwitchIconEffect(2)
	var_6_6:ConfigCallback(var_6_2, var_6_3, var_6_4, var_6_0)
	table.insert(self._skillBtnList, var_6_6)
	var_6_6:SetProgressInfo(var_6_5)
	var_6_6:SetActive(false)
	self._boostBtn:SetActive(false)
	self._diveBtn:SetActive(false)
	self._floatBtn:SetActive(false)
	self._specialBtn:SetActive(false)
	self._shiftBtn:SetActive(false)

	return
end

function ys.Battle.BattleSkillView:generateCommonButton(arg_22_1)
	local var_22_0 = var_0_0.Battle.BattleState.GetCombatSkinKey()
	local var_22_1 = var_0_0.Battle["BattleWeaponButton" .. var_22_0] and var_0_0.Battle["BattleWeaponButton" .. var_22_0].New() or var_0_0.Battle.BattleWeaponButton.New()

	self._progressSkin = self._progressSkin or self._ui._tf:Find("Weapon_button_progress")

	local var_22_2 = cloneTplTo(self._progressSkin, self._buttonContainer)

	var_22_2.name = "Skill_" .. arg_22_1

	self.SetSkillButtonPreferences(var_22_2, arg_22_1)
	var_22_1:ConfigSkin(var_22_2)
	var_22_1:SwitchIcon(arg_22_1)
	var_22_1:SwitchIconEffect(arg_22_1)
	var_22_1:SetTextActive(true)
	table.insert(self._skillBtnList, var_22_1)

	return var_22_1
end

function ys.Battle.BattleSkillView:generateSubmarineFuncButton(arg_23_1)
	local var_23_0 = var_0_0.Battle.BattleState.GetCombatSkinKey()
	local var_23_1 = var_0_0.Battle["BattleSubmarineFuncButton" .. var_23_0] and var_0_0.Battle["BattleSubmarineFuncButton" .. var_23_0].New() or var_0_0.Battle.BattleSubmarineFuncButton.New()

	self._progressSkin = self._progressSkin or self._ui._tf:Find("Weapon_button_progress")

	var_23_1:ConfigSkin((cloneTplTo(self._progressSkin, self._buttonContainer)))
	var_23_1:SwitchIcon(arg_23_1)
	var_23_1:SetTextActive(false)
	table.insert(self._skillBtnList, var_23_1)

	return var_23_1
end

function ys.Battle.BattleSkillView:generateSubmarineButton(arg_24_1)
	local var_24_0 = var_0_0.Battle.BattleState.GetCombatSkinKey()
	local var_24_1 = var_0_0.Battle["BattleSubmarineButton" .. var_24_0] and var_0_0.Battle["BattleSubmarineButton" .. var_24_0].New() or var_0_0.Battle.BattleSubmarineButton.New()

	self._disposableSkin = self._disposableSkin or self._ui._tf:Find("Weapon_button")

	var_24_1:ConfigSkin((cloneTplTo(self._disposableSkin, self._buttonContainer)))
	var_24_1:SwitchIcon(arg_24_1)
	table.insert(self._skillBtnList, var_24_1)

	return var_24_1
end

function ys.Battle.BattleSkillView:CustomButton(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		self._skillBtnList[iter_25_1]:SetActive(false)
	end

	return
end

function ys.Battle.BattleSkillView:NormalButton()
	self._chargeBtn:SetActive(true)
	self._torpedoBtn:SetActive(true)
	self._airStrikeBtn:SetActive(true)
	self._boostBtn:SetActive(false)
	self._diveBtn:SetActive(false)
	self._floatBtn:SetActive(false)
	self._specialBtn:SetActive(false)
	self._shiftBtn:SetActive(false)
	table.insert(self._activeBtnList, self._chargeBtn)
	table.insert(self._activeBtnList, self._torpedoBtn)
	table.insert(self._activeBtnList, self._airStrikeBtn)
	table.insert(self._delayAnimaList, self._chargeBtn)
	table.insert(self._delayAnimaList, self._torpedoBtn)
	table.insert(self._delayAnimaList, self._airStrikeBtn)

	if self._subStriveBtn then
		table.insert(self._delayAnimaList, self._subStriveBtn)
	end

	return
end

function ys.Battle.BattleSkillView:SubmarineButton()
	self._chargeBtn:SetActive(false)
	self._torpedoBtn:SetActive(true)
	self._airStrikeBtn:SetActive(false)
	self._boostBtn:SetActive(true)
	self._diveBtn:SetActive(true)
	self._floatBtn:SetActive(true)
	table.insert(self._activeBtnList, self._diveBtn)
	table.insert(self._activeBtnList, self._torpedoBtn)
	table.insert(self._activeBtnList, self._boostBtn)
	table.insert(self._activeBtnList, self._floatBtn)
	table.insert(self._delayAnimaList, self._floatBtn)
	table.insert(self._delayAnimaList, self._torpedoBtn)
	table.insert(self._delayAnimaList, self._boostBtn)

	local var_27_0 = self._torpedoBtn:GetSkin().transform

	var_27_0.anchorMin = Vector2(var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].x, var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].y)
	var_27_0.anchorMax = Vector2(var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].x, var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].y)

	return
end

function ys.Battle.BattleSkillView:SubRoutineButton()
	self._chargeBtn:SetActive(false)
	self._torpedoBtn:SetActive(true)
	self._airStrikeBtn:SetActive(false)
	self._boostBtn:SetActive(false)
	self._diveBtn:SetActive(true)
	self._floatBtn:SetActive(true)
	self._specialBtn:SetActive(true)
	self._shiftBtn:SetActive(true)
	table.insert(self._activeBtnList, self._diveBtn)
	table.insert(self._activeBtnList, self._torpedoBtn)
	table.insert(self._activeBtnList, self._specialBtn)
	table.insert(self._activeBtnList, self._floatBtn)
	table.insert(self._activeBtnList, self._shiftBtn)
	table.insert(self._delayAnimaList, self._floatBtn)
	table.insert(self._delayAnimaList, self._torpedoBtn)
	table.insert(self._delayAnimaList, self._shiftBtn)
	table.insert(self._delayAnimaList, self._specialBtn)
	self.SetSkillButtonPreferences(self._diveBtn:GetSkin(), 1)
	self.SetSkillButtonPreferences(self._floatBtn:GetSkin(), 1)
	self.SetSkillButtonPreferences(self._torpedoBtn:GetSkin(), 2)
	self.SetSkillButtonPreferences(self._shiftBtn:GetSkin(), 3)
	self.SetSkillButtonPreferences(self._specialBtn:GetSkin(), 4)

	return
end

function ys.Battle.BattleSkillView:AirFightButton()
	local var_29_0 = {
		9
	}

	for iter_29_0, iter_29_1 in ipairs(self._skillBtnList) do
		local var_29_1 = table.indexof(var_29_0, iter_29_0)

		iter_29_1:SetActive(var_29_1)

		if var_29_1 then
			table.insert(self._activeBtnList, iter_29_1)
			self.SetSkillButtonPreferences(iter_29_1:GetSkin(), var_29_1)
		end
	end

	return
end

function ys.Battle.BattleSkillView:ButtonInitialAnima()
	for iter_30_0, iter_30_1 in ipairs(self._delayAnimaList) do
		iter_30_1:InitialAnima(iter_30_0 * 0.2)
	end

	return
end

function ys.Battle.BattleSkillView:CardPuzzleButton()
	self._chargeBtn:SetActive(false)
	self._torpedoBtn:SetActive(false)
	self._airStrikeBtn:SetActive(false)
	self._boostBtn:SetActive(false)
	self._diveBtn:SetActive(false)
	self._floatBtn:SetActive(false)
	self._specialBtn:SetActive(false)
	self._shiftBtn:SetActive(false)

	return
end

function ys.Battle.BattleSkillView:HideSkillButton(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self._activeBtnList) do
		iter_32_1:SetActive(not arg_32_1)
	end

	return
end

function ys.Battle.BattleSkillView:OnSkillCd(arg_33_1)
	if arg_33_1.Data.coolDownTime < pg.TimeMgr.GetInstance():GetCombatTime() then
		return
	end

	self._skillCd[arg_33_1.Data.skillID] = arg_33_1.Data.coolDownTime

	return
end

function ys.Battle.BattleSkillView:Dispose()
	self._delayAnimaList = nil
	self._activeBtnList = nil

	for iter_34_0, iter_34_1 in ipairs(self._skillBtnList) do
		iter_34_1:Dispose()
	end

	self._ui = nil

	if self._main_cannon_sound then
		self._main_cannon_sound:Stop(true)

		self._main_cannon_sound = nil
	end

	var_0_0.EventListener.DetachEventListener(self)

	return
end

function ys.Battle.BattleSkillView:Update()
	for iter_35_0, iter_35_1 in ipairs(self._skillBtnList) do
		iter_35_1:Update()
	end

	return
end

function ys.Battle.BattleSkillView:SetSkillButtonPreferences(arg_36_1)
	local var_36_0 = PlayerPrefs.GetFloat("skill_" .. arg_36_1 .. "_scale", var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1].scale)
	local var_36_1 = PlayerPrefs.GetFloat("skill_" .. arg_36_1 .. "_anchorX", var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1].x)
	local var_36_2 = PlayerPrefs.GetFloat("skill_" .. arg_36_1 .. "_anchorY", var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1].y)

	self.transform.localScale = Vector3(var_36_0, var_36_0, 1)
	self.transform.anchorMin = Vector2(var_36_1, var_36_2)
	self.transform.anchorMax = Vector2(var_36_1, var_36_2)

	return
end

return
