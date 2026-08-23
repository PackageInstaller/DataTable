local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.model.User.resourceData
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.common.Goods
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum
local CrossServerArenaSkillPop = class("CrossServerArenaSkillPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaSkillPop"), function()
	return fgui.GComponent:create({
		resName = "CrossServerArenaSkillPop",
		pkgPath = "ui/crossServerArena/crossServerArena",
		pkgName = "crossServerArena"
	})
end)

function CrossServerArenaSkillPop:ctor()
	self:showAtCenter()
	self.m_skillList:setIniter()
	self.m_skillList:setItemRenderer(handler(self, self._rendererSkillItem))
	self:addListen(self.m_skillList)

	self._skillData = var_0_0:getSkillList()
	self._changeItemIndex = 1

	self:_updateView()
end

function CrossServerArenaSkillPop:_updateView()
	self._changeItemIndex = -1

	self.m_skillList:setNumItems(#self._skillData)
	self:_updateTotalSkillAttr()
end

function CrossServerArenaSkillPop:_updateTotalSkillAttr()
	for iter_4_0 = 1, #self._skillData do
		local var_4_0 = var_0_0:getAttrValByTalentId(self._skillData[iter_4_0].info.talent_skill_id)

		self["m_attrComp" .. iter_4_0]:getChild("nameTitle"):setText(self._skillData[iter_4_0].info.name)
		self["m_attrComp" .. iter_4_0]:setTitle("+" .. var_4_0)
	end
end

function CrossServerArenaSkillPop:onLoad()
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_CHIEF_ARENA_GUILDSKILL, self._updateView, self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_CHIEF_ARENA_SKILLLEVELUP, self._onRcvSkillLevelUp, self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_RFRESH_RESOURCE, self._onRcvRefreshResource, self)
	var_0_2:send_C2S_ChiefArena_GuildSkill({})
	var_0_2:send_C2S_RfreshResource({
		id = var_0_3.RESOURCE.TYPE_CHIEF_ARENA_SKILL
	})
end

function CrossServerArenaSkillPop:receiveCompEvent(arg_6_1, arg_6_2)
	if arg_6_1 == "CrossServerArenaSkillCell_ChangeState" then
		self._changeItemIndex = arg_6_2.index or -1

		self.m_skillList:setNumItems(#self._skillData)
	end
end

function CrossServerArenaSkillPop:_rendererSkillItem(arg_7_1, arg_7_2)
	arg_7_2:updateCell({
		data = self._skillData[arg_7_1 + 1],
		index = arg_7_1,
		changeIndex = self._changeItemIndex
	})
end

function CrossServerArenaSkillPop:_onRcvGetSkillInfo()
	self:_updateView()
end

function CrossServerArenaSkillPop:_onRcvSkillLevelUp(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0

	if arg_9_3.ret ~= g.core.network.proto.RET_OK and arg_9_3.ret ~= g.core.network.proto.RET_CHIEF_ARENA_GUILD_SKILL_LEVEL_MAX then
		do return end

		var_9_0 = {}
	end

	var_9_0.name = var_0_0:getSkillInfoByGroup(arg_9_3.skill.group).info.name

	g.core.module.ModuleManager:tip(g.core.lang:get(411035, var_9_0))
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

function CrossServerArenaSkillPop:_onRcvRefreshResource()
	self.m_resComp:updateByTVS({
		showHave = true,
		type = var_0_3.TYPE_RESOURCE,
		value = var_0_3.RESOURCE.TYPE_CHIEF_ARENA_SKILL,
		size = var_0_1:getChiefArenaScore()
	})
end

return CrossServerArenaSkillPop
