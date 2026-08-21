local var_0_0 = class("SummerRaceBattleSkillItemView", ReduxView)
local var_0_1 = Color.New(1, 1, 1, 1)
local var_0_2 = "enable"
local var_0_3 = "using"
local var_0_4 = "off"
local var_0_5 = "weapon"
local var_0_6 = "parts"
local var_0_7 = "true"
local var_0_8 = "false"
local var_0_9 = "on"
local var_0_10 = "off"

local function var_0_11(arg_1_0)
	return math.floor(arg_1_0 + 0.5)
end

local function var_0_12(arg_2_0)
	if arg_2_0 <= 0 then
		return 0
	end

	if arg_2_0 >= 1 then
		return 1
	end

	return arg_2_0
end

function var_0_0.OnCtor(arg_3_0, arg_3_1)
	arg_3_0.gameObject_ = arg_3_1
	arg_3_0.transform_ = arg_3_1.transform

	arg_3_0:InitUI()
	SetActive(arg_3_0.gameObject_, false)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.typeController_ = arg_4_0.controllerEx_:GetController("type")
	arg_4_0.maskController_ = arg_4_0.controllerEx_:GetController("mask")
	arg_4_0.selectController_ = arg_4_0.controllerEx_:GetController("select")
	arg_4_0.cdController_ = arg_4_0.controllerEx_:GetController("CD")
	arg_4_0.usingController_ = arg_4_0.controllerEx_:GetController("using")
	arg_4_0.controllerStateCache_ = {}

	if arg_4_0.labelText_ ~= nil then
		arg_4_0.labelText_.text = ""
	end

	arg_4_0:AddUIListener()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		arg_5_0.clickHandler_(arg_5_0.uiIndex_)
	end)
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	arg_7_0.clickHandler_ = arg_7_1
end

