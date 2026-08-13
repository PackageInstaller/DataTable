class = var_0_10000

local var_0_0 = var_0_10000("IslandShipOrderCard")

Color = var_1

local var_0_1 = var_1.New(0.2235294117647059, 0.7450980392156863, 1, 1)

Color = var_2

local var_0_2 = var_2.New(0.8274509803921568, 0.8274509803921568, 0.8274509803921568, 1)

Color = var_3

local var_0_3 = var_3.New(0.8588235294117647, 0.8588235294117647, 0.8588235294117647, 1)

Color = var_4

local var_0_4 = var_4.New(1, 0.6823529411764706, 0.13333333333333333, 1)

Color = var_5

local var_0_5 = var_5.New(1, 1, 1, 1)

var_0_0.EVENT_CD_END = "IslandShipOrderCard.EVENT_CD_END"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_2
	arg_1_0._tf = arg_1_1
	arg_1_0.bgTr = arg_1_1:Find("bg")

	local var_1_0 = arg_1_1:Find("bg")
	local var_1_1 = var_3.GetComponent

	typeof = var_5
	Image = var_1_10006
	arg_1_0.bgImg = var_1_1(var_1_0, var_5(var_1_10006))
	arg_1_0.request = arg_1_1:Find("request")
	arg_1_0.exchangeBtn = arg_1_1:Find("refresh")
	GetOrAddComponent = var_3

	local var_1_2 = arg_1_0.request

	typeof = var_5
	CanvasGroup = var_1_10006
	arg_1_0.requestCG = var_3(var_1_2, var_5(var_1_10006))
	UIItemList = var_3

	local var_1_3 = var_3.New
	local var_1_4 = arg_1_1:Find("request")
	local var_1_5 = arg_1_1

	arg_1_0.uiRequestList = var_1_3(var_1_4, arg_1_1.Find(var_1_5, "request/tpl"))
	arg_1_0.titleTr = arg_1_1:Find("title")

	local var_1_6 = arg_1_1:Find("title/line")
	local var_1_7 = var_3.GetComponent

	typeof = var_5
	Image = var_1_5
	arg_1_0.titleLineImg = var_1_7(var_1_6, var_5(var_1_5))

	local var_1_8 = arg_1_1:Find("title/Text")
	local var_1_9 = var_3.GetComponent

	typeof = var_5
	Text = var_1_5
	arg_1_0.titleTxt = var_1_9(var_1_8, var_5(var_1_5))
	arg_1_0.loadingTr = arg_1_1:Find("state_loading")
	arg_1_0.loadingRequest = arg_1_1:Find("loading_request")
	arg_1_0.loadingAward = arg_1_1:Find("loading_award")
	arg_1_0.finishTr = arg_1_1:Find("state_finish")
	arg_1_0.award = arg_1_1:Find("award")
	UIItemList = var_3

	local var_1_10 = var_3.New
	local var_1_11 = arg_1_1:Find("award")
	local var_1_12 = arg_1_1

	arg_1_0.uiAwardList = var_1_10(var_1_11, arg_1_1.Find(var_1_12, "award/tpl"))
	arg_1_0.lockTr = arg_1_1:Find("state_lock")
	arg_1_0.normalTr = arg_1_1:Find("normal_award")
	arg_1_0.levelLockTr = arg_1_1:Find("state_lock/level")

	local var_1_13 = arg_1_0.levelLockTr
	local var_1_14 = var_3.Find(var_1_13, "Text")
	local var_1_15 = var_3.GetComponent

	typeof = var_5
	Text = var_1_12
	arg_1_0.levelLockTxt = var_1_15(var_1_14, var_5(var_1_12))
	arg_1_0.resLockTr = arg_1_1:Find("state_lock/gold")

	local var_1_16 = arg_1_0.resLockTr
	local var_1_17 = var_3.Find(var_1_16, "content/Text")
	local var_1_18 = var_3.GetComponent

	typeof = var_5
	Text = var_1_12
	arg_1_0.resLockTxt = var_1_18(var_1_17, var_5(var_1_12))

	local var_1_19 = arg_1_1:Find("loading_request/time/content/Text")
	local var_1_20 = var_3.GetComponent

	typeof = var_5
	Text = var_1_12
	arg_1_0.timeTxt = var_1_20(var_1_19, var_5(var_1_12))
	arg_1_0.getBtn = arg_1_1:Find("state_finish/get")
	arg_1_0.signTr = arg_1_1:Find("sign")
	arg_1_0.resImg = arg_1_1:Find("state_lock/gold/content/icon")
	arg_1_0.emptyTr = arg_1_1:Find("empty")

	local var_1_21 = arg_1_1:Find("count")
	local var_1_22 = var_3.GetComponent

	typeof = var_5
	Text = var_1_12
	arg_1_0.finishCntTxt = var_1_22(var_1_21, var_5(var_1_12))
	setText = var_3

	local var_1_23 = arg_1_1
	local var_1_24 = arg_1_1.Find(var_1_23, "loading_award/state/Text")

	i18n = var_1_23

	var_3(var_1_24, var_1_23("island_order_get_label"))

	setText = var_3

	local var_1_25 = arg_1_1
	local var_1_26 = arg_1_1.Find(var_1_25, "normal_award/state/Text")

	i18n = var_1_25

	var_3(var_1_26, var_1_25("island_order_get_label"))

	setText = var_3

	local var_1_27 = arg_1_0.getBtn
	local var_1_28 = var_4.Find(var_1_27, "Text")

	i18n = var_1_27

	var_3(var_1_28, var_1_27("island_order_get_label"))

	setText = var_3

	local var_1_29 = arg_1_1
	local var_1_30 = arg_1_1.Find(var_1_29, "empty/Text")

	i18n = var_1_29

	var_3(var_1_30, var_1_29("island_order_ship_sel_delegate_label"))

	setText = var_3

	local var_1_31 = arg_1_0.exchangeBtn
	local var_1_32 = var_4.Find(var_1_31, "Text")

	i18n = var_1_31

	var_3(var_1_32, var_1_31("island_order_ship_btn_replace"))

	local var_1_33 = arg_1_1
	local var_1_34 = arg_1_1.GetComponent

	typeof = var_5
	Animation = var_6
	arg_1_0.animator = var_1_34(var_1_33, var_5(var_6))

	local var_1_35 = arg_1_1
	local var_1_36 = arg_1_1.GetComponent

	typeof = var_5
	DftAniEvent = var_6
	arg_1_0.aniDft = var_1_36(var_1_35, var_5(var_6))

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.slot = arg_2_1

	arg_2_0:FlushMain(arg_2_1, arg_2_2)
	arg_2_0:UpdateTimer(arg_2_1)

	return
