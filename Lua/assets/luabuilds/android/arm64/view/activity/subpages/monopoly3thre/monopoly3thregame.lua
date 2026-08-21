local var_0_0 = class("Monopoly3thReGame")
local var_0_1 = 25
local var_0_2 = 25
local var_0_7 = "dafuweng_gold"
local var_0_8 = "dafuweng_oil"
local var_0_9 = "dafuweng_event"
local var_0_10 = "dafuweng_walk"
local var_0_11 = "stand"
local var_0_12 = "dafuweng_stand"
local var_0_13 = "dafuweng_jump"
local var_0_14 = "dafuweng_run"
local var_0_15 = "dafuweng_touch"
local var_0_16 = 35

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0._configId = arg_1_4

	arg_1_0:initData()
	arg_1_0:initUI()
	arg_1_0:initEvent()

	return
end

function var_0_0.initData(arg_2_0)
	arg_2_0.leftCount = 0
	arg_2_0.mapIds = pg.activity_event_monopoly[arg_2_0._configId].map
	arg_2_0.inAnimatedFlag = false
	arg_2_0.lastBonusTimes = pg.activity_event_monopoly[arg_2_0._configId].drop_times[1]
	arg_2_0.randomMoveTiemr = Timer.New(function()
		arg_2_0:checkPlayerRandomMove()

		return
	end, 15, -1)
	arg_2_0.awardsTimer = Timer.New(function()
		if arg_2_0.awardTfs and #arg_2_0.awardTfs > 0 then
			for iter_4_0 = #arg_2_0.awardTfs, 1, -1 do
				arg_2_0.awardTfs[iter_4_0].anchoredPosition.y = arg_2_0.awardTfs[iter_4_0].anchoredPosition.y + 3

				if arg_2_0.awardTfs[iter_4_0].anchoredPosition.y >= 150 then
					Destroy(table.remove(arg_2_0.awardTfs, iter_4_0))
				else
					arg_2_0.awardTfs[iter_4_0].anchoredPosition = arg_2_0.awardTfs[iter_4_0].anchoredPosition
				end
			end
		end

		return
	end, 0.03333333333333333, -1)

	arg_2_0.awardsTimer:Start()

	return
end

function var_0_0.initUI(arg_5_0)
	arg_5_0.char = findTF(arg_5_0._tf, "map/char")

	setActive(arg_5_0.char, false)
	setText(findTF(arg_5_0._tf, "desc"), i18n("monopoly3thre_tip"))

	arg_5_0.btnStart = findTF(arg_5_0._tf, "btnStart")
	arg_5_0.btnAutoStart = findTF(arg_5_0._tf, "btnAutoStart")

	setActive(arg_5_0.btnStart, true)
	setActive(arg_5_0.btnAutoStart, true)

	arg_5_0.btnCancelAuto = findTF(arg_5_0._tf, "btnCancelAuto")

	setActive(arg_5_0.btnCancelAuto, false)

	arg_5_0.btnHelp = findTF(arg_5_0._tf, "btnHelp")
	arg_5_0.btnRp = findTF(arg_5_0._tf, "btnRp")
	arg_5_0.commonAnim = findTF(arg_5_0.btnRp, "rpAni"):GetComponent(typeof(Animator))
	arg_5_0.labelLeftCountTip = findTF(arg_5_0._tf, "countTip/labelLeftCountTip")
	arg_5_0.labelLeftCount = findTF(arg_5_0._tf, "countTip/labelLeftCount")
	arg_5_0.labelDropShip = findTF(arg_5_0._tf, "labelDropShip")
	arg_5_0.labelLeftRpCount = findTF(arg_5_0._tf, "labelLeftRpCount")
	arg_5_0.cellPos = findTF(arg_5_0._tf, "map/mask/posCell")
	arg_5_0.tplCell = findTF(arg_5_0._tf, "map/mask/posCell/tplCell")
	arg_5_0.mapCells = {}
	arg_5_0.curCellIndex = nil
	arg_5_0.groundChildsList = {}
	arg_5_0.groundMoveRate = {
		0.1,
		0.3,
		1
	}
	arg_5_0.awardTf = findTF(arg_5_0._tf, "awardTpl")
	arg_5_0.awardParent = findTF(arg_5_0.char, "award")

	for iter_5_0 = 1, 3 do
		local var_5_0 = findTF(arg_5_0._tf, "map/mask/ground" .. iter_5_0)

		for iter_5_1 = 1, var_5_0.childCount do
			table.insert({}, var_5_0:GetChild(iter_5_1 - 1))
		end

		table.insert(arg_5_0.groundChildsList, {})
	end

	PoolMgr.GetInstance():GetSpineChar(Ship.New({
		configId = var_0_1,
		skin_id = var_0_2
	}):getPrefab(), true, function(arg_6_0)
		arg_5_0.model = arg_6_0
		arg_5_0.model.transform.localScale = Vector3.one
		arg_5_0.model.transform.localPosition = Vector3.zero

		arg_5_0.model.transform:SetParent(arg_5_0.char, false)

		arg_5_0.anim = arg_5_0.model:GetComponent(typeof(SpineAnimUI))

		arg_5_0:changeCharAction(var_0_11, 0, nil)
		arg_5_0:checkCharActive()

		return
	end)
	arg_5_0.randomMoveTiemr:Start()

	return