function var_0_0.SetData(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.uiIndex_ = arg_8_1
	arg_8_0.runtimeSkill_ = arg_8_2

	SetActive(arg_8_0.gameObject_, true)

	local var_8_0 = arg_8_0:ResolveUiState(arg_8_2, arg_8_3)

	arg_8_0.btn_.interactable = var_8_0.canTrigger

	arg_8_0:SetControllerState("type", arg_8_0.typeController_, var_8_0.typeState, true)

	if not var_8_0.freezeControllerState or arg_8_0.controllerStateCache_.mask == nil then
		arg_8_0:SetControllerState("mask", arg_8_0.maskController_, var_8_0.maskState)
	end

	arg_8_0:SetControllerState("select", arg_8_0.selectController_, var_8_0.selectState, true)
	arg_8_0:SetControllerState("using", arg_8_0.usingController_, var_8_0.usingState)
	arg_8_0:RefreshCooldownUi(arg_8_2, var_8_0.freezeControllerState)

	if arg_8_0.labelText_ ~= nil then
		arg_8_0.labelText_.text = ""
	end

	arg_8_0.costText_.text = arg_8_0:ResolveCostText(arg_8_2)

	if arg_8_0.icon_ ~= nil then
		local var_8_1 = arg_8_2.iconPath

		arg_8_0.icon_.spriteSync = var_8_1
	end

	if arg_8_0.costText_ ~= nil then
		arg_8_0.costText_.color = var_0_1
	end
end

function var_0_0.SetControllerState(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4 ~= true and arg_9_0.controllerStateCache_[arg_9_1] == arg_9_3 then
		return
	end

	arg_9_0.controllerStateCache_[arg_9_1] = arg_9_3

	arg_9_2:SetSelectedState(arg_9_3)
end

function var_0_0.ResolveTypeState(arg_10_0, arg_10_1)
	if arg_10_1.slotType == "equip" then
		return var_0_3
	end

	return var_0_2
end

function var_0_0.ResolveUsingState(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1.slotType == "weapon" then
		return arg_11_2 and var_0_5 or var_0_4
	end

	if arg_11_1.slotType == "equip" then
		return arg_11_2 and var_0_6 or var_0_4
	end

	return var_0_4
end

function var_0_0.ResolveActiveState(arg_12_0, arg_12_1)
	return arg_12_1.activeRemaining > 0 and arg_12_1.activeTotal > 0
end

function var_0_0.ResolveCooldownState(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1.slotType == "weapon" then
		return arg_13_1.overloadRemaining > 0 and arg_13_1.overloadTotal > 0
	end

	if arg_13_2 then
		return false
	end

	return arg_13_1.cooldownRemaining > 0 and arg_13_1.cooldownTotal > 0
end

function var_0_0.ResolveCooldownDisplay(arg_14_0, arg_14_1)
	if arg_14_0:ResolveActiveState(arg_14_1) then
		return 0, 0
	end

	if arg_14_1.slotType == "weapon" then
		return arg_14_1.overloadRemaining, arg_14_1.overloadTotal
	end

	return arg_14_1.cooldownRemaining, arg_14_1.cooldownTotal
end

function var_0_0.RefreshCooldownUi(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = arg_15_0:ResolveCooldownDisplay(arg_15_1)
	local var_15_2 = var_15_0 > 0 and var_15_1 > 0

	if not arg_15_2 or arg_15_0.controllerStateCache_.CD == nil then
		arg_15_0:SetControllerState("CD", arg_15_0.cdController_, var_15_2 and var_0_9 or var_0_10)
	end

	arg_15_0.cdFillImage_.fillAmount = var_15_2 and var_0_12(var_15_0 / var_15_1) or 0
	arg_15_0.cdText_.text = var_15_2 and tostring(math.ceil(var_15_0)) or ""
end

function var_0_0.ResolveUiState(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = math.max(0, arg_16_2) >= math.max(0, arg_16_1.slotType == "weapon" and arg_16_1.overloadEnergyCost or arg_16_1.energyCost)
	local var_16_1 = arg_16_0:ResolveActiveState(arg_16_1)
	local var_16_2 = arg_16_0:ResolveCooldownState(arg_16_1, var_16_1)
	local var_16_3
	local var_16_4
	local var_16_5
	local var_16_6 = arg_16_1.inputBlocked == true

	if arg_16_1.slotType == "weapon" then
		local var_16_7 = arg_16_1.canUse or arg_16_1.canOverload or arg_16_1.cooldownRemaining > 0 or arg_16_1.activeRemaining > 0 or arg_16_1.overloadRemaining > 0

		var_16_3 = var_16_7 and var_16_0 and not var_16_1 and not var_16_2 and not var_16_6
		var_16_5 = var_16_7 and not var_16_0 and not var_16_1 and not var_16_2
	else
		var_16_3 = arg_16_1.canUse and var_16_0 and not var_16_1 and not var_16_2 and not var_16_6
		var_16_5 = arg_16_1.canUse and not var_16_0 and not var_16_1 and not var_16_2
	end

	return {
		canTrigger = var_16_3,
		isActive = var_16_1,
		hasCooldown = var_16_2,
		energyInsufficient = var_16_5,
		freezeControllerState = var_16_6,
		typeState = arg_16_0:ResolveTypeState(arg_16_1),
		usingState = arg_16_0:ResolveUsingState(arg_16_1, var_16_1),
		maskState = var_16_5 and var_0_7 or var_0_8,
		selectState = var_0_8
	}
end

function var_0_0.ResolveCostText(arg_17_0, arg_17_1)
	if arg_17_1.slotType == "weapon" then
		return tostring(var_0_11(math.max(0, arg_17_1.overloadEnergyCost)))
	end

	return tostring(var_0_11(math.max(0, arg_17_1.energyCost)))
end

function var_0_0.Dispose(arg_18_0)
	arg_18_0.playerEnergy_ = nil
	arg_18_0.uiIndex_ = nil
	arg_18_0.runtimeSkill_ = nil
	arg_18_0.clickHandler_ = nil

	arg_18_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
