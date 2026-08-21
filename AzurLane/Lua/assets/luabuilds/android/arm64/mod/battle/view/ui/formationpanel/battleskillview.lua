ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig

ys.Battle.BattleSkillView = class("BattleSkillView")
ys.Battle.BattleSkillView.__name = "BattleSkillView"

function ys.Battle.BattleSkillView.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._mediator = arg_1_1
	arg_1_0._ui = arg_1_1._ui

	arg_1_0:InitBtns()
	arg_1_0:EnableWeaponButton(false)

	return
end

function ys.Battle.BattleSkillView.EnableWeaponButton(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._skillBtnList) do
		iter_2_1:Enabled(arg_2_1)
	end

	return
end

function ys.Battle.BattleSkillView.DisableWeapnButton(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._skillBtnList) do
		iter_3_1:Disable()
	end

	return
end

function ys.Battle.BattleSkillView.JamSkillButton(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._skillBtnList) do
		iter_4_1:SetJam(arg_4_1)
	end

	return
end

function ys.Battle.BattleSkillView.ShiftSubmarineManualButton(arg_5_0, arg_5_1)
	if arg_5_1 == var_0_0.Battle.OxyState.STATE_FREE_FLOAT then
		arg_5_0._diveBtn:SetActive(true)
		arg_5_0._floatBtn:SetActive(false)
	elseif arg_5_1 == var_0_0.Battle.OxyState.STATE_FREE_DIVE then
		arg_5_0._diveBtn:SetActive(false)
		arg_5_0._floatBtn:SetActive(true)
	end

	return
end

