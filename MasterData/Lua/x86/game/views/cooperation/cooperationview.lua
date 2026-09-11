local CooperationView = class("CooperationView", ReduxView)
local var_0_1 = {
	{
		position = Vector3(500, 0, 0),
		rotation = Vector3(0, 0, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(502, 0, -2.5),
		rotation = Vector3(0, -16.419, 0),
		scale = Vector3(1, 1, 1)
	},
	{
		position = Vector3(498, 0, -2.5),
		rotation = Vector3(0, 9.932, 0),
		scale = Vector3(1, 1, 1)
	}
}

function CooperationView:UIBackCount()
	return 2
end

function CooperationView:UIName()
	return "UI/Cooperation/CooperationUI"
end

function CooperationView:UIParent()
	return manager.ui.uiMain.transform
end

function CooperationView:Init()
	self:InitUI()
	self:AddUIListener()

	self.friendController = ControllerUtil.GetController(self.m_friendEffectController, "friendEffect")
	self.raceController = ControllerUtil.GetController(self.m_raceEffectController, "raceEffect")
	self.roomAvailableController = ControllerUtil.GetController(self.m_roomAvailabelController, "swich")
	self.btnController = ControllerUtil.GetController(self.m_btnController, "btn")
	self.talkController = ControllerUtil.GetController(self.m_talkController, "talk")
	self.playerComList = {}

	for iter_4_0 = 1, 3 do
		table.insert(self.playerComList, self:GetCooperationPlayerClass().New(self["m_hero" .. iter_4_0], iter_4_0))
	end

	self.heroModel = {}
end

function CooperationView:InitUI()
	self:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(self, self.m_cooperationGo)
	SetActive(self.m_comboIncreaseGo, self:ShowComboIncreaseGo())
end

function CooperationView:AddUIListener()
	self:AddBtnListener(nil, self.m_startBtn, function()
		local var_7_0 = PlayerData:GetPlayerInfo().userID
		local var_7_1 = self.roomData:GetSelfHero()

		for iter_7_0, iter_7_1 in ipairs((self.roomData:GetRoomPlayerIdList())) do
			local var_7_2 = self.roomData:GetRoomPlayerData(iter_7_1)

			if iter_7_1 ~= var_7_0 and var_7_2.heroList[1].id == var_7_1 then
				ShowTips("COOPERATION_NO_ALLOW_READY_REPEAT")

				return
			end

			if var_7_2 and var_7_2.is_master ~= 1 and var_7_2.is_ready ~= 1 then
				ShowTips("COOPERATION_SOMEONE_UNREADY")

				return
			end
		end

		BattleController.GetInstance():LaunchCooperationBattle()
	end)
	self:AddBtnListener(nil, self.m_prepareBtn, function()
		local var_8_0 = PlayerData:GetPlayerInfo().userID
		local var_8_1 = self.roomData:GetSelfHero()

		for iter_8_0, iter_8_1 in ipairs((self.roomData:GetRoomPlayerIdList())) do
			if iter_8_1 ~= var_8_0 and self.roomData:GetRoomPlayerData(iter_8_1).heroList[1].id == var_8_1 then
				ShowTips("COOPERATION_NO_ALLOW_READY_REPEAT")

				return
			end
		end

		CooperationAction.GetReady()
	end)
	self:AddBtnListener(nil, self.m_cancelBtn, function()
		CooperationAction.CancelReay()
	end)
	self:AddBtnListener(nil, self.m_roomAvailableBtn, function()
		if CooperationData:GetIsMaster() then
			if self.roomData:IsAvailable() == 1 then
				CooperationAction.ChangeRoomAvailable(2)
			else
				CooperationAction.ChangeRoomAvailable(1)
			end
		else
			ShowTips("ERROR_COORDINATOR_NOT_OWNER")
		end
	end)
	self:AddBtnListener(self.m_talkLongBtn, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.m_talkShortBtn, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.m_comboIncreaseBtn, nil, function()
		JumpTools.OpenPageByJump("cooperationCombo")
	end)
	self:AddBtnListener(nil, self.m_roomIdCopyBtn, function()
		UnityEngine.GUIUtility.systemCopyBuffer = self.roomData.room_id

		ShowTips("COPY_SUCCESS")
	end)
end

function CooperationView:OnTop()
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("COOPERATION_LEAVE_ROOM_CONFIRM"),
			OkCallback = function()
				CooperationAction.LeaveRoom()
			end
		})
	end)
