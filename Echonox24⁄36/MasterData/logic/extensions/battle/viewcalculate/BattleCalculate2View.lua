-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleCalculate2View.lua

module("logic.extensions.battle.viewcalculate.BattleCalculate2View", package.seeall)

local BattleCalculate2View = class("BattleCalculate2View", ViewComponent)
local Step = {
	Reward = 3,
	Hero = 2
}
local OPEN_ANIM = "open1"
local STAR_2_HERO_ANIM = "1-2"
local HERO_2_REWARD_ANIM = "2-3"
local AUTO_CONTINUE_TIME = 3

function BattleCalculate2View:ctor()
	return
end

function BattleCalculate2View:buildUI()
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))

	local operationalReportPanel = goutil.findChild(self.mainGO, "operationalReportPanel")
	local goEventTrigger = goutil.findChild(self.mainGO, "clickEventTrigger")

	self._clickTrigger = Astral.UIClickTrigger.Get(goEventTrigger)
	self._txtChapterName = goutil.findChildComponent(operationalReportPanel, "txtTitle1", UIComponentType.Text)
	self._txtFbName = goutil.findChildComponent(operationalReportPanel, "txtTitle2", UIComponentType.Text)

	local heros_info = goutil.findChild(operationalReportPanel, "infoContent/heros_info")

	self._heros_info = heros_info

	local levelInfo = goutil.findChild(heros_info, "levelInfo")

	self._imgExpProgress = goutil.findChildComponent(levelInfo, "imgSliderValue", UIComponentType.Image)
	self._imgExpProgressGo = goutil.findChild(levelInfo, "imgSliderValue")
	self._expProgressView = Astral.SimpleLuaComponentContainer.Add(self._imgExpProgressGo, BattleCalculateExpProgress)
	self._txtLevel = goutil.findChildComponent(levelInfo, "txtLevel", UIComponentType.Text)
	self._txtExp = goutil.findChildComponent(levelInfo, "txtNum1", UIComponentType.Text)
	self._txtAddExp = goutil.findChildComponent(levelInfo, "txtNum2", UIComponentType.Text)
	self._heroListPanel = goutil.findChild(heros_info, "Content")
	self._roleHeadItem = goutil.findChild(heros_info, "Content/headitem1")

	goutil.setActive(self._roleHeadItem, false)

	self._crewInfo = goutil.findChild(heros_info, "crewInfo")
	self._headItemList = {}

	local stars_info = goutil.findChild(operationalReportPanel, "infoContent/stars_info")

	self._stars_info = stars_info
	self._resultList = {}

	for i = 1, 3 do
		self._resultList[i] = {}

		local resultItem = goutil.findChild(stars_info, "layout/resultItem" .. i)

		self._resultList[i].root = resultItem
		self._resultList[i].activeObj = goutil.findChild(resultItem, "imgType1")
		self._resultList[i].deActiveObj = goutil.findChild(resultItem, "imgType2")
		self._resultList[i].labDesc = goutil.findChildTextComponent(resultItem, "txtType")
		self._resultList[i].txtPrice = goutil.findChildTextComponent(resultItem, "txtPrice")
		self._resultList[i].priceIcon = goutil.findChildImageComponent(resultItem, "txtPrice/priceIcon")
		self._resultList[i].particle = goutil.findChild(resultItem, "UIParticleNode")
		self._resultList[i].anim = goutil.addComponentOnce(resultItem, ComponentType.Animation)
	end

	local rewards_info = goutil.findChild(operationalReportPanel, "infoContent/rewards_info")

	self._rewards_info = rewards_info
	self._rewardPanel = goutil.findChild(rewards_info, "viewPort/content")
	self._contentLayout = goutil.findChildComponent(rewards_info, "viewPort/content", UIComponentType.LayoutElement)
	self._rewardLayout = goutil.findChildComponent(operationalReportPanel, "infoContent/rewards_info", UIComponentType.LayoutElement)
	self._rewardItem = goutil.findChild(rewards_info, "viewPort/content/backpack_item")

	goutil.setActive(self._rewardItem, false)

	local btnList = goutil.findChild(operationalReportPanel, "btnList")

	self._btnList = btnList
	self._btnQuit = UIComponentType.ButtonAdapter(goutil.findChild(btnList, "btnQuit"))
	self._btnAgain = UIComponentType.ButtonAdapter(goutil.findChild(btnList, "btnAgain"))
	self._btnContinue = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(btnList, "btnContinue"), CommButton)
	self._txtAgent = goutil.findChildComponent(btnList, "txtAgent", UIComponentType.Text)
	self._txtContinueHint = goutil.findChild(operationalReportPanel, "txtContinueHint")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._goProxy = self:getGo("battle_calculate_view_918219175")
	self._btnUnsaveProxy = self:getBtn("battle_calculate_view_878618138")
	self._btnSaveProxy = self:getBtn("battle_calculate_view_-1989117247")

	goutil.setActive(self._txtContinueHint, true)
	goutil.setActive(self._btnList, false)
	goutil.setActive(self._txtAgent.gameObject, false)
end

function BattleCalculate2View:releaseTimer()
	removetimer(self._delayDoBehideGetRoleView, self)
	removetimer(self._setClickEnable, self)
	removetimer(self._showUpgradeLevelFinish, self)
end

function BattleCalculate2View:bindEvents()
	GlobalDispatcher:addEventListener(EventType.GET_ROLE_VIEW_OPEN, self._onGetRoleViewOpen, self)
	self._btnQuit:AddClickListener(self._onClickQuit, self)
	self._btnAgain:AddClickListener(self._onClickRestart, self)
	self._btnContinue:AddClickListener(self._onClickContinue, self)
	self._clickTrigger:AddClickListener(self._onClickFullView, self)
	self._btnUnsaveProxy:AddClickListener(self._onClickUnsaveProxy, self)
	self._btnSaveProxy:AddClickListener(self._onClickSaveProxy, self)
end

function BattleCalculate2View:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.GET_ROLE_VIEW_OPEN, self._onGetRoleViewOpen, self)
	self._btnQuit:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._btnContinue:RemoveClickListener()
	self._clickTrigger:RemoveClickListener()
	self._btnUnsaveProxy:RemoveClickListener()
	self._btnSaveProxy:RemoveClickListener()
end

function BattleCalculate2View:_quit()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if flow then
		local gamePlay = flow.model:getGamePlay()

		if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
			local rewards = BattleMgr.instance:getModel():getConsecutiveRewardsItemDataList(self._curRewardItemMoList)

			if #rewards > 0 then
				local titleStr = lang("tip_gain_item_title_total")

				ToolTipsMgr.showGainItemView({
					showRewardTag = true,
					getLstFromModel = false,
					itemDataList = rewards,
					titleStr = titleStr,
					exitCallBack = function()
						ViewMgr.instance:close(ViewName.BattleCalculateNew)
						BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
					end,
					exitCallBackHandler = self
				}, false)

				return
			end
		end
	end

	ViewMgr.instance:close(ViewName.BattleCalculateNew)
	BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
end

function BattleCalculate2View:_onClickQuit()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if flow then
		local gamePlay = flow.model:getGamePlay()
		local isProxyMode = flow.model:isProxyMode()

		if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
			local isConsecutiveFinish, curRound, maxRound = self:_isConsecutiveFinish()

			if not isConsecutiveFinish then
				self._consecutiveCancelChecking = true

				local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_consecutive_cancel_hint"))

				dialog:setConfirmListener(self._quit, self)
				dialog:setCancelListener(function()
					self._consecutiveCancelChecking = false
				end, self)
				dialog:setCloseListener(function()
					self._consecutiveCancelChecking = false
				end, self)

				return
			end
		end
	end

	self:_quit()
end

function BattleCalculate2View:_checkEnergy(multiCount)
	if self._dungeonMo:getPointCost() * multiCount > ItemModel.instance:getItemCountByItemId(GameEnum.CurrencyCodeEnum.TlCode) then
		ToolTipsMgr.showHealthExchangeTips()

		return false
	end

	return true
end

