local FeastProxy = class("FeastProxy", import("model.proxy.NetProxy"))

function FeastProxy:register()
	return
end

local function var_0_1(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0:getRawData() ~= nil then
		arg_2_2()

		return
	end

	arg_2_0:sendNotification(GAME.GET_FEAST_DATA, {
		activityId = arg_2_1.id,
		callback = arg_2_2
	})

	return
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:getConfig("config_data")
	local var_3_1 = var_3_0[1] or 5

	if not arg_3_0:getRawData():ShouldRandomShips() then
		arg_3_2()

		return
	end

	local var_3_2 = var_3_0[3]
	local var_3_3

	if not var_3_0[3] then
		var_3_2 = {}
		var_3_3 = {
			activityId = arg_3_1.id,
			cmd = FeastDorm.OP_RANDOM_SHIPS
		}
	end

	var_3_3.argList = _.map(arg_3_0:RandomShips(var_3_2, var_3_1), function(arg_4_0)
		return arg_4_0.id
	end)
	var_3_3.callback = arg_3_2

	arg_3_0:sendNotification(GAME.FEAST_OP, var_3_3)

	return
end

function FeastProxy:RequestData(arg_5_1)
	local var_5_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	if not var_5_0 or var_5_0:isEnd() then
		arg_5_1()

		return
	end

	seriesAsync({
		function(arg_6_0)
			var_0_1(self, var_5_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			var_0_2(self, var_5_0, arg_7_0)

			return
		end
	}, arg_5_1)

	return
end

function FeastProxy:SetData(arg_8_1)
	assert(isa(arg_8_1, FeastDorm))

	self.data = arg_8_1

	self:AddRefreshTimer()

	return
end

function FeastProxy:UpdateData(arg_9_1)
	assert(isa(arg_9_1, FeastDorm))

	self.data = arg_9_1

	return
end

function FeastProxy:GetConsumeList()
	local var_10_0 = getProxy(ActivityProxy)
	local var_10_1 = var_10_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST):getConfig("config_data")[3]

	return pg.activity_partyinvitation_template[((not var_10_0 or nil) and {})[1]].invitationID[2], pg.activity_partyinvitation_template[((not var_10_0 or nil) and {})[1]].giftID[2]
end

local function var_0_3(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs((_.filter(pg.ship_data_group.all, function(arg_12_0)
		return pg.ship_data_group[arg_12_0].handbook_type ~= 1
	end))) do
		if arg_11_0[pg.ship_data_group[iter_11_1].group_type] then
			table.insert(var_11_0, arg_11_0[pg.ship_data_group[iter_11_1].group_type])
		else
			table.insert(var_11_0, ShipGroup.New({
				id = pg.ship_data_group[iter_11_1].group_type
			}))
		end
	end

	return var_11_0, {}
end

local function var_0_4(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		if not table.contains(arg_13_1, iter_13_1.id) then
			table.insert(var_13_0, iter_13_1)
		end
	end

	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		for iter_13_4, iter_13_5 in ipairs((ShipGroup.getSkinList(iter_13_3.id))) do
			table.insert(ShipSkin.GetShopTypeIdBySkinId(iter_13_5.id, var_13_3) == 7 and var_13_1 or var_13_2, iter_13_3)
		end
	end

	shuffle(var_13_1)
	shuffle(var_13_2)

	for iter_13_6, iter_13_7 in ipairs(var_13_1) do
		if table.getCount(arg_13_2) == arg_13_3 then
			break
		end

		arg_13_2[iter_13_7.id] = iter_13_7
	end

	for iter_13_8, iter_13_9 in ipairs(var_13_2) do
		if table.getCount(arg_13_2) == arg_13_3 then
			break
		end

		arg_13_2[iter_13_9.id] = iter_13_9
	end

	return
end

function FeastProxy:RandomShips(arg_14_1, arg_14_2)
	local var_14_0 = pg.activity_partyinvitation_template or {}
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		table.insert(var_14_1, var_14_0[iter_14_1].groupid)
	end

	for iter_14_2, iter_14_3 in pairs((self:getRawData():GetFeastShipList())) do
		if not table.contains(var_14_1, iter_14_2) then
			table.insert(var_14_1, iter_14_2)
		end
	end

	local var_14_2, var_14_3 = var_0_3((getProxy(CollectionProxy):RawgetGroups()))
	local var_14_4 = {}

	var_0_4(var_14_2, var_14_1, var_14_4, arg_14_2)
	var_0_4(var_14_3, var_14_1, var_14_4, arg_14_2)

	local var_14_5 = {}

	for iter_14_4, iter_14_5 in pairs(var_14_4) do
		table.insert(var_14_5, iter_14_5)
	end

	return var_14_5
end

function FeastProxy:AddRefreshTimer()
	self:RemoveRefreshTimer()

	self.timer = Timer.New(function()
		self:RemoveRefreshTimer()

		local var_16_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

		if var_16_0 and not var_16_0:isEnd() then
			var_0_2(self, var_16_0, function()
				return
			end)
		end

		return
	end, GetZeroTime() - pg.TimeMgr.GetInstance():GetServerTime() + 1, 1)

	self.timer:Start()

	return
end

function FeastProxy:RemoveRefreshTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function FeastProxy:remove()
	self:RemoveRefreshTimer()

	return
end

function FeastProxy:GetBuffList()
	local var_20_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_PT_ACT)

	if not var_20_0 or var_20_0:isEnd() then
		return {}
	end

	return var_20_0:GetBuffList()
end

function FeastProxy:GetTaskList()
	local var_21_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_TASK_ACT)

	assert(var_21_0)

	local var_21_1 = {}
	local var_21_2 = getProxy(TaskProxy)

	for iter_21_0, iter_21_1 in ipairs(var_21_0:getConfig("config_data")) do
		if var_21_2:getTaskById(iter_21_1) or var_21_2:getFinishTaskById(iter_21_1) then
			table.insert(var_21_1, iter_21_1)
		end
	end

	return var_21_1
end

function FeastProxy:GetPtActData()
	local var_22_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_PT_ACT)

	assert(var_22_0)

	return (ActivityPtData.New(var_22_0))
