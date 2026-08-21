-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\Demo\\DemoStateBattleTestAI.lua

local GameState = require("GameFsm/GameState")
local FrameMgr = require("Debug/Modules/Demo/DemoFrameMgr")
local TheMatrixClass = require("Common/FrameBattle/TheMatrix")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleActorMgr = require("Logic/Battle/BattleActorMgr")
local MatrixOp = require("Common/FrameBattle/Lib/MatrixOp")
local BattleReplayHelper = require("Debug/BattleReplayHelper")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResDemoConfig = require("ClientData/ResDemoConfig")
local ResBattleToolAI = require("ResBattleToolAI")
local ResMonster = require("ClientData/ResMonster")
local ResScene = require("ClientData/ResScene")
local ResBattleMonsterWaves = require("ClientData/ResBattleMonsterWaves")
local ResWorldBoss = require("ClientData/ResWorldBoss")
local DynamicSceneUtil = DynamicScene.DynamicSceneUtil
local GameObject = UnityEngine.GameObject
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "DemoStateBattleTestAI"
local DemoStateBattleTestAI = Class(strClassName, GameState)
local StateBattleMixin = require("Logic/battle/StateBattleMixin")

if StateBattleMixin then
	MixinClass(DemoStateBattleTestAI, StateBattleMixin)
end

local listenerFuncConfig = {
	onMatrixOver = BattleConst.MATRIX_EVENT_BATTLE_OVER
}

function DemoStateBattleTestAI:ctor(name)
	self:_initData()
end

function DemoStateBattleTestAI:_initData()
	self.mEntityDict = {}
	self.onlineMode = true
	self.mainDlgName = "battleMainDlg"
	self.monsterAtkEnhance = nil
	self.monsterMhpEnhance = nil
	self.formation = nil
end

function DemoStateBattleTestAI:onEnter(preStateName)
	DemoStateBattleTestAI.super.onEnter(self, preStateName)
	EventCenter.addEventListenerGroup(self, listenerFuncConfig)
end

function DemoStateBattleTestAI:onExit(nextState)
	DemoStateBattleTestAI.super.onExit(self, nextState)
	EventCenter.removeEventListenerGroup(self, listenerFuncConfig)
	self:clear()

	UnityEngine.Time.timeScale = 1
end

function DemoStateBattleTestAI:split(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)

	if delimiter == "" then
		return false
	end

	local pos, arr = 0, {}

	for st, sp in function()
		return string.find(input, delimiter, pos, true)
	end do
		table.insert(arr, string.sub(input, pos, st - 1))

		pos = sp + 1
	end

	table.insert(arr, string.sub(input, pos))

	return arr
end

function DemoStateBattleTestAI:initBattle(sceneNo, battleNo, demoNo, isRobot, randomSeed, monsterAtkEnhance, monsterMhpEnhance, formation)
	if ResBattleConfig[battleNo] and ResBattleConfig[battleNo].sceneId then
		sceneNo = ResBattleConfig[battleNo].sceneId
	end

	if ResScene[sceneNo] then
		self.sceneNo = sceneNo
	else
		self.sceneNo = 1
	end

	if randomSeed then
		self.randomSeed = randomSeed
	else
		self.randomSeed = math.random(1000000)
	end

	self.monsterAtkEnhance = monsterAtkEnhance or 1
	self.monsterMhpEnhance = monsterMhpEnhance or 1
	self.formation = formation
	self.isRobot = isRobot
	self.sceneInfo = ResScene[self.sceneNo]
	self.gridAngle = self.sceneInfo.dir or 0
	self.gridDirection = math.rad(self.gridAngle)
	self.leftDir = Vector3(-math.cos(self.gridDirection), 0, -math.sin(self.gridDirection))
	self.upDir = Vector3(-self.leftDir.z, 0, self.leftDir.x)

	local centerPoint = self.sceneInfo.origin_point

	self.centerPoint = Vector3(centerPoint[1], centerPoint[2], centerPoint[3])
	self.battleNo = battleNo
	self.demoNo = demoNo
end

