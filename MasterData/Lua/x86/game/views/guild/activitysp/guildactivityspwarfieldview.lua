local GuildActivitySPWarFieldView = class("GuildActivitySPWarFieldView", ReduxView)

function GuildActivitySPWarFieldView:UIName()
	return "UI/GuildActivitySPUI/GuildActivitySPWarFieldUI"
end

function GuildActivitySPWarFieldView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivitySPWarFieldView:OnCtor()
	return
end

function GuildActivitySPWarFieldView:Init()
	self:InitUI()
	self:AddUIListener()

	self.newMessageHandler_ = handler(self, self.ChatNewMessage)
end

function GuildActivitySPWarFieldView:InitUI()
	self:BindCfgUI()

	self.hideLockController_ = ControllerUtil.GetController(self.gameObject_.transform, "canNext")
	self.chatTextExtension_ = self.chatText_:GetComponent(typeof(TextExtension))
end

function GuildActivitySPWarFieldView:indexItem(arg_6_1, arg_6_2)
	return
end

function GuildActivitySPWarFieldView:AddUIListener()
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		self:GetGuildActivityManager():SetZoom(self.mapSlider_.value)
	end))
	self:GetGuildActivityManager():SetOnZoomByFingerHandler(handler(self, self.OnZoomChangeByFinger))
	self:GetGuildActivityManager():SetOnNodeClick(handler(self, self.OnNodeClick))
	self:GetGuildActivityManager():SetOnBonusClick(handler(self, self.OnBonusNodeClick))
	self:GetGuildActivityManager():SetOnBgClick(handler(self, self.OnBgClick))
	self:GetGuildActivityManager():SetOnLevelLoaded(handler(self, self.OnLevelLoaded))
	self:AddBtnListener(self.allGetBtn_, nil, function()
		GuildActivitySPAction.GetCoin()
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		self:GoToPrevLevel()
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		self:GoToNextLevel()
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not self:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivitySPReward", {
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.ratingBtn_, nil, function()
		if not self:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivitySPRate", {
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.setupBtn_, nil, function()
		JumpTools.OpenPageByJump("guildActivitySPFightHeroSetting", {
			isEnter = true,
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.talentBtn_, nil, function()
		if not self:IsTop() then
			gameContext:Back()
		end

		self:Go("/guildActivitySPAffixMain", {
			activityID = self.params_.activityID
		})
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, (GuildActivitySPData:GetCurRunActivityID())), 0)
	end)
	self:AddBtnListener(self.storeBtn_, nil, function()
		local var_16_0 = {}
		local var_16_1 = GuildActivitySpTools.GetCurActivityIDInfo((GuildActivitySPData:GetCurMainActivityID())).shopID

		for iter_16_0, iter_16_1 in ipairs(ShopListCfg.all) do
			if ShopListCfg[iter_16_1].display_group == ShopListCfg[var_16_1].display_group then
				table.insert(var_16_0, iter_16_1)
			end
		end

		JumpTools.GoToSystem("/activityShop", {
			hideHomeBtn = 1,
			shopId = var_16_1,
			showShops = var_16_0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.chatBtn_, nil, function()
		local var_17_0

		if not self:IsTop() then
			gameContext:Back()

			var_17_0 = {
				ignoreBG = true
			}
		end

		var_17_0.chatToggleID = GuildActivitySpTools.GetCurOpenActivityStateInfo().chatToggleID

		JumpTools.OpenPageByJump("chat", var_17_0, ViewConst.SYSTEM_ID.CHAT)
	end)
	self:AddBtnListener(self.currencyBtn_, nil, function()
		local var_18_0 = GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1)

		if var_18_0 then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_18_0
			})
		end
	end)
	self:AddBtnListener(self.currency2Btn_, nil, function()
		local var_19_0 = GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 2)

		if var_19_0 then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_19_0
			})
		end
	end)
end

