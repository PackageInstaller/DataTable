local var_0_0 = class("WorldCruiseAwardPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "WorldCruiseAwardPage"
end

function var_0_0.UpdateActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.activity:GetCrusingInfo()) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	return
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0:UpdateActivity()

	local var_3_0 = arg_3_0._tf:Find("frame")

	arg_3_0.nextAwardTF = var_3_0:Find("next")
	arg_3_0.btnAll = var_3_0:Find("btns/btn_all")

	setText(arg_3_0.btnAll:Find("Text"), i18n("cruise_btn_all"))

	arg_3_0.btnPay = var_3_0:Find("btns/btn_pay")

	setText(arg_3_0.btnPay:Find("Text"), i18n("cruise_btn_pay"))

	arg_3_0.scrollCom = GetComponent(var_3_0:Find("view/content"), "LScrollRect")

	function arg_3_0.scrollCom.onUpdateItem(arg_4_0, arg_4_1)
		arg_3_0:UpdateAwardInfo(arg_4_0, tf(arg_4_1), arg_3_0.awardList[arg_4_0 + 1])

		return
	end

	return
end

function var_0_0.OnInit(arg_5_0)
	onButton(arg_5_0, arg_5_0.btnAll, function()
		arg_5_0:GetAllAward()

		return
	end, SFX_CONFIRM)
	onButton(arg_5_0, arg_5_0.btnPay, function()
		arg_5_0.contextData.windowForCharge:ExecuteAction("ShowBuyWindow")

		return
	end, SFX_CONFIRM)
	arg_5_0.scrollCom.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_5_0, arg_5_0.scrollCom.onValueChanged)
	arg_5_0.scrollCom.onValueChanged:AddListener(function(arg_8_0)
		arg_5_0:UpdateNextAward(arg_8_0.x)

		return
	end)

	return
end

