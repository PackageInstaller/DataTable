local var_0_0 = g.core.model.User.abvertPageAwardData
local AbvertPageAwardPop = class("AbvertPageAwardPop", require("app.fairyGUI.activity.UI_AbvertPageAwardPop"), function()
	return fgui.GComponent:create({
		resName = "AbvertPageAwardPop",
		pkgName = "activity",
		pkgPath = "ui/activity/activity"
	}, ...)
end)

function AbvertPageAwardPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._endcall = arg_2_1.endcall
	end

	self:showAtCenter()
	self.m_bgLoader:addClickListener(handler(self, self._onClickClose))
	self.m_enterTransition:play()
end

function AbvertPageAwardPop:_onClickClose()
	self.m_backTransition:play(handler(self, self._onClose))
end

function AbvertPageAwardPop:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	self:homeLayerAutoPopup()
end

function AbvertPageAwardPop:homeLayerAutoPopup()
	if self._endcall then
		self._endcall()

		self._endcall = nil
	end
end

function AbvertPageAwardPop:onLoad()
	self:updateView()
end

function AbvertPageAwardPop:updateView()
	local var_7_0 = fgui.UIPackage:createObject("activity", "ActivityAbvertPageAwardComp_" .. var_0_0:getOpenScreenTemplate((var_0_0:getCurActId())))

	self.m_placeComp:addChild(var_7_0)
	var_7_0:updateComp(true)
end

return AbvertPageAwardPop
