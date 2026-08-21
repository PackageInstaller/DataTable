local var_0_0 = class("MonopolyWorldGame")
local var_0_1 = 117
local var_0_2 = 60
local var_0_3 = {
	{
		0,
		4007,
		4008,
		4009,
		4010,
		0
	},
	{
		4005,
		4006,
		0,
		0,
		4011,
		4012
	},
	{
		4004,
		0,
		0,
		0,
		0,
		4013
	},
	{
		4003,
		4002,
		0,
		0,
		4015,
		4014
	},
	{
		0,
		4001,
		4018,
		4017,
		4016,
		0
	}
}
local var_0_4 = "mengya"
local var_0_5 = "monopoly_world_tip1"
local var_0_6 = "monopoly_world_tip2"
local var_0_7 = "monopoly_world_tip3"
local var_0_8 = 0.6
local var_0_9 = "dafuweng_gold"
local var_0_10 = "dafuweng_oil"
local var_0_11 = "dafuweng_event"
local var_0_12 = "dafuweng_walk"
local var_0_13 = "dafuweng_stand"
local var_0_14 = "dafuweng_walk"
local var_0_15 = "dafuweng_run"
local var_0_16 = "dafuweng_touch"
local var_0_17 = "cell gold"
local var_0_18 = "cell move"
local var_0_19 = "cell oil"
local var_0_20 = "cell event"
local var_0_21 = "cell item"
local var_0_22 = {}

;({
	name = "gulitemengya_1",
	path_length = 1
}).cell_type = "cell move"
;({})[1] = {
	name = "gulitemengya_1",
	path_length = 1
}
;({})[2] = {
	name = "gulitemengya_2",
	path_length = 2,
	cell_type = "cell move"
}
;({})[3] = {
	name = "gulitemengya_3",
	path_length = 3,
	cell_type = "cell move"
}
;({})[4] = {
	name = "gulitemengya_daoju",
	cell_type = "cell item"
}
;({})[5] = {
	name = "gulitemengya_jinbi",
	cell_type = "cell gold"
}
;({})[6] = {
	name = "gulitemengya_mingyun",
	cell_type = "cell event"
}
;({})[7] = {
	name = "gulitemengya_shiyou",
	cell_type = "cell oil"
}

local var_0_23 = {
	84180,
	84181,
	84183,
	84179,
	84182
}
local var_0_24
local var_0_25

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

	return
end

function var_0_0.initUI(arg_3_0)
	arg_3_0.tplMapCell = findTF(arg_3_0._tf, "tplMapCell")
	arg_3_0.gameTipUI1 = findTF(arg_3_0._tf, "btnStart/desc")

	setText(arg_3_0.gameTipUI1, i18n(var_0_5))

	arg_3_0.gameTipUI2 = findTF(arg_3_0._tf, "bg/desc")

	setText(arg_3_0.gameTipUI2, "")

	arg_3_0.mapContainer = findTF(arg_3_0._tf, "mapContainer")
	arg_3_0.char = findTF(arg_3_0._tf, "mapContainer/char")

	setActive(arg_3_0.char, false)

	arg_3_0.btnStart = findTF(arg_3_0._tf, "btnStart")
	arg_3_0.effectStart = findTF(arg_3_0.btnStart, "gulitemengya_pingmu")
	arg_3_0.btnHelp = findTF(arg_3_0._tf, "topRight/btnHelp")
	arg_3_0.labelLeftCount = findTF(arg_3_0.btnStart, "times")
	arg_3_0.btnBack = findTF(arg_3_0._tf, "leftTop/back")

	arg_3_0:initMap()
	arg_3_0:initChar()
	arg_3_0:initFurn()

	return
end

