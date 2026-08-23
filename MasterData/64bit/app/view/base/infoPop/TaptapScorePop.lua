local var_0_0 = {
	SCORE = 1,
	SUBMIT = 2
}
local TaptapScorePop = class("TaptapScorePop", require("app.fairyGUI.infoPop.UI_TaptapScorePop"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/infoPop/infoPop",
		resName = "TaptapScorePop",
		pkgName = "infoPop"
	})
end)

function TaptapScorePop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 then
		self._type = arg_2_1.type or var_0_0.SCORE
	end

	self._curStar = 0

	for iter_2_0 = 1, 5 do
		self["m_star" .. iter_2_0]:addClickListener(handler(self, self.onStarClick))
	end

	self.m_inputTxt:addEventListener(fgui.UIEventType.Changed, handler(self, self._onEditEventChanged))
	self.m_laterBtn:addClickListener(handler(self, self._onLaterClick))
	self.m_submitBtn:addClickListener(handler(self, self._onSubmitClick))
end

function TaptapScorePop:_onEditEventChanged()
	self.m_placeHolderTxt:setVisible(self.m_inputTxt:getText() == "")
end

function TaptapScorePop:onStarClick(arg_4_1)
	self._curStar = tonumber((string.match(arg_4_1:getSender():getName(), ".+(%d+)")))

	self.m_starController:setSelectedIndex(self._curStar)
end

function TaptapScorePop:onLoad()
	self.m_stateController:setSelectedIndex(self._type - 1)
end

function TaptapScorePop:_onLaterClick()
	g.core.model.User.UserTitleData:setLastShowTime(2)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function TaptapScorePop:_onSubmitClick()
	if self.m_stateController:getSelectedIndex() == 0 then
		if self._curStar == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1304))
		elseif self._curStar < 4 then
			self._type = var_0_0.SUBMIT

			g.core.model.User.UserTitleData:setLastShowTime(30)
			self.m_stateController:setSelectedIndex(self._type - 1)
		else
			g.core.model.User.UserTitleData:setLastShowTime(30)
			g.core.platform.PlatformProxy:jumpTaptapCommentArea()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return TaptapScorePop
