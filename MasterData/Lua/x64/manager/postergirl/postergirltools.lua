local var_0_0 = {}

function var_0_0.GetLoadLightEffect(arg_1_0, arg_1_1)
	local var_1_0 = HomeSceneSettingCfg[manager.posterGirl:GetCurScene()]

	if var_1_0 and type(var_1_0.light_effect) == "table" then
		return true, var_1_0.light_effect[arg_1_1 + 1], (var_0_0.GetEffectLightChangeTime(arg_1_0 + 1, arg_1_1 + 1))
	else
		return false
	end
end

function var_0_0.GetEffectLightChangeTime(arg_2_0, arg_2_1)
	local var_2_0 = HomeSceneSettingCfg[manager.posterGirl:GetCurScene()]

	if var_2_0 and var_2_0.light_effect_delay and type(var_2_0.light_effect_delay) == "table" then
		return var_2_0.light_effect_delay[arg_2_0][arg_2_1]
	end
end

function var_0_0.ProduceCommonState(arg_3_0, arg_3_1)
	if PosterGirlConst.StateKay.init == arg_3_0 then
		return PosterCommonInitState.New(arg_3_1)
	elseif PosterGirlConst.StateKay.init_no_blend == arg_3_0 then
		return PosterCommonInitState.New(arg_3_1, true)
	elseif PosterGirlConst.StateKay.idle == arg_3_0 then
		return PosterCommonInteractionState.New(arg_3_1, PosterGirlConst.InteractionKey.idle)
	elseif PosterGirlConst.StateKay.shake == arg_3_0 then
		return PosterCommonInteractionState.New(arg_3_1, PosterGirlConst.InteractionKey.shaking)
	elseif PosterGirlConst.StateKay.touch == arg_3_0 then
		return PosterCommonInteractionState.New(arg_3_1, PosterGirlConst.InteractionKey.mainTouch)
	elseif PosterGirlConst.StateKay.quickclick == arg_3_0 then
		return PosterCommonInteractionState.New(arg_3_1, PosterGirlConst.InteractionKey.mainQuickTouch)
	elseif PosterGirlConst.StateKay.show == arg_3_0 then
		return PosterCommonInteractionState.New(arg_3_1, PosterGirlConst.InteractionKey.showing)
	elseif PosterGirlConst.StateKay.greet == arg_3_0 then
		return PosterCommonGreetingState.New(arg_3_1)
	elseif PosterGirlConst.StateKay.custom == arg_3_0 then
		return PosterCommonCustomState.New(arg_3_1)
	end
end

function var_0_0:DlcStateShouldCache()
	if self then
		if type(self) == "table" then
			local var_4_0 = self.class or self

			if var_4_0.GetInstance or var_4_0.New then
				return var_4_0.__cname
			else
				return nil
			end
		end

		return self
	end
end

function var_0_0:ProduceDlcState(arg_5_1, arg_5_2)
	if PosterGirlConst.StateKay.init == self then
		return PosterDlcInitState.New(arg_5_1)
	elseif PosterGirlConst.StateKay.init_spec == self then
		return PosterDlcInitSpecState.New(arg_5_1)
	elseif PosterGirlConst.StateKay.init_no_blend == self then
		return PosterDlcInitNoblendState.New(arg_5_1)
	elseif PosterGirlConst.StateKay.idle == self then
		return PosterDlcIdleState.New(arg_5_1)
	elseif PosterGirlConst.StateKay.idle == self then
		return PosterDlcIdleState.New(arg_5_1)
	elseif PosterGirlConst.StateKay.shake == self then
		return PosterDlcInteractionState.New(arg_5_1, PosterGirlConst.InteractionKey.shaking)
	elseif PosterGirlConst.StateKay.touch == self then
		return PosterDlcTouchState.New(arg_5_1)
	elseif PosterGirlConst.StateKay.quickclick == self then
		return PosterDlcInteractionState.New(arg_5_1, PosterGirlConst.InteractionKey.mainQuickTouch)
	elseif PosterGirlConst.StateKay.show == self then
		return PosterDlcInteractionState.New(arg_5_1, PosterGirlConst.InteractionKey.showing)
	elseif PosterGirlConst.StateKay.mid2left == self then
		return PosterDlcSwipeState.New(arg_5_1, PosterGirlConst.ViewDirect.center, PosterGirlConst.ViewDirect.left)
	elseif PosterGirlConst.StateKay.mid2right == self then
		return PosterDlcSwipeState.New(arg_5_1, PosterGirlConst.ViewDirect.center, PosterGirlConst.ViewDirect.right)
	elseif PosterGirlConst.StateKay.left2mid == self then
		return PosterDlcSwipeState.New(arg_5_1, PosterGirlConst.ViewDirect.left, PosterGirlConst.ViewDirect.center)
	elseif PosterGirlConst.StateKay.right2mid == self then
		return PosterDlcSwipeState.New(arg_5_1, PosterGirlConst.ViewDirect.right, PosterGirlConst.ViewDirect.center)
	elseif PosterGirlConst.StateKay.debut == self then
		return PosterDlcDebutState.New(arg_5_1)
	elseif self then
		local var_5_0 = self.class or self
		local var_5_1 = var_5_0.GetInstance or var_5_0.New

		if var_5_1 then
			return var_5_1(arg_5_1)
		end
	end
