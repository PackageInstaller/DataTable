local var_0_0 = class("CommanderBoxCard")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._parent = arg_1_1
	arg_1_0._tf = arg_1_2
	arg_1_0._go = go(arg_1_2)
	arg_1_0.startingTF = arg_1_0._tf:Find("ongoing")
	arg_1_0.idleTF = arg_1_0._tf:Find("idle")
	arg_1_0.waitTF = arg_1_0._tf:Find("wait")
	arg_1_0.timerTxt = arg_1_0.startingTF:Find("time/Text"):GetComponent(typeof(Text))
	arg_1_0.slider = arg_1_0.startingTF:Find("slider/bar")
	arg_1_0.boxParent = arg_1_0._tf:Find("char")
	arg_1_0.titleStarting = arg_1_0.startingTF:Find("title_starting")
	arg_1_0.titleFinish = arg_1_0.startingTF:Find("title_finish")
	arg_1_0.quicklyTool = arg_1_0.startingTF:Find("quickly_tool")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	arg_2_0.boxVO = arg_2_1

	local var_2_0 = arg_2_1:getState()

	arg_2_0:removeTimer()
	arg_2_0:removeWaitingTimer()
	removeOnButton(arg_2_0._tf)

	if var_2_0 == CommanderBox.STATE_EMPTY then
		-- block empty
	elseif var_2_0 == CommanderBox.STATE_WAITING then
		arg_2_0.waitTimer = Timer.New(function()
			arg_2_0:removeWaitingTimer()
			arg_2_0:Update(arg_2_1)
			arg_2_0._parent:updateCntLabel()

			return
		end, arg_2_1.beginTime - pg.TimeMgr.GetInstance():GetServerTime(), 1)

		arg_2_0.waitTimer:Start()
	elseif var_2_0 == CommanderBox.STATE_STARTING then
		local var_2_1 = arg_2_1:getFinishTime() - arg_2_1.beginTime

		arg_2_0.timer = Timer.New(function()
			local var_4_0 = var_0 - pg.TimeMgr.GetInstance():GetServerTime()

			if var_4_0 <= 0 then
				arg_2_0:removeTimer()
				arg_2_0:Update(arg_2_1)
			else
				local var_4_1 = arg_2_0.timerTxt

				var_4_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_4_0)

				setFillAmount(arg_2_0.slider, 1 - var_4_0 / var_2_1)
			end

			return
		end, 1, -1)

		arg_2_0.timer:Start()
		arg_2_0.timer.func()
		onButton(arg_2_0._parent, arg_2_0.quicklyTool, function()
			arg_2_0._parent:emit(CommanderCatScene.EVENT_QUICKLY_TOOL, arg_2_1.id)

			return
		end, SFX_PANEL)
	elseif var_2_0 == CommanderBox.STATE_FINISHED then
		arg_2_0.timerTxt.text = "COMPLETE"

		setFillAmount(arg_2_0.slider, 1)
		onButton(arg_2_0._parent, arg_2_0._tf, function()
			if getProxy(PlayerProxy):getData().commanderBagMax <= getProxy(CommanderProxy):getCommanderCnt() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_capcity_is_max"))

				return
			end

			arg_2_0._parent:emit(CommanderCatMediator.GET, arg_2_1.id)

			return
		end, SFX_PANEL)
	end

	setActive(arg_2_0.quicklyTool, var_2_0 == CommanderBox.STATE_STARTING and not LOCK_CATTERY)
	setActive(arg_2_0.titleStarting, var_2_0 == CommanderBox.STATE_STARTING)
	setActive(arg_2_0.titleFinish, var_2_0 == CommanderBox.STATE_FINISHED)
	setActive(arg_2_0.startingTF, var_2_0 == CommanderBox.STATE_STARTING or var_2_0 == CommanderBox.STATE_FINISHED)
	setActive(arg_2_0.idleTF, var_2_0 == CommanderBox.STATE_EMPTY)
	setActive(arg_2_0.waitTF, var_2_0 == CommanderBox.STATE_WAITING)
	arg_2_0:loadBox(arg_2_1:getPrefab(), arg_2_0.boxParent)

	return
end

function var_0_0.playAnim(arg_7_0, arg_7_1)
	arg_7_0:loadBox(arg_7_0.boxVO:getFetchPrefab(), arg_7_0.boxParent, function(arg_8_0)
		arg_7_0.spineAnimUI = arg_8_0

		arg_8_0:SetActionCallBack(function(arg_9_0)
			if arg_9_0 == "finish" then
				arg_8_0:SetActionCallBack(nil)
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

		PoolMgr.GetInstance():GetSpineChar(arg_10_1, true, function(arg_11_0)
			if arg_10_0.exited or var_0 ~= arg_10_0.prefabName then
				PoolMgr.GetInstance():ReturnSpineChar(var_0, arg_11_0)

				return
			end

			arg_10_0.modelTf = tf(arg_11_0)
			arg_10_0.modelTf.localScale = Vector3(0.7, 0.7, 1)
			arg_10_0.modelTf.localPosition = Vector3(0, -123, 0)

			pg.ViewUtils.SetLayer(arg_10_0.modelTf, Layer.UI)
			setParent(arg_10_0.modelTf, arg_10_2)

			local var_11_0 = arg_11_0:GetComponent("SpineAnimUI")

			var_11_0:SetAction("normal", 0)

			if arg_10_3 then
				arg_10_3(var_11_0)
			end

			return
		end)
	end

	return
end

function var_0_0.removeTimer(arg_12_0)
	if arg_12_0.timer then
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	return
end

function var_0_0.removeWaitingTimer(arg_13_0)
	if arg_13_0.waitTimer then
		arg_13_0.waitTimer:Stop()

		arg_13_0.waitTimer = nil
	end

	return
end

function var_0_0.returnChar(arg_14_0)
	if arg_14_0.modelTf and arg_14_0.prefabName then
		PoolMgr.GetInstance():ReturnSpineChar(arg_14_0.prefabName, arg_14_0.modelTf.gameObject)

		arg_14_0.modelTf = nil
		arg_14_0.prefabName = nil
	end

	return
end

function var_0_0.Clear(arg_15_0)
	arg_15_0:removeTimer()
	arg_15_0:removeWaitingTimer()
	removeOnButton(arg_15_0._tf)

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
