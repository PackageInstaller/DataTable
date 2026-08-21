-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GameFsm\\GameFsm.lua

local EventConst = require("EventConst")
local NetService = require("Network/NetService")
local SDKAppUtils = require("SDK/SDKAppUtils")
local RetryHelper = require("Helper/RetryHelper")
local GameFsm = {}
local self = GameFsm

function GameFsm.ctor()
	local LoginState = require("GameFsm/GameStateLogin")
	local MainState = require("GameFsm/GameStateMain")
	local BattleState = require("GameFsm/GameStateBattle")
	local ReplayState = require("GameFsm/GameStateReplay")
	local Fsm = require("GameFsm/Fsm")

	self._fsm = Fsm()

	self._fsm:addState(LoginState(Const.STATE_LOGIN, Const.NO_STATE_SCENE))
	self._fsm:addState(MainState(Const.STATE_MAIN))
	self._fsm:addState(BattleState(Const.STATE_BATTLE))
	self._fsm:addState(ReplayState(Const.STATE_BATTLE_REPLAY))

	self._waitEnterChildState = nil

	EventCenter.addEventListener(EventConst.GAME_STATE_LOADED, self.onGameStateLoaded)
	NetService.setReconnectNoticeCallback(self.netDisconnectCB, self.reconnectSuccessCB, self.reconnectFaliedCB)
end

function GameFsm.translateState(tgtStateName, enterArgs)
	if tgtStateName == Const.STATE_LOGIN then
		self.getState(Const.STATE_LOGIN):resetState()
	end

	self._waitEnterChildState = nil

	local curState = self.getState()

	if self._fsm.mStates[tgtStateName] then
		if curState and curState.fsm then
			curState.fsm:translateState(nil)
		end

		self._fsm:translateState(tgtStateName, enterArgs)
		collectgarbage("collect")
	else
		for stateName, state in pairs(self._fsm.mStates) do
			if state.fsm then
				for childStateName, childState in pairs(state.fsm.mStates) do
					if childStateName == tgtStateName then
						if stateName == self._fsm.mCurStateName then
							state.fsm:translateState(tgtStateName, enterArgs)
						else
							self._waitEnterChildState = {
								main = stateName,
								child = tgtStateName,
								enterArgs = enterArgs
							}

							self._fsm:translateState(stateName)
							collectgarbage("collect")
						end

						return
					end
				end
			end
		end
	end
end

function GameFsm.getState(tgtStateName)
	local state = self._fsm:getState(tgtStateName)

	if state then
		return state
	else
		return self.getSubState(tgtStateName)
	end
end

function GameFsm.getSubState(tgtStateName)
	for stateName, state in pairs(self._fsm.mStates) do
		if state.fsm then
			for childStateName, childState in pairs(state.fsm.mStates) do
				if childStateName == tgtStateName then
					return childState
				end
			end
		end
	end
end

function GameFsm.isInState(tgtStateName)
	if self._fsm.mStates[tgtStateName] then
		return self._fsm.mCurStateName == tgtStateName
	else
		local curState = self.getState()

		if curState and curState.fsm then
			return curState.fsm.mCurStateName == tgtStateName
		else
			return false
		end
	end
end

function GameFsm.getCurState()
	return self.getState()
end

function GameFsm.onGameStateLoaded(stateName)
	if self._fsm.mStates[stateName] == nil then
		return
	end

	local state = self.getState(stateName)

	if state == nil then
		return
	end

	if self._waitEnterChildState and self._waitEnterChildState.main == stateName then
		if state.fsm then
			state.fsm:translateState(self._waitEnterChildState.child, self._waitEnterChildState.enterArgs)
		end

		self._waitEnterChildState = nil
	elseif state.fsm and state.defChildState then
		state:enterDefaultSubState(stateName)
	end
end

function GameFsm.onLoginToGameState(reconnect, enter_game)
	self.argLoginRespReconnect = reconnect

	if not GameFsm.isInState(Const.STATE_LOGIN) then
		if GameFsm.isInState(Const.STATE_BATTLE) then
			if GameFsm.getState(Const.STATE_BATTLE):onReconnect(enter_game) then
				CurAvatar:setToReconnect()
			else
				GameFsm.translateState(Const.STATE_MAIN)
			end
		elseif GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
			if GameFsm.getState(Const.STATE_BATTLE_REPLAY):onReconnect(enter_game) then
				CurAvatar:setToReconnect()
			else
				GameFsm.translateState(Const.STATE_MAIN)
			end
		elseif GameFsm.isInState(Const.STATE_MAIN) then
			CurAvatar:setToReconnect()
		end
	else
		GameFsm.translateState(Const.STATE_MAIN)
	end
end

function GameFsm.reset()
	UIManager.tryHideUI("relinkDlg")
	NetService.stopReconnect()

	if self._fsm.mCurStateName == Const.STATE_LOGIN then
		NetService.disconnect()
	else
		RPC.roleLogout()
		NetService.disconnect()
		self.translateState(Const.STATE_LOGIN)
	end
end

GameFsm.suppressDisconnectTip = false

function GameFsm.netDisconnectCB()
	if not self.isInState(Const.STATE_LOGIN) then
		local state = self.getCurState()

		state:onDisconnect()
		UIManager.getUI("relinkDlg", true)
		NetService.reconnectNextTime()
	elseif not GameFsm.suppressDisconnectTip then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(1792), NetService.connectFailedMsg or Lang.get(29943))
	end

	GameFsm.suppressDisconnectTip = false
end

function GameFsm.reconnectSuccessCB()
	return
end

function GameFsm.reconnectFaliedCB()
	local relinkDlg = UIManager.getUI("relinkDlg")

	if relinkDlg then
		relinkDlg:setVisible(false)
	end

	NetService.disconnect()
	self.translateState(Const.STATE_LOGIN)
end

function GameFsm.isInBattleState()
	return self.isBattleState(self._fsm and self._fsm.mCurStateName)
end

function GameFsm.isBattleState(state)
	return state == Const.STATE_BATTLE or state == Const.STATE_BATTLE_REPLAY or state == Const.STATE_DEMO or state == Const.STATE_DEMO_BATTLE_TEST or state == Const.STATE_DEMO_BATTLE_TEST_AI
end

return GameFsm
