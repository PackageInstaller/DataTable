class = var_0_10000

local var_0_0 = "PSSHei5AwardPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "PSSHei5AwardPage"
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
		var_2_1 = var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_PT_HEI5)
	end

	arg_2_0.activity = var_2_1
	pairs = var_2_1

	local var_2_2 = arg_2_0.activity

	for iter_2_0, iter_2_1 in var_2_1(var_3.GetHei5Info(var_2_2)) do
		arg_2_0[iter_2_0] = iter_2_1
	end

	return
end

function var_0_1.initTplVar(arg_3_0)
	arg_3_0.btnAllTip = "blackfriday_cruise_btn_all"

	return
end

function var_0_1.OnLoaded(arg_4_0)
	arg_4_0:initTplVar()
	arg_4_0:UpdateActivity()

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "frame")

	arg_4_0.nextAwardTF = var_1.Find(var_4_1, "next")
	arg_4_0.btnAll = var_1:Find("btns/btn_all")
	setText = var_2

	local var_4_2 = arg_4_0.btnAll
	local var_4_3 = var_3.Find(var_4_2, "Text")

	i18n = var_4_2

	var_2(var_4_3, var_4_2(arg_4_0.btnAllTip))

	GetComponent = var_2
	arg_4_0.scrollCom = var_2(var_1:Find("view/content"), "LScrollRect")

	function arg_4_0.scrollCom.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0
		local var_5_1 = var_2.UpdateAwardInfo
		local var_5_2 = arg_5_0

		tf = var_2_10005

		var_5_1(var_5_0, var_5_2, var_2_10005(arg_5_1), arg_4_0.awardList[arg_5_0 + 1])

		return
	end

	return
end

