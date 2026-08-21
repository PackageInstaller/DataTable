local var_0_0 = class("SoloHeartDemonMainView", ReduxView)
local var_0_1 = 11

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.difficultyBtnControllerList = {}
	arg_4_0.difficultyBtnControllerList[1] = ControllerUtil.GetController(arg_4_0.difficultyBtn1_.transform, "state")
	arg_4_0.difficultyBtnControllerList[2] = ControllerUtil.GetController(arg_4_0.difficultyBtn2_.transform, "state")
	arg_4_0.difficultyBtnControllerList[3] = ControllerUtil.GetController(arg_4_0.difficultyBtn3_.transform, "state")
	arg_4_0.challengeController = arg_4_0.fightBtnControllerEx_:GetController("state")
	arg_4_0.rankController = ControllerUtil.GetController(arg_4_0.rankGo_.transform, "state")
	arg_4_0.textLimit_ = arg_4_0.chatTxt_.gameObject:GetComponent("TextExtension")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.list_, SoloHeartDemonListItem)
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rankData.rankList[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, 1)
end

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["difficultyBtn" .. iter_6_0 .. "_"], nil, function()
			arg_6_0.selectDifficulty = iter_6_0

			arg_6_0:UpdateView()
			arg_6_0:UpdateDifficultyControllerState(iter_6_0)
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.fightBtn_, nil, function()
		SoloHeartDemonAction.UpdateViewRedPoint()

		if arg_6_0:CheckIsChallengeTime() then
			local var_8_0 = SoloHeartDemonCfg[arg_6_0.soloHeartDemonID].stage_id[arg_6_0.selectDifficulty][2]

			gameContext:Go("/sectionSelectHero", {
				section = var_8_0,
				sectionType = BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON,
				activityID = arg_6_0.activityId
			})
		else
			ShowTips(GetTips("SOLO_HEART_DEMON_TIME_OUT"))
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.upBtn_, nil, function()
		JumpTools.GoToSystem("/draw", {
			isFirst = true,
			poolId = DrawTools:GetRoleUpPoolID(arg_6_0.roleID)
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.GoToSystem("/soloHeartDemonReward", {
			activityId = arg_6_0.activityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.chatBtn_, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			soloHeartChange = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_6_0:AddBtnListener(arg_6_0.listGoBtn_, nil, function()
		JumpTools.GoToSystem("/soloHeartDemonRank", {
			activityId = arg_6_0.activityId
		})
	end)
end

function var_0_0.CheckIsChallengeTime(arg_13_0)
	return arg_13_0.challengeStage == 0
end

function var_0_0.UpdateView(arg_14_0)
	if arg_14_0.updateTimer2_ then
		arg_14_0.updateTimer2_:Stop()

		arg_14_0.updateTimer2_ = nil
	end

	for iter_14_0, iter_14_1 in pairs(ActivityCfg.get_id_list_by_activity_template[270]) do
		if ActivityData:GetActivityIsOpen(iter_14_1) then
			arg_14_0.activityId = iter_14_1

			break
		end
	end

	if arg_14_0.selectDifficulty == nil then
		arg_14_0.selectDifficulty = SoloHeartDemonData:GetDataByPara("selectDifficulty") or 3

		SoloHeartDemonData:ResetSelectDifficulty()
	end

	arg_14_0.difficultyData = SoloHeartDemonData:GetDataByPara("difficultyData")
	arg_14_0.soloHeartDemonID = SoloHeartDemonData:GetDataByPara("openEditor")
	arg_14_0.challengeStage = SoloHeartDemonData:GetDataByPara("challengeStage")
	arg_14_0.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)
	arg_14_0.maxCompleteDifficulty = SoloHeartDemonData:GetDataByPara("maxCompleteDifficulty")
	arg_14_0.templateID = SoloHeartDemonCfg[arg_14_0.soloHeartDemonID].heart_damon_id
	arg_14_0.roleID = SoloHeartDemonUICfg[arg_14_0.templateID].hero_id

	arg_14_0:UpdateDifficultyControllerState(arg_14_0.selectDifficulty)
	arg_14_0:OnRankUpdate()
	arg_14_0:LoadModel()

	local var_14_0 = arg_14_0.selectDifficulty == 3 and "SoloHeartDemonUI_00026" or "SoloHeartDemonUI_00012"

	arg_14_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/SoloHeartDemonUI/" .. var_14_0)

	if arg_14_0.selectDifficulty == 3 and arg_14_0.hardEffect_.activeSelf == false then
		manager.audio:PlayEffect("minigame_activity_2_4", "minigame_activity_2_4_xinmo_turn", "")
	end

	SetActive(arg_14_0.list.gameObject, arg_14_0.selectDifficulty == 3)
	SetActive(arg_14_0.normalEffect_, arg_14_0.selectDifficulty ~= 3)
	SetActive(arg_14_0.hardEffect_, arg_14_0.selectDifficulty == 3)

	arg_14_0.timeTxt_.text = GetTips(arg_14_0.challengeStage == 0 and "SOLO_HEART_DEMON_CHALLENGE_TIME" or "SOLO_HEART_DEMON_REFRESH_TIME")

	arg_14_0.challengeController:SetSelectedState(arg_14_0.challengeStage == 0 and "normal" or "lock")
	arg_14_0:UpdateDrawView()

	arg_14_0.remainTxt_.text = manager.time:GetLostTimeStr2(arg_14_0.remainTime)
	arg_14_0.updateTimer2_ = Timer.New(function()
		arg_14_0.remainTxt_.text = manager.time:GetLostTimeStr2(arg_14_0.remainTime)

		if ActivityData:GetActivityIsOpen(ActivityConst.SOLO_HEART_DEMON) == false then
			arg_14_0:Back()
			ShowTips("SOLO_HEART_DEMON_REFRESH_TIPS")

			arg_14_0.currentBossTemplateID = nil
		end
	end, 1, -1, 1)

	arg_14_0.updateTimer2_:Start()
end

function var_0_0.UpdateDrawView(arg_16_0)
	SetActive(arg_16_0.upBtn_.gameObject, DrawTools:GetRoleUpPoolID(arg_16_0.roleID) ~= false)

	if arg_16_0.updateTimer_ then
		arg_16_0.updateTimer_:Stop()

		arg_16_0.updateTimer_ = nil
	end

	if DrawTools:GetRoleUpPoolID(arg_16_0.roleID) == false then
		return
	end

	local var_16_0 = 0
	local var_16_1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if ActivityData:GetActivityIsOpen(iter_16_1) then
			local var_16_2 = ActivityDrawPoolCfg[iter_16_1]

			for iter_16_2, iter_16_3 in ipairs(var_16_2.config_list) do
				if iter_16_3 == DrawTools:GetRoleUpPoolID(arg_16_0.roleID) then
					var_16_0 = ActivityData:GetActivityData(iter_16_1).stopTime
				end
			end
		end
	end

	arg_16_0.drawRemainTxt_.text = manager.time:GetLostTimeStr2(var_16_0)
	arg_16_0.updateTimer_ = Timer.New(function()
		arg_16_0.drawRemainTxt_.text = manager.time:GetLostTimeStr2(var_16_0)

		if var_16_0 - manager.time:GetServerTime() <= -1 then
			SetActive(arg_16_0.upBtn_.gameObject, false)
		end
	end, 1, var_16_0 - manager.time:GetServerTime(), 1)

	arg_16_0.updateTimer_:Start()
end

function var_0_0.UpdateDifficultyControllerState(arg_18_0, arg_18_1)
	for iter_18_0 = 1, 3 do
		local var_18_0 = arg_18_0.difficultyData[iter_18_0]

		if arg_18_1 == iter_18_0 then
			arg_18_0.difficultyBtnControllerList[iter_18_0]:SetSelectedState(var_18_0.challengeState == 2 and "selecfinish" or "select")
		else
			arg_18_0.difficultyBtnControllerList[iter_18_0]:SetSelectedState(var_18_0.challengeState == 2 and "finish" or "unSelect")
		end
	end
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.exitView_ = false
	arg_19_0.activityId = arg_19_0.params_.activityId

	RankAction.QueryCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)
	manager.ui:SetMainCamera("soloHeartDemon")
	manager.windowBar:SetWhereTag("soloHeartDemon")
	arg_19_0:InitBackScene()
	arg_19_0:InitChat()
	arg_19_0:UpdateView()
	arg_19_0:BindRedPoint()
end

function var_0_0.InitChat(arg_20_0)
	arg_20_0.lastChatNumber = ChatData:GetWorldChannelNum()

	ChatAction.SetWorldChannelNum(var_0_1, function(arg_21_0)
		if arg_21_0 == 0 then
			ChatData:SetChannelTimestamp()
			ChatAction.EnterChatUI(3)
		end
	end)
	arg_20_0:RefreshReceiveMessage()
end

function var_0_0.ClearMsgTimer(arg_22_0)
	if arg_22_0.msgTimer_ then
		arg_22_0.msgTimer_:Stop()

		arg_22_0.msgTimer_ = nil
	end
end

function var_0_0.RefreshReceiveMessage(arg_23_0)
	arg_23_0:ClearMsgTimer()
	arg_23_0:RefreshWorldChat()

	arg_23_0.msgTimer_ = Timer.New(function()
		arg_23_0:RefreshWorldChat()
	end, 2, -1)

	arg_23_0.msgTimer_:Start()
end

function var_0_0.RefreshWorldChat(arg_25_0)
	local var_25_0 = ChatData:GetWorldChatData()
	local var_25_1 = var_25_0[#var_25_0]

	if var_25_1 then
		local var_25_2 = ""
		local var_25_3 = ""

		if var_25_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_25_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			if var_25_1.id == USER_ID then
				var_25_2 = PlayerData:GetPlayerInfo().nick or ""
			else
				var_25_2 = var_25_1.nick or ""
			end

			if var_25_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT then
				var_25_3 = var_25_1.content or ""
			else
				var_25_3 = string.format("[%s]", ChatStickerCfg[tonumber(var_25_1.content)].name)
			end
		end

		local var_25_4 = ""

		if var_25_2 ~= "" then
			var_25_4 = var_25_2 .. ":" .. var_25_3
		end

		arg_25_0.textLimit_:SetText(var_25_4)

		return
	end

	arg_25_0.textLimit_:SetText("")
end

function var_0_0.IsShowRank(arg_26_0)
	return arg_26_0.remainTime - 86400 > manager.time:GetServerTime() and arg_26_0.challengeStage == 1
end

function var_0_0.OnRankUpdate(arg_27_0)
	arg_27_0.rankData = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	arg_27_0.rankController:SetSelectedState("mini")

	if arg_27_0.selectDifficulty ~= 3 or arg_27_0.rankData == nil then
		return
	end

	if arg_27_0:IsShowRank() then
		return
	end

	if #arg_27_0.rankData.rankList >= 5 then
		arg_27_0.rankController:SetSelectedState("all")
	end

	arg_27_0.list:StartScroll(5)
end

function var_0_0.OnSoloDemonHeartUpdate(arg_28_0)
	arg_28_0:UpdateView()
end

function var_0_0.BindRedPoint(arg_29_0)
	manager.redPoint:bindUIandKey(arg_29_0.rewardBtn_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
	manager.redPoint:bindUIandKey(arg_29_0.fightBtn_.transform, RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW)
end

function var_0_0.UnbindRedPoint(arg_30_0)
	manager.redPoint:unbindUIandKey(arg_30_0.rewardBtn_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
	manager.redPoint:unbindUIandKey(arg_30_0.fightBtn_.transform, RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW)
end

function var_0_0.OnExit(arg_31_0)
	arg_31_0.exitView_ = true

	arg_31_0:ClearMsgTimer()
	arg_31_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	arg_31_0:DestroyBackScene()
	arg_31_0:UnloadModel()
	manager.ui:ResetMainCamera()

	if arg_31_0.updateTimer_ then
		arg_31_0.updateTimer_:Stop()

		arg_31_0.updateTimer_ = nil
	end

	if arg_31_0.updateTimer2_ then
		arg_31_0.updateTimer2_:Stop()

		arg_31_0.updateTimer2_ = nil
	end

	SetActive(arg_31_0.hardEffect_, false)

	if arg_31_0.lastChatNumber == 0 or arg_31_0.lastChatNumber == var_0_1 then
		arg_31_0.lastChatNumber = 1
	end

	if ChatData:GetWorldChannelNum() ~= var_0_1 then
		return
	end

	if manager.net.tcpConnection_:GetMachineState() == "connecting" or manager.net.tcpConnection_:GetMachineState() == "connected" then
		ChatAction.SetWorldChannelNum(arg_31_0.lastChatNumber, function(arg_32_0)
			if arg_32_0 == 0 then
				ChatAction.EnterChatUI(2)
				ChatData:SetChannelTimestamp()
			end
		end)
	end
end

function var_0_0.OnTop(arg_33_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("SOLO_HEART_DEMON_EXPLAIN")
end

function var_0_0.Dispose(arg_34_0)
	if arg_34_0.list then
		arg_34_0.list:Dispose()

		arg_34_0.list = nil
	end

	var_0_0.super.Dispose(arg_34_0)
	Object.Destroy(arg_34_0.gameObject_)
end

function var_0_0.InitBackScene(arg_35_0)
	local var_35_0 = "UI/Common/BackgroundQuad"

	arg_35_0.backGround_ = manager.resourcePool:Get(var_35_0, ASSET_TYPE.SCENE)
	arg_35_0.backGroundTrs_ = arg_35_0.backGround_.transform

	arg_35_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_35_1 = GameDisplayCfg.solo_heart_demon_bg_pos.value

	arg_35_0.backGroundTrs_.localPosition = Vector3(var_35_1[1], var_35_1[2], var_35_1[3])
	arg_35_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_35_2 = GameDisplayCfg.solo_heart_demon_bg_pos.scale

	arg_35_0.backGroundTrs_.localScale = Vector3(var_35_2[1], var_35_2[2], var_35_2[3])
end

function var_0_0.DestroyBackScene(arg_36_0)
	if arg_36_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_36_0.backGround_, ASSET_TYPE.SCENE)

		arg_36_0.backGround_ = nil
	end
end

function var_0_0.UnloadModel(arg_37_0)
	if arg_37_0.bossModel ~= nil then
		manager.resourcePool:DestroyOrReturn(arg_37_0.bossModel, ASSET_TYPE.TPOSE)

		arg_37_0.bossModel = nil

		manager.resourcePool:StopAsyncQuest(arg_37_0.loadIndex)

		arg_37_0.loadIndex = nil
		arg_37_0.currentBossTemplateID = nil
	end
end

function var_0_0.LoadModel(arg_38_0)
	if arg_38_0.currentBossTemplateID == arg_38_0.templateID then
		return
	end

	arg_38_0:UnloadModel()

	arg_38_0.currentBossTemplateID = arg_38_0.templateID

	local var_38_0 = SoloHeartDemonUICfg[arg_38_0.templateID]

	arg_38_0.loadIndex = manager.resourcePool:AsyncLoad("Char/" .. var_38_0.model, ASSET_TYPE.TPOSE, function(arg_39_0)
		if arg_38_0.exitView_ or arg_38_0.currentBossTemplateID ~= arg_38_0.templateID then
			manager.resourcePool:DestroyOrReturn(arg_39_0, ASSET_TYPE.TPOSE)

			return
		end

		local var_39_0 = var_38_0.model_pos
		local var_39_1 = var_38_0.model_rot
		local var_39_2 = var_38_0.model_scale

		arg_38_0.bossModel = arg_39_0
		arg_39_0.transform.localPosition = Vector3(var_39_0[1], var_39_0[2], var_39_0[3])
		arg_39_0.transform.localEulerAngles = Vector3(var_39_1[1], var_39_1[2], var_39_1[3])
		arg_39_0.transform.localScale = Vector3(var_39_2[1], var_39_2[2], var_39_2[3])
	end)
end

return var_0_0
