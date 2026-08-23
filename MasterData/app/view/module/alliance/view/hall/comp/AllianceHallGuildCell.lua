local var_0_0 = g.core.common.Path
local var_0_2 = g.core.model.User.snapShotCacheData
local var_0_3 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_4 = g.core.model.User.allianceData
local var_0_5 = g.core.const.ConstMgr.AllianceConst
local AllianceMenuConfig = require("app.view.module.alliance.const.AllianceMenuConfig")
local AllianceHallGuildCell = class("AllianceHallGuildCell", require("app.fairyGUI.alliance.UI_AllianceHallGuildCell"))

function AllianceHallGuildCell:ctor()
	self._guildId = 0
	self._guildSnapshot = nil

	self.m_guildIcon:addClickListener(handler(self, self._onClickGuildIcon))
end

function AllianceHallGuildCell:updateGuildCell(arg_2_1)
	self._guildId = arg_2_1.guild_id

	self.m_gradeController:setSelectedIndex(var_0_5.GRADE.MEMBER)

	local var_2_0 = var_0_2:getSnapShot(var_0_3.SNAP_SHOT_KEY.GUILD, arg_2_1.guild_id)

	if var_2_0 then
		self._guildSnapshot = var_2_0

		self.m_guildIcon:setIcon(var_0_0:getGuildMidIconById(var_2_0.icon))

		local var_2_1 = {}

		var_2_1.level = var_2_0.level or 0

		self.m_level:setText(g.core.lang:get(109619, var_2_1))
		self.m_guildName:setText(var_2_0.name or "")
		self.m_serverName:setText(var_0_4:getGuildServerName(var_2_0))
		self.m_memberNum:getChild("numTxt"):setText(var_2_0.member_num or 0)
		self.m_power:getChild("numTxt"):setText(var_2_0.fight_value or 0)
		self.m_gradeController:setSelectedIndex((var_0_4:getGrade(var_2_0.id)))
	end

	self.m_todayContrib:getChild("numTxt"):setText(arg_2_1.daily_exp)
	self.m_totalContrib:getChild("numTxt"):setText(arg_2_1.total_exp)
end

function AllianceHallGuildCell:_onClickGuildIcon(arg_3_1)
	if not self._guildSnapshot then
		return
	end

	local var_3_0 = arg_3_1:getInput()

	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.hall.AllianceMenuPop").new({
		guildSnapshot = self._guildSnapshot,
		menuConfigs = AllianceMenuConfig.getShowButtonByGrade(var_0_4:getGradeByUid(g.core.model.User.guildData:getGuildData(), (g.core.model.User:getId())), g.core.model.User:getGuildId() == self._guildSnapshot.id, (var_0_4:getGrade(self._guildSnapshot.id))),
		worldPos = var_3_0:getPosition()
	}), {
		isUpdateBlack = false,
		hideContinue = true
	})
end

return AllianceHallGuildCell
