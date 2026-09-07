local AgoraDecorationView = class("AgoraDecorationView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function AgoraDecorationView:GetUIName()
	return "IslandAgoraDecorationUI"
end

function AgoraDecorationView:OnInit(arg_2_1)
	self.scrollRect = self._tf:Find("panel/main/scrollrect"):GetComponent("LScrollRect")
	self.scrollRect4Theme = self._tf:Find("panel/main/scrollrect_theme"):GetComponent("LScrollRect")
	self.emptyTr = self._tf:Find("panel/main/empty")
	self.agoraSaveBtn = self._tf:Find("panel/btns/save")
	self.agoraSaveCdBtn = self._tf:Find("panel/btns/save_cd")
	self.agoraSaveCdTxt = self._tf:Find("panel/btns/save_cd/Text"):GetComponent(typeof(Text))
	self.agoraClearBtn = self._tf:Find("panel/btns/clear")
	self.agoraRevertBtn = self._tf:Find("panel/btns/revert")
	self.topPanel = self._tf:Find("top")
	self.agoraShopBtn = self._tf:Find("top/shop")
	self.backBtn = self._tf:Find("top/back")
	self.capacityBtn = self._tf:Find("top/capacity")
	self.capacityTxt = self._tf:Find("top/capacity/Text"):GetComponent(typeof(Text))
	self.themeBtn = self._tf:Find("panel/main/bg/theme")
	self.hideBtn = self._tf:Find("panel/main/bg/hide")
	self.showBtn = self._tf:Find("panel/btns/show")
	self.tagUIItemList = UIItemList.New(self._tf:Find("panel/main/bg/tags"), self._tf:Find("panel/main/bg/tags/1_1"))
	self.searchInput = self._tf:Find("panel/main/bg/search/search")
	self.searchClearBtn = self._tf:Find("panel/main/bg/search/search/clear")
	self.sortBtn = self._tf:Find("panel/main/bg/order")
	self.orderBtn = self._tf:Find("panel/main/bg/order/icon")
	self.orderTxt = self._tf:Find("panel/main/bg/order/Text_1"):GetComponent(typeof(Text))
	self.sortPage = AgoraDecorationSortPage.New(self._tf)
	self.descPage = AgoraFurnitureDescPage.New(self._tf)
	self.shapeSelectPanel = AgoraDecorationShapePage.New(self._tf:Find("shapeTpl"))

	setText(self.agoraClearBtn:Find("Text"), i18n("island_agora_btn_label_clear"))
	setText(self.agoraRevertBtn:Find("Text"), i18n("island_agora_btn_label_revert"))
	setText(self.agoraSaveBtn:Find("Text"), i18n("island_agora_btn_label_save"))
	setText(self._tf:Find("top/title/Text"), i18n("island_agora_title"))
	setText(self._tf:Find("panel/main/bg/search/search/holder"), i18n("island_agora_label_search"))
	setText(self._tf:Find("panel/main/bg/theme/unsel/Text"), i18n("island_agora_label_theme"))
	setText(self._tf:Find("panel/main/bg/theme/sel/Text"), i18n("island_agora_label_theme"))
	setText(self.emptyTr:Find("empty_1/Text"), i18n("island_agora_label_empty_tip"))

	self.anim = self._tf:GetComponent(typeof(Animation))
	self.dftAniEvent = self.anim:GetComponent(typeof(DftAniEvent))
	self.panelAnim = self._tf:Find("panel"):GetComponent(typeof(Animation))
	self.cards = {}
	self.themeCards = {}
	self.indexData = {
		tag = 1,
		sortKey = 1,
		searchKey = "",
		order = 1
	}

	self:RegisterEvent()
	self:UpdateOrderTxt()
	self:InitTags()
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_renovation.tip
		})

		return
	end, SFX_PANEL)

	return
end

function AgoraDecorationView:OnShow()
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_27")

	return
end

