class = var_0_10000

local var_0_0 = "WorldBossEntrancePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "WorldBossEntranceUI"
end

function var_0_1.Setup(arg_2_0, arg_2_1)
	arg_2_0.proxy = arg_2_1

	return
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.currentTr = var_1.Find(var_3_0, "current")

	local var_3_1 = arg_3_0._tf

	arg_3_0.pastTr = var_1.Find(var_3_1, "past")

	local var_3_2 = arg_3_0.currentTr
	local var_3_3 = var_1.Find(var_3_2, "time")
	local var_3_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.currTimeTxt = var_3_4(var_3_3, var_4(var_1_10006))

	local var_3_5 = arg_3_0.currentTr
	local var_3_6 = var_1.Find(var_3_5, "consume")
	local var_3_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.currConsumeTxt = var_3_7(var_3_6, var_4(var_1_10006))

	local var_3_8 = arg_3_0.currentTr
	local var_3_9 = var_1.Find(var_3_8, "acc")
	local var_3_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.currAccTxt = var_3_10(var_3_9, var_4(var_1_10006))

	local var_3_11 = arg_3_0.pastTr
	local var_3_12 = var_1.Find(var_3_11, "consume")
	local var_3_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.pastConsumeTxt = var_3_13(var_3_12, var_4(var_1_10006))

	local var_3_14 = arg_3_0.pastTr
	local var_3_15 = var_1.Find(var_3_14, "acc")
	local var_3_16 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.pastAccTxt = var_3_16(var_3_15, var_4(var_1_10006))

	local var_3_17 = arg_3_0._tf

	arg_3_0.currProgressTr = var_1.Find(var_3_17, "current_progress")

	local var_3_18 = arg_3_0._tf

	arg_3_0.pastProgressTr = var_1.Find(var_3_18, "past_progress")

	local var_3_19 = arg_3_0._tf
	local var_3_20 = var_1.Find(var_3_19, "current_progress/value")
	local var_3_21 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.currProgressTxt = var_3_21(var_3_20, var_4(var_1_10006))

	local var_3_22 = arg_3_0._tf
	local var_3_23 = var_1.Find(var_3_22, "past_progress/value")
	local var_3_24 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.pastProgressTxt = var_3_24(var_3_23, var_4(var_1_10006))

	local var_3_25 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_25, "blur_panel/adapt/top/back")
	WorldBossConst = var_1

	local var_3_26 = var_1.GetCurrBossGroup()
	local var_3_27 = arg_3_0._tf
	local var_3_28 = var_2.Find(var_3_27, "current")
	local var_3_29 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007

	local var_3_30 = var_3_29(var_3_28, var_5(var_1_10007))

	GetSpriteFromAtlas = var_3_25
	var_3_30.sprite = var_3_25("MetaWorldboss/" .. var_3_26, "cur")

	var_3_30:SetNativeSize()

	setText = var_3

	local var_3_31 = arg_3_0._tf
	local var_3_32 = var_5.Find(var_3_31, "tip/Text")

	i18n = var_6

	var_3(var_3_32, var_6("world_boss_item_usage_tip"))

	setText = var_3

	local var_3_33 = arg_3_0.currentTr
	local var_3_34 = var_5.Find(var_3_33, "label")

	i18n = var_6

	var_3(var_3_34, var_6("world_boss_current_boss_label"))

	setText = var_3

	local var_3_35 = arg_3_0.currentTr
	local var_3_36 = var_5.Find(var_3_35, "label1")

	i18n = var_6

	var_3(var_3_36, var_6("world_boss_current_boss_label1"))

	setText = var_3

	local var_3_37 = arg_3_0.pastTr
	local var_3_38 = var_5.Find(var_3_37, "label")

	i18n = var_6

	var_3(var_3_38, var_6("world_boss_current_boss_label"))

	setText = var_3

	local var_3_39 = arg_3_0.pastTr
	local var_3_40 = var_5.Find(var_3_39, "label1")

	i18n = var_6

	var_3(var_3_40, var_6("world_boss_current_boss_label1"))

	local var_3_41 = {}
	local var_3_42 = arg_3_0.pastTr

	var_3_41[1] = var_4.Find(var_3_42, "label")

	local var_3_43 = arg_3_0.pastTr

	var_3_41[2] = var_4.Find(var_3_43, "label1")

	local var_3_44 = arg_3_0.pastTr

	var_3_41[3] = var_4.Find(var_3_44, "label2")

	local var_3_45 = arg_3_0.pastTr

	var_3_41[4] = var_4.Find(var_3_45, "label3")
	arg_3_0.pastLabels = var_3_41

	return
