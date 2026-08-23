local var_0_0 = g.core.model.User.GuildFightData
local GuildFightNormalChooseCell = class("GuildFightNormalChooseCell", require("app.fairyGUI.guildFight.UI_GuildFightNormalChooseCell"))

function GuildFightNormalChooseCell:ctor()
	self._playerData = {}
	self._playerId = nil
	self._scoreInfo = nil

	self:addClickListener(handler(self, self._onTouchClick))

	if self.m_enterTransition then
		self.m_enterTransition:play()
	end

	self.getSharedTrans(self, "listCardAUiLeftIn", "CombineBagList", self)
end

function GuildFightNormalChooseCell:updateInfo(arg_2_1)
	self._playerData = arg_2_1

	local var_2_0 = var_0_0:getPlayerIdByData(self._playerData)
	local var_2_1 = var_0_0:getScoreInfoById(var_2_0)

	self._playerId = var_2_0
	self._scoreInfo = var_2_1

	if not var_2_1 then
		return
	end

	local var_2_2 = self._playerData.user

	if self._playerData.isRobot then
		self.m_picComp:setIcon(g.core.common.Path:getKnightPicRes(g.core.config.robot_info.get(var_2_2.id).res_id))
	else
		local var_2_5 = g.core.config.knight_info.get(var_2_2.base_id)
		local var_2_6 = var_2_5.res_id

		if var_2_2.dress_id and var_2_2.dress_id > 0 then
			var_2_6 = var_2_5.sex == 0 and g.core.config.dress_info.get(var_2_2.dress_id).woman_res_id or g.core.config.dress_info.get(var_2_2.dress_id).man_res_id
		end

		if var_2_2.show_knight_id then
			local var_2_7 = var_2_2.show_knight_id or 0

			if var_2_7 == 0 then
				var_2_7 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_KNIGHT_ID).parameter
			end

			if var_2_7 and var_2_7 > 0 then
				local var_2_8 = g.core.config.knight_base_info.get(g.core.config.knight_info.get(var_2_7).res_id)

				if var_2_8 and var_2_8.painted_id then
					var_2_6 = var_2_8.painted_id
				end
			end
		end

		self.m_picComp:setIcon(g.core.common.Path:getKnightBookPicRes(var_2_6))
	end

	self.m_playerNameText:setText(var_2_1.name)
	self.m_scoreText:setText(var_2_1.score)
	self.m_lifeLeftController:setSelectedIndex(0)

	if self._playerData.left > 0 and self._playerData.left <= 3 then
		self.m_lifeLeftController:setSelectedIndex(self._playerData.left)
	end

	self.m_fightValueText:setText(self._playerData.fightValue)
end

function GuildFightNormalChooseCell:_onTouchClick()
	local var_3_0

	if self._playerData.left <= 0 then
		var_3_0 = g.core.lang:get(109807)
	elseif not var_0_0:canFight() then
		var_3_0 = g.core.lang:get(1073)
	end

	if var_3_0 then
		g.core.module.ModuleManager:tip(var_3_0)
	else
		g.core.module.ModuleManager:pushPopup(require("app.view.module.guildFight.view.GuildFightBattleReadyPop").new(self._playerData), {
			hideContinue = true,
			touchDisappear = true
		})
	end
end

return GuildFightNormalChooseCell
