local RoleSkinRightComp = class("RoleSkinRightComp", require("app.fairyGUI.roleSkin.UI_RoleSkinRightComp"))

function RoleSkinRightComp:ctor()
	self.m_bgLoader:setURL("pic/base_new/bg_yht_rightdi.png")
end

function RoleSkinRightComp:onLoad()
	if self._viewData then
		for iter_2_0, iter_2_1 in pairs({
			[2] = 24,
			[3] = 23
		}) do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
				redPointComp = self._redPoints[iter_2_0],
				customData = {
					advId = self._viewData:getAdvanceId()
				}
			})
		end
	end
end

function RoleSkinRightComp:init(arg_3_1, arg_3_2)
	self._childComp = {}
	self._config = arg_3_1.DEV_LIST
	self._perSelectIndex = nil
	self._viewData = nil
	self._selectIndex = arg_3_2 or 1

	self.m_tabList:setSelectedIndex(self._selectIndex - 1)
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabClicked))

	local var_3_0 = {
		[2] = 24,
		[3] = 23
	}

	if not self._tabBtn then
		self._redPoints = {}
		self._tabBtn = self.m_tabList:getChildren()

		for iter_3_0, iter_3_1 in ipairs(self._tabBtn) do
			table.insert(self._redPoints, iter_3_1:getChild("redPointComp"))

			if var_3_0[iter_3_0] then
				self._redPoints[iter_3_0]:setId(var_3_0[iter_3_0])
			end
		end
	end
end

function RoleSkinRightComp:setViewData(arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in pairs({
		[2] = 24,
		[3] = 23
	}) do
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self._redPoints[iter_4_0],
			customData = {
				advId = arg_4_1:getAdvanceId()
			}
		})
	end

	self._viewData = arg_4_1

	self:updateView(arg_4_2)
end

function RoleSkinRightComp:onExitAnimPlayEnd()
	if self._perSelectIndex and self._childComp[self._perSelectIndex] then
		self._childComp[self._perSelectIndex]:setVisible(false)
	end

	self._childComp[self._selectIndex]:setVisible(true)
	self._childComp[self._selectIndex]:playEnterAnim(handler(self, self._onEnterAnimFinish))
end

function RoleSkinRightComp:_onEnterAnimFinish()
	self.m_tabList:setTouchable(true)
end

function RoleSkinRightComp:updateView(arg_7_1)
	if not self._viewData then
		return
	end

	local var_7_0 = false

	if not arg_7_1 then
		self.m_tabList:setTouchable(false)

		if self._perSelectIndex and self._childComp[self._perSelectIndex] and self._childComp[self._perSelectIndex]:isVisible() then
			self._childComp[self._perSelectIndex]:playExitAnim(handler(self, self.onExitAnimPlayEnd))

			var_7_0 = true
		end
	end

	if not self._childComp[self._selectIndex] then
		local var_7_1 = string.split(self._config[self._selectIndex].compNew, "/")
		local var_7_2 = fgui.UIPackage:createObject(var_7_1[1], var_7_1[2])

		if self._selectIndex == 1 then
			var_7_2:setX(-5)
		end

		self.m_placeHolderComp:addChild(var_7_2)

		self._childComp[self._selectIndex] = var_7_2

		self._childComp[self._selectIndex]:setVisible(false)
	end

	self:dispatchCompEvent("Event_refresh_top_bar", self._config[self._selectIndex].resInfoId)
	self._childComp[self._selectIndex]:updateShow(self._viewData)

	if not arg_7_1 and not var_7_0 then
		self:onExitAnimPlayEnd()
	end
end

function RoleSkinRightComp:_onTabClicked(arg_8_1)
	local var_8_0 = self.m_tabList:getSelectedIndex()

	if var_8_0 + 1 ~= self._selectIndex then
		local var_8_1 = arg_8_1:getSender():getChildAt(var_8_0):getChild("effectHolder")

		if var_8_1 then
			var_8_1:addEffectSpine({
				scale = 1,
				isLoop = false,
				name = "eff_ui_knight_tab"
			})
		end

		self._perSelectIndex = self._selectIndex
		self._selectIndex = var_8_0 + 1

		self:updateView()
	end
end

return RoleSkinRightComp
