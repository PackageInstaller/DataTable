local var_0_0 = class("CharacterBubbleManager")

function var_0_0.Init(arg_1_0)
	arg_1_0.bubbleList = {}
	arg_1_0.offset = 200

	arg_1_0:RegisterEvent()

	arg_1_0.Timer = FrameTimer.New(function()
		arg_1_0:Updata()
	end, 0.016666666666666666, -1)

	arg_1_0.Timer:Start()
end

function var_0_0.RegisterEvent(arg_3_0)
	local var_3_0 = arg_3_0.listener or EventListener.New()

	var_3_0:Register(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, handler(arg_3_0, arg_3_0.RefreshWaiteFoodBubbleList))
	var_3_0:Register(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, handler(arg_3_0, arg_3_0.RefreshEmotionBubbleList))
	var_3_0:Register(CANTEEN_CLEAR_BUBBLE_LIST, handler(arg_3_0, arg_3_0.ClearBubbleList))

	arg_3_0.listener = var_3_0
end

function var_0_0.RemoveRegister(arg_4_0)
	arg_4_0.listener:RemoveAll()
end

function var_0_0.GenerateBubbleList(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetCharacterBubbleList(arg_5_1)
	local var_5_1 = arg_5_0:GetCharacterScreenPosition(arg_5_1)

	var_5_1.y = var_5_1.y + arg_5_0.offset

	local var_5_2 = arg_5_0.bubbleList[arg_5_1]

	var_5_2.listRect = var_5_2.listRect or var_5_0:GetComponent("RectTransform")
	var_5_2.listRect.localPosition = var_5_1
	var_5_2.bubbleContentList = {}
	var_5_2.enmptyComtroller = ControllerUtil.GetController(var_5_0.transform, "empty")
	var_5_2.scroll = var_5_2.scroll or LuaList.New(handlerArg1(arg_5_0, arg_5_0.RefreshBubble, arg_5_1), var_5_0, CharacterBubbleItem)

	var_5_2.scroll:StartScroll(0)
	var_5_2.enmptyComtroller:SetSelectedState("false")
end

function var_0_0.ClearBubbleList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.bubbleList[arg_6_1]

	if var_6_0 then
		var_6_0.bubbleContentList = {}

		var_6_0.scroll:StartScroll(0)
		var_6_0.enmptyComtroller:SetSelectedState("false")
	end
end

function var_0_0.RefreshWaiteFoodBubbleList(arg_7_0, arg_7_1)
	local var_7_0 = CanteenAIFunction:GetEntityData(arg_7_1)
	local var_7_1 = arg_7_0.bubbleList[arg_7_1]

	if var_7_1 == nil then
		return
	end

	local var_7_2 = {}

	if CanteenAIFunction:GetEntityType(arg_7_1) == DormEnum.ItemType.DinningTable then
		local var_7_3 = var_7_0

		if var_7_3.waitFoodTimer then
			for iter_7_0, iter_7_1 in ipairs(var_7_3.curOrder) do
				if iter_7_1.status ~= DormEnum.FoodState.HasServer then
					local var_7_4 = {
						type = DormEnum.BubbleType.WaitForFood,
						entityID = arg_7_1,
						duration = GameSetting.dorm_customer_wait_food_time.value[1],
						params = iter_7_1
					}

					table.insert(var_7_2, var_7_4)
				end
			end

			var_7_1.bubbleContentList = var_7_2

			var_7_1.scroll:StartScroll(#var_7_2)

			if #var_7_2 == 0 then
				var_7_1.enmptyComtroller:SetSelectedState("false")
			end
		end
	end

	arg_7_0:GetCharacterBubbleList(arg_7_1):GetComponent("ScrollRectEx").vertical = false
end

function var_0_0.RefreshEmotionBubbleList(arg_8_0, arg_8_1)
	local var_8_0 = CanteenAIFunction:GetEntityData(arg_8_1)
	local var_8_1 = arg_8_0.bubbleList[arg_8_1]
	local var_8_2 = {}

	if CanteenAIFunction:GetEntityType(arg_8_1) == DormEnum.ItemType.DinningTable then
		local var_8_3 = {
			type = DormEnum.BubbleType.CharacterEmotion,
			params = var_8_0
		}

		table.insert(var_8_2, var_8_3)

		var_8_1.bubbleContentList = var_8_2

		var_8_1.scroll:StartScroll(#var_8_2)
	end

	arg_8_0:GetCharacterBubbleList(arg_8_1):GetComponent("ScrollRectEx").vertical = false
end

function var_0_0.RefreshBubble(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_3:RefreshUI(arg_9_0.bubbleList[arg_9_1].bubbleContentList[arg_9_2])
end

function var_0_0.SetFlag(arg_10_0, arg_10_1)
	arg_10_0.flag = arg_10_1
end

function var_0_0.Updata(arg_11_0)
	arg_11_0:UpdataListRect()
end

function var_0_0.UpdataListRect(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.bubbleList) do
		local var_12_0 = arg_12_0:GetCharacterScreenPosition(iter_12_0)

		var_12_0.y = var_12_0.y + arg_12_0.offset
		arg_12_0.bubbleList[iter_12_0].listRect.localPosition = var_12_0
	end
end

function var_0_0.GetCharacterBubbleList(arg_13_0, arg_13_1)
	if arg_13_0.bubbleList[arg_13_1] == nil then
		arg_13_0.bubbleList[arg_13_1] = {}
		arg_13_0.bubbleList[arg_13_1].go = arg_13_0.listPool:GetCanUsingObj()
	end

	return arg_13_0.bubbleList[arg_13_1].go
end

function var_0_0.SetUiListPrefab(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 and arg_14_2 then
		arg_14_0.uiListPrefab = arg_14_1
		arg_14_0.uiFatherTrs = arg_14_2
	else
		print("未传入uilist预制体与ui预制体")
	end

	arg_14_0.listPool = Pool.New(arg_14_0.uiListPrefab, arg_14_0.uiFatherTrs, 0)
end

function var_0_0.GetCharacterScreenPosition(arg_15_0, arg_15_1)
	local var_15_0 = manager.ui.mainCameraCom_
	local var_15_1 = Dorm.DormEntityManager.QueryPosition(arg_15_1)
	local var_15_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_15_0, var_15_1)
	local var_15_3 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_15_4 = {}
	local var_15_5, var_15_6 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_15_0.uiFatherTrs, var_15_2, var_15_3, var_15_4)

	if var_15_6 == nil then
		print("未找到对应的视口坐标")
	end

	return var_15_6
end

function var_0_0.Dispose(arg_16_0)
	if arg_16_0.listener then
		arg_16_0:RemoveRegister()
	end

	if arg_16_0.Timer then
		arg_16_0.Timer:Stop()

		arg_16_0.Timer = nil
	end

	if arg_16_0.bubbleList then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.bubbleList) do
			iter_16_1.scroll:StartScroll(0)
			iter_16_1.enmptyComtroller:SetSelectedState("false")
			iter_16_1.scroll:Dispose()

			iter_16_1.scroll = nil
		end
	end

	arg_16_0.listPool:Dispose()

	arg_16_0.bubbleList = nil
end

return var_0_0
