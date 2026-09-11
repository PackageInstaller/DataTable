local MoonPartyShareView = class("MoonPartyShareView", ReduxView)

function MoonPartyShareView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonPartyShareUI"
end

function MoonPartyShareView:UIParent()
	return manager.ui.uiPop.transform
end

function MoonPartyShareView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MoonPartyShareView:InitUI()
	self:BindCfgUI()
end

function MoonPartyShareView:AddUIListener()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.confirmBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if manager.time:GetServerTime() - MoonCakeData:GetLastShareTimestamp() < GameSetting.activity_mid_autumn_party_share_interval.value[1] then
			ShowTips("SEND_MESSAGE_FREQUENTLY")

			return
		end

		if ChatData:IsMuted() then
			self.inputField_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		local var_8_0 = self.inputField_.text

		if self.inputField_.text == "" then
			var_8_0 = GetTips("MID_AUTUMN_FESTIVAL_PARTY_SHARE_EMPTY_TIPS")
		end

		local var_8_1 = GameSetting.club_share_max.value[1]
		local var_8_2, var_8_3 = textLimit(var_8_0, GameSetting.club_share_max.value[1])

		self.inputField_.text = var_8_2

		if not var_8_3 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_8_1))

			return
		end

		if not nameRule(var_8_2, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_8_2, function(arg_9_0, arg_9_1)
			if not arg_9_0 then
				ShowTips("SENSITIVE_WORD")
			else
				ChatAction.SendChatNormalJump(ChatConst.CHAT_CHANNEL_MOON_CAKE, var_8_2, string.format("%s_%s", ViewConst.JUMP_SPECIAL_ID.MOON_CAKE, USER_ID), arg_9_1, function(arg_10_0)
					self:SendMessageResult(arg_10_0)
				end)
				SDKTools.SendMessageToSDK("activity_mid_autumn_phase2_party_share", {
					activity_id = self.activityID_,
					content = var_8_2
				})
			end
		end, JUDGE_MESSAGE_TYPE.ACTIVITY_MOON_CAKE)
	end)
end

function MoonPartyShareView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.inputField_.text = ""
end

function MoonPartyShareView:SendMessageResult(arg_12_1)
	if isSuccess(arg_12_1.result) then
		MoonCakeData:SetLastShareTimestamp()
		ChatData:SetSendTextTimestamp()

		self.inputField_.text = ""

		self:Back()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_MOON_CAKE
		}, ViewConst.SYSTEM_ID.CHAT)
	elseif arg_12_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				self:Back()
			end
		})
	elseif arg_12_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		self.inputField_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_12_1.result)
	end
end

return MoonPartyShareView
