local var_0_1 = g.core.config.gve_task_group_info
local var_0_2 = g.core.const.ConstMgr.GveConst.TASK_RECEIVE_STATUS
local var_0_3 = g.core.model.User.gveDataMgr
local var_0_4 = g.core.model.User.gveDataMgr:getGveTaskData()
local var_0_5 = {
	T1 = cc.c3b(126, 126, 126),
	T2 = cc.c3b(2, 79, 128),
	T3 = cc.c3b(2, 46, 128),
	T4 = cc.c3b(64, 2, 128),
	T5 = cc.c3b(128, 112, 2),
	T6 = cc.c3b(128, 61, 2),
	T7 = cc.c3b(128, 2, 58),
	T8 = cc.c3b(128, 2, 2)
}
local GveTaskLayer = class("GveTaskLayer", require("app.fairyGUI.gve.UI_GveTaskLayer"), function()
	return fgui.GComponent:create({
		resName = "GveTaskLayer",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	}, ...)
end)

function GveTaskLayer:ctor()
	var_0_4 = var_0_3:getGveTaskData()
	self._completeMaxChapterId = 0
	self._showChapterId = 0
	self._taskList = {}
	self._havePreChapter = false
	self._haveLastChapter = false
	self._chapterRewardStatus = var_0_2.CAN_NOT_RECEIVE
	self._spineNode = nil

	self.m_enterTransition:play()
	self:_initView()
end

function GveTaskLayer:_initView()
	self:addBg("bg/gve/bg_rw_jiemianxinxi.jpg")
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.GVE_TASK_LAYER)
	self.m_taskList:setVirtual(self)
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
	self.m_leftBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickLeftBtn))
	self.m_rightBtn:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickRightBtn))
	self.m_bigRewardIcon:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickBigReward))
end

function GveTaskLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_TASKGETINFO, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_TASKAWARD, self._onRecTaskReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_CHAPTERAWARD, self._onRecChapterReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, handler(self, self._onGoToTargetPos), self)
	self:updateView()
end

function GveTaskLayer:updateView()
	local var_5_0 = var_0_4:getMaxCompleteChapterId()
	local var_5_1, var_5_2 = var_0_4:isHaveNextChapter(var_5_0)

	self._showChapterId = var_5_1 and var_5_2 or var_5_0

	local var_5_3, var_5_4 = var_0_4:isHaveNextChapter(self._showChapterId)

	self._havePreChapter, self._haveLastChapter = var_0_4:isHavePreChapter(self._showChapterId), var_5_3

	self:updateChapterView()
	self:updatePrivilegeInfo()
end

function GveTaskLayer:_onGoToTargetPos(arg_6_1, arg_6_2, arg_6_3)
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, false, arg_6_3)
	end, 0)
end

