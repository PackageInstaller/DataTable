local var_0_0 = g.core.const.ConstMgr.ThemeConst
local var_0_1 = g.core.model.User.themeData
local ThemeTurnTableProgressCell = class("ThemeTurnTableProgressCell", require("app.fairyGUI.summerThemeGame.UI_ThemeTurnTableProgressCell"))

function ThemeTurnTableProgressCell:ctor()
	self._activeThemeValue = var_0_0.THEME_VALUE.MOLLY
	self._index = 0
	self._rewardList = {}
	self._turnTableData = nil
	self._progressData = nil

	self.m_getBtn:addClickListener(handler(self, self.onRewardClick))
	self.m_rewardList:setIniter()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
end

function ThemeTurnTableProgressCell:_onRenderRewardList(arg_2_1, arg_2_2)
	arg_2_2:updateIcon(self._rewardList[arg_2_1 + 1])
end

function ThemeTurnTableProgressCell:onRewardClick()
	if not self._turnTableData or not self._progressData then
		return
	end

	if self._turnTableData:isTurnTableClose() then
		return
	end

	if self._turnTableData:isProgAwardCanGet(self._index) then
		g.core.network.GameNetProxy:send_C2S_Turntable_Reward({
			act_id = self._activeThemeValue,
			box_id = self._progressData.cfg.id
		})
	end
end

function ThemeTurnTableProgressCell:updateCell(arg_4_1, arg_4_2)
	self._activeThemeValue = arg_4_1
	self._index = arg_4_2

	local var_4_0 = var_0_1:getThemeData(arg_4_1)

	if not var_4_0 then
		return
	end

	self._turnTableData = var_4_0:getTurnTableData()

	local var_4_1 = self._turnTableData:getProgressList()[arg_4_2]

	if not var_4_1 then
		return
	end

	self._progressData = var_4_1

	self.m_progNumText:setText(var_4_1.cfg.times)
	self.m_progressTitle:setText(var_4_1.cfg.name)

	local var_4_3 = var_4_1.isGet and 3 or self._turnTableData:isProgAwardCanGet(self._index) and 2 or 1

	self.m_rewardStateController:setSelectedIndex(var_4_3)

	if var_4_3 == 1 then
		self.m_turnNum:setText("[color=#e52e2e]" .. self._turnTableData:getCurTurnNum() .. "[/color]" .. "/" .. var_4_1.cfg.times)
	end

	self._rewardList = {}

	local var_4_4 = g.core.config.drop_info.get(var_4_1.cfg.reward, 1)

	for iter_4_0 = 1, 5 do
		if var_4_4["reward_type_" .. iter_4_0] and var_4_4["reward_type_" .. iter_4_0] ~= 0 then
			table.insert(self._rewardList, {
				type = var_4_4["reward_type_" .. iter_4_0],
				value = var_4_4["reward_value_" .. iter_4_0],
				size = var_4_4["reward_min_" .. iter_4_0]
			})
		end
	end

	self.m_rewardList:setNumItems(#self._rewardList)
end

return ThemeTurnTableProgressCell
