local var_0_0 = class("PSSHei5AwardPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PSSHei5AwardPage"
end

function var_0_0.UpdateActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1 or getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)

	for iter_2_0, iter_2_1 in pairs(arg_2_0.activity:GetHei5Info()) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	return
end

function var_0_0.initTplVar(arg_3_0)
	arg_3_0.btnAllTip = "blackfriday_cruise_btn_all"

	return
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0:initTplVar()
	arg_4_0:UpdateActivity()

	local var_4_0 = arg_4_0._tf:Find("frame")

	arg_4_0.nextAwardTF = var_4_0:Find("next")
	arg_4_0.btnAll = var_4_0:Find("btns/btn_all")

	setText(arg_4_0.btnAll:Find("Text"), i18n(arg_4_0.btnAllTip))

	arg_4_0.scrollCom = GetComponent(var_4_0:Find("view/content"), "LScrollRect")

	function arg_4_0.scrollCom.onUpdateItem(arg_5_0, arg_5_1)
		arg_4_0:UpdateAwardInfo(arg_5_0, tf(arg_5_1), arg_4_0.awardList[arg_5_0 + 1])

		return
	end

	return
end

function var_0_0.OnInit(arg_6_0)
	onButton(arg_6_0, arg_6_0.btnAll, function()
		arg_6_0:GetAllAward()

		return
	end, SFX_CONFIRM)
	arg_6_0.scrollCom.onValueChanged:RemoveAllListeners()
	pg.DelegateInfo.Add(arg_6_0, arg_6_0.scrollCom.onValueChanged)
	arg_6_0.scrollCom.onValueChanged:AddListener(function(arg_8_0)
		arg_6_0:UpdateNextAward(arg_8_0.x)

		return
	end)

	return
end

function var_0_0.Flush(arg_9_0, arg_9_1)
	arg_9_0:Show()

	if arg_9_1 then
		arg_9_0:UpdateActivity(arg_9_1)
	end

	arg_9_0.scrollCom:SetTotalCount(#arg_9_0.awardList)
	arg_9_0:BuildPhaseAwardScrollPos()

	arg_9_0.nextAwardIndex = nil

	local var_9_0 = #arg_9_0.activity:GetHei5UnreceiveAward() > 0

	setGray(arg_9_0.btnAll, not var_9_0)

	local var_9_1 = var_9_0 and Color.NewHex("#ffffff") or Color.NewHex("#7df39f")

	setTextColor(arg_9_0.btnAll:Find("Text"), var_9_1)
	setButtonEnabled(arg_9_0.btnAll, var_9_0)
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

function var_0_0.UpdateAwardInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.id < 10 then
		setText(arg_12_2:Find("Text"), "0" .. arg_12_3.id)
	else
		setText(arg_12_2:Find("Text"), arg_12_3.id)
	end

	local var_12_0 = arg_12_3.pt <= arg_12_0.pt
	local var_12_1 = Drop.Create(arg_12_3.award)

	var_12_1.desc = cancelColorRich(var_12_1.desc)

	onButton(arg_12_0, arg_12_2:Find("base"), function()
		arg_12_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_12_1
		})

		return
	end, SFX_CONFIRM)
	setActive(arg_12_2:Find("base/lock"), not var_12_0)
	updateDrop(arg_12_2:Find("base/mask/IconTpl"), var_12_1)
	setActive(arg_12_2:Find("base/get"), var_12_0 and not arg_12_0.awardDic[arg_12_3.pt])
	setActive(arg_12_2:Find("base/got"), arg_12_0.awardDic[arg_12_3.pt])

	local var_12_2 = Drop.Create(arg_12_3.award_pay)

	onButton(arg_12_0, arg_12_2:Find("pay"), function()
		arg_12_0:emit(BaseUI.ON_NEW_STYLE_DROP, {
			drop = var_12_2
		})

		return
	end, SFX_CONFIRM)
	updateDrop(arg_12_2:Find("pay/mask/IconTpl"), var_12_2)
	setActive(arg_12_2:Find("pay/no_pay"), not arg_12_0.isPay and not arg_12_0:IsSpecialMask(var_12_2.type))

	local var_12_3 = arg_12_0.isPay and var_12_0 and not arg_12_0.awardPayDic[arg_12_3.pt]

	setActive(arg_12_2:Find("pay/get"), var_12_3)
	setActive(arg_12_2:Find("pay/got"), arg_12_0.awardPayDic[arg_12_3.pt])

	return
end

function var_0_0.UpdateNextAward(arg_15_0, arg_15_1)
	if not arg_15_0.nextPhasePos then
		return
	end

	local var_15_0 = arg_15_0.nextPhasePos[#arg_15_0.nextPhasePos] - 1
	local var_15_1 = #arg_15_0.awardList

	for iter_15_0 = #arg_15_0.awardList - 1, 1, -1 do
		if arg_15_0.nextPhasePos[iter_15_0] < arg_15_1 + var_15_0 or arg_15_0.awardList[iter_15_0].pt <= arg_15_0.pt then
			break
		elseif arg_15_0.awardList[iter_15_0].isImportent then
			var_15_1 = iter_15_0
		end
	end

	arg_15_0:UpdateAwardInfo(arg_15_0.nextAwardIndex, arg_15_0.nextAwardTF, arg_15_0.awardList[var_15_1])

	return
end

function var_0_0.GetAllAward(arg_16_0)
	local var_16_0 = arg_16_0.activity:GetHei5UnreceiveAward()

	if #var_16_0 > 0 then
		if arg_16_0:CheckLimitMax(var_16_0) then
			table.insert({}, function(arg_17_0)
				pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
					contentText = i18n("player_expResource_mail_fullBag"),
					onConfirm = arg_17_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_16_0:emit(PSSHei5Mediator.EVENT_GET_AWARD_ALL)

			return
		end)
	end

	return
end

function var_0_0.CheckLimitMax(arg_19_0, arg_19_1)
	local var_19_0 = getProxy(PlayerProxy):getData()

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		if iter_19_1.type == DROP_TYPE_RESOURCE then
			if iter_19_1.id == 1 then
				if var_19_0:GoldMax(iter_19_1.count) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

					return true
				end
			elseif iter_19_1.id == 2 and var_19_0:OilMax(iter_19_1.count) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

				return true
			end
		elseif iter_19_1.type == DROP_TYPE_ITEM then
			local var_19_1 = Item.getConfigData(iter_19_1.id)

			if var_19_1.type == Item.EXP_BOOK_TYPE then
				local var_19_2 = getProxy(BagProxy)

				if var_19_2:getItemCountById(iter_19_1.id) + iter_19_1.count > var_19_1.max_num then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.OnDestroy(arg_20_0)
	return
end

return var_0_0
