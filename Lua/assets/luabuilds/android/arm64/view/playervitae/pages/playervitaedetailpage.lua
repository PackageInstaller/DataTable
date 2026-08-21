local var_0_0 = class("PlayerVitaeDetailPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PlayerVitaeDetailPage"
end

function var_0_0.OnPlayerNameChange(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1
	arg_2_0.nameTxt.text = arg_2_1.name

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.medalTpl = arg_3_0._tf:Find("medalList/tpl")
	arg_3_0.emblemIcon = arg_3_0._tf:Find("power/medal"):GetComponent(typeof(Image))
	arg_3_0.emblemTxt = arg_3_0._tf:Find("power/medal_text"):GetComponent(typeof(Image))
	arg_3_0.highestEmblem = arg_3_0._tf:Find("power/rank"):GetComponent(typeof(Text))
	arg_3_0.powerTxt = arg_3_0._tf:Find("power/power"):GetComponent(typeof(Text))
	arg_3_0.collectionTxt = arg_3_0._tf:Find("power/collection"):GetComponent(typeof(Text))
	arg_3_0.modityNameBtn = arg_3_0._tf:Find("info/name")
	arg_3_0.nameTxt = arg_3_0._tf:Find("info/name/Text"):GetComponent(typeof(Text))
	arg_3_0.idTxt = arg_3_0._tf:Find("info/uid"):GetComponent(typeof(Text))
	arg_3_0.levelTxt = arg_3_0._tf:Find("info/level"):GetComponent(typeof(Text))
	arg_3_0.expTxt = arg_3_0._tf:Find("info/exp"):GetComponent(typeof(Text))
	arg_3_0.copyBtn = arg_3_0._tf:Find("info/copy")
	arg_3_0.statisticTpl = arg_3_0._tf:Find("statistics/tpl")
	arg_3_0.shareBtn = arg_3_0._tf:Find("btn_share")
	arg_3_0.attireBtn = arg_3_0._tf:Find("btn_attire")
	arg_3_0.attireBtnTip = arg_3_0.attireBtn:Find("tip")
	arg_3_0.inputField = arg_3_0._tf:Find("greet/InputField")
	arg_3_0.writeBtn = arg_3_0._tf:Find("greet/write_btn")
	arg_3_0.animPanels = {
		arg_3_0._tf:Find("info"),
		arg_3_0._tf:Find("power"),
		arg_3_0._tf:Find("statistics"),
		arg_3_0._tf:Find("greet")
	}

	setText(arg_3_0._tf:Find("power/collection_label"), i18n("friend_resume_collection_rate"))
	setText(arg_3_0._tf:Find("power/power_label"), i18n("friend_resume_fleet_gs"))
	setText(arg_3_0._tf:Find("info/title_name"), i18n("friend_resume_title"))
	setText(arg_3_0._tf:Find("statistics/title_name"), i18n("friend_resume_data_title"))
	setText(arg_3_0._tf:Find("greet/InputField/Placeholder"), i18n("player_manifesto_placeholder"))
	arg_3_0:MatchResolution()

	return
end

function var_0_0.PreCalcAspect(arg_4_0, arg_4_1)
	return arg_4_0.rect.height / arg_4_1
end

function var_0_0.MatchResolution(arg_5_0)
	local var_5_0 = var_0_0.PreCalcAspect(arg_5_0._parentTf, arg_5_0._tf.rect.height)

	arg_5_0._tf.localScale = Vector3(var_5_0, var_5_0, 1)

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.modityNameBtn, function()
		local var_7_0, var_7_1 = arg_6_0.player:canModifyName()

		if not var_7_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_7_1)

			return
		end

		arg_6_0.contextData.renamePage:ExecuteAction("Show", arg_6_0.player)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.copyBtn, function()
		UniPasteBoard.SetClipBoardString(arg_6_0.player.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.writeBtn, function()
		activateInputField(arg_6_0.inputField)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeAdmira)

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.attireBtn, function()
		arg_6_0:emit(PlayerVitaeMediator.ON_ATTIRE)

		return
	end, SFX_PANEL)
	setActive(arg_6_0.attireBtnTip, underscore.any(getProxy(AttireProxy):needTip(), function(arg_12_0)
		return arg_12_0 == true
	end))
	onInputEndEdit(arg_6_0, arg_6_0.inputField, function(arg_13_0)
		if wordVer(arg_13_0) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("playerinfo_mask_word"))
			activateInputField(arg_6_0.inputField)

			return
		end

		if not arg_13_0 or arg_6_0.manifesto == arg_13_0 then
			return
		end

		arg_6_0.manifesto = arg_13_0

		arg_6_0:emit(PlayerVitaeMediator.CHANGE_MANIFESTO, arg_13_0)

		return
	end)
	arg_6_0._tf:SetAsFirstSibling()

	return
end

function var_0_0.Show(arg_14_0, arg_14_1, arg_14_2)
	var_0_0.super.Show(arg_14_0)

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

function var_0_0.DoEnterAnimation(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.animPanels) do
		iter_15_1.localPosition = Vector3(iter_15_1.localPosition.x + 800, iter_15_1.localPosition.y, 0)

		LeanTween.moveLocalX(iter_15_1.gameObject, iter_15_1.localPosition.x, 0.2 + (iter_15_0 - 1) * 0.05):setDelay(iter_15_0 * 0.05):setEase(LeanTweenType.easeInOutSine)
	end

	return
end