function var_0_0.initFurn(arg_4_0)
	local var_4_0 = findTF(arg_4_0._tf, "bg/mask/event"):GetComponent("HScrollSnap")

	arg_4_0.bannerCanvas = GetComponent(findTF(arg_4_0._tf, "bg/mask"), typeof(CanvasGroup))

	var_4_0:Init()

	local var_4_1 = findTF(var_4_0, "item")
	local var_4_2 = findTF(arg_4_0._tf, "bg/dots")
	local var_4_3 = findTF(arg_4_0._tf, "bg/dot")

	setActive(var_4_1, false)
	setActive(var_4_3, false)

	arg_4_0.furnItems = {}

	for iter_4_0 = 0, #var_0_23 - 1 do
		cloneTplTo(var_4_3, var_4_2)

		local var_4_4 = Instantiate(var_4_1)

		var_0_24 = pg.furniture_data_template[var_0_23[iter_4_0 + 1]]
		var_0_25 = var_0_24.icon

		GetImageSpriteFromAtlasAsync("ui/monopolyworldui_atlas", var_0_25, findTF(var_4_4, "img"), true)
		var_4_0:AddChild(var_4_4)
		setActive(var_4_4, true)
		table.insert(arg_4_0.furnItems, var_4_4)
	end

	arg_4_0.bannerSnap = var_4_0
	arg_4_0.bannerContent = findTF(var_4_0, "content")
	arg_4_0.bannerDots = var_4_2
	arg_4_0.furnNames = {}

	for iter_4_1 = 1, #var_0_23 do
		table.insert(arg_4_0.furnNames, findTF(arg_4_0._tf, "bg/furnName/img" .. iter_4_1))
	end

	arg_4_0.funrTimer = Timer.New(function()
		for iter_5_0 = 1, #var_0_23 do
			if iter_5_0 == arg_4_0.bannerSnap:CurrentScreen() + 1 then
				if not isActive(arg_4_0.furnNames[iter_5_0]) then
					setActive(arg_4_0.furnNames[iter_5_0], true)
				end
			elseif isActive(arg_4_0.furnNames[iter_5_0]) then
				setActive(arg_4_0.furnNames[iter_5_0], false)
			end
		end

		return
	end, 0.2, -1)

	arg_4_0.funrTimer:Start()
	;(function()
		for iter_5_0 = 1, #var_0_23 do
			if iter_5_0 == arg_4_0.bannerSnap:CurrentScreen() + 1 then
				if not isActive(arg_4_0.furnNames[iter_5_0]) then
					setActive(arg_4_0.furnNames[iter_5_0], true)
				end
			elseif isActive(arg_4_0.furnNames[iter_5_0]) then
				setActive(arg_4_0.furnNames[iter_5_0], false)
			end
		end

		return
	end)()

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
		setActive(arg_6_0.btnStart, true)
		arg_6_0._event:emit(MonopolyWorldScene.ON_START, arg_6_0.activity.id, function(arg_8_0)
			if arg_8_0 and arg_8_0 > 0 then
				arg_6_0:showRollAnimated(arg_8_0)
			end

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_6_0._binder, arg_6_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_monopoly_world.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0._binder, arg_6_0.btnBack, function()
		if not arg_6_0.inAnimatedFlag then
			arg_6_0._event:emit(BaseUI.ON_BACK)
		end

		return
	end, SFX_PANEL)
	onButton(arg_6_0._binder, findTF(arg_6_0.char, "click"), function()
		if not arg_6_0.model or arg_6_0.inAnimatedFlag then
			return
		end

		arg_6_0:changeCharAction(var_0_16, 1, function()
			arg_6_0:changeCharAction(var_0_13)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.showRollAnimated(arg_13_0, arg_13_1)
	seriesAsync({
		function(arg_14_0)
			setActive(arg_13_0.effectStart, true)
			GetComponent(findTF(arg_13_0.btnStart, "anim"), typeof(Animator)):Play("start", -1, 0)
			LeanTween.delayedCall(1, System.Action(function()
				for iter_15_0 = 1, 6 do
					local var_15_0 = findTF(arg_13_0.btnStart, "num/" .. iter_15_0)

					if iter_15_0 ~= arg_13_1 then
						setActive(var_15_0, false)
					else
						setActive(var_15_0, true)
					end
				end

				return
			end))
			LeanTween.delayedCall(2, System.Action(function()
				arg_14_0()

				return
			end))

			return
		end
	}, function()
		arg_13_0.useCount = arg_13_0.useCount + 1
		arg_13_0.leftCount = arg_13_0.leftCount - 1
		arg_13_0.step = arg_13_1

		arg_13_0:updataUI()
		arg_13_0:checkCharActive()

		return
	end)

	return
end

function var_0_0.checkCountStory(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.useCount
	local var_18_1 = arg_18_0.activity:getDataConfig("story") or {}
	local var_18_2 = _.detect(var_18_1, function(arg_19_0)
		return arg_19_0[1] == var_18_0
	end)

	if var_18_2 then
		pg.NewStoryMgr.GetInstance():Play(var_18_2[2], arg_18_1)
	else
		arg_18_1()
	end

	return
end

function var_0_0.changeAnimeState(arg_20_0, arg_20_1)
	if arg_20_1 then
		arg_20_0.btnStart:GetComponent(typeof(Image)).raycastTarget = false
		arg_20_0.inAnimatedFlag = true

		arg_20_0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, true)
	else
		arg_20_0.inAnimatedFlag = false
		arg_20_0.btnStart:GetComponent(typeof(Image)).raycastTarget = true

		arg_20_0._event:emit(ActivityMainScene.LOCK_ACT_MAIN, false)
	end

	return
end

function var_0_0.initMap(arg_21_0)
	arg_21_0.mapCells = {}

	for iter_21_0 = 1, #var_0_3 do
		for iter_21_1 = 1, #var_0_3[iter_21_0] do
			if var_0_3[iter_21_0][iter_21_1] > 0 then
				local var_21_0 = cloneTplTo(arg_21_0.tplMapCell, arg_21_0.mapContainer, tostring(var_0_3[iter_21_0][iter_21_1]))
				local var_21_1 = Vector2(var_0_1 * (iter_21_1 - 1) + ({
					x = -(iter_21_0 - 1) * var_0_1,
					y = -(iter_21_0 - 1) * var_0_2
				}).x, -var_0_2 * (iter_21_1 - 1) + ({
					x = -(iter_21_0 - 1) * var_0_1,
					y = -(iter_21_0 - 1) * var_0_2
				}).y)

				var_21_0.localPosition = var_21_1

				local var_21_2 = findTF(var_21_0, "image")

				var_21_2:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/monopolyworldui_atlas", pg.activity_event_monopoly_map[var_0_3[iter_21_0][iter_21_1]].icon)

				findTF(var_21_0, "image"):GetComponent(typeof(Image)):SetNativeSize()
				table.insert(arg_21_0.mapCells, {
					col = iter_21_1 - 1,
					row = iter_21_0 - 1,
					mapId = var_0_3[iter_21_0][iter_21_1],
					tf = var_21_0,
					icon = pg.activity_event_monopoly_map[var_0_3[iter_21_0][iter_21_1]].icon,
					position = var_21_1
				})
			end
		end
	end

	table.sort(arg_21_0.mapCells, function(arg_22_0, arg_22_1)
		return arg_22_0.mapId < arg_22_1.mapId
	end)

	return
end

function var_0_0.initChar(arg_23_0)
	PoolMgr.GetInstance():GetSpineChar(var_0_4, true, function(arg_24_0)
		arg_23_0.model = arg_24_0
		arg_23_0.model.transform.localScale = Vector3.one
		arg_23_0.model.transform.localPosition = Vector3.zero

		arg_23_0.model.transform:SetParent(arg_23_0.char, false)

		arg_23_0.anim = arg_23_0.model:GetComponent(typeof(SpineAnimUI))

		arg_23_0:changeCharAction(var_0_13, 0, nil)
		arg_23_0:checkCharActive()

		if arg_23_0.pos then
			arg_23_0:updataCharDirect(arg_23_0.pos, false)
		end

		return
	end)

	return
end

function var_0_0.updataCharDirect(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0.model then
		local var_25_2 = arg_25_0:getMoveType(arg_25_0.mapCells[arg_25_1].mapId, arg_25_0.mapCells[arg_25_1 + 1 > #arg_25_0.mapCells and 1 or arg_25_1 + 1].mapId, arg_25_2) or arg_25_0.char.localScale.x

		arg_25_0.char.localScale = Vector3(var_25_2, arg_25_0.char.localScale.y, arg_25_0.char.localScale.z)
	end

	return
end

function var_0_0.getMoveType(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0 = 1, #var_0_3 do
		for iter_26_1 = 1, #var_0_3[iter_26_0] do
			if var_0_3[iter_26_0][iter_26_1] == arg_26_1 then
				var_26_0 = {
					x = iter_26_1,
					y = iter_26_0
				}
			end

			if var_0_3[iter_26_0][iter_26_1] == arg_26_2 then
				var_26_1 = {
					x = iter_26_1,
					y = iter_26_0
				}
			end
		end
	end

	local var_26_2

	if var_26_1.y > var_26_0.y then
		var_26_2 = -var_0_8
	elseif var_26_1.y < var_26_0.y then
		var_26_2 = var_0_8
	elseif var_26_1.x > var_26_0.x then
		var_26_2 = var_0_8
	elseif var_26_1.x < var_26_0.x then
		var_26_2 = -var_0_8
	end

	return var_26_2
end

function var_0_0.checkCharActive(arg_27_0)
	if arg_27_0.anim then
		if arg_27_0.effectId and arg_27_0.effectId > 0 then
			arg_27_0:changeAnimeState(true)
			arg_27_0:checkEffect(function()
				arg_27_0:changeAnimeState(false)
				arg_27_0:checkCharActive()

				return
			end)
		elseif arg_27_0.step and arg_27_0.step > 0 then
			arg_27_0:changeAnimeState(true)
			arg_27_0:checkStep(function()
				arg_27_0:changeAnimeState(false)
				arg_27_0:checkCharActive()

				return
			end)
		elseif arg_27_0.activity then
			arg_27_0.activity = getProxy(ActivityProxy):getActivityById(arg_27_0.activity.id)

			arg_27_0:updataActivity(arg_27_0.activity)
		end
	end

	return
end

function var_0_0.firstUpdata(arg_30_0, arg_30_1)
	arg_30_0:activityDataUpdata(arg_30_1)
	arg_30_0:updataUI()
	arg_30_0:updataChar()
	arg_30_0:checkCharActive()

	return
end

function var_0_0.updataActivity(arg_31_0, arg_31_1)
	arg_31_0:activityDataUpdata(arg_31_1)
	arg_31_0:updataUI()

	return
end

function var_0_0.activityDataUpdata(arg_32_0, arg_32_1)
	arg_32_0.activity = arg_32_1
	arg_32_0.totalCnt = math.ceil((pg.TimeMgr.GetInstance():GetServerTime() - arg_32_0.activity.data1) / 0) * arg_32_0.activity:getDataConfig("daily_time") + arg_32_0.activity.data1_list[1]
	arg_32_0.useCount = arg_32_0.activity.data1_list[2]
	arg_32_0.leftCount = arg_32_0.totalCnt - arg_32_0.useCount

	if arg_32_0.turnCnt and arg_32_0.turnCnt ~= arg_32_0.activity.data1_list[3] - 1 then
		arg_32_0.autoShowScreen = nil
	end

	arg_32_0.turnCnt = arg_32_0.activity.data1_list[3] - 1
	arg_32_0.leftDropShipCnt = 8 - arg_32_0.turnCnt

	local var_32_0 = arg_32_0.activity.data2_list[2]

	arg_32_0.advanceTotalCnt = #arg_32_1:getDataConfig("reward")
	arg_32_0.isAdvanceRp = arg_32_0.advanceTotalCnt - var_32_0 > 0
	arg_32_0.leftAwardCnt = arg_32_0.activity.data2_list[1] - var_32_0
	arg_32_0.advanceRpCount = math.max(0, math.min(arg_32_0.activity.data2_list[1], arg_32_0.advanceTotalCnt) - var_32_0)
	arg_32_0.commonRpCount = math.max(0, arg_32_0.activity.data2_list[1] - arg_32_0.advanceTotalCnt) - math.max(0, var_32_0 - arg_32_0.advanceTotalCnt)

	local var_32_1 = arg_32_1:getDataConfig("reward_time")

	arg_32_0.nextredPacketStep = var_32_1 - arg_32_0.useCount % var_32_1
	arg_32_0.pos = arg_32_0.activity.data2
	arg_32_0.lastPos = arg_32_0.pos
	arg_32_0.step = arg_32_0.activity.data3
	arg_32_0.effectId = arg_32_0.activity.data4

	return
end

function var_0_0.checkStep(arg_33_0, arg_33_1)
	if arg_33_0.step > 0 then
		arg_33_0._event:emit(MonopolyWorldScene.ON_MOVE, arg_33_0.activity.id, function(arg_34_0, arg_34_1, arg_34_2)
			arg_33_0.step = arg_34_0
			arg_33_0.lastPos = arg_33_0.pos
			arg_33_0.pos = arg_34_1[#arg_34_1]
			arg_33_0.effectId = arg_34_2

			seriesAsync({
				function(arg_35_0)
					if #arg_34_1 > 3 then
						local var_35_0 = var_0_15 or var_0_14

						arg_33_0:moveCharWithPaths(arg_34_1, var_35_0, arg_35_0)

						return
					end
				end,
				function(arg_36_0)
					if arg_34_1 and #arg_34_1 > 0 and arg_33_0.pos == 1 then
						arg_33_0.turnCnt = arg_33_0.turnCnt + 1

						setText(findTF(arg_33_0._tf, "topRight/times"), tostring(arg_33_0.turnCnt))
						arg_33_0:changeBg()
					end

					if isActive(arg_33_0.effectStart) then
						setActive(arg_33_0.effectStart, false)
						setActive(arg_33_0.effectStart, true)
						LeanTween.delayedCall(1, System.Action(function()
							for iter_37_0 = 1, 6 do
								setActive(findTF(arg_33_0.btnStart, "num/" .. iter_37_0), false)
							end

							return
						end))
						LeanTween.delayedCall(2, System.Action(function()
							setActive(arg_33_0.effectStart, false)

							return
						end))
					end

					arg_33_0:checkEffect(arg_36_0)

					return
				end
			}, function()
				if arg_33_1 then
					arg_33_1()
				end

				return
			end)

			return
		end)
	else
		if arg_33_0.pos == 1 then
			arg_33_0.turnCnt = arg_33_0.turnCnt + 1

			arg_33_0:changeBg()
		end

		if arg_33_1 then
			arg_33_1()
		end
	end

	return
end

function var_0_0.updataUI(arg_40_0)
	setText(arg_40_0.labelLeftCount, arg_40_0.leftCount)

	local var_40_0 = arg_40_0.activity:getDataConfig("daily_time")

	var_0_25 = var_0_24.icon

	if arg_40_0.turnCnt and arg_40_0.turnCnt < #var_0_23 then
		var_0_24 = pg.furniture_data_template[var_0_23[arg_40_0.turnCnt + 1]]

		setText(arg_40_0.gameTipUI2, i18n(var_0_6, var_40_0, 1))
	else
		setText(arg_40_0.gameTipUI2, i18n(var_0_7, var_40_0))
	end

	if arg_40_0.leftCount and arg_40_0.leftCount > 0 then
		setActive(findTF(arg_40_0.btnStart, "img3"), true)
		setActive(findTF(arg_40_0.btnStart, "img4"), false)
	else
		setActive(findTF(arg_40_0.btnStart, "img3"), false)
		setActive(findTF(arg_40_0.btnStart, "img4"), true)
	end

	setText(findTF(arg_40_0._tf, "topRight/times"), tostring(arg_40_0.turnCnt))

	for iter_40_0 = 1, #arg_40_0.furnItems do
		if iter_40_0 <= arg_40_0.turnCnt then
			setActive(findTF(arg_40_0.furnItems[iter_40_0], "got"), true)
		else
			setActive(findTF(arg_40_0.furnItems[iter_40_0], "got"), false)
		end
	end

	if arg_40_0.bannerSnap.StartingScreen == 0 and not arg_40_0.bannerInit then
		if arg_40_0.turnCnt < #var_0_23 then
			arg_40_0.bannerSnap.StartingScreen = arg_40_0.turnCnt % 5 + 1
			arg_40_0.bannerInit = true
		else
			arg_40_0.bannerSnap.autoSnap = 5
		end
	elseif arg_40_0.bannerSnap:CurrentScreen() ~= arg_40_0.turnCnt and arg_40_0.turnCnt < #var_0_23 then
		local var_40_1 = arg_40_0.turnCnt % 5 - arg_40_0.bannerSnap:CurrentScreen()

		for iter_40_1 = 1, math.abs(var_40_1) do
			if math.sign(var_40_1) > 0 then
				arg_40_0.bannerSnap:NextScreen(true)
			else
				arg_40_0.bannerSnap:PreviousScreen(true)
			end
		end
	end

	if arg_40_0.turnCnt >= #var_0_23 then
		if arg_40_0.bannerCanvas.blocksRaycasts ~= true then
			arg_40_0.bannerCanvas.blocksRaycasts = true
		end

		if not isActive(findTF(arg_40_0._tf, "bg/dots")) then
			arg_40_0.bannerSnap:NextScreen(true)
			setActive(findTF(arg_40_0._tf, "bg/dots"), true)
		end
	else
		if arg_40_0.bannerCanvas.blocksRaycasts == true then
			arg_40_0.bannerCanvas.blocksRaycasts = false
		end

		if isActive(findTF(arg_40_0._tf, "bg/dots")) then
			setActive(findTF(arg_40_0._tf, "bg/dots"), false)
		end
	end

	arg_40_0:changeBg()

	return
end

function var_0_0.updataChar(arg_41_0)
	arg_41_0.char.localPosition = arg_41_0.mapCells[arg_41_0.pos].position

	if not isActive(arg_41_0.char) then
		SetActive(arg_41_0.char, true)
		arg_41_0.char:SetAsLastSibling()
	end

	if arg_41_0.model then
		arg_41_0:updataCharDirect(arg_41_0.pos, false)
	end

	return
end

function var_0_0.getEffectTf(arg_42_0, arg_42_1, arg_42_2)
	for iter_42_0 = 1, #var_0_22 do
		if var_0_22[iter_42_0].cell_type == arg_42_1 then
			if not arg_42_2 then
				return findTF(arg_42_0._tf, "mapContainer/effect/" .. var_0_22[iter_42_0].name)
			elseif arg_42_2 == var_0_22[iter_42_0].path_length then
				return findTF(arg_42_0._tf, "mapContainer/effect/" .. var_0_22[iter_42_0].name)
			end
		end
	end

	return nil
end

function var_0_0.checkEffect(arg_43_0, arg_43_1)
	if arg_43_0.effectId > 0 then
		local var_43_0, var_43_1 = arg_43_0:getActionName(arg_43_0.mapCells[arg_43_0.pos].icon)
		local var_43_2 = pg.activity_event_monopoly_event[arg_43_0.effectId].story

		seriesAsync({
			function(arg_44_0)
				if var_43_0 then
					arg_43_0:changeCharAction(var_43_0, 1, function()
						arg_43_0:changeCharAction(var_0_13, 0, nil)
						arg_44_0()

						return
					end)
				end

				if var_43_1 then
					local var_44_0 = arg_43_0:getEffectTf(var_43_1)

					if var_44_0 then
						var_44_0.anchoredPosition = Vector2(var_0.position.x, var_0.position.y)

						setActive(var_44_0, false)
						setActive(var_44_0, true)
					end
				end

				if not var_43_0 and not var_43_1 then
					arg_44_0()
				elseif not var_43_0 and var_43_1 then
					LeanTween.delayedCall(1, System.Action(function()
						arg_44_0()

						return
					end))
				end

				return
			end,
			function(arg_47_0)
				if var_43_2 and tonumber(var_43_2) ~= 0 then
					pg.NewStoryMgr.GetInstance():Play(var_43_2, arg_47_0, true, true)
				else
					arg_47_0()
				end

				return
			end,
			function(arg_48_0)
				arg_43_0:triggerEfeect(arg_48_0)

				return
			end,
			function(arg_49_0)
				arg_43_0:checkCountStory(arg_49_0)

				return
			end,
			function(arg_50_0)
				if arg_43_0.pos == 1 then
					arg_43_0:changeBg()
				end

				arg_50_0()

				return
			end
		}, arg_43_1)
	elseif arg_43_1 then
		arg_43_1()
	end

	return
end

function var_0_0.triggerEfeect(arg_51_0, arg_51_1)
	arg_51_0._event:emit(MonopolyWorldScene.ON_TRIGGER, arg_51_0.activity.id, function(arg_52_0, arg_52_1)
		if arg_52_0 and #arg_52_0 >= 0 then
			arg_51_0.effectId = arg_52_1
			arg_51_0.lastPos = arg_51_0.pos
			arg_51_0.pos = arg_52_0[#arg_52_0]

			if #arg_52_0 > 0 then
				print()
			end

			local var_52_0 = arg_51_0:getEffectTf(var_0_18, #arg_52_0)

			seriesAsync({
				function(arg_53_0)
					if var_52_0 then
						setActive(var_52_0, false)
						setActive(var_52_0, true)

						var_52_0.anchoredPosition = arg_51_0.mapCells[arg_51_0.lastPos].position

						LeanTween.delayedCall(1, System.Action(function()
							arg_53_0()

							return
						end))
					else
						arg_53_0()
					end

					return
				end,
				function(arg_55_0)
					arg_51_0:moveCharWithPaths(arg_52_0, var_0_12, arg_55_0)

					return
				end
			}, function()
				if var_52_0 then
					-- block empty
				end

				arg_51_1()

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.changeBg(arg_57_0)
	if arg_57_0.turnCnt then
		local var_57_0 = arg_57_0.turnCnt % 5 + 1 or 1

		for iter_57_0 = 1, 5 do
			local var_57_1 = findTF(arg_57_0._tf, "bg/img" .. iter_57_0)
			local var_57_2 = GetComponent(var_57_1, typeof(Image)).color.a

			if iter_57_0 == var_57_0 then
				if var_57_2 ~= 1 then
					LeanTween.alpha(var_57_1, 1, 0.5)
				end
			elseif var_57_2 ~= 0 then
				LeanTween.alpha(var_57_1, 0, 0.5)
			end
		end

		return
	end
end

function var_0_0.toMoveCar(arg_58_0)
	if not arg_58_0.targetPosition then
		return
	end

	if math.abs(arg_58_0.targetPosition.x - arg_58_0.char.localPosition.x) <= 6.5 and math.abs(arg_58_0.targetPosition.y - arg_58_0.char.localPosition.y) <= 6.5 then
		arg_58_0.targetPosition = nil

		if arg_58_0.moveComplete then
			arg_58_0:updataCharDirect(arg_58_0.targetPosIndex, true)
			arg_58_0.moveComplete()
		end
	end

	if math.abs(arg_58_0.speedX + arg_58_0.baseASpeedX) > math.abs(arg_58_0.baseSpeedX) then
		arg_58_0.speedX = arg_58_0.baseSpeedX or arg_58_0.speedX + arg_58_0.baseASpeedX

		if math.abs(arg_58_0.speedY + arg_58_0.baseASpeedY) > math.abs(arg_58_0.baseSpeedY) then
			arg_58_0.speedY = arg_58_0.baseSpeedY or arg_58_0.speedY + arg_58_0.baseASpeedY
			arg_58_0.char.localPosition = Vector3(arg_58_0.char.localPosition.x + arg_58_0.speedX, arg_58_0.char.localPosition.y + arg_58_0.speedY, 0)

			return
		end
	end
end

function var_0_0.checkPathTurn(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_1 + 1 > #arg_59_0.mapCells and 1 or arg_59_1 + 1

	if arg_59_1 - 1 < 1 then
		local var_59_1 = #arg_59_0.mapCells or arg_59_1 - 1

		if arg_59_0.mapCells[var_59_0].col == arg_59_0.mapCells[var_59_1].col or arg_59_0.mapCells[var_59_0].row == arg_59_0.mapCells[var_59_1].row then
			return false
		end

		return true
	end
end

function var_0_0.moveCharWithPaths(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_1 or #arg_60_1 <= 0 then
		if arg_60_3 then
			arg_60_3()
		end

		return
	end

	local var_60_0 = {}
	local var_60_1 = arg_60_1[1] - 1 < 1 and #arg_60_0.mapCells or arg_60_1[1] - 1

	for iter_60_0 = 1, #arg_60_1 do
		local var_60_2 = arg_60_0.mapCells[arg_60_1[iter_60_0]]

		table.insert(var_60_0, function(arg_61_0)
			arg_60_0:changeCharAction(arg_60_2, 0, nil)
			arg_60_0:updataCharDirect(var_60_1, true)

			var_60_1 = arg_60_1[iter_60_0]

			LeanTween.moveLocal(go(arg_60_0.char), var_60_2.tf.localPosition, arg_60_2 == var_0_12 and 0.9 or arg_60_2 == var_0_14 and 0.9 or 0.5):setEase(LeanTweenType.linear):setOnComplete(System.Action(function()
				if arg_60_2 == var_0_14 then
					LeanTween.delayedCall(0.05, System.Action(function()
						arg_61_0()

						return
					end))
				else
					arg_61_0()
				end

				return
			end))

			return
		end)

		if iter_60_0 == #arg_60_1 then
			table.insert(var_60_0, function(arg_64_0)
				arg_60_0:changeCharAction(var_0_13, 0, nil)
				arg_60_0:updataCharDirect(arg_60_1[iter_60_0], false)
				arg_64_0()

				return
			end)
		end
	end

	seriesAsync(var_60_0, arg_60_3)

	return
end

function var_0_0.changeCharAction(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	if arg_65_0.actionName == arg_65_1 and arg_65_0.actionName ~= var_0_14 then
		return
	end

	arg_65_0.actionName = arg_65_1

	arg_65_0.anim:SetActionCallBack(nil)
	arg_65_0.anim:SetAction(arg_65_1, 0)
	arg_65_0.anim:SetActionCallBack(function(arg_66_0)
		if arg_66_0 == "finish" then
			if arg_65_2 == 1 then
				arg_65_0.anim:SetActionCallBack(nil)
				arg_65_0.anim:SetAction(var_0_13, 0)
			end

			if arg_65_3 then
				arg_65_3()
			end
		end

		return
	end)

	if arg_65_2 ~= 1 and arg_65_3 then
		arg_65_3()
	end

	return
end

function var_0_0.getActionName(arg_67_0, arg_67_1)
	if arg_67_1 == "icon_1" then
		return var_0_11, var_0_21
	elseif arg_67_1 == "icon_2" then
		return var_0_9, var_0_17
	elseif arg_67_1 == "icon_3" then
		return var_0_11, var_0_20
	elseif arg_67_1 == "icon_4" then
		return var_0_11, var_0_21
	elseif arg_67_1 == "icon_5" then
		return var_0_10, var_0_19
	elseif arg_67_1 == "icon_6" then
		return nil, nil
	end

	return
end

function var_0_0.dispose(arg_68_0)
	if arg_68_0.skinCardName and arg_68_0.showModel then
		PoolMgr.GetInstance():ReturnSpineChar(arg_68_0.skinCardName, arg_68_0.showModel)
	end

	if arg_68_0.funrTimer then
		arg_68_0.funrTimer:Stop()

		arg_68_0.funrTimer = nil
	end

	for iter_68_0 = 1, 5 do
		local var_68_0 = findTF(arg_68_0._tf, "bg/img" .. iter_68_0)

		if LeanTween.isTweening(var_68_0) then
			LeanTween.cancel(var_68_0)
		end
	end

	return
end

return var_0_0
