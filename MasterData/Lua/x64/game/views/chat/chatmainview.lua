local ChatMainView = class("ChatMainView", ReduxView)

function ChatMainView:UIName()
	return "Widget/System/Chat/HomeDialogueUI"
end

function ChatMainView:UIParent()
	return manager.ui.uiPop.transform
end

function ChatMainView:Init()
	self:InitUI()
	self:AddListeners()
end

function ChatMainView:InitUI()
	self:BindCfgUI()

	self.chatToggleID_ = 0
	self.curfriendID_ = nil
	self.activityTabItemList_ = {}
	self.chatSeek_ = {}
	self.historySeek_ = {}

	self:InitItemPool()

	self.bugText_.text = GetI18NText("招募")
	self.loopScrollView_ = LoopScrollView.New(self, self.diaScrollEx_, self.diaGridTrs_, self.diaViewPortTrs_, self.diaViewPortTrs_.rect.height, self.diaGridTrs_:GetComponent("VerticalLayoutGroup").spacing, true)
	self.friendsLuaUIlist_ = LuaList.New(handler(self, self.IndexFriendsItem), self.friendsUIlist_, ChatFriendsTabItem)
	self.chatStickerView_ = ChatStickerView.New(self.stickerGo_)
	self.emptyStateController_ = self.mainControllerEx_:GetController("emptyState")
	self.tabStateController_ = self.mainControllerEx_:GetController("tabState")
	self.blurStateController_ = self.mainControllerEx_:GetController("blurState")
	self.worldTabStateController_ = self.mainControllerEx_:GetController("worldTabState")
	self.guildTabStateController_ = self.mainControllerEx_:GetController("guildTabState")
	self.recruitTabStateController_ = self.mainControllerEx_:GetController("recruitTabState")
	self.cooperTabStateController_ = self.mainControllerEx_:GetController("cooperTabState")
	self.onlineStateController_ = self.mainControllerEx_:GetController("friendOnlineState")
	self.soloStateController_ = self.mainControllerEx_:GetController("soloState")
	self.sendCDStateController_ = self.mainControllerEx_:GetController("sendCD")
end

