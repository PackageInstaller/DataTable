ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleSkillView = var_0_10003("BattleSkillView")

local var_0_3 = var_0.Battle.BattleSkillView

var_0_3.__name = "BattleSkillView"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._mediator = arg_1_1
	arg_1_0._ui = arg_1_1._ui

	arg_1_0:InitBtns()
	arg_1_0:EnableWeaponButton(false)

	return
end

function var_0_3.EnableWeaponButton(arg_2_0, arg_2_1)
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0._skillBtnList) do
		iter_2_1:Enabled(arg_2_1)
	end

	return
end

function var_0_3.DisableWeapnButton(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0._skillBtnList) do
		iter_3_1:Disable()
	end

	return
end

function var_0_3.JamSkillButton(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0._skillBtnList) do
		iter_4_1:SetJam(arg_4_1)
	end

	return
end

function var_0_3.ShiftSubmarineManualButton(arg_5_0, arg_5_1)
	if arg_5_1 == var_0.Battle.OxyState.STATE_FREE_FLOAT then
		local var_5_0 = arg_5_0._diveBtn

		var_2.SetActive(var_5_0, true)

		local var_5_1 = arg_5_0._floatBtn

		var_2.SetActive(var_5_1, false)
	elseif arg_5_1 == var_0.Battle.OxyState.STATE_FREE_DIVE then
		local var_5_2 = arg_5_0._diveBtn

		var_2.SetActive(var_5_2, false)

		local var_5_3 = arg_5_0._floatBtn

		var_2.SetActive(var_5_3, true)
	end

	return
end

