local var_0_0 = singletonClass("SimBusinessGame")

local function var_0_1(arg_1_0)
	return arg_1_0.model
end

local function var_0_2(arg_2_0)
	local var_2_0 = "sim.pos." .. arg_2_0

	return nullable(Dorm.storage:PickData(var_2_0), "transform")
end

local function var_0_3(arg_3_0)
	if arg_3_0.spawnAt == nil then
		return nil
	end

	return var_0_2(arg_3_0.spawnAt)
end

local var_0_4 = math.huge

local function var_0_5(arg_4_0)
	if arg_4_0 == var_0_4 then
		return "sim.obstacle.never_remove"
	end

	return "sim.obstacle.level_" .. arg_4_0
end

function var_0_0.EnumerateShelves()
	return Dorm.storage:ForeachData("sim.shelves.eid", pairs)
end

local function var_0_6(arg_6_0)
	return {
		id = arg_6_0.cfgID,
		remain = arg_6_0.hp,
		max = arg_6_0.max
	}
end

local function var_0_7(arg_7_0)
	local var_7_0 = arg_7_0.id
	local var_7_1 = nullable(SimBusinessGuestCfg, var_7_0)
	local var_7_2 = nullable(var_7_1, "love_type") or 0
	local var_7_3 = nullable(var_7_1, "special_effect") or 0

	return {
		cfgID = var_7_0,
		hp = arg_7_0.remain,
		max = arg_7_0.remain,
		preference = var_7_2,
		specialEffect = var_7_3
	}
end

function var_0_0.exitAction(arg_8_0)
	local var_8_0 = DormUtils.GetEntityData(arg_8_0.entityID)
	local var_8_1 = SimBusinessCustomerTrait.ApplyExitTrait(var_8_0.cfgID, arg_8_0.entityID, arg_8_0.targetID, nil)

	var_8_0.hp = var_8_0.hp - var_8_1

	SimBusinessGame.GetInstance():CollectCusotmerResult(var_0_6(var_8_0))

	if var_8_0.hp <= 0 then
		Dorm.DormEntityManager.PlayEffectDetached(arg_8_0.entityID, "root", "Dorm/Effect/simBusiness/fx_business_kaixin", 5)
		var_0_0.PlaySoundEffect("minigame_activity_3_5_shop_out02")
	else
		var_0_0.PlaySoundEffect("minigame_activity_3_5_shop_out01")
	end

	var_0_0.GetInstance():RemoveEntity(arg_8_0.entityID)

	if SimBusinessGame.GetInstance():IsAllCustomerExit() then
		SimBusinessGame.GetInstance():EndGame(true)
	end
end

function var_0_0.settlementAction(arg_9_0)
	var_0_0.ProcessHp(arg_9_0.entityID, arg_9_0.targetID)

	if DormUtils.GetEntityData(arg_9_0.entityID).hp <= 0 then
		Dorm.DormEntityManager.StopAllCmd(arg_9_0.entityID)
	end
end

local function var_0_8()
	return nullable(GameDisplayCfg, "sim_business_customer_buy_vfx_threashold", "value", 1) or 15
end

function var_0_0.ProcessHp(arg_11_0, arg_11_1)
	local var_11_0 = DormUtils.GetEntityData(arg_11_0)
	local var_11_1 = SimBusinessGuestCfg[var_11_0.cfgID]
	local var_11_2 = DormUtils.GetEntityData(arg_11_1)
	local var_11_3 = {
		buyCount = 0,
		shelfEID = arg_11_1,
		goods = var_11_2.goods
	}

	if var_11_2.goods ~= 0 then
		local var_11_4 = SimBusinessTools.GetShelfSellAbility(var_11_2.cfgID)
		local var_11_5 = SimBusinessGoodsCfg[var_11_2.goods].sell_ability_addition
		local var_11_6 = var_11_1.love_type
		local var_11_7 = 0 + SimBusinessGoodsTrait.Apply(var_11_2.goods, var_11_0.cfgID, var_11_2.cfgID)

		for iter_11_0, iter_11_1 in ipairs(var_0_0.GetInstance().genCustomerInfo) do
			local var_11_8 = iter_11_1.id

			var_11_7 = var_11_7 + SimBusinessCustomerTrait.ApplyGlobalTrait(var_11_8, arg_11_0, arg_11_1, var_11_2.goods)
		end

		local var_11_9 = var_11_7 + SimBusinessCustomerTrait.ApplyNormalTrait(var_11_0.cfgID, arg_11_0, arg_11_1, var_11_2.goods)
		local var_11_10 = math.max(0, var_11_4 + var_11_5 + var_11_9)

		if var_11_10 >= var_0_8() then
			Dorm.DormEntityManager.PlayEffect(arg_11_0, "root", "Dorm/Effect/simBusiness/fx_business_canlan", 5)
		end

		var_11_0.hp = var_11_0.hp - var_11_10
		var_11_3.buyCount = var_11_10
	end

	manager.notify:Invoke("SIM_BUSINESS_GUEST_HP_CHANGE", arg_11_0, var_11_3)
