local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local AnniversaryTaskData = require("app.view.module.anniversary.model.AnniversaryTaskData")
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.config.anniversary_info
local var_0_4 = g.core.config.anniversary_parameter_info
local var_0_5 = g.core.config.anniversary_floor_info
local var_0_6 = g.core.config.anniversary_shop_group_info
local var_0_7 = g.core.config.anniversary_jigsaw_sign_info
local var_0_8 = g.core.config.anniversary_jigsaw_group_info
local var_0_9 = g.core.config.anniversary_jigsaw_cumulative_reward_info
local AnniversaryData = class("AnniversaryData")

function AnniversaryData:ctor()
	self:initData()
end

function AnniversaryData:initData()
	self._openServerDays = 0
	self._activityOpenTime = 0
	self._activityShowTime = 0
	self._activityEndTime = 0
	self._drawNum = 0
	self._curSignAwardId = 0
	self._finalJigsawAward = false
	self._todayShareCount = 0
	self._getshareTime = 0
	self._cumulativeAwardMap = {}
	self._signAwardMap = {}
	self._jigsawMap = {}
	self._jigsawGroupInfo = {}
	self._cumulativeAwardIds = {}
	self._groupAwardMaps = {}
	self._jigsawPosById = {}
	self._jigsawIdByPos = {}
	self._historyIdMaps = {}
	self._saveShareData = {}
	self._activityId = 1
	self._curFloor = 1
	self._maxFloor = 1
	self._floorStateList = {}
	self._shopTabList = {}
	self._shopTabSellList = {}
	self._taskData = AnniversaryTaskData.new()

	self:initJigsawData()
end

function AnniversaryData:_updateCurFloor()
	self._curFloor = 1

	for iter_3_0, iter_3_1 in pairs(self._floorStateList) do
		local var_3_0 = true

		for iter_3_2 = 1, var_0_0.FLOOR_AWARD_NUM do
			if not iter_3_1[iter_3_2] then
				var_3_0 = false

				break
			end
		end

		if var_3_0 then
			self._curFloor = math.max(self._curFloor, iter_3_0 + 1)
		end
	end

	self._maxFloor = #var_0_5.match(function(arg_4_0)
		return arg_4_0.activity_id == self._activityId
	end)
	self._curFloor = math.min(self._curFloor, self._maxFloor)
end

function AnniversaryData:_initShopInfo()
	self._shopTabList = {}
	self._shopTabSellList = {}

	local var_5_0 = var_0_6.match(function(arg_6_0)
		return arg_6_0.activity_id == self._activityId
	end)

	for iter_5_0 = 1, #var_5_0 do
		self._shopTabList[iter_5_0] = {
			index = iter_5_0,
			name = var_5_0[iter_5_0].name,
			openScoreNum = var_5_0[iter_5_0].score
		}
		self._shopTabSellList[iter_5_0] = g.core.model.User.shopData:getInfo(g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ANNIVERSARY, var_5_0[iter_5_0].shop_group, true)
	end
end

function AnniversaryData:onS2CRedPoint(arg_7_1)
	self:onS2CGetInfo({
		info = arg_7_1.info,
		data = arg_7_1.activity
	})
end

