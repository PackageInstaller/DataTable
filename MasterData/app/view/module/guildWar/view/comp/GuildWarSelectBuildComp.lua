local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local GuildWarSelectBuildComp = class("GuildWarSelectBuildComp", require("app.fairyGUI.guildWar.UI_GuildWarSelectBuildComp"))

function GuildWarSelectBuildComp:ctor()
	self.m_userIcon:setTouchable(false)
end

function GuildWarSelectBuildComp:updateUserSelectComp(arg_2_1)
	if not arg_2_1 or not arg_2_1:getUser() then
		if var_0_0:isLeader() and var_0_0:getFightStageType() == var_0_1.DEPLOY then
			self.m_emptyController:setSelectedIndex(0)
		else
			self.m_emptyController:setSelectedIndex(2)
		end
	else
		self.m_emptyController:setSelectedIndex(1)

		local var_2_0 = arg_2_1:getUser()

		self.m_userIcon:updateAsUser(var_2_0)
		self.m_hpProgress:setProgress(arg_2_1:getMaxHp() - arg_2_1:getCostHp(), arg_2_1:getMaxHp())
		self.m_nameTxt:setText(var_2_0.name)
		self.m_fightValueTxt:setText(var_2_0.fight_value)
	end
end

function GuildWarSelectBuildComp:updateAsMemberData(arg_3_1)
	if arg_3_1 then
		self.m_emptyController:setSelectedIndex(1)
		self.m_userIcon:updateAsUser(arg_3_1.user)
		self.m_nameTxt:setText(arg_3_1.user.name)
		self.m_fightValueTxt:setText(arg_3_1.user.fight_value)
		self.m_hpProgress:setProgress(100, 100)
	elseif var_0_0:isLeader() and var_0_0:getFightStageType() == var_0_1.DEPLOY then
		self.m_emptyController:setSelectedIndex(0)
	else
		self.m_emptyController:setSelectedIndex(2)
	end
end

return GuildWarSelectBuildComp
