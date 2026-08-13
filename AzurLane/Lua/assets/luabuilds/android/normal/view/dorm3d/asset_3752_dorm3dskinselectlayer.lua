class = var_0_10000

local var_0_0 = "Dorm3dSkinSelectLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dSkinSelectLayer"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.btnChange = var_1.Find(var_2_0, "BG/bottom/btn_change")

	local var_2_1 = arg_2_0._tf

	arg_2_0.btnBuy = var_1.Find(var_2_1, "BG/bottom/btn_buy")

	local var_2_2 = arg_2_0._tf

	arg_2_0.priceText = var_1.Find(var_2_2, "BG/bottom/btn_buy/Price")

	local var_2_3 = arg_2_0._tf

	arg_2_0.line = var_1.Find(var_2_3, "BG/bottom/Line")

	local var_2_4 = arg_2_0._tf

	arg_2_0.desc = var_1.Find(var_2_4, "BG/bottom/desc")
	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.SetApartment(arg_3_0, arg_3_1)
	arg_3_0.apartment = arg_3_1

	return
end

function var_0_1.didEnter(arg_4_0)
	setText = var_1_10001

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_2.Find(var_4_0, "BG/Scroll/Content/Unlock/Title/Text")

	i18n = var_4_0

	var_1_10001(var_4_1, var_4_0("word_unlock"))

	setText = var_1_10001

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "BG/Scroll/Content/Lock/Title/Text")

	i18n = var_4_2

	var_1_10001(var_4_3, var_4_2("word_lock"))

	onButton = var_1_10001

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "btn_back")

	local function var_4_7()
		local var_5_0 = arg_4_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_4, var_4_6, var_4_7, var_5)

	onButton = var_1_10001

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0._tf
	local var_4_10 = var_3.Find(var_4_9, "BG/Close")

	local function var_4_11()
		local var_6_0 = arg_4_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_4_8, var_4_10, var_4_11, var_5)

	onButton = var_1_10001

	local var_4_12 = arg_4_0
	local var_4_13 = arg_4_0.btnChange

	local function var_4_14()
		if arg_4_0.contextData.isPublicRoom then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10002

			var_7_1(var_7_0, var_2_10002("dorm3d_skin_unlock"))

			return
		end

		local var_7_2 = arg_4_0

		if var_0.IsSameSkin(var_7_2) then
			return
		end

		local var_7_3 = arg_4_0
		local var_7_4 = var_0.emit

		Dorm3dSkinSelectMediator = var_2_10002

		var_7_4(var_7_3, var_2_10002.CHANGE_SKIN, arg_4_0.contextData.groupId, arg_4_0.selectedSkinId, arg_4_0.hiddenList)

		if not arg_4_0.contextData.onSwitchSkin then
			pg = var_0

			if var_0.dorm3d_resource[arg_4_0.selectedSkinId].wear_anim and var_0 ~= "" then
				local var_7_5 = arg_4_0.contextData.ladyEnv

				var_1.PlaySingleAction(var_7_5, var_0)
			end
		end

		arg_4_0.sortSkinId = arg_4_0.selectedSkinId

		local var_7_6 = arg_4_0

		var_0.FlushSkinList(var_7_6)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_12, var_4_13, var_4_14, var_5)

	onButton = var_1_10001

	local var_4_15 = arg_4_0
	local var_4_16 = arg_4_0.btnBuy

	local function var_4_17()
		local var_8_0 = arg_4_0.skinDic[arg_4_0.selectedSkinId]

		if var_0.GetType(var_8_0) == 2 then
			local var_8_1 = var_0
			local var_8_2 = var_0.GetPublicRoomId(var_8_1)

			getProxy = var_8_1
			ApartmentProxy = var_2_10004

			local var_8_3 = var_8_1(var_2_10004)

			if var_3.getRoom(var_8_3, var_8_2) then
				local var_8_4 = arg_4_0
				local var_8_5 = var_3.emit

				Dorm3dSkinSelectMediator = var_2_10005

				var_8_5(var_8_4, var_2_10005.OPEN_ROOM_UNLOCK_WINDOW, var_8_2, arg_4_0.contextData.groupId)
			else
				local var_8_6 = arg_4_0
				local var_8_7 = var_3.emit

				Dorm3dSkinSelectMediator = var_2_10005

				var_8_7(var_8_6, var_2_10005.OPEN_ROOM_UNLOCK_WINDOW, var_8_2)
			end
		elseif var_1 == 3 then
			local var_8_8 = var_0
			local var_8_9 = var_0.GetShopId(var_8_8)

			CommonCommodity = var_8_8

			local var_8_10 = var_8_8.New
			local var_8_11 = {
				id = var_8_9
			}

			Goods = var_2_10005

			local var_8_12 = var_8_10(var_8_11, var_2_10005.TYPE_SHOPSTREET)
			local var_8_13, var_8_14, var_8_15 = var_3.GetPrice(var_8_12)

			Drop = var_2_10007

			local var_8_16 = var_2_10007.New
			local var_8_17 = {}

			DROP_TYPE_RESOURCE = var_2_10009
			var_8_17.type = var_2_10009

			local var_8_18 = var_3

			var_8_17.id = var_3.GetResType(var_8_18)
			var_8_17.count = var_8_13

			local var_8_19 = var_8_16(var_8_17)
			local var_8_20 = arg_4_0
			local var_8_21 = var_8.emit

			Dorm3dSkinSelectMediator = var_8_18

			local var_8_22 = var_8_18.OPEN_SHOP_WINDOW
			local var_8_23 = {
				content = {
					icon = "<icon name=" .. var_3:GetResIcon() .. " w=1.1 h=1.1/>",
					off = var_8_14,
					cost = var_8_19.count,
					old = var_8_15,
					name = var_0:GetName()
				}
			}

			i18n = var_12
			var_8_23.tip = var_12("dorm3d_shop_gift_tip")
			var_8_23.drop = var_0

			function var_8_23.onYes()
				local var_9_0 = arg_4_0
				local var_9_1 = var_0.emit

				GAME = var_3_10002

				var_9_1(var_9_0, var_3_10002.SHOPPING, {
					silentTip = true,
					count = 1,
					id = var_8_9
				})

				return
			end

			var_8_21(var_8_20, var_8_22, var_8_23)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_4_15, var_4_16, var_4_17, var_5)

	arg_4_0.selectedSkinId = arg_4_0.contextData.ladyEnv.skinId
	arg_4_0.sortSkinId = arg_4_0.selectedSkinId
	arg_4_0.skinDic = {}
	ipairs = var_1

	for iter_4_0, iter_4_1 in var_1(arg_4_0.contextData.ladyEnv.skinIdList) do
		local var_4_18 = arg_4_0.skinDic

		Dorm3dSkin = var_1_10007
		var_4_18[iter_4_1] = var_1_10007.New({
			configId = iter_4_1
		})
	end

	arg_4_0:FlushSkinList()

	return
