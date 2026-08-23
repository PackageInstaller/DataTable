local AncientsAgainstIcon = class("AncientsAgainstIcon", require("app.fairyGUI.ancients.UI_AncientsAgainstIcon"))
local var_0_2 = g.core.const.ConstMgr.AncientsConst

function var_0_0:ctor()
	self:addClickListener(handler(self, self._onClickIcon))
end

function var_0_0:updateIcon(arg_2_1)
	self._data = arg_2_1.data

	local var_2_0 = arg_2_1.round

	if self._data then
		self.m_shuiyinController:setSelectedIndex(self._data.team_id == (g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM) and g.core.model.User.ancientsData:getTeam(var_0_2.GET_TEAM_TYPE.FINAL_TEAM).team_id or 0) and 1 or 0)
		self.m_is_emptyController:setSelectedIndex(0)
		self.m_is_likeController:setSelectedIndex(g.core.model.User.ancientsData:isGuessByTeamId(var_2_0, self._data.team_id) and 1 or 0)
		self.m_is_grayController:setSelectedIndex(not g.core.model.User.ancientsData:isPromoteByTeamId(var_2_0, self._data.team_id) and not g.core.model.User.ancientsData:isInStageShowTime(var_2_0) and 1 or 0)
		self.m_Txt_name:setText(g.core.lang:get(433332, {
			name = self._data.name
		}))
		self.m_Txt_name_king:setText(g.core.lang:get(433332, {
			name = self._data.name
		}))

		local var_2_1 = {}

		var_2_1.fightValue = self._data.pet_fight_value or 0

		self.m_Txt_fight:setText(g.core.lang:get(433411, var_2_1))

		local var_2_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._data.captain)

		if var_2_2 then
			self.m_headCutComp:getChild("icon"):updateAsUser(var_2_2)
		end
	else
		self.m_is_emptyController:setSelectedIndex(1)
		self.m_is_grayController:setSelectedIndex(not g.core.model.User.ancientsData:isPromoteByTeamId(var_2_0, 0) and not g.core.model.User.ancientsData:isInStageShowTime(var_2_0) and 1 or 0)
	end

	self.m_effDi:removeAllEffect()
	self.m_effKing:removeAllEffect()
	self.m_effDi:addEffectSpine({
		anim = "play_1",
		isLoop = true,
		remove = false,
		name = "eff_ui_ancients_championlight"
	})
	self.m_effKing:addEffectSpine({
		anim = "play_2",
		isLoop = true,
		remove = false,
		name = "eff_ui_ancients_championlight"
	})
end

function var_0_0._onClickEquip(arg_3_0)
	return
end

function var_0_0:_onClickIcon()
	if self._data then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_COOP_TEAM_INFO_POP, {
			teamId = self._data.team_id
		})
	end
end

return var_0_0
