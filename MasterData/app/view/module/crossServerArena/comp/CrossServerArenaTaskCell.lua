local var_0_0 = g.core.const.ConstMgr.CrossServerArenaConst
local CrossServerArenaTaskCell = class("CrossServerArenaTaskCell", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaTaskCell"))

function CrossServerArenaTaskCell:ctor()
	self._taskData = nil
	self._awardList = {}

	self.m_taskNumText:enableRich()
	self:_initBtn()
	self:_initListView()
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function CrossServerArenaTaskCell:_initBtn()
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetAwardClick))
end

function CrossServerArenaTaskCell:_initListView()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
end

function CrossServerArenaTaskCell:_onRenderAwardList(arg_4_1, arg_4_2)
	self._awardList[arg_4_1 + 1].scaleIndex = 2
	self._awardList[arg_4_1 + 1].hideNum = false

	arg_4_2:updateIcon(self._awardList[arg_4_1 + 1])
end

function CrossServerArenaTaskCell:updateCell(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._taskData = arg_5_1

	self.m_taskNameText:setText(g.core.lang:getByString(arg_5_1.info.name, {
		num = arg_5_1.info.require_value
	}))

	local var_5_0 = math.min(arg_5_1.count, arg_5_1.info.require_value)

	self.m_taskNumText:setText(g.core.lang:get(302515, {
		curNum = var_5_0,
		targetNum = arg_5_1.info.require_value
	}))

	self._awardList = {}

	for iter_5_0 = 1, var_0_0.MAX_AWARD_NUM do
		if arg_5_1.info["reward_type_" .. iter_5_0] ~= 0 then
			table.insert(self._awardList, {
				type = arg_5_1.info["reward_type_" .. iter_5_0],
				value = arg_5_1.info["reward_value_" .. iter_5_0],
				size = arg_5_1.info["reward_size_" .. iter_5_0]
			})
		end
	end

	self.m_awardList:setNumItems(#self._awardList)

	local var_5_1 = var_0_0.CTRL_AWARD_UNGET

	if arg_5_1.got then
		var_5_1 = var_0_0.CTRL_AWARD_GETDONE
	elseif arg_5_1.info.require_value <= var_5_0 then
		var_5_1 = var_0_0.CTRL_AWARD_CANGET
	end

	self.m_isGetController:setSelectedIndex(var_5_1)
end

function CrossServerArenaTaskCell:_onGetAwardClick()
	if not self._taskData then
		return
	end

	self:dispatchCompEvent("EVENT_ARENA_AWARD_GET", self._taskData.info.id)
end

return CrossServerArenaTaskCell
