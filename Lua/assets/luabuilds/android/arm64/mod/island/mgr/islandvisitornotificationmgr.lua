pg = pg or {}

local var_0_0 = singletonClass("IslandVisitorNotificationMgr")

pg.IslandVisitorNotificationMgr = var_0_0

local var_0_1 = 5

function var_0_0.Init(arg_1_0, arg_1_1)
	arg_1_0.schedule = {}

	LoadAndInstantiateAsync("ui", "IslandVisitorNotificationUI", function(arg_2_0)
		arg_1_0.UIOverlay = GameObject.Find("Overlay/UIOverlay")

		arg_2_0.transform:SetParent(arg_1_0.UIOverlay.transform, false)

		arg_1_0._tf = arg_2_0.transform
		arg_1_0.contentTxt = arg_2_0.transform:Find("Text"):GetComponent(typeof(Text))

		setActive(arg_2_0, false)
		arg_1_1()

		return
	end, true, true)

	return
end

function var_0_0.Enqueue(arg_3_0, arg_3_1)
	if PlayerPrefs.GetInt(ISLAND_NOTIFYCATION, 0) <= 0 then
		return
	end

	table.insert(arg_3_0.schedule, arg_3_1)

	if #arg_3_0.schedule == 1 then
		arg_3_0:StartTask()
	end

	return
end

function var_0_0.StartTask(arg_4_0)
	arg_4_0:ShowContent(arg_4_0.schedule[1], function()
		table.remove(arg_4_0.schedule, 1)

		if #arg_4_0.schedule > 0 then
			arg_4_0:StartTask()
		end

		return
	end)

	return
end

function var_0_0.ShowContent(arg_6_0, arg_6_1, arg_6_2)
	setActive(arg_6_0._tf, true)

	arg_6_0.contentTxt.text = arg_6_1:BuildWhitoutTime()

	arg_6_0:RemoveTimer()

	local var_6_0 = Timer.New(function()
		arg_6_0:RemoveTimer()
		arg_6_0:HideContent()
		arg_6_2()

		return
	end, var_0_1, 1)

	var_6_0:Start()

	arg_6_0.timer = var_6_0

	return
end

function var_0_0.HideContent(arg_8_0)
	arg_8_0.contentTxt.text = ""

	setActive(arg_8_0._tf, false)

	return
end

function var_0_0.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		arg_9_0.timer:Stop()

		arg_9_0.timer = nil
	end

	return
end

function var_0_0.Quit(arg_10_0)
	arg_10_0:RemoveTimer()
	arg_10_0:HideContent()

	arg_10_0.schedule = {}

	return
end

return
