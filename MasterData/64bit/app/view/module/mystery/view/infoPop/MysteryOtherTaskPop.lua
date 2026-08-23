local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.model.User.mysteryData
local var_0_3 = g.core.const.ConstMgr.MysteryConst
local MysteryOtherTaskPop = class("MysteryOtherTaskPop", require("app.fairyGUI.mystery.UI_MysteryOtherTaskPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/mystery/mystery",
		resName = "MysteryOtherTaskPop",
		pkgName = "mystery"
	}, ...)
end)

function MysteryOtherTaskPop:ctor()
	self:showAtCenter()

	self._giveUpTaskId = 0
	self._chapterId = var_0_2:getCurChapterId()
	self._chapterData = var_0_2:getChapterDataById(self._chapterId)

	self.m_taskList:setIniter()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRenderer))
	self:addListen(self.m_taskList)
	self.m_touchArea:addClickListener(handler(self, self._onClickClose))
	self:_addKnightComp()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Wuzhuang_GetMenuSlide)
end

function MysteryOtherTaskPop:_addKnightComp()
	self._tasks = self._chapterData:getChapterTasks()[var_0_3.TASK_TYPE.DAILY]
	self._knightSpine = DrawKnight.new({
		scale = 1,
		isShowBg = true,
		isAlphaNode = true,
		resId = g.core.config.knight_base_info.get(self._chapterData:getTaskNpcCfg().knight_base).painted_id
	})

	self._knightSpine:setAlphaRect(var_0_1.MASK_TYPE.HORIZON, cc.rect(-250, 0, 400, 0), 250)
	self.m_knightComp:addChild(self._knightSpine)
end

function MysteryOtherTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_ACCEPTTASK, self._updateTaskView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_GIVEUPTASK, self._onS2CMysteryGiveUpTask, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MYSTERY_AWARD, self._onS2CMysteryAward, self)
	self:_updateTaskView()
end

function MysteryOtherTaskPop:_updateTaskView()
	if not self._tasks then
		return
	end

	self.m_taskList:setNumItems(#self._tasks)
end

function MysteryOtherTaskPop:_onS2CMysteryGiveUpTask()
	if self._giveUpTaskId > 0 then
		var_0_2:setTaskProgress(self._giveUpTaskId)

		self._giveUpTaskId = 0

		self:_updateTaskView()
	end
end

function MysteryOtherTaskPop:_onS2CMysteryAward(arg_7_1, arg_7_2, arg_7_3)
	g.core.module.ModuleManager:awardSummary(arg_7_3.awards)
	self:_updateTaskView()
end

function MysteryOtherTaskPop:_onTaskItemRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._tasks[arg_8_1 + 1])
end

function MysteryOtherTaskPop:receiveCompEvent(arg_9_1)
	local var_9_0 = {
		...
	}

	if arg_9_1 == "CELL_CLICK_GO" then
		if var_9_0[2] <= var_0_2:getLastUnlockChapterId() then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MYSTERY_GOTO_TERMINUS, true, {
				var_9_0[1],
				var_9_0[2]
			})
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(423021))
		end
	elseif arg_9_1 == "GIVE_UP_TASK_ID" then
		self._giveUpTaskId = var_9_0[1] or 0

		g.core.network.GameNetProxy:send_C2S_Mystery_GiveUpTask({})
	end
end

function MysteryOtherTaskPop:_onClickClose()
	if self._isClosing then
		return
	end

	self._isClosing = true

	for iter_10_0, iter_10_1 in ipairs((self.m_taskList:getChildren())) do
		iter_10_1:hideKnightVisible()
	end

	self.m_backTransition:play(handler(self, self._onClose))
end

function MysteryOtherTaskPop:_onClose()
	self._isClosing = false

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return MysteryOtherTaskPop
