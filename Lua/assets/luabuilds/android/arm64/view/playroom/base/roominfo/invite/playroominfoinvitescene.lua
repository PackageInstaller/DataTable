local var_0_0 = class("PlayRoomInfoInviteScene", import("view.base.BaseUI"))

var_0_0.PAGE = {
	GUILD = 2,
	FRIEND = 1
}

function var_0_0.getUIName(arg_1_0)
	return "IslandPlayRoomInfoInviteUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0._tf:Find("bg")
		}
	})
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)
	setText(arg_2_0.uiFriendText, i18n("island_friend"))
	setText(arg_2_0.uiGuildText, i18n("island_guild"))
	onToggle(arg_2_0, arg_2_0.uiFriendToggle, function(arg_5_0)
		if arg_5_0 then
			arg_2_0.selectedPage = var_0_0.PAGE.FRIEND

			arg_2_0:RefreshUI()
		end

		local var_5_0 = arg_2_0.uiFriendText

		var_5_0.color = arg_5_0 and Color.NewHex("FEFEFE") or Color.NewHex("6B6E75")

		return
	end, SFX_PANEL)
	onToggle(arg_2_0, arg_2_0.uiGuildToggle, function(arg_6_0)
		if arg_6_0 then
			arg_2_0.selectedPage = var_0_0.PAGE.GUILD

			arg_2_0:RefreshUI()
		end

		local var_6_0 = arg_2_0.uiGuildText

		var_6_0.color = arg_6_0 and Color.NewHex("FEFEFE") or Color.NewHex("6B6E75")

		return
	end, SFX_PANEL)

	arg_2_0.uiFriendText.color = Color.NewHex("FEFEFE")
	arg_2_0.uiGuildText.color = Color.NewHex("6B6E75")
	arg_2_0.uiScrollView = LuaList.New(arg_2_0, handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList, PlayRoomInfoInviteItem)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0.selectedPage = var_0_0.PAGE.FRIEND

	triggerToggle(arg_7_0.uiFriendToggle, true)

	return
end

function var_0_0.willExit(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)
	arg_8_0.uiScrollView:Dispose()

	arg_8_0.uiScrollView = nil

	return
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0.displayData = arg_9_0:GetDisplayData()

	arg_9_0.uiScrollView:StartScroll(#arg_9_0.displayData)
	setActive(arg_9_0.uiEmptyGo, #arg_9_0.displayData <= 0)

	return
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2:didEnter(arg_10_0.displayData[arg_10_1])

	return
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.uiScrollView:Refresh()

	return
end

function var_0_0.GetDisplayData(arg_12_0)
	local var_12_0 = {}

	if arg_12_0.selectedPage == var_0_0.PAGE.FRIEND then
		var_12_0 = getProxy(FriendProxy):getAllFriends()
	elseif arg_12_0.selectedPage == var_0_0.PAGE.GUILD then
		local var_12_1 = getProxy(GuildProxy):getRawData()

		var_12_0 = var_12_1 and var_12_1:getSortMemberWithoutSelf() or {}
	end

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_0:isOnline()

		if var_13_0 ~= arg_13_1:isOnline() then
			return var_13_0 == true
		end

		return arg_13_0.preOnLineTime >= arg_13_1.preOnLineTime
	end)

	return var_12_0
end

return var_0_0
