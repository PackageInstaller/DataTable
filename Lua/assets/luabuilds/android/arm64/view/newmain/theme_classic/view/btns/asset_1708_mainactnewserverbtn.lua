local MainActNewServerBtn = class("MainActNewServerBtn", import(".MainBaseSpcailActBtn"))

function MainActNewServerBtn:GetContainer()
	return self.root.parent:Find("link_top/layout")
end

function MainActNewServerBtn:InShowTime()
	return NewServerCarnivalScene.isShow()
end

function MainActNewServerBtn:GetUIName()
	return "MainUINewServerBtn"
end

function MainActNewServerBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.NEW_SERVER_CARNIVAL)

	return
end

function MainActNewServerBtn:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"NEW_SERVER"
	}, function(arg_6_0)
		setActive(arg_6_0, NewServerCarnivalScene.isTip())

		return
	end)

	return
end

function MainActNewServerBtn:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainActNewServerBtn
