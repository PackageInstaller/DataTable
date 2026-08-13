class = var_0_10000

local var_0_0 = "ChargeItemPanelLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	local var_1_0

	if not arg_1_0.contextData.panelConfig.extraItems or not var_1.extraItems then
		var_1_0 = {}
	end

	if arg_1_0:ExistSkinExperienceItem(var_1_0) then
		return "ChargeItem4SkinDiscountItemUI"
	else
		return "ChargeItemPanelUI"
	end

	return
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:updatePanel()

	pg = var_1

	local var_3_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	arg_5_0.panelConfig = arg_5_0.contextData.panelConfig

	return
end

function var_0_1.initUIText(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "window/button_container/button_cancel/Image")
	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_2.Find(var_6_2, "window/button_container/button_ok/Image")

	setText = var_6_0

	local var_6_4 = var_6_1

	i18n = var_1_10006

	var_6_0(var_6_4, var_1_10006("text_cancel"))

	setText = var_6_0

	local var_6_5 = var_6_3

	i18n = var_6

	var_6_0(var_6_5, var_6("text_buy"))

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "back_sign")

	local var_7_1 = arg_7_0._tf

	arg_7_0.detailWindow = var_1.Find(var_7_1, "window")

	local var_7_2 = arg_7_0.detailWindow

	arg_7_0.cancelBtn = var_1.Find(var_7_2, "button_container/button_cancel")

	local var_7_3 = arg_7_0.detailWindow

	arg_7_0.confirmBtn = var_1.Find(var_7_3, "button_container/button_ok")

	local var_7_4 = arg_7_0.detailWindow

	arg_7_0.detailName = var_1.Find(var_7_4, "goods/mask/name/Text")

	local var_7_5 = arg_7_0.detailWindow

	arg_7_0.detailIcon = var_1.Find(var_7_5, "goods/icon")

	local var_7_6 = arg_7_0.detailWindow

	arg_7_0.detailExtraDrop = var_1.Find(var_7_6, "goods/extra_drop")

	local var_7_7 = arg_7_0.detailWindow

	arg_7_0.detailRmb = var_1.Find(var_7_7, "prince_bg/contain/icon_rmb")

	local var_7_8 = arg_7_0.detailWindow

	arg_7_0.detailGem = var_1.Find(var_7_8, "prince_bg/contain/icon_gem")

	local var_7_9 = arg_7_0.detailWindow

	arg_7_0.detailGold = var_1.Find(var_7_9, "prince_bg/contain/icon_gold")

	local var_7_10 = arg_7_0.detailWindow

	arg_7_0.detailPrice = var_1.Find(var_7_10, "prince_bg/contain/Text")

	local var_7_11 = arg_7_0.detailWindow

	arg_7_0.detailTag = var_1.Find(var_7_11, "goods/tag")
	arg_7_0.detailTags = {}
	table = var_1

	local var_7_12 = var_1.insert
	local var_7_13 = arg_7_0.detailTags
	local var_7_14 = arg_7_0.detailTag

	var_7_12(var_7_13, var_4.Find(var_7_14, "hot"))

	table = var_7_12

	local var_7_15 = var_7_12.insert
	local var_7_16 = arg_7_0.detailTags
	local var_7_17 = arg_7_0.detailTag

	var_7_15(var_7_16, var_4.Find(var_7_17, "new"))

	table = var_7_15

	local var_7_18 = var_7_15.insert
	local var_7_19 = arg_7_0.detailTags
	local var_7_20 = arg_7_0.detailTag

	var_7_18(var_7_19, var_4.Find(var_7_20, "advice"))

	table = var_7_18

	local var_7_21 = var_7_18.insert
	local var_7_22 = arg_7_0.detailTags
	local var_7_23 = arg_7_0.detailTag

	var_7_21(var_7_22, var_4.Find(var_7_23, "double"))

	table = var_7_21

	local var_7_24 = var_7_21.insert
	local var_7_25 = arg_7_0.detailTags
	local var_7_26 = arg_7_0.detailTag

	var_7_24(var_7_25, var_4.Find(var_7_26, "discount"))

	arg_7_0.detailTagAdviceTF = arg_7_0.detailTags[3]
	arg_7_0.detailTagDoubleTF = arg_7_0.detailTags[4]

	local var_7_27 = arg_7_0.detailWindow

	arg_7_0.detailContain = var_1.Find(var_7_27, "container")

	if arg_7_0.detailContain then
		local var_7_28 = arg_7_0.detailContain

		arg_7_0.normal = var_1.Find(var_7_28, "normal_items")

		local var_7_29 = arg_7_0.normal

		arg_7_0.detailTip = var_1.Find(var_7_29, "Text")

		local var_7_30 = arg_7_0.normal

		arg_7_0.detailItem = var_1.Find(var_7_30, "item_tpl")

		local var_7_31 = arg_7_0.detailContain

		arg_7_0.extra = var_1.Find(var_7_31, "items")

		local var_7_32 = arg_7_0.extra

		arg_7_0.extraTip = var_1.Find(var_7_32, "Text")

		local var_7_33 = arg_7_0.extra

		arg_7_0.detailItemList = var_1.Find(var_7_33, "scrollview/list")

		local var_7_34 = arg_7_0.detailContain

		arg_7_0.extraDesc = var_1.Find(var_7_34, "Text")
	end

	local var_7_35 = arg_7_0.detailWindow

	arg_7_0.detailNormalTip = var_1.Find(var_7_35, "NormalTips")

	local var_7_36 = arg_7_0.detailWindow

	arg_7_0.infoBtn = var_1.Find(var_7_36, "prince_bg/info")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.bg

	local function var_8_2()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_0, var_8_1, var_8_2, var_1_10006)

	onButton = var_1_10001

	local var_8_3 = arg_8_0
	local var_8_4 = arg_8_0.cancelBtn

	local function var_8_5()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_3, var_8_4, var_8_5, var_1_10006)

	onButton = var_1_10001

	local var_8_6 = arg_8_0
	local var_8_7 = arg_8_0.confirmBtn

	local function var_8_8()
		local var_11_0 = {}

		if arg_8_0.panelConfig.limitArgs then
			type = var_2_10002

			if var_2_10002(var_1) == "table" and var_1[1] then
				type = var_2_10003

				if var_2_10003(var_2_10002) == "table" then
					local var_11_1 = #var_2_10002

					if 2 <= var_11_1 then
						unpack = var_11_1

						local var_11_2

						var_11_2, var_2_10004 = var_11_1(var_2_10002)
						getProxy = var_5
						PlayerProxy = var_2_10007
						var_2_10007 = var_5(var_2_10007)

						local var_11_3 = var_5.getRawData(var_2_10007)

						if var_11_2 == "lv_70" and var_2_10004 <= var_11_3.level then
							table = var_2_10006

							var_2_10006.insert(var_11_0, function(arg_12_0)
								pg = var_3_10001

								local var_12_0 = var_3_10001.MsgboxMgr.GetInstance()
								local var_12_1 = var_1.ShowMsgBox
								local var_12_2 = {}

								i18n = var_3_10005
								var_12_2.content = var_3_10005("lv70_package_tip")
								var_12_2.onYes = arg_12_0

								var_12_1(var_12_0, var_12_2)

								return
							end)
						end
					end
				end
			end
		end

		ipairs = var_2_10002
		getProxy = var_2_10004
		ActivityProxy = var_2_10006

		local var_11_4 = var_2_10004(var_2_10006)
		local var_11_5 = var_4.getActivitiesByType

		ActivityConst = var_2_10007

		for iter_11_0, iter_11_1 in var_2_10002(var_11_5(var_11_4, var_2_10007.ACTIVITY_TYPE_SKIN_COUPON_COUNTING)) do
			if not arg_8_0.panelConfig.isChargeType then
				break
			end

			if not iter_11_1:isEnd() then
				table = var_7

				if var_7.contains(iter_11_1:getConfig("config_data")[1], arg_8_0.panelConfig.commodity.id) then
					Drop = var_7

					local var_11_6 = var_7.New
					local var_11_7 = {}

					DROP_TYPE_VITEM = var_10
					var_11_7.type = var_10

					local var_11_8 = iter_11_1

					var_11_7.id = iter_11_1.GetConfigClientSetting(var_11_8, "item_id")

					local var_11_9 = var_11_6(var_11_7)

					getProxy = var_2_10008
					ActivityProxy = var_10

					local var_11_10 = var_2_10008(var_10)

					if var_2_10008.getActivityById(var_11_10, var_11_9:getConfig("link_id")) and not var_2_10008:isEnd() then
						assert = var_9

						local var_11_11 = var_2_10008:getConfig("type")

						ActivityConst = var_11_8

						var_9(var_11_11 == var_11_8.ACTIVITY_TYPE_SKIN_COUPON)

						local var_11_12, var_11_13 = var_2_10008:GetOwnCount()

						if iter_11_1:GetConfigClientSetting("gift_tip")[arg_8_0.panelConfig.commodity.id][1] then
							table = var_12

							var_12.insert(var_11_0, function(arg_13_0)
								pg = var_3_10001

								local var_13_0 = var_3_10001.MsgboxMgr.GetInstance()
								local var_13_1 = var_1.ShowMsgBox
								local var_13_2 = {}

								i18n = var_3_10005
								var_13_2.content = var_3_10005(var_0, var_11_12, var_11_13)
								var_13_2.onYes = arg_13_0

								var_13_1(var_13_0, var_13_2)

								return
							end)
						else
							table = var_12

							var_12.insert(var_11_0, function(arg_14_0)
								arg_14_0()

								return
							end)
						end
					end
				end
			end
		end

		seriesAsync = var_2

		var_2(var_11_0, function()
			existCall = var_3_10000

			var_3_10000(arg_8_0.panelConfig.onYes)

			local var_15_0 = arg_8_0

			var_0.closeView(var_15_0)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_8_6, var_8_7, var_8_8, var_1_10006)

	return
