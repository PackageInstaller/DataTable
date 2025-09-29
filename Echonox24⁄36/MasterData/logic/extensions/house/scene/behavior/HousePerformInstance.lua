-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/behavior/HousePerformInstance.lua

module("logic.extensions.house.scene.behavior.HousePerformInstance", package.seeall)

local M = class("HousePerformInstance", AbstractGlobalReusable)
local BubbleType = SceneEnum.BubbleType
local UnitDirection = HouseEnum.UnitDirection
local AnimationState = HouseEnum.AnimationState
local vec3Temp = Vector3.New()

M.LimitPlayerTypes = {
	1,
	2,
	3,
	4
}

function M:ctor()
	self._unit = nil
	self._otherUnit = nil
	self._furniture = nil
	self._hasAddBubbleListener = false

	self:_clearPerformData()
end

function M:getCapacity()
	return 50
end

function M:reuse()
	return
end

function M:reset()
	self:clear()
end

function M:destroy()
	self:reset()
end

function M:clear()
	self:_endFrameTimer()
	self:_removePerformListener()
	self:_clearPerformData()

	self._unit = nil
	self._otherUnit = nil
	self._furniture = nil
end

function M:_clearPerformData()
	self._isRunning = false
	self._performCO = false
	self._paramTalkBubble = false
	self._paramEmojiBubble = false
	self._paramPlayAction = false
	self._paramDirection = false
	self._paramFurnitureAnima = false
	self._paramDelay = false
	self._finishCallback = false
	self._finishTarget = false
	self._isFrameTimerOpen = false
	self._isBreaking = false
	self._performTalkBubbleTime = -1
	self._performEmojiBubbleTime = -1
	self._performPlayActioneTime = -1
	self._performDirectionTime = -1
	self._performFurnitureAnimaTime = -1
	self._performDelayTime = -1
	self._actionEndTime = -1
end

function M:_removePerformListener()
	if self._unit and self._hasAddBubbleListener then
		self._unit:removeInnerEventListener(UnitActionType.FinishBubble, self._onFinishedBubble, self)
	end

	self._hasAddBubbleListener = false
end

function M:setUnit(unit)
	self._unit = unit
end

function M:setOtherPlayer(otherUnit)
	self._otherUnit = otherUnit
end

function M:setFurniture(furniture)
	self._furniture = furniture
end

function M:setPerformCO(performCO)
	self._performCO = performCO
end

function M:setBreaking(isBreaking)
	self._isBreaking = isBreaking
end

function M:luaUpdate(dt)
	if self._isRunning then
		self:_tryTriggerPerform()
		self:_tryFinishPlayAction()
	end
end

function M:interruptPerform()
	if self._isRunning then
		local isInterruptAI = self._performCO and self._performCO:interruptAI()

		self:endPerform()

		if self._unit then
			self._unit.bubble:endBubble()

			if isInterruptAI then
				self._unit.meshModel:play(AnimationState.Idle, true)
			end
		end
	end
end

function M:endPerform()
	if self._isRunning then
		self:_endFrameTimer()
		self:_removePerformListener()
		self:_clearPerformData()
	end
end

function M:perform(type, paramList)
	local initParamFuncMap = {
		self._initParamTalkBubble,
		self._initParamEmojiBubble,
		self._initParamPlayAction,
		self._initParamDirection,
		self._initParamFurnitureAnima,
		self._initParamDelay
	}
	local initParamFunc = initParamFuncMap[type]

	initParamFunc(self, paramList)

	local performFuncMap = {
		self._performTalkBubbleWithTimer,
		self._performEmojiBubbleWithTimer,
		self._performPlayActioneWithTimer,
		self._performDirectionWithTimer,
		self._performFurnitureAnimaWithTimer,
		self._performDelayWithTimer
	}
	local performFunc = performFuncMap[type]

	performFunc(self)

	self._isRunning = true

	self:_startFrameTimer()
end

function M:_startFrameTimer()
	FrameUpdate:addListener(self)
end

function M:_endFrameTimer()
	FrameUpdate:removeListener(self)
end

