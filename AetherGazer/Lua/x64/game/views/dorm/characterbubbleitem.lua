local var_0_0 = class("CharacterBubbleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:RegisterEvent()

	arg_2_0.bubbleController = ControllerUtil.GetController(arg_2_0.transform_, "state")
	arg_2_0.emotionController = ControllerUtil.GetController(arg_2_0.emojiTrs_, "emotion")
	arg_2_0.animator = arg_2_0:FindCom(typeof(Animator), "", arg_2_0.emojiTrs_)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RegisterEvent(arg_4_0)
	manager.notify:RegistListener(DORM_LOGIC_TICK, handler(arg_4_0, arg_4_0.Updata))
end

function var_0_0.RemoveEvent(arg_5_0)
	manager.notify:RemoveListener(DORM_LOGIC_TICK, handler(arg_5_0, arg_5_0.Updata))
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	if arg_6_1.type == DormEnum.BubbleType.WaitForFood then
		arg_6_0:WaitFoodBubble(arg_6_1)
	elseif arg_6_1.type == DormEnum.BubbleType.Working then
		arg_6_0:WorkingBubble(arg_6_1)
	elseif arg_6_1.type == DormEnum.BubbleType.CharacterEmotion then
		arg_6_0:EmotionBubble(arg_6_1)
	elseif arg_6_1.type == DormEnum.BubbleType.Award then
		arg_6_0:AwardBubble(arg_6_1)
	end
end

function var_0_0.WaitFoodBubble(arg_7_0, arg_7_1)
	arg_7_0.bubbleController:SetSelectedState("sendFood")

	local var_7_0 = arg_7_1.params

	arg_7_0.foodID_ = var_7_0.cfgID
	arg_7_0.foodnmaetextText_.text = GetI18NText(BackHomeCanteenFoodCfg[arg_7_0.foodID_].name)
	arg_7_0.entityID = arg_7_1.entityID
	arg_7_0.tastenameText_.text = string.format("<color=#%s>%s</color>", CanteenConst.FoodTaste[var_7_0.taste][2], GetTips(CanteenConst.FoodTaste[var_7_0.taste][1]))
	arg_7_0.timer = CanteenAIFunction:GetEntityData(arg_7_0.entityID).waitFoodTimer
	arg_7_0.time = arg_7_1.duration
end

function var_0_0.EmotionBubble(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.params.quality

	arg_8_0.bubbleController:SetSelectedState("emotion")

	local var_8_1 = GameDisplayCfg.canteen_customer_emote.value[var_8_0][2]

	arg_8_0.emotionController:SetSelectedIndex(var_8_1)
end

function var_0_0.Updata(arg_9_0)
	if arg_9_0.timer then
		local var_9_0 = arg_9_0.timer:QueryTime() / arg_9_0.time

		if arg_9_0.timebarImg_ then
			arg_9_0.timebarImg_.fillAmount = 1 - var_9_0
		end

		if arg_9_0.worktimebarImg_ then
			arg_9_0.worktimebarImg_.fillAmount = 1 - var_9_0
		end
	end
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.timer then
		arg_10_0.timer:Stop()

		arg_10_0.timer = nil
	end

	arg_10_0:RemoveEvent()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