function ChatMainView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.worldTabBtn_, nil, function()
		self:RefreshToggle(ChatConst.CHAT_CHANNEL_WORLD)
	end)
	self:AddBtnListener(self.guildTabBtn_, nil, function()
		self:RefreshToggle(ChatConst.CHAT_CHANNEL_GUILD)
	end)
	self:AddBtnListener(self.recruitTabBtn_, nil, function()
		if PlayerData:GetPlayerInfo().userLevel < GameSetting.club_recruit_unlock_level.value[1] then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.club_recruit_unlock_level.value[1]))
		else
			self:RefreshToggle(ChatConst.CHAT_CHANNEL_GUILD_RECRUIT)
		end
	end)
	self:AddBtnListener(self.cooperTabBtn_, nil, function()
		self:RefreshToggle(ChatConst.CHAT_CHANNEL_COOPERATION)
	end)
	self:AddBtnListener(self.sendCDBtn_, nil, function()
		if self.sendInputfield_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if IsAllSpace(self.sendInputfield_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			self.sendInputfield_.text = ""

			return
		end

		ShowTips("SEND_MESSAGE_FREQUENTLY")
	end)
	self:AddBtnListener(self.sendBtn_, nil, function()
		if self.sendInputfield_.text == "" then
			ShowTips("INPUT_CHAT_CONTENT")

			return
		end

		if ChatData:IsMuted() then
			self.sendInputfield_.text = ""

			JumpTools.OpenPageByJump("chatMuted")

			return
		end

		if IsAllSpace(self.sendInputfield_.text) then
			ShowTips("INPUT_CHAT_CONTENT")

			self.sendInputfield_.text = ""

			return
		end

		local var_12_0 = GameSetting.chat_length_max.value[1]
		local var_12_1, var_12_2 = textLimit(self.sendInputfield_.text, GameSetting.chat_length_max.value[1])

		self.sendInputfield_.text = GetI18NText(var_12_1)

		if not var_12_2 then
			ShowTips(string.format(GetTips("ERROR_CHAT_MESSAGE_CONTENT_OVER_SIZE"), var_12_0))

			return
		end

		if not nameRule(var_12_1, true) then
			ShowTips("ERROR_USER_NAME_SYMBOL_WORD")

			return
		end

		WordVerifyBySDK(self.sendInputfield_.text, function(arg_13_0, arg_13_1)
			if not arg_13_0 then
				ShowTips("SENSITIVE_WORD")
			else
				if self.sendInputfield_.text == "" then
					return
				end

				Debug.Log("当前时间：" .. manager.time:GetServerTime())
				Debug.Log("最近发言时间：" .. ChatData:GetSendTextTimestamp())

				if manager.time:GetServerTime() - ChatData:GetSendTextTimestamp() < 10 then
					ShowTips("SEND_MESSAGE_FREQUENTLY")

					return
				end

				if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
					ChatAction.SendMsg(self.sendInputfield_.text, arg_13_1, function(arg_14_0)
						self:SendMessageResult(arg_14_0)
					end)
				elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
					if GuildData:GetGuildInfo().id == nil then
						ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

						return
					end

					ChatAction.SendGuildMsg(self.sendInputfield_.text, arg_13_1, function(arg_15_0)
						self:SendMessageResult(arg_15_0)
					end)
				elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
					ChatAction.SendGuildRecruitMsg(self.sendInputfield_.text, arg_13_1, function(arg_16_0)
						self:SendMessageResult(arg_16_0)
					end)
				elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
					if not CooperationData:CheckInRoom() then
						ShowTips("ERROR_INVALID_OPERATION")

						return
					end

					ChatAction.SendCooperationdMsg(self.sendInputfield_.text, arg_13_1, function(arg_17_0)
						self:SendMessageResult(arg_17_0)
					end)
				elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
					ChatAction.SendFriendMsg(self.curfriendID_, self.sendInputfield_.text, arg_13_1, function(arg_18_0)
						if isSuccess(arg_18_0.result) then
							ChatData:SetSendTextTimestamp()

							self.sendInputfield_.text = ""
						elseif arg_18_0.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
							self.sendInputfield_.text = ""

							JumpTools.OpenPageByJump("chatMuted")

							return
						else
							ShowTips(arg_18_0.result)
						end
					end)
				else
					if ChatToggleCfg[self.chatToggleID_] and not ChatTools.IsOpenChatChannel(self.chatToggleID_) then
						ShowTips("TIME_OVER")

						return
					end

					ChatAction.SendChatNormalMsg(self.chatToggleID_, self.sendInputfield_.text, arg_13_1, function(arg_19_0)
						self:SendMessageResult(arg_19_0)
					end)
				end
			end
		end, self:GetChatJudgeMessageType())
	end)
	self:AddBtnListener(self.stickerBtn_, nil, function()
		self.chatStickerView_:Show(true)
	end)
	self:AddBtnListener(self.stickerHideBtn_, nil, function()
		self:HideStickerPanel()
		self:OnHideChatReport()
	end)
	self:AddBtnListener(self.newJumpBtn_, nil, function()
		self.loopScrollView_:Scroll2End()

		if self.chatSeek_[self.chatToggleID_] == #self:LsGetItemData() then
			SetActive(self.newJumpBtn_.gameObject, false)

			if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
				ChatGuildData:SaveRecordCnt()
			elseif ChatToggleCfg[self.chatToggleID_] then
				ChatChannelData:SaveRecordCnt(self.chatToggleID_)
			end
		end
	end)
	self:AddBtnListener(self.reportBtn_, nil, function()
		self:OnHideChatReport()
		self:HideStickerPanel()
		JumpTools.OpenPageByJump("chatReport", {
			reportType = ChatConst.CHAT_REPORT_TYPE.CONTENT,
			reportData = self.reportData_
		}, ViewConst.SYSTEM_ID.CHAT_REPORT)
	end)
	self:AddBtnListener(self.userSettingBtn_, nil, function()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	self:AddToggleListener(self.channelSelectDd_, function(arg_25_0)
		if self.stackoverflowProtect and self.stackoverflowProtect == arg_25_0 then
			return
		else
			self.stackoverflowProtect = arg_25_0
		end

		local var_25_0 = arg_25_0 + 1

		if arg_25_0 + 1 == ChatData:GetWorldChannelNum() then
			return
		end

		if manager.time:GetServerTime() - ChatData:GetChannelTimestamp() < 5 then
			ShowTips("SWITCH_CHANNEL_FREQUENTLY")

			self.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1

			return
		end

		ChatAction.SetWorldChannelNum(var_25_0, function(arg_26_0)
			if arg_26_0 == 0 then
				ChatData:SetChannelTimestamp()
			else
				self.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1

				ShowTips(arg_26_0)
			end
		end)
	end)
	self:AddBtnListener(self.friendCloseBtn_, nil, function()
		SetActive(self.friendCancelBtn_.gameObject, true)
	end)
	self:AddBtnListener(self.friendCancelBtn_, nil, function()
		SetActive(self.friendCancelBtn_.gameObject, false)
	end)
	self:AddBtnListener(self.friendRemoveBtn_, nil, function()
		SetActive(self.friendCancelBtn_.gameObject, false)
		self:CloseCurFriendChat()
	end)
	self:AddBtnListener(self.publicTabBtn_, nil, function()
		self:UpdatePublicMainTab()
	end)
	self:AddBtnListener(self.friendsTabBtn_, nil, function()
		self:UpdateFriendsMainTab()
	end)
	self:AddBtnListener(self.avatarsystemBtn_, nil, function()
		JumpTools.OpenPageByJump("HeadIconChange", {
			isEnter = true
		})
	end)
	self:AddBtnListener(self.addFriendChatBtn_, nil, function()
		JumpTools.OpenPageByJump("/friendsUI", {
			friendPage = FriendsConst.FRIEND_TYPE.MY_FRIENDS
		}, ViewConst.SYSTEM_ID.FRIEND)
	end)
end

function ChatMainView:ReserveCameraEnter()
	if self.params_.ignoreBG then
		return
	end

	manager.loadScene:SetSceneActive(manager.loadScene:GetHomeShouldLoadSceneName((HomeSceneSettingData:GetCurScene())), true)
end

function ChatMainView:OnEnter()
	FriendsAction:TryToRefreshFriendsView(1)
	manager.windowBar:HideBar()

	if self.params_.ignoreBG ~= true then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.chat)
		self:SetCamera()
	end

	self.blurStateController_:SetSelectedState(self.params_.ignoreBG and "blur" or "none")
	self.chatStickerView_:OnEnter()

	self.curfriendID_ = nil

	if self.params_.chatToggleID ~= ChatConst.CHAT_CHANNEL_FRIEND then
		self:UpdatePublicMainTab()
	else
		self:UpdateFriendsMainTab()
	end

	self.sendTipsCD_ = self.sendTipsCD_ or 0
	self.sendTipsTimer_ = Timer.New(function()
		if self.sendTipsCD_ > 0 then
			self.sendTipsText_.text = self.sendTipsCD_ .. GetTips("SECOND")
			self.sendTipsCD_ = self.sendTipsCD_ - 1
		else
			self.sendCDStateController_:SetSelectedState("false")
		end
	end, 1, -1)

	self.sendTipsTimer_:Start()
	self:RegistEventListener(CHAT_NEW_CHANNEL, handler(self, self.OnSwitchChannel))
	self:RegistEventListener(CHAT_REPORT, handler(self, self.OnChatReport))
	self:RegistEventListener(CHAT_REPORT_HIDE, handler(self, self.OnHideChatReport))
	self:RegistEventListener(CHAT_NEW_MESSAGE, handler(self, self.OnReceiveMessage))
	self:RegistEventListener(CHAT_GUILD_NEW_MESSAGE, handler(self, self.OnReceiveGuildMessage))
	self:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(self, self.OnReceiveCooperationMessage))
	self:RegistEventListener(CHAT_SEND_STICKER, handler(self, self.OnSendSticker))
	self:RegistEventListener(CHAT_WORLD_RESET, handler(self, self.OnResetWorldChat))
	self:RegistEventListener(CHAT_GUILD_RESET, handler(self, self.OnResetGuildChat))
	self:RegistEventListener(CHAT_COOPERATION_RESET, handler(self, self.OnResetCooperationChat))
	self:RegistEventListener(CHAT_FRIEND_NEW_MESSAGE, handler(self, self.OnReceiveFriendMsg))
	self:RegistEventListener(CHAT_FRIEND_CHAT_RESET, handler(self, self.OnRecallFriendMsg))
	manager.redPoint:bindUIandKey(self.friendsTabBtn_.transform, RedPointConst.FRIEND_MY_FRIENDS)
end

function ChatMainView:OnExit()
	self.params_.chatToggleID = self.chatToggleID_
	self.params_.friendID = self.curfriendID_

	if self.sendTipsTimer_ then
		self.sendTipsTimer_:Stop()

		self.sendTipsTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(self.friendsTabBtn_.transform, RedPointConst.FRIEND_MY_FRIENDS)
	manager.notify:Invoke(CHAT_REPORT_HIDE)
	self.chatStickerView_:OnExit()
	self:StopReguireMessageTimer()
	self:RemoveAllEventListener()

	if self.params_.ignoreBG ~= true then
		manager.posterGirl:SetViewTag(PosterGirlConst.ViewTag.null)
	end
end

function ChatMainView:UpdateSendTimeCD()
	local var_38_0 = ChatData:GetLevelTextTimeStamp(self.chatToggleID_)

	if manager.time:GetServerTime() - var_38_0 < GameSetting.chat_speech_interval.value[3] then
		self.sendTipsCD_ = GameSetting.chat_speech_interval.value[3] - manager.time:GetServerTime() + var_38_0
		self.sendTipsText_.text = self.sendTipsCD_ .. GetTips("SECOND")

		self.sendCDStateController_:SetSelectedState("true")
	else
		self.sendTipsCD_ = 0

		self.sendCDStateController_:SetSelectedState("false")
	end
end

function ChatMainView:GetPlayBackwardsAnimator()
	return {
		{
			self.mainAnimator_,
			"view_out",
			false
		}
	}, nil
end

function ChatMainView:IndexFriendsItem(arg_40_1, arg_40_2)
	local var_40_0 = ChatFriendData:GetCacheHeroList()[arg_40_1]

	arg_40_2:SetData(var_40_0, arg_40_1, self.curfriendID_, function()
		if var_40_0 == self.curfriendID_ then
			return
		end

		if self.curfriendID_ and self.curfriendID_ ~= 0 then
			self.friendsLuaUIlist_:GetItemByIndex((table.keyof(ChatFriendData:GetCacheHeroList(), self.curfriendID_))):SetSelectState(false)
		end

		arg_40_2:SetSelectState(true)
		self:RefreshFriends(var_40_0)
	end)
end

function ChatMainView:SetCamera()
	local var_42_0 = manager.loadScene:GetTimeSceneID((HomeSceneSettingData:GetCurScene()))

	if PosterGirlConst.PosterGirlTag.t0 == manager.posterGirl:GetTag() then
		local var_42_1 = manager.posterGirl:GetViewDirect()

		if var_42_1 ~= 0 then
			manager.ui:SetMainCamera((string.format("chat_%d_%d", var_42_0, var_42_1)))
		elseif CameraCfg["t0_chat_" .. var_42_0] then
			manager.ui:SetMainCamera("t0_chat_" .. var_42_0)
		elseif CameraCfg["chat_" .. var_42_0] then
			manager.ui:SetMainCamera("chat_" .. var_42_0)
		else
			manager.ui:SetMainCamera("chat")
		end
	elseif CameraCfg["chat_" .. var_42_0] then
		manager.ui:SetMainCamera("chat_" .. var_42_0)
	else
		manager.ui:SetMainCamera("chat")
	end
end

function ChatMainView:UpdatePublicMainTab()
	self.tabStateController_:SetSelectedState("publicChannel")

	if self.params_.soloHeartChange then
		self.soloStateController_:SetSelectedState("true")
	else
		self.soloStateController_:SetSelectedState("false")

		self.stackoverflowProtect = nil
		self.channelSelectDd_.value = ChatData:GetWorldChannelNum() - 1
		self.channelText_.text = ChatData:GetWorldChannelNum()

		ChatAction.EnterChatUI(1)
	end

	local var_43_0 = self.params_.chatToggleID

	if self.params_.chatToggleID == ChatConst.CHAT_CHANNEL_FRIEND then
		var_43_0 = ChatConst.CHAT_CHANNEL_WORLD
	end

	self:InitActivitySubTab()

	if self.params_.isBack == nil then
		self.historySeek_ = {}
	end

	if var_43_0 == ChatConst.CHAT_CHANNEL_COOPERATION then
		SetActive(self.cooperTabBtn_.gameObject, true)
	else
		SetActive(self.cooperTabBtn_.gameObject, false)
	end

	self:RefreshToggle(var_43_0)
	self:OnHideChatReport()
