class = var_0_10000

local var_0_0 = "PlayerVitaeDetailPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PlayerVitaeDetailPage"
end

function var_0_1.OnPlayerNameChange(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1
	arg_2_0.nameTxt.text = arg_2_1.name

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.medalTpl = var_1.Find(var_3_0, "medalList/tpl")

	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_1.Find(var_3_1, "power/medal")
	local var_3_3 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.emblemIcon = var_3_3(var_3_2, var_4(var_1_10006))

	local var_3_4 = arg_3_0._tf
	local var_3_5 = var_1.Find(var_3_4, "power/medal_text")
	local var_3_6 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_3_0.emblemTxt = var_3_6(var_3_5, var_4(var_1_10006))

	local var_3_7 = arg_3_0._tf
	local var_3_8 = var_1.Find(var_3_7, "power/rank")
	local var_3_9 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.highestEmblem = var_3_9(var_3_8, var_4(var_1_10006))

	local var_3_10 = arg_3_0._tf
	local var_3_11 = var_1.Find(var_3_10, "power/power")
	local var_3_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.powerTxt = var_3_12(var_3_11, var_4(var_1_10006))

	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_1.Find(var_3_13, "power/collection")
	local var_3_15 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.collectionTxt = var_3_15(var_3_14, var_4(var_1_10006))

	local var_3_16 = arg_3_0._tf

	arg_3_0.modityNameBtn = var_1.Find(var_3_16, "info/name")

	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_1.Find(var_3_17, "info/name/Text")
	local var_3_19 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.nameTxt = var_3_19(var_3_18, var_4(var_1_10006))

	local var_3_20 = arg_3_0._tf
	local var_3_21 = var_1.Find(var_3_20, "info/uid")
	local var_3_22 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.idTxt = var_3_22(var_3_21, var_4(var_1_10006))

	local var_3_23 = arg_3_0._tf
	local var_3_24 = var_1.Find(var_3_23, "info/level")
	local var_3_25 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.levelTxt = var_3_25(var_3_24, var_4(var_1_10006))

	local var_3_26 = arg_3_0._tf
	local var_3_27 = var_1.Find(var_3_26, "info/exp")
	local var_3_28 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.expTxt = var_3_28(var_3_27, var_4(var_1_10006))

	local var_3_29 = arg_3_0._tf

	arg_3_0.copyBtn = var_1.Find(var_3_29, "info/copy")

	local var_3_30 = arg_3_0._tf

	arg_3_0.statisticTpl = var_1.Find(var_3_30, "statistics/tpl")

	local var_3_31 = arg_3_0._tf

	arg_3_0.shareBtn = var_1.Find(var_3_31, "btn_share")

	local var_3_32 = arg_3_0._tf

	arg_3_0.attireBtn = var_1.Find(var_3_32, "btn_attire")

	local var_3_33 = arg_3_0.attireBtn

	arg_3_0.attireBtnTip = var_1.Find(var_3_33, "tip")

	local var_3_34 = arg_3_0._tf

	arg_3_0.inputField = var_1.Find(var_3_34, "greet/InputField")

	local var_3_35 = arg_3_0._tf

	arg_3_0.writeBtn = var_1.Find(var_3_35, "greet/write_btn")

	local var_3_36 = {}
	local var_3_37 = arg_3_0._tf

	var_3_36[1] = var_2.Find(var_3_37, "info")

	local var_3_38 = arg_3_0._tf

	var_3_36[2] = var_2.Find(var_3_38, "power")

	local var_3_39 = arg_3_0._tf

	var_3_36[3] = var_2.Find(var_3_39, "statistics")

	local var_3_40 = arg_3_0._tf

	var_3_36[4] = var_2.Find(var_3_40, "greet")
	arg_3_0.animPanels = var_3_36
	setText = var_3_36

	local var_3_41 = arg_3_0._tf
	local var_3_42 = var_3.Find(var_3_41, "power/collection_label")

	i18n = var_3_40

	var_3_36(var_3_42, var_3_40("friend_resume_collection_rate"))

	setText = var_3_36

	local var_3_43 = arg_3_0._tf
	local var_3_44 = var_3.Find(var_3_43, "power/power_label")

	i18n = var_4

	var_3_36(var_3_44, var_4("friend_resume_fleet_gs"))

	setText = var_3_36

	local var_3_45 = arg_3_0._tf
	local var_3_46 = var_3.Find(var_3_45, "info/title_name")

	i18n = var_4

	var_3_36(var_3_46, var_4("friend_resume_title"))

	setText = var_3_36

	local var_3_47 = arg_3_0._tf
	local var_3_48 = var_3.Find(var_3_47, "statistics/title_name")

	i18n = var_4

	var_3_36(var_3_48, var_4("friend_resume_data_title"))

	setText = var_3_36

	local var_3_49 = arg_3_0._tf
	local var_3_50 = var_3.Find(var_3_49, "greet/InputField/Placeholder")

	i18n = var_4

	var_3_36(var_3_50, var_4("player_manifesto_placeholder"))
	arg_3_0:MatchResolution()

	return
end

function var_0_1.PreCalcAspect(arg_4_0, arg_4_1)
	return arg_4_0.rect.height / arg_4_1
end

function var_0_1.MatchResolution(arg_5_0)
	local var_5_0 = var_0_1.PreCalcAspect(arg_5_0._parentTf, arg_5_0._tf.rect.height)
	local var_5_1 = arg_5_0._tf

	Vector3 = var_3
	var_5_1.localScale = var_3(var_5_0, var_5_0, 1)

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.modityNameBtn

	local function var_6_2()
		local var_7_0 = arg_6_0.player
		local var_7_1, var_7_2 = var_0.canModifyName(var_7_0)

		if not var_7_1 then
			pg = var_7_0

			local var_7_3 = var_7_0.TipsMgr.GetInstance()

			var_2.ShowTips(var_7_3, var_7_2)

			return
		end

		local var_7_4 = arg_6_0.contextData.renamePage

		var_2.ExecuteAction(var_7_4, "Show", arg_6_0.player)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10006)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.copyBtn

	local function var_6_5()
		UniPasteBoard = var_2_10000

		var_2_10000.SetClipBoardString(arg_6_0.player.id)

		pg = var_0

		local var_8_0 = var_0.TipsMgr.GetInstance()
		local var_8_1 = var_0.ShowTips

		i18n = var_2_10003

		var_8_1(var_8_0, var_2_10003("friend_id_copy_ok"))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1_10001

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.writeBtn

	local function var_6_8()
		activateInputField = var_2_10000

		var_2_10000(arg_6_0.inputField)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_6, var_6_7, var_6_8, var_1_10006)

	onButton = var_1_10001

	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.shareBtn

	local function var_6_11()
		pg = var_2_10000

		local var_10_0 = var_2_10000.ShareMgr.GetInstance()
		local var_10_1 = var_0.Share

		pg = var_2_10003

		var_10_1(var_10_0, var_2_10003.ShareMgr.TypeAdmira)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_9, var_6_10, var_6_11, var_1_10006)

	onButton = var_1_10001

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.attireBtn

	local function var_6_14()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		PlayerVitaeMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.ON_ATTIRE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_6_12, var_6_13, var_6_14, var_1_10006)

	setActive = var_1_10001

	local var_6_15 = arg_6_0.attireBtnTip

	underscore = var_6_13

	local var_6_16 = var_6_13.any

	getProxy = var_1_10006
	AttireProxy = var_1_10008

	local var_6_17 = var_1_10006(var_1_10008)

	var_1_10001(var_6_15, var_6_16(var_6.needTip(var_6_17), function(arg_12_0)
		return arg_12_0 == true
	end))

	onInputEndEdit = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.inputField, function(arg_13_0)
		wordVer = var_2_10001

		local var_13_0 = var_2_10001(arg_13_0)

		if 0 < var_13_0 then
			pg = var_2

			local var_13_1 = var_2.TipsMgr.GetInstance()
			local var_13_2 = var_2.ShowTips

			i18n = var_2_10005

			var_13_2(var_13_1, var_2_10005("playerinfo_mask_word"))

			activateInputField = var_13_2

			var_13_2(arg_6_0.inputField)

			return
		end

		if not arg_13_0 or arg_6_0.manifesto == arg_13_0 then
			return
		end

		arg_6_0.manifesto = arg_13_0

		local var_13_3 = arg_6_0
		local var_13_4 = var_2.emit

		PlayerVitaeMediator = var_2_10005

		var_13_4(var_13_3, var_2_10005.CHANGE_MANIFESTO, arg_13_0)

		return
	end)

	local var_6_18 = arg_6_0._tf

	var_1.SetAsFirstSibling(var_6_18)

	return
