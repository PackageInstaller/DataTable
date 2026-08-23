local ShowRoomFuncText = class("ShowRoomFuncText", require("app.fairyGUI.showRoom.UI_ShowRoomFuncText"))

function ShowRoomFuncText:ctor()
	self._data = nil

	self:addClickListener(handler(self, self._onTouchClick))
end

function ShowRoomFuncText:onLoad()
	if self._redPointId then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function ShowRoomFuncText:setData(arg_3_1)
	if not arg_3_1 then
		return
	end

	self._data = arg_3_1

	if arg_3_1.redPointId then
		self._redPointId = arg_3_1.redPointId

		self.m_redPointComp:setId(self._redPointId)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp
		})
	end
end

function ShowRoomFuncText:_onTouchClick()
	if not self._data or not self._data.isOpen() then
		local var_4_0, var_4_1 = self._data.isOpen()

		if var_4_1 then
			g.core.module.ModuleManager:tip(var_4_1)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(111524, {
				name = self._data.name
			}))
		end

		return
	end

	if self._data.onClick then
		self._data.onClick()
	end
end

function ShowRoomFuncText:playEnterAnim()
	if not self._data.isOpen() then
		self.m_lockController:setSelectedIndex(1)
	end

	local var_5_0 = self.m_typeController:getSelectedIndex()

	if var_5_0 == 5 then
		var_5_0 = 1
	end

	self["m_in" .. var_5_0 .. "Transition"]:play()
end

function ShowRoomFuncText:playInitAnim()
	self.m_initTransition:play()
end

return ShowRoomFuncText
