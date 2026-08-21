local var_0_0 = class("Monopoly3thGame")
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
	arg_2_0.inAnimatedFlag = false
	arg_2_0.mapIds = pg.activity_event_monopoly[arg_2_0._configId].map
	arg_2_0.lastBonusTimes = pg.activity_event_monopoly[arg_2_0._configId].drop_times[1]
	arg_2_0.randomMoveTiemr = Timer.New(function()
		arg_2_0:checkPlayerRandomMove()

		return
	end, 15, -1)

	return
end

function var_0_0.initUI(arg_4_0)
	arg_4_0.char = findTF(arg_4_0._tf, "map/char")

	setActive(arg_4_0.char, false)

	arg_4_0.btnStart = findTF(arg_4_0._tf, "btnStart")
	arg_4_0.btnHelp = findTF(arg_4_0._tf, "btnHelp")
	arg_4_0.btnRp = findTF(arg_4_0._tf, "btnRp")
	arg_4_0.commonAnim = findTF(arg_4_0.btnRp, "rpAni"):GetComponent(typeof(Animator))
	arg_4_0.labelLeftCountTip = findTF(arg_4_0._tf, "countTip/labelLeftCountTip")
	arg_4_0.labelLeftCount = findTF(arg_4_0._tf, "countTip/labelLeftCount")
	arg_4_0.labelDropShip = findTF(arg_4_0._tf, "labelDropShip")
	arg_4_0.labelLeftRpCount = findTF(arg_4_0._tf, "labelLeftRpCount")
	arg_4_0.cellPos = findTF(arg_4_0._tf, "map/mask/posCell")
	arg_4_0.tplCell = findTF(arg_4_0._tf, "map/mask/posCell/tplCell")
	arg_4_0.mapCells = {}
	arg_4_0.curCellIndex = nil
	arg_4_0.groundChildsList = {}
	arg_4_0.groundMoveRate = {
		0.1,
		0.3,
		1
	}

	for iter_4_0 = 1, 3 do
		local var_4_0 = findTF(arg_4_0._tf, "map/mask/ground" .. iter_4_0)

		for iter_4_1 = 1, var_4_0.childCount do
			table.insert({}, var_4_0:GetChild(iter_4_1 - 1))
		end

		table.insert(arg_4_0.groundChildsList, {})
	end

	PoolMgr.GetInstance():GetSpineChar(Ship.New({
		configId = var_0_1,
		skin_id = var_0_2
	}):getPrefab(), true, function(arg_5_0)
		arg_4_0.model = arg_5_0
		arg_4_0.model.transform.localScale = Vector3.one
		arg_4_0.model.transform.localPosition = Vector3.zero

		arg_4_0.model.transform:SetParent(arg_4_0.char, false)

		arg_4_0.anim = arg_4_0.model:GetComponent(typeof(SpineAnimUI))

		arg_4_0:changeCharAction(var_0_11, 0, nil)
		arg_4_0:checkCharActive()

		return
	end)
	arg_4_0.randomMoveTiemr:Start()

	return
end

function var_0_0.initEvent(arg_6_0)
	onButton(arg_6_0._binder, arg_6_0.btnStart, function()
		if arg_6_0.inAnimatedFlag then
			return
		end

		if arg_6_0.leftCount and arg_6_0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		arg_6_0:changeAnimeState(true)
		arg_6_0._event:emit(Monopoly3thPage.ON_START, arg_6_0.activity.id, function(arg_8_0)
			if arg_8_0 and arg_8_0 > 0 then
				arg_6_0.step = arg_8_0

				arg_6_0:updataUI()
				arg_6_0:checkCharActive()
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_6_0._binder, arg_6_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_3th.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0._binder, arg_6_0.char, function()
		if not arg_6_0.model or arg_6_0.inAnimatedFlag then
			return
		end

		if LeanTween.isTweening(go(arg_6_0.cellPos)) then
			LeanTween.cancel(go(arg_6_0.cellPos))
		end

		arg_6_0:changeCharAction(var_0_15, 1, function()
			arg_6_0:changeCharAction(var_0_11)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_6_0._binder, arg_6_0.btnRp, function()
		if arg_6_0.leftAwardCnt > 0 then
			arg_6_0._event:emit(Monopoly3thPage.ON_AWARD)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.checkPlayerRandomMove(arg_13_0)
	if not arg_13_0.model or arg_13_0.inAnimatedFlag then
		return
	end

	if math.random() > 0.5 then
		local var_13_0 = math.random(2, 4)
		local var_13_1 = 0

		arg_13_0:changeCharAction(var_0_10, 0, nil)
		LeanTween.value(go(arg_13_0.cellPos), 0, 300 * var_13_0, var_13_0 * 2):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_14_0)
			arg_13_0:updateMap(arg_14_0 - var_13_1)

			var_13_1 = arg_14_0

			return
		end)):setOnComplete(System.Action(function()
			arg_13_0:changeCharAction(var_0_11, 0, nil)

			return
		end))
	else
		arg_13_0:changeCharAction(var_0_12, 1, function()
			arg_13_0:changeCharAction(var_0_11)

			return
		end)
	end

	return
