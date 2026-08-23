local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.TowerConst.STAGE_TYPE_HARD
local var_0_4 = g.core.model.User.towerHardData
local var_0_5 = g.core.module.ModuleManager
local TowerHardMainLayer = class("TowerHardMainLayer", require("app.fairyGUI.tower.UI_TowerHardMainLayer"), function()
	return fgui.GComponent:create({
		resName = "TowerHardMainLayer",
		pkgName = "tower",
		isFullScreen = true,
		pkgPath = "ui/tower/tower"
	}, ...)
end)

function TowerHardMainLayer:ctor()
	if self.m_difficultyController then
		self.m_difficultyController:setSelectedIndex(1)
	end

	self._challengeComp = nil
	self._fadeInEffectNode = nil
	self._mainEffectNode = nil
	self._lineEffectList = {}
	self._lightTowerEffectList = {}
	self._guildTowerEffectList = {}
	self._collectionLightEffectNode = nil
	self._collectionStopEffectNode = nil
	self._isSelectBubble = false

	self:_initView()
	self.m_enterTransition:play(handler(self, self.playEnterEndAni))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TOWER_HARD)
end

function TowerHardMainLayer:playEnterEndAni()
	self.m_progressBtn:getChild("rewardLoader"):setVisible(true)

	local var_3_0, var_3_1 = var_0_4:getCurRealHangupTimeAndProgress()

	if var_3_1 < 50 then
		-- block empty
	end

	self.m_progressBtn:getChild("effectNode"):addEffectSpine({
		remove = true,
		name = "eff_ui_tower_bubble",
		isLoop = false,
		anim = "play"
	})
end

function TowerHardMainLayer:_updateMainEffect()
	if var_0_4:getMainTowerIsOpen() then
		self.m_mainEffTransition:play()

		if self._mainEffectNode == nil then
			self._mainEffectNode = self:_addTowerEffect(self.m_mainEffNode, "eff_ui_towerHardBuild_eff", true, "kingTowerIdle")
		end

		self:_addTowerEffect(self.m_mainEffNode, "eff_ui_towerHardBuild_eff", false, "kingTowerLight", true)
	elseif self._mainEffectNode ~= nil then
		self._mainEffectNode:dispose()

		self._mainEffectNode = nil
	end
end

function TowerHardMainLayer:_initView()
	self.m_topBar:setResInfoById(302)
	self.m_bgNode:initView()
	self.m_rankRewardBtn:addClickListener(handler(self, self._onRankRewardBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_CollectionPlatfpomBtn:getChild("touch"):addClickListener(handler(self, self._onCollectionPlatformPopClick))
	self.m_progressBtn:addClickListener(handler(self, self._onProgressBubbleClick))
	self.m_progressBtn:setMax(100)
	self.m_progressBtn:getChild("rewardLoader"):setVisible(false)
	self.m_touchBg:addClickListener(handler(self, self._onTouchBgEnd))
	self.m_touchBg:setVisible(false)
	self.m_stageBtnMain:getChild("touch"):addClickListener(handler(self, self._onClickMainStageBtnClick))

	for iter_5_0 = var_0_3.JIAO_GUO, var_0_3.LI_JIN do
		self["m_stageBtn" .. iter_5_0 % var_0_3.JIAO_GUO + 2]:setStageType(iter_5_0)
	end

	self.m_effLizi:addEffectSpine({
		remove = false,
		name = "eff_ui_TowerHardBuild_liziBg",
		isLoop = true,
		anim = "play"
	})
end

function TowerHardMainLayer:_onProgressBubbleClick()
	if var_0_4:canGetHangupReward() then
		self._isSelectBubble = true

		g.core.network.GameNetProxy:send_C2S_Tower_HangupAward({
			play_type = 2
		})
	end
end

function TowerHardMainLayer:_onTouchBgEnd()
	self:closeChallengeComp()
end

function TowerHardMainLayer:_onClickMainStageBtnClick()
	local var_8_0, var_8_1, var_8_2 = var_0_4:getCurTowerIdByType(var_0_3.MAIN)

	if var_8_2 then
		var_0_5:tip(g.core.lang:get(308014))

		return
	end

	if var_0_0:getLeftCount(var_0_2.ShopConst.PLAY_TYPE.TOWER_HARD_CHALLENGE_COUNT_MAIN) <= 0 then
		var_0_5:tip(g.core.lang:get(308024))

		return
	end

	if var_0_4:getMainTowerIsOpen() then
		self.m_uiShowTransition:stop()
		self.m_uiHideTransition:play()

		if self._challengeComp == nil then
			self._challengeComp = fgui.UIPackage:createObject("tower", "TowerHardMainChallengeComp")

			self._challengeComp:initView()
			self._challengeComp:setSize(565, 750)
			self._challengeComp:setPivot(1, 0.5, true)
			self.m_challageComp:addChild(self._challengeComp)
			self.m_touchBg:setVisible(true)
			self.m_topBar:setVisible(false)
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_OPEN_VOTE_GIFT_POP)
		end
	else
		var_0_5:tip(g.core.lang:get(308011))
	end
end

function TowerHardMainLayer:receiveCompEvent(arg_9_1, arg_9_2)
	if arg_9_1 == "TowerHardMainChallengeComp_remove" then
		self:closeChallengeComp()
	elseif arg_9_1 == "TowerHardSubStageLayer_update" then
		self:updateView()
	end
end

function TowerHardMainLayer:_onShopBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.FUNCTION_TYPE.PLAY_SHOP, nil, true) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
			shopValue = 1,
			tabType = var_0_2.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
			shopType = var_0_2.ShopConst.SHOP_TYPE.TOWER_HARD
		})
	end
