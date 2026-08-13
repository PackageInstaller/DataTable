class = var_0_10000

local var_0_0 = var_0_10000("GuildMemberCard")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	tf = var_1_10002
	arg_1_0.tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0.tf
	local var_1_1 = var_2.Find(var_1_0, "shipicon/icon")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.iconTF = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0.tf

	arg_1_0.starsTF = var_2.Find(var_1_3, "shipicon/stars")

	local var_1_4 = arg_1_0.tf

	arg_1_0.starTF = var_2.Find(var_1_4, "shipicon/stars/star")

	local var_1_5 = arg_1_0.tf
	local var_1_6 = var_2.Find(var_1_5, "level/Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.levelTF = var_1_7(var_1_6, var_5(var_1_10007))

	local var_1_8 = arg_1_0.tf
	local var_1_9 = var_2.Find(var_1_8, "name_bg/Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.nameTF = var_1_10(var_1_9, var_5(var_1_10007))

	local var_1_11 = arg_1_0.tf
	local var_1_12 = var_2.Find(var_1_11, "duty")
	local var_1_13 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.dutyTF = var_1_13(var_1_12, var_5(var_1_10007))

	local var_1_14 = arg_1_0.tf
	local var_1_15 = var_2.Find(var_1_14, "liveness/Text")
	local var_1_16 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.livenessTF = var_1_16(var_1_15, var_5(var_1_10007))

	local var_1_17 = arg_1_0.tf

	arg_1_0.onLine = var_2.Find(var_1_17, "online_tag")

	local var_1_18 = arg_1_0.tf

	arg_1_0.offLine = var_2.Find(var_1_18, "last_time")

	local var_1_19 = arg_1_0.tf

	arg_1_0.onLineLabel = var_2.Find(var_1_19, "online")

	local var_1_20 = arg_1_0.tf

	arg_1_0.offLineLabel = var_2.Find(var_1_20, "offline")

	local var_1_21 = arg_1_0.tf
	local var_1_22 = var_2.Find(var_1_21, "last_time/Text")
	local var_1_23 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.offLineText = var_1_23(var_1_22, var_5(var_1_10007))

	local var_1_24 = arg_1_0.tf

	arg_1_0.maskTF = var_2.Find(var_1_24, "mask")

	local var_1_25 = arg_1_0.tf
	local var_1_26 = var_2.Find(var_1_25, "mask/Text")
	local var_1_27 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.timerTF = var_1_27(var_1_26, var_5(var_1_10007))

	local var_1_28 = arg_1_0.tf

	arg_1_0.borderTF = var_2.Find(var_1_28, "selected")

	local var_1_29 = arg_1_0.tf

	arg_1_0.bg = var_2.Find(var_1_29, "bg")

	local var_1_30 = arg_1_0.tf

	arg_1_0.circle = var_2.Find(var_1_30, "shipicon/frame")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.memberVO = arg_2_1

	local var_2_0 = arg_2_0

	arg_2_0.Clear(var_2_0)

	pg = var_3

	local var_2_1 = var_3.ship_data_statistics[arg_2_1.icon]

	Ship = var_4

	local var_2_2 = var_4.New({
		configId = arg_2_1.icon,
		skin_id = arg_2_1.skinId,
		propose = arg_2_1.proposeTime
	})

	LoadSpriteAsync = var_2_0

	var_2_0("qicon/" .. var_2_2:getPainting(), function(arg_3_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_2_0.iconTF) then
			arg_2_0.iconTF.sprite = arg_3_0
		end

		return
	end)

	AttireFrame = var_2_0

	local var_2_3 = var_2_0.attireFrameRes
	local var_2_4 = arg_2_1
	local var_2_5 = arg_2_1.id

	getProxy = var_1_10009
	PlayerProxy = var_1_10011

	local var_2_6 = var_1_10009(var_1_10011)
	local var_2_7 = var_2_5 == var_9.getRawData(var_2_6).id

	AttireConst = var_9

	local var_2_8 = var_2_3(var_2_4, var_2_7, var_9.TYPE_ICON_FRAME, arg_2_1.propose)

	PoolMgr = var_6

	local var_2_9 = var_6.GetInstance()

	var_6.GetPrefab(var_2_9, "IconFrame/" .. var_2_8, var_2_8, true, function(arg_4_0)
		if arg_2_0.circle and not arg_2_0.exited then
			arg_4_0.name = var_2_8
			findTF = var_1

			local var_4_0 = var_1(arg_4_0.transform, "icon")
			local var_4_1 = var_1.GetComponent

			typeof = var_2_10005
			Image = var_2_10007
			var_4_1(var_4_0, var_2_10005(var_2_10007)).raycastTarget = false
			setParent = var_3

			var_3(arg_4_0, arg_2_0.circle, false)
		else
			PoolMgr = var_1

			local var_4_2 = var_1.GetInstance()

			var_1.ReturnPrefab(var_4_2, "IconFrame/" .. var_2_8, var_2_8, arg_4_0)
		end

		return
	end)

	GetSpriteFromAtlas = var_6

	local var_2_10 = var_6("dutyicon", arg_2_1.duty)

	arg_2_0.dutyTF.sprite = var_2_10

	for iter_2_0 = arg_2_0.starsTF.childCount, var_2_1.star - 1 do
		cloneTplTo = var_12

		var_12(arg_2_0.starTF, arg_2_0.starsTF)
	end

	for iter_2_1 = 1, var_7 do
		local var_2_11 = arg_2_0.starsTF
		local var_2_12 = var_12.GetChild(var_2_11, iter_2_1 - 1)

		setActive = var_1_10013

		var_1_10013(var_2_12, iter_2_1 <= var_2_1.star)
	end

	arg_2_0.levelTF.text = arg_2_1.level
	arg_2_0.nameTF.text = arg_2_1.name

	local var_2_13 = arg_2_0.livenessTF

	var_2_13.text = arg_2_1.liveness
	setActive = var_2_13

	var_2_13(arg_2_0.onLine, arg_2_1:isOnline())

	setActive = var_2_13

	var_2_13(arg_2_0.offLine, not arg_2_1:isOnline())

	setActive = var_2_13

	var_2_13(arg_2_0.onLineLabel, arg_2_1:isOnline())

	setActive = var_2_13

	var_2_13(arg_2_0.offLineLabel, not arg_2_1:isOnline())

	if not arg_2_1:isOnline() then
		local var_2_14 = arg_2_0.offLineText

		getOfflineTimeStamp = var_9
		var_2_14.text = var_9(arg_2_1.preOnLineTime)
	end

	local var_2_15 = arg_2_1.duty

	GuildConst = var_9

	local var_2_16 = var_2_15 == var_9.DUTY_COMMANDER and arg_2_2:inKickTime()

	setActive = var_9

	var_9(arg_2_0.maskTF, var_2_16)

	if var_2_16 then
		arg_2_0:AddTimer(function()
			local var_5_0 = arg_2_2

			if var_0.getKickLeftTime(var_5_0) > 0 then
				local var_5_1 = arg_2_0.timerTF

				pg = var_5_0

				local var_5_2 = var_5_0.TimeMgr.GetInstance()

				var_5_1.text = var_2.DescCDTime(var_5_2, var_0)
			else
				local var_5_3 = arg_2_0.timerTF

				var_5_3.text = ""
				setActive = var_5_3

				var_5_3(arg_2_0.maskTF, false)
			end

			return
		end)
	end

	return
end

function var_0_0.AddTimer(arg_6_0, arg_6_1)
	if arg_6_0.timer then
		local var_6_0 = arg_6_0.timer

		var_2.Stop(var_6_0)

		arg_6_0.timer = nil
	end

	Timer = var_2
	arg_6_0.timer = var_2.New(arg_6_1, 1, -1)

	local var_6_1 = arg_6_0.timer

	var_2.Start(var_6_1)
	arg_6_0.timer.func()

	return
end

function var_0_0.Clear(arg_7_0)
	if arg_7_0.circle.childCount > 0 then
		local var_7_0 = arg_7_0.circle
		local var_7_1 = var_1.GetChild(var_7_0, 0).gameObject.name

		PoolMgr = var_7_0

		local var_7_2 = var_7_0.GetInstance()

		var_3.ReturnPrefab(var_7_2, "IconFrame/" .. var_7_1, var_7_1, var_1.gameObject)
	end

	if arg_7_0.timer then
		local var_7_3 = arg_7_0.timer

		var_1.Stop(var_7_3)

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0.borderTF, arg_8_1)

	setActive = var_1_10002

	var_1_10002(arg_8_0.bg, not arg_8_1)

	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.exited = true

	arg_9_0:Clear()

	return
end

return var_0_0
