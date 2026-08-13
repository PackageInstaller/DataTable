class = var_0_10000

local var_0_0 = "ChatRoomLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChatRoomUI"
end

function var_0_1.setFriendVO(arg_2_0, arg_2_1)
	arg_2_0.friendVO = arg_2_1

	return
end

function var_0_1.setFriends(arg_3_0, arg_3_1)
	arg_3_0.friendVOs = arg_3_1

	return
end

function var_0_1.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.playerVO = arg_4_1

	return
end

function var_0_1.setCacheMsgs(arg_5_0, arg_5_1)
	arg_5_0.cacheMsgsVOs = arg_5_1

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.frame = var_1.Find(var_6_0, "frame")

	local var_6_1 = arg_6_0.frame

	arg_6_0.friendView = var_1.Find(var_6_1, "left_length/scrollView")

	local var_6_2 = arg_6_0.frame

	arg_6_0.chatPanel = var_1.Find(var_6_2, "notification_panel")

	local var_6_3 = arg_6_0.frame

	arg_6_0.chatPanelTitle = var_1.Find(var_6_3, "notification_panel/frame/top/name")

	local var_6_4 = arg_6_0.chatPanel

	arg_6_0.sendBtn = var_1.Find(var_6_4, "frame/bottom/send")

	local var_6_5 = arg_6_0.chatPanel

	arg_6_0.inputTF = var_1.Find(var_6_5, "frame/bottom/input")

	local var_6_6 = arg_6_0.chatPanel

	arg_6_0.chatsRect = var_1.Find(var_6_6, "frame/list")

	local var_6_7 = arg_6_0.chatPanel

	arg_6_0.chatsContainer = var_1.Find(var_6_7, "frame/list/content")

	local var_6_8 = arg_6_0._tf

	arg_6_0.closeBtn = var_1.Find(var_6_8, "frame/notification_panel/frame/top/close_btn")
	arg_6_0.otherPopTpl = arg_6_0:getTpl("frame/list/popo_other", arg_6_0.chatPanel)
	arg_6_0.selfPopTpl = arg_6_0:getTpl("frame/list/popo_self", arg_6_0.chatPanel)

	arg_6_0:BlurPanel(arg_6_0.frame)

	return
end

