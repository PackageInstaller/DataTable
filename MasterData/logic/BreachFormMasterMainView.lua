-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/breachformmaster/view/BreachFormMasterMainView.lua

module("logic.extensions.breachformmaster.view.BreachFormMasterMainView", package.seeall)

local BreachFormMasterMainView = class("BreachFormMasterMainView", ViewComponent)

function BreachFormMasterMainView:ctor()
	BreachFormMasterMainView.super.ctor(self)
end

function BreachFormMasterMainView:unbindEvents()
	BreachFormMasterMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPirze)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnUseBuff)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReport)
	GameUtil.rmClickHandler(self._btnFormation)
end

function BreachFormMasterMainView:bindEvents()
	BreachFormMasterMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnPirze, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnUseBuff, self._onClickUseBuff, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnReport, self._onClickReport, self)
	GameUtil.addClickHandler(self._btnFormation, self._onClickFormation, self)
end

function BreachFormMasterMainView:buildUI()
	BreachFormMasterMainView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")

	local rolePoint = self:getGo("modelCam/rolePoint")

	self._ememyAvatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._ememyAvatar:setParent(rolePoint.transform)
	self._ememyAvatar:setLayer(SceneLayer.UI3D_Value)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPirze = self:getGo("btnPirze")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._txtName = self:getTxt("name/txtName")
	self._txtScore = self:getTxt("score/txtScore")
	self._headIconBestPlayer = self:getGo("basePlayerInfo/headIcon")
	self._txtBestPlayerName = self:getTxt("basePlayerInfo/txtName")
	self._txtBestPlayerScore = self:getTxt("basePlayerInfo/txtScore")
	self._txtDefence = self:getTxt("myScore/txtDefence")
	self._txtAttack = self:getTxt("myScore/txtAttack")
	self._enemyTableview = self:getGo("enemyTableview")
	self._enemyTablecell = self:getGo("enemyTableview/enemyTablecell")
	self._enemyTableList = ScrollerList.create(self._enemyTableview, self._enemyTablecell, GameUtil.handler(self._updateEnemyCell, self), GameUtil.handler(self._clearEnemyCell, self))

	self._enemyTableList:setOnlyCircleOffsetPos(true)
	self._enemyTableList:extendCircleWithOffset(-150, "node")
	self._enemyTableList:regValueChanged(GameUtil.handler(self._onTableChange, self))

	self._enemyTableContent = self:getGo("enemyTableview/viewport/content")
	self._btnGainBuff = self:getGo("signInBuff/buffCol/btnGain")
	self._txtDescBuff = self:getTxt("signInBuff/buffCol/txtDesc")
	self._redBuff = self:getGo("signInBuff/buffCol/cell/red")
	self._btnUseBuff = self:getGo("signInBuff/btnUseBuff")
	self._tagUseBuff = self:getGo("signInBuff/btnUseBuff/tagUseBuff")
	self._petTableview = self:getGo("petInfo/petTableview")
	self._petTablecell = self:getGo("petInfo/petTableview/petTablecell")
	self._petTableList = ScrollerList.create(self._petTableview, self._petTablecell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._goldBarCon = self:getGo("goldBar")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnChallenge = self:getGo("btnChallenge")
	self._defenceInfo = self:getGo("defenceInfo")
	self._btnReport = self:getGo("defenceInfo/btnReport")
	self._btnFormation = self:getGo("defenceInfo/btnFormation")
	self._imgLeft = self:getGo("imgLeft")
	self._imgRight = self:getGo("imgRight")
end

function BreachFormMasterMainView:onExit()
	BreachFormMasterMainView.super.onExit(self)
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function BreachFormMasterMainView:onEnter()
	BreachFormMasterMainView.super.onEnter(self)
	self:addGEvent(GlobalNotify.PM_BreachFormMasterGetInfoRes, self._refreshView)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 593001
	end

	self._activityCfg = BreachFormMasterConfig.instance:getActivityCfg(self._activityId)
	self._selectStageId = BreachFormMasterModel.instance:getSelectIndex() or 1

	BreachFormMasterAgent.instance:sendPM_BreachFormMasterGetInfoReq(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
	self:_refreshUseBuff()
	self:_setTopGoldBar()

	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function BreachFormMasterMainView:_refreshView()
	self._isDefense = BreachFormMasterController.instance:isDefensePlayer(self._activityId)
	self._curStepId = BreachFormMasterModel.instance:getCurStepId(self._activityId)

	local enemyList

	if self._curStepId == BreachFormMasterController.ROBOT_STEP_ID then
		enemyList = BreachFormMasterConfig.instance:getStageCfgs(self._activityId, self._curStepId)
	else
		enemyList = {}

		local stageCfg = BreachFormMasterConfig.instance:getStageCfgs(self._activityId, self._curStepId)

		for i, v in ipairs(stageCfg) do
			local stageInfo = BreachFormMasterModel.instance:getStageInfo(self._activityId, v.stageId)

			if stageInfo then
				table.insert(enemyList, v)
			end
		end
	end

	if self._selectStageId > #enemyList then
		self._selectStageId = 1
	end

	self._enemyTableList:reloadData(enemyList)

	local scrollIdx = BreachFormMasterController.instance:getScrollIdx()

	self._enemyTableList:MoveCellToCenter(scrollIdx)

	local curStageCfg = enemyList[self._selectStageId]
	local stageInfo = BreachFormMasterModel.instance:getStageInfo(self._activityId, self._selectStageId)

	if not stageInfo then
		return
	end

	self._txtName.text = self._curStepId == BreachFormMasterController.ROBOT_STEP_ID and curStageCfg.robotName or stageInfo.defensePlayerView.headInfo.userName
	self._txtScore.text = stageInfo.firstPass == true and langPara("%s", stageInfo.myScore) or lang("0")

	self:_updateCurRole()

	if checknumber(stageInfo.bestPlayerHeadInfo.userId) ~= 0 then
		HeadItemController.instance:resetHeadCell(self._headIconBestPlayer)
		HeadItemController.instance:setHeadCellByInfo(self._headIconBestPlayer, stageInfo.bestPlayerHeadInfo, true)

		self._txtBestPlayerName.text = langPara("%s-%s", stageInfo.bestPlayerHeadInfo.areaId, stageInfo.bestPlayerHeadInfo.userName)
		self._txtBestPlayerScore.text = langPara("积分：%s", stageInfo.bestPlayerScore)
	else
		HeadItemController.instance:resetHeadCell(self._headIconBestPlayer)

		self._txtBestPlayerName.text = lang("暂无人挑战")
		self._txtBestPlayerScore.text = nil
	end

	self._txtAttack.text = langPara("破阵榜总分：%s", BreachFormMasterModel.instance:getMyAttackScore(self._activityId))
	self._txtDefence.text = langPara("防守榜总分：%s", BreachFormMasterModel.instance:getDefenseScore(self._activityId))

	local stepCfg = BreachFormMasterConfig.instance:getStepCfg(self._activityId, self._curStepId)
	local planCfg = BreachFormMasterConfig.instance:getRaceScorePlanCfg(stepCfg.attackRaceScorePlanId)
	local petList = {}

	for i, v in pairs(planCfg) do
		table.insert(petList, v.raceId)
	end

	self._petTableList:reloadData(petList)
	GameUtil.SetActive(self._defenceInfo, self._isDefense)
	GameUtil.SetActive(self._txtDefence, self._isDefense)
end

function BreachFormMasterMainView:_refreshUseBuff()
	GameUtil.SetActive(self._tagUseBuff, BreachFormMasterModel.instance:getUseDailyBuff())
end

function BreachFormMasterMainView:_updateCurRole()
	if self._curStepId == BreachFormMasterController.ROBOT_STEP_ID then
		local stageCfg = BreachFormMasterConfig.instance:getStageCfg(self._activityId, self._curStepId, self._selectStageId)
		local skId = DressModel.instance:getSkeIdByGender(stageCfg.robotGender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, {}, 0)

		self._ememyAvatar:updateByMo(mo)
	else
		local stageInfo = BreachFormMasterModel.instance:getStageInfo(self._activityId, self._selectStageId)

		if not stageInfo then
			return
		end

		local skId = DressModel.instance:getSkeIdByGender(stageInfo.defensePlayerView.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not stageInfo.defensePlayerView.clothes or nil) and {}, 0)

		self._ememyAvatar:updateByMo(mo)
	end
end

function BreachFormMasterMainView:_updateEnemyCell(view, cell, data, tag)
	local go = cell.gameObject
	local nodeGo = goutil.findChild(go, "node")
	local selectGo = goutil.findChild(nodeGo, "imgSelect")
	local robotHeadMale = goutil.findChild(nodeGo, "robotHeadMale")
	local robotHeadFemale = goutil.findChild(nodeGo, "robotHeadFemale")
	local headIcon = goutil.findChild(nodeGo, "headIcon")
	local powerGo = goutil.findChild(nodeGo, "power")
	local txtPower = goutil.findChildTextComponent(powerGo, "txtPower")
	local txtName = goutil.findChildTextComponent(nodeGo, "name/txtName")
	local btn = goutil.findChild(nodeGo, "btn")

	GameUtil.SetActive(selectGo, self._selectStageId == data.stageId)

	if self._curStepId == BreachFormMasterController.ROBOT_STEP_ID then
		local stageInfo = BreachFormMasterModel.instance:getStageInfo(self._activityId, data.stageId)
		local stageCfg = BreachFormMasterConfig.instance:getStageCfg(self._activityId, self._curStepId, data.stageId)

		GameUtil.SetActive(headIcon, false)
		HeadItemController.instance:resetHeadCell(headIcon)
		GameUtil.SetActive(robotHeadMale, stageCfg.robotGender == 1)
		GameUtil.SetActive(robotHeadFemale, stageCfg.robotGender == 0)

		txtName.text = data.robotName
		txtPower.text = langPara("积分：%s", stageInfo and checknumber(stageInfo.myScore) or 0)
	else
		local stageInfo = BreachFormMasterModel.instance:getStageInfo(self._activityId, data.stageId)

		GameUtil.SetActive(headIcon, true)
		HeadItemController.instance:resetHeadCell(headIcon)
		HeadItemController.instance:setHeadCellByInfo(headIcon, stageInfo.defensePlayerView.headInfo)
		GameUtil.SetActive(robotHeadMale, false)
		GameUtil.SetActive(robotHeadFemale, false)

		txtPower.text = langPara("积分：%s", checknumber(stageInfo.myScore))
		txtName.text = langPara("%s-%s", stageInfo.defensePlayerView.headInfo.areaId, stageInfo.defensePlayerView.headInfo.userName)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		BreachFormMasterController.instance:setScrollIdx(data.stageId - 1)
		self:_onClickStage(data.stageId)
	end)
