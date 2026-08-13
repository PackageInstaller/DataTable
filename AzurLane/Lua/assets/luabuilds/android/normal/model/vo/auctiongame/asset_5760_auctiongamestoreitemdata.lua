class = var_0_10000

local var_0_0 = var_0_10000("AuctionGameStoreItemData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.name = arg_1_1.name
	arg_1_0.rarity = arg_1_1.rarity
	AuctionGameTools = var_2
	arg_1_0.contour = var_2.GetPosRange(arg_1_1.pos)
	arg_1_0.value = arg_1_1.value
	arg_1_0.position = arg_1_1.pos[1]

	local var_1_0

	if arg_1_1.id and arg_1_1.id ~= 0 then
		pg = var_2
		arg_1_0.price = var_2.auction_collection[arg_1_0.id].value
		var_1_0 = arg_1_0

		arg_1_0.SetShowContour(var_1_0)
	end

	local var_1_1 = ""

	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_1.pos) do
		local var_1_2 = var_1_1

		string = var_1_10009
		var_1_1 = var_1_2 .. var_1_10009.format("{%s, %s}", iter_1_1.x, iter_1_1.y)
	end

	print = var_3

	local var_1_3 = "uid"
	local var_1_4 = arg_1_1.uid
	local var_1_5 = "id"
	local var_1_6 = arg_1_1.id
	local var_1_7 = "稀有度："
	local var_1_8 = arg_1_0.rarity

	string = var_1_10010

	local var_1_9 = var_1_10010.format("位置： {%s, %s}", arg_1_0.position.x, arg_1_0.position.y)

	string = var_11

	var_3(var_1_3, var_1_4, var_1_5, var_1_6, var_1_7, var_1_8, var_1_9, var_11.format("轮廓：{%s,%s}", arg_1_0.contour[1], arg_1_0.contour[2]), "占位:" .. var_1_1)

	return
end

function var_0_0.SetRevealFlag(arg_2_0, arg_2_1)
	arg_2_0.revealFlag = arg_2_1

	return
end

function var_0_0.GetReveal(arg_3_0)
	return arg_3_0.revealFlag
end

function var_0_0.UpdateContour(arg_4_0, arg_4_1)
	AuctionGameTools = var_1_10002
	arg_4_0.contour = var_1_10002.GetPosRange(arg_4_1)

	return
end

function var_0_0.InitContour(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.contour = {
		arg_5_1,
		arg_5_2
	}

	return
end

function var_0_0.UpdateRarity(arg_6_0, arg_6_1)
	arg_6_0.rarity = arg_6_1

	return
end

function var_0_0.UpdatePos(arg_7_0, arg_7_1)
	arg_7_0.position = arg_7_1

	return
end

function var_0_0.SetShowContour(arg_8_0)
	arg_8_0.showContour = true

	return
end

function var_0_0.SetShowPos(arg_9_0)
	arg_9_0.showPos = true

	return
end

function var_0_0.SetShowRarity(arg_10_0)
	arg_10_0.showRarity = true

	return
end

function var_0_0.GetEstimateValue(arg_11_0)
	if arg_11_0.id ~= nil and arg_11_0.id ~= 0 then
		pg = var_1

		return var_1.auction_collection[arg_11_0.id].value, var_1
	end

	local var_11_0 = {}

	if arg_11_0.showRarity ~= true and arg_11_0.showContour ~= true then
		Clone = var_2
		pg = var_1_10003
		var_11_0 = var_2(var_1_10003.auction_collection.all)
	else
		local var_11_1 = {}

		if arg_11_0.showRarity then
			Clone = var_3
			pg = var_1_10004
			var_11_1 = var_3(var_1_10004.auction_collection.get_id_list_by_rarity[arg_11_0.rarity])
		else
			Clone = var_3
			pg = var_1_10004
			var_11_1 = var_3(var_1_10004.auction_collection.all)
		end

		if arg_11_0.showContour then
			ipairs = var_3

			for iter_11_0, iter_11_1 in var_3(var_11_1) do
				pg = var_1_10008
				var_1_10008 = var_1_10008.auction_collection[iter_11_1].contour

				if arg_11_0.contour[1] == var_1_10008[1] and arg_11_0.contour[2] == var_1_10008[2] then
					table = var_1_10009

					var_1_10009.insert(var_11_0, iter_11_1)
				end
			end
		else
			var_11_0 = var_11_1
		end
	end

	local var_11_2 = 0
	local var_11_3 = 0

	ipairs = var_1_10004

	for iter_11_2, iter_11_3 in var_1_10004(var_11_0) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.auction_collection[iter_11_3]

		if var_11_2 == 0 or var_11_2 > var_1_10009.value then
			var_11_2 = var_1_10009.value
		end

		if var_11_3 == 0 or var_11_3 < var_1_10009.value then
			var_11_3 = var_1_10009.value
		end
	end

	return var_11_2, var_11_3
end

return var_0_0
