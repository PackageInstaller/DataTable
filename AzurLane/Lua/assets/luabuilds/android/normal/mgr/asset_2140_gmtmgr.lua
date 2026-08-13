pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.GMTMgr = var_0_10001("GMTMgr")
pg = var_0

local var_0_1 = var_0.GMTMgr

var_0_1.TYPE_DEFAULT_RES = 2
var_0_1.TYPE_L2D = 4
var_0_1.TYPE_PAINTING = 8
var_0_1.TYPE_CIPHER = 16

function var_0_1.Init(arg_1_0, arg_1_1)
	Timer = var_1_10002
	arg_1_0._gmtTimer = var_1_10002.New(function()
		local var_2_0 = arg_1_0

		var_0.onTimer(var_2_0)

		return
	end, 1, -1)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_1.initUI(arg_3_0, arg_3_1)
	if arg_3_0._go == nil then
		PoolMgr = var_2

		local var_3_0 = var_2.GetInstance()

		var_2.GetUI(var_3_0, "GMTUI", true, function(arg_4_0)
			arg_3_0._go = arg_4_0

			local var_4_0 = arg_3_0._go

			var_1.SetActive(var_4_0, false)

			local var_4_1 = arg_3_0

			findTF = var_4_0
			var_4_1._textTf = var_4_0(arg_3_0._go, "ad/text")
			GameObject = var_4_1

			local var_4_2 = var_4_1.Find("OverlayCamera/Overlay/UITop")
			local var_4_3 = arg_3_0._go.transform

			var_2.SetParent(var_4_3, var_4_2.transform, false)

			local var_4_4 = arg_3_0

			GetComponent = var_4_3

			local var_4_5 = arg_3_0._go

			typeof = var_5
			Animator = var_2_10006
			var_4_4._animator = var_4_3(var_4_5, var_5(var_2_10006))

			arg_3_1()

			return
		end)
	end

	return
end

function var_0_1.onTimer(arg_5_0)
	local var_5_0 = arg_5_0._gmtTime

	pg = var_1_10002

	local var_5_1 = var_1_10002.TimeMgr.GetInstance()

	arg_5_0._subTime = var_5_0 - var_2.GetServerTime(var_5_1)

	if arg_5_0._go == nil then
		arg_5_0:initUI(function()
			local var_6_0 = arg_5_0

			var_0.showTip(var_6_0)

			return
		end)
	else
		arg_5_0:showTip()
	end

	if arg_5_0._subTime < 0 and arg_5_0._gmtTimer.running then
		local var_5_2 = arg_5_0._gmtTimer

		var_1.Stop(var_5_2)

		local var_5_3 = arg_5_0._go

		var_1.SetActive(var_5_3, false)
	end

	return
end

function var_0_1.showGMT(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.gameset.maintenance_message.description

	Clone = var_1_10003
	arg_7_0._onceTime = var_1_10003(var_7_0[1])
	Clone = var_3
	arg_7_0._repeatTime = var_3(var_7_0[2])
	arg_7_0._gmtTime = arg_7_1

	if not arg_7_0._gmtTimer.running then
		local var_7_1 = arg_7_0._gmtTimer

		var_3.Start(var_7_1)
	end

	arg_7_0._triggerStop = false

	return
end

function var_0_1.showTip(arg_8_0)
	print = var_1_10001

	var_1_10001(arg_8_0._subTime)

	local var_8_0 = false

	if arg_8_0.focusShowTip then
		var_8_0 = true
		arg_8_0.focusShowTip = false
	end

	if arg_8_0._subTime <= arg_8_0._repeatTime then
		var_8_0 = true
	else
		for iter_8_0 = #arg_8_0._onceTime, 1, -1 do
			if arg_8_0._subTime <= arg_8_0._onceTime[iter_8_0] then
				table = var_6

				var_6.remove(arg_8_0._onceTime, iter_8_0)

				var_8_0 = true
			end
		end
	end

	if not var_8_0 then
		return
	end

	local var_8_1 = arg_8_0._go

	var_2.SetActive(var_8_1, false)

	local var_8_2 = arg_8_0._go

	var_2.SetActive(var_8_2, true)

	if arg_8_0._subTime > arg_8_0._repeatTime then
		local var_8_3 = arg_8_0._animator

		var_2.SetTrigger(var_8_3, "once")
	elseif not arg_8_0._triggerStop then
		arg_8_0._triggerStop = true

		local var_8_4 = arg_8_0._animator

		var_2.SetTrigger(var_8_4, "repeat")
	end

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0.getTimeTip(var_8_5)

	setText = var_8_5

	var_8_5(arg_8_0._textTf, var_8_6)

	return
end

function var_0_1.getTimeTip(arg_9_0)
	local var_9_0

	if arg_9_0._subTime > 0 then
		math = var_9_0
		var_9_0 = var_9_0.floor(arg_9_0._subTime / 16)
		math = var_2

		local var_9_1 = var_2.floor(arg_9_0._subTime / 60)
		local var_9_2 = arg_9_0._subTime % 60
		local var_9_3
		local var_9_4

		if 0 < var_9_0 then
			tostring = var_9_4
			var_9_4 = var_9_4(var_9_0)
			i18n = var_6
			var_9_3 = var_9_4 .. var_6("word_hour")
		elseif 0 < var_9_1 then
			tostring = var_9_4
			var_9_4 = var_9_4(var_9_1)
			i18n = var_6
			var_9_3 = var_9_4 .. var_6("word_minute")
		else
			tostring = var_9_4
			var_9_4 = var_9_4(var_9_2)
			i18n = var_6
			var_9_3 = var_9_4 .. var_6("word_second")
		end

		i18n = var_9_4

		return var_9_4("maintenance_message_text", var_9_3)
	end

	i18n = var_9_0

	return var_9_0("maintenance_message_stop_text")
end

return
