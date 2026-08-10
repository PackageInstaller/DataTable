local var_0_0 = import("game.views.sectionSelectHero.NewSectionSelectHeroBaseView")
local var_0_1 = class("CooperationSectionSelectHeroView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/Cooperation/CooperationMainUI"
end

function var_0_1.ProcessCustomParams(arg_2_0)
	arg_2_0.roomData_ = CooperationData:GetRoomData()
	arg_2_0.params_.roomData = arg_2_0.roomData_
	arg_2_0.masterPlayerID_ = arg_2_0.roomData_:GetMasetPlayerId()

	if arg_2_0.roomData_ == nil then
		arg_2_0:Go("/home")

		return
	end
end

function var_0_1.OnEnter(arg_3_0)
	FriendsAction:TryToRefreshFriendsView(1)
	arg_3_0:ProcessParams()
	arg_3_0:ProcessSubView()
	arg_3_0:SubViewOnEnter()
	arg_3_0:Refresh()
end

function var_0_1.UpdateMasterPlayerID(arg_4_0)
	local var_4_0 = arg_4_0.roomData_:GetMasetPlayerId()

	if arg_4_0.masterPlayerID_ ~= var_4_0 then
		local var_4_1 = arg_4_0.roomData_:GetRoomPlayerData(var_4_0)

		ShowTips(string.format(GetTips("ACTIVITY_STRONGHOLD_HOMEOWNER_CHANGE"), var_4_1.nick))

		arg_4_0.masterPlayerID_ = var_4_0
	end
end

function var_0_1.OnCooperationRoomInit(arg_5_0)
	arg_5_0:Refresh()
end

function var_0_1.OnCooperationRoomUpdate(arg_6_0)
	arg_6_0:UpdateMasterPlayerID()
	arg_6_0:Refresh()
end

function var_0_1.OnFriendsListChange(arg_7_0)
	arg_7_0:SubViewCallFunc("OnFriendsListChange")
end

return var_0_1
