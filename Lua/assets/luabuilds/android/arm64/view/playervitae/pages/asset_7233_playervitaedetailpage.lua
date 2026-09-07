local PlayerVitaeDetailPage = class("PlayerVitaeDetailPage", import("...base.BaseSubView"))

function PlayerVitaeDetailPage:getUIName()
	return "PlayerVitaeDetailPage"
end

function PlayerVitaeDetailPage:OnPlayerNameChange(arg_2_1)
	self.player = arg_2_1
	self.nameTxt.text = arg_2_1.name

	return
end

function PlayerVitaeDetailPage:OnLoaded()
	self.medalTpl = self._tf:Find("medalList/tpl")
	self.emblemIcon = self._tf:Find("power/medal"):GetComponent(typeof(Image))
	self.emblemTxt = self._tf:Find("power/medal_text"):GetComponent(typeof(Image))
	self.highestEmblem = self._tf:Find("power/rank"):GetComponent(typeof(Text))
	self.powerTxt = self._tf:Find("power/power"):GetComponent(typeof(Text))
	self.collectionTxt = self._tf:Find("power/collection"):GetComponent(typeof(Text))
	self.modityNameBtn = self._tf:Find("info/name")
	self.nameTxt = self._tf:Find("info/name/Text"):GetComponent(typeof(Text))
	self.idTxt = self._tf:Find("info/uid"):GetComponent(typeof(Text))
	self.levelTxt = self._tf:Find("info/level"):GetComponent(typeof(Text))
	self.expTxt = self._tf:Find("info/exp"):GetComponent(typeof(Text))
	self.copyBtn = self._tf:Find("info/copy")
	self.statisticTpl = self._tf:Find("statistics/tpl")
	self.shareBtn = self._tf:Find("btn_share")
	self.attireBtn = self._tf:Find("btn_attire")
	self.attireBtnTip = self.attireBtn:Find("tip")
	self.inputField = self._tf:Find("greet/InputField")
	self.writeBtn = self._tf:Find("greet/write_btn")
	self.animPanels = {
		self._tf:Find("info"),
		self._tf:Find("power"),
		self._tf:Find("statistics"),
		self._tf:Find("greet")
	}

	setText(self._tf:Find("power/collection_label"), i18n("friend_resume_collection_rate"))
	setText(self._tf:Find("power/power_label"), i18n("friend_resume_fleet_gs"))
	setText(self._tf:Find("info/title_name"), i18n("friend_resume_title"))
	setText(self._tf:Find("statistics/title_name"), i18n("friend_resume_data_title"))
	setText(self._tf:Find("greet/InputField/Placeholder"), i18n("player_manifesto_placeholder"))
	self:MatchResolution()

	return
end

function PlayerVitaeDetailPage:PreCalcAspect(arg_4_1)
	return self.rect.height / arg_4_1
end

function PlayerVitaeDetailPage:MatchResolution()
	local var_5_0 = PlayerVitaeDetailPage.PreCalcAspect(self._parentTf, self._tf.rect.height)

	self._tf.localScale = Vector3(var_5_0, var_5_0, 1)

	return
end

function PlayerVitaeDetailPage:OnInit()
	onButton(self, self.modityNameBtn, function()
		local var_7_0, var_7_1 = self.player:canModifyName()

		if not var_7_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_7_1)

			return
		end

		self.contextData.renamePage:ExecuteAction("Show", self.player)

		return
	end, SFX_PANEL)
	onButton(self, self.copyBtn, function()
		UniPasteBoard.SetClipBoardString(self.player.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(self, self.writeBtn, function()
		activateInputField(self.inputField)

		return
	end, SFX_PANEL)
	onButton(self, self.shareBtn, function()
		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeAdmira)

		return
	end, SFX_PANEL)
	onButton(self, self.attireBtn, function()
		self:emit(PlayerVitaeMediator.ON_ATTIRE)

		return
	end, SFX_PANEL)
	setActive(self.attireBtnTip, underscore.any(getProxy(AttireProxy):needTip(), function(arg_12_0)
		return arg_12_0 == true
	end))
	onInputEndEdit(self, self.inputField, function(arg_13_0)
		if wordVer(arg_13_0) > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("playerinfo_mask_word"))
			activateInputField(self.inputField)

			return
		end

		if not arg_13_0 or self.manifesto == arg_13_0 then
			return
		end

		self.manifesto = arg_13_0

		self:emit(PlayerVitaeMediator.CHANGE_MANIFESTO, arg_13_0)

		return
	end)
	self._tf:SetAsFirstSibling()

	return
end

function PlayerVitaeDetailPage:Show(arg_14_1, arg_14_2)
	PlayerVitaeDetailPage.super.Show(self)

	self.player = arg_14_1

	self:UpdateMedals()
	self:UpdatePower()
	self:UpdateInfo()
	self:UpdateStatistics()

	if arg_14_2 then
		self:DoEnterAnimation()
	end

	return
end

