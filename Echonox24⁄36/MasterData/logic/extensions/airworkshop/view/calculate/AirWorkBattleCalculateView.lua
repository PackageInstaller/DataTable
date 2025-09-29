-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleCalculateView.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleCalculateView", package.seeall)

local M = class("AirWorkBattleCalculateView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._stepCount = 1
end

function M:buildUI()
	local operationalReportPanel = goutil.findChild(self.mainGO, "operationalReportPanel")
	local goEventTrigger = goutil.findChild(self.mainGO, "clickEventTrigger")

	self._clickTrigger = Astral.UIClickTrigger.Get(goEventTrigger)
	self._testPanelGo = goutil.findChild(operationalReportPanel, "objTest")
	self._sportPanelGo = goutil.findChild(operationalReportPanel, "objSports")
	self._scoreGo = goutil.findChild(operationalReportPanel, "objSports/objScore")
	self._interactGo = goutil.findChild(operationalReportPanel, "objSports/objInteract")
	self._freeModelGo = goutil.findChild(operationalReportPanel, "objSports/txtFreeMode")
	self._txtId = goutil.findChildComponent(operationalReportPanel, "txtTitle1", UIComponentType.Text)
	self._txtName = goutil.findChildComponent(operationalReportPanel, "txtTitle2", UIComponentType.Text)
	self._txtCreatorName = self:getUIComponent("air_workshop_calculate_victory_view_446607745", UIComponentType.Text)
	self._txtTipGO = goutil.findChild(operationalReportPanel, "txtTitle3")
	self._txtStepName = goutil.findChildComponent(operationalReportPanel, "txtTitle3", UIComponentType.Text)
	self._txtFreePassRate = goutil.findChildComponent(operationalReportPanel, "objSports/txtFreeMode", UIComponentType.Text)
	self._txtRound = goutil.findChildComponent(operationalReportPanel, "txtNum1", UIComponentType.Text)
	self._txtKill = goutil.findChildComponent(operationalReportPanel, "txtNum2", UIComponentType.Text)
	self._txtLineupCount = goutil.findChildComponent(operationalReportPanel, "txtNum3", UIComponentType.Text)
	self._imgLine2 = goutil.findChild(operationalReportPanel, "imgDi/imgLine2")

	local btnList = goutil.findChild(operationalReportPanel, "btnList")

	self._btnList = btnList
	self._btnQuit = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(btnList, "btnQuit"), CommButton)
	self._btnAgain = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(btnList, "btnAgain"), CommButton)
	self._continueHintGo = goutil.findChild(operationalReportPanel, "txtContinueHint")
	self._btnFlag = UIComponentType.ButtonAdapter(goutil.findChild(self._interactGo, "btnChangeTab"))
	self._btnMessage = UIComponentType.ButtonAdapter(goutil.findChild(self._interactGo, "btnMessage"))
	self._btnLike = UIComponentType.ButtonAdapter(goutil.findChild(self._interactGo, "btnGiveGood"))
	self._txtMessageCount = goutil.findChildTextComponent(self._interactGo, "btnMessage/txtNum")
	self._txtLikeCount = goutil.findChildTextComponent(self._interactGo, "btnGiveGood/txtNum")
	self._canvasGroupLiked = goutil.findChildComponent(self._btnLike.gameObject, "img1", ComponentType.CanvasGroup)
	self._txtRodeoRoundProgress = goutil.findChildTextComponent(btnList, "txtProgress")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:bindEvents()
	self._btnQuit:AddClickListener(self._onClickQuit, self)
	self._btnAgain:AddClickListener(self._onClickMulti, self)
	self._btnFlag:AddClickListener(self._onClickFlag, self)
	self._btnMessage:AddClickListener(self._onClickMessage, self)
	self._btnLike:AddClickListener(self._onClickLike, self)
	self._clickTrigger:AddClickListener(self._onClickFullView, self)
end

function M:unbindEvents()
	self._btnQuit:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._btnFlag:RemoveClickListener()
	self._btnMessage:RemoveClickListener()
	self._btnLike:RemoveClickListener()
	self._clickTrigger:RemoveClickListener()
end

