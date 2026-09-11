local GuildFoundedView = class("GuildFoundedView", ReduxView)

function GuildFoundedView:UIName()
	return "Widget/System/Club/ClubCreateUI"
end

function GuildFoundedView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildFoundedView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function GuildFoundedView:OnEnter()
	self:RegisterEvent()
	self:RefreshBar()

	self.textCost_.text = GameSetting.club_founded_cost.value[1]
	self.headIconID_ = self.headIconID_ or math.random(1, #ClubHeadIconCfg.all)

	self:RefreshHeadIcon()
end

function GuildFoundedView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function GuildFoundedView:RegisterEvent()
	self:RegistEventListener(GUILD_SWITCH_HEAD_ICON, handler(self, self.SwitchHeadIcon))
end

function GuildFoundedView:Dispose()
	GuildFoundedView.super.Dispose(self)
end

function GuildFoundedView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function()
		self:Back()
	end)
end

function GuildFoundedView:AddListeners()
	self:AddBtnListener(self.selIconBtn, nil, function()
		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = self.headIconID_
		})
	end)
	self:AddBtnListener(self.buttonFounded_, nil, function()
		if self.inputFieldName_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(self.inputFieldName_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			self.inputFieldName_.text = ""

			return
		end

		local var_12_0, var_12_1 = textLimit(self.inputFieldName_.text, GameSetting.club_name_max.value[1])

		if not nameRule(self.inputFieldName_.text) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not var_12_1 then
			ShowTips("CLUB_FOUNDED_NAME_MAX")

			return
		end

		local var_12_2 = GameSetting.club_announcement_max.value[1]
		local var_12_3, var_12_4 = textLimit(self.inputFieldNotice_.text, GameSetting.club_announcement_max.value[1])

		self.inputFieldNotice_.text = GetI18NText(var_12_3)

		if not var_12_4 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_12_2))

			return
		end

		if not nameRule(var_12_3, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(self.inputFieldName_.text .. "" .. self.inputFieldNotice_.text, function(arg_13_0)
			if not arg_13_0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			local var_13_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

			if var_13_0 < GameSetting.club_founded_cost.value[1] then
				ShopTools.DefaultOpenPopUp(GameSetting.club_founded_cost.value[1] - var_13_0)

				return
			end

			GuildAction.FoundedGuild(self.inputFieldName_.text, self.inputFieldNotice_.text, self.headIconID_, function(arg_14_0)
				if isSuccess(arg_14_0.result) then
					ShowTips("CLUB_FOUNDED_SUCCESS")
					SendMessageManagerToSDK("guild_join")

					self.inputFieldName_.text = ""
					self.inputFieldNotice_.text = ""
				else
					ShowTips(arg_14_0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

function GuildFoundedView:SwitchHeadIcon(arg_15_1)
	self.headIconID_ = arg_15_1

	self:RefreshHeadIcon()
end

function GuildFoundedView:RefreshHeadIcon()
	self.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[self.headIconID_].iconName)
	self.imageBg_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[self.headIconID_].bg)
end

return GuildFoundedView
