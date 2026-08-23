local var_0_0 = g.core.model.User.guildData
local GuildRecommendCell = class("GuildRecommendCell", require("app.fairyGUI.guild.UI_GuildRecommendCell"))

function GuildRecommendCell:ctor(arg_1_1)
	self:addClickListener(handler(self, self._onClick))
	self.getSharedTrans(self, "listCardAUiScaleIn", "CombineBagList", self)
end

function GuildRecommendCell:updateInfo(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._guildData = arg_2_1.data or {}

	self.m_guildIcon:updateInfo({
		style = 1,
		data = self._guildData
	})
	self.m_title:setText(self._guildData.name)
	self.m_levelText:setText(g.core.lang:get(109619, {
		level = self._guildData.level
	}))

	local var_2_0 = var_0_0:getCfg(self._guildData.level)
	local var_2_1 = self._guildData.member_num or 0

	self.m_personNumText:setText(var_2_1 .. "/" .. var_2_0.number)
	self.m_isFullController:setSelectedIndex(var_2_1 == var_2_0.number and 1 or 0)
	self.m_fightValueText:setText(self._guildData.fight_value)

	local var_2_2 = self._guildData.apply_level or 0

	if g.core.model.User:getLevel() < self._guildData.apply_level then
		self.m_applyLevel:setText(g.core.lang:get(109502, {
			level = var_2_2
		}))
	else
		self.m_applyLevel:setText(g.core.lang:get(109503, {
			level = var_2_2
		}))
	end

	if self._guildData.alliance_id and self._guildData.alliance_id ~= 0 then
		self.m_hasAllianceController:setSelectedIndex(1)
		self.m_allianceName:setText(self._guildData.alliance_name)
	else
		self.m_hasAllianceController:setSelectedIndex(0)
		self.m_allianceName:setText(g.core.lang:get(109642))
	end
end

function GuildRecommendCell:_onClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_JOIN_HALL, {
		isShowApply = true,
		child = fgui.UIPackage:createObject("guild", "GuildJoinLeftComp"),
		guildType = g.core.const.ConstMgr.GuildCommonConst.guildType.OTHER_GUILD,
		guildId = self._guildData.id
	})
end

return GuildRecommendCell
