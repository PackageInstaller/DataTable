local DebugConst = require("app.view.module.debug.const.DebugConst")
local GMComp = class("GMComp", require("app.fairyGUI.debug.UI_GMComp"))

function GMComp:ctor()
	self._tabIndex = -1
	self._subComps = {}
	self._timeId = nil

	self:_init()
end

function GMComp:_init()
	self.m_closeBtn:addClickListener(handler(self, self.close))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChanged))
	self.m_tabList:setSelectedIndex(0)
	self:_onTabChanged()
end

function GMComp:onLoad()
	self._timeId = self._timeId or g.core.common.Scheduler:newSchedule(handler(self, self._updateTimeText), 1)

	self:_updateTimeText()

	if self._curComp then
		self._curComp:onShow()
	end
end

function GMComp:onUnload()
	if self._timeId then
		g.core.common.Scheduler:cancelSchedule(self._timeId)
	end

	self._timeId = nil

	if self._curComp then
		self._curComp:onHide()
	end
end

function GMComp:close()
	if self._curComp then
		self._curComp:onHide()
	end

	g.core.module.ModuleManager:popComponent()
end

function GMComp:_onTabChanged()
	local var_6_0 = self.m_tabList:getSelectedIndex()

	if var_6_0 == self._tabIndex then
		return
	end

	self._tabIndex = var_6_0

	self:_showSubComp(var_6_0 + 1)
end

function GMComp:_showSubComp(arg_7_1)
	if self._curComp then
		self._curComp:onHide()
	end

	local var_7_0 = self._subComps[arg_7_1]

	if not self._subComps[arg_7_1] then
		var_7_0 = fgui.UIPackage:createObject("debug", DebugConst.TOOL.SUB_COMP[arg_7_1], self)

		self.m_subComp:addChild(var_7_0)

		self._subComps[arg_7_1] = var_7_0
	end

	self._curComp = var_7_0

	self._curComp:onShow()
end

function GMComp:_updateTimeText()
	if self.m_serverTimeText then
		self.m_serverTimeText:setText((g.core.common.ServerTime:getTimeString()))
	end
end

return GMComp
