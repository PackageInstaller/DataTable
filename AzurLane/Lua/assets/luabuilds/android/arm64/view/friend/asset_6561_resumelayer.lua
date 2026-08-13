class = var_0_10000

local var_0_0 = "resumeLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "resumeUI"
end

function var_0_1.setPlayerVO(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.frame = var_1.Find(var_3_0, "frame")

	local var_3_1 = arg_3_0._tf

	arg_3_0.resumeIcon = var_1.Find(var_3_1, "frame/window/info/circle/head")

	local var_3_2 = arg_3_0._tf

	arg_3_0.resumeStars = var_1.Find(var_3_2, "frame/window/info/circle/head/stars")

	local var_3_3 = arg_3_0._tf

	arg_3_0.resumeStarTpl = var_1.Find(var_3_3, "frame/window/info/circle/head/star")

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_1.Find(var_3_4, "frame/window/info/player_info/level_bg/level")
	local var_3_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.resumeLv = var_3_6(var_3_5, var_4(var_1_10006))

	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_1.Find(var_3_7, "frame/window/info/player_info/name_bg/name")
	local var_3_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.resumeName = var_3_9(var_3_8, var_4(var_1_10006))

	local var_3_10 = arg_3_0._tf

	arg_3_0.resumeInfo = var_1.Find(var_3_10, "frame/window/summary/content")

	local var_3_11 = arg_3_0._tf

	arg_3_0.resumeEmblem = var_1.Find(var_3_11, "frame/window/info/rank_bg/rank/Image")

	local var_3_12 = arg_3_0._tf

	arg_3_0.resumeEmblemLabel = var_1.Find(var_3_12, "frame/window/info/rank_bg/rank/label")

	local var_3_13 = arg_3_0._tf

	arg_3_0.resumeMedalList = var_1.Find(var_3_13, "frame/window/medalList/container")

	local var_3_14 = arg_3_0._tf

	arg_3_0.resumeMedalTpl = var_1.Find(var_3_14, "frame/window/medal_tpl")

	local var_3_15 = arg_3_0._tf

	arg_3_0.closeBtn = var_1.Find(var_3_15, "frame/window/title_bg/close_btn")

	local var_3_16 = arg_3_0._tf

	arg_3_0.circle = var_1.Find(var_3_16, "frame/window/info/circle/head/frame")

	local var_3_17 = arg_3_0._tf

	arg_3_0.titleText = var_1.Find(var_3_17, "frame/title/label_cn/text")
	i18n = var_1

	if var_1("friend_resume_title_detail") then
		setText = var_1_10002

		var_1_10002(arg_3_0.titleText, var_1)
	end

	return
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:display(arg_4_0.player)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0._tf

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_CLOSE)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

	return
end

local var_0_2 = {}
local var_0_3 = {
	value = "shipCount",
	type = 1
}

i18n = var_3
var_0_3.tag = var_3("friend_resume_ship_count")
var_0_2[1] = var_0_3

local var_0_4 = {
	type = 3
}

i18n = var_3
var_0_4.tag = var_3("friend_resume_collection_rate")
var_0_4.value = {
	"collectionCount"
}
var_0_2[2] = var_0_4

local var_0_5 = {
	value = "attackCount",
	type = 1
}

i18n = var_3
var_0_5.tag = var_3("friend_resume_attack_count")
var_0_2[3] = var_0_5

local var_0_6 = {
	type = 2
}

i18n = var_3
var_0_6.tag = var_3("friend_resume_attack_win_rate")
var_0_6.value = {
	"attackCount",
	"winCount"
}
var_0_2[4] = var_0_6

local var_0_7 = {
	value = "pvp_attack_count",
	type = 1
}

i18n = var_3
var_0_7.tag = var_3("friend_resume_manoeuvre_count")
var_0_2[5] = var_0_7

local var_0_8 = {
	type = 2
}

i18n = var_3
var_0_8.tag = var_3("friend_resume_manoeuvre_win_rate")
var_0_8.value = {
	"pvp_attack_count",
	"pvp_win_count"
}
var_0_2[6] = var_0_8

