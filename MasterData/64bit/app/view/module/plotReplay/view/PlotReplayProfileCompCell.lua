local PlotReplayProfileCompCell = class("PlotReplayProfileCompCell", require("app.fairyGUI.plotReplay.UI_PlotReplayProfileCompCell"))
local var_0_1 = 50
local var_0_2 = 218
local var_0_3 = 8

function PlotReplayProfileCompCell:ctor()
	self:_init()
end

function PlotReplayProfileCompCell:onLoad()
	return
end

function PlotReplayProfileCompCell:_init()
	self.m_redPointComp:setId(303)
	self.m_profileSubList:setIniter(self)
	self.m_profileSubList:setItemRenderer(handler(self, self._onItemRenderer))
end

function PlotReplayProfileCompCell:updateView(arg_4_1)
	self._data = arg_4_1 or self._data

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			subtype = self._data[1].subtype
		}
	})

	local var_4_0 = false

	self._selectedId = g.core.model.User.plotReplayReviewData:getProfileSelectedId()

	if self._selectedId then
		for iter_4_0, iter_4_1 in ipairs(self._data) do
			if iter_4_1.id == self._selectedId then
				var_4_0 = true

				break
			end
		end
	end

	local var_4_1 = #self._data

	self.m_nameText:setText(g.core.lang:get(111543, {
		name = self._data[1].title,
		num1 = g.core.model.User.plotReplayReviewData:getProfileUnlockCntBySubType(self._data[1].subtype),
		num2 = #self._data
	}))

	if var_4_0 then
		self.m_profileSubList:setHeight(var_0_1 * var_4_1 + var_0_3 * (var_4_1 - 1) + var_0_2 - var_0_1)
	else
		self.m_profileSubList:setHeight(var_0_1 * var_4_1 + var_0_3 * (var_4_1 - 1))
	end

	self.m_profileSubList:setNumItems(var_4_1)
end

function PlotReplayProfileCompCell:_onItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateView(arg_5_1, self._data[arg_5_1 + 1])
end

return PlotReplayProfileCompCell
