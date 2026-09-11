local GuildChangeNoticeView = class("GuildChangeNoticeView", ReduxView)

function GuildChangeNoticeView:UIName()
	return "Widget/System/Club/ClubNoticeUI"
end

function GuildChangeNoticeView:UIParent()
	return manager.ui.uiPop.transform
end

function GuildChangeNoticeView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GuildChangeNoticeView:OnEnter()
	return
end

function GuildChangeNoticeView:OnExit()
	return
end

function GuildChangeNoticeView:Dispose()
	GuildChangeNoticeView.super.Dispose(self)
end

function GuildChangeNoticeView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self.inputFieldNotice_.text = ""

		self:Back()
	end)
	self:AddBtnListener(self.buttonCancel_, nil, function()
		self.inputFieldNotice_.text = ""

		self:Back()
	end)
	self:AddBtnListener(self.buttonOk_, nil, function()
		if OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.CHANGE_CLUB_SIGN) then
			ShowTips("ERROR_FUNCTION_STOP")

			return
		end

		local var_10_1, var_10_2 = textLimit(self.inputFieldNotice_.text, GameSetting.club_announcement_max.value[1])

		self.inputFieldNotice_.text = GetI18NText(var_10_1)

		if not var_10_2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), GameSetting.club_announcement_max.value[1]))

			return
		end

		if not nameRule(var_10_1, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(var_10_1, function(arg_11_0)
			if not arg_11_0 then
				ShowTips("SENSITIVE_WORD")
			else
				GuildAction.GuildChangeNotice(var_10_1, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						self:Back()

						self.inputFieldNotice_.text = ""

						ShowTips("CLUB_CHANGED_NOTICE_SUCCESS")
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end
		end, JUDGE_MESSAGE_TYPE.GUILD_NOTICE)
	end)
end

return GuildChangeNoticeView
