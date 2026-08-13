class = var_0_10000

local var_0_0 = "CommissionInfoLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	if var_1.IsMellowStyle(var_1_0) then
		return "CommissionInfoUI4Mellow"
	else
		return "CommissionInfoUI"
	end

	return
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.frame = var_1.Find(var_2_0, "frame")
	arg_2_0.parentTr = arg_2_0._tf.parent

	local var_2_1 = arg_2_0.frame

	arg_2_0.resourcesTF = var_1.Find(var_2_1, "resources")

	local var_2_2 = arg_2_0.resourcesTF
	local var_2_3 = var_1.Find(var_2_2, "canteen/bubble/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.oilTF = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0.resourcesTF
	local var_2_6 = var_1.Find(var_2_5, "merchant/bubble/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.goldTF = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0.resourcesTF
	local var_2_9 = var_1.Find(var_2_8, "class/bubble/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.classTF = var_2_10(var_2_9, var_4(var_1_10006))

	local var_2_11 = arg_2_0.resourcesTF

	arg_2_0.classLockTF = var_1.Find(var_2_11, "class/lock")

	local var_2_12 = arg_2_0.resourcesTF

	arg_2_0.oilbubbleTF = var_1.Find(var_2_12, "canteen/bubble")

	local var_2_13 = arg_2_0.resourcesTF

	arg_2_0.goldbubbleTF = var_1.Find(var_2_13, "merchant/bubble")

	local var_2_14 = arg_2_0.resourcesTF

	arg_2_0.classbubbleTF = var_1.Find(var_2_14, "class/bubble")
	GetOrAddComponent = var_1

	local var_2_15 = arg_2_0.oilbubbleTF

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.oilbubbleCG = var_1(var_2_15, var_4(var_1_10006))
	GetOrAddComponent = var_1

	local var_2_16 = arg_2_0.goldbubbleTF

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.goldbubbleCG = var_1(var_2_16, var_4(var_1_10006))
	GetOrAddComponent = var_1

	local var_2_17 = arg_2_0.classbubbleTF

	typeof = var_4
	CanvasGroup = var_1_10006
	arg_2_0.classbubbleCG = var_1(var_2_17, var_4(var_1_10006))
	getProxy = var_1
	NavalAcademyProxy = var_2_17

	local var_2_18 = var_1(var_2_17)
	local var_2_19 = var_1.GetClassVO(var_2_18)
	local var_2_20 = var_1.GetResourceType(var_2_19)

	Item = var_1_10002

	local var_2_21 = var_1_10002.getConfigData(var_2_20).icon
	local var_2_22 = arg_2_0.classbubbleTF
	local var_2_23 = var_3.Find(var_2_22, "icon")
	local var_2_24 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008

	local var_2_25 = var_2_24(var_2_23, var_6(var_1_10008))

	LoadSprite = var_4
	var_2_25.sprite = var_4(var_2_21)

	local var_2_26 = arg_2_0.frame

	arg_2_0.projectContainer = var_3.Find(var_2_26, "main/content")

	local var_2_27 = {}

	CommissionInfoEventItem = var_4

	local var_2_28 = var_4.New
	local var_2_29 = arg_2_0._tf

	var_2_27[1] = var_2_28(var_6.Find(var_2_29, "frame/main/content/event"), arg_2_0)
	CommissionInfoClassItem = var_4

	local var_2_30 = var_4.New
	local var_2_31 = arg_2_0._tf

	var_2_27[2] = var_2_30(var_6.Find(var_2_31, "frame/main/content/class"), arg_2_0)
	CommissionInfoTechnologyItem = var_4

	local var_2_32 = var_4.New
	local var_2_33 = arg_2_0._tf

	var_2_27[3] = var_2_32(var_6.Find(var_2_33, "frame/main/content/technology"), arg_2_0)
	arg_2_0.items = var_2_27

	arg_2_0:BlurPanel()

	local var_2_34 = arg_2_0._tf

	arg_2_0.linkBtnPanel = var_3.Find(var_2_34, "frame/link_btns/btns")

	local var_2_35 = arg_2_0._tf

	arg_2_0.activityInsBtn = var_3.Find(var_2_35, "frame/link_btns/btns/ins")

	local var_2_36 = arg_2_0._tf

	arg_2_0.activtyUrExchangeBtn = var_3.Find(var_2_36, "frame/link_btns/btns/urEx")

	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_3.Find(var_2_37, "frame/link_btns/btns/urEx/Text")
	local var_2_39 = var_3.GetComponent

	typeof = var_6
	Text = var_2_33
	arg_2_0.activtyUrExchangeTxt = var_2_39(var_2_38, var_6(var_2_33))

	local var_2_40 = arg_2_0.activtyUrExchangeBtn
	local var_2_41 = var_3.GetComponent

	typeof = var_6
	CanvasGroup = var_2_33
	arg_2_0.activtyUrExchangeCG = var_2_41(var_2_40, var_6(var_2_33))

	local var_2_42 = arg_2_0._tf

	arg_2_0.activtyUrExchangeTip = var_3.Find(var_2_42, "frame/link_btns/btns/urEx/tip")

	local var_2_43 = arg_2_0._tf

	arg_2_0.activityCrusingBtn = var_3.Find(var_2_43, "frame/link_btns/btns/crusing")
	CommissionMetaBossBtn = var_3

	local var_2_44 = var_3.New
	local var_2_45 = arg_2_0._tf

	arg_2_0.metaBossBtn = var_2_44(var_5.Find(var_2_45, "frame/link_btns/btns/meta_boss"), arg_2_0.event)

	return
end

function var_0_1.BlurPanel(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.UnBlurPanel(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf, arg_4_0.parentTr)

	return
end

function var_0_1.UpdataClassUnlock(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.SystemOpenMgr.GetInstance()
	local var_5_1 = var_1.isOpenSystem(var_5_0, arg_5_0.playerVO.level, "ClassMediator")

	setActive = var_1_10002

	var_1_10002(arg_5_0.classLockTF, not var_5_1)

	return
end

function var_0_1.UpdateUrItemEntrance(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.SystemOpenMgr.GetInstance()

	if var_1.isOpenSystem(var_6_0, arg_6_0.playerVO.level, "FragmentShop") then
		LOCK_UR_SHIP = var_1_10002

		if not var_1_10002 then
			pg = var_1_10002

			local var_6_1 = var_1_10002.gameset.urpt_chapter_max.description[1]
			local var_6_2 = var_1_10002[2]

			getProxy = var_5
			BagProxy = var_1_10007

			local var_6_3 = var_5(var_1_10007)
			local var_6_4 = var_5.GetLimitCntById(var_6_3, var_6_1)

			arg_6_0.activtyUrExchangeTxt.text = var_6_4 .. "/" .. var_6_2

			local var_6_5 = var_6_4 == var_6_2
			local var_6_6 = arg_6_0.activtyUrExchangeCG

			var_6_6.alpha = var_6_5 and 0.6 or 1
			setActive = var_6_6

			local var_6_7 = arg_6_0.activtyUrExchangeTip

			NotifyTipHelper = var_1_10010

			var_6_6(var_6_7, var_1_10010.ShouldShowUrTip())

			onButton = var_6_6

			local var_6_8 = arg_6_0
			local var_6_9 = arg_6_0.activtyUrExchangeBtn

			local function var_6_10()
				local var_7_0 = arg_6_0
				local var_7_1 = var_0.emit

				CommissionInfoMediator = var_2_10003

				var_7_1(var_7_0, var_2_10003.ON_UR_ACTIVITY)

				return
			end

			SFX_PANEL = var_1_10012

			var_6_6(var_6_8, var_6_9, var_6_10, var_1_10012)

			goto label_6_0
		end
	end

	setActive = var_1_10002

	var_1_10002(arg_6_0.activtyUrExchangeBtn, false)

	::label_6_0::

	return
end

function var_0_1.updateCrusingEntrance(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)
	local var_8_1 = var_1.getAliveActivityByType

	ActivityConst = var_1_10004

	if var_8_1(var_8_0, var_1_10004.ACTIVITY_TYPE_PT_CRUSING) and not var_1:isEnd() then
		setActive = var_1_10002

		var_1_10002(arg_8_0.activityCrusingBtn, true)

		local var_8_2 = var_1

		var_1_10002 = var_1.GetCrusingInfo(var_8_2)

		local var_8_3 = var_1.stopTime

		pg = var_8_2

		local var_8_4 = var_8_2.TimeMgr.GetInstance()
		local var_8_5 = var_8_3 - var_4.GetServerTime(var_8_4)

		math = var_4

		local var_8_6 = var_4.floor(var_8_5 / 0)

		pg = var_5

		if var_8_6 <= var_5.gameset.world_cruise_due_days.key_value then
			setActive = var_5

			local var_8_7 = arg_8_0.activityCrusingBtn

			var_5(var_1_10007.Find(var_8_7, "LastDay"), true)

			setText = var_5

			local var_8_8 = arg_8_0.activityCrusingBtn

			var_1_10007 = var_1_10007.Find(var_8_8, "LastDay/text")
			i18n = var_8

			var_5(var_1_10007, var_8("guild_left_supply_day", var_8_6))
		else
			setActive = var_5

			local var_8_9 = arg_8_0.activityCrusingBtn

			var_5(var_1_10007.Find(var_8_9, "LastDay"), false)
		end

		setText = var_5

		local var_8_10 = arg_8_0.activityCrusingBtn

		var_5(var_1_10007.Find(var_8_10, "Text"), var_1_10002.phase .. "/" .. #var_1_10002.awardList)

		setActive = var_5

		local var_8_11 = arg_8_0.activityCrusingBtn

		var_5(var_1_10007.Find(var_8_11, "tip"), #var_1:GetCrusingUnreceiveAward() > 0)
	else
		setActive = var_1_10002

		var_1_10002(arg_8_0.activityCrusingBtn, false)
	end

	onButton = var_1_10002

	local var_8_12 = arg_8_0
	local var_8_13 = arg_8_0.activityCrusingBtn

	local function var_8_14()
		local var_9_0 = arg_8_0
		local var_9_1 = var_0.emit

		CommissionInfoMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.ON_CRUSING)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_8_12, var_8_13, var_8_14, var_1_10007)

	return
end

function var_0_1.NotifyIns(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.activityInsBtn, false)

	return
end

function var_0_1.UpdateLinkPanel(arg_11_0)
	local var_11_0 = false

	for iter_11_0 = 1, arg_11_0.linkBtnPanel.childCount do
		isActive = var_1_10006

		local var_11_1 = arg_11_0.linkBtnPanel

		if var_1_10006(var_8.GetChild(var_11_1, iter_11_0 - 1)) then
			var_11_0 = true

			break
		end
	end

	setActive = var_2

	var_2(arg_11_0.linkBtnPanel.parent, var_11_0)

	return
end

function var_0_1.didEnter(arg_12_0)
	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.oilbubbleTF

	local function var_12_2()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_13_0 = var_2_10000(var_2_10002)
		local var_13_1 = var_0.getRawData(var_13_0)
		local var_13_2 = var_0.CanGetResource

		PlayerConst = var_2_10003

		if not var_13_2(var_13_1, var_2_10003.ResOil) then
			pg = var_0

			local var_13_3 = var_0.TipsMgr.GetInstance()
			local var_13_4 = var_0.ShowTips

			i18n = var_3

			var_13_4(var_13_3, var_3("player_harvestResource_error_fullBag"))

			return
		end

		local var_13_5 = arg_12_0

		var_0.PlayGetResAnimation(var_13_5, arg_12_0.oilbubbleTF, function()
			local var_14_0 = arg_12_0
			local var_14_1 = var_0.emit

			CommissionInfoMediator = var_3_10003

			var_14_1(var_14_0, var_3_10003.GET_OIL_RES)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_12_0, var_12_1, var_12_2, var_1_10006)

	onButton = var_1_10001

	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.goldbubbleTF

	local function var_12_5()
		getProxy = var_2_10000
		PlayerProxy = var_2_10002

		local var_15_0 = var_2_10000(var_2_10002)
		local var_15_1 = var_0.getRawData(var_15_0)
		local var_15_2 = var_0.CanGetResource

		PlayerConst = var_2_10003

		if not var_15_2(var_15_1, var_2_10003.ResGold) then
			pg = var_0

			local var_15_3 = var_0.TipsMgr.GetInstance()
			local var_15_4 = var_0.ShowTips

			i18n = var_3

			var_15_4(var_15_3, var_3("player_harvestResource_error_fullBag"))

			return
		end

		local var_15_5 = arg_12_0

		var_0.PlayGetResAnimation(var_15_5, arg_12_0.goldbubbleTF, function()
			local var_16_0 = arg_12_0
			local var_16_1 = var_0.emit

			CommissionInfoMediator = var_3_10003

			var_16_1(var_16_0, var_3_10003.GET_GOLD_RES)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_12_3, var_12_4, var_12_5, var_1_10006)

	onButton = var_1_10001

	local var_12_6 = arg_12_0
	local var_12_7 = arg_12_0.classbubbleTF

	local function var_12_8()
		getProxy = var_2_10000
		NavalAcademyProxy = var_2_10002

		local var_17_0 = var_2_10000(var_2_10002)
		local var_17_1 = var_0.GetClassVO(var_17_0)

		if not var_0.CanGetRes(var_17_1) then
			pg = var_0

			local var_17_2 = var_0.TipsMgr.GetInstance()
			local var_17_3 = var_0.ShowTips

			i18n = var_2_10003

			var_17_3(var_17_2, var_2_10003("player_harvestResource_error_fullBag"))

			return
		end

		local var_17_4 = arg_12_0

		var_0.PlayGetResAnimation(var_17_4, arg_12_0.classbubbleTF, function()
			local var_18_0 = arg_12_0
			local var_18_1 = var_0.emit

			CommissionInfoMediator = var_3_10003

			var_18_1(var_18_0, var_3_10003.GET_CLASS_RES)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_12_6, var_12_7, var_12_8, var_1_10006)

	onButton = var_1_10001

	local var_12_9 = arg_12_0
	local var_12_10 = arg_12_0._tf

	local function var_12_11()
		if arg_12_0.contextData.inFinished then
			return
		end

		arg_12_0.isPaying = true

		local var_19_0 = arg_12_0

		var_0.PlayUIAnimation(var_19_0, arg_12_0._tf, "exit", function()
			local var_20_0 = arg_12_0

			var_0.emit(var_20_0, var_0_1.ON_CLOSE)

			arg_12_0.isPaying = false

			return
		end)

		return
	end

	SOUND_BACK = var_1_10006

	var_1_10001(var_12_9, var_12_10, var_12_11, var_1_10006)

	onButton = var_1_10001

	local var_12_12 = arg_12_0
	local var_12_13 = arg_12_0.classLockTF

	local function var_12_14()
		pg = var_2_10000

		local var_21_0 = var_2_10000.open_systems_limited[9]

		pg = var_2_10001

		local var_21_1 = var_2_10001.TipsMgr.GetInstance()
		local var_21_2 = var_1.ShowTips

		i18n = var_2_10004

		var_21_2(var_21_1, var_2_10004("no_open_system_tip", var_21_0.name, var_21_0.level))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_12_12, var_12_13, var_12_14, var_1_10006)
	arg_12_0:InitItems()
	arg_12_0:UpdataClassUnlock()
	arg_12_0:UpdateUrItemEntrance()
	arg_12_0:updateCrusingEntrance()

	local var_12_15 = arg_12_0.metaBossBtn

	var_1.Flush(var_12_15)

	return
end

function var_0_1.PlayGetResAnimation(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0.isPaying = true

	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_1.GetComponent

	typeof = var_1_10006
	Animation = var_1_10008

	local var_22_2 = var_22_1(var_22_0, var_1_10006(var_1_10008))
	local var_22_3 = arg_22_1
	local var_22_4 = arg_22_1.GetComponent

	typeof = var_1_10007
	DftAniEvent = var_1_10009

	local var_22_5 = var_22_4(var_22_3, var_1_10007(var_1_10009))

	var_4.SetEndEvent(var_22_5, nil)
	var_4:SetEndEvent(function()
		local var_23_0 = var_0

		var_0.SetEndEvent(var_23_0, nil)
		arg_22_2()

		arg_22_0.isPaying = false

		return
	end)
	var_22_2:Play("anim_commission_bubble_get")

	return
end

function var_0_1.InitItems(arg_24_0)
	ipairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0.items) do
		iter_24_1:Init()
	end

	return
end

function var_0_1.OnUpdateEventInfo(arg_25_0)
	local var_25_0 = arg_25_0.items[1]

	var_1.Update(var_25_0)

	return
end

function var_0_1.OnUpdateClass(arg_26_0)
	local var_26_0 = arg_26_0.items[2]

	var_1.Update(var_26_0)

	return
end

function var_0_1.OnUpdateTechnology(arg_27_0)
	local var_27_0 = arg_27_0.items[3]

	var_1.Update(var_27_0)

	return
end

function var_0_1.setPlayer(arg_28_0, arg_28_1)
	arg_28_0.playerVO = arg_28_1

	arg_28_0:UpdateOilRes(arg_28_1)
	arg_28_0:UpdateGoldRes(arg_28_1)
	arg_28_0:UpdateClassRes()

	return
end

function var_0_1.OnPlayerUpdate(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.playerVO

	if arg_29_1.oilField ~= var_29_0.oilField then
		arg_29_0:UpdateOilRes(var_3)
	end

	if var_3.goldField ~= var_29_0.goldField then
		arg_29_0:UpdateGoldRes(var_3)
	end

	if var_3.expField ~= var_29_0.expField then
		arg_29_0:UpdateClassRes()
	end

	arg_29_0.playerVO = var_3

	return
end

function var_0_1.UpdateOilRes(arg_30_0, arg_30_1)
	arg_30_0.oilbubbleCG.alpha = 1

	local var_30_0 = arg_30_0.oilbubbleTF

	Vector3 = var_3
	var_30_0.localScale = var_3.one
	setActive = var_30_0

	var_30_0(arg_30_0.oilbubbleTF, arg_30_1.oilField ~= 0)

	arg_30_0.oilTF.text = arg_30_1.oilField

	return
end

function var_0_1.UpdateGoldRes(arg_31_0, arg_31_1)
	arg_31_0.goldbubbleCG.alpha = 1

	local var_31_0 = arg_31_0.goldbubbleTF

	Vector3 = var_3
	var_31_0.localScale = var_3.one
	setActive = var_31_0

	var_31_0(arg_31_0.goldbubbleTF, arg_31_1.goldField ~= 0)

	arg_31_0.goldTF.text = arg_31_1.goldField

	return
end

function var_0_1.UpdateClassRes(arg_32_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_32_0 = var_1_10001(var_1_10003)
	local var_32_1 = var_1.GetClassVO(var_32_0)
	local var_32_2 = var_1.GetGenResCnt(var_32_1)

	arg_32_0.classbubbleCG.alpha = 1

	local var_32_3 = arg_32_0.classbubbleTF

	Vector3 = var_4
	var_32_3.localScale = var_4.one
	setActive = var_32_3

	var_32_3(arg_32_0.classbubbleTF, var_32_2 > 0)

	arg_32_0.classTF.text = var_32_2

	return
end

function var_0_1.onBackPressed(arg_33_0)
	pg = var_1_10001

	local var_33_0 = var_1_10001.CriMgr.GetInstance()
	local var_33_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10004

	var_33_1(var_33_0, var_1_10004)

	triggerButton = var_33_1

	var_33_1(arg_33_0._tf)

	return
end

function var_0_1.willExit(arg_34_0)
	arg_34_0:UnBlurPanel()

	ipairs = var_1

	for iter_34_0, iter_34_1 in var_1(arg_34_0.items) do
		iter_34_1:Dispose()
	end

	arg_34_0.items = nil

	local var_34_0 = arg_34_0.metaBossBtn

	var_1.Dispose(var_34_0)

	arg_34_0.metaBossBtn = nil

	return
end

return var_0_1
