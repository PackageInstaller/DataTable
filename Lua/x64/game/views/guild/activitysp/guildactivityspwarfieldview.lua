local var_0_0 = class("GuildActivitySPWarFieldView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivitySPUI/GuildActivitySPWarFieldUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()

	arg_4_0.newMessageHandler_ = handler(arg_4_0, arg_4_0.ChatNewMessage)
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.hideLockController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "canNext")
	arg_5_0.chatTextExtension_ = arg_5_0.chatText_:GetComponent(typeof(TextExtension))
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		arg_7_0:GetGuildActivityManager():SetZoom(arg_7_0.mapSlider_.value)
	end))
	arg_7_0:GetGuildActivityManager():SetOnZoomByFingerHandler(handler(arg_7_0, arg_7_0.OnZoomChangeByFinger))
	arg_7_0:GetGuildActivityManager():SetOnNodeClick(handler(arg_7_0, arg_7_0.OnNodeClick))
	arg_7_0:GetGuildActivityManager():SetOnBonusClick(handler(arg_7_0, arg_7_0.OnBonusNodeClick))
	arg_7_0:GetGuildActivityManager():SetOnBgClick(handler(arg_7_0, arg_7_0.OnBgClick))
	arg_7_0:GetGuildActivityManager():SetOnLevelLoaded(handler(arg_7_0, arg_7_0.OnLevelLoaded))
	arg_7_0:AddBtnListener(arg_7_0.allGetBtn_, nil, function()
		GuildActivitySPAction.GetCoin()
	end)
	arg_7_0:AddBtnListener(arg_7_0.leftBtn_, nil, function()
		arg_7_0:GoToPrevLevel()
	end)
	arg_7_0:AddBtnListener(arg_7_0.rightBtn_, nil, function()
		arg_7_0:GoToNextLevel()
	end)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivitySPReward", {
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.ratingBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivitySPRate", {
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.setupBtn_, nil, function()
		JumpTools.OpenPageByJump("guildActivitySPFightHeroSetting", {
			isEnter = true,
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.talentBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		arg_7_0:Go("/guildActivitySPAffixMain", {
			activityID = arg_7_0.params_.activityID
		})

		local var_15_0 = GuildActivitySPData:GetCurRunActivityID()

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, var_15_0), 0)
	end)
	arg_7_0:AddBtnListener(arg_7_0.storeBtn_, nil, function()
		local var_16_0 = {}
		local var_16_1 = GuildActivitySPData:GetCurMainActivityID()
		local var_16_2 = GuildActivitySpTools.GetCurActivityIDInfo(var_16_1).shopID
		local var_16_3 = ShopListCfg[var_16_2].display_group

		for iter_16_0, iter_16_1 in ipairs(ShopListCfg.all) do
			if ShopListCfg[iter_16_1].display_group == var_16_3 then
				table.insert(var_16_0, iter_16_1)
			end
		end

		JumpTools.GoToSystem("/activityShop", {
			hideHomeBtn = 1,
			shopId = var_16_2,
			showShops = var_16_0
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_7_0:AddBtnListener(arg_7_0.chatBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		local var_17_0 = GuildActivitySpTools.GetCurOpenActivityStateInfo().chatToggleID

		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = var_17_0
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
	arg_7_0:AddBtnListener(arg_7_0.currencyBtn_, nil, function()
		local var_18_0 = GuildActivitySPData:GetCurMainActivityID()
		local var_18_1 = GuildActivitySpTools.GetCurCurrencyID(var_18_0, 1)

		if var_18_1 then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_18_1
			})
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.currency2Btn_, nil, function()
		local var_19_0 = GuildActivitySPData:GetCurMainActivityID()
		local var_19_1 = GuildActivitySpTools.GetCurCurrencyID(var_19_0, 2)

		if var_19_1 then
			ShowPopItem(POP_SOURCE_ITEM, {
				var_19_1
			})
		end
	end)
end

function var_0_0.AddEventListeners(arg_20_0)
	arg_20_0:RegistEventListener(MATERIAL_MODIFY, function(arg_21_0)
		local var_21_0 = GuildActivitySPData:GetCurMainActivityID()
		local var_21_1 = GuildActivitySpTools.GetCurCurrencyID(var_21_0, 1)
		local var_21_2 = GuildActivitySpTools.GetCurCurrencyID(var_21_0, 2)

		if arg_21_0 == var_21_1 or arg_21_0 == var_21_2 then
			arg_20_0:UpdateLevelView()
		end
	end)
	arg_20_0:RegistEventListener(GUILD_ACTIVITY_SP_DISPATCHED, function()
		arg_20_0:UpdateLevelView()
	end)
	arg_20_0:RegistEventListener(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, function()
		arg_20_0:UpdateLevelView()
	end)
	arg_20_0:RegistEventListener(GUILD_ACTIVITY_SP_SPAWN_ID_UPDATE, function()
		arg_20_0:UpdateRightBtn()
	end)
	arg_20_0:RegistEventListener(GUILD_ACTIVITY_SP_COIN_GET_FINISH, function()
		arg_20_0:UpdateLevelView()
		arg_20_0.currencyAnimator_:Play("currency", -1, 0)
	end)
end

function var_0_0.OnZoomChangeByFinger(arg_26_0, arg_26_1)
	arg_26_0.mapSlider_.value = arg_26_1
end

function var_0_0.OnBgClick(arg_27_0)
	local var_27_0 = gameContext.routes_[#gameContext.routes_]

	if var_27_0 == "guildActivitySPNormalPop" or var_27_0 == "guildActivitySPElitePop" or var_27_0 == "guildActivitySPBossPop" or var_27_0 == "guildActivitySPSmallBossPop" then
		gameContext:Back()
	end
end

function var_0_0.OnLevelLoaded(arg_28_0, arg_28_1)
	arg_28_0.curMapIndex_ = arg_28_1

	arg_28_0:UpdateLevelView()
end

function var_0_0.OnNodeClick(arg_29_0, arg_29_1)
	arg_29_0.curNodeId = arg_29_1

	local var_29_0 = ActivityClubSPCfg[arg_29_1]

	if not var_29_0 then
		CustomLog.Log(debug.traceback(string.format("找不到指定id为节点：%d", arg_29_1)))

		return
	end

	if not arg_29_0:IsTop() then
		gameContext:Back()
	end

	if arg_29_0.animTimer_ ~= nil then
		return
	end

	if var_29_0.type == 0 then
		-- block empty
	elseif var_29_0.type == 1 then
		JumpTools.OpenPageByJump("guildActivitySPNormalPop", {
			nodeId = arg_29_1
		})
	elseif var_29_0.type == 2 then
		JumpTools.OpenPageByJump("guildActivitySPElitePop", {
			nodeId = arg_29_1
		})
	elseif var_29_0.type == 3 then
		JumpTools.OpenPageByJump("guildActivitySPSmallBossPop", {
			nodeId = arg_29_1
		})
	elseif var_29_0.type == 4 then
		JumpTools.OpenPageByJump("guildActivitySPBossPop", {
			nodeId = arg_29_1
		})
	end
end

function var_0_0.OnBonusNodeClick(arg_30_0, arg_30_1)
	GuildActivitySPAction.GetCoin()
end

function var_0_0.OnTop(arg_31_0)
	if not manager.story.player_ then
		arg_31_0:GetGuildActivityManager():SetOnWarField(false)
		arg_31_0:GetGuildActivityManager():SetOnWarField(true)
	end

	arg_31_0:UpdateBar()
end

function var_0_0.OnBehind(arg_32_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_33_0)
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

		local var_34_0 = ActivityCfg.get_id_list_by_sub_activity_list[arg_33_0.params_.activityID][1]
		local var_34_1 = ActivityEntraceCfg[var_34_0].jump_system[1]
		local var_34_2 = SystemLinkCfg[var_34_1].link
		local var_34_3 = GuildActivitySPData:GetCurMainActivityID()

		JumpTools.OpenPageUntilLoaded(var_34_2, {
			activityID = var_34_0,
			subActivityID = var_34_3
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

function var_0_0.OnEnter(arg_36_0)
	manager.ui:SetMainCamera("GuildActivitySP", true, false)

	arg_36_0.curNodeId = arg_36_0.params_.nodeID or arg_36_0.curNodeId
	arg_36_0.params_.nodeID = nil

	arg_36_0:AddEventListeners()

	arg_36_0.curMapIndex_ = arg_36_0.params_.level or arg_36_0.curMapIndex_

	arg_36_0:GetGuildActivityManager():SetOnWarField(true)
	arg_36_0:UpdateLevelView()
	arg_36_0:RegisterRedPoint()
	arg_36_0:StartTimer()
	arg_36_0:UpdateTimer()
	arg_36_0:OnGuildActivitySpCheckRateUpgrade()

	local var_36_0 = GuildActivitySPData:GetCurMainActivityID()

	arg_36_0.currency1Img.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_36_0, 1))
	arg_36_0.currency2Img.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_36_0, 2))
	arg_36_0.getCurrencyImg.sprite = ItemTools.getItemSprite(GuildActivitySpTools.GetCurCurrencyID(var_36_0, 1))

	manager.notify:RegistListener(CHAT_NEW_MESSAGE, arg_36_0.newMessageHandler_)
	arg_36_0:ChatNewMessage()
	arg_36_0:UpdataRedPoint()

	arg_36_0.curNodeId = arg_36_0.curNodeId or GuildActivitySPData:GetCurrentGrid()

	if not GuildActivityTools:CheckCanPlayStory(arg_36_0.curMapIndex_) then
		arg_36_0:PlayBossNodeAniamtion()
	else
		GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)
		GuildActivityTools:PlayGuildActivitySpStoryList(handler(arg_36_0, arg_36_0.SetNoteState), nil, arg_36_0.curMapIndex_)
	end
