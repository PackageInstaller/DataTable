local SummerRaceBattleSkillItemView = class("SummerRaceBattleSkillItemView", ReduxView)
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

function SummerRaceBattleSkillItemView:OnCtor(arg_3_1)
	self.gameObject_ = arg_3_1
	self.transform_ = arg_3_1.transform

	self:InitUI()
	SetActive(self.gameObject_, false)
end

function SummerRaceBattleSkillItemView:InitUI()
	self:BindCfgUI()

	self.typeController_ = self.controllerEx_:GetController("type")
	self.maskController_ = self.controllerEx_:GetController("mask")
	self.selectController_ = self.controllerEx_:GetController("select")
	self.cdController_ = self.controllerEx_:GetController("CD")
	self.usingController_ = self.controllerEx_:GetController("using")
	self.controllerStateCache_ = {}

	if self.labelText_ ~= nil then
		self.labelText_.text = ""
	end

	self:AddUIListener()
end

function SummerRaceBattleSkillItemView:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		self.clickHandler_(self.uiIndex_)
	end)
end

function SummerRaceBattleSkillItemView:SetClickHandler(arg_7_1)
	self.clickHandler_ = arg_7_1
end

function SummerRaceBattleSkillItemView:SetData(arg_8_1, arg_8_2, arg_8_3)
	self.uiIndex_ = arg_8_1
	self.runtimeSkill_ = arg_8_2

	SetActive(self.gameObject_, true)

	local var_8_0 = self:ResolveUiState(arg_8_2, arg_8_3)

	self.btn_.interactable = var_8_0.canTrigger

	self:SetControllerState("type", self.typeController_, var_8_0.typeState, true)

	if not var_8_0.freezeControllerState or self.controllerStateCache_.mask == nil then
		self:SetControllerState("mask", self.maskController_, var_8_0.maskState)
	end

	self:SetControllerState("select", self.selectController_, var_8_0.selectState, true)
	self:SetControllerState("using", self.usingController_, var_8_0.usingState)
	self:RefreshCooldownUi(arg_8_2, var_8_0.freezeControllerState)

	if self.labelText_ ~= nil then
		self.labelText_.text = ""
	end

	self.costText_.text = self:ResolveCostText(arg_8_2)

	if self.icon_ ~= nil then
		self.icon_.spriteSync = arg_8_2.iconPath
	end

	if self.costText_ ~= nil then
		self.costText_.color = var_0_1
	end
end

function SummerRaceBattleSkillItemView:SetControllerState(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	if arg_9_4 ~= true and self.controllerStateCache_[arg_9_1] == arg_9_3 then
		return
	end

	self.controllerStateCache_[arg_9_1] = arg_9_3

	arg_9_2:SetSelectedState(arg_9_3)
end

function SummerRaceBattleSkillItemView:ResolveTypeState(arg_10_1)
	if arg_10_1.slotType == "equip" then
		return var_0_3
	end

	return var_0_2
end

function SummerRaceBattleSkillItemView:ResolveUsingState(arg_11_1, arg_11_2)
	if arg_11_1.slotType == "weapon" then
		return (arg_11_2 or nil) and (var_0_5 or var_0_4)
	end

	if arg_11_1.slotType == "equip" then
		return (arg_11_2 or nil) and (var_0_6 or var_0_4)
	end

	return var_0_4
end

function SummerRaceBattleSkillItemView:ResolveActiveState(arg_12_1)
	return arg_12_1.activeRemaining > 0 and arg_12_1.activeTotal > 0
end

function SummerRaceBattleSkillItemView:ResolveCooldownState(arg_13_1, arg_13_2)
	if arg_13_1.slotType == "weapon" then
		return arg_13_1.overloadRemaining > 0 and arg_13_1.overloadTotal > 0
	end

	if arg_13_2 then
		return false
	end

	return arg_13_1.cooldownRemaining > 0 and arg_13_1.cooldownTotal > 0
end

function SummerRaceBattleSkillItemView:ResolveCooldownDisplay(arg_14_1)
	if self:ResolveActiveState(arg_14_1) then
		return 0, 0
	end

	if arg_14_1.slotType == "weapon" then
		return arg_14_1.overloadRemaining, arg_14_1.overloadTotal
	end

	return arg_14_1.cooldownRemaining, arg_14_1.cooldownTotal
end

function SummerRaceBattleSkillItemView:RefreshCooldownUi(arg_15_1, arg_15_2)
	local var_15_0, var_15_1 = self:ResolveCooldownDisplay(arg_15_1)
	local var_15_2 = var_15_0 > 0 and var_15_1 > 0

	if arg_15_2 then
		if self.controllerStateCache_.CD == nil then
			self:SetControllerState("CD", self.cdController_, (var_15_2 or nil) and (var_0_9 or var_0_10))
		end
	end

	self.cdFillImage_.fillAmount = var_15_2 and var_0_12(var_15_0 / var_15_1) or 0
	self.cdText_.text = var_15_2 and tostring(math.ceil(var_15_0)) or ""
end

function SummerRaceBattleSkillItemView:ResolveUiState(arg_16_1, arg_16_2)
	local var_16_1 = math.max(0, arg_16_2) >= math.max(0, (arg_16_1.slotType == "weapon" or nil) and (arg_16_1.overloadEnergyCost or arg_16_1.energyCost))
	local var_16_2 = self:ResolveActiveState(arg_16_1)
	local var_16_3 = self:ResolveCooldownState(arg_16_1, var_16_2)
	local var_16_4
	local var_16_6
	local var_16_7 = arg_16_1.inputBlocked == true

	if arg_16_1.slotType == "weapon" then
		local var_16_8 = arg_16_1.canUse or arg_16_1.canOverload or arg_16_1.cooldownRemaining > 0 or arg_16_1.activeRemaining > 0 or arg_16_1.overloadRemaining > 0

		var_16_4 = var_16_8 and var_16_1 and not var_16_2 and not var_16_3 and not var_16_7
		var_16_6 = var_16_8 and not var_16_1 and not var_16_2 and not var_16_3
	else
		var_16_4 = arg_16_1.canUse and var_16_1 and not var_16_2 and not var_16_3 and not var_16_7
		var_16_6 = arg_16_1.canUse and not var_16_1 and not var_16_2 and not var_16_3
	end

	local var_16_9 = {
		canTrigger = var_16_4,
		isActive = var_16_2,
		hasCooldown = var_16_3,
		energyInsufficient = var_16_6,
		freezeControllerState = var_16_7,
		typeState = self:ResolveTypeState(arg_16_1),
		usingState = self:ResolveUsingState(arg_16_1, var_16_2)
	}

	if var_16_6 then
		var_16_9.maskState = var_0_7 or var_0_8
	end

	var_16_9.selectState = var_0_8

	return var_16_9
end

function SummerRaceBattleSkillItemView:ResolveCostText(arg_17_1)
	if arg_17_1.slotType == "weapon" then
		return tostring(var_0_11(math.max(0, arg_17_1.overloadEnergyCost)))
	end

	return tostring(var_0_11(math.max(0, arg_17_1.energyCost)))
end

function SummerRaceBattleSkillItemView:Dispose()
	self.playerEnergy_ = nil
	self.uiIndex_ = nil
	self.runtimeSkill_ = nil
	self.clickHandler_ = nil

	self:RemoveAllListeners()
	SummerRaceBattleSkillItemView.super.Dispose(self)
end

return SummerRaceBattleSkillItemView
