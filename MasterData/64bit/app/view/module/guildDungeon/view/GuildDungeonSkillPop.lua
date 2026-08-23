local GuildDungeonSkillPop = class("GuildDungeonSkillPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonSkillPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildDungeon/guildDungeon",
		resName = "GuildDungeonSkillPop",
		pkgName = "guildDungeon"
	})
end)
local var_0_1 = g.core.model.User.guildDungeonData
local var_0_2 = g.core.model.User.resourceData
local var_0_3 = g.core.network.GameNetProxy
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.const.ConstMgr.GuildDungeonConst.SKILL_NUM

function GuildDungeonSkillPop:ctor()
	self._skillData = {}
	self._changeItemIndex = 1

	self:_initComp()
	self:_addListener()
end

function GuildDungeonSkillPop:onLoad()
	self:_addNetWorkListener()
end

function GuildDungeonSkillPop:_initComp()
	self:_initData()
	self:_initUI()
end

function GuildDungeonSkillPop:_initData()
	return
end

function GuildDungeonSkillPop:_initUI()
	self:showAtCenter()
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._rendererSkillItem))
	self:addListen(self.m_skillList)
end

function GuildDungeonSkillPop:_addListener()
	return
end

function GuildDungeonSkillPop:_addNetWorkListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETSKILLINFO, self._onRcvGetSkillInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_SKILLLEVELUP, self._onRcvSkillLevelUp, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RFRESH_RESOURCE, self._onRcvRefreshResource, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	var_0_3:send_C2S_GuildDungeon_GetSkillInfo({})
	var_0_3:send_C2S_RfreshResource({
		id = var_0_4.RESOURCE.TYPE_GUILD_SCORE
	})
end

function GuildDungeonSkillPop:_onCrossDay()
	if g.core.common.ServerTime:getWeekDay() == 1 then
		self:removeSelf()
	end
end

function GuildDungeonSkillPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "GuildDungeonSkillCell_ChangeState" then
		self._changeItemIndex = arg_10_2.index or -1

		self.m_skillList:setNumItems(var_0_5)
	end
end

function GuildDungeonSkillPop:_updateView()
	self._changeItemIndex = -1

	self.m_skillList:setNumItems(var_0_5)
	self:_updateTotalSkillAttr()
end

function GuildDungeonSkillPop:_updateTotalSkillAttr()
	for iter_12_0 = 1, var_0_5 do
		self["m_attrComp" .. iter_12_0]:setTitle("+" .. var_0_1:getAttrValByTalentId(self._skillData[iter_12_0].info.talent_skill_id))
	end
end

function GuildDungeonSkillPop:_rendererSkillItem(arg_13_1, arg_13_2)
	arg_13_2:updateCell({
		data = self._skillData[arg_13_1 + 1],
		index = arg_13_1,
		changeIndex = self._changeItemIndex
	})
end

function GuildDungeonSkillPop:_onRcvGetSkillInfo()
	self._skillData = var_0_1:getSkillList()

	self:_updateView()
end

function GuildDungeonSkillPop:_onRcvSkillLevelUp(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	if arg_15_3.ret ~= g.core.network.proto.RET_OK then
		var_0_3:send_C2S_RfreshResource({
			id = var_0_4.RESOURCE.TYPE_GUILD_SCORE
		})

		do return end

		var_15_0 = {
			num = arg_15_3.score
		}
	end

	var_15_0.name = var_0_1:getSkillInfoById(arg_15_3.cur_skill_id).info.name

	g.core.module.ModuleManager:tip(g.core.lang:get(1129, var_15_0))

	self._skillData = var_0_1:getSkillList()

	self.m_resComp:updateHaveNum()

	if self._changeItemIndex >= 0 then
		self:_updateTotalSkillAttr()
		self.m_skillList:getChildAt(self._changeItemIndex):updateCell({
			data = self._skillData[self._changeItemIndex + 1],
			index = self._changeItemIndex,
			changeIndex = self._changeItemIndex
		})
	end
end

function GuildDungeonSkillPop:_onRcvRefreshResource()
	self.m_resComp:updateByTVS({
		showHave = true,
		type = var_0_4.TYPE_RESOURCE,
		value = var_0_4.RESOURCE.TYPE_GUILD_SCORE,
		size = var_0_2:getGuildDungeonScore()
	})
end

return GuildDungeonSkillPop
