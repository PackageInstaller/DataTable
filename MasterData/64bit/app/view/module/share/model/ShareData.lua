local ShareData = class("ShareData")
local var_0_1 = g.core.config.share_info

function ShareData:ctor()
	self:initData()

	self._fileIdx = 0
end

function ShareData:initData()
	self.shareData = {}
	self._basePath = cc.FileUtils:getInstance():getWritablePath()

	if device.isAndroid() and g.core.platform.PlatformProxy:checkNewFunctionByVersion1_1_0() then
		self._basePath = g.core.platform.PlatformProxy:getPackageStorageDir()
	end

	self._shotPath = self._basePath .. "/shotPic.jpg"
end

function ShareData:updateShareData(arg_3_1)
	if arg_3_1.shares then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.shares) do
			self.shareData[iter_3_1.id] = iter_3_1.last_award_time
		end
	end
end

function ShareData:setResetTime(arg_4_1)
	if arg_4_1.last_share_time then
		self.shareData[arg_4_1.id] = arg_4_1.last_share_time
	end
end

function ShareData:isGetGetVerifiedAward()
	if self.shareData[g.core.const.ConstMgr.ShareConst.SPECIAL_SHARE_TYPE.SHARE_ID1] and self.shareData[g.core.const.ConstMgr.ShareConst.SPECIAL_SHARE_TYPE.SHARE_ID1] > 0 then
		return true
	end

	return false
end

function ShareData:getRewardIsReset(arg_6_1)
	if not self.shareData[arg_6_1] then
		return true
	end

	local var_6_0 = self:getShareResetType(arg_6_1)

	if var_6_0 == g.core.const.ConstMgr.ShareConst.SHARE_RESET_TYPE.DAILY_RESET then
		return not g.core.common.ServerTime:isToday(self.shareData[arg_6_1])
	elseif var_6_0 == g.core.const.ConstMgr.ShareConst.SHARE_RESET_TYPE.WEEKLY_RESET then
		return not g.core.common.ServerTime:isSameWeek(self.shareData[arg_6_1])
	elseif var_6_0 == g.core.const.ConstMgr.ShareConst.SHARE_RESET_TYPE.LIFELONG_RESET then
		return false
	end
end

function ShareData:getShareResetType(arg_7_1)
	local var_7_0 = var_0_1.get(arg_7_1)

	if var_7_0 then
		return var_7_0.reset_type
	end
end

function ShareData:getShareResId(arg_8_1)
	local var_8_0 = var_0_1.get(arg_8_1)

	if var_8_0 then
		return var_8_0.share_res_id
	end
end

function ShareData:getShareReward(arg_9_1)
	local var_9_0 = var_0_1.get(arg_9_1)

	if var_9_0 and var_9_0.reward_type1 and var_9_0.reward_type1 > 0 then
		return var_9_0.reward_type1, var_9_0.reward_value1, var_9_0.reward_size1
	end
end

function ShareData:isShowShare()
	return g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SHARE)
end

function ShareData:saveImg(arg_11_1)
	self._fileIdx = self._fileIdx + 1

	arg_11_1:saveToFile(self:getSavaPath())
end

function ShareData:getSavaPath()
	self._savePath = self._basePath .. "/sharePic" .. self._fileIdx .. ".jpg"

	return self._savePath
end

function ShareData:getShotPath()
	return self._shotPath
end

return ShareData
