local var_0_0 = class("BattleGuildBossResultLayer", import(".BattleResultLayer"))

function var_0_0.showRightBottomPanel(arg_1_0)
	var_0_0.super.showRightBottomPanel(arg_1_0)
	SetActive(arg_1_0._rightBottomPanel, false)

	local var_1_0 = arg_1_0._blurConatiner:Find("activitybossConfirmPanel")

	setActive(var_1_0, true)
	onButton(arg_1_0, var_1_0:Find("statisticsBtn"), function()
		triggerButton(arg_1_0._statisticsBtn)

		return
	end, SFX_PANEL)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))
	onButton(arg_1_0, var_1_0:Find("confirmBtn"), function()
		triggerButton(arg_1_0._confirmBtn)

		return
	end, SFX_CONFIRM)
	setText(var_1_0:Find("confirmBtn/Image"), i18n("text_confirm"))

	return
end

function var_0_0.didEnter(arg_4_0)
	var_0_0.super.didEnter(arg_4_0)
	arg_4_0:setPoint()

	return
end

function var_0_0.setGradeLabel(arg_5_0)
	setActive(arg_5_0._tf:Find("grade/Xyz/bg13"), false)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_5_0._tf:Find("grade/Xyz/bg14"), false)

	return
end

function var_0_0.rankAnimaFinish(arg_6_0)
	setActive(arg_6_0._conditionBGNormal, false)
	setActive(arg_6_0._conditionBGContribute, true)
	arg_6_0:setCondition(i18n("battle_result_total_damage"), arg_6_0.contextData.statistics.specificDamage, COLOR_BLUE)
	arg_6_0:setCondition(i18n("battle_result_contribution"), arg_6_0._contributionPoint, COLOR_YELLOW)
	table.insert(arg_6_0._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
		arg_6_0._stateFlag = var_0_0.STATE_REPORTED

		SetActive(arg_6_0._bg:Find("jieuan01/tips"), true)

		return
	end)).id)

	arg_6_0._stateFlag = var_0_0.STATE_REPORT

	return
end

function var_0_0.setCondition(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = cloneTplTo(arg_8_0._conditionContributeTpl, arg_8_0._conditionContainer)

	setActive(var_8_0, false)

	var_8_0:Find("text"):GetComponent(typeof(Text)).text = setColorStr(arg_8_1, "#FFFFFFFF")
	var_8_0:Find("value"):GetComponent(typeof(Text)).text = setColorStr(arg_8_2, arg_8_3)

	if arg_8_0._conditionContainer.childCount - 1 > 0 then
		table.insert(arg_8_0._delayLeanList, LeanTween.delayedCall(var_0_0.CONDITIONS_FREQUENCE * (arg_8_0._conditionContainer.childCount - 1), System.Action(function()
			setActive(var_8_0, true)

			return
		end)).id)
	else
		setActive(var_8_0, true)
	end

	return
end

function var_0_0.setActId(arg_10_0, arg_10_1)
	return
end

function var_0_0.showRewardInfo(arg_11_0)
	arg_11_0._stateFlag = var_0_0.STATE_REWARD

	SetActive(arg_11_0._bg:Find("jieuan01/tips"), false)
	arg_11_0:displayBG()

	return
end

function var_0_0.setPoint(arg_12_0)
	arg_12_0._contributionPoint = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.contextData.drops) do
		if iter_12_1.configId == pg.guildset.guild_damage_resource.key_value then
			arg_12_0._contributionPoint = iter_12_1.count
		end
	end

	setActive(arg_12_0._tf:Find("blur_container/activitybossConfirmPanel/playAgain"), false)

	return
end