end

function var_0_1.FlushSkinList(arg_10_0)
	local var_10_0 = arg_10_0.contextData.ladyEnv.skinIdList
	local var_10_1 = {}
	local var_10_2 = {}

	_ = var_1_10004

	var_1_10004.each(var_10_0, function(arg_11_0)
		local var_11_0 = arg_10_0.skinDic[arg_11_0]

		if var_1.IsShow(var_11_0) then
			ApartmentProxy = var_1

			local var_11_1 = var_1.CheckUnlockConfig
			local var_11_2 = arg_10_0.skinDic[arg_11_0]

			if var_11_1(var_2.GetUnlock(var_11_2)) then
				table = var_1

				var_1.insert(var_10_1, arg_11_0)
			else
				table = var_1

				var_1.insert(var_10_2, arg_11_0)
			end
		end

		return
	end)

	local function var_10_3(arg_12_0, arg_12_1)
		return (arg_12_0 == arg_10_0.sortSkinId and 1 or 0) > (arg_12_1 == arg_10_0.sortSkinId and 1 or 0)
	end

	table = var_5

	var_5.sort(var_10_1, var_10_3)

	table = var_5

	var_5.sort(var_10_2, var_10_3)

	local function var_10_4(arg_13_0, arg_13_1)
		local var_13_0

		if not arg_13_1 or not var_10_1 then
			var_13_0 = var_10_2
		end

		UIItemList = var_2_10003

		var_2_10003.StaticAlign(arg_13_0, arg_13_0:GetChild(0), #var_13_0, function(arg_14_0, arg_14_1, arg_14_2)
			UIItemList = var_3_10003

			if arg_14_0 ~= var_3_10003.EventUpdate then
				return
			end

			local var_14_0 = var_13_0[arg_14_1 + 1]

			setActive = var_4

			var_4(arg_14_2:Find("Selected"), var_14_0 == arg_10_0.selectedSkinId)

			setActive = var_4

			var_4(arg_14_2:Find("Lock"), not arg_13_1)

			local var_14_1

			if not arg_13_1 then
				setText = var_4
				var_14_1 = arg_14_2

				local var_14_2 = arg_14_2.Find(var_14_1, "Lock/Bar/Text")
				local var_14_3 = arg_10_0.skinDic[var_14_0]

				var_4(var_14_2, var_14_1.GetUnlockText(var_14_3))
			end

			local var_14_4 = arg_10_0.loader
			local var_14_5 = var_4.GetSpriteQuiet

			string = var_14_1

			var_14_5(var_14_4, var_14_1.format("dorm3dselect/apartment_skin_%d", var_14_0), "", arg_14_2:Find("Icon"))

			onButton = var_14_5

			local var_14_6 = arg_10_0
			local var_14_7 = arg_14_2

			local function var_14_8()
				local var_15_0 = arg_10_0

				var_0.OnclickSkin(var_15_0, var_14_0, arg_13_1)

				return
			end

			SFX_PANEL = var_8

			var_14_5(var_14_6, var_14_7, var_14_8, var_8)

			return
		end)

		return
	end

	local var_10_5 = arg_10_0._tf

	var_10_4(var_7.Find(var_10_5, "BG/Scroll/Content/Unlock/List"), true)

	local var_10_6 = var_5
	local var_10_7 = arg_10_0._tf

	var_10_6(var_7.Find(var_10_7, "BG/Scroll/Content/Lock/List"), false)
	arg_10_0:FlushSkinPartOptions()
	arg_10_0:FlushBtns()

	return
