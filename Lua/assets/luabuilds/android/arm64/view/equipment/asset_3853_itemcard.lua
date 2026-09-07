local ItemCard = class("ItemCard")

function ItemCard:Ctor(arg_1_1)
	self.go = arg_1_1
	self.bg = findTF(arg_1_1, "bg")
	self.countTF = findTF(arg_1_1, "bg/icon_bg/count"):GetComponent(typeof(Text))
	self.nameTF = findTF(arg_1_1, "bg/name"):GetComponent(typeof(Text))
	self.timeLimitTag = findTF(arg_1_1, "bg/timeline")

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function ItemCard:update(arg_2_1)
	self.itemVO = arg_2_1

	if not IsNil(self.timeLimitTag) then
		setActive(self.timeLimitTag, arg_2_1:getConfig("time_limit") == 1 or Item.InTimeLimitSkinAssigned(arg_2_1.id))
	end

	updateItem(rtf(self.bg), arg_2_1)
	TweenItemAlphaAndWhite(self.go)

	if arg_2_1.count > 0 then
		self.countTF.text = arg_2_1.count or ""
	end

	self.nameTF.text = self:ShortenString(arg_2_1:getConfig("name"), 6)

	return
end

function ItemCard:ShortenString(arg_3_1, arg_3_2)
	local var_3_0 = 1
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = false

	while var_3_0 <= #arg_3_1 do
		local var_3_4, var_3_5 = GetPerceptualSize((string.byte(arg_3_1, var_3_0)))

		var_3_0 = var_3_0 + var_3_4
		var_3_1 = var_3_1 + var_3_5

		local var_3_6 = math.ceil(var_3_1)

		if var_3_6 == arg_3_2 - 1 then
			var_3_2 = var_3_0
		elseif arg_3_2 < var_3_6 then
			var_3_3 = true

			break
		end
	end

	if var_3_2 == 0 or #arg_3_1 < var_3_2 or not var_3_3 then
		return arg_3_1
	end

	return string.sub(arg_3_1, 1, var_3_2 - 1) .. ".."
end

function ItemCard:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function ItemCard:dispose()
	return
end

return ItemCard