function AnniversaryData:onS2CGetInfo(arg_8_1)
	if arg_8_1.info then
		self._activityId = arg_8_1.info.sub_id or 1
		self._openServerDays = arg_8_1.info.open_day or 0
		self._activityOpenTime = arg_8_1.info.start_time or 0
		self._activityShowTime = arg_8_1.info.end_time or 0
		self._activityEndTime = arg_8_1.info.end_view_time or 0

		self._taskData:updateTaskDataByActivityId(self._activityId)
		self:_initJigsawPosData()
	end

	if arg_8_1.data then
		if arg_8_1.data.tasks then
			self._taskData:updateTaskData(arg_8_1.data.tasks)
		end

		if arg_8_1.data.floor_data then
			self._floorStateList = {}

			for iter_8_0 = 1, #arg_8_1.data.floor_data do
				self._floorStateList[arg_8_1.data.floor_data[iter_8_0].floor] = {}

				for iter_8_1 = 1, #arg_8_1.data.floor_data[iter_8_0].had_get do
					self._floorStateList[arg_8_1.data.floor_data[iter_8_0].floor][arg_8_1.data.floor_data[iter_8_0].had_get[iter_8_1]] = true
				end
			end
		end

		self:_updateCurFloor()

		self._drawNum = arg_8_1.data.draw_num or 0
		self._cumulativeAwardIds = arg_8_1.data.all_draw_award_ids or {}
		self._finalJigsawAward = arg_8_1.data.final_jigsaw_award
		self._curSignDays = arg_8_1.data.cur_sign_days or 0
		self._awardSignDays = arg_8_1.data.award_sign_days or 0
		self._todayShareCount = arg_8_1.data.daily_share_times or 0
		self._getshareTime = arg_8_1.data.daily_get_share_times or 0

		if arg_8_1.data.award_jigsaws then
			for iter_8_2, iter_8_3 in ipairs(arg_8_1.data.award_jigsaws) do
				self._groupAwardMaps[iter_8_3] = true
			end
		end

		if arg_8_1.data.history_times then
			for iter_8_4, iter_8_5 in ipairs(arg_8_1.data.history_times) do
				self._historyIdMaps[iter_8_5.id] = iter_8_5.num
			end
		end
	end
end

function AnniversaryData:onS2CAnniversaryTaskAward(arg_9_1)
	local var_9_0 = arg_9_1.id or {}

	for iter_9_0 = 1, #var_9_0 do
		self._taskData:onTaskAward(var_9_0[iter_9_0])
	end
end

function AnniversaryData:onS2CAnniversaryTaskNotify(arg_10_1)
	if arg_10_1.tasks then
		self._taskData:updateTaskData(arg_10_1.tasks)
	end
end

function AnniversaryData:onS2CAnniversaryGetFloorAward(arg_11_1)
	if arg_11_1.floor and arg_11_1.target then
		self._floorStateList[arg_11_1.floor] = self._floorStateList[arg_11_1.floor] or {}
		self._floorStateList[arg_11_1.floor][arg_11_1.target] = true

		self:_updateCurFloor()
	end
end

function AnniversaryData:onS2CAnniversaryDrawJigsaw(arg_12_1)
	if arg_12_1.ids then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1.ids) do
			self._historyIdMaps[iter_12_1] = self._historyIdMaps[iter_12_1] or 0
			self._historyIdMaps[iter_12_1] = self._historyIdMaps[iter_12_1] + 1
		end
	end

	if arg_12_1.real_num then
		self._drawNum = self._drawNum + arg_12_1.real_num
	end
end

function AnniversaryData:onS2CAnniversaryGetJigsawGroupAward(arg_13_1)
	if arg_13_1.group then
		self._groupAwardMaps[arg_13_1.group] = true
	end
end

function AnniversaryData:onS2CAnniversaryGetShareJigsaw(arg_14_1)
	if arg_14_1.uid and arg_14_1.item_id and arg_14_1.time then
		self._saveShareData = g.core.common.Storage:load("anniversary_share_record.json", true) or {}

		local var_14_0 = table.concat({
			arg_14_1.uid,
			arg_14_1.item_id,
			arg_14_1.time
		}, "_")

		self._saveShareData[var_14_0] = self._saveShareData[var_14_0] or true
	end

	if arg_14_1.awards then
		self._getshareTime = self._getshareTime + 1
	end

	g.core.common.Storage:save("anniversary_share_record.json", self._saveShareData, true)
end

function AnniversaryData:onS2CAnniversaryGetDrawNumAward(arg_15_1)
	if arg_15_1.id then
		table.insert(self._cumulativeAwardIds, arg_15_1.id)
	end
end

function AnniversaryData:onS2CAnniversaryGetTotalScoreAward()
	self._finalJigsawAward = true
end

