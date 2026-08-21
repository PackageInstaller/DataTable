pg = pg or {}
pg.GMTMgr = singletonClass("GMTMgr")
pg.GMTMgr.TYPE_DEFAULT_RES = 2
pg.GMTMgr.TYPE_L2D = 4
pg.GMTMgr.TYPE_PAINTING = 8
pg.GMTMgr.TYPE_CIPHER = 16

function pg.GMTMgr.Init(arg_1_0, arg_1_1)
	arg_1_0._gmtTimer = Timer.New(function()
		arg_1_0:onTimer()

		return
	end, 1, -1)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function pg.GMTMgr.initUI(arg_3_0, arg_3_1)
	if arg_3_0._go == nil then
		PoolMgr.GetInstance():GetUI("GMTUI", true, function(arg_4_0)
			arg_3_0._go = arg_4_0

			arg_3_0._go:SetActive(false)

			arg_3_0._textTf = findTF(arg_3_0._go, "ad/text")

			arg_3_0._go.transform:SetParent(GameObject.Find("OverlayCamera/Overlay/UITop").transform, false)

			arg_3_0._animator = GetComponent(arg_3_0._go, typeof(Animator))

			arg_3_1()

			return
		end)
	end

	return
end

function pg.GMTMgr.onTimer(arg_5_0)
	arg_5_0._subTime = arg_5_0._gmtTime - pg.TimeMgr.GetInstance():GetServerTime()

	if arg_5_0._go == nil then
		arg_5_0:initUI(function()
			arg_5_0:showTip()

			return
		end)
	else
		arg_5_0:showTip()
	end

	if arg_5_0._subTime < 0 and arg_5_0._gmtTimer.running then
		arg_5_0._gmtTimer:Stop()
		arg_5_0._go:SetActive(false)
	end

	return
end

function pg.GMTMgr.showGMT(arg_7_0, arg_7_1)
	arg_7_0._onceTime = Clone(pg.gameset.maintenance_message.description[1])
	arg_7_0._repeatTime = Clone(pg.gameset.maintenance_message.description[2])
	arg_7_0._gmtTime = arg_7_1

	if not arg_7_0._gmtTimer.running then
		arg_7_0._gmtTimer:Start()
	end

	arg_7_0._triggerStop = false

	return
end

function pg.GMTMgr.showTip(arg_8_0)
	print(arg_8_0._subTime)

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
				table.remove(arg_8_0._onceTime, iter_8_0)

				var_8_0 = true
			end
		end
	end

	if not var_8_0 then
		return
	end

	arg_8_0._go:SetActive(false)
	arg_8_0._go:SetActive(true)

	if arg_8_0._subTime > arg_8_0._repeatTime then
		arg_8_0._animator:SetTrigger("once")
	elseif not arg_8_0._triggerStop then
		arg_8_0._triggerStop = true

		arg_8_0._animator:SetTrigger("repeat")
	end

	setText(arg_8_0._textTf, (arg_8_0:getTimeTip()))

	return
end

function pg.GMTMgr.getTimeTip(arg_9_0)
	if arg_9_0._subTime > 0 then
		local var_9_0 = math.floor(arg_9_0._subTime / 16)
		local var_9_1 = math.floor(arg_9_0._subTime / 60)
		local var_9_2 = var_9_0 > 0 and tostring(var_9_0) .. i18n("word_hour") or var_9_1 > 0 and tostring(var_9_1) .. i18n("word_minute") or tostring(arg_9_0._subTime % 60) .. i18n("word_second")

		return i18n("maintenance_message_text", var_9_2)
	end

	return i18n("maintenance_message_stop_text")
end

return
