local var_0_0 = class("CooperationView", ReduxView)
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

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/Cooperation/CooperationUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.friendController = ControllerUtil.GetController(arg_4_0.m_friendEffectController, "friendEffect")
	arg_4_0.raceController = ControllerUtil.GetController(arg_4_0.m_raceEffectController, "raceEffect")
	arg_4_0.roomAvailableController = ControllerUtil.GetController(arg_4_0.m_roomAvailabelController, "swich")
	arg_4_0.btnController = ControllerUtil.GetController(arg_4_0.m_btnController, "btn")
	arg_4_0.talkController = ControllerUtil.GetController(arg_4_0.m_talkController, "talk")
	arg_4_0.playerComList = {}

	for iter_4_0 = 1, 3 do
		local var_4_0 = arg_4_0["m_hero" .. iter_4_0]

		table.insert(arg_4_0.playerComList, arg_4_0:GetCooperationPlayerClass().New(var_4_0, iter_4_0))
	end

	arg_4_0.heroModel = {}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	ComponentBinder.GetInstance():BindCfgUI(arg_5_0, arg_5_0.m_cooperationGo)
	SetActive(arg_5_0.m_comboIncreaseGo, arg_5_0:ShowComboIncreaseGo())
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_startBtn, function()
		local var_7_0 = PlayerData:GetPlayerInfo().userID
		local var_7_1 = arg_6_0.roomData:GetSelfHero()
		local var_7_2 = arg_6_0.roomData:GetRoomPlayerIdList()

		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			local var_7_3 = arg_6_0.roomData:GetRoomPlayerData(iter_7_1)

			if iter_7_1 ~= var_7_0 and var_7_3.heroList[1].id == var_7_1 then
				ShowTips("COOPERATION_NO_ALLOW_READY_REPEAT")

				return
			end

			local var_7_4 = var_7_3.is_master == 1
			local var_7_5 = var_7_3.is_ready == 1

			if var_7_3 and not var_7_4 and not var_7_5 then
				ShowTips("COOPERATION_SOMEONE_UNREADY")

				return
			end
		end

		BattleController.GetInstance():LaunchCooperationBattle()
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_prepareBtn, function()
		local var_8_0 = PlayerData:GetPlayerInfo().userID
		local var_8_1 = arg_6_0.roomData:GetSelfHero()
		local var_8_2 = arg_6_0.roomData:GetRoomPlayerIdList()

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			if iter_8_1 ~= var_8_0 and arg_6_0.roomData:GetRoomPlayerData(iter_8_1).heroList[1].id == var_8_1 then
				ShowTips("COOPERATION_NO_ALLOW_READY_REPEAT")

				return
			end
		end

		CooperationAction.GetReady()
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_cancelBtn, function()
		CooperationAction.CancelReay()
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_roomAvailableBtn, function()
		if CooperationData:GetIsMaster() then
			if arg_6_0.roomData:IsAvailable() == 1 then
				CooperationAction.ChangeRoomAvailable(2)
			else
				CooperationAction.ChangeRoomAvailable(1)
			end
		else
			ShowTips("ERROR_COORDINATOR_NOT_OWNER")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_talkLongBtn, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_talkShortBtn, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_COOPERATION
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_comboIncreaseBtn, nil, function()
		JumpTools.OpenPageByJump("cooperationCombo")
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_roomIdCopyBtn, function()
		UnityEngine.GUIUtility.systemCopyBuffer = arg_6_0.roomData.room_id

		ShowTips("COPY_SUCCESS")
	end)
end

function var_0_0.OnTop(arg_15_0)
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

function var_0_0.OnEnter(arg_18_0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()

	arg_18_0.roomData = CooperationData:GetRoomData()

	if arg_18_0.roomData == nil then
		arg_18_0:Go("/home")

		return
	end

	arg_18_0:Refresh()
	arg_18_0:NewMessage()
	arg_18_0:RegistEventListener(CHAT_COOPERATION_NEW_MESSAGE, handler(arg_18_0, arg_18_0.NewMessage))
	arg_18_0:RegistEventListener(START_COOPERATION_BATTLE, handler(arg_18_0, arg_18_0.BattleStart))
	FriendsAction:TryToRefreshFriendsView(1)

	for iter_18_0 = 1, 3 do
		local var_18_0 = arg_18_0["m_hero" .. iter_18_0]
		local var_18_1 = var_0_1[iter_18_0].position
		local var_18_2 = manager.ui.mainCameraCom_:WorldToScreenPoint(var_18_1)
		local var_18_3 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
		local var_18_4, var_18_5 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_18_0.transform_, var_18_2, var_18_3, nil)

		print(var_18_5.x)

		var_18_0.transform.localPosition = Vector3.New(var_18_5.x, 10, 0)
	end

	arg_18_0.masterPlayerId = arg_18_0.roomData:GetMasetPlayerId()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_19_0:DestroyHeroModels()

	arg_19_0.playerList = nil

	for iter_19_0 = 1, 3 do
		arg_19_0.playerComList[iter_19_0]:Reset()
	end
