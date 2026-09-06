-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroStrengthenView.lua

module("logic.extensions.aoqihero.view.AoqiHeroStrengthenView", package.seeall)

local AoqiHeroStrengthenView = class("AoqiHeroStrengthenView", ViewComponent)

function AoqiHeroStrengthenView:ctor()
	AoqiHeroStrengthenView.super.ctor(self)
end

function AoqiHeroStrengthenView:unbindEvents()
	AoqiHeroStrengthenView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiHeroStrengthenView:bindEvents()
	AoqiHeroStrengthenView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiHeroStrengthenView:buildUI()
	AoqiHeroStrengthenView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._petTableView = self:getGo("petTableView")
	self._petCell = self:getGo("petCell")
	self._petTableList = ScrollerList.create(self._petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petTableList:getView():RegisterDraggingCallback(GameUtil.handler(self._onDragCellAvailable, self), GameUtil.handler(self._onDragCellStart, self), nil, GameUtil.handler(self._onDragCellEnd, self), GameUtil.handler(self._onCloneDragCell, self), nil)

	self._dragContainer = self:getGo("dragContainer")
	self._teamCell = self:getGo("teamCell")
	self._teamTableView = self:getGo("teamTableView")
	self._teamTableList = ScrollerList.create(self._teamTableView, self._teamCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
	self._goldBarCon = self:getGo("goldBar")
	self._emptyDragGo = self:getGo("emptyDrag")
end

function AoqiHeroStrengthenView:onExit()
	AoqiHeroStrengthenView.super.onExit(self)
	self._petTableList:dispose()
	self._teamTableList:dispose()
	removetimer(self._onClock, self)
end

function AoqiHeroStrengthenView:onEnter()
	AoqiHeroStrengthenView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.AoQiHeroLevelUpViewClose, self._setTopGoldBar, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroUnlockPetRes, self._PM_AoQiHeroUnlockPetRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._isCheckTime = params[2]

	self:_initView()
	self:_refreshView()

	if self._isCheckTime == true then
		self:_onClock()
		settimer(1, self._onClock, self, true)
	end
end

function AoqiHeroStrengthenView:_initView()
	self._unlockStage = {}

	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)
	local normalStageCfgs = AoQiHeroConfig.instance:getNormalStageCfgs(self._activityId)
	local cardUnlock = activityCfg.initCardUnlock
	local passStageId = AoQiHeroModel.instance:getPassStage(self._activityId)

	for i, v in ipairs(normalStageCfgs) do
		if v.unlock == true then
			cardUnlock = cardUnlock + 1

			if passStageId < v.stageId then
				self._unlockStage[cardUnlock] = v.stageId
			end
		end
	end

	self._posList = {}

	for i = 1, activityCfg.cardNum do
		table.insert(self._posList, i)
	end

	self:_setTopGoldBar()
end

function AoqiHeroStrengthenView:_refreshView()
	self._teamTableList:reloadData(self._posList)

	local petList = AoQiHeroConfig.instance:getUsePetCfgs(self._activityId)
	local showPetList = {}

	for i, v in ipairs(petList) do
		table.insert(showPetList, v)
	end

	self._petOnTeamMap = {}

	for i, posId in ipairs(self._posList) do
		local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, posId)

		if posInfo and checknumber(posInfo.petId) ~= 0 then
			self._petOnTeamMap[posInfo.petId] = true
		end
	end

	ArraySort.sortOn(showPetList, {
		function(a)
			if self._petOnTeamMap[a.raceId] then
				return 0
			else
				return 1
			end
		end,
		function(a)
			if AoQiHeroModel.instance:getPetInfo(self._activityId, a.raceId) then
				return 0
			else
				return 1
			end
		end,
		function(a)
			return a.raceId
		end
	})
	self._petTableList:reloadData(showPetList)
end