end

function var_0_1.Show(arg_14_0, arg_14_1, arg_14_2)
	var_0_1.super.Show(arg_14_0)

	arg_14_0.player = arg_14_1

	arg_14_0:UpdateMedals()
	arg_14_0:UpdatePower()
	arg_14_0:UpdateInfo()
	arg_14_0:UpdateStatistics()

	if arg_14_2 then
		arg_14_0:DoEnterAnimation()
	end

	return
end

function var_0_1.DoEnterAnimation(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.animPanels) do
		local var_15_0 = iter_15_1.localPosition.x
		local var_15_1 = iter_15_0 * 0.05
		local var_15_2 = 0.2 + (iter_15_0 - 1) * 0.05

		Vector3 = var_1_10009
		iter_15_1.localPosition = var_1_10009(var_15_0 + 800, iter_15_1.localPosition.y, 0)
		LeanTween = var_1_10009

		local var_15_3 = var_1_10009.moveLocalX(iter_15_1.gameObject, var_15_0, var_15_2)
		local var_15_4 = var_1_10009.setDelay(var_15_3, var_15_1)

		var_1_10009 = var_1_10009.setEase
		LeanTweenType = var_12

		var_1_10009(var_15_4, var_12.easeInOutSine)
	end

	return
end

function var_0_1.UpdateMedals(arg_16_0)
	local var_16_0 = arg_16_0.player.displayTrophyList

	math = var_1_10002

	local var_16_1 = var_1_10002.min(5, #var_16_0)
	local var_16_2 = 353
	local var_16_3 = 30

	UIItemList = var_5

	var_5.StaticAlign(arg_16_0.medalTpl.parent, arg_16_0.medalTpl, var_16_1, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = var_16_0[arg_17_1]

			if 0 < var_17_0 then
				LoveLetterTrophy = var_17_1

				local var_17_1

				if not var_17_1.New({
					id = var_17_0
				}) then
					Trophy = var_17_1
					var_17_1 = var_17_1.New({
						id = var_17_0
					})
				end

				local var_17_2 = arg_17_2:Find("icon")
				local var_17_3 = arg_17_2
				local var_17_4 = arg_17_2.Find(var_17_3, "now")
				local var_17_5 = var_17_1:isLoverLetter()

				setActive = var_17_3

				var_17_3(var_17_2, not var_17_5)

				setActive = var_17_3

				var_17_3(var_17_4, var_17_5)

				if var_17_5 then
					setLoveLetterMedal = var_17_3

					var_17_3(var_17_4:Find("medal"), var_17_1, {
						hideMark = true
					})
				else
					LoadImageSpriteAsync = var_17_3

					var_17_3("medal/s_" .. var_17_1:getConfig("icon"), var_17_2, true)
				end

				local var_17_6 = var_16_2 - (arg_17_1 - 1) * (var_16_3 + arg_17_2.sizeDelta.x)

				Vector2 = var_9
				arg_17_2.anchoredPosition = var_9(var_17_6, arg_17_2.anchoredPosition.y)

				return
			end
		end
	end)

	return
end

function var_0_1.UpdatePower(arg_18_0)
	getProxy = var_1_10001
	MilitaryExerciseProxy = var_1_10003

	local var_18_0 = var_1_10001(var_1_10003)
	local var_18_1 = var_1.RawGetSeasonInfo(var_18_0)

	SeasonInfo = var_1_10002

	local var_18_2 = var_1_10002.getEmblem(var_18_1.score, var_18_1.rank)

	LoadSpriteAsync = var_18_0

	var_18_0("emblem/" .. var_18_2, function(arg_19_0)
		arg_18_0.emblemIcon.sprite = arg_19_0

		local var_19_0 = arg_18_0.emblemIcon

		var_1.SetNativeSize(var_19_0)

		return
	end)

	LoadSpriteAsync = var_18_0

	var_18_0("emblem/n_" .. var_18_2, function(arg_20_0)
		if arg_18_0.exited then
			return
		end

		arg_18_0.emblemTxt.sprite = arg_20_0

		local var_20_0 = arg_18_0.emblemTxt

		var_1.SetNativeSize(var_20_0)

		return
	end)

	math = var_18_0

	local var_18_3 = var_18_0.max(arg_18_0.player.maxRank, 1)

	pg = var_4

	local var_18_4 = var_4.arena_data_rank

	math = var_5

	local var_18_5 = var_18_4[var_5.min(var_18_3, 14)]
	local var_18_6 = arg_18_0.highestEmblem

	i18n = var_6
	var_18_6.text = var_6("friend_resume_title_metal") .. var_18_5.name
	getProxy = var_18_6
	BayProxy = var_7

	local var_18_7 = var_18_6(var_7)

	var_5.GetBayPowerRootedAsyn(var_18_7, function(arg_21_0)
		if arg_18_0.exited then
			return
		end

		local var_21_0 = arg_18_0.powerTxt

		math = var_2_10002
		var_21_0.text = var_2_10002.floor(arg_21_0)

		return
	end)

	local var_18_8 = arg_18_0.collectionTxt

	getProxy = var_6
	CollectionProxy = var_8

	local var_18_9 = var_6(var_8)

	var_18_8.text = var_6.getCollectionRate(var_18_9) * 100 .. "%"

	return
end

function var_0_1.UpdateInfo(arg_22_0)
	arg_22_0.nameTxt.text = arg_22_0.player.name
	arg_22_0.idTxt.text = arg_22_0.player.id

	local var_22_0 = arg_22_0.levelTxt

	var_22_0.text = "LV." .. arg_22_0.player.level
	getConfigFromLevel1 = var_22_0
	pg = var_3

	local var_22_1 = var_22_0(var_3.user_level, arg_22_0.player.level).exp

	arg_22_0.expTxt.text = arg_22_0.player.exp .. "/" .. var_22_1

	local var_22_2 = arg_22_0.player
	local var_22_3 = var_2.GetManifesto(var_22_2)

	setInputText = var_3

	var_3(arg_22_0.inputField, var_22_3)

	return
end

function var_0_1.UpdateStatistics(arg_23_0)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.GetDisplayStatisticsData(var_23_0)
	local var_23_2 = 2

	Vector2 = var_23_0

	local var_23_3 = var_23_0(355, 25)
	local var_23_4 = arg_23_0.statisticTpl.anchoredPosition
	local var_23_5 = arg_23_0.statisticTpl.sizeDelta.x

	for iter_23_0 = 1, #var_23_1, var_23_2 do
		local var_23_6 = var_23_4.y - (iter_23_0 - 1) * var_23_3.y

		for iter_23_1 = 1, var_23_2 do
			if iter_23_1 ~= 1 or iter_23_0 ~= 1 or not arg_23_0.statisticTpl then
				cloneTplTo = var_1_10015
				var_1_10015 = var_1_10015(arg_23_0.statisticTpl, arg_23_0.statisticTpl.parent)
			end

			local var_23_7 = var_23_1[iter_23_0 + (iter_23_1 - 1)]

			setText = var_1_10017

			local var_23_8 = var_1_10015

			i18n = var_1_10020

			var_1_10017(var_23_8, var_1_10020(var_23_7[1]))

			setText = var_1_10017

			var_1_10017(var_1_10015:Find("value"), var_23_7[2])

			var_1_10017 = var_23_4.x + (iter_23_1 - 1) * var_23_3.x
			Vector2 = var_18
			var_1_10015.anchoredPosition = var_18(var_1_10017, var_23_6)
		end
	end

	return
end

function var_0_1.GetDisplayStatisticsData(arg_24_0)
	local var_24_0 = arg_24_0.player

	string = var_1_10002

	local var_24_1 = var_1_10002.format
	local var_24_2 = "%0.1f"
	local var_24_3 = var_24_0.winCount

	math = var_1_10006

	local var_24_4 = var_24_1(var_24_2, var_24_3 / var_1_10006.max(var_24_0.attackCount, 1) * 100) .. "%"

	string = var_3

	local var_24_5 = var_3.format
	local var_24_6 = "%0.1f"
	local var_24_7 = var_24_0.pvp_win_count

	math = var_1_10007

	local var_24_8 = var_24_5(var_24_6, var_24_7 / var_1_10007.max(var_24_0.pvp_attack_count, 1) * 100) .. "%"

	return {
		{
			"friend_resume_ship_count",
			var_24_0.shipCount
		},
		{
			"friend_event_count",
			var_24_0.collect_attack_count
		},
		{
			"friend_resume_attack_count",
			var_24_0.attackCount
		},
		{
			"friend_resume_manoeuvre_count",
			var_24_0.pvp_attack_count
		},
		{
			"friend_resume_attack_win_rate",
			var_24_4
		},
		{
			"friend_resume_manoeuvre_win_rate",
			var_24_8
		}
	}
end

function var_0_1.OnDestroy(arg_25_0)
	ipairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.animPanels) do
		LeanTween = var_1_10006

		if var_1_10006.isTweening(iter_25_1.gameObject) then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_25_1.gameObject)
		end
	end

	eachChild = var_1

	var_1(arg_25_0.medalTpl.parent, function(arg_26_0, arg_26_1)
		if arg_26_0:Find("now/medal").childCount > 0 then
			returnLoveLetterMedal = var_2

			local var_26_0 = arg_26_0:Find("now/medal")

			var_2(var_4.GetChild(var_26_0, 0))
		end

		return
	end)

	arg_25_0.exited = true

	return
end

return var_0_1