end

function var_0_0.Refresh(arg_20_0)
	if not arg_20_0.roomData then
		return
	end

	arg_20_0:RefreshRoom()
	arg_20_0:RefreshPlayer()
	arg_20_0:RefreshEffct()
	arg_20_0:RefreshUI()
end

function var_0_0.RefreshRoom(arg_21_0)
	arg_21_0.m_stageLab.text = arg_21_0:GetRoomName()
	arg_21_0.m_roomIdLab.text = string.format(GetTips("COOPERATION_ROOM_ID"), arg_21_0.roomData.room_id)

	local var_21_0 = arg_21_0.roomData:IsAvailable()

	arg_21_0.roomAvailableController:SetSelectedIndex(var_21_0 == 1 and 0 or 1)

	local var_21_1 = PlayerData:GetPlayerInfo().userID
	local var_21_2 = arg_21_0.roomData:GetRoomPlayerData(var_21_1)
	local var_21_3 = var_21_2.is_master == 1
	local var_21_4 = var_21_2.is_ready == 1

	if var_21_3 then
		arg_21_0.btnController:SetSelectedIndex(0)
	elseif var_21_4 then
		arg_21_0.btnController:SetSelectedIndex(2)
	else
		arg_21_0.btnController:SetSelectedIndex(1)
	end
end

function var_0_0.RefreshPlayer(arg_22_0)
	arg_22_0.playerIdList = arg_22_0.playerIdList or {}

	local var_22_0 = {}
	local var_22_1 = arg_22_0.roomData:GetRoomPlayerIdList()

	for iter_22_0 = 1, 3 do
		if iter_22_0 == 1 then
			local var_22_2 = PlayerData:GetPlayerInfo().userID
			local var_22_3 = table.indexof(var_22_1, var_22_2)

			table.remove(var_22_1, var_22_3)

			var_22_0[1] = var_22_2
		else
			local var_22_4 = arg_22_0.playerIdList[iter_22_0]

			if var_22_4 then
				local var_22_5 = table.indexof(var_22_1, var_22_4)

				if var_22_5 then
					var_22_0[iter_22_0] = var_22_1[var_22_5]

					table.remove(var_22_1, var_22_5)
				end
			end
		end
	end

	for iter_22_1 = 1, 3 do
		if not var_22_0[iter_22_1] then
			local var_22_6 = false

			for iter_22_2, iter_22_3 in ipairs(var_22_1) do
				if arg_22_0.roomData:GetRoomPlayerData(iter_22_3).is_master == 1 then
					table.remove(var_22_1, iter_22_2)

					var_22_0[iter_22_1] = iter_22_3
					var_22_6 = true

					break
				end
			end

			if not var_22_6 then
				var_22_0[iter_22_1] = table.remove(var_22_1, 1)
			end
		end
	end

	arg_22_0.playerIdList = var_22_0
	arg_22_0.cacheHeroTeam_ = {}

	for iter_22_4, iter_22_5 in pairs(arg_22_0.playerIdList) do
		local var_22_7 = arg_22_0.roomData:GetRoomPlayerData(iter_22_5).heroList[1]

		arg_22_0.cacheHeroTeam_[iter_22_4] = {
			id = var_22_7.id,
			skin = var_22_7.skin == 0 and var_22_7.id or var_22_7.skin
		}
	end

	arg_22_0:LoadHeroModelsInOrder(1)
	arg_22_0:RefreshPlayerState()
end

function var_0_0.RefreshPlayerState(arg_23_0)
	for iter_23_0 = 1, 3 do
		local var_23_0 = arg_23_0.playerComList[iter_23_0]
		local var_23_1 = arg_23_0.playerIdList[iter_23_0]

		var_23_0:SetData(arg_23_0.roomData, var_23_1)
	end
