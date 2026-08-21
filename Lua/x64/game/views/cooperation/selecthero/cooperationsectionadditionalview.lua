local var_0_0 = import("game.views.sectionSelectHero.SectionAdditionalView")
local var_0_1 = class("CooperationSectionAdditionalView", var_0_0)

function var_0_1.InitSubView(arg_1_0)
	arg_1_0.subViewDic_ = {}
end

function var_0_1.InitController(arg_2_0)
	var_0_1.super.InitController(arg_2_0)

	arg_2_0.roomAvailableController_ = arg_2_0.roomAvailableControllerEx_:GetController("switch")
	arg_2_0.startBtnController_ = arg_2_0.controllerExCollection_:GetController("startBtn")
end

function var_0_1.InitCallback(arg_3_0)
	arg_3_0.newMessageHandler_ = handler(arg_3_0, arg_3_0.NewMessage)
	arg_3_0.battleStartHandler_ = handler(arg_3_0, arg_3_0.BattleStart)
end

function var_0_1.AddEventListener(arg_4_0)
	arg_4_0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, arg_4_0.newMessageHandler_)
	arg_4_0:RegistEventListener(START_COOPERATION_BATTLE, arg_4_0.battleStartHandler_)
end

function var_0_1.AddListener(arg_5_0)
	arg_5_0:AddBtnListener(nil, arg_5_0.startBtn_, function()
		local var_6_0 = PlayerData:GetPlayerInfo().userID
		local var_6_1 = arg_5_0.roomData_:GetSelfHero()
		local var_6_2 = arg_5_0.roomData_:GetRoomPlayerIdList()

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			local var_6_3 = arg_5_0.roomData_:GetRoomPlayerData(iter_6_1)
			local var_6_4 = var_6_3.is_master == 1
			local var_6_5 = var_6_3.is_ready == 1

			if var_6_3 and not var_6_4 and not var_6_5 then
				ShowTips("COOPERATION_SOMEONE_UNREADY")

				return
			end
		end

		BattleController.GetInstance():LaunchCooperationBattle()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.prepareBtn_, function()
		local var_7_0 = PlayerData:GetPlayerInfo().userID
		local var_7_1 = arg_5_0.roomData_:GetSelfHero()
		local var_7_2 = arg_5_0.roomData_:GetRoomPlayerIdList()

		CooperationAction.GetReady()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.cancelBtn_, function()
		CooperationAction.CancelReay()
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.roomAvailableBtn_, function()
		if CooperationData:GetIsMaster() then
			if arg_5_0.roomData_:IsAvailable() == 1 then
				CooperationAction.ChangeRoomAvailable(2)
			else
				CooperationAction.ChangeRoomAvailable(1)
			end
		else
			ShowTips("ERROR_COORDINATOR_NOT_OWNER")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.chatBtn_, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_5_0:AddBtnListener(nil, arg_5_0.roomIdCopyBtn_, function()
		UnityEngine.GUIUtility.systemCopyBuffer = arg_5_0.roomData_.room_id

		ShowTips("COPY_SUCCESS")
	end)
	arg_5_0:AddBtnListener(arg_5_0.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = arg_5_0.maxRaceID_,
			sameCamp = arg_5_0.sameCamp_
		})
	end)
end

function var_0_1.SetProxy(arg_13_0, arg_13_1)
	arg_13_0.roomData_ = arg_13_1:GetRoomData()

	var_0_1.super.SetProxy(arg_13_0, arg_13_1)
end

function var_0_1.RefreshUI(arg_14_0)
	arg_14_0:RefreshRoom()
	arg_14_0:RefreshRace()
	arg_14_0:RefreshStartBtn()
end

function var_0_1.RefreshRoom(arg_15_0)
	arg_15_0:RefreshRoomTitle()
	arg_15_0:RefreshRoomAvailable()
end

function var_0_1.RefreshRoomTitle(arg_16_0)
	arg_16_0.roomeNameText_.text = arg_16_0:GetRoomName()
	arg_16_0.roomIDText_.text = string.format(GetTips("COOPERATION_ROOM_ID"), arg_16_0.roomData_.room_id)
end

function var_0_1.GetRoomName(arg_17_0)
	return CooperationTools.GetCooperationRoomName(arg_17_0.roomData_.type, arg_17_0.roomData_.dest, arg_17_0.roomData_.activity_id)
end

function var_0_1.RefreshRoomAvailable(arg_18_0)
	local var_18_0 = arg_18_0.roomData_:IsAvailable()

	arg_18_0.roomAvailableController_:SetSelectedState(var_18_0 == 1 and "on" or "off")
end

function var_0_1.RefreshStartBtn(arg_19_0)
	local var_19_0 = PlayerData:GetPlayerInfo().userID
	local var_19_1 = arg_19_0.roomData_:GetRoomPlayerData(var_19_0)
	local var_19_2 = var_19_1.is_master == 1
	local var_19_3 = var_19_1.is_ready == 1

	if var_19_2 then
		arg_19_0.startBtnController_:SetSelectedIndex(0)
	elseif var_19_3 then
		arg_19_0.startBtnController_:SetSelectedIndex(2)
	else
		arg_19_0.startBtnController_:SetSelectedIndex(1)
	end
end

function var_0_1.BattleStart(arg_20_0)
	local var_20_0 = PlayerData:GetPlayerInfo().userID

	if arg_20_0.roomData_:GetRoomPlayerData(var_20_0).is_master == 1 then
		arg_20_0.startBtnController_:SetSelectedIndex(0)
	else
		arg_20_0.startBtnController_:SetSelectedIndex(2)
	end
end

function var_0_1.NewMessage(arg_21_0)
	local var_21_0 = ChatCooperationData:GetCacheContent()

	if #var_21_0 > 0 then
		local var_21_1 = var_21_0[#var_21_0]
		local var_21_2 = var_21_1.content or ""

		if var_21_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_21_2 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_21_1.content)].name))
		end

		local var_21_3 = string.format("%s:%s", var_21_1.nick, var_21_2)

		arg_21_0.chatLab_.text = var_21_3
	else
		arg_21_0.chatLab_.text = ""
	end
end

return var_0_1
