local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local CrossServerArenaContrastPop = class("CrossServerArenaContrastPop", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaContrastPop"), function()
	return fgui.GComponent:create({
		pkgName = "crossServerArena",
		isFullScreen = false,
		pkgPath = "ui/crossServerArena/crossServerArena",
		resName = "CrossServerArenaContrastPop"
	}, ...)
end)

function CrossServerArenaContrastPop:ctor(arg_2_1)
	self:showAtCenter()

	self._uid = arg_2_1.uid
	self._myList = {}
	self._rivalList = {}

	self.m_myAdditionList:setVirtual()
	self.m_myAdditionList:setItemRenderer(handler(self, self._onRenderMyList))
	self.m_rivalAdditionList:setVirtual()
	self.m_rivalAdditionList:setItemRenderer(handler(self, self._onRenderRivalList))
	self.m_myHaveController:setSelectedIndex(0)
	self.m_rivalHaveController:setSelectedIndex(0)
end

function CrossServerArenaContrastPop:_updateView()
	self._myList = var_0_0:getMySkillList()
	self._rivalList = var_0_0:getOtherSkill()

	local var_3_0 = #self._myList
	local var_3_1 = #self._rivalList

	self.m_myAdditionList:setNumItems(#self._myList)
	self.m_rivalAdditionList:setNumItems(var_3_1)
	self.m_myHaveController:setSelectedIndex(var_3_0 > 0 and 1 or 0)
	self.m_rivalHaveController:setSelectedIndex(var_3_1 > 0 and 1 or 0)
end

function CrossServerArenaContrastPop:_onRenderMyList(arg_4_1, arg_4_2)
	arg_4_2:setTitle(g.core.lang:get(411033, {
		name = self._myList[arg_4_1 + 1].name,
		num = self._myList[arg_4_1 + 1].affect_value_1 / 10
	}))
end

function CrossServerArenaContrastPop:_onRenderRivalList(arg_5_1, arg_5_2)
	arg_5_2:setTitle(g.core.lang:get(411033, {
		name = self._rivalList[arg_5_1 + 1].name,
		num = self._rivalList[arg_5_1 + 1].affect_value_1 / 10
	}))
end

function CrossServerArenaContrastPop:_onCrossDayUpdate()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function CrossServerArenaContrastPop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_OTHERGUILDSKILL, self._updateView, self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_CHIEF_ARENA_GUILDSKILL, self._updateView, self)

	if self._uid then
		g.core.network.GameNetProxy:send_C2S_ChiefArena_OtherGuildSkill({
			target_id = self._uid
		})
	end

	g.core.network.GameNetProxy:send_C2S_ChiefArena_GuildSkill({})
	self:_updateView()
end

return CrossServerArenaContrastPop
