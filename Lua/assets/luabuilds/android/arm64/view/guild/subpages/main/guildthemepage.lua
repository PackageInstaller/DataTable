local var_0_0 = class("GuildThemePage", import("...base.GuildBasePage"))

function var_0_0.getTargetUI(arg_1_0)
	if getProxy(SettingsProxy):IsMellowStyle() then
		return "GuildThemeBlueUI4Mellow", "GuildThemeRedUI4Mellow"
	else
		return "GuildThemeBlueUI", "GuildThemeRedUI"
	end

	return
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0.chatBtn = arg_2_0._tf:Find("chat_bg")
	arg_2_0.chatBtnTip = arg_2_0.chatBtn:Find("tip")
	arg_2_0.chatBtnTipCnt = arg_2_0.chatBtn:Find("tip/Text"):GetComponent(typeof(Text))
	arg_2_0.chatPanel = arg_2_0._tf:Find("chat_frame")
	arg_2_0.chatCloseBtn = arg_2_0.chatPanel:Find("close")
	arg_2_0.bottomPanel = arg_2_0._tf:Find("bottom")
	arg_2_0.battleEvent = arg_2_0._tf:Find("bottom/battle_event")
	arg_2_0.battleEventTip = arg_2_0.battleEvent:Find("tip")
	arg_2_0.battleEventTipCnt = arg_2_0.battleEventTip:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.battleReport = arg_2_0._tf:Find("bottom/battle_report")
	arg_2_0.battleReportTip = arg_2_0.battleReport:Find("tip")
	arg_2_0.battleReportCnt = arg_2_0.battleReportTip:Find("Text"):GetComponent(typeof(Text))
	arg_2_0.shopBtn = arg_2_0._tf:Find("bottom/battle_shop")
	arg_2_0.nameTxt = arg_2_0._tf:Find("top/name/Text"):GetComponent(typeof(Text))
	arg_2_0.modifyBtn = arg_2_0._tf:Find("top/name")
	arg_2_0.levelImg = arg_2_0._tf:Find("top/level/Text"):GetComponent(typeof(Text))
	arg_2_0.factionTxt = arg_2_0._tf:Find("top/policy/label"):GetComponent(typeof(Text))
	arg_2_0.policyTxt = arg_2_0._tf:Find("top/policy/Text"):GetComponent(typeof(Text))
	arg_2_0.idTxt = arg_2_0._tf:Find("top/id/Text"):GetComponent(typeof(Text))
	arg_2_0.numberTxt = arg_2_0._tf:Find("top/id/number"):GetComponent(typeof(Text))
	arg_2_0.expImg = arg_2_0._tf:Find("top/exp/bar")
	arg_2_0.levelTxt = arg_2_0._tf:Find("top/exp/lv/Text"):GetComponent(typeof(Text))
	arg_2_0.topPanelWidth = arg_2_0.top.rect.height
	arg_2_0.bottomPanelWidth = -165
	arg_2_0.chatPanelWidth = arg_2_0.chatPanel.rect.width + 300
	arg_2_0.chatBtnWidth = arg_2_0.chatBtn.rect.width + 300

	setAnchoredPosition(arg_2_0.chatPanel, {
		x = arg_2_0.chatPanelWidth
	})
	setAnchoredPosition(arg_2_0.chatBtn, {
		x = 0
	})

	arg_2_0.modifyPage = GuildModifitonPage.New(arg_2_0._tf, arg_2_0.event)
	arg_2_0.chatBubbles = {}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.battleEvent, function()
		triggerToggle(arg_3_0.contextData.toggles[GuildMainScene.TOGGLE_TAG[6]], true)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.battleReport, function()
		arg_3_0:emit(GuildMainMediator.OPEN_EVENT_REPORT)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.shopBtn, function()
		arg_3_0:emit(GuildMainMediator.OPEN_SHOP)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.chatBtn, function()
		arg_3_0:InitChatWindow()
		arg_3_0:ShowOrHideChatWindow(true)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.chatCloseBtn, function()
		getProxy(GuildProxy):ClearNewChatMsgCnt()
		arg_3_0:UpdateChatBtn()
		arg_3_0:ShowOrHideChatWindow(false)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.modifyBtn, function()
		arg_3_0.modifyPage:ExecuteAction("Show", arg_3_0.guildVO, arg_3_0.playerVO)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Update(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:UpdateData(arg_10_1, arg_10_2, arg_10_3)
	arg_10_0:UpdateMainInfo()
	arg_10_0:UpdateChatBtn()
	arg_10_0:UpdateBattleBtn()
	arg_10_0:Show()

	return
end

function var_0_0.ResUISettings(arg_11_0)
	return {
		showType = PlayerResUI.TYPE_ALL
	}
end

function var_0_0.UpdateData(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0:UpdateGuild(arg_12_1)

	arg_12_0.playerVO = arg_12_2
	arg_12_0.chatMsgs = arg_12_3
	arg_12_0.isAdmin = arg_12_1:IsAdministrator()

	return
end

function var_0_0.UpdateGuild(arg_13_0, arg_13_1)
	arg_13_0.guildVO = arg_13_1

	return
end

function var_0_0.RefreshReportBtn(arg_14_0)
	arg_14_0:UpdateBattleBtn()

	return
end

function var_0_0.UpdateBattleBtn(arg_15_0)
	local var_15_0 = getProxy(GuildProxy):GetReports()

	setActive(arg_15_0.battleEvent, arg_15_0.guildVO:GetActiveEvent() ~= nil)
	setActive(arg_15_0.battleEventTip, false)

	local var_15_1 = arg_15_0.guildVO:getMemberById(arg_15_0.playerVO.id)
	local var_15_2 = _.select(_.values(var_15_0), function(arg_16_0)
		return arg_16_0:CanSubmit()
	end)
	local var_15_3 = #var_15_2 > 0 and not var_15_1:IsRecruit()

	setActive(arg_15_0.battleReport, var_15_3)
	setActive(arg_15_0.battleReportTip, var_15_3)

	if var_15_3 then
		arg_15_0.battleReportCnt.text = #var_15_2
	end

	return
end

function var_0_0.UpdateChatBtn(arg_17_0)
	local var_17_0 = getProxy(GuildProxy):GetNewChatMsgCnt()
	local var_17_1 = var_17_0 > 0

	setActive(arg_17_0.chatBtnTip, var_17_0 > 0)

	if var_17_1 then
		arg_17_0.chatBtnTipCnt.text = var_17_0
	end

	return
end

function var_0_0.InitChatWindow(arg_18_0)
	if arg_18_0.isInitChatWindow then
		return
	end

	arg_18_0.isInitChatWindow = true
	arg_18_0.noticeTxt = arg_18_0.chatPanel:Find("log/notice/InputField"):GetComponent(typeof(InputField))
	arg_18_0.noticeMask = arg_18_0.chatPanel:Find("log/notice/mask")
	arg_18_0.noticeScrollTxt = arg_18_0.chatPanel:Find("log/notice/mask/label"):GetComponent(typeof(ScrollText))
	arg_18_0.logContent = arg_18_0.chatPanel:Find("log/content/viewport/list")
	arg_18_0.prefabPublic = arg_18_0:getTpl("tpl", arg_18_0.logContent)
	arg_18_0.chatRect = arg_18_0.chatPanel:Find("bottom/list")
	arg_18_0.chatContent = arg_18_0.chatPanel:Find("bottom/list/content")
	arg_18_0.prefabOthers = arg_18_0.chatPanel:Find("bottom/list/popo_other")
	arg_18_0.prefabSelf = arg_18_0.chatPanel:Find("bottom/list/popo_self")
	arg_18_0.prefabWorldboss = arg_18_0.chatPanel:Find("bottom/list/popo_worldboss")
	arg_18_0.sendBtn = arg_18_0.chatPanel:Find("bottom/bottom/send")
	arg_18_0.msgInput = arg_18_0.chatPanel:Find("bottom/bottom/input"):GetComponent(typeof(InputField))
	arg_18_0.emojiBtn = arg_18_0.chatPanel:Find("bottom/bottom/emoji")
	arg_18_0.newMsgTip = arg_18_0.chatPanel:Find("bottom/bottom/tip")

	onButton(arg_18_0, arg_18_0.sendBtn, function()
		if wordVer(arg_18_0.msgInput.text) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("playerinfo_mask_word"))

			return
		end

		if arg_18_0.msgInput.text == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("guild_msg_is_null"))

			return
		end

		if arg_18_0.chatTimer then
			if pg.TimeMgr.GetInstance():GetServerTime() - arg_18_0.chatTimer < 5 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("dont_send_message_frequently"))

				return
			end
		end

		local var_19_0 = arg_18_0

		var_19_0.chatTimer = pg.TimeMgr.GetInstance():GetServerTime()

		arg_18_0:emit(GuildMainMediator.SEND_MSG, arg_18_0.msgInput.text)

		arg_18_0.msgInput.text = ""

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.emojiBtn, function()
		arg_18_0:emit(GuildMainMediator.OPEN_EMOJI, Vector3(arg_18_0.emojiBtn.position.x, arg_18_0.emojiBtn.position.y, 0), function(arg_21_0)
			arg_18_0:emit(GuildMainMediator.SEND_MSG, string.gsub(ChatConst.EmojiCode, "code", arg_21_0))

			return
		end)

		return
	end, SFX_PANEL)
	GetOrAddComponent(arg_18_0.chatRect, typeof(EventTriggerListener)):AddDragEndFunc(function(arg_22_0, arg_22_1)
		if GetComponent(arg_18_0.chatRect, typeof(ScrollRect)).normalizedPosition.y <= 0.1 then
			arg_18_0:ClearChatTip()
		end

		return
	end)
	arg_18_0:UpdateChatWindow()

	if arg_18_0.isAdmin then
		onInputEndEdit(arg_18_0, arg_18_0.noticeTxt.gameObject, function()
			local var_23_0 = arg_18_0.guildVO:GetAnnounce() or ""
			local var_23_1 = getInputText(arg_18_0.noticeTxt.gameObject)

			if var_23_1 == "" or var_23_1 == var_23_0 then
				return
			end

			if wordVer(var_23_1) > 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("playerinfo_mask_word"))
				setInputText(arg_18_0.noticeTxt.gameObject, "")

				return
			end

			arg_18_0.noticeScrollTxt:SetText(var_23_1)
			arg_18_0:emit(GuildMainMediator.MODIFY, 5, 0, var_23_1)
			setInputText(arg_18_0.noticeTxt.gameObject, "")

			return
		end)
	end

	setButtonEnabled(arg_18_0.noticeMask, arg_18_0.isAdmin)

	return