function PlayerVitaeDetailPage:DoEnterAnimation()
	for iter_15_0, iter_15_1 in ipairs(self.animPanels) do
		iter_15_1.localPosition = Vector3(iter_15_1.localPosition.x + 800, iter_15_1.localPosition.y, 0)

		LeanTween.moveLocalX(iter_15_1.gameObject, iter_15_1.localPosition.x, 0.2 + (iter_15_0 - 1) * 0.05):setDelay(iter_15_0 * 0.05):setEase(LeanTweenType.easeInOutSine)
	end

	return
end

function PlayerVitaeDetailPage:UpdateMedals()
	local var_16_0 = self.player.displayTrophyList
	local var_16_1 = 353
	local var_16_2 = 30

	UIItemList.StaticAlign(self.medalTpl.parent, self.medalTpl, math.min(5, #self.player.displayTrophyList), function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1

		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = var_16_0[arg_17_1] > 0 and LoveLetterTrophy.New({
				id = var_16_0[arg_17_1]
			}) or Trophy.New({
				id = var_16_0[arg_17_1]
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

			arg_17_2.anchoredPosition = Vector2(var_16_1 - (arg_17_1 - 1) * (var_16_2 + arg_17_2.sizeDelta.x), arg_17_2.anchoredPosition.y)
		end

		return
	end)

	return
end

function PlayerVitaeDetailPage:UpdatePower()
	local var_18_0 = getProxy(MilitaryExerciseProxy):RawGetSeasonInfo()
	local var_18_1 = SeasonInfo.getEmblem(var_18_0.score, var_18_0.rank)

	LoadSpriteAsync("emblem/" .. var_18_1, function(arg_19_0)
		self.emblemIcon.sprite = arg_19_0

		self.emblemIcon:SetNativeSize()

		return
	end)
	LoadSpriteAsync("emblem/n_" .. var_18_1, function(arg_20_0)
		if self.exited then
			return
		end

		self.emblemTxt.sprite = arg_20_0

		self.emblemTxt:SetNativeSize()

		return
	end)

	self.highestEmblem.text = i18n("friend_resume_title_metal") .. pg.arena_data_rank[math.min(math.max(self.player.maxRank, 1), 14)].name

	getProxy(BayProxy):GetBayPowerRootedAsyn(function(arg_21_0)
		if self.exited then
			return
		end

		self.powerTxt.text = math.floor(arg_21_0)

		return
	end)

	self.collectionTxt.text = getProxy(CollectionProxy):getCollectionRate() * 100 .. "%"

	return
end

function PlayerVitaeDetailPage:UpdateInfo()
	self.nameTxt.text = self.player.name
	self.idTxt.text = self.player.id
	self.levelTxt.text = "LV." .. self.player.level
	self.expTxt.text = self.player.exp .. "/" .. getConfigFromLevel1(pg.user_level, self.player.level).exp

	setInputText(self.inputField, (self.player:GetManifesto()))

	return
end

function PlayerVitaeDetailPage:UpdateStatistics()
	local var_23_0 = self:GetDisplayStatisticsData()
	local var_23_1 = Vector2(355, 25)
	local var_23_2 = self.statisticTpl.anchoredPosition

	for iter_23_0 = 1, #var_23_0, 2 do
		local var_23_4 = var_23_2.y - (iter_23_0 - 1) * var_23_1.y

		for iter_23_1 = 1, 2 do
			local var_23_5

			if iter_23_1 == 1 and iter_23_0 == 1 then
				var_23_5 = self.statisticTpl or cloneTplTo(self.statisticTpl, self.statisticTpl.parent)
			end

			local var_23_6 = var_23_0[iter_23_0 + (iter_23_1 - 1)]

			setText(var_23_5, i18n(var_23_0[iter_23_0 + (iter_23_1 - 1)][1]))
			setText(var_23_5:Find("value"), var_23_6[2])

			var_23_5.anchoredPosition = Vector2(var_23_2.x + (iter_23_1 - 1) * var_23_1.x, var_23_4)
		end
	end

	return
end

function PlayerVitaeDetailPage:GetDisplayStatisticsData()
	return {
		{
			"friend_resume_ship_count",
			self.player.shipCount
		},
		{
			"friend_event_count",
			self.player.collect_attack_count
		},
		{
			"friend_resume_attack_count",
			self.player.attackCount
		},
		{
			"friend_resume_manoeuvre_count",
			self.player.pvp_attack_count
		},
		{
			"friend_resume_attack_win_rate",
			string.format("%0.1f", self.player.winCount / math.max(self.player.attackCount, 1) * 100) .. "%"
		},
		{
			"friend_resume_manoeuvre_win_rate",
			string.format("%0.1f", self.player.pvp_win_count / math.max(self.player.pvp_attack_count, 1) * 100) .. "%"
		}
	}
end

function PlayerVitaeDetailPage:OnDestroy()
	for iter_25_0, iter_25_1 in ipairs(self.animPanels) do
		if LeanTween.isTweening(iter_25_1.gameObject) then
			LeanTween.cancel(iter_25_1.gameObject)
		end
	end

	eachChild(self.medalTpl.parent, function(arg_26_0, arg_26_1)
		if arg_26_0:Find("now/medal").childCount > 0 then
			returnLoveLetterMedal(arg_26_0:Find("now/medal"):GetChild(0))
		end

		return
	end)

	self.exited = true

	return
end

return PlayerVitaeDetailPage
