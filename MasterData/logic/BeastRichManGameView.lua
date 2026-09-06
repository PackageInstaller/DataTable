-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/beastrichman/view/BeastRichManGameView.lua

module("logic.extensions.beastrichman.view.BeastRichManGameView", package.seeall)

local BeastRichManGameView = class("BeastRichManGameView", ViewComponent)

function BeastRichManGameView:ctor()
	BeastRichManGameView.super.ctor(self)
end

function BeastRichManGameView:unbindEvents()
	BeastRichManGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRandomDice)
	GameUtil.rmClickHandler(self._btnFixDice)
	GameUtil.rmClickHandler(self._btnCard)
	GameUtil.rmClickHandler(self._btnOpenEvent)
	GameUtil.rmClickHandler(self._btnResTips)
	GameUtil.rmClickHandler(self._coin)
	GameUtil.rmClickHandler(self._btnPos)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
end

function BeastRichManGameView:bindEvents()
	BeastRichManGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRandomDice, self._onClickRandomDice, self)
	GameUtil.addClickHandler(self._btnFixDice, self._onClickFixDice, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnOpenEvent, self._onClickBtnOpenEvent, self)
	GameUtil.addClickHandler(self._btnResTips, self._onClickResTips, self)
	GameUtil.addClickHandler(self._coin, self._onClickCoin, self)
	GameUtil.addClickHandler(self._btnPos, self._onClickBtnPos, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnSkip:AddClickListener(self._onClickbtnSkip, self)
end

function BeastRichManGameView:buildUI()
	BeastRichManGameView.super.buildUI(self)

	self._map = self:getGo("map")
	self._eventTrick = self:getGo("tableview/viewport/content/eventTrick")
	self._tableview = self:getGo("tableview")
	self._content = self:getGo("tableview/viewport/content")
	self._cell = self:getGo("cell")
	self._bg = self:getGo("tableview/viewport/content/bg")
	self._eventFrontRoot = self:getGo("tableview/viewport/content/eventFrontRoot")
	self._eventBackRoot = self:getGo("tableview/viewport/content/eventBackRoot")
	self._bgRoot = self:getGo("tableview/viewport/content/bgRoot")
	self._pathRoot = self:getGo("tableview/viewport/content/pathRoot")
	self._templetPath = self:getGo("cellTemplet/templetPath")
	self._templetEvent = self:getGo("cellTemplet/templetEvent")
	self._templetBg = self:getGo("cellTemplet/templetBg")
	self._templetBoss = self:getGo("cellTemplet/templetBoss")

	goutil.setActive(self._templetBg, false)
	goutil.setActive(self._templetPath, false)
	goutil.setActive(self._templetEvent, false)
	goutil.setActive(self._templetBoss, false)

	self._player = self:getGo("tableview/viewport/content/player")
	self._playerTouming = self:getGo("tableview/viewport/content/playerTouming")
	self._btnOpenEvent = self:getGo("tableview/viewport/content/btnOpenEvent")
	self._txtOpenEvent = self:getTxt("tableview/viewport/content/btnOpenEvent/txtOpenEvent")
	self._coin = self:getGo("coin")
	self._txtNumCoin = self:getTxt("coin/txtNum")
	self._iconCoin = self:getGo("coin/icon")
	self._btnRandomDice = self:getGo("lightCol/btnRandomDice")
	self._btnFixDice = self:getGo("lightCol/btnFixDice")
	self._imgRedRandomDice = self:getGo("lightCol/btnRandomDice/imgRed")
	self._imgRedFixDice = self:getGo("lightCol/btnFixDice/imgRed")
	self._btnPos = self:getGo("lightCol/btnPos")
	self._btnCard = self:getGo("lightCol/btnCard")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnResTips = self:getGo("lightCol/btnResTips")
	self._imgRedResTips = self:getGo("lightCol/btnResTips/imgRed")
	self._txtDiceRandom = self:getTxt("lightCol/btnRandomDice/txtDiceHave")
	self._txtDiceFix = self:getTxt("lightCol/btnFixDice/txtDiceHave")
	self._eff = self:getGo("tableview/viewport/content/eff")
	self._createRoot = self:getGo("createRoot")
	self._btnSkip = self:getBtn("lightCol/btnDiceAnim/btnSkip")
	self._checkmarkGo = self:getGo("lightCol/btnDiceAnim/Toggle/Background/Checkmark")
	self._txtPrize = self:getTxt("lightCol/btnResTips/txt")
	self._diceCol = {}

	local mainGo = goutil.findChild(self.mainGO, "uiTopCol/diceCol")

	self._diceCol._mainGo = mainGo
	self._diceCol._diceHandlerList = {}

	for idx = 1, 3 do
		local diceView = goutil.findChild(mainGo, string.format("diceView_%s", 1))
		local diceHandler = RichManXplanDiceHandler.New()

		diceHandler:initFromGo(diceView, 3)

		self._diceCol._diceHandlerList[idx] = diceHandler
	end

	local cameraGo = self:getGo("uiTopCol/diceCol/diceView_1/camera")

	self._diceGos = {}

	for idx = 1, cameraGo.transform.childCount do
		self._diceGos[idx] = goutil.findChild(cameraGo, "go_" .. idx)

		goutil.setActive(self._diceGos[idx], false)
	end

	self._clickMask = goutil.findChild(self.mainGO, "uiTopCol/clickMask")
end

function BeastRichManGameView:onExit()
	BeastRichManGameView.super.onExit(self)
	BeastRichManMapMgr.instance:clear()

	if self._eff then
		self:stopViewEffectUniGo(self._eff)

		self._eff = nil
	end

	self:_clearDice()
	self:_blockClick(false)
	MaterialMgr.clearIcon(self._iconCoin)
	uGuiUtil.clearImage(self._bg)
	removetimer(self._tickTime, self)
end

function BeastRichManGameView:onEnter()
	BeastRichManGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.BeastRichManInfoRes, self._onBeastRichManInfoRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManMoveRes, self._onMoveRes, self)
	self.addGEvent(self, GlobalNotify.EndStory, self._onEndStory, self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleGridRes, self._onBeastRichManHandleGridRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManHandleEventRes, self._onBeastRichManHandleEventRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManBuildingLevelUp, self._onBeastRichManBuildingLevelUp, self)
	self.addGEvent(self, GlobalNotify.BeastRichManGainHangingRes, self._onBeastRichManGainHangingRes, self)
	self.addGEvent(self, GlobalNotify.BeastRichManOpenClickMask, self._onBeastRichManOpenClickMask, self)
	self.addGEvent(self, GlobalNotify.BeastRichManUseCardRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 558001
	end

	self._zoneId = 1

	if checknumber(params[2]) > 0 then
		self._zoneId = checknumber(params[2])
	end

	self._actCfg = BeastRichmanConfig.instance:getActCfg(self._activityId)
	self._bossEachHangingPrize = BeastRichmanController.instance:getBossEachHangingPrize(self._activityId, self._zoneId)
	self._mapCfg = BeastRichmanConfig.instance:getZoneCfgById(self._activityId, self._zoneId)
	self._diceCfgs = BeastRichmanConfig.instance:getDiceCfgs(self._activityId)
	self._hasUsedStopCard = false

	BeastRichManMapMgr.instance:setComplateInstance(BeastRichManEnum.MapGoType.Path, self._templetPath)
	BeastRichManMapMgr.instance:setComplateInstance(BeastRichManEnum.MapGoType.Bg, self._templetBg)
	BeastRichManMapMgr.instance:setComplateInstance(BeastRichManEnum.MapGoType.Event, self._templetEvent)
	BeastRichManMapMgr.instance:setComplateInstance(BeastRichManEnum.MapGoType.Boss, self._templetBoss)
	self:_initUI()
	self:_initMap()
	self:_updateHangingUI()
	BeastRichmanController.instance:sendPM_BeastRichManInfoReq(self._activityId)
end

function BeastRichManGameView:_tryPlayStory()
	local storyId = self._mapCfg.storyId

	if storyId > 0 then
		local key = string.format("BeastRichManGameView_%s_%s", self._activityId, self._zoneId)

		local function firstCallback()
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, storyId, StoryModel.StoryType.SCCopy)
		end

		GameUtil.doCallbackWhenFirst(key, firstCallback)
	end