end

function var_0_0.CollectCusotmerResult(arg_12_0, arg_12_1)
	table.insert(arg_12_0.customerEndResult, arg_12_1)
end

local function var_0_9(arg_13_0, arg_13_1, arg_13_2)
	SimBusinessAction.SendGameFinish(arg_13_0, arg_13_1, arg_13_2, function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
		local var_14_0 = deferred.new(function(arg_15_0)
			local var_15_0 = arg_14_0.is_clear

			JumpTools.OpenPageByJump("/activitySummerSimBusinessGameResult", {
				stage = arg_13_0,
				isClear = var_15_0,
				guest = arg_13_1,
				callback = function()
					arg_15_0:resolve()
				end
			})
		end)
		local var_14_1 = deferred.new(function(arg_17_0)
			if arg_14_3 > arg_14_2 then
				JumpTools.OpenPageByJump("simBusinessLevelUpView", {
					beforeLevel = arg_14_2,
					curLevel = arg_14_3,
					callback = function()
						arg_17_0:resolve()
					end
				})
			else
				arg_17_0:resolve()
			end
		end)
		local var_14_2 = deferred.new(function(arg_19_0)
			if #arg_14_0.item_list > 0 then
				getReward(arg_14_0.item_list, nil, function()
					arg_19_0:resolve()
				end)
			else
				arg_19_0:resolve()
			end
		end)

		deferred.all({
			var_14_1,
			var_14_0,
			var_14_2
		}):next(function()
			local var_21_0 = arg_13_0

			if SimBusinessTools.IsDailyLevel(var_21_0) then
				local var_21_1 = SimBusinessTools.GetDefaultEnterDailyLevel()

				if var_21_1 then
					SimBusinessBridge.EnterLevel(var_21_1)
					SimBusinessBridge.GoToMainPage(var_21_1)
				else
					DormMinigame.Exit()
				end
			else
				SimBusinessBridge.GoToMainPage(var_21_0)
			end
		end)
	end)
end

function var_0_0.EndGame(arg_22_0, arg_22_1)
	if arg_22_0.gameStart == nil then
		return
	end

	arg_22_0:RestoreGameGlobalSpeed()

	local var_22_0 = Time.time - arg_22_0.gameStart

	arg_22_0.gameStart = nil

	arg_22_0.entityManager:Clear()

	arg_22_0.nextGuestIdx = 0

	if arg_22_1 then
		var_0_9(arg_22_0.stage, arg_22_0.customerEndResult, var_22_0)
	else
		arg_22_0:AbortGameTask()
		SimBusinessBridge.GoToMainPage()
	end
end

local var_0_10 = {
	OnSpawn = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1.cfgID
		local var_23_1 = 0
		local var_23_2 = SimBusinessShelfCfg[var_23_0]
		local var_23_3 = var_23_2.area
		local var_23_4 = arg_23_1.testModel or var_23_2.model

		return (SimBusinessMgr.GenerateShelfEntity(var_23_4, var_23_0, var_23_3[1], var_23_3[2]))
	end,
	OnRemove = function(arg_24_0, arg_24_1)
		local var_24_0 = DormUtils.GetEntityData(arg_24_1)
		local var_24_1 = false

		if var_24_0 then
			var_24_1 = var_24_0.noOccupy or false
		end

		DormLuaBridge.RemoveFurniture(arg_24_1, not var_24_1)
	end
}

local function var_0_11()
	return nullable(GameDisplayCfg, "sim_business_customer_move_speed", "value", 1) or 1
end

local function var_0_12(arg_26_0)
	local var_26_0, var_26_1 = SimBusinessBridge.bubbleView:EmplaceBubble(arg_26_0, ShelfGoodsBubble, arg_26_0)

	var_26_1:SetActive(false)
