class = var_0_10000

local var_0_0 = "Dorm3dShoppingConfirmWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.SELECTED_WIDTH = 52
var_0_1.UNSELECTED_WIDTH = 12
var_0_1.LOOP_DURATION = 5

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dShopWindow"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.previewTf = var_1.Find(var_2_0, "Window/Preview")

	local var_2_1 = arg_2_0._tf

	arg_2_0.bubbleContent = var_1.Find(var_2_1, "Window/Bubbles/content")

	local var_2_2 = arg_2_0._tf

	arg_2_0.bubbleTpl = var_1.Find(var_2_2, "Window/Bubbles/tpl")
	UIItemList = var_1
	arg_2_0.bubbleList = var_1.New(arg_2_0.bubbleContent, arg_2_0.bubbleTpl)
	BannerScrollRect4Dorm = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "Window/banner/mask/content")
	local var_2_6 = arg_2_0._tf

	arg_2_0.scrollSnap = var_2_3(var_2_5, var_4.Find(var_2_6, "Window/banner/dots"))
	setActive = var_1

	var_1(arg_2_0.bubbleTpl, false)

	switch = var_1

	var_1(arg_2_0.contextData.drop.__cname, {
		Dorm3dGift = function()
			local var_3_0 = arg_2_0

			pg = var_2_10001

			local var_3_1

			if not var_2_10001.dorm3d_gift[arg_2_0.contextData.drop.configId].unlock_tips then
				var_3_1 = {}
			end

			var_3_0.unlockTips = var_3_1

			local var_3_2 = arg_2_0.contextData.groupId

			pg = var_3_1

			local var_3_3

			if not var_3_1.dorm3d_gift[arg_2_0.contextData.drop.configId].unlock_banners then
				var_3_3 = {}
			end

			table = var_2

			local var_3_4

			if not var_2.Find(var_3_3, function(arg_4_0, arg_4_1)
				if var_3_2 == nil or arg_4_1[1] == var_3_2 then
					return true
				end

				return
			end) then
				table = var_2_10003
				var_3_4 = var_2_10003.Find(var_3_3, function(arg_5_0)
					if arg_5_0[1] == 0 then
						return true
					end

					return
				end)
			end

			arg_2_0.unlockBanners = var_3_4 and var_3_4[2]

			local var_3_5 = arg_2_0

			pg = var_4
			var_3_5.isExclusive = var_4.dorm3d_gift[arg_2_0.contextData.drop.configId].ship_group_id ~= 0

			local var_3_6 = arg_2_0

			pg = var_4

			local var_3_7 = var_4.dorm3d_favor_trigger

			pg = var_5
			var_3_6.addFavor = var_3_7[var_5.dorm3d_gift[arg_2_0.contextData.drop.configId].favor_trigger_id].num
			setActive = var_3_6

			local var_3_8 = arg_2_0._tf

			var_3_6(var_5.Find(var_3_8, "Window/Title/gift"), true)

			return
		end,
		Dorm3dFurniture = function()
			local var_6_0 = arg_2_0

			pg = var_2_10001

			local var_6_1

			if not var_2_10001.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].unlock_tips then
				var_6_1 = {}
			end

			var_6_0.unlockTips = var_6_1

			local var_6_2 = arg_2_0

			pg = var_6_1

			local var_6_3

			if not var_6_1.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].unlock_banners then
				var_6_3 = {}
			end

			var_6_2.unlockBanners = var_6_3

			local var_6_4 = arg_2_0

			pg = var_6_3
			var_6_4.isExclusive = var_6_3.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].is_exclusive == 1

			local var_6_5 = arg_2_0

			pg = var_1
			var_6_5.isSpecial = var_1.dorm3d_furniture_template[arg_2_0.contextData.drop.configId].is_special == 1
			setActive = var_6_5

			local var_6_6 = arg_2_0._tf

			var_6_5(var_2.Find(var_6_6, "Window/Title/furniture"), true)

			return
		end,
		Dorm3dSkin = function()
			local var_7_0 = arg_2_0

			pg = var_2_10001

			local var_7_1

			if not var_2_10001.dorm3d_resource[arg_2_0.contextData.drop.configId].unlock_tips then
				var_7_1 = {}
			end

			var_7_0.unlockTips = var_7_1

			local var_7_2 = arg_2_0

			pg = var_7_1

			local var_7_3

			if not var_7_1.dorm3d_resource[arg_2_0.contextData.drop.configId].unlock_banners then
				var_7_3 = {}
			end

			var_7_2.unlockBanners = var_7_3
			setActive = var_7_2

			local var_7_4 = arg_2_0._tf

			var_7_2(var_2.Find(var_7_4, "Window/Title/skin"), true)

			return
		end
	})

	return
