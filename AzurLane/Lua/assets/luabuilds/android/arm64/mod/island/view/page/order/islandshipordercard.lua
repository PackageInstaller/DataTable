local var_0_0 = class("IslandShipOrderCard")
local var_0_1 = Color.New(0.2235294117647059, 0.7450980392156863, 1, 1)
local var_0_2 = Color.New(0.8274509803921568, 0.8274509803921568, 0.8274509803921568, 1)
local var_0_3 = Color.New(0.8588235294117647, 0.8588235294117647, 0.8588235294117647, 1)
local var_0_4 = Color.New(1, 0.6823529411764706, 0.13333333333333333, 1)
local var_0_5 = Color.New(1, 1, 1, 1)

var_0_0.EVENT_CD_END = "IslandShipOrderCard.EVENT_CD_END"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_2
	arg_1_0._tf = arg_1_1
	arg_1_0.bgTr = arg_1_1:Find("bg")
	arg_1_0.bgImg = arg_1_1:Find("bg"):GetComponent(typeof(Image))
	arg_1_0.request = arg_1_1:Find("request")
	arg_1_0.exchangeBtn = arg_1_1:Find("refresh")
	arg_1_0.requestCG = GetOrAddComponent(arg_1_0.request, typeof(CanvasGroup))
	arg_1_0.uiRequestList = UIItemList.New(arg_1_1:Find("request"), arg_1_1:Find("request/tpl"))
	arg_1_0.titleTr = arg_1_1:Find("title")
	arg_1_0.titleLineImg = arg_1_1:Find("title/line"):GetComponent(typeof(Image))
	arg_1_0.titleTxt = arg_1_1:Find("title/Text"):GetComponent(typeof(Text))
	arg_1_0.loadingTr = arg_1_1:Find("state_loading")
	arg_1_0.loadingRequest = arg_1_1:Find("loading_request")
	arg_1_0.loadingAward = arg_1_1:Find("loading_award")
	arg_1_0.finishTr = arg_1_1:Find("state_finish")
	arg_1_0.award = arg_1_1:Find("award")
	arg_1_0.uiAwardList = UIItemList.New(arg_1_1:Find("award"), arg_1_1:Find("award/tpl"))
	arg_1_0.lockTr = arg_1_1:Find("state_lock")
	arg_1_0.normalTr = arg_1_1:Find("normal_award")
	arg_1_0.levelLockTr = arg_1_1:Find("state_lock/level")
	arg_1_0.levelLockTxt = arg_1_0.levelLockTr:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.resLockTr = arg_1_1:Find("state_lock/gold")
	arg_1_0.resLockTxt = arg_1_0.resLockTr:Find("content/Text"):GetComponent(typeof(Text))
	arg_1_0.timeTxt = arg_1_1:Find("loading_request/time/content/Text"):GetComponent(typeof(Text))
	arg_1_0.getBtn = arg_1_1:Find("state_finish/get")
	arg_1_0.signTr = arg_1_1:Find("sign")
	arg_1_0.resImg = arg_1_1:Find("state_lock/gold/content/icon")
	arg_1_0.emptyTr = arg_1_1:Find("empty")
	arg_1_0.finishCntTxt = arg_1_1:Find("count"):GetComponent(typeof(Text))

	setText(arg_1_1:Find("loading_award/state/Text"), i18n("island_order_get_label"))
	setText(arg_1_1:Find("normal_award/state/Text"), i18n("island_order_get_label"))
	setText(arg_1_0.getBtn:Find("Text"), i18n("island_order_get_label"))
	setText(arg_1_1:Find("empty/Text"), i18n("island_order_ship_sel_delegate_label"))
	setText(arg_1_0.exchangeBtn:Find("Text"), i18n("island_order_ship_btn_replace"))

	arg_1_0.animator = arg_1_1:GetComponent(typeof(Animation))
	arg_1_0.aniDft = arg_1_1:GetComponent(typeof(DftAniEvent))

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
	local var_4_0 = arg_4_1:GetMaxFinishCnt()

	arg_4_0.finishCntTxt.text = i18n("island_order_ship_finish_cnt", var_4_0 - arg_4_1:GetRealFinishCnt(), var_4_0)

	return
end