function M:onEnter()
	self:_addEvents(true)

	local params = self:getOpenParam()

	self._style = params[1]
	self._resultData = params[2]

	local airPlayType = self._resultData.airPlayType

	printWarn(string.format("=====AirWorkBattleCalculateView===style:%s, airPlayType:%s", self._style, airPlayType))

	local showAgainBtn = true

	if airPlayType == AirWorkShopEnum.AirPlayType.HOT or airPlayType == AirWorkShopEnum.AirPlayType.ID or airPlayType == AirWorkShopEnum.AirPlayType.RECORD then
		showAgainBtn = false
	end

	self._btnAgain:setActive(showAgainBtn)
	goutil.setActive(self._txtRodeoRoundProgress.gameObject, airPlayType == AirWorkShopEnum.AirPlayType.RODEO)
	goutil.setActive(self._btnList, self._style == AirWorkShopEnum.CalculateStyle.Test)
	goutil.setActive(self._testPanelGo, self._style == AirWorkShopEnum.CalculateStyle.Test)
	goutil.setActive(self._sportPanelGo, self._style ~= AirWorkShopEnum.CalculateStyle.Test)
	goutil.setActive(self._continueHintGo, self._style ~= AirWorkShopEnum.CalculateStyle.Test)

	if self._style == AirWorkShopEnum.CalculateStyle.Test then
		self:_setTestContent()
	else
		self:_setCompetiveOrFreeContent()
	end
end

function M:onExit()
	BattleCalculateMgr.instance:stopVictoryPerformance()
	self:_addEvents(false)

	self._stepCount = 1

	self:_tryLikedMap()
end

function M:_addEvents(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_MANAGER_STATUS_UPDATE, self._onlineStatus, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_COMMENT_MAP, self._handleOnCommentMap, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_LIKED_MAP, self._handleLike, self)
	else
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_MANAGER_STATUS_UPDATE, self._onlineStatus, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_COMMENT_MAP, self._handleOnCommentMap, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_LIKED_MAP, self._handleLike, self)
	end
end

function M:_handleOnCommentMap(e)
	self._resultData.level.commented = true
	self._resultData.level.commentNum = self._resultData.level.commentNum + 1
	self._txtMessageCount.text = self._resultData.level.commentNum
end

function M:_handleLike(e, mapId, isLike)
	return
end

function M:_setTestContent()
	self._txtId.text = string.format("ID:%s", self._resultData.id)

	local levelMO = AirWorkMapModel.instance:getLevelMOById(self._resultData.id)
	local mapMo = levelMO:getMapMO()
	local sceneCo = AirWorkShopConfig.instance:getSceneCO(mapMo:getSceneId())

	self._txtName.text = sceneCo.name
	self._txtCreatorName.text = ""
	self._txtStepName.text = lang("tip_air_workshop_calculate_static1")
	self._txtRound.text = self._resultData.info.roundCount
	self._txtKill.text = self._resultData.info.killCount
	self._txtLineupCount.text = self._resultData.info.teamCount

	self._btnAgain:setText(lang("tip_air_workshop_calculate_static2"))
end

function M:_setCompetiveOrFreeContent()
	local sceneCo = AirWorkShopConfig.instance:getSceneCO(self._resultData.level.sceneId)

	self._txtId.text = string.format("ID:%s", self._resultData.level.mapId)
	self._txtName.text = sceneCo.name
	self._txtCreatorName.text = self._resultData.level.userName
	self._txtRound.text = self._resultData.battle.roundCount
	self._txtKill.text = self._resultData.battle.killCount
	self._txtLineupCount.text = self._resultData.battle.teamCount

	self._btnAgain:setText(lang("tip_air_workshop_calculate_btnfight"))

	if self._style == AirWorkShopEnum.CalculateStyle.Competitive then
		local txtTimes = goutil.findChildTextComponent(self._scoreGo, "txtTimes")
		local txtScore1 = goutil.findChildTextComponent(self._scoreGo, "txtScore1")
		local txtScore2 = goutil.findChildTextComponent(self._scoreGo, "txtScore2")
		local txtScore2_1 = goutil.findChildTextComponent(self._scoreGo, "txtScore2/txtScore2_1")
		local txtScore3 = goutil.findChildTextComponent(self._scoreGo, "txtScore3")
		local flagGo = goutil.findChild(self._scoreGo, "txtScore2/txt2")
		local addScore = self._resultData.rodeo.totalScore - self._resultData.rodeo.addScore

		txtTimes.text = self._resultData.rodeo.round
		txtScore1.text = self._resultData.rodeo.curScore
		txtScore2.text = self._resultData.rodeo.addScore
		txtScore2_1.text = addScore
		txtScore3.text = self._resultData.rodeo.maxScore
		self._txtRodeoRoundProgress.text = langF("tip_air_rodeo_round_progress", self._resultData.rodeo.round, AirWorkShopEnum.RodeoMaxRound)

		goutil.setActive(flagGo, addScore > 0)
		goutil.setActive(txtScore2_1.gameObject, addScore > 0)
	else
		self._txtFreePassRate.text = string.format("%s%%", AirWorkShopUtil.formatPassRatio(self._resultData.level.passRate * 100, 1))
	end

	self._txtMessageCount.text = self._resultData.level.commentNum
	self._txtLikeCount.text = self._resultData.level.likeNum
	self._cachLikedMap = self._resultData.level.liked
	self._canvasGroupLiked.alpha = self._cachLikedMap and 1 or 0.35

	self:checkStep()
end

function M:_hideSceneGo()
	local sceneRoot = SceneMgr.instance:getSceneRoot()

	self._hideGos = {}

	local trs = sceneRoot.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)
		local name = child.name
		local gameObject = child.gameObject

		if child.name ~= "victory_model" and child.gameObject.activeSelf then
			child.gameObject:SetActive(false)
			table.insert(self._hideGos, child)
		end
	end
end

function M:_showSceneGo()
	for _, child in ipairs(self._hideGos) do
		child.gameObject:SetActive(true)
	end

	self._hideGos = {}
end

function M:_dealTimelineListener(tagName)
	print("tagName--------", tagName)

	if tagName == "open" then
		-- block empty
	elseif tagName == "close" then
		-- block empty
	end
end

function M:checkStep()
	goutil.setActive(self._interactGo, self._stepCount == 2)
	goutil.setActive(self._btnList, self._stepCount == 2)
	goutil.setActive(self._continueHintGo, self._stepCount ~= 2)

	if self._style == AirWorkShopEnum.CalculateStyle.Competitive then
		goutil.setActive(self._freeModelGo, false)
		goutil.setActive(self._scoreGo, self._stepCount == 1)

		self._txtStepName.text = self._stepCount == 1 and lang("tip_air_workshop_calculate_static4") or lang("tip_air_workshop_calculate_static6")
	else
		goutil.setActive(self._scoreGo, false)
		goutil.setActive(self._freeModelGo, self._stepCount == 1)

		self._txtStepName.text = self._stepCount == 1 and lang("tip_air_workshop_calculate_static5") or lang("tip_air_workshop_calculate_static6")
	end
end

function M:pushOn()
	self._stepCount = self._stepCount + 1

	if self._stepCount > 2 then
		self._stepCount = 2
	end

	self:checkStep()
end

function M:_onClickFullView()
	if self._style == AirWorkShopEnum.CalculateStyle.Test then
		return
	end

	self:pushOn()
end

function M:_onClickFlag()
	local mapId = self._resultData.level.mapId
	local tagIds = self._resultData.level.tags

	ToolTipsMgr.showAirWorkShopBattleCalculateTagView(mapId, tagIds)
end

function M:_onClickMessage()
	local hideEditBtn = false
	local editBtnInteractable = not self._resultData.level.commented

	ToolTipsMgr.showAirWorkShopMessageLogTipsView(self._resultData.level.mapId, self._resultData.level.cover, hideEditBtn, editBtnInteractable)
end

function M:_onClickLike()
	self._cachLikedMap = not self._cachLikedMap
	self._canvasGroupLiked.alpha = self._cachLikedMap and 1 or 0.35

	local likeCount = self._resultData.level.likeNum

	if self._resultData.level.liked then
		likeCount = self._cachLikedMap and self._resultData.level.likeNum or self._resultData.level.likeNum - 1
	else
		likeCount = self._cachLikedMap and self._resultData.level.likeNum + 1 or self._resultData.level.likeNum
	end

	self._txtLikeCount.text = likeCount
end

function M:_tryLikedMap()
	if self._style ~= AirWorkShopEnum.CalculateStyle.Test and self._cachLikedMap ~= self._resultData.level.liked then
		local mapId = self._resultData.level.mapId
		local liked = self._cachLikedMap

		AirWorkShopAtkAgent.instance:sendLikeRequest(mapId, liked)
	end
end

function M:_onClickMulti()
	if self._style == AirWorkShopEnum.CalculateStyle.Test then
		AirWorkShopDefAgent.instance:sendModifyAirMapOnlineStateRequest(self._resultData.id, true)
	else
		AirWorkBattleResultController.instance:clearResultData()
		self:_onClickQuit()
	end
end

function M:_onlineStatus(e, params)
	FloatWordMgr.instance:show(lang("tip_air_workshop_calculate_static3"))
	settimer(0.5, function()
		self:_onClickQuit()
	end, self, false)
end

function M:_onClickQuit()
	self:close()
	BattleDispatcher:dispatchEvent(BattleEventType.ON_CALCULATE_FINISH)
end

return M
