local MainIslandActDelegationBtn = class("MainIslandActDelegationBtn", import(".MainBaseSpcailActBtn"))

function MainIslandActDelegationBtn:GetContainer()
	return self.root.parent:Find("eventPanel")
end

function MainIslandActDelegationBtn:InShowTime()
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

	return var_2_0 and not var_2_0:isEnd()
end

function MainIslandActDelegationBtn:GetUIName()
	return "MainIslandActDelegationBtn"
end

function MainIslandActDelegationBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SEA, {
		checkMain = true
	})

	return
end

function MainIslandActDelegationBtn:OnInit()
	return
end

function MainIslandActDelegationBtn:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"ISLAND"
	}, function(arg_7_0)
		setActive(arg_7_0, Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND))))

		return
	end)

	return
end

function MainIslandActDelegationBtn:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainIslandActDelegationBtn
