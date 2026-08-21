local var_0_0 = class("GuildFoundedView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club/ClubCreateUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RegisterEvent()
	arg_4_0:RefreshBar()

	arg_4_0.textCost_.text = GameSetting.club_founded_cost.value[1]
	arg_4_0.headIconID_ = arg_4_0.headIconID_ or math.random(1, #ClubHeadIconCfg.all)

	arg_4_0:RefreshHeadIcon()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.RegisterEvent(arg_6_0)
	arg_6_0:RegistEventListener(GUILD_SWITCH_HEAD_ICON, handler(arg_6_0, arg_6_0.SwitchHeadIcon))
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.RefreshBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:RegistBackCallBack(function()
		arg_8_0:Back()
	end)
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.selIconBtn, nil, function()
		JumpTools.OpenPageByJump("guildHeadIconSelect", {
			selectID = arg_10_0.headIconID_
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.buttonFounded_, nil, function()
		if arg_10_0.inputFieldName_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(arg_10_0.inputFieldName_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_10_0.inputFieldName_.text = ""

			return
		end

		local var_12_0, var_12_1 = textLimit(arg_10_0.inputFieldName_.text, GameSetting.club_name_max.value[1])

		if not nameRule(arg_10_0.inputFieldName_.text) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		if not var_12_1 then
			ShowTips("CLUB_FOUNDED_NAME_MAX")

			return
		end

		local var_12_2 = GameSetting.club_announcement_max.value[1]
		local var_12_3, var_12_4 = textLimit(arg_10_0.inputFieldNotice_.text, var_12_2)

		arg_10_0.inputFieldNotice_.text = GetI18NText(var_12_3)

		if not var_12_4 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_12_2))

			return
		end

		if not nameRule(var_12_3, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(arg_10_0.inputFieldName_.text .. "" .. arg_10_0.inputFieldNotice_.text, function(arg_13_0)
			if not arg_13_0 then
				ShowTips("SENSITIVE_WORD")

				return
			end

			local var_13_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

			if var_13_0 < GameSetting.club_founded_cost.value[1] then
				local var_13_1 = GameSetting.club_founded_cost.value[1] - var_13_0

				ShopTools.DefaultOpenPopUp(var_13_1)

				return
			end

			local var_13_2 = arg_10_0.inputFieldName_.text
			local var_13_3 = arg_10_0.inputFieldNotice_.text

			GuildAction.FoundedGuild(var_13_2, var_13_3, arg_10_0.headIconID_, function(arg_14_0)
				if isSuccess(arg_14_0.result) then
					ShowTips("CLUB_FOUNDED_SUCCESS")
					SendMessageManagerToSDK("guild_join")

					arg_10_0.inputFieldName_.text = ""
					arg_10_0.inputFieldNotice_.text = ""
				else
					ShowTips(arg_14_0.result)
				end
			end)
		end, JUDGE_MESSAGE_TYPE.GUILD_NAME)
	end)
end

function var_0_0.SwitchHeadIcon(arg_15_0, arg_15_1)
	arg_15_0.headIconID_ = arg_15_1

	arg_15_0:RefreshHeadIcon()
end

function var_0_0.RefreshHeadIcon(arg_16_0)
	local var_16_0 = ClubHeadIconCfg[arg_16_0.headIconID_]

	arg_16_0.imageIcon_.sprite = getSpriteViaConfig("ClubHeadIcon", var_16_0.iconName)
	arg_16_0.imageBg_.sprite = getSpriteViaConfig("ClubHeadIcon", var_16_0.bg)
end

return var_0_0
