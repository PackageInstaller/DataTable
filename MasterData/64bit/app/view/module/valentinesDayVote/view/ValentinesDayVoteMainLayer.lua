local ValentinesDayVoteMainLayer = class("ValentinesDayVoteMainLayer", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "valentinesDayVote",
		isFullScreen = true,
		pkgPath = "ui/valentinesDayVote/valentinesDayVote",
		resName = "ValentinesDayVoteMainLayer"
	}, ...)
end)
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.valentinesDayVoteData
local var_0_3 = g.core.const.ConstMgr.ValentinesDayVoteConst.ACTIVITY_STAGE
local var_0_4 = g.core.common.ServerTime
local DrawKnight = require("app.view.common.DrawKnight")

function ValentinesDayVoteMainLayer:ctor(arg_2_1)
	self._activityStage = var_0_2:getActivityStage()

	if self._activityStage == var_0_3.VOTE then
		self.m_stageController:setSelectedIndex(0)
	elseif self._activityStage == var_0_3.SHOW then
		self.m_stageController:setSelectedIndex(1)
	end

	self:addBg("bg/activity/bg_vote01_qrj_main.jpg")
	self.m_taskBtn:addClickListener(handler(self, self._onShowTask))
	self.m_giftBtn:addClickListener(handler(self, self._onShowGift))
	self:_updateTime()
	self.m_groupController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onGroupTabChanged))
	self.m_topBarComp:setResInfoById(175)
	self.m_topBarComp:getChild("resComp1"):setSound(g.core.const.ConstMgr.SoundConst.Sound.UI_PAGE_OPEN_02)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.VALENTINES_DAY_VOTE)
	self.m_moveTransition:setHook("end", function()
		self._isPlayingEffect = false

		self.m_levelComp:playVoteEffect()
		self:_updateView()
	end)

	self._route = 0

	if arg_2_1 and arg_2_1.route1 then
		self._route = arg_2_1.route1
	end

	self.m_titleEffectComp:addEffectSpine({
		anim = "play",
		name = "eff_ui_valentinesDayVote_titlelizi",
		isLoop = true,
		x = self.m_titleEffectComp:getWidth() / 2,
		y = self.m_titleEffectComp:getHeight() / 2
	})
	self.m_taskBtn:getChild("redPointComp"):setPosition(self.m_taskBtn:getWidth() - 20, 35)
end

function ValentinesDayVoteMainLayer:onLoad()
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_GETINFO, handler(self, self._onGetInfo), self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTE, handler(self, self._onVote), self)
	var_0_1:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTEALLAWARD, handler(self, self._showReward), self)

	if var_0_2:isProcess() then
		g.core.network.GameNetProxy:send_C2S_Support_GetInfo({})
	end

	self.m_enterTransition:play()
	self:_checkGuide()

	if self._route == 2 then
		self:_onShowGift()

		self._route = 0
	elseif self._route == 3 then
		self:_onShowTask()

		self._route = 0
	end

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_MENU_VALENTINES_VOTE_LAYER)
end

function ValentinesDayVoteMainLayer:_updateTime()
	local var_5_0, var_5_1 = var_0_2:getActivityTime()

	self.m_activityTimeTxt:setText(var_0_4:getDateYMDHMFormat(var_5_0) .. "-" .. var_0_4:getDateYMDHMFormat(var_5_1))
end

function ValentinesDayVoteMainLayer:_onGetInfo(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if not self._isPlayingEffect then
		self:_updateView()
	end
end

function ValentinesDayVoteMainLayer:_onVote(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self.m_effectComp:setPosition(display.cx, display.cy)
	self.m_effectComp:setVisible(true)
	self.m_effectComp:initView()

	self._isPlayingEffect = true

	self.m_effectComp:playEffect()
	self.m_moveTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_FLOWER_COLLECT)
end

function ValentinesDayVoteMainLayer:_showReward(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:awardSummary(arg_8_4.awards or {}, nil, nil, g.core.lang:get(300001))
	self:_updateView()
end

function ValentinesDayVoteMainLayer:_updateView()
	self._activityStage = var_0_2:getActivityStage()

	if self._activityStage == var_0_3.VOTE then
		self.m_stageController:setSelectedIndex(0)
		self.m_knightComp:updateView()
	elseif self._activityStage == var_0_3.SHOW then
		self.m_stageController:setSelectedIndex(1)
		self.m_resultComp:updateView()
		self:_showSpine()

		if var_0_2:isFinalResult() then
			self.m_isFinalController:setSelectedIndex(0)
		else
			self.m_isFinalController:setSelectedIndex(1)
		end
	end

	self.m_levelComp:updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn,
		customData = {}
	})
end

function ValentinesDayVoteMainLayer:_onGroupTabChanged(arg_10_1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SWITCH)
	self.m_knightComp:updateView({
		group = self.m_groupController:getSelectedIndex()
	})
end

function ValentinesDayVoteMainLayer:_onShowTask()
	g.core.module.ModuleManager:pushModule(g.view.entrance.VALENTINES_DAY_VOTE_TASK_LAYER)
end

function ValentinesDayVoteMainLayer:_onShowGift()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.valentinesDayVote.view.ValentinesDayVoteGiftPop").new(), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function ValentinesDayVoteMainLayer:receiveCompEvent(arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or {}

	if arg_13_1 == "knightCell_click" then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_MENU_SLIDE_01)

		local var_13_0 = arg_13_2.data or {}

		g.core.module.ModuleManager:pushPopup(require("app.view.module.valentinesDayVote.view.ValentinesDayVoteSupportPop").new({
			data = var_13_0
		}), {
			touchDisappear = true,
			ignoreTouch = false
		})
	elseif arg_13_1 == "levelPop_close" then
		self:_updateView()
	end
end

function ValentinesDayVoteMainLayer:onUnload()
	self.m_effectComp:stopEffect()
	self.m_effectComp:setVisible(false)

	if self.m_moveTransition:isPlaying() then
		self.m_moveTransition:stop()
	end

	self.m_levelComp:updateView()
end

function ValentinesDayVoteMainLayer:_checkGuide()
	if not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.VALENTINES_DAY_VOTE.FIRST_ENTER) then
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.VALENTINES_DAY_VOTE.FIRST_ENTER)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = g.core.const.ConstMgr.GuideConst.VALENTINES_DAY_VOTE.FIRST_ENTER
		})
	end
end

function ValentinesDayVoteMainLayer:_showSpine()
	self.m_spineComp:removeChildren()
	self.m_spineComp:addChild((DrawKnight.new({
		isShowBg = true,
		resId = var_0_2:getTopKnightData().knight:getBaseInfo().res_id
	})))
end

return ValentinesDayVoteMainLayer