function AnniversaryData:onS2CAnniversarySignDay(arg_17_1)
	self._awardSignDays = self._curSignDays
	self._curSignAwardId = 0

	if not arg_17_1.awards then
		if arg_17_1.extra_awards then
			for iter_17_0, iter_17_1 in ipairs((self:getSignAwards())) do
				if self._curSignDays >= iter_17_1.num then
					self._curSignAwardId = iter_17_1.id
				end
			end
		end
	end
end

function AnniversaryData:getTaskData()
	return self._taskData
end

function AnniversaryData:getActivityId()
	return self._activityId
end

function AnniversaryData:getAnniversaryInfo()
	return var_0_3.get(self._activityId)
end

function AnniversaryData:getCurFloor()
	return self._curFloor
end

function AnniversaryData:getMaxFloor()
	return self._maxFloor
end

function AnniversaryData:getCurScore()
	return (g.core.model.User.bagData:getOwnNum(var_0_0.SCORE_TYPE, var_0_0.SCORE_VALUE))
end

function AnniversaryData:getCumulativeDrawNum()
	return self._drawNum
end

function AnniversaryData:getCurSignDay()
	return self._curSignDays
end

function AnniversaryData:getAwardSignDays()
	return self._awardSignDays
end

function AnniversaryData:getCurSignAwardId()
	return self._curSignAwardId
end

function AnniversaryData:getCurFloorAwardList(arg_28_1)
	arg_28_1 = arg_28_1 or self._curFloor

	local var_28_0 = {}
	local var_28_1 = var_0_5.match(function(arg_29_0)
		return arg_29_0.activity_id == self._activityId and arg_29_0.floor == arg_28_1
	end)

	if #var_28_1 > 0 then
		for iter_28_0 = 1, var_0_0.FLOOR_AWARD_NUM do
			local var_28_2 = var_28_1[1]["score_" .. iter_28_0]
			local var_28_3 = g.core.common.Drops:getGoodsArray(var_28_1[1]["drop_" .. iter_28_0])
			local var_28_4 = var_0_0.FLOOR_AWARD.NOT_GET

			if self._floorStateList[arg_28_1] and self._floorStateList[arg_28_1][iter_28_0] then
				var_28_4 = var_0_0.FLOOR_AWARD.DONE
			elseif var_28_2 <= self:getCurScore() then
				var_28_4 = var_0_0.FLOOR_AWARD.CAN_GET
			end

			table.insert(var_28_0, {
				scoreNum = var_28_2,
				awards = var_28_3,
				state = var_28_4
			})
		end
	end

	return var_28_0
end

function AnniversaryData:isOpenDaysAvailable()
	return g.core.common.ServerTime:getOpenDays() >= self._openServerDays
end

function AnniversaryData:getCurStage()
	if not self:isOpenDaysAvailable() then
		return var_0_0.STAGE.NOT_OPEN
	end

	local var_31_0 = g.core.common.ServerTime:getTime()

	if var_31_0 >= self._activityOpenTime and var_31_0 < self._activityShowTime then
		return var_0_0.STAGE.GAME
	elseif var_31_0 >= self._activityShowTime and var_31_0 < self._activityEndTime then
		return var_0_0.STAGE.SHOW
	else
		return var_0_0.STAGE.NOT_OPEN
	end
end

function AnniversaryData:getCampaignStr()
	local var_32_0 = self:getCurStage()

	if var_32_0 == var_0_0.STAGE.GAME then
		return g.core.lang:get(431609)
	elseif var_32_0 == var_0_0.STAGE.SHOW then
		return g.core.lang:get(430913)
	elseif var_32_0 == var_0_0.STAGE.NOT_OPEN then
		return g.core.lang:get(430914)
	end
end

function AnniversaryData:getCurStageFinishTime()
	local var_33_0 = self:getCurStage()

	if var_33_0 == var_0_0.STAGE.GAME then
		return self._activityShowTime
	elseif var_33_0 == var_0_0.STAGE.SHOW then
		return self._activityEndTime
	elseif var_33_0 == var_0_0.STAGE.NOT_OPEN then
		return 0
	end
end

function AnniversaryData:isActivityOpen(arg_34_1)
	arg_34_1 = arg_34_1 or self._activityId

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ANNIVERSARY) or arg_34_1 ~= self._activityId or not self:isOpenDaysAvailable() then
		return false
	end

	return self:getCurStage() ~= var_0_0.STAGE.NOT_OPEN
