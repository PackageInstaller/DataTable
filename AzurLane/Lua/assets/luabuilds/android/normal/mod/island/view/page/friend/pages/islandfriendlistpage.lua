class = var_0_10000

local var_0_0 = "IslandFriendListPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFriendListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.morePanel = var_1.Find(var_2_0, "scrollrect/content/more_panel")

	local var_2_1 = arg_2_0.morePanel

	arg_2_0.whiteBtn = var_1.Find(var_2_1, "white")

	local var_2_2 = arg_2_0.morePanel

	arg_2_0.blackBtn = var_1.Find(var_2_2, "black")

	local var_2_3 = arg_2_0.morePanel

	arg_2_0.delBtn = var_1.Find(var_2_3, "del")
	arg_2_0.cards = {}

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "scrollrect")

	arg_2_0._scrollrect = var_1.GetComponent(var_2_5, "LScrollRect")

	function arg_2_0._scrollrect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	local var_2_6 = arg_2_0._scrollrect

	function var_2_6.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	setText = var_2_6

	local var_2_7 = arg_2_0.morePanel
	local var_2_8 = var_2.Find(var_2_7, "white/Text")

	i18n = var_2_7

	var_2_6(var_2_8, var_2_7("island_whiteList"))

	setText = var_2_6

	local var_2_9 = arg_2_0.morePanel
	local var_2_10 = var_2.Find(var_2_9, "black/Text")

	i18n = var_2_9

	var_2_6(var_2_10, var_2_9("island_blackList"))

	if arg_2_0.delBtn then
		setText = var_1

		local var_2_11 = arg_2_0.morePanel
		local var_2_12 = var_2.Find(var_2_11, "del/Text")

		i18n = var_2_11

		var_1(var_2_12, var_2_11("island_btn_label_del"))
	end

	return
end

function var_0_1.CreateCard(arg_5_0, arg_5_1)
	IslandFriendCard = var_1_10002

	return var_1_10002.New(arg_5_1)
end

function var_0_1.OnInitItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.CreateCard(var_6_0, arg_6_1)

	onButton = var_6_0

	local var_6_2 = arg_6_0
	local var_6_3 = var_6_1.visitBtn

	local function var_6_4()
		pg = var_2_10000

		local var_7_0 = var_2_10000.GameTrackerMgr.GetInstance()
		local var_7_1 = var_0.Record

		GameTrackerBuilder = var_2_10002

		local var_7_2 = var_2_10002.BuildIslandVisit

		playerId = var_2_10003

		var_7_1(var_7_0, var_7_2(var_2_10003))

		local var_7_3 = arg_6_0
		local var_7_4 = var_0.emit

		IslandMediator = var_2

		var_7_4(var_7_3, var_2.ENTER_ISLAND, var_6_1.player.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_6_0(var_6_2, var_6_3, var_6_4, var_1_10007)

	onButton = var_6_0

	local var_6_5 = arg_6_0
	local var_6_6 = var_6_1.moreBtn

	local function var_6_7()
		if arg_6_0.isOpenMore then
			local var_8_0 = arg_6_0

			var_0.CloseMorePanel(var_8_0)
		else
			local var_8_1 = var_6_1.moreBtn.parent.parent
			local var_8_2 = var_0.InverseTransformPoint(var_8_1, var_6_1.moreBtn.position)
			local var_8_3 = arg_6_0

			var_1.OpenMorePanel(var_8_3, var_6_1.player, var_8_2)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_6_0(var_6_5, var_6_6, var_6_7, var_1_10007)

	onButton = var_6_0

	local var_6_8 = arg_6_0
	local var_6_9 = var_6_1.cardBtn

	local function var_6_10()
		local var_9_0 = arg_6_0
		local var_9_1 = var_0.emit

		IslandMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.OPEN_PAGE, "IslandOtherCardPage", {
			var_6_1.player.id
		})

		return
	end

	SFX_PANEL = var_1_10007

	var_6_0(var_6_8, var_6_9, var_6_10, var_1_10007)

	arg_6_0.cards[arg_6_1] = var_6_1

	return
end

