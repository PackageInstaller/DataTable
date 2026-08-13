class = var_0_10000

local var_0_0 = "ShrineView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))

function var_0_1.getUIName(arg_1_0)
	return "Shrine"
end

function var_0_1.init(arg_2_0)
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:initData()

	local var_3_0 = arg_3_0.spineAnim

	var_1.SetAction(var_3_0, "normal", 0)
	arg_3_0:updateView()
	arg_3_0:updateBuff()
	arg_3_0:updateWitchImg()

	return
end

function var_0_1.onBackPressed(arg_4_0)
	local var_4_0 = arg_4_0.shrineBuffView
	local var_4_1 = var_1.CheckState

	BaseSubView = var_1_10003

	if var_4_1(var_4_0, var_1_10003.STATES.INITED) then
		local var_4_2 = arg_4_0.shrineBuffView

		var_1.Destroy(var_4_2)
	else
		local var_4_3 = arg_4_0.shrineResultView
		local var_4_4 = var_1.CheckState

		BaseSubView = var_3

		if var_4_4(var_4_3, var_3.STATES.INITED) then
			local var_4_5 = arg_4_0.shrineResultView

			var_1.Destroy(var_4_5)
		else
			arg_4_0:emit(var_0_1.ON_BACK_PRESSED)
		end
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.argList[1]
	local var_5_1 = var_2[2]

	if var_5_0 == arg_5_0.miniGameId then
		if var_5_1 == 1 then
			var_1_10006 = arg_5_0

			arg_5_0.updateView(var_1_10006)

			var_1_10006 = arg_5_0

			arg_5_0.updateWitchImg(var_1_10006)
		elseif var_5_1 == 2 then
			getProxy = var_5
			PlayerProxy = var_1_10006
			var_1_10006 = var_5(var_1_10006)

			local var_5_2 = var_5.getData(var_1_10006)

			var_1_10006 = var_5.consume

			local var_5_3 = {}
			local var_5_4 = arg_5_0:GetMGData()

			var_5_3.gold = var_9.getConfig(var_5_4, "config_data")[1]

			var_1_10006(var_5_2, var_5_3)

			getProxy = var_1_10006
			PlayerProxy = var_5_2

			local var_5_5 = var_1_10006(var_5_2)

			var_1_10006.updatePlayer(var_5_5, var_5)

			getProxy = var_1_10006
			ActivityProxy = var_5_5

			local var_5_6 = var_1_10006(var_5_5)

			var_1_10006 = var_1_10006.getActivityByType
			ActivityConst = var_8

			local var_5_7

			if var_1_10006(var_5_6, var_8.ACTIVITY_TYPE_SHRINE) then
				var_5_7 = var_1_10006

				if not var_1_10006.isEnd(var_5_7) then
					var_1_10006.data2 = var_1_10006.data2 + 1
					getProxy = var_7
					ActivityProxy = var_5_7
					var_5_7 = var_7(var_5_7)

					var_7.updateActivity(var_5_7, var_1_10006)
				end
			end

			local var_5_8 = var_2[3]

			pg = var_5_7

			local var_5_9 = var_5_7.benefit_buff_template[var_5_8].name

			table = var_9

			local var_5_10 = var_9.indexof
			local var_5_11 = arg_5_0:GetMGData()
			local var_5_12 = var_5_10(var_10.getConfig(var_5_11, "config_data")[2], var_5_8, 1)

			i18n = var_10

			local var_5_13 = var_10("tips_shrine_buff")

			arg_5_0:playAnime(var_5_13, var_5_12)
			arg_5_0:updateView()
			arg_5_0:updateWitchImg()
		elseif var_5_1 == 3 then
			getProxy = var_5
			PlayerProxy = var_1_10006

			local var_5_14 = var_5(var_1_10006)
			local var_5_15 = var_5.getData(var_5_14)
			local var_5_16 = var_5.consume
			local var_5_17 = {}
			local var_5_18 = arg_5_0:GetMGData()

			var_5_17.gold = var_9.getConfig(var_5_18, "config_data")[1]

			var_5_16(var_5_15, var_5_17)

			getProxy = var_5_16
			PlayerProxy = var_5_15

			local var_5_19 = var_5_16(var_5_15)

			var_6.updatePlayer(var_5_19, var_5)

			i18n = var_6

			local var_5_20 = var_6("tips_shrine_nobuff")

			arg_5_0:playAnime(var_5_20)
			arg_5_0:updateView()
			arg_5_0:updateWitchImg()
		end
	end

	return
end

function var_0_1.OnModifyMiniGameDataDone(arg_6_0, arg_6_1)
	arg_6_0:updateView()

	return
end

function var_0_1.willExit(arg_7_0)
	local var_7_0 = arg_7_0.shrineBuffView
	local var_7_1 = var_1.CheckState

	BaseSubView = var_1_10003

	if var_7_1(var_7_0, var_1_10003.STATES.INITED) then
		local var_7_2 = arg_7_0.shrineBuffView

		var_1.Destroy(var_7_2)
	end

	local var_7_3 = arg_7_0.shrineResultView
	local var_7_4 = var_1.CheckState

	BaseSubView = var_3

	if var_7_4(var_7_3, var_3.STATES.INITED) then
		local var_7_5 = arg_7_0.shrineResultView

		var_1.Destroy(var_7_5)
	end

	arg_7_0.spineAnim = nil

	if arg_7_0._buffTextTimer then
		local var_7_6 = arg_7_0._buffTextTimer

		var_1.Stop(var_7_6)
	end

	if arg_7_0._buffTimeCountDownTimer then
		local var_7_7 = arg_7_0._buffTimeCountDownTimer

		var_1.Stop(var_7_7)
	end

	if arg_7_0.ringSE then
		local var_7_8 = arg_7_0.ringSE

		var_1.Stop(var_7_8, true)
	end

	return
end

function var_0_1.initData(arg_8_0)
	arg_8_0.miniGameId = arg_8_0.contextData.miniGameId
	getProxy = var_1
	MiniGameProxy = var_1_10002

	local var_8_0 = var_1(var_1_10002)
	local var_8_1 = var_1.GetHubByGameId(var_8_0, arg_8_0.miniGameId)

	if not arg_8_0:isInitedMiniGameData() then
		local var_8_2 = arg_8_0
		local var_8_3 = arg_8_0.SendOperator

		MiniGameOPCommand = var_1_10005

		var_8_3(var_8_2, var_1_10005.CMD_SPECIAL_GAME, {
			arg_8_0.miniGameId,
			1
		})
	end

	local var_8_4 = {
		onSelect = function(arg_9_0)
			getProxy = var_2_10001
			PlayerProxy = var_2_10002

			local var_9_0 = var_2_10001(var_2_10002)
			local var_9_1 = var_1.getData(var_9_0)
			local var_9_2 = arg_8_0
			local var_9_3 = var_2.GetMGData(var_9_2)

			if var_2.getConfig(var_9_3, "config_data")[1] > var_9_1.gold then
				pg = var_4

				local var_9_4 = var_4.TipsMgr.GetInstance()
				local var_9_5 = var_4.ShowTips

				i18n = var_2_10006

				var_9_5(var_9_4, var_2_10006("common_no_resource"))

				return
			end

			local var_9_6 = arg_8_0
			local var_9_7 = var_4.GetMGData(var_9_6)

			if var_4.GetRuntimeData(var_9_7, "count") <= 0 then
				local var_9_8 = arg_8_0
				local var_9_9 = var_4.SendOperator

				MiniGameOPCommand = var_6

				var_9_9(var_9_8, var_6.CMD_SPECIAL_GAME, {
					arg_8_0.miniGameId,
					3
				})
			else
				local var_9_10 = arg_8_0
				local var_9_11 = var_4.GetMGData(var_9_10)
				local var_9_12 = var_4.getConfig(var_9_11, "config_data")[2][arg_9_0]
				local var_9_13 = arg_8_0
				local var_9_14 = var_5.SendOperator

				MiniGameOPCommand = var_2_10007

				var_9_14(var_9_13, var_2_10007.CMD_SPECIAL_GAME, {
					arg_8_0.miniGameId,
					2,
					var_9_12
				})
			end

			return
		end,
		onClose = function()
			arg_8_0.buffEffectAni.enabled = false

			local var_10_0 = arg_8_0.bgImg

			Color = var_1
			var_10_0.color = var_1.New(1, 1, 1)
			setActive = var_10_0

			var_10_0(arg_8_0.noAdaptPanel, true)

			setActive = var_10_0

			var_10_0(arg_8_0.cloudTF, true)

			setActive = var_10_0

			var_10_0(arg_8_0.witchImg, arg_8_0.activityWitch)

			return
		end
	}

	ShrineBuffView = var_4
	arg_8_0.shrineBuffView = var_4.New(arg_8_0._tf.parent, arg_8_0.event, var_8_4)
	ShrineResultView = var_4
	arg_8_0.shrineResultView = var_4.New(arg_8_0._tf, arg_8_0.event)

	return