end

function var_0_1.updatePanel(arg_16_0)
	local var_16_0 = arg_16_0.panelConfig.icon
	local var_16_1

	if not arg_16_0.panelConfig.name then
		var_16_1 = ""
	end

	local var_16_2

	if not arg_16_0.panelConfig.tipBonus then
		var_16_2 = ""
	end

	local var_16_3 = arg_16_0.panelConfig.bonusItem
	local var_16_4

	if not arg_16_0.panelConfig.tipExtra then
		var_16_4 = ""
	end

	local var_16_5

	if not arg_16_0.panelConfig.extraItems then
		var_16_5 = {}
	end

	local var_16_6

	if not arg_16_0.panelConfig.price or not arg_16_0.panelConfig.price then
		var_16_6 = 0
	end

	local var_16_7 = arg_16_0.panelConfig.isChargeType
	local var_16_8 = arg_16_0.panelConfig.isLocalPrice
	local var_16_9 = arg_16_0.panelConfig.isMonthCard
	local var_16_10 = arg_16_0.panelConfig.tagType
	local var_16_11 = arg_16_0.panelConfig.normalTip
	local var_16_12 = arg_16_0.panelConfig.extraDrop
	local var_16_13 = arg_16_0.panelConfig.isForceGold
	local var_16_14

	if not arg_16_0.panelConfig.infoTip then
		var_16_14 = ""
	end

	if arg_16_0.detailNormalTip then
		setActive = var_16

		var_16(arg_16_0.detailNormalTip, var_16_11)
	end

	if arg_16_0.detailContain then
		setActive = var_16

		var_16(arg_16_0.detailContain, not var_16_11)
	end

	if var_16_11 then
		local var_16_15 = arg_16_0.detailNormalTip

		if var_16.GetComponent(var_16_15, "Text") then
			setText = var_16

			var_16(arg_16_0.detailNormalTip, var_16_11)
		else
			setButtonText = var_16

			var_16(arg_16_0.detailNormalTip, var_16_11)
		end
	end

	setActive = var_16

	var_16(arg_16_0.detailTag, var_16_10 > 0)

	if 0 < var_16_10 then
		ipairs = var_16

		for iter_16_0, iter_16_1 in var_16(arg_16_0.detailTags) do
			setActive = var_1_10021

			var_1_10021(iter_16_1, iter_16_0 == var_16_10)
		end
	end

	GetImageSpriteFromAtlasAsync = var_16

	var_16(var_16_0, "", arg_16_0.detailIcon, false)

	setScrollText = var_16

	var_16(arg_16_0.detailName, var_16_1)

	if arg_16_0.detailExtraDrop then
		setActive = var_16

		var_16(arg_16_0.detailExtraDrop, var_16_12)

		if var_16_12 then
			setText = var_16

			local var_16_16 = arg_16_0.detailExtraDrop
			local var_16_17 = var_18.Find(var_16_16, "Text")

			i18n = var_19

			var_16(var_16_17, var_19("battlepass_pay_acquire") .. "\n" .. var_16_12.count .. "x")

			updateDrop = var_16

			local var_16_18 = arg_16_0.detailExtraDrop
			local var_16_19 = var_18.Find(var_16_18, "item/IconTpl")

			setmetatable = var_19

			var_16(var_16_19, var_19({
				count = 1
			}, {
				__index = var_16_12
			}))
		end
	end

	PLATFORM_CODE = var_16
	PLATFORM_CHT = var_1_10017

	if var_16 == var_1_10017 then
		setActive = var_16

		var_16(arg_16_0.detailRmb, var_16_7 and not var_16_8)
	else
		setActive = var_16

		var_16(arg_16_0.detailRmb, var_16_7)
	end

	setActive = var_16

	var_16(arg_16_0.detailGem, not var_16_7 and not var_16_13)

	setActive = var_16

	local var_16_20 = arg_16_0.detailGold
	local var_16_21

	if not var_16_7 then
		isActive = var_19

		if not var_19(arg_16_0.detailRmb) then
			isActive = var_19
			var_16_21 = not var_19(arg_16_0.detailGem)

			goto label_16_0
		end
	end

	var_16_21 = false

	if false then
		var_16_21 = true
	end

	::label_16_0::

	var_16(var_16_20, var_16_21)

	setText = var_16

	var_16(arg_16_0.detailPrice, var_16_6)

	if arg_16_0.extraDesc ~= nil then
		local var_16_22

		if not arg_16_0.panelConfig.descExtra then
			var_16_22 = ""
		end

		setActive = var_1_10017

		local var_16_23 = arg_16_0.extraDesc
		local var_16_24 = #var_16_22

		var_1_10017(var_16_23, 0 < var_16_24)

		setText = var_1_10017

		var_1_10017(arg_16_0.extraDesc, var_16_22)
	end

	if arg_16_0.detailContain then
		setActive = var_16_28

		var_16_28(arg_16_0.normal, var_16_9)

		local var_16_28

		if var_16_9 then
			updateDrop = var_16_28

			var_16_28(arg_16_0.detailItem, var_16_3)

			onButton = var_16_28

			local var_16_25 = arg_16_0
			local var_16_26 = arg_16_0.detailItem

			local function var_16_27()
				return
			end

			SFX_PANEL = var_21

			var_16_28(var_16_25, var_16_26, var_16_27, var_21)

			contentWrap = var_16_28
			var_16_28, var_1_10017 = var_16_28(var_16_3:getConfig("name"), 10, 2)

			if var_16_28 then
				var_1_10017 = var_1_10017 .. "..."
			end

			setText = var_18
			var_1_10022 = arg_16_0.detailItem

			var_18(var_20.Find(var_1_10022, "name"), var_1_10017)

			setText = var_18

			var_18(arg_16_0.detailTip, var_16_2)
		end

		setText = var_16_28

		var_16_28(arg_16_0.extraTip, var_16_4)

		if arg_16_0:ExistSkinExperienceItem(var_16_5) then
			arg_16_0:UpdateSkinDiscountItemItems(var_16_5)
		else
			arg_16_0:UpdateItems(var_16_5)
		end
	end

	local var_16_29 = var_16_14 ~= ""

	setActive = var_1_10017

	var_1_10017(arg_16_0.infoBtn, var_16_29)

	if var_16_29 then
		onButton = var_1_10017

		local var_16_30 = arg_16_0
		local var_16_31 = arg_16_0.infoBtn

		local function var_16_32()
			pg = var_2_10000

			local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
			local var_18_1 = var_0.ShowMsgBox
			local var_18_2 = {}

			MSGBOX_TYPE_HELP = var_2_10004
			var_18_2.type = var_2_10004
			pg = var_2_10004
			var_18_2.helps = var_2_10004.gametip[var_16_14].tip

			var_18_1(var_18_0, var_18_2)

			return
		end

		SFX_PANEL = var_1_10022

		var_1_10017(var_16_30, var_16_31, var_16_32, var_1_10022)
	else
		removeOnButton = var_1_10017

		var_1_10017(arg_16_0.infoBtn)
	end

	return