end

local function var_0_13(arg_27_0)
	local var_27_0, var_27_1 = SimBusinessBridge.bubbleView:EmplaceBubble(arg_27_0, GuestHpBubble, arg_27_0)

	var_27_1:SetActive(true)
end

function var_0_0.Ctor(arg_28_0)
	arg_28_0.nextGuestIdx = 0
	arg_28_0.nextShelfIdx = 0
	arg_28_0.customerAI = SimBusinessCustomerAI.New()

	local var_28_0 = EntityManager.CreateModel.New(var_0_1, var_0_3)

	arg_28_0.entityManager = EntityManager.New(var_28_0)

	function arg_28_0.entityManager.OnCreate(arg_29_0, arg_29_1)
		local var_29_0 = var_0_2("exit")

		SimBusinessMgr.SetupSimBusinessEntity(arg_29_1)
		Dorm.DormEntityManager.FadeOutNearPoint(arg_29_1, var_29_0, 1)
		arg_28_0.customerAI:Add(arg_29_1)

		local var_29_1 = var_0_11()

		Dorm.DormEntityManager.SetEntitySpeed(arg_29_1, var_29_1)
		var_0_13(arg_29_1)
		manager.notify:Invoke("SIM_BUSINESS_GUEST_SPAWN", arg_29_1)
		var_0_0.PlaySoundEffect("minigame_activity_3_5_shop_in")
		SimBusinessMgr.SendSafeMove(arg_29_1, true)
	end

	function arg_28_0.entityManager.OnRemove(arg_30_0, arg_30_1)
		manager.notify:Invoke("SIM_BUSINESS_GUEST_EXIT", arg_30_1)
		arg_28_0.customerAI:Remove(arg_30_1)
		SimBusinessBridge.bubbleView:RemoveBubble(arg_30_1)

		if arg_28_0.genCustomerInfo then
			for iter_30_0, iter_30_1 in ipairs(arg_28_0.genCustomerInfo) do
				if iter_30_1.eid == arg_30_1 then
					iter_30_1.eid = nil

					break
				end
			end
		end
	end

	arg_28_0.goodsManager = EntityManager.New(var_0_10)

	function arg_28_0.goodsManager.OnCreate(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = arg_31_3.cfgID

		SimBusinessData:ClaimUseShelfCost(var_31_0)
		var_0_12(arg_31_1)
	end

	function arg_28_0.goodsManager.OnRemove(arg_32_0, arg_32_1)
		local var_32_0 = DormUtils.GetEntityData(arg_32_1)

		SimBusinessData:ReleaseUseShelfCost(var_32_0.cfgID)
		SimBusinessBridge.bubbleView:RemoveBubble(arg_32_1)
	end

	arg_28_0.entityMgrList = {
		arg_28_0.entityManager,
		arg_28_0.goodsManager
	}
end

function var_0_0.Init(arg_33_0, arg_33_1)
	arg_33_0:ResetStage(arg_33_1)

	arg_33_0.tasks = {}

	arg_33_0.customerAI:Init()

	local var_33_0 = var_0_2("spawn")
	local var_33_1 = var_0_2("exit")
	local var_33_2 = Dorm.DormEntityManager.Instance:MakeModelEntity(var_33_1)

	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, var_33_2, {})
	Dorm.storage:RecordData("sim.entity.exit", 1, var_33_2)
	DormLuaBridge.SetupFurnitureTileEntity(var_33_2)
	arg_33_0.goodsManager:MapToDormStorageData("sim.shelves.eid")
	SimBusinessMgr.FillCustomOccupy(var_33_0, Bounds(var_33_0.position, Vector3(1, 0, 1)))
	SimBusinessMgr.FillCustomOccupy(var_33_1, Bounds(var_33_1.position, Vector3(1, 0, 1)))
end

function var_0_0.ResetStage(arg_34_0, arg_34_1)
	arg_34_0:AbortGameTask()
	arg_34_0.entityManager:Clear()

	arg_34_0.nextGuestIdx = 0

	if arg_34_1 ~= arg_34_0.stage then
		arg_34_0:InitShelfLayout(arg_34_1)

		local var_34_0
		local var_34_1

		arg_34_0.stage, var_34_1 = arg_34_1, arg_34_0.stage
		arg_34_0.genCustomerInfo = arg_34_0:PrepareCustomerGenInfo()

		manager.notify:Invoke("SIM_BUSINESS_STAGE_CHANGED", arg_34_0.stage, var_34_1)
		manager.notify:CallUpdateFunc("OnSimBusinessStageChanged", arg_34_0.stage, var_34_1)
		arg_34_0:UpdateBlockArea()
	end

	arg_34_0.customerEndResult = nil
