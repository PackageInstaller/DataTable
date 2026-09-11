local ActivityAutoCookPlayView = class("ActivityAutoCookPlayView", ReduxView)

ActivityAutoCookPlayView.SUCCESS = 1
ActivityAutoCookPlayView.FAIL = 2
ActivityAutoCookPlayView.DARKNESS = 3

function ActivityAutoCookPlayView:UIName()
	return "Widget/Version/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteenUI/SandPlay_Com_IdleCanteenCookingUI"
end

function ActivityAutoCookPlayView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityAutoCookPlayView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityAutoCookPlayView:InitUI()
	self:BindCfgUI()

	self.numController_ = self.controllerEx_:GetController("amount")
	self.statusController_ = self.controllerEx_:GetController("state")
	self.cookBtnController_ = self.controllerEx_:GetController("cookBtn")
	self.resultController_ = self.controllerEx_:GetController("result")
	self.bubbleController_ = self.bubbleControllerEx_:GetController("state")
	self.curSelectList_ = {}
	self.curFoodID_ = 0
	self.faildCount_ = 0
	self.selectController1_ = self.selectControllerEx1_:GetController("place")
	self.selectController2_ = self.selectControllerEx2_:GetController("place")
	self.selectController3_ = self.selectControllerEx3_:GetController("place")
	self.selectController4_ = self.selectControllerEx4_:GetController("place")
	self.heroController_ = self.heroControllerEx_:GetController("hero")
	self.hero1012Spine_ = self.hero1012Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.hero1061Spine_ = self.hero1061Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.hero1071Spine_ = self.hero1071Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.hero1074Spine_ = self.hero1074Go_:GetComponent("Spine.Unity.SkeletonGraphic")
	self.talkTimer_ = nil
	self.curDragMaterialID_ = 0
end

function ActivityAutoCookPlayView:AddUIListeners()
	for iter_5_0 = 1, 6 do
		self:AddBtnListener(self["materialBtn" .. iter_5_0 .. "_"], nil, function()
			self:StopGuideTimer()

			for iter_6_0 = 1, self.selectNum_ do
				if self.curSelectList_[iter_6_0] == nil then
					self.curSelectList_[iter_6_0] = self.materialList_[iter_5_0]

					self["selectController" .. iter_6_0 .. "_"]:SetSelectedState("on")

					self["selectImage" .. iter_6_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[self.curSelectList_[iter_6_0]].icon_path)

					self:RefreshCookBtn()

					break
				end
			end
		end)
	end

	for iter_5_1 = 1, 4 do
		self:AddBtnListener(self["selectIndexBtn" .. iter_5_1 .. "_"], nil, function()
			self["selectController" .. iter_5_1 .. "_"]:SetSelectedState("off")

			self.curSelectList_[iter_5_1] = nil

			self:RefreshCookBtn()
		end)
	end

	self:AddBtnListener(self.makeBtn_, nil, function()
		for iter_8_0 = 1, self.selectNum_ do
			if self.curSelectList_[iter_8_0] == nil then
				ShowTips("ACTIVITY_AUTO_COOK_NOMATERIAL")

				return
			end
		end

		self.curFoodID_ = ActivityAutoCookData:Cook(self.curSelectList_)

		self:RefreshCookState()
		self.statusController_:SetSelectedState("cook")

		self.foodImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/Cuisine/" .. ActivityAutoCookFoodCfg[self.curFoodID_].icon_path)

		manager.ui:UIEventEnabled(false)
		manager.windowBar:HideBar()
		self:PlayCookAnimator(var_8_0, function()
			self:WaitServer()
		end)
	end)

	for iter_5_2 = 1, 6 do
		self:AddDragListener(self["materialBtn" .. iter_5_2 .. "_"].gameObject, function()
			self:StopGuideTimer()

			self.curDragMaterialID_ = self.materialList_[iter_5_2]

			SetActive(self.dargImage_.gameObject, true)

			self.dargImage_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[self.curDragMaterialID_].icon_path)
		end, function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
			self.dargImage_.transform.localPosition = Vector3.New(self["materialBtn" .. iter_5_2 .. "_"].transform.localPosition.x + -arg_11_0, self["materialBtn" .. iter_5_2 .. "_"].transform.localPosition.y + -arg_11_1, 0)
		end, function(arg_12_0, arg_12_1, arg_12_2)
			if self.curDragMaterialID_ == 0 then
				return
			end

			local var_12_0 = self["materialBtn" .. iter_5_2 .. "_"].transform.localPosition.y - arg_12_1

			for iter_12_0 = 1, self.selectNum_ do
				if math.abs(self["selectIndexBtn" .. iter_12_0 .. "_"].transform.localPosition.x - (self["materialBtn" .. iter_5_2 .. "_"].transform.localPosition.x - arg_12_0)) < 100 and math.abs(self["selectIndexBtn" .. iter_12_0 .. "_"].transform.localPosition.y - var_12_0) < 100 then
					self.curSelectList_[iter_12_0] = self.curDragMaterialID_

					self["selectController" .. iter_12_0 .. "_"]:SetSelectedState("on")

					self["selectImage" .. iter_12_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[self.curSelectList_[iter_12_0]].icon_path)

					self:RefreshCookBtn()
				end
			end

			SetActive(self.dargImage_.gameObject, false)

			self.curDragMaterialID_ = 0
		end)
	end
