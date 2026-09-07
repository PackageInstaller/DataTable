local FavoriteCard = class("FavoriteCard")

function FavoriteCard:Ctor(arg_1_1, arg_1_2)
	self.go = arg_1_1
	self.tr = tf(arg_1_1)
	self.charTpl = arg_1_2
	self.charContainer = self.tr:Find("char_list")
	self.isInitChar = false
	self.maxStar = 0
	self.nameTF = self.tr:Find("bonus/name_bg/Text"):GetComponent(typeof(Text))
	self.unfinish = self.tr:Find("bonus/item_tpl/unfinish")
	self.get = self.tr:Find("bonus/item_tpl/get")
	self.got = self.tr:Find("bonus/item_tpl/got")
	self.lock = self.tr:Find("bonus/item_tpl/lock")
	self.tip = self.tr:Find("bonus/item_tpl/tip")
	self.starCount = self.tr:Find("bonus/process"):GetComponent(typeof(Text))
	self.awardTF = self.tr:Find("bonus/item_tpl")
	self.iconTF = self.awardTF:Find("icon_bg")
	self.box = self.tr:Find("box")

	return
end

local function var_0_1(arg_2_0)
	local var_2_0 = {
		go = arg_2_0,
		tr = tf(arg_2_0)
	}

	var_2_0.icon = var_2_0.tr:Find("icon")
	var_2_0.iconImg = var_2_0.icon:GetComponent(typeof(Image))
	var_2_0.stars = findTF(var_2_0.tr, "stars")
	var_2_0.starTpl = findTF(var_2_0.stars, "star")
	var_2_0.name = findTF(var_2_0.tr, "name"):GetComponent(typeof(Text))
	var_2_0.unkonwn = findTF(var_2_0.tr, "unkonwn")

	function var_2_0:update(arg_3_1, arg_3_2)
		var_2_0.name.text = arg_3_1:getConfig("name")

		LoadSpriteAsync("shipmodels/" .. Ship.getPaintingName(arg_3_1.configId), function(arg_4_0)
			if arg_4_0 then
				rtf(self.icon).pivot = getSpritePivot(arg_4_0)
				var_2_0.iconImg.sprite = arg_4_0

				var_2_0.iconImg:SetNativeSize()

				self.icon.localPosition = Vector3(0, -85, 0)

				setActive(var_2_0.iconImg, true)
			end

			return
		end)
		setActive(var_2_0.stars, arg_3_2)

		if arg_3_2 then
			setImageColor(self.icon, Color.New(1, 1, 1, 1))

			local var_3_0 = arg_3_1:getMaxStar()

			for iter_3_0 = var_2_0.stars.childCount + 1, var_3_0 do
				cloneTplTo(var_2_0.starTpl, var_2_0.stars)
			end

			for iter_3_1 = 1, 6 do
				local var_3_1 = findTF(var_2_0.stars, "star_" .. iter_3_1)

				setActive(var_3_1, iter_3_1 <= var_3_0)
				setActive(var_3_1:Find("startpl"), false)
			end

			for iter_3_2 = 1, var_3_0 do
				setActive(findTF(var_2_0.stars, "star_" .. ({
					[4] = {
						1,
						2,
						3,
						4
					},
					[5] = {
						1,
						2,
						5,
						3,
						4
					},
					[6] = {
						1,
						2,
						5,
						6,
						3,
						4
					}
				})[var_3_0][iter_3_2]):Find("startpl"), iter_3_2 <= arg_3_2.star)
			end
		else
			setImageColor(self.icon, Color.New(0, 0, 0, 0.7))
		end

		setActive(var_2_0.unkonwn, not arg_3_2)

		return
	end

	return var_2_0
end

function FavoriteCard:update(arg_5_1, arg_5_2, arg_5_3)
	self.favoriteVO = arg_5_1
	self.shipGroups = arg_5_2
	self.awards = arg_5_3

	local var_5_0 = {}
	local var_5_1 = arg_5_1:getConfig("char_list")

	for iter_5_0 = self.charContainer.childCount, #var_5_1 - 1 do
		cloneTplTo(self.charTpl, self.charContainer)
	end

	for iter_5_1 = 0, self.charContainer.childCount - 1 do
		local var_5_2 = self.charContainer:GetChild(iter_5_1)

		setActive(var_5_2, iter_5_1 < #var_5_1)

		if iter_5_1 < #var_5_1 then
			var_5_0[var_5_1[iter_5_1 + 1]] = var_0_1(var_5_2)
		end
	end

	local var_5_3 = 0
	local var_5_4 = 0

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		local var_5_5 = Ship.New({
			configId = iter_5_2 * 10 + 1
		})

		iter_5_3:update(var_5_5, arg_5_2[iter_5_2])

		var_5_3 = var_5_3 + ((arg_5_2[iter_5_2] or nil) and (arg_5_2[iter_5_2].star or 0))
		var_5_4 = var_5_4 + var_5_5:getMaxStar()
	end

	self.nameTF.text = arg_5_1:getConfig("name")

	self:updateBound()

	return
end

function FavoriteCard:updateBound()
	self.state = self.favoriteVO:getState(self.shipGroups, self.awards)

	setActive(self.unfinish, self.state == Favorite.STATE_WAIT)
	setActive(self.get, self.state == Favorite.STATE_AWARD)
	setActive(self.got, self.state == Favorite.STATE_FETCHED)
	setActive(self.lock, self.state == Favorite.STATE_LOCK)
	setActive(self.tip, self.state == Favorite.STATE_AWARD)

	local var_6_0 = self.favoriteVO:getNextAwardIndex(self.awards)
	local var_6_1 = self.favoriteVO:getConfig("award_display")
	local var_6_2

	if var_6_1[var_6_0] then
		var_6_2 = var_6_1[var_6_0] or var_6_1[#var_6_1]
	end

	updateDrop(self.awardTF, {
		type = var_6_2[1],
		id = var_6_2[2],
		count = var_6_2[3]
	})

	local var_6_3 = self.favoriteVO:getConfig("level")

	self.starCount.text = self.favoriteVO:getStarCount(self.shipGroups) .. "/" .. (var_6_3[var_6_0] or var_6_3[#var_6_3])

	return
end

return FavoriteCard