end

function var_0_1.OnInit(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.backBtn

	local function var_4_2()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10003

		var_5_1(var_5_0, var_2_10003.ON_BACK)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.currentTr

	local function var_4_5()
		local var_6_0 = arg_4_0
		local var_6_1 = var_0.emit

		WorldBossScene = var_2_10003

		local var_6_2 = var_2_10003.ON_SWITCH

		WorldBossScene = var_2_10004

		var_6_1(var_6_0, var_6_2, var_2_10004.PAGE_CURRENT)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.pastTr

	local function var_4_8()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		WorldBossScene = var_2_10003

		local var_7_2 = var_2_10003.ON_SWITCH

		WorldBossScene = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.PAGE_ARCHIVES)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_6, var_4_7, var_4_8, var_1_10006)

	onButton = var_1_10001

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.currProgressTr

	local function var_4_11()
		WorldBossConst = var_2_10000

		local var_8_0 = var_2_10000.GetCurrBossItemInfo()

		pg = var_2_10001

		local var_8_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_8_2 = var_1.ShowMsgBox
		local var_8_3 = {
			hideNo = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10005
		var_8_3.type = var_2_10005
		var_8_3.name = var_8_0.name
		var_8_3.content = var_8_0.display
		var_8_3.iconPath = var_8_0.icon
		var_8_3.frame = var_8_0.rarity

		var_8_2(var_8_1, var_8_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_9, var_4_10, var_4_11, var_1_10006)

	onButton = var_1_10001

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.pastProgressTr

	local function var_4_14()
		WorldBossConst = var_2_10000

		local var_9_0 = var_2_10000.GetAchieveBossItemInfo()

		pg = var_2_10001

		local var_9_1 = var_2_10001.MsgboxMgr.GetInstance()
		local var_9_2 = var_1.ShowMsgBox
		local var_9_3 = {
			hideNo = true
		}

		MSGBOX_TYPE_DROP_ITEM = var_2_10005
		var_9_3.type = var_2_10005
		var_9_3.name = var_9_0.name
		var_9_3.content = var_9_0.display
		var_9_3.iconPath = var_9_0.icon
		var_9_3.frame = var_9_0.rarity

		var_9_2(var_9_1, var_9_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_4_12, var_4_13, var_4_14, var_1_10006)

	return
end

function var_0_1.Update(arg_10_0)
	arg_10_0:UpdateCurrent()
	arg_10_0:UpdatePast()
	arg_10_0:Show()

	return
end

function var_0_1.UpdateCurrent(arg_11_0)
	arg_11_0:ClearTimer()

	local var_11_0

	;(function()
		WorldBossConst = var_2_10000

		local var_12_0, var_12_1 = var_2_10000.GetCurrBossLeftDay()
		local var_12_2 = arg_11_0.currTimeTxt

		i18n = var_2_10003
		var_12_2.text = var_2_10003("world_boss_lefttime", var_12_0)

		if var_12_1 > 0 then
			local var_12_3 = arg_11_0

			Timer = var_3
			var_12_3.timer = var_3.New(function()
				var_0()

				return
			end, var_12_1, 1)

			local var_12_4 = arg_11_0.timer

			var_2.Start(var_12_4)
		end

		return
	end)()

	WorldBossConst = var_2

	local var_11_1, var_11_2, var_11_3 = var_2.GetCurrBossConsume()

	WorldBossConst = var_1_10005

	local var_11_4 = var_1_10005.GetCurrBossItemProgress()
	local var_11_5 = arg_11_0.currConsumeTxt

	var_11_5.text = var_11_1
	WorldBossConst = var_11_5

	local var_11_6 = var_11_5.GetCurrBossItemAcc()

	arg_11_0.currAccTxt.text = "<color=#ffdf5d>" .. var_11_6 .. "</color>/" .. var_11_2
	arg_11_0.currProgressTxt.text = var_11_4 .. "/" .. var_11_3

	return
end

function var_0_1.UpdatePast(arg_14_0)
	WorldBossConst = var_1_10001

	local var_14_0, var_14_1, var_14_2 = var_1_10001.GetAchieveBossConsume()

	WorldBossConst = var_1_10004

	local var_14_3 = var_1_10004.GetAchieveBossItemProgress()
	local var_14_4 = arg_14_0.pastProgressTxt

	var_14_4.text = var_14_3 .. "/" .. var_14_2
	WorldBossConst = var_14_4

	local var_14_5 = var_14_4.GetSummonPtOldAcc()

	WorldBossConst = var_6

	local var_14_6 = var_6.GetAchieveState()
	local var_14_7 = arg_14_0.pastTr
	local var_14_8 = var_7.GetComponent

	typeof = var_1_10010
	Image = var_1_10012

	local var_14_9 = var_14_8(var_14_7, var_1_10010(var_1_10012))
	local var_14_10
	local var_14_11 = ""

	WorldBossConst = var_10

	local var_14_12

	if var_10.ACHIEVE_STATE_STARTING == var_14_6 then
		var_14_12 = arg_14_0.pastAccTxt
		var_14_12.text = "<color=#ffdf5d>" .. var_14_5 .. "</color>/" .. var_14_1
		var_14_12 = arg_14_0.pastConsumeTxt
		var_14_12.text = var_14_0
		var_14_12 = "/"
		WorldBossConst = var_11

		local var_14_13 = var_11.BossId2MetaId

		WorldBossConst = var_13

		local var_14_14 = var_14_12 .. var_14_13(var_13.GetArchivesId())

		var_14_10 = "useitem_archives"
		GetSpriteFromAtlas = var_14_12
		var_14_9.sprite = var_14_12("MetaWorldboss" .. var_14_14, var_14_10)

		var_14_9:SetNativeSize()
	else
		var_14_12 = arg_14_0.pastAccTxt
		var_14_12.text = ""
		var_14_12 = arg_14_0.pastConsumeTxt
		var_14_12.text = ""
		WorldBossConst = var_14_12

		if var_14_12.ACHIEVE_STATE_NOSTART == var_14_6 then
			var_14_10 = "extra_unselect"
		else
			WorldBossConst = var_14_12

			if var_14_12.ACHIEVE_STATE_CLEAR == var_14_6 then
				var_14_10 = "extra_clear"
			end
		end

		LoadSprite = var_14_12
		var_14_9.sprite = var_14_12("MetaWorldboss/" .. var_14_10)

		var_14_9:SetNativeSize()
	end

	ipairs = var_14_12

	for iter_14_0, iter_14_1 in var_14_12(arg_14_0.pastLabels) do
		setActive = var_1_10015

		local var_14_15 = iter_14_1

		WorldBossConst = var_1_10018
		var_1_10018 = var_1_10018.ACHIEVE_STATE_STARTING == var_14_6

		var_1_10015(var_14_15, var_1_10018)
	end

	return
end

function var_0_1.ClearTimer(arg_15_0)
	if arg_15_0.timer then
		local var_15_0 = arg_15_0.timer

		var_1.Stop(var_15_0)

		arg_15_0.timer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_16_0)
	arg_16_0:ClearTimer()

	return
end

return var_0_1
