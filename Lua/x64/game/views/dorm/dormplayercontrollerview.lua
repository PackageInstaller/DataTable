local var_0_0 = class("DormPlayerControllerView", ReduxView)

local function var_0_1(arg_1_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityType, arg_1_0)
end

local function var_0_2(arg_2_0)
	return EntityManager.ValidateEntity(EntityManager.all, arg_2_0)
end

function var_0_0.UIName(arg_3_0)
	return "Widget/BackHouseUI/canteen/EmptyDreamCanteenPlayerControl"
end

function var_0_0.UIParent(arg_4_0)
	return manager.ui.uiMain.transform
end

local var_0_3 = {}

function var_0_0.OnCtor(arg_5_0)
	arg_5_0.playerEID = nil
	arg_5_0.curTargetList = {}
	arg_5_0.curFocusTargetEID = nil
	arg_5_0.interactRange = 0.5
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

function var_0_0.Init(arg_6_0)
	arg_6_0:InitUI()
	arg_6_0:AddUIListener()
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RegistEventListener(DORM_LOGIC_TICK, handler(arg_7_0, arg_7_0.Update))
	arg_7_0:RegistEventListener(ON_DORM_CHARACTER_INTERACT_FINISH, handler(arg_7_0, arg_7_0.Update))
	arg_7_0:RegistEventListener(DORM_CHARACTER_DISPOSE, function(arg_8_0, arg_8_1)
		if arg_8_0 == arg_7_0.playerEID then
			arg_7_0:ReleaseControl()
		end
	end)
	arg_7_0:ReleaseControl()
	arg_7_0:ClaimControl()

	if not arg_7_0.params_.isBack then
		arg_7_0:InitBubbleManager()
	end

	arg_7_0:Update()
end

function var_0_0.IsKitchenware(arg_9_0, arg_9_1)
	return arg_9_1 == DormEnum.ItemType.Pan or arg_9_1 == DormEnum.ItemType.Oven or arg_9_1 == DormEnum.ItemType.Pot or arg_9_1 == DormEnum.ItemType.Steamer
end

