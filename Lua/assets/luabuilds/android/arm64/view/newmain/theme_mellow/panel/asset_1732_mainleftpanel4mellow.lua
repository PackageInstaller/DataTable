local MainLeftPanel4Mellow = class("MainLeftPanel4Mellow", import("...base.MainFdConcealablePanel"))

function MainLeftPanel4Mellow:GetBtns()
	return {
		MainCommissionBtn4Mellow.New(findTF(self._tf, "extend"), self.event, 0.5),
		MainHideBtn.New(findTF(self._tf, "btns/eye"), self.event),
		MainCameraBtn.New(findTF(self._tf, "btns/cam"), self.event),
		MainWordBtn.New(findTF(self._tf, "btns/word"), self.event),
		MainChangeSkinBtn.New(findTF(self._tf, "btns/change"), self.event),
		MainResetL2dBtn.New(findTF(self._tf, "btns/l2d"), self.event),
		MainL2dBoundBtn.New(findTF(self._tf, "btns/l2d_bound"), self.event)
	}
end

function MainLeftPanel4Mellow:GetDirection()
	return Vector2(-1, 0)
end

function MainLeftPanel4Mellow:CalcLayout()
	return
end

return MainLeftPanel4Mellow