end

function var_0_0.Reset(arg_35_0)
	arg_35_0.stage = nil
	arg_35_0.genCustomerInfo = nil
	arg_35_0.customerEndResult = nil

	arg_35_0:AbortGameTask()
	arg_35_0.customerAI:Reset()

	arg_35_0.tasks = nil

	local var_35_0 = Dorm.storage:GetData("sim.entity.exit", 1)

	Dorm.storage:RecordData(DormEnum.Namespace.EntityData, var_35_0, nil)
	Dorm.DormEntityManager.Instance:RemoveEntity(var_35_0)
	arg_35_0.entityManager:Clear()

	arg_35_0.nextGuestIdx = 0

	arg_35_0:ClearAllGoodsShelves()
end

local function var_0_14(arg_36_0)
	return arg_36_0.remain > 0
end

local function var_0_15(arg_37_0)
	local var_37_0 = SimBusinessStageCfg[arg_37_0]
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0.wave) do
		table.insert(var_37_1, {
			id = iter_37_1[1],
			remain = iter_37_1[2]
		})
	end

	return var_37_1
end

function var_0_0.PrepareCustomerGenInfo(arg_38_0)
	local var_38_0 = SimBusinessData:GetLevelGuestInfo(arg_38_0.stage) or var_0_15(arg_38_0.stage)
	local var_38_1 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if var_0_14(iter_38_1) then
			table.insert(var_38_1, iter_38_1)
		end
	end

	return var_38_1
end

function var_0_0.InitShelfLayout(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0:ClearAllGoodsShelves()

	arg_39_0.nextShelfIdx = 0

	if arg_39_2 or SimBusinessTools.IsDailyLevel(arg_39_1) then
		for iter_39_0, iter_39_1 in pairs(arg_39_2 or SimBusinessData.layout) do
			local var_39_0 = arg_39_0:GenerateGoodsShelf(iter_39_1.cfgID)

			DormUtils.GetEntityData(var_39_0).goods = iter_39_1.goods

			Dorm.DormEntityManager.PutEntityLookToDir(var_39_0, iter_39_1.pos, iter_39_1.forward)
			DormLuaBridge.ChangeFurnitureState(var_39_0, DormFurnitureManager.FurnitureState.Placed, false)
			DormLuaBridge.RecoverRoomFurnitureOccupyByLua(var_39_0)
		end
	end
end

function var_0_0.IsAllCustomerExit(arg_40_0)
	return #arg_40_0.customerEndResult == #arg_40_0.genCustomerInfo
end

function var_0_0.GenerateGoodsShelf(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.nextShelfIdx
	local var_41_1 = {
		cfgID = arg_41_1,
		model = nullable(SimBusinessShelfCfg, arg_41_1, "model")
	}
	local var_41_2 = {
		noOccupy = true,
		goods = 0,
		cfgID = arg_41_1
	}
	local var_41_3 = arg_41_0.goodsManager:Create(var_41_0, var_41_1, var_41_2)

	if var_41_3 then
		arg_41_0.nextShelfIdx = arg_41_0.nextShelfIdx + 1
	end

	return var_41_3
end

function var_0_0.EditExistingGoodsShelf(arg_42_0, arg_42_1)
	local var_42_0 = DormUtils.GetEntityData(arg_42_1)

	var_42_0.noOccupy = true
	var_42_0.edit = true

	DormLuaBridge.ReleaseRoomFurnitureOccupyByLua(arg_42_1)
	DormLuaBridge.ChangeFurnitureState(arg_42_1, DormFurnitureManager.FurnitureState.Editing, true)
	SimBusinessMgr.instance:SetShelfIsCanPlace(arg_42_1, true)
end

function var_0_0.PlaceGoodsShelf(arg_43_0, arg_43_1)
	local var_43_0 = DormUtils.GetEntityData(arg_43_1)
	local var_43_1 = DormLuaBridge.SaveChange()

	if var_43_1 then
		var_43_0.noOccupy = nil

		if not SimBusinessMgr.CheckShelfAnyInteractAreaAvailable(arg_43_1) then
			ShowTips("SIM_BUSINESS_SHELF_NO_INTERACT_AREA_AVAILABLE")
		end
	end

	return var_43_1
end

function var_0_0.RevokeEditGoodsShelf(arg_44_0, arg_44_1)
	local var_44_0 = DormUtils.GetEntityData(arg_44_1)
	local var_44_1 = SimBusinessData:GetPrevCachedShelfInfo(arg_44_1)

	if var_44_1 == nil then
		arg_44_0:RemoveEntity(arg_44_1)
	else
		var_44_0.edit = nil
		var_44_0.noOccupy = nil

		Dorm.DormEntityManager.PutEntityLookToDir(arg_44_1, var_44_1.pos, var_44_1.forward)
		DormLuaBridge.ChangeFurnitureState(arg_44_1, DormFurnitureManager.FurnitureState.Placed, true)
		DormLuaBridge.RecoverRoomFurnitureOccupyByLua(arg_44_1)
	end
end

function var_0_0.RestoreAllEditShelf(arg_45_0)
	arg_45_0:ClearAllGoodsShelves()

	if SimBusinessData.cacheEditShelfInfo then
		local var_45_0 = {}

		for iter_45_0, iter_45_1 in pairs(SimBusinessData.cacheEditShelfInfo) do
			local var_45_1 = iter_45_1.cfgID
			local var_45_2 = arg_45_0:GenerateGoodsShelf(var_45_1)
			local var_45_3 = DormUtils.GetEntityData(var_45_2)

			var_45_3.noOccupy = nil
			var_45_3.goods = iter_45_1.goods

			Dorm.DormEntityManager.PutEntityLookToDir(var_45_2, iter_45_1.pos, iter_45_1.forward)
			DormLuaBridge.RecoverRoomFurnitureOccupyByLua(var_45_2)

			iter_45_1.removed = nil
			var_45_0[var_45_2] = iter_45_1
		end

		SimBusinessData.cacheEditShelfInfo = var_45_0
	end
end

function var_0_0.SetShelfGoods(arg_46_0, arg_46_1, arg_46_2)
	DormUtils.GetEntityData(arg_46_1).goods = arg_46_2

	manager.notify:Invoke("SIM_BUSINESS_SET_GOODS", arg_46_1, arg_46_2)
end

function var_0_0.BatchSetShelfGoods(arg_47_0, arg_47_1, arg_47_2)
	for iter_47_0, iter_47_1 in var_0_0.EnumerateShelves() do
		if arg_47_1 == DormUtils.GetEntityData(iter_47_1).cfgID then
			arg_47_0:SetShelfGoods(iter_47_1, arg_47_2)
		end
	end
end

function var_0_0.CalcShelfLayout()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in var_0_0.EnumerateShelves() do
		local var_48_1 = DormUtils.GetEntityData(iter_48_1)

		var_48_1.edit = nil
		var_48_1.noOccupy = nil

		table.insert(var_48_0, SimBusinessData.EntityDataToLocalLayoutInfo(iter_48_1, var_48_1))
	end

	return var_48_0
end

function var_0_0.ClearAllGoodsShelves(arg_49_0)
	arg_49_0.goodsManager:Clear()

	arg_49_0.nextShelfIdx = 0
end

function var_0_0.GenerateCustomer(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0.nextGuestIdx
	local var_50_1 = nullable(SimBusinessGuestCfg, arg_50_1.id, "model")
	local var_50_2 = {
		spawnAt = "spawn",
		complex = true
	}

	if var_50_1 == nil or var_50_1 == "" then
		Debug.LogWarning("SimBusinessGame Guest model not defined", arg_50_1.id)

		var_50_2.model = "CharDorm/9084_tpose"
	else
		var_50_2.model = "CharDorm/activity/simBusiness/" .. var_50_1
	end

	local var_50_3 = var_0_7(arg_50_1)
	local var_50_4 = arg_50_0.entityManager:Create(var_50_0, var_50_2, var_50_3)

	if var_50_4 then
		arg_50_0.nextGuestIdx = arg_50_0.nextGuestIdx + 1
	end

	arg_50_1.eid = var_50_4

	return var_50_4
end

function var_0_0.RemoveEntity(arg_51_0, arg_51_1)
	EntityManager.FindAndRemoveEntity(arg_51_0.entityMgrList, arg_51_1)
end

function var_0_0.UpdatePreviewPath(arg_52_0, arg_52_1)
	local var_52_0 = var_0_2("spawn").position
	local var_52_1 = var_0_2("exit").transform
	local var_52_2

	if arg_52_1 then
		var_52_2 = System.Action(function()
			local var_53_0 = SimBusinessMgr.instance.previewPathPoints

			if arg_52_1 then
				arg_52_1(var_53_0)
			end
		end)
	end

	SimBusinessMgr.CalcPreviewPathToTarget(var_52_0, var_52_1, var_52_2)
end

local function var_0_16(arg_54_0)
	if arg_54_0 == 1 then
		return 1
	end

	return nullable(GameDisplayCfg, "sim_business_gen_customer_interval", "value", 1) or 5
end

function var_0_0.StartGame(arg_55_0)
	arg_55_0:RestoreLastGameGlobalSpeed()

	arg_55_0.gameStart = Time.time

	local var_55_0 = DormCharacterActionManager.taskRunner:NewTask()

	arg_55_0.customerEndResult = {}

	for iter_55_0, iter_55_1 in ipairs(arg_55_0.genCustomerInfo) do
		local var_55_1 = iter_55_1.id

		SimBusinessTools.MarkGuestShown(var_55_1)
		var_55_0:WaitForSec(var_0_16(iter_55_0)):Then(function()
			arg_55_0:GenerateCustomer(iter_55_1)
		end)
	end

	arg_55_0:AddGameTask(var_55_0)
	manager.notify:CallUpdateFunc("OnSimBusinessGameStart")
end

function var_0_0.AddGameTask(arg_57_0, arg_57_1)
	table.insert(arg_57_0.tasks, arg_57_1)
	arg_57_1:Start(true)
end

function var_0_0.AbortGameTask(arg_58_0)
	if arg_58_0.tasks then
		for iter_58_0, iter_58_1 in ipairs(arg_58_0.tasks) do
			iter_58_1:Abort()
		end
	end
end

function var_0_0.UpdateBlockArea(arg_59_0)
	local var_59_0 = SimBusinessData:GetSimBusinessLevel()
	local var_59_1 = SimBusinessData:GetSimBusinessMaxLevel()

	for iter_59_0 = 1, var_59_1 - 1 do
		local var_59_2 = var_59_0 <= iter_59_0

		arg_59_0:UpdateObstacleActive(iter_59_0, var_59_2)
	end

	arg_59_0:UpdateObstacleActive(var_0_4, true)
end

function var_0_0.UpdateObstacleActive(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = var_0_5(arg_60_1)

	for iter_60_0, iter_60_1 in Dorm.storage:ForeachData(var_60_0, pairs) do
		local var_60_1 = iter_60_1:GetComponent("Collider")

		if var_60_1 then
			if arg_60_2 then
				SimBusinessMgr.FillObstacleOccupy(var_60_1)
			else
				SimBusinessMgr.RemoveObstacleOccupy(var_60_1)
			end
		end

		SetActive(iter_60_1.gameObject, arg_60_2)
	end
end

function var_0_0.HasObstacle(arg_61_0, arg_61_1)
	local var_61_0 = var_0_5(arg_61_1)

	return Dorm.storage:PickData(var_61_0) ~= nil
end

function var_0_0.SwitchGameGlobalSpeed(arg_62_0)
	if Time.timeScale == 1 then
		SimBusinessTools.SetFlag("gameSpeed", 2)
		DormMinigame.SetGlobalTimeScale(2)
	else
		SimBusinessTools.SetFlag("gameSpeed", 1)
		DormMinigame.SetGlobalTimeScale(1)
	end
end

function var_0_0.RestoreLastGameGlobalSpeed(arg_63_0)
	local var_63_0 = SimBusinessTools.GetFlag("gameSpeed") or 1

	DormMinigame.SetGlobalTimeScale(var_63_0)
end

function var_0_0.RestoreGameGlobalSpeed(arg_64_0)
	DormMinigame.SetGlobalTimeScale(1)
end

function var_0_0.PauseGame(arg_65_0)
	DormMinigame.SetGlobalTimeScale(0)
end

function var_0_0.PlaySoundEffect(arg_66_0)
	manager.audio:PlayEffect("minigame_activity_3_5", arg_66_0)
end

return var_0_0