end

function var_0_0.checkCountStory(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.useCount
	local var_17_1 = arg_17_0.activity:getDataConfig("story") or {}
	local var_17_2 = _.detect(var_17_1, function(arg_18_0)
		return arg_18_0[1] == var_17_0
	end)

	if var_17_2 then
		pg.NewStoryMgr.GetInstance():Play(var_17_2[2], arg_17_1)
	else
		arg_17_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		arg_19_0.inAnimatedFlag = true

		arg_19_0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		arg_19_0.inAnimatedFlag = false
		arg_19_0.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		arg_19_0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	setActive(arg_19_0.btnStart, not arg_19_1)

	return
end

function var_0_0.checkCharActive(arg_20_0)
	if arg_20_0.anim then
		if arg_20_0.effectId and arg_20_0.effectId > 0 then
			arg_20_0:changeAnimeState(true)
			arg_20_0:checkEffect(function()
				arg_20_0:changeAnimeState(false)
				arg_20_0:checkCharActive()

				return
			end)
		elseif arg_20_0.step and arg_20_0.step > 0 then
			arg_20_0:changeAnimeState(true)
			arg_20_0:checkStep(function()
				arg_20_0:changeAnimeState(false)
				arg_20_0:checkCharActive()

				return
			end)
		else
			arg_20_0:checkLastBonus()
		end
	end

	return
end

function var_0_0.firstUpdata(arg_23_0, arg_23_1)
	arg_23_0:activityDataUpdata(arg_23_1)
	arg_23_0:updataUI()
	arg_23_0:updataChar()
	arg_23_0:checkCharActive()
	arg_23_0:checkLastBonus()

	if arg_23_0.pos and arg_23_0.pos > 0 then
		arg_23_0:updateMap(arg_23_0.pos * 1100 % 2500)
	end

	return
end

function var_0_0.updataActivity(arg_24_0, arg_24_1)
	arg_24_0:activityDataUpdata(arg_24_1)
	arg_24_0:updataUI()

	return
end

function var_0_0.checkLastBonus(arg_25_0)
	if (not arg_25_0.lastBonusFlag or arg_25_0.lastBonusFlag == 0) and arg_25_0.useCount and arg_25_0.useCount >= arg_25_0.lastBonusTimes then
		arg_25_0._event:emit(Monopoly3thPage.MONOPOLY_OP_LAST, arg_25_0.activity.id, function(arg_26_0)
			arg_25_0.lastBonusFlag = 1

			setActive(findTF(arg_25_0.labelDropShip, "get"), false)
			setActive(findTF(arg_25_0.labelDropShip, "got"), true)
			setActive(findTF(arg_25_0.labelDropShip, "text"), false)

			return
		end)
	end

	if arg_25_0.lastBonusFlag == 1 then
		setActive(findTF(arg_25_0.labelDropShip, "get"), false)
		setActive(findTF(arg_25_0.labelDropShip, "got"), true)
		setActive(findTF(arg_25_0.labelDropShip, "text"), false)
	end

	return
end

function var_0_0.activityDataUpdata(arg_27_0, arg_27_1)
	arg_27_0.activity = arg_27_1
	arg_27_0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_27_0.activity.data1) / 0) * arg_27_0.activity:getDataConfig("daily_time") + arg_27_0.activity.data1_list[1]
	arg_27_0.useCount = arg_27_0.activity.data1_list[2]
	arg_27_0.leftCount = arg_27_0.totalCnt - arg_27_0.useCount
	arg_27_0.turnCnt = arg_27_0.activity.data1_list[3] - 1
	arg_27_0.leftDropShipCnt = 8 - arg_27_0.turnCnt

	local var_27_0 = arg_27_0.activity.data2_list[2]

	arg_27_0.advanceTotalCnt = #arg_27_1:getDataConfig("reward")
	arg_27_0.isAdvanceRp = arg_27_0.advanceTotalCnt - var_27_0 > 0
	arg_27_0.leftAwardCnt = arg_27_0.activity.data2_list[1] - var_27_0
	arg_27_0.advanceRpCount = math.max(0, math.min(arg_27_0.activity.data2_list[1], arg_27_0.advanceTotalCnt) - var_27_0)
	arg_27_0.commonRpCount = math.max(0, arg_27_0.activity.data2_list[1] - arg_27_0.advanceTotalCnt) - math.max(0, var_27_0 - arg_27_0.advanceTotalCnt)

	local var_27_1 = arg_27_1:getDataConfig("reward_time")

	arg_27_0.nextredPacketStep = var_27_1 - arg_27_0.useCount % var_27_1
	arg_27_0.pos = arg_27_0.activity.data2
	arg_27_0.step = arg_27_0.activity.data3 or 0
	arg_27_0.effectId = arg_27_0.activity.data4 or 0
	arg_27_0.lastBonusFlag = arg_27_0.activity.data2_list[3]

	return
