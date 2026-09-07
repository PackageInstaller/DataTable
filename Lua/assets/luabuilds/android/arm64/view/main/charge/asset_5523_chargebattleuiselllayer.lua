local ChargeBattleUISellLayer = class("ChargeBattleUISellLayer", import("...base.BaseUI"))

function ChargeBattleUISellLayer:getUIName()
	return "ChargeBattleUISellLayer"
end

function ChargeBattleUISellLayer:init()
	self.loader = AutoLoader.New()

	self:InitData()
	self:InitUI()
	self:updateGiftWindow()
	self:InitBattleShow()

	return
end

function ChargeBattleUISellLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ChargeBattleUISellLayer:willExit()
	self.loader:Clear()
	UpdateBeat:RemoveListener(self.handle)
	self:ClearPreviewer()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function ChargeBattleUISellLayer:InitData()
	self.showGoodVO = self.contextData.showGoodVO
	self.chargedList = self.contextData.chargedList
	self.goodVOList = self.showGoodVO:getSameLimitGroupTecGoods()
	self.normalGoodVO = nil
	self.specailGoodVO = nil

	for iter_5_0, iter_5_1 in ipairs(self.goodVOList) do
		if iter_5_1:getConfig("limit_arg") == 1 then
			if not self.normalGoodVO then
				self.normalGoodVO = iter_5_1
			else
				self.specailGoodVO = iter_5_1
			end
		end
	end

	self.battleSkinId = nil

	return
end

function ChargeBattleUISellLayer:InitUI()
	self.bg = self._tf:Find("BG")
	self.titleText = self._tf:Find("mainPanel/topBar/left/nameMask/name")
	self.tipText = self._tf:Find("mainPanel/topBar/left/tipText")
	self.middleText = self._tf:Find("mainPanel/topBar/middle/Text")
	self.closeBtn = self._tf:Find("mainPanel/topBar/right")
	self.startShowBtn = self._tf:Find("mainPanel/main/showWindow")
	self.normalWindow = self._tf:Find("mainPanel/main/normalWindow")
	self.specialWindow = self._tf:Find("mainPanel/main/specialWindow")
	self.normalText = self.normalWindow:Find("title")
	self.specialText = self.specialWindow:Find("title")
	self.buyNormalBtn = self.normalWindow:Find("buyNormalButton")
	self.buySpecialBtn = self.specialWindow:Find("buySpecialButton")
	self.itemTpl = self._tf:Find("itemTpl")
	self.normalList = UIItemList.New(self.normalWindow:Find("list"), self.itemTpl)
	self.specialList = UIItemList.New(self.specialWindow:Find("list"), self.itemTpl)

	setScrollText(self.titleText, "")
	setText(self.tipText, i18n("ui_pack_tip1"))
	setText(self.normalText, i18n("ui_pack_tip2"))
	setText(self.specialText, i18n("ui_pack_tip3"))

	self.preview = self._tf:Find("mainPanel/main/preview")
	self.sea = self.preview:Find("sea")
	self.rawImage = self.sea:GetComponent("RawImage")

	setActive(self.preview, false)
	setActive(self.rawImage, false)
	onButton(self, self.closeBtn, function()
		self:ClearPreviewer()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.bg, function()
		self:ClearPreviewer()
		self:closeView()

		return
	end, SFX_PANEL)

	self.tipsGo = self._tf:Find("mainPanel/topBar/left/tips")
	self.tipsText = self._tf:Find("mainPanel/topBar/left/tips/text")
	self.toggleList = UIItemList.New(self._tf:Find("mainPanel/topBar/left/elementList"), self._tf:Find("mainPanel/topBar/left/elementList/main_toggle"))
	self.handle = UpdateBeat:CreateListener(self.UpdateClick, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function ChargeBattleUISellLayer:ShowTips(arg_9_1)
	setActive(self.tipsGo, arg_9_1)

	return
end

function ChargeBattleUISellLayer:UpdateClick()
	if UnityEngine.Input.GetMouseButtonDown(0) then
		self.toggleList:each(function(arg_11_0, arg_11_1)
			GetComponent(arg_11_1, typeof(Toggle)).isOn = false

			return
		end)
	end

	return
end

function ChargeBattleUISellLayer:updateGiftWindow()
	setText(self.buyNormalBtn:Find("Price/BuyText"), i18n("word_buy"))
	setText(self.buyNormalBtn:Find("Price/content/Text"), self.normalGoodVO:getConfig("money"))
	onButton(self, self.buyNormalBtn, function()
		pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = self.normalGoodVO.id
		})
		self:ClearPreviewer()
		self:closeView()

		return
	end, SFX_PANEL)
	setText(self.buySpecialBtn:Find("Price/BuyText"), i18n("word_buy"))
	setText(self.buySpecialBtn:Find("Price/content/Text"), self.specailGoodVO:getConfig("money"))
	onButton(self, self.buySpecialBtn, function()
		pg.m02:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = self.specailGoodVO.id
		})
		self:ClearPreviewer()
		self:closeView()

		return
	end, SFX_PANEL)

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self.normalGoodVO:GetExtraServiceItem()) do
		table.insert(var_12_0, iter_12_1)

		self.battleSkinId = self.battleSkinId or iter_12_1.id
	end

	self.normalList:make(function(arg_15_0, arg_15_1, arg_15_2)
		if arg_15_0 == UIItemList.EventUpdate then
			local var_15_0 = arg_15_2:Find("Container"):GetChild(0)
			local var_15_1 = var_12_0[arg_15_1 + 1]

			var_12_0[arg_15_1 + 1].notPlay = true

			updateDrop(var_15_0, var_12_0[arg_15_1 + 1])
			onButton(self, var_15_0, function()
				self:emit(BaseUI.ON_DROP, var_15_1)

				return
			end, SFX_PANEL)
			setScrollText(arg_15_2:Find("TextMask/Text"), var_12_0[arg_15_1 + 1]:getName())

			if self.titleText:GetComponent(typeof(Text)).text == "" then
				setScrollText(self.titleText, var_12_0[arg_15_1 + 1]:getName())
			end
		end

		return
	end)
	self.normalList:align(#var_12_0)

	var_12_0 = {}

	for iter_12_2, iter_12_3 in ipairs(self.specailGoodVO:GetExtraServiceItem()) do
		table.insert(var_12_0, iter_12_3)
	end

	self.specialList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			local var_17_0 = arg_17_2:Find("Container"):GetChild(0)
			local var_17_1 = var_12_0[arg_17_1 + 1]

			updateDrop(var_17_0, var_12_0[arg_17_1 + 1])

			var_12_0[arg_17_1 + 1].notPlay = true

			onButton(self, var_17_0, function()
				self:emit(BaseUI.ON_DROP, var_17_1)

				return
			end, SFX_PANEL)
			setScrollText(arg_17_2:Find("TextMask/Text"), var_12_0[arg_17_1 + 1]:getName())
		end

		return
	end)
	self.specialList:align(#var_12_0)
	self:InitTitle(var_12_0)

	return
end

function ChargeBattleUISellLayer:InitBattleShow()
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
	local var_19_2 = pg.item_data_battleui[self.battleSkinId].key

	onButton(self, self.startShowBtn, function()
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

			var_20_2.transform:SetParent(self.preview, false)
			var_20_3.transform:SetParent(self.preview, false)
			var_20_4.transform:SetParent(self.preview, false)
			setActive(self.preview, true)

			var_20_2.transform.localScale = Vector3(self.sea.rect.width / 0, self.sea.rect.height / 1080, 1)
			self.previewer = CombatUIPreviewer.New(self.rawImage)

			self.previewer:setDisplayWeapon({
				100
			})
			self.previewer:setCombatUI(var_20_2, var_20_3, var_20_4, var_19_2)
			self.previewer:load(40000, var_19_0, var_19_1, {}, function()
				return
			end)

			return
		end)

		return
	end, SFX_PANEL)
	triggerButton(self.startShowBtn)

	return