end

function var_0_1.findUI(arg_11_0)
	local var_11_0 = arg_11_0._tf

	arg_11_0.noAdaptPanel = var_1.Find(var_11_0, "noAdaptPanel")

	local var_11_1 = arg_11_0.noAdaptPanel

	arg_11_0.buffTF = var_1.Find(var_11_1, "Buff")

	local var_11_2 = arg_11_0.buffTF

	arg_11_0.buffImg = var_1.Find(var_11_2, "BuffTypeImg")
	GetComponent = var_1
	arg_11_0.buffEffectAni = var_1(arg_11_0.buffImg, "Animator")

	local var_11_3 = arg_11_0.buffTF

	arg_11_0.buffText = var_1.Find(var_11_3, "BuffText")
	GetComponent = var_1
	arg_11_0.buffDftAniEvent = var_1(arg_11_0.buffImg, "DftAniEvent")

	local var_11_4 = arg_11_0._tf
	local var_11_5 = var_1.Find(var_11_4, "BGImg")
	local var_11_6 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_11_0.bgImg = var_11_6(var_11_5, var_3(var_1_10004))

	local var_11_7 = arg_11_0.bgImg

	Color = var_11_5
	var_11_7.color = var_11_5.New(1, 1, 1)

	local var_11_8 = arg_11_0._tf

	arg_11_0.cloudTF = var_1.Find(var_11_8, "BG/cloud")

	local var_11_9 = arg_11_0.noAdaptPanel

	arg_11_0.topTF = var_1.Find(var_11_9, "Top")
	arg_11_0.backBtn = var_1:Find("BackBtn")
	arg_11_0.helpBtn = var_1:Find("HelpBtn")
	arg_11_0.timesText = var_1:Find("Times/Text")
	arg_11_0.goldText = var_1:Find("Gold/Text")

	local var_11_10 = arg_11_0._tf
	local var_11_11 = var_2.Find(var_11_10, "Main")

	arg_11_0.witchImg = var_2.Find(var_11_11, "Witch")
	arg_11_0.rope = var_2:Find("Rope")
	GetComponent = var_3
	arg_11_0.spineAnim = var_3(arg_11_0.rope, "SpineAnimUI")
	GetComponent = var_3
	arg_11_0.press = var_3(arg_11_0.rope, "EventTriggerListener")

	return
end

function var_0_1.addListener(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.backBtn

	local function var_12_2()
		local var_13_0 = arg_12_0

		var_0.onBackPressed(var_13_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_12_0, var_12_1, var_12_2, var_1_10005)

	onButton = var_1_10001

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.helpBtn

	local function var_12_5()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_14_2.type = var_2_10003
		pg = var_2_10003
		var_14_2.helps = var_2_10003.gametip.help_newyear_shrine.tip

		var_14_1(var_14_0, var_14_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_12_3, var_12_4, var_12_5, var_1_10005)

	onButton = var_1_10001

	var_1_10001(arg_12_0, arg_12_0.rope, function()
		local var_15_0 = arg_12_0.bgImg

		Color = var_2_10001
		var_15_0.color = var_2_10001.New(0, 0, 0)
		setActive = var_15_0

		var_15_0(arg_12_0.noAdaptPanel, false)

		setActive = var_15_0

		var_15_0(arg_12_0.cloudTF, false)

		setActive = var_15_0

		var_15_0(arg_12_0.witchImg, false)

		local var_15_1 = arg_12_0.shrineBuffView

		var_0.Reset(var_15_1)

		local var_15_2 = arg_12_0.shrineBuffView

		var_0.Load(var_15_2)

		return
	end)

	onButton = var_1_10001

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.buffImg

	local function var_12_8()
		local var_16_0 = arg_12_0

		var_0.updateBuffDesc(var_16_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_12_6, var_12_7, var_12_8, var_1_10005)

	local var_12_9 = arg_12_0.buffDftAniEvent

	var_1.SetStartEvent(var_12_9, function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_12_0.rope, false)

		return
	end)

	local var_12_10 = arg_12_0.buffDftAniEvent

	var_1.SetEndEvent(var_12_10, function()
		setButtonEnabled = var_2_10000

		var_2_10000(arg_12_0.rope, true)

		return
	end)

	return
end

