-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroDefenceView.lua

module("logic.extensions.aoqihero.view.AoQiHeroDefenceView", package.seeall)

local AoQiHeroDefenceView = class("AoQiHeroDefenceView", ViewComponent)

function AoQiHeroDefenceView:ctor()
	AoQiHeroDefenceView.super.ctor(self)
end

function AoQiHeroDefenceView:unbindEvents()
	AoQiHeroDefenceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChangeMap)
	GameUtil.rmClickHandler(self._btnSave)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBag)
	GameUtil.rmClickHandler(self._btnTip)
end

function AoQiHeroDefenceView:bindEvents()
	AoQiHeroDefenceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChangeMap, self._onClickChangeMap, self)
	GameUtil.addClickHandler(self._btnSave, self._onClickSave, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
end

function AoQiHeroDefenceView:buildUI()
	AoQiHeroDefenceView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._freeContainer = self:getGo("freeContainer")
	self._cellContain = self:getGo("cellContain")
	self._gridCell = self:getGo("cell")
	self._petContain = self:getGo("petContain")
	self._petTableView = self:getGo("petTableview")
	self._petCell = self:getGo("petContain/petCell")
	self._petTableList = ScrollerList.create(self._petTableView, self._petCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	self._petTableList:setDragCallBack("dragCell", function(eventData, data, go)
		self:_onDragBegin(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDrag(eventData, data, go)
	end, function(eventData, data, go)
		self:_onDragEnd(eventData, data, go)
	end)

	self._rangeTips = self:getGo("rangeTips")
	self._enemyContain = self:getGo("enemyContain")
	self._enemyCell = self:getGo("enemyContain/enemyCell")
	self._enemyItemGroup = ItemGroup.New(self._enemyContain, self._enemyCell)
	self._dragCon = self:getGo("dragCon")
	self._dragPetCon = self:getGo("dragCon/petCon")
	self._btnSave = self:getGo("btnSave")
	self._btnChangeMap = self:getGo("btnChangeMap")
	self._selectMapGo = self:getGo("selectMap")
	self._mapTableCell = self:getGo("selectMap/tableview/tablecell")
	self._mapTableView = self:getGo("selectMap/tableview")
	self._mapTableList = ScrollerList.create(self._mapTableView, self._mapTableCell, GameUtil.handler(self._updateMapCell, self), GameUtil.handler(self._clearMapCell, self))
	self._btnSure = self:getGo("selectMap/btnSure")
	self._txtNum = self:getTxt("txtNum")
	self._btnBag = self:getGo("btnBag")
end

function AoQiHeroDefenceView:onExit()
	AoQiHeroDefenceView.super.onExit(self)
	MaterialMgr.resetAll(self._dragPetCon)
end

function AoQiHeroDefenceView:onEnter()
	AoQiHeroDefenceView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_AoQiHeroInfoRes, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = AoQiHeroConfig.instance:getActivityCfg(self._activityId)

	local curMapInfo = AoQiHeroModel.instance:getPvPMapInfo(self._activityId)

	self._setPetMap = {}

	GameUtil.SetActive(self._selectMapGo, false)
	GameUtil.SetActive(self._dragCon, false)

	if curMapInfo and curMapInfo.mapId > 0 then
		self._creepsMasterId = curMapInfo.mapId

		for raceId, pos in pairs(curMapInfo.pets) do
			self._setPetMap[raceId] = pos
		end
	else
		self._creepsMasterId = AoQiHeroModel.instance:getTempPVPDefenceCreepsMasterId()

		if not self._creepsMasterId then
			self._creepsMasterId = self._activityCfg.pvpDefFormations[1]

			AoQiHeroModel.instance:setTempPVPDefenceCreepsMasterId(self._creepsMasterId)
			self:_onClickChangeMap()
		end
	end

	self._maxPetCount = self._activityCfg.pvpDefCreepsNum

	GameUtil.SetActive(self._rangeTips, false)
	self:_resetMap()
	self:_genarateMap()
	self:_refreshView()
end

function AoQiHeroDefenceView:_resetMap()
	local teamCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, self._creepsMasterId)

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

	local mapCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, self._creepsMasterId)

	self._fixGridIds = {}

	for i = 1, #mapCfg.map do
		if mapCfg.map[i] == 1 then
			table.insert(self._fixGridIds, i)
		end
	end

	local itemCfgs = AoQiHeroConfig.instance:getCreepsCfg(self._activityId, self._creepsMasterId)

	for i, v in ipairs(itemCfgs) do
		if not v.isEnemy then
			table.insert(self._fixGridIds, v.posId)
		end
	end
end

function AoQiHeroDefenceView:_refreshView()
	local teamInfo = AoQiHeroModel.instance:getCurPetTeams(self._activityId)

	self._lv = nil

	for k, v in pairs(teamInfo) do
		if self._lv then
			if v.lv < self._lv then
				self._lv = v.lv
			end
		else
			self._lv = v.lv
		end
	end

	local allPetsCfg = AoQiHeroConfig.instance:getUsePetCfgs(self._activityId)

	self._petData = {}

	for i, v in ipairs(allPetsCfg) do
		if AoQiHeroModel.instance:getPetInfo(self._activityId, v.raceId) == true then
			local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(v.propertyStrategyId, self._lv)
			local normaSkillCfg = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.defenseNormalSkillId)

			self._petData[v.raceId] = checkint(normaSkillCfg.attackParam)
		end
	end

	local list = {}

	for k, v in pairs(self._petData) do
		table.insert(list, k)
	end

	table.sort(list, function(a, b)
		local aOn = not not self._setPetMap[a]

		if aOn == ((self._setPetMap[b] or nil) and true) then
			return a < b
		else
			return aOn
		end
	end)
	self._petTableList:reloadData(list)
	self:_refreshGridCell()
	self:_refreshEnemyCell()

	local nums = table.nums(self._setPetMap)

	self._txtNum.text = langPara("可上阵：%d/%d", nums, self._maxPetCount)
