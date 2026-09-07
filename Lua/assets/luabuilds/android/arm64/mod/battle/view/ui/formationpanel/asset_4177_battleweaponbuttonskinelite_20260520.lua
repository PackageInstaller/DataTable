ys = ys or {}

local BattleWeaponButtonSkinElite_20260520 = class("BattleWeaponButtonSkinElite_20260520", ys.Battle.BattleWeaponButtonSkinElite_20250520)

ys.Battle.BattleWeaponButtonSkinElite_20260520 = BattleWeaponButtonSkinElite_20260520
BattleWeaponButtonSkinElite_20260520.__name = "BattleWeaponButtonSkinElite_20260520"

local var_0_1 = 1

function BattleWeaponButtonSkinElite_20260520:ConfigSkin(arg_1_1)
	BattleWeaponButtonSkinElite_20260520.super.ConfigSkin(self, arg_1_1)

	self._bgEffAni = self._bgEff:GetComponent(typeof(Animator))
	self._bgEffAniClipTotalFrames = math.max(1, math.floor(self._bgEffAni.runtimeAnimatorController.animationClips[0].length * self._bgEffAni.runtimeAnimatorController.animationClips[0].frameRate + 0.5))
	self._unfill = self._icon:Find("unfill/unfill")
	self._unfillShade = self._icon:Find("unfill/unfill_1")

	return
end

function BattleWeaponButtonSkinElite_20260520:OnFilled()
	BattleWeaponButtonSkinElite_20260520.super.OnFilled(self)
	SetActive(self._unfillShade, false)

	return
end

function BattleWeaponButtonSkinElite_20260520:OnUnfill()
	BattleWeaponButtonSkinElite_20260520.super.OnUnfill(self)
	SetActive(self._unfillShade, true)

	return
end