function BattleCalculate2View:_onClickRestart()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if not flow or not flow:isSupportRestart() then
		FloatWordMgr.instance:show(lang("tip_cannot_battle_again"))

		return
	end

	local dungeonBattleFlow = DungeonController.instance:getDungeonBattleFlow()
	local multiCount = dungeonBattleFlow and dungeonBattleFlow.model:getMultiCount() or 1
	local gamePlay = flow.model:getGamePlay()
	local isProxyMode = flow.model:isProxyMode()

	if gamePlay == BattleEnum.GamePlayType.RECORD then
		if not self:_checkEnergy(multiCount) then
			return
		end

		if DungeonUtil.isControlAction(self._dungeonMo:getType()) then
			ToolTipsMgr.showControlMultiFightView(self._dungeonId, gamePlay)
		else
			local maxMultiCount = self._dungeonMo:getMultiplicityLimit()

			ToolTipsMgr.showMultiFightTipsView(self._dungeonId, maxMultiCount, true, true, gamePlay)
		end
	elseif gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		if not self:_checkEnergy(1) then
			return
		end

		local curRound = flow.model:getConsecutiveRound()

		if multiCount <= curRound then
			if DungeonUtil.isControlAction(self._dungeonMo:getType()) then
				ToolTipsMgr.showControlMultiFightView(self._dungeonId, gamePlay)
			else
				local maxMultiCount = self._dungeonMo:getConsecutiveLimit()

				ToolTipsMgr.showMultiFightTipsView(self._dungeonId, maxMultiCount, true, true, gamePlay)
			end
		end
	else
		if not self:_checkEnergy(multiCount) then
			return
		end

		ViewMgr.instance:close(ViewName.BattleCalculateNew)
		BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.CALCULATE)
	end
end

function BattleCalculate2View:_onClickContinue()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if not flow or not flow:isSupportRestart() then
		FloatWordMgr.instance:show(lang("tip_cannot_battle_again"))

		return
	end

	if self:_isGamePlayEnableContinue() then
		self:_gotoNextBattleLevel()

		return
	end

	local dungeonBattleFlow = DungeonController.instance:getDungeonBattleFlow()
	local multiCount = dungeonBattleFlow and dungeonBattleFlow.model:getMultiCount() or 1
	local gamePlay = flow.model:getGamePlay()

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		local curRound = flow.model:getConsecutiveRound()

		if multiCount <= curRound then
			local maxMultiCount = self._dungeonMo:getConsecutiveLimit()

			ToolTipsMgr.showMultiFightTipsView(self._dungeonId, maxMultiCount, true, true, BattleEnum.GamePlayType.CONSECUTIVE)
		else
			ViewMgr.instance:close(ViewName.BattleCalculateNew)
			BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.CONSECUTIVE)
		end
	end
end

function BattleCalculate2View:_gotoNextBattleLevel()
	local nextDungeonCode = self:_getNextDungeonCode()

	if not nextDungeonCode then
		self:_onClickQuit()

		return
	end

	local dungeonMO = DungeonModel.instance:getDungeonMoById(nextDungeonCode)
	local scoreRate = DungeonModel.instance:getDungeonScoreRate(nextDungeonCode)
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMO:getScoreGroup())
	local scoreRate = DungeonModel.instance:getDungeonScoreRate(nextDungeonCode) * 1000
	local scoreCO = DungeonConfig.instance:getDungeonScoreCOByScore(scoreRate, dungeonMO:getScoreGroup())

	if not DungeonController.instance:tryOpenDangerTips(scoreCO, false) then
		ViewMgr.instance:close(ViewName.BattleCalculateNew)
		BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.TONEXT)
	end
end

function BattleCalculate2View:_getNextDungeonCode()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

	if not dungeonMO then
		return false
	end

	local dungeonType = dungeonMO:getType()

	if dungeonType == CommEnum.DungeonType.LightTower or dungeonType == CommEnum.DungeonType.DarkTower then
		return dungeonMO:getNextDungeonId()
	end

	return false
end

function BattleCalculate2View:_onDungeonDangerTipsConfirm()
	ViewMgr.instance:close(ViewName.BattleCalculateNew)
	BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.TONEXT)
end

function BattleCalculate2View:_onGetRoleViewOpen()
	self._isOpenedGetRoleView = true

	settimer(2, self._delayDoBehideGetRoleView, self, false)
end

function BattleCalculate2View:_delayDoBehideGetRoleView()
	removetimer(self._delayDoBehideGetRoleView, self)
	goutil.setActive(self._btnList, true)
end

function BattleCalculate2View:onEnter()
	self._canvasGroup.interactable = true
	self._isEnter = true

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		self._dungeonId = dungeonCode
		self._dungeonMo = DungeonModel.instance:getDungeonMoById(dungeonCode)
	else
		self._dungeonId = nil
		self._dungeonMo = nil
	end

	self._stepCount = self._stepCount or Step.Hero
	self._bNoStarsInfo = false
	self._bNoHero = false
	self._bNoReward = false
	self._animations = {}
	self._animQueue = self._animQueue or {}

	self:_initAnim()
	self:_initDungeonInfo()
	self:_initStarInfo()
	self:_initProxy()
	self:_updateHeadItemView()
	self:_initReward()
	self:_updateBaseInfoView()

	self._disableClick = true
	self._isOpenedGetRoleView = true
	self._consecutiveCancelChecking = false

	settimer(1.5, self._setClickEnable, self, false)
	self:checkStep()
	self:_setEvent(true)
	BattleCalculateMgr.instance:showPerform()
end

function BattleCalculate2View:_insertAnimQueue(animName)
	if not table.indexof(self._animQueue, animName) then
		table.insert(self._animQueue, animName)
	end
end

function BattleCalculate2View:_initAnim()
	for _, animName in ipairs(self._animQueue) do
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName(animName)
		self._guiAnimation:JumpAniTimeToEnd(animName)
		self._guiAnimation:Evaluate()
	end

	table.insert(self._animations, OPEN_ANIM)
	self:_insertAnimQueue(OPEN_ANIM)
end

function BattleCalculate2View:checkStep()
	local flow = BattleMgr.instance:getActiveBattleFlow()
	local isProxyMode = flow.model:isProxyMode()
	local isConsecutive = flow.model:getGamePlay() == BattleEnum.GamePlayType.CONSECUTIVE
	local isConsecutiveFinish, curRound, maxRound = self:_isConsecutiveFinish()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = false
	local dungeonCO = false

	if dungeonCode then
		dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
		dungeonCO = dungeonMO:getDungeonCO()
	end

	local canRechallenge = dungeonCO and DungeonConfig.instance:getCanRechallenge(dungeonCO.type) or false
	local isVisible = canRechallenge and not isConsecutive
	local isSystemEnableContinue = isConsecutive and not isConsecutiveFinish
	local isGamePlayEnableContinue = self:_isGamePlayEnableContinue()

	if self._stepCount == Step.Hero then
		if self._bNoHero then
			self:pushOn()

			return
		end

		goutil.setActive(self._heros_info, true)
		goutil.setActive(self._rewards_info, false)
		table.insert(self._animations, STAR_2_HERO_ANIM)
		self:_insertAnimQueue(STAR_2_HERO_ANIM)

		if self._bNoReward then
			goutil.setActive(self._txtContinueHint, false)
			goutil.setActive(self._btnAgain.gameObject, isVisible)
			self._btnContinue:setActive(isSystemEnableContinue or isGamePlayEnableContinue)
			goutil.setActive(self._btnList, true)
		end
	elseif self._stepCount == Step.Reward then
		if not self._bNoHero and self._bNoReward then
			self:pushOn()

			return
		end

		goutil.setActive(self._heros_info, false)
		goutil.setActive(self._rewards_info, true)
		table.insert(self._animations, HERO_2_REWARD_ANIM)
		self:_insertAnimQueue(HERO_2_REWARD_ANIM)

		if self._isGetNewRole then
			goutil.setActive(self._btnList, false)
		else
			self._txtAgent.text = langF("tip_proxy_title_consecutive", curRound, maxRound)

			self._btnContinue:setText(lang("tip_battle_calculate_continue"))
			goutil.setActive(self._txtAgent.gameObject, isConsecutive and curRound < maxRound)
			goutil.setActive(self._btnAgain.gameObject, isVisible)
			self._btnContinue:setActive(isSystemEnableContinue or isGamePlayEnableContinue)
			goutil.setActive(self._btnList, true)
		end

		goutil.setActive(self._txtContinueHint, false)
	elseif self._stepCount > Step.Reward then
		return
	end

	self:tryPlayAni()
end

function BattleCalculate2View:_isGamePlayEnableContinue()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

	if not dungeonMO then
		return false
	end

	local dungeonType = dungeonMO:getType()

	if dungeonType == CommEnum.DungeonType.LightTower or dungeonType == CommEnum.DungeonType.DarkTower then
		local lastDungeonId = dungeonMO:getLastDungeonId()

		return lastDungeonId ~= dungeonCode
	end
end

