local MainActNewServerBtnMellowAdapt = class("MainActNewServerBtnMellowAdapt", import(".MainDifferentStyleSpActBtnAdapt"))

function MainActNewServerBtnMellowAdapt:GetContainer()
	return self.root:Find("left/list")
end

function MainActNewServerBtnMellowAdapt:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"NEW_SERVER"
	}, function(arg_3_0)
		setActive(arg_3_0, NewServerCarnivalScene.isTip())

		return
	end)

	return
end

function MainActNewServerBtnMellowAdapt:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainActNewServerBtnMellowAdapt
