-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClimbTowerDemo\\ClimbTowerDragWall.lua

local UIUtils = require("Framework.UI.UIUtils")
local GameSettings = require("Helper/GameSettings")
local ClimbTowerObject = require("ClimbTowerDemo/ClimbTowerObject")
local ClimbTowerHero = require("ClimbTowerDemo/ClimbTowerHero")
local ResClimbTowerAction = require("ClientData/ResClimbTowerAction")
local ResClimbTowerItem = require("ClientData/ResClimbTowerItem")
local ResMiniGameMisc = require("ClientData/ResMiniGameMisc")
local BattleConst = require("Common/FrameBattle/BattleConst")
local CueDataBank = require("System/CueDataBank")
local DEFAULT_WALL_PIC_PATH = "Drag/RearHouse/bizhi/hz_bizhi_default"
local ClimbTowerDragWall = Class("ClimbTowerDragWall")
local UP_OFFSET = Const.REARHOUSE_UP_OFFSET
local ROW = 69 + UP_OFFSET
local COLUMN = Const.MINIGAME_COLUMN
local HIT_TIME = 0.5
local DIE_TIME = 0.5

ClimbTowerDragWall.ROW = ROW
ClimbTowerDragWall.COLUMN = COLUMN

function ClimbTowerDragWall:ctor(dragCenter, state, zoneName, index)
	self.inited = false
	self.mainState = state
	self.dragCenter = dragCenter
	self.zoneName = zoneName
	self.index = index
	self.zoneId = self.dragCenter.getZoneId(zoneName)
	self.csPanel = UIUtils.InitRearHouseDragCenter(self.zoneName, Slot(self.mCheckPos, self))
	self.transform = self.csPanel.transform
	self.objs = {}
	self.baseObjs = {}
	self.curDragObj = nil
	self.rows = ROW
	self.limitRows = self.rows - 4
	self.columns = COLUMN
	self.gridSize = Const.MINIGAME_GRID_SIZE

	self:initWallNode()
	self:resetLevelData()

	local traRoot = self.csPanel.transform.parent

	self:initRoot(traRoot)
	self.csPanel:SetGridCount(self.rows, self.columns, self.gridSize)
	self:initData()
	self:showBack(false)
	CueDataBank.initCueData("35001")

	self.inited = true
end

function ClimbTowerDragWall:initRoot(traRoot)
	traRoot.position = Vector3(traRoot.position.x, traRoot.position.y - 1 * self.gridSize, traRoot.position.z)
end

function ClimbTowerDragWall:initData(...)
	self.bounds = {}

	local tra = self.csPanel.transform
	local xOffset = self.columns * self.gridSize * 0.5
	local yOffset = self.rows * self.gridSize * 0.5
	local leftUpPos = Vector2(tra.position.x + xOffset, tra.position.y + yOffset)
	local rightDownPos = Vector2(tra.position.x - xOffset, tra.position.y - yOffset)
	local edit = {}

	edit.leftUpPos = leftUpPos
	edit.rightDownPos = {}
	edit.rightDownPos.y = rightDownPos.y + 3.5 * self.gridSize
	edit.rightDownPos.x = rightDownPos.x
	self.bounds.edit = edit
	self.bounds.edit.z = tra.position.z
	self.dragCenter.bounds = self.bounds
	self.dragModelRoot = self.csPanel:GetDragModelRoot()
	self.staticModelRoot = self.csPanel:GetStaticModelRoot()

	self:initCreation()
end

function ClimbTowerDragWall:initCreation(...)
	local t = {}
	local oriWidth = self.bounds.edit.leftUpPos.x - self.bounds.edit.rightDownPos.x
	local oriHeight = self.bounds.edit.leftUpPos.y - self.bounds.edit.rightDownPos.y

	t.size = Vector2(oriWidth * 1.5, oriHeight * 1.5)
	t.lock = {}

	self.csPanel:InitCreation(t)
end

function ClimbTowerDragWall:resetLevelData()
	self.rowOffset, self.colOffset = self.dragCenter.getHeroRowAndColOffSet()
	self.towerHeight = self.dragCenter.getTowerHeight()
	self.cameraMoveSpace = self.dragCenter.getCameraMoveSpace()

	self:showWallNode()
end

function ClimbTowerDragWall:setWallTexture(url)
	if self.csPanel then
		if not url then
			if self.zoneId >= 10 then
				url = DEFAULT_WALL_PIC_PATH .. self.zoneId
			else
				url = DEFAULT_WALL_PIC_PATH .. "0" .. self.zoneId
			end

			self.wallTextureData = nil
		end

		self.csPanel:SetWallTexture(url)
	end
end

function ClimbTowerDragWall:initWallNode()
	self.wallNodes = {}

	for i = 1, 5 do
		local wallName = Const.WALL_NODE_DEFAULT_NAME .. i
		local wallNode = UnityEngine.GameObject.Find(wallName)

		if wallNode then
			self.wallNodes[i] = wallNode
		end
	end
end

function ClimbTowerDragWall:showWallNode()
	local wallNode = self.dragCenter.getWallNode()

	for i, node in ipairs(self.wallNodes or {}) do
		node.gameObject:SetActive(wallNode == i)
	end
end

function ClimbTowerDragWall:showBack(v)
	if self.csPanel then
		self.csPanel:Show(v)
	end
end

function ClimbTowerDragWall:findDragingObj(gridIdx)
	if self.curDragObj and self.curDragObj.isClick and self.curDragObj:isInArea(gridIdx) then
		self.curDragObj:setDragBegin()
	end
end

function ClimbTowerDragWall:mCheckPos(pos, eventName)
	if self.inBattle then
		MsgManager.notice(Lang.get(96882))

		return
	elseif self.isChanging then
		return
	end

	local gridIdx = self:posToGridIndex(pos)
	local r, c = self:posToRowCol(pos)

	if eventName == "click" then
		self:circleChoose(gridIdx)

		return
	elseif eventName == "dragBegin" then
		self:findDragingObj(gridIdx)

		return
	end

	if self.curDragObj == nil then
		return
	end

	local r, c = self:posToRowCol(pos)
	local rowOffset = self.curDragObj.gridIndexOffset.rowOffset
	local colOffset = self.curDragObj.gridIndexOffset.colOffset
	local modelPos = self.curDragObj.posOffset + pos

	self.curDragObj:setModelMovePos(modelPos)

	local newGridIdx = self.curDragObj:isInLimitBounds(r - rowOffset, c - colOffset)

	if newGridIdx == -1 or self.curDragObj.gridPos == newGridIdx then
		return
	end

	self.curDragObj:setGridIndex(newGridIdx, true)
end

function ClimbTowerDragWall:circleChoose(gridIdx)
	if self.curDragObj and self.curDragObj:isInArea(gridIdx) then
		self.curDragObj:setClick()
		self.dragCenter.setClickingObj()
	end
end

function ClimbTowerDragWall:getCurDragObj(...)
	return self.curDragObj
end

function ClimbTowerDragWall:posToRowCol(pos)
	local x = self.bounds.edit.leftUpPos.x - pos.x
	local y = self.bounds.edit.leftUpPos.y - pos.y
	local rowIdx = math.ceil(y / self.gridSize)
	local columnIdx = math.ceil(x / self.gridSize)

	return rowIdx, columnIdx
end

function ClimbTowerDragWall:posToGridIndex(pos)
	local rowIdx, columnIdx = self:posToRowCol(pos)

	return math.max(0, rowIdx - 1) * self.columns + columnIdx
end

function ClimbTowerDragWall:gridIdxToRowColumn(gridIdx)
	local r = math.ceil(gridIdx / self.columns)
	local c = gridIdx % self.columns

	c = c == 0 and self.columns or c

	return r, c
end

function ClimbTowerDragWall:rowColToGridIdx(r, c)
	return (r - 1) * self.columns + c
end

function ClimbTowerDragWall:gridIdxToPos(gridIdx, range)
	local r, c = self:gridIdxToRowColumn(gridIdx)
	local vec = Vector3(self.bounds.edit.leftUpPos.x - (c - 1 + range.x * 0.5) * self.gridSize, self.bounds.edit.leftUpPos.y - (r - 1 + range.y * 0.5) * self.gridSize, 0)

	return vec
end

