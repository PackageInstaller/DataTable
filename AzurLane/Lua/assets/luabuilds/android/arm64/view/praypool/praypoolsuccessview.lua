local var_0_0 = class("PrayPoolSuccessView", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "PrayPoolSuccessView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()
	arg_2_0:Show()

	return
end

function var_0_0.OnDestroy(arg_3_0)
	arg_3_0.buildMsgBox:hide()

	return
end

function var_0_0.OnBackPress(arg_4_0)
	if arg_4_0:GetLoaded() and isActive(arg_4_0.boxTF) then
		arg_4_0.buildMsgBox:hide()

		return true
	end

	return
end

function var_0_0.initData(arg_5_0)
	arg_5_0.prayProxy = getProxy(PrayProxy)
	arg_5_0.poolType = arg_5_0.prayProxy:getSelectedPoolType()
	arg_5_0.playerProxy = getProxy(PlayerProxy)
	arg_5_0.bagProxy = getProxy(BagProxy)
	arg_5_0.useItem = pg.ship_data_create_material[1].use_item

	print("useitem " .. arg_5_0.useItem)

	arg_5_0.buildShipProxy = getProxy(BuildShipProxy)

	return
end

function var_0_0.initUI(arg_6_0)
	arg_6_0.shipTF = {
		arg_6_0._tf:Find("Ship1"),
		(arg_6_0._tf:Find("Ship2"))
	}
	arg_6_0.shipRarityTF = {
		arg_6_0._tf:Find("Rarity1"),
		(arg_6_0._tf:Find("Rarity2"))
	}
	arg_6_0.boxTF = arg_6_0._tf:Find("build_msg")
	arg_6_0.buildMsgBox = var_0_0.MsgBox(arg_6_0.boxTF)
	arg_6_0.buildBtn = arg_6_0._tf:Find("BuildBtn")
	arg_6_0.buildCubeNumText = arg_6_0._tf:Find("BuildInfo/CubeNum")
	arg_6_0.buildGoldNumText = arg_6_0._tf:Find("BuildInfo/GoldNum")
	arg_6_0.curCubeNumText = arg_6_0._tf:Find("CubeImg/NumText")
	arg_6_0.material1 = arg_6_0._tf:Find("material1")
	arg_6_0.material2 = arg_6_0._tf:Find("material2")
	arg_6_0.ratioSpriteMap = {}

	local var_6_0 = arg_6_0._tf:Find("Ratio")

	for iter_6_0 = 2, 6 do
		arg_6_0.ratioSpriteMap[iter_6_0] = getImageSprite(var_6_0:Find(tostring(iter_6_0)))
	end

	arg_6_0.raritySpriteMap = {
		Normal = {
			Light1 = getImageSprite(arg_6_0._tf:Find("Light/Normal/Light1")),
			Light2 = getImageSprite(arg_6_0._tf:Find("Light/Normal/Light2")),
			Light2_2 = getImageSprite(arg_6_0._tf:Find("Light/Normal/Light2_2")),
			Light3 = getImageSprite(arg_6_0._tf:Find("Light/Normal/Light3")),
			RarityBG = getImageSprite(arg_6_0._tf:Find("RarityBG/Normal"))
		},
		UR = {
			Light1 = getImageSprite(arg_6_0._tf:Find("Light/UR/Light1")),
			Light2 = getImageSprite(arg_6_0._tf:Find("Light/UR/Light2")),
			Light2_2 = getImageSprite(arg_6_0._tf:Find("Light/UR/Light2_2")),
			Light3 = getImageSprite(arg_6_0._tf:Find("Light/UR/Light3")),
			RarityBG = getImageSprite(arg_6_0._tf:Find("RarityBG/UR"))
		}
	}

	onButton(arg_6_0, arg_6_0.buildBtn, function()
		arg_6_0.buildMsgBox:show(math.max(1, (_.min({
			math.floor(arg_6_0.playerProxy:getData().gold / pg.ship_data_create_material[pg.activity_ship_create[arg_6_0.poolType].create_id].use_gold),
			math.floor(arg_6_0.bagProxy:getItemCountById(arg_6_0.useItem) / pg.ship_data_create_material[pg.activity_ship_create[arg_6_0.poolType].create_id].number_1),
			MAX_BUILD_WORK_COUNT - table.getCount((arg_6_0.buildShipProxy:getRawData()))
		}))), function(arg_8_0)
			if arg_8_0 > var_0 or var_0.gold < arg_8_0 * var_0.use_gold or var_0 < arg_8_0 * var_0.number_1 then
				return false
			end

			return true
		end, function(arg_9_0)
			arg_6_0:emit(PrayPoolConst.START_BUILD_SHIP_EVENT, var_0.id, arg_9_0, 0)

			return
		end, function(arg_10_0)
			local var_10_0 = arg_10_0 * var_0.use_gold
			local var_10_1 = arg_10_0 * var_0.number_1

			if var_0(arg_10_0) then
				local var_10_2 = COLOR_GREEN or COLOR_RED

				return i18n("build_ship_tip", arg_10_0, var_0.name, var_10_0, var_10_1, var_10_2)
			end
		end)

		return
	end, SFX_UI_BUILDING_STARTBUILDING)

	return
end

function var_0_0.updateUI(arg_11_0)
	arg_11_0:updatePaint((arg_11_0.prayProxy:getSelectedShipIDList()))

	local var_11_0 = arg_11_0.bagProxy:getItemById(arg_11_0.useItem) or {
		count = 0
	}

	setText(arg_11_0.curCubeNumText, (nil).count)
	setText(arg_11_0.buildCubeNumText, pg.ship_data_create_material[pg.activity_ship_create[arg_11_0.poolType].create_id].number_1)
	setText(arg_11_0.buildGoldNumText, pg.ship_data_create_material[pg.activity_ship_create[arg_11_0.poolType].create_id].use_gold)

	return
end

function var_0_0.updatePaint(arg_12_0, arg_12_1)
	for iter_12_0 = 1, 2 do
		local var_12_0 = pg.ship_data_statistics[arg_12_1[iter_12_0]].name
		local var_12_1 = pg.ship_data_statistics[arg_12_1[iter_12_0]].english_name
		local var_12_2 = pg.ship_data_statistics[arg_12_1[iter_12_0]].rarity
		local var_12_3 = pg.ship_data_statistics[arg_12_1[iter_12_0]].rarity == ShipRarity.SSR

		setPaintingPrefabAsync(arg_12_0.shipTF[iter_12_0]:Find("Mask/Paint"), Ship.getPaintingName(arg_12_1[iter_12_0]), "build", function()
			local var_13_0 = GetComponent(var_0:Find("fitter"):GetChild(0), "MeshImage")

			if iter_12_0 == 2 then
				local var_13_2 = var_13_1:GetComponent(typeof(Image)).material

				var_13_2:SetFloat("_Range", iter_12_0 == 2 and 0.9 or -0.57)
				var_13_2:SetFloat("_Degree", iter_12_0 == 2 and -50 or 50)

				var_13_0.material = var_13_2

				return
			end
		end)

		local var_12_5 = var_12_4:Find("Light1")
		local var_12_6 = var_12_4:Find("Light2")
		local var_12_7 = var_12_6:Find("Light2_2")
		local var_12_8 = var_12_4:Find("Light3")

		if not var_12_3 then
			setImageSprite(var_12_5, arg_12_0.raritySpriteMap.Normal.Light1)
			setImageSprite(var_12_6, arg_12_0.raritySpriteMap.Normal.Light2)
			setImageSprite(var_12_7, arg_12_0.raritySpriteMap.Normal.Light2_2)
			setImageSprite(var_12_8, arg_12_0.raritySpriteMap.Normal.Light3)
			setImageColor(var_12_5, var_0_0.Rarity_To_Light_Color_1[var_12_2])
			setImageColor(var_12_6, var_0_0.Rarity_To_Light_Color_1[var_12_2])
			setImageColor(var_12_7, var_0_0.Rarity_To_Light_Color_1[var_12_2])
			setImageColor(var_12_8, var_0_0.Rarity_To_Light_Color_2[var_12_2])
		else
			setImageSprite(var_12_5, arg_12_0.raritySpriteMap.UR.Light1)
			setImageSprite(var_12_6, arg_12_0.raritySpriteMap.UR.Light2)
			setImageSprite(var_12_7, arg_12_0.raritySpriteMap.UR.Light2_2)
			setImageSprite(var_12_8, arg_12_0.raritySpriteMap.UR.Light3)
		end

		local var_12_9 = arg_12_0.shipRarityTF[iter_12_0]

		if var_12_3 then
			local var_12_10 = arg_12_0.raritySpriteMap.UR.RarityBG or arg_12_0.raritySpriteMap.Normal.RarityBG

			setImageSprite(var_12_9, var_12_10)
			setText(var_12_4:Find("NameText"), var_12_0)
			setText(var_12_4:Find("NameEngText"), var_12_1)
			setImageSprite(var_12_9:Find("NumImg"), arg_12_0.ratioSpriteMap[var_12_2], true)
		end
	end

	return
end

function var_0_0.MsgBox(arg_14_0)
	local var_14_0 = {
		_go = arg_14_0
	}

	;({
		_go = arg_14_0
	}).__cname = "buildmsgbox"
	;({
		_go = arg_14_0
	})._tf = tf(arg_14_0)
	;({
		_go = arg_14_0
	}).inited = false
	;({
		_go = arg_14_0
	}).cancenlBtn = findTF(({
		_go = arg_14_0
	})._go, "window/btns/cancel_btn")
	;({
		_go = arg_14_0
	}).confirmBtn = findTF(({
		_go = arg_14_0
	})._go, "window/btns/confirm_btn")
	;({
		_go = arg_14_0
	}).closeBtn = findTF(({
		_go = arg_14_0
	})._go, "window/close_btn")
	;({
		_go = arg_14_0
	}).count = 1
	;({
		_go = arg_14_0
	}).minusBtn = findTF(({
		_go = arg_14_0
	})._go, "window/content/calc_panel/minus")
	;({
		_go = arg_14_0
	}).addBtn = findTF(({
		_go = arg_14_0
	})._go, "window/content/calc_panel/add")
	;({
		_go = arg_14_0
	}).maxBtn = findTF(({
		_go = arg_14_0
	})._go, "window/content/max")
	;({
		_go = arg_14_0
	}).valueTxt = findTF(({
		_go = arg_14_0
	})._go, "window/content/calc_panel/Text"):GetComponent(typeof(Text))
	;({
		_go = arg_14_0
	}).text = findTF(({
		_go = arg_14_0
	})._go, "window/content/Text"):GetComponent(typeof(Text))
	;({
		_go = arg_14_0
	}).buildUI = arg_14_0.parent
	;({
		_go = arg_14_0
	}).active = false

	pg.DelegateInfo.New({
		_go = arg_14_0
	})
	setText(findTF(({
		_go = arg_14_0
	}).cancenlBtn, "Image/Image (1)"), i18n("text_cancel"))
	setText(findTF(({
		_go = arg_14_0
	}).confirmBtn, "Image/Image (1)"), i18n("text_confirm"))

	local function var_14_1(arg_15_0, arg_15_1)
		var_14_0.valueTxt.text = arg_15_0
		var_14_0.text.text = arg_15_1 and arg_15_1(arg_15_0) or ""

		return
	end

	;({
		_go = arg_14_0
	}).init = function(arg_16_0)
		arg_16_0.inited = true

		onButton(arg_16_0, arg_16_0._tf, function()
			arg_16_0:hide()

			return
		end, SFX_PANEL)
		onButton(arg_16_0, arg_16_0.cancenlBtn, function()
			arg_16_0:hide()

			return
		end, SFX_PANEL)
		onButton(arg_16_0, arg_16_0.confirmBtn, function()
			if arg_16_0.onConfirm then
				arg_16_0.onConfirm(arg_16_0.count)
			end

			arg_16_0:hide()

			return
		end, SFX_PANEL)
		onButton(arg_16_0, arg_16_0.closeBtn, function()
			arg_16_0:hide()

			return
		end, SFX_PANEL)
		onButton(arg_16_0, arg_16_0.minusBtn, function()
			if arg_16_0:verifyCount(arg_16_0.count - 1) then
				arg_16_0.count = math.max(arg_16_0.count - 1, 1)

				var_14_1(arg_16_0.count, arg_16_0.updateText)
			end

			return
		end, SFX_PANEL)
		onButton(arg_16_0, arg_16_0.addBtn, function()
			if arg_16_0:verifyCount(arg_16_0.count + 1) then
				arg_16_0.count = math.min(arg_16_0.count + 1, arg_16_0.max)

				var_14_1(arg_16_0.count, arg_16_0.updateText)
			end

			return
		end, SFX_PANEL)
		onButton(arg_16_0, arg_16_0.maxBtn, function()
			if arg_16_0:verifyCount(arg_16_0.max) then
				arg_16_0.count = arg_16_0.max

				var_14_1(arg_16_0.count, arg_16_0.updateText)
			end

			return
		end, SFX_PANEL)

		return
	end
	;({
		_go = arg_14_0
	}).verifyCount = function(arg_24_0, arg_24_1)
		if arg_24_0.verify then
			return arg_24_0.verify(arg_24_1)
		end

		return true
	end
	;({
		_go = arg_14_0
	}).isActive = function(arg_25_0)
		return arg_25_0.active
	end
	;({
		_go = arg_14_0
	}).show = function(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		arg_26_0.verify = arg_26_2
		arg_26_0.onConfirm = arg_26_3
		arg_26_0.active = true
		arg_26_0.max = arg_26_1 or 1
		arg_26_0.count = 1
		arg_26_0.updateText = arg_26_4

		var_14_1(arg_26_0.count, arg_26_4)
		setActive(var_14_0._go, true)

		if not arg_26_0.inited then
			arg_26_0:init()
		end

		pg.UIMgr.GetInstance():BlurPanel(arg_26_0._tf)

		return
	end
	;({
		_go = arg_14_0
	}).hide = function(arg_27_0)
		if arg_27_0:isActive() then
			arg_27_0.onConfirm = nil
			arg_27_0.active = false
			arg_27_0.updateText = nil
			arg_27_0.count = 1
			arg_27_0.max = 1
			arg_27_0.verify = nil

			setActive(var_14_0._go, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(arg_27_0._tf, arg_27_0.buildUI)
		end

		return
	end
	;({
		_go = arg_14_0
	}).close = function(arg_28_0)
		arg_28_0:hide()
		pg.DelegateInfo.Dispose(arg_28_0)

		return
	end

	return {
		_go = arg_14_0
	}
end

var_0_0.Rarity_To_Light_Color_1 = {
	[2] = Color(0.5568627450980392, 0.5568627450980392, 0.5568627450980392, 1),
	[3] = Color(0.1568627450980392, 0.26666666666666666, 0.615686274509804, 1),
	[4] = Color(0.32941176470588235, 0.1568627450980392, 0.615686274509804, 1),
	[5] = Color(1, 0.8313725490196079, 0.3137254901960784, 1)
}
var_0_0.Rarity_To_Light_Color_2 = {
	[2] = Color(0.6235294117647059, 0.6549019607843137, 0.7411764705882353, 1),
	[3] = Color(0.34901960784313724, 0.5294117647058824, 0.996078431372549, 1),
	[4] = Color(0.9058823529411765, 0.615686274509804, 0.996078431372549, 1),
	[5] = Color(0.996078431372549, 0.8705882352941177, 0.3215686274509804, 1)
}

return var_0_0
