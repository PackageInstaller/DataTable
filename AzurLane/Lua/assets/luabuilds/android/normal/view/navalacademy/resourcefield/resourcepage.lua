class = var_0_10000

local var_0_0 = "ResourcePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ResourcePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/title/text")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/title/icon")
	local var_2_5 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_2_0.iconImg = var_2_5(var_2_4, var_3(var_1_10004))

	local var_2_6 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_6, "frame/btnBack")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "frame/content/describe/class")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.descTxt = var_2_9(var_2_8, var_3(var_1_10004))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "frame/title/icon/current")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.levelTxt = var_2_12(var_2_11, var_3(var_1_10004))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "frame/content/info/level/curr")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.currentLevelTxt = var_2_15(var_2_14, var_3(var_1_10004))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "frame/content/info/level/next")
	local var_2_18 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.nextLevelTxt = var_2_18(var_2_17, var_3(var_1_10004))

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_1.Find(var_2_19, "frame/content/upgrade_btn/cost")
	local var_2_21 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.costTxt = var_2_21(var_2_20, var_3(var_1_10004))

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_1.Find(var_2_22, "frame/upgrade_duration/Text")
	local var_2_24 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.spendTimeTxt = var_2_24(var_2_23, var_3(var_1_10004))

	local var_2_25 = arg_2_0._tf

	arg_2_0.upgradeBtn = var_1.Find(var_2_25, "frame/content/upgrade_btn")

	local var_2_26 = arg_2_0._tf

	arg_2_0.upgradingBtn = var_1.Find(var_2_26, "frame/content/upgrading_block")
	UIItemList = var_1

	local var_2_27 = var_1.New
	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_2.Find(var_2_28, "frame/content/info/conent")
	local var_2_30 = arg_2_0._tf

	arg_2_0.attrUIlist = var_2_27(var_2_29, var_3.Find(var_2_30, "frame/content/info/conent/tpl"))
	setText = var_1

	local var_2_31 = arg_2_0.upgradeBtn
	local var_2_32 = var_2.Find(var_2_31, "Image")

	i18n = var_2_31

	var_1(var_2_32, var_2_31("word_levelup"))

	setText = var_1

	local var_2_33 = arg_2_0.upgradingBtn
	local var_2_34 = var_2.Find(var_2_33, "Image")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("class_label_upgrading"))

	setText = var_1

	local var_2_35 = arg_2_0._tf
	local var_2_36 = var_2.Find(var_2_35, "frame/content/upgrade_btn/costback/label")

	i18n = var_2_35

	var_1(var_2_36, var_2_35("text_consume"))

	setText = var_1

	local var_2_37 = arg_2_0._tf
	local var_2_38 = var_2.Find(var_2_37, "frame/upgrade_duration/Image/Text")

	i18n = var_2_37

	var_1(var_2_38, var_2_37("class_label_upgradetime"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.upgradeBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		if var_0.CheckUpgrade(var_6_0) then
			local var_6_1 = arg_3_0

			var_0.OnUpgrade(var_6_1)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	local var_3_9 = arg_3_0.attrUIlist

	var_1.make(var_3_9, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_3_0

			var_3.UpdateResourceFieldAttr(var_7_0, arg_3_0.attrs[arg_7_1 + 1], arg_7_2)
		end

		return
	end)

	return
end

function var_0_1.Flush(arg_8_0, arg_8_1)
	arg_8_0:Update(arg_8_1)
	arg_8_0:Show()

	return
end

function var_0_1.Update(arg_9_0, arg_9_1)
	arg_9_0.resourceField = arg_9_1

	arg_9_0:Refresh()

	return
end

function var_0_1.CheckUpgrade(arg_10_0)
	local var_10_0 = arg_10_0.resourceField

	if not var_1.CanUpgrade(var_10_0) then
		local var_10_1 = arg_10_0.resourceField

		if var_1.IsMaxLevel(var_10_1) then
			pg = var_1

			local var_10_2 = var_1.TipsMgr.GetInstance()
			local var_10_3 = var_1.ShowTips

			i18n = var_1_10003

			var_10_3(var_10_2, var_1_10003("class_res_maxlevel_tip"))
		else
			local var_10_4 = arg_10_0.resourceField

			if not var_1.IsReachLevel(var_10_4) then
				pg = var_1

				local var_10_5 = var_1.TipsMgr.GetInstance()
				local var_10_6 = var_1.ShowTips

				i18n = var_1_10003
				var_1_10004 = "common_limit_level"
				var_1_10006 = arg_10_0.resourceField

				var_10_6(var_10_5, var_1_10003(var_1_10004, var_5.GetTargetLevel(var_1_10006)))
			else
				local var_10_7 = arg_10_0.resourceField

				if not var_1.IsReachRes(var_10_7) then
					local var_10_8 = arg_10_0.resourceField
					local var_10_9 = var_1.GetTargetRes(var_10_8)

					getProxy = var_10_8
					PlayerProxy = var_1_10003

					local var_10_10 = var_10_8(var_1_10003)
					local var_10_11 = var_2.getRawData(var_10_10).gold

					GoShoppingMsgBox = var_10_10
					i18n = var_1_10004

					local var_10_12 = "switch_to_shop_tip_2"

					i18n = var_1_10006

					local var_10_13 = var_1_10004(var_10_12, var_1_10006("word_gold"))

					ChargeScene = var_10_12

					var_10_10(var_10_13, var_10_12.TYPE_ITEM, {
						{
							59001,
							var_10_9 - var_10_11,
							var_10_9
						}
					})
				end
			end
		end

		return false
	end

	return true
end

function var_0_1.OnUpgrade(arg_11_0)
	local var_11_0 = arg_11_0.resourceField
	local var_11_1 = var_1.GetUpgradeType(var_11_0)
	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.emit

	NavalAcademyMediator = var_1_10004

	var_11_3(var_11_2, var_1_10004.UPGRADE_FIELD, var_11_1)

	return
end

function var_0_1.Refresh(arg_12_0)
	local var_12_0 = arg_12_0.resourceField
	local var_12_1 = var_1.GetKeyWord(var_12_0)
	local var_12_2 = arg_12_0.iconImg

	GetSpriteFromAtlas = var_1_10004
	var_12_2.sprite = var_1_10004("ui/ResourceFieldUI_atlas", var_12_1)
	arg_12_0.titleTxt.text = var_1:GetName()

	local var_12_3 = arg_12_0.resourceField

	arg_12_0.descTxt.text = var_12_3:GetDesc()

	local var_12_4 = "Lv." .. var_12_3:GetLevel()

	arg_12_0.levelTxt.text = var_12_4

	local var_12_5 = var_12_3:IsMaxLevel() and "Lv.Max" or "Lv." .. var_12_3:GetLevel() + 1

	arg_12_0.currentLevelTxt.text = var_12_4
	arg_12_0.nextLevelTxt.text = var_12_5

	local var_12_6 = var_5 and "-" or var_12_3:GetCost().count

	if var_12_3:IsReachRes() then
		COLOR_WHITE = var_8

		if not var_8 then
			COLOR_RED = var_8
		end

		arg_12_0.costTxt.text = "<color=" .. var_8 .. ">" .. var_12_6 .. "</color>"

		arg_12_0:FlushState()

		return
	end
end

function var_0_1.FlushState(arg_13_0)
	local var_13_0 = arg_13_0.resourceField
	local var_13_1 = var_1.IsMaxLevel(var_13_0)
	local var_13_2 = var_1
	local var_13_3 = var_1.IsStarting(var_13_2)

	setActive = var_13_2

	var_13_2(arg_13_0.upgradeBtn, not var_13_3)

	setActive = var_13_2

	var_13_2(arg_13_0.upgradingBtn, var_13_3)

	setGray = var_13_2

	var_13_2(arg_13_0.upgradeBtn, var_13_1, true)
	arg_13_0:RemoveTimer()

	if var_13_3 then
		arg_13_0:AddTimer()
	else
		local var_13_4

		if var_13_1 then
			var_13_4 = "-"
		else
			pg = var_13_4

			local var_13_5 = var_13_4.TimeMgr.GetInstance()

			var_13_4 = var_13_4.DescCDTime(var_13_5, var_1:GetSpendTime())
		end

		arg_13_0.spendTimeTxt.text = var_13_4
	end

	arg_13_0:UpdateResourceFieldAttrs()

	return
end

function var_0_1.UpdateResourceFieldAttrs(arg_14_0)
	local var_14_0 = arg_14_0.resourceField

	arg_14_0.attrs = var_1.GetEffectAttrs(var_14_0)

	local var_14_1 = arg_14_0.attrUIlist

	var_2.align(var_14_1, #arg_14_0.attrs)

	return
end

function var_0_1.UpdateResourceFieldAttr(arg_15_0, arg_15_1, arg_15_2)
	setText = var_1_10003

	var_1_10003(arg_15_2:Find("label"), arg_15_1:GetName())

	setText = var_1_10003

	var_1_10003(arg_15_2:Find("advance"), "[+" .. arg_15_1:GetAdditionDesc() .. "]")

	local var_15_0 = arg_15_1:GetValue()
	local var_15_1 = arg_15_1:GetNextValue()
	local var_15_2 = arg_15_1
	local var_15_3 = arg_15_1.GetMaxValue(var_15_2)

	setFillAmount = var_15_2

	var_15_2(arg_15_2:Find("curr"), var_15_0 / var_15_3)

	setFillAmount = var_15_2

	var_15_2(arg_15_2:Find("prev"), var_15_1 / var_15_3)

	LeanTween = var_15_2

	local var_15_4 = var_15_2.cancel

	go = var_7

	var_15_4(var_7(arg_15_2:Find("prev")))

	blinkAni = var_15_4

	local var_15_5 = var_15_4(arg_15_2:Find("prev"), 0.8, -1, 0.3)

	var_6.setFrom(var_15_5, 1)

	setText = var_6

	var_6(arg_15_2:Find("current"), arg_15_1:GetProgressDesc())

	return
end

function var_0_1.AddTimer(arg_16_0)
	local var_16_0 = arg_16_0.resourceField
	local var_16_1 = var_1.GetUpgradeTimeStamp(var_16_0)

	pg = var_16_0

	local var_16_2 = var_16_0.TimeMgr.GetInstance()

	if var_3.GetServerTime(var_16_2) < var_16_1 then
		Timer = var_3
		arg_16_0.timer = var_3.New(function()
			local var_17_0 = var_16_1

			pg = var_2_10001

			local var_17_1 = var_2_10001.TimeMgr.GetInstance()

			if var_17_0 - var_1.GetServerTime(var_17_1) <= 0 then
				var_17_1 = arg_16_0

				var_1.RemoveTimer(var_17_1)
			end

			local var_17_2 = arg_16_0.spendTimeTxt

			pg = var_17_1

			local var_17_3 = var_17_1.TimeMgr.GetInstance()

			var_17_2.text = var_2.DescCDTime(var_17_3, var_0)

			return
		end, 1, -1)

		local var_16_3 = arg_16_0.timer

		var_3.Start(var_16_3)
		arg_16_0.timer.func()
	end

	return
end

function var_0_1.RemoveTimer(arg_18_0)
	if arg_18_0.timer then
		local var_18_0 = arg_18_0.timer

		var_1.Stop(var_18_0)

		arg_18_0.timer = nil
	end

	return
end

function var_0_1.Show(arg_19_0)
	if not arg_19_0.isOpen then
		var_0_1.super.Show(arg_19_0)

		pg = var_1

		local var_19_0 = var_1.UIMgr.GetInstance()

		var_1.BlurPanel(var_19_0, arg_19_0._tf)

		arg_19_0.isOpen = true
	end

	return
end

function var_0_1.Hide(arg_20_0)
	if arg_20_0.isOpen then
		arg_20_0.isOpen = false

		var_0_1.super.Hide(arg_20_0)

		pg = var_1

		local var_20_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_20_0, arg_20_0._tf, arg_20_0._parentTf)
	end

	return
end

function var_0_1.OnDestroy(arg_21_0)
	arg_21_0:Hide()
	arg_21_0:RemoveTimer()

	return
end

return var_0_1
