local NewSlgPvcAllianceRankCell = class("NewSlgPvcAllianceRankCell", require("app.fairyGUI.newSlg.UI_NewSlgPvcAllianceRankCell"))

function NewSlgPvcAllianceRankCell:ctor()
	self._data = nil

	self:_initCell()
end

function NewSlgPvcAllianceRankCell:_initCell()
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function NewSlgPvcAllianceRankCell:updateRankCell(arg_3_1, arg_3_2, arg_3_3)
	self._data = arg_3_1

	if arg_3_2 % 2 == 0 then
		self.m_hasBgController:setSelectedIndex(1)
	else
		self.m_hasBgController:setSelectedIndex(0)
	end

	if arg_3_3 then
		self:_updateReward(arg_3_3)

		return
	end

	self.m_rankTxt:updateRankIndex({
		rank = arg_3_2
	})
	self.m_showTypeController:setSelectedIndex(0)

	if not arg_3_1 then
		return
	end

	self.m_scoreTxt:setText(arg_3_1.score)

	local var_3_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, arg_3_1.allianceId)

	if not var_3_0 then
		self.m_hasAllianceController:setSelectedIndex(0)

		return
	end

	self.m_allianceIcon:setIcon(g.core.common.Path:getAllianceFlag128(var_3_0.flag))
	self.m_nameTxt:setText(var_3_0.name)
	self.m_hasAllianceController:setSelectedIndex(1)
end

function NewSlgPvcAllianceRankCell:_updateReward(arg_4_1)
	self.m_rankTxt:updateRangeRankIndex({
		max = arg_4_1.max_rank,
		min = arg_4_1.min_rank
	})

	local var_4_0 = 1
	local var_4_1 = {
		"reward_type"
	}

	var_4_1[2] = 1

	local var_4_2 = table.concat(var_4_1, "_")
	local var_4_3 = table.concat({
		"reward_value",
		var_4_0
	}, "_")
	local var_4_4 = table.concat({
		"reward_size",
		var_4_0
	}, "_")

	self._rewards = {}

	local var_4_5 = {}

	while g.core.config.new_slg_rank_reward_info.hasKey(var_4_2) and arg_4_1[var_4_2] > 0 do
		local var_4_6 = {
			type = arg_4_1[var_4_2],
			value = arg_4_1[var_4_3],
			size = arg_4_1[var_4_4]
		}
		local var_4_7 = table.concat({
			var_4_6.type,
			var_4_6.value
		}, "_")
		local var_4_8 = var_4_5[var_4_7]

		if not var_4_5[var_4_7] then
			var_4_8 = #self._rewards + 1
			self._rewards[#self._rewards + 1] = var_4_6
			var_4_5[var_4_7] = var_4_8
		else
			self._rewards[var_4_8].size = self._rewards[var_4_8].size + var_4_6.size
		end

		var_4_0 = var_4_0 + 1
		var_4_2 = table.concat({
			"reward_type",
			var_4_0
		}, "_")
		var_4_3 = table.concat({
			"reward_value",
			var_4_0
		}, "_")
		var_4_4 = table.concat({
			"reward_size",
			var_4_0
		}, "_")
	end

	self.m_showTypeController:setSelectedIndex(1)
	self.m_awardList:setNumItems(#self._rewards)
end

function NewSlgPvcAllianceRankCell:_onAwardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateIcon(self._rewards[arg_5_1 + 1])
end

return NewSlgPvcAllianceRankCell