function GveTaskLayer:updateChapterView()
	self._taskList = var_0_4:getTaskByChapterId(self._showChapterId)

	self.m_taskList:setNumItems(#self._taskList)
	self.m_taskList:transitionShowCells("listCrossbandAUiRightIn", 0.03)

	local var_8_0 = var_0_1.get(self._showChapterId)

	self.m_knightPicComp:updateKnight({
		resId = var_8_0.res
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 250)
	self.m_titleIcon:setURL("ui://gve/" .. var_8_0.name_res)
	self.m_titleName:setText(var_8_0.name)
	self.m_titleName:setColor(g.core.common.Color.A6)

	if var_0_5[var_8_0.name_outline] then
		self.m_titleName:enableOutline(1, var_0_5[var_8_0.name_outline])
	end

	self.m_chapterNameText1:setText(var_8_0.title_name)
	self.m_chapterNameText2:setText(var_8_0.title_name)

	local var_8_1 = var_0_4:getMaxCompleteChapterId()

	if ((var_8_1 ~= 0 or nil) and var_0_1.get(var_8_1).next_id) == 0 then
		self.m_completeStatusController:setSelectedIndex(3)
	elseif self._showChapterId == var_8_1 + 1 then
		self.m_completeStatusController:setSelectedIndex(1)
	elseif self._showChapterId < var_8_1 + 1 then
		self.m_completeStatusController:setSelectedIndex(0)
	elseif self._showChapterId > var_8_1 + 1 then
		self.m_completeStatusController:setSelectedIndex(2)
	end

	local var_8_3 = var_0_4:getNewPrivilege(self._showChapterId)

	if #var_8_3 <= 0 then
		self.m_showNewPrivilegeController:setSelectedIndex(0)
	else
		self.m_showNewPrivilegeController:setSelectedIndex(1)

		local var_8_4 = ""

		for iter_8_0 = 1, #var_8_3 do
			var_8_4 = var_8_4 .. " " .. g.core.utils.String.formatText(g.core.config.gve_privilege_info.get(var_8_3[iter_8_0].privilegeType).des, {
				num = var_8_3[iter_8_0].privilegeValue
			})
		end

		self.m_privilegeText:setText(var_8_4)
	end

	self.m_leftBtn:setVisible(self._havePreChapter)
	self.m_rightBtn:setVisible(self._haveLastChapter)

	local var_8_5 = var_0_4:getTaskByChapterId(self._showChapterId)
	local var_8_6 = var_0_4:getCompleteTaskByChapterId(self._showChapterId)

	self.m_progress:setPercent({
		cur = #var_8_6,
		max = #var_8_5
	})
	self.m_progressText:setText(math.floor(#var_8_6 / #var_8_5 * 100) .. "%")
	self:updateChapterRewardView()
end

function GveTaskLayer:updateChapterRewardView()
	local var_9_0 = var_0_4:getChapterStatus(self._showChapterId)
	local var_9_1 = var_0_1.get(self._showChapterId).level

	if var_9_1 < 1 or var_9_1 > 5 then
		-- block empty
	end

	self._chapterRewardStatus = var_9_0

	self:removeEffect()
	self.m_bigRewardIcon:setURL("ui://gve/" .. var_0_1.get(self._showChapterId).box_res)

	if self._chapterRewardStatus == var_0_2.CAN_NOT_RECEIVE then
		self.m_bigRewardIcon:setGrayed(true)
	elseif self._chapterRewardStatus == var_0_2.CAN_RECEIVE then
		self._spineNode = self.m_effReward:addEffectSpine({
			remove = false,
			name = "eff_ui_gve_box128",
			isLoop = true
		})

		self.m_bigRewardIcon:setGrayed(false)
	elseif self._chapterRewardStatus == var_0_2.HAVE_RECEIVED then
		self.m_bigRewardIcon:setGrayed(true)
	end
end

function GveTaskLayer:removeEffect()
	if self._spineNode then
		self._spineNode:removeFromParent()

		self._spineNode = nil
	end
end

function GveTaskLayer:updatePrivilegeInfo()
	local var_11_0 = var_0_4:getPrivilegeByChapterId((var_0_4:getMaxCompleteChapterId()))

	if #var_11_0 > 0 then
		self.m_privilegeStatusController:setSelectedIndex(1)
		self.m_privilegeComp:updateView(var_11_0)
	else
		self.m_privilegeStatusController:setSelectedIndex(0)
	end
end

function GveTaskLayer:_onRecTaskReward(arg_12_1, arg_12_2, arg_12_3)
	self:updateChapterView()
	self:updatePrivilegeInfo()
	g.core.module.ModuleManager:awardSummary(arg_12_3.awards)
end

function GveTaskLayer:_onRecChapterReward(arg_13_1, arg_13_2, arg_13_3)
	g.core.module.ModuleManager:awardSummary(arg_13_3.awards)
	self:updateChapterRewardView()
end

function GveTaskLayer:_onTaskItemRender(arg_14_1, arg_14_2)
	arg_14_2:updateView(self._taskList[arg_14_1 + 1], self._showChapterId)
end

function GveTaskLayer:_onClickLeftBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Switch_Paper)

	if not self._havePreChapter then
		return
	end

	local var_15_0, var_15_1 = var_0_4:isHavePreChapter(self._showChapterId)

	self._showChapterId = var_15_1
	self._havePreChapter, self._haveLastChapter = var_0_4:isHavePreChapter(self._showChapterId), var_0_4:isHaveNextChapter(self._showChapterId)

	self:updateChapterView()
	self.m_enterTransition:play()
end

function GveTaskLayer:_onClickRightBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Switch_Paper)

	if not self._haveLastChapter then
		return
	end

	local var_16_0, var_16_1 = var_0_4:isHaveNextChapter(self._showChapterId)

	self._showChapterId = var_16_1
	self._havePreChapter, self._haveLastChapter = var_0_4:isHavePreChapter(self._showChapterId), var_0_4:isHaveNextChapter(self._showChapterId)

	self:updateChapterView()
	self.m_enterTransition:play()
end

function GveTaskLayer:_onClickBigReward()
	local var_17_0 = {
		chapterId = self._showChapterId,
		chapterRewardStatus = self._chapterRewardStatus
	}

	if self._chapterRewardStatus == var_0_2.CAN_NOT_RECEIVE then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveTask.GveTaskAwardPop").new(var_17_0), {
			hideContinue = true
		})
	elseif self._chapterRewardStatus == var_0_2.CAN_RECEIVE then
		g.core.network.GameNetProxy:send_C2S_GVE_ChapterAward({
			id = self._showChapterId
		})
	elseif self._chapterRewardStatus == var_0_2.HAVE_RECEIVED then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveTask.GveTaskAwardPop").new(var_17_0), {
			hideContinue = true
		})
	end
end

return GveTaskLayer
