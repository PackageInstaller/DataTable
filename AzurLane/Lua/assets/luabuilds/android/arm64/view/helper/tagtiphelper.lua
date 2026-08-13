class = var_0_10000

local var_0_0 = var_0_10000("TagTipHelper")

function var_0_0.FuDaiTagTip(arg_1_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_1_0, false)

	local var_1_0 = {}

	pg = var_1_10002

	local var_1_1 = var_1_10002.pay_data_display

	ipairs = var_3

	for iter_1_0, iter_1_1 in var_3(var_1_1.all) do
		if var_1_1[iter_1_1].type == 1 then
			pg = var_8

			local var_1_2 = var_8.TimeMgr.GetInstance()

			if var_8.inTime(var_1_2, var_1_1[iter_1_1].time) then
				type = var_8

				if var_8(var_1_1[iter_1_1].time) == "table" then
					table = var_8

					var_8.insert(var_1_0, var_1_1[iter_1_1])
				end
			end
		end
	end

	local var_1_3 = #var_1_0

	if 0 < var_1_3 then
		local function var_1_4(arg_2_0)
			table = var_2_10001

			var_2_10001.sort(var_1_0, function(arg_3_0, arg_3_1)
				pg = var_3_10002

				local var_3_0 = var_3_10002.TimeMgr.GetInstance()
				local var_3_1 = var_2.parseTimeFromConfig(var_3_0, arg_3_0.time[1])

				pg = var_3_10003

				local var_3_2 = var_3_10003.TimeMgr.GetInstance()

				return var_3_1 > var_3.parseTimeFromConfig(var_3_2, arg_3_1.time[1])
			end)

			local var_2_0 = arg_2_0[var_1_0[1].id] ~= nil

			pg = var_3

			local var_2_1 = var_3.TimeMgr.GetInstance()
			local var_2_2 = var_3.parseTimeFromConfig(var_2_1, var_1.time[1])

			PlayerPrefs = var_4

			local var_2_3 = var_4.GetInt("Ever_Enter_Mall_", 0)

			if not var_2_0 and var_2_3 < var_2_2 then
				local var_2_4 = var_0_0

				var_2_4.FudaiTime = var_2_2
				triggerToggle = var_2_4

				var_2_4(arg_1_0, true)
			end

			return
		end

		getProxy = var_4
		ShopsProxy = iter_1_0

		local var_1_5 = var_4(iter_1_0)

		if not var_4.getChargedList(var_1_5) then
			pg = iter_1_0

			local var_1_6 = iter_1_0.m02
			local var_1_7 = var_6.sendNotification

			GAME = var_1_10009

			var_1_7(var_1_6, var_1_10009.GET_CHARGE_LIST, {
				callback = function()
					local var_4_0 = var_0

					var_0 = var_0.getChargedList(var_4_0)

					var_1_4(var_0)

					return
				end
			})
		else
			var_1_4(var_5)
		end
	end

	return
end

function var_0_0.SetFuDaiTagMark()
	if var_0_0.FudaiTime then
		PlayerPrefs = var_0

		var_0.SetInt("Ever_Enter_Mall_", var_0_0.FudaiTime)

		PlayerPrefs = var_0

		var_0.Save()

		var_0_0.FudaiTime = nil
	end

	return
end

function var_0_0.SkinTagTip(arg_6_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_6_0, false)

	getProxy = var_1_10001
	ShipSkinProxy = var_3

	local var_6_0 = var_1_10001(var_3)
	local var_6_1 = var_1.GetAllSkins(var_6_0)
	local var_6_2 = {}

	ipairs = var_6_0

	for iter_6_0, iter_6_1 in var_6_0(var_6_1) do
		local var_6_3 = iter_6_1.type

		Goods = var_1_10009

		if var_6_3 == var_1_10009.TYPE_SKIN then
			type = var_6_3

			if var_6_3(iter_6_1:getConfig("time")) == "table" then
				local var_6_4 = iter_6_1.genre

				ShopArgs = var_1_10009

				if var_6_4 ~= var_1_10009.SkinShopTimeLimit then
					table = var_6_4

					local var_6_5 = var_6_4.insert
					local var_6_6 = var_6_2

					pg = var_1_10011

					local var_6_7 = var_1_10011.TimeMgr.GetInstance()

					var_6_5(var_6_6, var_1_10011.parseTimeFromConfig(var_6_7, iter_6_1:getConfig("time")[1]))
				end
			end
		end
	end

	local var_6_8 = #var_6_2

	if 0 < var_6_8 then
		table = var_4

		var_4.sort(var_6_2, function(arg_7_0, arg_7_1)
			return arg_7_1 < arg_7_0
		end)

		local var_6_9 = var_6_2[1]

		PlayerPrefs = var_5

		local var_6_10

		if var_6_9 > var_5.GetInt("Ever_Enter_Skin_Shop_", 0) then
			var_6_10 = var_0_0
			var_6_10.SkinTime = var_6_9
		end

		triggerToggle = var_6_10

		var_6_10(arg_6_0, var_6)
	end

	return
end

