local var_0_0 = g.core.model.User.commanderWorldData
local CommanderWorldProgComp = class("CommanderWorldProgComp", require("app.fairyGUI.commanderWorld.UI_CommanderWorldProgComp"))

function CommanderWorldProgComp:ctor()
	self._level = 0
	self._maxScore = 0
	self._curScore = var_0_0:getMyGuildScore()
	self._curLevel = var_0_0:getMyGuildLevel()
	self._guildId = g.core.model.User:getGuildId()
	self.m_boxEff = self.m_boxIcon:getChild("boxEff")

	self.m_boxIcon:addClickListener(handler(self, self._onClickBoxIcon))
end

function CommanderWorldProgComp:setNoGuildView()
	self.m_hasGuildController:setSelectedIndex(self._guildId > 0 and 1 or 0)

	if self._guildId == 0 then
		self.m_progTxt:setText("--/--")
		self.m_progBar:setMax(0)
		self.m_progBar:setValue(0)
		self.m_forgeNumTxt:setText((var_0_0:getGuildLevelName(0)))
	end

	self.m_tipTxt:setVisible(self._guildId == 0)
end

function CommanderWorldProgComp:setProgress(arg_3_1)
	if not arg_3_1 or self._guildId == 0 then
		return
	end

	local var_3_0 = arg_3_1.level or 0

	self.m_forgeNumTxt:setText((var_0_0:getGuildLevelName(var_3_0)))

	local var_3_1 = arg_3_1.score or 0
	local var_3_2 = var_0_0:getNextLevelUpScore(var_3_0)

	self.m_progTxt:setText(var_3_1 .. "/" .. var_3_2)
	self.m_progBar:setMax(var_3_2)
	self.m_progBar:setValue(var_3_1)

	if var_0_0:isMaxLevel() then
		self.m_progTxt:setText(g.core.lang:get(410321))
	end

	self:playHasAwardAnim()
end

function CommanderWorldProgComp:updateSvrProgress(arg_4_1)
	if self._guildId > 0 then
		self._curLevel = arg_4_1.level or 0
		self._curScore = arg_4_1.score or 0

		self:setProgress(arg_4_1)
	end
end

function CommanderWorldProgComp:updateProgress(arg_5_1, arg_5_2)
	if self._guildId > 0 then
		local var_5_0 = var_0_0:getNextLevelUpScore(self._curLevel)

		self._curScore = self._curScore + arg_5_1.addScore

		if var_5_0 <= self._curScore then
			self._curLevel = self._curLevel + 1
			self._curScore = self._curScore - var_5_0

			var_0_0:setNeedFullBom(true)
			g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Wuqi_Upgrade)
		end

		if arg_5_2 then
			self:setProgress({
				level = self._curLevel,
				score = self._curScore
			})
		end
	end
end

function CommanderWorldProgComp:_onClickBoxIcon()
	if self._guildId > 0 then
		if var_0_0:getTopGuildLevelAwardLevel() > 0 then
			self:dispatchCompEvent("receive_level_up_reward")
		else
			g.core.module.ModuleManager:pushPopup((require("app.view.module.commanderWorld.view.CommanderWorldForgeProgPop").new()))
		end
	end
end

function CommanderWorldProgComp:playHasAwardAnim()
	if var_0_0:getHasGuildLvUpReward() then
		self.m_boxEff:removeAllEffect()
		self.m_boxEff:addEffectSpine({
			anim = "play",
			name = "eff_ui_commanderworld_levelbox",
			isLoop = true
		})
	else
		self.m_boxEff:removeAllEffect()
	end
end

function CommanderWorldProgComp:_updateGuildId(arg_8_1)
	self._guildId = arg_8_1
end

function CommanderWorldProgComp:setCurLevel(arg_9_1)
	self._curLevel = arg_9_1 or 0
end

return CommanderWorldProgComp