end

function BeastRichManGameView:_initUI()
	local scoreMatStr = self._actCfg.scoreMatStr
	local matType, matId, matNum = MaterialMgr.getMatParams(scoreMatStr)

	MaterialMgr.setIcon(self._iconCoin, matType, matId, nil, nil)
end

function BeastRichManGameView:_initMap()
	BeastRichManMapMgr.instance:initParam(self._activityId, self._zoneId, self._content)
	BeastRichManMapMgr.instance:createMap()

	local playerPosX, playerPosY = BeastRichManMapMgr.instance:getPathCellPos(1)

	BeastRichManPlayerMgr.instance:initParam(self._activityId, self._zoneId, self._player, self._playerTouming, playerPosX, playerPosY, self, self._tableview)
	uGuiUtil.clearImage(self._bg)

	local name = self._mapCfg.zoneImgName
	local path = string.format("ui/bigbg/game/beastrichman/%s.png", name)

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, path)
	GameUtil.SetActive(self._templetPath, false)
	GameUtil.SetActive(self._templetBg, false)
	GameUtil.SetActive(self._templetEvent, false)
	GameUtil.SetActive(self._cell, false)
	GameUtil.SetActive(self._btnOpenEvent, true)

	self._isSkipDiceAnim = BeastRichmanController.instance:getIsSkipDiceAnim()

	local key = string.format("BeastrichmanSkipDiceAnim_%s", self._activityId)

	self._isSkipDiceAnim = GameUtil.getUserData(key, self._isSkipDiceAnim)

	self:_updateSkipDiceAnimState()
