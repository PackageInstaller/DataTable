class = var_0_10000

local var_0_0 = "PlayRoomRankScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.PAGE = {
	ALL = 0,
	FRIEND = 1,
	GUILD = 2
}

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomRankUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.OverlayPanel
	local var_2_2 = arg_2_0._tf
	local var_2_3 = {}
	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_6.Find(var_2_5, "bg")
	var_2_3.pbList = var_2_4

	var_2_1(var_2_0, var_2_2, var_2_3)

	onButton = var_2_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiBgBtn

	local function var_2_8()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_6, var_2_7, var_2_8, var_2_4)

	onButton = var_2_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.uiCloseBtn

	local function var_2_11()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_9, var_2_10, var_2_11, var_2_4)

	setText = var_2_1

	local var_2_12 = arg_2_0.uiFriendText1

	i18n = var_2_10

	var_2_1(var_2_12, var_2_10("island_friend"))

	setText = var_2_1

	local var_2_13 = arg_2_0.uiFriendText2

	i18n = var_3

	var_2_1(var_2_13, var_3("island_friend"))

	setText = var_2_1

	local var_2_14 = arg_2_0.uiGuildText1

	i18n = var_3

	var_2_1(var_2_14, var_3("island_guild"))

	setText = var_2_1

	local var_2_15 = arg_2_0.uiGuildText2

	i18n = var_3

	var_2_1(var_2_15, var_3("island_guild"))

	setText = var_2_1

	local var_2_16 = arg_2_0.uiAllText1

	i18n = var_3

	var_2_1(var_2_16, var_3("channel_name_1"))

	setText = var_2_1

	local var_2_17 = arg_2_0.uiAllText2

	i18n = var_3

	var_2_1(var_2_17, var_3("channel_name_1"))

	triggerToggle = var_2_1

	var_2_1(arg_2_0.uiFriendToggle, true)

	onToggle = var_2_1

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.uiFriendToggle

	local function var_2_20(arg_5_0)
		if arg_5_0 then
			arg_2_0.selectedPage = var_0_1.PAGE.FRIEND

			local var_5_0 = arg_2_0

			var_1.RefreshUI(var_5_0)
		end

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_18, var_2_19, var_2_20, var_2_4)

	onToggle = var_2_1

	local var_2_21 = arg_2_0
	local var_2_22 = arg_2_0.uiGuildToggle

	local function var_2_23(arg_6_0)
		if arg_6_0 then
			arg_2_0.selectedPage = var_0_1.PAGE.GUILD

			local var_6_0 = arg_2_0

			var_1.RefreshUI(var_6_0)
		end

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_21, var_2_22, var_2_23, var_2_4)

	onToggle = var_2_1

	local var_2_24 = arg_2_0
	local var_2_25 = arg_2_0.uiAllToggle

	local function var_2_26(arg_7_0)
		if arg_7_0 then
			arg_2_0.selectedPage = var_0_1.PAGE.ALL

			local var_7_0 = arg_2_0

			var_1.RefreshUI(var_7_0)
		end

		return
	end

	SFX_PANEL = var_2_4

	var_2_1(var_2_24, var_2_25, var_2_26, var_2_4)

	LuaList = var_2_1

	local var_2_27 = var_2_1.New
	local var_2_28 = arg_2_0

	handler = var_2_25

	local var_2_29 = var_2_25(arg_2_0, arg_2_0.IndexItem)
	local var_2_30 = arg_2_0.uiList

	PlayRoomRankItem = var_5
	arg_2_0.uiScrollView = var_2_27(var_2_28, var_2_29, var_2_30, var_5)
	PlayRoomRankItem = var_1
	arg_2_0.rankItemView = var_1.New(arg_2_0.uiItem, arg_2_0)

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0.selectedPage = var_0_1.PAGE.FRIEND

	return
end

function var_0_1.willExit(arg_9_0)
	arg_9_0:UnOverlayPanel(arg_9_0._tf)

	local var_9_0 = arg_9_0.uiScrollView

	var_1.Dispose(var_9_0)

	arg_9_0.uiScrollView = nil

	local var_9_1 = arg_9_0.rankItemView

	var_1.willExit(var_9_1)

	arg_9_0.rankItemView = nil

	return
end

function var_0_1.RefreshUI(arg_10_0)
	arg_10_0.displayData = arg_10_0:GetDisplayData()

	local var_10_0 = arg_10_0.uiScrollView

	var_1.StartScroll(var_10_0, #arg_10_0.displayData)

	local var_10_1 = arg_10_0.rankItemView
	local var_10_2 = var_1.didEnter

	getProxy = var_3
	PlayRoomProxy = var_1_10004

	local var_10_3 = var_3(var_1_10004)

	var_10_2(var_10_1, var_3.GetSelfRankData(var_10_3, arg_10_0.contextData.gameType))

	return
end

function var_0_1.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:didEnter(arg_11_0.displayData[arg_11_1])

	return
end

function var_0_1.GetDisplayData(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}

	getProxy = var_1_10003
	PlayRoomProxy = var_1_10004

	local var_12_2 = var_1_10003(var_1_10004)
	local var_12_3 = var_3.GetRankData(var_12_2, arg_12_0.contextData.gameType)
	local var_12_4

	if arg_12_0.selectedPage == var_0_1.PAGE.FRIEND then
		getProxy = var_4
		FriendProxy = var_12_4
		var_12_4 = var_4(var_12_4)
		var_12_1 = var_4.getAllFriends(var_12_4)
	elseif arg_12_0.selectedPage == var_0_1.PAGE.GUILD then
		getProxy = var_4
		GuildProxy = var_12_4
		var_12_4 = var_4(var_12_4)
		var_12_1 = var_4.getRawData(var_12_4) and var_4:getSortMemberWithoutSelf() or {}
	else
		return var_12_3
	end

	local var_12_5 = {}

	ipairs = var_12_4

	for iter_12_0, iter_12_1 in var_12_4(var_12_1) do
		table = var_1_10010

		var_1_10010.insert(var_12_5, iter_12_1.id)
	end

	ipairs = var_5

	for iter_12_2, iter_12_3 in var_5(var_12_3) do
		table = var_1_10010

		if var_1_10010.keyof(var_12_5, iter_12_3.playerData.id) then
			table = var_1_10010

			var_1_10010.insert(var_12_0, iter_12_3)
		end
	end

	return var_12_0
end

return var_0_1
