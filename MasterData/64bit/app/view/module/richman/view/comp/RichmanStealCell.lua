local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.richmanData
local RichmanStealCell = class("RichmanStealCell", require("app.fairyGUI.richman.UI_RichmanStealCell"))

function RichmanStealCell:ctor()
	self.m_actionBtn:addClickListener(handler(self, self._onActionBtnClick))
end

function RichmanStealCell:updateStealCell(arg_2_1, arg_2_2, arg_2_3)
	self._stealData = arg_2_1
	self._uniqueId = arg_2_3

	self.m_typeController:setSelectedIndex(arg_2_2 and 0 or 1)
	self.m_timeTxt:setText("")

	if arg_2_2 and arg_2_1.rob_time then
		local var_2_0 = g.core.common.ServerTime:getTime() - arg_2_1.rob_time

		if ((var_2_0 - var_2_0 % 3600) / 3600 - (var_2_0 - var_2_0 % 3600) / 3600 % 24) / 24 > 30 then
			self.m_timeTxt:setText(g.core.lang:get(426019, {
				time = math.floor(((var_2_0 - var_2_0 % 3600) / 3600 - (var_2_0 - var_2_0 % 3600) / 3600 % 24) / 24 / 30)
			}))
		elseif ((var_2_0 - var_2_0 % 3600) / 3600 - (var_2_0 - var_2_0 % 3600) / 3600 % 24) / 24 >= 1 then
			self.m_timeTxt:setText(g.core.lang:get(426018, {
				time = ((var_2_0 - var_2_0 % 3600) / 3600 - (var_2_0 - var_2_0 % 3600) / 3600 % 24) / 24
			}))
		elseif (var_2_0 - var_2_0 % 3600) / 3600 % 24 >= 1 then
			self.m_timeTxt:setText(g.core.lang:get(426017, {
				time = (var_2_0 - var_2_0 % 3600) / 3600 % 24
			}))
		else
			self.m_timeTxt:setText(g.core.lang:get(426016, {
				time = (var_2_0 - (var_2_0 - var_2_0 % 3600) / 3600 * 3600 - var_2_0 % 60) / 60
			}))
		end
	end

	local var_2_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_2_1.user_id)

	if var_2_1 then
		self.m_nameTxt:setText(var_2_1.name)
		self.m_mapLvTxt:setText(g.core.lang:get(426007, {
			lv = arg_2_1.map_level
		}))
		self.m_powerTxt:setText(var_2_1.fight_value)
		self.m_levelTxt:setText("LV." .. var_2_1.level)
		self.m_iconLoader:updateAsUser(var_2_1)
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self:updateCellTime()
end

function RichmanStealCell:_onActionBtnClick()
	if self._stealData then
		g.core.network.GameNetProxy:send_C2S_RichMan_RobData({
			user_id = self._stealData.user_id,
			event_id = self._uniqueId
		})
	end
end

function RichmanStealCell:updateCellTime()
	local var_4_0 = var_0_1:getRobPlayerData(self._stealData.user_id)

	if var_4_0 and var_4_0.construct and var_4_0.construct.armistice then
		if var_4_0.construct.armistice - var_0_0:getTime() <= 0 then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(2)
			self.m_protectTimeTxt:setText(var_0_0:getLeftSecondsString(var_4_0.construct.armistice))
		end
	end
end

return RichmanStealCell