function ClimbTowerDragWall:isInTowerRange()
	local curObjLayer = self.curDragObj.layer
	local curRow, curCol = self:gridIdxToRowColumn(self.curDragObj.gridPos)
	local rangeData = self.curDragObj.rangeData[1]

	for towerIndex, data in pairs(self.objs) do
		for layer, objs in pairs(data) do
			for did, obj in pairs(objs) do
				if obj.type == Const.REARHOUSE_TYPE_SHELF and obj.initData.partType and obj.initData.partType == Const.CLIMB_TOWER_TYPE_BODY then
					local shelfLength = obj.rangeData[1].x
					local shelfHeight = obj.rangeData[1].y
					local row, col = self:gridIdxToRowColumn(obj.gridPos)

					if curRow + rangeData.y - row <= 1 and curRow + rangeData.y - row >= -(shelfHeight - 1) and shelfLength >= curCol - (col - shelfLength / 2) and curCol - (col - shelfLength / 2) >= 0 then
						if towerIndex == self.curAttackTower or towerIndex == self.curAttackTower - 1 then
							return true, towerIndex, layer
						elseif towerIndex < self.curAttackTower - 1 then
							MsgManager.notice(Lang.get(99466))

							return false
						end
					end
				end
			end
		end
	end

	return false
end

function ClimbTowerDragWall:getPutGridPos(towerIndex, layer)
	for _, obj in pairs(self.objs[towerIndex][layer] or {}) do
		if obj.type == Const.REARHOUSE_TYPE_SHELF and obj.initData.partType and obj.initData.partType == Const.CLIMB_TOWER_TYPE_BODY then
			local row, col = self:gridIdxToRowColumn(obj.gridPos)
			local rangeData = self.curDragObj.rangeData[1]

			col = col - self.colOffset - rangeData.x

			local newGridPos = self:rowColToGridIdx(row - rangeData.y - self.rowOffset, col)

			return newGridPos
		end
	end

	return self.curDragObj.oldGridPos
end

function ClimbTowerDragWall:getPutPos(towerIndex, layer)
	for _, obj in pairs(self.objs[towerIndex][layer] or {}) do
		if obj.type == Const.REARHOUSE_TYPE_SHELF and obj.initData.partType and obj.initData.partType == Const.CLIMB_TOWER_TYPE_BODY then
			local vec = self:gridIdxToPos(obj.gridPos, {
				x = 0,
				y = 0
			})

			return vec
		end
	end

	return Vector3(0, 0, 0)
end

function ClimbTowerDragWall:checkPosIsRight()
	local isInTower, towerIndex, layer = self:isInTowerRange()

	if not isInTower then
		self.dragCenter.showWarning(true)

		local oldGridPos = self.curDragObj.oldGridPos

		self.curDragObj:setGridIndex(oldGridPos, true)
	else
		local newGridPos = self:getPutGridPos(towerIndex, layer)

		self.curDragObj:setGridIndex(newGridPos, true)
		self.dragCenter.showWarning(false)
		self:handlePutEvent(towerIndex, layer)
		self:playPutVoice()
		BeginnerManager.noticeMiniGame(Const.MINI_GAME_TYPE_CLIMB_TOWER)
	end

	return true
end

function ClimbTowerDragWall:playPutVoice()
	if ResMiniGameMisc[1] and ResMiniGameMisc[1].put_voice then
		CueManager.playVocal(ResMiniGameMisc[1].put_voice)
	end
end

function ClimbTowerDragWall:checkIsClearTower()
	local isAllEmpty = true

	for layer, layerData in pairs(self.objs[self.curAttackTower] or {}) do
		local isEmpty = self:isTowerLayerEmpty(self.curAttackTower, layer)

		if not isEmpty then
			return false
		end
	end

	return true
end

function ClimbTowerDragWall:isTowerLayerEmpty(towerIndex, layer)
	local isEmpty = true

	for _, obj in pairs(self.objs[towerIndex][layer] or {}) do
		if obj.type ~= Const.REARHOUSE_TYPE_SHELF and obj.did ~= self.curDragObj.did then
			isEmpty = false

			break
		end
	end

	return isEmpty
end

function ClimbTowerDragWall:changeTopObjLayer(topObj)
	local maxLayer

	for layer, layerData in pairs(self.objs[self.curAttackTower] or {}) do
		if maxLayer == nil or maxLayer < layer then
			maxLayer = layer
		end
	end

	if maxLayer and self.objs[self.curAttackTower][maxLayer] then
		self.objs[self.curAttackTower][maxLayer][topObj.did] = topObj
	end
end

