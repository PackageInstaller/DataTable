local var_0_0 = class("FavoriteCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0.tr = tf(arg_1_1)
	arg_1_0.charTpl = arg_1_2
	arg_1_0.charContainer = arg_1_0.tr:Find("char_list")
	arg_1_0.isInitChar = false
	arg_1_0.maxStar = 0
	arg_1_0.nameTF = arg_1_0.tr:Find("bonus/name_bg/Text"):GetComponent(typeof(Text))
	arg_1_0.unfinish = arg_1_0.tr:Find("bonus/item_tpl/unfinish")
	arg_1_0.get = arg_1_0.tr:Find("bonus/item_tpl/get")
	arg_1_0.got = arg_1_0.tr:Find("bonus/item_tpl/got")
	arg_1_0.lock = arg_1_0.tr:Find("bonus/item_tpl/lock")
	arg_1_0.tip = arg_1_0.tr:Find("bonus/item_tpl/tip")
	arg_1_0.starCount = arg_1_0.tr:Find("bonus/process"):GetComponent(typeof(Text))
	arg_1_0.awardTF = arg_1_0.tr:Find("bonus/item_tpl")
	arg_1_0.iconTF = arg_1_0.awardTF:Find("icon_bg")
	arg_1_0.box = arg_1_0.tr:Find("box")

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

	function var_2_0.update(arg_3_0, arg_3_1, arg_3_2)
		var_2_0.name.text = arg_3_1:getConfig("name")

		LoadSpriteAsync("shipmodels/" .. Ship.getPaintingName(arg_3_1.configId), function(arg_4_0)
			if arg_4_0 then
				rtf(arg_3_0.icon).pivot = getSpritePivot(arg_4_0)
				var_2_0.iconImg.sprite = arg_4_0

				var_2_0.iconImg:SetNativeSize()

				arg_3_0.icon.localPosition = Vector3(0, -85, 0)

				setActive(var_2_0.iconImg, true)
			end

			return
		end)
		setActive(var_2_0.stars, arg_3_2)

		if arg_3_2 then
			setImageColor(arg_3_0.icon, Color.New(1, 1, 1, 1))

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
				local var_3_2 = findTF(var_2_0.stars, "star_" .. ({
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
				})[var_3_0][iter_3_2])

				setActive(var_3_2:Find("startpl"), iter_3_2 <= arg_3_2.star)
			end
		else
			setImageColor(arg_3_0.icon, Color.New(0, 0, 0, 0.7))
		end

		setActive(var_2_0.unkonwn, not arg_3_2)

		return
	end

	return var_2_0
end

function var_0_0.update(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.favoriteVO = arg_5_1
	arg_5_0.shipGroups = arg_5_2
	arg_5_0.awards = arg_5_3

	local var_5_0 = {}
	local var_5_1 = arg_5_1:getConfig("char_list")

	for iter_5_0 = arg_5_0.charContainer.childCount, #var_5_1 - 1 do
		cloneTplTo(arg_5_0.charTpl, arg_5_0.charContainer)
	end

	for iter_5_1 = 0, arg_5_0.charContainer.childCount - 1 do
		local var_5_2 = arg_5_0.charContainer:GetChild(iter_5_1)

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

		if arg_5_2[iter_5_2] then
			local var_5_6 = arg_5_2[iter_5_2].star or 0

			var_5_3 = var_5_3 + var_5_6
			var_5_4 = var_5_4 + var_5_5:getMaxStar()
		end
	end

	arg_5_0.nameTF.text = arg_5_1:getConfig("name")

	arg_5_0:updateBound()

	return
end

function var_0_0.updateBound(arg_6_0)
	arg_6_0.state = arg_6_0.favoriteVO:getState(arg_6_0.shipGroups, arg_6_0.awards)

	setActive(arg_6_0.unfinish, arg_6_0.state == Favorite.STATE_WAIT)
	setActive(arg_6_0.get, arg_6_0.state == Favorite.STATE_AWARD)
	setActive(arg_6_0.got, arg_6_0.state == Favorite.STATE_FETCHED)
	setActive(arg_6_0.lock, arg_6_0.state == Favorite.STATE_LOCK)
	setActive(arg_6_0.tip, arg_6_0.state == Favorite.STATE_AWARD)

	local var_6_0 = arg_6_0.favoriteVO:getNextAwardIndex(arg_6_0.awards)
	local var_6_1 = arg_6_0.favoriteVO:getConfig("award_display")

	if var_6_1[var_6_0] then
		local var_6_2 = var_6_1[var_6_0] or var_6_1[#var_6_1]

		updateDrop(arg_6_0.awardTF, {
			type = var_6_2[1],
			id = var_6_2[2],
			count = var_6_2[3]
		})

		local var_6_3 = arg_6_0.favoriteVO:getConfig("level")
		local var_6_4 = var_6_3[var_6_0] or var_6_3[#var_6_3]

		arg_6_0.starCount.text = arg_6_0.favoriteVO:getStarCount(arg_6_0.shipGroups) .. "/" .. var_6_4

		return
	end
end

return var_0_0