end

function AoQiHeroDefenceView:_getCellSizeHalf()
	return {
		x = 47.5,
		y = 47.5
	}
end

function AoQiHeroDefenceView:_genarateMap()
	self:_clearMap()

	self._mapObject = {}

	local cellSizeHalf = self:_getCellSizeHalf()
	local posX, poxY = 0, 0
	local step = {
		x = cellSizeHalf.x * 2,
		y = -cellSizeHalf.y * 2
	}

	for row = 1, self._mapRow do
		for col = 1, self._mapCol do
			local obj = self:_genarateGridCell()

			self._mapObject[row] = self._mapObject[row] or {}
			self._mapObject[row][col] = obj

			GameUtil.setAnchoredPos(obj, -cellSizeHalf.x * self._mapCol + step.x * (col - 1), cellSizeHalf.y * self._mapRow + step.y * (row - 1))

			local info = self._map[row][col]

			self:setGridBlock(obj, checknumber(info) == AoQiHeroConst.MapBlockIndex)
		end
	end

	local cellContainerPos = GameUtil.getAnchoredPos(self._cellContain)
	local petContainerPos = GameUtil.getAnchoredPos(self._petContain)

	self._mapToPetOffset = petContainerPos - cellContainerPos

	GameUtil.setAnchoredPos(self._enemyContain, cellContainerPos.x, cellContainerPos.y)
	GameUtil.setHeight(self._rangeTips, cellSizeHalf.x * 2 * self._mapRow)

	self._rankTipsOffset = {
		x = -cellSizeHalf.x * self._mapCol + cellContainerPos.x - cellSizeHalf.x,
		y = cellContainerPos.y + cellSizeHalf.y
	}

	GameUtil.setAnchoredPos(self._rangeTips, self._rankTipsOffset.x, self._rankTipsOffset.y)
end

function AoQiHeroDefenceView:_disposeFunc(obj)
	return
end

function AoQiHeroDefenceView:_resetFunc(obj)
	goutil.addChildToParent(obj.gameObject, self._freeContainer.gameObject.transform)
	GameUtil.SetActive(obj.gameObject, false)
end

function AoQiHeroDefenceView:_genarateGridCell()
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