end

function CooperationView:OnEnter()
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()

	self.roomData = CooperationData:GetRoomData()

	if self.roomData == nil then
		self:Go("/home")

		return
	end

	self:Refresh()
	self:NewMessage()
	self:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(self, self.NewMessage))
	self:RegistEventListener(START_COOPERATION_BATTLE, handler(self, self.BattleStart))
	FriendsAction:TryToRefreshFriendsView(1)

	for iter_18_0 = 1, 3 do
		local var_18_0, var_18_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.transform_, manager.ui.mainCameraCom_:WorldToScreenPoint(var_0_1[iter_18_0].position), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

		print(var_18_1.x)

		self["m_hero" .. iter_18_0].transform.localPosition = Vector3.New(var_18_1.x, 10, 0)
	end

	self.masterPlayerId = self.roomData:GetMasetPlayerId()
end

function CooperationView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self:DestroyHeroModels()

	self.playerList = nil

	for iter_19_0 = 1, 3 do
		self.playerComList[iter_19_0]:Reset()
	end
end

function CooperationView:Refresh()
	if not self.roomData then
		return
	end

	self:RefreshRoom()
	self:RefreshPlayer()
	self:RefreshEffct()
	self:RefreshUI()
end

function CooperationView:RefreshRoom()
	self.m_stageLab.text = self:GetRoomName()
	self.m_roomIdLab.text = string.format(GetTips("COOPERATION_ROOM_ID"), self.roomData.room_id)

	self.roomAvailableController:SetSelectedIndex(self.roomData:IsAvailable() == 1 and 0 or 1)

	local var_21_0 = self.roomData:GetRoomPlayerData(PlayerData:GetPlayerInfo().userID)
	local var_21_1 = var_21_0.is_ready == 1

	if var_21_0.is_master == 1 then
		self.btnController:SetSelectedIndex(0)
	elseif var_21_1 then
		self.btnController:SetSelectedIndex(2)
	else
		self.btnController:SetSelectedIndex(1)
	end
end

function CooperationView:RefreshPlayer()
	self.playerIdList = self.playerIdList or {}

	local var_22_0 = {}
	local var_22_1 = self.roomData:GetRoomPlayerIdList()

	for iter_22_0 = 1, 3 do
		if iter_22_0 == 1 then
			local var_22_2 = PlayerData:GetPlayerInfo().userID

			table.remove(var_22_1, (table.indexof(var_22_1, var_22_2)))

			var_22_0[1] = var_22_2
		elseif self.playerIdList[iter_22_0] then
			local var_22_3 = table.indexof(var_22_1, self.playerIdList[iter_22_0])

			if var_22_3 then
				var_22_0[iter_22_0] = var_22_1[var_22_3]

				table.remove(var_22_1, var_22_3)
			end
		end
	end

	for iter_22_1 = 1, 3 do
		if not var_22_0[iter_22_1] then
			local var_22_4 = false

			for iter_22_2, iter_22_3 in ipairs(var_22_1) do
				if self.roomData:GetRoomPlayerData(iter_22_3).is_master == 1 then
					table.remove(var_22_1, iter_22_2)

					var_22_0[iter_22_1] = iter_22_3
					var_22_4 = true

					break
				end
			end

			if not var_22_4 then
				var_22_0[iter_22_1] = table.remove(var_22_1, 1)
			end
		end
	end

	self.playerIdList = var_22_0
	self.cacheHeroTeam_ = {}

	for iter_22_4, iter_22_5 in pairs(self.playerIdList) do
		local var_22_5 = self.roomData:GetRoomPlayerData(iter_22_5).heroList[1]
		local var_22_6 = {
			id = var_22_5.id
		}

		if var_22_5.skin == 0 then
			var_22_6.skin = var_22_5.id or var_22_5.skin
		end

		self.cacheHeroTeam_[iter_22_4] = var_22_6
	end

	self:LoadHeroModelsInOrder(1)
	self:RefreshPlayerState()
