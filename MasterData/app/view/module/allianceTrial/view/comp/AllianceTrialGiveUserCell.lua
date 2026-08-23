local var_0_0 = g.core.const.ConstMgr.AllianceConst
local var_0_1 = g.core.model.User.allianceData
local var_0_2 = g.core.model.User.allianceTrialData
local var_0_3 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_4 = g.core.model.User.snapShotCacheData
local AllianceTrialGiveUserCell = class("AllianceTrialGiveUserCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialGiveUserCell"))

function AllianceTrialGiveUserCell:ctor()
	self._uid = 0
	self._maxNum = var_0_1:getParams(var_0_0.PARAMETER.TRIAL_DAILY_RECEIVE)

	self.m_giveBtn:addClickListener(handler(self, self._onClickGiveBtn))
end

function AllianceTrialGiveUserCell:_onClickGiveBtn()
	if var_0_2:getLastGiveCount() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430407))

		return
	end

	if self._uid > 0 then
		g.core.network.GameNetProxy:send_C2S_AllianceTrial_Give({
			target_user_id = self._uid
		})
	end
end

function AllianceTrialGiveUserCell:updateGiveCell(arg_3_1, arg_3_2, arg_3_3)
	self._uid = arg_3_1.user_id

	local var_3_0 = arg_3_1.receive_times or 0

	if var_3_0 >= self._maxNum or var_0_2:getLastGiveCount() <= 0 then
		self.m_isGiveController:setSelectedIndex((arg_3_2[self._uid] or 0) > 0 and 1 or 2)
	else
		self.m_isGiveController:setSelectedIndex(0)
	end

	self.m_isShowBgController:setSelectedIndex(1 - arg_3_3 % 2)

	local var_3_1 = var_0_4:getSnapShot(var_0_3.SNAP_SHOT_KEY.USER, self._uid)

	if var_3_1 then
		self.m_userComp:updateAsUser(var_3_1)
		self.m_userName:setText(var_3_1.name)
		self.m_level:setText(g.core.lang:get(2052, {
			level = var_3_1.level
		}))
		self.m_serverName:setText(var_3_1.server_name)
	end

	self.m_fightValue:setText(arg_3_1.fight_value)
	self.m_giveCount:setText(g.core.lang:get(107056, {
		num = var_3_0,
		maxNum = self._maxNum
	}))
end

return AllianceTrialGiveUserCell