function var_0_0.PlayAniamtion(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1 == IslandShipOrder.OP_TYPE_UNLOCK then
		(function()
			arg_5_0.aniDft:SetEndEvent(function()
				arg_5_0.aniDft:SetEndEvent(nil)

				if arg_5_3 then
					arg_5_3()
				end

				return
			end)

			return
		end)()
		arg_5_0.animator:Play("anim_island_shiporder_unlock")
	elseif arg_5_1 == IslandShipOrder.OP_TYPE_LOADUP and arg_5_2 then
		(function()
			arg_5_0.aniDft:SetEndEvent(function()
				arg_5_0.aniDft:SetEndEvent(nil)

				if arg_5_3 then
					arg_5_3()
				end

				return
			end)

			return
		end)()
		arg_5_0.animator:Play("anim_island_shiporder_intransit")
	elseif arg_5_1 == IslandShipOrder.OP_TYPE_GET_AWARD then
		(function()
			arg_5_0.aniDft:SetEndEvent(function()
				arg_5_0.aniDft:SetEndEvent(nil)

				if arg_5_3 then
					arg_5_3()
				end

				return
			end)

			return
		end)()
		arg_5_0.animator:Play("anim_island_shiporder_next")
	else
		arg_5_3()
	end

	return
end

function var_0_0.PlayFinishAnimation(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 then
		local var_8_0 = Clone(arg_8_0.slot)

		var_8_0.endTime = pg.TimeMgr.GetInstance():GetServerTime() + 10

		arg_8_0:FlushMain(var_8_0, arg_8_0.mode)
	end

	arg_8_0.aniDft:SetEndEvent(nil)
	arg_8_0.aniDft:SetEndEvent(function()
		arg_8_0.aniDft:SetEndEvent(nil)

		if arg_8_1 then
			arg_8_0:FlushMain(arg_8_0.slot, arg_8_0.mode)
		end

		if arg_8_2 then
			arg_8_2()
		end

		return
	end)
	arg_8_0.animator:Play("anim_island_shiporder_complete")

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
		arg_12_0.timer:Stop()

		arg_12_0.timer = nil
	end

	return
end

function var_0_0.AddTimer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1:GetEndTime()

	arg_13_0.timer = Timer.New(function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = var_13_0 - pg.TimeMgr.GetInstance():GetServerTime()

		arg_13_0.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_14_0)

		if var_14_0 <= 0 then
			arg_13_0:RemoveTimer()
			arg_13_0:PlayFinishAnimation(function()
				arg_13_0:Flush(arg_13_1, arg_13_0.mode)

				return
			end)
		end

		return
	end, 1, -1)

	arg_13_0.timer.func()
	arg_13_0.timer:Start()

	return
end

function var_0_0.UpdateTitle(arg_16_0, arg_16_1)
	if arg_16_1:IsWaiting() then
		arg_16_0.titleTxt.text = i18n("island_order_ship_worktime", pg.TimeMgr.GetInstance():DescCDTime((arg_16_1:GetNeedTime())))
	elseif arg_16_1:IsSubmited() and not arg_16_1:IsFinished() then
		arg_16_0.titleTxt.text = i18n("island_order_ship_working")
	elseif arg_16_1:IsFinished() then
		arg_16_0.titleTxt.text = i18n("island_order_ship_end_work")
	end

	return
end

function var_0_0.UpdateLockTip(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetUnlockLevel()
	local var_17_1 = arg_17_1:GetUnlockGold()

	arg_17_0.levelLockTxt.text = i18n("island_order_ship_unlock_tip")
	arg_17_0.resLockTxt.text = "X" .. var_17_1.count .. i18n("island_order_ship_unlock_tip_2")

	GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[var_17_1.id].icon, "", arg_17_0.resImg)

	return
end

function var_0_0.UpdateAward(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1:GetOrder():GetAwardList()

	arg_18_0.uiAwardList:make(function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = Drop.New(var_18_0[arg_19_1 + 1])

			updateCustomDrop(arg_19_2, Drop.New(var_18_0[arg_19_1 + 1]))
			onButton(arg_18_0.parent, arg_19_2, function()
				arg_18_0.parent:ShowMsgBox({
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_19_0
				})

				return
			end)
		end

		return
	end)
	arg_18_0.uiAwardList:align(#arg_18_1:GetOrder():GetAwardList())

	return
end

function var_0_0.UpdateRequest(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:GetOrder():GetConsumeList()

	arg_21_0.uiRequestList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = Drop.New(var_21_0[arg_22_1 + 1])
			local var_22_1 = var_22_0.icon or var_22_0:getConfig("icon")

			GetImageSpriteFromAtlasAsync("island/" .. var_22_1, "", arg_22_2:Find("icon"))

			local var_22_2 = var_22_0.state == 1
			local var_22_3 = var_22_0:getOwnedCount()

			setText(arg_22_2:Find("cnt"), setColorStr(var_22_3 .. "/" .. var_22_0.count, (var_22_3 >= var_22_0.count or var_22_2) and "#39beff" or "#f36c6e"))
			setActive(arg_22_2:Find("finish"), var_22_2)
			setActive(arg_22_2:Find("loaded"), var_22_2)
			setActive(arg_22_2:Find("loaded_1"), false)
			setActive(arg_22_2:Find("enough"), not var_22_2 and var_22_3 >= var_22_0.count)
		end

		return
	end)
	arg_21_0.uiRequestList:align(#arg_21_1:GetOrder():GetConsumeList())

	return
end

function var_0_0.UpdateStyle(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_1:IsLock()
	local var_23_1 = arg_23_1:IsWaiting()
	local var_23_2 = arg_23_1:IsFinished()
	local var_23_3 = arg_23_1:IsSubmited() and not var_23_2
	local var_23_4 = arg_23_1:CanUnlock()
	local var_23_5 = arg_23_1:IsEmpty()
	local var_23_6 = arg_23_2 == IslandShipOrderPage.MODE_REQUEST_VIEW
	local var_23_7 = arg_23_2 == IslandShipOrderPage.MODE_AWARD_VIEW

	setActive(arg_23_0.loadingTr, var_23_3)
	setActive(arg_23_0.loadingRequest, var_23_3 and var_23_6)
	setActive(arg_23_0.loadingAward, var_23_3 and var_23_7)
	setActive(arg_23_0.finishTr, var_23_2 and not var_23_5)
	setActive(arg_23_0.request, not var_23_0 and var_23_6 and not var_23_2 and not var_23_5)
	setActive(arg_23_0.award, (not var_23_0 and var_23_7 or var_23_2) and not var_23_5)
	setActive(arg_23_0.lockTr, var_23_0)
	setActive(arg_23_0.normalTr, var_23_1 and var_23_7 and not var_23_5)
	setActive(arg_23_0.levelLockTr, var_23_0 and not var_23_4)
	setActive(arg_23_0.resLockTr, var_23_0 and var_23_4)
	setActive(arg_23_0.titleTr, not var_23_0 and not var_23_5)
	setActive(arg_23_0.emptyTr, var_23_5 and var_23_1)
	setActive(arg_23_0.exchangeBtn, not var_23_5 and var_23_1 and var_23_6)
	setActive(arg_23_0.finishCntTxt.gameObject, not var_23_0)

	arg_23_0.requestCG.alpha = var_23_3 and 0.6 or 1

	local var_23_8 = arg_23_0.titleTr

	var_23_8.sizeDelta = var_23_1 and Vector2(360, 39) or Vector2(155, 39)

	arg_23_0:UpdateBgColor(arg_23_1)
	arg_23_0:UpdateTitleColor(arg_23_1)

	return
end

function var_0_0.RemoveReloadingTimer(arg_24_0)
	if arg_24_0.reloadingTimer then
		arg_24_0.reloadingTimer:Stop()

		arg_24_0.reloadingTimer = nil
	end

	return
end

function var_0_0.UpdateBgColor(arg_25_0, arg_25_1)
	if arg_25_1:IsSubmited() and not arg_25_1:IsFinished() then
		setActive(arg_25_0.bgTr, false)

		return
	end

	setActive(arg_25_0.bgTr, true)

	local var_25_0 = arg_25_0.bgImg

	if arg_25_1:IsFinished() then
		var_25_0.color = var_0_1 or var_0_3

		return
	end
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

	if arg_26_1:IsWaiting() then
		var_26_0.color = var_0_2 or var_0_5

		return
	end
end

function var_0_0.Dispose(arg_27_0)
	arg_27_0:RemoveTimer()
	arg_27_0:RemoveReloadingTimer()
	arg_27_0.aniDft:SetEndEvent(nil)

	return
end

return var_0_0