function var_0_0.UpdateMedals(arg_16_0)
	local var_16_0 = 353
	local var_16_1 = 30

	UIItemList.StaticAlign(arg_16_0.medalTpl.parent, arg_16_0.medalTpl, math.min(5, #arg_16_0.player.displayTrophyList), function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = var_0[arg_17_1] > 0 and LoveLetterTrophy.New({
				id = var_0[arg_17_1]
			}) or Trophy.New({
				id = var_0[arg_17_1]
			})
			local var_17_1 = arg_17_2:Find("icon")
			local var_17_2 = arg_17_2:Find("now")
			local var_17_3 = var_17_0:isLoverLetter()

			setActive(var_17_1, not var_17_3)
			setActive(var_17_2, var_17_3)

			if var_17_3 then
				setLoveLetterMedal(var_17_2:Find("medal"), var_17_0, {
					hideMark = true
				})
			else
				LoadImageSpriteAsync("medal/s_" .. var_17_0:getConfig("icon"), var_17_1, true)
			end

			arg_17_2.anchoredPosition = Vector2(var_16_0 - (arg_17_1 - 1) * (var_16_1 + arg_17_2.sizeDelta.x), arg_17_2.anchoredPosition.y)
		end

		return
	end)

	return
end

function var_0_0.UpdatePower(arg_18_0)
	local var_18_0 = getProxy(MilitaryExerciseProxy):RawGetSeasonInfo()
	local var_18_1 = SeasonInfo.getEmblem(var_18_0.score, var_18_0.rank)

	LoadSpriteAsync("emblem/" .. var_18_1, function(arg_19_0)
		arg_18_0.emblemIcon.sprite = arg_19_0

		arg_18_0.emblemIcon:SetNativeSize()

		return
	end)
	LoadSpriteAsync("emblem/n_" .. var_18_1, function(arg_20_0)
		if arg_18_0.exited then
			return
		end

		arg_18_0.emblemTxt.sprite = arg_20_0

		arg_18_0.emblemTxt:SetNativeSize()

		return
	end)

	arg_18_0.highestEmblem.text = i18n("friend_resume_title_metal") .. pg.arena_data_rank[math.min(math.max(arg_18_0.player.maxRank, 1), 14)].name

	getProxy(BayProxy):GetBayPowerRootedAsyn(function(arg_21_0)
		if arg_18_0.exited then
			return
		end

		arg_18_0.powerTxt.text = math.floor(arg_21_0)

		return
	end)

	arg_18_0.collectionTxt.text = getProxy(CollectionProxy):getCollectionRate() * 100 .. "%"

	return
end

function var_0_0.UpdateInfo(arg_22_0)
	arg_22_0.nameTxt.text = arg_22_0.player.name
	arg_22_0.idTxt.text = arg_22_0.player.id
	arg_22_0.levelTxt.text = "LV." .. arg_22_0.player.level
	arg_22_0.expTxt.text = arg_22_0.player.exp .. "/" .. getConfigFromLevel1(pg.user_level, arg_22_0.player.level).exp

	setInputText(arg_22_0.inputField, (arg_22_0.player:GetManifesto()))

	return
end

function var_0_0.UpdateStatistics(arg_23_0)
	local var_23_0 = arg_23_0:GetDisplayStatisticsData()
	local var_23_1 = Vector2(355, 25)
	local var_23_2 = arg_23_0.statisticTpl.anchoredPosition

	for iter_23_0 = 1, #var_23_0, 2 do
		local var_23_4 = var_23_2.y - (iter_23_0 - 1) * var_23_1.y

		for iter_23_1 = 1, 2 do
			if iter_23_1 == 1 and iter_23_0 == 1 then
				local var_23_5 = arg_23_0.statisticTpl or cloneTplTo(arg_23_0.statisticTpl, arg_23_0.statisticTpl.parent)
				local var_23_6 = var_23_0[iter_23_0 + (iter_23_1 - 1)]

				setText(var_23_5, i18n(var_23_0[iter_23_0 + (iter_23_1 - 1)][1]))
				setText(var_23_5:Find("value"), var_23_6[2])

				var_23_5.anchoredPosition = Vector2(var_23_2.x + (iter_23_1 - 1) * var_23_1.x, var_23_4)
			end
		end
	end

	return
end

function var_0_0.GetDisplayStatisticsData(arg_24_0)
	return {
		{
			"friend_resume_ship_count",
			arg_24_0.player.shipCount
		},
		{
			"friend_event_count",
			arg_24_0.player.collect_attack_count
		},
		{
			"friend_resume_attack_count",
			arg_24_0.player.attackCount
		},
		{
			"friend_resume_manoeuvre_count",
			arg_24_0.player.pvp_attack_count
		},
		{
			"friend_resume_attack_win_rate",
			string.format("%0.1f", arg_24_0.player.winCount / math.max(arg_24_0.player.attackCount, 1) * 100) .. "%"
		},
		{
			"friend_resume_manoeuvre_win_rate",
			string.format("%0.1f", arg_24_0.player.pvp_win_count / math.max(arg_24_0.player.pvp_attack_count, 1) * 100) .. "%"
		}
	}
end

function var_0_0.OnDestroy(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.animPanels) do
		if LeanTween.isTweening(iter_25_1.gameObject) then
			LeanTween.cancel(iter_25_1.gameObject)
		end
	end

	eachChild(arg_25_0.medalTpl.parent, function(arg_26_0, arg_26_1)
		if arg_26_0:Find("now/medal").childCount > 0 then
			returnLoveLetterMedal(arg_26_0:Find("now/medal"):GetChild(0))
		end

		return
	end)

	arg_25_0.exited = true

	return
end

return var_0_0
