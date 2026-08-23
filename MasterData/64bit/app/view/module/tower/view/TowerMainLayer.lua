local var_0_0 = g.core.model.User.shopData
local var_0_1 = g.core.common.Goods
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.TowerConst
local var_0_4 = g.core.model.User.towerData
local var_0_5 = g.core.module.ModuleManager
local TowerMainLayer = class("TowerMainLayer", require("app.fairyGUI.tower.UI_TowerMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/tower/tower",
		resName = "TowerMainLayer",
		pkgName = "tower",
		isFullScreen = true
	}, ...)
end)

function TowerMainLayer:ctor()
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
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TOWER)
end

function TowerMainLayer:playEnterEndAni()
	self.m_progressBtn:getChild("rewardLoader"):setVisible(true)

	local var_3_0, var_3_1 = var_0_4:getCurRealHangupTimeAndProgress()

	if var_3_1 < 50 then
		-- block empty
	end

	self.m_progressBtn:getChild("effectNode"):addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_tower_bubble",
		anim = "play"
	})
end

function TowerMainLayer:_initView()
	self.m_topBar:setResInfoById(97)
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

	for iter_4_0 = var_0_3.STAGE_TYPE.JIAO_GUO, var_0_3.STAGE_TYPE.LI_JIN do
		self["m_stageBtn" .. iter_4_0]:setStageType(iter_4_0)
	end
end

function TowerMainLayer:_onProgressBubbleClick()
	if var_0_4:canGetHangupReward() then
		self._isSelectBubble = true

		g.core.network.GameNetProxy:send_C2S_Tower_HangupAward({})
	end
end

function TowerMainLayer:_onTouchBgEnd()
	self:closeChallengeComp()
end

function TowerMainLayer:_onClickMainStageBtnClick()
	local var_7_0, var_7_1, var_7_2 = var_0_4:getCurTowerIdByType(var_0_3.STAGE_TYPE.MAIN)

	if var_7_2 then
		var_0_5:tip(g.core.lang:get(308014))

		return
	end

	if var_0_0:getLeftCount(var_0_2.ShopConst.PLAY_TYPE.TOWER_CHALLENGE_COUNT_MAIN) <= 0 then
		var_0_5:tip(g.core.lang:get(308024))

		return
	end

	if var_0_4:getMainTowerIsOpen() then
		self.m_uiShowTransition:stop()
		self.m_uiHideTransition:play()

		if self._challengeComp == nil then
			self._challengeComp = fgui.UIPackage:createObject("tower", "TowerMainChallengeComp")

			self._challengeComp:initView()
			self._challengeComp:setSize(565, 750)
			self._challengeComp:setPivot(1, 0.5, true)
			self.m_challageComp:addChild(self._challengeComp)
			self.m_touchBg:setVisible(true)
			self.m_topBar:setVisible(false)
		end
	else
		var_0_5:tip(g.core.lang:get(308011))
	end
end

function TowerMainLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "TowerMainChallengeComp_remove" then
		self:closeChallengeComp()
	elseif arg_8_1 == "TowerSubStageLayer_update" then
		self:updateView()
	end
end

function TowerMainLayer:_onShopBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(var_0_2.FUNCTION_TYPE.PLAY_SHOP, nil, true) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
			tabType = var_0_2.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
			shopType = var_0_2.ShopConst.SHOP_TYPE.TOWER,
			shopValue = var_0_3.TOWER_DIFFICULTY.NORMAL
		})
	end
end

function TowerMainLayer:_onRankRewardBtnClick()
	var_0_5:pushPopup(require("app.view.module.tower.view.TowerRankRewardPop").new(), {
		ignoreTouch = false,
		touchDisappear = false
	})
end

function TowerMainLayer:_onCollectionPlatformPopClick()
	var_0_5:pushPopup(require("app.view.module.tower.view.TowerCollectionPlatformPop").new(), {
		hideContinue = true,
		touchDisappear = false
	})
