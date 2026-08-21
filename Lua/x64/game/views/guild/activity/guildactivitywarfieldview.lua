local var_0_0 = class("GuildActivityWarFieldView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/GuildActivityUI/GuildActivityWarFieldUI"
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
		GuildActivityAction.GetCoin()
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

		JumpTools.OpenPageByJump("guildActivityReward", {
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.ratingBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivityRate", {
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.setupBtn_, nil, function()
		JumpTools.OpenPageByJump("guildActivityFightHeroSetting", {
			isEnter = true,
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.talentBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		arg_7_0:Go("/guildActivityAffixMain", {
			activityID = arg_7_0.params_.activityID
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.chatBtn_, nil, function()
		if not arg_7_0:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function var_0_0.AddEventListeners(arg_17_0)
	arg_17_0:RegistEventListener(MATERIAL_MODIFY, function(arg_18_0)
		if arg_18_0 == MaterialConst.GUILD_ACTIVITY_COIN then
			arg_17_0:UpdateLevelView()
		end
	end)
	arg_17_0:RegistEventListener(SPAWN_ID_UPDATE, function()
		arg_17_0:UpdateRightBtn()
	end)
	arg_17_0:RegistEventListener(GUILD_ACTIVITY_COIN_GET_FINISH, function()
		arg_17_0.currencyAnimator_:Play("currency", -1, 0)
	end)
end

function var_0_0.OnZoomChangeByFinger(arg_21_0, arg_21_1)
	arg_21_0.mapSlider_.value = arg_21_1
end

function var_0_0.OnBgClick(arg_22_0)
	local var_22_0 = gameContext.routes_[#gameContext.routes_]

	if var_22_0 == "guildActivityNormalPop" or var_22_0 == "guildActivityElitePop" or var_22_0 == "guildActivityBossPop" then
		gameContext:Back()
	end
end

function var_0_0.OnLevelLoaded(arg_23_0, arg_23_1)
	arg_23_0.curMapIndex_ = arg_23_1

	arg_23_0:UpdateLevelView()
end

function var_0_0.OnNodeClick(arg_24_0, arg_24_1)
	local var_24_0 = ActivityClubCfg[arg_24_1]

	if not arg_24_0:IsTop() then
		gameContext:Back()
	end

	if arg_24_0.animTimer_ ~= nil then
		return
	end

	if var_24_0.type == 0 then
		-- block empty
	elseif var_24_0.type == 1 then
		JumpTools.OpenPageByJump("guildActivityNormalPop", {
			nodeId = arg_24_1
		})
	elseif var_24_0.type == 2 then
		JumpTools.OpenPageByJump("guildActivityElitePop", {
			nodeId = arg_24_1
		})
	elseif var_24_0.type == 3 then
		JumpTools.OpenPageByJump("guildActivityBossPop", {
			nodeId = arg_24_1
		})
	end
end

function var_0_0.OnBonusNodeClick(arg_25_0, arg_25_1)
	GuildActivityAction.GetCoin()
end

function var_0_0.OnTop(arg_26_0)
	arg_26_0:GetGuildActivityManager():SetOnWarField(false)
	arg_26_0:GetGuildActivityManager():SetOnWarField(true)
	arg_26_0:UpdateBar()
end

function var_0_0.OnBehind(arg_27_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_28_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = {
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_01",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_02",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_03",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_04",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_05",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_06",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_07",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_08"
			}
		}
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded("/thirdVolumePart2Main")
		GuildActivityAction.ExitGuildActivity()
	end)
	manager.windowBar:RegistHomeCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
		JumpTools.OpenPageUntilLoaded("/home")
		GuildActivityAction.ExitGuildActivity()
	end)
end

function var_0_0.OnEnter(arg_31_0)
	arg_31_0:AddEventListeners()

	arg_31_0.curMapIndex_ = arg_31_0.params_.level

	arg_31_0:GetGuildActivityManager():SetOnWarField(true)
	arg_31_0:UpdateLevelView()
	arg_31_0:RegisterRedPoint()
	arg_31_0:StartTimer()
	arg_31_0:UpdateTimer()
	arg_31_0:OnCheckRateUpgrade()
	manager.notify:RegistListener(CHAT_NEW_MESSAGE, arg_31_0.newMessageHandler_)
	arg_31_0:ChatNewMessage()

	if not getData("GuildActivity", "note") then
		saveData("GuildActivity", "note", true)
		JumpTools.OpenPageByJump("gameHelpPro", {
			pages = {
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_01",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_02",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_03",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_04",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_05",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_06",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_07",
				"TextureConfig/GuildActivitiesUI/note/activity_club_courses_08"
			}
		})
	end

	arg_31_0:RefreshBossSprite()
end

function var_0_0.OnExit(arg_32_0)
	arg_32_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
	LeanTween.cancel(manager.ui.mainCameraCom_.gameObject)
	arg_32_0:GetGuildActivityManager():SetOnWarField(false)
	arg_32_0:UnRegisterRedPoint()
	arg_32_0:StopTimer()
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, arg_32_0.newMessageHandler_)
	manager.ui:ResetMainCamera()
end

function var_0_0.StartTimer(arg_33_0)
	if arg_33_0.timer_ == nil then
		arg_33_0.timer_ = Timer.New(function()
			arg_33_0:UpdateTimer()
		end, 1, -1)
	end

	arg_33_0.timer_:Start()
end

function var_0_0.StopTimer(arg_35_0)
	if arg_35_0.timer_ then
		arg_35_0.timer_:Stop()

		arg_35_0.timer_ = nil
	end
end

function var_0_0.UpdateTimer(arg_36_0)
	local var_36_0 = ActivityData:GetActivityData(ActivityConst.GUILD_ACTIVITY_START)
	local var_36_1 = var_36_0.startTime
	local var_36_2 = var_36_0.stopTime

	arg_36_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_36_2)

	if GuildActivityData:GetTotalCoinToGet() > 0 then
		SetActive(arg_36_0.allGetBtn_.gameObject, true)
	else
		SetActive(arg_36_0.allGetBtn_.gameObject, false)
	end
end

function var_0_0.GoToPrevLevel(arg_37_0)
	if arg_37_0.animTimer_ ~= nil then
		return
	end

	arg_37_0.curMapIndex_ = arg_37_0.curMapIndex_ - 1

	arg_37_0:GotoLevel(arg_37_0.curMapIndex_)
end

function var_0_0.GoToNextLevel(arg_38_0)
	if arg_38_0.animTimer_ ~= nil then
		return
	end

	local var_38_0 = GuildActivityData:GetMySpawnNodeId(arg_38_0.curMapIndex_ + 1)

	if var_38_0 == nil or var_38_0 == 0 then
		ShowTips("ACTIVITY_CLUB_NEXT_MAP_LOCK_TIP")

		return
	end

	arg_38_0.curMapIndex_ = arg_38_0.curMapIndex_ + 1

	arg_38_0:GotoLevel(arg_38_0.curMapIndex_)
end

function var_0_0.OnGuildActivityEnterNewLevel(arg_39_0)
	if arg_39_0.animTimer_ ~= nil then
		return
	end

	arg_39_0.curMapIndex_ = arg_39_0.curMapIndex_ + 1

	arg_39_0:GotoLevel(arg_39_0.curMapIndex_)
end

local var_0_1

function var_0_0.GotoLevel(arg_40_0, arg_40_1)
	if not arg_40_0:IsTop() then
		gameContext:Back()
	end

	var_0_1 = arg_40_1

	SetActive(arg_40_0.cloudGo_, true)

	arg_40_0.animTimer_ = 1

	AnimatorTools.PlayAnimationWithCallback(arg_40_0.cloudAnimator_, "cloud", function()
		SetActive(arg_40_0.cloudGo_, false)

		arg_40_0.animTimer_ = nil
	end)
	arg_40_0.cloudAnimator_:Play("cloud", -1, 0)
end

function var_0_0.OnEnterNewLevel(arg_42_0)
	arg_42_0:GetGuildActivityManager():LoadLevel(var_0_1)

	arg_42_0.params_.level = var_0_1
end

function var_0_0.UpdateLevelView(arg_43_0)
	local var_43_0 = ActivityClubMapCfg.all[arg_43_0.curMapIndex_]

	arg_43_0.mapNameLabel_.text = GetI18NText(ActivityClubMapCfg[var_43_0].map_name)

	SetActive(arg_43_0.leftBtn_.gameObject, true)
	SetActive(arg_43_0.rightBtn_.gameObject, true)

	if arg_43_0.curMapIndex_ == 1 then
		SetActive(arg_43_0.leftBtn_.gameObject, false)
	end

	if arg_43_0.curMapIndex_ == #ActivityClubMapCfg.all then
		SetActive(arg_43_0.rightBtn_.gameObject, false)
	end

	arg_43_0.footPrintLabel_.text = string.format("%d/%d", GuildActivityData:GetMyOccupiedNum(), GuildActivityData:GetMaxOccupyCount())

	local var_43_1 = ItemTools.getItemNum(MaterialConst.GUILD_ACTIVITY_COIN)

	arg_43_0.profitLabel_.text = string.format("%d(+%d/%s)", var_43_1, GuildActivityData:GetCoinGain(), GetTips("HOUR"))

	arg_43_0:UpdateRightBtn()
end

function var_0_0.UpdateRightBtn(arg_44_0)
	local var_44_0 = GuildActivityData:GetMySpawnNodeId(arg_44_0.curMapIndex_ + 1)

	if arg_44_0.curMapIndex_ == #ActivityClubMapCfg.all then
		arg_44_0.hideLockController_:SetSelectedState("true")
	elseif var_44_0 == nil or var_44_0 == 0 then
		arg_44_0.hideLockController_:SetSelectedState("false")
	else
		arg_44_0.hideLockController_:SetSelectedState("true")
	end
end

function var_0_0.OnMainHomeViewTop(arg_45_0)
	return
end

function var_0_0.GetGuildActivityManager(arg_46_0)
	return GuildActivityLuaBridge.GetManager()
end

function var_0_0.Dispose(arg_47_0)
	arg_47_0.newMessageHandler_ = nil

	arg_47_0.mapSlider_.onValueChanged:RemoveAllListeners()
	arg_47_0:GetGuildActivityManager():SetOnZoomByFingerHandler(nil)

	if arg_47_0.timer_ then
		arg_47_0.timer_:Dispose()

		arg_47_0.timer_ = nil
	end

	arg_47_0:StopTimer()
	var_0_0.super.Dispose(arg_47_0)
end

function var_0_0.RegisterRedPoint(arg_48_0)
	manager.redPoint:bindUIandKey(arg_48_0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, arg_48_0.params_.activityID))
	manager.redPoint:bindUIandKey(arg_48_0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_48_0.params_.activityID))
	manager.redPoint:bindUIandKey(arg_48_0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, arg_48_0.params_.activityID))
end

function var_0_0.UnRegisterRedPoint(arg_49_0)
	manager.redPoint:unbindUIandKey(arg_49_0.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, arg_49_0.params_.activityID))
	manager.redPoint:unbindUIandKey(arg_49_0.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_49_0.params_.activityID))
	manager.redPoint:unbindUIandKey(arg_49_0.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, arg_49_0.params_.activityID))