end

function var_0_0.GetLoadWeatherEffect(arg_6_0)
	return false
end

function var_0_0.HasTimeEffect(arg_7_0, arg_7_1)
	if arg_7_0 == 109502 then
		return CustomCenterTools.IsTimeChangeScene(arg_7_1)
	end

	return false
end

function var_0_0.SceneHasTimeEffect(arg_8_0)
	return CustomCenterTools.IsTimeChangeScene(arg_8_0)
end

function var_0_0.HasWeatherEffect(arg_9_0, arg_9_1)
	return false
end

function var_0_0.IsSkinSceneTzeroMode(arg_10_0, arg_10_1)
	if next((CustomCenterTools.GetSkinSceneCfg(arg_10_0, arg_10_1))) then
		return true
	end

	return false
end

function var_0_0.IsStateOpenDrag(arg_11_0)
	if arg_11_0 == PosterGirlConst.StateKay.danceGame then
		return true
	end
end

function var_0_0.IsLoopSwitch(arg_12_0)
	return HomeSceneSettingCfg[arg_12_0].can_loop_switch_camera and HomeSceneSettingCfg[arg_12_0].can_loop_switch_camera == 1 or false
end

function var_0_0.IsInterruptCurAni(arg_13_0)
	return HomeSceneSettingCfg[arg_13_0].can_interrupt_current_anim_switch_camera and HomeSceneSettingCfg[arg_13_0].can_interrupt_current_anim_switch_camera == 1 or false
end

function var_0_0.GetSceneChangeViewType(arg_14_0)
	return HomeSceneSettingCfg[arg_14_0].change_view_type
end

function var_0_0.GetSceneCamCnt(arg_15_0)
	if HomeSceneSettingCfg[arg_15_0].camera_views == "" then
		return 1
	end

	return #HomeSceneSettingCfg[arg_15_0].camera_views
end

local var_0_1 = {
	PosterGirlConst.ViewDirect.center
}

function var_0_0.GetSceneCamViews(arg_16_0)
	if HomeSceneSettingCfg[arg_16_0].camera_views == "" then
		return var_0_1
	end

	return HomeSceneSettingCfg[arg_16_0].camera_views
end

function var_0_0.CanInterruptCurAni()
	if manager.posterGirl.actor then
		if manager.posterGirl.actor:CheckInitState() or PosterGirlTools.IsInterruptCurAni((HomeSceneSettingData:GetCurScene())) then
			return true
		end
	end

	return false
end

function var_0_0.ShowPureMode()
	manager.notify:Invoke(PUREMODE_SHOW)
end

function var_0_0.UpdateDlCBtnRed()
	if getData("GAMESETTING", "DLC_BTN") == 1 then
		manager.redPoint:setTip(RedPointConst.DLC_BTN_RED, 0)
	else
		manager.redPoint:setTip(RedPointConst.DLC_BTN_RED, 1)
	end
end

function var_0_0.ShouldMuteHomePosterTalk()
	return gameContext:IsOpenRoute("momoTalkMainView") ~= nil
end

function var_0_0:ActorRandomIndexOfInteractionType(arg_21_1, arg_21_2)
	local var_21_0 = SkinCfg[self:GetSkinId()].hero
	local var_21_1 = self:GetInteractionCfg()
	local var_21_2 = arg_21_2 or 0
	local var_21_3 = {}
	local var_21_4 = {}

	if not var_21_1 then
		error("RandomIndexOfInteractionType error")

		return 1
	end

	for iter_21_0, iter_21_1 in ipairs(var_21_1[arg_21_1 .. "_talk"]) do
		if iter_21_0 ~= var_21_2 then
			table.insert(var_21_3, iter_21_1)
			table.insert(var_21_4, iter_21_0)
		end
	end

	local var_21_5 = 1

	if var_21_1[arg_21_1 .. "_weight"] and #var_21_1[arg_21_1 .. "_weight"] > 0 then
		local var_21_6 = 0

		for iter_21_2, iter_21_3 in ipairs(var_21_4) do
			var_21_6 = var_21_6 + var_21_1[arg_21_1 .. "_weight"][iter_21_3]
		end

		local var_21_7 = math.round(math.random(var_21_6))

		for iter_21_4, iter_21_5 in ipairs(var_21_4) do
			if var_21_7 <= var_21_1[arg_21_1 .. "_weight"][iter_21_5] then
				var_21_5 = iter_21_4

				break
			else
				var_21_7 = var_21_7 - var_21_1[arg_21_1 .. "_weight"][iter_21_5]
			end
		end
	else
		var_21_5 = math.round(math.random(#var_21_4))
	end

	return var_21_4[var_21_5]
end

return var_0_0