function GuildActivitySPWarFieldView:AddEventListeners()
	self:RegistEventListener(MATERIAL_MODIFY, function(arg_21_0)
		local var_21_0 = GuildActivitySPData:GetCurMainActivityID()

		if arg_21_0 == GuildActivitySpTools.GetCurCurrencyID(var_21_0, 1) or arg_21_0 == GuildActivitySpTools.GetCurCurrencyID(var_21_0, 2) then
			self:UpdateLevelView()
		end
	end)
	self:RegistEventListener(GUILD_ACTIVITY_SP_DISPATCHED, function()
		self:UpdateLevelView()
	end)
	self:RegistEventListener(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, function()
		self:UpdateLevelView()
	end)
	self:RegistEventListener(GUILD_ACTIVITY_SP_SPAWN_ID_UPDATE, function()
		self:UpdateRightBtn()
	end)
	self:RegistEventListener(GUILD_ACTIVITY_SP_COIN_GET_FINISH, function()
		self:UpdateLevelView()
		self.currencyAnimator_:Play("currency", -1, 0)
	end)
end

function GuildActivitySPWarFieldView:OnZoomChangeByFinger(arg_26_1)
	self.mapSlider_.value = arg_26_1
end

function GuildActivitySPWarFieldView:OnBgClick()
	if gameContext.routes_[#gameContext.routes_] == "guildActivitySPNormalPop" or gameContext.routes_[#gameContext.routes_] == "guildActivitySPElitePop" or gameContext.routes_[#gameContext.routes_] == "guildActivitySPBossPop" or gameContext.routes_[#gameContext.routes_] == "guildActivitySPSmallBossPop" then
		gameContext:Back()
	end
end

function GuildActivitySPWarFieldView:OnLevelLoaded(arg_28_1)
	self.curMapIndex_ = arg_28_1

	self:UpdateLevelView()
end

function GuildActivitySPWarFieldView:OnNodeClick(arg_29_1)
	self.curNodeId = arg_29_1

	if not ActivityClubSPCfg[arg_29_1] then
		CustomLog.Log(debug.traceback(string.format("找不到指定id为节点：%d", arg_29_1)))

		return
	end

	if not self:IsTop() then
		gameContext:Back()
	end

	if self.animTimer_ ~= nil then
		return
	end

	if ActivityClubSPCfg[arg_29_1].type == 0 then
		-- block empty
	elseif ActivityClubSPCfg[arg_29_1].type == 1 then
		JumpTools.OpenPageByJump("guildActivitySPNormalPop", {
			nodeId = arg_29_1
		})
	elseif ActivityClubSPCfg[arg_29_1].type == 2 then
		JumpTools.OpenPageByJump("guildActivitySPElitePop", {
			nodeId = arg_29_1
		})
	elseif ActivityClubSPCfg[arg_29_1].type == 3 then
		JumpTools.OpenPageByJump("guildActivitySPSmallBossPop", {
			nodeId = arg_29_1
		})
	elseif ActivityClubSPCfg[arg_29_1].type == 4 then
		JumpTools.OpenPageByJump("guildActivitySPBossPop", {
			nodeId = arg_29_1
		})
	end
end

function GuildActivitySPWarFieldView:OnBonusNodeClick(arg_30_1)
	GuildActivitySPAction.GetCoin()
end

function GuildActivitySPWarFieldView:OnTop()
	if not manager.story.player_ then
		self:GetGuildActivityManager():SetOnWarField(false)
		self:GetGuildActivityManager():SetOnWarField(true)
	end

	self:UpdateBar()
end

function GuildActivitySPWarFieldView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivitySPWarFieldView:UpdateBar()
	local var_33_0, var_33_1 = GuildActivitySpTools.GetCurActivityDescribe()

	if var_33_0 and #var_33_0 > 0 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		})
		manager.windowBar:SetGameHelpKey({
			view = "gameHelpPro",
			type = "jump",
			params = {
				hideHomeBtn = 1,
				pages = var_33_0,
				isPrefab = var_33_1
			}
		})
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end

	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded(SystemLinkCfg[ActivityEntraceCfg[ActivityCfg.get_id_list_by_sub_activity_list[self.params_.activityID][1]].jump_system[1]].link, {
			activityID = ActivityCfg.get_id_list_by_sub_activity_list[self.params_.activityID][1],
			subActivityID = GuildActivitySPData:GetCurMainActivityID()
		})
		GuildActivitySPAction.ExitGuildActivity()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded("/home")
		GuildActivitySPAction.ExitGuildActivity()
	end)