function var_0_0.displayShips(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.shipVOs) do
		({})[iter_13_1.id] = iter_13_1
	end

	local var_13_0 = arg_13_0.contextData.statistics

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.shipVOs) do
		if var_13_0[iter_13_3.id] then
			var_13_0[iter_13_3.id].vo = iter_13_3
		end
	end

	local var_13_1
	local var_13_2

	if var_13_0.mvpShipID and var_13_0.mvpShipID ~= 0 then
		var_13_1 = var_13_0[var_13_0.mvpShipID]
		var_13_2 = var_13_0[var_13_0.mvpShipID].output
	else
		var_13_2 = 0
	end

	local var_13_3 = arg_13_0.contextData.oldMainShips

	arg_13_0._atkFuncs = {}

	local var_13_4
	local var_13_5

	SetActive(arg_13_0._atkToggle, #var_13_3 > 6)

	if #var_13_3 > 6 then
		onToggle(arg_13_0, arg_13_0._atkToggle, function(arg_14_0)
			SetActive(arg_13_0._atkContainer, arg_14_0)
			SetActive(arg_13_0._atkContainerNext, not arg_14_0)

			if arg_14_0 then
				arg_13_0:skipAtkAnima(arg_13_0._atkContainerNext)
			else
				arg_13_0:skipAtkAnima(arg_13_0._atkContainer)
			end

			return
		end, SFX_PANEL)
	end

	for iter_13_4, iter_13_5 in ipairs(var_13_3) do
		local var_13_8 = ({})[iter_13_5.id]

		if not ({})[iter_13_5.id] then
			var_13_8 = iter_13_5
		end

		if var_13_0[iter_13_5.id] then
			local var_13_9 = table.contains(ShipType.SubShipType, ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_13_5.configId).type)
			local var_13_11
			local var_13_13

			if iter_13_4 > 6 then
				var_13_11 = arg_13_0._atkContainerNext
				var_13_13 = 7
			else
				var_13_11 = arg_13_0._atkContainer
				var_13_13 = 1
			end

			local var_13_14 = cloneTplTo(arg_13_0._atkTpl, var_13_11)

			var_13_14.localPosition.x = var_13_14.localPosition.x + (iter_13_4 - var_13_13) * 74
			var_13_14.localPosition.y = var_13_14.localPosition.y + (iter_13_4 - var_13_13) * 4
			var_13_14.localPosition = var_13_14.localPosition

			local var_13_15 = findTF(var_13_14, "result/stars")
			local var_13_16 = findTF(var_13_14, "result/stars/star_tpl")
			local var_13_17 = iter_13_5:getStar()
			local var_13_18 = iter_13_5:getMaxStar()

			while var_13_18 > 0 do
				local var_13_19 = cloneTplTo(var_13_16, var_13_15)

				SetActive(var_13_19:Find("empty"), var_13_17 < var_13_18)
				SetActive(var_13_19:Find("star"), var_13_18 <= var_13_17)

				var_13_18 = var_13_18 - 1
			end

			local var_13_20 = var_13_14:Find("result/mask/icon")
			local var_13_21 = var_13_14:Find("result/type")

			var_13_20:GetComponent(typeof(Image)).sprite = LoadSprite("herohrzicon/" .. iter_13_5:getPainting())

			setImageSprite(var_13_21, GetSpriteFromAtlas("shiptype", shipType2print(iter_13_5:getShipType())), true)
			arg_13_0:setAtkAnima(var_13_14, var_13_11, var_13_0[iter_13_5.id].output / var_13_2, var_13_2, var_13_1 and iter_13_5.id == var_13_1.id, var_13_0[iter_13_5.id].output, var_13_0[iter_13_5.id].kill_count)

			local var_13_23 = false

			if var_13_1 and iter_13_5.id == var_13_1.id then
				var_13_23 = true
				arg_13_0.mvpShipVO = iter_13_5

				local var_13_26

				if arg_13_0.contextData.score > 1 then
					local var_13_27, var_13_28

					var_13_27, var_13_26, var_13_28 = ShipWordHelper.GetWordAndCV(arg_13_0.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_MVP, nil, nil, arg_13_0.mvpShipVO:getCVIntimacy())
				else
					local var_13_29, var_13_30

					var_13_29, var_13_26, var_13_30 = ShipWordHelper.GetWordAndCV(arg_13_0.mvpShipVO.skinId, ShipWordHelper.WORD_TYPE_LOSE)
				end

				if var_13_26 then
					arg_13_0:stopVoice()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_13_26, function(arg_15_0)
						arg_13_0._currentVoice = arg_15_0

						return
					end)
				end
			end

			if iter_13_5.id == var_13_0._flagShipID then
				arg_13_0.flagShipVO = iter_13_5
			end

			local var_13_31
			local var_13_32 = arg_13_0.shipBuff and arg_13_0.shipBuff[iter_13_5:getGroupId()]
			local var_13_33 = arg_13_0.expBuff or var_13_32

			if var_13_33 then
				var_13_31 = arg_13_0.expBuff and arg_13_0.expBuff:getConfig("name") or var_13_32 and i18n("Word_Ship_Exp_Buff")
			end

			local var_13_34

			if not var_13_9 then
				var_13_34 = BattleResultShipCard.New((cloneTplTo(arg_13_0._extpl, arg_13_0._expContainer)))

				table.insert(arg_13_0._shipResultCardList, var_13_34)

				if var_13_5 then
					var_13_5:ConfigCallback(function()
						var_13_34:Play()

						return
					end)
				else
					var_13_34:Play()
				end

				var_13_5 = var_13_34
			else
				var_13_34 = BattleResultShipCard.New((cloneTplTo(arg_13_0._extpl, arg_13_0._subExpContainer)))

				table.insert(arg_13_0._subShipResultCardList, var_13_34)

				if not var_13_4 then
					arg_13_0._subFirstExpCard = var_13_34
				else
					var_13_4:ConfigCallback(function()
						var_13_34:Play()

						return
					end)
				end

				var_13_4 = var_13_34
			end

			var_13_34:SetShipVO(iter_13_5, var_13_8, var_13_23, var_13_31)
		end
	end

	if var_13_5 then
		var_13_5:ConfigCallback(function()
			arg_13_0._stateFlag = var_0_0.STATE_DISPLAYED

			if not arg_13_0._subFirstExpCard then
				arg_13_0:skip()
			end

			return
		end)
	end

	if var_13_4 then
		var_13_4:ConfigCallback(function()
			arg_13_0._stateFlag = var_0_0.STATE_SUB_DISPLAYED

			arg_13_0:skip()

			return
		end)
	end

	return
end

return var_0_0
