local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationGuildBuffItem = class("ExplorationGuildBuffItem", require("app.fairyGUI.exploration.UI_ExplorationGuildBuffItem"))

function ExplorationGuildBuffItem:ctor()
	self._roomId = 0
	self._userIdList = {}

	self:_initBtn()
end

function ExplorationGuildBuffItem:_initBtn()
	self.m_playerBtn:addClickListener(handler(self, self._onGuildPlayerClick))
	self.m_gotoBtn:addClickListener(handler(self, self._onGotoRoomClick))
end

function ExplorationGuildBuffItem:_onGuildPlayerClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.exploration.view.buff.ExplorationGuildBuffPlayerPop").new(self._userIdList)))
end

function ExplorationGuildBuffItem:_onGotoRoomClick()
	if self._roomId > 0 then
		self:dispatchCompEvent("ExplorationGuildBuffPop_moveToMap", {
			roomId = self._roomId
		})
	end
end

function ExplorationGuildBuffItem:updateBuffInfo(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._roomId = arg_5_1.roomId
	self._userIdList = arg_5_1.userIdList

	local var_5_0 = g.core.config.exploration_guild_buff_info.get(arg_5_1.id)

	self.m_descText:setText(var_5_0.des)
	self.m_buffComp:updateBuffIcon(arg_5_1.id, var_0_0.BUFF.GUILD_TYPE)
	self.m_qualityLoader:setURL(g.core.common.Path:getExplorationGuildBuffQuality(var_5_0.quality))

	if #self._userIdList > 0 then
		self.m_isActiveController:setSelectedIndex(1)
		self.m_activeText:setText(g.core.lang:get(420657, {
			num = var_5_0.num
		}))

		local var_5_1 = g.core.model.User.explorationData:getGuildBuffPlayerInfo(self._userIdList[1])

		if var_5_1 then
			self.m_nameText:setText(var_5_1.name)

			if var_5_1.id == g.core.model.User:getId() then
				self.m_userIcon:updateAsSelf()
			else
				self.m_userIcon:updateAsUser(var_5_1)
			end
		end
	else
		self.m_isActiveController:setSelectedIndex(0)
	end
end

return ExplorationGuildBuffItem
