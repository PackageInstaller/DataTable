local HeroInteractionGMContentView = class("HeroInteractionGMContentView", ReduxView)

function HeroInteractionGMContentView:UIName()
	return "UI/HeroInteractionGMContentUI"
end

function HeroInteractionGMContentView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroInteractionGMContentView:OnCtor()
	return
end

function HeroInteractionGMContentView:OnEnter()
	if self.inited == false then
		self:Init()
	end
end

function HeroInteractionGMContentView:Init()
	self:InitUI()
	self:AddUIListener()

	self.inited = true
end

function HeroInteractionGMContentView:InitUI()
	self.skinId_ = self.params_.skinId

	if SkinCfg[self.skinId_] == nil then
		print("SkinCfg[self.skinId_] == nil")
	end

	self.typeName_ = self.params_.typeName

	local var_6_0 = string.split(self.typeName_, "_")

	if #var_6_0 == 1 then
		self.actionType_ = var_6_0[1]
		self.voiceType_ = self.actionType_ .. "_talk"
		self.voiceDelayType_ = self.actionType_ .. "_delay"
	else
		self.actionType_ = var_6_0[1]
		self.voiceType_ = self.typeName_
		self.voiceDelayType_ = var_6_0[1] .. "_delay"
	end

	self.actionNameList = {}
	self.actionList_ = {}
	self.voiceList_ = {}
	self.voiceDelayList_ = {}
	self.interactionCfg_ = HeroTools.GetOldInteractionCfg(SkinCfg[self.skinId_].hero)

	if self.interactionCfg_ and self.interactionCfg_[self.typeName_] ~= nil then
		self.actionNameList = self.interactionCfg_[self.typeName_]
	end

	if self.interactionCfg_ and self.interactionCfg_[self.voiceType_] ~= nil then
		self.voiceList_ = self.interactionCfg_[self.voiceType_]
	end

	if self.interactionCfg_ and self.interactionCfg_[self.actionType_] ~= nil then
		self.actionList_ = self.interactionCfg_[self.actionType_]
	end

	if self.interactionCfg_ and self.interactionCfg_[self.voiceDelayType_] ~= nil then
		self.voiceDelayList_ = self.interactionCfg_[self.voiceDelayType_]
	end

	if self.backgroundBtn_ == nil then
		self.backgroundBtn_ = self:FindCom("Button", "background")
	end

	if self.btn_prefab == nil then
		self.btn_prefab = self:FindGo("HeroInteractionBut_prefab")
	end

	if self.panel_go == nil then
		self.panel_go = self:FindTrs("panel")
	end

	self.btn_list = {}
	self.btnGo_list = {}

	self:GenBtn()
end

function HeroInteractionGMContentView:GenBtn()
	if self.actionNameList ~= nil and #self.actionNameList > 0 then
		for iter_7_0, iter_7_1 in ipairs(self.actionNameList) do
			local var_7_0 = Object.Instantiate(self.btn_prefab, self.panel_go)
			local var_7_1 = var_7_0:GetComponentInChildren(typeof(Text))

			if var_7_1 ~= nil then
				var_7_1.text = GetI18NText(iter_7_1)
			else
				print("btn_text为空")
			end

			local var_7_2 = var_7_0:GetComponent(typeof(Button))

			if var_7_2 == nil then
				print("button_:按钮为空")
			end

			table.insert(self.btn_list, var_7_2)
			table.insert(self.btnGo_list, var_7_0)
		end
	end
end

function HeroInteractionGMContentView:AddUIListener()
	for iter_8_0, iter_8_1 in ipairs(self.btn_list) do
		self:AddBtnListener(iter_8_1, nil, function()
			self:DelayToPlayInteractionAnimation(iter_8_0, 0)
		end)
	end

	self:AddBtnListener(self.backgroundBtn_, nil, function()
		self:Back()
	end)
end

function HeroInteractionGMContentView:DelayToPlayInteractionAnimation(arg_11_1, arg_11_2)
	if self.playingInteraction_ then
		return
	end

	if arg_11_2 == nil then
		arg_11_2 = 1
	end

	self:PlayInteractionAnimation(arg_11_1)
end

function HeroInteractionGMContentView:PlayInteractionAnimation(arg_12_1)
	manager.posterGirl:SetForceRandomIndex(arg_12_1)

	if self.typeName_ == "greeting" then
		manager.posterGirl:DoGreeting()
	elseif self.typeName_ == "mainTouch" then
		manager.posterGirl:DoTouch()
	elseif self.typeName_ == "mainQuickTouch" then
		manager.posterGirl:DoQuickTouch()
	elseif self.typeName_ == "shaking" then
		manager.posterGirl:DoShacking()
	elseif self.typeName_ == "showing" then
		manager.posterGirl:DoShowing()
	elseif self.typeName_ == "idle" then
		manager.posterGirl:DoIdle()
	else
		error("HeroInteractionGMContentView can not find interaction by typeName :" .. self.typeName_)
	end
end

function HeroInteractionGMContentView:PlaySpecialAnimation(arg_13_1, arg_13_2, arg_13_3)
	return
end

function HeroInteractionGMContentView:OnPlaySpecialCallback()
	return
end

function HeroInteractionGMContentView:PlayIdleAni()
	return
end

function HeroInteractionGMContentView:OnExit()
	self:RemoveAllListeners()

	for iter_16_0, iter_16_1 in ipairs(self.btnGo_list) do
		Object.Destroy(iter_16_1)
	end

	self.btn_list = nil
	self.btnGo_list = nil
	self.inited = false
	self.playingInteraction_ = false

	HeroTools.StopTalk()
end

function HeroInteractionGMContentView:Dispose()
	HeroInteractionGMContentView.super.Dispose(self)
end

return HeroInteractionGMContentView