end

function GuildActivitySPWarFieldView:OnEnter()
	manager.ui:SetMainCamera("GuildActivitySP", true, false)

	self.curNodeId = self.params_.nodeID or self.curNodeId
	self.params_.nodeID = nil

	self:AddEventListeners()

	self.curMapIndex_ = self.params_.level or self.curMapIndex_

	self:GetGuildActivityManager():SetOnWarField(true)
	self:UpdateLevelView()
	self:RegisterRedPoint()
	self:StartTimer()
	self:UpdateTimer()
	self:OnGuildActivitySpCheckRateUpgrade()

	local var_36_0 = GuildActivitySPData:GetCurMainActivityID()

	self.currency1Img.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_36_0, 1))
	self.currency2Img.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_36_0, 2))
	self.getCurrencyImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_36_0, 1))

	manager.notify:RegistListener(CHAT_NEW_MESSAGE, self.newMessageHandler_)
	self:ChatNewMessage()
	self:UpdataRedPoint()

	self.curNodeId = self.curNodeId or GuildActivitySPData:GetCurrentGrid()

	if not GuildActivityTools:CheckCanPlayStory(self.curMapIndex_) then
		self:PlayBossNodeAniamtion()
	else
		GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityTools:PlayGuildActivitySpStoryList(handler(self, self.SetNoteState), nil, self.curMapIndex_)
	end
end

function GuildActivitySPWarFieldView:SetNoteState(arg_37_1)
	if not getData("GuildActivitySP", "note") then
		saveData("GuildActivitySP", "note", true)

		local var_37_0, var_37_1 = GuildActivitySpTools.GetCurActivityDescribe()

		JumpTools.OpenPageByJump("gameHelpPro", {
			hideHomeBtn = 1,
			pages = var_37_0,
			isPrefab = var_37_1
		})
	end

	if arg_37_1 then
		self.curNodeId = self.curNodeId or GuildActivitySPData:GetCurrentGrid()

		GuildActivitySPLuaBridge.GetManager():SetOnWarField(true)

		manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

		self:GetGuildActivityManager():SetZoom(1)

		if not self:PlayBossNodeAniamtion() then
			GuildActivitySPLuaBridge.MoveCameraAimAtNode(self.curNodeId)
		end
	end
end

function GuildActivitySPWarFieldView:PlayBossNodeAniamtion()
	local var_38_0 = ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()][self.curMapIndex_]
	local var_38_1, var_38_2 = GuildActivitySPData:GetBigBossNode(var_38_0)
	local var_38_3 = GuildActivitySPData:IsAllLittleBossPass(var_38_0)
	local var_38_4
	local var_38_5 = 1

	if (GuildActivitySPData:HaveBigBossBeKilled(var_38_0) and 1 or 0) == 1 then
		var_38_4 = var_38_0 .. "_" .. var_38_1 .. "dead"
	elseif var_38_5 == 1 then
		var_38_4 = var_38_0 .. "_" .. var_38_1 .. "unlock"
	end

	if var_38_4 then
		if not getData("GuildActivitySP", var_38_4) then
			GuildActivitySPLuaBridge.PlayNodeAnimation(var_38_1, var_38_5 == 1 and 1 or 0, function()
				saveData("GuildActivitySP", var_38_4, 1)
				self:CheckSecondStageTip()
			end, GameDisplayCfg.activity_club_sp_camera_move_time.value[1] / 100)

			return true
		else
			self:CheckSecondStageTip()
		end
	else
		self:CheckSecondStageTip()
	end