function AoQiHeroDefenceView:_clearMap()
	for row, v in ipairs(self._mapObject or {}) do
		for col, obj in ipairs(v) do
			self._cellPools:returnObject(obj)
		end
	end

	self._mapObject = nil
end

function AoQiHeroDefenceView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject

	go.name = "pet_" .. data

	local selectGo = goutil.findChild(go, "select")
	local petCon = goutil.findChild(go, "petCon/con")
	local txtLv = goutil.findChildTextComponent(go, "txtLv")
	local txtRange = goutil.findChildTextComponent(go, "txtRange")
	local typeChange = goutil.findChildComponent(go, "type", "UIImageSpriteChange")
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data)
	local dragCell = goutil.findChild(go, "dragCell")

	if checknumber(petCfg.faceIds) ~= 0 then
		local showRaceId = petCfg.faceIds
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

		if not modelCo then
			printError("t_model id not exist:" .. showRaceId)

			return
		end

		uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	end

	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, self._lv)

	txtLv.text = langPara("Lv.%d", self._lv)
	txtRange.text = langPara("速度：%d", propertyCfg.defSpeed)

	if petCfg.elementId > 0 then
		typeChange:SetState(petCfg.elementId - 1)
	end

	GameUtil.SetActive(selectGo, false)

	local var_22_0 = goutil.findChild(go, "set")

	GameUtil.SetActive(setGo, self._setPetMap[data] or false)
	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:onClickPet(go, data)
	end)
end

function AoQiHeroDefenceView:_clearPetCell(cell)
	local go = cell.gameObject
	local petCon = goutil.findChild(go, "petCon/con")
	local dragCell = goutil.findChild(go, "dragCell")

	GameUtil.rmClickHandler(go)
	uGuiUtil.clearImage(petCon)
end

function AoQiHeroDefenceView:_onDrag(eventData, data, go)
	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local gridX, gridY = self:_checkGrid(posEvent.x + self._mapToPetOffset.x, posEvent.y + self._mapToPetOffset.y)

	if gridX <= 0 or gridX > self._mapRow or gridY <= 0 or gridY > self._mapCol then
		gridX = nil
		gridY = nil
	end

	if gridX ~= self._selectGridX or gridY ~= self._selectGridY then
		self._selectGridX = gridX
		self._selectGridY = gridY

		self:_refreshSelect()
	end

	GameUtil.setAnchoredPos(self._dragCon, posEvent.x, posEvent.y)
end

function AoQiHeroDefenceView:_onDragBegin(eventData, data, go)
	self._selectGridX = nil
	self._selectGridY = nil
	self._selectPet = data

	local selectGo = goutil.findChild(go, "select")

	GameUtil.SetActive(selectGo, true)

	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	GameUtil.setAnchoredPos(self._dragCon, posEvent.x, posEvent.y)
	self:_updateDragCell()
	GameUtil.SetActive(self._dragCon, true)

	self._draging = true
	self._setPetMap[self._selectPet] = nil

	self:_refreshEnemyCell()
end

function AoQiHeroDefenceView:_onDragEnd(eventData, data, go)
	if self._selectGridX and self._selectGridY then
		self:_changePetToGird(self._selectPet, self._selectGridX, self._selectGridY)
	end

	self._selectGridX = nil
	self._selectGridY = nil
	self._selectPet = nil

	self:_refreshSelect()
	self:_refreshView()

	local selectGo = goutil.findChild(go, "select")

	GameUtil.SetActive(selectGo, false)
	GameUtil.SetActive(self._dragCon, false)

	self._draging = false
end

function AoQiHeroDefenceView:_updateDragCell()
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, self._selectPet)

	if checknumber(petCfg.faceIds) ~= 0 then
		MaterialMgr.setIcon(self._dragPetCon, MatType.Pet, checknumber(petCfg.faceIds))
	end
end

