-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroSetTeamView.lua

module("logic.extensions.aoqihero.view.AoqiHeroSetTeamView", package.seeall)

local AoqiHeroSetTeamView = class("AoqiHeroSetTeamView", ViewComponent)

function AoqiHeroSetTeamView:ctor()
	AoqiHeroSetTeamView.super.ctor(self)
end

function AoqiHeroSetTeamView:unbindEvents()
	AoqiHeroSetTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AoqiHeroSetTeamView:bindEvents()
	AoqiHeroSetTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AoqiHeroSetTeamView:buildUI()
	AoqiHeroSetTeamView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._petTableView = self:getGo("petTableView")
	self._petCell = self:getGo("petCell")
	self._petTableList = ScrollerList.create(self._petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petTableList:getView():RegisterDraggingCallback(nil, GameUtil.handler(self._onDragCellStart, self), nil, nil, nil, nil)
	self._petTableList:getView():RegisterDragEndedCallback(self._onDragCellEnd, self)

	self._teamCell = self:getGo("teamCell")
	self._teamTableView = self:getGo("teamTableView")
	self._teamTableList = ScrollerList.create(self._teamTableView, self._teamCell, GameUtil.handler(self._updateTeamCell, self), GameUtil.handler(self._clearTeamCell, self))
end

function AoqiHeroSetTeamView:onExit()
	AoqiHeroSetTeamView.super.onExit(self)
	self._petTableList:dispose()
	self._teamTableList:dispose()
	removetimer(self._onClock, self)
end

function AoqiHeroSetTeamView:onEnter()
	AoqiHeroSetTeamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroInfoRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._isCheckTime = params[2]

	self:_initData()
	self:_refreshView()

	if self._isCheckTime == true then
		self:_onClock()
		settimer(1, self._onClock, self, true)
	end
end

function AoqiHeroSetTeamView:_initData()
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
end

function AoqiHeroSetTeamView:_refreshView()
	self._teamTableList:reloadData(self._posList)

	local petList = AoQiHeroConfig.instance:getUsePetCfgs(self._activityId)
	local showPetList = {}

	for i, v in ipairs(petList) do
		local petInfo = AoQiHeroModel.instance:getPetInfo(self._activityId, v.raceId)

		if petInfo == true then
			table.insert(showPetList, v)
		end
	end

	self._petOnTeamMap = {}

	for i, posId in ipairs(self._posList) do
		local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, posId)

		if posInfo and checknumber(posInfo.petId) ~= 0 then
			self._petOnTeamMap[posInfo.petId] = true
		end
	end

	table.sort(showPetList, function(a, b)
		if self._petOnTeamMap[a.raceId] == self._petOnTeamMap[b.raceId] then
			return a.raceId < b.raceId
		else
			return self._petOnTeamMap[a.raceId]
		end
	end)
	self._petTableList:reloadData(showPetList)
end

function AoqiHeroSetTeamView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon/con")
	local onTeamGo = goutil.findChild(go, "imgOnTeam")
	local typeChange = goutil.findChildComponent(go, "type", "UIImageSpriteChange")
	local imgRange = goutil.findChild(go, "imgRange")

	go.name = langPara("pet_%d", data.raceId)

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

	goto label_10_0

	GameUtil.SetActive(onTeamGo, self._petOnTeamMap[data.raceId] or false)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickPet(go, data.raceId, 1)
	end)
end

function AoqiHeroSetTeamView:_clearPetCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon/con")
	local imgRange = goutil.findChild(go, "imgRange")

	uGuiUtil.clearImage(imgRange)
	uGuiUtil.clearImage(petCon)
end

function AoqiHeroSetTeamView:_updateTeamCell(view, cell, data, tag)
	local go = cell.gameObject
	local petInfoGo = goutil.findChild(go, "petInfo")
	local petCon = goutil.findChild(petInfoGo, "petCon/con")
	local typeChange = goutil.findChildComponent(petInfoGo, "type", "UIImageSpriteChange")
	local imgRange = goutil.findChild(petInfoGo, "imgRange")
	local txtLv = goutil.findChildTextComponent(petInfoGo, "lv/txtLv")
	local emptyGo = goutil.findChild(go, "empty")
	local txtLock = goutil.findChildTextComponent(emptyGo, "txtLock")
	local imgAdd = goutil.findChild(emptyGo, "imgAdd")

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
			self:_onClickPet(go, posInfo.petId, posInfo.lv)
		end)
	else
		GameUtil.SetActive(emptyGo, true)
		GameUtil.SetActive(petInfoGo, false)

		if self._unlockStage[data] then
			txtLock.text = langPara("通关普通模式第%d关解锁", self._unlockStage[data])

			GameUtil.SetActive(txtLock, true)
			GameUtil.SetActive(imgAdd, false)
		else
			GameUtil.SetActive(txtLock, false)
			GameUtil.SetActive(imgAdd, true)
		end
	end
end

function AoqiHeroSetTeamView:_clearTeamCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petInfo/petCon/con")
	local imgRange = goutil.findChild(go, "petInfo/imgRange")

	uGuiUtil.clearImage(petCon)
	uGuiUtil.clearImage(imgRange)
	GameUtil.rmClickHandler(go)
end

function AoqiHeroSetTeamView:_onDragCellStart(startContainer, cell)
	self._drag = true
end

function AoqiHeroSetTeamView:_onDragCellEnd(startContainer, cell, endContainer)
	if endContainer then
		local cellNameStrArr = string.split(cell.name, "_")
		local lineGoStrArr = string.split(endContainer.name, "_")
		local petId = checknumber(cellNameStrArr[2])
		local posId = checknumber(lineGoStrArr[2])

		AoQiHeroController.instance:changeCurTeamPet(self._activityId, posId, petId)
	end

	self._drag = false

	return true
end

function AoqiHeroSetTeamView:_onClickPet(go, raceId, lv)
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = raceId
	param.isAttack = true
	param.lv = lv

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

function AoqiHeroSetTeamView:_onClock()
	local closeTime = AoQiHeroController.instance:getAutoStartPvPTime() - 2

	if closeTime < ServerTime.now() then
		removetimer(self._onClock, self)
		FloatWordMgr.instance:show(lang("战斗即将开始"))
		self:close()
	end
end

return AoqiHeroSetTeamView