function AoqiHeroStrengthenView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon/con")
	local onTeamGo = goutil.findChild(go, "imgOnTeam")
	local unlockGo = goutil.findChild(go, "unlock")
	local costCon = goutil.findChild(unlockGo, "con")
	local txtCost = goutil.findChildTextComponent(unlockGo, "txtCost")
	local typeChange = goutil.findChildComponent(go, "type", "UIImageSpriteChange")
	local imgRange = goutil.findChild(go, "imgRange")
	local btn = goutil.findChild(go, "btn")

	go.name = langPara("pet_%d", data.raceId)

	MaterialMgr.resetAll(costCon)
	uGuiUtil.clearImage(imgRange)
	uGuiUtil.clearImage(petCon)

	local showRaceId = data.faceIds
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. showRaceId)

		return
	end

	uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(data.propertyStrategyId, 1)
	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.normalSkillId)

	uGuiUtil.setSpriteToImage(imgRange, uGuiUtil.SpriteType.BigBg, skillCfg.rangeImg)

	if data.elementId > 0 then
		typeChange:SetState(data.elementId - 1)
	end

	goto label_12_0

	GameUtil.SetActive(onTeamGo, self._petOnTeamMap[data.raceId] or false)

	local petInfo = AoQiHeroModel.instance:getPetInfo(self._activityId, data.raceId)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data.raceId)

	if not string.nilorempty(petCfg.unlockCost) then
		if petInfo then
			GameUtil.SetActive(unlockGo, false)
		else
			GameUtil.SetActive(unlockGo, true)

			local matType, matId, matNum = MaterialMgr.getMatParams(petCfg.unlockCost)

			MaterialMgr.setIcon(costCon, onTeamGo, matId)

			txtCost.text = matNum
		end
	else
		GameUtil.SetActive(unlockGo, false)
	end

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickPet(btn, data.raceId)
	end)
end

function AoqiHeroStrengthenView:_clearPetCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon/con")
	local imgRange = goutil.findChild(go, "imgRange")
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
	uGuiUtil.clearImage(imgRange)
	uGuiUtil.clearImage(petCon)
end

function AoqiHeroStrengthenView:_updateTeamCell(view, cell, data, tag)
	local go = cell.gameObject
	local petInfoGo = goutil.findChild(go, "petInfo")
	local petCon = goutil.findChild(petInfoGo, "petCon/con")
	local typeChange = goutil.findChildComponent(petInfoGo, "type", "UIImageSpriteChange")
	local imgRange = goutil.findChild(petInfoGo, "imgRange")
	local txtLv = goutil.findChildTextComponent(petInfoGo, "lv/txtLv")
	local emptyGo = goutil.findChild(go, "empty")
	local lockGo = goutil.findChild(emptyGo, "lock")
	local txtLock = goutil.findChildTextComponent(emptyGo, "lock/txtLock")
	local imgAdd = goutil.findChild(emptyGo, "imgAdd")
	local lvUpTipsGo = goutil.findChild(petInfoGo, "lvUpTips")

	go.name = langPara("pos_%d", data)

	GameUtil.rmClickHandler(go)

	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, data)

	if posInfo and checknumber(posInfo.petId) ~= 0 then
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, posInfo.petId)

		uGuiUtil.clearImage(petCon)

		local showRaceId = petCfg.faceIds
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

		if not modelCo then
			printError("t_model id not exist:" .. showRaceId)

			return
		end

		uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
		uGuiUtil.clearImage(imgRange)

		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, 1)
		local skillCfg = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.normalSkillId)

		uGuiUtil.setSpriteToImage(imgRange, uGuiUtil.SpriteType.BigBg, skillCfg.rangeImg)

		if petCfg.elementId > 0 then
			typeChange:SetState(petCfg.elementId - 1)
		end

		txtLv.text = langPara("Lv.%d", posInfo.lv)

		GameUtil.SetActive(emptyGo, false)
		GameUtil.SetActive(petInfoGo, true)
		GameUtil.addClickHandler(go, function()
			self:_onClickTeam(data)
		end)
		GameUtil.SetActive(lockGo, false)
		GameUtil.SetActive(lvUpTipsGo, AoQiHeroController.instance:checkPosCanLvUp(self._activityId, data))
	else
		GameUtil.SetActive(emptyGo, true)
		GameUtil.SetActive(petInfoGo, false)

		if self._unlockStage[data] then
			txtLock.text = langPara("通关普通模式第%d关解锁", self._unlockStage[data])

			GameUtil.SetActive(lockGo, true)
			GameUtil.SetActive(imgAdd, false)
		else
			GameUtil.SetActive(lockGo, false)
			GameUtil.SetActive(imgAdd, true)
		end
	end