end

function BeastRichManGameView:_tryTickHangingPrize()
	if self._bossEachHangingPrize <= 0 then
		return
	end

	self._enterTime = ServerTime.now()
	self._totalTickTime = 0

	removetimer(self._tickTime, self)
	settimer(1, self._tickTime, self, true)
end

function BeastRichManGameView:_onUpdate()
	self._info = BeastRichmanModel.instance:getInfo(self._activityId)

	local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
	local randomDiceCfg = BeastRichmanConfig.instance:getDiceCfgByType(self._activityId, BeastRichManEnum.DiceType.Random)
	local randomCostStr = randomDiceCfg.cost
	local fixDiceCfg = BeastRichmanConfig.instance:getDiceCfgByType(self._activityId, BeastRichManEnum.DiceType.Fix)
	local fixCostStr = fixDiceCfg.cost

	if randomCostStr then
		local matType, matId, matNumRandom = MaterialMgr.getMatParams(randomCostStr)
		local curHasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		self._txtDiceRandom.text = curHasMatNum

		GameUtil.SetActive(self._imgRedRandomDice, curHasMatNum > 0)
	end

	if fixCostStr then
		local matType, matId, matNumFix = MaterialMgr.getMatParams(fixCostStr)
		local curHasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		self._txtDiceFix.text = curHasMatNum

		GameUtil.SetActive(self._imgRedFixDice, curHasMatNum > 0)
	end

	BeastRichManPlayerMgr.instance:setPlayerCurGridId(playerCurGridId)
	BeastRichManPlayerMgr.instance:setPlayerPos(playerCurGridId)

	local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)
	local eventHasFinish = BeastRichmanController.instance:curEventHasFinish(self._activityId, self._zoneId)
	local canMove = pathCellHasFinish and eventHasFinish

	self._txtOpenEvent.text = canMove and "可继续前进" or "继续事件"
	self._needAutoPop = BeastRichmanController.instance:getNeedAutoPop()

	if self._needAutoPop then
		self:_checkGridAutoPop()
		BeastRichmanController.instance:setNeedAutoPop(false)
	end

	local playerPosX, playerPosY = BeastRichManMapMgr.instance:getPathCellPosAfterOffset(playerCurGridId)

	GameUtil.setLocalPos(self._btnOpenEvent, playerPosX - 60, playerPosY + 120, 0)
	BeastRichManMapMgr.instance:_updateEventCellsUI(self._activityId, self._zoneId)

	self._txtNumCoin.text = BeastRichmanModel.instance:getScore(self._activityId)

	BeastRichManPlayerMgr.instance:focusOnPlayer()
	self:_updateHangingUI()
