class = var_0_10000

local var_0_0 = "FriendListPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "FriendListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.friendPanel = var_1.Find(var_2_0, "friend_panel")

	local var_2_1 = arg_2_0._tf

	arg_2_0.friendTopTF = var_1.Find(var_2_1, "friend_view_top")

	local var_2_2 = arg_2_0.friendTopTF

	arg_2_0.friendCountTF = var_1.Find(var_2_2, "friend_count/Text")

	local var_2_3 = arg_2_0.friendTopTF

	arg_2_0.friendIndexBtn = var_1.Find(var_2_3, "index_button")

	local var_2_4 = arg_2_0.friendTopTF

	arg_2_0.friendSortBtn = var_1.Find(var_2_4, "sort_button")

	local var_2_5 = arg_2_0.friendSortBtn

	arg_2_0.sortImgAsc = var_1.Find(var_2_5, "asc")

	local var_2_6 = arg_2_0.friendSortBtn

	arg_2_0.sortImgDec = var_1.Find(var_2_6, "desc")

	local var_2_7 = arg_2_0._tf

	arg_2_0.sortPanel = var_1.Find(var_2_7, "friend_sort_panel")

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.dec = false
	arg_3_0.sortdata = {}
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.friendSortBtn

	local function var_3_2()
		arg_3_0.dec = not arg_3_0.dec
		arg_3_0.contextData.sortData = {
			data = arg_3_0.sortdata,
			dec = arg_3_0.dec
		}

		local var_4_0 = arg_3_0

		var_0.sortFriends(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.friendIndexBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.openFriendsSortPanel(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.UpdateData(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_1.friendVOs then
		var_6_0 = {}
	end

	arg_6_0.friendVOs = var_6_0

	if not arg_6_0.isInit then
		arg_6_0.isInit = true

		arg_6_0:initFriendsPage()
		arg_6_0:initFriendsSortPanel()
	else
		arg_6_0:sortFriends()
	end

	arg_6_0:updateFriendCount()

	return
end

function var_0_1.initFriendsPage(arg_7_0)
	arg_7_0.friendItems = {}

	local var_7_0 = arg_7_0.friendPanel
	local var_7_1 = var_1.Find(var_7_0, "mask/view")

	arg_7_0.friendRect = var_1.GetComponent(var_7_1, "LScrollRect")

	function arg_7_0.friendRect.onInitItem(arg_8_0)
		local var_8_0 = arg_7_0

		var_1.onInitItem(var_8_0, arg_8_0)

		return
	end

	function arg_7_0.friendRect.onUpdateItem(arg_9_0, arg_9_1)
		local var_9_0 = arg_7_0

		var_2.onUpdateItem(var_9_0, arg_9_0, arg_9_1)

		return
	end

	return
end

function var_0_1.onInitItem(arg_10_0, arg_10_1)
	FriendListCard = var_1_10002

	local var_10_0 = var_1_10002.New(arg_10_1)

	onButton = var_3

	local var_10_1 = arg_10_0
	local var_10_2 = var_10_0.occuptBtn

	local function var_10_3()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		FriendMediator = var_2_10002

		var_11_1(var_11_0, var_2_10002.OPEN_CHATROOM, var_10_0.friendVO)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_10_1, var_10_2, var_10_3, var_1_10007)

	onButton = var_3

	local var_10_4 = arg_10_0
	local var_10_5 = var_10_0.deleteBtn

	local function var_10_6()
		pg = var_2_10000

		local var_12_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		i18n = var_2_10003
		var_12_2.content = var_2_10003("remove_friend_tip")

		function var_12_2.onYes()
			local var_13_0 = arg_10_0
			local var_13_1 = var_0.emit

			FriendMediator = var_3_10002

			var_13_1(var_13_0, var_3_10002.DELETE_FRIEND, var_10_0.friendVO.id)

			return
		end

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_10_4, var_10_5, var_10_6, var_1_10007)

	onButton = var_3

	local var_10_7 = arg_10_0
	local var_10_8 = var_10_0.resumeBtn

	local function var_10_9()
		local var_14_0 = arg_10_0
		local var_14_1 = var_0.emit

		FriendMediator = var_2_10002

		var_14_1(var_14_0, var_2_10002.OPEN_RESUME, var_10_0.friendVO.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_10_7, var_10_8, var_10_9, var_1_10007)

	onButton = var_3

	local var_10_10 = arg_10_0
	local var_10_11 = var_10_0.backYardBtn

	local function var_10_12()
		local var_15_0 = arg_10_0
		local var_15_1 = var_0.emit

		FriendMediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.VISIT_BACKYARD, var_10_0.friendVO.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_10_10, var_10_11, var_10_12, var_1_10007)

	arg_10_0.friendItems[arg_10_1] = var_10_0

	return
end

