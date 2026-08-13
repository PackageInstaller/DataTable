class = var_0_10000

local var_0_0 = "PutFurnitureCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().furnsPos
	local var_1_1 = var_2.tip
	local var_1_2 = var_2.callback

	getProxy = var_1_10006
	DormProxy = var_1_10008

	if not var_1_10006(var_1_10008) then
		return
	end

	local var_1_3

	if not var_2.floor then
		var_1_3 = var_6.floor
	end

	assert = var_1_10008

	var_1_10008(var_1_3, "floor should exist")

	local var_1_4 = var_6
	local var_1_5 = var_6.getRawData(var_1_4).level

	CourtYardRawDataChecker = var_1_4

	local var_1_6, var_1_7 = var_1_4.Check(var_1_0, var_8:GetMapSize())

	if not var_1_6 then
		if var_1_2 then
			var_1_2(false, var_1_7)

			return
		end

		pg = var_12

		local var_1_8 = var_12.TipsMgr.GetInstance()

		var_12.ShowTips(var_1_8, var_1_7)

		return
	end

	local var_1_9 = {}

	pairs = var_13

	for iter_1_0, iter_1_1 in var_13(var_1_0) do
		local var_1_10 = {}

		pairs = var_1_10019

		for iter_1_2, iter_1_3 in var_1_10019(iter_1_1.child) do
			table = var_1_10024
			var_1_10024 = var_1_10024.insert

			local var_1_11 = var_1_10
			local var_1_12 = {}

			tostring = var_1_10028
			var_1_12.id = var_1_10028(iter_1_2)
			var_1_12.x = iter_1_3.x
			var_1_12.y = iter_1_3.y

			var_1_10024(var_1_11, var_1_12)
		end

		table = var_1_10019
		var_1_10019 = var_1_10019.insert

		local var_1_13 = var_1_9
		local var_1_14 = {
			shipId = 1
		}

		tostring = iter_1_3
		var_1_14.id = iter_1_3(iter_1_1.configId)
		var_1_14.x = iter_1_1.x
		var_1_14.y = iter_1_1.y
		var_1_14.dir = iter_1_1.dir
		var_1_14.child = var_1_10
		var_1_14.parent = iter_1_1.parent

		var_1_10019(var_1_13, var_1_14)
	end

	local var_1_15 = var_6:getRawData()
	local var_1_16 = var_13.SetTheme
	local var_1_17 = var_1_3

	BackYardSelfThemeTemplate = iter_1_1

	var_1_16(var_1_15, var_1_17, iter_1_1.New({
		id = -1,
		furniture_put_list = var_1_9
	}, var_1_3))

	pg = var_1_16

	local var_1_18 = var_1_16.ConnectionMgr.GetInstance()

	var_13.Send(var_1_18, 19008, {
		floor = var_1_3,
		furniture_put_list = var_1_9
	})

	if var_1_1 then
		pg = var_13

		local var_1_19 = var_13.TipsMgr.GetInstance()
		local var_1_20 = var_13.ShowTips

		i18n = var_16

		var_1_20(var_1_19, var_16("backyard_putFurniture_ok"))
	end

	local var_1_21 = arg_1_0
	local var_1_22 = arg_1_0.sendNotification

	GAME = var_16

	var_1_22(var_1_21, var_16.PUT_FURNITURE_DONE)

	if var_1_2 then
		var_1_2(true)
	end

	return
end

return var_0_1