end

function ChatMainView:InitActivitySubTab()
	for iter_44_0, iter_44_1 in pairs(self.activityTabItemList_) do
		iter_44_1:Show(false)
	end

	for iter_44_2, iter_44_3 in pairs(ChatToggleCfg.all) do
		if iter_44_3 == ChatConst.CHAT_CHANNEL_MOON_CAKE and manager.windowBar:GetWhereTag() == "guildActivitySP" then
			-- block empty
		elseif ChatTools.IsOpenChatChannel(iter_44_3) then
			self.activityTabItemList_[iter_44_3] = self.activityTabItemList_[iter_44_3] or ChatSubTabItem.New(self.activityTabGo_, self.subTabRootTrs_, iter_44_3, function()
				self:RefreshToggle(iter_44_3)
			end)

			self.activityTabItemList_[iter_44_3]:Show(true)
		end
	end
end

function ChatMainView:RefreshToggle(arg_46_1)
	self.worldTabStateController_:SetSelectedState("cancel")
	self.guildTabStateController_:SetSelectedState(GuildData:GetGuildInfo().id == nil and "lock" or "unlock")
	self.recruitTabStateController_:SetSelectedState(PlayerData:GetPlayerInfo().userLevel < GameSetting.club_recruit_unlock_level.value[1] and "lock" or "unlock")
	self.cooperTabStateController_:SetSelectedState("cancel")

	for iter_46_0, iter_46_1 in pairs(self.activityTabItemList_) do
		iter_46_1:SetTabState(false)
	end

	if arg_46_1 == ChatConst.CHAT_CHANNEL_WORLD then
		self.worldTabStateController_:SetSelectedState("select")
	elseif arg_46_1 == ChatConst.CHAT_CHANNEL_GUILD then
		self.guildTabStateController_:SetSelectedState("select")
	elseif arg_46_1 == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		self.recruitTabStateController_:SetSelectedState("select")
	elseif arg_46_1 == ChatConst.CHAT_CHANNEL_COOPERATION then
		self.cooperTabStateController_:SetSelectedState("select")
	else
		self.activityTabItemList_[arg_46_1]:SetTabState(true)
	end

	self:SwitchChannel(arg_46_1)
end

