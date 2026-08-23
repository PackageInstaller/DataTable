local ThemeBioVoteItemComp = class("ThemeBioVoteItemComp", require("app.fairyGUI.themeBio.UI_ThemeBioVoteItemComp"))

function ThemeBioVoteItemComp:ctor()
	self._info = nil
	self._state = nil
	self._unlockStr = nil

	self:addClickListener(handler(self, self._onClickItem))
end

function ThemeBioVoteItemComp:updateVoteItem(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	if arg_2_1.info then
		self._info = arg_2_1.info
	end

	if arg_2_1.chapterId then
		self._chapterId = arg_2_1.chapterId
	end

	if arg_2_1.state then
		self._state = arg_2_1.state
	end

	if arg_2_1.unlockStr then
		self._unlockStr = arg_2_1.unlockStr
	end

	if arg_2_1.compIndex then
		self._compIndex = arg_2_1.compIndex
	end

	if arg_2_1.selected then
		self.m_selectedController:setSelectedIndex(1)
	else
		self.m_selectedController:setSelectedIndex(0)
	end

	if arg_2_1.hasOnlyOneOption and self._state == "lock" then
		self:setTitle(g.core.lang:get(409148))
	elseif self._info then
		self:setTitle(self._info.name)
	end

	if self._state then
		self.m_stateController:setSelectedPage(self._state)
	end
end

function ThemeBioVoteItemComp:onLoad()
	return
end

function ThemeBioVoteItemComp:onUnload()
	return
end

function ThemeBioVoteItemComp:_onClickItem()
	if self._state == "lock" and self._unlockStr then
		g.core.module.ModuleManager:tip(self._unlockStr)

		return
	end

	if self._info then
		self:dispatchCompEvent("ThemeBioVoteItemComp_onClickItem", {
			info = self._info,
			chapterId = self._chapterId,
			compIndex = self._compIndex
		})
	end
end

function ThemeBioVoteItemComp:_getVoteState()
	return
end

return ThemeBioVoteItemComp
