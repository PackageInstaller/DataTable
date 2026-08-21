local var_0_0 = class("ActivityAutoCookPlayView", ReduxView)

var_0_0.SUCCESS = 1
var_0_0.FAIL = 2
var_0_0.DARKNESS = 3

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteenUI/SandPlay_Com_IdleCanteenCookingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.numController_ = arg_4_0.controllerEx_:GetController("amount")
	arg_4_0.statusController_ = arg_4_0.controllerEx_:GetController("state")
	arg_4_0.cookBtnController_ = arg_4_0.controllerEx_:GetController("cookBtn")
	arg_4_0.resultController_ = arg_4_0.controllerEx_:GetController("result")
	arg_4_0.bubbleController_ = arg_4_0.bubbleControllerEx_:GetController("state")
	arg_4_0.curSelectList_ = {}
	arg_4_0.curFoodID_ = 0
	arg_4_0.faildCount_ = 0
	arg_4_0.selectController1_ = arg_4_0.selectControllerEx1_:GetController("place")
	arg_4_0.selectController2_ = arg_4_0.selectControllerEx2_:GetController("place")
	arg_4_0.selectController3_ = arg_4_0.selectControllerEx3_:GetController("place")
	arg_4_0.selectController4_ = arg_4_0.selectControllerEx4_:GetController("place")
	arg_4_0.heroController_ = arg_4_0.heroControllerEx_:GetController("hero")
	arg_4_0.hero1012Spine_ = arg_4_0.hero1012Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.hero1061Spine_ = arg_4_0.hero1061Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.hero1071Spine_ = arg_4_0.hero1071Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.hero1074Spine_ = arg_4_0.hero1074Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_4_0.talkTimer_ = nil
	arg_4_0.curDragMaterialID_ = 0
end