end

function CooperationView:RefreshPlayerState()
	for iter_23_0 = 1, 3 do
		self.playerComList[iter_23_0]:SetData(self.roomData, self.playerIdList[iter_23_0])
	end
end

function CooperationView:RefreshEffct()
	local var_24_0, var_24_1 = self:GetRaceEffect()

	self.m_raceEffect2Des.text = GetTips("NO_CORRECTOR_BUFF")
	self.m_raceEffect3Des.text = GetTips("NO_BATTLE_BUFF")

	if var_24_1 == 2 then
		self.m_raceEffectName.text = GetI18NText(RaceEffectCfg[var_24_0].name)
		self.m_raceEffectIcon.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_24_0].icon)
		self.m_raceEffect2Des.text = GetI18NText(RaceEffectCfg[var_24_0].desc)

		self.raceController:SetSelectedIndex(1)
	elseif var_24_1 == 3 then
		self.m_raceEffectName.text = GetI18NText(RaceEffectCfg[var_24_0].name)
		self.m_raceEffectIcon.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_24_0].icon)
		self.m_raceEffect2Des.text = GetI18NText(RaceEffectCfg[var_24_0].desc)
		self.m_raceEffect3Des.text = GetI18NText(RaceEffectCfg[var_24_0].battle_desc)

		self.raceController:SetSelectedIndex(2)
	else
		self.raceController:SetSelectedIndex(0)
	end

	local var_24_2 = 0

	for iter_24_0, iter_24_1 in ipairs((self.roomData:GetRoomPlayerIdList())) do
		-- block empty
	end

	if var_24_2 > 0 then
		self.friendController:SetSelectedIndex(0)

		self.m_friendEffectDes.text = ""
	else
		self.friendController:SetSelectedIndex(1)

		self.m_friendEffectDes.text = ""
	end
end

function CooperationView:GetRaceEffect()
	local var_25_0 = {}
	local var_25_1 = 0

	for iter_25_0, iter_25_1 in pairs(self.cacheHeroTeam_) do
		if iter_25_1.id ~= 0 then
			var_25_0[HeroCfg[iter_25_1.id].race] = (var_25_0[HeroCfg[iter_25_1.id].race] or 0) + 1

			if var_25_0[HeroCfg[iter_25_1.id].race] == 2 then
				var_25_1 = HeroCfg[iter_25_1.id].race
			end
		end
	end

	return var_25_1, var_25_0[var_25_1] or 1
end

function CooperationView:LoadHeroModelsInOrder(arg_26_1)
	if arg_26_1 > 3 then
		for iter_26_0, iter_26_1 in pairs(self.heroModel) do
			SetActive(iter_26_1.model, true)
		end

		return
	end

	local var_26_0 = self.cacheHeroTeam_[arg_26_1]

	if self.cacheHeroTeam_[arg_26_1] then
		var_26_0 = self.cacheHeroTeam_[arg_26_1].skin
	end

	if self.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(self.loadAsyncIndex)
	end

	if self.heroModel[arg_26_1] then
		if var_26_0 == self.heroModel[arg_26_1].id then
			self.heroModel[arg_26_1].model.transform.localEulerAngles = var_0_1[arg_26_1].rotation
			self.heroModel[arg_26_1].model.transform.localPosition = var_0_1[arg_26_1].position
			self.heroModel[arg_26_1].model.transform.localScale = var_0_1[arg_26_1].scale

			self:LoadHeroModelsInOrder(arg_26_1 + 1)

			return
		else
			manager.resourcePool:DestroyOrReturn(self.heroModel[arg_26_1].model, ASSET_TYPE.TPOSE)

			self.heroModel[arg_26_1] = nil
		end
	end

	if var_26_0 then
		self.loadAsyncIndex = manager.resourcePool:AsyncLoad("Char/" .. SkinCfg[var_26_0].ui_modelId, ASSET_TYPE.TPOSE, function(arg_27_0)
			self.heroModel[arg_26_1] = {
				model = arg_27_0,
				id = var_26_0
			}
			arg_27_0.transform.localEulerAngles = var_0_1[arg_26_1].rotation
			arg_27_0.transform.localPosition = var_0_1[arg_26_1].position
			arg_27_0.transform.localScale = var_0_1[arg_26_1].scale

			SetActive(arg_27_0, false)
			TimeTools.StartAfterSeconds(0.0333, function()
				self:LoadHeroModelsInOrder(arg_26_1 + 1)
			end, {})
		end)
	else
		self:LoadHeroModelsInOrder(arg_26_1 + 1)
	end
