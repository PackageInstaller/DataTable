local var_0_0 = {}

manager.net:Bind(54101, function(arg_1_0)
	CooperationData:InitRoomData(arg_1_0.room_info)
	manager.notify:CallUpdateFunc(COOPERATION_ROOM_INIT)
end)
manager.net:Bind(54103, function(arg_2_0)
	CooperationData:UpdateRoomData(arg_2_0.room_info)
	manager.notify:CallUpdateFunc(COOPERATION_ROOM_UPDATE)
end)

local var_0_1 = "0"

manager.net:Bind(54201, function(arg_3_0)
	local var_3_0 = CooperationData:GetRoomData()

	if whereami ~= "home" then
		if arg_3_0.room_info and var_0_1 ~= arg_3_0.room_info.room_id then
			CooperationData:InitRoomData(arg_3_0.room_info)
		else
			CooperationData:ClearRoomData()
		end
	elseif arg_3_0.room_info == nil or var_0_1 == arg_3_0.room_info.room_id then
		if var_3_0 ~= nil then
			local var_3_1 = var_3_0.type
			local var_3_2 = var_3_0.dest
			local var_3_3 = var_3_0.activity_id

			CooperationData:ClearRoomData()
			CooperationTools.GotoCooperationEntry(var_3_1, var_3_2, var_3_3)
		else
			CooperationData:ClearRoomData()
		end
	else
		CooperationData:InitRoomData(arg_3_0.room_info)
		manager.notify:CallUpdateFunc(COOPERATION_ROOM_INIT)
	end
end)
manager.net:Bind(37097, function(arg_4_0)
	CooperationData:SetIsMatching(false)
	manager.notify:CallUpdateFunc(COOPERATION_IS_MATCHING_CHANGE)

	if isSuccess(arg_4_0.result) then
		ChatCooperationData:RemoveChatData()
		CooperationTools.GotoCooperation()
	else
		ShowTips(arg_4_0.result)
	end
end)
manager.net:Bind(37099, function(arg_5_0)
	local var_5_0 = CooperationData:GetRoomData()

	if var_5_0 == nil then
		return
	end

	local var_5_1 = var_5_0.type
	local var_5_2 = var_5_0.dest
	local var_5_3 = var_5_0.activity_id

	CooperationData:ClearRoomData()

	if whereami ~= "home" then
		return
	end

	CooperationTools.GotoCooperationEntry(var_5_1, var_5_2, var_5_3)

	local var_5_4 = arg_5_0.reason

	ShowTips("COOPERATION_LEAVE_ROOM")
end)