end

function BeastRichManGameView:_onClickRandomDice()
	self._hasUsedStopCard = BeastRichmanController.instance:isUsingStopCard(self._activityId)

	if self._hasUsedStopCard then
		FloatWordMgr.instance:show("已触发“停留卡”，无法投掷固定骰子")
	end

	local pathHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)

	if not pathHasFinish then
		local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)

		self:_handlePathCellEvent(playerCurGridId)

		return
	end

	local eventHasFinish = BeastRichmanController.instance:curEventHasFinish(self._activityId, self._zoneId)

	if not eventHasFinish then
		FloatWordMgr.instance:show("请点击建筑上方浮动按钮，完成建筑事件，才能投掷骰子")
		self:_handleEventCellEvent()

		return
	end

	local randomDiceCfg = BeastRichmanConfig.instance:getDiceCfgByType(self._activityId, BeastRichManEnum.DiceType.Random)
	local randomCostStr = randomDiceCfg.cost
	local matType, matId, matNumRandom = MaterialMgr.getMatParams(randomCostStr)
	local curHasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if curHasMatNum <= 0 then
		FloatWordMgr.instance:show("骰子数量不足，无法使用")

		return
	end

	BeastRichmanController.instance:sendPM_BeastRichManMoveReq(self._activityId, self._zoneId, BeastRichManEnum.DiceType.Random, "")
end

function BeastRichManGameView:_onClickFixDice()
	self._hasUsedStopCard = BeastRichmanController.instance:isUsingStopCard(self._activityId)

	if self._hasUsedStopCard then
		FloatWordMgr.instance:show("已触发“停留卡”，无法投掷固定骰子")
	end

	local pathHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)

	if not pathHasFinish then
		local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)

		self:_handlePathCellEvent(playerCurGridId)

		return
	end

	local eventHasFinish = BeastRichmanController.instance:curEventHasFinish(self._activityId, self._zoneId)

	if not eventHasFinish then
		FloatWordMgr.instance:show("请点击建筑上方浮动按钮，完成建筑事件，才能投掷骰子")
		self:_handleEventCellEvent()

		return
	end

	local fixDiceCfg = BeastRichmanConfig.instance:getDiceCfgByType(self._activityId, BeastRichManEnum.DiceType.Fix)
	local fixCostStr = fixDiceCfg.cost
	local matType, matId, matNumFix = MaterialMgr.getMatParams(fixCostStr)
	local curHasMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

	if curHasMatNum <= 0 then
		FloatWordMgr.instance:show("骰子数量不足，无法使用")

		return
	end

	UIStateManager.instance:push(ViewName.BeastrichmanuniversaldiceView, self._activityId, self._zoneId)
end

function BeastRichManGameView:_onClickCard()
	UIStateManager.instance:push(ViewName.BeastrichmancardbagView, self._activityId)
end

function BeastRichManGameView:_onMoveRes(msg)
	GameUtil.SetActive(self._btnOpenEvent, false)

	self._moveMsg = msg

	if msg.diceType == BeastRichManEnum.DiceType.Random then
		self._diceValueList = {
			msg.diceValue
		}

		self:_tryPlayDiceAnim()
	else
		self:_tryPlayerMove()
	end
end

function BeastRichManGameView:_tryPlayerMove()
	if not self._moveMsg.moveGridLoad then
		local moveGridLoad = {}
		local diceValue = self._moveMsg.diceValue
		local hasStorm = diceValue > 0 and diceValue < #moveGridLoad

		local function finishFunc()
			self:_onMoveFinish()
			self:_onUpdate()
		end

		BeastRichManPlayerMgr.instance:move(moveGridLoad, finishFunc, hasStorm, diceValue)
	end
end

function BeastRichManGameView:_tryPlayDiceAnim()
	self:_playDiceAnim()
end