end

function var_0_0.checkStep(arg_28_0, arg_28_1)
	if arg_28_0.step > 0 then
		arg_28_0._event:emit(Monopoly3thPage.ON_MOVE, arg_28_0.activity.id, function(arg_29_0, arg_29_1, arg_29_2)
			arg_28_0.step = arg_29_0
			arg_28_0.pos = arg_29_1[#arg_29_1]
			arg_28_0.effectId = arg_29_2

			seriesAsync({
				function(arg_30_0)
					arg_28_0:moveCharWithPaths(arg_29_1, var_0_14, arg_30_0)

					return
				end,
				function(arg_31_0)
					arg_28_0:checkEffect(arg_31_0)

					return
				end
			}, function()
				if arg_28_1 then
					arg_28_1()
				end

				return
			end)

			return
		end)
	elseif arg_28_1 then
		arg_28_1()
	end

	return
end

function var_0_0.updataUI(arg_33_0)
	setText(arg_33_0.labelLeftRpCount, "" .. arg_33_0.leftAwardCnt)
	LeanTween.delayedCall(go(arg_33_0.btnRp), 1, System.Action(function()
		if arg_33_0.commonAnim.isActiveAndEnabled then
			arg_33_0.commonAnim:SetInteger("count", arg_33_0.leftAwardCnt)
		end

		return
	end))

	if arg_33_0.lastBonusTimes - arg_33_0.useCount > 0 then
		setText(findTF(arg_33_0.labelDropShip, "text"), "" .. arg_33_0.lastBonusTimes - arg_33_0.useCount)
	end

	setText(arg_33_0.labelLeftCountTip, arg_33_0.nextredPacketStep)
	setText(arg_33_0.labelLeftCount, arg_33_0.leftCount)

	return
end

function var_0_0.updataChar(arg_35_0)
	if not isActive(arg_35_0.char) then
		SetActive(arg_35_0.char, true)
		arg_35_0.char:SetAsLastSibling()
	end

	return
end

function var_0_0.checkEffect(arg_36_0, arg_36_1)
	if arg_36_0.effectId > 0 then
		local var_36_0 = pg.activity_event_monopoly_event[arg_36_0.effectId].story
		local var_36_1 = arg_36_0:getActionName(arg_36_0.pos)

		seriesAsync({
			function(arg_37_0)
				if var_36_1 then
					arg_36_0:changeCharAction(var_36_1, 1, function()
						arg_36_0:changeCharAction(var_0_11, 0, nil)
						arg_37_0()

						return
					end)
				else
					arg_37_0()
				end

				return
			end,
			function(arg_39_0)
				if var_36_0 and tonumber(var_36_0) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_36_0, arg_39_0, true, true)
				else
					arg_39_0()
				end

				return
			end,
			function(arg_40_0)
				arg_36_0:triggerEfect(arg_40_0)

				return
			end,
			function(arg_41_0)
				arg_36_0:checkCountStory(arg_41_0)

				return
			end
		}, arg_36_1)
	elseif arg_36_1 then
		arg_36_1()
	end

	return
