local MainTopPanel = class("MainTopPanel", import("...base.MainBasePanel"))

function MainTopPanel:GetBtns()
	return {
		MainPlayerInfoBtn.New(self._tf, self.event)
	}
end

function MainTopPanel:GetDirection()
	return Vector2(0, 1)
end

return MainTopPanel