end

function BreachFormMasterMainView:_clearEnemyCell(cell)
	local go = cell.gameObject
	local nodeGo = goutil.findChild(go, "node")
	local headIcon = goutil.findChild(nodeGo, "headIcon")
	local btn = goutil.findChild(nodeGo, "btn")

	HeadItemController.instance:resetHeadCell(headIcon)
	GameUtil.rmClickHandler(btn)
end

function BreachFormMasterMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or lang("点击激活Buff")
	end
end

function BreachFormMasterMainView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCell(MatType.Pet, data, go)
end

function BreachFormMasterMainView:_clearPetCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function BreachFormMasterMainView:_setTopGoldBar()
	local btn_list = {}
	local itemArry = string.split(self._activityCfg.coin, "#")

	for i, v in ipairs(itemArry) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function BreachFormMasterMainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.BreachFormMasterPrizeView, self._activityId)
end

function BreachFormMasterMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.BreachFormMasterRankView, self._activityId, 1, self._curStepId)
end

function BreachFormMasterMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpToShop) then
		GotoMgr.gotoByString(self._activityCfg.jumpToShop)
	end
end

function BreachFormMasterMainView:_onClickStage(stageId)
	self._selectStageId = stageId

	BreachFormMasterModel.instance:saveSelectIndex(stageId)
	self:_refreshView()
