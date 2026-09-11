local ActivityGodEaterGameMainView = class("ActivityGodEaterGameMainView", ReduxView)

function ActivityGodEaterGameMainView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Main/V4_2_GodEaterUI_MainUI"
end

function ActivityGodEaterGameMainView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityGodEaterGameMainView:Init()
	self:InitUI()
	self:InitBtnCfg()
	self:AddUIListeners()
end

function ActivityGodEaterGameMainView:InitUI()
	self:BindCfgUI()

	self.giftController_ = self.giftControllerEx_:GetController("gift")
	self.isMaxLevelController_ = self.sliderCon_:GetController("isMaxlv")
end

function ActivityGodEaterGameMainView:OnEnter()
	if self.params_ then
		self.activity_id = self.params_activity_id or ActivityConst.ACTIVITY_GODEATER_MAIN_KEY
	end

	self:RegistEventListener(ACTIVITY_GODEATER_LV_INFO, function()
		self:RefreshUI()
	end)
	self:ResetAnimation()

	if GodEaterData:GetHeroGiftIsGet(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_GODEATER_HERO_GIFT][1]) then
		self.giftController_:SetSelectedState("received")
	else
		self.giftController_:SetSelectedState("receive")
	end

	for iter_5_0, iter_5_1 in pairs(self.btnCfg) do
		if iter_5_1 and iter_5_1.redPointKey ~= "" then
			manager.redPoint:bindUIandKey(self[iter_5_1.key].transform, iter_5_1.redPointKey)
		end
	end

	manager.redPoint:bindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HUB_REWARD_ALL)
	manager.redPoint:bindUIandKey(self.giftBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HERO_GIFT)
	GodEaterData:UpdateHudLevel()
end

function ActivityGodEaterGameMainView:ResetAnimation()
	self.root_doorAni_:Play("idle", 0, 0)

	self.isAnimation = false
end

function ActivityGodEaterGameMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_1")
	self:RefreshUI()
	self:UpdateBtn()
	self:ResetAnimation()

	if GodEaterData:GetHeroGiftIsGet(ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_GODEATER_HERO_GIFT][1]) then
		self.giftController_:SetSelectedState("received")
	else
		self.giftController_:SetSelectedState("receive")
	end
end

function ActivityGodEaterGameMainView:RefreshUI()
	local var_9_0, var_9_1, var_9_2 = GodEaterTool.HubExpToLevel(GodEaterData.totalExp)

	self.lvtextText_.text = var_9_0
	self.processText_.text = string.format(GetTips("GODEATER_DES_1"), var_9_1, var_9_2)

	if var_9_2 <= var_9_1 then
		self.processText_.text = GetTips("TEXT_LEVEL_MAX")

		self.isMaxLevelController_:SetSelectedState("true")
	else
		self.isMaxLevelController_:SetSelectedState("false")
	end

	self.slider_yellowTrs_.localScale = Vector3.New(var_9_2 == 0 and 1 or var_9_1 / var_9_2, 1, 1)
	self.iconImg_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP)

	if not self.lastLv then
		-- block empty
	elseif self.lastLv ~= var_9_0 then
		JumpTools.OpenPageByJump("ActivityGodEaterLvUpView", {
			lastlV = self.lastLv,
			nowlV = var_9_0
		})
	end

	self.lastLv = var_9_0
end

