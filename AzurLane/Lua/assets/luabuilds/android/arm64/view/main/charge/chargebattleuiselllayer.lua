local var_0_0 = class("ChargeBattleUISellLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "ChargeBattleUISellLayer"
end

function var_0_0.init(arg_2_0)
	arg_2_0.loader = AutoLoader.New()

	arg_2_0:InitData()
	arg_2_0:InitUI()
	arg_2_0:updateGiftWindow()
	arg_2_0:InitBattleShow()

	return
end

function var_0_0.didEnter(arg_3_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.willExit(arg_4_0)
	arg_4_0.loader:Clear()
	UpdateBeat:RemoveListener(arg_4_0.handle)
	arg_4_0:ClearPreviewer()
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.InitData(arg_5_0)
	arg_5_0.showGoodVO = arg_5_0.contextData.showGoodVO
	arg_5_0.chargedList = arg_5_0.contextData.chargedList
	arg_5_0.goodVOList = arg_5_0.showGoodVO:getSameLimitGroupTecGoods()
	arg_5_0.normalGoodVO = nil
	arg_5_0.specailGoodVO = nil

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.goodVOList) do
		if iter_5_1:getConfig("limit_arg") == 1 then
			if not arg_5_0.normalGoodVO then
				arg_5_0.normalGoodVO = iter_5_1
			else
				arg_5_0.specailGoodVO = iter_5_1
			end
		end
	end

	arg_5_0.battleSkinId = nil

	return
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0.bg = arg_6_0._tf:Find("BG")
	arg_6_0.titleText = arg_6_0._tf:Find("mainPanel/topBar/left/nameMask/name")
	arg_6_0.tipText = arg_6_0._tf:Find("mainPanel/topBar/left/tipText")
	arg_6_0.middleText = arg_6_0._tf:Find("mainPanel/topBar/middle/Text")
	arg_6_0.closeBtn = arg_6_0._tf:Find("mainPanel/topBar/right")
	arg_6_0.startShowBtn = arg_6_0._tf:Find("mainPanel/main/showWindow")
	arg_6_0.normalWindow = arg_6_0._tf:Find("mainPanel/main/normalWindow")
	arg_6_0.specialWindow = arg_6_0._tf:Find("mainPanel/main/specialWindow")
	arg_6_0.normalText = arg_6_0.normalWindow:Find("title")
	arg_6_0.specialText = arg_6_0.specialWindow:Find("title")
	arg_6_0.buyNormalBtn = arg_6_0.normalWindow:Find("buyNormalButton")
	arg_6_0.buySpecialBtn = arg_6_0.specialWindow:Find("buySpecialButton")
	arg_6_0.itemTpl = arg_6_0._tf:Find("itemTpl")
	arg_6_0.normalList = UIItemList.New(arg_6_0.normalWindow:Find("list"), arg_6_0.itemTpl)
	arg_6_0.specialList = UIItemList.New(arg_6_0.specialWindow:Find("list"), arg_6_0.itemTpl)

	setScrollText(arg_6_0.titleText, "")
	setText(arg_6_0.tipText, i18n("ui_pack_tip1"))
	setText(arg_6_0.normalText, i18n("ui_pack_tip2"))
	setText(arg_6_0.specialText, i18n("ui_pack_tip3"))

	arg_6_0.preview = arg_6_0._tf:Find("mainPanel/main/preview")
	arg_6_0.sea = arg_6_0.preview:Find("sea")
	arg_6_0.rawImage = arg_6_0.sea:GetComponent("RawImage")

	setActive(arg_6_0.preview, false)
	setActive(arg_6_0.rawImage, false)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		arg_6_0:ClearPreviewer()
		arg_6_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.bg, function()
		arg_6_0:ClearPreviewer()
		arg_6_0:closeView()

		return
	end, SFX_PANEL)

	arg_6_0.tipsGo = arg_6_0._tf:Find("mainPanel/topBar/left/tips")
	arg_6_0.tipsText = arg_6_0._tf:Find("mainPanel/topBar/left/tips/text")
	arg_6_0.toggleList = UIItemList.New(arg_6_0._tf:Find("mainPanel/topBar/left/elementList"), arg_6_0._tf:Find("mainPanel/topBar/left/elementList/main_toggle"))
	arg_6_0.handle = UpdateBeat:CreateListener(arg_6_0.UpdateClick, arg_6_0)

	UpdateBeat:AddListener(arg_6_0.handle)

	return
