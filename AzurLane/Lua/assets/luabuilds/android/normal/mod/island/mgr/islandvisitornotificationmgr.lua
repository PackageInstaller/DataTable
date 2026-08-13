pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
singletonClass = pg

local var_0_1 = var_0("IslandVisitorNotificationMgr")

pg = var_1
var_1.IslandVisitorNotificationMgr = var_0_1

local var_0_2 = 5

function var_0_1.Init(arg_1_0, arg_1_1)
	arg_1_0.schedule = {}
	LoadAndInstantiateAsync = var_2

	var_2("ui", "IslandVisitorNotificationUI", function(arg_2_0)
		local var_2_0 = arg_1_0

		GameObject = var_2_10002
		var_2_0.UIOverlay = var_2_10002.Find("Overlay/UIOverlay")

		local var_2_1 = arg_2_0.transform

		var_1.SetParent(var_2_1, arg_1_0.UIOverlay.transform, false)

		arg_1_0._tf = arg_2_0.transform

		local var_2_2 = arg_1_0
		local var_2_3 = arg_2_0.transform
		local var_2_4 = var_2.Find(var_2_3, "Text")
		local var_2_5 = var_2.GetComponent

		typeof = var_4
		Text = var_2_10005
		var_2_2.contentTxt = var_2_5(var_2_4, var_4(var_2_10005))
		setActive = var_2_2

		var_2_2(arg_2_0, false)
		arg_1_1()

		return
	end, true, true)

	return
end

function var_0_1.Enqueue(arg_3_0, arg_3_1)
	PlayerPrefs = var_1_10002

	local var_3_0 = var_1_10002.GetInt

	ISLAND_NOTIFYCATION = var_1_10003

	if var_3_0(var_1_10003, 0) <= 0 then
		return
	end

	table = var_2

	var_2.insert(arg_3_0.schedule, arg_3_1)

	if #arg_3_0.schedule == 1 then
		arg_3_0:StartTask()
	end

	return
end

function var_0_1.StartTask(arg_4_0)
	local var_4_0 = arg_4_0.schedule[1]

	arg_4_0:ShowContent(var_4_0, function()
		table = var_2_10000

		var_2_10000.remove(arg_4_0.schedule, 1)

		if #arg_4_0.schedule > 0 then
			local var_5_0 = arg_4_0

			var_0.StartTask(var_5_0)
		end

		return
	end)

	return
end

function var_0_1.ShowContent(arg_6_0, arg_6_1, arg_6_2)
	setActive = var_1_10003

	var_1_10003(arg_6_0._tf, true)

	arg_6_0.contentTxt.text = arg_6_1:BuildWhitoutTime()

	arg_6_0:RemoveTimer()

	Timer = var_3

	local var_6_0 = var_3.New(function()
		local var_7_0 = arg_6_0

		var_0.RemoveTimer(var_7_0)

		local var_7_1 = arg_6_0

		var_0.HideContent(var_7_1)
		arg_6_2()

		return
	end, var_0_2, 1)

	var_3.Start(var_6_0)

	arg_6_0.timer = var_3

	return
end

function var_0_1.HideContent(arg_8_0)
	local var_8_0 = arg_8_0.contentTxt

	var_8_0.text = ""
	setActive = var_8_0

	var_8_0(arg_8_0._tf, false)

	return
end

function var_0_1.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		local var_9_0 = arg_9_0.timer

		var_1.Stop(var_9_0)

		arg_9_0.timer = nil
	end

	return
end

function var_0_1.Quit(arg_10_0)
	arg_10_0:RemoveTimer()
	arg_10_0:HideContent()

	arg_10_0.schedule = {}

	return
end

return