end

function var_0_1.didEnter(arg_8_0)
	onButton = var_1_10001

	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0._tf
	local var_8_2 = var_4.Find(var_8_1, "Window/Confirm")

	local function var_8_3()
		local var_9_0 = arg_8_0.contextData.onYes
		local var_9_1 = arg_8_0

		var_1.closeView(var_9_1)

		existCall = var_1

		var_1(var_9_0)

		return
	end

	SFX_PANEL = var_8_1

	var_1_10001(var_8_0, var_8_2, var_8_3, var_8_1)

	onButton = var_1_10001

	local var_8_4 = arg_8_0
	local var_8_5 = arg_8_0._tf
	local var_8_6 = var_4.Find(var_8_5, "Window/Cancel")

	local function var_8_7()
		local var_10_0 = arg_8_0.contextData.onNo
		local var_10_1 = arg_8_0

		var_1.closeView(var_10_1)

		existCall = var_1

		var_1(var_10_0)

		return
	end

	SFX_CANCEL = var_8_5

	var_1_10001(var_8_4, var_8_6, var_8_7, var_8_5)

	onButton = var_1_10001

	local var_8_8 = arg_8_0
	local var_8_9 = arg_8_0._tf

	var_1_10001(var_8_8, var_4.Find(var_8_9, "Mask"), function()
		local var_11_0 = arg_8_0.contextData.onClose
		local var_11_1 = arg_8_0

		var_1.closeView(var_11_1)

		existCall = var_1

		var_1(var_11_0)

		return
	end)
	arg_8_0:InitUIList()
	arg_8_0:InitDropIcon()
	arg_8_0:InitBanner()

	local var_8_10

	if arg_8_0.contextData.content.cost == 0 then
		i18n = var_2
		var_8_10 = var_2("dorm3d_purchase_confirm_free", arg_8_0.contextData.content.icon, "x" .. arg_8_0.contextData.content.cost, arg_8_0.contextData.content.name)
	elseif arg_8_0.contextData.content.off > 0 then
		i18n = var_2
		var_8_10 = var_2("dorm3d_purchase_confirm_discount", arg_8_0.contextData.content.icon, "x" .. arg_8_0.contextData.content.cost, arg_8_0.contextData.content.old, arg_8_0.contextData.content.name)
	else
		i18n = var_2
		var_8_10 = var_2("dorm3d_purchase_confirm_original", arg_8_0.contextData.content.icon, "x" .. arg_8_0.contextData.content.cost, arg_8_0.contextData.content.name)
	end

	switch = var_2

	var_2(arg_8_0.contextData.drop.__cname, {
		Dorm3dGift = function()
			if arg_8_0.contextData.content.weekLimit then
				local var_12_0 = var_8_10

				i18n = var_2_10002
				var_8_10 = var_12_0 .. var_2_10002("dorm3d_purchase_weekly_limit", var_0[1], var_0[2])
			end

			return
		end,
		Dorm3dFurniture = function()
			if arg_8_0.contextData.endTime and var_0 > 0 then
				local function var_13_0(arg_14_0)
					pg = var_3_10001

					local var_14_0 = var_3_10001.TimeMgr.GetInstance()
					local var_14_1 = var_1.GetServerTime(var_14_0)

					math = var_3_10002

					local var_14_2 = var_3_10002.max(arg_14_0 - var_14_1, 0)

					math = var_14_0

					local var_14_3 = var_14_0.floor(var_14_2 / 0)
					local var_14_4

					if 0 < var_14_3 then
						var_14_4 = var_14_3
						i18n = var_5

						return var_14_4 .. var_5("word_date")
					else
						math = var_14_4

						local var_14_5 = var_14_4.floor(var_14_2 / 16)
						local var_14_6

						if 0 < var_14_5 then
							var_14_6 = var_14_5
							i18n = var_6

							return var_14_6 .. var_6("word_hour")
						else
							math = var_14_6

							if var_14_6.floor(var_14_2 / 60) > 0 then
								local var_14_7 = var_5

								i18n = var_7

								return var_14_7 .. var_7("word_minute")
							else
								local var_14_8 = var_14_2

								i18n = var_7

								return var_14_8 .. var_7("word_second")
							end
						end
					end

					return
				end

				local var_13_1 = var_8_10
				local var_13_2 = arg_8_0

				Timer = var_2_10004
				var_13_2.timerRefreshTime = var_2_10004.New(function()
					local var_15_0 = var_13_1

					string = var_3_10001

					local var_15_1 = var_3_10001.format
					local var_15_2 = "\n<size=28><color=#7c7e81>%s</color><color=#169fff>%s</color></size>"

					i18n = var_3_10004

					local var_15_3 = var_15_0 .. var_15_1(var_15_2, var_3_10004("time_remaining_tip"), var_13_0(var_0))

					setText = var_1

					local var_15_4 = arg_8_0._tf

					var_1(var_3.Find(var_15_4, "Window/Content"), var_15_3)

					return
				end, 1, -1)

				local var_13_3 = arg_8_0.timerRefreshTime

				var_3.Start(var_13_3)

				local var_13_4 = var_8_10

				string = var_4

				local var_13_5 = var_4.format
				local var_13_6 = "\n<size=28><color=#7c7e81>%s</color><color=#169fff>%s</color></size>"

				i18n = var_7
				var_8_10 = var_13_4 .. var_13_5(var_13_6, var_7("time_remaining_tip"), var_13_0(var_0))
			end

			return
		end
	})

	setText = var_2

	local var_8_11 = arg_8_0._tf

	var_2(var_4.Find(var_8_11, "Window/Content"), var_8_10)

	setText = var_2

	local var_8_12 = arg_8_0._tf
	local var_8_13 = var_4.Find(var_8_12, "Window/Confirm/Text")

	i18n = var_5

	var_2(var_8_13, var_5("msgbox_text_confirm"))

	setText = var_2

	local var_8_14 = arg_8_0._tf
	local var_8_15 = var_4.Find(var_8_14, "Window/Cancel/Text")

	i18n = var_5

	var_2(var_8_15, var_5("msgbox_text_cancel"))

	pg = var_2

	local var_8_16 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_8_16, arg_8_0._tf)

	return
