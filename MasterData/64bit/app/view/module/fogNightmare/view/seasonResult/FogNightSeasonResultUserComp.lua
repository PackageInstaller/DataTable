local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_base_info
local var_0_2 = g.core.common.Path
local FogNightSeasonResultUserComp = class("FogNightSeasonResultUserComp", require("app.fairyGUI.fogNightmare.UI_FogNightSeasonResultUserComp"))

function FogNightSeasonResultUserComp:ctor()
	self._user = nil

	self:addClickListener(handler(self, self._onClickComp))
end

function FogNightSeasonResultUserComp:_onClickComp()
	if self._user and g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.PLAYER_INFO) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PLAYER_INFO, {
			isUpdate = true,
			uid = self._user.id
		})
	end
end

function FogNightSeasonResultUserComp:updateComp(arg_3_1)
	if not arg_3_1 then
		return
	end

	self.m_stageComp:setTitle(tostring(arg_3_1.score or 0))

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_3_1.id)

	self._user = var_3_0

	if var_3_0 then
		self.m_userNameText:setText(var_3_0.name or "")
		self.m_serverNameText:setText(var_3_0.server_name or "")

		if (var_3_0.guild_id or 0) > 0 then
			self.m_hasGuildController:setSelectedIndex(1)
			self.m_guildNameText:setText(var_3_0.guild_name or "")
		else
			self.m_hasGuildController:setSelectedIndex(0)
		end

		local var_3_2 = var_3_0.show_knight_id or 0
		local var_3_3 = var_3_0.show_knight_dress or 0
		local var_3_4

		if var_3_3 > 0 then
			var_3_4 = var_0_1.get(g.core.config.skin_info.get(var_3_3).res)
		elseif var_3_2 > 0 then
			var_3_4 = var_0_1.get(var_0_0.get(var_3_2).res_id)
		end

		if var_3_4 then
			self.m_knightComp:setIcon((var_0_2:getMiddleKnightPicById(var_3_4.painted_id)))
			self.m_knightComp:setVisible(true)
		end
	else
		self.m_userNameText:setText("")
		self.m_serverNameText:setText("")
		self.m_guildNameText:setText("")
		self.m_hasGuildController:setSelectedIndex(0)
		self.m_knightComp:setVisible(false)
	end
end

return FogNightSeasonResultUserComp
