local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.const.ConstMgr.PushGiftConst
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_3 = g.core.model.User.signActivityData
local var_0_4 = g.core.model.User.commonCompetitionDataManager
local HomeModuleAutoPopup = require("app.view.module.home.common.HomeModuleAutoPopup")
local var_0_6 = g.core.event.enum
local HomeLayer = class("HomeLayer", require("app.fairyGUI.home.UI_HomeLayer"), function()
	return fgui.GComponent:create({
		resName = "HomeLayer",
		pkgPath = "ui/home/home",
		isFullScreen = true,
		pkgName = "home"
	}, ...)
end)

function HomeLayer:ctor(arg_2_1)
	self._isHideUI = false
	self._isInTrans = false
	self._isFirst = true
	self._waitCount = 0
	self._effCompPos = self.m_effComp:getPosition()
	self._effComp = nil

	self:_addMark()
	self:_initView()
end

function HomeLayer:onLoad()
	g.core.platform.PlatformProxy:openHomePage()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CLEAR_COUNT)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_AUCTION_GETINFO, self._onAutionGetInfoRec, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDayUpdate), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GM_ACTIVITY_LOGIN_GETAWARD, self._onGetAwardRefreshBannerList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_USER_BACK_GETINFO, self._onGetUserBackInfo, self)
	g.core.event.EventManager:addEventListener(var_0_6.EVENT_CELEBRATION_LOGIN_BACK, self._celebrationLoginStore, self)
	g.core.event.EventManager:addEventListener(var_0_6.EVENT_NET_S2C_MAIN_TASK_GETINFO, self._onGetMainTaskInfo, self)
	g.core.event.EventManager:addEventListener(var_0_6.EVENT_NET_S2C_MAIN_TASK_GETAWARD, self._onGetMainTaskAward, self)
	g.core.event.EventManager:addEventListener(var_0_6.EVENT_NET_S2C_MAIN_TASK_NOTIFY, self._onMainTaskNotify, self)

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) and g.core.model.User.chatData:getFirstEnterFlag() then
		g.core.network.GameNetProxy:send_C2S_BulletScreenGetInfo({
			type = g.core.model.User.chatData:toSvrChatType(var_0_0.ChatConst.AREA)
		})
		g.core.model.User.chatData:setFirstEnterFlag()
	end

	if g.core.model.User.teamBattleData:needRequireBulletInfo() then
		g.core.model.User.teamBattleData:setGetBulletInfo(true)
		g.core.network.GameNetProxy:send_C2S_BulletScreenGetInfo({
			type = var_0_0.ChatConst.TEAM_BATTLE_ZONE
		})
		g.core.network.GameNetProxy:send_C2S_BulletScreenGetInfo({
			type = var_0_0.ChatConst.TEAM_BATTLE
		})
	end

	if not self._isFirst and not self._isInTempNominate then
		self.m_enterTransition:play(function()
			self:_onCheckPushGiftPop()
		end)
	end

	self._isInTempNominate = false

	self:_setIsInTrans(false)
	g.core.sound.SoundManager:playMusic(var_0_0.SoundConst.BGM.MUSIC_2026_616MAIN)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_HOME_GUIDE_CHECK)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_UNLOCK_FEEDBACK_POP)
	self:_checkLoginPop()

	if g.core.model.User.homeData:isHomeCrossDay() then
		self:updateBannerInfo()
		self:updateActivityInfo()
	elseif g.core.model.User.homeData:getIsNeedUpdateBanner() then
		self:updateBannerInfo()
	end

	g.core.layer.LayerManager:clearIosDownObj()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	g.core.model.User.userAvatarFrameData:updateDataByConfig()

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.MAIN_QUEST) then
		g.core.network.GameNetProxy:send_C2S_MainTask_GetInfo({})
	else
		self.m_activityComp:updateMainQuestShowState()
	end

	if not g.core.service.ServiceManager:getServiceByName("LaunchService"):isLoginFinish() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_EXPIRED)
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.STORM) and g.core.model.User.stormCityData:isOverLordExpired() then
		g.core.network.GameNetProxy:send_C2S_StormCity_GetLord({})
		g.core.model.User.stormCityData:resetOverLordTs()
	end

	self:_checkRefreshOtherFuncData()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GOLD_SAVING_SHOW_NEW)
	g.core.model.User.homeData:requireCensorZip()
	require("app.core.lang.MultilingualMgr"):uploadFanHeXiePoint()

	local var_3_0 = DebugCommon.getDebugGlobalValueByKey("debug_home_simple_ui") ~= true

	self.m_activityComp:setVisible(var_3_0)
	self.m_themeComp:setVisible(var_3_0)
	self.m_otherComp:setVisible(var_3_0)
	self.m_passComp:setVisible(var_3_0)
	self.m_settingComp:setVisible(var_3_0)
	self.m_taskComp:setVisible(var_3_0)
	self.m_resItemComp:setVisible(var_3_0)
	self:_checkIsShowChaosLabel()

	if g.core.model.User.teamBattleData:checkIsNeedGetTeamInfo() then
		g.core.network.GameNetProxy:send_C2S_TeamBattle_TeamInfo({})
	end

	if #g.core.model.User.weddingActivityData:checkNeedRequestedActivityId() > 0 then
		g.core.network.GameNetProxy:send_C2S_WeddingActivity_GetInfo({})
	end

	if g.core.model.User.succubaData:checkNeedRequest() then
		g.core.network.GameNetProxy:send_C2S_Succuba_GetInfo({})
	end

	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SERVER_PASS_ACTIVITY) then
		g.core.network.GameNetProxy:send_C2S_ServerPass_Info({})
	end

	if not g.core.model.User.waitGameData:isGetNewDownLoadAward() and g.core.model.User.waitGameData:getSilentDownLoadTag() then
		g.core.network.GameNetProxy:send_C2S_NewDownload_Award({})
	end

	g.core.common.PackageRes:checkAndSendGetAward()
end

function HomeLayer:_checkLoginPop()
	if g.core.model.User.homeData:getFirstLoginHome() or g.core.model.User.homeData:isHomeCrossDay() or var_0_3:isSignActivityCanAward() then
		self:newScheduleOnce(handler(self, function()
			self:_updateCommonCompetitionData()

			self._isFirst = false
		end), 1)
	end

	self:newScheduleOnce(handler(self, function()
		HomeModuleAutoPopup.checkHaveLoginPopShow()
	end), 1)
end

function HomeLayer:_updateCommonCompetitionData()
	for iter_8_0, iter_8_1 in ipairs((var_0_4:getAllShowCompetitionActivity())) do
		if not iter_8_1:isGetInfo() then
			g.core.network.GameNetProxy:send_C2S_Competition_GetInfo({
				activity_sub_id = iter_8_1:getActId()
			})
		end
	end
end

function HomeLayer:onUnload()
	if self._waitCount > 0 then
		for iter_9_0 = 1, self._waitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._waitCount = 0
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_HOMELAYER_UNLOAD)
end

function HomeLayer:_hideBattleSpeedBtn()
	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", false)
end

function HomeLayer:_showBattleSpeedBtn()
	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", true)
end

function HomeLayer:receiveCompEvent(arg_12_1)
	local var_12_0 = ...

	if arg_12_1 == "EVENT_HOME_HIDE_UI" then
		self._isHideUI = true

		self.m_hideTransition:play(handler(self, self._hideBattleSpeedBtn))
		g.core.service.ServiceManager:getServiceByName("BroadcastService"):setHideHomeLayerUI(true)
	elseif arg_12_1 == "EVENT_HOME_BANNER_UPDATE" then
		self:updateBannerInfo()
	elseif arg_12_1 == "EVENT_HOME_SHOW_UI" then
		self:_onTouchBegin()
	elseif arg_12_1 == "EVENT_HOME_ACTIVITY_UPDATE" then
		self:updateActivityInfo()
	elseif arg_12_1 == "EVENT_STORY_END" then
		self:_updateByStoryEnd(var_12_0)
	end

	if arg_12_1 == "Assistant_ChangePosition" then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.assistant.view.sub.AssistantChangePositionComp").new({
			advanceId = var_12_0 and var_12_0.advanceId
		}), {
			withoutAni = true,
			isUpdateBlack = false
		})

		if var_12_0 and var_12_0.advanceId then
			self.m_assistantComp:changeAssistantTempAdv(g.core.model.User:getNominateInfo(var_12_0.advanceId), var_12_0 and var_12_0.skinId)

			self._isInTempNominate = true
		end
	elseif arg_12_1 == "Assistant_ChangeScene" then
		self.m_mainGroup:setVisible(false)
		g.core.module.ModuleManager:pushPopup(require("app.view.module.assistant.view.sub.AssistantChangeSceneComp").new({
			advanceId = var_12_0 and var_12_0.advanceId
		}), {
			withoutAni = true,
			isUpdateBlack = false
		})

		if var_12_0 and var_12_0.advanceId then
			self.m_assistantComp:changeAssistantTempAdv(g.core.model.User:getNominateInfo(var_12_0.advanceId), var_12_0 and var_12_0.skinId)

			self._isInTempNominate = true
		end
	elseif arg_12_1 == "Assistant_popComp" then
		self.m_mainGroup:setVisible(true)
	elseif arg_12_1 == "AssistantChangeScene_Quit" then
		self.m_bannerComp:updateRedPoint()
		self.m_assistantComp:processCompEvent(arg_12_1, var_12_0)
	elseif string.find(arg_12_1, "AssistantChange") then
		self.m_assistantComp:processCompEvent(arg_12_1, var_12_0)
	elseif arg_12_1 == "PopView_Close" then
		self.m_activityComp:updateData()
	elseif arg_12_1 == "OnlineAwardCanGet" then
		self.m_activityComp:updateActivityBtnRed()
	end
end

function HomeLayer:_onGetUserBackInfo()
	self.m_activityComp:updateData()
end

function HomeLayer:_celebrationLoginMove(arg_14_1)
	if arg_14_1.eventData and arg_14_1.eventData.name == "cut" then
		local var_14_0 = self.m_activityComp:getChild("activityBtn")

		if var_14_0 then
			self.m_effComp:runFGAction((fgui.FSequence:create(fgui.FEaseQuinticActionOut:create(fgui.FMoveTo:create(0.8, (var_14_0:localToGlobal(cc.p(40, 35))))), fgui.FCallFunc:create(function()
				self.m_effComp:setVisible(false)
			end))))
		end
	end
end

function HomeLayer:_celebrationLoginStore(arg_16_1, arg_16_2)
	self.m_effComp:setVisible(true)
	self.m_effComp:setPosition(self._effCompPos)

	self._effComp = self.m_effComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_activity_celeBg",
		isLoop = false,
		remove = true,
		eventHandler = handler(self, self._celebrationLoginMove)
	})
end

function HomeLayer:_onGetMainTaskInfo()
	self.m_mainQuestComp:updateView()
	self.m_activityComp:updateMainQuestShowState()
end

function HomeLayer:_onGetMainTaskAward(arg_18_1, arg_18_2, arg_18_3)
	g.core.module.ModuleManager:awardSummary(arg_18_3.awards)
	self.m_mainQuestComp:updateView()
end

function HomeLayer:_onMainTaskNotify()
	self.m_mainQuestComp:updateView()
end

function HomeLayer:_initView()
	self:addClickListener(handler(self, self._onTouchBegin))
	self.m_assistantComp:setTalkLine(self.m_talkGroup, self.m_linesText)
end

function HomeLayer:_onTouchBegin()
	if self._isInTrans then
		return
	end

	if self._isHideUI then
		self._isHideUI = false

		self.m_showTransition:play(handler(self, self._showBattleSpeedBtn))
	end

	g.core.service.ServiceManager:getServiceByName("BroadcastService"):setHideHomeLayerUI(false)
end

function HomeLayer:_setIsInTrans(arg_22_1)
	self._isInTrans = arg_22_1 or false

	self:setTouchable(not self._isInTrans)
end

function HomeLayer:updateBannerInfo()
	g.core.model.User.homeData:updateBannerList()

	if self.m_bannerComp and self.m_bannerComp.m_bannerComp then
		self.m_bannerComp.m_bannerComp:updateData()
	end

	g.core.model.User.giftData:refreshInTime()
end

function HomeLayer:updateActivityInfo()
	if self.m_activityComp and self.m_activityComp.updateData then
		self.m_activityComp:updateData()
	end

	if self.m_themeComp and self.m_themeComp.updateThemeActivity then
		self.m_themeComp:updateThemeActivity()
	end
