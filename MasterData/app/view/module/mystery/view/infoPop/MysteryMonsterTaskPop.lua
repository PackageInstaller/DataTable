local var_0_0 = g.core.model.User.mysteryData
local var_0_1 = g.core.const.ConstMgr.MysteryConst
local MysteryMonsterTaskPop = class("MysteryMonsterTaskPop", require("app.fairyGUI.mystery.UI_MysteryMonsterTaskPop"), function()
	return fgui.GComponent:create({
		resName = "MysteryMonsterTaskPop",
		pkgPath = "ui/mystery/mystery",
		pkgName = "mystery"
	}, ...)
end)

function MysteryMonsterTaskPop:ctor()
	self:showAtCenter()
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabItemRenderer))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
	self:addListen(self.m_taskList)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_PopUp_Small)
end

function MysteryMonsterTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD, self._onS2CMysteryMainAward, self)

	self._chapters = var_0_0:getAllChapterList()
	self._chapterId = var_0_0:getCurChapterId()

	self.m_tabList:setNumItems(#self._chapters)
	self.m_tabList:setSelectedIndex(self._chapterId - 1)
	self:_updateTaskView()
end

function MysteryMonsterTaskPop:_onTabItemRenderer(arg_4_1, arg_4_2)
	local var_4_0 = self._chapters[arg_4_1 + 1]:getChapterConfig()

	arg_4_2:setTitle(var_4_0.name)

	local var_4_1 = arg_4_2:getChild("redPointComp")

	if var_4_1 then
		var_4_1:setId(802)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = var_4_1,
			customData = {
				chapterId = var_4_0.id
			}
		})
	end
end

function MysteryMonsterTaskPop:_onTabListClickItem()
	local var_5_0 = self.m_tabList:getSelectedIndex() + 1

	if var_5_0 == self._chapterId then
		return
	end

	self._chapterId = var_5_0

	self:_updateTaskView()
end

function MysteryMonsterTaskPop:_onTaskItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell(self._tasks[arg_6_1 + 1], self._curTaskId, arg_6_1 + 1)
end

function MysteryMonsterTaskPop:_updateTaskView()
	self._taskTypeDict = var_0_0:getChapterDataById(self._chapterId):getChapterTasks()
	self._tasks = self._taskTypeDict[var_0_1.TASK_TYPE.MAIN]
	self._curTaskId = self:_getCurTaskId()

	self.m_taskList:setNumItems(#self._tasks)
end

function MysteryMonsterTaskPop:_onS2CMysteryMainAward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
	self:_updateTaskView()
end

function MysteryMonsterTaskPop:receiveCompEvent(arg_9_1)
	local var_9_0 = {
		...
	}

	if arg_9_1 == "CELL_CLICK_GO" then
		if var_9_0[2] <= var_0_0:getLastUnlockChapterId() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_GOTO_TERMINUS, true, {
				var_9_0[1],
				var_9_0[2]
			})
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(423021))
		end
	end
end

function MysteryMonsterTaskPop:_getCurTaskId()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(self._tasks) do
		local var_10_1 = var_0_0:getTaskProgById(iter_10_1.id)

		if var_10_1 == nil or var_10_1.progress < iter_10_1.task_size then
			var_10_0 = iter_10_1.id

			break
		end

		var_10_0 = iter_10_1.id
	end

	return var_10_0
end

return MysteryMonsterTaskPop