end

function AoqiHeroStrengthenView:_clearTeamCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petInfo/petCon/con")
	local imgRange = goutil.findChild(go, "petInfo/imgRange")

	uGuiUtil.clearImage(petCon)
	uGuiUtil.clearImage(imgRange)
	GameUtil.rmClickHandler(go)
end

function AoqiHeroStrengthenView:_setTopGoldBar()
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)
	local btn_list = {}
	local cfgList = string.split(activityCfg.showBar, "#")

	for i, v in ipairs(cfgList) do
		table.insert(btn_list, {
			showAdd = false,
			id = v
		})
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function AoqiHeroStrengthenView:_onDragCellAvailable(startContainer, cell)
	local cellNameStrArr = string.split(cell.name, "_")
	local petId = checknumber(cellNameStrArr[2])

	self._isCanDrag = not not AoQiHeroModel.instance:getPetInfo(self._activityId, petId)

	return true
end

function AoqiHeroStrengthenView:_onDragCellStart(startContainer, cell)
	self._drag = true
end

function AoqiHeroStrengthenView:_onDragCellEnd(startContainer, cell, endContainer)
	if endContainer and self._isCanDrag == true then
		local cellNameStrArr = string.split(cell.name, "_")
		local lineGoStrArr = string.split(endContainer.name, "_")
		local petId = checknumber(cellNameStrArr[2])
		local posId = checknumber(lineGoStrArr[2])

		AoQiHeroController.instance:changeCurTeamPet(self._activityId, posId, petId)
	end

	self._drag = false

	return false
end

function AoqiHeroStrengthenView:_onCloneDragCell(startContainer, cell)
	if self._isCanDrag == true then
		local go = goutil.cloneAndSetParent(cell.gameObject, self._dragContainer.transform, cell.gameObject.name)
		local scale = GameUtil.getLocalScale(cell.gameObject)
		local pos = GameUtil.getPos(cell.gameObject)

		GameUtil.setLocalScale(go, scale.x, scale.y, scale.z)
		GameUtil.setPos(go, pos.x, pos.y, pos.z)

		return go
	else
		return (goutil.cloneAndSetParent(self._emptyDragGo, self._dragContainer.transform, cell.gameObject.name))
	end
end

function AoqiHeroStrengthenView:_onClickPet(go, raceId)
	if self._drag == true then
		return
	end

	local petInfo = AoQiHeroModel.instance:getPetInfo(self._activityId, raceId)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, raceId)

	if petInfo then
		local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)
		local param = {}

		param.pos = pos
		param.sizeDelta = sizeDelta
		param.view = self
		param.activityId = self._activityId
		param.raceId = raceId
		param.isAttack = true

		ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
	elseif not string.nilorempty(petCfg.unlockCost) then
		local matType, matId, matNum = MaterialMgr.getMatParams(petCfg.unlockCost)
		local matName = MaterialMgr.getMaterialsName(matType, matId)
		local param = {}

		param.matType = matType
		param.matId = matId
		param.matNum = matNum
		param.content = langPara("是否消耗%d%s解锁%s", matNum, matName, petCfg.name)
		param.raceId = raceId
		param.activityId = self._activityId

		function param.successCallBack()
			AoQiHeroAgent.instance:sendPM_AoQiHeroUnlockPetReq(self._activityId, raceId)
		end

		ViewMgr.instance:open(ViewName.AoqiHeroUnlockView, param)
	else
		return
	end
end

function AoqiHeroStrengthenView:_onClickTeam(posId)
	UIStateManager.instance:push(ViewName.AoqiHeroLevelUpView, self._activityId, posId)
end

function AoqiHeroStrengthenView:_onClock()
	local closeTime = AoQiHeroController.instance:getAutoStartPvPTime() - 2

	if closeTime < ServerTime.now() then
		removetimer(self._onClock, self)
		FloatWordMgr.instance:show(lang("战斗即将开始"))
		self:close()
	end
end

function AoqiHeroStrengthenView:_PM_AoQiHeroUnlockPetRes(raceId)
	self:_refreshView()
end

return AoqiHeroStrengthenView
