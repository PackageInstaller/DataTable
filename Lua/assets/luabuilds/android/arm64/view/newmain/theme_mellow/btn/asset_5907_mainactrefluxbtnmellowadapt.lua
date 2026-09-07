local MainActRefluxBtnMellowAdapt = class("MainActRefluxBtnMellowAdapt", import(".MainDifferentStyleSpActBtnAdapt"))

function MainActRefluxBtnMellowAdapt:GetContainer()
	return self.root:Find("left/list")
end

function MainActRefluxBtnMellowAdapt:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"ACT_RETURN"
	}, function(arg_3_0)
		setActive(arg_3_0, RefluxTaskView.isAnyTaskCanGetAward() or RefluxPTView.isAnyPTCanGetAward() or RefluxShopView.isShowRedPot())

		return
	end)

	return
end

function MainActRefluxBtnMellowAdapt:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainActRefluxBtnMellowAdapt
