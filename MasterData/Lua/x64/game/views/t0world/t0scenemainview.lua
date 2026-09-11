local T0SceneMainView = class("T0SceneMainView", ReduxView)

function T0SceneMainView:UIName()
	return T0WorldTools.GetMainUiView()
end

function T0SceneMainView:UIParent()
	return manager.ui.uiMain.transform
end

function T0SceneMainView:Init()
	self:InitUI()
	self:InitCapture()
	self:InitModules()
end

function T0SceneMainView:InitUI()
	self:BindCfgUI()
	self:AddListeners()

	self.captureModelController_ = self.controller_:GetController("captureMode")
	self.voiceContent = T0VoiceContent.New(self.voiceContentGo_)

	if self.chatOptionsContentGo_ then
		self.chatOptionsContent = T0ChatOptionsContent.New(self.chatOptionsContentGo_)
	end
end

function T0SceneMainView:InitModules()
	self.modules = {}

	if T0WorldMgr:GetSceneID() == 3 then
		self.bandLiveModule = self:AddModule("Widget/System/Main_T0SceneGame/104402/104402_StageUI", T0StageContent).inst
	end
end

function T0SceneMainView:AddListeners()
	if self.bandSoundSetBtn_ then
		self:AddBtnListener(self.bandSoundSetBtn_, nil, function()
			gameContext:Go("t0SceneSoundSetting")
		end)
	end

	if self.bandLivePanelBtn_ then
		self:AddBtnListener(self.bandLivePanelBtn_, nil, function()
			self.bandLiveModule:Toggle()
		end)
	end
end

function T0SceneMainView:AddEventListeners()
	self:RegistEventListener(T0_WORLD_SHOW_CAPTIONS, handler(self, self.OnShowCaptions))
	self:RegistEventListener(T0_WORLD_START_TALK, handler(self, self.OnStartTalk))
	self:RegistEventListener(T0_WORLD_CHANGE_CONTROLLER_MODE, handler(self, self.OnChangeControllerModeListener))
	self:RegistEventListener(T0_WORLD_SHOW_CHAT_OPTIONS, handler(self, self.OnShowChatOptions))
	self:RegistEventListener(T0_WORLD_PUSH_SUBTITLE, handler(self, self.OnPushSubtitle))
	self:RegistEventListener(T0_WORLD_SHOW_EFFECT, handler(self, self.OnShowEffect))
	self:RegistEventListener(T0_WORLD_SET_HELP_KEY, handler(self, self.OnSetHelpKey))
end

function T0SceneMainView:OnSetHelpKey(arg_10_1)
	self.helpKey = arg_10_1
end

function T0SceneMainView:OnStartTalk(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	self.voiceContent:OnStartTalk(arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
end

function T0SceneMainView:OnShowCaptions(arg_12_1, arg_12_2)
	if not arg_12_1 then
		self.voiceContent:CompelHide()
	else
		self.voiceContent:OnShowTipsKey(arg_12_2)
	end
end

function T0SceneMainView:OnPushSubtitle(arg_13_1)
	self.voiceContent:PushSubtitle(arg_13_1)
end

function T0SceneMainView:OnChangeControllerModeListener(arg_14_1)
	self.modeState = arg_14_1

	if arg_14_1 == T0WorldMgr.CaptureModeStateEnum.photo then
		self:RefreshPhotoBar()
	elseif arg_14_1 == T0WorldMgr.CaptureModeStateEnum.normal then
		self:RefreshNormalBar()
	end
end

function T0SceneMainView:OnShowChatOptions(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if not self.chatOptionsContent then
		return
	end

	if arg_15_1 then
		self.chatOptionsContent:AddOptionsBubble(arg_15_2, arg_15_3, icon, arg_15_4, arg_15_5)
	else
		self.chatOptionsContent:RemoveOptionsBubble(arg_15_2)
	end
end

function T0SceneMainView:OnShowEffect(arg_16_1)
	arg_16_1.transform:SetParent(self.effectContentGo_.transform, false)
end

function T0SceneMainView:OnEnter()
	CursorTools.LuaSwitchCursor(false)
	self:AddEventListeners()
	self:EnterCaptrue()
	self.voiceContent:OnEnter()

	if not getData(T0WorldTools.GetT0WorldHelpDataKey(), "showHelp") then
		CursorTools.LuaSwitchCursor(true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			noCache = true,
			pages = T0WorldTools.GetT0WorldHelpPages(),
			exitCallback = function()
				CursorTools.LuaSwitchCursor(false)
			end
		})
		saveData(T0WorldTools.GetT0WorldHelpDataKey(), "showHelp", 1)
	end
end

function T0SceneMainView:OnTop()
	if self.modeState and self.modeState == T0WorldMgr.CaptureModeStateEnum.photo then
		self:RefreshPhotoBar()
	else
		self:RefreshNormalBar()
	end
end

function T0SceneMainView:RefreshPhotoBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		T0WorldLuaBridge.EnterChapterMode(false)
	end)
end

function T0SceneMainView:RefreshNormalBar()
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

		if self.helpKey then
			if GameSetting[self.helpKey] then
				var_22_0 = GameSetting[self.helpKey].value or {}
			end
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

function T0SceneMainView:OnExit()
	CursorTools.LuaSwitchCursor(true)
	self.voiceContent:OnExit()
	self:ExitCapture()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function T0SceneMainView:Dispose()
	self.voiceContent:Dispose()

	if self.chatOptionsContent then
		self.chatOptionsContent:Dispose()
	end

	self:DisposeCapture()

	if self.modules then
		for iter_28_0, iter_28_1 in ipairs(self.modules) do
			if iter_28_1.inst then
				iter_28_1.inst:Dispose()
			end

			Object.Destroy(iter_28_1.obj)
		end

		self.modules = nil
	end

	self.super.Dispose(self)
end

function T0SceneMainView:AddModule(arg_29_1, arg_29_2)
	local var_29_0 = Object.Instantiate(Asset.Load(arg_29_1), self.moduleRoot_)
	local var_29_1 = {
		obj = var_29_0
	}

	table.insert(self.modules, var_29_1)

	if arg_29_2 then
		var_29_1.inst = arg_29_2.New(var_29_0)
	end

	return var_29_1
end

return T0SceneMainView