function BeastRichManGameView:_playDiceAnim()
	self:_blockClick(true)

	for k, v in pairs(self._diceGos) do
		goutil.setActive(v, false)
	end

	local valueList = self._diceValueList

	local function autoHideSelfCallback()
		if self._hasUsedStopCard then
			self:_onMoveFinish()
			self:_onUpdate()

			self._hasUsedStopCard = false
		else
			self:_tryPlayerMove()
		end
	end

	local key = "PlayDice"
	local num = #valueList

	self:_regEvent(key, num, autoHideSelfCallback)

	local saiziIds = {}

	if num == 1 then
		saiziIds = {
			2
		}
	elseif num == 2 then
		saiziIds = {
			1,
			3
		}
	elseif num == 3 then
		saiziIds = {
			1,
			2,
			3
		}
	end

	for idx, val in ipairs(valueList) do
		local params = {
			autoHideSelfSec = 1,
			value = val,
			useSaiZiId = saiziIds[idx],
			autoHideSelfCallback = function()
				self:_calcNode(key, num)
			end,
			thisArg = self,
			bNotPlayAnim = self._isSkipDiceAnim
		}
		local diceHandler = self:_getDiceHandler(idx)

		if diceHandler then
			diceHandler:play(params)
		else
			printError("缺失")
		end
	end
end

function BeastRichManGameView:_blockClick(isNeedBlock)
	GameUtil.SetActive(self._clickMask, isNeedBlock)
end

function BeastRichManGameView:_onMoveFinish()
	self:_blockClick(false)

	if not self._moveMsg then
		return
	end

	local moveMsg = self._moveMsg

	self._moveMsg = nil

	if moveMsg then
		if not moveMsg.moveGridLoad then
			do
				local moveGridLoad = {}

				if #moveGridLoad > 0 then
					local finalPlayerGridId = moveGridLoad[#moveGridLoad]
					local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)

					if pathCellHasFinish then
						BeastRichManMapMgr.instance:showServerAutoFinishPathCellItems(finalPlayerGridId)
						self:_handleEventCellEvent()
						self:_checkPopShop()
					else
						self:_handlePathCellEvent(finalPlayerGridId)
					end
				end
			end

			local finalPlayerGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
			local playerPosX, playerPosY = BeastRichManMapMgr.instance:getPathCellPosAfterOffset(finalPlayerGridId)

			BeastRichmanController.instance:tryPopCurScore(self._activityId)

			local changeSetId = BeastRichmanController.instance:getCurChangeSetId()

			if changeSetId then
				MaterialController.instance:showChangeSetInTemp(changeSetId)
			end

			GameUtil.SetActive(self._btnOpenEvent, true)
			GameUtil.setLocalPos(self._btnOpenEvent, playerPosX - 100, playerPosY + 50, 0)
		end
	end
end

function BeastRichManGameView:_showPlayRule()
	local ruleCfg = BeastRichmanConfig.instance:getRuleCfg(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
end

function BeastRichManGameView:_handlePathCellEvent(finalPlayerGridId)
	local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)
	local result = BeastRichManMapMgr.instance:trickPathCell(self._activityId, finalPlayerGridId, pathCellHasFinish)

	if result then
		self:_handleEventCellEvent()
	end
end

function BeastRichManGameView:_checkGridAutoPop()
	local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)

	if not pathCellHasFinish then
		local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)

		self:_handlePathCellEvent(playerCurGridId)
	else
		self:_handleEventCellEvent()
	end
end

function BeastRichManGameView:_onClickBtnOpenEvent()
	local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)

	if not pathCellHasFinish then
		local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)

		self:_handlePathCellEvent(playerCurGridId)

		return
	end

	local eventHasFinish = BeastRichmanController.instance:curEventHasFinish(self._activityId, self._zoneId)

	if not eventHasFinish then
		self:_handleEventCellEvent()
	end
end

function BeastRichManGameView:_onEndStory(playStoryId)
	local pathCellHasFinish = BeastRichmanController.instance:curPathCellHasFinish(self._activityId, self._zoneId)

	if not pathCellHasFinish then
		local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
		local gridCfg = BeastRichmanConfig.instance:getGridCfgById(self._activityId, self._zoneId, playerCurGridId)
		local storyId = checknumber(gridCfg.gridParam)
		local storyCfg = BeastRichmanConfig.instance:getStoryCfgById(self._activityId, storyId)
		local storyId = checknumber(storyCfg.playStoryId)

		if storyId > 0 and playStoryId == storyId then
			BeastRichmanController.instance:sendPM_BeastRichManHandleGridReq(self._activityId, self._zoneId, playerCurGridId, "")
		end
	end