end

function FeastProxy:GetSubmittedTaskStories()
	local var_23_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FEAST)

	if not var_23_0 or var_23_0:isEnd() then
		return {}
	end

	local var_23_1 = var_23_0:getConfig("config_client")
	local var_23_2 = {}

	for iter_23_0, iter_23_1 in ipairs({
		var_23_1[8],
		var_23_1[9]
	}) do
		if not pg.NewStoryMgr.GetInstance():IsPlayed(iter_23_1[2]) then
			var_23_2[iter_23_1[1]] = iter_23_1[2]
		end
	end

	return var_23_2
end

function FeastProxy:ShouldTipPt()
	if self:GetPtActData():AnyAwardCanGet() then
		return true
	end

	return false
end

function FeastProxy:ShouldTipFeastTask()
	local var_25_0 = getProxy(TaskProxy)

	for iter_25_0, iter_25_1 in ipairs((self:GetTaskList())) do
		local var_25_1 = var_25_0:getTaskById(iter_25_1)

		if var_25_1 and var_25_1:isFinish() and not var_25_1:isReceive() then
			return true
		end
	end

	return false
end

function FeastProxy:ShouldTipTask()
	if self:ShouldTipPt() then
		return true
	end

	if self:ShouldTipFeastTask() then
		return true
	end

	return false
end

function FeastProxy:ShouldTipInvitation()
	local var_27_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)
	local var_27_1, var_27_2 = self:GetConsumeList()
	local var_27_3 = var_27_0:getVitemNumber(var_27_1)
	local var_27_4 = var_27_0:getVitemNumber(var_27_2)

	for iter_27_0, iter_27_1 in ipairs((self.data:GetInvitedFeastShipList())) do
		if not iter_27_1:GotGift() and var_27_4 > 0 or not iter_27_1:GotTicket() and var_27_3 > 0 then
			return true
		end
	end

	return false
end

function FeastProxy:ShouldTip()
	if not self.data then
		return false
	end

	local var_28_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_TASK_ACT)

	if not var_28_0 or var_28_0:isEnd() then
		return false
	end

	local var_28_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.FEAST_PT_ACT)

	if not var_28_1 or var_28_1:isEnd() then
		return false
	end

	local var_28_2 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	if not var_28_2 or var_28_2:isEnd() then
		return false
	end

	if self.data == nil then
		return false
	end

	for iter_28_0, iter_28_1 in pairs((self.data:GetFeastShipList())) do
		if iter_28_1:HasBubble() then
			return true
		end
	end

	if self:ShouldTipTask() then
		return true
	end

	if self:ShouldTipInvitation() then
		return true
	end

	return false
end

function FeastProxy:HandleTaskStories(arg_29_1, arg_29_2)
	local var_29_0 = self:GetSubmittedTaskStories()

	if not var_29_0 or table.getCount(var_29_0) == 0 then
		if arg_29_2 then
			arg_29_2()
		end

		return
	end

	local var_29_1 = {}

	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if var_29_0[iter_29_1] ~= nil then
			table.insert(var_29_1, var_29_0[iter_29_1])
		end
	end

	if #var_29_1 > 0 then
		if arg_29_2 then
			pg.NewStoryMgr.GetInstance():SeriesPlay(var_29_1, arg_29_2)
		else
			pg.NewStoryMgr.GetInstance():SeriesPlay(var_29_1)
		end
	end

	return
end

return FeastProxy