function var_0_1.didEnter(arg_7_0)
	local var_7_0 = arg_7_0.chatPanel
	local var_7_1 = var_1.Find(var_7_0, "frame/bottom/emoji")

	onButton = var_1_10002

	local var_7_2 = arg_7_0
	local var_7_3 = var_7_1

	local function var_7_4()
		local var_8_0 = var_7_1.position
		local var_8_1 = arg_7_0
		local var_8_2 = var_1.emit

		ChatRoomMediator = var_2_10004

		local var_8_3 = var_2_10004.OPEN_EMOJI

		Vector3 = var_2_10005

		var_8_2(var_8_1, var_8_3, var_2_10005(var_8_0.x, var_8_0.y, 0), function(arg_9_0)
			local var_9_0 = arg_7_0
			local var_9_1 = var_1.sendMessage

			string = var_3_10004

			local var_9_2 = var_3_10004.gsub

			ChatConst = var_3_10006

			var_9_1(var_9_0, var_9_2(var_3_10006.EmojiCode, "code", arg_9_0))

			return
		end)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_2, var_7_3, var_7_4, var_1_10007)

	onButton = var_1_10002

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0._tf

	local function var_7_7()
		local var_10_0 = arg_7_0

		var_0.emit(var_10_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10007

	var_1_10002(var_7_5, var_7_6, var_7_7, var_1_10007)

	onButton = var_1_10002

	local var_7_8 = arg_7_0
	local var_7_9 = arg_7_0.closeBtn

	local function var_7_10()
		local var_11_0 = arg_7_0

		var_0.emit(var_11_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10007

	var_1_10002(var_7_8, var_7_9, var_7_10, var_1_10007)
	arg_7_0:initFriends()

	return
end

function var_0_1.initFriends(arg_12_0)
	arg_12_0.friendItems = {}

	local var_12_0 = arg_12_0.friendView

	arg_12_0.friendRect = var_1.GetComponent(var_12_0, "LScrollRect")

	function arg_12_0.friendRect.onInitItem(arg_13_0)
		local var_13_0 = arg_12_0

		var_1.initFriend(var_13_0, arg_13_0)

		return
	end

	function arg_12_0.friendRect.onUpdateItem(arg_14_0, arg_14_1)
		local var_14_0 = arg_12_0

		var_2.updateFriend(var_14_0, arg_14_0, arg_14_1)

		return
	end

	arg_12_0:sortFriend()

	return
end

function var_0_1.createFriendItem(arg_15_0, arg_15_1)
	local var_15_0 = {}

	tf = var_1_10003
	var_15_0.tf = var_1_10003(arg_15_1)

	local var_15_1 = var_15_0.tf
	local var_15_2 = var_3.Find(var_15_1, "name")
	local var_15_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_15_0.nameTF = var_15_3(var_15_2, var_6(var_1_10008))

	local var_15_4 = var_15_0.tf
	local var_15_5 = var_3.Find(var_15_4, "shipicon/icon")
	local var_15_6 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	var_15_0.iconTF = var_15_6(var_15_5, var_6(var_1_10008))

	local var_15_7 = var_15_0.tf

	var_15_0.circle = var_3.Find(var_15_7, "shipicon/frame")

	local var_15_8 = var_15_0.tf
	local var_15_9 = var_3.GetComponent

	typeof = var_6
	Toggle = var_1_10008
	var_15_0.toggle = var_15_9(var_15_8, var_6(var_1_10008))

	local var_15_10 = var_15_0.tf

	var_15_0.tipTF = var_3.Find(var_15_10, "tip")

	local var_15_11 = var_15_0.tf
	local var_15_12 = var_3.Find(var_15_11, "lv_bg/date")
	local var_15_13 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_15_0.dateTF = var_15_13(var_15_12, var_6(var_1_10008))

	local var_15_14 = var_15_0.tf

	var_15_0.onlineTF = var_3.Find(var_15_14, "lv_bg/online")

	local var_15_15 = var_15_0.tf
	local var_15_16 = var_3.Find(var_15_15, "lv_bg/Text")
	local var_15_17 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	var_15_0.levelTF = var_15_17(var_15_16, var_6(var_1_10008))

	local var_15_18 = arg_15_0.friendVO

	function var_15_0.update(arg_16_0, arg_16_1, arg_16_2)
		arg_16_0:clear()

		setActive = var_3

		var_3(var_15_0.tipTF, false)

		arg_16_0.friendVO = arg_16_1
		var_15_0.nameTF.text = arg_16_1.name

		local var_16_0 = var_15_0.levelTF

		var_16_0.text = "LV." .. arg_16_1.level
		pg = var_16_0

		local var_16_1 = var_16_0.ship_data_statistics[arg_16_1.icon]

		Ship = var_4

		local var_16_2 = var_4.New({
			configId = arg_16_1.icon,
			skin_id = arg_16_1.skinId
		})

		assert = var_5

		var_5(var_16_1, "shipCfg is nil >> id ==" .. arg_16_1.icon)

		LoadSpriteAsync = var_5

		var_5("qicon/" .. var_16_2:getPainting(), function(arg_17_0)
			if not arg_17_0 then
				local var_17_0 = var_15_0.iconTF

				GetSpriteFromAtlas = var_3_10002
				var_17_0.sprite = var_3_10002("heroicon/unknown", "")
			else
				var_15_0.iconTF.sprite = arg_17_0
			end

			return
		end)

		AttireFrame = var_5

		local var_16_3 = var_5.attireFrameRes
		local var_16_4 = arg_16_1
		local var_16_5 = arg_16_1.id

		getProxy = var_9
		PlayerProxy = var_2_10011

		local var_16_6 = var_9(var_2_10011)
		local var_16_7 = var_16_5 == var_9.getRawData(var_16_6).id

		AttireConst = var_9

		local var_16_8 = var_16_3(var_16_4, var_16_7, var_9.TYPE_ICON_FRAME, arg_16_1.propose)

		PoolMgr = var_6

		local var_16_9 = var_6.GetInstance()

		var_6.GetPrefab(var_16_9, "IconFrame/" .. var_16_8, var_16_8, true, function(arg_18_0)
			if arg_16_0.circle then
				arg_18_0.name = var_16_8
				findTF = var_1

				local var_18_0 = var_1(arg_18_0.transform, "icon")
				local var_18_1 = var_1.GetComponent

				typeof = var_3_10005
				Image = var_3_10007
				var_18_1(var_18_0, var_3_10005(var_3_10007)).raycastTarget = false
				setParent = var_3

				var_3(arg_18_0, arg_16_0.circle, false)
			else
				PoolMgr = var_1

				local var_18_2 = var_1.GetInstance()

				var_1.ReturnPrefab(var_18_2, "IconFrame/" .. var_16_8, var_16_8, arg_18_0)
			end

			return
		end)

		if var_15_18.id == arg_16_1.id and var_15_0.toggle.isOn == false then
			triggerToggle = var_6

			var_6(var_15_0.tf, true)
		end

		setActive = var_6

		local var_16_10 = arg_16_0.onlineTF
		local var_16_11 = arg_16_1.online

		Friend = var_10

		var_6(var_16_10, var_16_11 == var_10.ONLINE)

		setActive = var_6

		local var_16_12 = var_15_0.dateTF
		local var_16_13 = arg_16_1.online

		Friend = var_10

		var_6(var_16_12, var_16_13 == var_10.OFFLINE)

		local var_16_14 = var_15_0.dateTF

		pg = var_7

		local var_16_15 = var_7.TimeMgr.GetInstance()

		var_16_14.text = var_7.STimeDescC(var_16_15, arg_16_1.preOnLineTime, "%Y/%m/%d")

		return
	end

	function var_15_0.clear(arg_19_0)
		local var_19_0 = arg_19_0.circle.childCount

		if 0 < var_19_0 then
			local var_19_1 = arg_19_0.circle
			local var_19_2 = var_1.GetChild(var_19_1, 0).gameObject

			PoolMgr = var_2

			local var_19_3 = var_2.GetInstance()

			var_2.ReturnPrefab(var_19_3, "IconFrame/" .. var_19_2.name, var_19_2.name, var_19_2)
		end

		return
	end

	function var_15_0.dispose(arg_20_0)
		arg_20_0:clear()

		return
	end

	return var_15_0
end

function var_0_1.updateFriend(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0

	if not arg_21_0.friendItems[arg_21_2] then
		arg_21_0:initFriend(arg_21_2)

		var_21_0 = arg_21_0.friendItems[arg_21_2]
	end

	local var_21_1 = arg_21_0.friendVOs[arg_21_1 + 1]

	var_21_0:update(var_21_1)

	return
end

function var_0_1.initFriend(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:createFriendItem(arg_22_1)

	onToggle = var_1_10003

	var_1_10003(arg_22_0, var_22_0.tf, function(arg_23_0)
		if arg_23_0 and var_22_0.friendVO then
			local var_23_0 = arg_22_0

			var_1.openChatPanel(var_23_0, var_22_0.friendVO)

			arg_22_0.contextData.friendVO = var_22_0.friendVO

			local var_23_1 = arg_22_0

			var_1.setFriendVO(var_23_1, var_22_0.friendVO)

			local var_23_2 = arg_22_0
			local var_23_3 = var_1.emit

			ChatRoomMediator = var_4

			var_23_3(var_23_2, var_4.CLEAR_UNREADCOUNT, var_22_0.friendVO.id)
		end

		return
	end)

	arg_22_0.friendItems[arg_22_1] = var_22_0

	return
end

function var_0_1.updateFriendVO(arg_24_0, arg_24_1)
	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.friendVOs) do
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

function var_0_1.sortFriend(arg_25_0)
	table = var_1_10001

	var_1_10001.sort(arg_25_0.friendVOs, function(arg_26_0, arg_26_1)
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
			return var_3 < var_2
		end

		return
	end)

	local var_25_0 = arg_25_0.friendRect

	var_1.SetTotalCount(var_25_0, #arg_25_0.friendVOs, -1)

	return
end

function var_0_1.openChatPanel(arg_27_0, arg_27_1)
	arg_27_0.friendVO = arg_27_1
	removeAllChildren = var_1_10002

	var_1_10002(arg_27_0.chatsContainer)

	local var_27_0 = arg_27_0.cacheMsgsVOs[arg_27_1.id]

	pairs = var_3

	for iter_27_0, iter_27_1 in var_3(var_27_0 or {}) do
		arg_27_0:appendMsg(iter_27_1)
	end

	setText = var_3

	var_3(arg_27_0.chatPanelTitle, arg_27_0.friendVO.name)

	setActive = var_3

	var_3(arg_27_0.chatPanel, true)

	onButton = var_3

	var_3(arg_27_0, arg_27_0.sendBtn, function()
		getInputText = var_2_10000

		local var_28_0 = var_2_10000(arg_27_0.inputTF)

		setInputText = var_2_10001

		var_2_10001(arg_27_0.inputTF, "")

		local var_28_1 = arg_27_0

		var_1.sendMessage(var_28_1, var_28_0)

		return
	end)

	return
end

function var_0_1.sendMessage(arg_29_0, arg_29_1)
	if arg_29_1 == "" then
		pg = var_1_10002

		local var_29_0 = var_1_10002.TipsMgr.GetInstance()
		local var_29_1 = var_2.ShowTips

		i18n = var_1_10005

		var_29_1(var_29_0, var_1_10005("friend_send_msg_null_tip"))

		return
	end

	local var_29_2 = arg_29_0
	local var_29_3 = arg_29_0.emit

	ChatRoomMediator = var_1_10005

	var_29_3(var_29_2, var_1_10005.SEND_FRIEND_MSG, arg_29_0.friendVO.id, arg_29_1)

	return
end

function var_0_1.getPlayer(arg_30_0, arg_30_1)
	if arg_30_1 == arg_30_0.playerVO.id then
		return arg_30_0.playerVO
	end

	ipairs = var_2

	for iter_30_0, iter_30_1 in var_2(arg_30_0.friendVOs) do
		if iter_30_1.id == arg_30_1 then
			return iter_30_1
		end
	end

	return
end

function var_0_1.appendMsg(arg_31_0, arg_31_1)
	if arg_31_1.playerId ~= arg_31_0.playerVO.id and arg_31_1.playerId ~= arg_31_0.friendVO.id then
		return
	end

	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.emit

	ChatRoomMediator = var_1_10005

	var_31_1(var_31_0, var_1_10005.CLEAR_UNREADCOUNT, arg_31_0.friendVO.id)

	local var_31_2 = arg_31_0.otherPopTpl
	local var_31_3 = arg_31_0:getPlayer(arg_31_1.playerId)

	if arg_31_1.playerId == arg_31_0.playerVO.id then
		var_31_2 = arg_31_0.selfPopTpl
		setmetatable = var_4
		Clone = var_6
		arg_31_1.player = var_4(var_6(arg_31_0.playerVO), {
			__index = var_31_3
		})
		arg_31_1.isSelf = true
	end

	cloneTplTo = var_4

	local var_31_4 = var_4(var_31_2, arg_31_0.chatsContainer)

	ChatRoomBubble = var_5

	local var_31_5 = var_5.New(var_31_4)

	var_5.update(var_31_5, arg_31_1)

	scrollToBottom = var_6

	var_6(arg_31_0.chatsRect)

	return
end

function var_0_1.closeChatPanel(arg_32_0)
	setActive = var_1_10001

	var_1_10001(arg_32_0.chatPanel, false)

	return
end

function var_0_1.willExit(arg_33_0)
	arg_33_0:UnOverlayPanel(arg_33_0.frame, arg_33_0._tf)

	eachChild = var_1

	var_1(arg_33_0.chatsContainer, function(arg_34_0)
		local var_34_0 = arg_34_0:Find("face").childCount

		if 0 < var_34_0 then
			local var_34_1 = var_1:GetChild(0).gameObject

			PoolMgr = var_3

			local var_34_2 = var_3.GetInstance()

			var_3.ReturnPrefab(var_34_2, "emoji/" .. var_34_1.name, var_34_1.name, var_34_1)
		end

		return
	end)

	pairs = var_1

	for iter_33_0, iter_33_1 in var_1(arg_33_0.friendItems) do
		iter_33_1:dispose()
	end

	return
end

function var_0_1.insertEmojiToInputText(arg_35_0, arg_35_1)
	setInputText = var_1_10002

	local var_35_0 = arg_35_0.inputTF

	getInputText = var_1_10005

	local var_35_1 = var_1_10005(arg_35_0.inputTF)

	string = var_1_10006

	local var_35_2 = var_1_10006.gsub

	ChatConst = var_1_10008

	var_1_10002(var_35_0, var_35_1 .. var_35_2(var_1_10008.EmojiIconCode, "code", arg_35_1))

	return
end

return var_0_1