function AgoraDecorationView:PlayExitAnim(arg_5_1)
	if self.isAniming then
		return
	end

	self.isAniming = true

	self.dftAniEvent:SetEndEvent(function()
		self.isAniming = false

		AgoraDecorationView.super.Hide(self)
		arg_5_1()

		return
	end)
	self.anim:Play("anim_IslandAgoraDecorationUI_Out")

	return
end

function AgoraDecorationView:OnSelectedItem(arg_7_1, arg_7_2, arg_7_3)
	self.selectedId = arg_7_1

	for iter_7_0, iter_7_1 in pairs(self.cards) do
		iter_7_1:UpdateSelected(self.selectedId)
	end

	if not arg_7_2 then
		self:TriggerTag(arg_7_1)

		return
	end

	if self.selectedId > 0 and not self.isHideState then
		triggerButton(self.hideBtn)
		self:FoldBtnsAndTop()
	elseif arg_7_3 then
		local var_7_1 = _.detect(self.displays, function(arg_8_0)
			return arg_8_0:Contains(arg_7_3)
		end)

		if var_7_1 and var_7_1:GetAvailableCnt() > 0 then
			return
		end

		if arg_7_1 < 0 then
			triggerButton(self.showBtn)
		end
	elseif arg_7_1 < 0 then
		triggerButton(self.showBtn)
	end

	return
end

function AgoraDecorationView:TriggerTag(arg_9_1)
	if arg_9_1 <= 0 then
		return
	end

	local var_9_0 = self:GetView().agora:GetPlaceableItem(arg_9_1)

	if not var_9_0 then
		return
	end

	local var_9_1 = table.indexof(AgoraFurnitureType.PLACEMENT_TYPE, var_9_0:GetType())

	if var_9_1 > 0 then
		triggerToggle(self.toggles[var_9_1], true)
	end

	return
end

function AgoraDecorationView:OnCreateSameItem(arg_10_1)
	local var_10_0 = _.detect(self.displays, function(arg_11_0)
		return arg_11_0:Contains(arg_10_1)
	end)

	if var_10_0 and var_10_0:GetAvailableCnt() > 0 then
		self:Op("PlaceItemRandonPosition", var_10_0:GetAvailableItem().id)
	end

	return
end

