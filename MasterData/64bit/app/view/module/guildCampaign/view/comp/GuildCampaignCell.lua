local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.guildCampaignData
local var_0_2 = g.core.module.ModuleManager
local var_0_3 = {
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILDFIGHT_PLAYERLEVEL] = 11,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_DUNGEON] = 73,
	[g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS] = 88
}
local GuildCampaignCell = class("GuildCampaignCell", require("app.fairyGUI.guildCampaign.UI_GuildCampaignCell"))

function GuildCampaignCell:ctor(arg_1_1)
	self:addClickListener(handler(self, self._onClick))
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
	self.m_descText:enableRich()
end

function GuildCampaignCell:updateInfo(arg_2_1)
	self._isLock = arg_2_1.isLock
	self._functionId = arg_2_1.cfgInfo.id
	self._routeId = arg_2_1.cfgInfo.route_id
	self._videoName = arg_2_1.cfgInfo.video

	self.m_isNotOpenController:setSelectedIndex(2)

	if self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_BOSS or self._functionId == g.core.const.ConstMgr.FUNCTION_TYPE.GUILDFIGHT_PLAYERLEVEL then
		self.m_isNotOpenController:setSelectedIndex(var_0_1:isActivityOpen(self._functionId) and 0 or 1)
	end

	self.m_image:setURL(var_0_0:getGuildCampaignPicById(arg_2_1.cfgInfo.pic))
	self.m_nameComp:setText(arg_2_1.cfgInfo.name or "")
	self.m_isLockController:setSelectedIndex(self._isLock and 0 or 1)

	if self._isLock then
		self.m_unLockText:setText(g.core.lang:get(100528))
	else
		self.m_descText:setText(arg_2_1.cfgInfo.output_des)
	end

	if var_0_3[self._functionId] then
		self.m_redPointComp:setId(var_0_3[self._functionId])
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			functionId = self._functionId
		}
	})

	if var_0_1:judgeFunctionHasEnter(self._functionId) then
		self.m_redPointComp:setVisible(false)
	end
end

function GuildCampaignCell:_onClick()
	if self._isLock then
		var_0_2:tip(g.core.config.function_info.get(self._functionId).lock_direction or "")

		return
	else
		g.core.model.User.functionUnlockData:saveUnlockedFunc(self._functionId)

		if false and not var_0_1:judgeFunctionHasEnter(self._functionId) then
			var_0_1:setFunctionHasEnterRecord(self._functionId)
			var_0_2:pushPopup(require("app.view.module.guildCampaign.view.GuildCampaignMoviePop").new({
				movieInfo = {
					moduleName = "guildCampaign",
					movieName = self._videoName
				},
				callBack = handler(self, self._goToModule),
				functionId = self._functionId
			}), {
				blackOpacity = 0,
				withoutAni = true
			})
		else
			self:_goToModule(nil, true)
		end
	end
end

function GuildCampaignCell:_goToModule(arg_4_1, arg_4_2)
	if self._routeId then
		self:_goTo()
	end
end

function GuildCampaignCell:_goTo()
	self:dispatchCompEvent("GuildCampaignCell_goToModule", {
		routeId = self._routeId
	})
end

return GuildCampaignCell