function BattleWeaponButtonSkinElite_20260520:SwitchIcon(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = BattleWeaponButtonSkinElite_20260520.super.SwitchIcon(self, arg_4_1, arg_4_2)

	setImageSprite(self._unfillShade, LoadSprite("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

	return
end

function BattleWeaponButtonSkinElite_20260520:OnTotalChange(arg_5_1)
	if self._progressInfo:GetTotal() <= 0 then
		self._block:SetActive(true)

		self._progressBar.fillAmount = 0
		self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = 0
		self._text:GetComponent(typeof(Text)).text = "0/0"

		self:SetControllerActive(false)
		SetActive(self._glowEff, false)
		self:OnUnfill()
		self:OnUnSelect()
		SetActive(self._gizmos1, false)
		SetActive(self._gizmosXue, false)
	else
		self:OnCountChange()
		self:SetControllerActive(true)

		if arg_5_1 then
			if arg_5_1.Data.index and arg_5_1.Data.index == 1 then
				self:OnUnSelect()
			end
		end
	end

	return
end

function BattleWeaponButtonSkinElite_20260520:OnCountChange()
	BattleWeaponButtonSkinElite_20260520.super.OnCountChange(self)
	SetActive(self._gizmosXue, self._progressInfo:GetCount() > 0)
	SetActive(self._glowEff, self._progressInfo:GetCount() > 0)

	return
end

function BattleWeaponButtonSkinElite_20260520:StopCombatUIPreviewLoop()
	if self._skin then
		LeanTween.cancel(go(self._skin))
	end

	return
end

function BattleWeaponButtonSkinElite_20260520:ApplyCombatUIPreviewState(arg_8_1, arg_8_2, arg_8_3)
	SetActive(self._filled, not arg_8_3 and arg_8_1 > 0)
	SetActive(self._unfill, arg_8_3 or arg_8_1 <= 0)
	SetActive(self._unfillShade, arg_8_3 or arg_8_1 <= 0)

	self._progressBar.fillAmount = arg_8_2
	self._bgEff:GetComponent(typeof(CanvasGroup)).alpha = (arg_8_3 or arg_8_1 > 0) and 1 or 0
	self._countTxt.text = arg_8_1 .. "/" .. 2

	if self._gizmos1 then
		SetActive(self._gizmos1, arg_8_1 > 0)
		SetActive(self._gizmosXue, arg_8_1 > 0)
	end

	SetActive(self._glowEff, arg_8_1 > 0)

	self._bgEffAni.enabled = true

	self:updateProgressBG(arg_8_2, 5)

	return
end

function BattleWeaponButtonSkinElite_20260520:StartCombatUIPreviewLoop()
	local var_9_0 = go(self._skin)

	local function var_9_1()
		self:ApplyCombatUIPreviewState(0, 0, true)
		LeanTween.value(var_9_0, 0, 1, 5):setOnUpdate(System.Action_float(function(arg_11_0)
			self:ApplyCombatUIPreviewState(0, arg_11_0, true)

			return
		end)):setOnComplete(System.Action(function()
			self:ApplyCombatUIPreviewState(2, 1, false)
			quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_filled")
			LeanTween.delayedCall(var_9_0, 3, System.Action(function()
				self:ApplyCombatUIPreviewState(1, 1, false)
				quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_use")
				LeanTween.delayedCall(var_9_0, 3, System.Action(function()
					self:ApplyCombatUIPreviewState(0, 0, false)
					quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_use")
					LeanTween.delayedCall(var_9_0, 3, System.Action(function()
						var_9_1()

						return
					end))

					return
				end))

				return
			end))

			return
		end))

		return
	end

	var_9_1()

	return
end

function BattleWeaponButtonSkinElite_20260520:SetToCombatUIPreview(arg_16_1)
	self:StopCombatUIPreviewLoop()

	if arg_16_1 == CombatUIPreviewer.WeaponButtonPreviewMode.LOOP then
		self:StartCombatUIPreviewLoop()

		return
	end

	if arg_16_1 ~= CombatUIPreviewer.WeaponButtonPreviewMode.UNFILLED then
		self:ApplyCombatUIPreviewState(2, 1, false)
		quickCheckAndPlayAnimator(self._skin, "weapon_button_progress_filled")
	else
		self:ApplyCombatUIPreviewState(0, 0, false)
	end

	return
end

function BattleWeaponButtonSkinElite_20260520:updateProgressBar()
	local var_17_0 = self._progressInfo:GetCurrent() / self._progressInfo:GetMax()

	self._progressBar.fillAmount = var_17_0

	if self._progressInfo.GetCount and self._progressInfo:GetCount() > 0 then
		self:updateProgressBG(1, self._progressInfo:GetMax())
	else
		self._bgEffAni.enabled = true

		self:updateProgressBG(var_17_0, self._progressInfo:GetMax())
	end

	return
end

function BattleWeaponButtonSkinElite_20260520:updateProgressBG(arg_18_1, arg_18_2)
	arg_18_1 = Mathf.Clamp01(arg_18_1)

	local var_18_0

	if arg_18_2 and arg_18_2 > var_0_1 then
		local var_18_1 = math.floor(arg_18_1 * (self._bgEffAniClipTotalFrames - 1))

		var_18_0 = (var_18_1 + (math.min(self._bgEffAniClipTotalFrames - 1, var_18_1 + 1) - var_18_1) * (arg_18_1 * (self._bgEffAniClipTotalFrames - 1) - var_18_1)) / (self._bgEffAniClipTotalFrames - 1)
	else
		var_18_0 = math.floor(arg_18_1 * (self._bgEffAniClipTotalFrames - 1) + 0.5) / (self._bgEffAniClipTotalFrames - 1)
	end

	self._bgEffAni.speed = 1

	self._bgEffAni:Play("skinui_button_bg", 0, var_18_0)
	self._bgEffAni:Update(0)

	self._bgEffAni.speed = 0

	return
end

function BattleWeaponButtonSkinElite_20260520:Dispose()
	self:StopCombatUIPreviewLoop()
	BattleWeaponButtonSkinElite_20260520.super.Dispose(self)

	return
end

return