function var_0_0.AddUIListeners(arg_5_0)
	for iter_5_0 = 1, 6 do
		arg_5_0:AddBtnListener(arg_5_0["materialBtn" .. iter_5_0 .. "_"], nil, function()
			arg_5_0:StopGuideTimer()

			for iter_6_0 = 1, arg_5_0.selectNum_ do
				if arg_5_0.curSelectList_[iter_6_0] == nil then
					arg_5_0.curSelectList_[iter_6_0] = arg_5_0.materialList_[iter_5_0]

					arg_5_0["selectController" .. iter_6_0 .. "_"]:SetSelectedState("on")

					arg_5_0["selectImage" .. iter_6_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[arg_5_0.curSelectList_[iter_6_0]].icon_path)

					arg_5_0:RefreshCookBtn()

					break
				end
			end
		end)
	end

	for iter_5_1 = 1, 4 do
		arg_5_0:AddBtnListener(arg_5_0["selectIndexBtn" .. iter_5_1 .. "_"], nil, function()
			arg_5_0["selectController" .. iter_5_1 .. "_"]:SetSelectedState("off")

			arg_5_0.curSelectList_[iter_5_1] = nil

			arg_5_0:RefreshCookBtn()
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.makeBtn_, nil, function()
		for iter_8_0 = 1, arg_5_0.selectNum_ do
			if arg_5_0.curSelectList_[iter_8_0] == nil then
				ShowTips("ACTIVITY_AUTO_COOK_NOMATERIAL")

				return
			end
		end

		arg_5_0.curFoodID_ = ActivityAutoCookData:Cook(arg_5_0.curSelectList_)

		arg_5_0:RefreshCookState()
		arg_5_0.statusController_:SetSelectedState("cook")

		local var_8_0
		local var_8_1 = arg_5_0.cookState_ == var_0_0.SUCCESS and "Cooking" or "Cooking02"

		arg_5_0.foodImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/Cuisine/" .. ActivityAutoCookFoodCfg[arg_5_0.curFoodID_].icon_path)

		manager.ui:UIEventEnabled(false)
		manager.windowBar:HideBar()
		arg_5_0:PlayCookAnimator(var_8_1, function()
			arg_5_0:WaitServer()
		end)
	end)

	for iter_5_2 = 1, 6 do
		arg_5_0:AddDragListener(arg_5_0["materialBtn" .. iter_5_2 .. "_"].gameObject, function()
			arg_5_0:StopGuideTimer()

			arg_5_0.curDragMaterialID_ = arg_5_0.materialList_[iter_5_2]

			SetActive(arg_5_0.dargImage_.gameObject, true)

			arg_5_0.dargImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[arg_5_0.curDragMaterialID_].icon_path)
		end, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
			local var_11_0 = -arg_11_0
			local var_11_1 = -arg_11_1
			local var_11_2 = arg_5_0["materialBtn" .. iter_5_2 .. "_"].transform.localPosition

			arg_5_0.dargImage_.transform.localPosition = Vector3.New(var_11_2.x + var_11_0, var_11_2.y + var_11_1, 0)
		end, function(arg_12_0, arg_12_1, arg_12_2)
			if arg_5_0.curDragMaterialID_ == 0 then
				return
			end

			local var_12_0 = arg_5_0["materialBtn" .. iter_5_2 .. "_"].transform.localPosition
			local var_12_1 = var_12_0.x - arg_12_0
			local var_12_2 = var_12_0.y - arg_12_1

			for iter_12_0 = 1, arg_5_0.selectNum_ do
				local var_12_3 = arg_5_0["selectIndexBtn" .. iter_12_0 .. "_"].transform.localPosition
				local var_12_4 = math.abs(var_12_3.x - var_12_1)
				local var_12_5 = math.abs(var_12_3.y - var_12_2)

				if var_12_4 < 100 and var_12_5 < 100 then
					arg_5_0.curSelectList_[iter_12_0] = arg_5_0.curDragMaterialID_

					arg_5_0["selectController" .. iter_12_0 .. "_"]:SetSelectedState("on")

					arg_5_0["selectImage" .. iter_12_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[arg_5_0.curSelectList_[iter_12_0]].icon_path)

					arg_5_0:RefreshCookBtn()
				end
			end

			SetActive(arg_5_0.dargImage_.gameObject, false)

			arg_5_0.curDragMaterialID_ = 0
		end)
	end
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.activityID_ = ActivityConst.AUTO_COOK
	arg_13_0.battleHeroID_ = arg_13_0.params_.battleHeroID
	arg_13_0.activityStageID_ = arg_13_0.params_.activityStageID
	arg_13_0.stageCfg_ = ActivityAutoCookStageCfg[arg_13_0.activityStageID_]
	arg_13_0.materialList_ = arg_13_0.stageCfg_.material_list
	arg_13_0.isWin_ = false
	arg_13_0.startPlayTimeStep_ = manager.time:GetServerTime()
	arg_13_0.serverCount_ = 0
	arg_13_0.faildCount_ = 0
	arg_13_0.materialHistoryList_ = {}
	arg_13_0.foodHistoryList_ = {}

	arg_13_0.heroController_:SetSelectedState(arg_13_0.battleHeroID_)

	arg_13_0.heroSpine_ = arg_13_0["hero" .. arg_13_0.battleHeroID_ .. "Spine_"]
	arg_13_0.selectNum_ = #ActivityAutoCookFoodCfg[arg_13_0.stageCfg_.food].recipe

	if arg_13_0.selectNum_ == 3 then
		arg_13_0.numController_:SetSelectedState("three")
	elseif arg_13_0.selectNum_ == 4 then
		arg_13_0.numController_:SetSelectedState("four")
	end

	arg_13_0:RefreshUI()
	arg_13_0.bubbleAnimator_:Play("in", 0, 0)
	arg_13_0.bubbleAnimator_:Update(0)

	arg_13_0.desText_.text = arg_13_0.stageCfg_.first_challenge_tips

	arg_13_0:ReSetGame()

	arg_13_0.timer_ = Timer.New(function()
		arg_13_0:PlayGuideAni_()
	end, 5, -1)

	arg_13_0.timer_:Start()
end

function var_0_0.RefreshCookBtn(arg_15_0)
	for iter_15_0 = 1, arg_15_0.selectNum_ do
		if arg_15_0.curSelectList_[iter_15_0] == nil then
			arg_15_0.cookBtnController_:SetSelectedState("false")

			return
		end
	end

	arg_15_0.cookBtnController_:SetSelectedState("true")
end

function var_0_0.PlayGuideAni_(arg_16_0)
	arg_16_0.guideAni_:Play("CookingUI_guide")
end

function var_0_0.ReSetGame(arg_17_0)
	arg_17_0.statusController_:SetSelectedState("cooking")

	arg_17_0.curFoodID_ = 0
	arg_17_0.curSelectList_ = {}

	for iter_17_0 = 1, arg_17_0.selectNum_ do
		arg_17_0["selectController" .. iter_17_0 .. "_"]:SetSelectedState("off")
	end
