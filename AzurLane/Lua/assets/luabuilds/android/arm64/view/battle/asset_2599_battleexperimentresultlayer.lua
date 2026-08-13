class = var_0_10000

local var_0_0 = "BattleExperimentResultLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BattleContributionResultLayer"))

function var_0_1.setPoint(arg_1_0)
	arg_1_0._contributionPoint = 0

	return
end

function var_0_1.skip(arg_2_0)
	ipairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0._delayLeanList) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_2_1)
	end

	if arg_2_0._stateFlag == var_0_1.STATE_RANK_ANIMA then
		-- block empty
	elseif arg_2_0._stateFlag == var_0_1.STATE_REPORT then
		local var_2_0 = arg_2_0._conditionContainer.childCount

		while 0 < var_2_0 do
			SetActive = var_2

			local var_2_1 = arg_2_0._conditionContainer

			var_2(var_4.GetChild(var_2_1, var_2_0 - 1), true)

			var_2_0 = var_2_0 - 1
		end

		SetActive = var_2

		local var_2_2 = arg_2_0._bg

		var_2(var_4.Find(var_2_2, "jieuan01/tips"), true)

		arg_2_0._stateFlag = var_0_1.STATE_REPORTED
	elseif arg_2_0._stateFlag == var_0_1.STATE_REPORTED then
		arg_2_0:displayBG()

		SetActive = var_1

		local var_2_3 = arg_2_0._bg

		var_1(var_3.Find(var_2_3, "jieuan01/tips"), false)
	end

	return
end

function var_0_1.displayBG(arg_3_0)
	rtf = var_1_10001

	local var_3_0 = var_1_10001(arg_3_0._grade)

	LeanTween = var_1_10002

	local var_3_1 = var_1_10002.moveX

	rtf = var_1_10004

	var_3_1(var_1_10004(arg_3_0._conditions), 1300, var_0_1.DURATION_MOVE)

	LeanTween = var_3_1

	local var_3_2 = var_3_1.scale
	local var_3_3 = arg_3_0._grade

	Vector3 = var_5

	var_3_2(var_3_3, var_5(0.6, 0.6, 0), var_0_1.DURATION_MOVE)

	LeanTween = var_3_2

	local var_3_4 = var_3_2.moveLocal

	go = var_3_3

	local var_3_5 = var_3_4(var_3_3(var_3_0), arg_3_0._gradeUpperLeftPos, var_0_1.DURATION_MOVE)
	local var_3_6 = var_2.setOnComplete

	System = var_5

	var_3_6(var_3_5, var_5.Action(function()
		local var_4_0 = arg_3_0

		var_0.displayShips(var_4_0)

		local var_4_1 = arg_3_0

		var_0.showRightBottomPanel(var_4_1)

		triggerButton = var_0

		var_0(arg_3_0._statisticsBtn)

		local var_4_2 = arg_3_0

		var_0.skipAtkAnima(var_4_2, arg_3_0._atkContainerNext)

		local var_4_3 = arg_3_0

		var_0.skipAtkAnima(var_4_3, arg_3_0._atkContainer)

		setActive = var_0

		var_0(arg_3_0._statisticsBtn, false)

		arg_3_0._stateFlag = var_0_1.STATE_DISPLAY

		return
	end))

	setActive = var_3_6

	local var_3_7 = arg_3_0._bg

	var_3_6(var_4.Find(var_3_7, "jieuan01/Bomb"), false)

	return
end

function var_0_1.closeStatistics(arg_5_0)
	return
end