function AgoraDecorationView:RegisterEvent()
	function self.scrollRect.onInitItem(arg_13_0)
		self:OnInitItem(arg_13_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		self:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	function self.scrollRect4Theme.onInitItem(arg_15_0)
		self:OnInitItem4Theme(arg_15_0)

		return
	end

	function self.scrollRect4Theme.onUpdateItem(arg_16_0, arg_16_1)
		self:OnUpdateItem4Theme(arg_16_0, arg_16_1)

		return
	end

	onButton(self, self.agoraSaveBtn, function()
		if self:TrySave() then
			self:Op("Save")
		end

		return
	end, SFX_PANEL)
	onButton(self, self.agoraClearBtn, function()
		self:ShowMsgbox({
			content = i18n("island_agora_clear_tip"),
			onYes = function()
				self:Op("ClearAll")

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.agoraRevertBtn, function()
		self:ShowMsgbox({
			content = i18n("island_agora_revert_tip"),
			onYes = function()
				self:Op("Revert")

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.capacityBtn, function()
		local var_22_0 = self:GetView()

		self:ShowMsgbox({
			type = IslandMsgBox.TYPE_AGORA_PLACED_LIST,
			list = var_22_0.agora:GetPlacedInfoList(),
			totalCnt = var_22_0.agora:GetMaxCapacity()
		})

		return
	end, SFX_PANEL)
	onButton(self, self.agoraShopBtn, function()
		if self:GetView():GetController():CheckChange() then
			self:Save()
		else
			self:PlayExitAnim(function()
				self:Op("ExitEditMode")
				self:NotifiyIsland(ISLAND_EX_EVT.OPEN_PAGE, IslandShopPage, {
					1,
					2,
					3,
					4,
					5
				}, {
					10111,
					40111,
					50111,
					10122
				})

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		if self:GetView():GetController():CheckChange() then
			self:Save()
		else
			self:PlayExitAnim(function()
				self:Op("ExitEditMode")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onInputChanged(self, self.searchInput, function()
		local var_27_0 = getInputText(self.searchInput)

		setActive(self.searchClearBtn, var_27_0 ~= "")
		self:OnSearch(var_27_0)

		return
	end)
	onButton(self, self.searchClearBtn, function()
		setInputText(self.searchInput, "")

		self.indexData.searchKey = ""

		return
	end, SFX_PANEL)
	onButton(self, self.sortBtn, function()
		self.sortPage:ExecuteAction("Show", self.indexData, function(arg_30_0)
			self:OnSort(arg_30_0)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(self, self.orderBtn, function()
		self:OnOrder(1 - self.indexData.order)

		return
	end, SFX_PANEL)

	self.isHideState = false
	self.isHideBtnAndTop = false

	onButton(self, self.hideBtn, function()
		self.isHideState = true

		self.panelAnim:Play("fold")

		return
	end, SFX_PANEL)
	onButton(self, self.showBtn, function()
		self.isHideState = false

		self.panelAnim:Play("unfold")

		if self.isHideBtnAndTop then
			self:UnFoldBtnsAndTop()
		end

		return
	end, SFX_PANEL)

	return
end

function AgoraDecorationView:TrySave()
	local var_34_0 = self:GetView():GetController():CanEnterEditMode()

	if not var_34_0 then
		local var_34_1 = {
			type = IslandMsgBox.TYPE_AOGRA_SAVE_CD
		}

		var_34_1.duetime = self:GetView():GetController().editCdTime

		function var_34_1.onNo()
			self:Op("RevertAndExit")

			return
		end

		self:ShowMsgbox(var_34_1)
	end

	return var_34_0
end

function AgoraDecorationView:Save()
	if self:TrySave() then
		self:ShowMsgbox({
			content = i18n("island_agora_save_or_exit_tip"),
			noText = i18n("island_agora_exit_and_unsave"),
			yesText = i18n("island_agora_exit_and_save"),
			onYes = function()
				self:Op("SaveAndExit")

				return
			end,
			onNo = function()
				self:Op("RevertAndExit")

				return
			end
		})
	end

	return
end

function AgoraDecorationView:FoldBtnsAndTop()
	setActive(self.agoraSaveBtn, false)
	setActive(self.agoraClearBtn, false)
	setActive(self.agoraRevertBtn, false)
	setActive(self.topPanel, false)

	self.isHideBtnAndTop = true

	return
end

function AgoraDecorationView:UnFoldBtnsAndTop()
	setActive(self.agoraSaveBtn, true)
	setActive(self.agoraClearBtn, true)
	setActive(self.agoraRevertBtn, true)
	setActive(self.topPanel, true)

	self.isHideBtnAndTop = false

	return
end

function AgoraDecorationView:InitTags()
	self.toggles = {}

	self.tagUIItemList:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = AgoraFurnitureType.PLACEMENT_TYPE[arg_42_1 + 1]

			onToggle(self, arg_42_2, function(arg_43_0)
				if arg_43_0 then
					self.selectedTagIndex = arg_42_1 + 1

					self:Op("NotifiyAgora", ISLAND_AGORA_EVT.TAG_CHANGE, var_42_0)
					self:OnFliter(var_42_0)
				end

				return
			end, SFX_PANEL)
			setText(arg_42_2:Find("sel/Text"), AgoraFurnitureType.Type2CN(AgoraFurnitureType.PLACEMENT_TYPE[arg_42_1 + 1]))
			table.insert(self.toggles, arg_42_2)
		end

		return
	end)
	self.tagUIItemList:align(#AgoraFurnitureType.PLACEMENT_TYPE)
	onToggle(self, self.themeBtn, function(arg_44_0)
		if arg_44_0 then
			self.selectedTagIndex = nil

			self:FlushThemeList()
		end

		return
	end, SFX_PANEL)

	return
end

function AgoraDecorationView:OnInitItem4Theme(arg_45_1)
	local var_45_0 = AgoraDecorationThemeCard.New(arg_45_1)

	onButton(self, var_45_0.mainTr, function()
		local var_46_0 = isa(var_45_0.theme, AgoraSystemTheme)

		self:ShowMsgbox({
			type = (var_46_0 or nil) and (IslandMsgBox.TYPE_SYSTEM_THEME or IslandMsgBox.TYPE_THEME),
			theme = var_45_0.theme,
			onYes = function()
				self:Op("ApplyTheme", var_45_0.theme.id, var_46_0)

				return
			end,
			onDel = function()
				self:Op("DeleteTheme", var_45_0.theme.id)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, var_45_0.addTr, function()
		local var_49_0 = self:GetView().agora:GetUseableThemeId()

		if not var_49_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_pos_place"))

			return
		end

		seriesAsync({
			function(arg_50_0)
				self:PrepareToTakeScreenshot()
				self:ShootScreen(var_49_0, arg_50_0)

				return
			end,
			function()
				self:RevertTakeScreenshot()
				self:ShowMsgbox({
					type = IslandMsgBox.TYPE_SAVE_THEME,
					id = var_49_0,
					onYes = function(arg_52_0)
						self:Op("SaveTheme", var_49_0, arg_52_0)

						return
					end
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	self.themeCards[arg_45_1] = var_45_0

	return
end

function AgoraDecorationView:PrepareToTakeScreenshot()
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.AGORA_CAMERA_SHOOTSCREEN_NAME)
	self:GetView():ShowOrHideContainer(false)

	return
end

function AgoraDecorationView:ShootScreen(arg_54_1, arg_54_2)
	local var_54_0 = 426
	local var_54_1 = 320

	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(IslandCameraMgr.instance._mainCamera, function(arg_55_0)
		local var_55_0

		if arg_55_0.width < var_54_0 or arg_55_0.height < var_54_1 then
			var_55_0 = arg_55_0
		else
			var_55_0 = UnityEngine.Texture2D.New(var_54_0, var_54_1)

			var_55_0:SetPixels((arg_55_0:GetPixels(arg_55_0.width * 0.5 - var_54_0 * 0.5, arg_55_0.height * 0.5 - var_54_1 * 0.5, var_54_0, var_54_1)))
			var_55_0:Apply()
		end

		local var_55_1 = Tex2DExtension.EncodeToJPG(var_55_0)
		local var_55_2 = AgoraCalc.BuildScreenShootSavePath(arg_54_1)

		if PathMgr.FileExists(var_55_2) then
			System.IO.File.Delete(var_55_2)
		end

		System.IO.File.WriteAllBytes(var_55_2, var_55_1)
		arg_54_2()

		return
	end)

	return
end

function AgoraDecorationView:RevertTakeScreenshot()
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.AGORA_CAMERA_NAME)
	self:GetView():ShowOrHideContainer(true)

	return
end

function AgoraDecorationView:OnUpdateItem4Theme(arg_57_1, arg_57_2)
	if not self.themeCards[arg_57_2] then
		self:OnInitItem4Theme(arg_57_2)
	end

	self.themeCards[arg_57_2]:Update(self.displayThemes[arg_57_1 + 1])

	return
end

function AgoraDecorationView:GetDisplayThemes()
	local var_58_0 = self:GetView()
	local var_58_1 = var_58_0.agora:GetThemes()
	local var_58_2 = {}

	for iter_58_0, iter_58_1 in ipairs(var_58_1) do
		table.insert(var_58_2, iter_58_1)
	end

	if var_58_0.agora:GetMaxCustomThemeCnt() > #var_58_1 then
		table.insert(var_58_2, 1, {
			id = -1
		})
	end

	return var_58_2
end

function AgoraDecorationView:OnInitItem(arg_59_1)
	local var_59_0 = AgoraDecorationCard.New(arg_59_1)
	local var_59_1 = false

	local function var_59_2()
		if var_59_1 then
			self.descPage:ExecuteAction("Hide")

			var_59_1 = false
		end

		return
	end

	var_59_0.onClickEvent:RemoveAllListeners()
	var_59_0.onClickEvent:AddListener(function()
		if var_59_1 then
			var_59_2()

			return
		end

		local var_61_0 = var_59_0.valueObject:GetAvailableItem()

		if var_61_0 then
			self:Op("ClearNew", var_61_0.id)
		end

		if var_59_0.valueObject:IsOptionalShapeType() then
			self.shapeSelectPanel:Show(var_59_0, function(arg_62_0)
				self:GetView():EnterPaveTileMode(var_61_0, arg_62_0)

				return
			end)
		elseif var_59_0.valueObject:IsBuilding() then
			if var_61_0 then
				self:Op("ReplaceBuilding", var_61_0.id)
			end
		elseif var_59_0.valueObject:IsFoundation() then
			if var_61_0 then
				self:Op("ReplaceFoundation", var_61_0.id)
			end
		else
			if var_59_0.valueObject:IsUsing() then
				self:Op("TrySelectItemById", var_59_0.valueObject:GetFirstItem().id)

				return
			end

			if var_61_0 then
				self:Op("PlaceItemRandonPosition", var_61_0.id)
			end
		end

		return
	end)
	var_59_0.longPressTriggerEvent:RemoveAllListeners()
	var_59_0.longPressTriggerEvent:AddListener(function()
		var_59_1 = true

		self.descPage:ExecuteAction("Show", var_59_0.valueObject, var_59_0._go.transform.position)

		return
	end)
	var_59_0.onReleasedEvent:RemoveAllListeners()
	var_59_0.onReleasedEvent:AddListener(var_59_2)

	self.cards[arg_59_1] = var_59_0

	return
end

function AgoraDecorationView:OnUpdateItem(arg_64_1, arg_64_2)
	if not self.cards[arg_64_2] then
		self:OnInitItem(arg_64_2)
	end

	self.cards[arg_64_2]:Update(self.displays[arg_64_1 + 1], self.selectedId)

	return
end

function AgoraDecorationView:OnFliter(arg_65_1)
	self.indexData.tag = arg_65_1

	self.shapeSelectPanel:Hide()
	self:FlushList()

	return
end

function AgoraDecorationView:OnSort(arg_66_1)
	self.indexData.sortKey = arg_66_1

	self:UpdateOrderTxt()
	self:FlushList()

	return
end

function AgoraDecorationView:OnSearch(arg_67_1)
	self.indexData.searchKey = arg_67_1

	self:FlushList()

	return
end

function AgoraDecorationView:OnOrder(arg_68_1)
	self.indexData.order = arg_68_1
	self.orderBtn.localScale = Vector3(1, arg_68_1 == 1 and 1 or -1, 1)

	self:FlushList()

	return
end

function AgoraDecorationView:UpdateOrderTxt()
	self.orderTxt.text = AgoraFurnitureType.Sort2CN(self.indexData.sortKey)

	return
end

function AgoraDecorationView:GetDisplays()
	local var_70_0 = self:GetView()
	local var_70_1 = {}

	for iter_70_0, iter_70_1 in pairs((var_70_0.agora:GetPlaceableList())) do
		var_70_1[iter_70_1.configId] = var_70_1[iter_70_1.configId] or AgoraDecorationVO.New(iter_70_1.configId, var_70_0)

		var_70_1[iter_70_1.configId]:AddItem(iter_70_1)
	end

	local var_70_2 = {}

	for iter_70_2, iter_70_3 in pairs(var_70_1) do
		if iter_70_3:IsType(self.indexData.tag) and iter_70_3:IsMatchSearch(self.indexData.searchKey) then
			table.insert(var_70_2, iter_70_3)
		end
	end

	table.sort(var_70_2, CompareFuncs(self.indexData.sortKey == AgoraFurnitureType.SORT_DEFAULT and {
		function(arg_71_0)
			return arg_71_0:IsUsing() and 0 or 1
		end,
		function(arg_72_0)
			return arg_72_0:IsNew() and 0 or 1
		end,
		function(arg_73_0)
			return -1 * arg_73_0:GetRarity()
		end,
		function(arg_74_0)
			return -1 * arg_74_0.id
		end
	} or {
		function(arg_75_0)
			return arg_75_0:IsUsing() and 0 or 1
		end,
		function(arg_76_0)
			return arg_76_0:IsNew() and 0 or 1
		end,
		function(arg_77_0)
			return -1 * arg_77_0:GetSortValue(self.indexData.sortKey, self.indexData.order)
		end,
		function(arg_78_0)
			return -1 * arg_78_0.id
		end
	}))

	return var_70_2
end

function AgoraDecorationView:Flush()
	triggerToggle(self.toggles[self.selectedTagIndex or 1], true)
	self:FlushCapacity()
	self:FlushSaveBtn()
	self.anim:Play("anim_IslandAgoraDecorationUI_In")

	return
end

function AgoraDecorationView:FlushCard(arg_80_1)
	for iter_80_0, iter_80_1 in pairs(self.cards or {}) do
		if iter_80_1.valueObject:Contains(arg_80_1) then
			iter_80_1:Update(iter_80_1.valueObject, self.selectedId)

			break
		end
	end

	return
end

function AgoraDecorationView:FlushList()
	if not isActive(self.scrollRect) then
		return
	end

	self.displays = self:GetDisplays()

	self.scrollRect:SetTotalCount(#self.displays)
	setActive(self.emptyTr, #self.displays == 0)

	return
end

function AgoraDecorationView:FlushThemeList()
	if not isActive(self.scrollRect4Theme) then
		return
	end

	self.displayThemes = self:GetDisplayThemes()

	self.scrollRect4Theme:SetTotalCount(#self.displayThemes)
	setActive(self.emptyTr, false)

	return
end

function AgoraDecorationView:FlushCapacity()
	self.capacityTxt.text = i18n("island_agora_capacity") .. ":<color=#a0ff9d>" .. self:GetView().agora:GetCapacity() .. "</color>/" .. self:GetView().agora:GetMaxCapacity()

	return
end

function AgoraDecorationView:FlushSaveBtn()
	self:AddSaveCdTimer(self:GetView():GetController().editCdTime)

	return
end

function AgoraDecorationView:AddSaveCdTimer(arg_85_1)
	self:RemoveSaveCdTimer()

	if arg_85_1 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
		self.agoraSaveCdTxt.text = ""

		setActive(self.agoraSaveBtn, true)
		setActive(self.agoraSaveCdBtn, false)

		return
	end

	setActive(self.agoraSaveBtn, false)
	setActive(self.agoraSaveCdBtn, true)

	self.saveCdTimer = Timer.New(function()
		local var_86_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_85_1 - var_86_0 <= 0 then
			self:RemoveSaveCdTimer()
			self:FlushSaveBtn()
		else
			self.agoraSaveCdTxt.text = pg.TimeMgr.GetInstance():DescCDTimeForMinute(arg_85_1 - var_86_0)
		end

		return
	end, 1, -1)

	self.saveCdTimer:Start()
	self.saveCdTimer.func()

	return
end

function AgoraDecorationView:RemoveSaveCdTimer()
	if self.saveCdTimer then
		self.saveCdTimer:Stop()

		self.saveCdTimer = nil
	end

	return
end

function AgoraDecorationView:OnDestroy()
	ClearLScrollrect(self.scrollRect)
	ClearLScrollrect(self.scrollRect4Theme)

	if self.dftAniEvent then
		self.dftAniEvent:SetEndEvent(nil)
	end

	self:RemoveSaveCdTimer()

	if self.sortPage then
		self.sortPage:Destroy()

		self.sortPage = nil
	end

	if self.descPage then
		self.descPage:Destroy()

		self.descPage = nil
	end

	if self.shapeSelectPanel then
		self.shapeSelectPanel:Destroy()

		self.shapeSelectPanel = nil
	end

	for iter_88_0, iter_88_1 in pairs(self.cards or {}) do
		iter_88_1:Dispose()
	end

	self.cards = nil

	for iter_88_2, iter_88_3 in pairs(self.themeCards or {}) do
		iter_88_3:Dispose()
	end

	self.themeCards = nil

	return
end

return AgoraDecorationView