end

function var_0_0.SetNoteState(arg_37_0, arg_37_1)
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
		arg_37_0.curNodeId = arg_37_0.curNodeId or GuildActivitySPData:GetCurrentGrid()

		GuildActivitySPLuaBridge.GetManager():SetOnWarField(true)

		manager.ui.mainCamera:GetComponent("CameraExtension").shadowRotationImmediately = true

		arg_37_0:GetGuildActivityManager():SetZoom(1)

		if not arg_37_0:PlayBossNodeAniamtion() then
			GuildActivitySPLuaBridge.MoveCameraAimAtNode(arg_37_0.curNodeId)
		end
	end
end

function var_0_0.PlayBossNodeAniamtion(arg_38_0)
	local var_38_0 = GuildActivitySPData:GetCurRunActivityID()
	local var_38_1 = ActivityClubSPMapCfg.get_id_list_by_activity[var_38_0][arg_38_0.curMapIndex_]
	local var_38_2, var_38_3 = GuildActivitySPData:GetBigBossNode(var_38_1)
	local var_38_4 = GuildActivitySPData:HaveBigBossBeKilled(var_38_1) and 1 or 0
	local var_38_5 = GuildActivitySPData:IsAllLittleBossPass(var_38_1)
	local var_38_6
	local var_38_7 = 1

	if var_38_4 == 1 then
		var_38_6 = var_38_1 .. "_" .. var_38_2 .. "dead"
	elseif var_38_7 == 1 then
		var_38_6 = var_38_1 .. "_" .. var_38_2 .. "unlock"
	end

	if var_38_6 then
		if not getData("GuildActivitySP", var_38_6) then
			local var_38_8 = 0
			local var_38_9 = var_38_7 == 1 and 1 or 0

			GuildActivitySPLuaBridge.PlayNodeAnimation(var_38_2, var_38_9, function()
				saveData("GuildActivitySP", var_38_6, 1)
				arg_38_0:CheckSecondStageTip()
			end, GameDisplayCfg.activity_club_sp_camera_move_time.value[1] / 100)

			return true
		else
			arg_38_0:CheckSecondStageTip()
		end
	else
		arg_38_0:CheckSecondStageTip()
	end
end

function var_0_0.CheckSecondStageTip(arg_40_0)
	local var_40_0 = manager.time:GetServerTime()
	local var_40_1 = GuildActivitySPData:GetCurRunActivityID()
	local var_40_2 = ActivityData:GetActivityData(var_40_1)
	local var_40_3 = var_40_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
	local var_40_4 = var_40_2.stopTime

	if var_40_3 < var_40_0 and not getData("GuildActivitySP", "SecondStageTip") then
		saveData("GuildActivitySP", "SecondStageTip", 1)

		local var_40_5 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips(var_40_5.secondOpen),
			OkCallback = function()
				return
			end
		})
	end
end

function var_0_0.UpdataRedPoint(arg_42_0)
	GuildActivitySPAction.UpdataHadAwardRedPoint(arg_42_0.params_.activityID)
end

function var_0_0.OnExit(arg_43_0)
	arg_43_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	LeanTween.cancel(manager.ui.mainCameraCom_.gameObject)
	arg_43_0:GetGuildActivityManager():SetOnWarField(false)
	arg_43_0:UnRegisterRedPoint()
	arg_43_0:StopTimer()
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, arg_43_0.newMessageHandler_)
	manager.ui:ResetMainCamera()
end

function var_0_0.StartTimer(arg_44_0)
	if arg_44_0.timer_ == nil then
		arg_44_0.timer_ = Timer.New(function()
			arg_44_0:UpdateTimer()
		end, 1, -1)
	end

	arg_44_0.timer_:Start()
end

function var_0_0.StopTimer(arg_46_0)
	if arg_46_0.timer_ then
		arg_46_0.timer_:Stop()

		arg_46_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_47_0)
	local var_47_0 = manager.time:GetServerTime()
	local var_47_1 = GuildActivitySPData:GetCurRunActivityID()
	local var_47_2 = ActivityData:GetActivityData(var_47_1)
	local var_47_3 = var_47_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
	local var_47_4 = var_47_2.stopTime

	if var_47_3 < var_47_0 then
		arg_47_0.lastDayTitleLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP2"))
		arg_47_0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(var_47_4)
	else
		arg_47_0.lastDayTitleLabel_.text = string.format(GetTips("ACTIVITY_CLUB_SP_LAST_TIME_TIP1"))
		arg_47_0.lastTimeLabel_.text = manager.time:GetLostTimeStr2(var_47_3)
	end

	if GuildActivitySPData:GetTotalCoinToGet() > 0 then
		SetActive(arg_47_0.allGetBtn_.gameObject, true)
	else
		SetActive(arg_47_0.allGetBtn_.gameObject, false)
	end
end

function var_0_0.GoToPrevLevel(arg_48_0)
	if arg_48_0.animTimer_ ~= nil then
		return
	end

	arg_48_0.curMapIndex_ = arg_48_0.curMapIndex_ - 1

	arg_48_0:GotoLevel(arg_48_0.curMapIndex_)
end

function var_0_0.GoToNextLevel(arg_49_0)
	if arg_49_0.animTimer_ ~= nil then
		return
	end

	local var_49_0 = GuildActivitySPData:GetMySpawnNodeId(arg_49_0.curMapIndex_ + 1)

	if var_49_0 == nil or var_49_0 == 0 then
		local var_49_1 = GuildActivitySpTools.GetCurOpenActivityStateInfo()

		ShowTips(var_49_1.nextMapLock)

		return
	end

	arg_49_0.curMapIndex_ = arg_49_0.curMapIndex_ + 1

	arg_49_0:GotoLevel(arg_49_0.curMapIndex_)
end

function var_0_0.OnGuildActivitySpEnterNewLevel(arg_50_0)
	if arg_50_0.animTimer_ ~= nil then
		return
	end

	arg_50_0.curMapIndex_ = arg_50_0.curMapIndex_ + 1

	arg_50_0:GotoLevel(arg_50_0.curMapIndex_)
end

local var_0_1

function var_0_0.GotoLevel(arg_51_0, arg_51_1)
	if not arg_51_0:IsTop() then
		gameContext:Back()
	end

	var_0_1 = arg_51_1

	SetActive(arg_51_0.cloudGo_, true)

	arg_51_0.animTimer_ = 1

	AnimatorTools.PlayAnimationWithCallback(arg_51_0.cloudAnimator_, "cloud", function()
		SetActive(arg_51_0.cloudGo_, false)

		arg_51_0.animTimer_ = nil

		if GuildActivityTools:CheckCanPlayStory(arg_51_0.curMapIndex_) then
			GuildActivitySPLuaBridge.GetManager():SetOnWarField(false)
			GuildActivityTools:PlayGuildActivitySpStoryList(handler(arg_51_0, arg_51_0.SetNoteState), nil, arg_51_0.curMapIndex_)
		end
	end)
	arg_51_0.cloudAnimator_:Play("cloud", -1, 0)
end

function var_0_0.OnEnterNewLevel(arg_53_0)
	local var_53_0 = GuildActivitySPData:GetCurMainActivityID()

	arg_53_0:GetGuildActivityManager():LoadLevel(var_0_1, var_53_0)

	arg_53_0.params_.level = var_0_1
end

