local var_0_0 = class("AuctionGameStoreItemData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.name = arg_1_1.name
	arg_1_0.rarity = arg_1_1.rarity
	arg_1_0.contour = AuctionGameTools.GetPosRange(arg_1_1.pos)
	arg_1_0.value = arg_1_1.value
	arg_1_0.position = arg_1_1.pos[1]

	if arg_1_1.id and arg_1_1.id ~= 0 then
		arg_1_0.price = pg.auction_collection[arg_1_0.id].value

		arg_1_0:SetShowContour()
	end

	local var_1_0 = ""

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.pos) do
		var_1_0 = var_1_0 .. string.format("{%s, %s}", iter_1_1.x, iter_1_1.y)
	end

	print("uid", arg_1_1.uid, "id", arg_1_1.id, "稀有度：", arg_1_0.rarity, string.format("位置： {%s, %s}", arg_1_0.position.x, arg_1_0.position.y), string.format("轮廓：{%s,%s}", arg_1_0.contour[1], arg_1_0.contour[2]), "占位:" .. var_1_0)

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
	arg_4_0.contour = AuctionGameTools.GetPosRange(arg_4_1)

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
		return pg.auction_collection[arg_11_0.id].value, pg.auction_collection[arg_11_0.id].value
	end

	local var_11_0 = {}

	if arg_11_0.showRarity ~= true and arg_11_0.showContour ~= true then
		var_11_0 = Clone(pg.auction_collection.all)
	else
		local var_11_1 = {}

		var_11_1 = arg_11_0.showRarity and Clone(pg.auction_collection.get_id_list_by_rarity[arg_11_0.rarity]) or Clone(pg.auction_collection.all)

		if arg_11_0.showContour then
			for iter_11_0, iter_11_1 in ipairs(var_11_1) do
				if arg_11_0.contour[1] == pg.auction_collection[iter_11_1].contour[1] and arg_11_0.contour[2] == pg.auction_collection[iter_11_1].contour[2] then
					table.insert(var_11_0, iter_11_1)
				end
			end
		else
			var_11_0 = var_11_1
		end
	end

	local var_11_2 = 0
	local var_11_3 = 0

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_4 = pg.auction_collection[iter_11_3]

		if var_11_2 == 0 or var_11_2 > var_11_4.value then
			var_11_2 = var_11_4.value
		end

		if var_11_3 == 0 or var_11_3 < var_11_4.value then
			var_11_3 = var_11_4.value
		end
	end

	return var_11_2, var_11_3
end

return var_0_0