end

function CooperationView:DestroyHeroModels()
	if self.heroModel then
		for iter_29_0, iter_29_1 in pairs(self.heroModel) do
			manager.resourcePool:DestroyOrReturn(iter_29_1.model, ASSET_TYPE.TPOSE)
		end
	end

	if self.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(self.loadAsyncIndex)
	end

	self.loadAsyncIndex = nil
	self.heroModel = {}
end

function CooperationView:Dispose()
	for iter_30_0, iter_30_1 in ipairs(self.playerComList) do
		iter_30_1:Dispose()
	end

	self.playerComList = {}

	CooperationView.super.Dispose(self)
end

function CooperationView:NewMessage()
	local var_31_0 = ChatCooperationData:GetCacheContent()

	if #var_31_0 > 0 then
		local var_31_2 = string.format("%s:%s", var_31_0[#var_31_0].nick, (var_31_0[#var_31_0].contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER or nil) and string.format("[%s]", ChatStickerCfg[tonumber(var_31_0[#var_31_0].content)].name))
		local var_31_3 = self.m_chatLab

		if self.m_chatLab.cachedTextGenerator:GetPreferredWidth(var_31_2, (self.m_chatLab:GetGenerationSettings(self.m_chatLab.transform.rect.size))) * (1 / self.m_chatLab.pixelsPerUnit) > self.m_chatLab.transform.rect.width then
			SetActive(self.m_chatLabEx, true)
		else
			SetActive(self.m_chatLabEx, false)
		end

		var_31_3.text = GetI18NText(var_31_2)

		self.talkController:SetSelectedIndex(1)
	else
		self.m_chatLab.text = ""

		self.talkController:SetSelectedIndex(0)
	end
end

function CooperationView:BattleStart()
	for iter_32_0, iter_32_1 in ipairs(self.playerComList) do
		iter_32_1:BattleStart()
	end

	if self.roomData:GetRoomPlayerData(PlayerData:GetPlayerInfo().userID).is_master == 1 then
		self.btnController:SetSelectedIndex(0)
	else
		self.btnController:SetSelectedIndex(2)
	end
end

function CooperationView:ShowComboIncreaseGo()
	return false
end

function CooperationView:GetRoomName()
	return CooperationTools.GetCooperationRoomName(self.roomData.type, self.roomData.dest, self.roomData.activity_id)
end

function CooperationView:RefreshUI()
	return
end

function CooperationView:GetCooperationPlayerClass()
	return CooperationPlayer
end

function CooperationView:OnCooperationRoomInit()
	self:Refresh()
end

function CooperationView:OnCooperationRoomUpdate()
	local var_38_0 = self.roomData:GetMasetPlayerId()

	if self.masterPlayerId ~= var_38_0 then
		ShowTips(string.format(GetTips("ACTIVITY_STRONGHOLD_HOMEOWNER_CHANGE"), self.roomData:GetRoomPlayerData(var_38_0).nick))

		self.masterPlayerId = var_38_0
	end

	self:Refresh()
end

function CooperationView:OnFriendsListChange(arg_39_1)
	self:RefreshPlayerState()
end

return CooperationView
