class = var_0_10000

local var_0_0 = var_0_10000("MainRandomFlagShipSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	SettingsProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	if #var_2.GetRandomFlagShipList(var_1_0) > 0 then
		underscore = var_3

		if var_3.all(var_2, function(arg_2_0)
			getProxy = var_2_10001
			BayProxy = var_2_10003

			local var_2_0 = var_2_10001(var_2_10003)

			return var_1.GetShipPhantom(var_2_0, arg_2_0) == nil
		end) then
			pg = var_3

			local var_1_1 = var_3.TipsMgr.GetInstance()
			local var_1_2 = var_3.ShowTips

			i18n = var_1_10006

			var_1_2(var_1_1, var_1_10006("random_ship_off_0"))

			getProxy = var_1_2
			SettingsProxy = var_1_1

			local var_1_3 = var_1_2(var_1_1)

			var_3.UpdateRandomFlagShipList(var_1_3, {})
			arg_1_1()

			return
		end
	end

	local var_1_4, var_1_5 = arg_1_0:ShouldRandom()

	if var_1_4 then
		if not arg_1_0:Random() or #var_5 == 0 then
			pg = var_1_10006

			local var_1_6 = var_1_10006.TipsMgr.GetInstance()
			local var_1_7 = var_6.ShowTips

			i18n = var_1_10009

			var_1_7(var_1_6, var_1_10009("random_ship_off_0"))
			arg_1_0:SynToCache({}, var_1_5)
		else
			arg_1_0:SynToCache(var_5, var_1_5)
		end
	end

	arg_1_1()

	return
end

local function var_0_1(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerTime(var_3_0)

	GetZeroTime = var_1_10002

	local var_3_2 = var_1_10002() - 18000 - 39600 - 46800

	if var_3_1 < var_3 and arg_3_0 < var_3_2 then
		return true, var_3_2
	end

	if var_3 <= var_3_1 and var_3_1 < var_2 and arg_3_0 < var_3 then
		return true, var_3
	end

	if var_2 <= var_3_1 and arg_3_0 < var_2 then
		return true, var_2
	end

	return false
end

function var_0_0.ShouldRandom(arg_4_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	if not var_1.IsOpenRandomFlagShip(var_4_0) then
		return false
	end

	getProxy = var_1
	SettingsProxy = var_4_0

	local var_4_1 = var_1(var_4_0)
	local var_4_2 = var_1.GetPrevRandomFlagShipTime(var_4_1)

	return var_0_1(var_4_2)
end

local function var_0_2(arg_5_0, arg_5_1)
	if arg_5_1:isActivityNpc() then
		return false
	end

	SettingsRandomFlagShipAndSkinPanel = var_2

	local var_5_0

	if arg_5_0 == var_2.SHIP_FREQUENTLYUSED then
		var_5_0 = arg_5_1.phantomId == 0 and arg_5_1:GetPreferenceTag() ~= 0

		return var_5_0
	else
		SettingsRandomFlagShipAndSkinPanel = var_5_0

		local var_5_1

		if arg_5_0 == var_5_0.SHIP_LOCKED then
			var_5_1 = arg_5_1.phantomId == 0 and arg_5_1:GetLockState() ~= 0

			return var_5_1
		else
			SettingsRandomFlagShipAndSkinPanel = var_5_1

			if arg_5_0 == var_5_1.COUSTOM then
				-- block empty
			end
		end
	end

	return true
end

local function var_0_3(arg_6_0, arg_6_1)
	local function var_6_0(arg_7_0, arg_7_1, arg_7_2)
		if not arg_7_0[arg_7_2.groupId] then
			arg_7_0[arg_7_2.groupId] = {}
			table = var_3

			var_3.insert(arg_7_1, arg_7_2.groupId)
		end

		table = var_3

		var_3.insert(arg_7_0[arg_7_2.groupId], arg_7_2:GetShipPhantomMark())

		return
	end

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_6_1 = var_1_10003(var_1_10005)
	local var_6_2

	SettingsRandomFlagShipAndSkinPanel = var_1_10005

	if arg_6_0 == var_1_10005.COUSTOM then
		var_6_2 = var_6_1:getRandomFlagShipPhantomMarks()
	else
		var_6_2 = var_6_1:getAllShipPhantomMarks()
	end

	local var_6_3 = var_6_1:getShipPhantomList(var_6_2)
	local var_6_4 = {}
	local var_6_5 = {}
	local var_6_6 = {}
	local var_6_7 = {}

	pairs = var_1_10010

	for iter_6_0, iter_6_1 in var_1_10010(var_6_3) do
		if var_0_2(arg_6_0, iter_6_1) then
			if arg_6_1[iter_6_1.groupId] then
				var_6_0(var_6_6, var_6_7, iter_6_1)
			else
				var_6_0(var_6_4, var_6_5, iter_6_1)
			end
		end
	end

	return var_6_4, var_6_5, var_6_6, var_6_7
end

local function var_0_4(arg_8_0)
	local var_8_0 = {}

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0) do
		ShipPhantom = var_1_10007

		local var_8_1

		var_1_10007, var_8_1 = var_1_10007.UnpackMark(iter_8_1)
		getProxy = var_9
		BayProxy = var_1_10011
		var_1_10011 = var_9(var_1_10011)

		if var_9.RawGetShipById(var_1_10011, var_1_10007) then
			var_8_0[var_9.groupId] = true
		end
	end

	return var_8_0
end

function var_0_0.Random(arg_9_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_9_0 = var_1_10001(var_1_10003)
	local var_9_1 = var_1.getRawData(var_9_0)
	local var_9_2 = var_1.GetRandomFlagShipMode(var_9_1)

	PlayerVitaeShipsPage = var_9_0

	local var_9_3, var_9_4 = var_9_0.GetSlotMaxCnt()
	local var_9_5 = var_0_4

	getProxy = var_1_10007
	SettingsProxy = var_1_10009

	local var_9_6 = var_1_10007(var_1_10009)
	local var_9_7 = var_9_5(var_7.GetRandomFlagShipList(var_9_6))
	local var_9_8, var_9_9, var_9_10, var_9_11 = var_0_3(var_9_2, var_9_7)

	return (arg_9_0:RandomShips(var_9_4, var_9_8, var_9_9, var_9_10, var_9_11))
end

function var_0_0.RandomShips(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = {}

	for iter_10_0 = 1, arg_10_1 do
		if #arg_10_3 == 0 and #arg_10_5 == 0 then
			return var_10_0
		end

		local var_10_1 = #arg_10_3 == 0 and arg_10_5 or arg_10_3
		local var_10_2 = var_11 and arg_10_4 or arg_10_2

		math = var_1_10014

		local var_10_3

		if not var_10_2[var_10_1[var_1_10014.random(1, #var_10_1)]] then
			var_10_3 = {}
		end

		local var_10_4 = #var_10_3

		if 0 < var_10_4 then
			math = var_10_4

			local var_10_5 = var_10_3[var_10_4.random(1, #var_10_3)]

			table = var_17

			var_17.insert(var_10_0, var_10_5)

			table = var_17

			var_17.removebyvalue(var_10_3, var_10_5)
		end

		if #var_10_3 == 0 then
			table = var_16

			var_16.removebyvalue(var_10_1, var_1_10014)
		end
	end

	return var_10_0
end

function var_0_0.SynToCache(arg_11_0, arg_11_1, arg_11_2)
	getProxy = var_1_10003
	SettingsProxy = var_1_10005

	local var_11_0 = var_1_10003(var_1_10005)

	var_3.UpdateRandomFlagShipList(var_11_0, arg_11_1)

	getProxy = var_3
	SettingsProxy = var_11_0

	local var_11_1 = var_3(var_11_0)

	var_3.SetPrevRandomFlagShipTime(var_11_1, arg_11_2)

	return
end

return var_0_0
