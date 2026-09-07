local TargetEffect = class("TargetEffect", import("view.miniGame.gameView.RyzaMiniGame.Reactor"))

function TargetEffect:GetCollideRange()
	return {
		{
			{
				-0.5,
				0.5
			},
			{
				-0.5,
				0.5
			}
		}
	}
end

return TargetEffect
