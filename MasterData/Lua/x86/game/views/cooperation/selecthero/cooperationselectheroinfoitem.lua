local CooperationSelectHeroInfoItem = class("CooperationSelectHeroInfoItem", (import("game.views.sectionSelectHero.SectionSelectHeroInfoItem")))

function CooperationSelectHeroInfoItem:InitController()
	CooperationSelectHeroInfoItem.super.InitController(self)

	self.masterController_ = self.controllerExCollection_:GetController("master")
	self.playerStateController_ = self.playerControllerEx_:GetController("state")
	self.infoController_ = self.controllerExCollection_:GetController("info")
	self.friendController_ = self.friendControllerEx_:GetController("state")
	self.ownController_ = self.controllerExCollection_:GetController("own")
end

function CooperationSelectHeroInfoItem:AddUIListener()
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_3_0, arg_3_1)
		if self:IsEmpty() then
			JumpTools.GoToSystem("cooperationInvitation")
		elseif PlayerData:GetPlayerInfo().userID == self.roomPlayerID_ then
			if self.clickCallback_ then
				self.clickCallback_(self.pos_, arg_3_0, arg_3_1)
			end
		elseif self.infoController_:GetSelectedState() == "common" then
			if CooperationData:GetIsMaster() then
				self.infoController_:SetSelectedIndex(2)
			else
				self.infoController_:SetSelectedIndex(1)
			end
		else
			self.infoController_:SetSelectedIndex(0)
		end
	end))
	self:AddBtnListener(nil, self.playerInfoBtn_, function()
		ForeignInfoAction:TryToCheckForeignDetailInfo(self.roomPlayerID_)
	end)
	self:AddBtnListener(nil, self.heroInfoBtn_, function()
		CooperationTools.ShowHeroView(self.roomPlayerID_)
	end)
	self:AddBtnListener(nil, self.addFriendBtn_, function()
		FriendsAction:TryToRequestToFriend(self.roomPlayerID_, FriendConst.ADD_FRIEND_SOURCE.COOPERATION_ROOM)
	end)
	self:AddBtnListener(nil, self.changeMasterBtn_, function()
		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("COOPERATION_CONFIRM_CHANGE_MASTER"), self.roomPlayer_.nick),
			OkCallback = function()
				CooperationAction.ChangeRoomMaster(self.roomPlayerID_)
			end
		})
	end)
	self:AddBtnListener(nil, self.kickOutBtn_, function()
		ShowMessageBox({
			isTop = true,
			content = string.format(GetTips("COOPERATION_CONFIRM_KICK"), self.roomPlayer_.nick),
			OkCallback = function()
				CooperationAction.KickOutRoom(self.roomPlayerID_)
			end
		})
	end)
end

function CooperationSelectHeroInfoItem:Refresh(arg_11_1, arg_11_2)
	self.roomData_ = self.sectionProxy_:GetRoomData()
	self.roomPlayerID_ = arg_11_2

	CooperationSelectHeroInfoItem.super.Refresh(self, arg_11_1)
end

function CooperationSelectHeroInfoItem:RefreshUI()
	self:RefreshAddBtn()

	if self:IsEmpty() then
		self.emptyController_:SetSelectedState("true")
		self:RefreshInfoController()
	else
		self.emptyController_:SetSelectedState("false")
		self:RefershPower()
		self:RefreshRace()
		self:RefreshAttackType()
		self:RefreshInfoController()
		self:RefreshPlayerUI()
	end
end

function CooperationSelectHeroInfoItem:RefreshAddBtn()
	if self.stateController_ then
		if not self:IsEmpty() then
			self.stateController_:SetSelectedState("selected")
		elseif self.isPosLock_ == true or not self.sectionProxy_.canChangeTeam then
			self.stateController_:SetSelectedState("lock")
		else
			self.stateController_:SetSelectedState("empty")
		end
	end
end

function CooperationSelectHeroInfoItem:RefreshInfoController()
	if self:IsEmpty() then
		self.infoController_:SetSelectedIndex(0)
	elseif self.infoController_:GetSelectedState() ~= "common" then
		if CooperationData:GetIsMaster() then
			self.infoController_:SetSelectedIndex(2)
		else
			self.infoController_:SetSelectedIndex(1)
		end
	end

	SetActive(self.heroInfoBtn_.gameObject, CooperationTools.CanShowHero(self.roomPlayerID_))
end

function CooperationSelectHeroInfoItem:RefreshPlayerUI()
	self.roomPlayer_ = self.roomData_:GetRoomPlayerData(self.roomPlayerID_)

	self:RefreshMasterUI()
	self:RefreshOwnUI()
	self:RefreshPlayerState()
	self:RefreshFriendUI()
end

function CooperationSelectHeroInfoItem:RefreshMasterUI()
	self.masterController_:SetSelectedIndex(self.roomPlayer_.is_master == 1 and 1 or 0)
end

function CooperationSelectHeroInfoItem:RefreshOwnUI()
	self.userNameText_.text = GetI18NText(self.roomPlayer_.nick)

	self.ownController_:SetSelectedIndex(PlayerData:GetPlayerInfo().userID == self.roomPlayerID_ and 1 or 0)
end

function CooperationSelectHeroInfoItem:RefreshPlayerState()
	if whereami == "battle" then
		self.playerStateController_:SetSelectedState("ready")
	elseif self.roomPlayer_.is_ready == 1 then
		self.playerStateController_:SetSelectedState("ready")
	elseif self.roomData_:RepeatHero(self.heroID_) then
		self.playerStateController_:SetSelectedState("repeat")
	else
		self.playerStateController_:SetSelectedState("commom")
	end
end

function CooperationSelectHeroInfoItem:RefreshFriendUI()
	if table.indexof(FriendsData:GetList(1), tostring(self.roomPlayerID_)) then
		self.addFriendLab_.text = GetTips("COOPERATION_ALREADY_FRIEND")
		self.addFriendBtn_.interactable = false

		self.friendController_:SetSelectedIndex(1)
	else
		self.addFriendLab_.text = GetTips("COOPERATION_ADD_FRIEND")
		self.addFriendBtn_.interactable = true

		self.friendController_:SetSelectedIndex(0)
	end
end

function CooperationSelectHeroInfoItem:IsEmpty()
	return self.roomPlayerID_ == nil
end

function CooperationSelectHeroInfoItem:BattleStart()
	self.playerStateController_:SetSelectedIndex(1)
end

return CooperationSelectHeroInfoItem