end

function GuildActivitySPWarFieldView:CheckSecondStageTip()
	if ActivityData:GetActivityData((GuildActivitySPData:GetCurRunActivityID())).startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() and not getData("GuildActivitySP", "SecondStageTip") then
		saveData("GuildActivitySP", "SecondStageTip", 1)
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips(GuildActivitySpTools.GetCurOpenActivityStateInfo().secondOpen),
			OkCallback = function()
				return
			end
		})
	end
end

function GuildActivitySPWarFieldView:UpdataRedPoint()
	GuildActivitySPAction.UpdataHadAwardRedPoint(self.params_.activityID)
end

function GuildActivitySPWarFieldView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	LeanTween.cancel(manager.ui.mainCameraCom_.gameObject)
	self:GetGuildActivityManager():SetOnWarField(false)
	self:UnRegisterRedPoint()
	self:StopTimer()
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, self.newMessageHandler_)
	manager.ui:ResetMainCamera()
end

function GuildActivitySPWarFieldView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function GuildActivitySPWarFieldView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivitySPWarFieldView:UpdateTimer()
	local var_47_0 = ActivityData:GetActivityData((GuildActivitySPData:GetCurRunActivityID()))

	if var_47_0.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
		self.lastDayTitleLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
		self.lastTimeLabel_.text = manager.time:GetLostTimeStr2(var_47_0.stopTime)
	else
		self.lastDayTitleLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
		self.lastTimeLabel_.text = manager.time:GetLostTimeStr2(var_47_0.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600)
	end

	if GuildActivitySPData:GetTotalCoinToGet() > 0 then
		SetActive(self.allGetBtn_.gameObject, true)
	else
		SetActive(self.allGetBtn_.gameObject, false)
	end
end

function GuildActivitySPWarFieldView:GoToPrevLevel()
	if self.animTimer_ ~= nil then
		return
	end

	self.curMapIndex_ = self.curMapIndex_ - 1

	self:GotoLevel(self.curMapIndex_)
end

function GuildActivitySPWarFieldView:GoToNextLevel()
	if self.animTimer_ ~= nil then
		return
	end

	local var_49_0 = GuildActivitySPData:GetMySpawnNodeId(self.curMapIndex_ + 1)

	if var_49_0 ~= nil then
		if var_49_0 == 0 then
			ShowTips(GuildActivitySpTools.GetCurOpenActivityStateInfo().nextMapLock)

			return
		end
	end

	self.curMapIndex_ = self.curMapIndex_ + 1

	self:GotoLevel(self.curMapIndex_)
end

function GuildActivitySPWarFieldView:OnGuildActivitySpEnterNewLevel()
	if self.animTimer_ ~= nil then
		return
	end

	self.curMapIndex_ = self.curMapIndex_ + 1

	self:GotoLevel(self.curMapIndex_)
end

local var_0_1

function GuildActivitySPWarFieldView:GotoLevel(arg_51_1)
	if not self:IsTop() then
		gameContext:Back()
	end

	var_0_1 = arg_51_1

	SetActive(self.cloudGo_, true)

	self.animTimer_ = 1

	AnimatorTools.PlayAnimationWithCallback(self.cloudAnimator_, "cloud", function()
		SetActive(self.cloudGo_, false)

		self.animTimer_ = nil

		if GuildActivityTools:CheckCanPlayStory(self.curMapIndex_) then
			GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)
			GuildActivityTools:PlayGuildActivitySpStoryList(handler(self, self.SetNoteState), nil, self.curMapIndex_)
		end
	end)
	self.cloudAnimator_:Play("cloud", -1, 0)
end

function GuildActivitySPWarFieldView:OnEnterNewLevel()
	self:GetGuildActivityManager():LoadLevel(var_0_1, (GuildActivitySPData:GetCurMainActivityID()))

	self.params_.level = var_0_1
end

