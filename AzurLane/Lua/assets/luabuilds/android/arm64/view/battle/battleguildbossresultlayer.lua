class = var_0_10000

local var_0_0 = "BattleGuildBossResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleResultLayer"))

function var_0_1.showRightBottomPanel(arg_1_0)
	var_0_1.super.showRightBottomPanel(arg_1_0)

	SetActive = var_1

	var_1(arg_1_0._rightBottomPanel, false)

	local var_1_0 = arg_1_0._blurConatiner
	local var_1_1 = var_1.Find(var_1_0, "activitybossConfirmPanel")

	setActive = var_1_10002

	var_1_10002(var_1_1, true)

	onButton = var_1_10002

	local var_1_2 = arg_1_0
	local var_1_3 = var_1_1
	local var_1_4 = var_1_1.Find(var_1_3, "statisticsBtn")

	local function var_1_5()
		triggerButton = var_2_10000

		var_2_10000(arg_1_0._statisticsBtn)

		return
	end

	SFX_PANEL = var_1_3

	var_1_10002(var_1_2, var_1_4, var_1_5, var_1_3)

	setText = var_1_10002

	local var_1_6 = var_1_1:Find("confirmBtn/Image")

	i18n = var_1_4

	var_1_10002(var_1_6, var_1_4("text_confirm"))

	onButton = var_1_10002

	local var_1_7 = arg_1_0
	local var_1_8 = var_1_1
	local var_1_9 = var_1_1.Find(var_1_8, "confirmBtn")

	local function var_1_10()
		triggerButton = var_2_10000

		var_2_10000(arg_1_0._confirmBtn)

		return
	end

	SFX_CONFIRM = var_1_8

	var_1_10002(var_1_7, var_1_9, var_1_10, var_1_8)

	setText = var_1_10002

	local var_1_11 = var_1_1:Find("confirmBtn/Image")

	i18n = var_1_9

	var_1_10002(var_1_11, var_1_9("text_confirm"))

	return
end

function var_0_1.didEnter(arg_4_0)
	var_0_1.super.didEnter(arg_4_0)
	arg_4_0:setPoint()

	return
end

function var_0_1.setGradeLabel(arg_5_0)
	local var_5_0 = arg_5_0._tf
	local var_5_1 = var_1.Find(var_5_0, "grade/Xyz/bg13")
	local var_5_2 = arg_5_0._tf
	local var_5_3 = var_2.Find(var_5_2, "grade/Xyz/bg14")

	setActive = var_5_0

	var_5_0(var_5_1, false)

	local var_5_4 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_5_2

	var_5_2(var_5_4, var_5_3, false)

	return
end

function var_0_1.rankAnimaFinish(arg_6_0)
	setActive = var_1_10001

	var_1_10001(arg_6_0._conditionBGNormal, false)

	setActive = var_1_10001

	var_1_10001(arg_6_0._conditionBGContribute, true)

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.setCondition

	i18n = var_4

	local var_6_2 = var_4("battle_result_total_damage")
	local var_6_3 = arg_6_0.contextData.statistics.specificDamage

	COLOR_BLUE = var_6

	var_6_1(var_6_0, var_6_2, var_6_3, var_6)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.setCondition

	i18n = var_6_2

	local var_6_6 = var_6_2("battle_result_contribution")
	local var_6_7 = arg_6_0._contributionPoint

	COLOR_YELLOW = var_6

	var_6_5(var_6_4, var_6_6, var_6_7, var_6)

	LeanTween = var_6_5

	local var_6_8 = var_6_5.delayedCall
	local var_6_9 = 1

	System = var_6_6

	local var_6_10 = var_6_8(var_6_9, var_6_6.Action(function()
		local var_7_0 = arg_6_0

		var_7_0._stateFlag = var_0_1.STATE_REPORTED
		SetActive = var_7_0

		local var_7_1 = arg_6_0._bg

		var_7_0(var_2.Find(var_7_1, "jieuan01/tips"), true)

		return
	end))

	table = var_1_10002

	var_1_10002.insert(arg_6_0._delayLeanList, var_6_10.id)

	arg_6_0._stateFlag = var_0_1.STATE_REPORT

	return
end

function var_0_1.setCondition(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	cloneTplTo = var_1_10004

	local var_8_0 = var_1_10004(arg_8_0._conditionContributeTpl, arg_8_0._conditionContainer)

	setActive = var_1_10005

	var_1_10005(var_8_0, false)

	local var_8_1
	local var_8_2 = var_8_0:Find("text")
	local var_8_3 = var_6.GetComponent

	typeof = var_9
	Text = var_1_10011

	local var_8_4 = var_8_3(var_8_2, var_9(var_1_10011))

	setColorStr = var_7
	var_8_4.text = var_7(arg_8_1, "#FFFFFFFF")

	local var_8_5 = var_8_0:Find("value")
	local var_8_6 = var_7.GetComponent

	typeof = var_10
	Text = var_1_10012

	local var_8_7 = var_8_6(var_8_5, var_10(var_1_10012))

	setColorStr = var_8_2
	var_8_7.text = var_8_2(arg_8_2, arg_8_3)

	local var_8_8 = arg_8_0._conditionContainer.childCount - 1
	local var_8_9

	if 0 < var_8_8 then
		LeanTween = var_8_9
		var_8_9 = var_8_9.delayedCall

		local var_8_10 = var_0_1.CONDITIONS_FREQUENCE * var_8_8

		System = var_1_10012
		var_8_9 = var_8_9(var_8_10, var_1_10012.Action(function()
			setActive = var_2_10000

			var_2_10000(var_8_0, true)

			return
		end))
		table = var_10

		var_10.insert(arg_8_0._delayLeanList, var_8_9.id)
	else
		setActive = var_8_9

		var_8_9(var_8_0, true)
	end

	return
end

function var_0_1.setActId(arg_10_0, arg_10_1)
	return
end

function var_0_1.showRewardInfo(arg_11_0)
	arg_11_0._stateFlag = var_0_1.STATE_REWARD
	SetActive = var_1

	local var_11_0 = arg_11_0._bg

	var_1(var_3.Find(var_11_0, "jieuan01/tips"), false)
	arg_11_0:displayBG()

	return
end

function var_0_1.setPoint(arg_12_0)
	arg_12_0._contributionPoint = 0
	pg = var_1

	local var_12_0 = var_1.guildset.guild_damage_resource.key_value

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.contextData.drops) do
		if iter_12_1.configId == var_12_0 then
			arg_12_0._contributionPoint = iter_12_1.count
		end
	end

	setActive = var_2

	local var_12_1 = arg_12_0._tf

	var_2(var_4.Find(var_12_1, "blur_container/activitybossConfirmPanel/playAgain"), false)

	return
end

function var_0_1.displayShips(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = arg_13_0.shipVOs

	ipairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(var_13_1) do
		var_13_0[iter_13_1.id] = iter_13_1
	end

	local var_13_2 = arg_13_0.contextData.statistics

	ipairs = var_4

	for iter_13_2, iter_13_3 in var_4(var_13_1) do
		if var_13_2[iter_13_3.id] then
			var_1_10009 = var_13_2[iter_13_3.id]
			var_1_10009.vo = iter_13_3
		end
	end

	local var_13_3
	local var_13_4

	if var_13_2.mvpShipID and var_13_2.mvpShipID ~= 0 then
		var_13_4 = var_13_2[var_13_2.mvpShipID].output
	else
		var_13_4 = 0
	end

	local var_13_5 = arg_13_0.contextData.oldMainShips

	arg_13_0._atkFuncs = {}

	local var_13_6
	local var_13_7

	SetActive = var_1_10009

	var_1_10009(arg_13_0._atkToggle, #var_13_5 > 6)

	local var_13_8

	if #var_13_5 > 6 then
		onToggle = var_9
		var_13_8 = arg_13_0

		local var_13_9 = arg_13_0._atkToggle

		local function var_13_10(arg_14_0)
			SetActive = var_2_10001

			var_2_10001(arg_13_0._atkContainer, arg_14_0)

			SetActive = var_2_10001

			var_2_10001(arg_13_0._atkContainerNext, not arg_14_0)

			if arg_14_0 then
				local var_14_0 = arg_13_0

				var_1.skipAtkAnima(var_14_0, arg_13_0._atkContainerNext)
			else
				local var_14_1 = arg_13_0

				var_1.skipAtkAnima(var_14_1, arg_13_0._atkContainer)
			end

			return
		end

		SFX_PANEL = var_1_10014

		var_9(var_13_8, var_13_9, var_13_10, var_1_10014)
	end

	local var_13_11 = {}
	local var_13_12 = {}

	ipairs = var_13_8

	for iter_13_4, iter_13_5 in var_13_8(var_13_5) do
		local var_13_13

		if not var_13_0[iter_13_5.id] then
			var_13_13 = iter_13_5
		end

		if var_13_2[iter_13_5.id] then
			ys = var_17

			local var_13_14 = var_17.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_13_5.configId).type

			table = var_1_10018
			var_1_10018 = var_1_10018.contains
			ShipType = var_1_10020
			var_1_10018 = var_1_10018(var_1_10020.SubShipType, var_13_14)

			local var_13_15

			var_1_10020 = nil

			local var_13_16 = 0
			local var_13_17

			if 6 < iter_13_4 then
				var_1_10020 = arg_13_0._atkContainerNext
				var_13_17 = 7
			else
				var_1_10020 = arg_13_0._atkContainer
				var_13_17 = 1
			end

			cloneTplTo = var_22
			var_22.x = var_22(arg_13_0._atkTpl, var_1_10020).localPosition.x + (iter_13_4 - var_13_17) * 74
			var_22.y = var_22.y + (iter_13_4 - var_13_17) * 4
			var_19.localPosition = var_22
			findTF = var_23

			local var_13_18 = var_23(var_19, "result/stars")

			findTF = var_24

			local var_13_19 = var_24(var_19, "result/stars/star_tpl")
			local var_13_20 = iter_13_5:getStar()
			local var_13_21 = iter_13_5
			local var_13_22 = iter_13_5.getMaxStar(var_13_21)

			while 0 < var_13_22 do
				cloneTplTo = var_13_23

				local var_13_23 = var_13_23(var_13_19, var_13_18)

				SetActive = var_13_21
				var_1_10032 = var_13_23

				var_13_21(var_13_23.Find(var_1_10032, "empty"), var_13_20 < var_13_22)

				SetActive = var_13_21
				var_1_10032 = var_13_23

				var_13_21(var_13_23.Find(var_1_10032, "star"), var_13_22 <= var_13_20)

				var_13_22 = var_13_22 - 1
			end

			local var_13_24 = var_19:Find("result/mask/icon")
			local var_13_25 = var_19
			local var_13_26 = var_19.Find(var_13_25, "result/type")
			local var_13_27 = var_13_24
			local var_13_28 = var_13_24.GetComponent

			typeof = var_1_10032
			Image = var_1_10034

			local var_13_29 = var_13_28(var_13_27, var_1_10032(var_1_10034))

			LoadSprite = var_13_25
			var_13_29.sprite = var_13_25("herohrzicon/" .. iter_13_5:getPainting())

			local var_13_30 = var_13_2[iter_13_5.id].output / var_13_4

			GetSpriteFromAtlas = var_30
			var_1_10032 = "shiptype"
			shipType2print = var_33

			local var_13_31 = var_30(var_1_10032, var_33(iter_13_5:getShipType()))

			setImageSprite = var_13_27

			var_13_27(var_13_26, var_13_31, true)
			arg_13_0:setAtkAnima(var_19, var_1_10020, var_13_30, var_13_4, var_13_3 and iter_13_5.id == var_13_3.id, var_13_2[iter_13_5.id].output, var_13_2[iter_13_5.id].kill_count)

			local var_13_32

			var_1_10032 = false

			local var_13_36, var_13_41

			if var_13_3 and iter_13_5.id == var_13_3.id then
				var_1_10032 = true
				arg_13_0.mvpShipVO = iter_13_5

				local var_13_33

				var_1_10034 = nil

				local var_13_34
				local var_13_35 = arg_13_0.contextData.score
				local var_13_37

				if 1 < var_13_35 then
					ShipWordHelper = var_13_35
					var_13_35 = var_13_35.GetWordAndCV
					var_13_36 = arg_13_0.mvpShipVO.skinId
					ShipWordHelper = var_13_37
					var_13_37 = var_13_37.WORD_TYPE_MVP

					local var_13_38
					local var_13_39
					local var_13_40 = arg_13_0.mvpShipVO

					var_13_35, var_13_41, var_13_36 = var_13_35(var_13_36, var_13_37, var_13_38, var_13_39, var_42.getCVIntimacy(var_13_40))
					var_1_10034 = var_13_36
					var_13_34 = var_13_41

					local var_13_42 = var_13_35
				else
					ShipWordHelper = var_13_35

					local var_13_43 = var_13_35.GetWordAndCV

					var_13_36 = arg_13_0.mvpShipVO.skinId
					ShipWordHelper = var_13_37

					local var_13_44

					var_13_44, var_13_41, var_13_36 = var_13_43(var_13_36, var_13_37.WORD_TYPE_LOSE)
					var_1_10034 = var_13_36
					var_13_34 = var_13_41

					local var_13_45 = var_13_44
				end

				if var_13_34 then
					var_13_36 = arg_13_0

					arg_13_0.stopVoice(var_13_36)

					pg = var_36
					var_13_36 = var_36.CriMgr.GetInstance()

					var_36.PlaySoundEffect_V3(var_13_36, var_13_34, function(arg_15_0)
						arg_13_0._currentVoice = arg_15_0

						return
					end)
				end
			end

			if iter_13_5.id == var_13_2._flagShipID then
				arg_13_0.flagShipVO = iter_13_5
			end

			local var_13_46

			if arg_13_0.shipBuff then
				var_1_10034 = arg_13_0.shipBuff
				var_13_41 = iter_13_5
				var_1_10034 = var_1_10034[iter_13_5.getGroupId(var_13_41)]
			end

			local var_13_47

			if not arg_13_0.expBuff then
				var_13_47 = var_1_10034
			end

			if var_13_47 then
				if arg_13_0.expBuff then
					var_13_36 = arg_13_0.expBuff

					if not var_36.getConfig(var_13_36, "name") then
						::label_13_0::

						if var_1_10034 then
							::label_13_1::

							i18n = var_36
							var_13_46 = var_36("Word_Ship_Exp_Buff")
						end
					end

					local var_13_48

					if not var_1_10018 then
						cloneTplTo = var_13_41
						var_13_41 = var_13_41(arg_13_0._extpl, arg_13_0._expContainer)
						BattleResultShipCard = var_13_36
						var_13_48 = var_13_36.New(var_13_41)
						table = var_13_36

						var_13_36.insert(arg_13_0._shipResultCardList, var_13_48)

						if var_13_7 then
							var_13_7:ConfigCallback(function()
								local var_16_0 = var_13_48

								var_0.Play(var_16_0)

								return
							end)
						else
							var_13_48:Play()
						end

						var_13_7 = var_13_48
					else
						cloneTplTo = var_13_41

						local var_13_49 = var_13_41(arg_13_0._extpl, arg_13_0._subExpContainer)

						BattleResultShipCard = var_13_36
						var_13_48 = var_13_36.New(var_13_49)
						table = var_38

						var_38.insert(arg_13_0._subShipResultCardList, var_13_48)

						if not var_13_6 then
							arg_13_0._subFirstExpCard = var_13_48
						else
							var_13_6:ConfigCallback(function()
								local var_17_0 = var_13_48

								var_0.Play(var_17_0)

								return
							end)
						end

						var_13_6 = var_13_48
					end

					var_13_48:SetShipVO(iter_13_5, var_13_13, var_1_10032, var_13_46)
				end
			end
		end
	end

	if var_13_7 then
		var_13_7:ConfigCallback(function()
			arg_13_0._stateFlag = var_0_1.STATE_DISPLAYED

			if not arg_13_0._subFirstExpCard then
				local var_18_0 = arg_13_0

				var_0.skip(var_18_0)
			end

			return
		end)
	end

	if var_13_6 then
		var_13_6:ConfigCallback(function()
			arg_13_0._stateFlag = var_0_1.STATE_SUB_DISPLAYED

			local var_19_0 = arg_13_0

			var_0.skip(var_19_0)

			return
		end)
	end

	return
end

return var_0_1
