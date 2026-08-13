class = var_0_10000

local var_0_0 = "AddBackYardThemeTemplateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	DormProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getRawData(var_1_2).level

	CourtYardRawDataChecker = var_1_10005

	local var_1_4 = var_1_10005.Check
	local var_1_5 = var_1_1.furnitureputList
	local var_1_6 = var_3
	local var_1_7, var_1_8 = var_1_4(var_1_5, var_3.GetMapSize(var_1_6))

	if not var_1_7 then
		pg = var_7
		var_1_6 = var_7.TipsMgr.GetInstance()

		var_7.ShowTips(var_1_6, var_1_8)

		return
	end

	local var_1_9 = {}

	pairs = var_1_6

	for iter_1_0, iter_1_1 in var_1_6(var_1_1.furnitureputList) do
		local var_1_10 = {}

		pairs = var_1_10014

		for iter_1_2, iter_1_3 in var_1_10014(iter_1_1.child) do
			table = var_1_10019
			var_1_10019 = var_1_10019.insert

			local var_1_11 = var_1_10
			local var_1_12 = {}

			tostring = var_1_10022
			var_1_12.id = var_1_10022(iter_1_2)
			var_1_12.x = iter_1_3.x
			var_1_12.y = iter_1_3.y

			var_1_10019(var_1_11, var_1_12)
		end

		table = var_1_10014
		var_1_10014 = var_1_10014.insert

		local var_1_13 = var_1_9
		local var_1_14 = {
			shipId = 1
		}

		tostring = iter_1_2
		var_1_14.id = iter_1_2(iter_1_1.configId)
		var_1_14.x = iter_1_1.x
		var_1_14.y = iter_1_1.y
		var_1_14.dir = iter_1_1.dir
		var_1_14.child = var_1_10
		var_1_14.parent = iter_1_1.parent

		var_1_10014(var_1_13, var_1_14)
	end

	local var_1_15 = {
		pos = var_1_1.id,
		name = var_1_1.name,
		furniture_put_list = var_1_9,
		icon_image_md5 = var_1_1.iconMd5,
		image_md5 = var_1_1.imageMd5
	}

	pg = var_9

	local var_1_16 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_16, 19109, var_1_15, 19110, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			DormProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			BackYardBaseThemeTemplate = var_2_10002
			var_2_10003.id, var_2_10003 = var_2_10002.BuildId(var_1_1.id), var_1_15
			BackYardSelfThemeTemplate = var_2_10003
			var_2_10003 = var_2_10003.New(var_1_15)

			var_2_0:AddCustomThemeTemplate(var_2_10003)

			local var_2_1 = arg_1_0
			local var_2_2 = var_4.sendNotification

			GAME = var_6

			var_2_2(var_2_1, var_6.BACKYARD_SAVE_THEME_TEMPLATE_DONE)
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_4(var_2_3, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
