-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroFormationView.lua

module("logic.extensions.aoqihero.view.AoQiHeroFormationView", package.seeall)

local AoQiHeroFormationView = class("AoQiHeroFormationView", ViewComponent)
local HPGO_ANCHORED_X = -5
local HPGO_ANCHORED_Y = -30
local TXT_HP_SIZE = 12
local TXT_RANGE_SIZE = 12

function AoQiHeroFormationView:ctor()
	AoQiHeroFormationView.super.ctor(self)
end

function AoQiHeroFormationView:unbindEvents()
	AoQiHeroFormationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose, self)
	GameUtil.rmClickHandler(self._btnTip, self)
	GameUtil.rmClickHandler(self._btnStart, self)
	GameUtil.rmClickHandler(self._btnTeam, self)
	GameUtil.rmClickHandler(self._btnRule, self)
end

function AoQiHeroFormationView:bindEvents()
	AoQiHeroFormationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function AoQiHeroFormationView:buildUI()
	AoQiHeroFormationView.super.buildUI(self)

	self._freeContainer = self:getGo("freeContainer")
	self._cellContain = self:getGo("cellContain")
	self._gridCell = self:getGo("cell")
	self._enemyContain = self:getGo("enemyContain")
	self._enemyCell = self:getGo("enemyCell")
	self._enemyItemGroup = ItemGroup.New(self._enemyContain, self._enemyCell)
	self._petCell = self:getGo("petContain/petCell")
	self._petTableView = self:getGo("petTableview")
	self._petTableList = ScrollerList.create(self._petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnStart = self:getGo("btnStart")
	self._btnTeam = self:getGo("btnTeam")
	self._btnRule = self:getGo("stageInfo/btnRule")
	self._txtName = self:getTxt("stageInfo/txtName")
	self._txtMyHp = self:getTxt("myHp/txt")
	self._btnTip = self:getGo("btnTip")
end

function AoQiHeroFormationView:onExit()
	AoQiHeroFormationView.super.onExit(self)
	self:_clearMap()
	self._enemyItemGroup:dispose(self._clearEnemyCell, self)
	self._petTableList:dispose()
end

function AoQiHeroFormationView:onEnter()
	AoQiHeroFormationView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroNormalChallengeRes, self._PM_AoQiHeroNormalChallengeRes, self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	self:_initData()
	self:_genarateMap()
	self:_genarateEntity()
	self:_refreshPetView()

	if not AoQiHeroModel.instance:getOpenNormalRule(self._activityId) then
		self:_onClickTips()
		AoQiHeroModel.instance:saveOpenNormalRule(self._activityId)
	end
end

function AoQiHeroFormationView:_initData()
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

	local stageCfg = AoQiHeroConfig.instance:getNormalStageCfg(self._activityId, self._stageId)
	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, stageCfg.creepsMasterId)

	self._mapRow = teamCfg.row
	self._mapCol = teamCfg.col
	self._map = {}

	for i = 1, self._mapRow do
		self._map[i] = self._map[i] or {}

		for j = 1, self._mapCol do
			local gridId = (i - 1) * self._mapCol + j

			self._map[i][j] = teamCfg.map[gridId] == 0 and AoQiHeroConst.MapEmptyIndex or AoQiHeroConst.MapBlockIndex
		end
	end

	self._enemyDataList = {}

	local creepCfgs = AoQiHeroConfig.instance:getCreepsCfg(self._activityId, stageCfg.creepsMasterId)

	for i, v in ipairs(creepCfgs) do
		local attrData = FightingPowerFormula.instance:parseAttrValues(v.extproperties)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, v.raceId)
		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, v.lv)
		local info = {
			energy = 0,
			pos = v.posId,
			hp = checknumber(attrData[GameEnum.AttrType.Hp]),
			energymax = petCfg.maxEnergy,
			size = petCfg.size,
			configId = v.raceId,
			isEnemy = v.isEnemy,
			skillId = propertyCfg.defenseNormalSkillId
		}

		table.insert(self._enemyDataList, info)
	end

	self._txtName.text = teamCfg.name
end

function AoQiHeroFormationView:getCellSizeHalf()
	return {
		x = 47.5,
		y = 47.5
	}
end

