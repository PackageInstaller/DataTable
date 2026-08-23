local var_0_0 = g.core.model.User.teamPvpData
local TeamPVPBattleHeadComp = class("TeamPVPBattleHeadComp", require("app.fairyGUI.teamPVP.UI_TeamPVPBattleHeadComp"))

function TeamPVPBattleHeadComp:updateHeadComp(arg_1_1)
	self.m_isBattleController:setSelectedIndex(1)

	local var_1_0 = arg_1_1 and arg_1_1.info
	local var_1_1 = var_0_0:getBattleReport()

	if not var_1_1 then
		return
	end

	if self.m_campController:getSelectedIndex() == 1 then
		local var_1_2 = var_1_1.enemyInfos.userInfos[var_1_0.user_id] or var_1_1.playerInfos.userInfos[var_1_0.user_id]

		if var_1_2 then
			self.m_headComp:updateAsUser(var_1_2)

			if var_1_2.robotName then
				self.m_nameTxt:setText(var_1_2.robotName)
			else
				self.m_nameTxt:setText(var_1_2.name)
			end
		end
	end
end

function TeamPVPBattleHeadComp:updateMatchHeadComp(arg_2_1)
	local var_2_0 = arg_2_1.battleUser
	local var_2_1 = arg_2_1.battleUser.play_num

	if arg_2_1.snapshot.id == g.core.model.User:getId() then
		var_2_1 = var_0_0:getChallengeNum()
	end

	self.m_isHelpController:setSelectedIndex(var_2_1 == 0 and 1 or 0)
	self.m_playNum:setText(g.core.lang:get(420444, {
		num = var_2_1
	}))

	if var_2_0.is_robot then
		self.m_nameTxt:setText(var_0_0:getRobotName(var_2_0.guid))
	else
		self.m_nameTxt:setText(arg_2_1.snapshot.name)
	end

	self.m_headComp:updateAsUser(arg_2_1.snapshot)
end

function TeamPVPBattleHeadComp:dodead()
	self.m_deadController:setSelectedIndex(1)
end

function TeamPVPBattleHeadComp:playFireIconEffect()
	self.m_effidle:removeAllEffect()
	self.m_effidle:addEffectSpine({
		anim = "idle",
		name = "eff_ui_teamPvp_iconFire",
		isLoop = true
	})
	self.m_effplay:removeAllEffect()
	self.m_effplay:addEffectSpine({
		anim = "play",
		name = "eff_ui_teamPvp_iconFire",
		isLoop = false
	})
end

return TeamPVPBattleHeadComp