function ClimbTowerDragWall:checkEmptyLayer()
	local isEmptyLayer, topObj

	for layer, layerData in pairs(self.objs[self.curAttackTower] or {}) do
		local isEmpty = self:isTowerLayerEmpty(self.curAttackTower, layer)

		if isEmpty and self.curDragMoveLayer ~= layer then
			isEmptyLayer = layer

			local delObjs = {}

			for i, obj in pairs(layerData) do
				if obj.initData.partType == Const.CLIMB_TOWER_TYPE_TOP then
					topObj = obj
				else
					table.insert(delObjs, obj)
				end
			end

			self:delObj(delObjs)
		end
	end

	if isEmptyLayer then
		for layer, layerData in pairs(self.objs[self.curAttackTower] or {}) do
			if isEmptyLayer <= layer then
				for _, obj in pairs(layerData or {}) do
					local row, col = self:gridIdxToRowColumn(obj.gridPos)

					row = row + self.towerHeight

					local newGridPos = self:rowColToGridIdx(row, col)

					obj:setGridIndex(newGridPos, true, true)
				end
			end
		end

		self.objs[self.curAttackTower][isEmptyLayer] = nil

		if topObj then
			self:changeTopObjLayer(topObj)
		end

		if self.curDragMoveTower and self.curDragMoveTower == self.curAttackTower and self.curDragMoveLayer and isEmptyLayer < self.curDragMoveLayer then
			local row, col = self:gridIdxToRowColumn(self.curDragObj.gridPos)

			row = row + self.towerHeight

			local newGridPos = self:rowColToGridIdx(row, col)

			self.curDragObj:setGridIndex(newGridPos, true, true)
		end

		local curMyMaxLayer = 0

		for layer, layerData in pairs(self.objs[self.curAttackTower - 1] or {}) do
			curMyMaxLayer = curMyMaxLayer + 1

			for _, obj in pairs(layerData or {}) do
				if not obj.isMySelf then
					local row, col = self:gridIdxToRowColumn(obj.gridPos)

					row = row - self.towerHeight

					local newGridPos = self:rowColToGridIdx(row, col)

					obj:setGridIndex(newGridPos, true, true)
				end
			end
		end

		self.dragCenter.createMyNewLayerData(curMyMaxLayer + 1, self.curAttackTower - 1)
	end
end

function ClimbTowerDragWall:handlePutEvent(towerIndex, layer)
	self.curDragMoveTower = towerIndex
	self.curDragMoveLayer = layer

	if towerIndex == self.curAttackTower - 1 then
		self.gainObj = nil

		for _, obj in pairs(self.objs[towerIndex][layer] or {}) do
			if obj.type ~= Const.REARHOUSE_TYPE_SHELF and not obj.isMySelf then
				self.gainObj = obj

				self:playGainShow()

				break
			end
		end
	else
		self:checkEmptyLayer()

		self.enemyObj = nil

		for _, obj in pairs(self.objs[towerIndex][layer] or {}) do
			if obj.type ~= Const.REARHOUSE_TYPE_SHELF or obj.layer == self.curDragObj.layer then
				self.enemyObj = obj

				self:playBattleShow()

				break
			end
		end
	end
end

function ClimbTowerDragWall:playBattleShow()
	self.inBattle = true

	local skillData = self.curDragObj.skillData[Const.CLIMB_TOWER_ACTION_TYPE_ATTACK]

	if self.enemyObj.isBoss then
		skillData = self.curDragObj.skillData[Const.CLIMB_TOWER_ACTION_TYPE_SKILL]
	end

	self.curDragObj:playActionById(skillData.action_id or "skill1110109")

	if not self.hitTimer then
		self.hitTimer = Timer.New(Slot(self.playEnemyHit, self), skillData.hit_delay_time or HIT_TIME, 1)
	end

	self.hitTimer:Start()

	self.enemyObjNum = self.enemyObj.num

	if self.curDragObj.num > self.enemyObj.num then
		if not self.dieTimer then
			self.dieTimer = Timer.New(Slot(self.playEnemyDie, self), skillData.die_delay_time or 1, 1)
		end

		self.dieTimer:Start()
	end

	if not self.battleTimer then
		self.battleTimer = Timer.New(Slot(self._battleEnd, self), skillData.show_time, 1)
	end

	self.battleTimer:Start()
end

