local var_0_0 = class("PlayRoomInfoViewerScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "IslandPlayRoomInfoViewerUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0._tf:Find("bg")
		}
	})
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.uiSwitchBtn, function()
		local var_4_0 = PlayRoomTools.GetUnfullTeamIndex()

		if var_4_0 == nil then
			return
		end

		arg_2_0:emit(PlayRoomInfoViewerMediator.ON_CLICK_SWITCH, {
			teamIndex = var_4_0
		})

		return
	end, SFX_PANEL)

	arg_2_0.uiScrollView = LuaList.New(arg_2_0, handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList, PlayRoomInfoViewerItem)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0.playRoomProxy = getProxy(PlayRoomProxy)
	arg_5_0.roomData = arg_5_0.playRoomProxy:GetRoomData()

	arg_5_0:RefreshUI()

	return
end

function var_0_0.willExit(arg_6_0)
	arg_6_0:UnOverlayPanel(arg_6_0._tf)
	arg_6_0.uiScrollView:Dispose()

	arg_6_0.uiScrollView = nil

	return
end

function var_0_0.RefreshUI(arg_7_0)
	arg_7_0:RefreshBtn()
	arg_7_0:RefreshPlayerList()

	return
end

function var_0_0.RefreshPlayerList(arg_8_0)
	arg_8_0.viewerList = Clone(arg_8_0.roomData.viewerList)

	local var_8_0 = getProxy(PlayerProxy):getPlayerId()

	table.sort(arg_8_0.viewerList, function(arg_9_0, arg_9_1)
		return arg_9_0 == var_8_0
	end)
	arg_8_0.uiScrollView:StartScroll(#arg_8_0.viewerList)

	return
end

function var_0_0.RefreshBtn(arg_10_0)
	if PlayRoomTools.IsViewer() then
		setText(arg_10_0.uiBtnText, i18n("play_room_switch_viewer"))
		setButtonEnabled(arg_10_0.uiSwitchBtn, not PlayRoomTools.IsPlayerFull())
	else
		setText(arg_10_0.uiBtnText, i18n("play_room_switch_player"))
		setButtonEnabled(arg_10_0.uiSwitchBtn, not PlayRoomTools.IsViewerFull())
	end

	return
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = getProxy(PlayerProxy)

	arg_11_2:didEnter(arg_11_0.roomData.playerDataList[arg_11_0.viewerList[arg_11_1]], PlayRoomTools.GetHostID() == var_11_0:getPlayerId())

	return
end

return var_0_0
