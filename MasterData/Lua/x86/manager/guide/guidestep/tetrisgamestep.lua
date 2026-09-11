local TetrisGameStep = class("TetrisGameStep", DragStep)

function TetrisGameStep:Init()
	TetrisGameStep.super.Init(self)
end

function TetrisGameStep:Play()
	TetrisGameStep.super.Play(self)
	TetrisGameRunTimeManager:SetTetrisPos(self._params[1], self._params[2])
end

function TetrisGameStep:CheckDragSuccess()
	return TetrisGameRunTimeManager:GetIsEndNowRound()
end

return TetrisGameStep
