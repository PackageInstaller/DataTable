local MainBottomPanel = class("MainBottomPanel", import("...base.MainBasePanel"))

function MainBottomPanel:GetBtns()
	return {
		MainMallBtn.New(findTF(self._tf, "mallBtn"), findTF(self._tf, "tags"), self.event),
		MainDockBtn.New(findTF(self._tf, "dockBtn"), self.event),
		MainEquipBtn.New(findTF(self._tf, "equipButton"), self.event),
		MainLiveBtn.New(findTF(self._tf, "liveButton"), self.event),
		MainTechBtn.New(findTF(self._tf, "technologyButton"), self.event),
		MainTaskBtn.New(findTF(self._tf, "taskButton"), self.event),
		MainBuildBtn.New(findTF(self._tf, "buildButton"), self.event),
		MainGuildBtn.New(findTF(self._tf, "guildButton"), self.event)
	}
end

function MainBottomPanel:GetDirection()
	return Vector2(0, -1)
end

return MainBottomPanel
