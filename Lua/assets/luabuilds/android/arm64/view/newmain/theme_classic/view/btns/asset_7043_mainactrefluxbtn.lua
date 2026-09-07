local MainActRefluxBtn = class("MainActRefluxBtn", import(".MainBaseSpcailActBtn"))

function MainActRefluxBtn:GetContainer()
	return self.root.parent:Find("link_top/layout")
end

function MainActRefluxBtn:InShowTime()
	return getProxy(RefluxProxy):isActive()
end

function MainActRefluxBtn:GetUIName()
	return "MainUIReturnBtn"
end

function MainActRefluxBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.REFLUX)

	return
end

function MainActRefluxBtn:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"ACT_RETURN"
	}, function(arg_6_0)
		setActive(arg_6_0, RefluxTaskView.isAnyTaskCanGetAward() or RefluxPTView.isAnyPTCanGetAward() or RefluxShopView.isShowRedPot())

		return
	end)

	return
end

function MainActRefluxBtn:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainActRefluxBtn
