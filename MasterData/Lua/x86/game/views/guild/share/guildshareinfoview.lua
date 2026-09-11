local GuildShareInfoView = class("GuildShareInfoView", ReduxView)

function GuildShareInfoView:UIName()
	return "Widget/System/Club/ClubShareMessagePopUI"
end

function GuildShareInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildShareInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GuildShareInfoView:OnEnter()
	dealEnter(self.inputFieldNotice_)
end

function GuildShareInfoView:OnExit()
	return
end

function GuildShareInfoView:Dispose()
	GuildShareInfoView.super.Dispose(self)
end

function GuildShareInfoView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self.inputFieldNotice_.text = ""

		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self.inputFieldNotice_.text = ""

		self:Back()
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		local var_10_1, var_10_2 = textLimit(self.inputFieldNotice_.text, GameSetting.club_share_max.value[1])

		self.inputFieldNotice_.text = GetI18NText(var_10_1)

		if not nameRule(self.inputFieldNotice_.text) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not var_10_2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), GameSetting.club_share_max.value[1]))

			return
		end

		WordVerifyBySDK(var_10_1, function(arg_11_0)
			if not arg_11_0 then
				ShowTips("SENSITIVE_WORD")
			else
				GuildAction.GuildShare(var_10_1, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						self:Back()

						self.inputFieldNotice_.text = ""

						ChatAction.RequireGuildShareInfo()
						JumpTools.OpenPageByJump("chat", {
							ignoreBG = true,
							chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_RECRUIT
						}, ViewConst.SYSTEM_ID.CHAT)
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.GUILD_SHARE)
	end)
end

return GuildShareInfoView