end

function TowerMainLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	g.core.sound.SoundManager:playMusic(var_0_2.SoundConst.BGM.MUSIC_TOWER_LAYER)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_CHALLENGESTAGEBEGIN, self._onRcvBattleBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_GETINFO, self._onGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._onCrossDay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TOWER_HANGUPAWARD, self._onRecHangUpReward, self)
	g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
end

function TowerMainLayer:_onRecHangUpReward(arg_13_1, arg_13_2, arg_13_3)
	if arg_13_3 then
		var_0_5:awardSummary(arg_13_3.awards, true)
		self:updateProgressBtn()

		if self._isSelectBubble then
			self._isSelectBubble = false

			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.TOWER_BUBBLE_GET)
		end
	end
end

function TowerMainLayer:pushCapacityPop()
	local var_14_0 = {}

	var_14_0.touchDisappear = true
	var_14_0.hideContinue = true
	var_14_0.blackOpacity = 0.7
	var_14_0.withoutAni = true
	var_14_0.ignoreTouch = true

	g.core.module.ModuleManager:pushPopup(require("app.view.base.show.BaseFeedBackPopNew").new({
		autoDisappear = true,
		data = var_0_4:getCapacityAddListData(var_0_3.STAGE_TYPE.MAIN),
		title = g.core.lang:get(308018),
		func = handler(self, self.updateView),
		showComp = fgui.UIPackage:createObject("tower", "TowerCapacotyUpPop")
	}), var_14_0)
end

function TowerMainLayer:_onCrossDay()
	g.core.network.GameNetProxy:send_C2S_Tower_GetInfo({})
end

function TowerMainLayer:_onGetInfo(arg_16_1)
	if var_0_4:getRunSpeedAddEffect() then
		self:pushCapacityPop()
	else
		self:updateView()
	end
end

function TowerMainLayer:_onRcvBattleBegin(arg_17_1, arg_17_2, arg_17_3)
	self:closeChallengeComp()

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		canSkip = true,
		bgId = 126,
		cloudLoading = true,
		type = BattleConst.TYPE_TOWER,
		battle_id = arg_17_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVE
	})
end

function TowerMainLayer:updateView()
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

function TowerMainLayer:updateMainTowerProgress()
	self.m_bgNode:updateMainTowerProgress()
	self.m_stageBtnMain:updateBtn()
end

function TowerMainLayer:updateProgressBtn()
	local var_20_0 = var_0_4:getHangUpRewardData()
	local var_20_1, var_20_2 = var_0_4:getCurRealHangupTimeAndProgress()

	if #var_20_0 > 0 and var_20_2 * 100 >= 1 then
		self.m_progressBtn:setValue(var_20_2 * 100)
		self.m_progressBtn:getChild("rewardLoader"):setURL(var_0_1:convert(var_20_0[1]).icon or "")
		self.m_progressBtn:setVisible(true)
	else
		self.m_progressBtn:setVisible(false)
	end

	self.m_bgNode:updateBubbleEffect()
end

function TowerMainLayer:updateStageView()
	self.m_bgNode:updateEffectView()
end

function TowerMainLayer:_addTowerEffect(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	return (arg_22_1:addEffectSpine({
		name = arg_22_2,
		isLoop = arg_22_3,
		anim = arg_22_4,
		remove = arg_22_5
	}))
end

function TowerMainLayer:updateStageBtn()
	for iter_23_0 = var_0_3.STAGE_TYPE.JIAO_GUO, var_0_3.STAGE_TYPE.LI_JIN do
		if self["m_stageBtn" .. iter_23_0] then
			self["m_stageBtn" .. iter_23_0]:updateBtn(iter_23_0)
		end
	end

	self.m_bgNode:updateBuildEffectView()
end

function TowerMainLayer:closeChallengeComp()
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

function TowerMainLayer:onUnload()
	var_0_4:setRunSpeedAddEffect(false)
end

return TowerMainLayer