function AoQiHeroDefenceView:_refreshSelect()
	for i = 1, self._mapRow do
		for j = 1, self._mapCol do
			self:_setGridCellSelect(self._mapObject[i][j], false)
		end
	end

	GameUtil.SetActive(self._rangeTips, false)

	local petInfo = self._petData[self._selectPet]

	if self._selectGridX and self._selectGridY and petInfo then
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, self._selectPet)
		local sizeX, sizeY = petCfg.size[1], petCfg.size[2]
		local showRange = math.min(self._selectGridY - 1, petInfo)

		for i = self._selectGridX, self._selectGridX + sizeX - 1 do
			for j = self._selectGridY, self._selectGridY - showRange, -1 do
				if i <= self._mapRow and j <= self._mapCol then
					self:_setGridCellSelect(self._mapObject[i][j], true)
				end
			end
		end
	end
end

function AoQiHeroDefenceView:_refreshGridCell()
	for i = 1, self._mapRow do
		for j = 1, self._mapCol do
			self:_setGridCellSelect(self._mapObject[i][j], false)
			self:_setGridCellSet(self._mapObject[i][j], false)
		end
	end

	for k, v in pairs(self._setPetMap) do
		local posX, posY = self:_grid2XY(v)
		local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, k)
		local sizeX, sizeY = petCfg.size[1], petCfg.size[2]

		for p = posX, posX + sizeX - 1 do
			for q = posY, posY + sizeY - 1 do
				if p <= self._mapRow and q <= self._mapCol then
					self:_setGridCellSet(self._mapObject[p][q], true)
				end
			end
		end
	end
end

function AoQiHeroDefenceView:_setGridCellSelect(cell, state)
	local go = cell.gameObject
	local selectGo = goutil.findChild(go, "select")

	GameUtil.SetActive(selectGo, state)
end

function AoQiHeroDefenceView:_setGridCellSet(cell, state)
	local go = cell.gameObject
	local setGo = goutil.findChild(go, "set")

	GameUtil.SetActive(setGo, state)
end

function AoQiHeroDefenceView:_checkGrid(x, y)
	local cellSizeHalf = self:_getCellSizeHalf()
	local rootGridPos = GameUtil.getAnchoredPos(self._mapObject[1][1])
	local offsetX, offsetY = rootGridPos.y - y, x - rootGridPos.x
	local offSetGridX, offSetGridY

	if offsetX < 0 then
		offsetX = offsetX - cellSizeHalf.x
		offSetGridX = math.ceil(offsetX / (cellSizeHalf.x * 2))
	else
		offsetX = offsetX + cellSizeHalf.x
		offSetGridX = math.floor(offsetX / (cellSizeHalf.x * 2))
	end

	if offsetY < 0 then
		offsetY = offsetY - cellSizeHalf.y
		offSetGridY = math.ceil(offsetY / (cellSizeHalf.y * 2))
	else
		offsetY = offsetY + cellSizeHalf.x
		offSetGridY = math.floor(offsetY / (cellSizeHalf.y * 2))
	end

	local realGridX, realGridY = 1 + offSetGridX, 1 + offSetGridY

	return realGridX, realGridY
end

function AoQiHeroDefenceView:_refreshEnemyCell()
	local list = {}

	for i, v in pairs(self._setPetMap) do
		table.insert(list, {
			raceId = i,
			posId = v
		})
	end

	local itemCfgs = AoQiHeroConfig.instance:getCreepsCfg(self._activityId, self._creepsMasterId)

	for i, v in ipairs(itemCfgs) do
		if not v.isEnemy then
			table.insert(list, {
				isItem = true,
				raceId = v.raceId,
				posId = v.posId
			})
		end
	end

	self._enemyItemGroup:updateWithMoArray(list, self._updateEnemyCell, self)
end

