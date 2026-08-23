local var_0_0 = g.core.model.User.commanderWorldData
local CommanderWorldMainComp = class("CommanderWorldMainComp", require("app.fairyGUI.commanderWorld.UI_CommanderWorldMainComp"))

function CommanderWorldMainComp:ctor()
	self._maxLevel = var_0_0:getMaxLevel()

	self.m_bg:setURL("bg/commanderWorld/bg_haolingtianxia.jpg")
	self.m_sceneEff:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "commanderWorld"
	})
	self:playBallAnim()
end

function CommanderWorldMainComp:playBallAnim()
	local var_2_0 = (var_0_0:getHasGuildLvUpReward() or var_0_0:isMaxLevel()) and "full" or "empty"

	self.m_ballEff:removeAllEffect()
	self.m_ballEff:addEffectSpine({
		isLoop = true,
		name = "eff_ui_commanderworld_ball",
		anim = var_2_0
	})
end

function CommanderWorldMainComp:playBallFullAnim()
	self.m_ballEff:removeAllEffect()
	self.m_ballEff:addEffectSpine({
		isLoop = true,
		anim = "full",
		name = "eff_ui_commanderworld_ball"
	})
end

function CommanderWorldMainComp:playDonateAnim()
	self.m_bomEff:removeAllEffect()
	self.m_bomEff:addEffectSpine({
		isLoop = false,
		anim = "fillonce",
		name = "eff_ui_commanderworld_ballbom",
		eventHandler = handler(self, self._onDonateAnimEnd)
	})
end

function CommanderWorldMainComp:playPressDonateAnim()
	self.m_bomEff:removeAllEffect()
	self.m_bomEff:addEffectSpine({
		isLoop = false,
		anim = "fillthrice",
		name = "eff_ui_commanderworld_ballbom",
		eventHandler = handler(self, self._onDonateAnimEnd)
	})
end

function CommanderWorldMainComp:playPressEndAnim()
	self.m_bomEff:removeAllEffect()
	self.m_ballEff:addEffectSpine({
		isLoop = false,
		remove = true,
		anim = "fillbom",
		name = "eff_ui_commanderworld_ballbom"
	})
end

function CommanderWorldMainComp:_onDonateAnimEnd(arg_7_1)
	if arg_7_1.type == "complete" then
		self.m_bomEff:removeAllEffect()
	end
end

function CommanderWorldMainComp:playGetLevelUpRewardAnim()
	self.m_bomEff:removeAllEffect()
	self.m_bomEff:addEffectSpine({
		isLoop = true,
		anim = "fullbom",
		name = "eff_ui_commanderworld_ballbom",
		eventHandler = handler(self, self._playFullBom)
	})
end

function CommanderWorldMainComp:_playFullBom(arg_9_1)
	if arg_9_1.type == "event" then
		if arg_9_1.eventData and arg_9_1.eventData.name == "cut" then
			self:playBallFullAnim()
		end
	elseif arg_9_1.type == "complete" then
		g.core.network.GameNetProxy:send_C2S_OrderWorld_GuildAllAward({})
		self.m_bomEff:removeAllEffect()
		self.m_ballEff:removeAllEffect()
		self:playBallAnim()
	end
end

return CommanderWorldMainComp
