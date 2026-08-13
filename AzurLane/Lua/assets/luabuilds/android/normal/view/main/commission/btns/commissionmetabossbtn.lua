class = var_0_10000

local var_0_0 = var_0_10000("CommissionMetaBossBtn")

var_0_0.STATE_LOCK = 1
var_0_0.STATE_NORMAL = 2
var_0_0.STATE_AUTO_BATTLE = 3
var_0_0.STATE_FINSH_BATTLE = 4
var_0_0.STATE_GET_AWARDS = 5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	pg = var_1_10003

	var_1_10003.DelegateInfo.New(arg_1_0)

	arg_1_0.event = arg_1_2
	arg_1_0.tr = arg_1_1

	local var_1_0 = arg_1_0.tr
	local var_1_1 = var_3.Find(var_1_0, "Text")
	local var_1_2 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006
	arg_1_0.text = var_1_2(var_1_1, var_5(var_1_10006))

	local var_1_3 = arg_1_0.tr

	arg_1_0.tip = var_3.Find(var_1_3, "tip")

	local var_1_4 = arg_1_0.tr

	arg_1_0.timerIcon = var_3.Find(var_1_4, "timer")

	local var_1_5 = arg_1_0.tr

	arg_1_0.finishIcon = var_3.Find(var_1_5, "finish")

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.Flush(arg_3_0)
	local var_3_0 = arg_3_0:GetBossState()

	arg_3_0:RemoveTimer()

	arg_3_0.text.text = ""

	if var_0_0.STATE_AUTO_BATTLE == var_3_0 then
		arg_3_0:SetLeftTime()
	end

	setActive = var_2

	var_2(arg_3_0.timerIcon, var_0_0.STATE_AUTO_BATTLE == var_3_0)

	setActive = var_2

	var_2(arg_3_0.tip, var_0_0.STATE_GET_AWARDS == var_3_0 or var_0_0.STATE_FINSH_BATTLE == var_3_0)

	setActive = var_2

	var_2(arg_3_0.finishIcon, var_0_0.STATE_FINSH_BATTLE == var_3_0)

	setActive = var_2

	var_2(arg_3_0.tr, var_0_0.STATE_LOCK ~= var_3_0)

	onButton = var_2

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.tr

	local function var_3_3()
		if var_3_0 ~= var_0_0.STATE_LOCK then
			local var_4_0 = arg_3_0.event
			local var_4_1 = var_0.emit

			CommissionInfoMediator = var_2_10002

			var_4_1(var_4_0, var_2_10002.GO_META_BOSS)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_3_1, var_3_2, var_3_3, var_1_10006)

	return
end

function var_0_0.SetLeftTime(arg_5_0)
	arg_5_0:RemoveTimer()

	Timer = var_1
	arg_5_0.timer = var_1.New(function()
		WorldBossConst = var_2_10000

		if var_2_10000.GetAutoBattleLeftTime() <= 0 then
			var_2_10002 = arg_5_0

			var_1.Flush(var_2_10002)
		end

		local var_6_0 = arg_5_0.text

		pg = var_2_10002

		local var_6_1 = var_2_10002.TimeMgr.GetInstance()

		var_6_0.text = var_2.DescCDTimeForMinute(var_6_1, var_0)

		return
	end, 1, -1)

	local var_5_0 = arg_5_0.timer

	var_1.Start(var_5_0)
	arg_5_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.GetBossState(arg_8_0)
	WorldBossConst = var_1_10001

	return var_1_10001.GetCommissionSceneMetaBossBtnState()
end

function var_0_0.Dispose(arg_9_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_9_0)
	arg_9_0:RemoveTimer()

	return
end

return var_0_0
