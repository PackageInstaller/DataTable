local var_0_0 = g.core.config.omikuji_info
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE.NEW_YEAR_WISH
local NewYearWishConst = require("app.view.module.newYearWish.const.NewYearWishConst")
local var_0_3 = g.core.common.ModuleUnlock
local var_0_4 = g.core.model.User.giftData
local NewYearWishData = class("NewYearWishData")

function NewYearWishData:ctor()
	self:initData()
end

function NewYearWishData:initData()
	self._activityId = 0
	self._openDaysTime = 0
	self._startTime = 0
	self._endTime = 0
	self._activityType = 1
	self._drawDay = 0
	self._curDrawId = 0
	self._isGetReward = false
	self._rechargeGiftList = {}
	self._actInfo = nil
	self._nameId = nil
end

function NewYearWishData:onS2CNewYearWishGetInfo(arg_3_1)
	self._actInfo = arg_3_1.act_info

	if arg_3_1.act_info then
		self._nameId = arg_3_1.act_info.name_id
		self._activityId = arg_3_1.act_info.id
		self._openDaysTime = arg_3_1.act_info.open_day or 0
		self._startTime = arg_3_1.act_info.begin_time or 0
		self._endTime = arg_3_1.act_info.end_time or 0
		self._activityType = (not arg_3_1.act_info.activity_type or arg_3_1.act_info.activity_type == 0) and 1 or arg_3_1.act_info.activity_type
	end

	local var_3_0 = arg_3_1.user_data

	if arg_3_1.user_data then
		self._drawDay = var_3_0.draw_day or 0
		self._curDrawId = var_3_0.cur_draw_id or 0
		self._isGetReward = var_3_0.is_award or false
	end
end

function NewYearWishData:onS2CNewYearWishDraw(arg_4_1)
	self._drawDay = arg_4_1.draw_day or 0
	self._curDrawId = arg_4_1.draw_id or 0
	self._isGetReward = false
end

function NewYearWishData:onS2CNewYearWishAward(arg_5_1)
	self._isGetReward = true
end

function NewYearWishData:getDrawDays()
	return self._drawDay
end

function NewYearWishData:getCurInfo()
	return var_0_0.fetch(self._curDrawId) or var_0_0.fetch(1)
end

function NewYearWishData:isGetReward()
	return self._isGetReward
end

function NewYearWishData:hasAwardCanGet()
	return self._curDrawId > 0 and not self._isGetReward
end

function NewYearWishData:isShowEntrance()
	if var_0_3:isModuleUnlock(var_0_1) then
		local var_10_0 = g.core.common.ServerTime:getTime()

		return var_10_0 > self._startTime and var_10_0 < self._endTime
	end

	return false
end

function NewYearWishData:isDrawEnable()
	if self:isShowEntrance() then
		return self._curDrawId == 0
	end

	return false
end

function NewYearWishData:getWishResultPopResName()
	return NewYearWishConst.WISH_RESULT_POP_RES_PRE_NAME .. self._activityType
end

function NewYearWishData:getShareBgPath()
	return NewYearWishConst.ShareBg[self._activityType] or NewYearWishConst.ShareBg[1]
end

function NewYearWishData:getGiftArr()
	local var_14_0 = self:getCurInfo()
	local var_14_1 = {}

	while var_0_0.hasKey("gift_" .. 1) do
		if var_14_0["gift_" .. 1] > 0 then
			local var_14_2 = var_0_4:getGiftDataById(var_14_0["gift_" .. 1])

			if var_14_2 then
				table.insert(var_14_1, var_14_2)
			end
		end
	end

	return var_14_1
end

function NewYearWishData:getTitle()
	if not self._nameId or self._nameId == 0 then
		return g.core.lang:get(NewYearWishConst.title[self._activityType]) or ""
	else
		return g.core.config.omikuji_name_info.get(self._nameId).name
	end
end

function NewYearWishData:getIconURL()
	return self._nameId and self._nameId > 0 and NewYearWishConst.GM_iCON or NewYearWishConst.icon[self._activityType] or NewYearWishConst.icon[1]
end

function NewYearWishData:getShareType()
	return g.core.const.ConstMgr.ShareConst.SHARE_ACTIVITY_TYPE[self._activityType] or g.core.const.ConstMgr.ShareConst.SHARE_ACTIVITY_TYPE[1]
end

function NewYearWishData:getNameInfoById(arg_18_1)
	return (g.core.config.omikuji_name_info.get(arg_18_1))
end

function NewYearWishData:getResInfoById(arg_19_1)
	return (g.core.config.omikuji_res_info.get(arg_19_1))
end

function NewYearWishData:getGMNameId()
	return self._nameId
end

function NewYearWishData:getActInfo()
	return self._actInfo
end

function NewYearWishData:getResId()
	return (self._actInfo or nil) and self._actInfo.res_id
end

function NewYearWishData:getActivityId()
	if self._actInfo then
		return self._actInfo.id
	end
end

return NewYearWishData