function var_0_0.CreateRoom(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_4 == nil then
		arg_6_4 = 2
	end

	if arg_6_3 == nil then
		arg_6_3 = 0
	end

	local var_6_0 = {
		dest = arg_6_0,
		type = arg_6_1,
		available = arg_6_4,
		hero_list = arg_6_2,
		battle_vs = LuaForUtil.GetBattleVersion(),
		activity_id = arg_6_3
	}

	manager.net:SendWithLoadingNew(37010, var_6_0, 37011, var_0_0.OnCreateRoomBack)
end

function var_0_0.OnCreateRoomBack(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		-- block empty
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.JoinRoom(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1 = arg_8_1 or {}

	local var_8_0 = {
		room_id = arg_8_0,
		hero_list = arg_8_1,
		battle_vs = LuaForUtil.GetBattleVersion(),
		source = arg_8_2
	}

	manager.net:SendWithLoadingNew(37012, var_8_0, 37013, var_0_0.OnJoinRoomBack)
end

function var_0_0.OnJoinRoomBack(arg_9_0, arg_9_1)
	if isSuccess(arg_9_0.result) then
		-- block empty
	else
		ShowTips(arg_9_0.result)
	end
end

function var_0_0.StartMatching(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not CooperationData:GetIsMatching() then
		local var_10_0 = {
			dest = arg_10_0,
			type = arg_10_1,
			hero_list = arg_10_2,
			activity_id = arg_10_3,
			battle_vs = LuaForUtil.GetBattleVersion()
		}

		manager.net:SendWithLoadingNew(37036, var_10_0, 37037, var_0_0.OnStartMatchingBack)
	end
end

function var_0_0.OnStartMatchingBack(arg_11_0)
	if isSuccess(arg_11_0.result) then
		CooperationData:SetIsMatching(true)
		manager.notify:CallUpdateFunc(COOPERATION_IS_MATCHING_CHANGE)
	else
		ShowTips(arg_11_0.result)
	end
end

function var_0_0.CancelMatching()
	if CooperationData:GetIsMatching() then
		manager.net:SendWithLoadingNew(37038, {}, 37039, var_0_0.OnCancelMatchingBack)
	end
end

function var_0_0.OnCancelMatchingBack(arg_13_0)
	if isSuccess(arg_13_0.result) then
		CooperationData:SetIsMatching(false)
		manager.notify:CallUpdateFunc(COOPERATION_IS_MATCHING_CHANGE)
		ShowTips("COOPERATION_CANCEL_MATCH_TIP")
	else
		ShowTips(arg_13_0.result)
	end
end

function var_0_0.ChangeHero(arg_14_0)
	local var_14_0 = {
		hero_list = arg_14_0
	}

	manager.net:SendWithLoadingNew(37016, var_14_0, 37017, var_0_0.OnChangeHeroBack)
end

function var_0_0.OnChangeHeroBack(arg_15_0, arg_15_1)
	if isSuccess(arg_15_0.result) then
		CooperationData:SetCooperationHero(arg_15_1.hero_list[1])
		CooperationTools.GotoCooperation()
	else
		ShowTips(arg_15_0.result)
	end
end

function var_0_0.LeaveRoom()
	manager.net:SendWithLoadingNew(37018, {}, 37019, var_0_0.OnLeaveRoomBack)
end

function var_0_0.OnLeaveRoomBack(arg_17_0, arg_17_1)
	if isSuccess(arg_17_0.result) then
		-- block empty
	else
		ShowTips(arg_17_0.result)
	end
end

function var_0_0.LeaveCooperationBattle(arg_18_0, arg_18_1)
	if CooperationData:GetRoomData() then
		manager.net:SendWithLoadingNew(37018, {
			battle_id = arg_18_1
		}, 37019, function(arg_19_0)
			arg_18_0()
		end)
	else
		arg_18_0()
	end
end

function var_0_0.KickOutRoom(arg_20_0)
	manager.net:SendWithLoadingNew(37020, {
		uid = arg_20_0
	}, 37021, var_0_0.OnKickOutRoomBack)
end

function var_0_0.OnKickOutRoomBack(arg_21_0, arg_21_1)
	if isSuccess(arg_21_0.result) then
		-- block empty
	else
		ShowTips(arg_21_0.result)
	end
end

function var_0_0.ChangeRoomMaster(arg_22_0)
	manager.net:SendWithLoadingNew(37022, {
		uid = arg_22_0
	}, 37023, var_0_0.OnChangeRoomMasterBack)
end

function var_0_0.OnChangeRoomMasterBack(arg_23_0, arg_23_1)
	if isSuccess(arg_23_0.result) then
		-- block empty
	else
		ShowTips(arg_23_0.result)
	end
end

function var_0_0.GetReady()
	manager.net:SendWithLoadingNew(37024, {}, 37025, var_0_0.OnGetReadyBack)
end

function var_0_0.OnGetReadyBack(arg_25_0, arg_25_1)
	if isSuccess(arg_25_0.result) then
		-- block empty
	else
		ShowTips(arg_25_0.result)
	end
end

function var_0_0.CancelReay()
	manager.net:SendWithLoadingNew(37026, {}, 37027, var_0_0.OnCancelReadyBack)
end

function var_0_0.OnCancelReadyBack(arg_27_0, arg_27_1)
	if isSuccess(arg_27_0.result) then
		-- block empty
	else
		ShowTips(arg_27_0.result)
	end
end

function var_0_0.ChangeRoomAvailable(arg_28_0)
	local var_28_0 = {
		available = arg_28_0
	}

	manager.net:SendWithLoadingNew(37028, var_28_0, 37029, var_0_0.OnRoomAvailableBack)
end

function var_0_0.OnRoomAvailableBack(arg_29_0, arg_29_1)
	if isSuccess(arg_29_0.result) then
		-- block empty
	else
		ShowTips(arg_29_0.result)
	end
end

function var_0_0.SendMsg(arg_30_0, arg_30_1, arg_30_2)
	manager.net:SendWithLoadingNew(37030, {
		type = ChatConst.CHAT_CONTENT_TYPE.TEXT,
		content = arg_30_0
	}, 37031, function(arg_31_0)
		arg_30_2(arg_31_0)
	end)
end

function var_0_0.SendSticker(arg_32_0, arg_32_1)
	manager.net:SendWithLoadingNew(37030, {
		type = ChatConst.CHAT_CONTENT_TYPE.STICKER,
		content = tostring(arg_32_0)
	}, 37031, function(arg_33_0)
		arg_32_1(arg_33_0)
	end)
end

function var_0_0.ThumbsUp(arg_34_0)
	manager.net:SendWithLoadingNew(37034, {
		uid = arg_34_0
	}, 37035, var_0_0.OnThumbsUpBack)
end

function var_0_0.OnThumbsUpBack(arg_35_0, arg_35_1)
	if isSuccess(arg_35_0.result) then
		-- block empty
	else
		ShowTips(arg_35_0.result)
	end
end

function var_0_0.CooperationReport(arg_36_0, arg_36_1)
	manager.net:SendWithLoadingNew(57006, {
		user_id = arg_36_0,
		battle_id = arg_36_1
	}, 57007, var_0_0.OnCooperationReportBack)
end

function var_0_0.OnCooperationReportBack(arg_37_0)
	if isSuccess(arg_37_0.result) then
		-- block empty
	end
end

manager.net:Bind(37101, function(arg_38_0)
	CooperationData:InitInviteInfo(arg_38_0)
	manager.notify:CallUpdateFunc(COOPERATION_INVIT_UPDATE)

	if CooperationData:CheckInviteEntryShow() then
		manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 1)
	end
end)
manager.net:Bind(37103, function(arg_39_0)
	if var_0_0.CheckCooperationApplyLimit() then
		return
	end

	CooperationData:AddInviteInfo(arg_39_0)
	manager.notify:CallUpdateFunc(COOPERATION_INVIT_UPDATE)
	manager.redPoint:setTip(RedPointConst.COOPERATION_INVIT, 1)
end)

function var_0_0.InvitePlayer(arg_40_0, arg_40_1)
	manager.net:SendWithLoadingNew(37110, {
		uid = arg_40_0,
		type = arg_40_1
	}, 37111, var_0_0.OnInvitePlayerBack)
end

function var_0_0.OnInvitePlayerBack(arg_41_0, arg_41_1)
	if isSuccess(arg_41_0.result) then
		CooperationData:SetHadInvited(arg_41_1.uid, arg_41_1.type)
		manager.notify:CallUpdateFunc(COOPERATION_INVIT_SUCCESS)
	else
		ShowTips(arg_41_0.result)
	end
end

function var_0_0.DelectInvite(arg_42_0)
	manager.net:SendWithLoadingNew(37112, {
		uid_list = arg_42_0
	}, 37113, var_0_0.OnDelectInviteBack)
end

function var_0_0.OnDelectInviteBack(arg_43_0, arg_43_1)
	if isSuccess(arg_43_0.result) then
		for iter_43_0, iter_43_1 in ipairs(arg_43_1.uid_list) do
			CooperationData:DelectInvite(iter_43_1)
		end

		manager.notify:CallUpdateFunc(COOPERATION_INVIT_REFUSE, arg_43_1.uid_list)
	else
		ShowTips(arg_43_0.result)
	end
end

function var_0_0.ClearInvite()
	local var_44_0 = {}
	local var_44_1 = CooperationData:GetAllInviteList()

	if table.length(var_44_1) <= 0 then
		CooperationData:ClearInvite()
		manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)

		return
	end

	for iter_44_0, iter_44_1 in pairs(var_44_1) do
		table.insert(var_44_0, iter_44_1.uid)
	end

	manager.net:SendWithLoadingNew(37112, {
		uid_list = var_44_0
	}, 37113, var_0_0.OnClearInviteBack)
end

function var_0_0.OnClearInviteBack(arg_45_0)
	if isSuccess(arg_45_0.result) then
		CooperationData:ClearInvite()
		manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
	else
		ShowTips(arg_45_0.result)
	end
end

function var_0_0.ReceiveInvite(arg_46_0)
	manager.net:SendWithLoadingNew(37120, {
		uid = arg_46_0
	}, 37121, var_0_0.OnReceiveInviteBack)
end

function var_0_0.OnReceiveInviteBack(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1.uid

	if isSuccess(arg_47_0.result) then
		local var_47_1 = CooperationData:GetInvite(var_47_0)

		if var_47_1 then
			if var_47_1:IsOverdue() then
				ShowTips("COOPERATION_INVITE_OVERDUE")
			elseif var_47_1.activity_id ~= 0 and not ActivityTools.GetActivityIsOpenWithTip(var_47_1.activity_id, true) then
				-- block empty
			else
				local var_47_2 = CooperationData:GetCooperationHero(var_47_1.battle_type, var_47_1.dest, var_47_1.activity_id)

				var_0_0.JoinRoom(var_47_1.room_id, {
					var_47_2
				}, CooperationConst.JOIN_ROOM_SOURCE.INVET)
			end
		end

		CooperationData:DelectInvite(var_47_0)
		manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
	else
		ShowTips(arg_47_0.result)
		CooperationData:DelectInvite(var_47_0)
		manager.notify:CallUpdateFunc(COOPERATION_INVIT_CLEAR)
	end
end

function var_0_0.SetInviteRestrict(arg_48_0, arg_48_1)
	manager.net:SendWithLoadingNew(37114, {
		type = arg_48_0,
		op = arg_48_1
	}, 37115, var_0_0.OnSetInvitRestrictBack)
end

function var_0_0.SetInviteRestrictByList(arg_49_0)
	local var_49_0 = #arg_49_0
	local var_49_1 = deepClone(arg_49_0)

	table.remove(var_49_1, var_49_0)

	if var_49_0 == 1 then
		local var_49_2 = arg_49_0[var_49_0] == 1 and 2 or 1

		manager.net:SendWithLoadingNew(37114, {
			type = var_49_0,
			op = var_49_2
		}, 37115, var_0_0.OnSetInvitRestrictBack)
	else
		local var_49_3 = arg_49_0[var_49_0] == 1 and 2 or 1

		manager.net:SendWithLoadingNew(37114, {
			type = var_49_0,
			op = var_49_3
		}, 37115, function(arg_50_0, arg_50_1)
			if isSuccess(arg_50_0.result) then
				CooperationData:SetInviteRestrict(arg_50_1.type, arg_50_1.op)
				manager.notify:CallUpdateFunc(COOPERATION_INVIT_RESTRICT_UPDATE)
				var_0_0.SetInviteRestrictByList(var_49_1)
			else
				ShowTips(arg_50_0.result)
			end
		end)
	end
end

function var_0_0.OnSetInvitRestrictBack(arg_51_0, arg_51_1)
	if isSuccess(arg_51_0.result) then
		CooperationData:SetInviteRestrict(arg_51_1.type, arg_51_1.op)
		manager.notify:CallUpdateFunc(COOPERATION_INVIT_RESTRICT_UPDATE)
	else
		ShowTips(arg_51_0.result)
	end
end

function var_0_0.QueryRecentVisit()
	manager.net:SendWithLoadingNew(37116, {}, 37117, var_0_0.OnQueryRecentVisitBack)
end

function var_0_0.OnQueryRecentVisitBack(arg_53_0)
	if isSuccess(arg_53_0.result) then
		CooperationData:InitVisiteList(arg_53_0)
		manager.notify:CallUpdateFunc(COOPERATION_RECENT_VISIT_UPDATE)
	else
		ShowTips(arg_53_0.result)
	end
end

function var_0_0.RequestInviteList(arg_54_0)
	local var_54_0 = {
		type = arg_54_0
	}

	manager.net:SendWithLoadingNew(37118, var_54_0, 37119, var_0_0.OnRequestInviteListCallback)
end

function var_0_0.OnRequestInviteListCallback(arg_55_0, arg_55_1)
	if isSuccess(arg_55_0.result) then
		local var_55_0 = {}

		for iter_55_0, iter_55_1 in ipairs(arg_55_0.invite_list) do
			var_55_0[iter_55_1.type] = {}

			for iter_55_2, iter_55_3 in ipairs(iter_55_1.player_list) do
				local var_55_1 = {
					uid = iter_55_3.uid,
					nick = iter_55_3.user_base_info.nick,
					icon = iter_55_3.user_base_info.icon,
					icon_frame = iter_55_3.user_base_info.icon_frame,
					level = iter_55_3.level,
					timestamp = iter_55_3.timestamp,
					activity_data_list = {}
				}

				for iter_55_4, iter_55_5 in ipairs(iter_55_3.activity_data_list) do
					table.insert(var_55_1.activity_data_list, {
						enum = iter_55_5.enum,
						data = iter_55_5.data
					})
				end

				table.insert(var_55_0[iter_55_1.type], var_55_1)
			end
		end

		manager.notify:CallUpdateFunc(COOPERATION_INVITE_LIST_UPDATE, var_55_0)
	else
		ShowTips(GetTips(arg_55_0.result))
	end
end

function var_0_0.CheckCooperationApplyLimit(arg_56_0)
	local var_56_0 = GameSetting.activity_main_plot_unlock_level.value[1]

	if var_56_0 > PlayerData:GetPlayerInfo().userLevel then
		if arg_56_0 then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_56_0))
		end

		return true
	end

	return false
end

return var_0_0