function AoQiHeroDefenceView:_updateEnemyCell(cell, data, index)
	local go = cell.mainGO
	local txtName = goutil.findChildTextComponent(go, "txt")
	local txtHp = goutil.findChildTextComponent(go, "hp/slider/txt")
	local sliderHp = Framework.SliderAdapter.GetFrom(go, "hp/slider")
	local sliderEnergy = Framework.SliderAdapter.GetFrom(go, "petInfo/energy")
	local petInfo = goutil.findChild(go, "petInfo")
	local petCon = goutil.findChild(petInfo, "petCon")
	local itemGo = goutil.findChild(go, "itemCon")
	local itemImageChange = goutil.findChildComponent(go, "itemCon", ComponentType.UIImageSpriteChange)
	local hpGo = goutil.findChild(go, "hp")
	local petTypeGo = goutil.findChild(go, "hp/petType")
	local typeChange = goutil.findChildComponent(petTypeGo, "type", "UIImageSpriteChange")
	local dragTrigger = Framework.UIDragTrigger.Get(go)
	local rangeGo = goutil.findChild(go, "hp/range")
	local txtRange = goutil.findChildTextComponent(rangeGo, "txt")
	local posX, posY = self:_grid2XY(data.posId)
	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, data.raceId)
	local sizeX, sizeY = petCfg.size[1], petCfg.size[2]

	GameUtil.setLocalScale(go, sizeX, sizeY)

	if petCfg.elementId > 0 then
		GameUtil.SetActive(petTypeGo, true)
		typeChange:SetState(petCfg.elementId - 1)
	else
		GameUtil.SetActive(petTypeGo, false)
	end

	if checknumber(petCfg.faceIds) ~= 0 then
		MaterialMgr.setIcon(petCon, MatType.Pet, checknumber(petCfg.faceIds))
	end

	local targetGridCellObj = self._mapObject[posX][posY]
	local cellPos = GameUtil.getAnchoredPos(targetGridCellObj)
	local cellSizeHalf = self:_getCellSizeHalf()

	GameUtil.setAnchoredPos(go, cellPos.x - cellSizeHalf.x, cellPos.y + cellSizeHalf.y)

	txtName.text = data.configId

	local propertyCfg = AoQiHeroConfig.instance:getPropertyCfg(petCfg.propertyStrategyId, self._lv or 1)

	txtHp.text = propertyCfg.defHp

	sliderHp:SetValue(1)
	GameUtil.SetActive(hpGo, true)
	GameUtil.SetActive(sliderEnergy, false)
	GameUtil.SetActive(petInfo, not data.isItem)
	GameUtil.SetActive(itemGo, data.isItem == true)
	GameUtil.SetActive(typeChange, not data.isItem)

	if not string.nilorempty(petCfg.res) then
		itemImageChange:ChangeSprite(petCfg.res)
	end

	GameUtil.rmClickHandler(go)
	dragTrigger:RemoveDragListener()
	dragTrigger:RemoveBeginDragListener()
	dragTrigger:RemoveEndDragListener()

	if not data.isItem then
		GameUtil.addClickHandler(go, function()
			self:onClickPet(go, data.raceId)
		end)
		dragTrigger:AddDragListener(self._onDragEnemy, self, data.raceId)
		dragTrigger:AddBeginDragListener(function(eventData)
			self:_onDragBeginEnemy(eventData, data.raceId, go)
		end)
		dragTrigger:AddEndDragListener(self._onDragEndEnemy, self, data.raceId)
	end

	local skillCfg = AoQiHeroConfig.instance:getSkillCfg(propertyCfg.defenseNormalSkillId)

	GameUtil.SetActive(rangeGo, checknumber(skillCfg.attackParam) > 0)

	txtRange.text = langPara("距离：%d", checknumber(skillCfg.attackParam))
end

function AoQiHeroDefenceView:_clearEnemyCell(cell)
	local go = cell.mainGO
	local petCon = goutil.findChild(petInfo, "petCon")
	local dragTrigger = Framework.UIDragTrigger.Get(go)

	dragTrigger:RemoveDragListener()
	dragTrigger:RemoveBeginDragListener()
	dragTrigger:RemoveEndDragListener()
	MaterialMgr.resetAll(petCon)
end

function AoQiHeroDefenceView:_onDragEnemy(eventData, data)
	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)
	local gridX, gridY = self:_checkGrid(posEvent.x + self._mapToPetOffset.x, posEvent.y + self._mapToPetOffset.y)

	if gridX <= 0 or gridX > self._mapRow or gridY <= 0 or gridY > self._mapCol then
		gridX = nil
		gridY = nil
	end

	if gridX ~= self._selectGridX or gridY ~= self._selectGridY then
		self._selectGridX = gridX
		self._selectGridY = gridY

		self:_refreshSelect()
	end

	GameUtil.setAnchoredPos(self._dragCon, posEvent.x, posEvent.y)
end

