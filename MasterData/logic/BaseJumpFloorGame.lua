-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/game/BaseJumpFloorGame.lua

module("logic.extensions.jumpfloor.view.game.BaseJumpFloorGame", package.seeall)

local BaseJumpFloorGame = class("BaseJumpFloorGame")

BaseJumpFloorGame.GameState = {
	GameEnd = 4,
	Pause = 3,
	StartBefore = 1,
	Playing = 2
}
BaseJumpFloorGame.AnimationTime = 0.16
BaseJumpFloorGame.DropTime = 0.3
BaseJumpFloorGame.UpdateStageMap = "updatestagemap"
BaseJumpFloorGame.UpdateShield = "updateshield"
BaseJumpFloorGame.TriggerTrap = "gameover"

function BaseJumpFloorGame:ctor()
	self._localDispatcher = {}

	NotifyDispatcher.extend(self._localDispatcher)
	self:reset()
end

function BaseJumpFloorGame:reset()
	self._cellDataList = {}
	self._cellDataDic = {}
	self._curCellData = nil
	self._emptyCellData = JumpFloorCellData.New(1, 1, 0, 0, 0)
	self._curPassFloors = 0
	self._totalCountdown = 0
	self._curCountdown = 0
	self._gameState = self.GameState.StartBefore
	self._destinationFloorNum = 0
	self._isForceExit = false
	self._shieldBuff = 0
	self._stepCellDataList = {}

	removetimer(self._onUpdate, self)
end

function BaseJumpFloorGame:addListener(name, handler, handlerObj, priority)
	self._localDispatcher:addListener(name, handler, handlerObj)
end

function BaseJumpFloorGame:removeListener(name, handler, handlerObj)
	self._localDispatcher:removeListener(name, handler, handlerObj)
end

function BaseJumpFloorGame:dispatch(name, ...)
	self._localDispatcher:dispatch(name, ...)
end

function BaseJumpFloorGame:init(...)
	return
end

function BaseJumpFloorGame:setCellDatas()
	return
end

function BaseJumpFloorGame:play()
	self._gameState = BaseJumpFloorGame.GameState.Playing

	settimer(0, self._onUpdate, self)
end

function BaseJumpFloorGame:pause()
	self._gameState = BaseJumpFloorGame.GameState.Pause

	removetimer(self._onUpdate, self)
end

function BaseJumpFloorGame:playFromPause()
	self._gameState = BaseJumpFloorGame.GameState.Playing

	settimer(0, self._onUpdate, self)
end

function BaseJumpFloorGame:gameEnd()
	self._gameState = BaseJumpFloorGame.GameState.GameEnd

	removetimer(self._onUpdate, self)
end

function BaseJumpFloorGame:forceEnd()
	self._gameState = BaseJumpFloorGame.GameState.GameEnd

	removetimer(self._onUpdate, self)

	self._isForceExit = true
end

function BaseJumpFloorGame:isForceEnd()
	return self._isForceExit
end

function BaseJumpFloorGame:getGameState()
	return self._gameState
end

function BaseJumpFloorGame:jumpLeft()
	table.clear(self._stepCellDataList)

	local col = self._curCellData:getCol()
	local newCol = col + 1
	local newRow = self._curCellData:getRow()
	local newCellData = self._cellDataDic[newCol][newRow]

	if newCellData then
		self._curCellData = newCellData
		self._curPassFloors = newCol
	else
		self._emptyCellData:setColAndRow(newCol, newRow)

		self._curCellData = self._emptyCellData
	end
end

function BaseJumpFloorGame:jumpRight()
	table.clear(self._stepCellDataList)

	local col = self._curCellData:getCol()
	local row = self._curCellData:getRow()
	local newCol = col + 1
	local newRow = row + 1
	local newCellData = self._cellDataDic[newCol][newRow]

	if newCellData then
		self._curCellData = newCellData
		self._curPassFloors = newCol
	else
		self._emptyCellData:setColAndRow(newCol, newRow)

		self._curCellData = self._emptyCellData
	end
end