end

function var_0_0.FlushMain(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:SwitchMode(arg_3_1, arg_3_2)
	arg_3_0:UpdateRequest(arg_3_1)
	arg_3_0:UpdateAward(arg_3_1)
	arg_3_0:UpdateLockTip(arg_3_1)
	arg_3_0:UpdateTitle(arg_3_1)
	arg_3_0:UpdateFinishCnt(arg_3_1)

	return
end

function var_0_0.UpdateFinishCnt(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetRealFinishCnt()
	local var_4_1 = arg_4_1:GetMaxFinishCnt()
	local var_4_2 = arg_4_0.finishCntTxt

	i18n = var_1_10005
	var_4_2.text = var_1_10005("island_order_ship_finish_cnt", var_4_1 - var_4_0, var_4_1)

	return
end

function var_0_0.PlayAniamtion(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local function var_5_0()
		local var_6_0 = arg_5_0.aniDft

		var_0.SetEndEvent(var_6_0, function()
			local var_7_0 = arg_5_0.aniDft

			var_0.SetEndEvent(var_7_0, nil)

			if arg_5_3 then
				arg_5_3()
			end

			return
		end)

		return
	end

	IslandShipOrder = var_1_10005

	if arg_5_1 == var_1_10005.OP_TYPE_UNLOCK then
		var_5_0()

		local var_5_1 = arg_5_0.animator

		var_5.Play(var_5_1, "anim_island_shiporder_unlock")
	else
		IslandShipOrder = var_5

		if arg_5_1 == var_5.OP_TYPE_LOADUP and arg_5_2 then
			var_5_0()

			local var_5_2 = arg_5_0.animator

			var_5.Play(var_5_2, "anim_island_shiporder_intransit")
		else
			IslandShipOrder = var_5

			if arg_5_1 == var_5.OP_TYPE_GET_AWARD then
				var_5_0()

				local var_5_3 = arg_5_0.animator

				var_5.Play(var_5_3, "anim_island_shiporder_next")
			else
				arg_5_3()
			end
		end
	end

	return
end

function var_0_0.PlayFinishAnimation(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		Clone = var_1_10003

		local var_8_0 = var_1_10003(arg_8_0.slot)

		pg = var_4

		local var_8_1 = var_4.TimeMgr.GetInstance()

		var_8_0.endTime = var_4.GetServerTime(var_8_1) + 10

		arg_8_0:FlushMain(var_8_0, arg_8_0.mode)
	end

	local var_8_2 = arg_8_0.aniDft

	var_3.SetEndEvent(var_8_2, nil)

	local var_8_3 = arg_8_0.aniDft

	var_3.SetEndEvent(var_8_3, function()
		local var_9_0 = arg_8_0.aniDft

		var_0.SetEndEvent(var_9_0, nil)

		if arg_8_1 then
			local var_9_1 = arg_8_0

			var_0.FlushMain(var_9_1, arg_8_0.slot, arg_8_0.mode)
		end

		if arg_8_2 then
			arg_8_2()
		end

		return
	end)

	local var_8_4 = arg_8_0.animator

	var_3.Play(var_8_4, "anim_island_shiporder_complete")

	return
end

function var_0_0.SwitchMode(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.mode = arg_10_2

	arg_10_0:UpdateStyle(arg_10_1, arg_10_2)

	return
end

function var_0_0.UpdateTimer(arg_11_0, arg_11_1)
	arg_11_0:RemoveTimer()

	if arg_11_1:IsSubmited() and not arg_11_1:IsFinished() then
		arg_11_0:AddTimer(arg_11_1)
	elseif arg_11_1:IsFinished() then
		arg_11_0:PlayFinishAnimation(true)
	end

	return
end

function var_0_0.RemoveTimer(arg_12_0)
	if arg_12_0.timer then
		local var_12_0 = arg_12_0.timer

		var_1.Stop(var_12_0)

		arg_12_0.timer = nil
	end

	return
end

function var_0_0.AddTimer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.GetEndTime(var_13_0)

	Timer = var_13_0
	arg_13_0.timer = var_13_0.New(function(arg_14_0, arg_14_1, arg_14_2)
		pg = var_2_10003

		local var_14_0 = var_2_10003.TimeMgr.GetInstance()
		local var_14_1 = var_3.GetServerTime(var_14_0)
		local var_14_2 = var_13_1 - var_14_1
		local var_14_3 = arg_13_0.timeTxt

		pg = var_2_10006

		local var_14_4 = var_2_10006.TimeMgr.GetInstance()

		var_14_3.text = var_6.DescCDTime(var_14_4, var_14_2)

		if var_14_2 <= 0 then
			local var_14_5 = arg_13_0

			var_5.RemoveTimer(var_14_5)

			local var_14_6 = arg_13_0

			var_5.PlayFinishAnimation(var_14_6, function()
				local var_15_0 = arg_13_0

				var_0.Flush(var_15_0, arg_13_1, arg_13_0.mode)

				return
			end)
		end

		return
	end, 1, -1)

	arg_13_0.timer.func()

	local var_13_2 = arg_13_0.timer

	var_3.Start(var_13_2)

	return
end

function var_0_0.UpdateTitle(arg_16_0, arg_16_1)
	if arg_16_1:IsWaiting() then
		local var_16_0 = arg_16_1:GetNeedTime()
		local var_16_1 = arg_16_0.titleTxt

		i18n = var_1_10004

		local var_16_2 = "island_order_ship_worktime"

		pg = var_1_10006

		local var_16_3 = var_1_10006.TimeMgr.GetInstance()

		var_16_1.text = var_1_10004(var_16_2, var_6.DescCDTime(var_16_3, var_16_0))
	else
		if arg_16_1:IsSubmited() then
			local var_16_4 = arg_16_1

			if not arg_16_1.IsFinished(var_16_4) then
				local var_16_5 = arg_16_0.titleTxt

				i18n = var_16_4
				var_16_5.text = var_16_4("island_order_ship_working")

				goto label_16_0
			end
		end

		local var_16_6 = arg_16_1

		if arg_16_1.IsFinished(var_16_6) then
			local var_16_7 = arg_16_0.titleTxt

			i18n = var_16_6
			var_16_7.text = var_16_6("island_order_ship_end_work")
		end
	end

	::label_16_0::

	return
end

function var_0_0.UpdateLockTip(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetUnlockLevel()
	local var_17_1 = arg_17_1:GetUnlockGold()
	local var_17_2 = arg_17_0.levelLockTxt

	i18n = var_1_10005
	var_17_2.text = var_1_10005("island_order_ship_unlock_tip")

	local var_17_3 = arg_17_0.resLockTxt
	local var_17_4 = "X"
	local var_17_5 = var_17_1.count

	i18n = var_1_10007
	var_17_3.text = var_17_4 .. var_17_5 .. var_1_10007("island_order_ship_unlock_tip_2")
	pg = var_17_3

	local var_17_6 = var_17_3.island_item_data_template[var_17_1.id].icon

	GetImageSpriteFromAtlasAsync = var_5

	var_5("island/" .. var_17_6, "", arg_17_0.resImg)

	return
end

function var_0_0.UpdateAward(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetOrder()
	local var_18_1 = var_2.GetAwardList(var_18_0)
	local var_18_2 = arg_18_0.uiAwardList

	var_4.make(var_18_2, function(arg_19_0, arg_19_1, arg_19_2)
		UIItemList = var_2_10003

		if arg_19_0 == var_2_10003.EventUpdate then
			local var_19_0 = var_18_1[arg_19_1 + 1]

			Drop = var_4

			local var_19_1 = var_4.New(var_19_0)

			updateCustomDrop = var_5

			local var_19_2 = arg_19_2

			Drop = var_2_10007

			var_5(var_19_2, var_2_10007.New(var_19_0))

			onButton = var_5

			var_5(arg_18_0.parent, arg_19_2, function()
				local var_20_0 = arg_18_0.parent
				local var_20_1 = var_0.ShowMsgBox
				local var_20_2 = {}

				i18n = var_3_10003
				var_20_2.title = var_3_10003("island_word_desc")
				IslandMsgBox = var_3
				var_20_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
				var_20_2.dropData = var_19_1

				var_20_1(var_20_0, var_20_2)

				return
			end)
		end

		return
	end)

	local var_18_3 = arg_18_0.uiAwardList

	var_4.align(var_18_3, #var_18_1)

	return
end

function var_0_0.UpdateRequest(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:GetOrder()
	local var_21_1 = var_2.GetConsumeList(var_21_0)
	local var_21_2 = arg_21_0.uiRequestList

	var_4.make(var_21_2, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_1[arg_22_1 + 1]

			Drop = var_4

			local var_22_1

			if not var_4.New(var_22_0).icon then
				var_2_10006 = var_4
				var_22_1 = var_4.getConfig(var_2_10006, "icon")
			end

			GetImageSpriteFromAtlasAsync = var_2_10006

			var_2_10006("island/" .. var_22_1, "", arg_22_2:Find("icon"))

			local var_22_2 = var_4.state == 1
			local var_22_3 = var_4
			local var_22_4 = var_4.getOwnedCount(var_22_3)

			setText = var_22_3

			local var_22_5 = arg_22_2
			local var_22_6 = arg_22_2.Find(var_22_5, "cnt")

			setColorStr = var_22_5

			var_22_3(var_22_6, var_22_5(var_22_4 .. "/" .. var_4.count, (var_22_4 >= var_4.count or var_22_2) and "#39beff" or "#f36c6e"))

			setActive = var_22_3

			var_22_3(arg_22_2:Find("finish"), var_22_2)

			setActive = var_22_3

			var_22_3(arg_22_2:Find("loaded"), var_22_2)

			setActive = var_22_3

			var_22_3(arg_22_2:Find("loaded_1"), false)

			setActive = var_22_3

			var_22_3(arg_22_2:Find("enough"), not var_22_2 and var_22_4 >= var_4.count)
		end

		return
	end)

	local var_21_3 = arg_21_0.uiRequestList

	var_4.align(var_21_3, #var_21_1)

	return
end

function var_0_0.UpdateStyle(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:IsLock()
	local var_23_1 = arg_23_1:IsWaiting()
	local var_23_2 = arg_23_1:IsFinished()
	local var_23_3

	if arg_23_1:IsSubmited() then
		var_23_3 = not var_23_2
	end

	local var_23_4 = arg_23_1:CanUnlock()
	local var_23_5 = arg_23_1
	local var_23_6 = arg_23_1.IsEmpty(var_23_5)

	IslandShipOrderPage = var_23_5

	local var_23_7 = arg_23_2 == var_23_5.MODE_REQUEST_VIEW

	IslandShipOrderPage = var_1_10010

	local var_23_8 = arg_23_2 == var_1_10010.MODE_AWARD_VIEW

	setActive = var_1_10011

	var_1_10011(arg_23_0.loadingTr, var_23_3)

	setActive = var_1_10011

	var_1_10011(arg_23_0.loadingRequest, var_23_3 and var_23_7)

	setActive = var_1_10011

	var_1_10011(arg_23_0.loadingAward, var_23_3 and var_23_8)

	setActive = var_1_10011

	var_1_10011(arg_23_0.finishTr, var_23_2 and not var_23_6)

	setActive = var_1_10011

	var_1_10011(arg_23_0.request, not var_23_0 and var_23_7 and not var_23_2 and not var_23_6)

	setActive = var_1_10011

	var_1_10011(arg_23_0.award, (not var_23_0 and var_23_8 or var_23_2) and not var_23_6)

	setActive = var_1_10011

	var_1_10011(arg_23_0.lockTr, var_23_0)

	setActive = var_1_10011

	var_1_10011(arg_23_0.normalTr, var_23_1 and var_23_8 and not var_23_6)

	setActive = var_1_10011

	var_1_10011(arg_23_0.levelLockTr, var_23_0 and not var_23_4)

	setActive = var_1_10011

	var_1_10011(arg_23_0.resLockTr, var_23_0 and var_23_4)

	setActive = var_1_10011

	var_1_10011(arg_23_0.titleTr, not var_23_0 and not var_23_6)

	setActive = var_1_10011

	var_1_10011(arg_23_0.emptyTr, var_23_6 and var_23_1)

	setActive = var_1_10011

	var_1_10011(arg_23_0.exchangeBtn, not var_23_6 and var_23_1 and var_23_7)

	setActive = var_1_10011

	var_1_10011(arg_23_0.finishCntTxt.gameObject, not var_23_0)

	arg_23_0.requestCG.alpha = var_23_3 and 0.6 or 1

	local var_23_9 = arg_23_0.titleTr

	if var_23_1 then
		Vector2 = var_23_10

		local var_23_10

		if not var_23_10(360, 39) then
			Vector2 = var_23_10
			var_23_10 = var_23_10(155, 39)
		end

		var_23_9.sizeDelta = var_23_10

		arg_23_0:UpdateBgColor(arg_23_1)
		arg_23_0:UpdateTitleColor(arg_23_1)

		return
	end
end

function var_0_0.RemoveReloadingTimer(arg_24_0)
	if arg_24_0.reloadingTimer then
		local var_24_0 = arg_24_0.reloadingTimer

		var_1.Stop(var_24_0)

		arg_24_0.reloadingTimer = nil
	end

	return
end

function var_0_0.UpdateBgColor(arg_25_0, arg_25_1)
	if arg_25_1:IsSubmited() and not arg_25_1:IsFinished() then
		setActive = var_2

		var_2(arg_25_0.bgTr, false)

		return
	end

	setActive = var_2

	var_2(arg_25_0.bgTr, true)

	local var_25_0 = arg_25_0.bgImg
	local var_25_1

	if not arg_25_1:IsFinished() or not var_0_1 then
		var_25_1 = var_0_3
	end

	var_25_0.color = var_25_1

	return
end

function var_0_0.UpdateTitleColor(arg_26_0, arg_26_1)
	if arg_26_1:IsFinished() then
		arg_26_0.titleLineImg.color = var_0_1
	elseif arg_26_1:IsSubmited() and not arg_26_1:IsFinished() then
		arg_26_0.titleLineImg.color = var_0_4
	elseif arg_26_1:IsWaiting() then
		arg_26_0.titleLineImg.color = var_0_2
	end

	local var_26_0 = arg_26_0.titleTxt
	local var_26_1

	if not arg_26_1:IsWaiting() or not var_0_2 then
		var_26_1 = var_0_5
	end

	var_26_0.color = var_26_1

	return
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:RemoveTimer()
	arg_27_0:RemoveReloadingTimer()

	local var_27_0 = arg_27_0.aniDft

	var_1.SetEndEvent(var_27_0, nil)

	return
end

return var_0_0