function BattleCalculate2View:_showUpgradeLevelFinish()
	removetimer(self._showUpgradeLevelFinish, self)

	if self._isGetNewRole then
		self._isOpenedGetRoleView = false
	end

	BattleCalculateModel.instance:popCacheItemMoList()
end

function BattleCalculate2View:playExpAnim()
	for i, heroItem in ipairs(self._headItemList) do
		heroItem:playExpAni()
	end

	local currentLevel = PlayerModel.instance:getLevel()
	local playMaxLevelInfo = PlayerConfig.instance:getMaxLevelInfo()

	if playMaxLevelInfo and currentLevel >= playMaxLevelInfo.lv then
		self:_addExpFinish()
	else
		self._expProgressView:setCharacterParam(self._characterParam, self._addExpFinish, self)
	end
end

function BattleCalculate2View:_addExpFinish()
	local currentLevel = self._characterParam.newLevel
	local currentExp = self._characterParam.newExp
	local totalExp = PlayerConfig.instance:getExpByLevel(currentLevel)
	local playMaxLevelInfo = PlayerConfig.instance:getMaxLevelInfo()

	self._txtLevel.text = string.format("%d-%d", currentLevel / 10, currentLevel % 10)
	self._txtExp.text = currentExp .. "/" .. totalExp

	if playMaxLevelInfo and currentLevel >= playMaxLevelInfo.lv then
		self._txtExp.text = "Max"
		self._imgExpProgress.fillAmount = 1
	end
end

function BattleCalculate2View:tryPlayAni()
	if #self._animations > 0 then
		local aniName = table.remove(self._animations, 1)

		self._disableClick = true

		settimer(1.5, self._setClickEnable, self, false)

		if aniName == OPEN_ANIM then
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:PlayAniByName(aniName)

			aniName = table.remove(self._animations, 1)
		end

		if aniName == STAR_2_HERO_ANIM then
			self:_delayPlayExpAnim()

			if self._isLevelUp then
				settimer(1, function()
					ToolTipsMgr.showPlayerUpgradeShowView(self._packageInfo)
				end, self, false)
			end
		elseif aniName == HERO_2_REWARD_ANIM then
			self._guiAnimation:PlayAniByName(aniName)
			settimer(1, self._showUpgradeLevelFinish, self, false)
		end
	end
end

function BattleCalculate2View:_setClickEnable()
	removetimer(self._setClickEnable, self)

	self._disableClick = false
end

function BattleCalculate2View:_delayPlayExpAnim()
	self:playExpAnim()
end

function BattleCalculate2View:pushOn()
	self._stepCount = self._stepCount + 1

	self:checkStep()
end

function BattleCalculate2View:_onClickFullView()
	local flow = BattleMgr.instance:getActiveBattleFlow()

	if flow and flow.model:getGamePlay() == BattleEnum.GamePlayType.CONSECUTIVE then
		if Astral.OSDef.isEditor then
			printWarn("连战模式屏蔽点击")
		end

		return
	end

	self:_dealClickFullView()
end

function BattleCalculate2View:_dealClickFullView()
	if self._disableClick then
		return
	end

	if self._stepCount == 3 and not self._isOpenedGetRoleView then
		return
	end

	if ToolTipsController.instance:getInCloseTipsTime() then
		return
	end

	BattleAudioUtil.playSEByName("ui_generic_click")
	self:pushOn()
end

function BattleCalculate2View:_initDungeonInfo()
	if self._dungeonId then
		local index = DungeonModel.instance:getDungeonIndex(self._dungeonId)

		self._txtChapterName.text = index
	end

	self._txtFbName.text = self._dungeonMo:getName()

	local totalKill = 0
	local heroBattleData = BattleCalculateModel.instance:getCalculateHeroBattleData()

	if not heroBattleData then
		return
	end

	for _, heroData in ipairs(heroBattleData) do
		local enemyKilled = heroData.enemyKilled

		totalKill = totalKill + enemyKilled
	end
end