function var_0_1.OpenMorePanel(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.isOpenMore = true
	setActive = var_3

	var_3(arg_10_0.morePanel, true)

	local var_10_0 = arg_10_0.morePanel

	var_3.SetAsLastSibling(var_10_0)

	local var_10_1 = arg_10_0.morePanel

	Vector3 = var_10_0
	var_10_1.localPosition = arg_10_2 - var_10_0(110, 0, 0)

	local var_10_2 = arg_10_0.morePanel

	arg_10_0.whiteBtn = var_3.Find(var_10_2, "white")

	local var_10_3 = arg_10_0.morePanel

	arg_10_0.blackBtn = var_3.Find(var_10_3, "black")

	local var_10_4 = arg_10_0.morePanel

	arg_10_0.delBtn = var_3.Find(var_10_4, "del")

	arg_10_0:InitMoreBtns(arg_10_1)

	return
end

function var_0_1.InitMoreBtns(arg_11_0, arg_11_1)
	onButton = var_1_10002

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.whiteBtn

	local function var_11_2()
		local var_12_0 = arg_11_0
		local var_12_1 = var_0.emit

		IslandMediator = var_2_10002

		var_12_1(var_12_0, var_2_10002.ADD_WHITE_LIST, arg_11_1.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_11_0, var_11_1, var_11_2, var_1_10006)

	onButton = var_1_10002

	local var_11_3 = arg_11_0
	local var_11_4 = arg_11_0.blackBtn

	local function var_11_5()
		local var_13_0 = arg_11_0
		local var_13_1 = var_0.emit

		IslandMediator = var_2_10002

		var_13_1(var_13_0, var_2_10002.ADD_BLACK_LIST, arg_11_1.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_11_3, var_11_4, var_11_5, var_1_10006)

	onButton = var_1_10002

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.delBtn

	local function var_11_8()
		pg = var_2_10000

		local var_14_0 = var_2_10000.NewStyleMsgboxMgr.GetInstance()
		local var_14_1 = var_0.Show

		pg = var_2_10002

		local var_14_2 = var_2_10002.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
		local var_14_3 = {}

		i18n = var_2_10004
		var_14_3.contentText = var_2_10004("remove_friend_tip")

		function var_14_3.onConfirm()
			local var_15_0 = arg_11_0
			local var_15_1 = var_0.emit

			IslandMediator = var_3_10002

			var_15_1(var_15_0, var_3_10002.REMOVE_FRIEND, arg_11_1.id)

			return
		end

		var_14_1(var_14_0, var_14_2, var_14_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_11_6, var_11_7, var_11_8, var_1_10006)

	return
end

function var_0_1.CloseMorePanel(arg_16_0)
	arg_16_0.isOpenMore = false
	setActive = var_1

	var_1(arg_16_0.morePanel, false)

	return
end

function var_0_1.OnUpdateItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0

	if not arg_17_0.cards[arg_17_2] then
		arg_17_0:OnInitItem(arg_17_2)

		var_17_0 = arg_17_0.cards[arg_17_2]
	end

	local var_17_1 = arg_17_0.displays[arg_17_1 + 1]

	var_17_0:Update(var_17_1)

	return
end

function var_0_1.Show(arg_18_0)
	var_0_1.super.Show(arg_18_0)
	arg_18_0:InitList()

	return
end

function var_0_1.Hide(arg_19_0)
	var_0_1.super.Hide(arg_19_0)

	if arg_19_0.isOpenMore then
		arg_19_0:CloseMorePanel()
	end

	return
end

function var_0_1.Flush(arg_20_0)
	arg_20_0:InitList()

	return
end

function var_0_1.GetData(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	FriendProxy = var_1_10003

	local var_21_0 = var_1_10002(var_1_10003)

	if #var_2.getAllFriends(var_21_0) <= 0 then
		return arg_21_1({})
	end

	local var_21_1 = {}

	pairs = var_4

	for iter_21_0, iter_21_1 in var_4(var_2) do
		table = var_1_10009

		var_1_10009.insert(var_21_1, iter_21_1.id)
	end

	local var_21_2 = arg_21_0
	local var_21_3 = arg_21_0.emit

	IslandMediator = var_6

	var_21_3(var_21_2, var_6.GET_GIFT_TAG, var_21_1, function()
		arg_21_1(var_0)

		return
	end)

	return
end

function var_0_1.InitList(arg_23_0)
	pg = var_1_10001

	local var_23_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_23_0)
	arg_23_0:GetData(function(arg_24_0)
		pg = var_2_10001

		local var_24_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_24_0)

		arg_23_0.displays = arg_24_0

		local var_24_1 = arg_23_0._scrollrect

		var_1.SetTotalCount(var_24_1, #arg_23_0.displays)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_25_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_25_0._scrollrect)

	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.cards) do
		iter_25_1:Dispose()
	end

	arg_25_0.cards = nil

	return
end

return var_0_1
