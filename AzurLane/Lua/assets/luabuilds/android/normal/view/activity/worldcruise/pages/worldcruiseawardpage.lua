class = var_0_10000

local var_0_0 = "WorldCruiseAwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldCruiseAwardPage"
end

function var_0_1.UpdateActivity(arg_2_0, arg_2_1)
	local var_2_1

	if not arg_2_1 then
		::label_2_0::

		getProxy = var_2_1
		ActivityProxy = var_1_10003

		local var_2_0 = var_2_1(var_1_10003)

		var_2_1 = var_2_1.getAliveActivityByType
		ActivityConst = var_1_10004
		var_2_1 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_PT_CRUSING)
	end

	arg_2_0.activity = var_2_1
	pairs = var_2_1

	local var_2_2 = arg_2_0.activity

	for iter_2_0, iter_2_1 in var_2_1(var_3.GetCrusingInfo(var_2_2)) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	return
end

function var_0_1.OnLoaded(arg_3_0)
	arg_3_0:UpdateActivity()

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "frame")

	arg_3_0.nextAwardTF = var_1.Find(var_3_1, "next")
	arg_3_0.btnAll = var_1:Find("btns/btn_all")
	setText = var_2

	local var_3_2 = arg_3_0.btnAll
	local var_3_3 = var_3.Find(var_3_2, "Text")

	i18n = var_3_2

	var_2(var_3_3, var_3_2("cruise_btn_all"))

	arg_3_0.btnPay = var_1:Find("btns/btn_pay")
	setText = var_2

	local var_3_4 = arg_3_0.btnPay
	local var_3_5 = var_3.Find(var_3_4, "Text")

	i18n = var_3_4

	var_2(var_3_5, var_3_4("cruise_btn_pay"))

	GetComponent = var_2
	arg_3_0.scrollCom = var_2(var_1:Find("view/content"), "LScrollRect")

	function arg_3_0.scrollCom.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0
		local var_4_1 = var_2.UpdateAwardInfo
		local var_4_2 = arg_4_0

		tf = var_2_10005

		var_4_1(var_4_0, var_4_2, var_2_10005(arg_4_1), arg_3_0.awardList[arg_4_0 + 1])

		return
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.btnAll

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.GetAllAward(var_6_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.btnPay

	local function var_5_5()
		local var_7_0 = arg_5_0.contextData.windowForCharge

		var_0.ExecuteAction(var_7_0, "ShowBuyWindow")

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	local var_5_6 = arg_5_0.scrollCom.onValueChanged

	var_1.RemoveAllListeners(var_5_6)

	pg = var_2

	var_2.DelegateInfo.Add(arg_5_0, var_1)
	var_1:AddListener(function(arg_8_0)
		local var_8_0 = arg_5_0

		var_1.UpdateNextAward(var_8_0, arg_8_0.x)

		return
	end)

	return
end

function var_0_1.Flush(arg_9_0, arg_9_1)
	arg_9_0:Show()

	if arg_9_1 then
		arg_9_0:UpdateActivity(arg_9_1)
	end

	local var_9_0 = arg_9_0.scrollCom

	var_2.SetTotalCount(var_9_0, #arg_9_0.awardList - 1)
	arg_9_0:BuildPhaseAwardScrollPos()

	if arg_9_0.phase == 0 then
		local var_9_1 = arg_9_0.scrollCom

		var_2.ScrollTo(var_9_1, 0)
	elseif arg_9_0.phase == #arg_9_0.awardList then
		local var_9_2 = arg_9_0.scrollCom

		var_2.ScrollTo(var_9_2, 1)
	else
		local var_9_3 = arg_9_0.scrollCom
		local var_9_4 = var_2.ScrollTo

		math = var_4

		var_9_4(var_9_3, var_4.clamp(arg_9_0.phasePos[arg_9_0.phase], 0, 1), true)
	end

	arg_9_0.nextAwardIndex = nil

	local var_9_5 = arg_9_0.activity
	local var_9_6 = #var_2.GetCrusingUnreceiveAward(var_9_5)
	local var_9_7 = 0 < var_9_6

	setActive = var_3

	var_3(arg_9_0.btnAll, var_9_7)

	setActive = var_3

	var_3(arg_9_0.btnPay, not arg_9_0.isPay)

	if not arg_9_0.isPay then
		WorldCruiseChargePage = var_3

		local var_9_8 = var_3.GetPassID()

		pg = var_4

		local var_9_9 = var_4.TimeMgr.GetInstance()
		local var_9_10 = var_4.inTime

		pg = var_1_10006

		if not var_9_10(var_9_9, var_1_10006.pay_data_display[var_9_8].time) then
			setActive = var_9_9

			var_9_9(arg_9_0.btnPay, false)
		end
	end

	arg_9_0:UpdateNextAward(arg_9_0.scrollCom.value)

	return
end

function var_0_1.BuildPhaseAwardScrollPos(arg_10_0)
	if arg_10_0.phasePos then
		return
	end

	arg_10_0.phasePos = {}
	arg_10_0.nextPhasePos = {}

	local var_10_0 = arg_10_0.scrollCom
	local var_10_1 = var_1.HeadIndexToValue(var_10_0, #arg_10_0.awardList)
	local var_10_2 = arg_10_0.scrollCom
	local var_10_3 = var_10_1 - var_2.HeadIndexToValue(var_10_2, 0)
	local var_10_4 = arg_10_0.scrollCom
	local var_10_5 = var_2.HeadIndexToValue(var_10_4, #arg_10_0.awardList - 6)
	local var_10_6 = arg_10_0.scrollCom
	local var_10_7 = var_10_5 - var_3.HeadIndexToValue(var_10_6, 0)

	for iter_10_0 = 1, #arg_10_0.awardList - 1 do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_10_8 = arg_10_0.phasePos
		local var_10_9 = arg_10_0.scrollCom

		var_1_10007(var_10_8, var_9.HeadIndexToValue(var_10_9, iter_10_0 - 1) / var_10_3)

		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_10_10 = arg_10_0.nextPhasePos
		local var_10_11 = arg_10_0.scrollCom

		var_1_10007(var_10_10, var_9.HeadIndexToValue(var_10_11, iter_10_0 - 1) / var_10_7)
	end

	return
end

function var_0_1.IsSpecialMask(arg_11_0, arg_11_1)
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002

	local var_11_0

	if arg_11_1 ~= var_1_10002 then
		DROP_TYPE_SKIN = var_1_10002

		if arg_11_1 ~= var_1_10002 then
			DROP_TYPE_EQUIPMENT_SKIN = var_1_10002

			if arg_11_1 ~= var_1_10002 then
				var_11_0 = false

				goto label_11_0
			end
		end
	end

	var_11_0 = true

	::label_11_0::

	return var_11_0
end

function var_0_1.IsSkinFrame(arg_12_0, arg_12_1)
	DROP_TYPE_SKIN = var_1_10002

	local var_12_0

	if arg_12_1 ~= var_1_10002 then
		DROP_TYPE_EQUIPMENT_SKIN = var_1_10002

		if arg_12_1 ~= var_1_10002 then
			var_12_0 = false

			goto label_12_0
		end
	end

	var_12_0 = true

	::label_12_0::

	return var_12_0
end

function var_0_1.IsBattleUIFrame(arg_13_0, arg_13_1)
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002

	return arg_13_1 == var_1_10002
end

function var_0_1.UpdateAwardInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2:Find("bg_cur") then
		setActive = var_4

		var_4(arg_14_2:Find("bg_cur"), arg_14_1 + 2 == arg_14_0.phase)
	end

	setText = var_4

	var_4(arg_14_2:Find("Text"), arg_14_3.id)

	local var_14_0 = arg_14_3.pt <= arg_14_0.pt

	Drop = var_5

	local var_14_1 = var_5.Create(arg_14_3.award)

	onButton = var_6

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_2:Find("base")

	local function var_14_4()
		local var_15_0 = arg_14_0
		local var_15_1 = var_0.emit

		BaseUI = var_2_10002

		var_15_1(var_15_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_14_1
		})

		return
	end

	SFX_CONFIRM = var_10

	var_6(var_14_2, var_14_3, var_14_4, var_10)

	updateDrop = var_6

	var_6(arg_14_2:Find("base/mask/IconTpl"), var_14_1)

	setActive = var_6

	var_6(arg_14_2:Find("base/frame_skin"), arg_14_0:IsSkinFrame(var_14_1.type))

	setActive = var_6

	var_6(arg_14_2:Find("base/frame_ui"), arg_14_0:IsBattleUIFrame(var_14_1.type))

	setActive = var_6

	var_6(arg_14_2:Find("base/lock"), not var_14_0)

	setActive = var_6

	var_6(arg_14_2:Find("base/get"), var_14_0 and not arg_14_0.awardDic[arg_14_3.pt])

	setActive = var_6

	local var_14_5 = arg_14_2:Find("base/got")
	local var_14_6

	if arg_14_0.awardDic[arg_14_3.pt] then
		var_14_6 = not arg_14_0:IsSpecialMask(var_14_1.type)
	end

	var_6(var_14_5, var_14_6)

	setActive = var_6

	local var_14_7 = arg_14_2:Find("base/got_frame")
	local var_14_8

	if arg_14_0.awardDic[arg_14_3.pt] then
		var_14_8 = arg_14_0:IsSpecialMask(var_14_1.type)
	end

	var_6(var_14_7, var_14_8)

	Drop = var_6

	local var_14_9 = var_6.Create(arg_14_3.award_pay)

	onButton = var_7

	local var_14_10 = arg_14_0
	local var_14_11 = arg_14_2:Find("pay")

	local function var_14_12()
		local var_16_0 = arg_14_0
		local var_16_1 = var_0.emit

		BaseUI = var_2_10002

		var_16_1(var_16_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_14_9
		})

		return
	end

	SFX_CONFIRM = var_11

	var_7(var_14_10, var_14_11, var_14_12, var_11)

	updateDrop = var_7

	var_7(arg_14_2:Find("pay/mask/IconTpl"), var_14_9)

	setActive = var_7

	var_7(arg_14_2:Find("pay/frame_skin"), arg_14_0:IsSkinFrame(var_14_9.type))

	setActive = var_7

	var_7(arg_14_2:Find("pay/frame_ui"), arg_14_0:IsBattleUIFrame(var_14_9.type))

	setActive = var_7

	var_7(arg_14_2:Find("pay/no_pay"), not arg_14_0.isPay and not arg_14_0:IsSpecialMask(var_14_9.type))

	setActive = var_7

	var_7(arg_14_2:Find("pay/no_pay_frame"), not arg_14_0.isPay and arg_14_0:IsSpecialMask(var_14_9.type))

	setActive = var_7

	var_7(arg_14_2:Find("pay/lock"), not var_14_0 or not arg_14_0.isPay)

	setActive = var_7

	local var_14_13 = arg_14_2:Find("pay/get")
	local var_14_14

	if arg_14_0.isPay then
		var_14_14 = var_14_0 and not arg_14_0.awardPayDic[arg_14_3.pt]
	end

	var_7(var_14_13, var_14_14)

	setActive = var_7

	local var_14_15 = arg_14_2:Find("pay/got")
	local var_14_16

	if arg_14_0.awardPayDic[arg_14_3.pt] then
		var_14_16 = not arg_14_0:IsSpecialMask(var_14_9.type)
	end

	var_7(var_14_15, var_14_16)

	setActive = var_7

	local var_14_17 = arg_14_2:Find("pay/got_frame")
	local var_14_18

	if arg_14_0.awardPayDic[arg_14_3.pt] then
		var_14_18 = arg_14_0:IsSpecialMask(var_14_9.type)
	end

	var_7(var_14_17, var_14_18)

	return
end

function var_0_1.UpdateNextAward(arg_17_0, arg_17_1)
	if not arg_17_0.nextPhasePos then
		return
	end

	local var_17_0 = arg_17_0.nextPhasePos[#arg_17_0.nextPhasePos] - 1

	for iter_17_0 = #arg_17_0.awardList - 1, 1, -1 do
		local var_17_1 = arg_17_0.awardList[iter_17_0]
		local var_17_2

		if arg_17_0.nextPhasePos[iter_17_0] < arg_17_1 + var_17_0 or var_17_1.pt <= arg_17_0.pt then
			break
		elseif var_17_1.isImportent then
			var_17_2 = iter_17_0
		end
	end

	if arg_17_0.nextAwardIndex ~= var_17_2 then
		arg_17_0.nextAwardIndex = var_17_2

		arg_17_0:UpdateAwardInfo(arg_17_0.nextAwardIndex, arg_17_0.nextAwardTF, arg_17_0.awardList[var_17_2])
	end

	return
end

function var_0_1.GetAllAward(arg_18_0)
	local var_18_0 = arg_18_0.activity

	if #var_1.GetCrusingUnreceiveAward(var_18_0) > 0 then
		local var_18_1 = {}

		if arg_18_0:CheckLimitMax(var_1) then
			table = var_3

			var_3.insert(var_18_1, function(arg_19_0)
				pg = var_2_10001

				local var_19_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
				local var_19_1 = var_1.Show

				pg = var_2_10003

				local var_19_2 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
				local var_19_3 = {}

				i18n = var_2_10005
				var_19_3.contentText = var_2_10005("player_expResource_mail_fullBag")
				var_19_3.onConfirm = arg_19_0

				var_19_1(var_19_0, var_19_2, var_19_3)

				return
			end)
		end

		seriesAsync = var_3

		var_3(var_18_1, function()
			local var_20_0 = arg_18_0
			local var_20_1 = var_0.emit

			WorldCruiseMediator = var_2_10002

			var_20_1(var_20_0, var_2_10002.EVENT_GET_AWARD_ALL)

			return
		end)
	end

	return
end

function var_0_1.CheckLimitMax(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_21_0 = var_1_10002(var_1_10003)
	local var_21_1 = var_2.getData(var_21_0)

	ipairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(arg_21_1) do
		local var_21_2 = iter_21_1.type

		DROP_TYPE_RESOURCE = var_1_10009

		if var_21_2 == var_1_10009 then
			if iter_21_1.id == 1 then
				var_1_10009 = var_21_1

				if var_21_1.GoldMax(var_1_10009, iter_21_1.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_21_3 = var_8.ShowTips

					i18n = var_1_10010

					var_21_3(var_1_10009, var_1_10010("gold_max_tip_title"))

					return true
				end
			elseif iter_21_1.id == 2 then
				var_1_10009 = var_21_1

				if var_21_1.OilMax(var_1_10009, iter_21_1.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_21_4 = var_8.ShowTips

					i18n = var_1_10010

					var_21_4(var_1_10009, var_1_10010("oil_max_tip_title"))

					return true
				end
			end
		else
			local var_21_5 = iter_21_1.type

			DROP_TYPE_ITEM = var_1_10009

			if var_21_5 == var_1_10009 then
				Item = var_21_5
				var_1_10009 = var_21_5.getConfigData(iter_21_1.id).type
				Item = var_1_10010

				if var_1_10009 == var_1_10010.EXP_BOOK_TYPE then
					getProxy = var_1_10009
					BagProxy = var_1_10010
					var_1_10010 = var_1_10009(var_1_10010)
					var_1_10009 = var_1_10009.getItemCountById(var_1_10010, iter_21_1.id) + iter_21_1.count

					if var_8.max_num < var_1_10009 then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_1.OnDestroy(arg_22_0)
	return
end

return var_0_1
