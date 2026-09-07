local MainActDelegationBtn = class("MainActDelegationBtn", import(".MainBaseSpcailActBtn"))

function MainActDelegationBtn:GetContainer()
	return self.root.parent:Find("eventPanel")
end

function MainActDelegationBtn:InShowTime()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.RYZA_TASK)

	return var_2_0 and not var_2_0:isEnd() and (var_2_0 and var_2_0:getConfig("config_client").hide_main_btn or nil) ~= 1
end

function MainActDelegationBtn:GetUIName()
	return "MainActDelegationBtn"
end

function MainActDelegationBtn:OnClick()
	self.event:emit(NewMainMediator.GO_SCENE, SCENE.RYZA_TASK)

	return
end

function MainActDelegationBtn:OnInit()
	setAnchoredPosition(self._tf, {
		x = 200,
		y = 220
	})

	return
end

function MainActDelegationBtn:OnRegister()
	self.redDotUI = self._tf:Find("tip")

	pg.EasyRedDotMgr.GetInstance():RegisterRedDot(self.redDotUI, {
		"RYZA_TASK"
	}, function(arg_7_0)
		setActive(arg_7_0, getProxy(ActivityTaskProxy):getActTaskTip(ActivityConst.RYZA_TASK))

		return
	end)

	return
end

function MainActDelegationBtn:OnClear()
	if self.redDotUI then
		pg.EasyRedDotMgr.GetInstance():UnRegisterRedDot(self.redDotUI)

		self.redDotUI = nil
	end

	return
end

return MainActDelegationBtn
