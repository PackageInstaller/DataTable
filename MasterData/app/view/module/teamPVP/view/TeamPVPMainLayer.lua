local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.network.GameNetProxy
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.model.User.teamPvpData
local var_0_8 = g.core.const.ConstMgr.TeamPvpConst
local var_0_9 = g.core.common.ServerTime
local TeamPVPMainLayer = class("TeamPVPMainLayer", require("app.fairyGUI.teamPVP.UI_TeamPVPMainLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamPVPMainLayer",
		pkgPath = "ui/teamPVP/teamPVP",
		isFullScreen = true,
		pkgName = "teamPVP"
	}, ...)
end)

function TeamPVPMainLayer:ctor(arg_2_1)
	self._mapInfo = {}
	self._myRank = 0
	self._isInEntrance = arg_2_1
	self._cdHandler = nil
	self._hasPopGuideVideo = false
	self._matchEff = nil
	self._createEff = nil

	self:_addListeners()
	self:_initView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_PVP)
end

function TeamPVPMainLayer:_addListeners()
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_taskBtn:addClickListener(handler(self, self._onClickTaskBtn))
	self.m_matchBtn:addClickListener(handler(self, self._onClickMatchBtn))
	self.m_createTeamBtn:addClickListener(handler(self, self._onClickCreateTeamBtn))
	self.m_rankLoader:addClickListener(handler(self, self._onClickRank))
	self.m_deployBtn:addClickListener(handler(self, self._onClickDeployBtn))
	self.m_guideBtn:addClickListener(handler(self, self._onClickGuideBtn))
end

function TeamPVPMainLayer:_initView()
	self.m_topBarComp:setResInfoById(var_0_8.TOP_BAR_ID)
	self.m_challengesNumComp:initView({
		playNum = 1,
		getTimesFunc = function()
			return g.core.model.User.shopData:getLeftCount(var_0_8.PLAY_NUM_ID) or 0
		end,
		fullTime = var_0_7:getPlayFullTimes(),
		onGetTimes = handler(self, self._onClickBuy),
		refreshEvent = {
			var_0_0.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM,
			var_0_0.EVENT_CROSS_DAY_NOTIFY
		}
	})
end

function TeamPVPMainLayer:_updateLeftTime()
	local var_6_0 = var_0_7:getActivityState()

	if var_6_0 == 1 then
		local var_6_1 = var_0_7:getEndTime()

		if var_6_1 >= 86400 then
			self.m_leftTimeTxt:setText(g.core.lang:get(420447, {
				timeStr = var_0_9:getLeftDHFormat(var_6_1)
			}))
		else
			local var_6_2 = {}

			var_6_2.timeStr = var_0_9:getLeftHMFormat(var_6_1)

			self.m_leftTimeTxt:setText(g.core.lang:get(420447, var_6_2))
		end
	elseif var_6_0 == 2 then
		local var_6_3 = var_0_7:getActivityExpireTime()

		if var_6_3 >= 86400 then
			self.m_leftTimeTxt:setText(g.core.lang:get(420448, {
				timeStr = var_0_9:getLeftDHFormat(var_6_3)
			}))
		else
			local var_6_4 = {}

			var_6_4.timeStr = var_0_9:getLeftHMFormat(var_6_3)

			self.m_leftTimeTxt:setText(g.core.lang:get(420448, var_6_4))
		end
	end
end

function TeamPVPMainLayer:_updateMapView()
	self._mapInfo = var_0_7:getMapInfo()

	self.m_bgLoader:setURL(var_0_2:getTeamPVPMainBg(self._mapInfo.map_id))
	self.m_mapName:setText(g.core.lang:get(420421, {
		map = self._mapInfo.name
	}))
	self.m_mapDesc:setText(self._mapInfo.des)
end

function TeamPVPMainLayer:_updateRankView()
	self._myRank = var_0_7:getMyRank()

	local var_8_0 = var_0_7:getMyTitleInfo()

	self.m_honorNum:setText((var_0_7:getMyHonorNum()))

	if self._myRank == 0 or var_0_7:getTeamPVPParameterById(var_0_8.PARAMETER_ID.SHOW_RANK_LIMIT) < self._myRank then
		self.m_crossRank:setText(g.core.lang:get(420433))
	else
		self.m_crossRank:setText(self._myRank)
	end

	if var_8_0 then
		self.m_rankName:setText(var_8_0.title or g.core.lang:get(420422))
		self.m_rankLoader:setURL(var_0_2:getTeamPVPBadge300(var_8_0.title_res))
	end
end

function TeamPVPMainLayer:onLoad()
	if var_0_7:isActivityInExpire() then
		self:newScheduleOnce(handler(self, self._onClose))
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))

		return
	else
		self:newSchedule(handler(self, self._onExpireSchedule), 1)
	end

	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_ENTER, self._onS2CEnter, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GROUP_BATTLE_CREATEROOM, self._onS2CCreateRoom, self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_1:addEventListener(var_0_0.TEAM_PVP_GUIDE_VIDEO, self._onPopGuideVideo, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM, self._updateBtnAnim, self)
	var_0_1:dispatchEvent(var_0_0.EVENT_WEAK_GUIDE_READY)

	if self._isInEntrance then
		self:_onS2CEnter()

		self._isInEntrance = false
	else
		var_0_4:send_C2S_GroupBattle_Enter({})
	end

	self.m_challengesNumComp:updateView()
	self:_updateBtnAnim()
	self:_updateLeftTime()

	self._cdHandler = self:newSchedule(handler(self, self._updateLeftTime), 1)

	self.m_enterTransition:play(handler(self, self._checkTipsGuide))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
end

function TeamPVPMainLayer:_onClose()
	var_0_3:popAllPopup()
	var_0_3:onlyPopSelfByDisplay(self)
end

function TeamPVPMainLayer:_onExpireSchedule()
	if var_0_7:isActivityInExpire() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1005))
		self:_onClose()
	end
end

function TeamPVPMainLayer:_enterRoom()
	var_0_3:popAllPopup()

	local var_12_0 = var_0_7:getTeamInfo()

	if var_12_0 and var_12_0.id then
		var_0_3:popAllPopupAndPush(g.view.entrance.TEAM_PVP_TEAM_LAYER)
	end
end

function TeamPVPMainLayer:_updateBtnAnim()
	local var_13_0 = var_0_7:getChallengeNum()
	local var_13_1 = self.m_matchBtn:getChild("matchEffect")
	local var_13_2 = self.m_createTeamBtn:getChild("createEffect")

	var_13_1:setVisible(var_13_0 > 0)
	var_13_2:setVisible(var_13_0 > 0)

	if var_13_0 > 0 then
		self._matchEff = self._matchEff or var_13_1:addEffectSpine({
			anim = "play",
			name = "eff_ui_teamPvp_btnMatch",
			isLoop = true
		})
		self._createEff = self._createEff or var_13_2:addEffectSpine({
			anim = "play",
			name = "eff_ui_teamPvp_btnCreate",
			isLoop = true
		})
	end
end

function TeamPVPMainLayer:_onClickShopBtn()
	var_0_3:popAllPopupAndPush(g.view.entrance.SHOP, {
		tabType = var_0_6.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_6.SHOP_TYPE.TEAM_PVP
	})
end

function TeamPVPMainLayer:_onClickRankBtn()
	var_0_3:popAllPopupAndPush(g.view.entrance.TEAM_PVP_RANK_LAYER)
end

function TeamPVPMainLayer:_onClickTaskBtn()
	var_0_3:pushPopup(require("app.view.module.teamPVP.view.TeamPVPTaskPop").new(), {
		touchDisappear = false
	})
end

