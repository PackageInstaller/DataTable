local SoloHeartDemonMainView = class("SoloHeartDemonMainView", ReduxView)
local var_0_1 = 11

function SoloHeartDemonMainView:UIName()
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonMainUI"
end

function SoloHeartDemonMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloHeartDemonMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SoloHeartDemonMainView:InitUI()
	self:BindCfgUI()

	self.difficultyBtnControllerList = {}
	self.difficultyBtnControllerList[1] = ControllerUtil.GetController(self.difficultyBtn1_.transform, "state")
	self.difficultyBtnControllerList[2] = ControllerUtil.GetController(self.difficultyBtn2_.transform, "state")
	self.difficultyBtnControllerList[3] = ControllerUtil.GetController(self.difficultyBtn3_.transform, "state")
	self.challengeController = self.fightBtnControllerEx_:GetController("state")
	self.rankController = ControllerUtil.GetController(self.rankGo_.transform, "state")
	self.textLimit_ = self.chatTxt_.gameObject:GetComponent("TextExtension")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, SoloHeartDemonListItem)
end

function SoloHeartDemonMainView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData.rankList[arg_5_1], arg_5_1, 1)
end

function SoloHeartDemonMainView:AddUIListener()
	for iter_6_0 = 1, 3 do
		self:AddBtnListener(self["difficultyBtn" .. iter_6_0 .. "_"], nil, function()
			self.selectDifficulty = iter_6_0

			self:UpdateView()
			self:UpdateDifficultyControllerState(iter_6_0)
		end)
	end

	self:AddBtnListener(self.fightBtn_, nil, function()
		SoloHeartDemonAction.UpdateViewRedPoint()

		if self:CheckIsChallengeTime() then
			gameContext:Go("/sectionSelectHero", {
				section = SoloHeartDemonCfg[self.soloHeartDemonID].stage_id[self.selectDifficulty][2],
				sectionType = BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON,
				activityID = self.activityId
			})
		else
			ShowTips(GetTips("SOLO_HEART_DEMON_TIME_OUT"))
		end
	end)
	self:AddBtnListener(self.upBtn_, nil, function()
		JumpTools.GoToSystem("/draw", {
			isFirst = true,
			poolId = DrawTools:GetRoleUpPoolID(self.roleID)
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.GoToSystem("/soloHeartDemonReward", {
			activityId = self.activityId
		})
	end)
	self:AddBtnListener(self.chatBtn_, nil, function()
		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			soloHeartChange = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_WORLD
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.listGoBtn_, nil, function()
		JumpTools.GoToSystem("/soloHeartDemonRank", {
			activityId = self.activityId
		})
	end)
end

function SoloHeartDemonMainView:CheckIsChallengeTime()
	return self.challengeStage == 0
end

function SoloHeartDemonMainView:UpdateView()
	if self.updateTimer2_ then
		self.updateTimer2_:Stop()

		self.updateTimer2_ = nil
	end

	for iter_14_0, iter_14_1 in pairs(ActivityCfg.get_id_list_by_activity_template[270]) do
		if ActivityData:GetActivityIsOpen(iter_14_1) then
			self.activityId = iter_14_1

			break
		end
	end

	if self.selectDifficulty == nil then
		self.selectDifficulty = SoloHeartDemonData:GetDataByPara("selectDifficulty") or 3

		SoloHeartDemonData:ResetSelectDifficulty()
	end

	self.difficultyData = SoloHeartDemonData:GetDataByPara("difficultyData")
	self.soloHeartDemonID = SoloHeartDemonData:GetDataByPara("openEditor")
	self.challengeStage = SoloHeartDemonData:GetDataByPara("challengeStage")
	self.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)
	self.maxCompleteDifficulty = SoloHeartDemonData:GetDataByPara("maxCompleteDifficulty")
	self.templateID = SoloHeartDemonCfg[self.soloHeartDemonID].heart_damon_id
	self.roleID = SoloHeartDemonUICfg[self.templateID].hero_id

	self:UpdateDifficultyControllerState(self.selectDifficulty)
	self:OnRankUpdate()
	self:LoadModel()

	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureConfig/SoloHeartDemonUI/" .. (self.selectDifficulty == 3 and "SoloHeartDemonUI_00026" or "SoloHeartDemonUI_00012"))

	if self.selectDifficulty == 3 and self.hardEffect_.activeSelf == false then
		manager.audio:PlayEffect("minigame_activity_2_4", "minigame_activity_2_4_xinmo_turn", "")
	end

	SetActive(self.list.gameObject, self.selectDifficulty == 3)
	SetActive(self.normalEffect_, self.selectDifficulty ~= 3)
	SetActive(self.hardEffect_, self.selectDifficulty == 3)

	self.timeTxt_.text = GetTips(self.challengeStage == 0 and "SOLO_HEART_DEMON_CHALLENGE_TIME" or "SOLO_HEART_DEMON_REFRESH_TIME")

	self.challengeController:SetSelectedState(self.challengeStage == 0 and "normal" or "lock")
	self:UpdateDrawView()

	self.remainTxt_.text = manager.time:GetLostTimeStr2(self.remainTime)
	self.updateTimer2_ = Timer.New(function()
		self.remainTxt_.text = manager.time:GetLostTimeStr2(self.remainTime)

		if ActivityData:GetActivityIsOpen(ActivityConst.SOLO_HEART_DEMON) == false then
			self:Back()
			ShowTips("SOLO_HEART_DEMON_REFRESH_TIPS")

			self.currentBossTemplateID = nil
		end
	end, 1, -1, 1)

	self.updateTimer2_:Start()
end

function SoloHeartDemonMainView:UpdateDrawView()
	SetActive(self.upBtn_.gameObject, DrawTools:GetRoleUpPoolID(self.roleID) ~= false)

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if DrawTools:GetRoleUpPoolID(self.roleID) == false then
		return
	end

	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
		if ActivityData:GetActivityIsOpen(iter_16_1) then
			for iter_16_2, iter_16_3 in ipairs(ActivityDrawPoolCfg[iter_16_1].config_list) do
				if iter_16_3 == DrawTools:GetRoleUpPoolID(self.roleID) then
					var_16_0 = ActivityData:GetActivityData(iter_16_1).stopTime
				end
			end
		end
	end

	self.drawRemainTxt_.text = manager.time:GetLostTimeStr2(var_16_0)
	self.updateTimer_ = Timer.New(function()
		self.drawRemainTxt_.text = manager.time:GetLostTimeStr2(var_16_0)

		if var_16_0 - manager.time:GetServerTime() <= -1 then
			SetActive(self.upBtn_.gameObject, false)
		end
	end, 1, var_16_0 - manager.time:GetServerTime(), 1)

	self.updateTimer_:Start()
end

function SoloHeartDemonMainView:UpdateDifficultyControllerState(arg_18_1)
	for iter_18_0 = 1, 3 do
		local var_18_0 = self.difficultyData[iter_18_0]

		if arg_18_1 == iter_18_0 then
			self.difficultyBtnControllerList[iter_18_0]:SetSelectedState(var_18_0.challengeState == 2 and "selecfinish" or "select")
		else
			self.difficultyBtnControllerList[iter_18_0]:SetSelectedState(var_18_0.challengeState == 2 and "finish" or "unSelect")
		end
	end
end

function SoloHeartDemonMainView:OnEnter()
	self.exitView_ = false
	self.activityId = self.params_.activityId

	RankAction.QueryCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)
	manager.ui:SetMainCamera("soloHeartDemon")
	manager.windowBar:SetWhereTag("soloHeartDemon")
	self:InitBackScene()
	self:InitChat()
	self:UpdateView()
	self:BindRedPoint()