function var_0_1.playAnime(arg_19_0, arg_19_1, arg_19_2)
	setButtonEnabled = var_1_10003

	var_1_10003(arg_19_0.rope, false)

	pg = var_1_10003

	local var_19_0 = var_1_10003.CriMgr.GetInstance()

	arg_19_0.ringSE = var_3.PlaySE_V3(var_19_0, "ui-shensheling")

	if arg_19_0.spineAnim then
		local var_19_1 = arg_19_0.spineAnim

		var_3.SetAction(var_19_1, "action", 0)

		local var_19_2 = arg_19_0.spineAnim

		var_3.SetActionCallBack(var_19_2, function(arg_20_0)
			if arg_20_0 == "finish" then
				local var_20_0 = arg_19_0.spineAnim

				var_1.SetActionCallBack(var_20_0, nil)

				if arg_19_0.ringSE then
					local var_20_1 = arg_19_0.ringSE

					var_1.Stop(var_20_1, true)
				end

				local var_20_2 = arg_19_0.shrineResultView

				var_1.Reset(var_20_2)

				local var_20_3 = arg_19_0.shrineResultView

				var_1.Load(var_20_3)

				local var_20_4 = arg_19_0.shrineResultView

				var_1.ActionInvoke(var_20_4, "updateView", arg_19_1, arg_19_2)

				local var_20_5 = arg_19_0.shrineResultView

				var_1.ActionInvoke(var_20_5, "setCloseFunc", function()
					local var_21_1

					if arg_19_2 then
						local var_21_0 = arg_19_0

						var_21_1.updateBuff(var_21_0)

						var_21_1 = arg_19_0.buffEffectAni
						var_21_1.enabled = true
					end

					setButtonEnabled = var_21_1

					var_21_1(arg_19_0.rope, true)

					return
				end)

				local var_20_6 = arg_19_0.spineAnim

				var_1.SetAction(var_20_6, "normal", 0)
			end

			return
		end)
	end

	return
end

function var_0_1.updateView(arg_22_0)
	if not arg_22_0:isInitedMiniGameData() then
		return
	end

	local var_22_0 = arg_22_0:GetMGData()
	local var_22_1 = var_1.GetRuntimeData(var_22_0, "count")

	setText = var_22_0

	var_22_0(arg_22_0.timesText, var_22_1)

	getProxy = var_22_0
	PlayerProxy = var_3

	local var_22_2 = var_22_0(var_3)
	local var_22_3 = var_2.getData(var_22_2).gold

	setText = var_4

	var_4(arg_22_0.goldText, var_22_3)

	return
end

function var_0_1.updateBuff(arg_23_0, arg_23_1)
	if arg_23_1 then
		setImageSprite = var_1_10002
		var_1_10003 = arg_23_0.buffImg
		GetSpriteFromAtlas = var_1_10004

		var_1_10002(var_1_10003, var_1_10004("ui/shrineui_atlas", "buff_type_" .. arg_23_1))

		setActive = var_1_10002

		var_1_10002(arg_23_0.buffImg, true)
	else
		getProxy = var_1_10002
		PlayerProxy = var_1_10003

		local var_23_0 = var_1_10002(var_1_10003)
		local var_23_1 = var_2.getData(var_23_0)
		local var_23_2 = arg_23_0:GetMGData()
		local var_23_3 = var_3.getConfig(var_23_2, "config_data")[2]
		local var_23_4

		ipairs = var_5

		for iter_23_0, iter_23_1 in var_5(var_23_1.buff_list) do
			table = var_1_10010

			if var_1_10010.indexof(var_23_3, iter_23_1.id, 1) then
				pg = var_1_10010

				local var_23_5 = var_1_10010.TimeMgr.GetInstance()

				if var_1_10010.GetServerTime(var_23_5) < iter_23_1.timestamp then
					setImageSprite = var_12

					local var_23_6 = arg_23_0.buffImg

					GetSpriteFromAtlas = var_1_10014

					var_12(var_23_6, var_1_10014("ui/shrineui_atlas", "buff_type_" .. var_23_4))

					setActive = var_12

					var_12(arg_23_0.buffImg, true)

					break
				end

				var_23_4 = nil

				break
			end
		end

		if not var_23_4 then
			setActive = var_5

			var_5(arg_23_0.buffImg, false)
		end
	end

	return
end