end

function var_0_1.UpdateItems(arg_19_0, arg_19_1)
	UIItemList = var_1_10002

	var_1_10002.StaticAlign(arg_19_0.detailItemList, arg_19_0.detailItem, #arg_19_1, function(arg_20_0, arg_20_1, arg_20_2)
		arg_20_1 = arg_20_1 + 1
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = arg_19_1[arg_20_1]

			updateDrop = var_2_10004

			var_2_10004(arg_20_2, var_20_0)

			contentWrap = var_2_10004

			local var_20_1, var_20_2 = var_2_10004(var_20_0:getConfig("name"), 8, 2)

			if var_20_1 then
				var_20_2 = var_20_2 .. "..."
			end

			setText = var_6

			var_6(arg_20_2:Find("name"), var_20_2)

			onButton = var_6

			local var_20_3 = arg_19_0
			local var_20_4 = arg_20_2

			local function var_20_5()
				pg = var_3_10000

				local var_21_0 = var_3_10000.MsgboxMgr.GetInstance()
				local var_21_1 = var_0.ShowMsgBox
				local var_21_2 = {
					hideNo = true
				}

				MSGBOX_TYPE_SINGLE_ITEM = var_3_10004
				var_21_2.type = var_3_10004
				var_21_2.drop = var_20_0

				var_21_1(var_21_0, var_21_2)

				return
			end

			SFX_PANEL = var_11

			var_6(var_20_3, var_20_4, var_20_5, var_11)

			setBlackMask = var_6

			local var_20_6 = arg_20_2:Find("icon_bg")
			local var_20_7 = var_20_0.got
			local var_20_8 = {}

			Color = var_11
			var_20_8.color = var_11(0, 0, 0, 0.6)

			var_6(var_20_6, var_20_7, var_20_8)

			setActive = var_6

			var_6(arg_20_2:Find("got"), var_20_0.got)

			setActive = var_6

			var_6(arg_20_2:Find("special"), var_20_0.special)
		end

		return
	end)

	return
