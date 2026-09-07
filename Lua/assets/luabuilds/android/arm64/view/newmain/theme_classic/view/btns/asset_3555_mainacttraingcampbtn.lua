local MainActTraingCampBtn = class("MainActTraingCampBtn", import(".MainBaseSpcailActBtn"))

function MainActTraingCampBtn:GetContainer()
	return self.root.parent:Find("link_top/layout")
end

function MainActTraingCampBtn:InShowTime()
	return true
end

function MainActTraingCampBtn:GetUIName()
	return "MainUIRecruitBtn"
end

function MainActTraingCampBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.COMMANDER_MANUAL)

	return
end

function MainActTraingCampBtn:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"COMMANDER_MANUAL"
	}, function(arg_6_0)
		local var_6_0, var_6_1 = TechnologyConst.isTecActOn()
		local var_6_2 = getProxy(CommanderManualProxy):ShouldShowTaskOrGuideTip()

		var_6_2 = var_6_2 or var_6_1

		setActive(arg_6_0, var_6_2)

		return
	end)

	return
end

function MainActTraingCampBtn:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainActTraingCampBtn
