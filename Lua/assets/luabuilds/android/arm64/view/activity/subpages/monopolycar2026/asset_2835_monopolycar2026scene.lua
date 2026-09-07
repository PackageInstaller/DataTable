local MonopolyCar2026Scene = class("MonopolyCar2026Scene", import("..MonopolyCar2024.MonopolyCar2024Scene"))

function MonopolyCar2026Scene:getUIName()
	return "MonopolyCar2026UI"
end

function MonopolyCar2026Scene:NewGame()
	return MonopolyCar2026Game.New(self.activity, self._tf:Find("adapt"), self.event)
end

return MonopolyCar2026Scene