function TeamPVPMainLayer:_onClickMatchBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_MATCHING_PLAY)
	var_0_3:pushPopup(require("app.view.module.teamPVP.view.TeamPVPMatchPop").new({
		matchType = var_0_8.MATCH_TYPE.TEAM
	}), {
		touchDisappear = false,
		ignoreTouch = true
	})
end

function TeamPVPMainLayer:_onClickCreateTeamBtn()
	var_0_4:send_C2S_GroupBattle_CreateRoom({})
end

function TeamPVPMainLayer:_onClickRank()
	var_0_3:popAllPopupAndPush(g.view.entrance.TEAM_PVP_RANK_LAYER, {
		tab = var_0_8.RANK_TAB_TYPE.HONOR
	})
end

function TeamPVPMainLayer:_onClickDeployBtn()
	var_0_3:popAllPopupAndPush(g.view.entrance.FORMATION)
end

function TeamPVPMainLayer:_onClickGuideBtn()
	self:_onPopGuideVideo()
end

function TeamPVPMainLayer:_onClickBuy()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_5.TYPE_ITEM,
		value = var_0_5.ITEM.TYPE_TEAM_PVP,
		shopId = var_0_6.SHOP_ITEM_ID.TEAM_PVP_TOKEN
	}), {
		touchDisappear = true
	})
end

function TeamPVPMainLayer:_onS2CEnter()
	self:_updateMapView()
	self:_updateRankView()

	local var_23_0 = var_0_7:getTeamInfo()

	if var_23_0 and var_23_0.id then
		self:newScheduleOnce(function()
			var_0_3:popAllPopupAndPush(g.view.entrance.TEAM_PVP_TEAM_LAYER)
		end)
	end
end

function TeamPVPMainLayer:_onS2CCreateRoom(arg_25_1, arg_25_2, arg_25_3)
	var_0_3:popAllPopupAndPush(g.view.entrance.TEAM_PVP_TEAM_LAYER)
end

function TeamPVPMainLayer:_onCrossDayUpdate()
	if not var_0_7:isActivityInStart() then
		var_0_3:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	var_0_4:send_C2S_GroupBattle_Enter({})
	self:_updateBtnAnim()
end

function TeamPVPMainLayer:_onPopGuideVideo()
	if not self._hasPopGuideVideo then
		self._hasPopGuideVideo = true

		local var_27_0 = require("app.view.module.teamPVP.view.TeamPVPGuideVideoPop").new()

		self:addListen(var_27_0)
		var_0_3:pushPopup(var_27_0, {
			touchDisappear = false,
			ignoreTouch = true
		})
	end
end

function TeamPVPMainLayer:receiveCompEvent(arg_28_1, arg_28_2)
	if arg_28_1 == "quick_join_succeed" then
		if arg_28_2.time >= var_0_8.MATCH_POP_CLOSE_DELAY then
			self:_enterRoom()
		else
			self:newScheduleOnce(handler(self, self._enterRoom), var_0_8.MATCH_POP_CLOSE_DELAY - arg_28_2.time)
		end

		return true
	elseif arg_28_1 == "close_guide_video" then
		self._hasPopGuideVideo = false
	end
end

function TeamPVPMainLayer:_checkTipsGuide()
	if g.core.guide.GuideProxy:isGuideRunning() then
		return
	end

	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.TEAM_PVP_MAIN_LAYER_GUIDE) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.TEAM_PVP_MAIN_LAYER_GUIDE)
		self:newScheduleOnce(function()
			var_0_1:dispatchEvent(g.core.event.enum.EVENT_TICK_TIP_GUIDE_TICK, false, {
				key = "TEAM_PVP_MAIN_LAYER_GUIDE",
				objects = {
					self.m_guide_1,
					self.m_rankLoader,
					self.m_guide_3
				}
			})
		end, 0)
	elseif not var_0_7:isGuideVideoPopToday() or not var_0_7:isGuideVideoPopSelected() then
		self:_onPopGuideVideo()
	end
end

return TeamPVPMainLayer