function DemoStateBattleTestAI:onLoadEnded()
	DemoStateBattleTestAI.super.onLoadEnded(self)

	if self.sceneInfo.dynamic_path then
		local nowPath = "Scenes/world/Chunk/" .. self.sceneInfo.dynamic_path

		if self.preDynamicPath and self.preDynamicPath ~= nowPath then
			DynamicSceneUtil.UnloadScene(self.preDynamicPath)
		end

		if self.preDynamicPath ~= nowPath then
			self.preDynamicPath = nowPath

			DynamicSceneUtil.LoadScene(self.preDynamicPath)
		end
	end

	self.centerPointGo = GameObject("CenterPoint")
	self.cameraCenterPointGo = GameObject("CameraCenterPoint")

	if ResBattleMonsterWaves[self.battleNo] then
		CameraModeManager.setToBattle(self, true, 0, 31, 0.16)
	else
		CameraModeManager.setToBattle(self, true)
	end

	self:initConfig()
end

function DemoStateBattleTestAI:initConfig()
	self:clear()

	local randomSeed = math.random(1000000)

	self:initObjInfo()

	if self:isZombieBattle() then
		self.mainDlgName = "battleZombieMainDlg"
	else
		self.mainDlgName = "battleMainDlg"
	end

	local input = self:getMatrixInput()

	input.monsterAtkEnhance = self.monsterAtkEnhance
	input.monsterMhpEnhance = self.monsterMhpEnhance
	self.mMatrixInstance = TheMatrixClass(input, false)
	self.mActorMgr = BattleActorMgr(self, self.mMatrixInstance, self.mEntityDict)
	self.frameMgr = FrameMgr(self.mMatrixInstance)
	self.startTimer = Timer.New(Slot(self.startGame, self), 2)

	self.startTimer:Start()
end

function DemoStateBattleTestAI:_initSpeData(mainData, camp)
	local buffData = utils.getDemoBuffData(mainData)

	if next(buffData) then
		if not self.speData.campBuffData then
			self.speData.campBuffData = {}
		end

		self.speData.campBuffData[camp] = buffData
	end
end

function DemoStateBattleTestAI:initObjInfo(battleNo, demoNo)
	self.speData = {}

	local battleNo = self.battleNo
	local demoNo = self.demoNo

	self.mEntityDict = {}

	local battleData = ResBattleConfig[battleNo] or {}
	local monsters = self:getBattleMonsters()
	local objId = 1
	local demoBattleData

	if self.isRobot then
		local mainData = ResBattleToolAI[demoNo]
		local formation = self.formation or mainData.formation or {}

		demoBattleData = mainData

		self:_initSpeData(mainData, BattleConst.CAMP_PLAYER)

		for pos, heroIdx in ipairs(formation) do
			local playerinfo = utils.getRobotPlayerInfoAI(mainData.heros[heroIdx])

			if playerinfo then
				playerinfo.pos = pos
				playerinfo.entityID = objId
				playerinfo.camp = BattleConst.CAMP_PLAYER
				self.mEntityDict[objId] = playerinfo
				objId = objId + 1
			end
		end

		if battleNo == nil then
			self:_initSpeData(mainData, BattleConst.CAMP_MONSTER)

			monsters = {}

			for pos, heroIdx in ipairs(mainData.enemy_formation or {}) do
				local playerinfo = utils.getRobotPlayerInfoAI(mainData.enemy_heros[heroIdx])

				if playerinfo then
					playerinfo.pos = pos
					playerinfo.entityID = objId
					playerinfo.camp = BattleConst.CAMP_MONSTER
					self.mEntityDict[objId] = playerinfo
					objId = objId + 1
				end
			end
		end
	else
		local demoData = ResDemoConfig[demoNo] or {}

		demoBattleData = demoData

		local players = demoData.players or {}

		for pos, monsterID in ipairs(players) do
			if ResMonster[monsterID] then
				local player = {}

				player.entityID = objId
				player.pos = pos
				player.monsterID = monsterID
				player.camp = BattleConst.CAMP_PLAYER
				self.mEntityDict[objId] = player
				objId = objId + 1
			end
		end
	end

	local friends = battleData.friends or {}

	for pos, monsterID in ipairs(friends) do
		if ResMonster[monsterID] then
			self.mEntityDict[objId] = utils.getBattleMonsterInfo(monsterID, pos, BattleConst.CAMP_PLAYER, objId)
			objId = objId + 1
		end
	end

	local monsterHps = {}

	if self.speData and self.speData.monsterHps then
		monsterHps = self.speData.monsterHps
	end

	for pos, monsterID in ipairs(monsters) do
		if ResMonster[monsterID] and (not monsterHps[pos] or not (monsterHps[pos] <= 0)) then
			self.mEntityDict[objId] = utils.getBattleMonsterInfo(monsterID, pos, BattleConst.CAMP_MONSTER, objId)
			self.mEntityDict[objId].monsterAtkEnhance = self.monsterAtkEnhance
			self.mEntityDict[objId].monsterMhpEnhance = self.monsterMhpEnhance
			objId = objId + 1
		end
	end

	if demoBattleData.battle_type then
		self.battleType = demoBattleData.battle_type

		if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
			local worldBossData = {}
			local bossDataType = 1
			local bossDataLevel = 1

			worldBossData.init_score = ResWorldBoss[bossDataType][bossDataLevel].init_score
			worldBossData.score_k = ResWorldBoss[bossDataType][bossDataLevel].score_k
			worldBossData.type = bossDataType
			self.speData.worldBossData = worldBossData
		end
	else
		self.battleType = nil
	end
