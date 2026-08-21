local var_0_0 = class("CooperationPlayer", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index = arg_1_2

	arg_1_0:Init()
	arg_1_0.positionController:SetSelectedIndex(arg_1_2 - 1)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.masterController = ControllerUtil.GetController(arg_3_0.transform_, "master")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.playerController = ControllerUtil.GetController(arg_3_0.transform_, "player")
	arg_3_0.infoController = ControllerUtil.GetController(arg_3_0.transform_, "info")
	arg_3_0.positionController = ControllerUtil.GetController(arg_3_0.transform_, "position")
	arg_3_0.friendController = ControllerUtil.GetController(arg_3_0.transform_, "friend")
	arg_3_0.campController = ControllerUtil.GetController(arg_3_0.transform_, "icon")
	arg_3_0.ownController = ControllerUtil.GetController(arg_3_0.transform_, "own")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_btn, function()
		if PlayerData:GetPlayerInfo().userID == arg_4_0.roomPlayerId then
			arg_4_0:GotoTeamInfo()
		elseif arg_4_0.infoController:GetSelectedState() == "common" then
			if CooperationData:GetIsMaster() then
				arg_4_0.infoController:SetSelectedIndex(2)
			else
				arg_4_0.infoController:SetSelectedIndex(1)
			end
		else
			arg_4_0.infoController:SetSelectedIndex(0)
		end
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_playerInfoBtn, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_4_0.roomPlayerId)
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_heroInfoBtn, function()
		CooperationTools.ShowHeroView(arg_4_0.roomPlayerId)
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_addFriendBtn, function()
		FriendsAction:TryToRequestToFriend(arg_4_0.roomPlayerId, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_ROOM)
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_changeMasterBtn, function()
		local var_9_0 = string.format(GetTips("COOPERATION_CONFIRM_CHANGE_MASTER"), arg_4_0.roomPlayer.nick)

		ShowMessageBox({
			isTop = true,
			content = var_9_0,
			OkCallback = function()
				CooperationAction.ChangeRoomMaster(arg_4_0.roomPlayerId)
			end
		})
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_kickOutBtn, function()
		local var_11_0 = string.format(GetTips("COOPERATION_CONFIRM_KICK"), arg_4_0.roomPlayer.nick)

		ShowMessageBox({
			isTop = true,
			content = var_11_0,
			OkCallback = function()
				CooperationAction.KickOutRoom(arg_4_0.roomPlayerId)
			end
		})
	end)
	arg_4_0:AddBtnListener(nil, arg_4_0.m_inviteBtn, function()
		JumpTools.GoToSystem("cooperationInvitation")
	end)
end

function var_0_0.GotoTeamInfo(arg_14_0)
	arg_14_0:Go("/heroTeamInfoCooperation")
end

function var_0_0.Reset(arg_15_0)
	arg_15_0.roomPlayerId = nil
	arg_15_0.room = nil

	arg_15_0.infoController:SetSelectedIndex(0)
end

function var_0_0.SetData(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.roomPlayerId == nil or arg_16_2 ~= arg_16_0.roomPlayerId then
		arg_16_0.infoController:SetSelectedIndex(0)
	elseif arg_16_0.infoController:GetSelectedState() ~= "common" then
		if CooperationData:GetIsMaster() then
			arg_16_0.infoController:SetSelectedIndex(2)
		else
			arg_16_0.infoController:SetSelectedIndex(1)
		end
	end

	arg_16_0.roomPlayerId = arg_16_2
	arg_16_0.room = arg_16_1

	if arg_16_2 then
		arg_16_0.roomPlayer = arg_16_1:GetRoomPlayerData(arg_16_2)
		arg_16_0.m_heroName.text = GetI18NText(arg_16_0.roomPlayer.nick)

		arg_16_0.masterController:SetSelectedIndex(arg_16_0.roomPlayer.is_master == 1 and 1 or 0)

		local var_16_0 = arg_16_0.roomPlayer.heroList[1].id
		local var_16_1 = CooperationData:GetCooperationHeroPower(arg_16_2)

		arg_16_0.m_powerLab.text = string.format(GetTips("COOPERATION_POWER_LAB"), var_16_1)

		local var_16_2 = HeroCfg[var_16_0]
		local var_16_3 = RaceEffectCfg[var_16_2.race]

		arg_16_0.m_camp.sprite = getSprite("Atlas/CampItemAtlas", var_16_3.icon)

		if whereami == "battle" then
			arg_16_0.stateController:SetSelectedIndex(1)
		elseif arg_16_0.roomPlayer.is_ready == 1 then
			arg_16_0.stateController:SetSelectedIndex(1)
		elseif arg_16_0.room:RepeatHero(var_16_0) then
			arg_16_0.stateController:SetSelectedIndex(3)
		else
			arg_16_0.stateController:SetSelectedIndex(2)
		end

		local var_16_4 = PlayerData:GetPlayerInfo().userID

		arg_16_0.ownController:SetSelectedIndex(var_16_4 == arg_16_0.roomPlayerId and 1 or 0)
		arg_16_0.playerController:SetSelectedIndex(1)

		local var_16_5 = FriendsData:GetList(1)

		if table.indexof(var_16_5, tostring(arg_16_0.roomPlayerId)) then
			arg_16_0.m_addFriendLab.text = GetTips("COOPERATION_ALREADY_FRIEND")
			arg_16_0.m_addFriendBtn.interactable = false

			arg_16_0.friendController:SetSelectedIndex(1)
		else
			arg_16_0.m_addFriendLab.text = GetTips("COOPERATION_ADD_FRIEND")
			arg_16_0.m_addFriendBtn.interactable = true

			arg_16_0.friendController:SetSelectedIndex(0)
		end
	else
		arg_16_0.playerController:SetSelectedIndex(0)
	end
end

function var_0_0.BattleStart(arg_17_0)
	arg_17_0.stateController:SetSelectedIndex(1)
end

function var_0_0.Dispose(arg_18_0)
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