end

function var_0_1.InitBanner(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.unlockBanners do
		local var_16_0 = arg_16_0.scrollSnap
		local var_16_1 = var_5.AddChild(var_16_0)

		LoadImageSpriteAsync = var_1_10006

		var_1_10006("dorm3dbanner/" .. arg_16_0.unlockBanners[iter_16_0], var_16_1)
	end

	local var_16_2 = arg_16_0.scrollSnap

	var_1.SetUp(var_16_2)

	return
end

function var_0_1.InitUIList(arg_17_0)
	local var_17_0 = arg_17_0.bubbleList

	var_1.make(var_17_0, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventInit then
			local var_18_0 = arg_18_1 + 1
			local var_18_1 = arg_17_0.unlockTips[var_18_0]

			LoadImageSpriteAtlasAsync = var_2_10005

			var_2_10005("ui/shoptip_atlas", "icon_" .. var_18_1, arg_18_2:Find("icon/icon"), true)

			setText = var_2_10005

			local var_18_2 = arg_18_2:Find("bubble/Text")

			i18n = var_8

			var_2_10005(var_18_2, var_8("dorm3d_shop_tag" .. var_18_1))

			setActive = var_2_10005

			var_2_10005(arg_18_2:Find("bubble"), false)

			onToggle = var_2_10005

			var_2_10005(arg_17_0, arg_18_2, function(arg_19_0)
				setActive = var_3_10001

				local var_19_0 = arg_18_2

				var_3_10001(var_3.Find(var_19_0, "icon/select"), arg_19_0)

				setActive = var_3_10001

				local var_19_1 = arg_18_2

				var_3_10001(var_3.Find(var_19_1, "icon/unselect"), not arg_19_0)

				setActive = var_3_10001

				local var_19_2 = arg_18_2

				var_3_10001(var_3.Find(var_19_2, "bubble"), arg_19_0)

				return
			end)
		end

		return
	end)

	local var_17_1 = arg_17_0.bubbleList

	var_1.align(var_17_1, #arg_17_0.unlockTips)

	return
end

function var_0_1.InitDropIcon(arg_20_0)
	LoadImageSpriteAtlasAsync = var_1_10001

	local var_20_0 = arg_20_0.contextData.drop
	local var_20_1 = var_3.GetIcon(var_20_0)
	local var_20_2 = ""
	local var_20_3 = arg_20_0._tf

	var_1_10001(var_20_1, var_20_2, var_5.Find(var_20_3, "Window/Item/Dorm3dIconTpl/icon"), true)

	GetImageSpriteFromAtlasAsync = var_1_10001

	local var_20_4 = "weaponframes"
	local var_20_5 = "dorm3d_"

	ItemRarity = var_5

	local var_20_6 = var_5.Rarity2Print
	local var_20_7 = arg_20_0.contextData.drop
	local var_20_8 = var_20_5 .. var_20_6(var_7.GetRarity(var_20_7))
	local var_20_9 = arg_20_0._tf

	var_1_10001(var_20_4, var_20_8, var_5.Find(var_20_9, "Window/Item/Dorm3dIconTpl"))

	setActive = var_1_10001

	local var_20_10 = arg_20_0._tf
	local var_20_11 = var_3.Find(var_20_10, "Window/Item/sp")
	local var_20_12

	if not arg_20_0.isExclusive then
		var_20_12 = arg_20_0.isSpecial
	end

	var_1_10001(var_20_11, var_20_12)

	if arg_20_0.isSpecial then
		setText = var_1

		local var_20_13 = arg_20_0._tf
		local var_20_14 = var_3.Find(var_20_13, "Window/Item/sp/Text")

		i18n = var_20_12

		var_1(var_20_14, var_20_12("dorm3d_purchase_label_special"))
	elseif arg_20_0.isExclusive then
		setText = var_1

		local var_20_15 = arg_20_0._tf
		local var_20_16 = var_3.Find(var_20_15, "Window/Item/sp/Text")

		i18n = var_20_12

		var_1(var_20_16, var_20_12("dorm3d_purchase_confirm_tip"))
	end

	if arg_20_0.addFavor then
		setActive = var_1

		local var_20_17 = arg_20_0._tf

		var_1(var_3.Find(var_20_17, "Window/Item/gift"), true)

		setText = var_1

		local var_20_18 = arg_20_0._tf

		var_1(var_3.Find(var_20_18, "Window/Item/gift/Text"), "+" .. arg_20_0.addFavor)
	end

	return
end

function var_0_1.willExit(arg_21_0)
	if arg_21_0.timerRefreshTime then
		local var_21_0 = arg_21_0.timerRefreshTime

		var_1.Stop(var_21_0)

		arg_21_0.timerRefreshTime = nil
	end

	local var_21_1 = arg_21_0.scrollSnap

	var_1.Dispose(var_21_1)

	arg_21_0.scrollSnap = nil
	pg = var_1

	local var_21_2 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_2, arg_21_0._tf)

	return
end

return var_0_1
