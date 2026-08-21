-- chunkname: @IQIGame\\Module\\SceneTransfer\\MazeSceneToBattleTransfer.lua

local SceneTransferController = require("IQIGame/Module/SceneTransfer/SceneTransferController")
local Transfer = Clone(SceneTransferController)

function Transfer:__OnPrepare()
	BattleModule.SetBattleSceneIsReady(false)
	self:__CommonPrepare()
end

function Transfer:__UnloadScene()
	MazeModule.ExitMazeSceneToBattle()
	self:__CommonUnloadScene()
end

function Transfer:__LoadScene()
	BattleModule.SetBattleSceneIsReady(true)
	BattleModule.RequestStartBattle(self.Args.IsLocalFight, self.Args.FightPOD, self.Args.UserData)
	self:__AddConditionCall(function(_args)
		return BattleModule.isInitBattleComplete
	end, nil, function(_args)
		self:__ChangeState(self.State.Exit)
	end, nil)
end

return Transfer