function BattleCalculate2View:_initStarInfo()
	local endStars = DungeonModel.instance:getCacheEndStars()

	if not endStars then
		self._bNoStarsInfo = true

		for i = 1, 3 do
			goutil.setActive(self._resultList[i].root, false)
		end

		return
	end

	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()

	if dungeonCode then
		local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)
		local dungeonCO = dungeonMO:getDungeonCO()
		local starRequire = dungeonCO.starRequire

		if starRequire then
			goutil.setActive(self._stars_info, true)

			for i = 1, 3 do
				goutil.setActive(self._resultList[i].root, true)
				goutil.setActive(self._resultList[i].deActiveObj, not endStars.mergedStars[i])
				goutil.setActive(self._resultList[i].activeObj, endStars.mergedStars[i])
				goutil.setActive(self._resultList[i].txtPrice.gameObject, endStars.currentStars[i])
				goutil.setActive(self._resultList[i].particle, false)

				if endStars.currentStars[i] then
					goutil.setActive(self._resultList[i].particle, true)
					self._resultList[i].anim:Stop()
					self._resultList[i].anim:Play("resultitem_anim")
					TextUtils.SetColor(self._resultList[i].labDesc, "#FEFEFE")

					local rewardId = ConstConfig.instance:getNumValueByKey("DungeonStarReward")
					local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)

					if rewardCO then
						local itemCo = BackpackConfig.instance:getItemInfoByItemId(rewardCO.reward[1].code)

						IconLoader.setSprite(self._resultList[i].priceIcon, IconType.ItemIcon, itemCo.icon)

						self._resultList[i].txtPrice.text = string.format("+%d", rewardCO.reward[1].num)
					end
				elseif not endStars.currentStars[i] and endStars.mergedStars[i] then
					TextUtils.SetColor(self._resultList[i].labDesc, "#FEFEFE")
				else
					TextUtils.SetColor(self._resultList[i].labDesc, "#737373")
				end

				local dungeonStarCOWrapper = DungeonConfig.instance:getDungeonStarCOWrapper(starRequire[i])

				self._resultList[i].labDesc.text = dungeonStarCOWrapper:getDescription()
			end
		else
			self._bNoStarsInfo = true

			goutil.setActive(self._stars_info, false)
		end
	end
end

function BattleCalculate2View:_initReward()
	self._rewardItemList = {}

	local moList = {}
	local itemMOList = BattleCalculateModel.instance:getCalculateItemMOList()

	table.insertto(moList, itemMOList)

	self._curRewardItemMoList = itemMOList

	if #moList == 0 then
		self._bNoReward = true

		goutil.setActive(self._rewardPanel, false)

		return
	end

	self._contentLayout.enabled = #moList <= 5 and not self._bNoStarsInfo and true or false

	if #moList > 10 and self._bNoStarsInfo then
		self._rewardLayout.minHeight = 450
	end

	goutil.setActive(self._rewardPanel, true)

	self._isGetNewRole = self._isGetNewRole or false

	for i, info in ipairs(moList) do
		local goRewardItem = goutil.clone(self._rewardItem, "item")

		goutil.setActive(goRewardItem, true)

		goRewardItem.name = "item"

		goutil.addChildToParent(goRewardItem, self._rewardPanel)

		local rewardItem = Astral.SimpleLuaComponentContainer.Get(goRewardItem, BattleCalculateRewardItem)

		if rewardItem == nil then
			rewardItem = Astral.SimpleLuaComponentContainer.Add(goRewardItem, BattleCalculateRewardItem)
		end

		local rewardTag = info:getRewardTag()

		rewardItem:setItemMO(info)
		rewardItem:setSignShow(rewardTag)
		table.insert(self._rewardItemList, rewardItem)
		rewardItem:setClickHeight(0)

		if ItemUtil.isCharacterById(info:getItemId()) and self._isGetNewRole == nil then
			self._isGetNewRole = true
		end
	end
end

function BattleCalculate2View:_updateBaseInfoView()
	local entityIds = BattleCalculateModel.instance:getCalculateHeroIdList()

	if not entityIds or #entityIds == 0 then
		return
	end

	local currentLevel = PlayerModel.instance:getLevel()
	local prePlayLevelInfo = BattleCalculateModel.instance:getPlayerLevelInfo()
	local preLevel = prePlayLevelInfo.level or 0
	local preExp = prePlayLevelInfo.exp or 0

	self._isLevelUp = preLevel < currentLevel

	if self._isLevelUp then
		self._packageInfo = {
			currentLevel = currentLevel
		}
	end

	local currentExp = PlayerModel.instance:getExp()
	local preTotalExp = PlayerConfig.instance:getExpByLevel(preLevel)
	local characterParam = {}

	characterParam.newLevel = currentLevel
	characterParam.newExp = currentExp
	characterParam.oldLevel = preLevel
	characterParam.oldExp = preExp
	self._characterParam = characterParam
	self._txtLevel.text = string.format("%d-%d", preLevel / 10, preLevel % 10)
	self._txtExp.text = preExp .. "/" .. preTotalExp

	local increaseExp = PlayerConfig.instance:getIncreaseExp(characterParam)

	self._txtAddExp.text = "+" .. increaseExp