function AoQiHeroFormationView:_genarateMap()
	self:_clearMap()

	self._mapObject = {}

	local cellSizeHalf = self:getCellSizeHalf()
	local posX, poxY = 0, 0
	local step = {
		x = cellSizeHalf.x * 2,
		y = -cellSizeHalf.y * 2
	}

	for row = 1, self._mapRow do
		for col = 1, self._mapCol do
			local obj = self:_genarateGridCell(self._map[row][col])

			self._mapObject[row] = self._mapObject[row] or {}
			self._mapObject[row][col] = obj

			GameUtil.setAnchoredPos(obj, -cellSizeHalf.x * self._mapCol + step.x * (col - 1), cellSizeHalf.y * self._mapRow + step.y * (row - 1))

			local info = self._map[row][col]

			self:setGridBlock(obj, checknumber(info) == AoQiHeroConst.MapBlockIndex)
		end
	end

	local cellContainerPos = GameUtil.getAnchoredPos(self._cellContain)

	GameUtil.setAnchoredPos(self._enemyContain, cellContainerPos.x, cellContainerPos.y)
	GameUtil.SetActive(self._gridCell, false)
end

function AoQiHeroFormationView:_disposeFunc(obj)
	return
end

function AoQiHeroFormationView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
	GameUtil.SetActive(obj.gameObject, false)
end

function AoQiHeroFormationView:_genarateGridCell()
	if not self._cellPools then
		local function resetFunc(obj)
			self:_resetFunc(obj)
		end

		local function disposeFunc(obj)
			self:_disposeFunc(obj)
		end

		local function createFunc()
			return (goutil.cloneAndSetParent(self._gridCell, self._cellContain.gameObject.transform))
		end

		self._cellPools = ObjectPool.New(5, createFunc, disposeFunc, resetFunc)
	end

	local cellObj = self._cellPools:fetchObject()

	goutil.addChildToParent(cellObj.gameObject, self._cellContain.gameObject.transform)
	GameUtil.SetActive(cellObj.gameObject, true)

	return cellObj
end

function AoQiHeroFormationView:_clearMap()
	for row, v in ipairs(self._mapObject or {}) do
		for col, obj in ipairs(v) do
			self._cellPools:returnObject(obj)
		end
	end

	self._mapObject = nil
end

function AoQiHeroFormationView:_genarateEntity()
	self._enemyItemGroup:updateWithMoArray(self._enemyDataList, self._updateEnemyCell, self)
end

function AoQiHeroFormationView:_refreshPetView()
	local posList = {}
	local totalHp = 0
	local activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)

	for i = 1, activityCfg.cardNum do
		local petInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, i)

		if petInfo and checknumber(petInfo.petId) ~= 0 then
			local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, petInfo.petId)
			local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, petInfo.lv)

			totalHp = totalHp + propertyCfg.hp
		end

		table.insert(posList, i)
	end

	self._petTableList:reloadData(posList)

	self._txtMyHp.text = langPara("%d", totalHp)
end

