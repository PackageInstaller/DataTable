local var_0_0 = class("MonopolyCar2Game")
local var_0_1 = 100
local var_0_2 = 50
local var_0_3 = "xinnongpaoche"
local var_0_4 = {
	"yuekegongjue_2",
	"dafeng_5",
	"baerdimo_6"
}
local var_0_5 = {
	"gaoxiong_5",
	"aidang_5",
	"xinnong_3",
	"qiye_7"
}
local var_0_6 = {
	"ruihe_3",
	"xianghe_3",
	"ougen_5",
	"weiershiqinwang_3"
}
local var_0_7 = {
	xianghe_3 = "dance",
	baerdimo_6 = "stand2",
	xinnong_3 = "stand2",
	dafeng_5 = "stand2",
	weiershiqinwang_3 = "stand2",
	ruihe_3 = "stand2",
	qiye_7 = "dance",
	ougen_5 = "stand2",
	aidang_5 = "dance",
	yuekegongjue_2 = "stand2",
	gaoxiong_5 = "dance"
}
local var_0_8 = 0.6
local var_0_9 = "ui/activityuipage/monopolycar2_atlas"
local var_0_10 = "B-stand"
local var_0_11 = "F-stand"
local var_0_12 = "B-walk"
local var_0_13 = "F-walk"
local var_0_18 = {
	{
		5006,
		5007,
		5008,
		5009,
		5010
	},
	{
		5005,
		0,
		0,
		0,
		5011
	},
	{
		5004,
		0,
		0,
		0,
		5012
	},
	{
		5003,
		0,
		0,
		0,
		5013
	},
	{
		5002,
		0,
		0,
		0,
		5014
	},
	{
		2001,
		5018,
		5017,
		5016,
		5015
	}
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._binder = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0._event = arg_1_3

	arg_1_0:initData()
	arg_1_0:initUI()
	arg_1_0:initEvent()

	return
end

function var_0_0.initData(arg_2_0)
	arg_2_0.leftCount = 0
	arg_2_0.inAnimatedFlag = false
	arg_2_0.mapCells = {}
	arg_2_0.showCharNames = {}

	if var_0_4 and #var_0_4 > 0 then
		table.insert(arg_2_0.showCharNames, Clone(var_0_4[math.random(1, #var_0_4)]))
	end

	if var_0_5 and #var_0_5 > 0 then
		table.insert(arg_2_0.showCharNames, Clone(var_0_5[math.random(1, #var_0_5)]))
	end

	if var_0_6 and #var_0_6 > 0 then
		table.insert(arg_2_0.showCharNames, Clone(var_0_6[math.random(1, #var_0_6)]))
	end

	return
end

function var_0_0.initUI(arg_3_0)
	arg_3_0.tplMapCell = findTF(arg_3_0._tf, "tplMapCell")
	arg_3_0.mapContainer = findTF(arg_3_0._tf, "mapContainer")
	arg_3_0.char = findTF(arg_3_0._tf, "mapContainer/char")
	arg_3_0.showChars = {}

	for iter_3_0 = 1, 3 do
		table.insert(arg_3_0.showChars, findTF(arg_3_0._tf, "showChar" .. iter_3_0))
	end

	setActive(arg_3_0.char, false)

	arg_3_0.btnStart = findTF(arg_3_0._tf, "btnStart")
	arg_3_0.btnHelp = findTF(arg_3_0._tf, "btnHelp")
	arg_3_0.btnRp = findTF(arg_3_0._tf, "btnRp")
	arg_3_0.commonAnim = findTF(arg_3_0.btnRp, "rpAni"):GetComponent(typeof(Animator))
	arg_3_0.labelLeftCountTip = findTF(arg_3_0.btnStart, "labelLeftCountTip")

	setActive(arg_3_0.labelLeftCountTip, false)

	arg_3_0.labelLeftCount = findTF(arg_3_0.btnStart, "labelLeftCount")
	arg_3_0.labelDropShip = findTF(arg_3_0._tf, "labelDropShip")
	arg_3_0.labelLeftRpCount = findTF(arg_3_0._tf, "labelLeftRpCount")
	arg_3_0.rollStep = findTF(arg_3_0._tf, "step")

	setActive(arg_3_0.rollStep, false)
	arg_3_0:initMap()
	arg_3_0:initChar()

	return
end

function var_0_0.initEvent(arg_4_0)
	onButton(arg_4_0._binder, arg_4_0.btnStart, function()
		if arg_4_0.inAnimatedFlag then
			return
		end

		if arg_4_0.leftCount and arg_4_0.leftCount <= 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_count_noenough"))

			return
		end

		arg_4_0:changeAnimeState(true)
		setActive(arg_4_0.btnStart, true)
		arg_4_0._event:emit(MonopolyCar2Page.ON_START, arg_4_0.activity.id, function(arg_6_0)
			if arg_6_0 and arg_6_0 > 0 then
				arg_4_0:showRollAnimated(arg_6_0)
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_4_0._binder, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_car_2.tip
		})

		return
	end, SFX_PANEL)

	for iter_4_0 = 1, #arg_4_0.showChars do
		onButton(arg_4_0._binder, arg_4_0.showChars[iter_4_0], function()
			arg_4_0._event:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

			return
		end, SFX_PANEL)
	end

	onButton(arg_4_0._binder, arg_4_0.btnRp, function()
		if arg_4_0.leftAwardCnt > 0 then
			arg_4_0._event:emit(MonopolyCar2Page.ON_AWARD)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showRollAnimated(arg_10_0, arg_10_1)
	local var_10_0 = findTF(arg_10_0.rollStep, "stepArrow")

	findTF(arg_10_0.rollStep, "stepArrow").localEulerAngles = Vector3(0, 0, 0)
	findTF(arg_10_0.rollStep, "progress/bg"):GetComponent(typeof(Image)).fillAmount = 0.1
	findTF(arg_10_0.rollStep, "select/bg"):GetComponent(typeof(Image)).fillAmount = 0.1

	setText(findTF(arg_10_0.rollStep, "labelRoll"), "0")
	seriesAsync({
		function(arg_11_0)
			LeanTween.value(go(arg_10_0._tf), 1, 0, 0.2):setOnUpdate(System.Action_float(function(arg_12_0)
				arg_10_0.btnStart:GetComponent(typeof(CanvasGroup)).alpha = arg_12_0

				return
			end)):setOnComplete(System.Action(function()
				setActive(arg_10_0.btnStart, false)

				arg_10_0.btnStart:GetComponent(typeof(CanvasGroup)).alpha = 1

				arg_11_0()

				return
			end))

			return
		end,
		function(arg_14_0)
			LeanTween.value(go(arg_10_0._tf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_15_0)
				arg_10_0.rollStep:GetComponent(typeof(CanvasGroup)).alpha = arg_15_0

				setActive(arg_10_0.rollStep, true)

				return
			end)):setOnComplete(System.Action(function()
				arg_14_0()

				return
			end))

			return
		end,
		function(arg_17_0)
			local var_17_0 = arg_10_1 / 6 * 0.62 / arg_10_1
			local var_17_1 = -arg_10_1 * 31

			LeanTween.value(go(arg_10_0._tf), 0, 1, 0.7 + arg_10_1 / 5):setEase(LeanTweenType.easeOutCirc):setOnUpdate(System.Action_float(function(arg_18_0)
				findTF(arg_10_0.rollStep, "progress/bg"):GetComponent(typeof(Image)).fillAmount = var_0 * arg_18_0 + 0.13
				findTF(arg_10_0.rollStep, "select/bg"):GetComponent(typeof(Image)).fillAmount = var_17_0 * math.floor(arg_18_0 / (1 / arg_10_1)) + 0.17

				setText(findTF(arg_10_0.rollStep, "labelRoll"), math.floor(arg_18_0 / (1 / arg_10_1)))

				var_10_0.localEulerAngles = Vector3(0, 0, var_17_1 * arg_18_0 - 13)

				return
			end)):setOnComplete(System.Action(function()
				arg_17_0()

				return
			end))

			return
		end,
		function(arg_20_0)
			LeanTween.value(go(arg_10_0._tf), 1, 0, 0.3):setOnComplete(System.Action(function()
				arg_20_0()

				return
			end))

			return
		end,
		function(arg_22_0)
			LeanTween.value(go(arg_10_0._tf), 1, 0, 0.3):setOnUpdate(System.Action_float(function(arg_23_0)
				arg_10_0.rollStep:GetComponent(typeof(CanvasGroup)).alpha = arg_23_0

				return
			end)):setOnComplete(System.Action(function()
				setActive(arg_10_0.rollStep, false)

				arg_10_0.rollStep:GetComponent(typeof(CanvasGroup)).alpha = 1

				arg_22_0()

				return
			end))

			return
		end
	}, function()
		arg_10_0.useCount = arg_10_0.useCount + 1
		arg_10_0.step = arg_10_1

		if arg_10_0.step > 0 then
			local var_25_0 = GetSpriteFromAtlas(var_0_9, arg_10_0.step)
		end

		arg_10_0:updataUI()
		arg_10_0:checkCharActive()

		return
	end)

	return
end

function var_0_0.checkCountStory(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0.useCount
	local var_26_1 = arg_26_0.activity:getDataConfig("story") or {}
	local var_26_2 = _.detect(var_26_1, function(arg_27_0)
		return arg_27_0[1] == var_26_0
	end)

	if var_26_2 then
		pg.NewStoryMgr.GetInstance():Play(var_26_2[2], arg_26_1)
	else
		arg_26_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_28_0, arg_28_1)
	if arg_28_1 then
		arg_28_0.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		arg_28_0.inAnimatedFlag = true

		arg_28_0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		arg_28_0.inAnimatedFlag = false
		arg_28_0.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		arg_28_0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	setActive(arg_28_0.btnStart, not arg_28_1)

	return
end

function var_0_0.initMap(arg_29_0)
	arg_29_0.mapCells = {}

	for iter_29_0 = 1, #var_0_18 do
		for iter_29_1 = 1, #var_0_18[iter_29_0] do
			if var_0_18[iter_29_0][iter_29_1] > 0 then
				local var_29_0 = cloneTplTo(arg_29_0.tplMapCell, arg_29_0.mapContainer, tostring(var_0_18[iter_29_0][iter_29_1]))
				local var_29_1 = Vector2(var_0_1 * (iter_29_1 - 1) + ({
					x = -(iter_29_0 - 1) * var_0_1,
					y = -(iter_29_0 - 1) * var_0_2
				}).x, -var_0_2 * (iter_29_1 - 1) + ({
					x = -(iter_29_0 - 1) * var_0_1,
					y = -(iter_29_0 - 1) * var_0_2
				}).y)

				var_29_0.localPosition = var_29_1

				local var_29_2 = findTF(var_29_0, "image")

				var_29_2:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas(var_0_9, pg.activity_event_monopoly_map[var_0_18[iter_29_0][iter_29_1]].icon)

				findTF(var_29_0, "image"):GetComponent(typeof(Image)):SetNativeSize()
				table.insert(arg_29_0.mapCells, {
					col = iter_29_1 - 1,
					row = iter_29_0 - 1,
					mapId = var_0_18[iter_29_0][iter_29_1],
					tf = var_29_0,
					icon = pg.activity_event_monopoly_map[var_0_18[iter_29_0][iter_29_1]].icon,
					position = var_29_1
				})
			end
		end
	end

	table.sort(arg_29_0.mapCells, function(arg_30_0, arg_30_1)
		return arg_30_0.mapId < arg_30_1.mapId
	end)

	return
end

function var_0_0.initChar(arg_31_0)
	PoolMgr.GetInstance():GetSpineChar(var_0_3, true, function(arg_32_0)
		arg_31_0.model = arg_32_0
		arg_31_0.model.transform.localScale = Vector3.one
		arg_31_0.model.transform.localPosition = Vector3.zero

		arg_31_0.model.transform:SetParent(arg_31_0.char, false)

		arg_31_0.anim = arg_31_0.model:GetComponent(typeof(SpineAnimUI))

		arg_31_0:checkCharActive()

		if arg_31_0.pos then
			arg_31_0:updataCharDirect(arg_31_0.pos, false)
		end

		return
	end)

	arg_31_0.showCharMods = {}

	for iter_31_0 = 1, #arg_31_0.showCharNames do
		PoolMgr.GetInstance():GetSpineChar(arg_31_0.showCharNames[iter_31_0], true, function(arg_33_0)
			arg_33_0.transform.localScale = Vector3.one
			arg_33_0.transform.localPosition = Vector3.zero

			arg_33_0.transform:SetParent(arg_31_0.showChars[iter_31_0], false)

			local var_33_0 = arg_33_0:GetComponent(typeof(SpineAnimUI))

			if var_0_7[var_0] then
				var_33_0:SetAction(var_0_7[var_0], 0)
			else
				var_33_0:SetAction("stand", 0)
			end

			table.insert(arg_31_0.showCharMods, arg_33_0)

			return
		end)
	end

	return
end

function var_0_0.updataCharDirect(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_0.model then
		local var_34_2, var_34_3 = arg_34_0:getMoveType(arg_34_0.mapCells[arg_34_1].mapId, arg_34_0.mapCells[arg_34_1 + 1 > #arg_34_0.mapCells and 1 or arg_34_1 + 1].mapId, arg_34_2)

		arg_34_0.char.localScale = Vector3(var_34_3, arg_34_0.char.localScale.y, arg_34_0.char.localScale.z)

		arg_34_0.anim:SetActionCallBack(nil)
		arg_34_0.anim:SetAction(var_34_2, 0)
	end

	return
end

function var_0_0.getMoveType(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = {}
	local var_35_1 = {}

	for iter_35_0 = 1, #var_0_18 do
		for iter_35_1 = 1, #var_0_18[iter_35_0] do
			if var_0_18[iter_35_0][iter_35_1] == arg_35_1 then
				var_35_0 = {
					x = iter_35_1,
					y = iter_35_0
				}
			end

			if var_0_18[iter_35_0][iter_35_1] == arg_35_2 then
				var_35_1 = {
					x = iter_35_1,
					y = iter_35_0
				}
			end
		end
	end

	local var_35_2
	local var_35_3

	if var_35_1.y > var_35_0.y then
		var_35_2 = arg_35_3 and var_0_13 or var_0_11
		var_35_3 = var_0_8
	elseif var_35_1.y < var_35_0.y then
		var_35_2 = arg_35_3 and var_0_12 or var_0_10
		var_35_3 = var_0_8
	elseif var_35_1.x > var_35_0.x then
		var_35_2 = arg_35_3 and var_0_13 or var_0_11
		var_35_3 = -var_0_8
	elseif var_35_1.x < var_35_0.x then
		var_35_2 = arg_35_3 and var_0_12 or var_0_10
		var_35_3 = -var_0_8
	end

	return var_35_2, var_35_3
end

function var_0_0.checkCharActive(arg_36_0)
	if arg_36_0.anim then
		if arg_36_0.effectId and arg_36_0.effectId > 0 then
			arg_36_0:changeAnimeState(true)
			arg_36_0:checkEffect(function()
				arg_36_0:changeAnimeState(false)
				arg_36_0:checkCharActive()

				return
			end)
		elseif arg_36_0.step and arg_36_0.step > 0 then
			arg_36_0:changeAnimeState(true)
			arg_36_0:checkStep(function()
				arg_36_0:changeAnimeState(false)
				arg_36_0:checkCharActive()

				return
			end)
		end
	end

	return
end

function var_0_0.firstUpdata(arg_39_0, arg_39_1)
	arg_39_0:activityDataUpdata(arg_39_1)
	arg_39_0:updataUI()
	arg_39_0:updataChar()
	arg_39_0:checkCharActive()

	return
end

function var_0_0.updataActivity(arg_40_0, arg_40_1)
	arg_40_0:activityDataUpdata(arg_40_1)
	arg_40_0:updataUI()

	return
end

function var_0_0.activityDataUpdata(arg_41_0, arg_41_1)
	arg_41_0.activity = arg_41_1
	arg_41_0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_41_0.activity.data1) / 0) * arg_41_0.activity:getDataConfig("daily_time") + arg_41_0.activity.data1_list[1]
	arg_41_0.useCount = arg_41_0.activity.data1_list[2]
	arg_41_0.leftCount = arg_41_0.totalCnt - arg_41_0.useCount
	arg_41_0.turnCnt = arg_41_0.activity.data1_list[3] - 1
	arg_41_0.leftDropShipCnt = 8 - arg_41_0.turnCnt

	local var_41_0 = arg_41_0.activity.data2_list[2]

	arg_41_0.advanceTotalCnt = #arg_41_1:getDataConfig("reward")
	arg_41_0.isAdvanceRp = arg_41_0.advanceTotalCnt - var_41_0 > 0
	arg_41_0.leftAwardCnt = arg_41_0.activity.data2_list[1] - var_41_0
	arg_41_0.advanceRpCount = math.max(0, math.min(arg_41_0.activity.data2_list[1], arg_41_0.advanceTotalCnt) - var_41_0)
	arg_41_0.commonRpCount = math.max(0, arg_41_0.activity.data2_list[1] - arg_41_0.advanceTotalCnt) - math.max(0, var_41_0 - arg_41_0.advanceTotalCnt)

	local var_41_1 = arg_41_1:getDataConfig("reward_time")

	arg_41_0.nextredPacketStep = var_41_1 - arg_41_0.useCount % var_41_1
	arg_41_0.pos = arg_41_0.activity.data2
	arg_41_0.step = arg_41_0.activity.data3
	arg_41_0.effectId = arg_41_0.activity.data4

	return
end

function var_0_0.checkStep(arg_42_0, arg_42_1)
	if arg_42_0.step > 0 then
		arg_42_0._event:emit(MonopolyCar2Page.ON_MOVE, arg_42_0.activity.id, function(arg_43_0, arg_43_1, arg_43_2)
			arg_42_0.step = arg_43_0
			arg_42_0.pos = arg_43_1[#arg_43_1]
			arg_42_0.effectId = arg_43_2

			seriesAsync({
				function(arg_44_0)
					arg_42_0:moveCharWithPaths(arg_43_1, nil, arg_44_0)

					return
				end,
				function(arg_45_0)
					arg_42_0:checkEffect(arg_45_0)

					return
				end
			}, function()
				if arg_42_1 then
					arg_42_1()
				end

				return
			end)

			return
		end)
	elseif arg_42_1 then
		arg_42_1()
	end

	return
end

function var_0_0.updataUI(arg_47_0)
	setText(arg_47_0.labelLeftRpCount, "" .. arg_47_0.leftAwardCnt)
	arg_47_0.commonAnim:SetInteger("count", arg_47_0.leftAwardCnt)
	setText(arg_47_0.labelDropShip, "" .. arg_47_0.turnCnt + 1)
	setText(arg_47_0.labelLeftCountTip, i18n("monopoly_left_count"))
	setText(arg_47_0.labelLeftCount, arg_47_0.leftCount)

	return
end

function var_0_0.updataChar(arg_48_0)
	arg_48_0.char.localPosition = arg_48_0.mapCells[arg_48_0.pos].position

	if not isActive(arg_48_0.char) then
		SetActive(arg_48_0.char, true)
		arg_48_0.char:SetAsLastSibling()
	end

	if arg_48_0.model then
		arg_48_0:updataCharDirect(arg_48_0.pos, false)
	end

	return
end

function var_0_0.checkEffect(arg_49_0, arg_49_1)
	if arg_49_0.effectId > 0 then
		local var_49_1 = pg.activity_event_monopoly_event[arg_49_0.effectId].story

		seriesAsync({
			function(arg_50_0)
				if var_49_1 and tonumber(var_49_1) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_49_1, arg_50_0, true, true)
				else
					arg_50_0()
				end

				return
			end,
			function(arg_51_0)
				arg_49_0:triggerEfeect(arg_51_0)

				return
			end,
			function(arg_52_0)
				arg_49_0:checkCountStory(arg_52_0)

				return
			end
		}, arg_49_1)
	elseif arg_49_1 then
		arg_49_1()
	end

	return
end

function var_0_0.triggerEfeect(arg_53_0, arg_53_1)
	arg_53_0._event:emit(MonopolyCar2Page.ON_TRIGGER, arg_53_0.activity.id, function(arg_54_0, arg_54_1)
		if arg_54_0 and #arg_54_0 >= 0 then
			arg_53_0.effectId = arg_54_1
			arg_53_0.pos = arg_54_0[#arg_54_0]

			seriesAsync({
				function(arg_55_0)
					arg_53_0:moveCharWithPaths(arg_54_0, nil, arg_55_0)

					return
				end
			}, function()
				arg_53_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.moveCarWithPaths(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	if not arg_57_1 or #arg_57_1 <= 0 then
		if arg_57_3 then
			arg_57_3()
		end

		return
	end

	local var_57_0 = {}
	local var_57_2 = {}
	local var_57_3 = {}

	for iter_57_0 = 1, #arg_57_1 do
		if arg_57_0:checkPathTurn(arg_57_1[iter_57_0]) then
			table.insert({}, arg_57_0.mapCells[arg_57_1[iter_57_0]].position)
			table.insert({}, arg_57_1[iter_57_0])
		elseif iter_57_0 == #arg_57_1 then
			table.insert({}, arg_57_0.mapCells[arg_57_1[iter_57_0]].position)
			table.insert({}, arg_57_1[iter_57_0])
		end
	end

	arg_57_0.speedX = 0
	arg_57_0.speedY = 0
	arg_57_0.baseSpeed = 6
	arg_57_0.baseASpeed = 0.1

	if not arg_57_0.timer then
		arg_57_0.timer = Timer.New(function()
			arg_57_0:toMoveCar()

			return
		end, 0.016666666666666666, -1)

		arg_57_0.timer:Start()
	end

	for iter_57_1 = 1, #{} do
		table.insert(var_57_0, function(arg_59_0)
			arg_57_0.moveComplete = arg_59_0
			arg_57_0.stopOnEnd = false
			arg_57_0.targetPosition = var_57_2[iter_57_1]
			arg_57_0.targetPosIndex = var_57_3[iter_57_1]
			arg_57_0.moveX = arg_57_0.targetPosition.x - arg_57_0.char.localPosition.x
			arg_57_0.moveY = arg_57_0.targetPosition.y - arg_57_0.char.localPosition.y
			arg_57_0.baseSpeedX = arg_57_0.baseSpeed * (arg_57_0.moveX / math.abs(arg_57_0.moveX))
			arg_57_0.baseASpeedX = arg_57_0.baseASpeed * (arg_57_0.moveX / math.abs(arg_57_0.moveX))
			arg_57_0.baseSpeedY = math.abs(arg_57_0.baseSpeedX) / (math.abs(arg_57_0.moveX) / arg_57_0.moveY)
			arg_57_0.baseASpeedY = math.abs(arg_57_0.baseASpeedX) / (math.abs(arg_57_0.moveX) / arg_57_0.moveY)

			if iter_57_1 == 1 then
				arg_57_0.speedX = 0
				arg_57_0.speedY = 0
			else
				arg_57_0.speedX = arg_57_0.baseSpeedX
				arg_57_0.speedY = arg_57_0.baseSpeedY
			end

			return
		end)
	end

	table.insert(var_57_0, function(arg_60_0)
		arg_57_0.moveComplete = nil

		arg_57_0:updataCharDirect(arg_57_1[#arg_57_1], false)
		arg_60_0()

		return
	end)
	table.insert(var_57_0, function(arg_61_0)
		LeanTween.value(go(arg_57_0._tf), 1, 0, 0.1):setOnComplete(System.Action(function()
			arg_61_0()

			return
		end))

		return
	end)
	seriesAsync(var_57_0, arg_57_3)

	return
end

function var_0_0.toMoveCar(arg_63_0)
	if not arg_63_0.targetPosition then
		return
	end

	if math.abs(arg_63_0.targetPosition.x - arg_63_0.char.localPosition.x) <= 6.5 and math.abs(arg_63_0.targetPosition.y - arg_63_0.char.localPosition.y) <= 6.5 then
		arg_63_0.targetPosition = nil

		if arg_63_0.moveComplete then
			arg_63_0:updataCharDirect(arg_63_0.targetPosIndex, true)
			arg_63_0.moveComplete()
		end
	end

	if math.abs(arg_63_0.speedX + arg_63_0.baseASpeedX) > math.abs(arg_63_0.baseSpeedX) then
		arg_63_0.speedX = arg_63_0.baseSpeedX or arg_63_0.speedX + arg_63_0.baseASpeedX

		if math.abs(arg_63_0.speedY + arg_63_0.baseASpeedY) > math.abs(arg_63_0.baseSpeedY) then
			arg_63_0.speedY = arg_63_0.baseSpeedY or arg_63_0.speedY + arg_63_0.baseASpeedY
			arg_63_0.char.localPosition = Vector3(arg_63_0.char.localPosition.x + arg_63_0.speedX, arg_63_0.char.localPosition.y + arg_63_0.speedY, 0)

			return
		end
	end
end

function var_0_0.checkPathTurn(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_1 + 1 > #arg_64_0.mapCells and 1 or arg_64_1 + 1

	if arg_64_1 - 1 < 1 then
		local var_64_1 = #arg_64_0.mapCells or arg_64_1 - 1

		if arg_64_0.mapCells[var_64_0].col == arg_64_0.mapCells[var_64_1].col or arg_64_0.mapCells[var_64_0].row == arg_64_0.mapCells[var_64_1].row then
			return false
		end

		return true
	end
end

function var_0_0.moveCharWithPaths(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	arg_65_0:moveCarWithPaths(arg_65_1, arg_65_2, arg_65_3)

	do return end

	if not arg_65_1 or #arg_65_1 <= 0 then
		if arg_65_3 then
			arg_65_3()
		end

		return
	end

	local var_65_0 = {}
	local var_65_1 = arg_65_1[1] - 1 < 1 and #arg_65_0.mapCells or arg_65_1[1] - 1

	for iter_65_0 = 1, #arg_65_1 do
		local var_65_2 = arg_65_0.mapCells[arg_65_1[iter_65_0]]

		table.insert(var_65_0, function(arg_66_0)
			arg_65_0:updataCharDirect(var_65_1, true)

			var_65_1 = arg_65_1[iter_65_0]

			LeanTween.moveLocal(go(arg_65_0.char), var_65_2.tf.localPosition, 0.35):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				arg_66_0()

				return
			end))

			return
		end)

		if iter_65_0 == #arg_65_1 then
			table.insert(var_65_0, function(arg_68_0)
				arg_65_0:updataCharDirect(arg_65_1[iter_65_0], false)
				arg_68_0()

				return
			end)
		end
	end

	seriesAsync(var_65_0, arg_65_3)

	return
end

function var_0_0.dispose(arg_69_0)
	PoolMgr.GetInstance():ReturnSpineChar(var_0_3, arg_69_0.showModel)

	for iter_69_0 = 1, 3 do
		if arg_69_0.showCharNames[iter_69_0] then
			PoolMgr.GetInstance():ReturnSpineChar(arg_69_0.showCharNames[iter_69_0], arg_69_0.showCharMods[iter_69_0])
		end
	end

	return
end

return var_0_0
