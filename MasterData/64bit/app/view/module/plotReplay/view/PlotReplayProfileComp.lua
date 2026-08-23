local PlotReplayProfileComp = class("PlotReplayProfileComp", require("app.fairyGUI.plotReplay.UI_PlotReplayProfileComp"))

function PlotReplayProfileComp:ctor()
	self._profileInfo = g.core.model.User.plotReplayReviewData:getProfileInfo()

	self:_init()
end

function PlotReplayProfileComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_PLOT_REPLAY_PROFILE_CELL, self._refreshUI, self)
end

function PlotReplayProfileComp:_init()
	for iter_3_0 = 1, 3 do
		self["m_tabBtn" .. iter_3_0]:setTitle(self._profileInfo[iter_3_0].typeName)

		local var_3_0 = self["m_tabBtn" .. iter_3_0]:getChild("redPointComp")

		var_3_0:setId(303)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = var_3_0,
			customData = {
				type = self._profileInfo[iter_3_0].type
			}
		})
	end

	self.m_tabStateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChanged))
	self.m_profileList:setVirtual()
	self.m_profileList:doFairyBatching(false)
	self.m_profileList:setItemRenderer(handler(self, self._onItemRenderer))
end

function PlotReplayProfileComp:updateView(arg_4_1)
	if arg_4_1 then
		self.m_tabStateController:setSelectedIndex(arg_4_1 - 1)
	end

	self._curProfileInfo = {}

	for iter_4_0, iter_4_1 in pairs(self._profileInfo[self.m_tabStateController:getSelectedIndex() + 1].infos) do
		table.insert(self._curProfileInfo, iter_4_1)
	end

	self.m_profileList:setNumItems(#self._curProfileInfo)

	if arg_4_1 then
		local var_4_0 = g.core.model.User.plotReplayReviewData:getProfileSelectedId()
		local var_4_1

		for iter_4_2, iter_4_3 in ipairs(self._curProfileInfo) do
			for iter_4_4, iter_4_5 in ipairs(iter_4_3) do
				if iter_4_5.id == var_4_0 then
					var_4_1 = iter_4_2

					break
				end
			end

			if var_4_1 then
				break
			end
		end

		if var_4_1 then
			self.m_profileList:scrollToView(var_4_1 - 1)
		end
	end
end

function PlotReplayProfileComp:_refreshUI()
	self:updateView()
end

function PlotReplayProfileComp:_onTabChanged()
	self:updateView()
end

function PlotReplayProfileComp:_onItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateView(self._curProfileInfo[arg_7_1 + 1])
end

return PlotReplayProfileComp
