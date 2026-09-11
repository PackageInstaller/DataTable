local GuildActivityWarFieldView = class("GuildActivityWarFieldView", ReduxView)

function GuildActivityWarFieldView:UIName()
	return "UI/GuildActivityUI/GuildActivityWarFieldUI"
end

function GuildActivityWarFieldView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildActivityWarFieldView:OnCtor()
	return
end

function GuildActivityWarFieldView:Init()
	self:InitUI()
	self:AddUIListener()

	self.newMessageHandler_ = handler(self, self.ChatNewMessage)
end

function GuildActivityWarFieldView:InitUI()
	self:BindCfgUI()

	self.hideLockController_ = ControllerUtil.GetController(self.gameObject_.transform, "canNext")
	self.chatTextExtension_ = self.chatText_:GetComponent(typeof(TextExtension))
end

function GuildActivityWarFieldView:indexItem(arg_6_1, arg_6_2)
	return
end

function GuildActivityWarFieldView:AddUIListener()
	self.dragEventListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function(arg_8_0, arg_8_1)
		self:GetGuildActivityManager():SetZoom(self.mapSlider_.value)
	end))
	self:GetGuildActivityManager():SetOnZoomByFingerHandler(handler(self, self.OnZoomChangeByFinger))
	self:GetGuildActivityManager():SetOnNodeClick(handler(self, self.OnNodeClick))
	self:GetGuildActivityManager():SetOnBonusClick(handler(self, self.OnBonusNodeClick))
	self:GetGuildActivityManager():SetOnBgClick(handler(self, self.OnBgClick))
	self:GetGuildActivityManager():SetOnLevelLoaded(handler(self, self.OnLevelLoaded))
	self:AddBtnListener(self.allGetBtn_, nil, function()
		GuildActivityAction.GetCoin()
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

		JumpTools.OpenPageByJump("guildActivityReward", {
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.ratingBtn_, nil, function()
		if not self:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("guildActivityRate", {
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.setupBtn_, nil, function()
		JumpTools.OpenPageByJump("guildActivityFightHeroSetting", {
			isEnter = true,
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.talentBtn_, nil, function()
		if not self:IsTop() then
			gameContext:Back()
		end

		self:Go("/guildActivityAffixMain", {
			activityID = self.params_.activityID
		})
	end)
	self:AddBtnListener(self.chatBtn_, nil, function()
		if not self:IsTop() then
			gameContext:Back()
		end

		JumpTools.OpenPageByJump("chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY
		}, ViewConst.SYSTEM_ID.CHAT)
	end)
end

function GuildActivityWarFieldView:AddEventListeners()
	self:RegistEventListener(MATERIAL_MODIFY, function(arg_18_0)
		if arg_18_0 == MaterialConst.GUILD_ACTIVITY_COIN then
			self:UpdateLevelView()
		end
	end)
	self:RegistEventListener(SPAWN_ID_UPDATE, function()
		self:UpdateRightBtn()
	end)
	self:RegistEventListener(GUILD_ACTIVITY_COIN_GET_FINISH, function()
		self.currencyAnimator_:Play("currency", -1, 0)
	end)
end

function GuildActivityWarFieldView:OnZoomChangeByFinger(arg_21_1)
	self.mapSlider_.value = arg_21_1
end

function GuildActivityWarFieldView:OnBgClick()
	if gameContext.routes_[#gameContext.routes_] == "guildActivityNormalPop" or gameContext.routes_[#gameContext.routes_] == "guildActivityElitePop" or gameContext.routes_[#gameContext.routes_] == "guildActivityBossPop" then
		gameContext:Back()
	end
end

function GuildActivityWarFieldView:OnLevelLoaded(arg_23_1)
	self.curMapIndex_ = arg_23_1

	self:UpdateLevelView()
end

function GuildActivityWarFieldView:OnNodeClick(arg_24_1)
	if not self:IsTop() then
		gameContext:Back()
	end

	if self.animTimer_ ~= nil then
		return
	end

	if ActivityClubCfg[arg_24_1].type == 0 then
		-- block empty
	elseif ActivityClubCfg[arg_24_1].type == 1 then
		JumpTools.OpenPageByJump("guildActivityNormalPop", {
			nodeId = arg_24_1
		})
	elseif ActivityClubCfg[arg_24_1].type == 2 then
		JumpTools.OpenPageByJump("guildActivityElitePop", {
			nodeId = arg_24_1
		})
	elseif ActivityClubCfg[arg_24_1].type == 3 then
		JumpTools.OpenPageByJump("guildActivityBossPop", {
			nodeId = arg_24_1
		})
	end
end

function GuildActivityWarFieldView:OnBonusNodeClick(arg_25_1)
	GuildActivityAction.GetCoin()
end

function GuildActivityWarFieldView:OnTop()
	self:GetGuildActivityManager():SetOnWarField(false)
	self:GetGuildActivityManager():SetOnWarField(true)
	self:UpdateBar()
end

function GuildActivityWarFieldView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildActivityWarFieldView:UpdateBar()
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

function GuildActivityWarFieldView:OnEnter()
	self:AddEventListeners()

	self.curMapIndex_ = self.params_.level

	self:GetGuildActivityManager():SetOnWarField(true)
	self:UpdateLevelView()
	self:RegisterRedPoint()
	self:StartTimer()
	self:UpdateTimer()
	self:OnCheckRateUpgrade()
	manager.notify:RegistListener(CHAT_NEW_MESSAGE, self.newMessageHandler_)
	self:ChatNewMessage()

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

	self:RefreshBossSprite()
end

function GuildActivityWarFieldView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
	LeanTween.cancel(manager.ui.mainCameraCom_.gameObject)
	self:GetGuildActivityManager():SetOnWarField(false)
	self:UnRegisterRedPoint()
	self:StopTimer()
	manager.notify:RemoveListener(CHAT_NEW_MESSAGE, self.newMessageHandler_)
	manager.ui:ResetMainCamera()
end

function GuildActivityWarFieldView:StartTimer()
	if self.timer_ == nil then
		self.timer_ = Timer.New(function()
			self:UpdateTimer()
		end, 1, -1)
	end

	self.timer_:Start()
end

function GuildActivityWarFieldView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function GuildActivityWarFieldView:UpdateTimer()
	self.lastTimeLabel_.text = manager.time:GetLostTimeStr(ActivityData:GetActivityData(ActivityConst.GUILD_ACTIVITY_START).stopTime)

	if GuildActivityData:GetTotalCoinToGet() > 0 then
		SetActive(self.allGetBtn_.gameObject, true)
	else
		SetActive(self.allGetBtn_.gameObject, false)
	end
end

function GuildActivityWarFieldView:GoToPrevLevel()
	if self.animTimer_ ~= nil then
		return
	end

	self.curMapIndex_ = self.curMapIndex_ - 1

	self:GotoLevel(self.curMapIndex_)
end

function GuildActivityWarFieldView:GoToNextLevel()
	if self.animTimer_ ~= nil then
		return
	end

	local var_38_0 = GuildActivityData:GetMySpawnNodeId(self.curMapIndex_ + 1)

	if var_38_0 == nil or var_38_0 == 0 then
		ShowTips("ACTIVITY_CLUB_NEXT_MAP_LOCK_TIP")

		return
	end

	self.curMapIndex_ = self.curMapIndex_ + 1

	self:GotoLevel(self.curMapIndex_)
end

function GuildActivityWarFieldView:OnGuildActivityEnterNewLevel()
	if self.animTimer_ ~= nil then
		return
	end

	self.curMapIndex_ = self.curMapIndex_ + 1

	self:GotoLevel(self.curMapIndex_)
end

local var_0_1

function GuildActivityWarFieldView:GotoLevel(arg_40_1)
	if not self:IsTop() then
		gameContext:Back()
	end

	var_0_1 = arg_40_1

	SetActive(self.cloudGo_, true)

	self.animTimer_ = 1

	AnimatorTools.PlayAnimationWithCallback(self.cloudAnimator_, "cloud", function()
		SetActive(self.cloudGo_, false)

		self.animTimer_ = nil
	end)
	self.cloudAnimator_:Play("cloud", -1, 0)
end

function GuildActivityWarFieldView:OnEnterNewLevel()
	self:GetGuildActivityManager():LoadLevel(var_0_1)

	self.params_.level = var_0_1
end

function GuildActivityWarFieldView:UpdateLevelView()
	self.mapNameLabel_.text = GetI18NText(ActivityClubMapCfg[ActivityClubMapCfg.all[self.curMapIndex_]].map_name)

	SetActive(self.leftBtn_.gameObject, true)
	SetActive(self.rightBtn_.gameObject, true)

	if self.curMapIndex_ == 1 then
		SetActive(self.leftBtn_.gameObject, false)
	end

	if self.curMapIndex_ == #ActivityClubMapCfg.all then
		SetActive(self.rightBtn_.gameObject, false)
	end

	self.footPrintLabel_.text = string.format("%d/%d", GuildActivityData:GetMyOccupiedNum(), GuildActivityData:GetMaxOccupyCount())
	self.profitLabel_.text = string.format("%d(+%d/%s)", ItemTools.getItemNum(MaterialConst.GUILD_ACTIVITY_COIN), GuildActivityData:GetCoinGain(), GetTips("HOUR"))

	self:UpdateRightBtn()
end

function GuildActivityWarFieldView:UpdateRightBtn()
	local var_44_0 = GuildActivityData:GetMySpawnNodeId(self.curMapIndex_ + 1)

	if self.curMapIndex_ == #ActivityClubMapCfg.all then
		self.hideLockController_:SetSelectedState("true")
	elseif var_44_0 == nil or var_44_0 == 0 then
		self.hideLockController_:SetSelectedState("false")
	else
		self.hideLockController_:SetSelectedState("true")
	end
end

function GuildActivityWarFieldView:OnMainHomeViewTop()
	return
end

function GuildActivityWarFieldView:GetGuildActivityManager()
	return GuildActivityLuaBridge.GetManager()
end

function GuildActivityWarFieldView:Dispose()
	self.newMessageHandler_ = nil

	self.mapSlider_.onValueChanged:RemoveAllListeners()
	self:GetGuildActivityManager():SetOnZoomByFingerHandler(nil)

	if self.timer_ then
		self.timer_:Dispose()

		self.timer_ = nil
	end

	self:StopTimer()
	GuildActivityWarFieldView.super.Dispose(self)
end

function GuildActivityWarFieldView:RegisterRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, self.params_.activityID))
	manager.redPoint:bindUIandKey(self.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, self.params_.activityID))
	manager.redPoint:bindUIandKey(self.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, self.params_.activityID))
end

function GuildActivityWarFieldView:UnRegisterRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, self.params_.activityID))
	manager.redPoint:unbindUIandKey(self.talentBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, self.params_.activityID))
	manager.redPoint:unbindUIandKey(self.setupBtn_.transform, string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_ON_FIGHT_NOT_FULL, self.params_.activityID))