function M:setFinishCallback(finishCallback, finishTarget)
	self._finishCallback = finishCallback
	self._finishTarget = finishTarget
end

function M:_finishOnePerform()
	if self._finishCallback then
		self._finishCallback(self._finishTarget)
	end
end

function M:_initParamTalkBubble(paramList)
	self._paramTalkBubble = {}

	local waitTime = checknumber(paramList[1])

	self._paramTalkBubble.waitTime = waitTime > 0 and waitTime or 0
	self._paramTalkBubble.txtKey = paramList[3]
end

function M:_initParamEmojiBubble(paramList)
	self._paramEmojiBubble = {}

	local waitTime = checknumber(paramList[1])

	self._paramEmojiBubble.waitTime = waitTime > 0 and waitTime or 0
	self._paramEmojiBubble.content = paramList[3]
end

function M:_initParamPlayAction(paramList)
	self._paramPlayAction = {}

	local waitTime = checknumber(paramList[1])

	self._paramPlayAction.waitTime = waitTime > 0 and waitTime or 0
	self._paramPlayAction.newActionName = paramList[3]

	local playCount = checknumber(paramList[4])

	self._paramPlayAction.playCount = playCount > 1 and playCount or 1
end

function M:_initParamDirection(paramList)
	self._paramDirection = {}

	local waitTime = checknumber(paramList[1])

	self._paramDirection.waitTime = waitTime > 0 and waitTime or 0
	self._paramDirection.faceTarget = checknumber(paramList[4])
	self._paramDirection.faceType = checknumber(paramList[3])
end

function M:_initParamFurnitureAnima(paramList)
	self._paramFurnitureAnima = {}
	self._paramFurnitureAnima.animName = paramList[1]
end

function M:_initParamDelay(paramList)
	self._paramDelay = {}

	local delayTime = checknumber(paramList[1])

	self._paramDelay.delayTime = delayTime > 0 and delayTime or 0
end

function M:_tryTriggerPerform()
	if self._performTalkBubbleTime > 0 and Time.time > self._performTalkBubbleTime then
		self._performTalkBubbleTime = -1

		self:_performTalkBubble()
	end

	if self._performEmojiBubbleTime > 0 and Time.time > self._performEmojiBubbleTime then
		self._performEmojiBubbleTime = -1

		self:_performEmojiBubble()
	end

	if self._performPlayActioneTime > 0 and Time.time > self._performPlayActioneTime then
		self._performPlayActioneTime = -1

		self:_performPlayAction()
	end

	if self._performDirectionTime > 0 and Time.time > self._performDirectionTime then
		self._performDirectionTime = -1

		self:_performDirection()
	end

	if self._performFurnitureAnimaTime > 0 and Time.time > self._performFurnitureAnimaTime then
		self._performFurnitureAnimaTime = -1

		self:_performFurnitureAnima()
	end

	if self._performDelayTime > 0 and Time.time > self._performDelayTime then
		self._performDelayTime = -1

		self:_performDelay()
	end
end

function M:_performTalkBubbleWithTimer()
	self._performTalkBubbleTime = Time.time + self._paramTalkBubble.waitTime
end

function M:_performTalkBubble()
	self._unit:addInnerEventListener(UnitActionType.FinishBubble, self._onFinishedBubble, self)

	self._hasAddBubbleListener = true

	local textStr = ""

	if self._isBreaking then
		textStr = self._performCO:getBreakText(self._paramTalkBubble.txtKey)
	else
		textStr = self._performCO:getText(self._paramTalkBubble.txtKey)
	end

	local bubbleData = {}

	bubbleData.type = BubbleType.Talk
	bubbleData.content = textStr

	self._unit.bubble:show(bubbleData)
end

function M:_onFinishedBubble(eventId, actionType, bubbleType)
	self._unit:removeInnerEventListener(UnitActionType.FinishBubble, self._onFinishedBubble, self)

	self._hasAddBubbleListener = false

	self:_finishOnePerform()
end

function M:_performEmojiBubbleWithTimer()
	self._performEmojiBubbleTime = Time.time + self._paramEmojiBubble.waitTime
end