end

function ActivityAutoCookPlayView:OnEnter()
	self.activityID_ = ActivityConst.AUTO_COOK
	self.battleHeroID_ = self.params_.battleHeroID
	self.activityStageID_ = self.params_.activityStageID
	self.stageCfg_ = ActivityAutoCookStageCfg[self.activityStageID_]
	self.materialList_ = self.stageCfg_.material_list
	self.isWin_ = false
	self.startPlayTimeStep_ = manager.time:GetServerTime()
	self.serverCount_ = 0
	self.faildCount_ = 0
	self.materialHistoryList_ = {}
	self.foodHistoryList_ = {}

	self.heroController_:SetSelectedState(self.battleHeroID_)

	self.heroSpine_ = self["hero" .. self.battleHeroID_ .. "Spine_"]
	self.selectNum_ = #ActivityAutoCookFoodCfg[self.stageCfg_.food].recipe

	if self.selectNum_ == 3 then
		self.numController_:SetSelectedState("three")
	elseif self.selectNum_ == 4 then
		self.numController_:SetSelectedState("four")
	end

	self:RefreshUI()
	self.bubbleAnimator_:Play("in", 0, 0)
	self.bubbleAnimator_:Update(0)

	self.desText_.text = self.stageCfg_.first_challenge_tips

	self:ReSetGame()

	self.timer_ = Timer.New(function()
		self:PlayGuideAni_()
	end, 5, -1)

	self.timer_:Start()
end

function ActivityAutoCookPlayView:RefreshCookBtn()
	for iter_15_0 = 1, self.selectNum_ do
		if self.curSelectList_[iter_15_0] == nil then
			self.cookBtnController_:SetSelectedState("false")

			return
		end
	end

	self.cookBtnController_:SetSelectedState("true")
end

function ActivityAutoCookPlayView:PlayGuideAni_()
	self.guideAni_:Play("CookingUI_guide")
end

function ActivityAutoCookPlayView:ReSetGame()
	self.statusController_:SetSelectedState("cooking")

	self.curFoodID_ = 0
	self.curSelectList_ = {}

	for iter_17_0 = 1, self.selectNum_ do
		self["selectController" .. iter_17_0 .. "_"]:SetSelectedState("off")
	end
end

function ActivityAutoCookPlayView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function ActivityAutoCookPlayView:RefreshUI()
	for iter_19_0, iter_19_1 in pairs(self.materialList_) do
		self["materialImage" .. iter_19_0 .. "_"].sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_IdleCanteen/FoodIngredient/" .. ActivityAutoCookMaterialCfg[iter_19_1].icon_path)
	end

	self:RefreshCookBtn()
	SetActive(self.dargImage_.gameObject, false)

	self.curDragMaterialID_ = 0

	self.heroSpine_.AnimationState:SetAnimation(0, "idle", true)
end

function ActivityAutoCookPlayView:RefreshCookState()
	self.serverCount_ = self.serverCount_ + 1

	table.insert(self.materialHistoryList_, (deepClone(self.curSelectList_)))
	table.insert(self.foodHistoryList_, self.curFoodID_)

	self.cookState_ = self.curFoodID_ == self.stageCfg_.food and ActivityAutoCookPlayView.SUCCESS or ActivityAutoCookFoodCfg[self.curFoodID_].type == 1 and ActivityAutoCookPlayView.DARKNESS or ActivityAutoCookPlayView.FAIL
end

function ActivityAutoCookPlayView:WaitServer()
	self.statusController_:SetSelectedState("serve")

	if self.cookState_ == ActivityAutoCookPlayView.SUCCESS then
		self.resultController_:SetSelectedState("correct")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done03", "")
	elseif self.cookState_ == ActivityAutoCookPlayView.DARKNESS then
		self.resultController_:SetSelectedState("darkness")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done02", "")
	else
		self.resultController_:SetSelectedState("fault")
		manager.audio:PlayEffect("minigame_activity_3_10", "minigame_activity_3_10_cook_done01", "")
	end

	self:ServerFood()
end

function ActivityAutoCookPlayView:StartEat()
	self:StopEatTimer()

	self.eatTimer_ = Timer.New(function()
		self:StopEatTimer()
	end, 2, 1)

	self.eatTimer_:Start()
end

function ActivityAutoCookPlayView:StopEatTimer()
	if self.eatTimer_ then
		self.eatTimer_:Stop()

		self.eatTimer_ = nil
	end
end

