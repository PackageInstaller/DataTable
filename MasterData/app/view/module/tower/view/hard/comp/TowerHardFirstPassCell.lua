local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.model.User.towerHardData
local TowerHardFirstPassCell = class("TowerHardFirstPassCell", require("app.fairyGUI.tower.UI_TowerHardFirstPassCell"))

function TowerHardFirstPassCell:ctor()
	self._rewardList = {}
	self._id = 0

	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderList))
	self.m_getAwardBtn:addClickListener(handler(self, self._onGetReward))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function TowerHardFirstPassCell:_onGetReward()
	if not var_0_1:getFirstPassAwardIsGetById(self.id) then
		g.core.network.GameNetProxy:send_C2S_Tower_FirstPassAward({
			play_type = 2,
			id = self._id
		})
	end
end

function TowerHardFirstPassCell:_onRenderList(arg_3_1, arg_3_2)
	self._rewardList[arg_3_1 + 1].scaleIndex = 3

	arg_3_2:updateIcon(self._rewardList[arg_3_1 + 1])
end

function TowerHardFirstPassCell:update(arg_4_1)
	local var_4_0

	if arg_4_1 then
		var_4_0 = arg_4_1.data or {}
	end

	local var_4_1 = false

	if next(var_4_0) then
		local var_4_2 = var_4_0.user_records or {}
		local var_4_3

		if var_4_2[1] then
			var_4_3 = var_4_2[1].snapshot or {}

			if var_4_3.id == nil then
				var_4_1 = false

				goto label_4_0
			end
		end

		var_4_1 = true

		self.m_userName:setText(var_4_3.name)

		local var_4_4, var_4_5 = g.core.lang:getFormatServerName(var_4_3.server_name)

		self.m_serverName:setText(var_4_5)
		self.m_power:setText(var_4_3.fight_value)
		self.m_userIcon:updateAsUser(var_4_3)
	end

	::label_4_0::

	local var_4_6 = arg_4_1.info
	local var_4_7 = var_0_0.get(arg_4_1.info.require_value)

	self.m_passOrder:setText(g.core.lang:get(308022, {
		stageOrder = var_4_7.stage_order
	}))

	self._id = var_4_6.id

	self.m_getRewardController:setSelectedIndex(not var_4_1 and 0 or var_0_1:getFirstPassAwardIsGetById(self._id) and 2 or var_0_1:getIsFirstPassByStageAndId(var_4_7.stage_type, var_4_6.id) and 1 or 0)

	self._rewardList = {}

	local var_4_9 = 1

	while var_0_0.hasKey("reward_type" .. 1) do
		if var_4_6["reward_type" .. 1] > 0 then
			table.insert(self._rewardList, {
				type = var_4_6["reward_type" .. 1],
				value = var_4_6["reward_value" .. var_4_9],
				size = var_4_6["reward_size" .. var_4_9]
			})
		end

		var_4_9 = var_4_9 + 1
	end

	self.m_rewardList:setNumItems(#self._rewardList)
end

return TowerHardFirstPassCell