end

function var_0_0.OnTop(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.RefreshUI(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.materialList_) do
		arg_19_0["materialImage" .. iter_19_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[iter_19_1].icon_path)
	end

	arg_19_0:RefreshCookBtn()
	SetActive(arg_19_0.dargImage_.gameObject, false)

	arg_19_0.curDragMaterialID_ = 0

	arg_19_0.heroSpine_.AnimationState:SetAnimation(0, "idle", true)
end

function var_0_0.RefreshCookState(arg_20_0)
	local var_20_0 = deepClone(arg_20_0.curSelectList_)

	arg_20_0.serverCount_ = arg_20_0.serverCount_ + 1

	table.insert(arg_20_0.materialHistoryList_, var_20_0)
	table.insert(arg_20_0.foodHistoryList_, arg_20_0.curFoodID_)

	if arg_20_0.curFoodID_ == arg_20_0.stageCfg_.food then
		arg_20_0.cookState_ = var_0_0.SUCCESS
	elseif ActivityAutoCookFoodCfg[arg_20_0.curFoodID_].type == 1 then
		arg_20_0.cookState_ = var_0_0.DARKNESS
	else
		arg_20_0.cookState_ = var_0_0.FAIL
	end
end

function var_0_0.WaitServer(arg_21_0)
	arg_21_0.statusController_:SetSelectedState("serve")

	if arg_21_0.cookState_ == var_0_0.SUCCESS then
		arg_21_0.resultController_:SetSelectedState("correct")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done03", "")
	elseif arg_21_0.cookState_ == var_0_0.DARKNESS then
		arg_21_0.resultController_:SetSelectedState("darkness")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done02", "")
	else
		arg_21_0.resultController_:SetSelectedState("fault")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done01", "")
	end

	arg_21_0:ServerFood()
end

function var_0_0.StartEat(arg_22_0)
	arg_22_0:StopEatTimer()

	arg_22_0.eatTimer_ = Timer.New(function()
		arg_22_0:StopEatTimer()
	end, 2, 1)

	arg_22_0.eatTimer_:Start()
end

function var_0_0.StopEatTimer(arg_24_0)
	if arg_24_0.eatTimer_ then
		arg_24_0.eatTimer_:Stop()

		arg_24_0.eatTimer_ = nil
	end
end

function var_0_0.ServerFood(arg_25_0)
	if arg_25_0.cookState_ == var_0_0.SUCCESS then
		arg_25_0.bubbleController_:SetSelectedState("like")

		arg_25_0.isWin_ = true

		local var_25_0 = manager.time:GetServerTime() - arg_25_0.startPlayTimeStep_
		local var_25_1 = {}

		for iter_25_0, iter_25_1 in pairs(arg_25_0.materialHistoryList_) do
			local var_25_2 = string.format("[%s]", table.concat(iter_25_1, ","))

			table.insert(var_25_1, var_25_2)
		end

		local var_25_3 = string.format("[%s]", table.concat(var_25_1, ","))
		local var_25_4 = string.format("[%s]", table.concat(arg_25_0.foodHistoryList_, ","))

		ActivityAutoCookAction:AutoCookStageFinish(arg_25_0.activityStageID_, arg_25_0.battleHeroID_, function()
			SDKTools.SendMessageToSDK("activity_combat_over", {
				result = 1,
				activity_id = arg_25_0.activityID_,
				stage_id = arg_25_0.activityStageID_,
				use_seconds = var_25_0,
				battle_times = arg_25_0.serverCount_,
				cost_item_list = var_25_3,
				params_list = var_25_4
			})
		end)
		arg_25_0.heroSpine_.AnimationState:SetAnimation(0, "kaixin", true)
		arg_25_0:TalkWithTimer(arg_25_0.stageCfg_.success_tips, function()
			arg_25_0.bubbleController_:SetSelectedState("normal")
			manager.ui:UIEventEnabled(true)
			manager.windowBar:SwitchBar({
				BACK_BAR
			})
			JumpTools.Back()
		end)
	else
		arg_25_0.heroSpine_.AnimationState:SetAnimation(0, "ganga", true)

		if arg_25_0.cookState_ == var_0_0.DARKNESS then
			arg_25_0.bubbleController_:SetSelectedState("unlike")
			arg_25_0:TalkWithTimer(arg_25_0.stageCfg_.dark_food_tips, function()
				arg_25_0.bubbleController_:SetSelectedState("normal")
				arg_25_0:CookTips()
				arg_25_0:ReSetGame()
				manager.ui:UIEventEnabled(true)
				manager.windowBar:SwitchBar({
					BACK_BAR
				})
			end)
		else
			arg_25_0:TalkWithTimer(arg_25_0.stageCfg_.fail_tips, function()
				arg_25_0.bubbleController_:SetSelectedState("normal")
				arg_25_0:CookTips()
				arg_25_0:ReSetGame()
				manager.ui:UIEventEnabled(true)
				manager.windowBar:SwitchBar({
					BACK_BAR
				})
			end)
		end
	end
end

function var_0_0.CookTips(arg_30_0)
	arg_30_0.bubbleAnimator_:Play("in", 0, 0)
	arg_30_0.bubbleAnimator_:Update(0)
	arg_30_0.bubbleController_:SetSelectedState("normal")

	if arg_30_0.faildCount_ == 0 then
		arg_30_0.desText_.text = arg_30_0.stageCfg_.simple_challenge_tips
	else
		arg_30_0.desText_.text = arg_30_0.stageCfg_.challenge_tips
	end

	arg_30_0.faildCount_ = arg_30_0.faildCount_ + 1

	arg_30_0.heroSpine_.AnimationState:SetAnimation(0, "idle", true)
end

function var_0_0.PlayCookAnimator(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0.cookingAnimator_:Play(arg_31_1, 0, 0)
	arg_31_0.bubbleAnimator_:Play("out", 0, 0)

	arg_31_0.cookTimer_ = FrameTimer.New(function()
		if arg_31_0.cookingAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			arg_31_0:StopCookAnimator()
			arg_31_2()
		end
	end, 1, -1)

	arg_31_0.cookTimer_:Start()
end

function var_0_0.StopCookAnimator(arg_33_0)
	if arg_33_0.cookTimer_ then
		arg_33_0.cookTimer_:Stop()

		arg_33_0.cookTimer_ = nil
	end
end

function var_0_0.TalkWithTimer(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.talkTimer_ ~= nil then
		arg_34_0:StopTimer()
	end

	arg_34_0.desText_.text = arg_34_1

	arg_34_0.bubbleAnimator_:Play("in", 0, 0)
	arg_34_0.bubbleAnimator_:Update(0)

	arg_34_0.talkTimer_ = Timer.New(function()
		if arg_34_2 then
			arg_34_2()
		end
	end, 4, 1)

	arg_34_0.talkTimer_:Start()
end

function var_0_0.StopTimer(arg_36_0)
	if arg_36_0.talkTimer_ then
		arg_36_0.talkTimer_:Stop()

		arg_36_0.talkTimer_ = nil
	end
end

function var_0_0.StopGuideTimer(arg_37_0)
	if arg_37_0.timer_ then
		arg_37_0.timer_:Stop()

		arg_37_0.timer_ = nil
	end
end

function var_0_0.OnExit(arg_38_0)
	manager.windowBar:HideBar()

	if not arg_38_0.isWin_ then
		local var_38_0 = manager.time:GetServerTime() - arg_38_0.startPlayTimeStep_
		local var_38_1 = {}

		for iter_38_0, iter_38_1 in pairs(arg_38_0.materialHistoryList_) do
			local var_38_2 = string.format("[%s]", table.concat(iter_38_1, ","))

			table.insert(var_38_1, var_38_2)
		end

		local var_38_3 = string.format("[%s]", table.concat(var_38_1, ","))
		local var_38_4 = string.format("[%s]", table.concat(arg_38_0.foodHistoryList_, ","))

		SDKTools.SendMessageToSDK("activity_combat_over", {
			result = 3,
			activity_id = arg_38_0.activityID_,
			stage_id = arg_38_0.activityStageID_,
			use_seconds = var_38_0,
			battle_times = arg_38_0.serverCount_,
			cost_item_list = var_38_3,
			params_list = var_38_4
		})
	end

	arg_38_0:StopTimer()
	arg_38_0:StopGuideTimer()
	arg_38_0:StopEatTimer()
	arg_38_0:StopCookAnimator()
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0:StopTimer()
	arg_39_0:StopGuideTimer()
	arg_39_0.super.Dispose(arg_39_0)
end

return var_0_0
