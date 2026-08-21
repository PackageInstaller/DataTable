-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameState.lua

local EventConst = require("EventConst")
local UIManager = require("UI/UIManager")
local Fsm = require("GameFsm/Fsm")
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "GameState"
local GameState = Class(strClassName)

function GameState:ctor(name, sceneNo)
	self.stateName = name
	self.sceneNo = sceneNo
	self.flagSceneLoaded = false
	self.flagLoaded = false
	self._slotLoadEnded = Slot(self.onLoadEnded, self)
	self._slotSceneLoaded = Slot(self.onSceneLoaded, self)
end

function GameState:destroy()
	self.stateName = nil
end

function GameState:addChildState(childState, isDefState)
	isDefState = isDefState or false

	if self.fsm == nil then
		self.fsm = Fsm()
		self.fsm.mEventTranslate = Slot(self.onChildStateTranslate)
	end

	childState.parent = self

	self.fsm:addState(childState)

	if isDefState then
		self.defChildState = childState.stateName
	end
end

function GameState:enter(preStateName, enterArgs)
	self.flagSceneLoaded = false
	self.flagLoaded = false
	self.preStateName = preStateName
	self.enterArgs = enterArgs

	LoadManager.clear()
	self:onEnter(preStateName)
	LoadManager.start(self._slotLoadEnded)
end

function GameState:exit(tgtStateName)
	UIManager.stateExit(self.stateName, tgtStateName)
	self:onExit(tgtStateName)
end

function GameState:onEnter(preStateName)
	if self.sceneNo then
		SceneManager.addLoadScene(self.sceneNo, self._slotSceneLoaded)
	end

	CueManager.clearAllCue()
end

function GameState:onSceneLoaded()
	self.flagSceneLoaded = true

	EventCenter.sendEvent(EventConst.GAME_STATE_SCENE_LOADED, self.stateName, self.sceneNo)
end

function GameState:onLoadEnded()
	self.flagLoaded = true

	UIManager.stateEnter(nil, self.stateName)
	EventCenter.sendEvent(EventConst.GAME_STATE_LOADED, self.stateName)
	self:playStateBGM()
end

function GameState:onExit(tgtStateName)
	return
end

function GameState:onDisconnect()
	return
end

function GameState:onReconnect(newInfo)
	return
end

function GameState:onChildStateTranslate(preStateName, tgtStateName)
	return
end

function GameState:enterDefaultSubState(preStateName)
	self.fsm:translateState(self.defChildState)
end

function GameState:playStateBGM(...)
	if self.stateName ~= Const.STATE_MAIN then
		CueManager.setBaseBGMByState(self.stateName)
		CueManager.playBaseBGM()
	end
end

function GameState:checkEnterReason()
	if self.enterArgs and self.enterArgs[1] == Const.STATE_ENTER_REASON_JUMP then
		JumpGuideManager.jump(unpack(self.enterArgs[2]))

		return true
	end
end

function GameState:onBgVisible(isVisible)
	CameraManager.SetMainCameraEnable(isVisible)
end

return GameState