end

function AnniversaryData:isInActivityTime()
	local var_35_0 = g.core.common.ServerTime:getTime()

	return var_35_0 >= self._activityOpenTime and var_35_0 <= self._activityEndTime
end

function AnniversaryData:getTimeData()
	local var_36_0 = 0
	local var_36_1 = 0
	local var_36_2 = 0

	if self:isActivityOpen() then
		var_36_2 = self._activityEndTime
		var_36_1 = self._activityShowTime
		var_36_0 = self._activityOpenTime
	end

	return var_36_0, var_36_1, var_36_2
end

function AnniversaryData:getActivityEndTime(arg_37_1)
	arg_37_1 = arg_37_1 or self._activityId

	if arg_37_1 ~= self._activityId then
		return 0
	end

	return self._activityEndTime
end

function AnniversaryData:getActivityShowTime(arg_38_1)
	arg_38_1 = arg_38_1 or self._activityId

	if arg_38_1 ~= self._activityId then
		return 0
	end

	return self._activityShowTime
end

function AnniversaryData:isInActivityGameTime(arg_39_1)
	arg_39_1 = arg_39_1 or self._activityId

	if arg_39_1 ~= self._activityId then
		return false
	end

	if not self:isActivityOpen(arg_39_1) then
		return false
	end

	return self:getCurStage() == var_0_0.STAGE.GAME
end

function AnniversaryData:getShopTabList()
	if #self._shopTabList == 0 then
		self:_initShopInfo()
	end

	return self._shopTabList
end

function AnniversaryData:getShopTabSellList(arg_41_1)
	if #self._shopTabList == 0 then
		self:_initShopInfo()
	end

	return self._shopTabSellList[arg_41_1]
end

function AnniversaryData:initCumulativeAwardMap()
	for iter_42_0, iter_42_1 in var_0_9.ipairs() do
		self._cumulativeAwardMap[iter_42_1.activity_id] = self._cumulativeAwardMap[iter_42_1.activity_id] or {}

		table.insert(self._cumulativeAwardMap[iter_42_1.activity_id], iter_42_1)
	end
end

function AnniversaryData:getCumulativeAwards()
	if self._cumulativeAwardMap[self._activityId] then
		return self._cumulativeAwardMap[self._activityId]
	end

	self:initCumulativeAwardMap()

	return self._cumulativeAwardMap[self._activityId]
end

function AnniversaryData:initSignAwardMap()
	for iter_44_0, iter_44_1 in var_0_7.ipairs() do
		self._signAwardMap[iter_44_1.activity_id] = self._signAwardMap[iter_44_1.activity_id] or {}

		table.insert(self._signAwardMap[iter_44_1.activity_id], iter_44_1)
	end
end

function AnniversaryData:getSignAwards()
	if self._signAwardMap[self._activityId] then
		return self._signAwardMap[self._activityId]
	end

	self:initSignAwardMap()

	return self._signAwardMap[self._activityId]
end

function AnniversaryData:getJigSawAllCollectedAward()
	return (g.core.common.Drops:getGoodsArray(self:getAnniversaryInfo().jigsaw))
end

function AnniversaryData:initJigsawData()
	for iter_47_0, iter_47_1 in var_0_8.ipairs() do
		self._jigsawMap[iter_47_1.activity_id] = self._jigsawMap[iter_47_1.activity_id] or {}

		table.insert(self._jigsawMap[iter_47_1.activity_id], iter_47_1)
	end

	self:_initJigsawPosData()
end