function var_0_1.OnInit(arg_6_0)
	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.btnAll

	local function var_6_2()
		local var_7_0 = arg_6_0

		var_0.GetAllAward(var_7_0)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	local var_6_3 = arg_6_0.scrollCom.onValueChanged

	var_1.RemoveAllListeners(var_6_3)

	pg = var_2

	var_2.DelegateInfo.Add(arg_6_0, var_1)
	var_1:AddListener(function(arg_8_0)
		local var_8_0 = arg_6_0

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

	var_2.SetTotalCount(var_9_0, #arg_9_0.awardList)
	arg_9_0:BuildPhaseAwardScrollPos()

	arg_9_0.nextAwardIndex = nil

	local var_9_1 = arg_9_0.activity
	local var_9_2 = #var_2.GetHei5UnreceiveAward(var_9_1)
	local var_9_3 = 0 < var_9_2

	setGray = var_3

	var_3(arg_9_0.btnAll, not var_9_3)

	setTextColor = var_3

	local var_9_4 = arg_9_0.btnAll
	local var_9_5 = var_4.Find(var_9_4, "Text")

	if var_9_3 then
		Color = var_9_4

		if not var_9_4.NewHex("#ffffff") then
			Color = var_9_4
			var_9_4 = var_9_4.NewHex("#7df39f")
		end

		var_3(var_9_5, var_9_4)

		setButtonEnabled = var_3

		var_3(arg_9_0.btnAll, var_9_3)
		arg_9_0:UpdateNextAward(arg_9_0.scrollCom.value)

		return
	end
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

function var_0_1.UpdateAwardInfo(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.id < 10 then
		setText = var_4

		var_4(arg_12_2:Find("Text"), "0" .. arg_12_3.id)
	else
		setText = var_4

		var_4(arg_12_2:Find("Text"), arg_12_3.id)
	end

	local var_12_0 = arg_12_3.pt <= arg_12_0.pt

	Drop = var_5

	local var_12_1 = var_5.Create(arg_12_3.award)

	cancelColorRich = var_6
	var_12_1.desc = var_6(var_12_1.desc)
	onButton = var_6

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_2:Find("base")

	local function var_12_4()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_12_1
		})

		return
	end

	SFX_CONFIRM = var_10

	var_6(var_12_2, var_12_3, var_12_4, var_10)

	setActive = var_6

	var_6(arg_12_2:Find("base/lock"), not var_12_0)

	updateDrop = var_6

	var_6(arg_12_2:Find("base/mask/IconTpl"), var_12_1)

	setActive = var_6

	var_6(arg_12_2:Find("base/get"), var_12_0 and not arg_12_0.awardDic[arg_12_3.pt])

	setActive = var_6

	var_6(arg_12_2:Find("base/got"), arg_12_0.awardDic[arg_12_3.pt])

	Drop = var_6

	local var_12_5 = var_6.Create(arg_12_3.award_pay)

	onButton = var_7

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_2:Find("pay")

	local function var_12_8()
		local var_14_0 = arg_12_0
		local var_14_1 = var_0.emit

		BaseUI = var_2_10002

		var_14_1(var_14_0, var_2_10002.ON_NEW_STYLE_DROP, {
			drop = var_12_5
		})

		return
	end

	SFX_CONFIRM = var_11

	var_7(var_12_6, var_12_7, var_12_8, var_11)

	updateDrop = var_7

	var_7(arg_12_2:Find("pay/mask/IconTpl"), var_12_5)

	setActive = var_7

	var_7(arg_12_2:Find("pay/no_pay"), not arg_12_0.isPay and not arg_12_0:IsSpecialMask(var_12_5.type))

	setActive = var_7

	local var_12_9 = arg_12_2:Find("pay/get")
	local var_12_10

	if arg_12_0.isPay then
		var_12_10 = var_12_0 and not arg_12_0.awardPayDic[arg_12_3.pt]
	end

	var_7(var_12_9, var_12_10)

	setActive = var_7

	var_7(arg_12_2:Find("pay/got"), arg_12_0.awardPayDic[arg_12_3.pt])

	return
end

function var_0_1.UpdateNextAward(arg_15_0, arg_15_1)
	if not arg_15_0.nextPhasePos then
		return
	end

	local var_15_0 = arg_15_0.nextPhasePos[#arg_15_0.nextPhasePos] - 1

	for iter_15_0 = #arg_15_0.awardList - 1, 1, -1 do
		local var_15_1 = arg_15_0.awardList[iter_15_0]
		local var_15_2

		if arg_15_0.nextPhasePos[iter_15_0] < arg_15_1 + var_15_0 or var_15_1.pt <= arg_15_0.pt then
			break
		elseif var_15_1.isImportent then
			var_15_2 = iter_15_0
		end
	end

	arg_15_0:UpdateAwardInfo(arg_15_0.nextAwardIndex, arg_15_0.nextAwardTF, arg_15_0.awardList[var_15_2])

	return
end

function var_0_1.GetAllAward(arg_16_0)
	local var_16_0 = arg_16_0.activity

	if #var_1.GetHei5UnreceiveAward(var_16_0) > 0 then
		local var_16_1 = {}

		if arg_16_0:CheckLimitMax(var_1) then
			table = var_3

			var_3.insert(var_16_1, function(arg_17_0)
				pg = var_2_10001

				local var_17_0 = var_2_10001.NewStyleMsgboxMgr.GetInstance()
				local var_17_1 = var_1.Show

				pg = var_2_10003

				local var_17_2 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
				local var_17_3 = {}

				i18n = var_2_10005
				var_17_3.contentText = var_2_10005("player_expResource_mail_fullBag")
				var_17_3.onConfirm = arg_17_0

				var_17_1(var_17_0, var_17_2, var_17_3)

				return
			end)
		end

		seriesAsync = var_3

		var_3(var_16_1, function()
			local var_18_0 = arg_16_0
			local var_18_1 = var_0.emit

			PSSHei5Mediator = var_2_10002

			var_18_1(var_18_0, var_2_10002.EVENT_GET_AWARD_ALL)

			return
		end)
	end

	return
end

function var_0_1.CheckLimitMax(arg_19_0, arg_19_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_19_0 = var_1_10002(var_1_10003)
	local var_19_1 = var_2.getData(var_19_0)

	ipairs = var_19_0

	for iter_19_0, iter_19_1 in var_19_0(arg_19_1) do
		local var_19_2 = iter_19_1.type

		DROP_TYPE_RESOURCE = var_1_10009

		if var_19_2 == var_1_10009 then
			if iter_19_1.id == 1 then
				var_1_10009 = var_19_1

				if var_19_1.GoldMax(var_1_10009, iter_19_1.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_19_3 = var_8.ShowTips

					i18n = var_1_10010

					var_19_3(var_1_10009, var_1_10010("gold_max_tip_title"))

					return true
				end
			elseif iter_19_1.id == 2 then
				var_1_10009 = var_19_1

				if var_19_1.OilMax(var_1_10009, iter_19_1.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_19_4 = var_8.ShowTips

					i18n = var_1_10010

					var_19_4(var_1_10009, var_1_10010("oil_max_tip_title"))

					return true
				end
			end
		else
			local var_19_5 = iter_19_1.type

			DROP_TYPE_ITEM = var_1_10009

			if var_19_5 == var_1_10009 then
				Item = var_19_5
				var_1_10009 = var_19_5.getConfigData(iter_19_1.id).type
				Item = var_1_10010

				if var_1_10009 == var_1_10010.EXP_BOOK_TYPE then
					getProxy = var_1_10009
					BagProxy = var_1_10010
					var_1_10010 = var_1_10009(var_1_10010)
					var_1_10009 = var_1_10009.getItemCountById(var_1_10010, iter_19_1.id) + iter_19_1.count

					if var_8.max_num < var_1_10009 then
						return true
					end
				end
			end
		end
	end

	return false
end

function var_0_1.OnDestroy(arg_20_0)
	return
end

return var_0_1
