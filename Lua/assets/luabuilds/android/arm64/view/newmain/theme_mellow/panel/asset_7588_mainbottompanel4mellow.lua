local MainBottomPanel4Mellow = class("MainBottomPanel4Mellow", import("...base.MainBasePanel"))

function MainBottomPanel4Mellow:GetBtns()
	return {
		MainMallBtn.New(findTF(self._tf, "frame/shop"), findTF(self._tf, "tags"), self.event),
		MainDockBtn.New(findTF(self._tf, "frame/dock"), self.event),
		MainEquipBtn.New(findTF(self._tf, "frame/storage"), self.event),
		MainLiveBtn.New(findTF(self._tf, "frame/live"), self.event),
		MainTechBtn.New(findTF(self._tf, "frame/tech"), self.event),
		MainTaskBtn.New(findTF(self._tf, "frame/task"), self.event),
		MainBuildBtn.New(findTF(self._tf, "frame/build"), self.event),
		MainGuildBtn.New(findTF(self._tf, "frame/guild"), self.event)
	}
end

function MainBottomPanel4Mellow:GetDirection()
	return Vector2(0, -1)
end

return MainBottomPanel4Mellow