function var_0_0.UpdateLevelView(arg_54_0)
	local var_54_0 = GuildActivitySPData:GetCurRunActivityID()
	local var_54_1 = ActivityClubSPMapCfg.get_id_list_by_activity[var_54_0][arg_54_0.curMapIndex_]

	arg_54_0.mapNameLabel_.text = ActivityClubSPMapCfg[var_54_1].map_name

	SetActive(arg_54_0.leftBtn_.gameObject, true)
	SetActive(arg_54_0.rightBtn_.gameObject, true)

	if arg_54_0.curMapIndex_ == 1 then
		SetActive(arg_54_0.leftBtn_.gameObject, false)
	end

	local var_54_2 = GuildActivitySPData:GetCurRunActivityID()
	local var_54_3 = ActivityClubSPMapCfg.get_id_list_by_activity[var_54_2]

	if arg_54_0.curMapIndex_ == #var_54_3 then
		SetActive(arg_54_0.rightBtn_.gameObject, false)
	end

	arg_54_0.footPrintLabel_.text = string.format("%d/%d", GuildActivitySPData:GetDispatchCatNum(), #GuildActivitySPData:GetCanDispatchCatList())

	local var_54_4 = GuildActivitySPData:GetCurMainActivityID()
	local var_54_5 = GuildActivitySpTools.GetCurCurrencyID(var_54_4, 1)
	local var_54_6 = ItemTools.getItemNum(var_54_5)

	arg_54_0.profitLabel_.text = string.format("%d(+%d/%s)", var_54_6, GuildActivitySPData:GetCoinGain(), GetTips("HOUR"))

	local var_54_7 = GuildActivitySpTools.GetCurCurrencyID(var_54_4, 2)

	arg_54_0.profit2Label_.text = ItemTools.getItemNum(var_54_7)

	arg_54_0:UpdateRightBtn()
end

function var_0_0.UpdateRightBtn(arg_55_0)
	local var_55_0 = GuildActivitySPData:GetMySpawnNodeId(arg_55_0.curMapIndex_ + 1)
	local var_55_1 = GuildActivitySPData:GetCurRunActivityID()
	local var_55_2 = ActivityClubSPMapCfg.get_id_list_by_activity[var_55_1]

	if arg_55_0.curMapIndex_ == #var_55_2 then
		arg_55_0.hideLockController_:SetSelectedState("true")
	elseif var_55_0 == nil or var_55_0 == 0 then
		arg_55_0.hideLockController_:SetSelectedState("false")
	else
		arg_55_0.hideLockController_:SetSelectedState("true")
	end
end

function var_0_0.OnMainHomeViewTop(arg_56_0)
	return
end

function var_0_0.GetGuildActivityManager(arg_57_0)
	return GuildActivitySPLuaBridge.GetManager()
end

function var_0_0.Dispose(arg_58_0)
	arg_58_0.newMessageHandler_ = nil

	arg_58_0.mapSlider_.onValueChanged:RemoveAllListeners()
	arg_58_0:GetGuildActivityManager():SetOnZoomByFingerHandler(nil)

	if arg_58_0.timer_ then
		arg_58_0.timer_:Dispose()

		arg_58_0.timer_ = nil
	end

	arg_58_0:StopTimer()
	var_0_0.super.Dispose(arg_58_0)
end

function var_0_0.RegisterRedPoint(arg_59_0)
	manager.redPoint:bindUIandKey(arg_59_0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_BONUS, arg_59_0.params_.activityID))
	manager.redPoint:bindUIandKey(arg_59_0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, arg_59_0.params_.activityID))
	manager.redPoint:bindUIandKey(arg_59_0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, arg_59_0.params_.activityID))
end

function var_0_0.UnRegisterRedPoint(arg_60_0)
	manager.redPoint:unbindUIandKey(arg_60_0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_BONUS, arg_60_0.params_.activityID))
	manager.redPoint:unbindUIandKey(arg_60_0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX_OUT, arg_60_0.params_.activityID))
	manager.redPoint:unbindUIandKey(arg_60_0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_ON_FIGHT_NOT_FULL, arg_60_0.params_.activityID))
end

function var_0_0.OnGuildActivitySpCheckRateUpgrade(arg_61_0)
	local var_61_0, var_61_1 = GuildActivitySPData:CheckRateUpgrade(arg_61_0.params_.activityID)

	if var_61_0 == true then
		JumpTools.OpenPageByJump("guildActivitySPRateUpgrad", {
			rateID = var_61_1
		})
		GuildActivitySPData:RefreshRateRedPoint(arg_61_0.params_.activityID)
		arg_61_0:UpdateLevelView()
	end
end

function var_0_0.ChatNewMessage(arg_62_0)
	local var_62_0 = GuildActivitySpTools.GetCurOpenActivityStateInfo().chatToggleID
	local var_62_1 = ChatChannelData:GetCacheContent(var_62_0)

	if #var_62_1 > 0 then
		local var_62_2 = var_62_1[#var_62_1]
		local var_62_3 = var_62_2.content

		if var_62_2.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_62_3 = string.format("[%s]", ChatStickerCfg[tonumber(var_62_2.content)].name)
		end

		arg_62_0.chatTextExtension_:SetText(string.format("%s:%s", var_62_2.nick, var_62_3))
	else
		arg_62_0.chatText_.text = ""
	end
end

return var_0_0