local var_0_9 = {
	value = "collect_attack_count",
	type = 1
}

i18n = var_3
var_0_9.tag = var_3("friend_event_count")
var_0_2[7] = var_0_9

function var_0_1.display(arg_6_0, arg_6_1)
	if arg_6_0.contextData.parent then
		setParent = var_2

		var_2(arg_6_0._tf, arg_6_0.contextData.parent)
	else
		pg = var_2

		local var_6_0 = var_2.UIMgr.GetInstance()

		var_2.BlurPanel(var_6_0, arg_6_0._tf)
	end

	SeasonInfo = var_2

	local var_6_1 = var_2.getMilitaryRank(arg_6_1.score, arg_6_1.rank)

	SeasonInfo = var_1_10003

	local var_6_2 = var_1_10003.getEmblem(arg_6_1.score, arg_6_1.rank)

	LoadImageSpriteAsync = var_4

	var_4("emblem/" .. var_6_2, arg_6_0.resumeEmblem)

	LoadImageSpriteAsync = var_4

	var_4("emblem/n_" .. var_6_2, arg_6_0.resumeEmblemLabel)

	arg_6_0.resumeName.text = arg_6_1.name

	local var_6_3 = arg_6_0.resumeLv

	var_6_3.text = "Lv." .. arg_6_1.level
	LoadSpriteAsync = var_6_3

	var_6_3("qicon/" .. arg_6_1:getPainting(), function(arg_7_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_6_0.resumeIcon) then
			local var_7_0 = arg_6_0.resumeIcon
			local var_7_1 = var_1.GetComponent

			typeof = var_2_10004
			Image = var_2_10006

			local var_7_2 = var_7_1(var_7_0, var_2_10004(var_2_10006))

			Color = var_2_10002
			var_7_2.color = var_2_10002.white

			local var_7_3

			if not arg_7_0 then
				::label_7_0::

				LoadSprite = var_7_3
				var_7_3 = var_7_3("heroicon/unknown")
			end

			var_7_2.sprite = var_7_3
		end

		return
	end)

	AttireFrame = var_6_3

	local var_6_4 = var_6_3.attireFrameRes
	local var_6_5 = arg_6_1
	local var_6_6 = arg_6_1.id

	getProxy = var_1_10008
	PlayerProxy = var_1_10010

	local var_6_7 = var_1_10008(var_1_10010)
	local var_6_8 = var_6_6 == var_8.getRawData(var_6_7).id

	AttireConst = var_8

	local var_6_9 = var_6_4(var_6_5, var_6_8, var_8.TYPE_ICON_FRAME, arg_6_1.propose)

	PoolMgr = var_5

	local var_6_10 = var_5.GetInstance()

	var_5.GetPrefab(var_6_10, "IconFrame/" .. var_6_9, var_6_9, true, function(arg_8_0)
		IsNil = var_2_10001

		if var_2_10001(arg_6_0._tf) then
			return
		end

		if arg_6_0.circle then
			arg_8_0.name = var_6_9
			findTF = var_1

			local var_8_0 = var_1(arg_8_0.transform, "icon")
			local var_8_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_8_1(var_8_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			var_3(arg_8_0, arg_6_0.circle, false)
		else
			PoolMgr = var_1

			local var_8_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_8_2, "IconFrame/" .. var_6_9, var_6_9, arg_8_0)
		end

		return
	end)

	pg = var_5

	local var_6_11 = var_5.ship_data_statistics[arg_6_1.icon]

	Ship = var_6

	local var_6_12 = var_6.New({
		configId = var_6_11.id
	})
	local var_6_13 = arg_6_0.resumeStars.childCount
	local var_6_14 = var_6_12:getStar()

	for iter_6_0 = var_6_13, var_6_14 - 1 do
		cloneTplTo = var_1_10013

		var_1_10013(arg_6_0.resumeStarTpl, arg_6_0.resumeStars)
	end

	local var_6_15 = arg_6_0.resumeStars.childCount

	for iter_6_1 = 0, var_6_15 - 1 do
		var_1_10015 = arg_6_0.resumeStars

		local var_6_16 = var_1_10013.GetChild(var_1_10015, iter_6_1).gameObject

		var_1_10014.SetActive(var_6_16, iter_6_1 < var_6_11.star)
	end

	removeAllChildren = var_9

	var_9(arg_6_0.resumeMedalList)

	for iter_6_2 = 1, 5 do
		cloneTplTo = var_1_10013
		var_1_10013 = var_1_10013(arg_6_0.resumeMedalTpl, arg_6_0.resumeMedalList)
		setActive = var_1_10014

		var_1_10014(var_1_10013:Find("empty"), iter_6_2 > #arg_6_1.displayTrophyList)

		if iter_6_2 <= #arg_6_1.displayTrophyList then
			setActive = var_1_10014

			var_1_10014(var_1_10013:Find("icon"), true)

			var_1_10014 = arg_6_1.displayTrophyList[iter_6_2]
			Trophy = var_1_10015

			if var_1_10015.IsLoveLetterID(var_1_10014) then
				LoveLetterTrophy = var_1_10015
				var_1_10015 = var_1_10015.New({
					id = var_1_10014
				})
				setLoveLetterMedal = var_16

				var_16(var_1_10013, var_1_10015, {
					hideMark = true
				})
			else
				pg = var_1_10015
				var_1_10015 = var_1_10015.medal_template[arg_6_1.displayTrophyList[iter_6_2]]
				LoadImageSpriteAsync = var_16

				local var_6_17 = "medal/" .. var_1_10015.icon

				var_1_10021 = var_1_10013

				var_16(var_6_17, var_1_10013.Find(var_1_10021, "icon"), true)
			end
		end
	end

	ipairs = var_9

	for iter_6_3, iter_6_4 in var_9(var_0_2) do
		local var_6_18 = arg_6_0.resumeInfo
		local var_6_19 = var_14.GetChild(var_6_18, iter_6_3 - 1)

		setText = var_1_10015

		var_1_10015(var_6_19:Find("tag"), iter_6_4.tag)

		local var_6_20 = var_6_19

		var_1_10015 = var_6_19.Find(var_6_20, "value")

		if iter_6_4.type == 1 then
			setText = var_16

			var_16(var_1_10015, arg_6_0.player[iter_6_4.value])
		else
			local var_6_23

			if iter_6_4.type == 2 then
				math = var_16

				local var_6_21 = var_16.max(arg_6_0.player[iter_6_4.value[1]], 1)

				math = var_6_20

				local var_6_22 = var_6_20.max(arg_6_0.player[iter_6_4.value[2]], 0)

				setText = var_18
				var_6_23 = var_1_10015
				string = var_1_10021

				var_18(var_6_23, var_1_10021.format("%0.2f", var_6_22 / var_6_21 * 100) .. "%")
			elseif iter_6_4.type == 3 then
				local var_6_24

				if not arg_6_0.player[iter_6_4.value[1]] then
					var_6_24 = 1
				end

				setText = var_17

				local var_6_25 = var_1_10015

				string = var_6_23

				local var_6_26 = var_6_23.format
				local var_6_27 = "%0.2f"

				getProxy = var_1_10023
				CollectionProxy = var_1_10025
				var_1_10025 = var_1_10023(var_1_10025)

				var_17(var_6_25, var_6_26(var_6_27, var_6_24 / var_1_10023.getCollectionTotal(var_1_10025) * 100) .. "%")
			end
		end
	end

	return
end

function var_0_1.willExit(arg_9_0)
	if arg_9_0.contextData.parent then
		-- block empty
	else
		pg = var_1

		local var_9_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_9_0, arg_9_0._tf)
	end

	local var_9_1 = arg_9_0.circle.childCount

	if 0 < var_9_1 then
		local var_9_2 = arg_9_0.circle
		local var_9_3 = var_1.GetChild(var_9_2, 0).gameObject

		PoolMgr = var_2

		local var_9_4 = var_2.GetInstance()

		var_2.ReturnPrefab(var_9_4, "IconFrame/" .. var_9_3.name, var_9_3.name, var_9_3)
	end

	return
end

return var_0_1