function ClimbTowerDragWall:playEnemyHit()
	if self.hitTimer then
		self.hitTimer:Stop()

		self.hitTimer = nil
	end

	if self.enemyObj then
		self.enemyObj:playAnimator("Hit")
	end
end

function ClimbTowerDragWall:playEnemyDie()
	if self.dieTimer then
		self.dieTimer:Stop()

		self.dieTimer = nil
	end

	if self.enemyObj then
		self.enemyObj:playAnimator("Die")
	end

	if not self.dieTimer then
		self.dieTimer = Timer.New(Slot(self._clearEnemy, self), DIE_TIME, 1)
	end

	self.dieTimer:Start()
end

function ClimbTowerDragWall:_clearEnemy()
	if self.dieTimer then
		self.dieTimer:Stop()

		self.dieTimer = nil
	end

	self.curDragObj.num = self.curDragObj.num + self.enemyObj.num

	self.curDragObj:refreshNumInfo()
	self:delObj({
		self.enemyObj
	})

	self.enemyObj = nil

	local isClear = self:checkIsClearTower()

	if isClear then
		if self.objs[self.curAttackTower + 1] then
			self:changeMyObjData()

			self.curAttackTower = self.curAttackTower + 1

			self.mainState:tweenMoveCamreaX(-(self.cameraMoveSpace or 10) * self.gridSize, 1)
			self:refreshPlayTowerEffect()
		else
			local skillData = self.curDragObj.skillData[Const.CLIMB_TOWER_ACTION_TYPE_WIN]

			self.curDragObj:playActionById(skillData.action_id)
			self:playModelVocalByType(Const.HERO_VOCAL_VICTORY)

			if not self.dieTimer then
				self.dieTimer = Timer.New(Slot(self.playEndAvg, self), skillData.show_time, 1)
			end

			self.dieTimer:Start()
		end
	else
		MsgManager.notice(Lang.get(96885))
	end

	self.inBattle = false
end

function ClimbTowerDragWall:playEndAvg()
	if self.dieTimer then
		self.dieTimer:Stop()

		self.dieTimer = nil
	end

	local preAvgId, endAvgId = self.dragCenter.getPreAndEndAvgId()

	if endAvgId then
		self:setHideAllLogo(true)
		UIManager.playAVG(endAvgId, nil, Slot(self.sendRpcWin, self))
	else
		self:sendRpcWin()
	end
end

function ClimbTowerDragWall:sendRpcWin()
	self.isPlayPreAvg = false

	local chapter, stage = CurAvatar:getChapterAndStage(Const.MINI_GAME_TYPE_CLIMB_TOWER)

	RPC.relaxingGamePass(Const.MINI_GAME_TYPE[Const.MINI_GAME_TYPE_CLIMB_TOWER], chapter, stage)
end

function ClimbTowerDragWall:_battleEnd()
	if self.battleTimer then
		self.battleTimer:Stop()

		self.battleTimer = nil
	end

	if self.curDragObj.num > self.enemyObjNum then
		-- block empty
	else
		local skillData = self.curDragObj.skillData[Const.CLIMB_TOWER_ACTION_TYPE_LOSE]

		self.curDragObj:playActionById(skillData.action_id)
		self:playModelVocalByType(Const.HERO_VOCAL_FAIL)

		if not self.battleTimer then
			self.battleTimer = Timer.New(Slot(self.loseActionEnd, self), skillData.show_time, 1)
		end

		self.battleTimer:Start()
	end
end

function ClimbTowerDragWall:loseActionEnd()
	if self.battleTimer then
		self.battleTimer:Stop()

		self.battleTimer = nil
	end

	MsgManager.notice(Lang.get(101433))

	self.inBattle = false
end

function ClimbTowerDragWall:playGainShow()
	if self.gainObj then
		if self.gainObj.changeModel and self.gainObj.changeModel ~= 0 then
			local skillData = self.curDragObj.skillData[Const.CLIMB_TOWER_ACTION_TYPE_GAIN]

			self.curDragObj:playActionById(skillData.action_id)

			self.isChanging = true

			if not self.battleTimer then
				self.battleTimer = Timer.New(Slot(self.changeModel, self), skillData.show_time, 1)
			end

			self.battleTimer:Start()
		elseif self.gainObj.num and self.gainObj.num ~= 0 then
			if self.gainObj.numType == Const.CLIMB_TOWER_NUM_TYPE_ADD then
				self.curDragObj.num = self.curDragObj.num + self.gainObj.num
			elseif self.gainObj.numType == Const.CLIMB_TOWER_NUM_TYPE_MULTIPLY then
				self.curDragObj.num = self.curDragObj.num * self.gainObj.num
			end

			self.curDragObj:refreshNumInfo()

			local skillData = self.curDragObj.skillData[Const.CLIMB_TOWER_ACTION_TYPE_GAIN]

			self.curDragObj:playActionById(skillData.action_id)
			self:playModelVocalByType(Const.HERO_VOCAL_DRAG)
			MsgManager.notice(Lang.get(96887))
			self:delObj({
				self.gainObj
			})

			self.gainObj = nil
		end
	end
