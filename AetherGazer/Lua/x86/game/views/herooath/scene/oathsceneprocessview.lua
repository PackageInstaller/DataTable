local var_0_0 = class("OathSceneProcessView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/OathCaptureView/HeroOathSceneProcessView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.voiceContent = OathVoiceContent.New(arg_3_0.voiceContentGo_)
	arg_3_0.bubbleContent = OathBubbleContent.New(arg_3_0.bubbleContentGo_)
	arg_3_0.conditionContent = OathConditionContent.New(arg_3_0.conditionContentGo_)
	arg_3_0.girlCameraContent = OathGirlCameraContent.New(arg_3_0.btnGirl_)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddBtnListener(arg_4_0.btnSkip_, nil, function()
		SetActive(arg_4_0.btnSkipGo_, false)
		manager.transition:OnlyShowEffect(true, function()
			OathLuaBridge.InvokeSkip()
			arg_4_0:AddSkipBalckTimer()
			HeroTools.StopTalk()
			arg_4_0.voiceContent:HideVoiceContent()
		end)
	end)
end

function var_0_0.DelSkipBalckTimer(arg_7_0)
	if arg_7_0.skipBalckTimer_ then
		arg_7_0.skipBalckTimer_:Stop()

		arg_7_0.skipBalckTimer_ = nil
	end
end

function var_0_0.AddSkipBalckTimer(arg_8_0)
	arg_8_0:DelSkipBalckTimer()

	arg_8_0.skipBalckTimer_ = Timer.New(function()
		manager.transition:OnlyShowEffect(false)
	end, 1)

	arg_8_0.skipBalckTimer_:Start()
end

function var_0_0.DelCostHideTimer(arg_10_0)
	if arg_10_0.costHideTimer_ then
		arg_10_0.costHideTimer_:Stop()

		arg_10_0.costHideTimer_ = nil
	end
end

function var_0_0.AddCostHideTimer(arg_11_0, arg_11_1)
	arg_11_0:DelCostHideTimer()

	arg_11_0.costHideTimer_ = Timer.New(function()
		LuaExchangeHelper.ActionInvoke(arg_11_1)
		SetActive(arg_11_0.costShowGo_, false)
	end, 0.5)

	arg_11_0.costHideTimer_:Start()
end

function var_0_0.AddEventListeners(arg_13_0)
	arg_13_0:RegistEventListener(OATH_SCENE_SHOW_SKIP, handler(arg_13_0, arg_13_0.OnShowSkip))
	arg_13_0:RegistEventListener(OATH_SCENE_SHOW_OATH_CONDITION, handler(arg_13_0, arg_13_0.OnShowOathCondition))
	arg_13_0:RegistEventListener(OATH_SCENE_ADD_BUBBLE, handler(arg_13_0, arg_13_0.OnAddOptionsBubble))
	arg_13_0:RegistEventListener(OATH_SCENE_TALK, handler(arg_13_0, arg_13_0.OnTalk))
	arg_13_0:RegistEventListener(OATH_SCENE_LOAD_MODEL, handler(arg_13_0, arg_13_0.OnLoadModel))
	arg_13_0:RegistEventListener(OATH_SCENE_SHOW_COST, handler(arg_13_0, arg_13_0.OnShowCost))
	arg_13_0:RegistEventListener(OATH_SCENE_ENTER_DRAG, handler(arg_13_0, arg_13_0.OnEnterDragMode))
	arg_13_0:RegistEventListener(OATH_SCENE_LOAD_EFFECT, handler(arg_13_0, arg_13_0.OnLoadEffect))
end

function var_0_0.OnShowSkip(arg_14_0, arg_14_1)
	local var_14_0 = OathToLuaBridge:GetOathHeroID()

	if not OathTools.IsOath(var_14_0) then
		arg_14_1 = false
	end

	SetActive(arg_14_0.btnSkipGo_, arg_14_1)
end

function var_0_0.OnLoadEffect(arg_15_0, arg_15_1)
	arg_15_1.transform:SetParent(arg_15_0.effectContentGo_.transform, false)
end

function var_0_0.OnEnterDragMode(arg_16_0, arg_16_1)
	arg_16_0.btnGirl_:SetActive(not arg_16_1)
end

function var_0_0.OnShowOathCondition(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_2 then
		manager.ui:SetUISeparateRender(false)
		arg_17_0.conditionContent:Show(false)

		return
	end

	local var_17_0 = {
		countDownTimes = arg_17_3,
		finishCallBack = arg_17_1
	}

	manager.ui:SetUISeparateRender(true)
	arg_17_0.conditionContent:RefreshUI(var_17_0)
end

function var_0_0.OnAddOptionsBubble(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	if arg_18_1 then
		arg_18_0.bubbleContent:AddOptionsBubble(arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	else
		arg_18_0.bubbleContent:RemoveOptionsBubble(arg_18_2)
	end
end

function var_0_0.OnTalk(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0.voiceContent:OnTalk(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
end

function var_0_0.OnLoadModel(arg_20_0, arg_20_1)
	arg_20_0.girlCameraContent:LoadModel(arg_20_1)
end

function var_0_0.OnShowCost(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = OathToLuaBridge:GetOathHeroID()
	local var_21_1 = OathTools.IsOath(var_21_0)

	if arg_21_1 and not var_21_1 then
		arg_21_0.costAni_.enabled = false

		SetActive(arg_21_0.costShowGo_, true)

		local var_21_2 = WeddingCfg[var_21_0].ring_id

		arg_21_0.costIcon_.sprite = ItemTools.getItemSprite(var_21_2)

		local var_21_3 = ItemTools.getItemNum(var_21_2)

		if var_21_3 > 1 then
			arg_21_0.costText_.text = string.format("%s/%s", var_21_3, 1)
		else
			arg_21_0.costText_.text = string.format("%s/%s", var_21_3, 1)
		end

		arg_21_0.costName_.text = GetI18NText(ItemCfg[var_21_2].name)
	elseif not var_21_1 then
		local var_21_4 = WeddingCfg[var_21_0].ring_id
		local var_21_5 = ItemTools.getItemNum(var_21_4)

		arg_21_0.costText_.text = string.format("%s/%s", var_21_5 - 1, 1)
		arg_21_0.costAni_.enabled = true

		arg_21_0:AddCostHideTimer(arg_21_2)
	else
		if arg_21_2 then
			LuaExchangeHelper.ActionInvoke(arg_21_2)
		end

		SetActive(arg_21_0.costShowGo_, false)
	end
end

function var_0_0.OnEnter(arg_22_0)
	arg_22_0:AddEventListeners()
end

function var_0_0.OnTop(arg_23_0)
	arg_23_0:RefreshBar()
end

function var_0_0.CameraEnter(arg_24_0)
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function var_0_0.RefreshBar(arg_25_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("SNAKEGAME_GIVE_UP"),
			OkCallback = function()
				arg_25_0:ExitSDK()
				OathToLuaBridge.OathExitScene()
			end
		})
	end)
end

function var_0_0.ExitSDK(arg_28_0)
	SDKTools.SendMessageToSDK("activity_sys_act", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		type = OathConst.OATH_SCENE_ID.EXIT,
		mould_id = isMeetOath and 1 or 2
	})
end

function var_0_0.OnExit(arg_29_0)
	arg_29_0:DelSkipBalckTimer()
	arg_29_0.voiceContent:OnExit()
	arg_29_0.bubbleContent:OnExit()
	arg_29_0.conditionContent:OnExit()
	arg_29_0.girlCameraContent:OnExit()
	manager.windowBar:HideBar()
	arg_29_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_30_0)
	arg_30_0.voiceContent:Dispose()
	arg_30_0.bubbleContent:Dispose()
	arg_30_0.conditionContent:Dispose()
	arg_30_0.girlCameraContent:Dispose()
	arg_30_0.super.Dispose(arg_30_0)
end

return var_0_0
