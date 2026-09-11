local T0GameManagerBase = import("..T0GameManagerBase")
local GuelGameAcion = class("GuelGameAcion", T0GameManagerBase)
local Include = import(".States.Include")

function GuelGameAcion:Init()
	self.gameData = {}
	self.exit = false

	manager.windowBar:HideBar()
	self:GoToState(Include.EnterState)
end

function GuelGameAcion:Reset()
	self.gameData = nil

	self:RemoveAllStateEvents()
end

function GuelGameAcion.StartGame()
	T0GameManagerBase.StartGameImpl(GuelGameAcion)
end

local var_0_3 = {
	[GuelGameManager.GameResult.Win] = "game_tv_lose",
	[GuelGameManager.GameResult.Lose] = "game_tv_win"
}

function GuelGameAcion:ExitGame()
	if manager.posterGirl.actor then
		local var_4_0 = manager.posterGirl.actor:GetCurrentState()

		if var_4_0.gameInst and not var_4_0.gameInst.exit then
			var_4_0.gameInst:GoToState(Include.ExitState, var_0_3[self])
		end
	end
end

return GuelGameAcion