end

function ClimbTowerDragWall:changeModel()
	if self.battleTimer then
		self.battleTimer:Stop()

		self.battleTimer = nil
	end

	local initData = self.curDragObj.initData

	initData.modelId = self.gainObj.changeModel

	if self.gainObj.numType == Const.CLIMB_TOWER_NUM_TYPE_ADD then
		initData.num = self.curDragObj.num + self.gainObj.num
	elseif self.gainObj.numType == Const.CLIMB_TOWER_NUM_TYPE_MULTIPLY then
		initData.num = self.curDragObj.num * self.gainObj.num
	end

	local towerIndex = self.gainObj.initData.towerIndex
	local layer = self.gainObj.initData.layer

	self:delObj({
		self.curDragObj,
		self.gainObj
	})

	self.gainObj = nil

	self.dragCenter.createNewMySelfModel(initData)

	for index, data in pairs(self.objs) do
		for _, objs in pairs(data) do
			for did, obj in pairs(objs) do
				if obj.initData.isMySelf then
					self:setCurDragObj(obj)
					self.curDragObj:setClick()
					self.dragCenter.setClickingObj()

					local gridPos = self:getPutGridPos(towerIndex, layer)

					self.curDragObj:setGridIndex(gridPos, true)
				end
			end
		end
	end

	self.isChanging = false
end

function ClimbTowerDragWall:playModelVocalByType(type)
	local heroId = self.curDragObj:getHeroId()

	CueManager.playHeroVocal(heroId, type)
end

function ClimbTowerDragWall:showPlane(obj, show, colorMode)
	if obj then
		obj:showPlane(show, colorMode)
	end
end

function ClimbTowerDragWall:refreshPlayTowerEffect()
	for index, data in pairs(self.objs) do
		for layer, objs in pairs(data) do
			for did, obj in pairs(objs) do
				if obj.type == Const.REARHOUSE_TYPE_SHELF then
					obj:playTowerObjEffect(self.curAttackTower)
				end
			end
		end
	end
end

function ClimbTowerDragWall:changeMyObjData()
	local leftLayer

	for layer, layerData in pairs(self.objs[self.curAttackTower] or {}) do
		if layer == 1 then
			return
		end

		leftLayer = layer
	end

	if leftLayer then
		self.objs[self.curAttackTower][1] = self.objs[self.curAttackTower][leftLayer]
		self.objs[self.curAttackTower][leftLayer] = nil
	end
end

function ClimbTowerDragWall:setHideAllLogo(v)
	for index, data in pairs(self.objs) do
		for layer, objs in pairs(data) do
			for did, obj in pairs(objs) do
				obj:setHideLogo(v)
			end
		end
	end
end

function ClimbTowerDragWall:playPreAvg()
	local preAvgId = self.dragCenter.getPreAndEndAvgId()

	if preAvgId and not self.isPlayPreAvg then
		self:setHideAllLogo(true)
		UIManager.playAVG(preAvgId, nil, Slot(self.endPreAvg, self))

		self.isPlayPreAvg = true
	else
		self:setHideAllLogo(false)
		CurAvatar:checkBeginnerTrigger(Const.MINI_GAME_TYPE_CLIMB_TOWER)
	end
end

function ClimbTowerDragWall:endPreAvg()
	self:setHideAllLogo(false)
	CurAvatar:checkBeginnerTrigger(Const.MINI_GAME_TYPE_CLIMB_TOWER)
end

function ClimbTowerDragWall:resetLoad(func)
	self:resetLevelData()

	if func then
		func()
	end

	self:onInitObjsLoadEnd()
end