end

function var_0_0.initEvent(arg_7_0)
	onButton(arg_7_0._binder, arg_7_0.btnAutoStart, function()
		setActive(arg_7_0.btnCancelAuto, true)

		arg_7_0.autoFlag = true

		arg_7_0:start()

		return
	end, SFX_PANEL)
	onButton(arg_7_0._binder, arg_7_0.btnCancelAuto, function()
		setActive(arg_7_0.btnCancelAuto, false)

		arg_7_0.autoFlag = false

		return
	end, SFX_PANEL)
	onButton(arg_7_0._binder, arg_7_0.btnStart, function()
		arg_7_0:start()

		return
	end, SFX_PANEL)
	onButton(arg_7_0._binder, arg_7_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_3th.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0._binder, arg_7_0.char, function()
		if not arg_7_0.model or arg_7_0.inAnimatedFlag then
			return
		end

		if LeanTween.isTweening(go(arg_7_0.cellPos)) then
			LeanTween.cancel(go(arg_7_0.cellPos))
		end

		arg_7_0:changeCharAction(var_0_15, 1, function()
			arg_7_0:changeCharAction(var_0_11)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_7_0._binder, arg_7_0.btnRp, function()
		if arg_7_0.leftAwardCnt > 0 then
			arg_7_0._event:emit(Monopoly3thRePage.ON_AWARD)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.addAwards(arg_15_0, arg_15_1)
	arg_15_0.awardTfs = arg_15_0.awardTfs or {}

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_0 = tf(instantiate(go(arg_15_0.awardTf)))

		setParent(var_15_0, arg_15_0.awardParent)
		updateDrop(var_15_0, arg_15_1[iter_15_0])

		var_15_0.anchoredPosition = Vector2(0, 0)

		setActive(var_15_0, true)
		table.insert(arg_15_0.awardTfs, var_15_0)
	end

	return
end

function var_0_0.start(arg_16_0)
	if arg_16_0.inAnimatedFlag then
		return
	end

	if arg_16_0.leftCount and arg_16_0.leftCount <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

		if arg_16_0.autoFlag and not arg_16_0:checkLastBonus() then
			arg_16_0.autoFlag = false

			setActive(arg_16_0.btnCancelAuto, false)
			arg_16_0:changeAnimeState(false, true)
		end

		return
	end

	arg_16_0:changeAnimeState(true)
	arg_16_0._event:emit(Monopoly3thRePage.ON_START, arg_16_0.activity.id, function(arg_17_0)
		if arg_17_0 and arg_17_0 > 0 then
			arg_16_0.step = arg_17_0

			arg_16_0:updataUI()
			arg_16_0:checkCharActive()
		end

		return
	end)

	return
end

function var_0_0.checkPlayerRandomMove(arg_18_0)
	if not arg_18_0.model or arg_18_0.inAnimatedFlag then
		return
	end

	if math.random() > 0.5 then
		local var_18_0 = math.random(2, 4)
		local var_18_1 = 0

		arg_18_0:changeCharAction(var_0_10, 0, nil)
		LeanTween.value(go(arg_18_0.cellPos), 0, 300 * var_18_0, var_18_0 * 2):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_19_0)
			arg_18_0:updateMap(arg_19_0 - var_18_1)

			var_18_1 = arg_19_0

			return
		end)):setOnComplete(System.Action(function()
			arg_18_0:changeCharAction(var_0_11, 0, nil)

			return
		end))
	else
		arg_18_0:changeCharAction(var_0_12, 1, function()
			arg_18_0:changeCharAction(var_0_11)

			return
		end)
	end

	return