function ActivityAutoCookPlayView:ServerFood()
	if self.cookState_ == ActivityAutoCookPlayView.SUCCESS then
		self.bubbleController_:SetSelectedState("like")

		self.isWin_ = true

		local var_25_0 = manager.time:GetServerTime() - self.startPlayTimeStep_
		local var_25_1 = {}

		for iter_25_0, iter_25_1 in pairs(self.materialHistoryList_) do
			table.insert(var_25_1, (string.format("[%s]", table.concat(iter_25_1, ","))))
		end

		local var_25_2 = string.format("[%s]", table.concat(var_25_1, ","))
		local var_25_3 = string.format("[%s]", table.concat(self.foodHistoryList_, ","))

		ActivityAutoCookAction:AutoCookStageFinish(self.activityStageID_, self.battleHeroID_, function()
			SDKTools.SendMessageToSDK("activity_combat_over", {
				result = 1,
				activity_id = self.activityID_,
				stage_id = self.activityStageID_,
				use_seconds = var_25_0,
				battle_times = self.serverCount_,
				cost_item_list = var_25_2,
				params_list = var_25_3
			})
		end)
		self.heroSpine_.AnimationState:SetAnimation(0, "kaixin", true)
		self:TalkWithTimer(self.stageCfg_.success_tips, function()
			self.bubbleController_:SetSelectedState("normal")
			manager.ui:UIEventEnabled(true)
			manager.windowBar:SwitchBar({
				BACK_BAR
			})
			JumpTools.Back()
		end)
	else
		self.heroSpine_.AnimationState:SetAnimation(0, "ganga", true)

		if self.cookState_ == ActivityAutoCookPlayView.DARKNESS then
			self.bubbleController_:SetSelectedState("unlike")
			self:TalkWithTimer(self.stageCfg_.dark_food_tips, function()
				self.bubbleController_:SetSelectedState("normal")
				self:CookTips()
				self:ReSetGame()
				manager.ui:UIEventEnabled(true)
				manager.windowBar:SwitchBar({
					BACK_BAR
				})
			end)
		else
			self:TalkWithTimer(self.stageCfg_.fail_tips, function()
				self.bubbleController_:SetSelectedState("normal")
				self:CookTips()
				self:ReSetGame()
				manager.ui:UIEventEnabled(true)
				manager.windowBar:SwitchBar({
					BACK_BAR
				})
			end)
		end
	end
end

function ActivityAutoCookPlayView:CookTips()
	self.bubbleAnimator_:Play("in", 0, 0)
	self.bubbleAnimator_:Update(0)
	self.bubbleController_:SetSelectedState("normal")

	self.desText_.text = self.faildCount_ == 0 and self.stageCfg_.simple_challenge_tips or self.stageCfg_.challenge_tips
	self.faildCount_ = self.faildCount_ + 1

	self.heroSpine_.AnimationState:SetAnimation(0, "idle", true)
end

function ActivityAutoCookPlayView:PlayCookAnimator(arg_31_1, arg_31_2)
	self.cookingAnimator_:Play(arg_31_1, 0, 0)
	self.bubbleAnimator_:Play("out", 0, 0)

	self.cookTimer_ = FrameTimer.New(function()
		if self.cookingAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			self:StopCookAnimator()
			arg_31_2()
		end
	end, 1, -1)

	self.cookTimer_:Start()
end

function ActivityAutoCookPlayView:StopCookAnimator()
	if self.cookTimer_ then
		self.cookTimer_:Stop()

		self.cookTimer_ = nil
	end
end

function ActivityAutoCookPlayView:TalkWithTimer(arg_34_1, arg_34_2)
	if self.talkTimer_ ~= nil then
		self:StopTimer()
	end

	self.desText_.text = arg_34_1

	self.bubbleAnimator_:Play("in", 0, 0)
	self.bubbleAnimator_:Update(0)

	self.talkTimer_ = Timer.New(function()
		if arg_34_2 then
			arg_34_2()
		end
	end, 4, 1)

	self.talkTimer_:Start()
end

function ActivityAutoCookPlayView:StopTimer()
	if self.talkTimer_ then
		self.talkTimer_:Stop()

		self.talkTimer_ = nil
	end
end

function ActivityAutoCookPlayView:StopGuideTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityAutoCookPlayView:OnExit()
	manager.windowBar:HideBar()

	if not self.isWin_ then
		local var_38_0 = {}

		for iter_38_0, iter_38_1 in pairs(self.materialHistoryList_) do
			table.insert(var_38_0, (string.format("[%s]", table.concat(iter_38_1, ","))))
		end

		SDKTools.SendMessageToSDK("activity_combat_over", {
			result = 3,
			activity_id = self.activityID_,
			stage_id = self.activityStageID_,
			use_seconds = manager.time:GetServerTime() - self.startPlayTimeStep_,
			battle_times = self.serverCount_,
			cost_item_list = string.format("[%s]", table.concat(var_38_0, ",")),
			params_list = string.format("[%s]", table.concat(self.foodHistoryList_, ","))
		})
	end

	self:StopTimer()
	self:StopGuideTimer()
	self:StopEatTimer()
	self:StopCookAnimator()
end

function ActivityAutoCookPlayView:Dispose()
	self:StopTimer()
	self:StopGuideTimer()
	self.super.Dispose(self)
end

return ActivityAutoCookPlayView