function var_0_1.displayShips(arg_6_0)
	arg_6_0._expTFs = {}
	arg_6_0._nameTxts = {}
	arg_6_0._initExp = {}
	arg_6_0._skipExp = {}
	arg_6_0._subSkipExp = {}
	arg_6_0._subCardAnimaFuncList = {}

	local var_6_0 = {}
	local var_6_1 = arg_6_0.shipVOs

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_1) do
		var_6_0[iter_6_1.id] = iter_6_1
	end

	local var_6_2 = arg_6_0.contextData.statistics

	ipairs = var_4

	for iter_6_2, iter_6_3 in var_4(var_6_1) do
		if var_6_2[iter_6_3.id] then
			var_6_2[iter_6_3.id].vo = iter_6_3
		end
	end

	local var_6_3 = arg_6_0.contextData.oldMainShips
	local var_6_4 = 0

	ipairs = var_6

	for iter_6_4, iter_6_5 in var_6(var_6_3) do
		if var_6_2[iter_6_5.id] and var_6_4 < var_11.output then
			arg_6_0.mvpShipVO = iter_6_5
			var_6_4 = var_11.output
		end
	end

	arg_6_0._atkFuncs = {}
	arg_6_0._commonAtkTplList = {}
	arg_6_0._subAtkTplList = {}

	local var_6_5
	local var_6_6

	SetActive = var_8

	var_8(arg_6_0._atkToggle, #var_6_3 > 6)

	local var_6_7

	if #var_6_3 > 6 then
		onToggle = var_8
		var_6_7 = arg_6_0

		local var_6_8 = arg_6_0._atkToggle

		local function var_6_9(arg_7_0)
			SetActive = var_2_10001

			var_2_10001(arg_6_0._atkContainer, arg_7_0)

			SetActive = var_2_10001

			var_2_10001(arg_6_0._atkContainerNext, not arg_7_0)

			if arg_7_0 then
				local var_7_0 = arg_6_0

				var_1.skipAtkAnima(var_7_0, arg_6_0._atkContainerNext)
			else
				local var_7_1 = arg_6_0

				var_1.skipAtkAnima(var_7_1, arg_6_0._atkContainer)
			end

			return
		end

		SFX_PANEL = var_1_10013

		var_8(var_6_7, var_6_8, var_6_9, var_1_10013)
	end

	local var_6_10 = {}
	local var_6_11 = {}

	ipairs = var_6_7

	for iter_6_6, iter_6_7 in var_6_7(var_6_3) do
		local var_6_12 = var_6_0[iter_6_7.id]

		if var_6_2[iter_6_7.id] then
			ys = var_16

			local var_6_13 = var_16.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(iter_6_7.configId).type

			table = var_1_10017
			var_1_10017 = var_1_10017.contains
			ShipType = var_1_10019
			var_1_10017 = var_1_10017(var_1_10019.SubShipType, var_6_13)

			local var_6_14

			var_1_10019 = nil

			local var_6_15 = 0
			local var_6_16

			if 6 < iter_6_6 then
				var_1_10019 = arg_6_0._atkContainerNext
				var_6_16 = 7
			else
				var_1_10019 = arg_6_0._atkContainer
				var_6_16 = 1
			end

			cloneTplTo = var_21
			var_21.x = var_21(arg_6_0._atkTpl, var_1_10019).localPosition.x + (iter_6_6 - var_6_16) * 74
			var_21.y = var_21.y + (iter_6_6 - var_6_16) * 4
			var_18.localPosition = var_21

			local var_6_17 = var_18:Find("result/mask/icon")
			local var_6_18 = var_18
			local var_6_19 = var_18.Find(var_6_18, "result/type")
			local var_6_20 = var_6_17
			local var_6_21 = var_6_17.GetComponent

			typeof = var_1_10027
			Image = var_1_10029

			local var_6_22 = var_6_21(var_6_20, var_1_10027(var_1_10029))

			LoadSprite = var_6_18
			var_6_22.sprite = var_6_18("herohrzicon/" .. iter_6_7:getPainting())

			local var_6_23 = var_6_2[iter_6_7.id].output / var_6_4

			GetSpriteFromAtlas = var_25
			var_1_10027 = "shiptype"
			shipType2print = var_28

			local var_6_24 = var_25(var_1_10027, var_28(iter_6_7:getShipType()))

			setImageSprite = var_6_20

			var_6_20(var_6_19, var_6_24, true)
			arg_6_0:setAtkAnima(var_18, var_1_10019, var_6_23, var_6_4, arg_6_0.mvpShipVO == iter_6_7, var_6_2[iter_6_7.id].output, var_6_2[iter_6_7.id].kill_count)

			if iter_6_7.id == var_6_2._flagShipID then
				arg_6_0.flagShipVO = iter_6_7
			end
		end
	end

	return
end

return var_0_1
