class = var_0_10000

local var_0_0 = var_0_10000("AttireDescPanel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)
	findTF = var_2
	arg_1_0.icon = var_2(arg_1_0._tf, "icon")
	findTF = var_2
	arg_1_0.frame = var_2(arg_1_0._tf, "frame")
	findTF = var_2
	arg_1_0.chatContainer = var_2(arg_1_0._tf, "chatContainer")
	findTF = var_2
	arg_1_0.conditionTF = var_2(arg_1_0._tf, "condition")
	findTF = var_2

	local var_1_0 = var_2(arg_1_0._tf, "name/Text")
	local var_1_1 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.nameTxt = var_1_1(var_1_0, var_4(var_1_10005))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0._tf, "get_info/lock")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.stateTxt = var_1_3(var_1_2, var_4(var_1_10005))
	findTF = var_2

	local var_1_4 = var_2(arg_1_0._tf, "get_info/time")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.timeTxt = var_1_5(var_1_4, var_4(var_1_10005))
	findTF = var_2

	local var_1_6 = var_2(arg_1_0._tf, "condition/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.conditionTxt = var_1_7(var_1_6, var_4(var_1_10005))
	findTF = var_2
	arg_1_0.applyBtn = var_2(arg_1_0._tf, "apply_btn")
	findTF = var_2
	arg_1_0.applyingBtn = var_2(arg_1_0._tf, "applying_btn")
	findTF = var_2
	arg_1_0.getBtn = var_2(arg_1_0._tf, "get_btn")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0

	arg_2_0.UpdateIconDesc(var_2_0, arg_2_1, arg_2_2)

	local var_2_1 = arg_2_0.nameTxt

	HXSet = var_2_0

	local var_2_2 = var_2_0.hxLan
	local var_2_3 = arg_2_1

	var_2_1.text = var_2_2(arg_2_1.getConfig(var_2_3, "name"))

	local var_2_4 = arg_2_1

	if arg_2_1.isOwned(var_2_4) then
		i18n = var_2_4

		if not var_2_4("word_got") then
			i18n = var_2_4
			var_2_4 = var_2_4("word_not_get")
		end

		local var_2_5 = arg_2_0.stateTxt

		setColorStr = var_2_3
		var_2_5.text = var_2_3(var_2_4, var_3 and "#3DC6FFFF" or "#a5afdf")

		local var_2_6 = arg_2_1:expiredType()
		local var_2_7 = arg_2_0

		arg_2_0.RemoveTimer(var_2_7)

		if var_3 and var_2_6 then
			var_2_7 = arg_2_0

			arg_2_0.AddTimer(var_2_7, arg_2_1, arg_2_2)
		elseif var_3 and not var_2_6 then
			arg_2_0.timeTxt.text = ""
		elseif not var_3 then
			arg_2_0.timeTxt.text = ""
		end

		local var_2_8 = arg_2_0.conditionTxt

		HXSet = var_2_7
		var_2_8.text = var_2_7.hxLan(arg_2_1:getConfig("desc"))

		local var_2_9 = arg_2_1:getState()
		local var_2_10 = arg_2_2:getAttireByType(arg_2_1:getType()) == arg_2_1.id

		setActive = var_9

		local var_2_11 = arg_2_0.applyBtn

		AttireFrame = var_1_10011

		var_9(var_2_11, var_2_9 == var_1_10011.STATE_UNLOCK and not var_2_10)

		setActive = var_9

		local var_2_12 = arg_2_0.applyingBtn

		AttireFrame = var_11

		var_9(var_2_12, var_2_9 == var_11.STATE_UNLOCK and var_2_10)

		setActive = var_9

		local var_2_13 = arg_2_0.getBtn

		AttireFrame = var_11

		var_9(var_2_13, var_2_9 == var_11.STATE_LOCK)

		return
	end
end

function var_0_0.UpdateIconDesc(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.getType(var_3_0)

	AttireConst = var_3_0

	local var_3_2 = var_3_1 == var_3_0.TYPE_ICON_FRAME
	local var_3_3 = arg_3_1
	local var_3_4 = arg_3_1.getType(var_3_3)

	AttireConst = var_3_3

	local var_3_5 = var_3_4 == var_3_3.TYPE_CHAT_FRAME
	local var_3_6

	if arg_3_0.loadedIcon and arg_3_0.loadedIconTF then
		var_1_10006 = arg_3_0.loadedIcon
		var_3_6 = var_3_6.getIcon(var_1_10006)

		if var_3_5 then
			local var_3_7 = arg_3_0.loadedIconTF.transform
			local var_3_8 = var_1_10006.Find(var_3_7, "Text")

			var_1_10006 = var_1_10006.GetComponent
			typeof = var_8
			Text = var_1_10009
			var_1_10006 = var_1_10006(var_3_8, var_8(var_1_10009))
			var_1_10006.supportRichText = false
		end

		PoolMgr = var_1_10006

		local var_3_9 = var_1_10006.GetInstance()

		var_1_10006.ReturnPrefab(var_3_9, var_3_6, arg_3_0.loadedIcon.id, arg_3_0.loadedIconTF)
	end

	if var_3_2 then
		if not arg_3_0.startList then
			UIItemList = var_3_6
			var_3_6 = var_3_6.New
			findTF = var_1_10006

			local var_3_10 = var_1_10006(arg_3_0._tf, "stars")

			findTF = var_7
			arg_3_0.startList = var_3_6(var_3_10, var_7(arg_3_0._tf, "stars/tpl"))
		end

		local var_3_11 = arg_3_1

		var_3_6 = arg_3_1.getIcon(var_3_11)
		PoolMgr = var_3_11

		local var_3_12 = var_3_11.GetInstance()

		var_6.GetPrefab(var_3_12, var_3_6, arg_3_1:getConfig("id"), true, function(arg_4_0)
			arg_3_0.loadedIcon = arg_3_1

			local var_4_0 = arg_3_0

			var_4_0.loadedIconTF = arg_4_0
			setParent = var_4_0

			var_4_0(arg_4_0, arg_3_0.frame, false)

			return
		end)

		local var_3_13 = arg_3_2
		local var_3_14 = arg_3_2.GetFlagShip(var_3_13)

		LoadSpriteAsync = var_3_13

		var_3_13("qicon/" .. var_3_14:getPrefab(), function(arg_5_0)
			local var_5_0 = arg_3_0.icon
			local var_5_1 = var_1.GetComponent

			typeof = var_2_10003
			Image = var_2_10004
			var_5_1(var_5_0, var_2_10003(var_2_10004)).sprite = arg_5_0

			return
		end)

		local var_3_15 = arg_3_0.startList

		var_7.align(var_3_15, var_3_14:getStar())
	elseif var_3_5 then
		local var_3_16 = arg_3_1

		var_3_6 = arg_3_1.getIcon(var_3_16)
		PoolMgr = var_3_16

		local var_3_17 = var_3_16.GetInstance()

		var_6.GetPrefab(var_3_17, var_3_6, arg_3_1:getConfig("id") .. "_self", true, function(arg_6_0)
			arg_3_0.loadedIcon = arg_3_1

			local var_6_0 = arg_3_0

			var_6_0.loadedIconTF = arg_6_0
			setParent = var_6_0

			var_6_0(arg_6_0, arg_3_0.chatContainer, false)

			tf = var_6_0

			local var_6_1 = var_6_0(arg_6_0)

			Vector3 = var_2
			var_6_1.localPosition = var_2(0, 0, 0)
			findTF = var_6_1

			local var_6_2 = var_6_1(arg_6_0, "Text")
			local var_6_3 = var_1.GetComponent

			typeof = var_3
			Text = var_4

			local var_6_4 = var_6_3(var_6_2, var_3(var_4))

			var_6_4.supportRichText = true
			setText = var_6_4
			findTF = var_2

			local var_6_5 = var_2(arg_6_0, "Text")
			local var_6_6 = arg_3_1

			var_6_4(var_6_5, var_3.getConfig(var_6_6, "desc"))

			return
		end)
	end

	setActive = var_3_6

	var_3_6(arg_3_0.conditionTF, not var_3_5)

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getExpiredTime(var_7_0)

	Timer = var_7_0
	arg_7_0.timer = var_7_0.New(function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.TimeMgr.GetInstance()
		local var_8_1 = var_0.GetServerTime(var_8_0)

		if var_7_1 - var_8_1 > 0 then
			local var_8_2 = arg_7_0.timeTxt
			local var_8_3 = "/ "

			attireTimeStamp = var_2_10004
			var_8_2.text = var_8_3 .. var_2_10004(var_1)
		else
			local var_8_4 = arg_7_0

			var_2.Update(var_8_4, arg_7_1, arg_7_2)

			local var_8_5 = arg_7_0

			var_2.RemoveTimer(var_8_5)
		end

		return
	end, 1, -1)

	local var_7_2 = arg_7_0.timer

	var_4.Start(var_7_2)
	arg_7_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_9_0)
	if arg_9_0.timer then
		local var_9_0 = arg_9_0.timer

		var_1.Stop(var_9_0)

		arg_9_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveTimer()

	return
end

return var_0_0
