local BattleGuildBossResultLayer = class("BattleGuildBossResultLayer", import(".BattleResultLayer"))

function BattleGuildBossResultLayer:showRightBottomPanel()
	BattleGuildBossResultLayer.super.showRightBottomPanel(self)
	SetActive(self._rightBottomPanel, false)

	local var_1_0 = self._blurConatiner:Find("activitybossConfirmPanel")

	setActive(var_1_0, true)
	onButton(self, var_1_0:Find("statisticsBtn"), function()
		triggerButton(self._statisticsBtn)

		return
	end, SFX_PANEL)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))
	onButton(self, var_1_0:Find("confirmBtn"), function()
		triggerButton(self._confirmBtn)

		return
	end, SFX_CONFIRM)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))

	return
end

function BattleGuildBossResultLayer:didEnter()
	BattleGuildBossResultLayer.super.didEnter(self)
	self:setPoint()

	return
end

function BattleGuildBossResultLayer:setGradeLabel()
	setActive(self._tf:Find("grade/Xyz/bg13"), false)
	LoadImageSpriteAsync("battlescore/grade_label_clear", self._tf:Find("grade/Xyz/bg14"), false)

	return
end

function BattleGuildBossResultLayer:rankAnimaFinish()
	setActive(self._conditionBGNormal, false)
	setActive(self._conditionBGContribute, true)
	self:setCondition(i18n("battle_result_total_damage"), self.contextData.statistics.specificDamage, COLOR_BLUE)
	self:setCondition(i18n("battle_result_contribution"), self._contributionPoint, COLOR_YELLOW)
	table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		self._stateFlag = BattleGuildBossResultLayer.STATE_REPORTED

		SetActive(self._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	self._stateFlag = BattleGuildBossResultLayer.STATE_REPORT

	return
end

function BattleGuildBossResultLayer:setCondition(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = cloneTplTo(self._conditionContributeTpl, self._conditionContainer)

	setActive(var_8_0, false)

	var_8_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_8_1, "#FFFFFFFF")
	var_8_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_8_2, arg_8_3)

	if self._conditionContainer.childCount - 1 > 0 then
		table.insert(self._delayLeanList, LeanTween.delayedCall(BattleGuildBossResultLayer.CONDITIONS_FREQUENCE * (self._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_8_0, true)

			return
		end)).id)
	else
		setActive(var_8_0, true)
	end

	return
end

function BattleGuildBossResultLayer:setActId(arg_10_1)
	return
end

function BattleGuildBossResultLayer:showRewardInfo()
	self._stateFlag = BattleGuildBossResultLayer.STATE_REWARD

	SetActive(self._bg:Find("jieuan01/tips"), false)
	self:displayBG()

	return
end

function BattleGuildBossResultLayer:setPoint()
	self._contributionPoint = 0

	for iter_12_0, iter_12_1 in ipairs(self.contextData.drops) do
		if iter_12_1.configId == pg.guildset.guild_damage_resource.key_value then
			self._contributionPoint = iter_12_1.count
		end
	end

	setActive(self._tf:Find("blur_container/activitybossConfirmPanel/playAgain"), false)

	return
end