function AoQiHeroDefenceView:_onDragBeginEnemy(eventData, data, go)
	self._selectGridX = nil
	self._selectGridY = nil
	self._selectPet = data

	local rectTransform = ViewMgr.instance:getUIRoot():GetComponent("RectTransform")
	local posEvent = goutil.screenToLocalPos(eventData.position, rectTransform)

	GameUtil.setAnchoredPos(self._dragCon, posEvent.x, posEvent.y)
	self:_updateDragCell()
	GameUtil.SetActive(self._dragCon, true)

	self._draging = true

	local hpGo = goutil.findChild(go, "hp")
	local infoGo = goutil.findChild(go, "petInfo")

	GameUtil.SetActive(hpGo, false)
	GameUtil.SetActive(infoGo, false)

	self._setPetMap[self._selectPet] = nil
end

function AoQiHeroDefenceView:_onDragEndEnemy(eventData, data)
	if self._selectGridX and self._selectGridY then
		self:_changePetToGird(self._selectPet, self._selectGridX, self._selectGridY)
	end

	self._selectGridX = nil
	self._selectGridY = nil
	self._selectPet = nil

	self:_refreshSelect()
	self:_refreshView()
	GameUtil.SetActive(self._dragCon, false)

	self._draging = false
end

function AoQiHeroDefenceView:setGridBlock(cell, state)
	local go = cell.gameObject
	local blockGo = goutil.findChild(go, "block")
	local imgChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)

	GameUtil.SetActive(blockGo, state)
	imgChange:SetState(math.random(0, 7))
end

function AoQiHeroDefenceView:_grid2XY(gridId)
	local x, y

	x = math.ceil(gridId / self._mapCol)

	return x, gridId - (x - 1) * self._mapCol
end

function AoQiHeroDefenceView:_changePetToGird(petId, posX, posY)
	local pos = (posX - 1) * self._mapCol + posY
	local petInfo = self._petData[petId]

	if not petInfo then
		return
	end

	local petCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, petId)
	local sizeX, sizeY = petCfg.size[1], petCfg.size[2]
	local maxX = posX + sizeX - 1
	local maxY = posY + sizeY - 1

	if posX <= 0 or posY <= 0 or maxX > self._mapRow or maxY > self._mapCol then
		return
	end

	for i, v in ipairs(self._fixGridIds) do
		local fixX, fixY = self:_grid2XY(v)

		if posX <= fixX and fixX <= maxX and posY <= fixY and fixY <= maxY then
			return
		end
	end

	local removePetIndex = {}
	local selectPetCount = 0

	for k, v in pairs(self._setPetMap) do
		local checkX, checkY = self:_grid2XY(v)
		local gridPetCfg = AoQiHeroConfig.instance:getPetCfg(self._activityId, k)
		local checkSizeX, checkSizeY = gridPetCfg.size[1], gridPetCfg.size[2]
		local checkMaxX = checkX + checkSizeX - 1
		local checkMaxY = checkY + checkSizeY - 1

		if posX <= checkMaxX and checkX <= maxX and posY <= checkMaxY and checkY <= maxY then
			table.insert(removePetIndex, k)
		end

		selectPetCount = selectPetCount + 1
	end

	if self._maxPetCount < selectPetCount - #removePetIndex + 1 then
		FloatWordMgr.instance:show(lang("上阵数量已达上限"))

		return
	end

	for i, v in ipairs(removePetIndex) do
		self._setPetMap[v] = nil
	end

	self._setPetMap[petId] = pos
end

function AoQiHeroDefenceView:_updateMapCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgMap = goutil.findChild(go, "imgMap")
	local curMapGo = goutil.findChild(go, "curMap")
	local selectGo = goutil.findChild(go, "select")
	local notSelectGo = goutil.findChild(go, "notSelect")
	local mapCfg = AoQiHeroConfig.instance:getTeamCfg(self._activityId, data)

	GameUtil.rmClickHandler(go)
	GameUtil.addClickHandler(go, function()
		self:_onClickMap(data)
	end)
	GameUtil.SetActive(curMapGo, data == self._creepsMasterId)
	GameUtil.SetActive(selectGo, data == self._selectCreepsMasterId)
	GameUtil.SetActive(notSelectGo, data ~= self._selectCreepsMasterId)
	uGuiUtil.clearImage(imgMap)

	if not string.nilorempty(mapCfg.mapRes) then
		uGuiUtil.setSpriteToImage(imgMap, uGuiUtil.SpriteType.BigBg, mapCfg.mapRes)
	end
