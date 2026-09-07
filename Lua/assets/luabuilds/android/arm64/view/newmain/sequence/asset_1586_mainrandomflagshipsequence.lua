local MainRandomFlagShipSequence = class("MainRandomFlagShipSequence")

function MainRandomFlagShipSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(SettingsProxy):GetRandomFlagShipList()

	if #var_1_0 > 0 and underscore.all(var_1_0, function(arg_2_0)
		return getProxy(BayProxy):GetShipPhantom(arg_2_0) == nil
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_off_0"))
		getProxy(SettingsProxy):UpdateRandomFlagShipList({})
		arg_1_1()

		return
	end

	local var_1_1, var_1_2 = self:ShouldRandom()

	if var_1_1 then
		local var_1_3 = self:Random()

		if not var_1_3 or #var_1_3 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_off_0"))
			self:SynToCache({}, var_1_2)
		else
			self:SynToCache(var_1_3, var_1_2)
		end
	end

	arg_1_1()

	return
end

local function var_0_1(arg_3_0)
	local var_3_0 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_3_1 = GetZeroTime() - 18000

	if var_3_0 < var_3_1 - 39600 and arg_3_0 < var_3_1 - 39600 - 46800 then
		return true, var_3_1 - 39600 - 46800
	end

	if var_3_1 - 39600 <= var_3_0 and var_3_0 < var_3_1 and arg_3_0 < var_3_1 - 39600 then
		return true, var_3_1 - 39600
	end

	if var_3_1 <= var_3_0 and arg_3_0 < var_3_1 then
		return true, var_3_1
	end

	return false
end

function MainRandomFlagShipSequence:ShouldRandom()
	if not getProxy(SettingsProxy):IsOpenRandomFlagShip() then
		return false
	end

	return var_0_1((getProxy(SettingsProxy):GetPrevRandomFlagShipTime()))
end

local function var_0_2(arg_5_0, arg_5_1)
	if arg_5_1:isActivityNpc() then
		return false
	end

	if arg_5_0 == SettingsRandomFlagShipAndSkinPanel.SHIP_FREQUENTLYUSED then
		return arg_5_1.phantomId == 0 and arg_5_1:GetPreferenceTag() ~= 0
	elseif arg_5_0 == SettingsRandomFlagShipAndSkinPanel.SHIP_LOCKED then
		return arg_5_1.phantomId == 0 and arg_5_1:GetLockState() ~= 0
	elseif arg_5_0 == SettingsRandomFlagShipAndSkinPanel.COUSTOM then
		-- block empty
	end

	return true
end

local function var_0_3(arg_6_0, arg_6_1)
	local function var_6_0(arg_7_0, arg_7_1, arg_7_2)
		if not arg_7_0[arg_7_2.groupId] then
			arg_7_0[arg_7_2.groupId] = {}

			table.insert(arg_7_1, arg_7_2.groupId)
		end

		table.insert(arg_7_0[arg_7_2.groupId], arg_7_2:GetShipPhantomMark())

		return
	end

	local var_6_1 = getProxy(BayProxy)
	local var_6_2

	if arg_6_0 == SettingsRandomFlagShipAndSkinPanel.COUSTOM then
		var_6_2 = var_6_1:getRandomFlagShipPhantomMarks()
	end

	local var_6_6
	local var_6_4
	local var_6_3
	local var_6_5

	do
		var_6_2 = var_6_1:getAllShipPhantomMarks()
		var_6_3 = {}
		var_6_4 = {}
		var_6_5 = {}
		var_6_6 = {}
	end

	for iter_6_0, iter_6_1 in pairs((var_6_1:getShipPhantomList(var_6_2))) do
		if var_0_2(arg_6_0, iter_6_1) then
			if arg_6_1[iter_6_1.groupId] then
				var_6_0(var_6_5, var_6_6, iter_6_1)
			else
				var_6_0(var_6_3, var_6_4, iter_6_1)
			end
		end
	end

	return var_6_3, var_6_4, var_6_5, var_6_6
end

local function var_0_4(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		local var_8_1, var_8_2 = ShipPhantom.UnpackMark(iter_8_1)
		local var_8_3 = getProxy(BayProxy):RawGetShipById(var_8_1)

		if var_8_3 then
			var_8_0[var_8_3.groupId] = true
		end
	end

	return var_8_0
end

function MainRandomFlagShipSequence:Random()
	local var_9_0, var_9_1 = PlayerVitaeShipsPage.GetSlotMaxCnt()
	local var_9_2, var_9_3, var_9_4, var_9_5 = var_0_3(getProxy(PlayerProxy):getRawData():GetRandomFlagShipMode(), (var_0_4(getProxy(SettingsProxy):GetRandomFlagShipList())))

	return (self:RandomShips(var_9_1, var_9_2, var_9_3, var_9_4, var_9_5))
end

function MainRandomFlagShipSequence:RandomShips(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = {}

	for iter_10_0 = 1, arg_10_1 do
		local var_10_2
		local var_10_1

		if #arg_10_3 == 0 and #arg_10_5 == 0 then
			do return var_10_0 end

			var_10_1 = #arg_10_3 == 0 and arg_10_5 or arg_10_3
			var_10_2 = var_10_1[math.random(1, #var_10_1)]
		end

		local var_10_3 = (#arg_10_3 == 0 and arg_10_4 or arg_10_2)[var_10_2] or {}

		if #var_10_3 > 0 then
			local var_10_4 = var_10_3[math.random(1, #var_10_3)]

			table.insert(var_10_0, var_10_4)
			table.removebyvalue(var_10_3, var_10_4)
		end

		if #var_10_3 == 0 then
			table.removebyvalue(var_10_1, var_10_2)
		end
	end

	return var_10_0
end

function MainRandomFlagShipSequence:SynToCache(arg_11_1, arg_11_2)
	getProxy(SettingsProxy):UpdateRandomFlagShipList(arg_11_1)
	getProxy(SettingsProxy):SetPrevRandomFlagShipTime(arg_11_2)

	return
end

return MainRandomFlagShipSequence
