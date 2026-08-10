local var_0_0 = class("MomoTalkMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Momotalk/MomotalkUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.staticContext = {
		page = {
			chat = {
				opened = false,
				state = "chat",
				script = MomoTalkChatTabsView,
				go = arg_3_0.chatGo_
			},
			setting = {
				opened = false,
				state = "edit",
				script = MomoTalkPlayerSettingView,
				go = arg_3_0.editGo_
			}
		},
		viewCon = arg_3_0.viewController_:GetController("viewState")
	}

	arg_3_0:AddListeners()
	arg_3_0:AddEventListener()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		arg_4_0:Back()
	end)
	arg_4_0:AddBtnListener(arg_4_0.changeBtn_, nil, function()
		arg_4_0:OnClickChange()
	end)
	arg_4_0:AddBtnListener(arg_4_0.fullScreenBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.AddEventListener(arg_8_0)
	arg_8_0:RegistEventListener(MOMOTALK_BACK_FROM_SETTING, handler(arg_8_0, arg_8_0.OnBackFromSetting))
	arg_8_0:RegistEventListener(MOMOTALK_REFRESH_PLAYER_ICON, handler(arg_8_0, arg_8_0.RefreshPlayerIcon))
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.momoTalkUpdateHandler_ = handler(arg_10_0, arg_10_0.OnMomoTalkUpdate)

	manager.notify:RegistListener(MOMOTALK_UPDATE, arg_10_0.momoTalkUpdateHandler_)
	arg_10_0:RefreshPlayerIcon()
	arg_10_0:EnterPage("chat")
end

function var_0_0.OnExit(arg_11_0)
	if arg_11_0.momoTalkUpdateHandler_ then
		manager.notify:RemoveListener(MOMOTALK_UPDATE, arg_11_0.momoTalkUpdateHandler_)

		arg_11_0.momoTalkUpdateHandler_ = nil
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.staticContext.page) do
		if iter_11_1.opened then
			iter_11_1.entity:OnExit()

			iter_11_1.opened = false
		end
	end

	manager.windowBar:HideBar()
end

function var_0_0.InstOrCreatePage(arg_12_0, arg_12_1)
	if arg_12_1.entity == nil then
		arg_12_1.entity = arg_12_1.script.New(arg_12_1.go)
	end
end

function var_0_0.EnterPage(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in pairs(arg_13_0.staticContext.page) do
		if iter_13_0 == arg_13_1 then
			if not iter_13_1.opened then
				arg_13_0:InstOrCreatePage(iter_13_1)
				iter_13_1.entity:OnEnter()

				iter_13_1.opened = true

				arg_13_0.staticContext.viewCon:SetSelectedState(iter_13_1.state)
			end
		elseif iter_13_1.opened then
			iter_13_1.entity:OnExit()

			iter_13_1.opened = false
		end
	end
end

function var_0_0.OnClickChange(arg_14_0)
	if arg_14_0.staticContext.page.setting.opened then
		arg_14_0:EnterPage("chat")
	else
		arg_14_0:EnterPage("setting")
	end
end

function var_0_0.RefreshPlayerIcon(arg_15_0)
	if arg_15_0.heroImg_ then
		arg_15_0.heroImg_.sprite = MomoTalkTools.GetMonoAvatarIcon(MomoTalkData.icon)
	end
end

function var_0_0.OnBackFromSetting(arg_16_0)
	arg_16_0:EnterPage("chat")
end

function var_0_0.OnMomoTalkUpdate(arg_17_0)
	local var_17_0 = arg_17_0.staticContext.page.chat

	if var_17_0.entity then
		var_17_0.entity:RefreshCurrentPanel()
	end

	arg_17_0:RefreshPlayerIcon()
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.staticContext.page) do
		if iter_18_1.entity then
			iter_18_1.entity:Dispose()

			iter_18_1.entity = nil
		end
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