end

function GuildActivityWarFieldView:OnCheckRateUpgrade()
	local var_50_0, var_50_1 = GuildActivityData:CheckRateUpgrade(self.params_.activityID)

	if var_50_0 == true then
		JumpTools.OpenPageByJump("guildActivityRateUpgrad", {
			rateID = var_50_1
		})
		GuildActivityData:RefreshRateRedPoint(self.params_.activityID)
		self:UpdateLevelView()
	end
end

function GuildActivityWarFieldView:ChatNewMessage()
	local var_51_0 = ChatChannelData:GetCacheContent(ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY)

	if #var_51_0 > 0 then
		self.chatTextExtension_:SetText(string.format("%s:%s", var_51_0[#var_51_0].nick, (var_51_0[#var_51_0].contentType == ChatConst.CHAT_CONTENT_TYPE.STICKER or nil) and string.format("[%s]", GetI18NText(ChatStickerCfg[tonumber(var_51_0[#var_51_0].content)].name))))
	else
		self.chatText_.text = ""
	end
end

function GuildActivityWarFieldView:RefreshBossSprite()
	local var_52_0 = {
		defeatSprite = "GuildActivities_icon_00055",
		hpSprite = "GuildActivities_icon_00057",
		fightingSprite = "GuildActivities_icon_00058",
		nextLevel = "GuildActivities_icon_00059"
	}
	local var_52_1 = {}

	ComponentBinder.GetInstance():BindCfgUI(var_52_1, (GuildActivityLuaBridge.GetManager().gameObject.transform:GetChild(0)))

	local var_52_2 = SettingData:GetCurrentLanguage()

	if var_52_1.hpSprite_ then
		var_52_1.hpSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_0.hpSprite, var_52_2))
	end

	if var_52_1.fightingSprite_ then
		var_52_1.fightingSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_0.fightingSprite, var_52_2))
	end

	if var_52_1.defeatSprite_ then
		var_52_1.defeatSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_0.defeatSprite, var_52_2))
	end

	if var_52_1.nextLevelSprite_ then
		var_52_1.nextLevelSprite_.sprite = getSprite("Atlas/GuildActivitiesUI", string.format("%s@%s", var_52_0.nextLevel, var_52_2))
	end
end

return GuildActivityWarFieldView