end

function SoloHeartDemonMainView:InitChat()
	self.lastChatNumber = ChatData:GetWorldChannelNum()

	ChatAction.SetWorldChannelNum(var_0_1, function(arg_21_0)
		if arg_21_0 == 0 then
			ChatData:SetChannelTimestamp()
			ChatAction.EnterChatUI(3)
		end
	end)
	self:RefreshReceiveMessage()
end

function SoloHeartDemonMainView:ClearMsgTimer()
	if self.msgTimer_ then
		self.msgTimer_:Stop()

		self.msgTimer_ = nil
	end
end

function SoloHeartDemonMainView:RefreshReceiveMessage()
	self:ClearMsgTimer()
	self:RefreshWorldChat()

	self.msgTimer_ = Timer.New(function()
		self:RefreshWorldChat()
	end, 2, -1)

	self.msgTimer_:Start()
end

function SoloHeartDemonMainView:RefreshWorldChat()
	local var_25_0 = ChatData:GetWorldChatData()
	local var_25_1 = var_25_0[#var_25_0]

	if var_25_0[#var_25_0] then
		local var_25_2 = ""
		local var_25_3 = ""

		if var_25_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT or var_25_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_25_2 = var_25_1.id == USER_ID and (PlayerData:GetPlayerInfo().nick or "") or var_25_1.nick or ""
			var_25_3 = var_25_1.contentType == ChatConst.CHAT_CONTENT_TYPE.TEXT and (var_25_1.content or "") or string.format("[%s]", ChatStickerCfg[tonumber(var_25_1.content)].name)
		end

		self.textLimit_:SetText((var_25_2 ~= "" or nil) and var_25_2 .. ":" .. var_25_3)

		return
	end

	self.textLimit_:SetText("")
end

function SoloHeartDemonMainView:IsShowRank()
	return self.remainTime - 86400 > manager.time:GetServerTime() and self.challengeStage == 1
end

function SoloHeartDemonMainView:OnRankUpdate()
	self.rankData = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	self.rankController:SetSelectedState("mini")

	if self.selectDifficulty ~= 3 or self.rankData == nil then
		return
	end

	if self:IsShowRank() then
		return
	end

	if #self.rankData.rankList >= 5 then
		self.rankController:SetSelectedState("all")
	end

	self.list:StartScroll(5)
end

function SoloHeartDemonMainView:OnSoloDemonHeartUpdate()
	self:UpdateView()
end

function SoloHeartDemonMainView:BindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
	manager.redPoint:bindUIandKey(self.fightBtn_.transform, RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW)
end

function SoloHeartDemonMainView:UnbindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.SOLO_HEART_DEMON_REWARD)
	manager.redPoint:unbindUIandKey(self.fightBtn_.transform, RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW)
end

function SoloHeartDemonMainView:OnExit()
	self.exitView_ = true

	self:ClearMsgTimer()
	self:UnbindRedPoint()
	manager.windowBar:HideBar()
	self:DestroyBackScene()
	self:UnloadModel()
	manager.ui:ResetMainCamera()

	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end

	if self.updateTimer2_ then
		self.updateTimer2_:Stop()

		self.updateTimer2_ = nil
	end

	SetActive(self.hardEffect_, false)

	if self.lastChatNumber == 0 or self.lastChatNumber == var_0_1 then
		self.lastChatNumber = 1
	end

	if ChatData:GetWorldChannelNum() ~= var_0_1 then
		return
	end

	if manager.net.tcpConnection_:GetMachineState() == "connecting" or manager.net.tcpConnection_:GetMachineState() == "connected" then
		ChatAction.SetWorldChannelNum(self.lastChatNumber, function(arg_32_0)
			if arg_32_0 == 0 then
				ChatAction.EnterChatUI(2)
				ChatData:SetChannelTimestamp()
			end
		end)
	end
end

function SoloHeartDemonMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("SOLO_HEART_DEMON_EXPLAIN")
end

function SoloHeartDemonMainView:Dispose()
	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	SoloHeartDemonMainView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

function SoloHeartDemonMainView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.solo_heart_demon_bg_pos.value[1], GameDisplayCfg.solo_heart_demon_bg_pos.value[2], GameDisplayCfg.solo_heart_demon_bg_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.solo_heart_demon_bg_pos.scale[1], GameDisplayCfg.solo_heart_demon_bg_pos.scale[2], GameDisplayCfg.solo_heart_demon_bg_pos.scale[3])
end