end

function var_0_0.triggerEfect(arg_42_0, arg_42_1)
	arg_42_0._event:emit(Monopoly3thPage.ON_TRIGGER, arg_42_0.activity.id, function(arg_43_0, arg_43_1)
		if arg_43_0 and #arg_43_0 >= 0 then
			arg_42_0.effectId = arg_43_1
			arg_42_0.pos = arg_43_0[#arg_43_0]

			seriesAsync({
				function(arg_44_0)
					arg_42_0:moveCharWithPaths(arg_43_0, var_0_10, arg_44_0)

					return
				end
			}, function()
				arg_42_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.moveCharWithPaths(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	if not arg_46_1 or #arg_46_1 <= 0 then
		if arg_46_3 then
			arg_46_3()
		end

		return
	end

	local var_46_0 = {}

	table.insert({}, function(arg_47_0)
		local var_47_0 = arg_46_2 ~= var_0_14 and 4 or 2
		local var_47_1 = 1100
		local var_47_2 = 0

		arg_46_0:createCell(1100)
		arg_46_0:changeCharAction(arg_46_2, 0, nil)

		if LeanTween.isTweening(go(arg_46_0.cellPos)) then
			LeanTween.cancel(go(arg_46_0.cellPos))
		end

		LeanTween.value(go(arg_46_0.cellPos), 0, var_47_1, var_47_0):setEase(LeanTweenType.linear):setOnUpdate(System.Action_float(function(arg_48_0)
			arg_46_0:updateMap(arg_48_0 - var_47_2)

			var_47_2 = arg_48_0

			return
		end)):setOnComplete(System.Action(function()
			arg_47_0()

			return
		end))

		return
	end)
	table.insert(var_46_0, function(arg_50_0)
		arg_46_0:changeCharAction(var_0_11, 0, nil)
		arg_50_0()

		return
	end)
	seriesAsync(var_46_0, arg_46_3)

	return
end

function var_0_0.createCell(arg_51_0, arg_51_1)
	local var_51_0 = tf(instantiate(go(arg_51_0.tplCell)))

	var_51_0.localPosition = Vector3(arg_51_1, 0, 0)
	findTF(var_51_0, "icon"):GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/activityuipage/monopoly3th_atlas", pg.activity_event_monopoly_map[arg_51_0.mapIds[arg_51_0.pos]].icon)

	findTF(var_51_0, "icon"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(var_51_0, true)
	setParent(var_51_0, arg_51_0.cellPos)
	table.insert(arg_51_0.mapCells, var_51_0)

	return
end

function var_0_0.updateMap(arg_52_0, arg_52_1)
	for iter_52_0 = 1, #arg_52_0.mapCells do
		arg_52_0.mapCells[iter_52_0].anchoredPosition.x = arg_52_0.mapCells[iter_52_0].anchoredPosition.x - arg_52_1
		arg_52_0.mapCells[iter_52_0].anchoredPosition = arg_52_0.mapCells[iter_52_0].anchoredPosition
	end

	if #arg_52_0.mapCells > 0 and arg_52_0.mapCells[1].anchoredPosition.x < -1000 then
		Destroy((table.remove(arg_52_0.mapCells, 1)))
	end

	for iter_52_1 = 1, #arg_52_0.groundChildsList do
		for iter_52_2 = #arg_52_0.groundChildsList[iter_52_1], 1, -1 do
			arg_52_0.groundChildsList[iter_52_1][iter_52_2].anchoredPosition = Vector3(arg_52_0.groundChildsList[iter_52_1][iter_52_2].anchoredPosition.x - arg_52_1 * arg_52_0.groundMoveRate[iter_52_1], arg_52_0.groundChildsList[iter_52_1][iter_52_2].anchoredPosition.y, arg_52_0.groundChildsList[iter_52_1][iter_52_2].anchoredPosition.z)
		end
	end

	for iter_52_3 = 1, #arg_52_0.groundChildsList do
		for iter_52_4 = #arg_52_0.groundChildsList[iter_52_3], 1, -1 do
			if arg_52_0.groundChildsList[iter_52_3][iter_52_4].anchoredPosition.x <= -arg_52_0.groundChildsList[iter_52_3][iter_52_4].sizeDelta.x and #arg_52_0.groundChildsList[iter_52_3] > 1 then
				local var_52_0 = table.remove(arg_52_0.groundChildsList[iter_52_3], iter_52_4)

				var_52_0.anchoredPosition = Vector3(arg_52_0.groundChildsList[iter_52_3][#arg_52_0.groundChildsList[iter_52_3]].anchoredPosition.x + arg_52_0.groundChildsList[iter_52_3][#arg_52_0.groundChildsList[iter_52_3]].sizeDelta.x, arg_52_0.groundChildsList[iter_52_3][iter_52_4].anchoredPosition.y, arg_52_0.groundChildsList[iter_52_3][iter_52_4].anchoredPosition.z)

				table.insert(arg_52_0.groundChildsList[iter_52_3], var_52_0)
			end
		end
	end

	return
end

function var_0_0.changeCharAction(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	if arg_53_0.actionName == arg_53_1 and arg_53_0.actionName ~= var_0_13 then
		return
	end

	arg_53_0.actionName = arg_53_1

	arg_53_0.anim:SetActionCallBack(nil)
	arg_53_0.anim:SetAction(arg_53_1, 0)
	arg_53_0.anim:SetActionCallBack(function(arg_54_0)
		if arg_54_0 == "finish" then
			if arg_53_2 == 1 then
				arg_53_0.anim:SetActionCallBack(nil)
				arg_53_0.anim:SetAction(var_0_11, 0)
			end

			if arg_53_3 then
				arg_53_3()
			end
		end

		return
	end)

	if arg_53_2 ~= 1 and arg_53_3 then
		arg_53_3()
	end

	return
end

function var_0_0.getActionName(arg_55_0, arg_55_1)
	if pg.activity_event_monopoly_map[arg_55_0.mapIds[arg_55_1]].icon == "icon_1" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[arg_55_0.mapIds[arg_55_1]].icon == "icon_2" then
		return var_0_7
	elseif pg.activity_event_monopoly_map[arg_55_0.mapIds[arg_55_1]].icon == "icon_3" then
		return nil
	elseif pg.activity_event_monopoly_map[arg_55_0.mapIds[arg_55_1]].icon == "icon_4" then
		return var_0_9
	elseif pg.activity_event_monopoly_map[arg_55_0.mapIds[arg_55_1]].icon == "icon_5" then
		return var_0_8
	elseif pg.activity_event_monopoly_map[arg_55_0.mapIds[arg_55_1]].icon == "icon_6" then
		return var_0_9
	end

	return var_0_9
end

function var_0_0.dispose(arg_56_0)
	if arg_56_0.model then
		PoolMgr.GetInstance():ReturnSpineChar(var_0_1, arg_56_0.model)
	end

	if arg_56_0.randomMoveTiemr then
		if arg_56_0.randomMoveTiemr.running then
			arg_56_0.randomMoveTiemr:Stop()
		end

		arg_56_0.randomMoveTiemr = nil
	end

	if LeanTween.isTweening(go(arg_56_0.btnRp)) then
		LeanTween.cancel(go(arg_56_0.btnRp))
	end

	if LeanTween.isTweening(go(arg_56_0.cellPos)) then
		LeanTween.cancel(go(arg_56_0.cellPos))
	end

	return
end

return var_0_0
