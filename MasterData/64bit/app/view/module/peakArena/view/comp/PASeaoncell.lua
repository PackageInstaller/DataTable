local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.peakArenaData
local var_0_3 = g.core.model.User.snapShotCacheData
local var_0_4 = g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER
local PASeaoncell = class("PASeaoncell", require("app.fairyGUI.peakArena.UI_PASeaoncell"))

function PASeaoncell:update(arg_1_1)
	local var_1_0 = arg_1_1.top_user_ids or {}

	for iter_1_0 = 1, var_0_0.SHOW_TOP_USER_COUNT do
		if self["m_user" .. iter_1_0] then
			self["m_user" .. iter_1_0]:updateUserInfo((var_1_0[iter_1_0] and var_1_0[iter_1_0] > 0 or nil) and var_0_3:getSnapShot(var_0_4, var_1_0[iter_1_0]))
		end
	end

	self.m_seasonName:setText((var_0_2:getName(arg_1_1.sub_id)))
	self.m_seasonTime:setText((g.core.lang:get(307025, {
		startTime = var_0_1:getTimeStringEx(arg_1_1.start_time, true),
		endTime = var_0_1:getTimeStringEx(arg_1_1.end_time, true)
	})))
end

return PASeaoncell