end

function var_0_0.checkCountStory(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.useCount
	local var_22_1 = arg_22_0.activity:getDataConfig("story") or {}
	local var_22_2 = _.detect(var_22_1, function(arg_23_0)
		return arg_23_0[1] == var_22_0
	end)

	if var_22_2 then
		pg.NewStoryMgr.GetInstance():Play(var_22_2[2], arg_22_1)
	else
		arg_22_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		arg_24_0.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		arg_24_0.btnAutoStart:GetComponent(typeof(Image)).raycastTarget = false
		arg_24_0.inAnimatedFlag = true
	else
		arg_24_0.inAnimatedFlag = false
		arg_24_0.btnStart:GetComponent(typeof(Image)).raycastTarget = true
		arg_24_0.btnAutoStart:GetComponent(typeof(Image)).raycastTarget = true
	end

	if not arg_24_1 and arg_24_0.autoFlag then
		arg_24_0:start()
		setActive(arg_24_0.btnStart, false)
		setActive(arg_24_0.btnAutoStart, false)
	else
		setActive(arg_24_0.btnStart, not arg_24_1)
		setActive(arg_24_0.btnAutoStart, not arg_24_1)
	end

	if not arg_24_1 and not arg_24_0.autoFlag and arg_24_2 then
		arg_24_0._event:emit(Monopoly3thRePage.ON_STOP, nil, function()
			return
		end)
	end

	return
end

function var_0_0.checkCharActive(arg_26_0)
	if arg_26_0.anim then
		if arg_26_0.effectId and arg_26_0.effectId > 0 then
			arg_26_0:changeAnimeState(true)
			arg_26_0:checkEffect(function()
				arg_26_0:changeAnimeState(false)
				arg_26_0:checkCharActive()

				return
			end)
		elseif arg_26_0.step and arg_26_0.step > 0 then
			arg_26_0:changeAnimeState(true)
			arg_26_0:checkStep(function()
				arg_26_0:changeAnimeState(false)
				arg_26_0:checkCharActive()

				return
			end)
		else
			arg_26_0:checkLastBonus()
		end
	end

	return
end

function var_0_0.firstUpdata(arg_29_0, arg_29_1)
	arg_29_0:activityDataUpdata(arg_29_1)
	arg_29_0:updataUI()
	arg_29_0:updataChar()
	arg_29_0:checkCharActive()
	arg_29_0:checkLastBonus()

	if arg_29_0.pos and arg_29_0.pos > 0 then
		arg_29_0:updateMap(arg_29_0.pos * 1100 % 2500)
	end

	return
end

function var_0_0.updataActivity(arg_30_0, arg_30_1)
	arg_30_0:activityDataUpdata(arg_30_1)
	arg_30_0:updataUI()

	return
end

function var_0_0.checkLastBonus(arg_31_0)
	if (not arg_31_0.lastBonusFlag or arg_31_0.lastBonusFlag == 0) and arg_31_0.useCount and arg_31_0.useCount >= arg_31_0.lastBonusTimes then
		arg_31_0._event:emit(Monopoly3thRePage.MONOPOLY_OP_LAST, arg_31_0.activity.id, function(arg_32_0)
			arg_31_0.lastBonusFlag = 1

			setActive(findTF(arg_31_0.labelDropShip, "get"), false)
			setActive(findTF(arg_31_0.labelDropShip, "got"), true)
			setActive(findTF(arg_31_0.labelDropShip, "text"), false)

			if arg_31_0.autoFlag then
				arg_31_0:start()
			end

			return
		end)

		return true
	end

	if arg_31_0.lastBonusFlag == 1 then
		setActive(findTF(arg_31_0.labelDropShip, "get"), false)
		setActive(findTF(arg_31_0.labelDropShip, "got"), true)
		setActive(findTF(arg_31_0.labelDropShip, "text"), false)
	end

	return false
end

function var_0_0.activityDataUpdata(arg_33_0, arg_33_1)
	arg_33_0.activity = arg_33_1
	arg_33_0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_33_0.activity.data1) / 0) * arg_33_0.activity:getDataConfig("daily_time") + arg_33_0.activity.data1_list[1]
	arg_33_0.useCount = arg_33_0.activity.data1_list[2]
	arg_33_0.leftCount = arg_33_0.totalCnt - arg_33_0.useCount
	arg_33_0.turnCnt = arg_33_0.activity.data1_list[3] - 1
	arg_33_0.leftDropShipCnt = 8 - arg_33_0.turnCnt

	local var_33_0 = arg_33_0.activity.data2_list[2]

	arg_33_0.advanceTotalCnt = #arg_33_1:getDataConfig("reward")
	arg_33_0.isAdvanceRp = arg_33_0.advanceTotalCnt - var_33_0 > 0
	arg_33_0.leftAwardCnt = arg_33_0.activity.data2_list[1] - var_33_0
	arg_33_0.advanceRpCount = math.max(0, math.min(arg_33_0.activity.data2_list[1], arg_33_0.advanceTotalCnt) - var_33_0)
	arg_33_0.commonRpCount = math.max(0, arg_33_0.activity.data2_list[1] - arg_33_0.advanceTotalCnt) - math.max(0, var_33_0 - arg_33_0.advanceTotalCnt)

	local var_33_1 = arg_33_1:getDataConfig("reward_time")

	arg_33_0.nextredPacketStep = var_33_1 - arg_33_0.useCount % var_33_1

	if arg_33_0.useCount >= var_0_16 then
		arg_33_0.nextredPacketStep = nil
	end

	arg_33_0.pos = arg_33_0.activity.data2
	arg_33_0.step = arg_33_0.activity.data3 or 0
	arg_33_0.effectId = arg_33_0.activity.data4 or 0
	arg_33_0.lastBonusFlag = arg_33_0.activity.data2_list[3]

	return
