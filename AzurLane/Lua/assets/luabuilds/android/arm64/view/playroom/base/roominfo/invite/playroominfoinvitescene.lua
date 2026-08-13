class = var_0_10000

local var_0_0 = "PlayRoomInfoInviteScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.PAGE = {
	GUILD = 2,
	FRIEND = 1
}

function var_0_1.getUIName(arg_1_0)
	return "IslandPlayRoomInfoInviteUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.OverlayPanel
	local var_2_2 = arg_2_0._tf
	local var_2_3 = {}
	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_7.Find(var_2_5, "bg")
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

	local var_2_12 = arg_2_0.uiFriendText

	i18n = var_2_10

	var_2_1(var_2_12, var_2_10("island_friend"))

	setText = var_2_1

	local var_2_13 = arg_2_0.uiGuildText

	i18n = var_4

	var_2_1(var_2_13, var_4("island_guild"))

	onToggle = var_2_1

	local var_2_14 = arg_2_0
	local var_2_15 = arg_2_0.uiFriendToggle

	local function var_2_16(arg_5_0)
		if arg_5_0 then
			arg_2_0.selectedPage = var_0_1.PAGE.FRIEND

			local var_5_0 = arg_2_0

			var_1.RefreshUI(var_5_0)
		end

		local var_5_1 = arg_2_0.uiFriendText

		if arg_5_0 then
			Color = var_2_10002

			if not var_2_10002.NewHex("FEFEFE") then
				Color = var_2_10002
				var_2_10002 = var_2_10002.NewHex("6B6E75")
			end

			var_5_1.color = var_2_10002

			return
		end
	end

	SFX_PANEL = var_6

	var_2_1(var_2_14, var_2_15, var_2_16, var_6)

	onToggle = var_2_1

	local var_2_17 = arg_2_0
	local var_2_18 = arg_2_0.uiGuildToggle

	local function var_2_19(arg_6_0)
		if arg_6_0 then
			arg_2_0.selectedPage = var_0_1.PAGE.GUILD

			local var_6_0 = arg_2_0

			var_1.RefreshUI(var_6_0)
		end

		local var_6_1 = arg_2_0.uiGuildText

		if arg_6_0 then
			Color = var_2_10002

			if not var_2_10002.NewHex("FEFEFE") then
				Color = var_2_10002
				var_2_10002 = var_2_10002.NewHex("6B6E75")
			end

			var_6_1.color = var_2_10002

			return
		end
	end

	SFX_PANEL = var_6

	var_2_1(var_2_17, var_2_18, var_2_19, var_6)

	local var_2_20 = arg_2_0.uiFriendText

	Color = var_1_10002
	var_2_20.color = var_1_10002.NewHex("FEFEFE")

	local var_2_21 = arg_2_0.uiGuildText

	Color = var_2
	var_2_21.color = var_2.NewHex("6B6E75")
	LuaList = var_2_21

	local var_2_22 = var_2_21.New
	local var_2_23 = arg_2_0

	handler = var_4

	local var_2_24 = var_4(arg_2_0, arg_2_0.IndexItem)
	local var_2_25 = arg_2_0.uiList

	PlayRoomInfoInviteItem = var_6
	arg_2_0.uiScrollView = var_2_22(var_2_23, var_2_24, var_2_25, var_6)

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0.selectedPage = var_0_1.PAGE.FRIEND
	triggerToggle = var_1

	var_1(arg_7_0.uiFriendToggle, true)

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	local var_8_0 = arg_8_0.uiScrollView

	var_1.Dispose(var_8_0)

	arg_8_0.uiScrollView = nil

	return
end

function var_0_1.RefreshUI(arg_9_0)
	arg_9_0.displayData = arg_9_0:GetDisplayData()

	local var_9_0 = arg_9_0.uiScrollView

	var_1.StartScroll(var_9_0, #arg_9_0.displayData)

	setActive = var_1

	var_1(arg_9_0.uiEmptyGo, #arg_9_0.displayData <= 0)

	return
end

function var_0_1.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:didEnter(arg_10_0.displayData[arg_10_1])

	return
end

function var_0_1.RefreshItem(arg_11_0)
	local var_11_0 = arg_11_0.uiScrollView

	var_1.Refresh(var_11_0)

	return
end

function var_0_1.GetDisplayData(arg_12_0)
	local var_12_0 = {}

	if arg_12_0.selectedPage == var_0_1.PAGE.FRIEND then
		getProxy = var_2
		FriendProxy = var_1_10004
		var_1_10004 = var_2(var_1_10004)
		var_12_0 = var_2.getAllFriends(var_1_10004)
	elseif arg_12_0.selectedPage == var_0_1.PAGE.GUILD then
		getProxy = var_2
		GuildProxy = var_1_10004

		local var_12_1 = var_2(var_1_10004)

		var_12_0 = var_2.getRawData(var_12_1) and var_2:getSortMemberWithoutSelf() or {}
	end

	table = var_2

	var_2.sort(var_12_0, function(arg_13_0, arg_13_1)
		if arg_13_0:isOnline() ~= arg_13_1:isOnline() then
			return var_2 == true
		end

		return arg_13_0.preOnLineTime >= arg_13_1.preOnLineTime
	end)

	return var_12_0
end

return var_0_1
