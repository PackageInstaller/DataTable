local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_1 = g.core.model.User.cultivateDataMgr
local var_0_2 = g.core.common.Path
local CultivateTaskCell = class("CultivateTaskCell", require("app.fairyGUI.cultivate.UI_CultivateTaskCell"))

function CultivateTaskCell:ctor()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))

	self._rewards = {}

	self.m_receiveBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function CultivateTaskCell:updateCultivateCell(arg_2_1, arg_2_2)
	self._taskId = arg_2_1.cfg.id
	self._actId = arg_2_2
	self._routeId = arg_2_1.cfg.route_id

	local var_2_0 = var_0_1:getCultivateData(arg_2_2):getTaskData()

	self._taskData = var_2_0

	self.m_name:setText(arg_2_1.cfg.name)
	self.m_descText:setText(arg_2_1.cfg.des)

	self._rewards = var_2_0:getTaskReward(arg_2_1.cfg)

	self.m_awardList:setNumItems(#self._rewards)
	self.m_curProgressText:setText((arg_2_1.taskData.progress > arg_2_1.cfg.action_value or nil) and (arg_2_1.cfg.action_value or arg_2_1.taskData.progress))
	self.m_destinNumText:setText("/" .. arg_2_1.cfg.action_value)

	if arg_2_1.cfg.action_value == 0 then
		self.m_curProgressText:setText("1")
		self.m_destinNumText:setText("/1")
	end

	self.m_drawStateController:setSelectedIndex(arg_2_1.taskState)

	if arg_2_1.taskState == CultivateConst.TASK_REWARD_STATE.TASK_NOT_START then
		local var_2_1, var_2_2, var_2_3, var_2_4 = g.core.common.ServerTime:getLeftTimeParts(arg_2_1.startTime)

		self.m_lockDesc:setText(g.core.lang:get(421408, {
			day = var_2_1,
			hour = var_2_2
		}))
	end

	self:updateWitchRes()
end

function CultivateTaskCell:updateWitchRes()
	self._actData = var_0_1:getCultivateData(self._actId)

	local var_3_0 = self._actData:getActivityCfg()

	if var_3_0.type == CultivateConst.ACTIVITY_TYPE.WITCH then
		local var_3_1 = self._taskData:getTaskRewardState(self._taskId)
		local var_3_2 = var_0_1:getResDirId(var_3_0.id)

		self.m_bgLoader:setURL(var_0_2:getCultivateImage("pic_mnzj_renwudi", var_3_2))
		self.m_receiveBtn:getChild("bg"):setURL(var_0_2:getCultivateImage("btn_mnzj_lingqvdi", var_3_2))

		if var_3_1 == CultivateConst.TASK_REWARD_STATE.GOT then
			self.m_receiveBtn:setIcon(var_0_2:getCultivateImage("icon_mnzj_yilingqv", var_3_2))
		elseif var_3_1 == CultivateConst.TASK_REWARD_STATE.CAN_REWARD then
			self.m_receiveBtn:setIcon(var_0_2:getCultivateImage("icon_mnzj_kelingqv", var_3_2))
		elseif var_3_1 == CultivateConst.TASK_REWARD_STATE.NOT_FINISH then
			self.m_receiveBtn:setIcon(var_0_2:getCultivateImage("icon_mnzj_qianwang", var_3_2))
		end
	end
end

function CultivateTaskCell:_onAwardRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rewards[arg_4_1 + 1])
end

function CultivateTaskCell:_onTaskBtnClick()
	if not self._taskId then
		return
	end

	local var_5_0 = self._taskData:getTaskRewardState(self._taskId)

	if var_5_0 == CultivateConst.TASK_REWARD_STATE.GOT then
		g.core.module.ModuleManager:tip(g.core.lang:get(421413))
	elseif var_5_0 == CultivateConst.TASK_REWARD_STATE.CAN_REWARD then
		g.core.network.GameNetProxy:send_C2S_CultivateActivity_TaskAward({
			activity_id = self._actId,
			task_id = self._taskId
		})
	elseif var_5_0 == CultivateConst.TASK_REWARD_STATE.NOT_FINISH then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._routeId)
	end
end

return CultivateTaskCell
