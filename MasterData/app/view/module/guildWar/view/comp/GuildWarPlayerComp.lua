local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local GuildWarPlayerComp = class("GuildWarPlayerComp", require("app.fairyGUI.guildWar.UI_GuildWarPlayerComp"))

function GuildWarPlayerComp:ctor()
	self._userStruct = nil
	self._maxHp = 0
	self._curHp = 0
	self._position = 0
	self._buildId = 0

	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function GuildWarPlayerComp:onLoad()
	return
end

function GuildWarPlayerComp:_onTouchBegin(arg_3_1)
	arg_3_1:stopPropagation()
end

function GuildWarPlayerComp:setPosAndBuildId(arg_4_1, arg_4_2)
	self._position = arg_4_1
	self._buildId = arg_4_2

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			buildId = arg_4_2,
			pos = arg_4_1
		}
	})
end

function GuildWarPlayerComp:getPosAndBuildId()
	return self._position, self._buildId
end

function GuildWarPlayerComp:setPlayer(arg_6_1)
	if not var_0_0:isCurMineStation() then
		self.m_userIcon:setTouchable(false)
	else
		self.m_userIcon:setTouchable(true)
	end

	self._userData = arg_6_1

	if not arg_6_1 then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
		self.m_userIcon:updateAsUser(arg_6_1)
		self.m_userIcon:setTouchCallFunc(handler(self, self.onUserIconClick))

		if self:getChild("nameTxt") then
			self:getChild("nameTxt"):setText(arg_6_1.name)
			self:getChild("fightValueTxt"):setText(arg_6_1.fight_value)
		end
	end
end

function GuildWarPlayerComp:onUserIconClick()
	return
end

function GuildWarPlayerComp:setUserStruct(arg_8_1)
	self._userStruct = arg_8_1

	self.m_isMineController:setSelectedIndex(1)

	if var_0_0:getCurWatchGuildId() == var_0_0:getMyGuildId() and var_0_0:isLeader() and var_0_0:getFightStageType() == var_0_1.DEPLOY then
		self.m_isMineController:setSelectedIndex(0)
	end

	if not arg_8_1 then
		return
	end

	self:setMaxHp(self._userStruct:getMaxHp())
	self:setCostHp(self._userStruct:getCostHp())
	self:setPlayer(self._userStruct:getUser())

	if self._userData and not self._userStruct:isAlive() then
		self.m_stateController:setSelectedIndex(2)
	end
end

function GuildWarPlayerComp:setEmpty()
	self._userStruct = nil
	self._maxHp = 0
	self._curHp = 0
	self._position = 0
	self._buildId = 0

	self.m_stateController:setSelectedIndex(0)
	self.m_isMineController:setSelectedIndex(1)

	if var_0_0:getCurWatchGuildId() == var_0_0:getMyGuildId() and var_0_0:isLeader() and var_0_0:getFightStageType() == var_0_1.DEPLOY then
		self.m_isMineController:setSelectedIndex(0)
	end
end

function GuildWarPlayerComp:setMaxHp(arg_10_1)
	self._maxHp = arg_10_1
end

function GuildWarPlayerComp:setCostHp(arg_11_1)
	self._curHp = self._maxHp - arg_11_1

	self.m_hpProgress:setProgress(self._curHp, self._maxHp)
end

function GuildWarPlayerComp:setInDrag(arg_12_1)
	if arg_12_1 then
		self.m_stateController:setSelectedIndex(0)
	elseif not self._userData then
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

function GuildWarPlayerComp:getUserData()
	return self._userStruct
end

return GuildWarPlayerComp
