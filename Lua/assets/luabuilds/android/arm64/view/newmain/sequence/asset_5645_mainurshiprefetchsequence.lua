local MainUrShipReFetchSequence = class("MainUrShipReFetchSequence", import("...base.ContextMediator"))

MainUrShipReFetchSequence.ON_TIME_UP = "MainUrShipReFetchSequence:ON_TIME_UP"

function MainUrShipReFetchSequence:Ctor()
	MainUrShipReFetchSequence.super.Ctor(self, BaseEventLogic.New())
	pg.m02:registerMediator(self)

	return
end

function MainUrShipReFetchSequence:Execute(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_GRAFTING)

	if #var_2_0 == 0 then
		arg_2_1()

		return
	end

	self:CheckUrShipAct(var_2_0, arg_2_1)

	return
end

local function var_0_1(arg_3_0)
	local var_3_0 = getProxy(ActivityProxy):getActivityById(arg_3_0)

	return var_3_0 and not var_3_0:isEnd()
end

local function var_0_2(arg_4_0)
	return arg_4_0 == ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1 or arg_4_0 == ActivityConst.ACTIVITY_TYPE_BUILD or arg_4_0 == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD
end

local function var_0_3(arg_5_0)
	if not arg_5_0 or arg_5_0:isEnd() then
		return false
	end

	local var_5_0 = arg_5_0:getConfig("config_id")

	if var_0_1(var_5_0) then
		return false
	end

	return pg.activity_template[var_5_0] and var_0_2(pg.activity_template[var_5_0].type)
end

function MainUrShipReFetchSequence:CheckUrShipAct(arg_6_1, arg_6_2)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if var_0_3(iter_6_1) then
			table.insert(var_6_0, function(arg_7_0)
				self:TryFetchUrShips(iter_6_1, arg_7_0)

				return
			end)
		end
	end

	seriesAsync(var_6_0, arg_6_2)

	return
end

local function var_0_4(arg_8_0)
	local var_8_0 = getProxy(ActivityProxy):getActivityById(arg_8_0)

	if not var_8_0 or var_8_0:isEnd() then
		return false
	end

	local var_8_1 = pg.ship_data_create_exchange[var_8_0:getConfig("config_id")]

	return var_8_0.data2 < var_8_1.exchange_available_times and math.min(var_8_1.exchange_available_times, var_8_0.data2 + 1) * var_8_1.exchange_request <= var_8_0.data1
end

function MainUrShipReFetchSequence:TryFetchUrShips(arg_9_1, arg_9_2)
	if var_0_4(arg_9_1.id) then
		self:ShowFetchShipMsgbox(arg_9_1.id, function()
			self:TryFetchUrShips(arg_9_1, arg_9_2)

			return
		end)
	else
		arg_9_2()
	end

	return
end

function MainUrShipReFetchSequence:ShowFetchShipMsgbox(arg_11_1, arg_11_2)
	self.callback = arg_11_2
	self.page = UrShipRefetchWindow.New(pg.UIMgr.GetInstance().UIMain)

	self.page:ExecuteAction("Show", arg_11_1)

	return
end

function MainUrShipReFetchSequence:listNotificationInterests()
	return {
		GAME.GRAFTING_ACT_OP_DONE,
		MainUrShipReFetchSequence.ON_TIME_UP
	}
end

function MainUrShipReFetchSequence:handleNotification(arg_13_1)
	local var_13_0 = arg_13_1:getName()
	local var_13_1 = arg_13_1:getBody()

	if var_13_0 == GAME.GRAFTING_ACT_OP_DONE and var_0_2(var_13_1.linkActType) then
		if #var_13_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_13_1.awards, self.callback)
		else
			self.callback()
		end

		if self.page and self.page:GetLoaded() and self.page:isShowing() then
			self.page:Hide()
		end

		self.callback = nil
	elseif var_13_0 == MainUrShipReFetchSequence.ON_TIME_UP then
		if self.page and self.page:GetLoaded() and self.page:isShowing() then
			self.page:Hide()
		end

		if self.callback then
			self.callback()

			self.callback = nil
		end
	end

	return
end

function MainUrShipReFetchSequence:Clear()
	if self.page then
		self.page:Destroy()

		self.page = nil
	end

	return
end

function MainUrShipReFetchSequence:Dispose()
	pg.m02:removeMediator(self.__cname)
	self:Clear()

	return
end

function MainUrShipReFetchSequence:addSubLayers(arg_16_1, arg_16_2, arg_16_3)
	assert(isa(arg_16_1, Context), "should be an instance of Context")

	local var_16_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(NewMainMediator)

	if arg_16_2 then
		while var_16_0.parent do
			var_16_0 = var_16_0.parent
		end
	end

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {
		parentContext = var_16_0,
		context = arg_16_1,
		callback = arg_16_3
	})

	return
end

return MainUrShipReFetchSequence
