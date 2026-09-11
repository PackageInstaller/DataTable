local AwakeNameView = class("AwakeNameView", ReduxView)

function AwakeNameView:UIName()
	return "Widget/System/LoginInterface/Login_name"
end

function AwakeNameView:UIParent()
	return manager.ui.uiMain.transform
end

function AwakeNameView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.playerable = self.transform_:GetComponent("PlayableDirector")
	self.animator = self.transform_:GetComponent("Animator")
end

function AwakeNameView:OnEnter()
	return
end

function AwakeNameView:OnExit()
	return
end

function AwakeNameView:Dispose()
	AwakeNameView.super.Dispose(self)
end

function AwakeNameView:AddListeners()
	self:AddBtnListener(self.confirmBtn_, nil, function()
		if self.nameInputField_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")
		else
			local var_8_0, var_8_1 = textLimit(self.nameInputField_.text, GameSetting.user_name_max.value[1])

			self.nameInputField_.text = GetI18NText(var_8_0)

			local var_8_2 = var_8_0

			if not nameRule(var_8_0) then
				ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

				return
			end

			WordVerifyBySDK(var_8_0, function(arg_9_0)
				if arg_9_0 then
					if not var_8_1 then
						return
					end

					PlayerAction.AwakeName(var_8_2, function()
						SendMessageManagerToSDK("role_create", {
							curNameText = var_8_2
						})

						self.confirmBtn_.interactable = false

						self.playerable:Stop()
						self.animator:Play("Login_name_exit", 0, 0)
						TimeTools.StartAfterSeconds(2, function()
							if self.gameObject_ then
								SetActive(self.gameObject_, false)
							end
						end, {})
						ShowAwakeNameCallBack()
					end)
				else
					ShowTips("ERROR_USER_NAME_VER_WORD")
				end
			end, JUDGE_MESSAGE_TYPE.PLAYER_NAME)
		end
	end)
end

function AwakeNameView:Cacheable()
	return false
end

return AwakeNameView