function M:_performEmojiBubble()
	self._unit:addInnerEventListener(UnitActionType.FinishBubble, self._onFinishedBubble, self)

	self._hasAddBubbleListener = true

	local bubbleData = {}

	bubbleData.type = BubbleType.Emoji
	bubbleData.content = self._paramEmojiBubble.content

	self._unit.bubble:show(bubbleData)
end

function M:_performPlayActioneWithTimer()
	self._performPlayActioneTime = Time.time + self._paramPlayAction.waitTime
end

function M:_performPlayAction()
	local actionName = self._paramPlayAction.newActionName
	local duration = self._unit.meshModel:getAnimationDuration(actionName)
	local len = self._unit.meshModel:getAnimationLength(actionName)

	self._actionEndTime = Time.time + duration + (self._paramPlayAction.playCount - 1) * len

	self._unit.meshModel:play(actionName, self._paramPlayAction.playCount > 1)
end

function M:_tryFinishPlayAction()
	if self._actionEndTime > 0 and Time.time > self._actionEndTime then
		self._actionEndTime = -1

		self:_finishPlayAction()
	end
end

function M:_finishPlayAction()
	self._unit.meshModel:play(AnimationState.Idle, true)

	self._paramPlayAction.newActionName = nil

	self:_finishOnePerform()
end

function M:_performDirectionWithTimer()
	self._performDirectionTime = Time.time + self._paramDirection.waitTime
end

function M:_performDirection()
	self:_faceToTarget()
	self:_finishOnePerform()
end

function M:_updateFaceToTarget()
	if self._paramDirection then
		-- block empty
	end
end

function M:_faceToTarget()
	local mainPlayer
	local curScene = SceneMgr.instance:getCurScene()

	if curScene and curScene.getMainPlayer then
		mainPlayer = curScene:getMainPlayer()
	end

	local targetUnit = self._paramDirection.faceTarget == 1 and mainPlayer or self._otherUnit

	if targetUnit then
		local facePosX, facePosY, facePosZ = Astral.TransformUtil.GetPos(targetUnit.go.transform, 0, 0, 0)

		if self._paramDirection.faceType == 1 then
			vec3Temp:Set(facePosX, facePosY, facePosZ)
		else
			local posX, posY, posZ = self._unit.mountRoot:getRelativeLocalPosByWorldPos(facePosX, facePosY, facePosZ)

			posX, posY, posZ = self._unit.mountRoot:getRelativeWorldPosByLocalPos(-posX, -posY, -posZ)

			vec3Temp:Set(posX, posY, posZ)
		end

		self._unit.navMeshMover:lookAtPos(vec3Temp)
	end
end

function M:_performFurnitureAnimaWithTimer()
	self._performFurnitureAnimaTime = Time.time + 0
end

function M:_performFurnitureAnima()
	self:_finishOnePerform()
end

function M:_performDelayWithTimer()
	self._performDelayTime = Time.time + self._paramDelay.delayTime
end

function M:_performDelay()
	self:_finishOnePerform()
end

function M:initWords(limitCount)
	if self._unit then
		self._unit.bubble:setWordLimitCount(limitCount)

		self._scheduleWordList = HouseConfig.instance:getWordCfgsByStatus(self._unit.scheduleModel:getCurWorkStatus())
		self._normalWordList = HouseConfig.instance:getWordCfgsByStatus(0)
	end
end

function M:_getOneWord()
	local weights = HouseConfig.instance:getWordWeights()
	local idx = HouseSceneUtil.getIdxByWeights(weights)
	local wordList = self._normalWordList

	if idx == 1 and #self._scheduleWordList > 0 then
		wordList = self._scheduleWordList
	end

	local wordStr = ". . ."

	if #wordList > 0 then
		local i = math.random(1, #wordList)

		wordStr = wordList[i].word

		table.remove(wordList, i)
	end

	return wordStr
end

function M:showWordBubble()
	if self._unit.bubble:hasUsefulWord() then
		local bubbleData = {}

		bubbleData.type = BubbleType.Word
		bubbleData.content = self:_getOneWord()

		self._unit.bubble:show(bubbleData)

		return true
	end

	return false
end

return M