end

function var_0_0.OnCheckRateUpgrade(arg_50_0)
	local var_50_0, var_50_1 = GuildActivityData:CheckRateUpgrade(arg_50_0.params_.activityID)

	if var_50_0 == true then
		JumpTools.OpenPageByJump("guildActivityRateUpgrad", {
			rateID = var_50_1
		})
		GuildActivityData:RefreshRateRedPoint(arg_50_0.params_.activityID)
		arg_50_0:UpdateLevelView()
	end
end

function var_0_0.ChatNewMessage(arg_51_0)
	local var_51_0 = ChatChannelData:GetCacheContent(ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY)

	if #var_51_0 > 0 then
		local var_51_1 = var_51_0[#var_51_0]
		local var_51_2 = var_51_1.content

		if var_51_1.contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER then
			var_51_2 = string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_51_1.content)].name))
		end

		arg_51_0.chatTextExtension_:SetText(string.format("%s:%s", var_51_1.nick, var_51_2))
	else
		arg_51_0.chatText_.text = ""
	end
end

function var_0_0.RefreshBossSprite(arg_52_0)
	local var_52_0 = GuildActivityLuaBridge.GetManager().gameObject.transform:GetChild(0)
	local var_52_1 = {
		defeatSprite = "GuildActivities_icon_00055",
		hpSprite = "GuildActivities_icon_00057",
		fightingSprite = "GuildActivities_icon_00058",
		nextLevel = "GuildActivities_icon_00059"
	}
	local var_52_2 = {}

	ComponentBinder.GetInstance():BindCfgUI(var_52_2, var_52_0)

	local var_52_3 = SettingData:GetCurrentLanguage()

	if var_52_2.hpSprite_ then
		var_52_2.hpSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_1.hpSprite, var_52_3))
	end

	if var_52_2.fightingSprite_ then
		var_52_2.fightingSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_1.fightingSprite, var_52_3))
	end

	if var_52_2.defeatSprite_ then
		var_52_2.defeatSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_1.defeatSprite, var_52_3))
	end

	if var_52_2.nextLevelSprite_ then
		var_52_2.nextLevelSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_1.nextLevel, var_52_3))
	end
end

return var_0_0
