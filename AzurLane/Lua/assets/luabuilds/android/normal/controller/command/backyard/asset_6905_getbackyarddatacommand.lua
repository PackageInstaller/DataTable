class = var_0_10000

local var_0_0 = "GetBackYardDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().data
	local var_1_1 = var_2.isMine
	local var_1_2
	local var_1_3 = {}

	if var_1_1 then
		Dorm = var_1_10007
		var_1_2 = var_1_10007.New(var_1_0)
		ipairs = var_1_10007

		local var_1_4

		if not var_1_0.ship_list then
			var_1_4 = {}
		end

		for iter_1_0, iter_1_1 in var_1_10007(var_1_4) do
			DormShip = var_1_10012
			var_1_10012 = var_1_10012.New(iter_1_1)
			table = var_1_10013

			var_1_10013.insert(var_1_3, var_1_10012)
		end
	else
		FriendDorm = var_1_10007
		var_1_2 = var_1_10007.New(var_1_0)
		ipairs = var_7

		local var_1_5

		if not var_1_0.ship_list then
			var_1_5 = {}
		end

		for iter_1_2, iter_1_3 in var_7(var_1_5) do
			FriendDormShip = var_1_10012
			var_1_10012 = var_1_10012.New(iter_1_3)
			table = var_1_10013

			var_1_10013.insert(var_1_3, var_1_10012)
		end
	end

	local var_1_6 = var_1_2

	var_1_2.SetShips(var_1_6, var_1_3)

	local var_1_7 = {}

	ipairs = var_1_6

	for iter_1_4, iter_1_5 in var_1_6(var_1_0.furniture_id_list) do
		Furniture = var_1_10013
		var_1_10013 = var_1_10013.New(iter_1_5)
		tonumber = var_1_10014
		var_1_7[var_1_10014(var_1_10013.id)] = var_1_10013
	end

	local var_1_8 = var_1_2

	var_1_2.SetFurnitures(var_1_8, var_1_7)

	local var_1_9 = 1

	BackYardConst = var_1_8

	for iter_1_6 = var_1_9, var_1_8.MAX_FLOOR_CNT do
		local var_1_10 = var_1_2
		local var_1_11 = var_1_2.SetTheme

		var_1_10014 = iter_1_6
		BackYardSelfThemeTemplate = var_1_10015

		var_1_11(var_1_10, var_1_10014, var_1_10015.New({
			id = -1,
			furniture_put_list = {}
		}, iter_1_6))
	end

	ipairs = var_1_9

	for iter_1_7, iter_1_8 in var_1_9(var_1_0.furniture_put_list) do
		local var_1_12 = {}

		ipairs = var_1_10014

		for iter_1_9, iter_1_10 in var_1_10014(iter_1_8.furniture_put_list) do
			local var_1_13 = {}

			ipairs = var_1_10020

			for iter_1_11, iter_1_12 in var_1_10020(iter_1_10.child) do
				table = var_1_10025

				var_1_10025.insert(var_1_13, {
					id = iter_1_12.id,
					x = iter_1_12.x,
					y = iter_1_12.y
				})
			end

			var_1_10020 = {
				id = iter_1_10.id,
				x = iter_1_10.x,
				y = iter_1_10.y,
				dir = iter_1_10.dir,
				child = var_1_13,
				parent = iter_1_10.parent,
				shipId = iter_1_10.shipId
			}
			table = var_21

			var_21.insert(var_1_12, var_1_10020)
		end

		local var_1_14 = var_1_2

		var_1_10014 = var_1_2.SetTheme

		local var_1_15 = iter_1_8.floor

		BackYardSelfThemeTemplate = iter_1_9

		var_1_10014(var_1_14, var_1_15, iter_1_9.New({
			id = -1,
			furniture_put_list = var_1_12
		}, iter_1_8.floor))
	end

	getProxy = var_8
	DormProxy = var_9

	local var_1_16 = var_8(var_9)

	if var_1_1 then
		var_1_16:addDorm(var_1_2)
	else
		var_1_16.friendData = var_1_2
	end

	local var_1_17 = arg_1_0
	local var_1_18 = arg_1_0.sendNotification

	GAME = iter_1_7

	var_1_18(var_1_17, iter_1_7.GET_BACKYARD_DATA_DONE, var_1_2)

	return
end

return var_0_1
