ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleWeaponButton")

var_0.Battle.BattleWeaponButton = var_0_1
var_0_1.__name = "BattleWeaponButton"
var_0_1.ICON_BY_INDEX = {
	"cannon",
	"torpedo",
	"aircraft",
	"submarine",
	"dive",
	"rise",
	"boost",
	"switch",
	"special",
	"aamissile",
	"meteor",
	"pointairstrike"
}

function var_0_1.Ctor(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0.eventTriggers = {}

	return
end

function var_0_1.ConfigCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._downFunc = arg_2_1
	arg_2_0._upFunc = arg_2_2
	arg_2_0._cancelFunc = arg_2_3
	arg_2_0._emptyFunc = arg_2_4

	return
end

function var_0_1.SetActive(arg_3_0, arg_3_1)
	SetActive = var_1_10002

	var_1_10002(arg_3_0._skin, arg_3_1)

	return
end

function var_0_1.SetJam(arg_4_0, arg_4_1)
	SetActive = var_1_10002

	var_1_10002(arg_4_0._jam, arg_4_1)

	SetActive = var_1_10002

	var_1_10002(arg_4_0._icon, not arg_4_1)

	SetActive = var_1_10002

	var_1_10002(arg_4_0._progress, not arg_4_1)

	return
end

function var_0_1.SwitchIcon(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._iconIndex = arg_5_1

	local var_5_0 = var_0_1.ICON_BY_INDEX[arg_5_1]
	local var_5_1

	if (arg_5_2 or var_0.Battle.BattleState.GetCombatSkinKey()) ~= "Standard" then
		var_5_1 = ""
	end

	setImageSprite = var_1_10005

	local var_5_2 = arg_5_0._unfill

	LoadSprite = var_1_10008

	var_1_10005(var_5_2, var_1_10008("ui/CombatUI" .. var_5_1 .. "_atlas", "weapon_unfill_" .. var_5_0))

	setImageSprite = var_1_10005

	local var_5_3 = arg_5_0._filled

	LoadSprite = var_8

	var_1_10005(var_5_3, var_8("ui/CombatUI" .. var_5_1 .. "_atlas", "filled_combined_" .. var_5_0))

	return var_5_1, var_5_0
end

function var_0_1.SwitchIconEffect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_1.ICON_BY_INDEX[arg_6_1]
	local var_6_1

	if (arg_6_2 or var_0.Battle.BattleState.GetCombatSkinKey()) ~= "Standard" then
		var_6_1 = ""
	end

	setImageSprite = var_1_10005

	local var_6_2 = arg_6_0._filledEffect

	LoadSprite = var_1_10008

	var_1_10005(var_6_2, var_1_10008("ui/CombatUI" .. var_6_1 .. "_atlas", "filled_effect_" .. var_6_0), true)

	setImageSprite = var_1_10005

	local var_6_3 = arg_6_0._jam

	LoadSprite = var_8

	var_1_10005(var_6_3, var_8("ui/CombatUI" .. var_6_1 .. "_atlas", "skill_jam_" .. var_6_0), true)

	return
end

function var_0_1.ConfigSkin(arg_7_0, arg_7_1)
	arg_7_0._skin = arg_7_1
	arg_7_0._btn = arg_7_1:Find("ActCtl")
	arg_7_0._block = arg_7_1:Find("ActCtl/block").gameObject
	arg_7_0._progress = arg_7_1:Find("ActCtl/skill_progress")

	local var_7_0 = arg_7_0._progress
	local var_7_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_7_0._progressBar = var_7_1(var_7_0, var_5(var_1_10007))
	arg_7_0._icon = arg_7_1:Find("ActCtl/skill_icon")

	local var_7_2 = arg_7_0._icon

	arg_7_0._filled = var_2.Find(var_7_2, "filled")

	local var_7_3 = arg_7_0._icon

	arg_7_0._unfill = var_2.Find(var_7_3, "unfill")
	arg_7_0._count = arg_7_1:Find("ActCtl/Count")

	local var_7_4 = arg_7_0._count

	arg_7_0._text = var_2.Find(var_7_4, "CountText")
	arg_7_0._selected = arg_7_1:Find("ActCtl/selected")
	arg_7_0._unSelect = arg_7_1:Find("ActCtl/unselect")
	arg_7_0._filledEffect = arg_7_1:Find("ActCtl/filledEffect")
	arg_7_0._jam = arg_7_1:Find("ActCtl/jam")

	local var_7_5 = arg_7_0._text
	local var_7_6 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_7_0._countTxt = var_7_6(var_7_5, var_5(var_1_10007))

	local var_7_7 = arg_7_1.gameObject

	var_2.SetActive(var_7_7, true)

	local var_7_8 = arg_7_0._block

	var_2.SetActive(var_7_8, false)

	local var_7_9 = arg_7_0._progress.gameObject

	var_2.SetActive(var_7_9, true)

	local var_7_10 = arg_7_0._filledEffect.gameObject

	var_2.SetActive(var_7_10, false)

	local var_7_11 = var_2:GetComponent("DftAniEvent")

	var_3.SetEndEvent(var_7_11, function(arg_8_0)
		SetActive = var_2_10001

		var_2_10001(arg_7_0._filledEffect, false)

		return
	end)

	local var_7_12 = arg_7_1
	local var_7_13 = arg_7_1.GetComponent

	typeof = var_7
	Animator = var_1_10009
	arg_7_0._animtor = var_7_13(var_7_12, var_7(var_1_10009))
	arg_7_0._bgEff = arg_7_1:Find("ActCtl/bg_eff")
	arg_7_0._gizmos1 = arg_7_1:Find("ActCtl/gizmos_1")
	arg_7_0._gizmosXue = arg_7_1:Find("ActCtl/gizmos_xue")

	return
end

function var_0_1.GetSkin(arg_9_0)
	return arg_9_0._skin
end

function var_0_1.Enabled(arg_10_0, arg_10_1)
	GetComponent = var_1_10002

	local var_10_0 = var_1_10002(arg_10_0._btn, "EventTriggerListener")

	GetComponent = var_1_10003

	local var_10_1 = var_1_10003(arg_10_0._block, "EventTriggerListener")

	arg_10_0.eventTriggers[var_10_0] = true
	arg_10_0.eventTriggers[var_10_1] = true
	var_10_0.enabled = arg_10_1
	var_10_1.enabled = arg_10_1

	return
end

function var_0_1.Disable(arg_11_0)
	if arg_11_0._cancelFunc then
		arg_11_0._cancelFunc()
	end

	arg_11_0:OnUnSelect()

	GetComponent = var_1

	local var_11_0 = var_1(arg_11_0._btn, "EventTriggerListener")

	GetComponent = var_1_10002

	local var_11_1 = var_1_10002(arg_11_0._block, "EventTriggerListener")

	var_11_0.enabled = false
	var_11_1.enabled = false

	return
end

function var_0_1.OnSelected(arg_12_0)
	SetActive = var_1_10001

	var_1_10001(arg_12_0._unSelect, false)

	SetActive = var_1_10001

	var_1_10001(arg_12_0._selected, true)

	return
end

function var_0_1.OnUnSelect(arg_13_0)
	SetActive = var_1_10001

	var_1_10001(arg_13_0._selected, false)

	SetActive = var_1_10001

	var_1_10001(arg_13_0._unSelect, true)

	return
end

function var_0_1.OnFilled(arg_14_0)
	SetActive = var_1_10001

	var_1_10001(arg_14_0._filled, true)

	SetActive = var_1_10001

	var_1_10001(arg_14_0._unfill, false)

	return
end

function var_0_1.OnUnfill(arg_15_0)
	SetActive = var_1_10001

	var_1_10001(arg_15_0._filled, false)

	SetActive = var_1_10001

	var_1_10001(arg_15_0._unfill, true)

	return
end

function var_0_1.OnfilledEffect(arg_16_0)
	SetActive = var_1_10001

	var_1_10001(arg_16_0._filledEffect, true)

	return
end

function var_0_1.OnOverLoadChange(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._progressInfo

	if var_2.IsOverLoad(var_17_0) then
		local var_17_1 = arg_17_0._block

		var_2.SetActive(var_17_1, true)
		arg_17_0:OnUnfill()
	else
		local var_17_2 = arg_17_0._block

		var_2.SetActive(var_17_2, false)
		arg_17_0:OnFilled()

		if arg_17_1 and arg_17_1.Data and arg_17_1.Data.preCast then
			if var_2 == 0 then
				quickCheckAndPlayAnimator = var_1_10003

				var_1_10003(arg_17_0._skin, "weapon_button_progress_filled")
			elseif 0 < var_2 then
				quickCheckAndPlayAnimator = var_3

				var_3(arg_17_0._skin, "weapon_button_progress_charge")
			end
		end
	end

	if arg_17_1 and arg_17_1.Data and arg_17_1.Data.postCast then
		quickCheckAndPlayAnimator = var_2

		var_2(arg_17_0._skin, "weapon_button_progress_use")
	end

	local var_17_3 = arg_17_0._progressInfo

	if var_2.GetTotal(var_17_3) > 0 then
		arg_17_0:updateProgressBar()
	end

	return
end

function var_0_1.SetProgressActive(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._progress.gameObject

	var_2.SetActive(var_18_0, arg_18_1)

	return
end

function var_0_1.SetTextActive(arg_19_0, arg_19_1)
	SetActive = var_1_10002

	var_1_10002(arg_19_0._count, arg_19_1)

	return
end

function var_0_1.SetProgressInfo(arg_20_0, arg_20_1)
	arg_20_0._progressInfo = arg_20_1

	local var_20_0 = arg_20_0._progressInfo

	var_2.RegisterEventListener(var_20_0, arg_20_0, var_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE, arg_20_0.OnTotalChange)

	local var_20_1 = arg_20_0._progressInfo

	var_2.RegisterEventListener(var_20_1, arg_20_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS, arg_20_0.OnfilledEffect)

	local var_20_2 = arg_20_0._progressInfo

	var_2.RegisterEventListener(var_20_2, arg_20_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE, arg_20_0.OnOverLoadChange)

	local var_20_3 = arg_20_0._progressInfo

	var_2.RegisterEventListener(var_20_3, arg_20_0, var_0.Battle.BattleEvent.COUNT_CHANGE, arg_20_0.OnCountChange)
	arg_20_0:OnTotalChange()
	arg_20_0:OnOverLoadChange()

	return
end

function var_0_1.OnCountChange(arg_21_0)
	local var_21_0 = arg_21_0._progressInfo
	local var_21_1 = var_1.GetCount(var_21_0)
	local var_21_2 = arg_21_0._progressInfo
	local var_21_3 = var_2.GetTotal(var_21_2)
	local var_21_4 = arg_21_0._countTxt

	string = var_21_2
	var_21_4.text = var_21_2.format("%d/%d", var_21_1, var_21_3)

	local var_21_5 = arg_21_0._progressInfo

	if var_3.GetCurrentWeaponIconIndex(var_21_5) ~= arg_21_0._iconIndex then
		arg_21_0:SwitchIcon(var_3)
		arg_21_0:SwitchIconEffect(var_3)
	end

	if arg_21_0._gizmos1 then
		SetActive = var_4

		var_4(arg_21_0._gizmos1, var_21_1 > 0)

		SetActive = var_4

		var_4(arg_21_0._gizmosXue, var_21_1 == var_21_3)
	end

	return
end

function var_0_1.OnTotalChange(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._progressInfo

	if var_2.GetTotal(var_22_0) <= 0 then
		local var_22_1 = arg_22_0._block

		var_2.SetActive(var_22_1, true)

		arg_22_0._progressBar.fillAmount = 0

		if arg_22_0._bgEff then
			local var_22_2 = arg_22_0._skin
			local var_22_3 = var_2.Find(var_22_2, "ActCtl/bg_eff")
			local var_22_4 = var_2.GetComponent

			typeof = var_5
			CanvasGroup = var_1_10007
			var_22_4(var_22_3, var_5(var_1_10007)).alpha = 0
		end

		local var_22_5 = arg_22_0._text
		local var_22_6 = var_2.GetComponent

		typeof = var_5
		Text = var_1_10007
		var_22_6(var_22_5, var_5(var_1_10007)).text = "0/0"

		arg_22_0:SetControllerActive(false)
		arg_22_0:OnUnfill()
		arg_22_0:OnUnSelect()
	else
		arg_22_0:OnCountChange()
		arg_22_0:SetControllerActive(true)

		if arg_22_1 and arg_22_1.Data.index and var_2 == 1 then
			arg_22_0:OnUnSelect()
		end
	end

	return
end

function var_0_1.SetControllerActive(arg_23_0, arg_23_1)
	if arg_23_0._isActive == arg_23_1 then
		return
	end

	arg_23_0._isActive = arg_23_1
	GetComponent = var_2

	local var_23_0 = var_2(arg_23_0._btn, "EventTriggerListener")

	GetComponent = var_1_10003

	local var_23_1 = var_1_10003(arg_23_0._block, "EventTriggerListener")

	if arg_23_1 then
		local var_23_2

		if arg_23_0._downFunc ~= nil then
			var_23_0:AddPointDownFunc(function()
				var_23_2 = true

				arg_23_0._downFunc()

				local var_24_0 = arg_23_0

				var_0.OnSelected(var_24_0)

				return
			end)
		end

		if arg_23_0._upFunc ~= nil then
			var_23_0:AddPointUpFunc(function()
				if var_23_2 then
					var_23_2 = false

					arg_23_0._upFunc()

					local var_25_0 = arg_23_0

					var_0.OnUnSelect(var_25_0)
				end

				return
			end)
		end

		if arg_23_0._cancelFunc ~= nil then
			var_23_0:AddPointExitFunc(function()
				if var_23_2 then
					var_23_2 = false

					arg_23_0._cancelFunc()

					local var_26_0 = arg_23_0

					var_0.OnUnSelect(var_26_0)
				end

				return
			end)
		end

		var_23_1:RemovePointDownFunc()
	else
		var_23_1:AddPointDownFunc(arg_23_0._emptyFunc)
		var_23_0:RemovePointDownFunc()
		var_23_0:RemovePointUpFunc()
		var_23_0:RemovePointExitFunc()
	end

	return
end

function var_0_1.InitialAnima(arg_27_0, arg_27_1)
	SetActive = var_1_10002

	var_1_10002(arg_27_0._btn, false)

	LeanTween = var_1_10002

	local var_27_0 = var_1_10002.delayedCall
	local var_27_1 = arg_27_1

	System = var_5
	arg_27_0._leanID = var_27_0(var_27_1, var_5.Action(function()
		local var_28_0 = arg_27_0._skin

		var_0.GetComponent(var_28_0, "Animator").enabled = true
		arg_27_0._leanID = nil

		return
	end))

	return
end

function var_0_1.Update(arg_29_0)
	local var_29_0 = arg_29_0._progressInfo
	local var_29_1 = var_1.GetCurrent(var_29_0)
	local var_29_2 = arg_29_0._progressInfo
	local var_29_3 = var_2.GetMax(var_29_2)
	local var_29_4 = arg_29_0._progressInfo

	if var_3.GetTotal(var_29_4) > 0 and var_29_1 < var_29_3 then
		arg_29_0:updateProgressBar()
	end

	return
end

function var_0_1.SetToCombatUIPreview(arg_30_0, arg_30_1)
	CombatUIPreviewer = var_1_10002

	if arg_30_1 ~= var_1_10002.WeaponButtonPreviewMode.UNFILLED then
		SetActive = var_1_10004

		var_1_10004(arg_30_0._filled, true)

		SetActive = var_1_10004

		var_1_10004(arg_30_0._unfill, false)

		var_1_10004 = arg_30_0._progressBar
		var_1_10004.fillAmount = 1

		if arg_30_0._bgEff then
			local var_30_0 = arg_30_0._skin
			local var_30_1 = var_1_10004.Find(var_30_0, "ActCtl/bg_eff")

			var_1_10004 = var_1_10004.GetComponent
			typeof = var_7
			CanvasGroup = var_1_10009
			var_1_10004 = var_1_10004(var_30_1, var_7(var_1_10009))
			var_1_10004.alpha = 1
		end

		var_1_10004 = arg_30_0._countTxt
		var_1_10004.text = "1/1"

		if arg_30_0._gizmos1 then
			SetActive = var_1_10004

			var_1_10004(arg_30_0._gizmos1, true)

			SetActive = var_1_10004

			var_1_10004(arg_30_0._gizmosXue, true)
		end
	else
		SetActive = var_1_10004

		var_1_10004(arg_30_0._unfill, true)

		SetActive = var_1_10004

		var_1_10004(arg_30_0._filled, false)

		arg_30_0._progressBar.fillAmount = 0

		if arg_30_0._bgEff then
			local var_30_2 = arg_30_0._skin
			local var_30_3 = var_4.Find(var_30_2, "ActCtl/bg_eff")
			local var_30_4 = var_4.GetComponent

			typeof = var_7
			CanvasGroup = var_1_10009
			var_30_4(var_30_3, var_7(var_1_10009)).alpha = 0
		end

		arg_30_0._countTxt.text = "0/0"

		if arg_30_0._gizmos1 then
			SetActive = var_4

			var_4(arg_30_0._gizmos1, false)

			SetActive = var_4

			var_4(arg_30_0._gizmosXue, false)
		end
	end

	return
end

function var_0_1.updateProgressBar(arg_31_0)
	local var_31_0 = arg_31_0._progressInfo
	local var_31_1 = var_1.GetCurrent(var_31_0)
	local var_31_2 = arg_31_0._progressInfo
	local var_31_3 = var_31_1 / var_2.GetMax(var_31_2)

	arg_31_0._progressBar.fillAmount = var_31_3

	if arg_31_0._bgEff then
		if arg_31_0._progressInfo.GetCount then
			local var_31_4 = arg_31_0._progressInfo

			if var_2.GetCount(var_31_4) > 0 then
				local var_31_5 = arg_31_0._bgEff
				local var_31_6 = var_2.GetComponent

				typeof = var_1_10005
				CanvasGroup = var_1_10007
				var_31_6(var_31_5, var_1_10005(var_1_10007)).alpha = 1

				goto label_31_0
			end
		end

		local var_31_7 = arg_31_0._bgEff
		local var_31_8 = var_2.GetComponent

		typeof = var_1_10005
		CanvasGroup = var_1_10007
		var_31_8(var_31_7, var_1_10005(var_1_10007)).alpha = var_31_3
	end

	::label_31_0::

	return
end

function var_0_1.Dispose(arg_32_0)
	if arg_32_0.eventTriggers then
		pairs = var_1

		for iter_32_0, iter_32_1 in var_1(arg_32_0.eventTriggers) do
			ClearEventTrigger = var_1_10006

			var_1_10006(iter_32_0)
		end

		arg_32_0.eventTriggers = nil
	end

	arg_32_0._progress = nil
	arg_32_0._progressBar = nil

	local var_32_0 = arg_32_0._progressInfo

	var_1.UnregisterEventListener(var_32_0, arg_32_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE)

	local var_32_1 = arg_32_0._progressInfo

	var_1.UnregisterEventListener(var_32_1, arg_32_0, var_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE)

	local var_32_2 = arg_32_0._progressInfo

	var_1.UnregisterEventListener(var_32_2, arg_32_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)

	local var_32_3 = arg_32_0._progressInfo

	var_1.UnregisterEventListener(var_32_3, arg_32_0, var_0.Battle.BattleEvent.COUNT_CHANGE)
	var_0.EventListener.DetachEventListener(arg_32_0)

	return
end

return