end

function ChargeBattleUISellLayer:InitTitle(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if iter_29_1.type == DROP_TYPE_COMBAT_UI_STYLE then
			setScrollText(self.titleText, iter_29_1:getName())

			local var_29_0 = pg.item_data_battleui[iter_29_1.id]

			self.loader:GetSpriteQuiet("ui/combatskinrare", string.format("rare_%s", pg.item_data_battleui[iter_29_1.id].rare), self._tf:Find("mainPanel/topBar/left/rareImage"))
			self.toggleList:make(function(arg_30_0, arg_30_1, arg_30_2)
				if arg_30_0 == UIItemList.EventUpdate then
					local var_30_0 = var_29_0.rare_display[arg_30_1 + 1]

					self.loader:GetSpriteQuiet("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_29_0.rare_display[arg_30_1 + 1]], findTF(arg_30_2, "on"))
					self.loader:GetSpriteQuiet("ui/combatskinrare", string.format("%s_unselected", CombatSkinConst.TYPE_ICON_NAME[var_29_0.rare_display[arg_30_1 + 1]]), findTF(arg_30_2, "off"))
					onToggle(self, arg_30_2, function(arg_31_0)
						setText(self.tipsText, i18n("battleui_display" .. var_30_0))
						setLocalPosition(self.tipsGo, self._tf:Find("mainPanel/topBar/left"):InverseTransformPoint(arg_30_2.transform.position) + Vector3(-20, 46, 0))
						self:ShowTips(arg_31_0)

						return
					end, SFX_CONFIRM)
				end

				return
			end)
			self.toggleList:align(#pg.item_data_battleui[iter_29_1.id].rare_display)
		end
	end

	return
end

function ChargeBattleUISellLayer:ClearPreviewer()
	if self.previewer then
		setActive(self.preview, false)
		self.previewer:clear()

		self.previewer = nil
	end

	return
end

function ChargeBattleUISellLayer:onBackPressed()
	self:ClearPreviewer()
	self:emit(ChargeBattleUISellLayer.ON_BACK_PRESSED)

	return
end

return ChargeBattleUISellLayer