end

function BeastRichManGameView:_onBeastRichManHandleGridRes()
	self:_handleEventCellEvent()
	self:_onUpdate()
	self:_checkPlayStoryScore()
end

function BeastRichManGameView:_checkPlayStoryScore()
	local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
	local curGridCfg = BeastRichmanConfig.instance:getGridCfg(self._activityId, self._zoneId, playerCurGridId)
	local isPlayerStoryGrid = curGridCfg.gridType == BeastRichManEnum.CellType.StoryPlay

	if isPlayerStoryGrid then
		BeastRichmanController.instance:tryPopCurScore(self._activityId)
	end
end

function BeastRichManGameView:_handleEventCellEvent()
	local finalPlayerGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)

	BeastRichManMapMgr.instance:trickEventCell(self._activityId, self._zoneId, finalPlayerGridId)
	self:_checkPopShop()
end

function BeastRichManGameView:_onBeastRichManHandleEventRes()
	BeastRichManMapMgr.instance:_updateEventCellsUI(self._activityId, self._zoneId)
	self:_onUpdate()
end

function BeastRichManGameView:_onBeastRichManInfoRes()
	self:_onUpdate()
	self:_tryTickHangingPrize()
end

function BeastRichManGameView:_onClickbtnClose()
	self:close()
	BeastRichmanController.instance:setNeedAutoPop(true)
end

function BeastRichManGameView:_onClickbtnTip()
	self:_showPlayRule()
end

function BeastRichManGameView:_onClickbtnSkip()
	self._isSkipDiceAnim = not self._isSkipDiceAnim

	local key = string.format("BeastrichmanSkipDiceAnim_%s", self._activityId)

	GameUtil.saveUserData(key, self._isSkipDiceAnim)
	BeastRichmanController.instance:setIsSkipDiceAnim(self._isSkipDiceAnim)
	self:_updateSkipDiceAnimState()
end

local effPath = "20250926/baoweiluobo/fx_ui_chuxian.prefab"

function BeastRichManGameView:_onBeastRichManBuildingLevelUp(uniqueId)
	local posX, posY = BeastRichManMapMgr.instance:calCellPos(self._activityId, self._zoneId, uniqueId)
	local offsetX, offsetY = BeastRichManMapMgr.instance:getOffsetXY()

	GameUtil.setLocalPos(self._eff, posX + offsetX - 10, posY + offsetY - 10, 0)

	if self._eff then
		self:stopViewEffectUniGo(self._eff)
	end

	self:playViewEffectUniGo(effPath, self._eff, self.mainGO.transform, false, nil, nil)
end

function BeastRichManGameView:_updateSkipDiceAnimState()
	goutil.setActive(self._checkmarkGo, self._isSkipDiceAnim)
end

function BeastRichManGameView:_regEvent(key, totalNum, endCallBack)
	if self._eventQueue == nil then
		self._eventQueue = {}
	end

	self._eventQueue[key] = {
		curNum = 0,
		totalNum = totalNum,
		endCallBack = endCallBack
	}
end

function BeastRichManGameView:_calcNode(key, delta)
	if self._eventQueue[key] == nil then
		return
	end

	local curNum = self._eventQueue[key].curNum

	curNum = curNum + delta

	if curNum >= self._eventQueue[key].totalNum then
		self:_endEvent(key, true)
	else
		self._eventQueue[key].curNum = curNum
	end
end

function BeastRichManGameView:_endEvent(key, isNeedCallBack)
	local node = self._eventQueue[key]

	if isNeedCallBack then
		GameUtil.callBack(node.endCallBack)
	end

	table.clear(self._eventQueue[key])

	self._eventQueue[key] = nil
end

function BeastRichManGameView:_getDiceHandler(handlerIdx)
	return self._diceCol._diceHandlerList[handlerIdx]
