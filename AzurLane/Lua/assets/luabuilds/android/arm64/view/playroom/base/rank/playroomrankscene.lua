local var_0_0 = class("PlayRoomRankScene", import("view.base.BaseUI"))

var_0_0.PAGE = {
	ALL = 0,
	FRIEND = 1,
	GUILD = 2
}

function var_0_0.getUIName(arg_1_0)
	return "IslandPlayRoomRankUI"
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
	setText(arg_2_0.uiFriendText1, i18n("island_friend"))
	setText(arg_2_0.uiFriendText2, i18n("island_friend"))
	setText(arg_2_0.uiGuildText1, i18n("island_guild"))
	setText(arg_2_0.uiGuildText2, i18n("island_guild"))
	setText(arg_2_0.uiAllText1, i18n("channel_name_1"))
	setText(arg_2_0.uiAllText2, i18n("channel_name_1"))
	triggerToggle(arg_2_0.uiFriendToggle, true)
	onToggle(arg_2_0, arg_2_0.uiFriendToggle, function(arg_5_0)
		if arg_5_0 then
			arg_2_0.selectedPage = var_0_0.PAGE.FRIEND

			arg_2_0:RefreshUI()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_2_0, arg_2_0.uiGuildToggle, function(arg_6_0)
		if arg_6_0 then
			arg_2_0.selectedPage = var_0_0.PAGE.GUILD

			arg_2_0:RefreshUI()
		end

		return
	end, SFX_PANEL)
	onToggle(arg_2_0, arg_2_0.uiAllToggle, function(arg_7_0)
		if arg_7_0 then
			arg_2_0.selectedPage = var_0_0.PAGE.ALL

			arg_2_0:RefreshUI()
		end

		return
	end, SFX_PANEL)

	arg_2_0.uiScrollView = LuaList.New(arg_2_0, handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList, PlayRoomRankItem)
	arg_2_0.rankItemView = PlayRoomRankItem.New(arg_2_0.uiItem, arg_2_0)

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0.selectedPage = var_0_0.PAGE.FRIEND

	return
end

function var_0_0.willExit(arg_9_0)
	arg_9_0:UnOverlayPanel(arg_9_0._tf)
	arg_9_0.uiScrollView:Dispose()

	arg_9_0.uiScrollView = nil

	arg_9_0.rankItemView:willExit()

	arg_9_0.rankItemView = nil

	return
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.displayData = arg_10_0:GetDisplayData()

	arg_10_0.uiScrollView:StartScroll(#arg_10_0.displayData)
	arg_10_0.rankItemView:didEnter(getProxy(PlayRoomProxy):GetSelfRankData(arg_10_0.contextData.gameType))

	return
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:didEnter(arg_11_0.displayData[arg_11_1])

	return
end

function var_0_0.GetDisplayData(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = getProxy(PlayRoomProxy):GetRankData(arg_12_0.contextData.gameType)

	if arg_12_0.selectedPage == var_0_0.PAGE.FRIEND then
		var_12_0 = getProxy(FriendProxy):getAllFriends()
	elseif arg_12_0.selectedPage == var_0_0.PAGE.GUILD then
		local var_12_2 = getProxy(GuildProxy):getRawData()

		var_12_0 = var_12_2 and var_12_2:getSortMemberWithoutSelf() or {}
	else
		return var_12_1
	end

	local var_12_3 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		table.insert(var_12_3, iter_12_1.id)
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_1) do
		if table.keyof(var_12_3, iter_12_3.playerData.id) then
			table.insert({}, iter_12_3)
		end
	end

	return {}
end

return var_0_0
