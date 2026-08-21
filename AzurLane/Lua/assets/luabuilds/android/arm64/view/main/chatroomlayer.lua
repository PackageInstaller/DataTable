local var_0_0 = class("ChatRoomLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChatRoomUI"
end

function var_0_0.setFriendVO(arg_2_0, arg_2_1)
	arg_2_0.friendVO = arg_2_1

	return
end

function var_0_0.setFriends(arg_3_0, arg_3_1)
	arg_3_0.friendVOs = arg_3_1

	return
end

function var_0_0.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.playerVO = arg_4_1

	return
end

function var_0_0.setCacheMsgs(arg_5_0, arg_5_1)
	arg_5_0.cacheMsgsVOs = arg_5_1

	return
end

function var_0_0.init(arg_6_0)
	arg_6_0.frame = arg_6_0._tf:Find("frame")
	arg_6_0.friendView = arg_6_0.frame:Find("left_length/scrollView")
	arg_6_0.chatPanel = arg_6_0.frame:Find("notification_panel")
	arg_6_0.chatPanelTitle = arg_6_0.frame:Find("notification_panel/frame/top/name")
	arg_6_0.sendBtn = arg_6_0.chatPanel:Find("frame/bottom/send")
	arg_6_0.inputTF = arg_6_0.chatPanel:Find("frame/bottom/input")
	arg_6_0.chatsRect = arg_6_0.chatPanel:Find("frame/list")
	arg_6_0.chatsContainer = arg_6_0.chatPanel:Find("frame/list/content")
	arg_6_0.closeBtn = arg_6_0._tf:Find("frame/notification_panel/frame/top/close_btn")
	arg_6_0.otherPopTpl = arg_6_0:getTpl("frame/list/popo_other", arg_6_0.chatPanel)
	arg_6_0.selfPopTpl = arg_6_0:getTpl("frame/list/popo_self", arg_6_0.chatPanel)

	arg_6_0:BlurPanel(arg_6_0.frame)

	return
end

function var_0_0.didEnter(arg_7_0)
	onButton(arg_7_0, arg_7_0.chatPanel:Find("frame/bottom/emoji"), function()
		arg_7_0:emit(ChatRoomMediator.OPEN_EMOJI, Vector3(var_0.position.x, var_0.position.y, 0), function(arg_9_0)
			arg_7_0:sendMessage(string.gsub(ChatConst.EmojiCode, "code", arg_9_0))

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0._tf, function()
		arg_7_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)
	onButton(arg_7_0, arg_7_0.closeBtn, function()
		arg_7_0:emit(var_0_0.ON_CLOSE)

		return
	end, SOUND_BACK)
	arg_7_0:initFriends()

	return
end

function var_0_0.initFriends(arg_12_0)
	arg_12_0.friendItems = {}
	arg_12_0.friendRect = arg_12_0.friendView:GetComponent("LScrollRect")

	function arg_12_0.friendRect.onInitItem(arg_13_0)
		arg_12_0:initFriend(arg_13_0)

		return
	end

	function arg_12_0.friendRect.onUpdateItem(arg_14_0, arg_14_1)
		arg_12_0:updateFriend(arg_14_0, arg_14_1)

		return
	end

	arg_12_0:sortFriend()

	return
end

function var_0_0.createFriendItem(arg_15_0, arg_15_1)
	local var_15_0 = {
		tf = tf(arg_15_1)
	}

	var_15_0.nameTF = var_15_0.tf:Find("name"):GetComponent(typeof(Text))
	var_15_0.iconTF = var_15_0.tf:Find("shipicon/icon"):GetComponent(typeof(Image))
	var_15_0.circle = var_15_0.tf:Find("shipicon/frame")
	var_15_0.toggle = var_15_0.tf:GetComponent(typeof(Toggle))
	var_15_0.tipTF = var_15_0.tf:Find("tip")
	var_15_0.dateTF = var_15_0.tf:Find("lv_bg/date"):GetComponent(typeof(Text))
	var_15_0.onlineTF = var_15_0.tf:Find("lv_bg/online")
	var_15_0.levelTF = var_15_0.tf:Find("lv_bg/Text"):GetComponent(typeof(Text))

	local var_15_1 = arg_15_0.friendVO

	function var_15_0.update(arg_16_0, arg_16_1, arg_16_2)
		arg_16_0:clear()
		setActive(var_15_0.tipTF, false)

		arg_16_0.friendVO = arg_16_1
		var_15_0.nameTF.text = arg_16_1.name
		var_15_0.levelTF.text = "LV." .. arg_16_1.level

		assert(pg.ship_data_statistics[arg_16_1.icon], "shipCfg is nil >> id ==" .. arg_16_1.icon)
		LoadSpriteAsync("qicon/" .. Ship.New({
			configId = arg_16_1.icon,
			skin_id = arg_16_1.skinId
		}):getPainting(), function(arg_17_0)
			var_15_0.iconTF.sprite = not arg_17_0 and GetSpriteFromAtlas("heroicon/unknown", "") or arg_17_0

			return
		end)

		local var_16_0 = arg_16_1.id == getProxy(PlayerProxy):getRawData().id
		local var_16_1 = AttireFrame.attireFrameRes(arg_16_1, var_16_0, AttireConst.TYPE_ICON_FRAME, arg_16_1.propose)

		PoolMgr.GetInstance():GetPrefab("IconFrame/" .. var_16_1, var_16_1, true, function(arg_18_0)
			if arg_16_0.circle then
				arg_18_0.name = var_16_1
				findTF(arg_18_0.transform, "icon"):GetComponent(typeof(Image)).raycastTarget = false

				setParent(arg_18_0, arg_16_0.circle, false)
			else
				PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_16_1, var_16_1, arg_18_0)
			end

			return
		end)

		if var_15_1.id == arg_16_1.id and var_15_0.toggle.isOn == false then
			triggerToggle(var_15_0.tf, true)
		end

		setActive(arg_16_0.onlineTF, arg_16_1.online == Friend.ONLINE)
		setActive(var_15_0.dateTF, arg_16_1.online == Friend.OFFLINE)

		var_15_0.dateTF.text = pg.TimeMgr.GetInstance():STimeDescC(arg_16_1.preOnLineTime, "%Y/%m/%d")

		return
	end

	function var_15_0.clear(arg_19_0)
		if arg_19_0.circle.childCount > 0 then
			local var_19_0 = arg_19_0.circle:GetChild(0).gameObject

			PoolMgr.GetInstance():ReturnPrefab("IconFrame/" .. var_19_0.name, var_19_0.name, var_19_0)
		end

		return
	end

	function var_15_0.dispose(arg_20_0)
		arg_20_0:clear()

		return
	end

	return var_15_0
end

function var_0_0.updateFriend(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_0.friendItems[arg_21_2] then
		arg_21_0:initFriend(arg_21_2)
	end

	arg_21_0.friendItems[arg_21_2]:update(arg_21_0.friendVOs[arg_21_1 + 1])

	return
end

function var_0_0.initFriend(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:createFriendItem(arg_22_1)

	onToggle(arg_22_0, var_22_0.tf, function(arg_23_0)
		if arg_23_0 and var_22_0.friendVO then
			arg_22_0:openChatPanel(var_22_0.friendVO)

			arg_22_0.contextData.friendVO = var_22_0.friendVO

			arg_22_0:setFriendVO(var_22_0.friendVO)
			arg_22_0:emit(ChatRoomMediator.CLEAR_UNREADCOUNT, var_22_0.friendVO.id)
		end

		return
	end)

	arg_22_0.friendItems[arg_22_1] = var_22_0

	return
end

function var_0_0.updateFriendVO(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.friendVOs) do
		if iter_24_1.id == arg_24_1.id then
			arg_24_0.friendVOs[iter_24_0] = arg_24_1

			break
		end
	end

	if arg_24_1.id == arg_24_0.friendVO.id then
		arg_24_0.friendVO = arg_24_1
	end

	arg_24_0:sortFriend()

	return
end

function var_0_0.sortFriend(arg_25_0)
	table.sort(arg_25_0.friendVOs, function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0.id == arg_25_0.friendVO.id and 1 or 0
		local var_26_1 = arg_26_1.id == arg_25_0.friendVO.id and 1 or 0

		if (arg_26_0.id == arg_25_0.friendVO.id and 1 or 0) == (arg_26_1.id == arg_25_0.friendVO.id and 1 or 0) then
			if arg_26_0.online == arg_26_1.online then
				if arg_26_0.level == arg_26_1.level then
					return arg_26_0.id < arg_26_1.id
				else
					return arg_26_0.level > arg_26_1.level
				end
			else
				return arg_26_0.online > arg_26_1.online
			end
		else
			return var_26_1 < var_26_0
		end

		return
	end)
	arg_25_0.friendRect:SetTotalCount(#arg_25_0.friendVOs, -1)

	return
end

function var_0_0.openChatPanel(arg_27_0, arg_27_1)
	arg_27_0.friendVO = arg_27_1

	removeAllChildren(arg_27_0.chatsContainer)

	for iter_27_0, iter_27_1 in pairs(arg_27_0.cacheMsgsVOs[arg_27_1.id] or {}) do
		arg_27_0:appendMsg(iter_27_1)
	end

	setText(arg_27_0.chatPanelTitle, arg_27_0.friendVO.name)
	setActive(arg_27_0.chatPanel, true)
	onButton(arg_27_0, arg_27_0.sendBtn, function()
		setInputText(arg_27_0.inputTF, "")
		arg_27_0:sendMessage((getInputText(arg_27_0.inputTF)))

		return
	end)

	return
end

function var_0_0.sendMessage(arg_29_0, arg_29_1)
	if arg_29_1 == "" then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_send_msg_null_tip"))

		return
	end

	arg_29_0:emit(ChatRoomMediator.SEND_FRIEND_MSG, arg_29_0.friendVO.id, arg_29_1)

	return
end

function var_0_0.getPlayer(arg_30_0, arg_30_1)
	if arg_30_1 == arg_30_0.playerVO.id then
		return arg_30_0.playerVO
	end

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.friendVOs) do
		if iter_30_1.id == arg_30_1 then
			return iter_30_1
		end
	end

	return
end

function var_0_0.appendMsg(arg_31_0, arg_31_1)
	if arg_31_1.playerId ~= arg_31_0.playerVO.id and arg_31_1.playerId ~= arg_31_0.friendVO.id then
		return
	end

	arg_31_0:emit(ChatRoomMediator.CLEAR_UNREADCOUNT, arg_31_0.friendVO.id)

	local var_31_0 = arg_31_0.otherPopTpl

	if arg_31_1.playerId == arg_31_0.playerVO.id then
		var_31_0 = arg_31_0.selfPopTpl
		arg_31_1.player = setmetatable(Clone(arg_31_0.playerVO), {
			__index = arg_31_0:getPlayer(arg_31_1.playerId)
		})
		arg_31_1.isSelf = true
	end

	ChatRoomBubble.New((cloneTplTo(var_31_0, arg_31_0.chatsContainer))):update(arg_31_1)
	scrollToBottom(arg_31_0.chatsRect)

	return
end

function var_0_0.closeChatPanel(arg_32_0)
	setActive(arg_32_0.chatPanel, false)

	return
end

function var_0_0.willExit(arg_33_0)
	arg_33_0:UnOverlayPanel(arg_33_0.frame, arg_33_0._tf)
	eachChild(arg_33_0.chatsContainer, function(arg_34_0)
		local var_34_0 = arg_34_0:Find("face")

		if var_34_0.childCount > 0 then
			local var_34_1 = var_34_0:GetChild(0).gameObject

			PoolMgr.GetInstance():ReturnPrefab("emoji/" .. var_34_1.name, var_34_1.name, var_34_1)
		end

		return
	end)

	for iter_33_0, iter_33_1 in pairs(arg_33_0.friendItems) do
		iter_33_1:dispose()
	end

	return
end

function var_0_0.insertEmojiToInputText(arg_35_0, arg_35_1)
	setInputText(arg_35_0.inputTF, getInputText(arg_35_0.inputTF) .. string.gsub(ChatConst.EmojiIconCode, "code", arg_35_1))

	return
end

return var_0_0