end

function var_0_0.RefreshEffct(arg_24_0)
	local var_24_0, var_24_1 = arg_24_0:GetRaceEffect()

	arg_24_0.m_raceEffect2Des.text = GetTips("NO_CORRECTOR_BUFF")
	arg_24_0.m_raceEffect3Des.text = GetTips("NO_BATTLE_BUFF")

	if var_24_1 == 2 then
		local var_24_2 = RaceEffectCfg[var_24_0]

		arg_24_0.m_raceEffectName.text = GetI18NText(var_24_2.name)
		arg_24_0.m_raceEffectIcon.sprite = getSprite("Atlas/CampItemAtlas", var_24_2.icon)
		arg_24_0.m_raceEffect2Des.text = GetI18NText(var_24_2.desc)

		arg_24_0.raceController:SetSelectedIndex(1)
	elseif var_24_1 == 3 then
		local var_24_3 = RaceEffectCfg[var_24_0]

		arg_24_0.m_raceEffectName.text = GetI18NText(var_24_3.name)
		arg_24_0.m_raceEffectIcon.sprite = getSprite("Atlas/CampItemAtlas", var_24_3.icon)
		arg_24_0.m_raceEffect2Des.text = GetI18NText(var_24_3.desc)
		arg_24_0.m_raceEffect3Des.text = GetI18NText(var_24_3.battle_desc)

		arg_24_0.raceController:SetSelectedIndex(2)
	else
		arg_24_0.raceController:SetSelectedIndex(0)
	end

	local var_24_4 = 0
	local var_24_5 = arg_24_0.roomData:GetRoomPlayerIdList()

	for iter_24_0, iter_24_1 in ipairs(var_24_5) do
		if false then
			var_24_4 = var_24_4 + 1
		end
	end

	if var_24_4 > 0 then
		arg_24_0.friendController:SetSelectedIndex(0)

		arg_24_0.m_friendEffectDes.text = ""
	else
		arg_24_0.friendController:SetSelectedIndex(1)

		arg_24_0.m_friendEffectDes.text = ""
	end
end

function var_0_0.GetRaceEffect(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = 0
	local var_25_2 = arg_25_0.cacheHeroTeam_

	for iter_25_0, iter_25_1 in pairs(var_25_2) do
		local var_25_3 = iter_25_1.id

		if var_25_3 ~= 0 then
			local var_25_4 = HeroCfg[var_25_3].race

			var_25_0[var_25_4] = (var_25_0[var_25_4] or 0) + 1

			if var_25_0[var_25_4] == 2 then
				var_25_1 = var_25_4
			end
		end
	end

	return var_25_1, var_25_0[var_25_1] or 1
end

function var_0_0.LoadHeroModelsInOrder(arg_26_0, arg_26_1)
	if arg_26_1 > 3 then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.heroModel) do
			SetActive(iter_26_1.model, true)
		end

		return
	end

	local var_26_0 = arg_26_0.cacheHeroTeam_[arg_26_1] and arg_26_0.cacheHeroTeam_[arg_26_1].skin

	if arg_26_0.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(arg_26_0.loadAsyncIndex)
	end

	if arg_26_0.heroModel[arg_26_1] then
		if var_26_0 == arg_26_0.heroModel[arg_26_1].id then
			local var_26_1 = arg_26_0.heroModel[arg_26_1].model
			local var_26_2 = arg_26_1

			var_26_1.transform.localEulerAngles = var_0_1[var_26_2].rotation
			var_26_1.transform.localPosition = var_0_1[var_26_2].position
			var_26_1.transform.localScale = var_0_1[var_26_2].scale

			arg_26_0:LoadHeroModelsInOrder(arg_26_1 + 1)

			return
		else
			manager.resourcePool:DestroyOrReturn(arg_26_0.heroModel[arg_26_1].model, ASSET_TYPE.TPOSE)

			arg_26_0.heroModel[arg_26_1] = nil
		end
	end

	if var_26_0 then
		local var_26_3 = SkinCfg[var_26_0]

		arg_26_0.loadAsyncIndex = manager.resourcePool:AsyncLoad("Char/" .. var_26_3.ui_modelId, ASSET_TYPE.TPOSE, function(arg_27_0)
			arg_26_0.heroModel[arg_26_1] = {
				model = arg_27_0,
				id = var_26_0
			}

			local var_27_0 = arg_26_1

			arg_27_0.transform.localEulerAngles = var_0_1[var_27_0].rotation
			arg_27_0.transform.localPosition = var_0_1[var_27_0].position
			arg_27_0.transform.localScale = var_0_1[var_27_0].scale

			SetActive(arg_27_0, false)
			TimeTools.StartAfterSeconds(0.0333, function()
				arg_26_0:LoadHeroModelsInOrder(arg_26_1 + 1)
			end, {})
		end)
	else
		arg_26_0:LoadHeroModelsInOrder(arg_26_1 + 1)
	end
