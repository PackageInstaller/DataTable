local var_0_0 = g.core.model.User.GuildFightData
local GuildFightBattleReadyPop = class("GuildFightBattleReadyPop", require("app.fairyGUI.guildFight.UI_GuildFightBattleReadyPop"), function()
	return fgui.GComponent:create({
		resName = "GuildFightBattleReadyPop",
		pkgName = "guildFight",
		isFullScreen = true,
		pkgPath = "ui/guildFight/guildFight"
	}, ...)
end)

function GuildFightBattleReadyPop:ctor(arg_2_1)
	self._playerData = arg_2_1

	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
	self.m_challengeBtn:addClickListener(handler(self, self._onClickChallenge))
	self.m_closePanel:addClickListener(handler(self, self._onClickClosePanel))
end

function GuildFightBattleReadyPop:onLoad()
	if not var_0_0:isNormal() then
		g.core.module.ModuleManager:popComponent()

		return
	end

	if not self._playerData then
		return
	end

	self:_updateView()
	self.m_enterTransition:play()
end

function GuildFightBattleReadyPop:_updateView()
	local var_4_0 = var_0_0:getScoreInfoById((var_0_0:getPlayerIdByData(self._playerData)))
	local var_4_1

	if self._playerData.isRobot then
		var_4_1 = {
			resId = tonumber(g.core.config.robot_info.get(self._playerData.user.id).res_id)
		}
	else
		var_4_1 = {
			baseId = tonumber(self._playerData.user.base_id)
		}

		if self._playerData.user.show_knight_id then
			local var_4_2 = self._playerData.user.show_knight_id or 0

			if var_4_2 == 0 then
				var_4_2 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_KNIGHT_ID).parameter
			end

			if var_4_2 and var_4_2 > 0 then
				local var_4_3 = g.core.config.knight_base_info.get(g.core.config.knight_info.get(var_4_2).res_id)

				if var_4_3 and var_4_3.painted_id then
					var_4_1 = {
						resId = var_4_3.painted_id
					}
				end
			end
		end
	end

	self.m_knightPicComp:updateKnight(var_4_1)
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
	self.m_nameText:setText(var_4_0.name)
	self.m_fightValueText:setText(self._playerData.fightValue)
	self.m_contributeText:setText("x" .. g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILDFIGHT_CONTRIBUTE).parameter)
	self.m_scoreText:setText("x" .. var_4_0.score)

	local var_4_4 = string.split(var_4_0.talk, ",")
	local var_4_6

	if #var_4_4 == 1 then
		var_4_6 = var_4_4[1]
	elseif #var_4_4 > 1 then
		var_4_6 = var_4_4[math.random(1, #var_4_4)]
	end

	self.m_descText:setText((var_4_6 or nil) and g.core.config.guild_talk_info.get(tonumber(var_4_6)).talk)
	self.m_fightValueColorController:setSelectedIndex(0)

	if self._playerData.fightValue > g.core.model.User:getFightValue() then
		self.m_fightValueColorController:setSelectedIndex(1)
	end

	local var_4_7 = self._playerData.left

	self.m_lifeLeftController:setSelectedIndex(0)

	if var_4_7 > 0 and var_4_7 <= 3 then
		self.m_lifeLeftController:setSelectedIndex(var_4_7)
	end

	self:_refreshLeftCount()
end

function GuildFightBattleReadyPop:_refreshLeftCount()
	self.m_countLable:updateInfo((var_0_0:getLeftTimes()))
end

function GuildFightBattleReadyPop:_onClickChallenge()
	self:dispatchCompEvent("guildFight_begin_challenge", {
		type = 1,
		index = self._playerData.index
	})
end

function GuildFightBattleReadyPop:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function GuildFightBattleReadyPop:_onClickClosePanel()
	if self.m_backTransition and not self._isClosed then
		self._isClosed = true

		self.m_backTransition:play(handler(self, function()
			g.core.module.ModuleManager:popModule()
		end))
	end
end

return GuildFightBattleReadyPop