function ys.Battle.BattleSkillView.InitBtns(arg_6_0)
	arg_6_0._skillBtnList = {}
	arg_6_0._activeBtnList = {}
	arg_6_0._delayAnimaList = {}
	arg_6_0._fleetVO = arg_6_0._mediator._dataProxy:GetFleetByIFF(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)
	arg_6_0._buttonContainer = arg_6_0._ui._tf:Find("Weapon_button_container")
	arg_6_0._buttonRes = arg_6_0._ui._tf:Find("Weapon_button_Resource")
	arg_6_0._chargeBtn = arg_6_0:generateCommonButton(1)

	arg_6_0._chargeBtn:ConfigCallback(function()
		if arg_6_0._main_cannon_sound then
			arg_6_0._main_cannon_sound:Stop(true)
		end

		local var_9_0 = arg_6_0

		var_9_0._main_cannon_sound = pg.CriMgr.GetInstance():PlaySE_V3("battle-cannon-main-prepared")

		arg_6_0._fleetVO:CastChargeWeapon()

		return
	end, function()
		arg_6_0._fleetVO:UnleashChrageWeapon()

		return
	end, function()
		if arg_6_0._main_cannon_sound then
			arg_6_0._main_cannon_sound:Stop(true)
		end

		arg_6_0._fleetVO:CancelChargeWeapon()

		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._chargeBtn:SetProgressInfo((arg_6_0._fleetVO:GetChargeWeaponVO()))

	arg_6_0._torpedoBtn = arg_6_0:generateCommonButton(2)

	arg_6_0._torpedoBtn:ConfigCallback(function()
		arg_6_0._fleetVO:CastTorpedo()

		return
	end, function()
		arg_6_0._fleetVO:UnleashTorpedo()

		return
	end, function()
		arg_6_0._fleetVO:CancelTorpedo()

		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)

	local var_6_0 = arg_6_0._fleetVO:GetTorpedoWeaponVO()

	arg_6_0._torpedoBtn:SetProgressInfo(var_6_0)

	arg_6_0._airStrikeBtn = arg_6_0:generateCommonButton(3)

	arg_6_0._airStrikeBtn:ConfigCallback(function()
		return
	end, function()
		arg_6_0._fleetVO:UnleashAllInStrike(true)

		return
	end, function()
		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._airStrikeBtn:SetProgressInfo((arg_6_0._fleetVO:GetAirAssistVO()))

	arg_6_0._diveBtn = arg_6_0:generateSubmarineFuncButton(5)

	arg_6_0._diveBtn:ConfigCallback(function()
		return
	end, function()
		arg_6_0._fleetVO:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_DIVE, true)

		return
	end, function()
		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._diveBtn:SetProgressInfo((arg_6_0._fleetVO:GetSubFreeDiveVO()))
	arg_6_0._diveBtn:SetActive(false)

	arg_6_0._floatBtn = arg_6_0:generateSubmarineFuncButton(6)

	arg_6_0._floatBtn:ConfigCallback(function()
		return
	end, function()
		arg_6_0._fleetVO:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_FLOAT, true)

		return
	end, function()
		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._floatBtn:SetProgressInfo((arg_6_0._fleetVO:GetSubFreeFloatVO()))
	arg_6_0._floatBtn:SetActive(false)

	arg_6_0._boostBtn = arg_6_0:generateSubmarineFuncButton(7)

	arg_6_0._boostBtn:ConfigCallback(function()
		return
	end, function()
		arg_6_0._fleetVO:SubmarinBoost()

		return
	end, function()
		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._boostBtn:SetProgressInfo((arg_6_0._fleetVO:GetSubBoostVO()))

	arg_6_0._specialBtn = arg_6_0:generateSubmarineButton(9)

	arg_6_0._specialBtn:ConfigCallback(function()
		return
	end, function()
		arg_6_0._fleetVO:UnleashSubmarineSpecial()

		return
	end, function()
		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._specialBtn:SetProgressInfo((arg_6_0._fleetVO:GetSubSpecialVO()))

	arg_6_0._shiftBtn = arg_6_0:generateSubmarineFuncButton(8)

	arg_6_0._shiftBtn:ConfigCallback(function()
		return
	end, function()
		arg_6_0._fleetVO:ShiftManualSub()

		return
	end, function()
		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	arg_6_0._shiftBtn:SetProgressInfo((arg_6_0._fleetVO:GetSubShiftVO()))

	if arg_6_0._fleetVO._submarineVO:GetUseable() and arg_6_0._fleetVO._submarineVO:GetCount() > 0 then
		arg_6_0._subStriveBtn = arg_6_0:generateSubmarineButton(4)

		arg_6_0.SetSkillButtonPreferences(arg_6_0._subStriveBtn:GetSkin(), 4)
		arg_6_0._subStriveBtn:ConfigCallback(function()
			return
		end, function()
			arg_6_0._mediator._dataProxy:SubmarineStrike(var_0_0.Battle.BattleConfig.FRIENDLY_CODE)

			return
		end, function()
			return
		end, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

			return
		end)
		arg_6_0._subStriveBtn:SetProgressInfo(arg_6_0._fleetVO._submarineVO)
		table.insert(arg_6_0._activeBtnList, arg_6_0._subStriveBtn)
	end

	local var_6_1 = var_0_0.Battle.BattleWeaponButton.New()
	local var_6_2 = cloneTplTo(arg_6_0._progressSkin, arg_6_0._buttonContainer)

	arg_6_0.SetSkillButtonPreferences(var_6_2, 2)
	var_6_1:ConfigSkin(var_6_2)
	var_6_1:SwitchIcon(10)
	var_6_1:SwitchIconEffect(2)
	var_6_1:ConfigCallback(function()
		arg_6_0._fleetVO:CastTorpedo()

		return
	end, function()
		arg_6_0._fleetVO:UnleashTorpedo()

		return
	end, function()
		arg_6_0._fleetVO:CancelTorpedo()

		return
	end, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_emptyBlock"))

		return
	end)
	table.insert(arg_6_0._skillBtnList, var_6_1)
	var_6_1:SetProgressInfo(var_6_0)
	var_6_1:SetActive(false)
	arg_6_0._boostBtn:SetActive(false)
	arg_6_0._diveBtn:SetActive(false)
	arg_6_0._floatBtn:SetActive(false)
	arg_6_0._specialBtn:SetActive(false)
	arg_6_0._shiftBtn:SetActive(false)

	return
end

function ys.Battle.BattleSkillView.generateCommonButton(arg_22_0, arg_22_1)
	local var_22_0 = var_0_0.Battle.BattleState.GetCombatSkinKey()
	local var_22_1 = var_0_0.Battle["BattleWeaponButton" .. var_22_0] and var_0_0.Battle["BattleWeaponButton" .. var_22_0].New() or var_0_0.Battle.BattleWeaponButton.New()

	arg_22_0._progressSkin = arg_22_0._progressSkin or arg_22_0._ui._tf:Find("Weapon_button_progress")

	local var_22_2 = cloneTplTo(arg_22_0._progressSkin, arg_22_0._buttonContainer)

	var_22_2.name = "Skill_" .. arg_22_1

	arg_22_0.SetSkillButtonPreferences(var_22_2, arg_22_1)
	var_22_1:ConfigSkin(var_22_2)
	var_22_1:SwitchIcon(arg_22_1)
	var_22_1:SwitchIconEffect(arg_22_1)
	var_22_1:SetTextActive(true)
	table.insert(arg_22_0._skillBtnList, var_22_1)

	return var_22_1
end

function ys.Battle.BattleSkillView.generateSubmarineFuncButton(arg_23_0, arg_23_1)
	local var_23_0 = var_0_0.Battle.BattleState.GetCombatSkinKey()
	local var_23_1 = var_0_0.Battle["BattleSubmarineFuncButton" .. var_23_0] and var_0_0.Battle["BattleSubmarineFuncButton" .. var_23_0].New() or var_0_0.Battle.BattleSubmarineFuncButton.New()

	arg_23_0._progressSkin = arg_23_0._progressSkin or arg_23_0._ui._tf:Find("Weapon_button_progress")

	var_23_1:ConfigSkin((cloneTplTo(arg_23_0._progressSkin, arg_23_0._buttonContainer)))
	var_23_1:SwitchIcon(arg_23_1)
	var_23_1:SetTextActive(false)
	table.insert(arg_23_0._skillBtnList, var_23_1)

	return var_23_1
end

function ys.Battle.BattleSkillView.generateSubmarineButton(arg_24_0, arg_24_1)
	local var_24_0 = var_0_0.Battle.BattleState.GetCombatSkinKey()
	local var_24_1 = var_0_0.Battle["BattleSubmarineButton" .. var_24_0] and var_0_0.Battle["BattleSubmarineButton" .. var_24_0].New() or var_0_0.Battle.BattleSubmarineButton.New()

	arg_24_0._disposableSkin = arg_24_0._disposableSkin or arg_24_0._ui._tf:Find("Weapon_button")

	var_24_1:ConfigSkin((cloneTplTo(arg_24_0._disposableSkin, arg_24_0._buttonContainer)))
	var_24_1:SwitchIcon(arg_24_1)
	table.insert(arg_24_0._skillBtnList, var_24_1)

	return var_24_1
end

function ys.Battle.BattleSkillView.CustomButton(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		arg_25_0._skillBtnList[iter_25_1]:SetActive(false)
	end

	return
end

function ys.Battle.BattleSkillView.NormalButton(arg_26_0)
	arg_26_0._chargeBtn:SetActive(true)
	arg_26_0._torpedoBtn:SetActive(true)
	arg_26_0._airStrikeBtn:SetActive(true)
	arg_26_0._boostBtn:SetActive(false)
	arg_26_0._diveBtn:SetActive(false)
	arg_26_0._floatBtn:SetActive(false)
	arg_26_0._specialBtn:SetActive(false)
	arg_26_0._shiftBtn:SetActive(false)
	table.insert(arg_26_0._activeBtnList, arg_26_0._chargeBtn)
	table.insert(arg_26_0._activeBtnList, arg_26_0._torpedoBtn)
	table.insert(arg_26_0._activeBtnList, arg_26_0._airStrikeBtn)
	table.insert(arg_26_0._delayAnimaList, arg_26_0._chargeBtn)
	table.insert(arg_26_0._delayAnimaList, arg_26_0._torpedoBtn)
	table.insert(arg_26_0._delayAnimaList, arg_26_0._airStrikeBtn)

	if arg_26_0._subStriveBtn then
		table.insert(arg_26_0._delayAnimaList, arg_26_0._subStriveBtn)
	end

	return
end

function ys.Battle.BattleSkillView.SubmarineButton(arg_27_0)
	arg_27_0._chargeBtn:SetActive(false)
	arg_27_0._torpedoBtn:SetActive(true)
	arg_27_0._airStrikeBtn:SetActive(false)
	arg_27_0._boostBtn:SetActive(true)
	arg_27_0._diveBtn:SetActive(true)
	arg_27_0._floatBtn:SetActive(true)
	table.insert(arg_27_0._activeBtnList, arg_27_0._diveBtn)
	table.insert(arg_27_0._activeBtnList, arg_27_0._torpedoBtn)
	table.insert(arg_27_0._activeBtnList, arg_27_0._boostBtn)
	table.insert(arg_27_0._activeBtnList, arg_27_0._floatBtn)
	table.insert(arg_27_0._delayAnimaList, arg_27_0._floatBtn)
	table.insert(arg_27_0._delayAnimaList, arg_27_0._torpedoBtn)
	table.insert(arg_27_0._delayAnimaList, arg_27_0._boostBtn)

	local var_27_0 = arg_27_0._torpedoBtn:GetSkin().transform

	var_27_0.anchorMin = Vector2(var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].x, var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].y)
	var_27_0.anchorMax = Vector2(var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].x, var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2].y)

	return
end

function ys.Battle.BattleSkillView.SubRoutineButton(arg_28_0)
	arg_28_0._chargeBtn:SetActive(false)
	arg_28_0._torpedoBtn:SetActive(true)
	arg_28_0._airStrikeBtn:SetActive(false)
	arg_28_0._boostBtn:SetActive(false)
	arg_28_0._diveBtn:SetActive(true)
	arg_28_0._floatBtn:SetActive(true)
	arg_28_0._specialBtn:SetActive(true)
	arg_28_0._shiftBtn:SetActive(true)
	table.insert(arg_28_0._activeBtnList, arg_28_0._diveBtn)
	table.insert(arg_28_0._activeBtnList, arg_28_0._torpedoBtn)
	table.insert(arg_28_0._activeBtnList, arg_28_0._specialBtn)
	table.insert(arg_28_0._activeBtnList, arg_28_0._floatBtn)
	table.insert(arg_28_0._activeBtnList, arg_28_0._shiftBtn)
	table.insert(arg_28_0._delayAnimaList, arg_28_0._floatBtn)
	table.insert(arg_28_0._delayAnimaList, arg_28_0._torpedoBtn)
	table.insert(arg_28_0._delayAnimaList, arg_28_0._shiftBtn)
	table.insert(arg_28_0._delayAnimaList, arg_28_0._specialBtn)
	arg_28_0.SetSkillButtonPreferences(arg_28_0._diveBtn:GetSkin(), 1)
	arg_28_0.SetSkillButtonPreferences(arg_28_0._floatBtn:GetSkin(), 1)
	arg_28_0.SetSkillButtonPreferences(arg_28_0._torpedoBtn:GetSkin(), 2)
	arg_28_0.SetSkillButtonPreferences(arg_28_0._shiftBtn:GetSkin(), 3)
	arg_28_0.SetSkillButtonPreferences(arg_28_0._specialBtn:GetSkin(), 4)

	return
end

function ys.Battle.BattleSkillView.AirFightButton(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0._skillBtnList) do
		local var_29_0 = table.indexof({
			9
		}, iter_29_0)

		iter_29_1:SetActive(var_29_0)

		if var_29_0 then
			table.insert(arg_29_0._activeBtnList, iter_29_1)
			arg_29_0.SetSkillButtonPreferences(iter_29_1:GetSkin(), var_29_0)
		end
	end

	return
end

function ys.Battle.BattleSkillView.ButtonInitialAnima(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._delayAnimaList) do
		iter_30_1:InitialAnima(iter_30_0 * 0.2)
	end

	return
end

function ys.Battle.BattleSkillView.CardPuzzleButton(arg_31_0)
	arg_31_0._chargeBtn:SetActive(false)
	arg_31_0._torpedoBtn:SetActive(false)
	arg_31_0._airStrikeBtn:SetActive(false)
	arg_31_0._boostBtn:SetActive(false)
	arg_31_0._diveBtn:SetActive(false)
	arg_31_0._floatBtn:SetActive(false)
	arg_31_0._specialBtn:SetActive(false)
	arg_31_0._shiftBtn:SetActive(false)

	return
end

function ys.Battle.BattleSkillView.HideSkillButton(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0._activeBtnList) do
		iter_32_1:SetActive(not arg_32_1)
	end

	return
end

function ys.Battle.BattleSkillView.OnSkillCd(arg_33_0, arg_33_1)
	if arg_33_1.Data.coolDownTime < pg.TimeMgr.GetInstance():GetCombatTime() then
		return
	end

	arg_33_0._skillCd[arg_33_1.Data.skillID] = arg_33_1.Data.coolDownTime

	return
end

function ys.Battle.BattleSkillView.Dispose(arg_34_0)
	arg_34_0._delayAnimaList = nil
	arg_34_0._activeBtnList = nil

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._skillBtnList) do
		iter_34_1:Dispose()
	end

	arg_34_0._ui = nil

	if arg_34_0._main_cannon_sound then
		arg_34_0._main_cannon_sound:Stop(true)

		arg_34_0._main_cannon_sound = nil
	end

	var_0_0.EventListener.DetachEventListener(arg_34_0)

	return
end

function ys.Battle.BattleSkillView.Update(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0._skillBtnList) do
		iter_35_1:Update()
	end

	return
end

function ys.Battle.BattleSkillView.SetSkillButtonPreferences(arg_36_0, arg_36_1)
	local var_36_0 = PlayerPrefs.GetFloat("skill_" .. arg_36_1 .. "_scale", var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1].scale)
	local var_36_1 = PlayerPrefs.GetFloat("skill_" .. arg_36_1 .. "_anchorX", var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1].x)
	local var_36_2 = PlayerPrefs.GetFloat("skill_" .. arg_36_1 .. "_anchorY", var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1].y)

	arg_36_0.transform.localScale = Vector3(var_36_0, var_36_0, 1)
	arg_36_0.transform.anchorMin = Vector2(var_36_1, var_36_2)
	arg_36_0.transform.anchorMax = Vector2(var_36_1, var_36_2)

	return
end

return