end

function var_0_0.checkStep(arg_34_0, arg_34_1)
	if arg_34_0.step > 0 then
		arg_34_0._event:emit(Monopoly3thRePage.ON_MOVE, arg_34_0.activity.id, function(arg_35_0, arg_35_1, arg_35_2)
			arg_34_0.step = arg_35_0
			arg_34_0.pos = arg_35_1[#arg_35_1]
			arg_34_0.effectId = arg_35_2

			seriesAsync({
				function(arg_36_0)
					arg_34_0:moveCharWithPaths(arg_35_1, var_0_14, arg_36_0)

					return
				end,
				function(arg_37_0)
					arg_34_0:checkEffect(arg_37_0)

					return
				end
			}, function()
				if arg_34_1 then
					arg_34_1()
				end

				return
			end)

			return
		end)
	elseif arg_34_1 then
		arg_34_1()
	end

	return
end

function var_0_0.updataUI(arg_39_0)
	setText(arg_39_0.labelLeftRpCount, "" .. arg_39_0.leftAwardCnt)

	if LeanTween.isTweening(go(arg_39_0.btnRp)) then
		LeanTween.cancel(go(arg_39_0.btnRp))
	end

	LeanTween.delayedCall(go(arg_39_0.btnRp), 1, System.Action(function()
		if arg_39_0.commonAnim.isActiveAndEnabled then
			arg_39_0.commonAnim:SetInteger("count", arg_39_0.leftAwardCnt)
		end

		return
	end))

	if arg_39_0.lastBonusTimes - arg_39_0.useCount > 0 then
		setText(findTF(arg_39_0.labelDropShip, "text"), "" .. arg_39_0.lastBonusTimes - arg_39_0.useCount)
	end

	if arg_39_0.nextredPacketStep and arg_39_0.nextredPacketStep ~= 0 then
		setText(arg_39_0.labelLeftCountTip, arg_39_0.nextredPacketStep)
		setActive(arg_39_0.labelLeftCountTip, true)
		setActive(findTF(arg_39_0._tf, "countTip/ad"), true)
		setActive(findTF(arg_39_0._tf, "countTip/adB"), false)
	else
		setText(arg_39_0.labelLeftCountTip, "")
		setActive(arg_39_0.labelLeftCountTip, false)
		setActive(findTF(arg_39_0._tf, "countTip/ad"), false)
		setActive(findTF(arg_39_0._tf, "countTip/adB"), true)
	end

	setText(arg_39_0.labelLeftCount, arg_39_0.leftCount)

	return
end

function var_0_0.updataChar(arg_41_0)
	if not isActive(arg_41_0.char) then
		SetActive(arg_41_0.char, true)
		arg_41_0.char:SetAsLastSibling()
	end

	return
end

function var_0_0.checkEffect(arg_42_0, arg_42_1)
	if arg_42_0.effectId > 0 then
		local var_42_0 = pg.activity_event_monopoly_event[arg_42_0.effectId].story
		local var_42_1 = arg_42_0:getActionName(arg_42_0.pos)

		seriesAsync({
			function(arg_43_0)
				if var_42_1 then
					arg_42_0:changeCharAction(var_42_1, 1, function()
						arg_42_0:changeCharAction(var_0_11, 0, nil)
						arg_43_0()

						return
					end)
				else
					arg_43_0()
				end

				return
			end,
			function(arg_45_0)
				if var_42_0 and tonumber(var_42_0) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_42_0, arg_45_0, true, true)
				else
					arg_45_0()
				end

				return
			end,
			function(arg_46_0)
				arg_42_0:triggerEfect(arg_46_0)

				return
			end,
			function(arg_47_0)
				arg_42_0:checkCountStory(arg_47_0)

				return
			end
		}, arg_42_1)
	elseif arg_42_1 then
		arg_42_1()
	end

	return