function var_0_1.updateBuffDesc(arg_24_0)
	local var_24_0

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_24_1 = var_1_10002(var_1_10003)
	local var_24_2 = var_2.getActivityByType

	ActivityConst = var_1_10004

	if var_24_2(var_24_1, var_1_10004.ACTIVITY_TYPE_MINIGAME) and not var_2:isEnd() then
		local var_24_3 = arg_24_0:GetMGData()
		local var_24_4 = var_3.getConfig(var_24_3, "config_data")[2]

		getProxy = var_24_3
		PlayerProxy = var_5

		local var_24_5 = var_24_3(var_5)
		local var_24_6 = var_4.getData(var_24_5)

		pairs = var_24_5

		for iter_24_0, iter_24_1 in var_24_5(var_24_6.buff_list) do
			table = var_1_10010

			if var_1_10010.contains(var_24_4, iter_24_1.id) then
				ActivityBuff = var_1_10010
				var_24_0 = var_1_10010.New(var_2.id, iter_24_1.id, iter_24_1.timestamp)

				break
			end
		end
	end

	if arg_24_0._buffTimeCountDownTimer then
		local var_24_7 = arg_24_0._buffTimeCountDownTimer

		var_3.Stop(var_24_7)
	end

	if arg_24_0._buffTextTimer then
		local var_24_8 = arg_24_0._buffTextTimer

		var_3.Stop(var_24_8)
	end

	local var_24_9 = var_24_0:getConfig("desc")
	local var_24_10 = var_24_0:getConfig("max_time")
	local var_24_12

	if 0 < var_24_10 then
		pg = var_24_12

		local var_24_11 = var_24_12.TimeMgr.GetInstance()

		var_24_12 = var_24_12.GetServerTime(var_24_11)

		if var_24_0.timestamp then
			local var_24_13 = var_6 - var_24_12

			pg = iter_24_0

			local var_24_14 = iter_24_0.TimeMgr.GetInstance()
			local var_24_15 = var_8.DescCDTime(var_24_14, var_24_13)

			setText = var_24_14

			local var_24_16 = arg_24_0.buffText
			local var_24_17 = var_10.Find(var_24_16, "Text")

			string = var_24_16

			var_24_14(var_24_17, var_24_16.gsub(var_24_9, "$" .. 1, var_24_15))

			Timer = var_24_14
			arg_24_0._buffTimeCountDownTimer = var_24_14.New(function()
				if var_24_13 > 0 then
					var_24_13 = var_24_13 - 1
					pg = var_0

					local var_25_0 = var_0.TimeMgr.GetInstance()
					local var_25_1 = var_0.DescCDTime(var_25_0, var_24_13)

					setText = var_25_0

					local var_25_2 = arg_24_0.buffText
					local var_25_3 = var_2.Find(var_25_2, "Text")

					string = var_25_2

					var_25_0(var_25_3, var_25_2.gsub(var_24_9, "$" .. 1, var_25_1))
				else
					local var_25_4 = arg_24_0._buffTimeCountDownTimer

					var_0.Stop(var_25_4)

					setActive = var_0

					var_0(arg_24_0.buffText, false)

					setActive = var_0

					var_0(arg_24_0.buffImg, false)
				end

				return
			end, 1, -1)
			setActive = var_9

			var_9(arg_24_0.buffText, true)

			local var_24_18 = arg_24_0._buffTimeCountDownTimer

			var_9.Start(var_24_18)
		end
	end

	Timer = var_24_12
	arg_24_0._buffTextTimer = var_24_12.New(function()
		setActive = var_2_10000

		var_2_10000(arg_24_0.buffText, false)

		local var_26_0 = arg_24_0._buffTimeCountDownTimer

		var_0.Stop(var_26_0)

		return
	end, 7, 1)

	local var_24_19 = arg_24_0._buffTextTimer

	var_5.Start(var_24_19)

	return
end

function var_0_1.updateWitchImg(arg_27_0)
	arg_27_0.activityWitch = false

	if not arg_27_0:isInitedMiniGameData() then
		return
	end

	local var_27_0 = arg_27_0:GetMGData()
	local var_27_1 = var_1.GetRuntimeData(var_27_0, "serverGold")
	local var_27_2 = arg_27_0:GetMGData()

	if var_27_1 >= var_2.getConfig(var_27_2, "simple_config_data").target then
		arg_27_0.activityWitch = true
		setActive = var_3

		var_3(arg_27_0.witchImg, true)
	end

	return
end

function var_0_1.isInitedMiniGameData(arg_28_0)
	local var_28_0 = arg_28_0:GetMGData()

	if not var_1.GetRuntimeData(var_28_0, "isInited") then
		return false
	else
		return true
	end

	return
end

return var_0_1