end

function var_0_0.UpdateChatWindow(arg_24_0)
	arg_24_0:UpdateNotice()
	arg_24_0:UpdateAllLog(arg_24_0.guildVO.logInfo)
	arg_24_0:UpdateAllChat(arg_24_0.chatMsgs)

	return
end

function var_0_0.UpdateNotice(arg_25_0)
	local var_25_0 = arg_25_0.guildVO:GetAnnounce()
	local var_25_1 = (not var_25_0 or var_25_0 == "") and i18n("guild_not_exist_notifycation") or var_25_0

	arg_25_0.noticeScrollTxt:SetText(var_25_1)

	return
end

function var_0_0.UpdateAllLog(arg_26_0, arg_26_1)
	removeAllChildren(arg_26_0.logContent)

	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		arg_26_0:AppendLog(iter_26_1)
	end

	return
end

function var_0_0.AppendLog(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.isInitChatWindow then
		return
	end

	if arg_27_0.logContent.childCount >= 200 then
		arg_27_0:emit(GuildMainMediator.ON_REBUILD_LOG_ALL)
	else
		local var_27_0 = cloneTplTo(arg_27_0.prefabPublic, arg_27_0.logContent)

		if arg_27_2 then
			var_27_0:SetAsFirstSibling()
		end

		local var_27_1 = var_27_0:Find("text"):GetComponent("RichText")
		local var_27_2 = var_27_0:Find("time"):GetComponent(typeof(Text))
		local var_27_3, var_27_4 = arg_27_1:getConent()

		if arg_27_1.cmd == GuildLogInfo.CMD_TYPE_GET_SHIP then
			ChatProxy.InjectPublic(var_27_1, var_27_3, true)
		else
			var_27_1.text = var_27_3
		end

		var_27_2.text = var_27_4
	end

	return
end

function var_0_0.UpdateAllChat(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1 or {}

	removeAllChildren(arg_28_0.chatContent)

	arg_28_0.index = math.max(1, #var_28_0 - GuildConst.CHAT_LOG_MAX_COUNT)

	for iter_28_0 = arg_28_0.index, #var_28_0 do
		table.insert({}, function(arg_29_0)
			arg_28_0:Append(var_28_0[iter_28_0], -1, true)
			arg_29_0()

			return
		end)
	end

	seriesAsync({}, function()
		Timer.New(function()
			if not IsNil(arg_28_0.chatContent) then
				scrollToBottom(arg_28_0.chatContent.parent)
			end

			return
		end, 0.5, 1):Start()

		return
	end)

	return
end

function var_0_0.Append(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:UpdateChatBtn()

	if not arg_32_0.isInitChatWindow then
		return
	end

	if arg_32_0.chatContent.childCount >= GuildConst.CHAT_LOG_MAX_COUNT * 2 then
		arg_32_0:emit(GuildMainMediator.REBUILD_ALL)
	elseif arg_32_1.id and arg_32_1.id == 4 then
		arg_32_0:AddWorldBossMsg(arg_32_1, arg_32_2, arg_32_3)
	else
		arg_32_0:AppendWorld(arg_32_1, arg_32_2, arg_32_3)
	end

	return
end

function var_0_0.ShowChatTip(arg_33_0)
	setActive(arg_33_0.newMsgTip, true)

	return
end

function var_0_0.ClearChatTip(arg_34_0)
	setActive(arg_34_0.newMsgTip, false)

	return
end

function var_0_0.AddWorldBossMsg(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = Clone(arg_35_1)

	if not arg_35_3 then
		arg_35_0:ShowChatTip()
	end

	local var_35_2 = ChatBubbleWorldBoss.New((cloneTplTo(arg_35_0.prefabWorldboss, arg_35_0.chatContent)))

	if arg_35_2 >= 0 then
		var_35_2.tf:SetSiblingIndex(arg_35_2)
	end

	var_35_2:update(var_35_0)
	table.insert(arg_35_0.chatBubbles, var_35_2)

	return
end

function var_0_0.AppendWorld(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = Clone(arg_36_1)
	local var_36_1 = var_36_0.player
	local var_36_2 = arg_36_0.prefabOthers

	if var_36_0.player.id == arg_36_0.playerVO.id then
		var_36_2 = arg_36_0.prefabSelf
		var_36_0.player = setmetatable(Clone(arg_36_0.playerVO), {
			__index = var_36_0.player
		})
	elseif not arg_36_3 then
		arg_36_0:ShowChatTip()
	end

	local var_36_3 = GuildChatBubble.New((cloneTplTo(var_36_2, arg_36_0.chatContent)))

	if arg_36_2 >= 0 then
		var_36_3.tf:SetSiblingIndex(arg_36_2)
	end

	var_36_0.isSelf = var_36_1.id == arg_36_0.playerVO.id

	var_36_3:update(var_36_0)

	if not arg_36_3 and var_36_0.isSelf then
		onNextTick(function()
			scrollToBottom(arg_36_0.chatContent.parent)

			return
		end)
	end

	table.insert(arg_36_0.chatBubbles, var_36_3)

	return
end

function var_0_0.UpdateMainInfo(arg_38_0)
	arg_38_0.nameTxt.text = arg_38_0.guildVO:getName()
	arg_38_0.factionTxt.text = arg_38_0.guildVO:getFactionName()
	arg_38_0.policyTxt.text = arg_38_0.guildVO:getPolicyName()
	arg_38_0.idTxt.text = "ID:" .. arg_38_0.guildVO.id
	arg_38_0.numberTxt.text = arg_38_0.guildVO.memberCount .. "/" .. arg_38_0.guildVO:getMaxMember()

	setFillAmount(arg_38_0.expImg, arg_38_0.guildVO.exp / math.max(arg_38_0.guildVO:getLevelMaxExp(), 1))

	local var_38_0 = arg_38_0.levelTxt

	if arg_38_0.guildVO.level <= 9 then
		var_38_0.text = "0" .. arg_38_0.guildVO.level or arg_38_0.guildVO.level

		local var_38_2 = ""

		for iter_38_0 = 1, math.floor(arg_38_0.guildVO.level / 10) do
			var_38_2 = var_38_2 .. ":"
		end

		local var_38_3 = arg_38_0.guildVO.level % 10

		arg_38_0.levelImg.text = var_38_2 .. (arg_38_0.guildVO.level % 10 == 0 and "" or var_38_3)

		if arg_38_0.isInitChatWindow then
			arg_38_0:UpdateNotice()
		end

		return
	end
end

function var_0_0.ShowOrHideChatWindow(arg_39_0, arg_39_1)
	if LeanTween.isTweening(go(arg_39_0.chatPanel)) then
		return
	end

	local var_39_0
	local var_39_1
	local var_39_2
	local var_39_3

	if not arg_39_1 then
		var_39_1 = arg_39_0.chatPanelWidth
		var_39_0 = 0
		var_39_3 = 0
		var_39_2 = arg_39_0.chatBtnWidth

		goto label_39_0

		var_39_1 = 0
	end

	var_39_0 = arg_39_0.chatPanelWidth
	var_39_3 = arg_39_0.chatBtnWidth
	var_39_2 = 0

	::label_39_0::

	arg_39_0.isShowChatWindow = arg_39_1

	LeanTween.value(go(arg_39_0.chatPanel), var_39_0, var_39_1, 0.3):setOnUpdate(System.Action_float(function(arg_41_0)
		setAnchoredPosition(arg_39_0.chatPanel, {
			x = arg_41_0
		})

		return
	end)):setOnComplete(System.Action(function()
		if arg_39_1 then
			setParent(arg_39_0.chatPanel, pg.UIMgr.GetInstance().OverlayMain, true)

			arg_39_0.chatPanel.localPosition = Vector3(arg_39_0.chatPanel.localPosition.x, arg_39_0.chatPanel.localPosition.y, 0)

			pg.UIMgr.GetInstance():OverlayPanel(arg_39_0.chatPanel, {
				groupName = "group_GuildMainUI",
				pbList = {
					arg_39_0.chatPanel
				}
			})

			arg_39_0.chatPanelAnchoredPositionX = arg_39_0.chatPanel.anchoredPosition.x
		else
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_39_0.chatPanel, arg_39_0._tf)
		end

		return
	end))
	LeanTween.value(go(arg_39_0.chatBtn), var_39_2, var_39_3, 0.3):setOnUpdate(System.Action_float(function(arg_42_0)
		setAnchoredPosition(arg_39_0.chatBtn, {
			x = arg_42_0
		})

		return
	end))

	return
end

function var_0_0.EnterOrExitPreView(arg_43_0, arg_43_1)
	if LeanTween.isTweening(go(arg_43_0.top)) or LeanTween.isTweening(go(arg_43_0.bottomPanel)) or LeanTween.isTweening(go(arg_43_0.chatPanel)) or LeanTween.isTweening(go(arg_43_0.chatBtn)) then
		return
	end

	if arg_43_1 then
		local var_43_0 = {
			0,
			arg_43_0.topPanelWidth
		}

		if not {
			0,
			arg_43_0.topPanelWidth
		} then
			var_43_0 = {
				arg_43_0.topPanelWidth,
				0
			}
		end

		LeanTween.value(go(arg_43_0.top), var_43_0[1], var_43_0[2], 0.3):setOnUpdate(System.Action_float(function(arg_44_0)
			setAnchoredPosition(arg_43_0.top, {
				y = arg_44_0
			})

			return
		end))

		if arg_43_1 then
			local var_43_1 = {
				94,
				94 + arg_43_0.bottomPanelWidth
			}

			if not {
				94,
				94 + arg_43_0.bottomPanelWidth
			} then
				var_43_1 = {
					94 + arg_43_0.bottomPanelWidth,
					94
				}
			end

			LeanTween.value(go(arg_43_0.bottomPanel), var_43_1[1], var_43_1[2], 0.3):setOnUpdate(System.Action_float(function(arg_45_0)
				setAnchoredPosition(arg_43_0.bottomPanel, {
					y = arg_45_0
				})

				return
			end))

			if arg_43_0.isShowChatWindow then
				if arg_43_1 then
					local var_43_2 = {
						0,
						arg_43_0.chatPanelWidth
					}

					if not {
						0,
						arg_43_0.chatPanelWidth
					} then
						var_43_2 = {
							arg_43_0.chatPanelWidth
						}
						var_43_2[2] = arg_43_0.chatPanelAnchoredPositionX or 0
					end

					LeanTween.value(go(arg_43_0.chatPanel), var_43_2[1], var_43_2[2], 0.3):setOnUpdate(System.Action_float(function(arg_46_0)
						setAnchoredPosition(arg_43_0.chatPanel, {
							x = arg_46_0
						})

						return
					end))

					goto label_43_0

					::label_43_0::

					if arg_43_1 then
						do
							local var_43_3 = {
								0,
								arg_43_0.chatBtnWidth
							}

							if not {
								0,
								arg_43_0.chatBtnWidth
							} then
								var_43_3 = {
									arg_43_0.chatBtnWidth,
									0
								}
							end

							LeanTween.value(go(arg_43_0.chatBtn), var_43_3[1], var_43_3[2], 0.3):setOnUpdate(System.Action_float(function(arg_47_0)
								setAnchoredPosition(arg_43_0.chatBtn, {
									x = arg_47_0
								})

								return
							end))
						end

						return
					end
				end
			end
		end
	end
end

function var_0_0.InsertEmojiToInputText(arg_48_0, arg_48_1)
	arg_48_0.msgInput.text = arg_48_0.msgInput.text .. string.gsub(ChatConst.EmojiIconCode, "code", arg_48_1)

	return
end

function var_0_0.OnDestroy(arg_49_0)
	if arg_49_0.isShowChatWindow then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_49_0.chatPanel, arg_49_0._tf)
	end

	if LeanTween.isTweening(go(arg_49_0.chatPanel)) then
		LeanTween.cancel(go(arg_49_0.chatPanel))
	end

	if LeanTween.isTweening(go(arg_49_0.chatBtn)) then
		LeanTween.cancel(go(arg_49_0.chatBtn))
	end

	arg_49_0.modifyPage:Destroy()

	for iter_49_0, iter_49_1 in ipairs(arg_49_0.chatBubbles) do
		if iter_49_1 then
			iter_49_1:dispose()
		end
	end

	arg_49_0.chatBubbles = nil

	arg_49_0:Hide()

	return
end

return var_0_0
