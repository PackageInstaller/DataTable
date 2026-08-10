local var_0_0 = import("game.views.sectionSelectHero.SectionSelectHeroInfoItem")
local var_0_1 = class("CooperationSelectHeroInfoItem", var_0_0)

function var_0_1.InitController(arg_1_0)
	var_0_1.super.InitController(arg_1_0)

	arg_1_0.masterController_ = arg_1_0.controllerExCollection_:GetController("master")
	arg_1_0.playerStateController_ = arg_1_0.playerControllerEx_:GetController("state")
	arg_1_0.infoController_ = arg_1_0.controllerExCollection_:GetController("info")
	arg_1_0.friendController_ = arg_1_0.friendControllerEx_:GetController("state")
	arg_1_0.ownController_ = arg_1_0.controllerExCollection_:GetController("own")
end

function var_0_1.AddUIListener(arg_2_0)
	arg_2_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_3_0, arg_3_1)
		if arg_2_0:IsEmpty() then
			JumpTools.GoToSystem("cooperationInvitation")
		elseif PlayerData:GetPlayerInfo().userID == arg_2_0.roomPlayerID_ then
			if arg_2_0.clickCallback_ then
				arg_2_0.clickCallback_(arg_2_0.pos_, arg_3_0, arg_3_1)
			end
		elseif arg_2_0.infoController_:GetSelectedState() == "common" then
			if CooperationData:GetIsMaster() then
				arg_2_0.infoController_:SetSelectedIndex(2)
			else
				arg_2_0.infoController_:SetSelectedIndex(1)
			end
		else
			arg_2_0.infoController_:SetSelectedIndex(0)
		end
	end))
	arg_2_0:AddBtnListener(nil, arg_2_0.playerInfoBtn_, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(arg_2_0.roomPlayerID_)
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.heroInfoBtn_, function()
		CooperationTools.ShowHeroView(arg_2_0.roomPlayerID_)
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.addFriendBtn_, function()
		FriendsAction:TryToRequestToFriend(arg_2_0.roomPlayerID_, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_ROOM)
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.changeMasterBtn_, function()
		local var_7_0 = string.format(GetTips("COOPERATION_CONFIRM_CHANGE_MASTER"), arg_2_0.roomPlayer_.nick)

		ShowMessageBox({
			isTop = true,
			content = var_7_0,
			OkCallback = function()
				CooperationAction.ChangeRoomMaster(arg_2_0.roomPlayerID_)
			end
		})
	end)
	arg_2_0:AddBtnListener(nil, arg_2_0.kickOutBtn_, function()
		local var_9_0 = string.format(GetTips("COOPERATION_CONFIRM_KICK"), arg_2_0.roomPlayer_.nick)

		ShowMessageBox({
			isTop = true,
			content = var_9_0,
			OkCallback = function()
				CooperationAction.KickOutRoom(arg_2_0.roomPlayerID_)
			end
		})
	end)
end

function var_0_1.Refresh(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.roomData_ = arg_11_0.sectionProxy_:GetRoomData()
	arg_11_0.roomPlayerID_ = arg_11_2

	var_0_1.super.Refresh(arg_11_0, arg_11_1)
end

function var_0_1.RefreshUI(arg_12_0)
	arg_12_0:RefreshAddBtn()

	if arg_12_0:IsEmpty() then
		arg_12_0.emptyController_:SetSelectedState("true")
		arg_12_0:RefreshInfoController()
	else
		arg_12_0.emptyController_:SetSelectedState("false")
		arg_12_0:RefershPower()
		arg_12_0:RefreshRace()
		arg_12_0:RefreshAttackType()
		arg_12_0:RefreshInfoController()
		arg_12_0:RefreshPlayerUI()
	end
end

function var_0_1.RefreshAddBtn(arg_13_0)
	if arg_13_0.stateController_ then
		if not arg_13_0:IsEmpty() then
			arg_13_0.stateController_:SetSelectedState("selected")
		elseif arg_13_0.isPosLock_ == true or not arg_13_0.sectionProxy_.canChangeTeam then
			arg_13_0.stateController_:SetSelectedState("lock")
		else
			arg_13_0.stateController_:SetSelectedState("empty")
		end
	end
end

function var_0_1.RefreshInfoController(arg_14_0)
	if arg_14_0:IsEmpty() then
		arg_14_0.infoController_:SetSelectedIndex(0)
	elseif arg_14_0.infoController_:GetSelectedState() ~= "common" then
		if CooperationData:GetIsMaster() then
			arg_14_0.infoController_:SetSelectedIndex(2)
		else
			arg_14_0.infoController_:SetSelectedIndex(1)
		end
	end

	SetActive(arg_14_0.heroInfoBtn_.gameObject, CooperationTools.CanShowHero(arg_14_0.roomPlayerID_))
end

function var_0_1.RefreshPlayerUI(arg_15_0)
	arg_15_0.roomPlayer_ = arg_15_0.roomData_:GetRoomPlayerData(arg_15_0.roomPlayerID_)

	arg_15_0:RefreshMasterUI()
	arg_15_0:RefreshOwnUI()
	arg_15_0:RefreshPlayerState()
	arg_15_0:RefreshFriendUI()
end

function var_0_1.RefreshMasterUI(arg_16_0)
	arg_16_0.masterController_:SetSelectedIndex(arg_16_0.roomPlayer_.is_master == 1 and 1 or 0)
end

function var_0_1.RefreshOwnUI(arg_17_0)
	arg_17_0.userNameText_.text = GetI18NText(arg_17_0.roomPlayer_.nick)

	local var_17_0 = PlayerData:GetPlayerInfo().userID

	arg_17_0.ownController_:SetSelectedIndex(var_17_0 == arg_17_0.roomPlayerID_ and 1 or 0)
end

function var_0_1.RefreshPlayerState(arg_18_0)
	if whereami == "battle" then
		arg_18_0.playerStateController_:SetSelectedState("ready")
	elseif arg_18_0.roomPlayer_.is_ready == 1 then
		arg_18_0.playerStateController_:SetSelectedState("ready")
	elseif arg_18_0.roomData_:RepeatHero(arg_18_0.heroID_) then
		arg_18_0.playerStateController_:SetSelectedState("repeat")
	else
		arg_18_0.playerStateController_:SetSelectedState("commom")
	end
end

function var_0_1.RefreshFriendUI(arg_19_0)
	local var_19_0 = FriendsData:GetList(1)

	if table.indexof(var_19_0, tostring(arg_19_0.roomPlayerID_)) then
		arg_19_0.addFriendLab_.text = GetTips("COOPERATION_ALREADY_FRIEND")
		arg_19_0.addFriendBtn_.interactable = false

		arg_19_0.friendController_:SetSelectedIndex(1)
	else
		arg_19_0.addFriendLab_.text = GetTips("COOPERATION_ADD_FRIEND")
		arg_19_0.addFriendBtn_.interactable = true

		arg_19_0.friendController_:SetSelectedIndex(0)
	end
end

function var_0_1.IsEmpty(arg_20_0)
	return arg_20_0.roomPlayerID_ == nil
end

function var_0_1.BattleStart(arg_21_0)
	arg_21_0.playerStateController_:SetSelectedIndex(1)
end

return var_0_1
