local CourtYardFurnitureBaseSlot = class("CourtYardFurnitureBaseSlot")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

CourtYardFurnitureBaseSlot.TYPE_COMMOM = 1
CourtYardFurnitureBaseSlot.TYPE_MAIN_SPINE = 2
CourtYardFurnitureBaseSlot.TYPE_SPINE_EXTRA = 3

function CourtYardFurnitureBaseSlot:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.controller = arg_1_4
	self.id = arg_1_1
	self.mask = nil
	self.scale = Vector3.one
	self.offset = Vector3.zero
	self.skewValue = Vector3.zero
	self.follower = nil
	self.animatorIndex = 0
	self.animators = {}
	self.bodyMask = nil
	self.name = nil

	if not arg_1_2 or arg_1_2 == "" then
		self.state = var_0_3
	else
		self.state = var_0_1

		self:OnInit(arg_1_2)
		self:OnInitCombine(arg_1_3)
	end

	return
end

function CourtYardFurnitureBaseSlot:IsEmpty()
	return self.state == var_0_1
end

function CourtYardFurnitureBaseSlot:IsUsing()
	return self.state == var_0_2
end

function CourtYardFurnitureBaseSlot:Occupy(arg_4_1, arg_4_2, arg_4_3)
	if self.state == var_0_1 then
		self.user = arg_4_2
		self.owner = arg_4_1
		self.observer = arg_4_3
		self.state = var_0_2

		arg_4_2:WillInteraction(self)
		arg_4_1:WillInteraction(self)
		self:OnAwake()
		arg_4_3:StartInteraction(self)
		arg_4_2:StartInteraction(self)
		arg_4_1:StartInteraction(self)
		onNextTick(function()
			self:OnStart()

			return
		end)
	end

	return
end

function CourtYardFurnitureBaseSlot:GetUser()
	return self.user
end

function CourtYardFurnitureBaseSlot:GetOwner()
	return self.owner
end

function CourtYardFurnitureBaseSlot:Use()
	self.state = var_0_2

	return
end

function CourtYardFurnitureBaseSlot:Empty()
	self.state = var_0_1

	return
end

function CourtYardFurnitureBaseSlot:Clear(arg_10_1)
	if self.state == var_0_2 then
		self.state = var_0_1

		self.observer:WillClearInteraction(self, arg_10_1)
		self.user:ClearInteraction(self, arg_10_1)
		self.owner:ClearInteraction(self, arg_10_1)
		self.observer:ClearInteraction(self, arg_10_1)

		self.user = nil
		self.owner = nil
		self.observer = nil
	end

	return
end

function CourtYardFurnitureBaseSlot:Continue(arg_11_1)
	self:OnContinue(arg_11_1)

	return
end

function CourtYardFurnitureBaseSlot:Stop()
	self:Clear(true)
	self:OnStop()

	return
end

function CourtYardFurnitureBaseSlot:Reset()
	return
end

function CourtYardFurnitureBaseSlot:End()
	self:Clear(false)
	self:OnEnd()

	return
end

function CourtYardFurnitureBaseSlot:GetMask()
	return self.mask
end

function CourtYardFurnitureBaseSlot:GetScale()
	return self.scale
end

function CourtYardFurnitureBaseSlot:GetOffset()
	return self.offset
end

function CourtYardFurnitureBaseSlot:GetFollower()
	return self.follower
end

function CourtYardFurnitureBaseSlot:GetBodyMask()
	return self.bodyMask
end

function CourtYardFurnitureBaseSlot:GetAnimators()
	return self.animators
end

function CourtYardFurnitureBaseSlot:GetUsingAnimator()
	return self.animators[self.animatorIndex]
end

function CourtYardFurnitureBaseSlot:GetName()
	return self.name
end

function CourtYardFurnitureBaseSlot:GetSkew()
	return self.skewValue
end

function CourtYardFurnitureBaseSlot:GetCombineFurnitureAnimator()
	if type(self.combineData) ~= "table" then
		return
	end

	for iter_24_0, iter_24_1 in ipairs(self.combineData) do
		if self:HasFurnitureList(iter_24_1[1]) then
			return iter_24_1
		end
	end

	return nil
end

function CourtYardFurnitureBaseSlot:HasFurnitureList(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		if self:HasFurniture(iter_25_1) == false then
			return false
		end
	end

	return true
end

function CourtYardFurnitureBaseSlot:HasFurniture(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.controller:GetStorey():GetFurnitures()) do
		if iter_26_1.configId == arg_26_1 then
			return true
		end
	end

	return false
end

function CourtYardFurnitureBaseSlot:OnInit(arg_27_1)
	return
end

function CourtYardFurnitureBaseSlot:OnInitCombine(arg_28_1)
	return
end

function CourtYardFurnitureBaseSlot:OnAwake()
	return
end

function CourtYardFurnitureBaseSlot:OnStart()
	return
end

function CourtYardFurnitureBaseSlot:OnStop()
	return
end

function CourtYardFurnitureBaseSlot:OnEnd()
	return
end

function CourtYardFurnitureBaseSlot:OnContinue(arg_33_1)
	return
end

return CourtYardFurnitureBaseSlot
