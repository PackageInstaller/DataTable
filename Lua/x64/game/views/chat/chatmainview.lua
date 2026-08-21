local var_0_0 = class("ChatMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Chat/HomeDialogueUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.chatToggleID_ = 0
	arg_4_0.curfriendID_ = nil
	arg_4_0.activityTabItemList_ = {}
	arg_4_0.chatSeek_ = {}
	arg_4_0.historySeek_ = {}

	arg_4_0:InitItemPool()

	arg_4_0.bugText_.text = GetI18NText("招募")

	local var_4_0 = arg_4_0.diaViewPortTrs_.rect.height
	local var_4_1 = arg_4_0.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing

	arg_4_0.loopScrollView_ = LoopScrollView.New(arg_4_0, arg_4_0.diaScrollEx_, arg_4_0.diaGridTrs_, arg_4_0.diaViewPortTrs_, var_4_0, var_4_1, true)
	arg_4_0.friendsLuaUIlist_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexFriendsItem), arg_4_0.friendsUIlist_, ChatFriendsTabItem)
	arg_4_0.chatStickerView_ = ChatStickerView.New(arg_4_0.stickerGo_)
	arg_4_0.emptyStateController_ = arg_4_0.mainControllerEx_:GetController("emptyState")
	arg_4_0.tabStateController_ = arg_4_0.mainControllerEx_:GetController("tabState")
	arg_4_0.blurStateController_ = arg_4_0.mainControllerEx_:GetController("blurState")
	arg_4_0.worldTabStateController_ = arg_4_0.mainControllerEx_:GetController("worldTabState")
	arg_4_0.guildTabStateController_ = arg_4_0.mainControllerEx_:GetController("guildTabState")
	arg_4_0.recruitTabStateController_ = arg_4_0.mainControllerEx_:GetController("recruitTabState")
	arg_4_0.cooperTabStateController_ = arg_4_0.mainControllerEx_:GetController("cooperTabState")
	arg_4_0.onlineStateController_ = arg_4_0.mainControllerEx_:GetController("friendOnlineState")
	arg_4_0.soloStateController_ = arg_4_0.mainControllerEx_:GetController("soloState")
	arg_4_0.sendCDStateController_ = arg_4_0.mainControllerEx_:GetController("sendCD")
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.worldTabBtn_, nil, function()
		arg_5_0:RefreshToggle(ChatConst.CHAT_CHANNEL_WORLD)
	end)
	arg_5_0:AddBtnListener(arg_5_0.guildTabBtn_, nil, function()
		arg_5_0:RefreshToggle(ChatConst.CHAT_CHANNEL_GUILD)
	end)
	arg_5_0:AddBtnListener(arg_5_0.recruitTabBtn_, nil, function()
		local var_9_0 = PlayerData:GetPlayerInfo().userLevel
		local var_9_1 = GameSetting.club_recruit_unlock_level.value[1]

		if var_9_0 < var_9_1 then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_9_1))
		else
			arg_5_0:RefreshToggle(ChatConst.CHAT_CHANNEL_GUILD_RECRUIT)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cooperTabBtn_, nil, function()
		arg_5_0:RefreshToggle(ChatConst.CHAT_CHANNEL_COOPERATION)
	end)
	arg_5_0:AddBtnListener(arg_5_0.sendCDBtn_, nil, function()
		if arg_5_0.sendInputfield_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(arg_5_0.sendInputfield_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_5_0.sendInputfield_.text = ""

			return
		end

		ShowTips("SEND_MESSAGE_FREQUENTLY")
	end)
	arg_5_0:AddBtnListener(arg_5_0.sendBtn_, nil, function()
		if arg_5_0.sendInputfield_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if ChatData:IsMuted() then
			arg_5_0.sendInputfield_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if IsAllSpace(arg_5_0.sendInputfield_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			arg_5_0.sendInputfield_.text = ""

			return
		end

		local var_12_0 = GameSetting.chat_length_max.value[1]
		local var_12_1, var_12_2 = textLimit(arg_5_0.sendInputfield_.text, var_12_0)

		arg_5_0.sendInputfield_.text = GetI18NText(var_12_1)

		if not var_12_2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_12_0))

			return
		end

		if not nameRule(var_12_1, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(arg_5_0.sendInputfield_.text, function(arg_13_0, arg_13_1)
			if not arg_13_0 then
				ShowTips("SENSITIVE_WORD")
			else
				if arg_5_0.sendInputfield_.text == "" then
					return
				end

				Debug.Log("当前时间：" .. manager.time:GetServerTime())
				Debug.Log("最近发言时间：" .. ChatData:GetSendTextTimestamp())

				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				if arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
					ChatAction.SendMsg(arg_5_0.sendInputfield_.text, arg_13_1, function(arg_14_0)
						arg_5_0:SendMessageResult(arg_14_0)
					end)
				elseif arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
					if GuildData:GetGuildInfo().id == nil then
						ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

						return
					end

					ChatAction.SendGuildMsg(arg_5_0.sendInputfield_.text, arg_13_1, function(arg_15_0)
						arg_5_0:SendMessageResult(arg_15_0)
					end)
				elseif arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
					ChatAction.SendGuildRecruitMsg(arg_5_0.sendInputfield_.text, arg_13_1, function(arg_16_0)
						arg_5_0:SendMessageResult(arg_16_0)
					end)
				elseif arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
					if not CooperationData:CheckInRoom() then
						ShowTips("ERROR_INVALID_OPERATION")

						return
					end

					ChatAction.SendCooperationdMsg(arg_5_0.sendInputfield_.text, arg_13_1, function(arg_17_0)
						arg_5_0:SendMessageResult(arg_17_0)
					end)
				elseif arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
					ChatAction.SendFriendMsg(arg_5_0.curfriendID_, arg_5_0.sendInputfield_.text, arg_13_1, function(arg_18_0)
						if isSuccess(arg_18_0.result) then
							ChatData:SetSendTextTimestamp()

							arg_5_0.sendInputfield_.text = ""
						elseif arg_18_0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
							arg_5_0.sendInputfield_.text = ""

							JumpTools.OpenPageByJump("chatMuted")

							return
						else
							ShowTips(arg_18_0.result)
						end
					end)
				else
					if ChatToggleCfg[arg_5_0.chatToggleID_] and not ChatTools.IsOpenChatChannel(arg_5_0.chatToggleID_) then
						ShowTips("TIME_OVER")

						return
					end

					ChatAction.SendChatNormalMsg(arg_5_0.chatToggleID_, arg_5_0.sendInputfield_.text, arg_13_1, function(arg_19_0)
						arg_5_0:SendMessageResult(arg_19_0)
					end)
				end
			end
		end, arg_5_0:GetChatJudgeMessageType())
	end)
	arg_5_0:AddBtnListener(arg_5_0.stickerBtn_, nil, function()
		arg_5_0.chatStickerView_:Show(true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.stickerHideBtn_, nil, function()
		arg_5_0:HideStickerPanel()
		arg_5_0:OnHideChatReport()
	end)
	arg_5_0:AddBtnListener(arg_5_0.newJumpBtn_, nil, function()
		arg_5_0.loopScrollView_:Scroll2End()

		if arg_5_0.chatSeek_[arg_5_0.chatToggleID_] == #arg_5_0:LsGetItemData() then
			SetActive(arg_5_0.newJumpBtn_.gameObject, false)

			if arg_5_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
				ChatGuildData:SaveRecordCnt()
			elseif ChatToggleCfg[arg_5_0.chatToggleID_] then
				ChatChannelData:SaveRecordCnt(arg_5_0.chatToggleID_)
			end
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.reportBtn_, nil, function()
		arg_5_0:OnHideChatReport()
		arg_5_0:HideStickerPanel()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = arg_5_0.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	arg_5_0:AddBtnListener(arg_5_0.userSettingBtn_, nil, function()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	arg_5_0:AddToggleListener(arg_5_0.channelSelectDd_, function(arg_25_0)
		if arg_5_0.stackoverflowProtect and arg_5_0.stackoverflowProtect == arg_25_0 then
			return
		else
			arg_5_0.stackoverflowProtect = arg_25_0
		end

		local var_25_0 = arg_25_0 + 1

		if var_25_0 == ChatData:GetWorldChannelNum() then
			return
		end

		if manager.time:GetServerTime() - ChatData:GetChannelTimestamp() < 5 then
			ShowTips("SWITCH_CHANNEL_FREQUENTLY")

			arg_5_0.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1

			return
		end

		ChatAction.SetWorldChannelNum(var_25_0, function(arg_26_0)
			if arg_26_0 == 0 then
				ChatData:SetChannelTimestamp()
			else
				arg_5_0.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1

				ShowTips(arg_26_0)
			end
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.friendCloseBtn_, nil, function()
		SetActive(arg_5_0.friendCancelBtn_.gameObject, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.friendCancelBtn_, nil, function()
		SetActive(arg_5_0.friendCancelBtn_.gameObject, false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.friendRemoveBtn_, nil, function()
		SetActive(arg_5_0.friendCancelBtn_.gameObject, false)
		arg_5_0:CloseCurFriendChat()
	end)
	arg_5_0:AddBtnListener(arg_5_0.publicTabBtn_, nil, function()
		arg_5_0:UpdatePublicMainTab()
	end)
	arg_5_0:AddBtnListener(arg_5_0.friendsTabBtn_, nil, function()
		arg_5_0:UpdateFriendsMainTab()
	end)
	arg_5_0:AddBtnListener(arg_5_0.avatarsystemBtn_, nil, function()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.addFriendChatBtn_, nil, function()
		JumpTools.OpenPageByJump("/friendsUI", {
			friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
		}, ViewConst.SYSTEM_ID.FRIEND)
	end)
end

function var_0_0.ReserveCameraEnter(arg_34_0)
	if arg_34_0.params_.ignoreBG then
		return
	end

	local var_34_0 = HomeSceneSettingData:GetCurScene()
	local var_34_1 = manager.loadScene:GetHomeShouldLoadSceneName(var_34_0)

	manager.loadScene:SetSceneActive(var_34_1, true)
end

function var_0_0.OnEnter(arg_35_0)
	FriendsAction:TryToRefreshFriendsView(1)
	manager.windowBar:HideBar()

	if arg_35_0.params_.ignoreBG ~= true then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.chat)
		arg_35_0:SetCamera()
	end

	arg_35_0.blurStateController_:SetSelectedState(arg_35_0.params_.ignoreBG and "blur" or "none")
	arg_35_0.chatStickerView_:OnEnter()

	arg_35_0.curfriendID_ = nil

	if arg_35_0.params_.chatToggleID ~= ChatConst.CHAT_CHANNEL_FRIEND then
		arg_35_0:UpdatePublicMainTab()
	else
		arg_35_0:UpdateFriendsMainTab()
	end

	if not arg_35_0.sendTipsCD_ then
		arg_35_0.sendTipsCD_ = 0
	end

	arg_35_0.sendTipsTimer_ = Timer.New(function()
		if arg_35_0.sendTipsCD_ > 0 then
			arg_35_0.sendTipsText_.text = arg_35_0.sendTipsCD_ .. GetTips("SECOND")
			arg_35_0.sendTipsCD_ = arg_35_0.sendTipsCD_ - 1
		else
			arg_35_0.sendCDStateController_:SetSelectedState("false")
		end
	end, 1, -1)

	arg_35_0.sendTipsTimer_:Start()
	arg_35_0:RegistEventListener(CHAT_NEW_CHANNEL, handler(arg_35_0, arg_35_0.OnSwitchChannel))
	arg_35_0:RegistEventListener(CHAT_REPORT, handler(arg_35_0, arg_35_0.OnChatReport))
	arg_35_0:RegistEventListener(CHAT_REPORT_HIDE, handler(arg_35_0, arg_35_0.OnHideChatReport))
	arg_35_0:RegistEventListener(CHAT_NEW_MESSAGE, handler(arg_35_0, arg_35_0.OnReceiveMessage))
	arg_35_0:RegistEventListener(CHAT_GUILD_NEW_MESSAGE, handler(arg_35_0, arg_35_0.OnReceiveGuildMessage))
	arg_35_0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(arg_35_0, arg_35_0.OnReceiveCooperationMessage))
	arg_35_0:RegistEventListener(CHAT_SEND_STICKER, handler(arg_35_0, arg_35_0.OnSendSticker))
	arg_35_0:RegistEventListener(CHAT_WORLD_RESET, handler(arg_35_0, arg_35_0.OnResetWorldChat))
	arg_35_0:RegistEventListener(CHAT_GUILD_RESET, handler(arg_35_0, arg_35_0.OnResetGuildChat))
	arg_35_0:RegistEventListener(CHAT_COOPERATION_RESET, handler(arg_35_0, arg_35_0.OnResetCooperationChat))
	arg_35_0:RegistEventListener(CHAT_FRIEND_NEW_MESSAGE, handler(arg_35_0, arg_35_0.OnReceiveFriendMsg))
	arg_35_0:RegistEventListener(CHAT_FRIEND_CHAT_RESET, handler(arg_35_0, arg_35_0.OnRecallFriendMsg))
	manager.redPoint:bindUIandKey(arg_35_0.friendsTabBtn_.transform, RedPointConst.FRIEND_MY_FRIENDS)
end

function var_0_0.OnExit(arg_37_0)
	arg_37_0.params_.chatToggleID = arg_37_0.chatToggleID_
	arg_37_0.params_.friendID = arg_37_0.curfriendID_

	if arg_37_0.sendTipsTimer_ then
		arg_37_0.sendTipsTimer_:Stop()

		arg_37_0.sendTipsTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_37_0.friendsTabBtn_.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.notify:Invoke(CHAT_REPORT_HIDE)
	arg_37_0.chatStickerView_:OnExit()
	arg_37_0:StopReguireMessageTimer()
	arg_37_0:RemoveAllEventListener()

	if arg_37_0.params_.ignoreBG ~= true then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	end
end

function var_0_0.UpdateSendTimeCD(arg_38_0)
	local var_38_0 = ChatData:GetLevelTextTimeStamp(arg_38_0.chatToggleID_)

	if manager.time:GetServerTime() - var_38_0 < GameSetting.chat_speech_interval.value[3] then
		arg_38_0.sendTipsCD_ = GameSetting.chat_speech_interval.value[3] - manager.time:GetServerTime() + var_38_0
		arg_38_0.sendTipsText_.text = arg_38_0.sendTipsCD_ .. GetTips("SECOND")

		arg_38_0.sendCDStateController_:SetSelectedState("true")
	else
		arg_38_0.sendTipsCD_ = 0

		arg_38_0.sendCDStateController_:SetSelectedState("false")
	end
end

function var_0_0.GetPlayBackwardsAnimator(arg_39_0)
	return {
		{
			arg_39_0.mainAnimator_,
			"view_out",
			false
		}
	}, nil
end

function var_0_0.IndexFriendsItem(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = ChatFriendData:GetCacheHeroList()[arg_40_1]

	arg_40_2:SetData(var_40_0, arg_40_1, arg_40_0.curfriendID_, function()
		if var_40_0 == arg_40_0.curfriendID_ then
			return
		end

		if arg_40_0.curfriendID_ and arg_40_0.curfriendID_ ~= 0 then
			local var_41_0 = table.keyof(ChatFriendData:GetCacheHeroList(), arg_40_0.curfriendID_)

			arg_40_0.friendsLuaUIlist_:GetItemByIndex(var_41_0):SetSelectState(false)
		end

		arg_40_2:SetSelectState(true)
		arg_40_0:RefreshFriends(var_40_0)
	end)
end

function var_0_0.SetCamera(arg_42_0)
	local var_42_0 = HomeSceneSettingData:GetCurScene()
	local var_42_1 = manager.loadScene:GetTimeSceneID(var_42_0)

	if PosterGirlConst.PosterGirlTag.t0 == manager.posterGirl:GetTag() then
		local var_42_2 = manager.posterGirl:GetViewDirect()

		if var_42_2 ~= 0 then
			local var_42_3 = string.format("chat_%d_%d", var_42_1, var_42_2)

			manager.ui:SetMainCamera(var_42_3)
		elseif CameraCfg["t0_chat_" .. var_42_1] then
			manager.ui:SetMainCamera("t0_chat_" .. var_42_1)
		elseif CameraCfg["chat_" .. var_42_1] then
			manager.ui:SetMainCamera("chat_" .. var_42_1)
		else
			manager.ui:SetMainCamera("chat")
		end
	else
		local var_42_4 = "chat_" .. var_42_1

		if CameraCfg[var_42_4] then
			manager.ui:SetMainCamera(var_42_4)
		else
			manager.ui:SetMainCamera("chat")
		end
	end
end

function var_0_0.UpdatePublicMainTab(arg_43_0)
	arg_43_0.tabStateController_:SetSelectedState("publicChannel")

	if arg_43_0.params_.soloHeartChange then
		arg_43_0.soloStateController_:SetSelectedState("true")
	else
		arg_43_0.soloStateController_:SetSelectedState("false")

		arg_43_0.stackoverflowProtect = nil
		arg_43_0.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1
		arg_43_0.channelText_.text = ChatData:GetWorldChannelNum()

		ChatAction.EnterChatUI(1)
	end

	local var_43_0 = arg_43_0.params_.chatToggleID

	if var_43_0 == ChatConst.CHAT_CHANNEL_FRIEND then
		var_43_0 = ChatConst.CHAT_CHANNEL_WORLD
	end

	arg_43_0:InitActivitySubTab()

	if arg_43_0.params_.isBack == nil then
		arg_43_0.historySeek_ = {}
	end

	if var_43_0 == ChatConst.CHAT_CHANNEL_COOPERATION then
		SetActive(arg_43_0.cooperTabBtn_.gameObject, true)
	else
		SetActive(arg_43_0.cooperTabBtn_.gameObject, false)
	end

	arg_43_0:RefreshToggle(var_43_0)
	arg_43_0:OnHideChatReport()
end

function var_0_0.InitActivitySubTab(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.activityTabItemList_) do
		iter_44_1:Show(false)
	end

	for iter_44_2, iter_44_3 in pairs(ChatToggleCfg.all) do
		if iter_44_3 == ChatConst.CHAT_CHANNEL_MOON_CAKE and manager.windowBar:GetWhereTag() == "guildActivitySP" then
			-- block empty
		elseif ChatTools.IsOpenChatChannel(iter_44_3) then
			arg_44_0.activityTabItemList_[iter_44_3] = arg_44_0.activityTabItemList_[iter_44_3] or ChatSubTabItem.New(arg_44_0.activityTabGo_, arg_44_0.subTabRootTrs_, iter_44_3, function()
				arg_44_0:RefreshToggle(iter_44_3)
			end)

			arg_44_0.activityTabItemList_[iter_44_3]:Show(true)
		end
	end
end

function var_0_0.RefreshToggle(arg_46_0, arg_46_1)
	arg_46_0.worldTabStateController_:SetSelectedState("cancel")
	arg_46_0.guildTabStateController_:SetSelectedState(GuildData:GetGuildInfo().id == nil and "lock" or "unlock")

	local var_46_0 = PlayerData:GetPlayerInfo().userLevel
	local var_46_1 = GameSetting.club_recruit_unlock_level.value[1]

	arg_46_0.recruitTabStateController_:SetSelectedState(var_46_0 < var_46_1 and "lock" or "unlock")
	arg_46_0.cooperTabStateController_:SetSelectedState("cancel")

	for iter_46_0, iter_46_1 in pairs(arg_46_0.activityTabItemList_) do
		iter_46_1:SetTabState(false)
	end

	if arg_46_1 == ChatConst.CHAT_CHANNEL_WORLD then
		arg_46_0.worldTabStateController_:SetSelectedState("select")
	elseif arg_46_1 == ChatConst.CHAT_CHANNEL_GUILD then
		arg_46_0.guildTabStateController_:SetSelectedState("select")
	elseif arg_46_1 == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		arg_46_0.recruitTabStateController_:SetSelectedState("select")
	elseif arg_46_1 == ChatConst.CHAT_CHANNEL_COOPERATION then
		arg_46_0.cooperTabStateController_:SetSelectedState("select")
	else
		arg_46_0.activityTabItemList_[arg_46_1]:SetTabState(true)
	end

	arg_46_0:SwitchChannel(arg_46_1)
end

function var_0_0.SwitchChannel(arg_47_0, arg_47_1)
	arg_47_0.chatToggleID_ = arg_47_1

	arg_47_0:UpdateSendTimeCD()

	if arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD and GuildData:GetGuildInfo().id == nil then
		arg_47_0.emptyStateController_:SetSelectedState("noguild")
		ShowTips("NEED_JOIN_CLUB")
	elseif arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		arg_47_0.emptyStateController_:SetSelectedState("nosend")
	elseif ChatToggleCfg[arg_47_0.chatToggleID_] ~= nil then
		local var_47_0 = ChatToggleCfg[arg_47_0.chatToggleID_]

		arg_47_0.emptyStateController_:SetSelectedState(var_47_0.hide_send_btn == 1 and "nosend" or "normal")
	else
		arg_47_0.emptyStateController_:SetSelectedState("normal")
	end

	if arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT or arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		arg_47_0:AddReguireMessageTimer()
	elseif arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		arg_47_0:AddReguireMessageTimer()
	elseif ChatToggleCfg[arg_47_0.chatToggleID_] ~= nil and ChatToggleCfg[arg_47_0.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL then
		arg_47_0:AddReguireMessageTimer()
	end

	if arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		local var_47_1 = ChatGuildData:InitCacheGuildContent()

		if var_47_1 ~= 0 and var_47_1 ~= #ChatGuildData:GetCacheContent() then
			arg_47_0.historySeek_[arg_47_0.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = var_47_1
			}
		end
	elseif arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
	elseif arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		local var_47_2 = ChatCooperationData:InitCacheCooperationContent()

		if var_47_2 ~= 0 and var_47_2 ~= #ChatCooperationData:GetCacheContent() then
			arg_47_0.historySeek_[arg_47_0.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = var_47_2
			}
		end
	elseif arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		ActivityRecallData:InitCacheContent()
	elseif arg_47_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		AutoChessCardData:InitCacheContent()
	elseif ChatToggleCfg[arg_47_0.chatToggleID_] then
		ChatChannelData:InitCacheContent(arg_47_0.chatToggleID_)
	end

	arg_47_0.loopScrollView_:SetContentHeight(arg_47_0.diaViewPortTrs_.rect.height)

	if arg_47_0.historySeek_[arg_47_0.chatToggleID_] then
		arg_47_0.loopScrollView_:RestoredScroll(arg_47_0.historySeek_[arg_47_0.chatToggleID_].index, arg_47_0.historySeek_[arg_47_0.chatToggleID_].verticalNormalizedPosition)
	else
		arg_47_0.loopScrollView_:Scroll2End()
	end

	arg_47_0.chatSeek_[arg_47_0.chatToggleID_] = arg_47_0.chatSeek_[arg_47_0.chatToggleID_] or 0

	SetActive(arg_47_0.newJumpBtn_.gameObject, arg_47_0.chatSeek_[arg_47_0.chatToggleID_] < #arg_47_0:LsGetItemData())
end

function var_0_0.UpdateFriendsMainTab(arg_48_0)
	arg_48_0.chatToggleID_ = ChatConst.CHAT_CHANNEL_FRIEND

	arg_48_0:UpdateSendTimeCD()

	local var_48_0 = ChatFriendData:GetCacheHeroList()

	arg_48_0.tabStateController_:SetSelectedState(#var_48_0 > 0 and "friendsChannel" or "friendsEmpty")
	arg_48_0.emptyStateController_:SetSelectedState(#var_48_0 > 0 and "normal" or "nothing")
	SetActive(arg_48_0.friendCancelBtn_.gameObject, false)

	if #var_48_0 > 0 then
		local var_48_1 = arg_48_0.params_.friendID or var_48_0[1]

		arg_48_0:RefreshFriends(var_48_1)
	else
		arg_48_0.friendsLuaUIlist_:StartScroll(0)
	end
end

function var_0_0.RefreshFriends(arg_49_0, arg_49_1)
	arg_49_0.curfriendID_ = arg_49_1

	local var_49_0 = 1

	if arg_49_0.curfriendID_ and arg_49_0.curfriendID_ ~= 0 then
		local var_49_1 = table.keyof(ChatFriendData:GetCacheHeroList(), arg_49_0.curfriendID_)

		ChatFriendData:LockFriendID(arg_49_0.curfriendID_)
		arg_49_0.friendsLuaUIlist_:StartScroll(#ChatFriendData:GetCacheHeroList())
		arg_49_0.friendsLuaUIlist_:ScrollToIndex(var_49_1, false, false)
		arg_49_0:RefreshFriendTitle()
		arg_49_0.loopScrollView_:Scroll2End()
	else
		arg_49_0.friendsLuaUIlist_:StartScroll(0)
	end
end

function var_0_0.RefreshFriendTitle(arg_50_0)
	local var_50_0 = FriendsData:GetInfoByID(arg_50_0.curfriendID_)

	if var_50_0 == false then
		print("unfind friend data", arg_50_0.curfriendID_)

		return
	end

	arg_50_0.friendsIpText_.text = var_50_0.ip
	arg_50_0.friendNameText_.text = GetI18NText(var_50_0.nick)
	arg_50_0.friendSignText_.text = GetI18NText(var_50_0.sign)

	arg_50_0.onlineStateController_:SetSelectedState(var_50_0.online_state == 0 and "on" or "off")
end

function var_0_0.OnFriendsDelect(arg_51_0, arg_51_1)
	if arg_51_0.chatToggleID_ ~= ChatConst.CHAT_CHANNEL_FRIEND then
		return
	end

	local var_51_0 = ChatFriendData:GetCacheHeroList()

	arg_51_0.tabStateController_:SetSelectedState(#var_51_0 > 0 and "friendsChannel" or "friendsEmpty")
	arg_51_0.emptyStateController_:SetSelectedState(#var_51_0 > 0 and "normal" or "nothing")
	SetActive(arg_51_0.friendCancelBtn_.gameObject, false)

	if arg_51_0.curfriendID_ ~= arg_51_1 then
		arg_51_0.friendsLuaUIlist_:StartScroll(#var_51_0)

		return
	end

	if #var_51_0 > 0 then
		local var_51_1 = var_51_0[1]

		arg_51_0:RefreshFriends(var_51_1)
	else
		arg_51_0.friendsLuaUIlist_:StartScroll(0)
	end
end

function var_0_0.OnReceiveFriendMsg(arg_52_0, arg_52_1)
	if arg_52_0.chatToggleID_ ~= ChatConst.CHAT_CHANNEL_FRIEND then
		return
	end

	if arg_52_0.tabStateController_:GetSelectedState() == "friendsEmpty" then
		local var_52_0 = ChatFriendData:GetCacheHeroList()

		arg_52_0.tabStateController_:SetSelectedState(#var_52_0 > 0 and "friendsChannel" or "friendsEmpty")
		arg_52_0.emptyStateController_:SetSelectedState(#var_52_0 > 0 and "normal" or "nothing")

		if #var_52_0 > 0 then
			local var_52_1 = var_52_0[1]

			arg_52_0:RefreshFriends(var_52_1)
		else
			arg_52_0.friendsLuaUIlist_:StartScroll(0)
		end

		return
	end

	arg_52_0.friendsLuaUIlist_:StartScroll(#ChatFriendData:GetCacheHeroList())

	if arg_52_0.curfriendID_ ~= arg_52_1 then
		return
	end

	for iter_52_0 = 0, ChatFriendData:GetUnreadMsgCnt(arg_52_1) - 1 do
		if arg_52_0:LsGetItemData()[#arg_52_0:LsGetItemData() - iter_52_0].senderID == USER_ID then
			arg_52_0.loopScrollView_:Scroll2End()
			ChatFriendData:UpdateSeek(arg_52_0.curfriendID_)

			return
		end
	end

	if not arg_52_0.loopScrollView_:IsFillContent() or arg_52_0.diaScrollEx_.verticalNormalizedPosition <= 0.0001 then
		arg_52_0.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(arg_52_0.curfriendID_)

		return
	end

	SetActive(arg_52_0.newJumpBtn_.gameObject, true)
	arg_52_0.loopScrollView_:RefreshScrollView()
end

function var_0_0.CloseCurFriendChat(arg_53_0)
	ChatFriendData:RemoveCacheHero(arg_53_0.curfriendID_)
	ChatFriendData:SaveRecordCnt(arg_53_0.curfriendID_)
	FriendsAction:RefreshUnread(arg_53_0.curfriendID_, 0)

	local var_53_0 = ChatFriendData:GetCacheHeroList()

	if #var_53_0 > 0 then
		arg_53_0:RefreshFriends(var_53_0[1])
	else
		arg_53_0.tabStateController_:SetSelectedState("friendsEmpty")
		arg_53_0.emptyStateController_:SetSelectedState("nothing")
		arg_53_0:RefreshFriends()
	end
end

function var_0_0.AddReguireMessageTimer(arg_54_0)
	arg_54_0:TryToRequireMsg()

	if arg_54_0.reguireMessageTimer_ ~= nil then
		return
	end

	arg_54_0.reguireMessageTimer_ = Timer.New(function()
		arg_54_0:TryToRequireMsg()
	end, 1, -1)

	arg_54_0.reguireMessageTimer_:Start()
end

function var_0_0.StopReguireMessageTimer(arg_56_0)
	if arg_56_0.reguireMessageTimer_ then
		arg_56_0.reguireMessageTimer_:Stop()

		arg_56_0.reguireMessageTimer_ = nil
	end
end

function var_0_0.TryToRequireMsg(arg_57_0)
	if arg_57_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT and manager.time:GetServerTime() - ChatGuildRecruitData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		ChatAction.RequireGuildShareInfo()
	elseif arg_57_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL and manager.time:GetServerTime() - ActivityRecallData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		ChatAction.RequireRecallInfo()
	elseif arg_57_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS and manager.time:GetServerTime() - AutoChessCardData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		AutoChessCardAction.RequestShareRecord()
	elseif ChatToggleCfg[arg_57_0.chatToggleID_] and ChatToggleCfg[arg_57_0.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL and ChatToggleCfg[arg_57_0.chatToggleID_].require_type[2][1] < manager.time:GetServerTime() - ChatChannelData:GetLastRequireMsgTimestamp(arg_57_0.chatToggleID_) then
		ChatAction.RequireChatNormalMsg(arg_57_0.chatToggleID_)
	end
end

function var_0_0.GetChatJudgeMessageType(arg_58_0, arg_58_1)
	local var_58_0 = ({
		[ChatConst.CHAT_CHANNEL_WORLD] = JUDGE_MESSAGE_TYPE.CHAT_WORLD,
		[ChatConst.CHAT_CHANNEL_FRIEND] = JUDGE_MESSAGE_TYPE.CHAT_FRIEND,
		[ChatConst.CHAT_CHANNEL_GUILD] = JUDGE_MESSAGE_TYPE.CHAT_GUILD,
		[ChatConst.CHAT_CHANNEL_GUILD_RECRUIT] = JUDGE_MESSAGE_TYPE.GUILD_SHARE,
		[ChatConst.CHAT_CHANNEL_COOPERATION] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8] = JUDGE_MESSAGE_TYPE.OTHER,
		[ChatConst.CHAT_CHANNEL_MOON_CAKE] = JUDGE_MESSAGE_TYPE.ACTIVITY_MOON_CAKE
	})[arg_58_1]

	if var_58_0 then
		return var_58_0
	end
end

function var_0_0.LsGetItemData(arg_59_0)
	if arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		return ChatData:GetWorldChatData()
	elseif arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		return ChatGuildData:GetCacheContent()
	elseif arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		return ChatGuildRecruitData:GetChatData()
	elseif arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		return ChatCooperationData:GetCacheContent()
	elseif arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		return ActivityRecallData:GetChatData()
	elseif arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		return AutoChessCardData:GetChatData()
	elseif ChatToggleCfg[arg_59_0.chatToggleID_] then
		return ChatChannelData:GetCacheContent(arg_59_0.chatToggleID_)
	elseif arg_59_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
		return ChatFriendData:GetCacheContent(arg_59_0.curfriendID_)
	else
		return {}
	end
end

function var_0_0.ParseFriendData(arg_60_0, arg_60_1)
	if not arg_60_1.senderID then
		return arg_60_1
	end

	local var_60_0 = {
		id = arg_60_1.senderID,
		content = arg_60_1.content,
		contentType = arg_60_1.contentType,
		msgID = arg_60_1.msgID,
		timestamp = arg_60_1.timestamp
	}

	var_60_0.roomID = 0

	local var_60_1 = arg_60_1.senderID

	if var_60_1 == USER_ID then
		local var_60_2 = PlayerData:GetPlayerInfo()

		var_60_0.bubbleID = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]
		var_60_0.icon = var_60_2.portrait
		var_60_0.iconFrame = var_60_2.icon_frame
		var_60_0.ip = var_60_2.ip
		var_60_0.nick = var_60_2.nick
	else
		local var_60_3 = FriendsData:GetInfoByID(var_60_1)

		var_60_0.bubbleID = var_60_3.bubbleID or GameSetting.profile_chat_bubble_default.value[1]
		var_60_0.icon = var_60_3.icon
		var_60_0.iconFrame = var_60_3.icon_frame
		var_60_0.ip = var_60_3.ip
		var_60_0.nick = var_60_3.nick
	end

	return var_60_0
end

function var_0_0.LsAddItem(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_0:ParseFriendData(arg_61_1)
	local var_61_1

	if var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.CHANNEL then
		var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemChannelPool_, function()
			return ChatChannelView.New(arg_61_0.channelTitleGo_, arg_61_0.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
		var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemTimePool_, function()
			return ChatTimeView.New(arg_61_0.timeStampGo_, arg_61_0.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
		var_61_1 = arg_61_0:GetFreeItem(arg_61_0.historyTipsPool_, function()
			return ChatFriendHistoryTipsItem.New(arg_61_0.historyTipsGo_, arg_61_0.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT then
		if var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) then
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemSelfGuildRecruitPool_, function()
				return ChatGuildRecruitItemView.New(arg_61_0.recruitSelfGo_, arg_61_0.diaGridGo_)
			end)
		else
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemFriendGuildRecruitPool_, function()
				return ChatGuildRecruitItemView.New(arg_61_0.recruitOtherGo_, arg_61_0.diaGridGo_)
			end)
		end
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.JUMP then
		local var_61_2 = var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID)
		local var_61_3 = arg_61_0:GetJumpItemClass()

		if var_61_2 then
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemSelfJumpPool_, function()
				return var_61_3.New(arg_61_0.jumpSelfGo_, arg_61_0.diaGridGo_)
			end)
		else
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemFriendJumptPool_, function()
				return var_61_3.New(arg_61_0.jumpOtherGo_, arg_61_0.diaGridGo_)
			end)
		end
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.RECALL then
		if var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) then
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemSelfRecallPool_, function()
				return ChatRecallItemView.New(arg_61_0.recallSelfGo_, arg_61_0.diaGridGo_)
			end)
		else
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemFriendRecallPool_, function()
				return ChatRecallItemView.New(arg_61_0.recallOtherGo_, arg_61_0.diaGridGo_)
			end)
		end
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.AUTO_CHESS then
		if var_61_0.userId == tostring(PlayerData:GetPlayerInfo().userID) then
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemSelfAutoChessPool_, function()
				return AutoChessCardChatItemView.New(arg_61_0.autoChessSelfGo_, arg_61_0.diaGridGo_)
			end)
		else
			var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemFriendAutoChessPool_, function()
				return AutoChessCardChatItemView.New(arg_61_0.autoChessOtherGo_, arg_61_0.diaGridGo_)
			end)
		end
	elseif var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) then
		var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemSelfPool_, function()
			return ChatItemView.New(arg_61_0.chatSelfGo_, arg_61_0.diaGridGo_, arg_61_0.diaScrollEx_)
		end)
	else
		var_61_1 = arg_61_0:GetFreeItem(arg_61_0.itemFriendPool_, function()
			return ChatItemView.New(arg_61_0.chatOtherGo_, arg_61_0.diaGridGo_, arg_61_0.diaScrollEx_)
		end)
	end

	var_61_1.itemView:SetData(var_61_0, arg_61_2)

	arg_61_0.chatSeek_[arg_61_0.chatToggleID_] = arg_61_0.chatSeek_[arg_61_0.chatToggleID_] or 0

	if arg_61_2 > arg_61_0.chatSeek_[arg_61_0.chatToggleID_] then
		arg_61_0.chatSeek_[arg_61_0.chatToggleID_] = arg_61_2
	end

	if arg_61_2 >= #arg_61_0:LsGetItemData() then
		SetActive(arg_61_0.newJumpBtn_.gameObject, false)
	end

	if arg_61_0.curfriendID_ and arg_61_0.curfriendID_ ~= 0 then
		local var_61_4 = ChatFriendData:GetUnreadMsgCnt(arg_61_0.curfriendID_)

		if arg_61_2 >= #arg_61_0:LsGetItemData() then
			ChatFriendData:SaveRecordCnt(arg_61_0.curfriendID_)
			FriendsAction:RefreshUnread(arg_61_0.curfriendID_, 0)
		else
			local var_61_5 = #arg_61_0:LsGetItemData() - arg_61_2

			if var_61_5 < var_61_4 then
				ChatFriendData:SaveRecordCnt(arg_61_0.curfriendID_, var_61_5)
				FriendsAction:RefreshUnread(arg_61_0.curfriendID_, var_61_5)
			end
		end
	end

	if arg_61_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:SaveRecordCnt()
	elseif ChatToggleCfg[arg_61_0.chatToggleID_] then
		ChatChannelData:SaveRecordCnt(arg_61_0.chatToggleID_)
	end

	return var_61_1
end

function var_0_0.LsUpdateItem(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
	local var_75_0 = arg_75_0:ParseFriendData(arg_75_2)

	arg_75_1.itemView:SetData(var_75_0, arg_75_3)
end

function var_0_0.LsRemoveItem(arg_76_0, arg_76_1)
	arg_76_1.itemView:Show(false)

	arg_76_1.isFree = true
end

function var_0_0.GetJumpItemClass(arg_77_0)
	if arg_77_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_MOON_CAKE then
		return MoonCakeChatJumpItemView
	else
		return ChatJumpItemView
	end
end

function var_0_0.InitItemPool(arg_78_0)
	arg_78_0.itemChannelPool_ = {}
	arg_78_0.itemTimePool_ = {}
	arg_78_0.itemSelfPool_ = {}
	arg_78_0.itemFriendPool_ = {}
	arg_78_0.itemSelfGuildRecruitPool_ = {}
	arg_78_0.itemFriendGuildRecruitPool_ = {}
	arg_78_0.historyTipsPool_ = {}
	arg_78_0.itemSelfJumpPool_ = {}
	arg_78_0.itemFriendJumptPool_ = {}
	arg_78_0.itemSelfRecallPool_ = {}
	arg_78_0.itemFriendRecallPool_ = {}
	arg_78_0.itemSelfAutoChessPool_ = {}
	arg_78_0.itemFriendAutoChessPool_ = {}
end

function var_0_0.GetFreeItem(arg_79_0, arg_79_1, arg_79_2)
	for iter_79_0, iter_79_1 in pairs(arg_79_1) do
		if iter_79_1.isFree == true then
			iter_79_1.isFree = false

			return iter_79_1
		end
	end

	local var_79_0 = {
		isFree = false,
		itemView = arg_79_2()
	}

	table.insert(arg_79_1, var_79_0)

	return var_79_0
end

function var_0_0.DisposeItemPool(arg_80_0)
	for iter_80_0, iter_80_1 in ipairs(arg_80_0.itemChannelPool_) do
		iter_80_1.itemView:Dispose()
	end

	arg_80_0.itemChannelPool_ = nil

	for iter_80_2, iter_80_3 in ipairs(arg_80_0.itemTimePool_) do
		iter_80_3.itemView:Dispose()
	end

	arg_80_0.itemTimePool_ = nil

	for iter_80_4, iter_80_5 in ipairs(arg_80_0.itemSelfPool_) do
		iter_80_5.itemView:Dispose()
	end

	arg_80_0.itemSelfPool_ = nil

	for iter_80_6, iter_80_7 in ipairs(arg_80_0.itemFriendPool_) do
		iter_80_7.itemView:Dispose()
	end

	arg_80_0.itemFriendPool_ = nil

	for iter_80_8, iter_80_9 in ipairs(arg_80_0.itemSelfGuildRecruitPool_) do
		iter_80_9.itemView:Dispose()
	end

	for iter_80_10, iter_80_11 in ipairs(arg_80_0.itemFriendGuildRecruitPool_) do
		iter_80_11.itemView:Dispose()
	end

	for iter_80_12, iter_80_13 in ipairs(arg_80_0.historyTipsPool_) do
		iter_80_13.itemView:Dispose()
	end

	for iter_80_14, iter_80_15 in ipairs(arg_80_0.itemSelfJumpPool_) do
		iter_80_15.itemView:Dispose()
	end

	arg_80_0.itemSelfJumpPool_ = nil

	for iter_80_16, iter_80_17 in ipairs(arg_80_0.itemFriendJumptPool_) do
		iter_80_17.itemView:Dispose()
	end

	arg_80_0.itemFriendJumptPool_ = nil

	for iter_80_18, iter_80_19 in ipairs(arg_80_0.itemSelfRecallPool_) do
		iter_80_19.itemView:Dispose()
	end

	arg_80_0.itemSelfRecallPool_ = nil

	for iter_80_20, iter_80_21 in ipairs(arg_80_0.itemFriendRecallPool_) do
		iter_80_21.itemView:Dispose()
	end

	arg_80_0.itemFriendRecallPool_ = nil

	for iter_80_22, iter_80_23 in ipairs(arg_80_0.itemSelfAutoChessPool_) do
		iter_80_23.itemView:Dispose()
	end

	arg_80_0.itemSelfAutoChessPool_ = nil

	for iter_80_24, iter_80_25 in ipairs(arg_80_0.itemFriendAutoChessPool_) do
		iter_80_25.itemView:Dispose()
	end

	arg_80_0.itemFriendAutoChessPool_ = nil
end

function var_0_0.RefreshReceiveMessage(arg_81_0)
	local var_81_0 = arg_81_0:LsGetItemData()[#arg_81_0:LsGetItemData()]

	if var_81_0 == nil then
		return
	end

	for iter_81_0 = arg_81_0.chatSeek_[arg_81_0.chatToggleID_] + 1, #arg_81_0:LsGetItemData() do
		if arg_81_0:LsGetItemData()[iter_81_0].id == USER_ID then
			arg_81_0.loopScrollView_:Scroll2End()

			return
		end
	end

	if var_81_0.id == USER_ID then
		arg_81_0.loopScrollView_:Scroll2End()

		return
	end

	if not arg_81_0.loopScrollView_:IsFillContent() or arg_81_0.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		arg_81_0.loopScrollView_:Scroll2End()

		return
	end

	SetActive(arg_81_0.newJumpBtn_.gameObject, true)
end

function var_0_0.SendMessageResult(arg_82_0, arg_82_1)
	if isSuccess(arg_82_1.result) then
		if arg_82_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[arg_82_0.chatToggleID_] and ChatToggleCfg[arg_82_0.chatToggleID_].limit_type == 1 then
			ChatData:SetLevelTextTimeStamp(arg_82_0.chatToggleID_)
		end

		ChatData:SetSendTextTimestamp()
		arg_82_0:UpdateSendTimeCD()

		arg_82_0.sendInputfield_.text = ""
	elseif arg_82_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				arg_82_0:Back()
			end
		})
	elseif arg_82_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		arg_82_0.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_82_1.result)
	end
end

function var_0_0.OnSwitchChannel(arg_84_0)
	if arg_84_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		arg_84_0.loopScrollView_:Scroll2End()
	end
end

function var_0_0.OnRecallFriendMsg(arg_85_0, arg_85_1)
	if arg_85_0.curfriendID_ ~= arg_85_1 then
		return
	end

	arg_85_0.loopScrollView_:RefreshScrollView(true)
	SetActive(arg_85_0.newJumpBtn_.gameObject, ChatFriendData:GetUnreadMsgCnt(arg_85_1) > 0)
end

function var_0_0.OnChatReport(arg_86_0, arg_86_1)
	arg_86_0.reportTrs_:SetParent(arg_86_1.parentRect.transform, false)

	arg_86_0.reportTrs_.localPosition = Vector2(arg_86_1.x, arg_86_1.y)
	arg_86_0.reportData_ = arg_86_1.reportData

	SetActive(arg_86_0.reportGo_, true)
end

function var_0_0.OnHideChatReport(arg_87_0)
	SetActive(arg_87_0.reportGo_, false)
end

function var_0_0.OnReceiveMessage(arg_88_0, arg_88_1)
	local var_88_0 = arg_88_1.chatToggleID

	if arg_88_0.chatToggleID_ ~= var_88_0 then
		return
	end

	if arg_88_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		arg_88_0:RefreshReceiveMessage()
	elseif arg_88_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		if #arg_88_0.loopScrollView_:GetItemList() <= 0 then
			arg_88_0.loopScrollView_:Scroll2End()
		else
			arg_88_0.loopScrollView_:RefreshScrollView(true, true)
		end
	elseif ChatToggleCfg[arg_88_0.chatToggleID_] then
		arg_88_0:RefreshReceiveMessage()
	end
end

function var_0_0.OnReceiveGuildMessage(arg_89_0)
	if arg_89_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		arg_89_0:RefreshReceiveMessage()
	end
end

function var_0_0.OnReceiveCooperationMessage(arg_90_0)
	if arg_90_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		arg_90_0:RefreshReceiveMessage()
	end
end

function var_0_0.OnSendSticker(arg_91_0, arg_91_1)
	if ChatToggleCfg[arg_91_0.chatToggleID_] and not ChatTools.IsOpenChatChannel(arg_91_0.chatToggleID_) then
		ShowTips("TIME_OVER")

		return
	end

	arg_91_0:HideStickerPanel()

	if ChatData:IsMuted() then
		arg_91_0.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if arg_91_0.sendTipsCD_ > 0 or manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_MESSAGE_FREQUENTLY")

		return
	end

	if arg_91_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		ChatAction.SendSticker(arg_91_1, function(arg_92_0)
			arg_91_0:SendStickerResult(arg_92_0)
		end)
	elseif arg_91_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		if GuildData:GetGuildInfo().id == nil then
			ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

			return
		end

		ChatAction.SendGuildSticker(arg_91_1, function(arg_93_0)
			arg_91_0:SendStickerResult(arg_93_0)
		end)
	elseif arg_91_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatAction.SendGuildRecruitSticker(arg_91_1, function(arg_94_0)
			arg_91_0:SendStickerResult(arg_94_0)
		end)
	elseif ChatToggleCfg[arg_91_0.chatToggleID_] then
		ChatAction.SendChatNormalSticker(arg_91_0.chatToggleID_, arg_91_1, function(arg_95_0)
			arg_91_0:SendStickerResult(arg_95_0)
		end)
	elseif arg_91_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if not CooperationData:CheckInRoom() then
			ShowTips("ERROR_INVALID_OPERATION")

			return
		end

		ChatAction.SendCooperationSticker(arg_91_1, function(arg_96_0)
			arg_91_0:SendStickerResult(arg_96_0)
		end)
	elseif arg_91_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
		ChatAction.SendFriendSticker(arg_91_0.curfriendID_, arg_91_1, function(arg_97_0)
			if isSuccess(arg_97_0.result) then
				ChatData:SetSendStickerTimestamp()

				arg_91_0.sendInputfield_.text = ""
			end
		end)
	else
		ShowTips("SEND_MESSAGE_ERROR")
	end
end

function var_0_0.SendStickerResult(arg_98_0, arg_98_1)
	if isSuccess(arg_98_1.result) then
		if arg_98_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[arg_98_0.chatToggleID_] and ChatToggleCfg[arg_98_0.chatToggleID_].limit_type == 1 then
			ChatData:SetLevelTextTimeStamp(arg_98_0.chatToggleID_)
		end

		ChatData:SetSendStickerTimestamp()
		arg_98_0:UpdateSendTimeCD()
	elseif arg_98_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				arg_98_0:Back()
			end
		})
	elseif arg_98_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		arg_98_0.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_98_1.result)
	end
end

function var_0_0.HideStickerPanel(arg_100_0)
	arg_100_0.chatStickerView_:Show(false)
end

function var_0_0.OnResetWorldChat(arg_101_0)
	if arg_101_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[arg_101_0.chatToggleID_] then
		if ChatToggleCfg[arg_101_0.chatToggleID_] then
			ChatChannelData:InitCacheContent(arg_101_0.chatToggleID_)
		end

		arg_101_0.loopScrollView_:RefreshScrollView(true)
	end
end

function var_0_0.OnResetGuildChat(arg_102_0)
	if arg_102_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()
		arg_102_0.loopScrollView_:RefreshScrollView(true)
	elseif arg_102_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
		arg_102_0.loopScrollView_:RefreshScrollView(true)
	end
end

function var_0_0.OnResetCooperationChat(arg_103_0)
	if arg_103_0.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		arg_103_0.loopScrollView_:RefreshScrollView(true)
	end
end

function var_0_0.OnBehind(arg_104_0)
	arg_104_0:OnHideChatReport()
end

function var_0_0.Dispose(arg_105_0)
	for iter_105_0, iter_105_1 in pairs(arg_105_0.activityTabItemList_) do
		iter_105_1:Dispose()
	end

	arg_105_0.activityTabItemList_ = nil

	arg_105_0.loopScrollView_:Dispose()
	arg_105_0.friendsLuaUIlist_:Dispose()
	arg_105_0:DisposeItemPool()

	if arg_105_0.chatStickerView_ then
		arg_105_0.chatStickerView_:Dispose()

		arg_105_0.chatStickerView_ = nil
	end

	var_0_0.super.Dispose(arg_105_0)
end

function var_0_0.OnExitInput(arg_106_0)
	arg_106_0:Back()

	return true
end

return var_0_0
