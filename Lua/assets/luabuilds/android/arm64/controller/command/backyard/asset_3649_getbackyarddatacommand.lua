local GetBackYardDataCommand = class("GetBackYardDataCommand", pm.SimpleCommand)

function GetBackYardDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.data
	local var_1_2 = var_1_0.isMine
	local var_1_3
	local var_1_4 = {}

	if var_1_0.isMine then
		var_1_3 = Dorm.New(var_1_1)

		for iter_1_0, iter_1_1 in ipairs(var_1_1.ship_list or {}) do
			table.insert(var_1_4, (DormShip.New(iter_1_1)))
		end
	else
		var_1_3 = FriendDorm.New(var_1_1)

		for iter_1_2, iter_1_3 in ipairs(var_1_1.ship_list or {}) do
			table.insert(var_1_4, (FriendDormShip.New(iter_1_3)))
		end
	end

	var_1_3:SetShips(var_1_4)

	local var_1_5 = {}

	for iter_1_4, iter_1_5 in ipairs(var_1_1.furniture_id_list) do
		local var_1_6 = Furniture.New(iter_1_5)

		var_1_5[tonumber(var_1_6.id)] = var_1_6
	end

	var_1_3:SetFurnitures(var_1_5)

	for iter_1_6 = 1, BackYardConst.MAX_FLOOR_CNT do
		var_1_3:SetTheme(iter_1_6, BackYardSelfThemeTemplate.New({
			id = -1,
			furniture_put_list = {}
		}, iter_1_6))
	end

	for iter_1_7, iter_1_8 in ipairs(var_1_1.furniture_put_list) do
		local var_1_7 = {}

		for iter_1_9, iter_1_10 in ipairs(iter_1_8.furniture_put_list) do
			local var_1_8 = {}

			for iter_1_11, iter_1_12 in ipairs(iter_1_10.child) do
				table.insert(var_1_8, {
					id = iter_1_12.id,
					x = iter_1_12.x,
					y = iter_1_12.y
				})
			end

			table.insert(var_1_7, {
				id = iter_1_10.id,
				x = iter_1_10.x,
				y = iter_1_10.y,
				dir = iter_1_10.dir,
				child = var_1_8,
				parent = iter_1_10.parent,
				shipId = iter_1_10.shipId
			})
		end

		var_1_3:SetTheme(iter_1_8.floor, BackYardSelfThemeTemplate.New({
			id = -1,
			furniture_put_list = var_1_7
		}, iter_1_8.floor))
	end

	local var_1_9 = getProxy(DormProxy)

	if var_1_2 then
		var_1_9:addDorm(var_1_3)
	else
		var_1_9.friendData = var_1_3
	end

	self:sendNotification(GAME.GET_BACKYARD_DATA_DONE, var_1_3)

	return
end

return GetBackYardDataCommand
