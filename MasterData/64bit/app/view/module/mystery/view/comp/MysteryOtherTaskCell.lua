local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = g.core.model.User.mysteryData
local var_0_2 = g.core.const.ConstMgr.MysteryConst
local MysteryOtherTaskCell = class("MysteryOtherTaskCell", require("app.fairyGUI.mystery.UI_MysteryOtherTaskCell"))

function MysteryOtherTaskCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:doFairyBatching(false)
	self.m_awardList:setItemRenderer(handler(self, self._onRewardItemRender))
	self.m_getTaskBtn:addClickListener(handler(self, self._onClickGetTaskBtn))
	self.m_giveUpBtn:addClickListener(handler(self, self._onClickGiveUpBtn))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetAwardBtn))
	self.m_goBtn:addClickListener(handler(self, self._onClickGoBtn))
end

function MysteryOtherTaskCell:_onRewardItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._awards[arg_2_1 + 1])
end

function MysteryOtherTaskCell:updateCell(arg_3_1)
	self._taskInfo = arg_3_1
	self._chapterId = var_0_1:getCurChapterId()
	self._chapterData = var_0_1:getChapterDataById(self._chapterId)
	self._dailyTaskId = var_0_1:getDailyTaskId()
	self._dailyTaskState = var_0_1:getTaskStateById(self._dailyTaskId)

	if self._taskInfo.id == self._dailyTaskId then
		self.m_taskStateController:setSelectedIndex(self._dailyTaskState)
	end

	if self._dailyTaskId == 0 then
		self.m_isGetController:setSelectedIndex(0)
	elseif self._taskInfo.id == self._dailyTaskId then
		self.m_isGetController:setSelectedIndex(1)
	else
		self.m_isGetController:setSelectedIndex(2)
	end

	self.m_descTxt:setText(self._taskInfo.task_desc)

	if self:isUnlockGroupMonster() then
		self.m_isUnlockController:setSelectedIndex(1)
	else
		self.m_isUnlockController:setSelectedIndex(0)

		local var_3_0 = self._chapterData:getMonsterListByGroup(self._taskInfo.target_value)

		if var_3_0 and next(var_3_0) then
			self.m_unlockDescTxt:setText(g.core.lang:get(423025, {
				str = var_3_0[1].stage_name
			}))
		end
	end

	local var_3_1 = var_0_1:getTaskProgById(self._taskInfo.id)

	self.m_valueTxt:setText((g.core.lang:get(423002, {
		cur = (var_3_1 or nil) and (var_3_1.progress or 0),
		max = self._taskInfo.task_size
	})))

	self._awards = self:_getTaskAwards()

	self.m_awardList:setNumItems(#self._awards)
	self.m_enterTransition:play(handler(self, self._onCreateKnight))
end

function MysteryOtherTaskCell:_onCreateKnight()
	self.m_knightPlaceHolder:removeChildren()
	self.m_knightPlaceHolder:addChild((CommonKnight.new({
		resId = g.core.config.knight_base_info.get(self._taskInfo.knight_base).fight_id
	})))
end

function MysteryOtherTaskCell:hideKnightVisible()
	self.m_knightPlaceHolder:setVisible(false)
end

function MysteryOtherTaskCell:_getTaskAwards()
	local var_6_0 = {}

	for iter_6_0 = 1, 4 do
		if self._taskInfo["reward_type_" .. iter_6_0] > 0 then
			table.insert(var_6_0, {
				type = self._taskInfo["reward_type_" .. iter_6_0],
				value = self._taskInfo["reward_value_" .. iter_6_0],
				size = self._taskInfo["reward_size_" .. iter_6_0]
			})
		end
	end

	return var_6_0
end

function MysteryOtherTaskCell:isUnlockGroupMonster()
	return self._chapterData:getGroupIsPass(self._taskInfo.target_value)
end

function MysteryOtherTaskCell:_onClickGetTaskBtn()
	if self._dailyTaskId > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(423012))

		return
	end

	if not var_0_1:isDaliyTaskDone() then
		if self:isUnlockGroupMonster() then
			g.core.network.GameNetProxy:send_C2S_Mystery_AcceptTask({
				task_id = self._taskInfo.id
			})
		else
			local var_8_0 = self._chapterData:getMonsterListByGroup(self._taskInfo.target_value)

			if var_8_0 and next(var_8_0) then
				g.core.module.ModuleManager:tip(g.core.lang:get(423025, {
					str = var_8_0[1].stage_name
				}))
			end
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(423010))
	end
end

function MysteryOtherTaskCell:_onClickGiveUpBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(1257),
		desc = g.core.lang:get(423023),
		onConfirm = handler(self, self._giveUpDailyTask)
	}))
end

function MysteryOtherTaskCell:_giveUpDailyTask()
	self:dispatchCompEvent("GIVE_UP_TASK_ID", self._taskInfo.id)
end

function MysteryOtherTaskCell:_onClickGetAwardBtn()
	if self._dailyTaskState == var_0_2.TASK_STATE.CAN_AWARD then
		g.core.network.GameNetProxy:send_C2S_Mystery_Award({
			task_id = self._taskInfo.id
		})
	end
end

function MysteryOtherTaskCell:_onClickGoBtn()
	for iter_12_0, iter_12_1 in ipairs((var_0_1:getChapterDataById(self._taskInfo.chapter_id):getMonsterListByGroup(self._taskInfo.target_value))) do
		if var_0_1:getStageDataById(iter_12_1.id):isMonsterExist() then
			self:dispatchCompEvent("CELL_CLICK_GO", iter_12_1.number, self._taskInfo.chapter_id)

			break
		end
	end
end

return MysteryOtherTaskCell
