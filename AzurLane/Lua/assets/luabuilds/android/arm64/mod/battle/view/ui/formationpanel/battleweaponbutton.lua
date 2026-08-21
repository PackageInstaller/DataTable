ys = ys or {}

local var_0_0 = class("BattleWeaponButton")

ys.Battle.BattleWeaponButton = var_0_0
var_0_0.__name = "BattleWeaponButton"
var_0_0.ICON_BY_INDEX = {
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

function var_0_0.Ctor(arg_1_0)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0.eventTriggers = {}

	return
end

function var_0_0.ConfigCallback(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0._downFunc = arg_2_1
	arg_2_0._upFunc = arg_2_2
	arg_2_0._cancelFunc = arg_2_3
	arg_2_0._emptyFunc = arg_2_4

	return
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	SetActive(arg_3_0._skin, arg_3_1)

	return
end

function var_0_0.SetJam(arg_4_0, arg_4_1)
	SetActive(arg_4_0._jam, arg_4_1)
	SetActive(arg_4_0._icon, not arg_4_1)
	SetActive(arg_4_0._progress, not arg_4_1)

	return
end

function var_0_0.SwitchIcon(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._iconIndex = arg_5_1

	local var_5_0 = arg_5_2 or var_0.Battle.BattleState.GetCombatSkinKey()

	if var_5_0 ~= "Standard" then
		var_5_0 = ""
	end

	setImageSprite(arg_5_0._unfill, LoadSprite("ui/CombatUI" .. var_5_0 .. "_atlas", "weapon_unfill_" .. var_0_0.ICON_BY_INDEX[arg_5_1]))
	setImageSprite(arg_5_0._filled, LoadSprite("ui/CombatUI" .. var_5_0 .. "_atlas", "filled_combined_" .. var_0_0.ICON_BY_INDEX[arg_5_1]))

	return var_5_0, var_0_0.ICON_BY_INDEX[arg_5_1]
end

function var_0_0.SwitchIconEffect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2 or var_0.Battle.BattleState.GetCombatSkinKey()

	if var_6_0 ~= "Standard" then
		var_6_0 = ""
	end

	setImageSprite(arg_6_0._filledEffect, LoadSprite("ui/CombatUI" .. var_6_0 .. "_atlas", "filled_effect_" .. var_0_0.ICON_BY_INDEX[arg_6_1]), true)
	setImageSprite(arg_6_0._jam, LoadSprite("ui/CombatUI" .. var_6_0 .. "_atlas", "skill_jam_" .. var_0_0.ICON_BY_INDEX[arg_6_1]), true)

	return
end

function var_0_0.ConfigSkin(arg_7_0, arg_7_1)
	arg_7_0._skin = arg_7_1
	arg_7_0._btn = arg_7_1:Find("ActCtl")
	arg_7_0._block = arg_7_1:Find("ActCtl/block").gameObject
	arg_7_0._progress = arg_7_1:Find("ActCtl/skill_progress")
	arg_7_0._progressBar = arg_7_0._progress:GetComponent(typeof(Image))
	arg_7_0._icon = arg_7_1:Find("ActCtl/skill_icon")
	arg_7_0._filled = arg_7_0._icon:Find("filled")
	arg_7_0._unfill = arg_7_0._icon:Find("unfill")
	arg_7_0._count = arg_7_1:Find("ActCtl/Count")
	arg_7_0._text = arg_7_0._count:Find("CountText")
	arg_7_0._selected = arg_7_1:Find("ActCtl/selected")
	arg_7_0._unSelect = arg_7_1:Find("ActCtl/unselect")
	arg_7_0._filledEffect = arg_7_1:Find("ActCtl/filledEffect")
	arg_7_0._jam = arg_7_1:Find("ActCtl/jam")
	arg_7_0._countTxt = arg_7_0._text:GetComponent(typeof(Text))

	arg_7_1.gameObject:SetActive(true)
	arg_7_0._block:SetActive(false)
	arg_7_0._progress.gameObject:SetActive(true)
	arg_7_0._filledEffect.gameObject:SetActive(false)
	arg_7_0._filledEffect.gameObject:GetComponent("DftAniEvent"):SetEndEvent(function(arg_8_0)
		SetActive(arg_7_0._filledEffect, false)

		return
	end)

	arg_7_0._animtor = arg_7_1:GetComponent(typeof(Animator))
	arg_7_0._bgEff = arg_7_1:Find("ActCtl/bg_eff")
	arg_7_0._gizmos1 = arg_7_1:Find("ActCtl/gizmos_1")
	arg_7_0._gizmosXue = arg_7_1:Find("ActCtl/gizmos_xue")

	return
end

function var_0_0.GetSkin(arg_9_0)
	return arg_9_0._skin
end

function var_0_0.Enabled(arg_10_0, arg_10_1)
	local var_10_0 = GetComponent(arg_10_0._btn, "EventTriggerListener")
	local var_10_1 = GetComponent(arg_10_0._block, "EventTriggerListener")

	arg_10_0.eventTriggers[var_10_0] = true
	arg_10_0.eventTriggers[var_10_1] = true
	var_10_0.enabled = arg_10_1
	var_10_1.enabled = arg_10_1

	return
end

function var_0_0.Disable(arg_11_0)
	if arg_11_0._cancelFunc then
		arg_11_0._cancelFunc()
	end

	arg_11_0:OnUnSelect()

	GetComponent(arg_11_0._btn, "EventTriggerListener").enabled = false
	GetComponent(arg_11_0._block, "EventTriggerListener").enabled = false

	return
end

function var_0_0.OnSelected(arg_12_0)
	SetActive(arg_12_0._unSelect, false)
	SetActive(arg_12_0._selected, true)

	return
end

function var_0_0.OnUnSelect(arg_13_0)
	SetActive(arg_13_0._selected, false)
	SetActive(arg_13_0._unSelect, true)

	return
end

function var_0_0.OnFilled(arg_14_0)
	SetActive(arg_14_0._filled, true)
	SetActive(arg_14_0._unfill, false)

	return
end

function var_0_0.OnUnfill(arg_15_0)
	SetActive(arg_15_0._filled, false)
	SetActive(arg_15_0._unfill, true)

	return
end

function var_0_0.OnfilledEffect(arg_16_0)
	SetActive(arg_16_0._filledEffect, true)

	return
end

function var_0_0.OnOverLoadChange(arg_17_0, arg_17_1)
	if arg_17_0._progressInfo:IsOverLoad() then
		arg_17_0._block:SetActive(true)
		arg_17_0:OnUnfill()
	else
		arg_17_0._block:SetActive(false)
		arg_17_0:OnFilled()

		if arg_17_1 and arg_17_1.Data then
			if arg_17_1.Data.preCast then
				if arg_17_1.Data.preCast == 0 then
					quickCheckAndPlayAnimator(arg_17_0._skin, "weapon_button_progress_filled")
				elseif arg_17_1.Data.preCast > 0 then
					quickCheckAndPlayAnimator(arg_17_0._skin, "weapon_button_progress_charge")
				end
			end
		end
	end

	if arg_17_1 and arg_17_1.Data and arg_17_1.Data.postCast then
		quickCheckAndPlayAnimator(arg_17_0._skin, "weapon_button_progress_use")
	end

	if arg_17_0._progressInfo:GetTotal() > 0 then
		arg_17_0:updateProgressBar()
	end

	return
end

function var_0_0.SetProgressActive(arg_18_0, arg_18_1)
	arg_18_0._progress.gameObject:SetActive(arg_18_1)

	return
end

function var_0_0.SetTextActive(arg_19_0, arg_19_1)
	SetActive(arg_19_0._count, arg_19_1)

	return
end

function var_0_0.SetProgressInfo(arg_20_0, arg_20_1)
	arg_20_0._progressInfo = arg_20_1

	arg_20_0._progressInfo:RegisterEventListener(arg_20_0, var_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE, arg_20_0.OnTotalChange)
	arg_20_0._progressInfo:RegisterEventListener(arg_20_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS, arg_20_0.OnfilledEffect)
	arg_20_0._progressInfo:RegisterEventListener(arg_20_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE, arg_20_0.OnOverLoadChange)
	arg_20_0._progressInfo:RegisterEventListener(arg_20_0, var_0.Battle.BattleEvent.COUNT_CHANGE, arg_20_0.OnCountChange)
	arg_20_0:OnTotalChange()
	arg_20_0:OnOverLoadChange()

	return
end

function var_0_0.OnCountChange(arg_21_0)
	local var_21_0 = arg_21_0._progressInfo:GetCount()
	local var_21_1 = arg_21_0._progressInfo:GetTotal()

	arg_21_0._countTxt.text = string.format("%d/%d", var_21_0, var_21_1)

	local var_21_2 = arg_21_0._progressInfo:GetCurrentWeaponIconIndex()

	if var_21_2 ~= arg_21_0._iconIndex then
		arg_21_0:SwitchIcon(var_21_2)
		arg_21_0:SwitchIconEffect(var_21_2)
	end

	if arg_21_0._gizmos1 then
		SetActive(arg_21_0._gizmos1, var_21_0 > 0)
		SetActive(arg_21_0._gizmosXue, var_21_0 == var_21_1)
	end

	return
end

function var_0_0.OnTotalChange(arg_22_0, arg_22_1)
	if arg_22_0._progressInfo:GetTotal() <= 0 then
		arg_22_0._block:SetActive(true)

		arg_22_0._progressBar.fillAmount = 0

		if arg_22_0._bgEff then
			arg_22_0._skin:Find("ActCtl/bg_eff"):GetComponent(typeof(CanvasGroup)).alpha = 0
		end

		arg_22_0._text:GetComponent(typeof(Text)).text = "0/0"

		arg_22_0:SetControllerActive(false)
		arg_22_0:OnUnfill()
		arg_22_0:OnUnSelect()
	else
		arg_22_0:OnCountChange()
		arg_22_0:SetControllerActive(true)

		if arg_22_1 then
			if arg_22_1.Data.index and arg_22_1.Data.index == 1 then
				arg_22_0:OnUnSelect()
			end
		end
	end

	return
end

function var_0_0.SetControllerActive(arg_23_0, arg_23_1)
	if arg_23_0._isActive == arg_23_1 then
		return
	end

	arg_23_0._isActive = arg_23_1

	local var_23_0 = GetComponent(arg_23_0._btn, "EventTriggerListener")
	local var_23_1 = GetComponent(arg_23_0._block, "EventTriggerListener")

	if arg_23_1 then
		local var_23_2

		if arg_23_0._downFunc ~= nil then
			var_23_0:AddPointDownFunc(function()
				var_23_2 = true

				arg_23_0._downFunc()
				arg_23_0:OnSelected()

				return
			end)
		end

		if arg_23_0._upFunc ~= nil then
			var_23_0:AddPointUpFunc(function()
				if var_23_2 then
					var_23_2 = false

					arg_23_0._upFunc()
					arg_23_0:OnUnSelect()
				end

				return
			end)
		end

		if arg_23_0._cancelFunc ~= nil then
			var_23_0:AddPointExitFunc(function()
				if var_23_2 then
					var_23_2 = false

					arg_23_0._cancelFunc()
					arg_23_0:OnUnSelect()
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

function var_0_0.InitialAnima(arg_27_0, arg_27_1)
	SetActive(arg_27_0._btn, false)

	arg_27_0._leanID = LeanTween.delayedCall(arg_27_1, System.Action(function()
		arg_27_0._skin:GetComponent("Animator").enabled = true
		arg_27_0._leanID = nil

		return
	end))

	return
end

function var_0_0.Update(arg_29_0)
	if arg_29_0._progressInfo:GetTotal() > 0 and arg_29_0._progressInfo:GetCurrent() < arg_29_0._progressInfo:GetMax() then
		arg_29_0:updateProgressBar()
	end

	return
end

function var_0_0.SetToCombatUIPreview(arg_30_0, arg_30_1)
	if arg_30_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		SetActive(arg_30_0._filled, true)
		SetActive(arg_30_0._unfill, false)

		arg_30_0._progressBar.fillAmount = 1

		if arg_30_0._bgEff then
			arg_30_0._skin:Find("ActCtl/bg_eff"):GetComponent(typeof(CanvasGroup)).alpha = 1
		end

		arg_30_0._countTxt.text = "1/1"

		if arg_30_0._gizmos1 then
			SetActive(arg_30_0._gizmos1, true)
			SetActive(arg_30_0._gizmosXue, true)
		end
	else
		SetActive(arg_30_0._unfill, true)
		SetActive(arg_30_0._filled, false)

		arg_30_0._progressBar.fillAmount = 0

		if arg_30_0._bgEff then
			arg_30_0._skin:Find("ActCtl/bg_eff"):GetComponent(typeof(CanvasGroup)).alpha = 0
		end

		arg_30_0._countTxt.text = "0/0"

		if arg_30_0._gizmos1 then
			SetActive(arg_30_0._gizmos1, false)
			SetActive(arg_30_0._gizmosXue, false)
		end
	end

	return
end

function var_0_0.updateProgressBar(arg_31_0)
	local var_31_0 = arg_31_0._progressInfo:GetCurrent() / arg_31_0._progressInfo:GetMax()

	arg_31_0._progressBar.fillAmount = var_31_0

	if arg_31_0._bgEff then
		arg_31_0._bgEff:GetComponent(typeof(CanvasGroup)).alpha = arg_31_0._progressInfo.GetCount and arg_31_0._progressInfo:GetCount() > 0 and 1 or var_31_0
	end

	return
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.eventTriggers then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.eventTriggers) do
			ClearEventTrigger(iter_32_0)
		end

		arg_32_0.eventTriggers = nil
	end

	arg_32_0._progress = nil
	arg_32_0._progressBar = nil

	arg_32_0._progressInfo:UnregisterEventListener(arg_32_0, var_0.Battle.BattleEvent.OVER_LOAD_CHANGE)
	arg_32_0._progressInfo:UnregisterEventListener(arg_32_0, var_0.Battle.BattleEvent.WEAPON_TOTAL_CHANGE)
	arg_32_0._progressInfo:UnregisterEventListener(arg_32_0, var_0.Battle.BattleEvent.WEAPON_COUNT_PLUS)
	arg_32_0._progressInfo:UnregisterEventListener(arg_32_0, var_0.Battle.BattleEvent.COUNT_CHANGE)
	var_0.EventListener.DetachEventListener(arg_32_0)

	return
end

return
