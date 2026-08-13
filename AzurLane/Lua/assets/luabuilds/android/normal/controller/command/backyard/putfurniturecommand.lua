class = var_0_10000

local var_0_0 = "PutFurnitureCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().furnsPos
	local var_1_1 = var_2.tip
	local var_1_2 = var_2.callback

	getProxy = var_1_10006
	DormProxy = var_1_10007

	if not var_1_10006(var_1_10007) then
		return
	end

	local var_1_3

	if not var_2.floor then
		var_1_3 = var_6.floor
	end

	assert = var_1_10008

	var_1_10008(var_1_3, "floor should exist")

	local var_1_4 = var_6:getRawData().level

	CourtYardRawDataChecker = var_10

	local var_1_5 = var_10.Check
	local var_1_6 = var_1_0
	local var_1_7 = var_8
	local var_1_8, var_1_9 = var_1_5(var_1_6, var_8.GetMapSize(var_1_7))

	if not var_1_8 then
		if var_1_2 then
			var_1_2(false, var_1_9)

			return
		end

		pg = var_12
		var_1_7 = var_12.TipsMgr.GetInstance()

		var_12.ShowTips(var_1_7, var_1_9)

		return
	end

	local var_1_10 = {}

	pairs = var_1_7

	for iter_1_0, iter_1_1 in var_1_7(var_1_0) do
		local var_1_11 = {}

		pairs = var_1_10019

		for iter_1_2, iter_1_3 in var_1_10019(iter_1_1.child) do
			table = var_1_10024
			var_1_10024 = var_1_10024.insert

			local var_1_12 = var_1_11
			local var_1_13 = {}

			tostring = var_1_10027
			var_1_13.id = var_1_10027(iter_1_2)
			var_1_13.x = iter_1_3.x
			var_1_13.y = iter_1_3.y

			var_1_10024(var_1_12, var_1_13)
		end

		table = var_1_10019
		var_1_10019 = var_1_10019.insert

		local var_1_14 = var_1_10
		local var_1_15 = {
			shipId = 1
		}

		tostring = iter_1_2
		var_1_15.id = iter_1_2(iter_1_1.configId)
		var_1_15.x = iter_1_1.x
		var_1_15.y = iter_1_1.y
		var_1_15.dir = iter_1_1.dir
		var_1_15.child = var_1_11
		var_1_15.parent = iter_1_1.parent

		var_1_10019(var_1_14, var_1_15)
	end

	local var_1_16 = var_6:getRawData()
	local var_1_17 = var_13.SetTheme
	local var_1_18 = var_1_3

	BackYardSelfThemeTemplate = iter_1_0

	var_1_17(var_1_16, var_1_18, iter_1_0.New({
		id = -1,
		furniture_put_list = var_1_10
	}, var_1_3))

	pg = var_1_17

	local var_1_19 = var_1_17.ConnectionMgr.GetInstance()

	var_13.Send(var_1_19, 19008, {
		floor = var_1_3,
		furniture_put_list = var_1_10
	})

	if var_1_1 then
		pg = var_13

		local var_1_20 = var_13.TipsMgr.GetInstance()
		local var_1_21 = var_13.ShowTips

		i18n = var_15

		var_1_21(var_1_20, var_15("backyard_putFurniture_ok"))
	end

	local var_1_22 = arg_1_0
	local var_1_23 = arg_1_0.sendNotification

	GAME = var_15

	var_1_23(var_1_22, var_15.PUT_FURNITURE_DONE)

	if var_1_2 then
		var_1_2(true)
	end

	return
end

return var_0_1