function var_0_0.Flush(arg_9_0, arg_9_1)
	arg_9_0:Show()

	if arg_9_1 then
		arg_9_0:UpdateActivity(arg_9_1)
	end

	arg_9_0.scrollCom:SetTotalCount(#arg_9_0.awardList - 1)
	arg_9_0:BuildPhaseAwardScrollPos()

	if arg_9_0.phase == 0 then
		arg_9_0.scrollCom:ScrollTo(0)
	elseif arg_9_0.phase == #arg_9_0.awardList then
		arg_9_0.scrollCom:ScrollTo(1)
	else
		arg_9_0.scrollCom:ScrollTo(math.clamp(arg_9_0.phasePos[arg_9_0.phase], 0, 1), true)
	end

	arg_9_0.nextAwardIndex = nil

	setActive(arg_9_0.btnAll, #arg_9_0.activity:GetCrusingUnreceiveAward() > 0)
	setActive(arg_9_0.btnPay, not arg_9_0.isPay)

	if not arg_9_0.isPay then
		if not pg.TimeMgr.GetInstance():inTime(pg.pay_data_display[WorldCruiseChargePage.GetPassID()].time) then
			setActive(arg_9_0.btnPay, false)
		end
	end

	arg_9_0:UpdateNextAward(arg_9_0.scrollCom.value)

	return
end

function var_0_0.BuildPhaseAwardScrollPos(arg_10_0)
	if arg_10_0.phasePos then
		return
	end

	arg_10_0.phasePos = {}
	arg_10_0.nextPhasePos = {}

	local var_10_0 = arg_10_0.scrollCom:HeadIndexToValue(#arg_10_0.awardList) - arg_10_0.scrollCom:HeadIndexToValue(0)
	local var_10_1 = arg_10_0.scrollCom:HeadIndexToValue(#arg_10_0.awardList - 6) - arg_10_0.scrollCom:HeadIndexToValue(0)

	for iter_10_0 = 1, #arg_10_0.awardList - 1 do
		table.insert(arg_10_0.phasePos, arg_10_0.scrollCom:HeadIndexToValue(iter_10_0 - 1) / var_10_0)
		table.insert(arg_10_0.nextPhasePos, arg_10_0.scrollCom:HeadIndexToValue(iter_10_0 - 1) / var_10_1)
	end

	return
end

function var_0_0.IsSpecialMask(arg_11_0, arg_11_1)
	return arg_11_1 == DROP_TYPE_COMBAT_UI_STYLE or arg_11_1 == DROP_TYPE_SKIN or arg_11_1 == DROP_TYPE_EQUIPMENT_SKIN
end

function var_0_0.IsSkinFrame(arg_12_0, arg_12_1)
	return arg_12_1 == DROP_TYPE_SKIN or arg_12_1 == DROP_TYPE_EQUIPMENT_SKIN
end

function var_0_0.IsBattleUIFrame(arg_13_0, arg_13_1)
	return arg_13_1 == DROP_TYPE_COMBAT_UI_STYLE
end

function var_0_0.UpdateAwardInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2:Find("bg_cur") then
		setActive(arg_14_2:Find("bg_cur"), arg_14_1 + 2 == arg_14_0.phase)
	end

	setText(arg_14_2:Find("Text"), arg_14_3.id)

	local var_14_0 = arg_14_3.pt <= arg_14_0.pt
	local var_14_1 = Drop.Create(arg_14_3.award)

	onButton(arg_14_0, arg_14_2:Find("base"), function()
		arg_14_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_14_1
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_14_2:Find("base/mask/IconTpl"), var_14_1)
	setActive(arg_14_2:Find("base/frame_skin"), arg_14_0:IsSkinFrame(var_14_1.type))
	setActive(arg_14_2:Find("base/frame_ui"), arg_14_0:IsBattleUIFrame(var_14_1.type))
	setActive(arg_14_2:Find("base/lock"), not var_14_0)
	setActive(arg_14_2:Find("base/get"), var_14_0 and not arg_14_0.awardDic[arg_14_3.pt])

	local var_14_2 = arg_14_0.awardDic[arg_14_3.pt] and not arg_14_0:IsSpecialMask(var_14_1.type)

	setActive(arg_14_2:Find("base/got"), var_14_2)

	local var_14_3 = arg_14_0.awardDic[arg_14_3.pt] and arg_14_0:IsSpecialMask(var_14_1.type)

	setActive(arg_14_2:Find("base/got_frame"), var_14_3)

	local var_14_4 = Drop.Create(arg_14_3.award_pay)

	onButton(arg_14_0, arg_14_2:Find("pay"), function()
		arg_14_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_14_4
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_14_2:Find("pay/mask/IconTpl"), var_14_4)
	setActive(arg_14_2:Find("pay/frame_skin"), arg_14_0:IsSkinFrame(var_14_4.type))
	setActive(arg_14_2:Find("pay/frame_ui"), arg_14_0:IsBattleUIFrame(var_14_4.type))
	setActive(arg_14_2:Find("pay/no_pay"), not arg_14_0.isPay and not arg_14_0:IsSpecialMask(var_14_4.type))
	setActive(arg_14_2:Find("pay/no_pay_frame"), not arg_14_0.isPay and arg_14_0:IsSpecialMask(var_14_4.type))
	setActive(arg_14_2:Find("pay/lock"), not var_14_0 or not arg_14_0.isPay)

	local var_14_5 = arg_14_0.isPay and var_14_0 and not arg_14_0.awardPayDic[arg_14_3.pt]

	setActive(arg_14_2:Find("pay/get"), var_14_5)

	local var_14_6 = arg_14_0.awardPayDic[arg_14_3.pt] and not arg_14_0:IsSpecialMask(var_14_4.type)

	setActive(arg_14_2:Find("pay/got"), var_14_6)

	local var_14_7 = arg_14_0.awardPayDic[arg_14_3.pt] and arg_14_0:IsSpecialMask(var_14_4.type)

	setActive(arg_14_2:Find("pay/got_frame"), var_14_7)

	return
end

function var_0_0.UpdateNextAward(arg_17_0, arg_17_1)
	if not arg_17_0.nextPhasePos then
		return
	end

	local var_17_0 = arg_17_0.nextPhasePos[#arg_17_0.nextPhasePos] - 1
	local var_17_1 = #arg_17_0.awardList

	for iter_17_0 = #arg_17_0.awardList - 1, 1, -1 do
		if arg_17_0.nextPhasePos[iter_17_0] < arg_17_1 + var_17_0 or arg_17_0.awardList[iter_17_0].pt <= arg_17_0.pt then
			break
		elseif arg_17_0.awardList[iter_17_0].isImportent then
			var_17_1 = iter_17_0
		end
	end

	if arg_17_0.nextAwardIndex ~= var_17_1 then
		arg_17_0.nextAwardIndex = var_17_1

		arg_17_0:UpdateAwardInfo(arg_17_0.nextAwardIndex, arg_17_0.nextAwardTF, arg_17_0.awardList[var_17_1])
	end

	return
end

function var_0_0.GetAllAward(arg_18_0)
	local var_18_0 = arg_18_0.activity:GetCrusingUnreceiveAward()

	if #var_18_0 > 0 then
		if arg_18_0:CheckLimitMax(var_18_0) then
			table.insert({}, function(arg_19_0)
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
					contentText = i18n("player_expResource_mail_fullBag"),
					onConfirm = arg_19_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_18_0:emit(WorldCruiseMediator.EVENT_GET_AWARD_ALL)

			return
		end)
	end

	return
end

function var_0_0.CheckLimitMax(arg_21_0, arg_21_1)
	local var_21_0 = getProxy(PlayerProxy):getData()

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		if iter_21_1.type == DROP_TYPE_RESOURCE then
			if iter_21_1.id == 1 then
				if var_21_0:GoldMax(iter_21_1.count) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

					return true
				end
			elseif iter_21_1.id == 2 and var_21_0:OilMax(iter_21_1.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

				return true
			end
		elseif iter_21_1.type == DROP_TYPE_ITEM then
			local var_21_1 = Item.getConfigData(iter_21_1.id)

			if var_21_1.type == Item.EXP_BOOK_TYPE then
				local var_21_2 = getProxy(BagProxy)

				if var_21_2:getItemCountById(iter_21_1.id) + iter_21_1.count > var_21_1.max_num then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.OnDestroy(arg_22_0)
	return
end

return var_0_0