function ClimbTowerDragWall:onInitObjsLoadEnd(...)
	local function func(...)
		for index, data in pairs(self.objs) do
			for layer, objs in pairs(data) do
				for did, obj in pairs(objs) do
					if obj.initData.isMySelf then
						self:setCurDragObj(obj)
						self.curDragObj:setClick()
						self.dragCenter.setClickingObj()
					end
				end
			end
		end

		self.curAttackTower = 2

		self:refreshPlayTowerEffect()
		self:playPreAvg()
	end

	self.coInitObjs = coroutine.start(func)
end

function ClimbTowerDragWall:addObj(datas)
	for i, data in ipairs(datas) do
		local putData = data.putData
		local initData = data.initData
		local obj = self:_createObj(self, putData, initData)

		if initData.partType and initData.partType == Const.CLIMB_TOWER_TYPE_BASE then
			if not self.baseObjs[initData.towerIndex] then
				self.baseObjs[initData.towerIndex] = {}
			end

			self.baseObjs[initData.towerIndex][obj.did] = obj
		else
			if not self.objs[initData.towerIndex] then
				self.objs[initData.towerIndex] = {}
			end

			if not self.objs[initData.towerIndex][initData.layer] then
				self.objs[initData.towerIndex][initData.layer] = {}
			end

			self.objs[initData.towerIndex][initData.layer][obj.did] = obj
		end

		obj:loadModel()
	end
end

function ClimbTowerDragWall:_createObj(parent, putData, initData)
	if putData.data.typeId == 5 then
		return ClimbTowerHero(BattleConst.SHOW_ACTOR_ID_START, "", parent, putData, initData)
	else
		return ClimbTowerObject(BattleConst.SHOW_ACTOR_ID_START, "", parent, putData, initData)
	end
end

function ClimbTowerDragWall:delObj(objs)
	for _, obj in pairs(objs) do
		if obj then
			obj:onDel()

			self.objs[obj.initData.towerIndex][obj.initData.layer][obj.did] = nil
		end
	end

	return true
end

function ClimbTowerDragWall:setCurDragObj(obj)
	self.curDragObj = obj

	self.dragCenter.setCurDragObj(obj)
end

function ClimbTowerDragWall:setDraging(...)
	self.dragCenter.setDraging(true)
end

function ClimbTowerDragWall:delAllObj(isForceAll, isIncludeStage)
	for towerIndex, data in pairs(self.objs) do
		for layer, objs in pairs(data) do
			for did, obj in pairs(objs) do
				if obj then
					obj:destroy()

					obj = nil
				end
			end
		end
	end

	self.objs = {}

	for towerIndex, objs in pairs(self.baseObjs) do
		for did, obj in pairs(objs) do
			if obj then
				obj:destroy()

				obj = nil
			end
		end
	end

	self.baseObjs = {}

	self:stopAllTimer()
end

function ClimbTowerDragWall:stopAllTimer()
	if self.battleTimer then
		self.battleTimer:Stop()

		self.battleTimer = nil
	end

	if self.dieTimer then
		self.dieTimer:Stop()

		self.dieTimer = nil
	end

	if self.hitTimer then
		self.hitTimer:Stop()

		self.hitTimer = nil
	end

	self.inBattle = false
end

function ClimbTowerDragWall:clearObjs(...)
	for towerIndex, data in pairs(self.objs) do
		for layer, objs in pairs(data) do
			for did, obj in pairs(objs) do
				if obj then
					obj:destroy()

					obj = nil
				end
			end
		end
	end

	self.objs = {}

	for towerIndex, objs in pairs(self.baseObjs) do
		for did, obj in pairs(objs) do
			if obj then
				obj:destroy()

				obj = nil
			end
		end
	end

	self.baseObjs = {}
end

function ClimbTowerDragWall:destroy(...)
	self:clearObjs()
	self:stopAllTimer()

	self.csPanel = nil
	self.dragModelRoot = nil
	self.staticModelRoot = nil
	self.inited = false

	if self.coInitObjs then
		coroutine.stop(self.coInitObjs)

		self.coInitObjs = nil
	end

	if self.transform and self.transform.parent then
		UnityEngine.Object.Destroy(self.transform.parent.gameObject)
	end

	self.transform = nil

	if self.battleTimer then
		self.battleTimer:Stop()

		self.battleTimer = nil
	end
end

return ClimbTowerDragWall
