class = var_0_10000

local var_0_0 = var_0_10000("CommanderBoxCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._parent = arg_1_1
	arg_1_0._tf = arg_1_2
	go = var_1_10003
	arg_1_0._go = var_1_10003(arg_1_2)

	local var_1_0 = arg_1_0._tf

	arg_1_0.startingTF = var_3.Find(var_1_0, "ongoing")

	local var_1_1 = arg_1_0._tf

	arg_1_0.idleTF = var_3.Find(var_1_1, "idle")

	local var_1_2 = arg_1_0._tf

	arg_1_0.waitTF = var_3.Find(var_1_2, "wait")

	local var_1_3 = arg_1_0.startingTF
	local var_1_4 = var_3.Find(var_1_3, "time/Text")
	local var_1_5 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008
	arg_1_0.timerTxt = var_1_5(var_1_4, var_6(var_1_10008))

	local var_1_6 = arg_1_0.startingTF

	arg_1_0.slider = var_3.Find(var_1_6, "slider/bar")

	local var_1_7 = arg_1_0._tf

	arg_1_0.boxParent = var_3.Find(var_1_7, "char")

	local var_1_8 = arg_1_0.startingTF

	arg_1_0.titleStarting = var_3.Find(var_1_8, "title_starting")

	local var_1_9 = arg_1_0.startingTF

	arg_1_0.titleFinish = var_3.Find(var_1_9, "title_finish")

	local var_1_10 = arg_1_0.startingTF

	arg_1_0.quicklyTool = var_3.Find(var_1_10, "quickly_tool")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.boxVO = arg_2_1

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.getState(var_2_0)

	arg_2_0:removeTimer()
	arg_2_0:removeWaitingTimer()

	removeOnButton = var_3

	var_3(arg_2_0._tf)

	CommanderBox = var_3

	local var_2_2

	if var_2_1 == var_3.STATE_EMPTY then
		-- block empty
	else
		CommanderBox = var_2_2

		if var_2_1 == var_2_2.STATE_WAITING then
			var_2_2 = arg_2_1.beginTime
			pg = var_2_0
			var_1_10006 = var_2_0.TimeMgr.GetInstance()
			var_2_2 = var_2_2 - var_4.GetServerTime(var_1_10006)
			Timer = var_4
			arg_2_0.waitTimer = var_4.New(function()
				local var_3_0 = arg_2_0

				var_0.removeWaitingTimer(var_3_0)

				local var_3_1 = arg_2_0

				var_0.Update(var_3_1, arg_2_1)

				local var_3_2 = arg_2_0._parent

				var_0.updateCntLabel(var_3_2)

				return
			end, var_2_2, 1)
			var_1_10006 = arg_2_0.waitTimer

			var_4.Start(var_1_10006)
		else
			CommanderBox = var_2_2

			if var_2_1 == var_2_2.STATE_STARTING then
				local var_2_3 = arg_2_1
				local var_2_4 = arg_2_1.getFinishTime(var_2_3) - arg_2_1.beginTime

				Timer = var_2_3
				arg_2_0.timer = var_2_3.New(function()
					pg = var_2_10000

					local var_4_0 = var_2_10000.TimeMgr.GetInstance()
					local var_4_1 = var_0.GetServerTime(var_4_0)

					if var_2_2 - var_4_1 <= 0 then
						local var_4_2 = arg_2_0

						var_2.removeTimer(var_4_2)

						local var_4_3 = arg_2_0

						var_2.Update(var_4_3, arg_2_1)
					else
						local var_4_4 = arg_2_0.timerTxt

						pg = var_2_10003

						local var_4_5 = var_2_10003.TimeMgr.GetInstance()

						var_4_4.text = var_3.DescCDTime(var_4_5, var_1)
						setFillAmount = var_4_4

						var_4_4(arg_2_0.slider, 1 - var_1 / var_2_4)
					end

					return
				end, 1, -1)

				local var_2_5 = arg_2_0.timer

				var_5.Start(var_2_5)
				arg_2_0.timer.func()

				onButton = var_5

				local var_2_6 = arg_2_0._parent

				var_1_10008 = arg_2_0.quicklyTool

				local function var_2_7()
					local var_5_0 = arg_2_0._parent
					local var_5_1 = var_0.emit

					CommanderCatScene = var_2_10003

					var_5_1(var_5_0, var_2_10003.EVENT_QUICKLY_TOOL, arg_2_1.id)

					return
				end

				SFX_PANEL = var_1_10010

				var_5(var_2_6, var_1_10008, var_2_7, var_1_10010)
			else
				CommanderBox = var_2_2

				if var_2_1 == var_2_2.STATE_FINISHED then
					var_2_2 = arg_2_0.timerTxt
					var_2_2.text = "COMPLETE"
					setFillAmount = var_2_2

					var_2_2(arg_2_0.slider, 1)

					onButton = var_2_2

					local var_2_8 = arg_2_0._parent

					var_1_10006 = arg_2_0._tf

					local function var_2_9()
						getProxy = var_2_10000
						CommanderProxy = var_2_10002

						local var_6_0 = var_2_10000(var_2_10002)

						getProxy = var_2_10001
						PlayerProxy = var_2_10003

						local var_6_1 = var_2_10001(var_2_10003)
						local var_6_2 = var_1.getData(var_6_1).commanderBagMax
						local var_6_3 = var_6_0

						if var_6_2 <= var_6_0.getCommanderCnt(var_6_3) then
							pg = var_6_2

							local var_6_4 = var_6_2.TipsMgr.GetInstance()
							local var_6_5 = var_2.ShowTips

							i18n = var_6_3

							var_6_5(var_6_4, var_6_3("commander_capcity_is_max"))

							return
						end

						local var_6_6 = arg_2_0._parent
						local var_6_7 = var_2.emit

						CommanderCatMediator = var_6_3

						var_6_7(var_6_6, var_6_3.GET, arg_2_1.id)

						return
					end

					SFX_PANEL = var_1_10008

					var_2_2(var_2_8, var_1_10006, var_2_9, var_1_10008)
				end
			end
		end
	end

	setActive = var_2_2

	local var_2_10 = arg_2_0.quicklyTool

	CommanderBox = var_1_10006

	local var_2_11

	if var_2_1 == var_1_10006.STATE_STARTING then
		LOCK_CATTERY = var_6
		var_2_11 = not var_6
	else
		var_2_11 = false
	end

	if false then
		var_2_11 = true
	end

	var_2_2(var_2_10, var_2_11)

	setActive = var_2_2

	local var_2_12 = arg_2_0.titleStarting

	CommanderBox = var_2_11

	var_2_2(var_2_12, var_2_1 == var_2_11.STATE_STARTING)

	setActive = var_2_2

	local var_2_13 = arg_2_0.titleFinish

	CommanderBox = var_6

	var_2_2(var_2_13, var_2_1 == var_6.STATE_FINISHED)

	setActive = var_2_2

	local var_2_14 = arg_2_0.startingTF

	CommanderBox = var_6

	local var_2_15

	if var_2_1 ~= var_6.STATE_STARTING then
		CommanderBox = var_6

		if var_2_1 ~= var_6.STATE_FINISHED then
			var_2_15 = false

			goto label_2_0
		end
	end

	var_2_15 = true

	::label_2_0::

	var_2_2(var_2_14, var_2_15)

	setActive = var_2_2

	local var_2_16 = arg_2_0.idleTF

	CommanderBox = var_2_15

	var_2_2(var_2_16, var_2_1 == var_2_15.STATE_EMPTY)

	setActive = var_2_2

	local var_2_17 = arg_2_0.waitTF

	CommanderBox = var_6

	var_2_2(var_2_17, var_2_1 == var_6.STATE_WAITING)

	local var_2_18 = arg_2_1:getPrefab()

	arg_2_0:loadBox(var_2_18, arg_2_0.boxParent)

	return
end

local var_0_1 = true

function var_0_0.playAnim(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.loadBox
	local var_7_2 = arg_7_0.boxVO

	var_7_1(var_7_0, var_5.getFetchPrefab(var_7_2), arg_7_0.boxParent, function(arg_8_0)
		arg_7_0.spineAnimUI = arg_8_0

		arg_8_0:SetActionCallBack(function(arg_9_0)
			if arg_9_0 == "finish" then
				local var_9_0 = arg_8_0

				var_1.SetActionCallBack(var_9_0, nil)
				arg_7_1()
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.loadBox(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		arg_10_0:returnChar()
	else
		if arg_10_0.prefabName == arg_10_1 then
			return
		end

		arg_10_0:returnChar()

		arg_10_0.prefabName = arg_10_1

		local var_10_0 = arg_10_1

		PoolMgr = var_1_10005

		local var_10_1 = var_1_10005.GetInstance()

		var_5.GetSpineChar(var_10_1, var_10_0, true, function(arg_11_0)
			if arg_10_0.exited or var_10_0 ~= arg_10_0.prefabName then
				PoolMgr = var_1

				local var_11_0 = var_1.GetInstance()

				var_1.ReturnSpineChar(var_11_0, var_10_0, arg_11_0)

				return
			end

			local var_11_1 = arg_10_0

			tf = var_2_10002
			var_11_1.modelTf = var_2_10002(arg_11_0)

			local var_11_2 = arg_10_0.modelTf

			Vector3 = var_2
			var_11_2.localScale = var_2(0.7, 0.7, 1)

			local var_11_3 = arg_10_0.modelTf

			Vector3 = var_2
			var_11_3.localPosition = var_2(0, -123, 0)
			pg = var_11_3

			local var_11_4 = var_11_3.ViewUtils.SetLayer
			local var_11_5 = arg_10_0.modelTf

			Layer = var_4

			var_11_4(var_11_5, var_4.UI)

			setParent = var_11_4

			var_11_4(arg_10_0.modelTf, arg_10_2)

			local var_11_6 = arg_11_0:GetComponent("SpineAnimUI")

			var_1.SetAction(var_11_6, "normal", 0)

			if arg_10_3 then
				arg_10_3(var_1)
			end

			return
		end)
	end

	return
end

function var_0_0.removeTimer(arg_12_0)
	if arg_12_0.timer then
		local var_12_0 = arg_12_0.timer

		var_1.Stop(var_12_0)

		arg_12_0.timer = nil
	end

	return
end

function var_0_0.removeWaitingTimer(arg_13_0)
	if arg_13_0.waitTimer then
		local var_13_0 = arg_13_0.waitTimer

		var_1.Stop(var_13_0)

		arg_13_0.waitTimer = nil
	end

	return
end

function var_0_0.returnChar(arg_14_0)
	if arg_14_0.modelTf and arg_14_0.prefabName then
		PoolMgr = var_1

		local var_14_0 = var_1.GetInstance()

		var_1.ReturnSpineChar(var_14_0, arg_14_0.prefabName, arg_14_0.modelTf.gameObject)

		arg_14_0.modelTf = nil
		arg_14_0.prefabName = nil
	end

	return
end

function var_0_0.Clear(arg_15_0)
	arg_15_0:removeTimer()
	arg_15_0:removeWaitingTimer()

	removeOnButton = var_1

	var_1(arg_15_0._tf)

	arg_15_0.boxVO = nil

	return
end

function var_0_0.Destroy(arg_16_0)
	arg_16_0:Clear()
	arg_16_0:returnChar()

	arg_16_0.exited = true
	arg_16_0.boxVO = nil
	arg_16_0.loading = nil

	return
end

return var_0_0
