local GuildDungeonSkillCell = class("GuildDungeonSkillCell", require("app.fairyGUI.guildDungeon.UI_GuildDungeonSkillCell"))
local var_0_1 = g.core.model.User.guildDungeonData
local var_0_2 = g.core.model.User.resourceData
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.config.guild_dungeon_skill_info
local var_0_5 = g.core.common.Path

function GuildDungeonSkillCell:ctor()
	self._skillData = {}

	self:_initComp()
	self:_addListener()
end

function GuildDungeonSkillCell:onLoad()
	self:_addNetWorkListener()
end

function GuildDungeonSkillCell:_initComp()
	self:_initData()
	self:_initUI()
end

function GuildDungeonSkillCell:updateCell(arg_4_1)
	if arg_4_1 then
		self._skillData = arg_4_1.data or {}
	end

	self._index = arg_4_1.index or 0

	local var_4_0 = self._skillData.info

	self.m_nameTxt:setText(self._skillData.info.name)
	self.m_levelTxt:setText(var_4_0.level)
	self.m_skillIcon:setURL(var_0_5:getGuildDungeonSkillIcon(var_4_0.icon))
	self.m_skillIconBg:setURL(var_0_5:getGuildDungeonSkillIconBg(var_4_0.icon_bg))

	local var_4_1, var_4_2 = var_0_1:getAttrValByTalentId(var_4_0.talent_skill_id)
	local var_4_3 = g.core.lang:get(306014, {
		description = var_4_0.description,
		curVal = var_4_1
	})

	if var_4_0.next_id > 0 then
		if not arg_4_1.changeIndex or arg_4_1.changeIndex ~= self._index then
			self.m_stateController:setSelectedIndex(0)
		end

		local var_4_4, var_4_5 = var_0_1:getAttrValByTalentId(var_0_4.get(var_4_0.next_id).talent_skill_id)

		var_4_3 = g.core.lang:get(306015, {
			description = var_4_0.description,
			curVal = var_4_1,
			upValNum = tostring((var_4_5 - var_4_2) / 10)
		})

		local var_4_6 = var_0_2:getGuildDungeonScore()

		self.m_resComp:updateByTVS({
			showHave = true,
			type = var_0_3.TYPE_RESOURCE,
			value = var_0_3.RESOURCE.TYPE_GUILD_SCORE,
			size = var_4_6
		})
		self.m_subAddComp:initMinMaxNum({
			max = var_4_6
		})
	else
		self.m_stateController:setSelectedIndex(2)
	end

	self.m_descTxt:enableRich()
	self.m_descTxt:setText(var_4_3, true)
	self.m_progBar:setPercent({
		max = var_4_0.exp,
		cur = self._skillData.curExp
	})
end

function GuildDungeonSkillCell:_initData()
	return
end

function GuildDungeonSkillCell:_initUI()
	return
end

function GuildDungeonSkillCell:_addListener()
	self.m_touchComp:addClickListener(handler(self, self._onClickChangeState))
	self.m_stateChangeBtn:addClickListener(handler(self, self._onClickChangeState))
	self.m_levelUpBtn:addClickListener(handler(self, self._onClickLevelUp))
end

function GuildDungeonSkillCell:_addNetWorkListener()
	return
end

function GuildDungeonSkillCell:_onClickChangeState()
	local var_9_0 = self.m_stateController:getSelectedIndex()

	if var_9_0 == 0 then
		self.m_stateController:setSelectedIndex(1)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PAGE_OPEN_1)
	elseif var_9_0 == 1 then
		self.m_stateController:setSelectedIndex(0)
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.PAGE_CLOSE_1)
	end

	self:dispatchCompEvent("GuildDungeonSkillCell_ChangeState", {
		index = self._index
	})
end

function GuildDungeonSkillCell:_onClickLevelUp()
	local var_10_0

	if self._skillData.info.next_id == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(306012))

		return
	elseif var_0_2:getGuildDungeonScore() == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(306013))

		do return end

		var_10_0 = {
			type = self._skillData.info.type
		}
	end

	var_10_0.score = self.m_subAddComp:getCurNum()

	g.core.network.GameNetProxy:send_C2S_GuildDungeon_SkillLevelUp(var_10_0)
end

return GuildDungeonSkillCell
