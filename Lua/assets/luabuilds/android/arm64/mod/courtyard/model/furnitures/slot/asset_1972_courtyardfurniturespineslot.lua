local CourtYardFurnitureSpineSlot = class("CourtYardFurnitureSpineSlot", import(".CourtYardFurnitureBaseSlot"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function CourtYardFurnitureSpineSlot:OnInit(arg_1_1)
	self.name = arg_1_1[1][1]
	self.defaultAction = arg_1_1[1][2]
	self.mask = arg_1_1[2] and arg_1_1[2][1]

	if self.mask then
		self.maskDefaultAction = arg_1_1[2][2]
	end

	local var_1_0 = arg_1_1[4]

	if arg_1_1[4] then
		if #arg_1_1[4] > 0 then
			var_1_0 = {}
			var_1_0.offset = arg_1_1[4][1] and Vector3(arg_1_1[4][1][1], arg_1_1[4][1][2], 0) or Vector3.zero
			var_1_0.size = arg_1_1[4][2] and Vector3(arg_1_1[4][2][1], arg_1_1[4][2][2], 0) or Vector3.zero
			var_1_0.img = arg_1_1[4][3]
		else
			var_1_0 = false
		end
	end

	self.bodyMask = var_1_0
	self.offset = arg_1_1[5] and Vector3(arg_1_1[5][1], arg_1_1[5][2], 0) or Vector3.zero
	self.scale = arg_1_1[6] and Vector3(arg_1_1[6][1], arg_1_1[6][2], 0) or Vector3.one
	self.substituteActions = {}
	self.actions = {}
	self.loop = false
	self.valid = tobool(arg_1_1[3]) and tobool(arg_1_1[3][3])

	if self.valid then
		self.actions = arg_1_1[3][2]

		local var_1_1 = arg_1_1[3][3][2] or var_0_1

		if var_1_1 == true then
			var_1_1 = var_0_2
		end

		if arg_1_1[3][5] then
			var_1_1 = var_0_4
		end

		self.strategyType = var_1_1
		self.updateStrategy = self:InitUpdateStrategy(var_1_1)
		self.preheatAction = arg_1_1[3][3][3]
		self.tailAction = arg_1_1[3][3][4]
		self.loop = arg_1_1[3][4][1] == 1
		self.variedActions = arg_1_1[3][5]
	end

	return
end

function CourtYardFurnitureSpineSlot:OnInitCombine(arg_2_1)
	self.combineData = arg_2_1

	return
end

function CourtYardFurnitureSpineSlot:InitUpdateStrategy(arg_3_1)
	return arg_3_1 == var_0_2 and CourtYardFollowInteraction.New(self) or arg_3_1 == var_0_3 and CourtYardMonglineInteraction.New(self) or arg_3_1 == var_0_4 and CourtYardVariedInteraction.New(self) or CourtYardInteraction.New(self)
end

function CourtYardFurnitureSpineSlot:SetAnimators(arg_4_1)
	local var_4_0 = arg_4_1[1][self.id] or arg_4_1[1][1] or {}

	for iter_4_0, iter_4_1 in ipairs(type(var_4_0) == "string" and {
		var_4_0
	} or var_4_0) do
		table.insert(self.animators, {
			key = self.id .. "_" .. iter_4_0,
			value = iter_4_1
		})
	end

	return
end

function CourtYardFurnitureSpineSlot:SetFollower(arg_5_1)
	self.follower = {
		bone = arg_5_1[1],
		scale = Vector3(arg_5_1[2], 1, 1)
	}

	return
end

function CourtYardFurnitureSpineSlot:SetSubstitute(arg_6_1)
	self.substituteActions = _.map(arg_6_1, function(arg_7_0)
		return {
			action = arg_7_0[1],
			match = arg_7_0[2],
			replace = arg_7_0[3],
			replace_mode = arg_7_0[4],
			math_mode = arg_7_0[5]
		}
	end)

	return
end

function CourtYardFurnitureSpineSlot:GetSubstituteAction(arg_8_1, arg_8_2)
	local function var_8_0(arg_9_0)
		local var_9_0 = self:GetUser()

		return table.contains(arg_9_0.match, arg_9_0.math_mode == 1 and var_9_0:GetSkinID() or var_9_0:GetGroupID()) and (arg_9_0.replace_mode == 0 or arg_9_0.replace_mode == arg_8_2)
	end

	local var_8_1 = _.detect(self.substituteActions, function(arg_10_0)
		return arg_10_0.action == arg_8_1 and var_8_0(arg_10_0)
	end)

	return (var_8_1 or nil) and (var_8_1.replace or arg_8_1)
end

function CourtYardFurnitureSpineSlot:GetUserSubstituteAction(arg_11_1)
	return self:GetSubstituteAction(arg_11_1, 1)
end

function CourtYardFurnitureSpineSlot:GetOwnerSubstituteAction(arg_12_1)
	return self:GetSubstituteAction(arg_12_1, 2)
end

function CourtYardFurnitureSpineSlot:IsEmpty()
	return CourtYardFurnitureSpineSlot.super.IsEmpty(self) and self.valid
end

function CourtYardFurnitureSpineSlot:GetScale()
	if self.follower then
		return self.follower.scale
	else
		return self.scale
	end

	return
end

local function var_0_5(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = {}
	local var_15_2 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.variedActions) do
		table.insert(var_15_0, iter_15_1[math.random(1, #iter_15_1)])
		table.insert(var_15_1, arg_15_0.actions[1][3])
		table.insert(var_15_2, arg_15_0.actions[1][2])
	end

	return var_15_0, var_15_1, var_15_2
end

local function var_0_6(arg_16_0)
	local var_16_0 = arg_16_0:GetCombineFurnitureAnimator()
	local var_16_1 = {}
	local var_16_2 = {}
	local var_16_3 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.actions) do
		local var_16_4 = iter_16_1[1]
		local var_16_5 = iter_16_1[3]

		var_16_4 = var_16_0 and var_16_0[3] and var_16_0[3][iter_16_0] or var_16_4

		local var_16_6 = type(var_16_4) == "table" and var_16_4[math.random(1, #var_16_4)] or var_16_4

		table.insert(var_16_1, (arg_16_0:GetOwnerSubstituteAction(var_16_6)))
		table.insert(var_16_2, (arg_16_0:GetUserSubstituteAction(var_16_5 or var_16_6)))
		table.insert(var_16_3, tobool(iter_16_1[2]))
	end

	return var_16_1, var_16_2, var_16_3
end

function CourtYardFurnitureSpineSlot:GetActions()
	local var_17_0
	local var_17_1
	local var_17_2

	if self.preheatAction and type(self.preheatAction) == "string" then
		var_17_2 = false
		var_17_0 = self.preheatAction
	elseif self.preheatAction and type(self.preheatAction) == "table" then
		local var_17_3 = {}

		if type(self.preheatAction[1]) == "table" then
			for iter_17_0, iter_17_1 in ipairs(self.preheatAction[1]) do
				table.insert(var_17_3, iter_17_1)
			end
		else
			table.insert(var_17_3, self.preheatAction[1])
		end

		local var_17_5 = self:GetOwner()

		var_17_0, var_17_1, var_17_2, preheatOnlyHost = var_17_3[(isa(var_17_5, CourtYardFurniture) or nil) and #var_17_5:GetUsingSlots()], self.preheatAction[2], self.preheatAction[3], self.preheatAction[4]
	end

	local var_17_6
	local var_17_7
	local var_17_8

	if self.strategyType == var_0_4 then
		var_17_6, var_17_7, var_17_8 = var_0_5(self)
	else
		var_17_6, var_17_7, var_17_8 = var_0_6(self)
	end

	if var_17_2 then
		var_17_8[0] = true
	end

	return var_17_6, var_17_7, var_17_8, var_17_0, var_17_1, self.tailAction, preheatOnlyHost
end

function CourtYardFurnitureSpineSlot:OnAwake()
	if #self.animators > 0 then
		self.animatorIndex = math.random(1, #self.animators)
	end

	return
end

function CourtYardFurnitureSpineSlot:OnStart()
	self.updateStrategy:Update(self.loop)

	return
end

function CourtYardFurnitureSpineSlot:OnContinue(arg_20_1)
	self.updateStrategy:StepEnd(arg_20_1)

	return
end

function CourtYardFurnitureSpineSlot:Reset()
	self.updateStrategy:Reset()

	return
end

function CourtYardFurnitureSpineSlot:GetSpineDefaultAction()
	local var_22_0 = self:GetCombineFurnitureAnimator()

	if var_22_0 then
		return var_22_0[2] or self.defaultAction
	end

	return self.defaultAction
end

function CourtYardFurnitureSpineSlot:GetSpineMaskDefaultAcation()
	return self.maskDefaultAction
end

return CourtYardFurnitureSpineSlot
