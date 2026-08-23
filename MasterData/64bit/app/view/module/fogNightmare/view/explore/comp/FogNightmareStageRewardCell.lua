local var_0_0 = g.core.model.User.fogNightmareData
local FogNightMareStageRewardCell = class("FogNightMareStageRewardCell", require("app.fairyGUI.fogNightmare.UI_FogNightmareStageRewardCell"))

function FogNightMareStageRewardCell:ctor()
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardRenderer))
	self.m_getBtn:addClickListener(handler(self, self._onGetBtnClick))
end

function FogNightMareStageRewardCell:updateFogNightCell(arg_2_1)
	self._data = arg_2_1

	self.m_rewardTitle:setText(g.core.lang:get(500123, {
		num = arg_2_1.index
	}))
	self.m_descTxt:setText(g.core.lang:get(500124, {
		num = arg_2_1.floor
	}))

	self._rewards = arg_2_1.awards

	self.m_rewardList:setNumItems(#self._rewards)

	if arg_2_1.received then
		self.m_rewardStateController:setSelectedIndex(2)
	else
		local var_2_0 = var_0_0:getTowerData()
		local var_2_1 = var_2_0:getFloorStruct(arg_2_1.floor)

		var_2_1:checkAndFixFloorState()

		local var_2_2 = var_2_1:getLockInfo()

		if not var_2_2.time and not var_2_2.level then
			local var_2_3 = math.max(var_2_0:getCurrentFloorNum() - 1, (math.max(var_2_0:getCurrentMaxFloorNum(), var_2_0:getHistoryMaxFloorNum())))

			if arg_2_1.floor <= var_2_3 then
				self.m_rewardStateController:setSelectedIndex(1)
			else
				self.m_rewardStateController:setSelectedIndex(0)
				self.m_scoreNum:setText(var_2_3 .. "/" .. arg_2_1.floor)
			end
		else
			self.m_rewardStateController:setSelectedIndex(3)

			if var_2_2.time then
				if (var_2_2.time - var_2_2.time % 86400) / 86400 ~= 0 and (var_2_2.time - (var_2_2.time - var_2_2.time % 86400) / 86400 * 86400 - var_2_2.time % 3600) / 3600 ~= 0 then
					self.m_lockStr:setText(g.core.lang:get(500125, {
						day = (var_2_2.time - var_2_2.time % 86400) / 86400,
						hour = (var_2_2.time - (var_2_2.time - var_2_2.time % 86400) / 86400 * 86400 - var_2_2.time % 3600) / 3600
					}))
				elseif (var_2_2.time - var_2_2.time % 86400) / 86400 == 0 then
					self.m_lockStr:setText(g.core.lang:get(500127, {
						hour = (var_2_2.time - (var_2_2.time - var_2_2.time % 86400) / 86400 * 86400 - var_2_2.time % 3600) / 3600
					}))
				else
					self.m_lockStr:setText(g.core.lang:get(500126, {
						day = (var_2_2.time - var_2_2.time % 86400) / 86400
					}))
				end
			elseif var_2_2.level then
				self.m_lockStr:setText(g.core.lang:get(500128, {
					lv = var_2_2.level
				}))
			end
		end
	end
end

function FogNightMareStageRewardCell:_onGetBtnClick()
	g.core.network.GameNetProxy:send_C2S_Fog_PhaseAward({
		floor = self._data.floor
	})
end

function FogNightMareStageRewardCell:_onRewardRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateIcon(self._rewards[arg_4_1 + 1])
end

return FogNightMareStageRewardCell
