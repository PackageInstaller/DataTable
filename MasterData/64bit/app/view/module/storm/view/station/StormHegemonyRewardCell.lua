local StormHegemonyRewardCell = class("StormHegemonyRewardCell", require("app.fairyGUI.storm.UI_StormHegemonyRewardCell"))

function StormHegemonyRewardCell:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
	self.m_takeRewardBtn:addClickListener(handler(self, self._onTakeClick))
end

function StormHegemonyRewardCell:updateCellView(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 then
		self:updateTaskCell(arg_2_2)
	else
		self._params = arg_2_2

		local var_2_0 = arg_2_2.info

		self._awards = arg_2_2.awards or {}

		self.m_rewardDescTxt:setText(var_2_0.title)
		self.m_rewardList:setNumItems(#self._awards)

		if arg_2_2.isReceived or false then
			self.m_stateController:setSelectedIndex(2)
		elseif arg_2_3 >= var_2_0.num then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(0)
			self.m_processTxt:setText(arg_2_3 .. "/" .. var_2_0.num)
		end

		self.m_descTxt:setText(g.core.lang:get(304625, {
			num = var_2_0.num
		}))
	end
end

function StormHegemonyRewardCell:updateTaskCell(arg_3_1)
	self._isTask = true
	self._data = arg_3_1

	self.m_descTxt:setText(g.core.lang:getByString(arg_3_1.info.name, {
		num = arg_3_1.info.require_value
	}), true)
	self.m_processTxt:setText(((arg_3_1.count > arg_3_1.info.require_value or nil) and arg_3_1.info.require_value) .. "/" .. arg_3_1.info.require_value)
	self.m_rewardDescTxt:setText(arg_3_1.info.title)

	local var_3_1 = 0

	for iter_3_0 = 1, 4 do
		if self._data.info["reward_type_" .. iter_3_0] ~= 0 then
			var_3_1 = var_3_1 + 1
		end
	end

	self.m_rewardList:setNumItems(var_3_1)
	self.m_stateController:setSelectedIndex(self._data.got and 2 or self._data.count >= self._data.info.require_value and 1 or 0)
end

function StormHegemonyRewardCell:_onAwardItemRenderer(arg_4_1, arg_4_2)
	if self._isTask then
		arg_4_2:updateIcon({
			type = self._data.info["reward_type_" .. arg_4_1 + 1],
			value = self._data.info["reward_value_" .. arg_4_1 + 1],
			size = self._data.info["reward_size_" .. arg_4_1 + 1]
		})
	else
		arg_4_2:updateIcon(self._awards[arg_4_1 + 1])
	end
end

function StormHegemonyRewardCell:_onTakeClick()
	if self._isTask then
		g.core.network.GameNetProxy:send_C2S_GetModuleTaskAward({
			task_id = self._data.info.id
		})
	elseif self._params and not self._params.isReceived then
		if g.core.model.User.stormCityData:getLordAchievePoint() >= self._params.info.num then
			g.core.network.GameNetProxy:send_C2S_StormCity_GetLordAchiveAward({
				id = self._params.info.id
			})
		end
	end
end

return StormHegemonyRewardCell
