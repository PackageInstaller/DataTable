local IllustrationCell = class("IllustrationCell", require("app.fairyGUI.illustration.UI_IllustrationCell"))

function IllustrationCell:ctor()
	self._isActive = false
	self._info = nil
	self._new = false
	self._type = nil
	self._id = nil

	self:addClickListener(handler(self, self._onTouchClick))
	self.m_playBtn:addClickListener(handler(self, self._onTouchClick))
	self.getSharedTrans(self, "listReplayUiDownIn01", "PlotReplayList", self)
	self.getSharedTrans(self, "listReplayUiDownOut01", "PlotReplayList", self)
end

function IllustrationCell:setData(arg_2_1, arg_2_2)
	self._isActive = arg_2_1.isActive
	self._info = arg_2_1.info
	self._new = not arg_2_1.readed
	self._type = arg_2_2
	self._id = arg_2_1.id

	self.m_showLabel:setIcon(g.core.common.Path:getWarriorsWindRes(arg_2_1.info.pic_reel))
	self.m_showLabel:setTitle(arg_2_1.info.name)

	if arg_2_1.isActive then
		self.m_lockController:setSelectedIndex(1)

		if arg_2_1.info.is_play == 1 then
			self.m_movieController:setSelectedIndex(1)
		else
			self.m_movieController:setSelectedIndex(0)
		end
	else
		self.m_movieController:setSelectedIndex(0)
		self.m_lockController:setSelectedIndex(0)
	end

	self.m_typeController:setSelectedIndex(arg_2_1.info.type - 1)

	if not arg_2_1.readed and arg_2_1.isActive then
		self.m_newController:setSelectedIndex(1)
	else
		self.m_newController:setSelectedIndex(0)
	end
end

function IllustrationCell:_onTouchClick()
	if self._isActive then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.illustration.view.IllustrationSharePop").new({
			info = self._info,
			new = self._new
		})))

		if self._new then
			self._new = false

			g.core.model.User.illustrationData:setReaded(self._type, self._id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ILLUSTRATION_NEW_READ)
		end
	end
end

return IllustrationCell