end

function HomeLayer:_onAutionGetInfoRec()
	if self.m_activityComp and self.m_activityComp.onUpdateAuctionBtn then
		self.m_activityComp:onUpdateAuctionBtn()
	end
end

function HomeLayer:_updateByStoryEnd(arg_26_1)
	if arg_26_1.trigger_type == "EVENT_STORY_FORCE_START" and arg_26_1.trigger_data.id == var_0_1.FRIST_PUSHGIFT_AVG_ID then
		g.core.model.User.pushGiftData:setFirstPushGiftAvgShow()
		self:newScheduleOnce(handler(self, self._onCheckPushGiftPop), 0.2)
	end
end

function HomeLayer:_checkRefreshOtherFuncData()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.HOME_LAND_TRAIN) and g.core.model.User.hlTrainData:isExpired() then
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_GetInfo({})
	end

	if g.core.model.User.homeData:isGMFirstReq() then
		g.core.network.GameNetProxy:send_C2S_Screen_Items_Infos({})
	end
end

function HomeLayer:_onCheckPushGiftPop()
	if g.core.common.ModuleUnlock:isModuleUnlock(var_0_0.FUNCTION_TYPE.PUSH_GIFT) then
		g.core.model.User.pushGiftData:checkValidData()

		if not g.core.guide.GuideProxy:isGuideRunning() then
			if g.core.module.ModuleManager:getCurModule().module == g.view.entrance.HOME and g.core.model.User.pushGiftData:getHasNew() then
				if g.core.model.User.pushGiftData:isFirstPushGiftAvgShow() then
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
						id = var_0_1.FRIST_PUSHGIFT_AVG_ID
					})
				else
					g.core.module.ModuleManager:popAllPopupAndPush(g.view.entrance.PUSH_GIFT)
				end
			end
		end
	end
end

function HomeLayer:_onCrossDayUpdate()
	self:newScheduleOnce(handler(self, function()
		if g.core.model.User.homeData:isHomeCrossDay() then
			HomeModuleAutoPopup.checkHaveLoginPopShow()
			self:updateBannerInfo()
			self:updateActivityInfo()

			self._isFirst = false
		end
	end), 3)
end

function HomeLayer:_onGetAwardRefreshBannerList()
	self:updateBannerInfo()
	self:updateActivityInfo()
end

function HomeLayer:_createChaosLabel()
	local var_32_0 = g.core.layer.LayerManager:getFloatLayer()

	if var_32_0:getChild("chaosLabel") then
		return
	end

	local var_32_1 = fgui.UIPackage:createObject("base_new", "BaseVerScrollLbl")

	var_32_1:setTitle((g.core.common.GlobalFunc.getChaosCode(tostring((g.core.model.User:getId())))))

	local var_32_2 = var_32_1:getChild("title")

	var_32_2:setColor(cc.BLACK)
	var_32_2:setFontSize(14)
	var_32_1:setName("chaosLabel")
	var_32_0:addChild(var_32_1)

	local var_32_3 = cc.Director:getInstance():getSafeAreaRect()

	var_32_1:setPosition(var_32_3.x + 10, display.height - var_32_3.y * 2 - var_32_1:getSize().height / 2)
	var_32_2:setOpacity(127.5)
	var_32_1:setTouchable(false)
end

function HomeLayer:_checkIsShowChaosLabel()
	local ChannelConst = require("app.core.platform.const.ChannelConst")

	if g.core.platform.PlatformProxy:isChannelOfChina() and ({
		[ChannelConst.ChannelNames.HUAWEI] = true,
		[ChannelConst.ChannelNames.XIAOMI] = true,
		[ChannelConst.ChannelNames.OPPO] = true,
		[ChannelConst.ChannelNames.VIVO] = true,
		[ChannelConst.ChannelNames.DOUYIN] = true
	})[g.core.platform.PlatformProxy:getCurChannel().name] then
		self:_createChaosLabel()
	end
end

function HomeLayer:_addMark()
	if not not (config.DEBUG_VERSION or device.isWindows() and not config.PCSDK_ENABLED) and not config.HIDE_MARK then
		g.core.layer.LayerManager:addMark()
	end
end

return HomeLayer
