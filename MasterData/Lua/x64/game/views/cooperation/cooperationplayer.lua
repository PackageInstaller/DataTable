local CooperationPlayer = class("CooperationPlayer", ReduxView)

function CooperationPlayer:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.index = arg_1_2

	self:Init()
	self.positionController:SetSelectedIndex(arg_1_2 - 1)
end

function CooperationPlayer:Init()
	self:InitUI()
	self:AddUIListener()
end

function CooperationPlayer:InitUI()
	self:BindCfgUI()

	self.masterController = ControllerUtil.GetController(self.transform_, "master")
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
	self.playerController = ControllerUtil.GetController(self.transform_, "player")
	self.infoController = ControllerUtil.GetController(self.transform_, "info")
	self.positionController = ControllerUtil.GetController(self.transform_, "position")
	self.friendController = ControllerUtil.GetController(self.transform_, "friend")
	self.campController = ControllerUtil.GetController(self.transform_, "icon")
	self.ownController = ControllerUtil.GetController(self.transform_, "own")
end

function CooperationPlayer:AddUIListener()
	self:AddBtnListener(nil, self.m_btn, function()
		if PlayerData:GetPlayerInfo().userID == self.roomPlayerId then
			self:GotoTeamInfo()
		elseif self.infoController:GetSelectedState() == "common" then
			if CooperationData:GetIsMaster() then
				self.infoController:SetSelectedIndex(2)
			else
				self.infoController:SetSelectedIndex(1)
			end
		else
			self.infoController:SetSelectedIndex(0)
		end
	end)
	self:AddBtnListener(nil, self.m_playerInfoBtn, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.roomPlayerId)
	end)
	self:AddBtnListener(nil, self.m_heroInfoBtn, function()
		CooperationTools.ShowHeroView(self.roomPlayerId)
	end)
	self:AddBtnListener(nil, self.m_addFriendBtn, function()
		FriendsAction:TryToRequestToFriend(self.roomPlayerId, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_ROOM)
	end)
	self:AddBtnListener(nil, self.m_changeMasterBtn, function()
		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("COOPERATION_CONFIRM_CHANGE_MASTER"), self.roomPlayer.nick),
			OkCallback = function()
				CooperationAction.ChangeRoomMaster(self.roomPlayerId)
			end
		})
	end)
	self:AddBtnListener(nil, self.m_kickOutBtn, function()
		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("COOPERATION_CONFIRM_KICK"), self.roomPlayer.nick),
			OkCallback = function()
				CooperationAction.KickOutRoom(self.roomPlayerId)
			end
		})
	end)
	self:AddBtnListener(nil, self.m_inviteBtn, function()
		JumpTools.GoToSystem("cooperationInvitation")
	end)
end

function CooperationPlayer:GotoTeamInfo()
	self:Go("/heroTeamInfoCooperation")
end

function CooperationPlayer:Reset()
	self.roomPlayerId = nil
	self.room = nil

	self.infoController:SetSelectedIndex(0)
end

function CooperationPlayer:SetData(arg_16_1, arg_16_2)
	if self.roomPlayerId == nil or arg_16_2 ~= self.roomPlayerId then
		self.infoController:SetSelectedIndex(0)
	elseif self.infoController:GetSelectedState() ~= "common" then
		if CooperationData:GetIsMaster() then
			self.infoController:SetSelectedIndex(2)
		else
			self.infoController:SetSelectedIndex(1)
		end
	end

	self.roomPlayerId = arg_16_2
	self.room = arg_16_1

	if arg_16_2 then
		self.roomPlayer = arg_16_1:GetRoomPlayerData(arg_16_2)
		self.m_heroName.text = GetI18NText(self.roomPlayer.nick)

		self.masterController:SetSelectedIndex(self.roomPlayer.is_master == 1 and 1 or 0)

		self.m_powerLab.text = string.format(GetTips("COOPERATION_POWER_LAB"), (CooperationData:GetCooperationHeroPower(arg_16_2)))
		self.m_camp.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[HeroCfg[self.roomPlayer.heroList[1].id].race].icon)

		if whereami == "battle" then
			self.stateController:SetSelectedIndex(1)
		elseif self.roomPlayer.is_ready == 1 then
			self.stateController:SetSelectedIndex(1)
		elseif self.room:RepeatHero(self.roomPlayer.heroList[1].id) then
			self.stateController:SetSelectedIndex(3)
		else
			self.stateController:SetSelectedIndex(2)
		end

		self.ownController:SetSelectedIndex(PlayerData:GetPlayerInfo().userID == self.roomPlayerId and 1 or 0)
		self.playerController:SetSelectedIndex(1)

		if table.indexof(FriendsData:GetList(1), tostring(self.roomPlayerId)) then
			self.m_addFriendLab.text = GetTips("COOPERATION_ALREADY_FRIEND")
			self.m_addFriendBtn.interactable = false

			self.friendController:SetSelectedIndex(1)
		else
			self.m_addFriendLab.text = GetTips("COOPERATION_ADD_FRIEND")
			self.m_addFriendBtn.interactable = true

			self.friendController:SetSelectedIndex(0)
		end
	else
		self.playerController:SetSelectedIndex(0)
	end
end

function CooperationPlayer:BattleStart()
	self.stateController:SetSelectedIndex(1)
end

function CooperationPlayer:Dispose()
	CooperationPlayer.super.Dispose(self)
end

return CooperationPlayer
