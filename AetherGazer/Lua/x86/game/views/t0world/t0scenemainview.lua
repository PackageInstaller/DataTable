local var_0_0 = class("T0SceneMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return T0WorldTools.GetMainUiView()
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:InitCapture()
	arg_3_0:InitModules()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()

	arg_4_0.captureModelController_ = arg_4_0.controller_:GetController("captureMode")
	arg_4_0.voiceContent = T0VoiceContent.New(arg_4_0.voiceContentGo_)

	if arg_4_0.chatOptionsContentGo_ then
		arg_4_0.chatOptionsContent = T0ChatOptionsContent.New(arg_4_0.chatOptionsContentGo_)
	end
end

function var_0_0.InitModules(arg_5_0)
	arg_5_0.modules = {}

	if T0WorldMgr:GetSceneID() == 3 then
		arg_5_0.bandLiveModule = arg_5_0:AddModule("Widget/System/Main_T0SceneGame/104402/104402_StageUI", T0StageContent).inst
	end
end

function var_0_0.AddListeners(arg_6_0)
	if arg_6_0.bandSoundSetBtn_ then
		arg_6_0:AddBtnListener(arg_6_0.bandSoundSetBtn_, nil, function()
			gameContext:Go("t0SceneSoundSetting")
		end)
	end

	if arg_6_0.bandLivePanelBtn_ then
		arg_6_0:AddBtnListener(arg_6_0.bandLivePanelBtn_, nil, function()
			arg_6_0.bandLiveModule:Toggle()
		end)
	end
end

function var_0_0.AddEventListeners(arg_9_0)
	arg_9_0:RegistEventListener(T0_WORLD_SHOW_CAPTIONS, handler(arg_9_0, arg_9_0.OnShowCaptions))
	arg_9_0:RegistEventListener(T0_WORLD_START_TALK, handler(arg_9_0, arg_9_0.OnStartTalk))
	arg_9_0:RegistEventListener(T0_WORLD_CHANGE_CONTROLLER_MODE, handler(arg_9_0, arg_9_0.OnChangeControllerModeListener))
	arg_9_0:RegistEventListener(T0_WORLD_SHOW_CHAT_OPTIONS, handler(arg_9_0, arg_9_0.OnShowChatOptions))
	arg_9_0:RegistEventListener(T0_WORLD_PUSH_SUBTITLE, handler(arg_9_0, arg_9_0.OnPushSubtitle))
	arg_9_0:RegistEventListener(T0_WORLD_SHOW_EFFECT, handler(arg_9_0, arg_9_0.OnShowEffect))
	arg_9_0:RegistEventListener(T0_WORLD_SET_HELP_KEY, handler(arg_9_0, arg_9_0.OnSetHelpKey))
end

function var_0_0.OnSetHelpKey(arg_10_0, arg_10_1)
	arg_10_0.helpKey = arg_10_1
end

function var_0_0.OnStartTalk(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0.voiceContent:OnStartTalk(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
end

function var_0_0.OnShowCaptions(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 then
		arg_12_0.voiceContent:CompelHide()
	else
		arg_12_0.voiceContent:OnShowTipsKey(arg_12_2)
	end
end

function var_0_0.OnPushSubtitle(arg_13_0, arg_13_1)
	arg_13_0.voiceContent:PushSubtitle(arg_13_1)
end

function var_0_0.OnChangeControllerModeListener(arg_14_0, arg_14_1)
	arg_14_0.modeState = arg_14_1

	if arg_14_1 == T0WorldMgr.CaptureModeStateEnum.photo then
		arg_14_0:RefreshPhotoBar()
	elseif arg_14_1 == T0WorldMgr.CaptureModeStateEnum.normal then
		arg_14_0:RefreshNormalBar()
	end
end

function var_0_0.OnShowChatOptions(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if not arg_15_0.chatOptionsContent then
		return
	end

	if arg_15_1 then
		arg_15_0.chatOptionsContent:AddOptionsBubble(arg_15_2, arg_15_3, icon, arg_15_4, arg_15_5)
	else
		arg_15_0.chatOptionsContent:RemoveOptionsBubble(arg_15_2)
	end
end

function var_0_0.OnShowEffect(arg_16_0, arg_16_1)
	arg_16_1.transform:SetParent(arg_16_0.effectContentGo_.transform, false)
end

function var_0_0.OnEnter(arg_17_0)
	CursorTools.LuaSwitchCursor(false)
	arg_17_0:AddEventListeners()
	arg_17_0:EnterCaptrue()
	arg_17_0.voiceContent:OnEnter()

	if not getData(T0WorldTools.GetT0WorldHelpDataKey(), "showHelp") then
		local var_17_0 = T0WorldTools.GetT0WorldHelpPages()

		CursorTools.LuaSwitchCursor(true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			noCache = true,
			pages = var_17_0,
			exitCallback = function()
				CursorTools.LuaSwitchCursor(false)
			end
		})
		saveData(T0WorldTools.GetT0WorldHelpDataKey(), "showHelp", 1)
	end
end

function var_0_0.OnTop(arg_19_0)
	if arg_19_0.modeState and arg_19_0.modeState == T0WorldMgr.CaptureModeStateEnum.photo then
		arg_19_0:RefreshPhotoBar()
	else
		arg_19_0:RefreshNormalBar()
	end
end

function var_0_0.RefreshPhotoBar(arg_20_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		T0WorldLuaBridge.EnterChapterMode(false)
	end)
end

function var_0_0.RefreshNormalBar(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if T0WorldLuaBridge.CheckIsHaveExitEventAndDo() then
			return
		end

		ShowMessageBox({
			content = GetTips("T0_WORLD_HORUS_TIPS_17"),
			OkCallback = function()
				ExitT0WorldScene()
			end
		})
	end)

	local var_22_0 = T0WorldTools.GetT0WorldHelpPages()

	manager.windowBar:RegistInfoCallBack(function()
		CursorTools.LuaSwitchCursor(true)

		if arg_22_0.helpKey then
			var_22_0 = GameSetting[arg_22_0.helpKey] and GameSetting[arg_22_0.helpKey].value or {}
		end

		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			noCache = true,
			pages = var_22_0,
			exitCallback = function()
				CursorTools.LuaSwitchCursor(false)
			end
		})
	end)
end

function var_0_0.OnExit(arg_27_0)
	CursorTools.LuaSwitchCursor(true)
	arg_27_0.voiceContent:OnExit()
	arg_27_0:ExitCapture()
	manager.windowBar:HideBar()
	arg_27_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_28_0)
	arg_28_0.voiceContent:Dispose()

	if arg_28_0.chatOptionsContent then
		arg_28_0.chatOptionsContent:Dispose()
	end

	arg_28_0:DisposeCapture()

	if arg_28_0.modules then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.modules) do
			if iter_28_1.inst then
				iter_28_1.inst:Dispose()
			end

			Object.Destroy(iter_28_1.obj)
		end

		arg_28_0.modules = nil
	end

	arg_28_0.super.Dispose(arg_28_0)
end

function var_0_0.AddModule(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = Asset.Load(arg_29_1)
	local var_29_1 = Object.Instantiate(var_29_0, arg_29_0.moduleRoot_)
	local var_29_2 = {
		obj = var_29_1
	}

	table.insert(arg_29_0.modules, var_29_2)

	if arg_29_2 then
		var_29_2.inst = arg_29_2.New(var_29_1)
	end

	return var_29_2
end

return var_0_0