function var_0_3.InitBtns(arg_6_0)
	arg_6_0._skillBtnList = {}
	arg_6_0._activeBtnList = {}
	arg_6_0._delayAnimaList = {}

	local var_6_0 = arg_6_0._mediator._dataProxy

	arg_6_0._fleetVO = var_1.GetFleetByIFF(var_6_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	local var_6_1 = arg_6_0._ui._tf

	arg_6_0._buttonContainer = var_1.Find(var_6_1, "Weapon_button_container")

	local var_6_2 = arg_6_0._ui._tf

	arg_6_0._buttonRes = var_1.Find(var_6_2, "Weapon_button_Resource")

	local function var_6_3()
		pg = var_2_10000

		local var_7_0 = var_2_10000.TipsMgr.GetInstance()
		local var_7_1 = var_0.ShowTips

		i18n = var_2_10003

		var_7_1(var_7_0, var_2_10003("battle_emptyBlock"))

		return
	end

	local function var_6_4()
		return
	end

	local function var_6_5()
		if arg_6_0._main_cannon_sound then
			local var_9_0 = arg_6_0._main_cannon_sound

			var_0.Stop(var_9_0, true)
		end

		local var_9_1 = arg_6_0

		pg = var_2_10001

		local var_9_2 = var_2_10001.CriMgr.GetInstance()

		var_9_1._main_cannon_sound = var_1.PlaySE_V3(var_9_2, "battle-cannon-main-prepared")

		local var_9_3 = arg_6_0._fleetVO

		var_0.CastChargeWeapon(var_9_3)

		return
	end

	local function var_6_6()
		local var_10_0 = arg_6_0._fleetVO

		var_0.UnleashChrageWeapon(var_10_0)

		return
	end

	local function var_6_7()
		if arg_6_0._main_cannon_sound then
			local var_11_0 = arg_6_0._main_cannon_sound

			var_0.Stop(var_11_0, true)
		end

		local var_11_1 = arg_6_0._fleetVO

		var_0.CancelChargeWeapon(var_11_1)

		return
	end

	arg_6_0._chargeBtn = arg_6_0:generateCommonButton(1)

	local var_6_8 = arg_6_0._chargeBtn

	var_6.ConfigCallback(var_6_8, var_6_5, var_6_6, var_6_7, var_6_3)

	local var_6_9 = arg_6_0._fleetVO
	local var_6_10 = var_6.GetChargeWeaponVO(var_6_9)
	local var_6_11 = arg_6_0._chargeBtn

	var_7.SetProgressInfo(var_6_11, var_6_10)

	local function var_6_12()
		local var_12_0 = arg_6_0._fleetVO

		var_0.CastTorpedo(var_12_0)

		return
	end

	local function var_6_13()
		local var_13_0 = arg_6_0._fleetVO

		var_0.UnleashTorpedo(var_13_0)

		return
	end

	local function var_6_14()
		local var_14_0 = arg_6_0._fleetVO

		var_0.CancelTorpedo(var_14_0)

		return
	end

	arg_6_0._torpedoBtn = arg_6_0:generateCommonButton(2)

	local var_6_15 = arg_6_0._torpedoBtn

	var_10.ConfigCallback(var_6_15, var_6_12, var_6_13, var_6_14, var_6_3)

	local var_6_16 = arg_6_0._fleetVO
	local var_6_17 = var_10.GetTorpedoWeaponVO(var_6_16)
	local var_6_18 = arg_6_0._torpedoBtn

	var_11.SetProgressInfo(var_6_18, var_6_17)

	local function var_6_19()
		local var_15_0 = arg_6_0._fleetVO

		var_0.UnleashAllInStrike(var_15_0, true)

		return
	end

	arg_6_0._airStrikeBtn = arg_6_0:generateCommonButton(3)

	local var_6_20 = arg_6_0._airStrikeBtn

	var_12.ConfigCallback(var_6_20, var_6_4, var_6_19, var_6_4, var_6_3)

	local var_6_21 = arg_6_0._fleetVO
	local var_6_22 = var_12.GetAirAssistVO(var_6_21)
	local var_6_23 = arg_6_0._airStrikeBtn

	var_13.SetProgressInfo(var_6_23, var_6_22)

	local function var_6_24()
		local var_16_0 = arg_6_0._fleetVO

		var_0.ChangeSubmarineState(var_16_0, var_0.Battle.OxyState.STATE_FREE_DIVE, true)

		return
	end

	arg_6_0._diveBtn = arg_6_0:generateSubmarineFuncButton(5)

	local var_6_25 = arg_6_0._diveBtn

	var_14.ConfigCallback(var_6_25, var_6_4, var_6_24, var_6_4, var_6_3)

	local var_6_26 = arg_6_0._fleetVO
	local var_6_27 = var_14.GetSubFreeDiveVO(var_6_26)
	local var_6_28 = arg_6_0._diveBtn

	var_15.SetProgressInfo(var_6_28, var_6_27)

	local var_6_29 = arg_6_0._diveBtn

	var_15.SetActive(var_6_29, false)

	local function var_6_30()
		local var_17_0 = arg_6_0._fleetVO

		var_0.ChangeSubmarineState(var_17_0, var_0.Battle.OxyState.STATE_FREE_FLOAT, true)

		return
	end

	arg_6_0._floatBtn = arg_6_0:generateSubmarineFuncButton(6)

	local var_6_31 = arg_6_0._floatBtn

	var_16.ConfigCallback(var_6_31, var_6_4, var_6_30, var_6_4, var_6_3)

	local var_6_32 = arg_6_0._fleetVO
	local var_6_33 = var_16.GetSubFreeFloatVO(var_6_32)
	local var_6_34 = arg_6_0._floatBtn

	var_17.SetProgressInfo(var_6_34, var_6_33)

	local var_6_35 = arg_6_0._floatBtn

	var_17.SetActive(var_6_35, false)

	local function var_6_36()
		local var_18_0 = arg_6_0._fleetVO

		var_0.SubmarinBoost(var_18_0)

		return
	end

	arg_6_0._boostBtn = arg_6_0:generateSubmarineFuncButton(7)

	local var_6_37 = arg_6_0._boostBtn

	var_18.ConfigCallback(var_6_37, var_6_4, var_6_36, var_6_4, var_6_3)

	local var_6_38 = arg_6_0._fleetVO
	local var_6_39 = var_18.GetSubBoostVO(var_6_38)
	local var_6_40 = arg_6_0._boostBtn

	var_19.SetProgressInfo(var_6_40, var_6_39)

	local function var_6_41()
		local var_19_0 = arg_6_0._fleetVO

		var_0.UnleashSubmarineSpecial(var_19_0)

		return
	end

	arg_6_0._specialBtn = arg_6_0:generateSubmarineButton(9)

	local var_6_42 = arg_6_0._specialBtn

	var_20.ConfigCallback(var_6_42, var_6_4, var_6_41, var_6_4, var_6_3)

	local var_6_43 = arg_6_0._fleetVO
	local var_6_44 = var_20.GetSubSpecialVO(var_6_43)
	local var_6_45 = arg_6_0._specialBtn

	var_21.SetProgressInfo(var_6_45, var_6_44)

	local function var_6_46()
		local var_20_0 = arg_6_0._fleetVO

		var_0.ShiftManualSub(var_20_0)

		return
	end

	arg_6_0._shiftBtn = arg_6_0:generateSubmarineFuncButton(8)

	local var_6_47 = arg_6_0._shiftBtn

	var_22.ConfigCallback(var_6_47, var_6_4, var_6_46, var_6_4, var_6_3)

	local var_6_48 = arg_6_0._fleetVO
	local var_6_49 = var_22.GetSubShiftVO(var_6_48)
	local var_6_50 = arg_6_0._shiftBtn

	var_23.SetProgressInfo(var_6_50, var_6_49)

	local var_6_51 = arg_6_0._fleetVO._submarineVO

	if var_23.GetUseable(var_6_51) then
		local var_6_52 = var_23:GetCount()

		if 0 < var_6_52 then
			local function var_6_53()
				local var_21_0 = arg_6_0._mediator._dataProxy

				var_0.SubmarineStrike(var_21_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

				return
			end

			arg_6_0._subStriveBtn = arg_6_0:generateSubmarineButton(4)

			local var_6_54 = arg_6_0._subStriveBtn

			var_6_50 = var_6_50.GetSkin(var_6_54)

			arg_6_0.SetSkillButtonPreferences(var_6_50, 4)

			local var_6_55 = arg_6_0._subStriveBtn

			var_26.ConfigCallback(var_6_55, var_6_4, var_6_53, var_6_4, var_6_3)

			local var_6_56 = arg_6_0._subStriveBtn

			var_26.SetProgressInfo(var_6_56, var_23)

			table = var_26

			var_26.insert(arg_6_0._activeBtnList, arg_6_0._subStriveBtn)
		end
	end

	local var_6_57 = var_0.Battle.BattleWeaponButton.New()

	cloneTplTo = var_6_50

	local var_6_58 = var_6_50(arg_6_0._progressSkin, arg_6_0._buttonContainer)

	arg_6_0.SetSkillButtonPreferences(var_6_58, 2)
	var_6_57:ConfigSkin(var_6_58)
	var_6_57:SwitchIcon(10)
	var_6_57:SwitchIconEffect(2)
	var_6_57:ConfigCallback(var_6_12, var_6_13, var_6_14, var_6_3)

	table = var_26

	var_26.insert(arg_6_0._skillBtnList, var_6_57)
	var_6_57:SetProgressInfo(var_6_17)
	var_6_57:SetActive(false)

	local var_6_59 = arg_6_0._boostBtn

	var_26.SetActive(var_6_59, false)

	local var_6_60 = arg_6_0._diveBtn

	var_26.SetActive(var_6_60, false)

	local var_6_61 = arg_6_0._floatBtn

	var_26.SetActive(var_6_61, false)

	local var_6_62 = arg_6_0._specialBtn

	var_26.SetActive(var_6_62, false)

	local var_6_63 = arg_6_0._shiftBtn

	var_26.SetActive(var_6_63, false)

	return
end

function var_0_3.generateCommonButton(arg_22_0, arg_22_1)
	local var_22_0 = var_0.Battle.BattleState.GetCombatSkinKey()
	local var_22_1

	if var_0.Battle["BattleWeaponButton" .. var_22_0] then
		var_22_1 = var_0.Battle["BattleWeaponButton" .. var_22_0].New()
	else
		var_22_1 = var_0.Battle.BattleWeaponButton.New()
	end

	local var_22_3

	if not arg_22_0._progressSkin then
		local var_22_2 = arg_22_0._ui._tf

		var_22_3 = var_4.Find(var_22_2, "Weapon_button_progress")
	end

	arg_22_0._progressSkin = var_22_3
	cloneTplTo = var_22_3

	local var_22_4 = var_22_3(arg_22_0._progressSkin, arg_22_0._buttonContainer)

	var_22_4.name = "Skill_" .. arg_22_1

	arg_22_0.SetSkillButtonPreferences(var_22_4, arg_22_1)
	var_22_1:ConfigSkin(var_22_4)
	var_22_1:SwitchIcon(arg_22_1)
	var_22_1:SwitchIconEffect(arg_22_1)
	var_22_1:SetTextActive(true)

	table = var_5

	var_5.insert(arg_22_0._skillBtnList, var_22_1)

	return var_22_1
end

function var_0_3.generateSubmarineFuncButton(arg_23_0, arg_23_1)
	local var_23_0 = var_0.Battle.BattleState.GetCombatSkinKey()
	local var_23_1

	if var_0.Battle["BattleSubmarineFuncButton" .. var_23_0] then
		var_23_1 = var_0.Battle["BattleSubmarineFuncButton" .. var_23_0].New()
	else
		var_23_1 = var_0.Battle.BattleSubmarineFuncButton.New()
	end

	local var_23_3

	if not arg_23_0._progressSkin then
		local var_23_2 = arg_23_0._ui._tf

		var_23_3 = var_4.Find(var_23_2, "Weapon_button_progress")
	end

	arg_23_0._progressSkin = var_23_3
	cloneTplTo = var_23_3

	local var_23_4 = var_23_3(arg_23_0._progressSkin, arg_23_0._buttonContainer)

	var_23_1:ConfigSkin(var_23_4)
	var_23_1:SwitchIcon(arg_23_1)
	var_23_1:SetTextActive(false)

	table = var_5

	var_5.insert(arg_23_0._skillBtnList, var_23_1)

	return var_23_1
end

function var_0_3.generateSubmarineButton(arg_24_0, arg_24_1)
	local var_24_0 = var_0.Battle.BattleState.GetCombatSkinKey()
	local var_24_1

	if var_0.Battle["BattleSubmarineButton" .. var_24_0] then
		var_24_1 = var_0.Battle["BattleSubmarineButton" .. var_24_0].New()
	else
		var_24_1 = var_0.Battle.BattleSubmarineButton.New()
	end

	local var_24_3

	if not arg_24_0._disposableSkin then
		local var_24_2 = arg_24_0._ui._tf

		var_24_3 = var_4.Find(var_24_2, "Weapon_button")
	end

	arg_24_0._disposableSkin = var_24_3
	cloneTplTo = var_24_3

	local var_24_4 = var_24_3(arg_24_0._disposableSkin, arg_24_0._buttonContainer)

	var_24_1:ConfigSkin(var_24_4)
	var_24_1:SwitchIcon(arg_24_1)

	table = var_5

	var_5.insert(arg_24_0._skillBtnList, var_24_1)

	return var_24_1
end

function var_0_3.CustomButton(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_1) do
		local var_25_0 = arg_25_0._skillBtnList[iter_25_1]

		var_7.SetActive(var_25_0, false)
	end

	return
end

function var_0_3.NormalButton(arg_26_0)
	local var_26_0 = arg_26_0._chargeBtn

	var_1.SetActive(var_26_0, true)

	local var_26_1 = arg_26_0._torpedoBtn

	var_1.SetActive(var_26_1, true)

	local var_26_2 = arg_26_0._airStrikeBtn

	var_1.SetActive(var_26_2, true)

	local var_26_3 = arg_26_0._boostBtn

	var_1.SetActive(var_26_3, false)

	local var_26_4 = arg_26_0._diveBtn

	var_1.SetActive(var_26_4, false)

	local var_26_5 = arg_26_0._floatBtn

	var_1.SetActive(var_26_5, false)

	local var_26_6 = arg_26_0._specialBtn

	var_1.SetActive(var_26_6, false)

	local var_26_7 = arg_26_0._shiftBtn

	var_1.SetActive(var_26_7, false)

	table = var_1

	var_1.insert(arg_26_0._activeBtnList, arg_26_0._chargeBtn)

	table = var_1

	var_1.insert(arg_26_0._activeBtnList, arg_26_0._torpedoBtn)

	table = var_1

	var_1.insert(arg_26_0._activeBtnList, arg_26_0._airStrikeBtn)

	table = var_1

	var_1.insert(arg_26_0._delayAnimaList, arg_26_0._chargeBtn)

	table = var_1

	var_1.insert(arg_26_0._delayAnimaList, arg_26_0._torpedoBtn)

	table = var_1

	var_1.insert(arg_26_0._delayAnimaList, arg_26_0._airStrikeBtn)

	if arg_26_0._subStriveBtn then
		table = var_1

		var_1.insert(arg_26_0._delayAnimaList, arg_26_0._subStriveBtn)
	end

	return
end

function var_0_3.SubmarineButton(arg_27_0)
	local var_27_0 = arg_27_0._chargeBtn

	var_1.SetActive(var_27_0, false)

	local var_27_1 = arg_27_0._torpedoBtn

	var_1.SetActive(var_27_1, true)

	local var_27_2 = arg_27_0._airStrikeBtn

	var_1.SetActive(var_27_2, false)

	local var_27_3 = arg_27_0._boostBtn

	var_1.SetActive(var_27_3, true)

	local var_27_4 = arg_27_0._diveBtn

	var_1.SetActive(var_27_4, true)

	local var_27_5 = arg_27_0._floatBtn

	var_1.SetActive(var_27_5, true)

	table = var_1

	var_1.insert(arg_27_0._activeBtnList, arg_27_0._diveBtn)

	table = var_1

	var_1.insert(arg_27_0._activeBtnList, arg_27_0._torpedoBtn)

	table = var_1

	var_1.insert(arg_27_0._activeBtnList, arg_27_0._boostBtn)

	table = var_1

	var_1.insert(arg_27_0._activeBtnList, arg_27_0._floatBtn)

	table = var_1

	var_1.insert(arg_27_0._delayAnimaList, arg_27_0._floatBtn)

	table = var_1

	var_1.insert(arg_27_0._delayAnimaList, arg_27_0._torpedoBtn)

	table = var_1

	var_1.insert(arg_27_0._delayAnimaList, arg_27_0._boostBtn)

	local var_27_6 = arg_27_0._torpedoBtn
	local var_27_7 = var_1.GetSkin(var_27_6).transform
	local var_27_8 = var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[2]

	Vector2 = var_4
	var_27_7.anchorMin = var_4(var_27_8.x, var_27_8.y)
	Vector2 = var_4
	var_27_7.anchorMax = var_4(var_27_8.x, var_27_8.y)

	return
end

function var_0_3.SubRoutineButton(arg_28_0)
	local var_28_0 = arg_28_0._chargeBtn

	var_1.SetActive(var_28_0, false)

	local var_28_1 = arg_28_0._torpedoBtn

	var_1.SetActive(var_28_1, true)

	local var_28_2 = arg_28_0._airStrikeBtn

	var_1.SetActive(var_28_2, false)

	local var_28_3 = arg_28_0._boostBtn

	var_1.SetActive(var_28_3, false)

	local var_28_4 = arg_28_0._diveBtn

	var_1.SetActive(var_28_4, true)

	local var_28_5 = arg_28_0._floatBtn

	var_1.SetActive(var_28_5, true)

	local var_28_6 = arg_28_0._specialBtn

	var_1.SetActive(var_28_6, true)

	local var_28_7 = arg_28_0._shiftBtn

	var_1.SetActive(var_28_7, true)

	table = var_1

	var_1.insert(arg_28_0._activeBtnList, arg_28_0._diveBtn)

	table = var_1

	var_1.insert(arg_28_0._activeBtnList, arg_28_0._torpedoBtn)

	table = var_1

	var_1.insert(arg_28_0._activeBtnList, arg_28_0._specialBtn)

	table = var_1

	var_1.insert(arg_28_0._activeBtnList, arg_28_0._floatBtn)

	table = var_1

	var_1.insert(arg_28_0._activeBtnList, arg_28_0._shiftBtn)

	table = var_1

	var_1.insert(arg_28_0._delayAnimaList, arg_28_0._floatBtn)

	table = var_1

	var_1.insert(arg_28_0._delayAnimaList, arg_28_0._torpedoBtn)

	table = var_1

	var_1.insert(arg_28_0._delayAnimaList, arg_28_0._shiftBtn)

	table = var_1

	var_1.insert(arg_28_0._delayAnimaList, arg_28_0._specialBtn)

	local var_28_8 = arg_28_0.SetSkillButtonPreferences
	local var_28_9 = arg_28_0._diveBtn

	var_28_8(var_3.GetSkin(var_28_9), 1)

	local var_28_10 = arg_28_0.SetSkillButtonPreferences
	local var_28_11 = arg_28_0._floatBtn

	var_28_10(var_3.GetSkin(var_28_11), 1)

	local var_28_12 = arg_28_0.SetSkillButtonPreferences
	local var_28_13 = arg_28_0._torpedoBtn

	var_28_12(var_3.GetSkin(var_28_13), 2)

	local var_28_14 = arg_28_0.SetSkillButtonPreferences
	local var_28_15 = arg_28_0._shiftBtn

	var_28_14(var_3.GetSkin(var_28_15), 3)

	local var_28_16 = arg_28_0.SetSkillButtonPreferences
	local var_28_17 = arg_28_0._specialBtn

	var_28_16(var_3.GetSkin(var_28_17), 4)

	return
end

function var_0_3.AirFightButton(arg_29_0)
	local var_29_0 = {
		9
	}

	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0._skillBtnList) do
		table = var_1_10007
		var_1_10007 = var_1_10007.indexof(var_29_0, iter_29_0)

		iter_29_1:SetActive(var_1_10007)

		if var_1_10007 then
			table = var_8

			var_8.insert(arg_29_0._activeBtnList, iter_29_1)
			arg_29_0.SetSkillButtonPreferences(iter_29_1:GetSkin(), var_1_10007)
		end
	end

	return
end

function var_0_3.ButtonInitialAnima(arg_30_0)
	ipairs = var_1_10001

	for iter_30_0, iter_30_1 in var_1_10001(arg_30_0._delayAnimaList) do
		iter_30_1:InitialAnima(iter_30_0 * 0.2)
	end

	return
end

function var_0_3.CardPuzzleButton(arg_31_0)
	local var_31_0 = arg_31_0._chargeBtn

	var_1.SetActive(var_31_0, false)

	local var_31_1 = arg_31_0._torpedoBtn

	var_1.SetActive(var_31_1, false)

	local var_31_2 = arg_31_0._airStrikeBtn

	var_1.SetActive(var_31_2, false)

	local var_31_3 = arg_31_0._boostBtn

	var_1.SetActive(var_31_3, false)

	local var_31_4 = arg_31_0._diveBtn

	var_1.SetActive(var_31_4, false)

	local var_31_5 = arg_31_0._floatBtn

	var_1.SetActive(var_31_5, false)

	local var_31_6 = arg_31_0._specialBtn

	var_1.SetActive(var_31_6, false)

	local var_31_7 = arg_31_0._shiftBtn

	var_1.SetActive(var_31_7, false)

	return
end

function var_0_3.HideSkillButton(arg_32_0, arg_32_1)
	ipairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0._activeBtnList) do
		iter_32_1:SetActive(not arg_32_1)
	end

	return