end

function BattleCalculate2View:_updateHeadItemView()
	local _tmpHeroList = HeroDepotModel.instance:getHeroDepotData():getShowDataList()
	local sortData = CharacterUtil.SortAndFitler(CommEnum.HeroFilter.Battle, _tmpHeroList:getMoList())
	local tmpList = BattleCalculateModel.instance:getCalculateHeroIdList()
	local map = {}

	for _, id in ipairs(tmpList) do
		map[id] = true
	end

	local heroIdList = {}

	for _, co in ipairs(sortData) do
		local id = co:getId()

		if map[id] then
			table.insert(heroIdList, id)
		end
	end

	local len = #heroIdList

	if len == 0 then
		self._bNoHero = true
	end

	goutil.setActive(self._heroListPanel, len > 0)
	goutil.setActive(self._crewInfo, len == 0)

	for index, heroId in ipairs(heroIdList) do
		local heroItem = self._headItemList[index]

		if not heroItem then
			local goHeroItem = goutil.cloneAndSetParent(self._roleHeadItem.gameObject, self._heroListPanel.transform, string.format("heroitem_%s", heroId))

			goutil.setActive(goHeroItem, true)

			heroItem = Astral.SimpleLuaComponentContainer.Add(goHeroItem, BattleCalculateHeadItem)
			self._headItemList[index] = heroItem
		else
			goutil.setActive(heroItem.mainGO, true)
		end

		if heroItem then
			heroItem:setHeroId(heroId)
		end
	end

	local index = #heroIdList
	local maxItemCount = #self._headItemList

	while index < maxItemCount do
		index = index + 1

		local heroItem = self._headItemList[index]

		goutil.setActive(heroItem.mainGO, false)
	end
end

function BattleCalculate2View:_initProxy()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonType = DungeonModel.instance:getDungeonTypeByCfg(dungeonCode)
	local battleFllow = BattleMgr.instance:getActiveBattleFlow()
	local proxyMode = battleFllow and battleFllow.model:isProxyMode()
	local gamePlay = battleFllow and battleFllow.model:getGamePlay()
	local canSaveProxy = false

	if self._dungeonMo:canRecord() and battleFllow.model:isWin() and not DungeonModel.instance:isFirstPassed() then
		canSaveProxy = not proxyMode
	end

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		canSaveProxy = false
	end

	if dungeonType == CommEnum.DungeonType.Mainline and DungeonMainLineChapterModel.instance:isTeachDungeon(dungeonCode) then
		canSaveProxy = false
	end

	if enableLog then
		printWarn(string.format("dungeonCode:%s dungeonType:%s gamePlay:%s canRecord:%s isWin:%s isFirstPassed:%s canSaveProxy:%s", dungeonCode, dungeonType, gamePlay, self._dungeonMo:canRecord(), battleFllow.model:isWin(), DungeonModel.instance:isFirstPassed(), canSaveProxy))
	end

	goutil.setActive(self._goProxy, canSaveProxy)
end

function BattleCalculate2View:_onClickUnsaveProxy()
	goutil.setActive(self._goProxy, false)
end

function BattleCalculate2View:_onClickSaveProxy()
	goutil.setActive(self._goProxy, false)
	DungeonAgent.instance:SendSaveLastRecordRequest()
end

function BattleCalculate2View:onExit()
	self._canvasGroup.interactable = false
	self._isEnter = false
	self._curRewardItemMoList = nil

	for _, rewardItem in ipairs(self._rewardItemList or {}) do
		UnityEngine.GameObject.Destroy(rewardItem.mainGO)
	end

	self._rewardItemList = {}

	BattleCalculateMgr.instance:hidePerform()
	self:releaseTimer()
	self:_setEvent(false)
end

