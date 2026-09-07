local AuctionGameStoreItemData = class("AuctionGameStoreItemData")

function AuctionGameStoreItemData:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.uid = arg_1_1.uid
	self.name = arg_1_1.name
	self.rarity = arg_1_1.rarity
	self.contour = AuctionGameTools.GetPosRange(arg_1_1.pos)
	self.value = arg_1_1.value
	self.position = arg_1_1.pos[1]

	if arg_1_1.id and arg_1_1.id ~= 0 then
		self.price = pg.auction_collection[self.id].value

		self:SetShowContour()
	end

	local var_1_0 = ""

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.pos) do
		var_1_0 = var_1_0 .. string.format("{%s, %s}", iter_1_1.x, iter_1_1.y)
	end

	print("uid", arg_1_1.uid, "id", arg_1_1.id, "稀有度：", self.rarity, string.format("位置： {%s, %s}", self.position.x, self.position.y), string.format("轮廓：{%s,%s}", self.contour[1], self.contour[2]), "占位:" .. var_1_0)

	return
end

function AuctionGameStoreItemData:SetRevealFlag(arg_2_1)
	self.revealFlag = arg_2_1

	return
end

function AuctionGameStoreItemData:GetReveal()
	return self.revealFlag
end

function AuctionGameStoreItemData:UpdateContour(arg_4_1)
	self.contour = AuctionGameTools.GetPosRange(arg_4_1)

	return
end

function AuctionGameStoreItemData:InitContour(arg_5_1, arg_5_2)
	self.contour = {
		arg_5_1,
		arg_5_2
	}

	return
end

function AuctionGameStoreItemData:UpdateRarity(arg_6_1)
	self.rarity = arg_6_1

	return
end

function AuctionGameStoreItemData:UpdatePos(arg_7_1)
	self.position = arg_7_1

	return
end

function AuctionGameStoreItemData:SetShowContour()
	self.showContour = true

	return
end

function AuctionGameStoreItemData:SetShowPos()
	self.showPos = true

	return
end

function AuctionGameStoreItemData:SetShowRarity()
	self.showRarity = true

	return
end

function AuctionGameStoreItemData:GetEstimateValue()
	if self.id ~= nil and self.id ~= 0 then
		return pg.auction_collection[self.id].value, pg.auction_collection[self.id].value
	end

	local var_11_0 = {}

	if self.showRarity ~= true and self.showContour ~= true then
		var_11_0 = Clone(pg.auction_collection.all)
	else
		local var_11_1 = {}

		var_11_1 = self.showRarity and Clone(pg.auction_collection.get_id_list_by_rarity[self.rarity]) or Clone(pg.auction_collection.all)

		if self.showContour then
			for iter_11_0, iter_11_1 in ipairs(var_11_1) do
				if self.contour[1] == pg.auction_collection[iter_11_1].contour[1] and self.contour[2] == pg.auction_collection[iter_11_1].contour[2] then
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

return AuctionGameStoreItemData