end

function var_0_1.UpdateSkinDiscountItemItems(arg_22_0, arg_22_1)
	local var_22_0, var_22_1 = arg_22_0:SplitItemAndSkinExperienceItem(arg_22_1)

	arg_22_0:UpdateItems(var_22_0)

	UIItemList = var_4

	local var_22_2 = var_4.New
	local var_22_3 = arg_22_0._tf
	local var_22_4 = var_6.Find(var_22_3, "window/container/bonus_gift/bg/scrollview/list")
	local var_22_5 = arg_22_0._tf
	local var_22_6 = var_22_2(var_22_4, var_7.Find(var_22_5, "window/container/normal_items/item_tpl"))

	var_4.make(var_22_6, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = arg_22_0

			var_3.UpdateItem(var_23_0, var_22_1[arg_23_1 + 1], arg_23_2)
		end

		return
	end)
	var_4:align(#var_22_1)

	setText = var_5

	local var_22_7 = arg_22_0._tf
	local var_22_8 = var_7.Find(var_22_7, "window/container/bonus_gift/bg/Text")

	i18n = var_8

	var_5(var_22_8, var_8("skin_discount_item_return_tip"))

	setText = var_5

	local var_22_9 = arg_22_0._tf
	local var_22_10 = var_7.Find(var_22_9, "window/container/bonus_gift/bg/label")

	i18n = var_8

	var_5(var_22_10, var_8("skin_discount_item_extra_bounds"))

	return
end

function var_0_1.UpdateItem(arg_24_0, arg_24_1, arg_24_2)
	Drop = var_1_10003

	local var_24_0 = var_1_10003.Create
	local var_24_1 = {}

	DROP_TYPE_ITEM = var_1_10006
	var_24_1[1] = var_1_10006
	var_24_1[2] = arg_24_1.id
	var_24_1[3] = arg_24_1.count

	local var_24_2 = var_24_0(var_24_1)

	updateDrop = var_1_10004

	var_1_10004(arg_24_2, var_24_2)

	setText = var_1_10004

	local var_24_3 = arg_24_2:Find("name")

	shortenString = var_7

	var_1_10004(var_24_3, var_7(var_24_2:getName(), 4))

	onButton = var_1_10004

	local var_24_4 = arg_24_0
	local var_24_5 = arg_24_2

	local function var_24_6()
		pg = var_2_10000

		local var_25_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_25_1 = var_0.ShowMsgBox
		local var_25_2 = {
			hideNo = true
		}

		MSGBOX_TYPE_SINGLE_ITEM = var_2_10004
		var_25_2.type = var_2_10004
		var_25_2.drop = var_24_2

		var_25_1(var_25_0, var_25_2)

		return
	end

	SFX_PANEL = var_9

	var_1_10004(var_24_4, var_24_5, var_24_6, var_9)

	return
end

function var_0_1.SplitItemAndSkinExperienceItem(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1 = {}

	ipairs = var_1_10004

	for iter_26_0, iter_26_1 in var_1_10004(arg_26_1) do
		if var_0_1.IsSkinExperienceItem(iter_26_1) then
			table = var_9

			var_9.insert(var_26_1, iter_26_1)
		else
			table = var_9

			var_9.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0, var_26_1
end

function var_0_1.IsSkinExperienceItem(arg_27_0)
	local var_27_0

	isa = var_1_10002

	local var_27_1 = arg_27_0

	Drop = var_1_10005

	if not var_1_10002(var_27_1, var_1_10005) then
		Drop = var_2
		arg_27_0 = var_2.New(arg_27_0)
	end

	local var_27_2

	if arg_27_0:getConfigTable() then
		::label_27_0::

		var_27_2 = var_1.usage
		ItemUsage = var_1_10003
		var_27_2 = var_27_2 == var_1_10003.USAGE_SKIN_EXP
	end

	return var_27_2
end

function var_0_1.ExistSkinExperienceItem(arg_28_0, arg_28_1)
	_ = var_1_10002

	return var_1_10002.any(arg_28_1, function(arg_29_0)
		return var_0_1.IsSkinExperienceItem(arg_29_0)
	end)
end

return var_0_1