function BattleGuildBossResultLayer:displayShips()
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(self.shipVOs) do
		var_13_0[iter_13_1.id] = iter_13_1
	end

	local var_13_1 = self.contextData.statistics

	for iter_13_2, iter_13_3 in ipairs(self.shipVOs) do
		if var_13_1[iter_13_3.id] then
			var_13_1[iter_13_3.id].vo = iter_13_3
		end
	end

	local var_13_2
	local var_13_3

	if var_13_1.mvpShipID and var_13_1.mvpShipID ~= 0 then
		var_13_2 = var_13_1[var_13_1.mvpShipID]
		var_13_3 = var_13_1[var_13_1.mvpShipID].output
	else
		var_13_3 = 0
	end

	local var_13_4 = self.contextData.oldMainShips

	self._atkFuncs = {}

	local var_13_5
	local var_13_6

	SetActive(self._atkToggle, #var_13_4 > 6)

	if #var_13_4 > 6 then
		onToggle(self, self._atkToggle, function(arg_14_0)
			SetActive(self._atkContainer, arg_14_0)
			SetActive(self._atkContainerNext, not arg_14_0)

			if arg_14_0 then
				self:skipAtkAnima(self._atkContainerNext)
			else
				self:skipAtkAnima(self._atkContainer)
			end

			return
		end, SFX_PANEL)
	end

	for iter_13_4, iter_13_5 in ipairs(var_13_4) do
		if var_13_1[iter_13_5.id] then
			local var_13_10 = table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_13_5.configId).type)
			local var_13_12
			local var_13_14

			if iter_13_4 > 6 then
				var_13_12 = self._atkContainerNext
				var_13_14 = 7
			else
				var_13_12 = self._atkContainer
				var_13_14 = 1
			end

			local var_13_15 = cloneTplTo(self._atkTpl, var_13_12)

			var_13_15.localPosition.x = var_13_15.localPosition.x + (iter_13_4 - var_13_14) * 74
			var_13_15.localPosition.y = var_13_15.localPosition.y + (iter_13_4 - var_13_14) * 4
			var_13_15.localPosition = var_13_15.localPosition

			local var_13_16 = findTF(var_13_15, "result/stars")
			local var_13_17 = findTF(var_13_15, "result/stars/star_tpl")
			local var_13_18 = iter_13_5:getStar()
			local var_13_19 = iter_13_5:getMaxStar()

			while var_13_19 > 0 do
				local var_13_20 = cloneTplTo(var_13_17, var_13_16)

				SetActive(var_13_20:Find("empty"), var_13_18 < var_13_19)
				SetActive(var_13_20:Find("star"), var_13_19 <= var_13_18)

				var_13_19 = var_13_19 - 1
			end

			local var_13_21 = var_13_15:Find("result/mask/icon")
			local var_13_22 = var_13_15:Find("result/type")

			var_13_21:GetComponent(typeof(Image)).sprite = LoadSprite("herohrzicon/" .. iter_13_5:getPainting())

			setImageSprite(var_13_22, GetSpriteFromAtlas("shiptype", shipType2print(iter_13_5:getShipType())), true)
			self:setAtkAnima(var_13_15, var_13_12, var_13_1[iter_13_5.id].output / var_13_3, var_13_3, var_13_2 and iter_13_5.id == var_13_2.id, var_13_1[iter_13_5.id].output, var_13_1[iter_13_5.id].kill_count)

			local var_13_24 = false

			if var_13_2 and iter_13_5.id == var_13_2.id then
				var_13_24 = true
				self.mvpShipVO = iter_13_5

				local var_13_27

				if self.contextData.score > 1 then
					local var_13_28, var_13_29

					var_13_28, var_13_27, var_13_29 = ShipWordHelper.GetWordAndCV(self.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, self.mvpShipVO:getCVIntimacy())
				else
					local var_13_30, var_13_31

					var_13_30, var_13_27, var_13_31 = ShipWordHelper.GetWordAndCV(self.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_LOSE)
				end

				if var_13_27 then
					self:stopVoice()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_13_27, function(arg_15_0)
						self._currentVoice = arg_15_0

						return
					end)
				end
			end

			if iter_13_5.id == var_13_1._flagShipID then
				self.flagShipVO = iter_13_5
			end

			local var_13_32
			local var_13_33 = self.shipBuff and self.shipBuff[iter_13_5:getGroupId()]

			if self.expBuff or var_13_33 then
				var_13_32 = self.expBuff and self.expBuff:getConfig("name") or var_13_33 and i18n("Word_Ship_Exp_Buff")
			end

			local var_13_34

			if not var_13_10 then
				var_13_34 = BattleResultShipCard.New((cloneTplTo(self._extpl, self._expContainer)))

				table.insert(self._shipResultCardList, var_13_34)

				if var_13_6 then
					var_13_6:ConfigCallback(function()
						var_13_34:Play()

						return
					end)
				else
					var_13_34:Play()
				end

				var_13_6 = var_13_34
			else
				var_13_34 = BattleResultShipCard.New((cloneTplTo(self._extpl, self._subExpContainer)))

				table.insert(self._subShipResultCardList, var_13_34)

				if not var_13_5 then
					self._subFirstExpCard = var_13_34
				else
					var_13_5:ConfigCallback(function()
						var_13_34:Play()

						return
					end)
				end

				var_13_5 = var_13_34
			end

			var_13_34:SetShipVO(iter_13_5, var_13_0[iter_13_5.id] or iter_13_5, var_13_24, var_13_32)
		end
	end

	if var_13_6 then
		var_13_6:ConfigCallback(function()
			self._stateFlag = BattleGuildBossResultLayer.STATE_DISPLAYED

			if not self._subFirstExpCard then
				self:skip()
			end

			return
		end)
	end

	if var_13_5 then
		var_13_5:ConfigCallback(function()
			self._stateFlag = BattleGuildBossResultLayer.STATE_SUB_DISPLAYED

			self:skip()

			return
		end)
	end

	return
end

return BattleGuildBossResultLayer