end

function var_0_0.ShowTips(arg_9_0, arg_9_1)
	setActive(arg_9_0.tipsGo, arg_9_1)

	return
end

function var_0_0.UpdateClick(arg_10_0)
	if UnityEngine.Input.GetMouseButtonDown(0) then
		arg_10_0.toggleList:each(function(arg_11_0, arg_11_1)
			GetComponent(arg_11_1, typeof(Toggle)).isOn = false

			return
		end)
	end

	return
end

function var_0_0.updateGiftWindow(arg_12_0)
	setText(arg_12_0.buyNormalBtn:Find("Price/BuyText"), i18n("word_buy"))
	setText(arg_12_0.buyNormalBtn:Find("Price/content/Text"), arg_12_0.normalGoodVO:getConfig("money"))
	onButton(arg_12_0, arg_12_0.buyNormalBtn, function()
		pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_12_0.normalGoodVO.id
		})
		arg_12_0:ClearPreviewer()
		arg_12_0:closeView()

		return
	end, SFX_PANEL)
	setText(arg_12_0.buySpecialBtn:Find("Price/BuyText"), i18n("word_buy"))
	setText(arg_12_0.buySpecialBtn:Find("Price/content/Text"), arg_12_0.specailGoodVO:getConfig("money"))
	onButton(arg_12_0, arg_12_0.buySpecialBtn, function()
		pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_12_0.specailGoodVO.id
		})
		arg_12_0:ClearPreviewer()
		arg_12_0:closeView()

		return
	end, SFX_PANEL)

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.normalGoodVO:GetExtraServiceItem()) do
		table.insert(var_12_0, iter_12_1)

		arg_12_0.battleSkinId = arg_12_0.battleSkinId or iter_12_1.id
	end

	arg_12_0.normalList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = arg_15_2:Find("Container"):GetChild(0)
			local var_15_1 = var_12_0[arg_15_1 + 1]

			var_12_0[arg_15_1 + 1].notPlay = true

			updateDrop(var_15_0, var_12_0[arg_15_1 + 1])
			onButton(arg_12_0, var_15_0, function()
				arg_12_0:emit(BaseUI.ON_DROP, var_15_1)

				return
			end, SFX_PANEL)
			setScrollText(arg_15_2:Find("TextMask/Text"), var_12_0[arg_15_1 + 1]:getName())

			if arg_12_0.titleText:GetComponent(typeof(Text)).text == "" then
				setScrollText(arg_12_0.titleText, var_12_0[arg_15_1 + 1]:getName())
			end
		end

		return
	end)
	arg_12_0.normalList:align(#var_12_0)

	var_12_0 = {}

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.specailGoodVO:GetExtraServiceItem()) do
		table.insert(var_12_0, iter_12_3)
	end

	arg_12_0.specialList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = arg_17_2:Find("Container"):GetChild(0)
			local var_17_1 = var_12_0[arg_17_1 + 1]

			updateDrop(var_17_0, var_12_0[arg_17_1 + 1])

			var_12_0[arg_17_1 + 1].notPlay = true

			onButton(arg_12_0, var_17_0, function()
				arg_12_0:emit(BaseUI.ON_DROP, var_17_1)

				return
			end, SFX_PANEL)
			setScrollText(arg_17_2:Find("TextMask/Text"), var_12_0[arg_17_1 + 1]:getName())
		end

		return
	end)
	arg_12_0.specialList:align(#var_12_0)
	arg_12_0:InitTitle(var_12_0)

	return
end

function var_0_0.InitBattleShow(arg_19_0)
	local var_19_0 = Ship.New({
		id = 100001,
		configId = 100001,
		skin_id = 100000
	})
	local var_19_1 = Ship.New({
		id = 100011,
		configId = 100011,
		skin_id = 100010
	})
	local var_19_2 = pg.item_data_battleui[arg_19_0.battleSkinId].key

	onButton(arg_19_0, arg_19_0.startShowBtn, function()
		local var_20_0 = "CombatUI" .. var_19_2
		local var_20_1 = "CombatHPBar" .. var_19_2
		local var_20_2
		local var_20_3
		local var_20_4

		seriesAsync({
			function(arg_21_0)
				PoolMgr.GetInstance():GetUI(var_20_1, true, function(arg_22_0)
					var_20_3 = arg_22_0

					arg_21_0()

					return
				end)

				return
			end,
			function(arg_23_0)
				PoolMgr.GetInstance():GetUI(var_20_1, true, function(arg_24_0)
					var_20_4 = arg_24_0

					arg_23_0()

					return
				end)

				return
			end,
			function(arg_25_0)
				PoolMgr.GetInstance():GetUI(var_20_0, true, function(arg_26_0)
					var_20_2 = arg_26_0

					arg_25_0()

					return
				end)

				return
			end
		}, function()
			local var_27_0 = pg.UIMgr.GetInstance().UIMain

			var_20_2.transform:SetParent(arg_19_0.preview, false)
			var_20_3.transform:SetParent(arg_19_0.preview, false)
			var_20_4.transform:SetParent(arg_19_0.preview, false)
			setActive(arg_19_0.preview, true)

			var_20_2.transform.localScale = Vector3(arg_19_0.sea.rect.width / 0, arg_19_0.sea.rect.height / 1080, 1)
			arg_19_0.previewer = CombatUIPreviewer.New(arg_19_0.rawImage)

			arg_19_0.previewer:setDisplayWeapon({
				100
			})
			arg_19_0.previewer:setCombatUI(var_20_2, var_20_3, var_20_4, var_19_2)
			arg_19_0.previewer:load(40000, var_19_0, var_19_1, {}, function()
				return
			end)

			return
		end)

		return
	end, SFX_PANEL)
	triggerButton(arg_19_0.startShowBtn)

	return
end

function var_0_0.InitTitle(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if iter_29_1.type == DROP_TYPE_COMBAT_UI_STYLE then
			setScrollText(arg_29_0.titleText, iter_29_1:getName())

			local var_29_0 = pg.item_data_battleui[iter_29_1.id]

			arg_29_0.loader:GetSpriteQuiet("ui/combatskinrare", string.format("rare_%s", pg.item_data_battleui[iter_29_1.id].rare), arg_29_0._tf:Find("mainPanel/topBar/left/rareImage"))
			arg_29_0.toggleList:make(function(arg_30_0, arg_30_1, arg_30_2)
				if arg_30_0 == UIItemList.EventUpdate then
					local var_30_0 = var_29_0.rare_display[arg_30_1 + 1]

					arg_29_0.loader:GetSpriteQuiet("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_29_0.rare_display[arg_30_1 + 1]], findTF(arg_30_2, "on"))
					arg_29_0.loader:GetSpriteQuiet("ui/combatskinrare", string.format("%s_unselected", CombatSkinConst.TYPE_ICON_NAME[var_29_0.rare_display[arg_30_1 + 1]]), findTF(arg_30_2, "off"))
					onToggle(arg_29_0, arg_30_2, function(arg_31_0)
						setText(arg_29_0.tipsText, i18n("battleui_display" .. var_30_0))
						setLocalPosition(arg_29_0.tipsGo, arg_29_0._tf:Find("mainPanel/topBar/left"):InverseTransformPoint(arg_30_2.transform.position) + Vector3(-20, 46, 0))
						arg_29_0:ShowTips(arg_31_0)

						return
					end, SFX_CONFIRM)
				end

				return
			end)
			arg_29_0.toggleList:align(#pg.item_data_battleui[iter_29_1.id].rare_display)
		end
	end

	return
end

function var_0_0.ClearPreviewer(arg_32_0)
	if arg_32_0.previewer then
		setActive(arg_32_0.preview, false)
		arg_32_0.previewer:clear()

		arg_32_0.previewer = nil
	end

	return
end

function var_0_0.onBackPressed(arg_33_0)
	arg_33_0:ClearPreviewer()
	arg_33_0:emit(var_0_0.ON_BACK_PRESSED)

	return
end

return var_0_0
