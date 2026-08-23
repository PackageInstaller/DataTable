local SpireChallengeMapComp = class("SpireChallengeMapComp", require("app.fairyGUI.spire.UI_SpireChallengeMapComp"))

function SpireChallengeMapComp:ctor()
	self._spine = nil
	self._bossEffect = nil
end

function SpireChallengeMapComp:updateMapComp(arg_2_1)
	if not arg_2_1:isBossStage() then
		local var_2_1 = arg_2_1:getCfg().stage

		self.m_title:setText(arg_2_1:getShowName())
		self.m_title:setOpacity(255)
		self.m_isBossController:setSelectedIndex(0)
	else
		self.m_isBossController:setSelectedIndex(1)

		self._bossEffect = self._bossEffect or self.m_effLoop:addEffectSpine({
			isLoop = true,
			anim = "loop",
			name = "eff_ui_spire_bossin"
		})
	end

	if arg_2_1:isPass() then
		if self._spine then
			self._spine:dispose()
		end

		self.m_title:setOpacity(0)
	else
		self:_updateShowSpine(arg_2_1:getShowSpineId())
	end
end

function SpireChallengeMapComp:_updateShowSpine(arg_3_1)
	if self._spine then
		self._spine:dispose()
	end

	self.m_spineNode:removeChildren()

	local var_3_0 = require("app.view.battle.BattleKnight").new({
		resId = arg_3_1
	})

	self.m_spineNode:addNode(var_3_0)

	self._spine = var_3_0
end

function SpireChallengeMapComp:playSpineAnim(arg_4_1, arg_4_2, arg_4_3)
	self._spine:setAnimation(arg_4_1, arg_4_2, arg_4_3)
end

function SpireChallengeMapComp:playMonsterDead()
	self:playSpineAnim(0, g.core.const.ConstMgr.SpineConst.ACTION.DEAD)
	self.m_fadeNameTransition:play()
end

function SpireChallengeMapComp:setBgLevel(arg_6_1)
	self.m_bgLoader:displayObject():setLocalZOrder(arg_6_1)
end

function SpireChallengeMapComp:getSpinePos()
	local var_7_0 = self:getParent():globalToLocal((self:localToGlobal(self.m_spineNode:getPosition())))

	var_7_0.x = var_7_0.x - 100

	return var_7_0
end

function SpireChallengeMapComp:setBossInAnimHook(arg_8_1, arg_8_2)
	self.m_bossInTransition:setHook(arg_8_1, arg_8_2)
end

function SpireChallengeMapComp:playBossInAnim(arg_9_1)
	self.m_effPlay:addEffectSpine({
		isLoop = false,
		remove = true,
		name = "eff_ui_spire_bossin"
	})

	if arg_9_1 then
		self.m_bossInTransition:play(arg_9_1)
	else
		self.m_bossInTransition:play()
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_Boss02)
end

return SpireChallengeMapComp