function var_0_0.SetCustomerHighlighted(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = CanteenAIFunction:GetEntityData(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(var_10_0.peer) do
		Dorm.DormEntityManager.SetHighlighted(iter_10_1, arg_10_2)
	end
end

function var_0_0.SetCurTarget(arg_11_0, arg_11_1)
	if arg_11_0.curFocusTargetEID and var_0_2(arg_11_0.curFocusTargetEID) then
		if CanteenAIFunction:GetEntityType(arg_11_0.curFocusTargetEID) == DormEnum.CharacterType.RestaurantNormalCustomer then
			arg_11_0:SetCustomerHighlighted(arg_11_0.curFocusTargetEID, false)
		else
			Dorm.DormEntityManager.SetHighlighted(arg_11_0.curFocusTargetEID, false)
		end
	end

	if arg_11_1 then
		local var_11_0 = CanteenAIFunction:GetEntityType(arg_11_1)

		if var_11_0 == DormEnum.CharacterType.RestaurantNormalCustomer then
			arg_11_0:SetCustomerHighlighted(arg_11_1, true)
		else
			Dorm.DormEntityManager.SetHighlighted(arg_11_1, true)
		end

		if arg_11_0:IsKitchenware(var_11_0) then
			arg_11_0.interactIconController:SetSelectedState("cook")
		elseif var_11_0 == DormEnum.ItemType.DinningTable then
			arg_11_0.interactIconController:SetSelectedState("serve")
		elseif var_11_0 == DormEnum.ItemType.PassTable then
			arg_11_0.interactIconController:SetSelectedState("pick")
		else
			arg_11_0.interactIconController:SetSelectedState("normal")
		end
	end

	arg_11_0.curFocusTargetEID = arg_11_1
end

function var_0_0.InitBubbleManager(arg_12_0)
	CharacterBubbleManager:Init()

	local var_12_0 = arg_12_0.bubblelistGo_

	CharacterBubbleManager:SetUiListPrefab(var_12_0, arg_12_0.transform_)

	local var_12_1 = CanteenItemManager.ItemEIdNamespace(DormEnum.ItemType.DinningTable)

	for iter_12_0, iter_12_1 in Dorm.storage:ForeachData(var_12_1, pairs) do
		CharacterBubbleManager:GenerateBubbleList(iter_12_1)
	end
end

local function var_0_4()
	return Dorm.storage:PickData(CanteenCharacterManager.EIdNamespace(DormEnum.CharacterType.RestaurantCook))
end

function var_0_0.PlayerEntityData(arg_14_0)
	return Dorm.storage:GetData(DormEnum.Namespace.EntityData, arg_14_0.playerEID)
end

function var_0_0.ClaimControl(arg_15_0)
	arg_15_0.playerEID = var_0_4()
	arg_15_0:PlayerEntityData().isControlledByPlayer = true

	Dorm.DormEntityManager.PlayerControlEntity(arg_15_0.playerEID)
end

function var_0_0.ReleaseControl(arg_16_0)
	if arg_16_0.playerEID then
		local var_16_0 = arg_16_0:PlayerEntityData()

		if var_16_0 then
			var_16_0.isControlledByPlayer = false
		end
	end

	arg_16_0.playerEID = nil
end

function var_0_0.InitUI(arg_17_0)
	arg_17_0:BindCfgUI()

	arg_17_0.interactController = ControllerUtil.GetController(arg_17_0.controllerRoot_, "interact")
	arg_17_0.interactIconController = ControllerUtil.GetController(arg_17_0.interactBtn_.transform, "icon")
	arg_17_0.activeController = ControllerUtil.GetController(arg_17_0.controllerRoot_, "active")
	arg_17_0.movableController = ControllerUtil.GetController(arg_17_0.controllerRoot_, "movable")

	SetActive(arg_17_0.stickGo_, true)
	DormLuaBridge.InitJoystick(arg_17_0.stickGo_)
end

function var_0_0.Update(arg_18_0)
	arg_18_0:ValidateEntityMobility()

	local var_18_0 = {}

	if arg_18_0.playerEID then
		arg_18_0:UpdateControlActive()
		arg_18_0:FindAvailableInteractOnPlayerGrid(var_18_0)
		arg_18_0:FindAvailableCustomerInRange(var_18_0)
	end

	arg_18_0.curTargetList = var_18_0

	arg_18_0:ValidateCurTargetInRange()

	local var_18_1 = next(var_18_0)
	local var_18_2 = false

	if var_18_2 then
		arg_18_0.interactController:SetSelectedState("multiTarget")
	else
		arg_18_0.interactController:SetSelectedState("singleTarget")
	end

	if arg_18_0.curFocusTargetEID == nil then
		arg_18_0:SetCurTarget(var_18_1)

		if var_18_1 == nil then
			arg_18_0.interactController:SetSelectedState("hide")
		end
	end
end

function var_0_0.AddUIListener(arg_19_0)
	arg_19_0:AddBtnListener(arg_19_0.interactBtn_, nil, function()
		if arg_19_0.interactClickTask then
			arg_19_0.interactClickTask:Abort()

			arg_19_0.interactClickTask = nil
		end

		arg_19_0.activeController:SetSelectedState("false")

		arg_19_0.interactClickTask = DormCharacterActionManager.taskRunner:NewTask():WaitUntil(function()
			return arg_19_0:EntityCanInteract(arg_19_0.curFocusTargetEID)
		end):Then(function()
			manager.notify:Invoke(DORM_CHARACTER_INTERACT, arg_19_0.playerEID, arg_19_0.curFocusTargetEID)

			arg_19_0.interactClickTask = nil
		end)

		arg_19_0.interactClickTask:Start()
	end)
	arg_19_0:AddBtnListener(arg_19_0.switchBtn_, nil, function()
		local var_23_0 = arg_19_0.curTargetList

		arg_19_0:ValidateCurTargetInRange()

		if var_23_0 then
			arg_19_0:SetCurTarget(next(var_23_0, arg_19_0.curFocusTargetEID))

			if arg_19_0.curFocusTargetEID == nil then
				arg_19_0:SetCurTarget(next(var_23_0))
			end
		end
	end)
end

function var_0_0.UpdateControlActive(arg_24_0)
	local var_24_0 = CanteenAIFunction:GetEntityData(arg_24_0.playerEID)

	arg_24_0.activeController:SetSelectedState(var_24_0.isDuringInteract and "false" or "true")
end

function var_0_0.CanInteract(arg_25_0, arg_25_1)
	return (arg_25_0:PlayerEntityData().pick and var_0_3.carry or var_0_3.normal)[arg_25_1]
end

function var_0_0.ValidateEntityMobility(arg_26_0)
	local var_26_0 = arg_26_0.playerEID and Dorm.DormEntityManager.QueryMobility(arg_26_0.playerEID)

	arg_26_0.movableController:SetSelectedState(var_26_0 and "true" or "false")
end

function var_0_0.ValidateCurTargetInRange(arg_27_0)
	if arg_27_0.curFocusTargetEID ~= nil and (not var_0_2(arg_27_0.curFocusTargetEID) or not arg_27_0.curTargetList[arg_27_0.curFocusTargetEID]) then
		arg_27_0:SetCurTarget(nil)
	end
end

function var_0_0.EntityCanInteract(arg_28_0, arg_28_1)
	local var_28_0 = var_0_1(arg_28_1)

	return arg_28_0:CanInteract(var_28_0) and CanteenAIFunction:GetItemAvailable(arg_28_1)
end

function var_0_0.FindAvailableInteractOnPlayerGrid(arg_29_0, arg_29_1)
	local var_29_0 = Dorm.DormEntityManager.QueryPosition(arg_29_0.playerEID)
	local var_29_1 = CanteenManager.GetItemInteractPointsOnGrid(var_29_0)

	for iter_29_0, iter_29_1 in pairs(var_29_1) do
		if arg_29_0:EntityCanInteract(iter_29_0) then
			arg_29_1[iter_29_0] = iter_29_1
		end
	end
end

function var_0_0.FindAvailableCustomerInRange(arg_30_0, arg_30_1)
	local var_30_0 = DormEnum.CharacterType.RestaurantNormalCustomer

	if not arg_30_0:CanInteract(var_30_0) then
		return
	end

	local var_30_1 = CanteenCharacterManager.EIdNamespace(var_30_0)

	for iter_30_0, iter_30_1 in Dorm.storage:ForeachData(var_30_1, pairs) do
		local var_30_2 = CanteenAIFunction:GetEntityData(iter_30_1)

		if var_30_2.pay then
			local var_30_3 = false
			local var_30_4 = true
			local var_30_5 = false

			for iter_30_2, iter_30_3 in pairs(var_30_2.peer) do
				local var_30_6 = CanteenAIFunction:GetEntityData(iter_30_1)

				var_30_3 = var_30_3 or arg_30_0:InRange(iter_30_3)
				var_30_4 = var_30_4 and var_30_6.sit
				var_30_5 = var_30_5 or var_30_6.eat
			end

			if var_30_3 and var_30_4 and not var_30_5 then
				arg_30_1[iter_30_1] = var_30_0
			end
		end
	end
end

function var_0_0.InRange(arg_31_0, arg_31_1)
	if EntityManager.ValidateEntity(EntityManager.all, arg_31_1) then
		local var_31_0 = Dorm.DormEntityManager.QueryPosition(arg_31_0.playerEID)
		local var_31_1 = Dorm.DormEntityManager.QueryPosition(arg_31_1)

		return Vector3.Distance(var_31_0, var_31_1) < arg_31_0.interactRange
	end
end

function var_0_0.OnExit(arg_32_0)
	arg_32_0:RemoveAllEventListener()

	if arg_32_0.interactClickTask then
		arg_32_0.interactClickTask:Abort()

		arg_32_0.interactClickTask = nil
	end
end

function var_0_0.Dispose(arg_33_0)
	return
end

return var_0_0