function GuildActivitySPWarFieldView:UpdateLevelView()
	self.mapNameLabel_.text = ActivityClubSPMapCfg[ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()][self.curMapIndex_]].map_name

	SetActive(self.leftBtn_.gameObject, true)
	SetActive(self.rightBtn_.gameObject, true)

	if self.curMapIndex_ == 1 then
		SetActive(self.leftBtn_.gameObject, false)
	end

	if self.curMapIndex_ == #ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()] then
		SetActive(self.rightBtn_.gameObject, false)
	end

	self.footPrintLabel_.text = string.format("%d/%d", GuildActivitySPData:GetDispatchCatNum(), #GuildActivitySPData:GetCanDispatchCatList())

	local var_54_0 = GuildActivitySPData:GetCurMainActivityID()

	self.profitLabel_.text = string.format("%d(+%d/%s)", ItemTools.getItemNum((GuildActivitySpTools.GetCurCurrencyID(var_54_0, 1))), GuildActivitySPData:GetCoinGain(), GetTips("HOUR"))
	self.profit2Label_.text = ItemTools.getItemNum((GuildActivitySpTools.GetCurCurrencyID(var_54_0, 2)))

	self:UpdateRightBtn()
end

function GuildActivitySPWarFieldView:UpdateRightBtn()
	local var_55_0 = GuildActivitySPData:GetMySpawnNodeId(self.curMapIndex_ + 1)

	if self.curMapIndex_ == #ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()] then
		self.hideLockController_:SetSelectedState("true")
	elseif var_55_0 == nil or var_55_0 == 0 then
		self.hideLockController_:SetSelectedState("false")
	else
		self.hideLockController_:SetSelectedState("true")
	end
end

function GuildActivitySPWarFieldView:OnMainHomeViewTop()
	return
end

function GuildActivitySPWarFieldView:GetGuildActivityManager()
	return GuildActivitySPLuaBridge.GetManager()
end

function GuildActivitySPWarFieldView:Dispose()
	self.newMessageHandler_ = nil

	self.mapSlider_.onValueChanged:RemoveAllListeners()
	self:GetGuildActivityManager():SetOnZoomByFingerHandler(nil)

	if self.timer_ then
		self.timer_:Dispose()

		self.timer_ = nil
	end

	self:StopTimer()
	GuildActivitySPWarFieldView.super.Dispose(self)
end

function GuildActivitySPWarFieldView:RegisterRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_BONUS, self.params_.activityID))
	manager.redPoint:bindUIandKey(self.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, self.params_.activityID))
	manager.redPoint:bindUIandKey(self.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, self.params_.activityID))
end

function GuildActivitySPWarFieldView:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_BONUS, self.params_.activityID))
	manager.redPoint:unbindUIandKey(self.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, self.params_.activityID))
	manager.redPoint:unbindUIandKey(self.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, self.params_.activityID))
end

function GuildActivitySPWarFieldView:OnGuildActivitySpCheckRateUpgrade()
	local var_61_0, var_61_1 = GuildActivitySPData:CheckRateUpgrade(self.params_.activityID)

	if var_61_0 == true then
		JumpTools.OpenPageByJump("guildActivitySPRateUpgrad", {
			rateID = var_61_1
		})
		GuildActivitySPData:RefreshRateRedPoint(self.params_.activityID)
		self:UpdateLevelView()
	end
end

function GuildActivitySPWarFieldView:ChatNewMessage()
	local var_62_0 = ChatChannelData:GetCacheContent(GuildActivitySpTools.GetCurOpenActivityStateInfo().chatToggleID)

	if #var_62_0 > 0 then
		self.chatTextExtension_:SetText(string.format("%s:%s", var_62_0[#var_62_0].nick, (var_62_0[#var_62_0].contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER or nil) and string.format("[%s]", ChatStickerCfg[tonumber(var_62_0[#var_62_0].content)].name)))
	else
		self.chatText_.text = ""
	end
end

return GuildActivitySPWarFieldView
