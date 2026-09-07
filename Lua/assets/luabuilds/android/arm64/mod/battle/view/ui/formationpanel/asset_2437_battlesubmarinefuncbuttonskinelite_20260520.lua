ys = ys or {}

local BattleSubmarineFuncButtonSkinElite_20260520 = class("BattleSubmarineFuncButtonSkinElite_20260520", ys.Battle.BattleSubmarineFuncButton)

ys.Battle.BattleSubmarineFuncButtonSkinElite_20260520 = BattleSubmarineFuncButtonSkinElite_20260520
BattleSubmarineFuncButtonSkinElite_20260520.__name = "BattleSubmarineFuncButtonSkinElite_20260520"

local var_0_1 = 1

function BattleSubmarineFuncButtonSkinElite_20260520:ConfigSkin(arg_1_1)
	BattleSubmarineFuncButtonSkinElite_20260520.super.ConfigSkin(self, arg_1_1)

	self._bgEffAni = self._bgEff:GetComponent(typeof(Animator))
	self._bgEffAniClipTotalFrames = math.max(1, math.floor(self._bgEffAni.runtimeAnimatorController.animationClips[0].length * self._bgEffAni.runtimeAnimatorController.animationClips[0].frameRate + 0.5))
	self._unfill = self._icon:Find("unfill/unfill")
	self._unfillShade = self._icon:Find("unfill/unfill_1")

	return
end

function BattleSubmarineFuncButtonSkinElite_20260520:OnFilled()
	BattleSubmarineFuncButtonSkinElite_20260520.super.OnFilled(self)
	SetActive(self._unfillShade, false)

	return
end

function BattleSubmarineFuncButtonSkinElite_20260520:OnUnfill()
	BattleSubmarineFuncButtonSkinElite_20260520.super.OnUnfill(self)
	SetActive(self._unfillShade, true)

	return
end

function BattleSubmarineFuncButtonSkinElite_20260520:SwitchIcon(arg_4_1, arg_4_2)
	local var_4_0, var_4_1 = BattleSubmarineFuncButtonSkinElite_20260520.super.SwitchIcon(self, arg_4_1, arg_4_2)

	setImageSprite(self._unfillShade, LoadSprite("ui/CombatUI" .. var_4_0 .. "_atlas", "weapon_unfill_" .. var_4_1))

	return
end

function BattleSubmarineFuncButtonSkinElite_20260520:updateProgressBar()
	local var_5_0 = self._progressInfo:GetCurrent() / self._progressInfo:GetMax()

	self._progressBar.fillAmount = var_5_0

	if self._progressInfo.GetCount and self._progressInfo:GetCount() > 0 then
		self:updateProgressBG(1, self._progressInfo:GetMax())
	else
		self._bgEffAni.enabled = true

		self:updateProgressBG(var_5_0, self._progressInfo:GetMax())
	end

	return
end

function BattleSubmarineFuncButtonSkinElite_20260520:updateProgressBG(arg_6_1, arg_6_2)
	arg_6_1 = Mathf.Clamp01(arg_6_1)

	local var_6_0

	if arg_6_2 and arg_6_2 > var_0_1 then
		local var_6_1 = math.floor(arg_6_1 * (self._bgEffAniClipTotalFrames - 1))

		var_6_0 = (var_6_1 + (math.min(self._bgEffAniClipTotalFrames - 1, var_6_1 + 1) - var_6_1) * (arg_6_1 * (self._bgEffAniClipTotalFrames - 1) - var_6_1)) / (self._bgEffAniClipTotalFrames - 1)
	else
		var_6_0 = math.floor(arg_6_1 * (self._bgEffAniClipTotalFrames - 1) + 0.5) / (self._bgEffAniClipTotalFrames - 1)
	end

	self._bgEffAni.speed = 1

	self._bgEffAni:Play("skinui_button_bg", 0, var_6_0)
	self._bgEffAni:Update(0)

	self._bgEffAni.speed = 0

	return
end

return