function var_0_1.onUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if not arg_16_0.friendItems[arg_16_2] then
		arg_16_0:onInitItem(arg_16_2)

		var_16_0 = arg_16_0.friendItems[arg_16_2]
	end

	local var_16_1 = arg_16_0.friendVOs[arg_16_1 + 1]

	var_16_0:update(var_16_1)

	return
end

function var_0_1.sortFriends(arg_17_0)
	if arg_17_0.contextData.sortData then
		arg_17_0.contextData.sortData.data.func(arg_17_0.friendVOs, arg_17_0.dec)

		setImageSprite = var_1

		local var_17_0 = arg_17_0.friendIndexBtn
		local var_17_1 = var_2.Find(var_17_0, "icon")

		GetSpriteFromAtlas = var_17_0

		var_1(var_17_1, var_17_0("ui/friendsui_atlas", arg_17_0.contextData.sortData.data.spr), true)

		setActive = var_1

		var_1(arg_17_0.sortImgAsc, arg_17_0.dec)

		setActive = var_1

		var_1(arg_17_0.sortImgDec, not arg_17_0.dec)
	end

	local var_17_2 = arg_17_0.friendRect

	var_1.SetTotalCount(var_17_2, #arg_17_0.friendVOs, -1)

	return
end

function var_0_1.updateFriendCount(arg_18_0)
	setText = var_1_10001

	local var_18_0 = arg_18_0.friendCountTF
	local var_18_1 = #arg_18_0.friendVOs
	local var_18_2 = "/"

	MAX_FRIEND_COUNT = var_1_10005

	var_1_10001(var_18_0, var_18_1 .. var_18_2 .. var_1_10005)

	return
end

function var_0_1.initFriendsSortPanel(arg_19_0)
	local var_19_0 = arg_19_0.sortPanel
	local var_19_1 = var_1.Find(var_19_0, "mask/content")
	local var_19_2 = arg_19_0
	local var_19_3 = arg_19_0.getTpl(var_19_2, "tpl", var_19_1)

	require = var_19_2
	arg_19_0.friendSortCfg = var_19_2("view.friend.FriendSortCfg")
	ipairs = var_3

	for iter_19_0, iter_19_1 in var_3(arg_19_0.friendSortCfg.SORT_TAG) do
		cloneTplTo = var_1_10008

		local var_19_4 = var_1_10008(var_19_3, var_19_1)
		local var_19_5 = var_1_10008.Find(var_19_4, "arr")

		setImageSprite = var_19_4

		local var_19_6 = var_1_10008
		local var_19_7 = var_1_10008.Find(var_19_6, "Image")

		GetSpriteFromAtlas = var_19_6

		var_19_4(var_19_7, var_19_6("ui/friendsui_atlas", iter_19_1.spr), true)

		onToggle = var_19_4

		local var_19_8 = arg_19_0
		local var_19_9 = var_1_10008

		local function var_19_10(arg_20_0)
			if arg_20_0 then
				arg_19_0.sortdata = iter_19_1
				arg_19_0.contextData.sortData = {
					data = arg_19_0.sortdata,
					dec = arg_19_0.dec
				}

				local var_20_0 = arg_19_0

				var_1.sortFriends(var_20_0)

				triggerButton = var_1

				var_1(arg_19_0.sortPanel)
			end

			return
		end

		SFX_PANEL = var_14

		var_19_4(var_19_8, var_19_9, var_19_10, var_14)

		if iter_19_0 == 1 then
			triggerToggle = var_19_4

			var_19_4(var_1_10008, true)
		end
	end

	onButton = var_3

	local var_19_11 = arg_19_0
	local var_19_12 = arg_19_0.sortPanel

	local function var_19_13()
		local var_21_0 = arg_19_0

		var_0.closeFriendsSortPanel(var_21_0)

		return
	end

	SFX_PANEL = iter_19_1

	var_3(var_19_11, var_19_12, var_19_13, iter_19_1)

	return
end

function var_0_1.openFriendsSortPanel(arg_22_0)
	if arg_22_0.contextData.sortData then
		setImageSprite = var_1

		local var_22_0 = arg_22_0.sortPanel
		local var_22_1 = var_2.Find(var_22_0, "index_button/icon")

		GetSpriteFromAtlas = var_22_0

		var_1(var_22_1, var_22_0("ui/friendsui_atlas", arg_22_0.contextData.sortData.data.spr), true)
	end

	setActive = var_1

	var_1(arg_22_0.sortPanel, true)

	return
end

function var_0_1.closeFriendsSortPanel(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.sortPanel, false)

	return
end

function var_0_1.OnDestroy(arg_24_0)
	pairs = var_1_10001

	local var_24_0

	if not arg_24_0.friendItems then
		var_24_0 = {}
	end

	for iter_24_0, iter_24_1 in var_1_10001(var_24_0) do
		iter_24_1:dispose()
	end

	return
end

return var_0_1
