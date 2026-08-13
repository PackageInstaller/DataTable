class = var_0_10000

local var_0_0 = var_0_10000("FavoriteCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	tf = var_1_10003
	arg_1_0.tr = var_1_10003(arg_1_1)
	arg_1_0.charTpl = arg_1_2

	local var_1_0 = arg_1_0.tr

	arg_1_0.charContainer = var_3.Find(var_1_0, "char_list")
	arg_1_0.isInitChar = false
	arg_1_0.maxStar = 0

	local var_1_1 = arg_1_0.tr
	local var_1_2 = var_3.Find(var_1_1, "bonus/name_bg/Text")
	local var_1_3 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.nameTF = var_1_3(var_1_2, var_6(var_1_10008))

	local var_1_4 = arg_1_0.tr

	arg_1_0.unfinish = var_3.Find(var_1_4, "bonus/item_tpl/unfinish")

	local var_1_5 = arg_1_0.tr

	arg_1_0.get = var_3.Find(var_1_5, "bonus/item_tpl/get")

	local var_1_6 = arg_1_0.tr

	arg_1_0.got = var_3.Find(var_1_6, "bonus/item_tpl/got")

	local var_1_7 = arg_1_0.tr

	arg_1_0.lock = var_3.Find(var_1_7, "bonus/item_tpl/lock")

	local var_1_8 = arg_1_0.tr

	arg_1_0.tip = var_3.Find(var_1_8, "bonus/item_tpl/tip")

	local var_1_9 = arg_1_0.tr
	local var_1_10 = var_3.Find(var_1_9, "bonus/process")
	local var_1_11 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.starCount = var_1_11(var_1_10, var_6(var_1_10008))

	local var_1_12 = arg_1_0.tr

	arg_1_0.awardTF = var_3.Find(var_1_12, "bonus/item_tpl")

	local var_1_13 = arg_1_0.awardTF

	arg_1_0.iconTF = var_3.Find(var_1_13, "icon_bg")

	local var_1_14 = arg_1_0.tr

	arg_1_0.box = var_3.Find(var_1_14, "box")

	return
end

local function var_0_1(arg_2_0)
	local var_2_0 = {
		go = arg_2_0
	}

	tf = var_1_10002
	var_2_0.tr = var_1_10002(arg_2_0)

	local var_2_1 = var_2_0.tr

	var_2_0.icon = var_2.Find(var_2_1, "icon")

	local var_2_2 = var_2_0.icon
	local var_2_3 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	var_2_0.iconImg = var_2_3(var_2_2, var_5(var_1_10007))
	findTF = var_2
	var_2_0.stars = var_2(var_2_0.tr, "stars")
	findTF = var_2
	var_2_0.starTpl = var_2(var_2_0.stars, "star")
	findTF = var_2

	local var_2_4 = var_2(var_2_0.tr, "name")
	local var_2_5 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_2_0.name = var_2_5(var_2_4, var_5(var_1_10007))
	findTF = var_2
	var_2_0.unkonwn = var_2(var_2_0.tr, "unkonwn")

	function var_2_0.update(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = var_2_0.name
		local var_3_1 = arg_3_1

		var_3_0.text = arg_3_1.getConfig(var_3_1, "name")
		LoadSpriteAsync = var_3_0

		local var_3_2 = "shipmodels/"

		Ship = var_3_1

		var_3_0(var_3_2 .. var_3_1.getPaintingName(arg_3_1.configId), function(arg_4_0)
			if arg_4_0 then
				rtf = var_3_10001

				local var_4_0 = var_3_10001(arg_3_0.icon)

				getSpritePivot = var_3_10002
				var_4_0.pivot = var_3_10002(arg_4_0)
				var_2_0.iconImg.sprite = arg_4_0

				local var_4_1 = var_2_0.iconImg

				var_1.SetNativeSize(var_4_1)

				local var_4_2 = arg_3_0.icon

				Vector3 = var_2
				var_4_2.localPosition = var_2(0, -85, 0)
				setActive = var_4_2

				var_4_2(var_2_0.iconImg, true)
			end

			return
		end)

		setActive = var_3_0

		var_3_0(var_2_0.stars, arg_3_2)

		if arg_3_2 then
			setImageColor = var_3_0

			local var_3_3 = arg_3_0.icon

			Color = var_6

			var_3_0(var_3_3, var_6.New(1, 1, 1, 1))

			var_3_0 = arg_3_1:getMaxStar()

			for iter_3_0 = var_2_0.stars.childCount + 1, var_3_0 do
				cloneTplTo = var_8

				var_8(var_2_0.starTpl, var_2_0.stars)
			end

			local var_3_4 = {
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
			}

			for iter_3_1 = 1, 6 do
				findTF = var_3_5

				local var_3_5 = var_3_5(var_2_0.stars, "star_" .. iter_3_1)

				setActive = var_3_7

				var_3_7(var_3_5, iter_3_1 <= var_3_0)

				setActive = var_3_7

				var_3_7(var_3_5:Find("startpl"), false)
			end

			local var_3_6 = var_3_4[var_3_0]

			for iter_3_2 = 1, var_3_0 do
				findTF = var_3_7

				local var_3_7 = var_3_7(var_2_0.stars, "star_" .. var_3_6[iter_3_2])

				setActive = var_11

				var_11(var_3_7:Find("startpl"), iter_3_2 <= arg_3_2.star)
			end
		else
			setImageColor = var_3_0

			local var_3_8 = arg_3_0.icon

			Color = var_6

			var_3_0(var_3_8, var_6.New(0, 0, 0, 0.7))
		end

		setActive = var_3_0

		var_3_0(var_2_0.unkonwn, not arg_3_2)

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
		cloneTplTo = var_1_10010

		var_1_10010(arg_5_0.charTpl, arg_5_0.charContainer)
	end

	for iter_5_1 = 0, arg_5_0.charContainer.childCount - 1 do
		local var_5_2 = arg_5_0.charContainer
		local var_5_3 = var_10.GetChild(var_5_2, iter_5_1)

		setActive = var_1_10011

		local var_5_4 = var_5_3

		var_1_10014 = iter_5_1 < #var_5_1

		var_1_10011(var_5_4, var_1_10014)

		var_1_10011 = var_5_1[iter_5_1 + 1]

		if iter_5_1 < #var_5_1 then
			var_5_0[var_1_10011] = var_0_1(var_5_3)
		end
	end

	local var_5_5 = 0
	local var_5_6 = 0

	pairs = var_8

	for iter_5_2, iter_5_3 in var_8(var_5_0) do
		local var_5_7 = iter_5_2 * 10 + 1

		Ship = var_1_10014
		var_1_10014 = var_1_10014.New({
			configId = var_5_7
		})

		iter_5_3:update(var_1_10014, arg_5_2[iter_5_2])

		local var_5_8

		if not arg_5_2[iter_5_2] or not arg_5_2[iter_5_2].star then
			var_5_8 = 0
		end

		var_5_5 = var_5_5 + var_5_8
		var_5_6 = var_5_6 + var_1_10014:getMaxStar()
	end

	arg_5_0.nameTF.text = arg_5_1:getConfig("name")

	arg_5_0:updateBound()

	return
end

function var_0_0.updateBound(arg_6_0)
	local var_6_0 = arg_6_0.favoriteVO

	arg_6_0.state = var_1.getState(var_6_0, arg_6_0.shipGroups, arg_6_0.awards)
	setActive = var_1

	local var_6_1 = arg_6_0.unfinish
	local var_6_2 = arg_6_0.state

	Favorite = var_5

	var_1(var_6_1, var_6_2 == var_5.STATE_WAIT)

	setActive = var_1

	local var_6_3 = arg_6_0.get
	local var_6_4 = arg_6_0.state

	Favorite = var_5

	var_1(var_6_3, var_6_4 == var_5.STATE_AWARD)

	setActive = var_1

	local var_6_5 = arg_6_0.got
	local var_6_6 = arg_6_0.state

	Favorite = var_5

	var_1(var_6_5, var_6_6 == var_5.STATE_FETCHED)

	setActive = var_1

	local var_6_7 = arg_6_0.lock
	local var_6_8 = arg_6_0.state

	Favorite = var_5

	var_1(var_6_7, var_6_8 == var_5.STATE_LOCK)

	setActive = var_1

	local var_6_9 = arg_6_0.tip
	local var_6_10 = arg_6_0.state

	Favorite = var_5

	var_1(var_6_9, var_6_10 == var_5.STATE_AWARD)

	local var_6_11 = arg_6_0.favoriteVO
	local var_6_12 = var_1.getNextAwardIndex(var_6_11, arg_6_0.awards)
	local var_6_13 = arg_6_0.favoriteVO
	local var_6_14

	if not var_2.getConfig(var_6_13, "award_display")[var_6_12] or not var_2[var_6_12] then
		var_6_14 = var_2[#var_2]
	end

	updateDrop = var_6_13

	var_6_13(arg_6_0.awardTF, {
		type = var_6_14[1],
		id = var_6_14[2],
		count = var_6_14[3]
	})

	local var_6_15 = arg_6_0.favoriteVO
	local var_6_16 = var_4.getConfig(var_6_15, "level")
	local var_6_17 = arg_6_0.favoriteVO
	local var_6_18, var_6_19 = var_5.getStarCount(var_6_17, arg_6_0.shipGroups), arg_6_0.starCount
	local var_6_20 = "/"
	local var_6_21

	if not var_6_16[var_6_12] then
		var_6_21 = var_6_16[#var_6_16]
	end

	var_6_19.text = var_6_18 .. var_6_20 .. var_6_21

	return
end

return var_0_0