end

function var_0_3.OnSkillCd(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_1.Data.skillID
	local var_33_1 = arg_33_1.Data.coolDownTime

	pg = var_1_10004

	local var_33_2 = var_1_10004.TimeMgr.GetInstance()

	if var_33_1 < var_4.GetCombatTime(var_33_2) then
		return
	end

	arg_33_0._skillCd[var_33_0] = var_33_1

	return
end

function var_0_3.Dispose(arg_34_0)
	arg_34_0._delayAnimaList = nil
	arg_34_0._activeBtnList = nil
	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0._skillBtnList) do
		iter_34_1:Dispose()
	end

	arg_34_0._ui = nil

	if arg_34_0._main_cannon_sound then
		local var_34_0 = arg_34_0._main_cannon_sound

		var_1.Stop(var_34_0, true)

		arg_34_0._main_cannon_sound = nil
	end

	var_0.EventListener.DetachEventListener(arg_34_0)

	return
end

function var_0_3.Update(arg_35_0)
	ipairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0._skillBtnList) do
		iter_35_1:Update()
	end

	return
end

function var_0_3.SetSkillButtonPreferences(arg_36_0, arg_36_1)
	local var_36_0 = var_0_1.SKILL_BUTTON_DEFAULT_PREFERENCE[arg_36_1]

	PlayerPrefs = var_1_10003

	local var_36_1 = var_1_10003.GetFloat("skill_" .. arg_36_1 .. "_scale", var_36_0.scale)

	PlayerPrefs = var_1_10004

	local var_36_2 = var_1_10004.GetFloat("skill_" .. arg_36_1 .. "_anchorX", var_36_0.x)

	PlayerPrefs = var_5

	local var_36_3 = var_5.GetFloat("skill_" .. arg_36_1 .. "_anchorY", var_36_0.y)
	local var_36_4 = arg_36_0.transform

	Vector3 = var_7
	var_36_4.localScale = var_7(var_36_1, var_36_1, 1)
	Vector2 = var_7
	var_36_4.anchorMin = var_7(var_36_2, var_36_3)
	Vector2 = var_7
	var_36_4.anchorMax = var_7(var_36_2, var_36_3)

	return
end

return
