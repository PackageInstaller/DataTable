local var_0_0 = class("ActivityGodEaterGameMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Main/V4_2_GodEaterUI_MainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:InitBtnCfg()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.giftController_ = arg_4_0.giftControllerEx_:GetController("gift")
	arg_4_0.isMaxLevelController_ = arg_4_0.sliderCon_:GetController("isMaxlv")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.activity_id = arg_5_0.params_ and arg_5_0.params_activity_id or ActivityConst.ACTIVITY_GODEATER_MAIN_KEY

	arg_5_0:RegistEventListener(ACTIVITY_GODEATER_LV_INFO, function()
		arg_5_0:RefreshUI()
	end)
	arg_5_0:ResetAnimation()

	local var_5_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_GODEATER_HERO_GIFT][1]

	if GodEaterData:GetHeroGiftIsGet(var_5_0) then
		arg_5_0.giftController_:SetSelectedState("received")
	else
		arg_5_0.giftController_:SetSelectedState("receive")
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0.btnCfg) do
		local var_5_1 = iter_5_1.router
		local var_5_2 = iter_5_1.param_
		local var_5_3 = iter_5_1.animation

		if iter_5_1 and iter_5_1.redPointKey ~= "" then
			manager.redPoint:bindUIandKey(arg_5_0[iter_5_1.key].transform, iter_5_1.redPointKey)
		end
	end

	manager.redPoint:bindUIandKey(arg_5_0.taskBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HUB_REWARD_ALL)
	manager.redPoint:bindUIandKey(arg_5_0.giftBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HERO_GIFT)
	GodEaterData:UpdateHudLevel()
end

function var_0_0.ResetAnimation(arg_7_0)
	arg_7_0.root_doorAni_:Play("idle", 0, 0)

	arg_7_0.isAnimation = false
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("GOD_EATER_GAME_TIPS_1")
	arg_8_0:RefreshUI()
	arg_8_0:UpdateBtn()
	arg_8_0:ResetAnimation()

	local var_8_0 = ActivityPointRewardCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_GODEATER_HERO_GIFT][1]

	if GodEaterData:GetHeroGiftIsGet(var_8_0) then
		arg_8_0.giftController_:SetSelectedState("received")
	else
		arg_8_0.giftController_:SetSelectedState("receive")
	end
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0, var_9_1, var_9_2 = GodEaterTool.HubExpToLevel(GodEaterData.totalExp)

	arg_9_0.lvtextText_.text = var_9_0
	arg_9_0.processText_.text = string.format(GetTips("GODEATER_DES_1"), var_9_1, var_9_2)

	if var_9_2 <= var_9_1 then
		arg_9_0.processText_.text = GetTips("TEXT_LEVEL_MAX")

		arg_9_0.isMaxLevelController_:SetSelectedState("true")
	else
		arg_9_0.isMaxLevelController_:SetSelectedState("false")
	end

	arg_9_0.slider_yellowTrs_.localScale = Vector3.New(var_9_2 == 0 and 1 or var_9_1 / var_9_2, 1, 1)
	arg_9_0.iconImg_.sprite = ItemTools.getItemLittleSprite(CurrencyConst.ACTIVITY_GOD_EATER_HUB_EXP)

	if not arg_9_0.lastLv then
		-- block empty
	elseif arg_9_0.lastLv ~= var_9_0 then
		JumpTools.OpenPageByJump("ActivityGodEaterLvUpView", {
			lastlV = arg_9_0.lastLv,
			nowlV = var_9_0
		})
	end

	arg_9_0.lastLv = var_9_0
end

function var_0_0.InitBtnCfg(arg_10_0)
	arg_10_0.btnCfg = {
		{
			router = "/goldMinerSelectLevelView",
			key = "button1Btn_",
			activityID = ActivityConst.ACTIVITY_GOLDMINER,
			param_ = {
				activityID = ActivityConst.ACTIVITY_GOLDMINER
			},
			animation = {
				arg_10_0.root_doorAni_,
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
				arg_10_0.root_doorAni_,
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
				arg_10_0.root_doorAni_,
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
				arg_10_0.root_doorAni_,
				"Root_right"
			},
			redPointKey = RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE
		}
	}
end

function var_0_0.AddUIListeners(arg_13_0)
	arg_13_0:AddBtnListener(arg_13_0.taskBtn_, nil, function()
		return
	end)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.btnCfg) do
		local var_13_0 = iter_13_1.router
		local var_13_1 = iter_13_1.param_
		local var_13_2 = iter_13_1.animation
		local var_13_3 = iter_13_1.condition
		local var_13_4 = iter_13_1.lockTips

		arg_13_0:AddBtnListener(arg_13_0[iter_13_1.key], nil, function(arg_15_0)
			if arg_13_0.isAnimation then
				return
			end

			if var_13_3 and not var_13_3() or false then
				ShowTips(var_13_4)

				return
			end

			arg_13_0.isAnimation = true

			if var_13_2 then
				AnimatorTools.PlayAnimationWithCallback(var_13_2[1], var_13_2[2], function()
					JumpTools.OpenPageByJump(var_13_0, var_13_1)
				end)
			else
				JumpTools.OpenPageByJump(var_13_0, var_13_1)
			end
		end)
	end

	arg_13_0:AddBtnListener(arg_13_0.shopBtn_, nil, function()
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
	arg_13_0:AddBtnListener(arg_13_0.giftBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_GODEATER_HERO_GIFT) then
			JumpTools.OpenPageByJump("activityGodEaterGiftPopView")
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function var_0_0.UpdateBtn(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.btnCfg) do
		local var_19_0 = iter_19_1.router
		local var_19_1 = iter_19_1.param_
		local var_19_2 = iter_19_1.controller
		local var_19_3 = iter_19_1.param_
		local var_19_4 = iter_19_1.condition

		if activityID and activityID ~= 0 then
			SetActive(arg_19_0[iter_19_1.key].gameObject, ActivityData:GetActivityIsOpen(activityID))
		end

		if var_19_2 and var_19_4 then
			arg_19_0[var_19_2]:GetController("unlock"):SetSelectedState(var_19_4() and "true" or "false")
		end
	end
end

function var_0_0.OnBehind(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_21_0)
	var_0_0.super.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	arg_21_0:StopTimer()
	arg_21_0:RemoveTween()
	manager.redPoint:unbindUIandKey(arg_21_0.taskBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HUB_REWARD_ALL)
	manager.redPoint:unbindUIandKey(arg_21_0.giftBtn_.transform, RedPointConst.ACTIVITY_GODEATER_HERO_GIFT)

	for iter_21_0, iter_21_1 in pairs(arg_21_0.btnCfg) do
		if iter_21_1 and iter_21_1.redPointKey ~= "" then
			manager.redPoint:unbindUIandKey(arg_21_0[iter_21_1.key].transform, iter_21_1.redPointKey)
		end
	end
end

function var_0_0.RemoveTween(arg_22_0)
	return
end

function var_0_0.StopTimer(arg_23_0)
	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_24_0)
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