end

function var_0_1.OnclickSkin(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.contextData.ladyEnv
	local var_16_1 = arg_16_0.contextData.groupId
	local var_16_2 = var_16_0.skinId

	arg_16_0.selectedSkinId = arg_16_1

	arg_16_0:FlushBtns()
	arg_16_0:FlushSkinPartOptions()

	if arg_16_1 ~= var_16_2 then
		if arg_16_0.contextData.onSwitchSkin then
			arg_16_0.contextData.onSwitchSkin(var_16_0, var_16_1, arg_16_0.selectedSkinId)
		else
			var_16_0:SwitchCharacterSkin(var_16_1, arg_16_0.selectedSkinId, function()
				Dorm3dHxHelper = var_2_10000

				var_2_10000.HideCharacterPart(var_16_0.lady, arg_16_0.hiddenList)

				local var_17_0 = arg_16_0.skinDic[arg_16_0.selectedSkinId]

				if var_0.GetSwitchAnim(var_17_0) and var_0 ~= "" then
					local var_17_1 = var_16_0

					var_1.PlaySingleAction(var_17_1, var_0)
				end

				return
			end)
		end
	end

	arg_16_0:FlushSkinList()

	return
end

function var_0_1.FlushBtns(arg_18_0)
	local var_18_0 = arg_18_0.skinDic[arg_18_0.selectedSkinId]

	ApartmentProxy = var_2

	local var_18_1 = var_2.CheckUnlockConfig(var_18_0:GetUnlock())

	setActive = var_3

	var_3(arg_18_0.btnChange, var_18_1)

	setActive = var_3

	var_3(arg_18_0.btnBuy, not var_18_1)

	if not var_18_1 then
		local var_18_2 = var_18_0

		if not var_18_0.GetShopId(var_18_2) then
			return
		end

		CommonCommodity = var_18_2

		local var_18_3 = var_18_2.New
		local var_18_4 = {
			id = var_3
		}

		Goods = var_1_10006

		local var_18_5 = var_18_3(var_18_4, var_1_10006.TYPE_SHOPSTREET)
		local var_18_6 = var_4.GetPrice(var_18_5)

		setText = var_18_5

		var_18_5(arg_18_0.priceText, "<icon name=" .. var_4:GetResIcon() .. " w=1.1 h=1.1/> " .. var_18_6)

		local var_18_7 = var_18_0:GetUnlock()[1]
		local var_18_8 = var_18_0

		if var_18_0.GetRemarks(var_18_8) and var_7 ~= "" then
			setActive = var_18_8

			var_18_8(arg_18_0.line, false)

			setActive = var_18_8

			var_18_8(arg_18_0.desc, true)

			setText = var_18_8

			var_18_8(arg_18_0.desc, var_7)
		else
			setActive = var_18_8

			var_18_8(arg_18_0.line, true)

			setActive = var_18_8

			var_18_8(arg_18_0.desc, false)
		end
	else
		setActive = var_3

		var_3(arg_18_0.desc, false)

		if arg_18_0:IsSameSkin() then
			setText = var_3

			local var_18_9 = arg_18_0.btnChange
			local var_18_10 = var_4.Find(var_18_9, "text")

			i18n = var_18_9

			var_3(var_18_10, var_18_9("dorm3d_skin_already"))
		else
			setText = var_3

			local var_18_11 = arg_18_0.btnChange
			local var_18_12 = var_4.Find(var_18_11, "text")

			i18n = var_18_11

			var_3(var_18_12, var_18_11("dorm3d_skin_confirm"))
		end
	end

	return
end

function var_0_1.FlushSkinPartOptions(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.dorm3d_resource[arg_19_0.selectedSkinId].hidden_part

	Clone = var_2

	local var_19_1 = arg_19_0.apartment

	arg_19_0.hiddenList = var_2(var_3.GetHiddenParts(var_19_1, arg_19_0.selectedSkinId))
	UIItemList = var_2

	local var_19_2 = var_2.StaticAlign
	local var_19_3 = arg_19_0._tf
	local var_19_4 = var_3.Find(var_19_3, "BG/parts")
	local var_19_5 = arg_19_0._tf

	var_19_2(var_19_4, var_4.Find(var_19_5, "BG/parts/tpl"), #var_19_0, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = var_19_0[arg_20_1 + 1]

		UIItemList = var_4

		if arg_20_0 == var_4.EventInit then
			local var_20_1 = arg_19_0.loader

			var_4.GetSpriteQuiet(var_20_1, "dorm3dskinpart/" .. var_20_0[2], "", arg_20_2:Find("open"))

			local var_20_2 = arg_19_0.loader
			local var_20_3 = var_4.GetSpriteQuiet
			local var_20_4 = "dorm3dskinpart/" .. var_20_0[2] .. "_close"
			local var_20_5 = ""
			local var_20_6 = arg_20_2

			var_20_3(var_20_2, var_20_4, var_20_5, arg_20_2.Find(var_20_6, "close"))

			table = var_20_3

			local var_20_7 = var_20_3.contains(arg_19_0.hiddenList, var_20_0[1])

			setActive = var_5

			var_5(arg_20_2:Find("open"), not var_20_7)

			setActive = var_5

			var_5(arg_20_2:Find("close"), var_20_7)

			onButton = var_5

			local var_20_8 = arg_19_0
			local var_20_9 = arg_20_2

			local function var_20_10()
				table = var_3_10000

				if var_3_10000.contains(arg_19_0.hiddenList, var_20_0[1]) then
					table = var_1

					var_1.removebyvalue(arg_19_0.hiddenList, var_20_0[1])
				else
					table = var_1

					var_1.insert(arg_19_0.hiddenList, var_20_0[1])
				end

				local var_21_0 = not var_0

				setActive = var_1

				local var_21_1 = arg_20_2

				var_1(var_2.Find(var_21_1, "open"), not var_21_0)

				setActive = var_1

				local var_21_2 = arg_20_2

				var_1(var_2.Find(var_21_2, "close"), var_21_0)

				Dorm3dHxHelper = var_1

				var_1.HideCharacterPart(arg_19_0.contextData.ladyEnv.lady, arg_19_0.hiddenList)

				local var_21_3 = arg_19_0

				var_1.FlushBtns(var_21_3)

				return
			end

			SFX_PANEL = var_20_6

			var_5(var_20_8, var_20_9, var_20_10, var_20_6)
		end

		return
	end)

	return
end

function var_0_1.IsSameSkin(arg_22_0)
	local var_22_0 = arg_22_0.selectedSkinId
	local var_22_1 = arg_22_0.apartment

	if var_22_0 ~= var_2.GetCurSkinId(var_22_1) then
		return false
	end

	local var_22_2 = arg_22_0.apartment
	local var_22_3 = var_1.GetHiddenParts(var_22_2, arg_22_0.selectedSkinId)

	table = var_22_2

	local var_22_4, var_22_5, var_22_6 = var_22_2.Diff(arg_22_0.hiddenList, var_22_3)

	return #var_22_5 == 0 and #var_22_6 == 0
end

function var_0_1.ConfirmCurrentSkin(arg_23_0)
	arg_23_0:OnclickSkin(arg_23_0.selectedSkinId, true)

	return
end

function var_0_1.CancelCurrentSkin(arg_24_0)
	arg_24_0:OnclickSkin(arg_24_0.contextData.ladyEnv.skinId, true)

	return
end

function var_0_1.willExit(arg_25_0)
	local var_25_0 = arg_25_0.loader

	var_1.Clear(var_25_0)

	if arg_25_0.contextData.isPublicRoom then
		return
	end

	local var_25_1 = arg_25_0.apartment
	local var_25_2 = var_1.GetCurSkinId(var_25_1)

	if arg_25_0.contextData.ladyEnv.skinId ~= var_25_2 then
		local var_25_3 = arg_25_0.contextData.ladyEnv

		var_2.SwitchCharacterSkin(var_25_3, arg_25_0.contextData.groupId, var_25_2, function()
			Dorm3dHxHelper = var_2_10000

			local var_26_0 = var_2_10000.HideCharacterPart
			local var_26_1 = arg_25_0.contextData.ladyEnv.lady
			local var_26_2 = arg_25_0.apartment

			var_26_0(var_26_1, var_2.GetHiddenParts(var_26_2, var_25_2))

			return
		end)
	else
		Dorm3dHxHelper = var_2

		local var_25_4 = var_2.HideCharacterPart
		local var_25_5 = arg_25_0.contextData.ladyEnv.lady
		local var_25_6 = arg_25_0.apartment

		var_25_4(var_25_5, var_4.GetHiddenParts(var_25_6, var_25_2))
	end

	return
end

return var_0_1