end

function BeastRichManGameView:_clearDice()
	for _, v in ipairs(self._diceCol._diceHandlerList) do
		v:dispose()
	end
end

function BeastRichManGameView:_onClickResTips()
	if self._bossEachHangingPrize <= 0 or self._canGetPrizeScore <= 0 then
		FloatWordMgr.instance:show("目前暂无可领取boss收益")

		return
	end

	BeastRichmanController.instance:sendPM_BeastRichManGainHangingReq(self._activityId)
end

function BeastRichManGameView:_onClickCoin()
	local matstr = self._actCfg.scoreMatStr

	CommonTipsMgr.instance:openTipsByConfStr(self._coin.gameObject, matstr)
end

function BeastRichManGameView:_onBeastRichManGainHangingRes(addScore)
	self._txtPrize.text = "点击领取挂机收益：0"
	self._canGetPrizeScore = 0
	self._prePrizeNum = 0
	self._enterTime = 0
	self._totalTickTime = 0

	self:_tryTickHangingPrize()
	self:_popGetScore(addScore)
	self:_onUpdate()
end

function BeastRichManGameView:_updateHangingUI()
	local totalPrize = BeastRichmanController.instance:getHangingTotalPrize(self._activityId, self._zoneId)

	self._canGetPrizeScore = totalPrize
	self._txtPrize.text = string.format("点击领取挂机收益：%s", totalPrize)

	GameUtil.SetActive(self._imgRedResTips, checknumber(totalPrize) > 10000)
end

function BeastRichManGameView:_tickTime()
	local hangInfo = self._info.hanging
	local lastSettleTimeMillis = checknumber(hangInfo.lastSettleTimeMillis)
	local lastSettleTime = math.ceil(lastSettleTimeMillis / 1000)
	local curTime = self._enterTime + self._totalTickTime
	local diffTime = curTime - lastSettleTime
	local cycle = BeastRichmanConfig.instance:getBossCycle(self._activityId)

	if cycle > 0 then
		local cycleTime = cycle
		local curPrizeNum = math.floor(diffTime / cycleTime)
		local totalPrize = 0

		if curPrizeNum > checknumber(self._prePrizeNum) then
			totalPrize = curPrizeNum * self._bossEachHangingPrize + hangInfo.extAccumulate
			self._canGetPrizeScore = curPrizeNum * self._bossEachHangingPrize + hangInfo.extAccumulate
			self._prePrizeNum = curPrizeNum
			self._txtPrize.text = string.format("点击领取挂机收益：%s", (math.min(curPrizeNum * self._bossEachHangingPrize + hangInfo.extAccumulate, self._actCfg.storageLimit)))
		elseif hangInfo.extAccumulate > 0 then
			self._canGetPrizeScore = hangInfo.extAccumulate
		end
	end

	self._totalTickTime = self._totalTickTime + 1
end

function BeastRichManGameView:_popGetScore(score)
	local scoreMatStr = self._actCfg.scoreMatStr
	local type, id, num = MaterialMgr.getMatParams(scoreMatStr)
	local list = {}

	if type == MatType.Item_Fake then
		local mo = MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, id, score)

		table.insert(list, mo)
	end

	local obj = {}

	obj.items = list
	obj.ci = 0

	MaterialController.instance:addInList(MaterialController.TYPE_ITEMSET, obj)
	MaterialController.instance:checkAndOpenDisplay()
end

function BeastRichManGameView:_onBeastRichManOpenClickMask(openClickMask)
	self:_blockClick(openClickMask)
end

function BeastRichManGameView:_checkPopShop()
	local playerCurGridId = BeastRichmanModel.instance:getCurManGridId(self._activityId, self._zoneId)
	local curGridHasShop = BeastRichmanController.instance:curGridHasShop(self._activityId, self._zoneId, playerCurGridId)

	if curGridHasShop then
		UIStateManager.instance:push(ViewName.BeastRichManShopView, self._activityId, self._zoneId, playerCurGridId, true)
	end
end

function BeastRichManGameView:_onClickBtnPos()
	BeastRichManPlayerMgr.instance:focusOnPlayer()
end

return BeastRichManGameView