end

function BreachFormMasterMainView:_onClickUseBuff()
	local useBuff = BreachFormMasterModel.instance:getUseDailyBuff()

	BreachFormMasterModel.instance:setUseDailyBuff(not useBuff)
	self:_refreshUseBuff()
end

function BreachFormMasterMainView:_onClickChallenge()
	if BreachFormMasterController.instance:checkCanChallenge(self._activityId, self._curStepId) == false then
		return
	else
		BreachFormMasterController.instance:openMissionView(self._activityId, self._curStepId, self._selectStageId)
	end
end

function BreachFormMasterMainView:_onClickTip()
	TipsFacade.instance:openRulesView("breach_form_master_rule")
end

function BreachFormMasterMainView:_onClickReport()
	UIStateManager.instance:push(ViewName.BreachFormMasterReportView, self._activityId)
end

function BreachFormMasterMainView:_onClickFormation()
	local isDefense, stageId = BreachFormMasterController.instance:isDefensePlayer(self._activityId)

	if isDefense == true then
		BreachFormMasterController.instance:openFormationView(self._activityId, stageId)
	end
end

function BreachFormMasterMainView:_onTableChange(tableview)
	local pos = GameUtil.getAnchoredPos(self._enemyTableContent)
	local viewWidth = GameUtil.getWidth(self._enemyTableview)
	local contentWidth = GameUtil.getWidth(self._enemyTableContent)
	local min = viewWidth - contentWidth

	GameUtil.SetActive(self._imgLeft, pos.x < -10)
	GameUtil.SetActive(self._imgRight, pos.x > min + 10)
end

return BreachFormMasterMainView