end

function var_0_0.DestroyHeroModels(arg_29_0)
	if arg_29_0.heroModel then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.heroModel) do
			manager.resourcePool:DestroyOrReturn(iter_29_1.model, ASSET_TYPE.TPOSE)
		end
	end

	if arg_29_0.loadAsyncIndex then
		manager.resourcePool:StopAsyncQuest(arg_29_0.loadAsyncIndex)
	end

	arg_29_0.loadAsyncIndex = nil
	arg_29_0.heroModel = {}
end

function var_0_0.Dispose(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0.playerComList) do
		iter_30_1:Dispose()
	end

	arg_30_0.playerComList = {}

	var_0_0.super.Dispose(arg_30_0)
end

function var_0_0.NewMessage(arg_31_0)
	local var_31_0 = ChatCooperationData:GetCacheContent()

	if #var_31_0 > 0 then
		local var_31_1 = var_31_0[#var_31_0]
		local var_31_2 = var_31_1.content or ""

		if var_31_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_31_2 = string.format("[%s]", ChatStickerCfg[tonumber(var_31_1.content)].name)
		end

		local var_31_3 = string.format("%s:%s", var_31_1.nick, var_31_2)
		local var_31_4 = arg_31_0.m_chatLab.transform.rect.size
		local var_31_5 = arg_31_0.m_chatLab
		local var_31_6 = var_31_5:GetGenerationSettings(var_31_4)
		local var_31_7 = 1 / var_31_5.pixelsPerUnit

		if var_31_5.cachedTextGenerator:GetPreferredWidth(var_31_3, var_31_6) * var_31_7 > arg_31_0.m_chatLab.transform.rect.width then
			SetActive(arg_31_0.m_chatLabEx, true)
		else
			SetActive(arg_31_0.m_chatLabEx, false)
		end

		var_31_5.text = GetI18NText(var_31_3)

		arg_31_0.talkController:SetSelectedIndex(1)
	else
		arg_31_0.m_chatLab.text = ""

		arg_31_0.talkController:SetSelectedIndex(0)
	end
end

function var_0_0.BattleStart(arg_32_0)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.playerComList) do
		iter_32_1:BattleStart()
	end

	local var_32_0 = PlayerData:GetPlayerInfo().userID

	if arg_32_0.roomData:GetRoomPlayerData(var_32_0).is_master == 1 then
		arg_32_0.btnController:SetSelectedIndex(0)
	else
		arg_32_0.btnController:SetSelectedIndex(2)
	end
end

function var_0_0.ShowComboIncreaseGo(arg_33_0)
	return false
end

function var_0_0.GetRoomName(arg_34_0)
	return CooperationTools.GetCooperationRoomName(arg_34_0.roomData.type, arg_34_0.roomData.dest, arg_34_0.roomData.activity_id)
end

function var_0_0.RefreshUI(arg_35_0)
	return
end

function var_0_0.GetCooperationPlayerClass(arg_36_0)
	return CooperationPlayer
end

function var_0_0.OnCooperationRoomInit(arg_37_0)
	arg_37_0:Refresh()
end

function var_0_0.OnCooperationRoomUpdate(arg_38_0)
	local var_38_0 = arg_38_0.roomData:GetMasetPlayerId()

	if arg_38_0.masterPlayerId ~= var_38_0 then
		local var_38_1 = arg_38_0.roomData:GetRoomPlayerData(var_38_0)

		ShowTips(string.format(GetTips("ACTIVITY_STRONGHOLD_HOMEOWNER_CHANGE"), var_38_1.nick))

		arg_38_0.masterPlayerId = var_38_0
	end

	arg_38_0:Refresh()
end

function var_0_0.OnFriendsListChange(arg_39_0, arg_39_1)
	arg_39_0:RefreshPlayerState()
end

return var_0_0