end

function var_0_0.triggerEfect(arg_48_0, arg_48_1)
	arg_48_0._event:emit(Monopoly3thRePage.ON_TRIGGER, arg_48_0.activity.id, function(arg_49_0, arg_49_1)
		if arg_49_0 and #arg_49_0 >= 0 then
			arg_48_0.effectId = arg_49_1
			arg_48_0.pos = arg_49_0[#arg_49_0]

			seriesAsync({
				function(arg_50_0)
					arg_48_0:moveCharWithPaths(arg_49_0, var_0_10, arg_50_0)

					return
				end
			}, function()
				arg_48_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.moveCharWithPaths(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	if not arg_52_1 or #arg_52_1 <= 0 then
		if arg_52_3 then
			arg_52_3()
		end

		return
	end

	local var_52_0 = {}

	table.insert({}, function(arg_53_0)
		local var_53_0 = arg_52_2 ~= var_0_14 and 4 or 2
		local var_53_1 = 1100
		local var_53_2 = 0

		arg_52_0:createCell(1100)
		arg_52_0:changeCharAction(arg_52_2, 0, nil)

		if LeanTween.isTweening(go(arg_52_0.cellPos)) then
			LeanTween.cancel(go(arg_52_0.cellPos))
		end

		LeanTween.value(go(arg_52_0.cellPos), 0, var_53_1, var_53_0):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_54_0)
			arg_52_0:updateMap(arg_54_0 - var_53_2)

			var_53_2 = arg_54_0

			return
		end)):setOnComplete(System.Action(function()
			arg_53_0()

			return
		end))

		return
	end)
	table.insert(var_52_0, function(arg_56_0)
		arg_52_0:changeCharAction(var_0_11, 0, nil)
		arg_56_0()

		return
	end)
	seriesAsync(var_52_0, arg_52_3)

	return
end

function var_0_0.createCell(arg_57_0, arg_57_1)
	local var_57_0 = tf(instantiate(go(arg_57_0.tplCell)))

	var_57_0.localPosition = Vector3(arg_57_1, 0, 0)
	findTF(var_57_0, "icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly3thre_atlas", pg.activity_event_monopoly_map[arg_57_0.mapIds[arg_57_0.pos]].icon)

	findTF(var_57_0, "icon"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(var_57_0, true)
	setParent(var_57_0, arg_57_0.cellPos)
	table.insert(arg_57_0.mapCells, var_57_0)

	return
end

function var_0_0.updateMap(arg_58_0, arg_58_1)
	for iter_58_0 = 1, #arg_58_0.mapCells do
		arg_58_0.mapCells[iter_58_0].anchoredPosition.x = arg_58_0.mapCells[iter_58_0].anchoredPosition.x - arg_58_1
		arg_58_0.mapCells[iter_58_0].anchoredPosition = arg_58_0.mapCells[iter_58_0].anchoredPosition
	end

	if #arg_58_0.mapCells > 0 and arg_58_0.mapCells[1].anchoredPosition.x < -1000 then
		Destroy((table.remove(arg_58_0.mapCells, 1)))
	end

	for iter_58_1 = 1, #arg_58_0.groundChildsList do
		for iter_58_2 = #arg_58_0.groundChildsList[iter_58_1], 1, -1 do
			arg_58_0.groundChildsList[iter_58_1][iter_58_2].anchoredPosition = Vector3(arg_58_0.groundChildsList[iter_58_1][iter_58_2].anchoredPosition.x - arg_58_1 * arg_58_0.groundMoveRate[iter_58_1], arg_58_0.groundChildsList[iter_58_1][iter_58_2].anchoredPosition.y, arg_58_0.groundChildsList[iter_58_1][iter_58_2].anchoredPosition.z)
		end
	end

	for iter_58_3 = 1, #arg_58_0.groundChildsList do
		for iter_58_4 = #arg_58_0.groundChildsList[iter_58_3], 1, -1 do
			if arg_58_0.groundChildsList[iter_58_3][iter_58_4].anchoredPosition.x <= -arg_58_0.groundChildsList[iter_58_3][iter_58_4].sizeDelta.x and #arg_58_0.groundChildsList[iter_58_3] > 1 then
				local var_58_0 = table.remove(arg_58_0.groundChildsList[iter_58_3], iter_58_4)

				var_58_0.anchoredPosition = Vector3(arg_58_0.groundChildsList[iter_58_3][#arg_58_0.groundChildsList[iter_58_3]].anchoredPosition.x + arg_58_0.groundChildsList[iter_58_3][#arg_58_0.groundChildsList[iter_58_3]].sizeDelta.x, arg_58_0.groundChildsList[iter_58_3][iter_58_4].anchoredPosition.y, arg_58_0.groundChildsList[iter_58_3][iter_58_4].anchoredPosition.z)

				table.insert(arg_58_0.groundChildsList[iter_58_3], var_58_0)
			end
		end
	end

	return
end

function var_0_0.changeCharAction(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_0.actionName == arg_59_1 and arg_59_0.actionName ~= var_0_13 then
		return
	end

	arg_59_0.actionName = arg_59_1

	arg_59_0.anim:SetActionCallBack(nil)
	arg_59_0.anim:SetAction(arg_59_1, 0)
	arg_59_0.anim:SetActionCallBack(function(arg_60_0)
		if arg_60_0 == "finish" then
			if arg_59_2 == 1 then
				arg_59_0.anim:SetActionCallBack(nil)
				arg_59_0.anim:SetAction(var_0_11, 0)
			end

			if arg_59_3 then
				arg_59_3()
			end
		end

		return
	end)

	if arg_59_2 ~= 1 and arg_59_3 then
		arg_59_3()
	end

	return
end

function var_0_0.getActionName(arg_61_0, arg_61_1)
	if pg.activity_event_monopoly_map[arg_61_0.mapIds[arg_61_1]].icon == "icon_1" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[arg_61_0.mapIds[arg_61_1]].icon == "icon_2" then
		return var_0_7
	elseif pg.activity_event_monopoly_map[arg_61_0.mapIds[arg_61_1]].icon == "icon_3" then
		return nil
	elseif pg.activity_event_monopoly_map[arg_61_0.mapIds[arg_61_1]].icon == "icon_4" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[arg_61_0.mapIds[arg_61_1]].icon == "icon_5" then
		return var_0_8
	elseif pg.activity_event_monopoly_map[arg_61_0.mapIds[arg_61_1]].icon == "icon_6" then
		return var_0_9
	end

	return var_0_9
end

function var_0_0.onHide(arg_62_0)
	return
end

function var_0_0.dispose(arg_63_0)
	if arg_63_0.model then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_1, arg_63_0.model)
	end

	for iter_63_0 = #arg_63_0.mapCells, 1, -1 do
		Destroy(arg_63_0.mapCells[iter_63_0])
	end

	arg_63_0.mapCells = {}

	if arg_63_0.randomMoveTiemr then
		if arg_63_0.randomMoveTiemr.running then
			arg_63_0.randomMoveTiemr:Stop()
		end

		arg_63_0.randomMoveTiemr = nil
	end

	if LeanTween.isTweening(go(arg_63_0.btnRp)) then
		LeanTween.cancel(go(arg_63_0.btnRp))
	end

	if LeanTween.isTweening(go(arg_63_0.cellPos)) then
		LeanTween.cancel(go(arg_63_0.cellPos))
	end

	if arg_63_0.awardsTimer then
		if arg_63_0.awardsTimer.running then
			arg_63_0.awardsTimer:Stop()
		end

		arg_63_0.awardsTimer = nil
	end

	if arg_63_0.awardTfs and #arg_63_0.awardTfs > 0 then
		for iter_63_1 = #arg_63_0.awardTfs, 1, -1 do
			Destroy(table.remove(arg_63_0.awardTfs, iter_63_1))
		end
	end

	return
end

return var_0_0