function BattleCalculate2View:destroyUI()
	BattleCalculateMgr.instance:stopVictoryPerformance()
	DungeonModel.instance:clearCacheEndStars()

	self._stepCount = Step.Star
	self._bNoStarsInfo = false
	self._bNoHero = false
	self._bNoReward = false
	self._disableClick = true
	self._isOpenedGetRoleView = true
	self._animations = {}
	self._dungeonId = nil
	self._dungeonMo = nil
	self._disableClick = false
	self._isGetNewRole = nil
	self._animQueue = nil
end

function BattleCalculate2View:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleItemChangedPush, self)
		GlobalDispatcher:addEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._multiFightConfirm, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._handleTickSecond, self)
		GlobalDispatcher:addEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._onDungeonDangerTipsConfirm, self)
		GlobalDispatcher:addEventListener(EventType.DISCONNENT_SERVER_EVENT, self._onDisconnectServer, self)
	else
		GlobalDispatcher:removeEventListener(EventType.GAIN_ITEM_CHANGE_EVENT, self._handleItemChangedPush, self)
		GlobalDispatcher:removeEventListener(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, self._multiFightConfirm, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKSECOND, self._handleTickSecond, self)
		GlobalDispatcher:removeEventListener(EventType.ON_DUNGEON_DANGER_TIPS_CONFIRM, self._onDungeonDangerTipsConfirm, self)
		GlobalDispatcher:removeEventListener(EventType.DISCONNENT_SERVER_EVENT, self._onDisconnectServer, self)
	end
end

function BattleCalculate2View:_handleItemChangedPush(e, msg)
	if msg and msg.optType == GameEnum.OptionType.ITEM_LOCK then
		for _, cell in pairs(self._rewardItemList or {}) do
			if cell then
				cell:refreshLock()
			end
		end
	end
end

function BattleCalculate2View:_onDisconnectServer()
	self._isEnter = false

	if enableLog then
		printWarn("onDisconnectServer")
	end
end

function BattleCalculate2View:_handleTickSecond(e)
	if not self._isEnter then
		return
	end

	local flow = BattleMgr.instance:getActiveBattleFlow()
	local gamePlay = flow.model:getGamePlay()

	if gamePlay ~= BattleEnum.GamePlayType.CONSECUTIVE then
		return
	end

	if self._stepCount <= Step.Reward then
		self:_dealClickFullView()
	end

	if self._stepCount == Step.Reward then
		local isConsecutiveFinish, curRound, maxRound = self:_isConsecutiveFinish()

		self._autoContinue = isConsecutiveFinish and 1 or AUTO_CONTINUE_TIME

		self._btnContinue:setText(langF("tip_consecutive_btn", self._autoContinue))
	elseif self._stepCount > Step.Reward then
		local time = self._autoContinue

		if not self._consecutiveCancelChecking then
			time = self._autoContinue - 1
			self._autoContinue = time <= 0 and 0 or time
		end

		self._btnContinue:setText(langF("tip_consecutive_btn", self._autoContinue))

		local isConsecutiveFinish, curRound, maxRound = self:_isConsecutiveFinish()

		if time == 0 then
			if isConsecutiveFinish then
				self:_quit()
			else
				self:_onClickContinue()
			end
		end
	end
end

function BattleCalculate2View:_multiFightConfirm(_, info)
	ViewMgr.instance:close(ViewName.BattleCalculateNew)

	local flow = BattleMgr.instance:getActiveBattleFlow()

	if flow then
		flow.model:setMultiCount(info.multiCount)
		flow.model:setGamePlay(info.gamePlay)
		flow.model:setConsecutiveRound(1)
		flow.model:setConsecutiveRewards(nil)
	end

	BattleMgr.instance:userRequestRestart(BattleEnum.RestartType.CALCULATE)
end

function BattleCalculate2View:_isConsecutiveFinish()
	local flow = BattleMgr.instance:getActiveBattleFlow()
	local curRound = flow.model:getConsecutiveRound()
	local gamePlay = flow.model:getGamePlay()
	local dungeonBattleFlow = DungeonController.instance:getDungeonBattleFlow()
	local multiCount = dungeonBattleFlow and dungeonBattleFlow.model:getMultiCount() or 1

	if gamePlay == BattleEnum.GamePlayType.CONSECUTIVE then
		return multiCount <= curRound, curRound, multiCount
	end

	return false, curRound, multiCount
end

function BattleCalculate2View:resetUI()
	return
end

function BattleCalculate2View:resetAllView()
	return
end

return BattleCalculate2View
