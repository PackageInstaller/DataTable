local AttireCombatUIPanel = class("AttireCombatUIPanel", import(".AttireFramePanel"))

local function var_0_2(arg_1_0, arg_1_1)
	local var_1_0 = {}

	var_1_0.__cname = "UICARD"

	function var_1_0:ShowTips(arg_5_1)
		setActive(self.tipsGo, arg_5_1)

		return
	end

	function var_1_0:isEmpty()
		return not self.uiStyle or self.uiStyle.id == -1
	end

	function var_1_0:Update(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
		self.uiStyle = arg_7_1

		if self:isEmpty() then
			setActive(self.info, false)
			setActive(self.empty, true)

			return
		else
			setActive(self.info, true)
			setActive(self.empty, false)
		end

		LoadImageSpriteAsync("combatuistyle/" .. arg_7_1:getConfig("icon"), self.icon, true)
		setScrollText(self.nameTxt, arg_7_1:getConfig("name"))
		setText(self.descTxt, arg_7_1:getConfig("desc"))
		setText(self.conditionTxt, arg_7_1:getConfig("unlock"))
		setActive(self.tags[2], arg_7_1:isOwned() and arg_7_2:getAttireByType(arg_7_1:getType()) == arg_7_1.id)
		setActive(self.tags[1], arg_7_1:isNew())
		setActive(self.crossPrint, not arg_7_3 and math.fmod(arg_7_4 + 1, arg_7_5) ~= 0)
		setActive(self.notOwn, not arg_7_1:isOwned())
		arg_1_1:GetSpriteQuiet("ui/combatskinrare", string.format("rare_%s", (arg_7_1:getConfig("rare"))), findTF(self._go, "info/rareImage"))
		self.toggleList:align(#arg_7_1:getConfig("rare_display"))

		return
	end

	function var_1_0:UpdateClick()
		if UnityEngine.Input.GetMouseButtonDown(0) then
			self.toggleList:each(function(arg_9_0, arg_9_1)
				GetComponent(arg_9_1, typeof(Toggle)).isOn = false

				return
			end)
		end

		return
	end

	function var_1_0:Dispose()
		UpdateBeat:RemoveListener(self.handle)
		pg.DelegateInfo.Dispose(self)

		return
	end

	function var_1_0:UpdateSelected(arg_11_1)
		setActive(self.selected, arg_11_1)

		return
	end

	function var_1_0:IsOwned()
		return self.uiStyle:isOwned()
	end

	;(function(arg_2_0)
		pg.DelegateInfo.New(arg_2_0)

		arg_2_0._go = arg_1_0
		arg_2_0.info = findTF(arg_2_0._go, "info")
		arg_2_0.empty = findTF(arg_2_0._go, "empty")
		arg_2_0.icon = findTF(arg_2_0._go, "info/icon")
		arg_2_0.selected = findTF(arg_2_0._go, "info/selected")
		arg_2_0.nameTxt = findTF(arg_2_0._go, "info/nameMask/name")
		arg_2_0.descTxt = findTF(arg_2_0._go, "info/desc")
		arg_2_0.conditionTxt = findTF(arg_2_0._go, "info/condition")
		arg_2_0.tags = {
			findTF(arg_2_0._go, "info/tags/new"),
			findTF(arg_2_0._go, "info/tags/e")
		}
		arg_2_0.crossPrint = findTF(arg_2_0._go, "prints/odd")
		arg_2_0.notOwn = findTF(arg_2_0._go, "info/notOwn")
		arg_2_0.tipsGo = findTF(arg_2_0._go, "info/tips")
		arg_2_0.tipsText = findTF(arg_2_0._go, "info/tips/text")
		arg_2_0.toggleItem = findTF(arg_2_0._go, "info/elementList/main_toggle")
		arg_2_0.toggleList = UIItemList.New(findTF(arg_2_0._go, "info/elementList"), arg_2_0.toggleItem)

		arg_2_0.toggleList:make(function(arg_3_0, arg_3_1, arg_3_2)
			if arg_3_0 == UIItemList.EventUpdate then
				local var_3_0 = arg_2_0.uiStyle:getConfig("rare_display")

				arg_1_1:GetSpriteQuiet("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_3_0[arg_3_1 + 1]], findTF(arg_3_2, "on"))
				arg_1_1:GetSpriteQuiet("ui/combatskinrare", string.format("%s_unselected", CombatSkinConst.TYPE_ICON_NAME[var_3_0[arg_3_1 + 1]]), findTF(arg_3_2, "off"))
				onToggle(arg_2_0, arg_3_2, function(arg_4_0)
					setText(arg_2_0.tipsText, i18n("battleui_display" .. var_3_0[arg_3_1 + 1]))
					setLocalPosition(arg_2_0.tipsGo, findTF(arg_2_0._go, "info"):InverseTransformPoint(arg_3_2.transform.position) + Vector3(24, 46, 0))
					arg_2_0:ShowTips(arg_4_0)

					return
				end)
			end

			return
		end)

		arg_2_0.handle = UpdateBeat:CreateListener(arg_2_0.UpdateClick, arg_2_0)

		UpdateBeat:AddListener(arg_2_0.handle)

		return
	end)(var_1_0)

	return var_1_0
end

function AttireCombatUIPanel:OnInit()
	self.listPanel = self._tf:Find("list_panel")
	self.scolrect = self.listPanel:Find("scrollrect"):GetComponent("LScrollRect")
	self.confirmBtn = self.listPanel:Find("confirm")
	self.previewBtn = self.listPanel:Find("preview")
	self.lockBtn = self.listPanel:Find("lock")

	function self.scolrect.onInitItem(arg_14_0)
		self:OnInitItem(arg_14_0)

		return
	end

	function self.scolrect.onUpdateItem(arg_15_0, arg_15_1)
		self:OnUpdateItem(arg_15_0, arg_15_1)

		return
	end

	function self.scolrect.onReturnItem(arg_16_0, arg_16_1)
		self:OnReturnItem(arg_16_0, arg_16_1)

		return
	end

	self.cards = {}
	self.totalCount = self._tf:Find("total_count/Text"):GetComponent(typeof(Text))
	self.preview = self._tf:Find("preview")
	self.sea = self._tf:Find("preview/sea")
	self.rawImage = self.sea:GetComponent("RawImage")
	self.uiLayer = self._tf:Find("preview/ui")

	setText(self.preview:Find("bg/title/Image"), i18n("word_preview"))
	setText(self.confirmBtn:Find("Text"), i18n("attire_combatui_confirm"))
	setText(self.previewBtn:Find("Text"), i18n("attire_combatui_preview"))
	setText(self.lockBtn:Find("Text"), i18n("index_not_obtained"))
	setActive(self.preview, false)
	setActive(self.rawImage, false)
	onButton(self, self.preview, function()
		self:onBackPressed()

		return
	end)

	self.loader = AutoLoader.New()

	return
end

function AttireCombatUIPanel:getUIName()
	return "AttireCombatUIUI"
end

function AttireCombatUIPanel:GetData()
	return self.rawAttireVOs.combatUIStyles
end

function AttireCombatUIPanel:OnInitItem(arg_20_1)
	local var_20_0 = var_0_2(arg_20_1, self.loader)

	self.cards[arg_20_1] = var_20_0

	onButton(self, var_20_0._go, function()
		if not var_20_0:isEmpty() then
			if self.card then
				self.card:UpdateSelected(false)
			end

			self.contextData.iconFrameId = var_20_0.uiStyle.id

			self:UpdateDesc(var_20_0)
			var_20_0:UpdateSelected(true)

			self.card = var_20_0

			if var_20_0:IsOwned() then
				setActive(self.confirmBtn, true)
				setActive(self.lockBtn, false)
			else
				setActive(self.confirmBtn, false)
				setActive(self.lockBtn, true)
			end
		end

		return
	end, SFX_PANEL)

	return
end

function AttireCombatUIPanel:OnReturnItem(arg_22_1, arg_22_2)
	if self.cards[arg_22_2] then
		self.cards[arg_22_2]:Dispose()
	end

	self.cards[arg_22_2] = nil

	return
end

function AttireCombatUIPanel:GetColumn()
	return 2
end

function AttireCombatUIPanel:OnUpdateItem(arg_24_1, arg_24_2)
	AttireCombatUIPanel.super.OnUpdateItem(self, arg_24_1, arg_24_2)

	if self.cards[arg_24_2].uiStyle.id == self.playerVO:getAttireByType(AttireConst.TYPE_COMBAT_UI_STYLE) then
		triggerButton(self.cards[arg_24_2]._go)
	end

	return
end

function AttireCombatUIPanel:GetDisplayVOs()
	local var_25_0 = {}
	local var_25_1 = 0

	for iter_25_0, iter_25_1 in pairs(self:GetData()) do
		table.insert(var_25_0, iter_25_1)

		if iter_25_1:getState() == AttireFrame.STATE_UNLOCK and iter_25_1.id >= 0 then
			var_25_1 = var_25_1 + 1
		end
	end

	return var_25_0, var_25_1
end

function AttireCombatUIPanel:UpdateDesc(arg_26_1)
	if arg_26_1:isEmpty() then
		return
	end

	onButton(self, self.confirmBtn, function()
		self:emit(AttireMediator.ON_APPLY, arg_26_1.uiStyle:getType(), arg_26_1.uiStyle.id)

		return
	end, SFX_PANEL)

	local var_26_0 = Ship.New({
		id = 100001,
		configId = 100001,
		skin_id = 100000
	})
	local var_26_1 = Ship.New({
		id = 100011,
		configId = 100011,
		skin_id = 100010
	})
	local var_26_2 = arg_26_1.uiStyle:getConfig("key")

	onButton(self, self.previewBtn, function()
		self.combatPreview = CombatPreviewLayer.New(pg.UIMgr.GetInstance().OverlayMain)

		self.combatPreview:ExecuteAction("Show", arg_26_1.uiStyle:getConfig("id"), function()
			self.combatPreview:Destroy()

			self.combatPreview = nil

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function AttireCombatUIPanel:onBackPressed()
	if self.combatPreview then
		self.combatPreview:Destroy()

		self.combatPreview = nil

		return true
	end

	return
end

function AttireCombatUIPanel:OnDestroy()
	self.loader:Clear()

	return
end

return AttireCombatUIPanel