function AoQiHeroFormationView:_updateEnemyCell(cell, data, index)
	local go = cell.mainGO
	local petInfoGo = goutil.findChild(go, "petInfo")
	local hpGo = goutil.findChild(go, "hp")
	local txtName = goutil.findChildTextComponent(go, "txt")
	local txtHpGO = goutil.findChild(go, "hp/slider/txt")
	local txtHp = goutil.findChildTextComponent(go, "hp/slider/txt")
	local sliderHp = Framework.SliderAdapter.GetFrom(go, "hp/slider")
	local petTypeGo = goutil.findChild(go, "hp/petType")
	local typeChange = goutil.findChildComponent(petTypeGo, "type", "UIImageSpriteChange")
	local petInfo = goutil.findChild(go, "petInfo")
	local sliderEnergy = Framework.SliderAdapter.GetFrom(petInfo, "energy")
	local petIcon = goutil.findChild(petInfo, "petCon")
	local itemCon = goutil.findChild(go, "itemCon")
	local itemImageChange = goutil.findChildComponent(go, "itemCon", ComponentType.UIImageSpriteChange)
	local rangeGo = goutil.findChild(go, "hp/range")
	local txtRangeGO = goutil.findChild(rangeGo, "txt")
	local txtRange = goutil.findChildTextComponent(rangeGo, "txt")
	local posX, posY = self:grid2XY(data.pos)
	local sizeX, sizeY = checkint(data.size[1]), checkint(data.size[2])

	GameUtil.setLocalScale(go, sizeY, sizeX)

	local maxScaleSize = math.min(sizeX, sizeY)
	local scaleX, scaleY = maxScaleSize / sizeY, maxScaleSize / sizeX

	GameUtil.setLocalScale(petInfoGo, scaleX, scaleY, 1)
	GameUtil.setLocalScale(hpGo, scaleX, scaleY, 1)
	GameUtil.setLocalScale(itemCon, scaleX, scaleY, 1)
	GameUtil.setLocalScale(txtHpGO, 1 / maxScaleSize, 1 / maxScaleSize, 1)
	GameUtil.setLocalScale(txtRangeGO, 1 / maxScaleSize, 1 / maxScaleSize, 1)
	GameUtil.setAnchoredPos(hpGo, HPGO_ANCHORED_X * scaleX, HPGO_ANCHORED_Y * scaleY)

	txtHp.fontSize = TXT_HP_SIZE * maxScaleSize
	txtRange.fontSize = TXT_RANGE_SIZE * maxScaleSize

	local targetGridCellObj = self._mapObject[posX][posY]
	local cellPos = GameUtil.getAnchoredPos(targetGridCellObj)
	local cellSizeHalf = self:getCellSizeHalf()

	GameUtil.setAnchoredPos(go, cellPos.x - cellSizeHalf.x, cellPos.y + cellSizeHalf.y)

	txtName.text = data.configId
	txtHp.text = data.hp

	sliderHp:SetValue(1)
	sliderEnergy:SetValue(data.energy / data.energymax)

	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data.configId)

	MaterialMgr.resetAll(petIcon)
	MaterialMgr.setIcon(petIcon, MatType.Pet, petCfg.faceIds)

	if petCfg.elementId > 0 then
		GameUtil.SetActive(petTypeGo, true)
		typeChange:SetState(petCfg.elementId - 1)
	else
		GameUtil.SetActive(petTypeGo, false)
	end

	if string.nilorempty(petCfg.res) then
		GameUtil.SetActive(petInfo, true)
		GameUtil.SetActive(itemCon, false)
	else
		itemImageChange:ChangeSprite(petCfg.res)
		GameUtil.SetActive(petInfo, false)
		GameUtil.SetActive(itemCon, true)
	end

	GameUtil.rmClickHandler(go)

	if data.isEnemy == true then
		GameUtil.addClickHandler(go, function()
			self:_onClickEnemy(go, data.configId)
		end)
	end

	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(data.skillId)

	GameUtil.SetActive(rangeGo, checknumber(skillCfg.attackParam) > 0)

	txtRange.text = langPara("距离：%d", checknumber(skillCfg.attackParam))
end

function AoQiHeroFormationView:_clearEnemyCell(cell)
	local go = cell.mainGO
	local petIcon = goutil.findChild(go, "petCon")

	MaterialMgr.resetAll(petIcon)
	GameUtil.rmClickHandler(go)
end

function AoQiHeroFormationView:grid2XY(gridId)
	local x, y

	x = math.ceil(gridId / self._mapCol)

	return x, gridId - (x - 1) * self._mapCol
end

function AoQiHeroFormationView:XY2grid(x, y)
	return (x - 1) * self._mapCol + y
end

