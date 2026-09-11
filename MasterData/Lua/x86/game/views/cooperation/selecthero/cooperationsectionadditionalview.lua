local CooperationSectionAdditionalView = class("CooperationSectionAdditionalView", (import("game.views.sectionSelectHero.SectionAdditionalView")))

function CooperationSectionAdditionalView:InitSubView()
	self.subViewDic_ = {}
end

function CooperationSectionAdditionalView:InitController()
	CooperationSectionAdditionalView.super.InitController(self)

	self.roomAvailableController_ = self.roomAvailableControllerEx_:GetController("switch")
	self.startBtnController_ = self.controllerExCollection_:GetController("startBtn")
end

function CooperationSectionAdditionalView:InitCallback()
	self.newMessageHandler_ = handler(self, self.NewMessage)
	self.battleStartHandler_ = handler(self, self.BattleStart)
end

function CooperationSectionAdditionalView:AddEventListener()
	self:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, self.newMessageHandler_)
	self:RegistEventListener(START_COOPERATION_BATTLE, self.battleStartHandler_)
end

function CooperationSectionAdditionalView:AddListener()
	self:AddBtnListener(nil, self.startBtn_, function()
		local var_6_0 = PlayerData:GetPlayerInfo().userID
		local var_6_1 = self.roomData_:GetSelfHero()

		for iter_6_0, iter_6_1 in ipairs((self.roomData_:GetRoomPlayerIdList())) do
			local var_6_2 = self.roomData_:GetRoomPlayerData(iter_6_1)

			if var_6_2 and var_6_2.is_master ~= 1 and var_6_2.is_ready ~= 1 then
				ShowTips("COOPERATION_SOMEONE_UNREADY")

				return
			end
		end

		BattleController.GetInstance():LaunchCooperationBattle()
	end)
	self:AddBtnListener(nil, self.prepareBtn_, function()
		local var_7_0 = PlayerData:GetPlayerInfo().userID
		local var_7_1 = self.roomData_:GetSelfHero()
		local var_7_2 = self.roomData_:GetRoomPlayerIdList()

		CooperationAction.GetReady()
	end)
	self:AddBtnListener(nil, self.cancelBtn_, function()
		CooperationAction.CancelReay()
	end)
	self:AddBtnListener(nil, self.roomAvailableBtn_, function()
		if CooperationData:GetIsMaster() then
			if self.roomData_:IsAvailable() == 1 then
				CooperationAction.ChangeRoomAvailable(2)
			else
				CooperationAction.ChangeRoomAvailable(1)
			end
		else
			ShowTips("ERROR_COORDINATOR_NOT_OWNER")
		end
	end)
	self:AddBtnListener(self.chatBtn_, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(nil, self.roomIdCopyBtn_, function()
		UnityEngine.GUIUtility.systemCopyBuffer = self.roomData_.room_id

		ShowTips("COPY_SUCCESS")
	end)
	self:AddBtnListener(self.raceBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = self.maxRaceID_,
			sameCamp = self.sameCamp_
		})
	end)
end

function CooperationSectionAdditionalView:SetProxy(arg_13_1)
	self.roomData_ = arg_13_1:GetRoomData()

	CooperationSectionAdditionalView.super.SetProxy(self, arg_13_1)
end

function CooperationSectionAdditionalView:RefreshUI()
	self:RefreshRoom()
	self:RefreshRace()
	self:RefreshStartBtn()
end

function CooperationSectionAdditionalView:RefreshRoom()
	self:RefreshRoomTitle()
	self:RefreshRoomAvailable()
end

function CooperationSectionAdditionalView:RefreshRoomTitle()
	self.roomeNameText_.text = self:GetRoomName()
	self.roomIDText_.text = string.format(GetTips("COOPERATION_ROOM_ID"), self.roomData_.room_id)
end

function CooperationSectionAdditionalView:GetRoomName()
	return CooperationTools.GetCooperationRoomName(self.roomData_.type, self.roomData_.dest, self.roomData_.activity_id)
end

function CooperationSectionAdditionalView:RefreshRoomAvailable()
	self.roomAvailableController_:SetSelectedState(self.roomData_:IsAvailable() == 1 and "on" or "off")
end

function CooperationSectionAdditionalView:RefreshStartBtn()
	local var_19_0 = self.roomData_:GetRoomPlayerData(PlayerData:GetPlayerInfo().userID)
	local var_19_1 = var_19_0.is_ready == 1

	if var_19_0.is_master == 1 then
		self.startBtnController_:SetSelectedIndex(0)
	elseif var_19_1 then
		self.startBtnController_:SetSelectedIndex(2)
	else
		self.startBtnController_:SetSelectedIndex(1)
	end
end

function CooperationSectionAdditionalView:BattleStart()
	if self.roomData_:GetRoomPlayerData(PlayerData:GetPlayerInfo().userID).is_master == 1 then
		self.startBtnController_:SetSelectedIndex(0)
	else
		self.startBtnController_:SetSelectedIndex(2)
	end
end

function CooperationSectionAdditionalView:NewMessage()
	local var_21_0 = ChatCooperationData:GetCacheContent()

	self.chatLab_.text = #var_21_0 > 0 and string.format("%s:%s", var_21_0[#var_21_0].nick, (var_21_0[#var_21_0].contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER or nil) and string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_21_0[#var_21_0].content)].name))) or ""
end

return CooperationSectionAdditionalView