function SoloHeartDemonMainView:DestroyBackScene()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

function SoloHeartDemonMainView:UnloadModel()
	if self.bossModel ~= nil then
		manager.resourcePool:DestroyOrReturn(self.bossModel, ASSET_TYPE.TPOSE)

		self.bossModel = nil

		manager.resourcePool:StopAsyncQuest(self.loadIndex)

		self.loadIndex = nil
		self.currentBossTemplateID = nil
	end
end

function SoloHeartDemonMainView:LoadModel()
	if self.currentBossTemplateID == self.templateID then
		return
	end

	self:UnloadModel()

	self.currentBossTemplateID = self.templateID

	local var_38_0 = SoloHeartDemonUICfg[self.templateID]

	self.loadIndex = manager.resourcePool:AsyncLoad("Char/" .. SoloHeartDemonUICfg[self.templateID].model, ASSET_TYPE.TPOSE, function(arg_39_0)
		if self.exitView_ or self.currentBossTemplateID ~= self.templateID then
			manager.resourcePool:DestroyOrReturn(arg_39_0, ASSET_TYPE.TPOSE)

			return
		end

		local var_39_0 = var_38_0.model_pos

		self.bossModel = arg_39_0
		arg_39_0.transform.localPosition = Vector3(var_39_0[1], var_39_0[2], var_39_0[3])
		arg_39_0.transform.localEulerAngles = Vector3(var_38_0.model_rot[1], var_38_0.model_rot[2], var_38_0.model_rot[3])
		arg_39_0.transform.localScale = Vector3(var_38_0.model_scale[1], var_38_0.model_scale[2], var_38_0.model_scale[3])
	end)
end

return SoloHeartDemonMainView
