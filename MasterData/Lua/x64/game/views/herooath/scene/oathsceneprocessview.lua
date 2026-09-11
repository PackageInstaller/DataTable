local OathSceneProcessView = class("OathSceneProcessView", ReduxView)

function OathSceneProcessView:UIName()
	return "Widget/System/Hero_Oath/OathCaptureView/HeroOathSceneProcessView"
end

function OathSceneProcessView:UIParent()
	return manager.ui.uiMain.transform
end

function OathSceneProcessView:Init()
	self:InitUI()

	self.voiceContent = OathVoiceContent.New(self.voiceContentGo_)
	self.bubbleContent = OathBubbleContent.New(self.bubbleContentGo_)
	self.conditionContent = OathConditionContent.New(self.conditionContentGo_)
	self.girlCameraContent = OathGirlCameraContent.New(self.btnGirl_)
end

function OathSceneProcessView:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(self.btnSkip_, nil, function()
		SetActive(self.btnSkipGo_, false)
		manager.transition:OnlyShowEffect(true, function()
			OathLuaBridge.InvokeSkip()
			self:AddSkipBalckTimer()
			HeroTools.StopTalk()
			self.voiceContent:HideVoiceContent()
		end)
	end)
end

function OathSceneProcessView:DelSkipBalckTimer()
	if self.skipBalckTimer_ then
		self.skipBalckTimer_:Stop()

		self.skipBalckTimer_ = nil
	end
end

function OathSceneProcessView:AddSkipBalckTimer()
	self:DelSkipBalckTimer()

	self.skipBalckTimer_ = Timer.New(function()
		manager.transition:OnlyShowEffect(false)
	end, 1)

	self.skipBalckTimer_:Start()
end

function OathSceneProcessView:DelCostHideTimer()
	if self.costHideTimer_ then
		self.costHideTimer_:Stop()

		self.costHideTimer_ = nil
	end
end

function OathSceneProcessView:AddCostHideTimer(arg_11_1)
	self:DelCostHideTimer()

	self.costHideTimer_ = Timer.New(function()
		LuaExchangeHelper.ActionInvoke(arg_11_1)
		SetActive(self.costShowGo_, false)
	end, 0.5)

	self.costHideTimer_:Start()
end

function OathSceneProcessView:AddEventListeners()
	self:RegistEventListener(OATH_SCENE_SHOW_SKIP, handler(self, self.OnShowSkip))
	self:RegistEventListener(OATH_SCENE_SHOW_OATH_CONDITION, handler(self, self.OnShowOathCondition))
	self:RegistEventListener(OATH_SCENE_ADD_BUBBLE, handler(self, self.OnAddOptionsBubble))
	self:RegistEventListener(OATH_SCENE_TALK, handler(self, self.OnTalk))
	self:RegistEventListener(OATH_SCENE_LOAD_MODEL, handler(self, self.OnLoadModel))
	self:RegistEventListener(OATH_SCENE_SHOW_COST, handler(self, self.OnShowCost))
	self:RegistEventListener(OATH_SCENE_ENTER_DRAG, handler(self, self.OnEnterDragMode))
	self:RegistEventListener(OATH_SCENE_LOAD_EFFECT, handler(self, self.OnLoadEffect))
end

function OathSceneProcessView:OnShowSkip(arg_14_1)
	if not OathTools.IsOath((OathToLuaBridge:GetOathHeroID())) then
		arg_14_1 = false
	end

	SetActive(self.btnSkipGo_, arg_14_1)
end

function OathSceneProcessView:OnLoadEffect(arg_15_1)
	arg_15_1.transform:SetParent(self.effectContentGo_.transform, false)
end

function OathSceneProcessView:OnEnterDragMode(arg_16_1)
	self.btnGirl_:SetActive(not arg_16_1)
end

function OathSceneProcessView:OnShowOathCondition(arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_2 then
		manager.ui:SetUISeparateRender(false)
		self.conditionContent:Show(false)

		return
	end

	local var_17_0 = {
		countDownTimes = arg_17_3,
		finishCallBack = arg_17_1
	}

	manager.ui:SetUISeparateRender(true)
	self.conditionContent:RefreshUI(var_17_0)
end

function OathSceneProcessView:OnAddOptionsBubble(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	if arg_18_1 then
		self.bubbleContent:AddOptionsBubble(arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	else
		self.bubbleContent:RemoveOptionsBubble(arg_18_2)
	end
end

function OathSceneProcessView:OnTalk(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	self.voiceContent:OnTalk(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
end

function OathSceneProcessView:OnLoadModel(arg_20_1)
	self.girlCameraContent:LoadModel(arg_20_1)
end

function OathSceneProcessView:OnShowCost(arg_21_1, arg_21_2)
	local var_21_0 = OathToLuaBridge:GetOathHeroID()
	local var_21_1 = OathTools.IsOath(var_21_0)

	if arg_21_1 and not var_21_1 then
		self.costAni_.enabled = false

		SetActive(self.costShowGo_, true)

		local var_21_2 = WeddingCfg[var_21_0].ring_id

		self.costIcon_.sprite = ItemTools.getItemSprite(WeddingCfg[var_21_0].ring_id)

		local var_21_3 = ItemTools.getItemNum(var_21_2)

		self.costText_.text = var_21_3 > 1 and string.format("%s/%s", var_21_3, 1) or string.format("%s/%s", var_21_3, 1)
		self.costName_.text = GetI18NText(ItemCfg[var_21_2].name)
	elseif not var_21_1 then
		self.costText_.text = string.format("%s/%s", ItemTools.getItemNum(WeddingCfg[var_21_0].ring_id) - 1, 1)
		self.costAni_.enabled = true

		self:AddCostHideTimer(arg_21_2)
	else
		if arg_21_2 then
			LuaExchangeHelper.ActionInvoke(arg_21_2)
		end

		SetActive(self.costShowGo_, false)
	end
end

function OathSceneProcessView:OnEnter()
	self:AddEventListeners()
end

function OathSceneProcessView:OnTop()
	self:RefreshBar()
end

function OathSceneProcessView:CameraEnter()
	manager.ui:SetMainCameraCom("CinemachineBrain", true)
end

function OathSceneProcessView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("SNAKEGAME_GIVE_UP"),
			OkCallback = function()
				self:ExitSDK()
				OathToLuaBridge.OathExitScene()
			end
		})
	end)
end

function OathSceneProcessView:ExitSDK()
	SDKTools.SendMessageToSDK("activity_sys_act", {
		sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM,
		hero_id = OathToLuaBridge:GetOathHeroID(),
		type = OathConst.OATH_SCENE_ID.EXIT,
		mould_id = isMeetOath and 1 or 2
	})
end

function OathSceneProcessView:OnExit()
	self:DelSkipBalckTimer()
	self.voiceContent:OnExit()
	self.bubbleContent:OnExit()
	self.conditionContent:OnExit()
	self.girlCameraContent:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function OathSceneProcessView:Dispose()
	self.voiceContent:Dispose()
	self.bubbleContent:Dispose()
	self.conditionContent:Dispose()
	self.girlCameraContent:Dispose()
	self.super.Dispose(self)
end

return OathSceneProcessView