function ChatMainView:SwitchChannel(arg_47_1)
	self.chatToggleID_ = arg_47_1

	self:UpdateSendTimeCD()

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD and GuildData:GetGuildInfo().id == nil then
		self.emptyStateController_:SetSelectedState("noguild")
		ShowTips("NEED_JOIN_CLUB")
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		self.emptyStateController_:SetSelectedState("nosend")
	elseif ChatToggleCfg[self.chatToggleID_] ~= nil then
		self.emptyStateController_:SetSelectedState(ChatToggleCfg[self.chatToggleID_].hide_send_btn == 1 and "nosend" or "normal")
	else
		self.emptyStateController_:SetSelectedState("normal")
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT or self.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		self:AddReguireMessageTimer()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		self:AddReguireMessageTimer()
	elseif ChatToggleCfg[self.chatToggleID_] ~= nil and ChatToggleCfg[self.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL then
		self:AddReguireMessageTimer()
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		local var_47_0 = ChatGuildData:InitCacheGuildContent()

		if var_47_0 ~= 0 and var_47_0 ~= #ChatGuildData:GetCacheContent() then
			self.historySeek_[self.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = var_47_0
			}
		end
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		local var_47_1 = ChatCooperationData:InitCacheCooperationContent()

		if var_47_1 ~= 0 and var_47_1 ~= #ChatCooperationData:GetCacheContent() then
			self.historySeek_[self.chatToggleID_] = {
				verticalNormalizedPosition = 1,
				index = var_47_1
			}
		end
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		ActivityRecallData:InitCacheContent()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		AutoChessCardData:InitCacheContent()
	elseif ChatToggleCfg[self.chatToggleID_] then
		ChatChannelData:InitCacheContent(self.chatToggleID_)
	end

	self.loopScrollView_:SetContentHeight(self.diaViewPortTrs_.rect.height)

	if self.historySeek_[self.chatToggleID_] then
		self.loopScrollView_:RestoredScroll(self.historySeek_[self.chatToggleID_].index, self.historySeek_[self.chatToggleID_].verticalNormalizedPosition)
	else
		self.loopScrollView_:Scroll2End()
	end

	self.chatSeek_[self.chatToggleID_] = self.chatSeek_[self.chatToggleID_] or 0

	SetActive(self.newJumpBtn_.gameObject, self.chatSeek_[self.chatToggleID_] < #self:LsGetItemData())
end

function ChatMainView:UpdateFriendsMainTab()
	self.chatToggleID_ = ChatConst.CHAT_CHANNEL_FRIEND

	self:UpdateSendTimeCD()

	local var_48_0 = ChatFriendData:GetCacheHeroList()

	self.tabStateController_:SetSelectedState(#var_48_0 > 0 and "friendsChannel" or "friendsEmpty")
	self.emptyStateController_:SetSelectedState(#var_48_0 > 0 and "normal" or "nothing")
	SetActive(self.friendCancelBtn_.gameObject, false)

	if #var_48_0 > 0 then
		self:RefreshFriends(self.params_.friendID or var_48_0[1])
	else
		self.friendsLuaUIlist_:StartScroll(0)
	end
end

function ChatMainView:RefreshFriends(arg_49_1)
	self.curfriendID_ = arg_49_1

	if self.curfriendID_ and self.curfriendID_ ~= 0 then
		ChatFriendData:LockFriendID(self.curfriendID_)
		self.friendsLuaUIlist_:StartScroll(#ChatFriendData:GetCacheHeroList())
		self.friendsLuaUIlist_:ScrollToIndex(table.keyof(ChatFriendData:GetCacheHeroList(), self.curfriendID_), false, false)
		self:RefreshFriendTitle()
		self.loopScrollView_:Scroll2End()
	else
		self.friendsLuaUIlist_:StartScroll(0)
	end
end

function ChatMainView:RefreshFriendTitle()
	local var_50_0 = FriendsData:GetInfoByID(self.curfriendID_)

	if var_50_0 == false then
		print("unfind friend data", self.curfriendID_)

		return
	end

	self.friendsIpText_.text = var_50_0.ip
	self.friendNameText_.text = GetI18NText(var_50_0.nick)
	self.friendSignText_.text = GetI18NText(var_50_0.sign)

	self.onlineStateController_:SetSelectedState(var_50_0.online_state == 0 and "on" or "off")
end

function ChatMainView:OnFriendsDelect(arg_51_1)
	if self.chatToggleID_ ~= ChatConst.CHAT_CHANNEL_FRIEND then
		return
	end

	local var_51_0 = ChatFriendData:GetCacheHeroList()

	self.tabStateController_:SetSelectedState(#var_51_0 > 0 and "friendsChannel" or "friendsEmpty")
	self.emptyStateController_:SetSelectedState(#var_51_0 > 0 and "normal" or "nothing")
	SetActive(self.friendCancelBtn_.gameObject, false)

	if self.curfriendID_ ~= arg_51_1 then
		self.friendsLuaUIlist_:StartScroll(#var_51_0)

		return
	end

	if #var_51_0 > 0 then
		self:RefreshFriends(var_51_0[1])
	else
		self.friendsLuaUIlist_:StartScroll(0)
	end
end

function ChatMainView:OnReceiveFriendMsg(arg_52_1)
	if self.chatToggleID_ ~= ChatConst.CHAT_CHANNEL_FRIEND then
		return
	end

	if self.tabStateController_:GetSelectedState() == "friendsEmpty" then
		local var_52_0 = ChatFriendData:GetCacheHeroList()

		self.tabStateController_:SetSelectedState(#var_52_0 > 0 and "friendsChannel" or "friendsEmpty")
		self.emptyStateController_:SetSelectedState(#var_52_0 > 0 and "normal" or "nothing")

		if #var_52_0 > 0 then
			self:RefreshFriends(var_52_0[1])
		else
			self.friendsLuaUIlist_:StartScroll(0)
		end

		return
	end

	self.friendsLuaUIlist_:StartScroll(#ChatFriendData:GetCacheHeroList())

	if self.curfriendID_ ~= arg_52_1 then
		return
	end

	for iter_52_0 = 0, ChatFriendData:GetUnreadMsgCnt(arg_52_1) - 1 do
		if self:LsGetItemData()[#self:LsGetItemData() - iter_52_0].senderID == USER_ID then
			self.loopScrollView_:Scroll2End()
			ChatFriendData:UpdateSeek(self.curfriendID_)

			return
		end
	end

	if not self.loopScrollView_:IsFillContent() or self.diaScrollEx_.verticalNormalizedPosition <= 0.0001 then
		self.loopScrollView_:Scroll2End()
		ChatFriendData:UpdateSeek(self.curfriendID_)

		return
	end

	SetActive(self.newJumpBtn_.gameObject, true)
	self.loopScrollView_:RefreshScrollView()
end

function ChatMainView:CloseCurFriendChat()
	ChatFriendData:RemoveCacheHero(self.curfriendID_)
	ChatFriendData:SaveRecordCnt(self.curfriendID_)
	FriendsAction:RefreshUnread(self.curfriendID_, 0)

	local var_53_0 = ChatFriendData:GetCacheHeroList()

	if #var_53_0 > 0 then
		self:RefreshFriends(var_53_0[1])
	else
		self.tabStateController_:SetSelectedState("friendsEmpty")
		self.emptyStateController_:SetSelectedState("nothing")
		self:RefreshFriends()
	end
end

function ChatMainView:AddReguireMessageTimer()
	self:TryToRequireMsg()

	if self.reguireMessageTimer_ ~= nil then
		return
	end

	self.reguireMessageTimer_ = Timer.New(function()
		self:TryToRequireMsg()
	end, 1, -1)

	self.reguireMessageTimer_:Start()
end

function ChatMainView:StopReguireMessageTimer()
	if self.reguireMessageTimer_ then
		self.reguireMessageTimer_:Stop()

		self.reguireMessageTimer_ = nil
	end
end

function ChatMainView:TryToRequireMsg()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT and manager.time:GetServerTime() - ChatGuildRecruitData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		ChatAction.RequireGuildShareInfo()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL and manager.time:GetServerTime() - ActivityRecallData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		ChatAction.RequireRecallInfo()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS and manager.time:GetServerTime() - AutoChessCardData:GetLastTimestamp() > GameSetting.chat_club_refresh_time.value[1] then
		AutoChessCardAction.RequestShareRecord()
	elseif ChatToggleCfg[self.chatToggleID_] and ChatToggleCfg[self.chatToggleID_].require_type[1] == ChatConst.REQUIRE_TYPE.MANUAL and ChatToggleCfg[self.chatToggleID_].require_type[2][1] < manager.time:GetServerTime() - ChatChannelData:GetLastRequireMsgTimestamp(self.chatToggleID_) then
		ChatAction.RequireChatNormalMsg(self.chatToggleID_)
	end
end

function ChatMainView:GetChatJudgeMessageType(arg_58_1)
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

function ChatMainView:LsGetItemData()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		return ChatData:GetWorldChatData()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		return ChatGuildData:GetCacheContent()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		return ChatGuildRecruitData:GetChatData()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		return ChatCooperationData:GetCacheContent()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_RECALL then
		return ActivityRecallData:GetChatData()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_AUTO_CHESS then
		return AutoChessCardData:GetChatData()
	elseif ChatToggleCfg[self.chatToggleID_] then
		return ChatChannelData:GetCacheContent(self.chatToggleID_)
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
		return ChatFriendData:GetCacheContent(self.curfriendID_)
	else
		return {}
	end
end

function ChatMainView:ParseFriendData(arg_60_1)
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

	if arg_60_1.senderID == USER_ID then
		local var_60_1 = PlayerData:GetPlayerInfo()

		var_60_0.bubbleID = PlayerData:GetCurChatBubbleID() or GameSetting.profile_chat_bubble_default.value[1]
		var_60_0.icon = var_60_1.portrait
		var_60_0.iconFrame = var_60_1.icon_frame
		var_60_0.ip = var_60_1.ip
		var_60_0.nick = var_60_1.nick
	else
		local var_60_2 = FriendsData:GetInfoByID(arg_60_1.senderID)

		var_60_0.bubbleID = var_60_2.bubbleID or GameSetting.profile_chat_bubble_default.value[1]
		var_60_0.icon = var_60_2.icon
		var_60_0.iconFrame = var_60_2.icon_frame
		var_60_0.ip = var_60_2.ip
		var_60_0.nick = var_60_2.nick
	end

	return var_60_0
end

function ChatMainView:LsAddItem(arg_61_1, arg_61_2)
	local var_61_0 = self:ParseFriendData(arg_61_1)
	local var_61_1

	if var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.CHANNEL then
		var_61_1 = self:GetFreeItem(self.itemChannelPool_, function()
			return ChatChannelView.New(self.channelTitleGo_, self.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.TIMESTAMP then
		var_61_1 = self:GetFreeItem(self.itemTimePool_, function()
			return ChatTimeView.New(self.timeStampGo_, self.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.HISTORY_TIPS then
		var_61_1 = self:GetFreeItem(self.historyTipsPool_, function()
			return ChatFriendHistoryTipsItem.New(self.historyTipsGo_, self.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.GUILD_RECRUIT then
		var_61_1 = var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) and self:GetFreeItem(self.itemSelfGuildRecruitPool_, function()
			return ChatGuildRecruitItemView.New(self.recruitSelfGo_, self.diaGridGo_)
		end) or self:GetFreeItem(self.itemFriendGuildRecruitPool_, function()
			return ChatGuildRecruitItemView.New(self.recruitOtherGo_, self.diaGridGo_)
		end)
	elseif var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.JUMP then
		local var_61_2 = self:GetJumpItemClass()

		var_61_1 = var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) and self:GetFreeItem(self.itemSelfJumpPool_, function()
			return var_61_2.New(self.jumpSelfGo_, self.diaGridGo_)
		end) or self:GetFreeItem(self.itemFriendJumptPool_, function()
			return var_61_2.New(self.jumpOtherGo_, self.diaGridGo_)
		end)
	else
		var_61_1 = var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.RECALL and (var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) and self:GetFreeItem(self.itemSelfRecallPool_, function()
			return ChatRecallItemView.New(self.recallSelfGo_, self.diaGridGo_)
		end) or self:GetFreeItem(self.itemFriendRecallPool_, function()
			return ChatRecallItemView.New(self.recallOtherGo_, self.diaGridGo_)
		end)) or var_61_0.contentType == ChatConst.CHAT_CONTENT_TYPE.AUTO_CHESS and (var_61_0.userId == tostring(PlayerData:GetPlayerInfo().userID) and self:GetFreeItem(self.itemSelfAutoChessPool_, function()
			return AutoChessCardChatItemView.New(self.autoChessSelfGo_, self.diaGridGo_)
		end) or self:GetFreeItem(self.itemFriendAutoChessPool_, function()
			return AutoChessCardChatItemView.New(self.autoChessOtherGo_, self.diaGridGo_)
		end)) or var_61_0.id == tostring(PlayerData:GetPlayerInfo().userID) and self:GetFreeItem(self.itemSelfPool_, function()
			return ChatItemView.New(self.chatSelfGo_, self.diaGridGo_, self.diaScrollEx_)
		end) or self:GetFreeItem(self.itemFriendPool_, function()
			return ChatItemView.New(self.chatOtherGo_, self.diaGridGo_, self.diaScrollEx_)
		end)
	end

	var_61_1.itemView:SetData(var_61_0, arg_61_2)

	self.chatSeek_[self.chatToggleID_] = self.chatSeek_[self.chatToggleID_] or 0

	if arg_61_2 > self.chatSeek_[self.chatToggleID_] then
		self.chatSeek_[self.chatToggleID_] = arg_61_2
	end

	if arg_61_2 >= #self:LsGetItemData() then
		SetActive(self.newJumpBtn_.gameObject, false)
	end

	if self.curfriendID_ and self.curfriendID_ ~= 0 then
		if arg_61_2 >= #self:LsGetItemData() then
			ChatFriendData:SaveRecordCnt(self.curfriendID_)
			FriendsAction:RefreshUnread(self.curfriendID_, 0)
		else
			local var_61_3 = #self:LsGetItemData() - arg_61_2

			if var_61_3 < ChatFriendData:GetUnreadMsgCnt(self.curfriendID_) then
				ChatFriendData:SaveRecordCnt(self.curfriendID_, var_61_3)
				FriendsAction:RefreshUnread(self.curfriendID_, var_61_3)
			end
		end
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:SaveRecordCnt()
	elseif ChatToggleCfg[self.chatToggleID_] then
		ChatChannelData:SaveRecordCnt(self.chatToggleID_)
	end

	return var_61_1
end

function ChatMainView:LsUpdateItem(arg_75_1, arg_75_2, arg_75_3)
	arg_75_1.itemView:SetData(self:ParseFriendData(arg_75_2), arg_75_3)
end

function ChatMainView:LsRemoveItem(arg_76_1)
	arg_76_1.itemView:Show(false)

	arg_76_1.isFree = true
end

function ChatMainView:GetJumpItemClass()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_MOON_CAKE then
		return MoonCakeChatJumpItemView
	else
		return ChatJumpItemView
	end
end

function ChatMainView:InitItemPool()
	self.itemChannelPool_ = {}
	self.itemTimePool_ = {}
	self.itemSelfPool_ = {}
	self.itemFriendPool_ = {}
	self.itemSelfGuildRecruitPool_ = {}
	self.itemFriendGuildRecruitPool_ = {}
	self.historyTipsPool_ = {}
	self.itemSelfJumpPool_ = {}
	self.itemFriendJumptPool_ = {}
	self.itemSelfRecallPool_ = {}
	self.itemFriendRecallPool_ = {}
	self.itemSelfAutoChessPool_ = {}
	self.itemFriendAutoChessPool_ = {}
end

function ChatMainView:GetFreeItem(arg_79_1, arg_79_2)
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

function ChatMainView:DisposeItemPool()
	for iter_80_0, iter_80_1 in ipairs(self.itemChannelPool_) do
		iter_80_1.itemView:Dispose()
	end

	self.itemChannelPool_ = nil

	for iter_80_2, iter_80_3 in ipairs(self.itemTimePool_) do
		iter_80_3.itemView:Dispose()
	end

	self.itemTimePool_ = nil

	for iter_80_4, iter_80_5 in ipairs(self.itemSelfPool_) do
		iter_80_5.itemView:Dispose()
	end

	self.itemSelfPool_ = nil

	for iter_80_6, iter_80_7 in ipairs(self.itemFriendPool_) do
		iter_80_7.itemView:Dispose()
	end

	self.itemFriendPool_ = nil

	for iter_80_8, iter_80_9 in ipairs(self.itemSelfGuildRecruitPool_) do
		iter_80_9.itemView:Dispose()
	end

	for iter_80_10, iter_80_11 in ipairs(self.itemFriendGuildRecruitPool_) do
		iter_80_11.itemView:Dispose()
	end

	for iter_80_12, iter_80_13 in ipairs(self.historyTipsPool_) do
		iter_80_13.itemView:Dispose()
	end

	for iter_80_14, iter_80_15 in ipairs(self.itemSelfJumpPool_) do
		iter_80_15.itemView:Dispose()
	end

	self.itemSelfJumpPool_ = nil

	for iter_80_16, iter_80_17 in ipairs(self.itemFriendJumptPool_) do
		iter_80_17.itemView:Dispose()
	end

	self.itemFriendJumptPool_ = nil

	for iter_80_18, iter_80_19 in ipairs(self.itemSelfRecallPool_) do
		iter_80_19.itemView:Dispose()
	end

	self.itemSelfRecallPool_ = nil

	for iter_80_20, iter_80_21 in ipairs(self.itemFriendRecallPool_) do
		iter_80_21.itemView:Dispose()
	end

	self.itemFriendRecallPool_ = nil

	for iter_80_22, iter_80_23 in ipairs(self.itemSelfAutoChessPool_) do
		iter_80_23.itemView:Dispose()
	end

	self.itemSelfAutoChessPool_ = nil

	for iter_80_24, iter_80_25 in ipairs(self.itemFriendAutoChessPool_) do
		iter_80_25.itemView:Dispose()
	end

	self.itemFriendAutoChessPool_ = nil
end

function ChatMainView:RefreshReceiveMessage()
	local var_81_0 = self:LsGetItemData()[#self:LsGetItemData()]

	if var_81_0 == nil then
		return
	end

	for iter_81_0 = self.chatSeek_[self.chatToggleID_] + 1, #self:LsGetItemData() do
		if self:LsGetItemData()[iter_81_0].id == USER_ID then
			self.loopScrollView_:Scroll2End()

			return
		end
	end

	if var_81_0.id == USER_ID then
		self.loopScrollView_:Scroll2End()

		return
	end

	if not self.loopScrollView_:IsFillContent() or self.diaScrollEx_.verticalNormalizedPosition <= 0.01 then
		self.loopScrollView_:Scroll2End()

		return
	end

	SetActive(self.newJumpBtn_.gameObject, true)
end

function ChatMainView:SendMessageResult(arg_82_1)
	if isSuccess(arg_82_1.result) then
		if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[self.chatToggleID_] and ChatToggleCfg[self.chatToggleID_].limit_type == 1 then
			ChatData:SetLevelTextTimeStamp(self.chatToggleID_)
		end

		ChatData:SetSendTextTimestamp()
		self:UpdateSendTimeCD()

		self.sendInputfield_.text = ""
	elseif arg_82_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				self:Back()
			end
		})
	elseif arg_82_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		self.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_82_1.result)
	end
end

function ChatMainView:OnSwitchChannel()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		self.loopScrollView_:Scroll2End()
	end
end

function ChatMainView:OnRecallFriendMsg(arg_85_1)
	if self.curfriendID_ ~= arg_85_1 then
		return
	end

	self.loopScrollView_:RefreshScrollView(true)
	SetActive(self.newJumpBtn_.gameObject, ChatFriendData:GetUnreadMsgCnt(arg_85_1) > 0)
end

function ChatMainView:OnChatReport(arg_86_1)
	self.reportTrs_:SetParent(arg_86_1.parentRect.transform, false)

	self.reportTrs_.localPosition = Vector2(arg_86_1.x, arg_86_1.y)
	self.reportData_ = arg_86_1.reportData

	SetActive(self.reportGo_, true)
end

function ChatMainView:OnHideChatReport()
	SetActive(self.reportGo_, false)
end

function ChatMainView:OnReceiveMessage(arg_88_1)
	if self.chatToggleID_ ~= arg_88_1.chatToggleID then
		return
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		self:RefreshReceiveMessage()
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		if #self.loopScrollView_:GetItemList() <= 0 then
			self.loopScrollView_:Scroll2End()
		else
			self.loopScrollView_:RefreshScrollView(true, true)
		end
	elseif ChatToggleCfg[self.chatToggleID_] then
		self:RefreshReceiveMessage()
	end
end

function ChatMainView:OnReceiveGuildMessage()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		self:RefreshReceiveMessage()
	end
end

function ChatMainView:OnReceiveCooperationMessage()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		self:RefreshReceiveMessage()
	end
end

function ChatMainView:OnSendSticker(arg_91_1)
	if ChatToggleCfg[self.chatToggleID_] and not ChatTools.IsOpenChatChannel(self.chatToggleID_) then
		ShowTips("TIME_OVER")

		return
	end

	self:HideStickerPanel()

	if ChatData:IsMuted() then
		self.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	end

	if self.sendTipsCD_ > 0 or manager.time:GetServerTime() - ChatData:GetSendStickerTimestamp() < 10 then
		ShowTips("SEND_MESSAGE_FREQUENTLY")

		return
	end

	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD then
		ChatAction.SendSticker(arg_91_1, function(arg_92_0)
			self:SendStickerResult(arg_92_0)
		end)
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		if GuildData:GetGuildInfo().id == nil then
			ShowTips("SEND_SOCIETY_MESSAGE_ERROR")

			return
		end

		ChatAction.SendGuildSticker(arg_91_1, function(arg_93_0)
			self:SendStickerResult(arg_93_0)
		end)
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatAction.SendGuildRecruitSticker(arg_91_1, function(arg_94_0)
			self:SendStickerResult(arg_94_0)
		end)
	elseif ChatToggleCfg[self.chatToggleID_] then
		ChatAction.SendChatNormalSticker(self.chatToggleID_, arg_91_1, function(arg_95_0)
			self:SendStickerResult(arg_95_0)
		end)
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		if not CooperationData:CheckInRoom() then
			ShowTips("ERROR_INVALID_OPERATION")

			return
		end

		ChatAction.SendCooperationSticker(arg_91_1, function(arg_96_0)
			self:SendStickerResult(arg_96_0)
		end)
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_FRIEND then
		ChatAction.SendFriendSticker(self.curfriendID_, arg_91_1, function(arg_97_0)
			if isSuccess(arg_97_0.result) then
				ChatData:SetSendStickerTimestamp()

				self.sendInputfield_.text = ""
			end
		end)
	else
		ShowTips("SEND_MESSAGE_ERROR")
	end
end

function ChatMainView:SendStickerResult(arg_98_1)
	if isSuccess(arg_98_1.result) then
		if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[self.chatToggleID_] and ChatToggleCfg[self.chatToggleID_].limit_type == 1 then
			ChatData:SetLevelTextTimeStamp(self.chatToggleID_)
		end

		ChatData:SetSendStickerTimestamp()
		self:UpdateSendTimeCD()
	elseif arg_98_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_NOT_IN_ROOM then
		ShowMessageBox({
			isTop = true,
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("WORLD_CHANNEL_ERROR"),
			OkCallback = function()
				self:Back()
			end
		})
	elseif arg_98_1.result == TipsCfg.get_id_list_by_define.ERROR_CHAT_BAN then
		self.sendInputfield_.text = ""

		JumpTools.OpenPageByJump("chatMuted")

		return
	else
		ShowTips(arg_98_1.result)
	end
end

function ChatMainView:HideStickerPanel()
	self.chatStickerView_:Show(false)
end

function ChatMainView:OnResetWorldChat()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_WORLD or ChatToggleCfg[self.chatToggleID_] then
		if ChatToggleCfg[self.chatToggleID_] then
			ChatChannelData:InitCacheContent(self.chatToggleID_)
		end

		self.loopScrollView_:RefreshScrollView(true)
	end
end

function ChatMainView:OnResetGuildChat()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD then
		ChatGuildData:InitCacheGuildContent()
		self.loopScrollView_:RefreshScrollView(true)
	elseif self.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_RECRUIT then
		ChatGuildRecruitData:InitCacheContent()
		self.loopScrollView_:RefreshScrollView(true)
	end
end

function ChatMainView:OnResetCooperationChat()
	if self.chatToggleID_ == ChatConst.CHAT_CHANNEL_COOPERATION then
		self.loopScrollView_:RefreshScrollView(true)
	end
end

function ChatMainView:OnBehind()
	self:OnHideChatReport()
end

function ChatMainView:Dispose()
	for iter_105_0, iter_105_1 in pairs(self.activityTabItemList_) do
		iter_105_1:Dispose()
	end

	self.activityTabItemList_ = nil

	self.loopScrollView_:Dispose()
	self.friendsLuaUIlist_:Dispose()
	self:DisposeItemPool()

	if self.chatStickerView_ then
		self.chatStickerView_:Dispose()

		self.chatStickerView_ = nil
	end

	ChatMainView.super.Dispose(self)
end

function ChatMainView:OnExitInput()
	self:Back()

	return true
end

return ChatMainView
