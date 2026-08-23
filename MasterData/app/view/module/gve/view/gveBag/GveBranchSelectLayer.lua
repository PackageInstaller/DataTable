local GveBranchSelectLayer = class("GveBranchSelectLayer", require("app.fairyGUI.gve.UI_GveBranchSelectLayer"), function()
	return fgui.GComponent:create({
		resName = "GveBranchSelectLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveBranchSelectLayer:ctor(arg_2_1)
	self._data = arg_2_1

	self.m_enterTransition:play()
	self:_initView()
end

function GveBranchSelectLayer:_initView()
	self:addBg("bg/gve/bg_pshc_fenzhixuanze.jpg", false, nil, 1)
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_HALIDOM_LAYER)
	self.m_tipBtn:addClickListener(handler(self, self._onClickTip))
end

function GveBranchSelectLayer:updateView()
	for iter_4_0 = 1, 3 do
		self["m_branchBtn" .. iter_4_0]:updateView(iter_4_0, self._data)
	end
end

function GveBranchSelectLayer:onLoad()
	self:updateView()
	self:checkSelectBranchGuide()
end

function GveBranchSelectLayer:receiveCompEvent(arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or {}
end

function GveBranchSelectLayer:_onClickTip()
	self._helpId = 207

	if self._helpId and self._helpId > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.component.HelpPop").new({
			id = self._helpId
		}), {
			touchDisappear = true
		})
	end
end

function GveBranchSelectLayer:checkSelectBranchGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = "GUIDE_GVE_HALIDOM_CHANGE_BRANCH",
		targetBtn = self
	})
end

function GveBranchSelectLayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return GveBranchSelectLayer
