local CharacterBubbleManager = class("CharacterBubbleManager")

function CharacterBubbleManager:Init()
	self.bubbleList = {}
	self.offset = 200

	self:RegisterEvent()

	self.Timer = FrameTimer.New(function()
		self:Updata()
	end, 0.016666666666666666, -1)

	self.Timer:Start()
end

function CharacterBubbleManager:RegisterEvent()
	local var_3_0 = self.listener or EventListener.New()

	var_3_0:Register(DORM_RESTAURANT_CHARACTER_BUBBLE_REFRESH, handler(self, self.RefreshWaiteFoodBubbleList))
	var_3_0:Register(DORM_CANTEEN_QUALITY_BUBBLE_REFRESH, handler(self, self.RefreshEmotionBubbleList))
	var_3_0:Register(CANTEEN_CLEAR_BUBBLE_LIST, handler(self, self.ClearBubbleList))

	self.listener = var_3_0
end

function CharacterBubbleManager:RemoveRegister()
	self.listener:RemoveAll()
end

function CharacterBubbleManager:GenerateBubbleList(arg_5_1)
	local var_5_0 = self:GetCharacterBubbleList(arg_5_1)
	local var_5_1 = self:GetCharacterScreenPosition(arg_5_1)

	var_5_1.y = var_5_1.y + self.offset
	self.bubbleList[arg_5_1].listRect = self.bubbleList[arg_5_1].listRect or var_5_0:GetComponent("RectTransform")
	self.bubbleList[arg_5_1].listRect.localPosition = var_5_1
	self.bubbleList[arg_5_1].bubbleContentList = {}
	self.bubbleList[arg_5_1].enmptyComtroller = ControllerUtil.GetController(var_5_0.transform, "empty")
	self.bubbleList[arg_5_1].scroll = self.bubbleList[arg_5_1].scroll or LuaList.New(handlerArg1(self, self.RefreshBubble, arg_5_1), var_5_0, CharacterBubbleItem)

	self.bubbleList[arg_5_1].scroll:StartScroll(0)
	self.bubbleList[arg_5_1].enmptyComtroller:SetSelectedState("false")
end

function CharacterBubbleManager:ClearBubbleList(arg_6_1)
	if self.bubbleList[arg_6_1] then
		self.bubbleList[arg_6_1].bubbleContentList = {}

		self.bubbleList[arg_6_1].scroll:StartScroll(0)
		self.bubbleList[arg_6_1].enmptyComtroller:SetSelectedState("false")
	end
end

function CharacterBubbleManager:RefreshWaiteFoodBubbleList(arg_7_1)
	local var_7_0 = CanteenAIFunction:GetEntityData(arg_7_1)

	if self.bubbleList[arg_7_1] == nil then
		return
	end

	local var_7_1 = {}

	if CanteenAIFunction:GetEntityType(arg_7_1) == DormEnum.ItemType.DinningTable then
		if var_7_0.waitFoodTimer then
			for iter_7_0, iter_7_1 in ipairs(var_7_0.curOrder) do
				if iter_7_1.status ~= DormEnum.FoodState.HasServer then
					table.insert(var_7_1, {
						type = DormEnum.BubbleType.WaitForFood,
						entityID = arg_7_1,
						duration = GameSetting.dorm_customer_wait_food_time.value[1],
						params = iter_7_1
					})
				end
			end

			self.bubbleList[arg_7_1].bubbleContentList = var_7_1

			self.bubbleList[arg_7_1].scroll:StartScroll(#var_7_1)

			if #var_7_1 == 0 then
				self.bubbleList[arg_7_1].enmptyComtroller:SetSelectedState("false")
			end
		end
	end

	self:GetCharacterBubbleList(arg_7_1):GetComponent("ScrollRectEx").vertical = false
end

function CharacterBubbleManager:RefreshEmotionBubbleList(arg_8_1)
	local var_8_0 = {}

	if CanteenAIFunction:GetEntityType(arg_8_1) == DormEnum.ItemType.DinningTable then
		table.insert(var_8_0, {
			type = DormEnum.BubbleType.CharacterEmotion,
			params = CanteenAIFunction:GetEntityData(arg_8_1)
		})

		self.bubbleList[arg_8_1].bubbleContentList = var_8_0

		self.bubbleList[arg_8_1].scroll:StartScroll(#var_8_0)
	end

	self:GetCharacterBubbleList(arg_8_1):GetComponent("ScrollRectEx").vertical = false
end

function CharacterBubbleManager:RefreshBubble(arg_9_1, arg_9_2, arg_9_3)
	arg_9_3:RefreshUI(self.bubbleList[arg_9_1].bubbleContentList[arg_9_2])
end

function CharacterBubbleManager:SetFlag(arg_10_1)
	self.flag = arg_10_1
end

function CharacterBubbleManager:Updata()
	self:UpdataListRect()
end

function CharacterBubbleManager:UpdataListRect()
	for iter_12_0, iter_12_1 in pairs(self.bubbleList) do
		local var_12_0 = self:GetCharacterScreenPosition(iter_12_0)

		var_12_0.y = var_12_0.y + self.offset
		self.bubbleList[iter_12_0].listRect.localPosition = var_12_0
	end
end

function CharacterBubbleManager:GetCharacterBubbleList(arg_13_1)
	if self.bubbleList[arg_13_1] == nil then
		self.bubbleList[arg_13_1] = {}
		self.bubbleList[arg_13_1].go = self.listPool:GetCanUsingObj()
	end

	return self.bubbleList[arg_13_1].go
end

function CharacterBubbleManager:SetUiListPrefab(arg_14_1, arg_14_2)
	if arg_14_1 and arg_14_2 then
		self.uiListPrefab = arg_14_1
		self.uiFatherTrs = arg_14_2
	else
		print("未传入uilist预制体与ui预制体")
	end

	self.listPool = Pool.New(self.uiListPrefab, self.uiFatherTrs, 0)
end

function CharacterBubbleManager:GetCharacterScreenPosition(arg_15_1)
	local var_15_0, var_15_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.uiFatherTrs, UnityEngine.RectTransformUtility.WorldToScreenPoint(manager.ui.mainCameraCom_, (Dorm.DormEntityManager.QueryPosition(arg_15_1))), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	if var_15_1 == nil then
		print("未找到对应的视口坐标")
	end

	return var_15_1
end

function CharacterBubbleManager:Dispose()
	if self.listener then
		self:RemoveRegister()
	end

	if self.Timer then
		self.Timer:Stop()

		self.Timer = nil
	end

	if self.bubbleList then
		for iter_16_0, iter_16_1 in pairs(self.bubbleList) do
			iter_16_1.scroll:StartScroll(0)
			iter_16_1.enmptyComtroller:SetSelectedState("false")
			iter_16_1.scroll:Dispose()

			iter_16_1.scroll = nil
		end
	end

	self.listPool:Dispose()

	self.bubbleList = nil
end

return CharacterBubbleManager
