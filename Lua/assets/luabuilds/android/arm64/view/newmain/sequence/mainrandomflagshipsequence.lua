local var_0_0 = class("MainRandomFlagShipSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(SettingsProxy):GetRandomFlagShipList()

	if #var_1_0 > 0 and underscore.all(var_1_0, function(arg_2_0)
		local var_2_0 = getProxy(BayProxy)

		return var_2_0:GetShipPhantom(arg_2_0) == nil
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_off_0"))
		getProxy(SettingsProxy):UpdateRandomFlagShipList({})
		arg_1_1()

		return
	end

	local var_1_1, var_1_2 = arg_1_0:ShouldRandom()

	if var_1_1 then
		local var_1_3 = arg_1_0:Random()

		if not var_1_3 or #var_1_3 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_off_0"))
			arg_1_0:SynToCache({}, var_1_2)
		else
			arg_1_0:SynToCache(var_1_3, var_1_2)
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

function var_0_0.ShouldRandom(arg_4_0)
	if not getProxy(SettingsProxy):IsOpenRandomFlagShip() then
		return false
	end

	local var_4_0 = getProxy(SettingsProxy)

	return var_0_1((var_4_0:GetPrevRandomFlagShipTime()))
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
	local var_6_0 = getProxy(BayProxy)
	local var_6_1 = arg_6_0 == SettingsRandomFlagShipAndSkinPanel.COUSTOM and var_6_0:getRandomFlagShipPhantomMarks() or var_6_0:getAllShipPhantomMarks()

	for iter_6_0, iter_6_1 in pairs((var_6_0:getShipPhantomList(var_6_1))) do
		if var_0_2(arg_6_0, iter_6_1) then
			if arg_6_1[iter_6_1.groupId] then
				(function(arg_7_0, arg_7_1, arg_7_2)
					if not arg_7_0[arg_7_2.groupId] then
						arg_7_0[arg_7_2.groupId] = {}

						table.insert(arg_7_1, arg_7_2.groupId)
					end

					table.insert(arg_7_0[arg_7_2.groupId], arg_7_2:GetShipPhantomMark())

					return
				end)({}, {}, iter_6_1)
			else
				(function(arg_7_0, arg_7_1, arg_7_2)
					if not arg_7_0[arg_7_2.groupId] then
						arg_7_0[arg_7_2.groupId] = {}

						table.insert(arg_7_1, arg_7_2.groupId)
					end

					table.insert(arg_7_0[arg_7_2.groupId], arg_7_2:GetShipPhantomMark())

					return
				end)({}, {}, iter_6_1)
			end
		end
	end

	return {}, {}, {}, {}
end

local function var_0_4(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
		local var_8_0, var_8_1 = ShipPhantom.UnpackMark(iter_8_1)
		local var_8_2 = getProxy(BayProxy):RawGetShipById(var_8_0)

		if var_8_2 then
			({})[var_8_2.groupId] = true
		end
	end

	return {}
end

function var_0_0.Random(arg_9_0)
	local var_9_0, var_9_1 = PlayerVitaeShipsPage.GetSlotMaxCnt()
	local var_9_2, var_9_3, var_9_4, var_9_5 = var_0_3(getProxy(PlayerProxy):getRawData():GetRandomFlagShipMode(), (var_0_4(getProxy(SettingsProxy):GetRandomFlagShipList())))

	return (arg_9_0:RandomShips(var_9_1, var_9_2, var_9_3, var_9_4, var_9_5))
end

function var_0_0.RandomShips(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	for iter_10_0 = 1, arg_10_1 do
		local var_10_0, var_10_1

		if #arg_10_3 == 0 and #arg_10_5 == 0 then
			do return {} end

			var_10_0 = #arg_10_3 == 0 and arg_10_5 or arg_10_3
			var_10_1 = var_10_0[math.random(1, #var_10_0)]
		end

		local var_10_2 = (#arg_10_3 == 0 and arg_10_4 or arg_10_2)[var_10_1] or {}

		if #var_10_2 > 0 then
			local var_10_3 = var_10_2[math.random(1, #var_10_2)]

			table.insert({}, var_10_3)
			table.removebyvalue(var_10_2, var_10_3)
		end

		if #var_10_2 == 0 then
			table.removebyvalue(var_10_0, var_10_1)
		end
	end

	return {}
end

function var_0_0.SynToCache(arg_11_0, arg_11_1, arg_11_2)
	getProxy(SettingsProxy):UpdateRandomFlagShipList(arg_11_1)
	getProxy(SettingsProxy):SetPrevRandomFlagShipTime(arg_11_2)

	return
end

return var_0_0
