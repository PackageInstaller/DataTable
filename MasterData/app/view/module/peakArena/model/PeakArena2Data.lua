local PeakArena2Data = class("PeakArena2Data", require("app.view.module.peakArena.model.PeakArenaData"))
local var_0_1 = g.core.const.ConstMgr.PeakArenaConst

function PeakArena2Data:ctor()
	self:initData()
end

function PeakArena2Data:initData()
	PeakArena2Data.super.initData(self)

	self._init = true
end

function PeakArena2Data:sendCrossRedPoint()
	if self:isShowEntrance() and self._init then
		g.core.network.GameNetProxy:send_C2S_FlushRedPoint({
			cross_modules = {
				g.core.const.ConstMgr.RedPointConst.Cross_RedPoint_module.PEAK_ARENA
			}
		})
	end

	self._init = false
end

function PeakArena2Data:onS2CCheer(arg_4_1)
	self:getPeakStageUserStructWithId(arg_4_1.target_id):setCheerCount(arg_4_1.cheer_count or 0)
	table.insert(self._hasCheerIds, arg_4_1.target_id)
end

function PeakArena2Data:onS2CAllianceRankAward(arg_5_1)
	table.insert(self._recvUserRankAward, arg_5_1.target_id)
end

function PeakArena2Data:isUserCheer(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._hasCheerIds) do
		if iter_6_1 == arg_6_1 then
			return true
		end
	end

	return false
end

function PeakArena2Data:getCheerCount(arg_7_1)
	local var_7_0 = self:getPeakStageUserStructWithId(arg_7_1)

	return var_7_0 and var_7_0:getCheerCount() or 0
end

function PeakArena2Data:getOwnCheerCount()
	return g.core.config.peakarena_parameter_info.get(3).parameter - #self._hasCheerIds
end

function PeakArena2Data:isRankAwardRecv(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._recvUserRankAward) do
		if iter_9_1 == arg_9_1 then
			return true
		end
	end

	return false
end

function PeakArena2Data:hasCanCheerCount()
	if not self:isShowEntrance() then
		return false
	end

	local var_10_0, var_10_1

	if self:getStageType() ~= var_0_1.StageType.PEAK then
		do return false end

		var_10_0 = self:getFinalStageEndTime()
		var_10_1 = g.core.common.ServerTime:getTime()
	end

	if not (self:getGroupStageEndTime() <= var_10_1 and var_10_1 < var_10_0) then
		return false
	end

	local var_10_2 = g.core.model.User:getAllianceId()

	if var_10_2 == 0 then
		return false
	end

	if self._hasCheer then
		return true
	end

	if self:getOwnCheerCount() == 0 then
		return false
	end

	for iter_10_0, iter_10_1 in ipairs((self._peakStageSvrRoundInfoArr[#self._peakStageSvrRoundInfoArr] or {}).uids or {}) do
		if not self:isUserCheer(iter_10_1) then
			local var_10_4 = self:getUserSnapshotWithId(iter_10_1)

			if var_10_4 and var_10_4.alliance_id == var_10_2 then
				return true
			end
		end
	end

	return false
end

function PeakArena2Data:hasRankAwardCanRecv()
	if not self:isShowEntrance() then
		return false
	end

	if self:getStageType() ~= var_0_1.StageType.TOP_SHOW then
		return false
	end

	local var_11_0 = g.core.model.User:getAllianceId()

	if var_11_0 == 0 then
		return false
	end

	if self._hasAward then
		return true
	end

	local var_11_1 = self:getGroupStruct(var_0_1.FINAL_GROUP_ID)

	if var_11_1 then
		local var_11_2 = var_11_1:getUserIdArrSortByRank()

		for iter_11_0 = 1, var_0_1.SHOW_TOP_USER_COUNT do
			if (var_11_2[iter_11_0] or 0) > 0 and not self:isRankAwardRecv(var_11_2[iter_11_0]) then
				local var_11_4 = self:getUserSnapshotWithId(var_11_2[iter_11_0])

				if var_11_4 and var_11_4.alliance_id == var_11_0 then
					return true
				end
			end
		end
	end

	return false
end

return PeakArena2Data