function AnniversaryData:_initJigsawPosData()
	for iter_48_0 = 1, #self._jigsawMap[self._activityId] do
		self._jigsawGroupInfo[self._jigsawMap[self._activityId][iter_48_0].group] = self._jigsawGroupInfo[self._jigsawMap[self._activityId][iter_48_0].group] or {}
		self._jigsawGroupInfo[self._jigsawMap[self._activityId][iter_48_0].group] = self._jigsawMap[self._activityId][iter_48_0]

		while var_0_8.hasKey("jigsaw_" .. 1) do
			self._jigsawPosById[self._jigsawMap[self._activityId][iter_48_0]["jigsaw_" .. 1]] = self._jigsawPosById[self._jigsawMap[self._activityId][iter_48_0]["jigsaw_" .. 1]] or {
				x = self._jigsawMap[self._activityId][iter_48_0].group,
				y = 1
			}
			self._jigsawIdByPos[self._jigsawMap[self._activityId][iter_48_0].group] = self._jigsawIdByPos[self._jigsawMap[self._activityId][iter_48_0].group] or {}
			self._jigsawIdByPos[self._jigsawMap[self._activityId][iter_48_0].group][1] = self._jigsawIdByPos[self._jigsawMap[self._activityId][iter_48_0].group][1] or {}
			self._jigsawIdByPos[self._jigsawMap[self._activityId][iter_48_0].group][1] = self._jigsawMap[self._activityId][iter_48_0]["jigsaw_" .. 1]
		end
	end
end

function AnniversaryData:getJigsawIdByPos(arg_49_1, arg_49_2)
	return self._jigsawIdByPos[arg_49_1][arg_49_2]
end

function AnniversaryData:getJigsawPosById(arg_50_1)
	return self._jigsawPosById[arg_50_1]
end

function AnniversaryData:getJigsawGroupInfo(arg_51_1)
	return self._jigsawGroupInfo[arg_51_1]
end

function AnniversaryData:getOwnJigsaws()
	local var_52_0 = {}

	for iter_52_0, iter_52_1 in pairs(self._historyIdMaps) do
		local var_52_1 = self:getJigsawPosById(iter_52_0)

		if var_52_1 then
			local var_52_2 = var_0_2:getOwnNum(g.core.common.Goods.TYPE_ITEM, iter_52_0)

			if not self:isGetGroupAward(var_52_1.x) then
				var_52_2 = var_52_2 - 1
			end

			if var_52_2 > 0 then
				table.insert(var_52_0, {
					jigsawId = iter_52_0,
					num = var_52_2
				})
			end
		end
	end

	return var_52_0
end

function AnniversaryData:isGetSharejigsaw(arg_53_1, arg_53_2, arg_53_3)
	self._saveShareData = g.core.common.Storage:load("anniversary_share_record.json", true) or {}

	return self._saveShareData[table.concat({
		arg_53_1,
		arg_53_2,
		arg_53_3
	}, "_")]
end

function AnniversaryData:getJigsawCumulativeState(arg_54_1)
	if not self:isGetCumulativeAward(arg_54_1) then
		if self._drawNum >= var_0_9.get(arg_54_1).num then
			return var_0_0.CUMULATIVE_AWARD.CAN_GET
		else
			return var_0_0.CUMULATIVE_AWARD.NOT_GET
		end
	else
		return var_0_0.CUMULATIVE_AWARD.DONE
	end
end

function AnniversaryData:isGetCumulativeAward(arg_55_1)
	for iter_55_0, iter_55_1 in ipairs(self._cumulativeAwardIds) do
		if iter_55_1 == arg_55_1 then
			return true
		end
	end

	return false
end

function AnniversaryData:getDrawJigsawTime(arg_56_1)
	return self._historyIdMaps[arg_56_1] or 0
end

function AnniversaryData:isGetGroupAward(arg_57_1)
	return self._groupAwardMaps[arg_57_1]
end

function AnniversaryData:isCanGetGroupAwardById(arg_58_1)
	local var_58_0 = self:getJigsawPosById(arg_58_1).x
	local var_58_1 = true
	local var_58_2 = self:getJigsawGroupInfo(var_58_0)

	for iter_58_0 = 1, var_0_0.JIGSAW_LEN_NUM do
		if g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_58_2["jigsaw_" .. iter_58_0]) <= 0 then
			var_58_1 = false

			break
		end
	end

	if not self:isGetGroupAward(var_58_0) and var_58_1 then
		return true, var_58_0
	else
		return false
	end
end