end

function TowerHardMainLayer:_onRankRewardBtnClick()
	var_0_5:pushPopup(require("app.view.module.tower.view.hard.TowerHardRankRewardPop").new(), {
		ignoreTouch = false,
		touchDisappear = false
	})
end

function TowerHardMainLayer:_onCollectionPlatformPopClick()
	var_0_5:pushPopup(require("app.view.module.tower.view.hard.TowerHardCollectionPlatformPop").new(), {
		hideContinue = true,
		touchDisappear = false
	})
end

function TowerHardMainLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.sound.SoundManager:playMusic(var_0_2.SoundConst.BGM.MUSIC_TOWER_LAYER)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_CHALLENGESTAGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_GETINFO, self._onGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPAWARD, self._onRecHangUpReward, self)
	g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({
		play_type = 2
	})
end

function TowerHardMainLayer:_onRecHangUpReward(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3 then
		var_0_5:awardSummary(arg_14_3.awards, true)
		self:updateProgressBtn()

		if self._isSelectBubble then
			self._isSelectBubble = false

			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TOWER_BUBBLE_GET)
		end
	end
end

function TowerHardMainLayer:pushCapacityPop()
	local var_15_0 = {}

	var_15_0.touchDisappear = true
	var_15_0.hideContinue = true
	var_15_0.blackOpacity = 0.7
	var_15_0.withoutAni = true
	var_15_0.ignoreTouch = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = true,
		data = var_0_4:getCapacityAddListData(var_0_3.MAIN),
		title = g.core.lang:get(308018),
		func = handler(self, self.updateView),
		showComp = fgui.UIPackage:createObject("tower", "TowerCapacotyUpPop")
	}), var_15_0)
end

function TowerHardMainLayer:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({
		play_type = 2
	})
end

function TowerHardMainLayer:_onGetInfo(arg_17_1)
	if var_0_4:getRunSpeedAddEffect() then
		self:pushCapacityPop()
	else
		self:updateView()
	end
end

function TowerHardMainLayer:_onRcvBattleBegin(arg_18_1, arg_18_2, arg_18_3)
	self:closeChallengeComp()

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		bgId = 126,
		cloudLoading = true,
		type = BattleConst.TYPE_TOWER,
		battle_id = arg_18_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
end

function TowerHardMainLayer:updateView()
	self:updateStageView()
	self:updateStageBtn()
	self:updateProgressBtn()
	self:updateMainTowerProgress()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_rankRewardBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_CollectionPlatfpomBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
end

function TowerHardMainLayer:updateMainTowerProgress()
	self.m_bgNode:updateMainTowerProgress()
	self.m_stageBtnMain:updateBtn()
end

function TowerHardMainLayer:updateProgressBtn()
	local var_21_0 = var_0_4:getHangUpRewardData()
	local var_21_1, var_21_2 = var_0_4:getCurRealHangupTimeAndProgress()

	if #var_21_0 > 0 and var_21_2 * 100 >= 1 then
		self.m_progressBtn:setValue(var_21_2 * 100)
		self.m_progressBtn:getChild("rewardLoader"):setURL(var_0_1:convert(var_21_0[1]).icon or "")
		self.m_progressBtn:setVisible(true)
	else
		self.m_progressBtn:setVisible(false)
	end

	self.m_bgNode:updateBubbleEffect()
end

function TowerHardMainLayer:updateStageView()
	self.m_bgNode:updateEffectView()
	self:_updateMainEffect()
end

function TowerHardMainLayer:_addTowerEffect(arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	return (arg_23_1:addEffectSpine({
		name = arg_23_2,
		isLoop = arg_23_3,
		anim = arg_23_4,
		remove = arg_23_5
	}))
end

function TowerHardMainLayer:updateStageBtn()
	for iter_24_0 = var_0_3.JIAO_GUO, var_0_3.LI_JIN do
		if self["m_stageBtn" .. iter_24_0 % var_0_3.JIAO_GUO + 2] then
			self["m_stageBtn" .. iter_24_0 % var_0_3.JIAO_GUO + 2]:updateBtn(iter_24_0)
		end
	end

	self.m_bgNode:updateBuildEffectView()
end

function TowerHardMainLayer:closeChallengeComp()
	if self._challengeComp ~= nil then
		self._challengeComp.m_backTransition:play(function()
			self._challengeComp:removeSelf()

			self._challengeComp = nil
		end)
	end

	self.m_touchBg:setVisible(false)
	self.m_uiHideTransition:stop()
	self.m_uiShowTransition:play()
	self.m_topBar:setVisible(true)
end

function TowerHardMainLayer:onUnload()
	var_0_4:setRunSpeedAddEffect(false)
end

return TowerHardMainLayer