end

function AoQiHeroDefenceView:_clearMapCell(cell)
	local go = cell.gameObject
	local imgMap = goutil.findChild(go, "imgMap")

	GameUtil.rmClickHandler(go)
	uGuiUtil.clearImage(imgMap)
end

function AoQiHeroDefenceView:_onClickChangeMap()
	GameUtil.SetActive(self._selectMapGo, true)

	self._selectCreepsMasterId = self._creepsMasterId

	self._mapTableList:reloadData(self._activityCfg.pvpDefFormations)
end

function AoQiHeroDefenceView:_onClickSure()
	GameUtil.SetActive(self._selectMapGo, false)

	if self._selectCreepsMasterId ~= self._creepsMasterId then
		self._creepsMasterId = self._selectCreepsMasterId

		AoQiHeroModel.instance:setTempPVPDefenceCreepsMasterId(self._creepsMasterId)

		self._setPetMap = {}

		self:_resetMap()
		self:_genarateMap()
		self:_refreshView()
	end
end

function AoQiHeroDefenceView:_onClickMap(creepsMasterId)
	self._selectCreepsMasterId = creepsMasterId

	self._mapTableList:reloadData(self._activityCfg.pvpDefFormations)
end

function AoQiHeroDefenceView:_onClickClose()
	TipsFacade.instance:openPopupWindow(lang("提示"), langPara("变更将不会保存，是否退出"), function()
		AoQiHeroModel.instance:setTempPVPDefenceCreepsMasterId(nil)
		self:close()
	end)
end

function AoQiHeroDefenceView:_onClickSave()
	local nums = table.nums(self._setPetMap)

	if nums == 0 then
		FloatWordMgr.instance:show(lang("攻阵不能为空阵"))
	elseif nums < self._maxPetCount then
		local content = langPara("上阵精灵未满%d只，是否保存", self._maxPetCount)

		TipsFacade.instance:openPopupWindow(lang("提示"), content, function()
			local pbTable = self:_setPetToPb()

			AoQiHeroAgent.instance:sendPM_AoQiHeroPvPSetDefFormationReq(self._activityId, pbTable, self._creepsMasterId)
			self:close()
		end)
	else
		local pbTable = self:_setPetToPb()

		AoQiHeroAgent.instance:sendPM_AoQiHeroPvPSetDefFormationReq(self._activityId, pbTable, self._creepsMasterId)
		self:close()
	end
end

function AoQiHeroDefenceView:_setPetToPb()
	local pbTable = {}

	for petId, pos in pairs(self._setPetMap) do
		local targetPb = AoQiHeroExtension_pb.AoQiHeroDefFormationItem()

		targetPb.posId = pos
		targetPb.raceId = petId

		table.insert(pbTable, targetPb)
	end

	return pbTable
end

function AoQiHeroDefenceView:onClickPet(go, raceId)
	if self._draging then
		return
	end

	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(go)
	local param = {}

	param.pos = pos
	param.sizeDelta = sizeDelta
	param.view = self
	param.activityId = self._activityId
	param.raceId = raceId
	param.isAttack = false
	param.lv = self._lv

	ViewMgr.instance:open(ViewName.AoqiHeroPetTipsView, param)
end

function AoQiHeroDefenceView:_onClickBag()
	UIStateManager.instance:push(ViewName.AoqiHeroStrengthenView, self._activityId)
end

function AoQiHeroDefenceView:_onClickTips()
	local ruleCfgs = AoQiHeroConfig.instance:getImageRuleCfg(3)
	local list = {}

	for i, v in ipairs(ruleCfgs) do
		table.insert(list, {
			url = v.resName,
			desc = v.desc
		})
	end

	TipsFacade.instance:openImageRuleView(list, ruleCfgs[1].title)
end

return AoQiHeroDefenceView
