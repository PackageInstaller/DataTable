local MomoTalkMainView = class("MomoTalkMainView", ReduxView)

function MomoTalkMainView:UIName()
	return "Widget/System/Momotalk/MomotalkUI"
end

function MomoTalkMainView:UIParent()
	return manager.ui.uiPop.transform
end

function MomoTalkMainView:Init()
	self:BindCfgUI()

	self.staticContext = {
		page = {
			chat = {
				opened = false,
				state = "chat",
				script = MomoTalkChatTabsView,
				go = self.chatGo_
			},
			setting = {
				opened = false,
				state = "edit",
				script = MomoTalkPlayerSettingView,
				go = self.editGo_
			}
		},
		viewCon = self.viewController_:GetController("viewState")
	}

	self:AddListeners()
	self:AddEventListener()
end

function MomoTalkMainView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.changeBtn_, nil, function()
		self:OnClickChange()
	end)
	self:AddBtnListener(self.fullScreenBtn_, nil, function()
		self:Back()
	end)
end

function MomoTalkMainView:AddEventListener()
	self:RegistEventListener(MOMOTALK_BACK_FROM_SETTING, handler(self, self.OnBackFromSetting))
	self:RegistEventListener(MOMOTALK_REFRESH_PLAYER_ICON, handler(self, self.RefreshPlayerIcon))
end

function MomoTalkMainView:OnTop()
	manager.windowBar:HideBar()
end

function MomoTalkMainView:OnEnter()
	self.momoTalkUpdateHandler_ = handler(self, self.OnMomoTalkUpdate)

	manager.notify:RegistListener(MOMOTALK_UPDATE, self.momoTalkUpdateHandler_)
	self:RefreshPlayerIcon()
	self:EnterPage("chat")
end

function MomoTalkMainView:OnExit()
	if self.momoTalkUpdateHandler_ then
		manager.notify:RemoveListener(MOMOTALK_UPDATE, self.momoTalkUpdateHandler_)

		self.momoTalkUpdateHandler_ = nil
	end

	for iter_11_0, iter_11_1 in pairs(self.staticContext.page) do
		if iter_11_1.opened then
			iter_11_1.entity:OnExit()

			iter_11_1.opened = false
		end
	end

	manager.windowBar:HideBar()
end

function MomoTalkMainView:InstOrCreatePage(arg_12_1)
	if arg_12_1.entity == nil then
		arg_12_1.entity = arg_12_1.script.New(arg_12_1.go)
	end
end

function MomoTalkMainView:EnterPage(arg_13_1)
	for iter_13_0, iter_13_1 in pairs(self.staticContext.page) do
		if iter_13_0 == arg_13_1 then
			if not iter_13_1.opened then
				self:InstOrCreatePage(iter_13_1)
				iter_13_1.entity:OnEnter()

				iter_13_1.opened = true

				self.staticContext.viewCon:SetSelectedState(iter_13_1.state)
			end
		elseif iter_13_1.opened then
			iter_13_1.entity:OnExit()

			iter_13_1.opened = false
		end
	end
end

function MomoTalkMainView:OnClickChange()
	if self.staticContext.page.setting.opened then
		self:EnterPage("chat")
	else
		self:EnterPage("setting")
	end
end

function MomoTalkMainView:RefreshPlayerIcon()
	if self.heroImg_ then
		self.heroImg_.sprite = MomoTalkTools.GetMonoAvatarIcon(MomoTalkData.icon)
	end
end

function MomoTalkMainView:OnBackFromSetting()
	self:EnterPage("chat")
end

function MomoTalkMainView:OnMomoTalkUpdate()
	if self.staticContext.page.chat.entity then
		self.staticContext.page.chat.entity:RefreshCurrentPanel()
	end

	self:RefreshPlayerIcon()
end

function MomoTalkMainView:Dispose()
	for iter_18_0, iter_18_1 in pairs(self.staticContext.page) do
		if iter_18_1.entity then
			iter_18_1.entity:Dispose()

			iter_18_1.entity = nil
		end
	end

	MomoTalkMainView.super.Dispose(self)
end

return MomoTalkMainView
