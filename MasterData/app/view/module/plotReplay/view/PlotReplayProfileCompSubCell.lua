local PlotReplayProfileCompSubCell = class("PlotReplayProfileCompSubCell", require("app.fairyGUI.plotReplay.UI_PlotReplayProfileCompSubCell"))

function PlotReplayProfileCompSubCell:ctor()
	self:_init()
end

function PlotReplayProfileCompSubCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORY_COMPLETION_AWARD, handler(self, self._onRcvProfileAward), self)
end

function PlotReplayProfileCompSubCell:_init()
	self:addClickListener(handler(self, self._onClick))
	self.m_getBtn:addClickListener(handler(self, self._onGetClick))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
end

function PlotReplayProfileCompSubCell:updateView(arg_4_1, arg_4_2)
	self._data = arg_4_2
	self._selectedId = g.core.model.User.plotReplayReviewData:getProfileSelectedId()

	local var_4_0 = g.core.model.User.dungeonData:getPassedChapterNum() >= arg_4_2.num

	self.m_isUnlockController:setSelectedIndex(var_4_0 and 1 or 0)

	if self._selectedId == arg_4_2.id then
		self.m_cellTypeController:setSelectedIndex(1)
		self:setHeight(218)
		self.m_noText2:setText(string.format("%02d", arg_4_1 + 1))
		self.m_nameText2:setText(arg_4_2.proflie)
		self.m_lockText2:setText(g.core.lang:get(111542, {
			num = arg_4_2.num
		}))
		self.m_iconLoader:setURL(g.core.common.Path:getProfileIconById(arg_4_2.icon))

		if var_4_0 then
			self.m_contentLabel:setTitle(arg_4_2.proflie_content)
		else
			self.m_contentLabel:setTitle("")
		end

		self._awards = g.core.model.User.plotReplayReviewData:getProfileAward(arg_4_2.drop_id)

		self.m_awardList:setNumItems(#self._awards)
		self.m_stateController:setSelectedIndex((g.core.model.User.plotReplayReviewData:getProfileAwardState(arg_4_2.id)))
	else
		self.m_cellTypeController:setSelectedIndex(0)
		self:setHeight(50)
		self.m_noText:setText(string.format("%02d", arg_4_1 + 1))

		if var_4_0 then
			self.m_nameText:setText(arg_4_2.proflie)
		else
			self.m_lockText:setText(g.core.lang:get(111542, {
				num = arg_4_2.num
			}))
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			type = arg_4_2.type,
			subtype = arg_4_2.subtype,
			id = arg_4_2.id
		}
	})
end

function PlotReplayProfileCompSubCell:_onRcvProfileAward(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if self._selectedId == self._data.id and arg_5_4.story_id == self._data.id then
		self.m_stateController:setSelectedIndex(2)
	end
end

function PlotReplayProfileCompSubCell:_onAwardItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateIcon(self._awards[arg_6_1 + 1])
end

function PlotReplayProfileCompSubCell:_onClick()
	if self.m_cellTypeController:getSelectedIndex() == 1 then
		return
	end

	g.core.model.User.plotReplayReviewData:setProfileSelectedId(self._data.id)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_PLOT_REPLAY_PROFILE_CELL)
end

function PlotReplayProfileCompSubCell:_onGetClick()
	g.core.network.GameNetProxy:send_C2S_StoryCompletion_Award({
		story_id = self._data.id
	})
end

return PlotReplayProfileCompSubCell