function AoQiHeroFormationView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local petInfoGo = goutil.findChild(go, "petInfo")
	local petCon = goutil.findChild(petInfoGo, "petCon/con")
	local txtLv = goutil.findChildTextComponent(petInfoGo, "txtLv")
	local typeChange = goutil.findChildComponent(petInfoGo, "type", "UIImageSpriteChange")
	local imgRange = goutil.findChild(petInfoGo, "imgRange")
	local emptyGo = goutil.findChild(go, "empty")
	local lockGo = goutil.findChild(emptyGo, "lock")
	local txtLock = goutil.findChildTextComponent(lockGo, "txtLock")
	local imgAddGo = goutil.findChild(emptyGo, "imgAdd")

	GameUtil.rmClickHandler(go)
	uGuiUtil.clearImage(imgRange)
	uGuiUtil.clearImage(petCon)

	local posInfo = AoQiHeroModel.instance:getCurPetTeam(self._activityId, data)

	if posInfo and checknumber(posInfo.petId) ~= 0 then
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, posInfo.petId)
		local showRaceId = petCfg.faceIds
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

		if not modelCo then
			printError("t_model id not exist:" .. showRaceId)

			return
		end

		uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

		txtLv.text = langPara("Lv.%d", posInfo.lv)

		if petCfg.elementId > 0 then
			typeChange:SetState(petCfg.elementId - 1)
		end

		GameUtil.SetActive(emptyGo, false)
		GameUtil.SetActive(petInfoGo, true)

		local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, posInfo.lv)
		local skillCfg = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.normalSkillId)

		uGuiUtil.setSpriteToImage(imgRange, uGuiUtil.SpriteType.BigBg, skillCfg.rangeImg)
		GameUtil.addClickHandler(go, function()
			self:_onClickPet(go, posInfo.petId, posInfo.lv)
		end)
	else
		local unlockNum = AoQiHeroModel.instance:getUnlockNum(self._activityId)

		GameUtil.SetActive(emptyGo, true)
		GameUtil.SetActive(petInfoGo, false)
		GameUtil.SetActive(lockGo, unlockNum < data)
		GameUtil.SetActive(imgAddGo, data <= unlockNum)

		if data <= unlockNum then
			GameUtil.addClickHandler(go, function()
				self:_onClickTeam()
			end)
		end

		txtLock.text = self._unlockStage and self._unlockStage[data] and langPara("通关普通模式第%d关解锁", self._unlockStage[data]) or ""
	end
end

function AoQiHeroFormationView:_clearPetCell(cell)
	local go = cell.gameObject
	local petInfoGo = goutil.findChild(go, "petInfo")
	local petCon = goutil.findChild(petInfoGo, "petCon/con")
	local imgRange = goutil.findChild(petInfoGo, "imgRange")

	uGuiUtil.clearImage(petCon)
	uGuiUtil.clearImage(imgRange)
end

function AoQiHeroFormationView:setGridBlock(cell, state)
	local go = cell.gameObject
	local blockGo = goutil.findChild(go, "block")
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)

	GameUtil.SetActive(blockGo, state)
	imgChange:SetState(math.random(0, 7))
end

function AoQiHeroFormationView:_onClickStart()
	local teamInfo = AoQiHeroModel.instance:getCurPetTeams(self._activityId)
	local raceIds = {}

	for i, v in ipairs(teamInfo) do
		if v.petId ~= 0 then
			table.insert(raceIds, v.petId)
		end
	end

	if #raceIds <= 0 then
		FloatWordMgr.instance:show(lang("未上阵精灵"))
	elseif #raceIds < AoQiHeroModel.instance:getUnlockNum(self._activityId) then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("仍有位置可以上阵精灵，确定要开始游戏吗？"), function()
			AoQiHeroController.instance:sendPM_AoQiHeroNormalChallengeReq(self._activityId, self._stageId, raceIds, ViewName.AoQiHeroBattleView)
		end)
	else
		AoQiHeroController.instance:sendPM_AoQiHeroNormalChallengeReq(self._activityId, self._stageId, raceIds, ViewName.AoQiHeroBattleView)
	end
end

function AoQiHeroFormationView:_onClickTeam()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoQiHeroFormationView:_onClickRule()
	local stageCfg = AoQiHeroConfig.instance:getNormalStageCfg(self._activityId, self._stageId)
	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, stageCfg.creepsMasterId)

	TipsFacade.instance:openTipWindow(lang("本关规则"), teamCfg.description)
end

function AoQiHeroFormationView:_onClickPet(go, raceId, lv)
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

function AoQiHeroFormationView:_onClickEnemy(go, raceId)
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = raceId
	param.isAttack = false

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

function AoQiHeroFormationView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(1)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

function AoQiHeroFormationView:_PM_AoQiHeroNormalChallengeRes()
	self:close()
	UIStateManager.instance:push(ViewName.AoQiHeroBattleView, self._activityId, self._stageId)
end

return AoQiHeroFormationView