end

function DemoStateBattleTestAI:onMatrixOver(loseCamp, speResultType)
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function DemoStateBattleTestAI:startGame()
	self:battleHideGameObject()
	self.frameMgr:start()

	if self.mActorMgr then
		self.mActorMgr:actBeforeStart()
	end
end

function DemoStateBattleTestAI:clear()
	if self.mMatrixInstance then
		self.mMatrixInstance:destroy()

		self.mMatrixInstance = nil
	end

	if self.frameMgr then
		self.frameMgr:destroy()

		self.frameMgr = nil
	end

	if self.mActorMgr then
		self.mActorMgr:destroy()

		self.mActorMgr = nil
	end

	if self.preHideSceneObjects then
		for _, node in ipairs(self.preHideSceneObjects) do
			if node and not tolua.isnull(node) then
				node:SetActive(true)
			end
		end

		self.preHideSceneObjects = nil
	end
end

function DemoStateBattleTestAI:onActorsReady()
	self.actorsReady = true
end

function DemoStateBattleTestAI:onRaiseMatrixInput(matrixOpType, ...)
	local inputData = MatrixOp.packMatrixOp(matrixOpType, ...)

	if inputData and self.frameMgr then
		self.frameMgr:onReceiveMsg(matrixOpType, inputData)
	end
end

function DemoStateBattleTestAI:getPlayers()
	if not self.mMatrixInstance then
		return {}
	end

	local out = {}

	for _, obj in pairs(self.mMatrixInstance.bObjMgr.objects) do
		if obj.camp == BattleConst.CAMP_PLAYER then
			out[obj.pos] = obj
		end
	end

	return out
end

function DemoStateBattleTestAI:refreshInfoLevel(infoLevel, refreshAll)
	if infoLevel == nil then
		infoLevel = UserData.loadCommonData(BattleConst.INFO_LEVEL_KEY) or BattleConst.INFO_LEVEL_DEFAULT
	end

	if self.mActorMgr and refreshAll then
		for _, obj in pairs(self.mActorMgr.actors) do
			if obj.logo then
				obj.logo:refreshInfoLevel(infoLevel)
			end
		end
	end
end

function DemoStateBattleTestAI:onPause()
	if self.frameMgr then
		self.frameMgr:pause()
		self.mActorMgr:onPause()
	end
end

function DemoStateBattleTestAI:onResume()
	if self.frameMgr then
		self.frameMgr:resume()
		self.mActorMgr:onResume()
	end
end

function DemoStateBattleTestAI:getCenterPointPos()
	if self.centerPointGo then
		return self.centerPointGo.transform.position
	else
		return self.centerPoint
	end
end

function DemoStateBattleTestAI:getReplayData()
	local data = {}

	data.frameData = {}

	if self.frameMgr then
		data.frameData = self.frameMgr.frameQueue
		data.maxFrame = self.frameMgr.curFrame
	end

	return data
end

function DemoStateBattleTestAI:recordBattle(sender, menu, value)
	local replayRecorder = BattleReplayHelper.initRecorder(self.mainDlgName .. "_" .. self.randomSeed)

	replayRecorder:Record(self:getReplayData())
	replayRecorder:Close()
end

return DemoStateBattleTestAI
