class = var_0_10000

local var_0_0 = "SaveDormThemeCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	DormProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getRawData(var_1_1).level

	CourtYardRawDataChecker = var_1_1

	local var_1_3, var_1_4 = var_1_1.Check(var_1_0.furnitureputList, var_3:GetMapSize())

	if not var_1_3 then
		pg = var_7

		local var_1_5 = var_7.TipsMgr.GetInstance()

		var_7.ShowTips(var_1_5, var_1_4)

		return
	end

	local var_1_6 = {}

	pairs = var_8

	for iter_1_0, iter_1_1 in var_8(var_1_0.furnitureputList) do
		local var_1_7 = {}

		pairs = var_1_10014

		for iter_1_2, iter_1_3 in var_1_10014(iter_1_1.child) do
			table = var_1_10019
			var_1_10019 = var_1_10019.insert

			local var_1_8 = var_1_7
			local var_1_9 = {}

			tostring = var_1_10023
			var_1_9.id = var_1_10023(iter_1_2)
			var_1_9.x = iter_1_3.x
			var_1_9.y = iter_1_3.y

			var_1_10019(var_1_8, var_1_9)
		end

		table = var_1_10014
		var_1_10014 = var_1_10014.insert

		local var_1_10 = var_1_6
		local var_1_11 = {
			shipId = 0
		}

		tostring = iter_1_3
		var_1_11.id = iter_1_3(iter_1_1.configId)
		var_1_11.x = iter_1_1.x
		var_1_11.y = iter_1_1.y
		var_1_11.dir = iter_1_1.dir
		var_1_11.child = var_1_7
		var_1_11.parent = iter_1_1.parent

		var_1_10014(var_1_10, var_1_11)
	end

	local var_1_12 = {
		id = var_1_0.id,
		name = var_1_0.name,
		furniture_put_list = var_1_6
	}

	pg = var_9

	local var_1_13 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_13, 19020, var_1_12, 19021, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			DormProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			var_1.AddTheme(var_2_10004, var_1_12)

			var_2_10004 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_5

			var_2_0(var_2_10004, var_5.SAVE_DORMTHEME_DONE)

			pg = var_2_0
			var_2_10004 = var_2_0.TipsMgr.GetInstance()

			var_2.ShowTips(var_2_10004, "保存成功")
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_2(var_2_1, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