function ActivityGodEaterGameMainView:InitBtnCfg()
	self.btnCfg = {
		{
			router = "/goldMinerSelectLevelView",
			key = "button1Btn_",
			activityID = ActivityConst.ACTIVITY_GOLDMINER,
			param_ = {
				activityID = ActivityConst.ACTIVITY_GOLDMINER
			},
			animation = {
				self.root_doorAni_,
				"Door_open"
			},
			redPointKey = RedPointConst.ACTIVITY_GODEATER_GOLD_MINER_STAGE
		},
		{
			controller = "namebg02Controllerexcollection_",
			router = "/civilizationGameMainView",
			key = "button2Btn_",
			activityID = ActivityConst.ACTIVITY_CIVILIZATION,
			animation = {
				self.root_doorAni_,
				"Root_left"
			},
			redPointKey = RedPointConst.ACTIVITY_CODEATER_CIVILIZATION,
			condition = function()
				return GameSetting.godeater_subactivity_unlock1.value[1] <= GodEaterData.hubLv
			end,
			lockTips = string.format(GetTips("GODEATER_DES_5"), GameSetting.godeater_subactivity_unlock1.value[1])
		},
		{
			router = "/ActivityGodEaterGameTaskView",
			key = "button3Btn_",
			activityID = 0,
			animation = {
				self.root_doorAni_,
				"Root_desk"
			},
			redPointKey = RedPointConst.ACTIVITY_GODEATER_TASK_REWARD_ALL,
			condition = function()
				return ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY)
			end,
			lockTips = GetTips("TIME_OVER")
		},
		{
			router = "/eatGodBattleEnterView",
			key = "button4Btn_",
			activityID = 0,
			animation = {
				self.root_doorAni_,
				"Root_right"
			},
			redPointKey = RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE
		}
	}
end

function ActivityGodEaterGameMainView:AddUIListeners()
	self:AddBtnListener(self.taskBtn_, nil, function()
		return
	end)

	for iter_13_0, iter_13_1 in pairs(self.btnCfg) do
		local var_13_0 = iter_13_1.router
		local var_13_1 = iter_13_1.param_
		local var_13_2 = iter_13_1.animation
		local var_13_3 = iter_13_1.condition
		local var_13_4 = iter_13_1.lockTips

		self:AddBtnListener(self[iter_13_1.key], nil, function(arg_15_0)
			if self.isAnimation then
				return
			end

			if var_13_3 and not var_13_3() or false then
				ShowTips(var_13_4)

				return
			end

			self.isAnimation = true

			if var_13_2 then
				AnimatorTools.PlayAnimationWithCallback(var_13_2[1], var_13_2[2], function()
					JumpTools.OpenPageByJump(var_13_0, var_13_1)
				end)
			else
				JumpTools.OpenPageByJump(var_13_0, var_13_1)
			end
		end)
	end

	self:AddBtnListener(self.shopBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_MAIN_KEY) then
			ShowTips(GetTips("TIME_OVER"))

			return
		end

		JumpTools.GoToSystem("/activityShop", {
			shopId = ShopConst.SHOP_ID.GODEARTER_SHOP_1,
			showShops = {
				ShopConst.SHOP_ID.GODEARTER_SHOP_1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.giftBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_HERO_GIFT) then
			JumpTools.OpenPageByJump("activityGodEaterGiftPopView")
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function ActivityGodEaterGameMainView:UpdateBtn()
	for iter_19_0, iter_19_1 in pairs(self.btnCfg) do
		local var_19_2 = iter_19_1.controller
		local var_19_4 = iter_19_1.condition

		if activityID and activityID ~= 0 then
			SetActive(self[iter_19_1.key].gameObject, ActivityData:GetActivityIsOpen(activityID))
		end

		if var_19_2 and var_19_4 then
			self[var_19_2]:GetController("unlock"):SetSelectedState(var_19_4() and "true" or "false")
		end
	end
end

function ActivityGodEaterGameMainView:OnBehind()
	manager.windowBar:HideBar()
end

function ActivityGodEaterGameMainView:OnExit()
	ActivityGodEaterGameMainView.super.OnExit(self)
	manager.windowBar:HideBar()
	self:StopTimer()
	self:RemoveTween()
	manager.redPoint:unbindUIandKey(self.taskBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HUB_REWARD_ALL)
	manager.redPoint:unbindUIandKey(self.giftBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HERO_GIFT)

	for iter_21_0, iter_21_1 in pairs(self.btnCfg) do
		if iter_21_1 and iter_21_1.redPointKey ~= "" then
			manager.redPoint:unbindUIandKey(self[iter_21_1.key].transform, iter_21_1.redPointKey)
		end
	end
end

function ActivityGodEaterGameMainView:RemoveTween()
	return
end

function ActivityGodEaterGameMainView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function ActivityGodEaterGameMainView:Dispose()
	ActivityGodEaterGameMainView.super.Dispose(self)
end

return ActivityGodEaterGameMainView
