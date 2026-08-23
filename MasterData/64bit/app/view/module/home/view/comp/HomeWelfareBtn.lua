local HomeWelfareBtn = class("HomeWelfareBtn", require("app.fairyGUI.home.UI_HomeWelfareBtn"))

function HomeWelfareBtn:ctor()
	self._welfareInfo = nil

	self:addClickListener(handler(self, self._onClick))
	self.m_eff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_home_welfareBtn"
	})
end

function HomeWelfareBtn:updateBtn()
	if g.core.platform.ServerListProxy:isTesting() then
		self:setVisible(false)

		return
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.WELFARE_TIP_ENTER) then
		self:setVisible(false)

		return
	end

	self._welfareInfo = g.core.model.User.homeData:getWelfareInfo()

	if self._welfareInfo == nil then
		self:setVisible(false)

		return
	end

	self.m_scrollTitle:setText(self._welfareInfo.title)
	self.m_lockTipText:setText(self._welfareInfo.tip)
	self:setVisible(true)
end

function HomeWelfareBtn:_onClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.home.view.HomeWelfarePop").new(self._welfareInfo), {
		touchDisappear = false
	})
end

return HomeWelfareBtn
