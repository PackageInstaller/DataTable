local DormPlayerControllerView = class("DormPlayerControllerView", ReduxView)

local function var_0_1(arg_1_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityType, arg_1_0)
end

local function var_0_2(arg_2_0)
	return EntityManager.ValidateEntity(EntityManager.all, arg_2_0)
end

function DormPlayerControllerView:UIName()
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenPlayerControl"
end

function DormPlayerControllerView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_3 = {}

function DormPlayerControllerView:OnCtor()
	self.playerEID = nil
	self.curTargetList = {}
	self.curFocusTargetEID = nil
	self.interactRange = 0.5
	var_0_3.carry = {
		[DormEnum.ItemType.PassTable] = true,
		[DormEnum.ItemType.DinningTable] = true,
		[DormEnum.ItemType.TrashCan] = true
	}
	var_0_3.normal = {
		[DormEnum.ItemType.Pan] = true,
		[DormEnum.ItemType.Oven] = true,
		[DormEnum.ItemType.Steamer] = true,
		[DormEnum.ItemType.Pot] = true,
		[DormEnum.ItemType.Food] = true,
		[DormEnum.ItemType.PassTable] = true,
		[DormEnum.CharacterType.RestaurantNormalCustomer] = true
	}
end

function DormPlayerControllerView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DormPlayerControllerView:OnEnter()
	self:RegistEventListener(DORM_LOGIC_TICK, handler(self, self.Update))
	self:RegistEventListener(ON_DORM_CHARACTER_INTERACT_FINISH, handler(self, self.Update))
	self:RegistEventListener(DORM_CHARACTER_DISPOSE, function(arg_8_0, arg_8_1)
		if arg_8_0 == self.playerEID then
			self:ReleaseControl()
		end
	end)
	self:ReleaseControl()
	self:ClaimControl()

	if not self.params_.isBack then
		self:InitBubbleManager()
	end

	self:Update()
end

function DormPlayerControllerView:IsKitchenware(arg_9_1)
	return arg_9_1 == DormEnum.ItemType.Pan or arg_9_1 == DormEnum.ItemType.Oven or arg_9_1 == DormEnum.ItemType.Pot or arg_9_1 == DormEnum.ItemType.Steamer
end

function DormPlayerControllerView:SetCustomerHighlighted(arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(CanteenAIFunction:GetEntityData(arg_10_1).peer) do
		Dorm.DormEntityManager.SetHighlighted(iter_10_1, arg_10_2)
	end
end

function DormPlayerControllerView:SetCurTarget(arg_11_1)
	if self.curFocusTargetEID and var_0_2(self.curFocusTargetEID) then
		if CanteenAIFunction:GetEntityType(self.curFocusTargetEID) == DormEnum.CharacterType.RestaurantNormalCustomer then
			self:SetCustomerHighlighted(self.curFocusTargetEID, false)
		else
			Dorm.DormEntityManager.SetHighlighted(self.curFocusTargetEID, false)
		end
	end

	if arg_11_1 then
		local var_11_0 = CanteenAIFunction:GetEntityType(arg_11_1)

		if var_11_0 == DormEnum.CharacterType.RestaurantNormalCustomer then
			self:SetCustomerHighlighted(arg_11_1, true)
		else
			Dorm.DormEntityManager.SetHighlighted(arg_11_1, true)
		end

		if self:IsKitchenware(var_11_0) then
			self.interactIconController:SetSelectedState("cook")
		elseif var_11_0 == DormEnum.ItemType.DinningTable then
			self.interactIconController:SetSelectedState("serve")
		elseif var_11_0 == DormEnum.ItemType.PassTable then
			self.interactIconController:SetSelectedState("pick")
		else
			self.interactIconController:SetSelectedState("normal")
		end
	end

	self.curFocusTargetEID = arg_11_1
end

function DormPlayerControllerView:InitBubbleManager()
	CharacterBubbleManager:Init()
	CharacterBubbleManager:SetUiListPrefab(self.bubblelistGo_, self.transform_)

	for iter_12_0, iter_12_1 in Dorm.storage:ForeachData(CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable), pairs) do
		CharacterBubbleManager:GenerateBubbleList(iter_12_1)
	end
end

local function var_0_4()
	return Dorm.storage:PickData(CanteenCharacterManager.EIdNamespace(DormEnum.CharacterType.RestaurantCook))
end

function DormPlayerControllerView:PlayerEntityData()
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, self.playerEID)
end

function DormPlayerControllerView:ClaimControl()
	self.playerEID = var_0_4()
	self:PlayerEntityData().isControlledByPlayer = true

	Dorm.DormEntityManager.PlayerControlEntity(self.playerEID)
end

function DormPlayerControllerView:ReleaseControl()
	if self.playerEID then
		local var_16_0 = self:PlayerEntityData()

		if var_16_0 then
			var_16_0.isControlledByPlayer = false
		end
	end

	self.playerEID = nil
end

function DormPlayerControllerView:InitUI()
	self:BindCfgUI()

	self.interactController = ControllerUtil.GetController(self.controllerRoot_, "interact")
	self.interactIconController = ControllerUtil.GetController(self.interactBtn_.transform, "icon")
	self.activeController = ControllerUtil.GetController(self.controllerRoot_, "active")
	self.movableController = ControllerUtil.GetController(self.controllerRoot_, "movable")

	SetActive(self.stickGo_, true)
	DormLuaBridge.InitJoystick(self.stickGo_)
end

function DormPlayerControllerView:Update()
	self:ValidateEntityMobility()

	local var_18_0 = {}

	if self.playerEID then
		self:UpdateControlActive()
		self:FindAvailableInteractOnPlayerGrid(var_18_0)
		self:FindAvailableCustomerInRange(var_18_0)
	end

	self.curTargetList = var_18_0

	self:ValidateCurTargetInRange()

	local var_18_1 = next(var_18_0)

	if false then
		self.interactController:SetSelectedState("multiTarget")
	else
		self.interactController:SetSelectedState("singleTarget")
	end

	if self.curFocusTargetEID == nil then
		self:SetCurTarget(var_18_1)

		if var_18_1 == nil then
			self.interactController:SetSelectedState("hide")
		end
	end
end

function DormPlayerControllerView:AddUIListener()
	self:AddBtnListener(self.interactBtn_, nil, function()
		if self.interactClickTask then
			self.interactClickTask:Abort()

			self.interactClickTask = nil
		end

		self.activeController:SetSelectedState("false")

		self.interactClickTask = DormCharacterActionManager.taskRunner:NewTask():WaitUntil(function()
			return self:EntityCanInteract(self.curFocusTargetEID)
		end):Then(function()
			manager.notify:Invoke(DORM_CHARACTER_INTERACT, self.playerEID, self.curFocusTargetEID)

			self.interactClickTask = nil
		end)

		self.interactClickTask:Start()
	end)
	self:AddBtnListener(self.switchBtn_, nil, function()
		self:ValidateCurTargetInRange()

		if self.curTargetList then
			self:SetCurTarget(next(self.curTargetList, self.curFocusTargetEID))

			if self.curFocusTargetEID == nil then
				self:SetCurTarget(next(self.curTargetList))
			end
		end
	end)
end

function DormPlayerControllerView:UpdateControlActive()
	self.activeController:SetSelectedState(CanteenAIFunction:GetEntityData(self.playerEID).isDuringInteract and "false" or "true")
end

function DormPlayerControllerView:CanInteract(arg_25_1)
	return ((self:PlayerEntityData().pick or nil) and (var_0_3.carry or var_0_3.normal))[arg_25_1]
end

function DormPlayerControllerView:ValidateEntityMobility()
	self.movableController:SetSelectedState(self.playerEID and Dorm.DormEntityManager.QueryMobility(self.playerEID) and "true" or "false")
end

function DormPlayerControllerView:ValidateCurTargetInRange()
	if self.curFocusTargetEID ~= nil and (not var_0_2(self.curFocusTargetEID) or not self.curTargetList[self.curFocusTargetEID]) then
		self:SetCurTarget(nil)
	end
end

function DormPlayerControllerView:EntityCanInteract(arg_28_1)
	return self:CanInteract((var_0_1(arg_28_1))) and CanteenAIFunction:GetItemAvailable(arg_28_1)
end

function DormPlayerControllerView:FindAvailableInteractOnPlayerGrid(arg_29_1)
	for iter_29_0, iter_29_1 in pairs((CanteenManager.GetItemInteractPointsOnGrid((Dorm.DormEntityManager.QueryPosition(self.playerEID))))) do
		if self:EntityCanInteract(iter_29_0) then
			arg_29_1[iter_29_0] = iter_29_1
		end
	end
end

function DormPlayerControllerView:FindAvailableCustomerInRange(arg_30_1)
	if not self:CanInteract(DormEnum.CharacterType.RestaurantNormalCustomer) then
		return
	end

	for iter_30_0, iter_30_1 in Dorm.storage:ForeachData(CanteenCharacterManager.EIdNamespace(DormEnum.CharacterType.RestaurantNormalCustomer), pairs) do
		local var_30_0 = CanteenAIFunction:GetEntityData(iter_30_1)

		if var_30_0.pay then
			local var_30_1 = false
			local var_30_2 = true
			local var_30_3 = false

			for iter_30_2, iter_30_3 in pairs(var_30_0.peer) do
				local var_30_4 = CanteenAIFunction:GetEntityData(iter_30_1)

				var_30_1 = var_30_1 or self:InRange(iter_30_3)
				var_30_2 = var_30_2 and var_30_4.sit
				var_30_3 = var_30_3 or var_30_4.eat
			end

			if var_30_1 and var_30_2 and not var_30_3 then
				arg_30_1[iter_30_1] = DormEnum.CharacterType.RestaurantNormalCustomer
			end
		end
	end
end

function DormPlayerControllerView:InRange(arg_31_1)
	if EntityManager.ValidateEntity(EntityManager.all, arg_31_1) then
		return Vector3.Distance(Dorm.DormEntityManager.QueryPosition(self.playerEID), (Dorm.DormEntityManager.QueryPosition(arg_31_1))) < self.interactRange
	end
end

function DormPlayerControllerView:OnExit()
	self:RemoveAllEventListener()

	if self.interactClickTask then
		self.interactClickTask:Abort()

		self.interactClickTask = nil
	end
end

function DormPlayerControllerView:Dispose()
	return
end

return DormPlayerControllerView