function AnniversaryData:getCanGetGroupAward()
	for iter_59_0 = 1, var_0_0.JIGSAW_GROUP_NUM do
		local var_59_0 = self:isGetGroupAward(iter_59_0)
		local var_59_1 = self:getJigsawGroupInfo(iter_59_0)
		local var_59_2 = true

		if var_59_1 then
			for iter_59_1 = 1, var_0_0.JIGSAW_LEN_NUM do
				if g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, var_59_1["jigsaw_" .. iter_59_1]) <= 0 then
					var_59_2 = false

					break
				end
			end
		end

		if not var_59_0 and var_59_2 then
			return iter_59_0
		end
	end

	return 0
end

function AnniversaryData:isCanGetTotalScoreAward()
	for iter_60_0, iter_60_1 in pairs(self._jigsawGroupInfo) do
		if not self:isGetGroupAward(iter_60_1.group) then
			return false
		end
	end

	if self._finalJigsawAward then
		return false
	end

	return true
end

function AnniversaryData:isGetFinallyBigAward()
	return self._finalJigsawAward
end

function AnniversaryData:getTodayShareLimitNum()
	return var_0_4.get(4).parameter
end

function AnniversaryData:getTodayShareAwardMaxNum()
	return var_0_4.get(5).parameter
end

function AnniversaryData:getCurShareTimes()
	return self._todayShareCount
end

function AnniversaryData:getShareAwardTimes()
	return self._getshareTime
end

function AnniversaryData:getActivityResource(arg_66_1, arg_66_2)
	if not self._activityId then
		return
	end

	local var_66_0 = self:getAnniversaryInfo().file_type or 1

	return (table.concat({
		arg_66_1,
		"/anniversary/",
		var_66_0,
		"/",
		arg_66_2
	}))
end

function AnniversaryData:isHaveFloorReward()
	if not self:isActivityOpen() then
		return false
	end

	local var_67_0 = self:getCurFloorAwardList()

	for iter_67_0 = 1, #var_67_0 do
		if var_67_0[iter_67_0].state == var_0_0.FLOOR_AWARD.CAN_GET then
			return true
		end
	end

	return false
end

function AnniversaryData:getLocalServerFriends()
	local var_68_0 = {}

	for iter_68_0, iter_68_1 in ipairs((g.core.model.User.friendData:getFriendList())) do
		if not iter_68_1:isCrossServerFriend() then
			table.insert(var_68_0, iter_68_1)
		end
	end

	return var_68_0
end

function AnniversaryData:isHaveTaskReward(arg_69_1)
	if not self:isInActivityGameTime() then
		return false
	end

	if arg_69_1.index then
		return #self._taskData:getCanRewardTaskList((arg_69_1.index == 1 or nil) and (var_0_0.TASK_TYPE.DAILY or var_0_0.TASK_TYPE.SEASON)) > 0
	else
		return self._taskData:isCanRewardTask()
	end
end

function AnniversaryData:isHaveFireItem()
	if not self:isActivityOpen() then
		return false
	end

	local var_70_0 = self:getAnniversaryInfo()

	return g.core.model.User.bagData:getOwnNum(var_70_0.item_type, var_70_0.item_value) > 0
end

function AnniversaryData:isHaveJigsawDrawCost()
	if not self:isInActivityGameTime() then
		return false
	end

	local var_71_0 = self:getAnniversaryInfo()

	return g.core.model.User.bagData:getOwnNum(var_71_0.recruited_type, var_71_0.recruited_value) > 0
end

function AnniversaryData:isHaveCumulativeAward(arg_72_1)
	if not self:isInActivityGameTime() then
		return false
	end

	if arg_72_1.id then
		if self:getJigsawCumulativeState(arg_72_1.id) == var_0_0.CUMULATIVE_AWARD.CAN_GET then
			return true
		end
	else
		for iter_72_0, iter_72_1 in ipairs((self:getCumulativeAwards())) do
			if self:getJigsawCumulativeState(iter_72_1.id) == var_0_0.CUMULATIVE_AWARD.CAN_GET then
				return true
			end
		end
	end

	return false
end

return AnniversaryData