function var_0_0.SetSkinTagMark()
	if var_0_0.SkinTime then
		PlayerPrefs = var_0

		var_0.SetInt("Ever_Enter_Skin_Shop_", var_0_0.SkinTime)

		PlayerPrefs = var_0

		var_0.Save()

		var_0_0.SkinTime = nil
	end

	return
end

function var_0_0.MonthCardTagTip(arg_9_0)
	MonthCardOutDateTipPanel = var_1_10001

	local var_9_0 = var_1_10001.GetShowMonthCardTag()

	triggerToggle = var_1_10002

	var_1_10002(arg_9_0, var_9_0)

	return
end

function var_0_0.GiftPackagesTag(arg_10_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10003

	local var_10_0 = var_1_10001(var_1_10003)

	var_1.GiftPackageRedDotTip(var_10_0, arg_10_0, nil)

	return
end

function var_0_0.FreeGiftTag(arg_11_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)

	if not var_1.getChargedList(var_11_0) then
		pg = var_1_10003

		local var_11_1 = var_1_10003.m02

		var_1_10003 = var_1_10003.sendNotification
		GAME = var_1_10006

		var_1_10003(var_11_1, var_1_10006.GET_CHARGE_LIST, {
			callback = function()
				_ = var_2_10000

				if var_2_10000.all(arg_11_0, function(arg_13_0)
					IsNil = var_3_10001

					return not var_3_10001(arg_13_0)
				end) then
					ipairs = var_0

					for iter_12_0, iter_12_1 in var_0(arg_11_0) do
						setActive = var_2_10005

						local var_12_0 = iter_12_1
						local var_12_1 = var_0

						var_2_10005(var_12_0, var_8.checkHasFreeNormal(var_12_1))
					end
				end

				return
			end
		})
	else
		ipairs = var_1_10003

		for iter_11_0, iter_11_1 in var_1_10003(arg_11_0) do
			setActive = var_1_10008

			var_1_10008(iter_11_1, var_1:checkHasFreeNormal())
		end
	end

	return
end

function var_0_0.FreeBuildTicketTip(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_14_0 = var_1_10002(var_1_10004)

	if var_2.IsShowFreeBuildMark(var_14_0, false) then
		setActive = var_1_10004

		var_1_10004(arg_14_0, true)

		LoadImageSpriteAtlasAsync = var_1_10004
		Drop = var_6

		local var_14_1 = var_6.New
		local var_14_2 = {}

		DROP_TYPE_VITEM = var_1_10009
		var_14_2.type = var_1_10009
		var_14_2.id = var_3:getConfig("config_client")[1]

		local var_14_3 = var_14_1(var_14_2)

		var_1_10004(var_6.getIcon(var_14_3), "", arg_14_0:Find("Image"))

		tostring = var_1_10004
		var_1_10004 = var_1_10004(var_3.data1)

		if var_3.data1 < 10 then
			var_1_10004 = var_1_10004 .. " "
		end

		setText = var_5

		local var_14_4 = arg_14_0:Find("Text")

		i18n = var_8

		var_5(var_14_4, var_8("build_ticket_expire_warning", var_1_10004))

		var_0_0.BuildMark = true
	else
		setActive = var_1_10004

		var_1_10004(arg_14_0, false)
	end

	return
end

function var_0_0.TecShipGiftTip(arg_15_0)
	local var_15_0 = {
		2001,
		2002,
		2003,
		2004,
		2005,
		2006,
		2007,
		2008
	}
	local var_15_1 = 30

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_15_2 = var_1_10003(var_1_10005)
	local var_15_3 = var_15_1 <= var_3.getData(var_15_2).level

	PlayerPrefs = var_15_2

	local var_15_4 = var_15_2.GetInt("Tec_Ship_Gift_Enter_Tag", 0) > 0
	local var_15_5 = false

	ipairs = var_7
	pg = var_1_10009

	for iter_15_0, iter_15_1 in var_7(var_1_10009.pay_data_display.all) do
		table = var_1_10012

		if var_1_10012.contains(var_15_0, iter_15_1) then
			var_15_5 = true

			break
		end
	end

	if var_15_5 and var_15_3 and not var_15_4 then
		triggerToggle = var_7

		var_7(arg_15_0, true)
	else
		triggerToggle = var_7

		var_7(arg_15_0, false)
	end

	return
end

function var_0_0.SetFreeBuildMark()
	if var_0_0.BuildMark then
		getProxy = var_0
		ActivityProxy = var_1_10002

		local var_16_0 = var_0(var_1_10002)

		if var_0.IsShowFreeBuildMark(var_16_0, false) then
			PlayerPrefs = var_1_10001

			local var_16_1 = var_1_10001.SetString
			local var_16_2 = "Free_Build_Ticket_" .. var_0.id

			pg = var_4

			local var_16_3 = var_4.TimeMgr.GetInstance()

			var_16_1(var_16_2, var_4.CurrentSTimeDesc(var_16_3, "%Y/%m/%d"))

			PlayerPrefs = var_16_1

			var_16_1.Save()
		end

		var_0_0.BuildMark = nil
	end

	return
end

return var_0_0