function BaseJumpFloorGame:skipCell()
	local moveStep = self._curCellData:getSkipCellStep()

	printInfo("test BaseJumpFloorGame:skipCell", moveStep)

	if moveStep == 0 then
		return
	end

	local col = self._curCellData:getCol()
	local row = self._curCellData:getRow()
	local newCol = col + moveStep
	local tempCellData
	local tempCol = col
	local tempRow = row

	table.clear(self._stepCellDataList)

	if moveStep > 0 then
		for iCol = col + 1, newCol do
			local newCellDatas = self:getCellDatasByCol(iCol)

			if newCellDatas then
				for i, v in ipairs(newCellDatas) do
					if v:getRow() == tempRow then
						tempCol = iCol

						table.insert(self._stepCellDataList, v)

						break
					elseif v:getRow() == tempRow + 1 then
						tempCol = iCol
						tempRow = tempRow + 1

						table.insert(self._stepCellDataList, v)

						break
					end
				end
			end
		end
	else
		for iCol = col - 1, newCol, -1 do
			local newCellDatas = self:getCellDatasByCol(iCol)

			if newCellDatas then
				for i, v in ipairs(newCellDatas) do
					if v:getRow() == tempRow then
						tempCol = iCol

						table.insert(self._stepCellDataList, v)

						break
					elseif v:getRow() == tempRow - 1 then
						tempCol = iCol
						tempRow = tempRow - 1

						table.insert(self._stepCellDataList, v)

						break
					end
				end
			end
		end
	end

	if tempCol == col and tempRow == row then
		return
	end

	local newCellData = self._cellDataDic[tempCol][tempRow]

	if newCellData then
		self._curCellData = newCellData
		self._curPassFloors = tempCol
	else
		self._emptyCellData:setColAndRow(tempCol, tempRow)

		self._curCellData = self._emptyCellData
	end

	self:dispatch(BaseJumpFloorGame.UpdateStageMap)
end

function BaseJumpFloorGame:getStepCellDataList()
	return self._stepCellDataList
end

function BaseJumpFloorGame:getCountdown()
	return (self._curCountdown >= 0 or nil) and (self._curCountdown or 0)
end

function BaseJumpFloorGame:getMaxFloors()
	return self._destinationFloorNum
end

function BaseJumpFloorGame:getCurPassFloors()
	return self._curPassFloors
end

function BaseJumpFloorGame:getLeftFloors()
	return self:getMaxFloors() - self:getCurPassFloors()
end

function BaseJumpFloorGame:getCurCellData()
	return self._curCellData
end

function BaseJumpFloorGame:getCellDatas()
	return self._cellDataList
end

function BaseJumpFloorGame:getDestinationFloorCol()
	return self._destinationFloorNum
end

function BaseJumpFloorGame:getCellDatasByCol(col, isReverse)
	local cells = self._cellDataDic[col]

	if cells then
		local list = {}

		for k, v in pairs(cells) do
			table.insert(list, v)
		end

		if isReverse then
			table.sort(list, function(a, b)
				return a:getRow() > b:getRow()
			end)
		else
			table.sort(list, function(a, b)
				return a:getRow() < b:getRow()
			end)
		end

		return list
	end

	return nil
end

function BaseJumpFloorGame:handleBuff()
	if self:getGameState() ~= BaseJumpFloorGame.GameState.GameEnd then
		local cellData = self._curCellData

		if cellData:isBuffAvailable() then
			local baseBuff = JumpFloorBuffFactory.create(self._curCellData:getCellType(), self)

			baseBuff:excute()
			cellData:setBuffUnAvailable()
		end
	end
end

function BaseJumpFloorGame:addShield()
	self._shieldBuff = 1

	local isShow = true

	self:dispatch(BaseJumpFloorGame.UpdateShield, isShow)
end

function BaseJumpFloorGame:clearShield()
	self._shieldBuff = 0

	local isShow = false

	self:dispatch(BaseJumpFloorGame.UpdateShield, isShow)
end

function BaseJumpFloorGame:isExistShield()
	return self._shieldBuff > 0
end

function BaseJumpFloorGame:triggerTrap()
	if self:isExistShield() then
		self:clearShield()
	else
		self:dispatch(BaseJumpFloorGame.TriggerTrap)
	end
end

function BaseJumpFloorGame:_onUpdate()
	self._curCountdown = self._curCountdown - UnityEngine.Time.deltaTime
end

return BaseJumpFloorGame
