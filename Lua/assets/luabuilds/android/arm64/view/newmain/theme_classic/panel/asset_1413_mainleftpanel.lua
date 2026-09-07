local MainLeftPanel = class("MainLeftPanel", import("...base.MainConcealablePanel"))

function MainLeftPanel:GetBtns()
	return {
		MainCommissionBtn.New(findTF(self._tf, "commissionButton"), self.event),
		MainHideBtn.New(findTF(self._tf, "hideButton"), self.event),
		MainCameraBtn.New(findTF(self._tf, "cameraButton"), self.event),
		MainWordBtn.New(findTF(self._tf, "wordBtn"), self.event),
		MainChangeSkinBtn.New(findTF(self._tf, "changeBtn"), self.event),
		MainL2dBoundBtn.New(findTF(self._tf, "l2d_bound"), self.event)
	}
end

function MainLeftPanel:GetDirection()
	return Vector2(-1, 0)
end

return MainLeftPanel
