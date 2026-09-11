local CharacterBubbleItem = class("CharacterBubbleItem", ReduxView)

function CharacterBubbleItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CharacterBubbleItem:Init()
	self:InitUI()
	self:RegisterEvent()

	self.bubbleController = ControllerUtil.GetController(self.transform_, "state")
	self.emotionController = ControllerUtil.GetController(self.emojiTrs_, "emotion")
	self.animator = self:FindCom(typeof(Animator), "", self.emojiTrs_)
end

function CharacterBubbleItem:InitUI()
	self:BindCfgUI()
end

function CharacterBubbleItem:RegisterEvent()
	manager.notify:RegistListener(DORM_LOGIC_TICK, handler(self, self.Updata))
end

function CharacterBubbleItem:RemoveEvent()
	manager.notify:RemoveListener(DORM_LOGIC_TICK, handler(self, self.Updata))
end

function CharacterBubbleItem:RefreshUI(arg_6_1)
	if arg_6_1.type == DormEnum.BubbleType.WaitForFood then
		self:WaitFoodBubble(arg_6_1)
	elseif arg_6_1.type == DormEnum.BubbleType.Working then
		self:WorkingBubble(arg_6_1)
	elseif arg_6_1.type == DormEnum.BubbleType.CharacterEmotion then
		self:EmotionBubble(arg_6_1)
	elseif arg_6_1.type == DormEnum.BubbleType.Award then
		self:AwardBubble(arg_6_1)
	end
end

function CharacterBubbleItem:WaitFoodBubble(arg_7_1)
	self.bubbleController:SetSelectedState("sendFood")

	self.foodID_ = arg_7_1.params.cfgID
	self.foodnmaetextText_.text = GetI18NText(BackHomeCanteenFoodCfg[self.foodID_].name)
	self.entityID = arg_7_1.entityID
	self.tastenameText_.text = string.format("<color=#%s>%s</color>", CanteenConst.FoodTaste[arg_7_1.params.taste][2], GetTips(CanteenConst.FoodTaste[arg_7_1.params.taste][1]))
	self.timer = CanteenAIFunction:GetEntityData(self.entityID).waitFoodTimer
	self.time = arg_7_1.duration
end

function CharacterBubbleItem:EmotionBubble(arg_8_1)
	self.bubbleController:SetSelectedState("emotion")
	self.emotionController:SetSelectedIndex(GameDisplayCfg.canteen_customer_emote.value[arg_8_1.params.quality][2])
end

function CharacterBubbleItem:Updata()
	if self.timer then
		local var_9_0 = self.timer:QueryTime() / self.time

		if self.timebarImg_ then
			self.timebarImg_.fillAmount = 1 - var_9_0
		end

		if self.worktimebarImg_ then
			self.worktimebarImg_.fillAmount = 1 - var_9_0
		end
	end
end

function CharacterBubbleItem:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self:RemoveEvent()
	CharacterBubbleItem.super.Dispose(self)
end

return CharacterBubbleItem
