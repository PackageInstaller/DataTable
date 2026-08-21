local var_0_0 = class("AgoraDecorationView", import("Mod.Island.Core.View.IslandASynLoadSubView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandAgoraDecorationUI"
end

function var_0_0.OnInit(arg_2_0, arg_2_1)
	arg_2_0.scrollRect = arg_2_0._tf:Find("panel/main/scrollrect"):GetComponent("LScrollRect")
	arg_2_0.scrollRect4Theme = arg_2_0._tf:Find("panel/main/scrollrect_theme"):GetComponent("LScrollRect")
	arg_2_0.emptyTr = arg_2_0._tf:Find("panel/main/empty")
	arg_2_0.agoraSaveBtn = arg_2_0._tf:Find("panel/btns/save")
	arg_2_0.agoraSaveCdBtn = arg_2_0._tf:Find("panel/btns/save_cd")
	arg_2_0.agoraSaveCdTxt = arg_2_0._tf:Find("panel/btns/save_cd/Text"):GetComponent(typeof(Text))
	arg_2_0.agoraClearBtn = arg_2_0._tf:Find("panel/btns/clear")
	arg_2_0.agoraRevertBtn = arg_2_0._tf:Find("panel/btns/revert")
	arg_2_0.topPanel = arg_2_0._tf:Find("top")
	arg_2_0.agoraShopBtn = arg_2_0._tf:Find("top/shop")
	arg_2_0.backBtn = arg_2_0._tf:Find("top/back")
	arg_2_0.capacityBtn = arg_2_0._tf:Find("top/capacity")
	arg_2_0.capacityTxt = arg_2_0._tf:Find("top/capacity/Text"):GetComponent(typeof(Text))
	arg_2_0.themeBtn = arg_2_0._tf:Find("panel/main/bg/theme")
	arg_2_0.hideBtn = arg_2_0._tf:Find("panel/main/bg/hide")
	arg_2_0.showBtn = arg_2_0._tf:Find("panel/btns/show")
	arg_2_0.tagUIItemList = UIItemList.New(arg_2_0._tf:Find("panel/main/bg/tags"), arg_2_0._tf:Find("panel/main/bg/tags/1_1"))
	arg_2_0.searchInput = arg_2_0._tf:Find("panel/main/bg/search/search")
	arg_2_0.searchClearBtn = arg_2_0._tf:Find("panel/main/bg/search/search/clear")
	arg_2_0.sortBtn = arg_2_0._tf:Find("panel/main/bg/order")
	arg_2_0.orderBtn = arg_2_0._tf:Find("panel/main/bg/order/icon")
	arg_2_0.orderTxt = arg_2_0._tf:Find("panel/main/bg/order/Text_1"):GetComponent(typeof(Text))
	arg_2_0.sortPage = AgoraDecorationSortPage.New(arg_2_0._tf)
	arg_2_0.descPage = AgoraFurnitureDescPage.New(arg_2_0._tf)
	arg_2_0.shapeSelectPanel = AgoraDecorationShapePage.New(arg_2_0._tf:Find("shapeTpl"))

	setText(arg_2_0.agoraClearBtn:Find("Text"), i18n("island_agora_btn_label_clear"))
	setText(arg_2_0.agoraRevertBtn:Find("Text"), i18n("island_agora_btn_label_revert"))
	setText(arg_2_0.agoraSaveBtn:Find("Text"), i18n("island_agora_btn_label_save"))
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_agora_title"))
	setText(arg_2_0._tf:Find("panel/main/bg/search/search/holder"), i18n("island_agora_label_search"))
	setText(arg_2_0._tf:Find("panel/main/bg/theme/unsel/Text"), i18n("island_agora_label_theme"))
	setText(arg_2_0._tf:Find("panel/main/bg/theme/sel/Text"), i18n("island_agora_label_theme"))
	setText(arg_2_0.emptyTr:Find("empty_1/Text"), i18n("island_agora_label_empty_tip"))

	arg_2_0.anim = arg_2_0._tf:GetComponent(typeof(Animation))
	arg_2_0.dftAniEvent = arg_2_0.anim:GetComponent(typeof(DftAniEvent))
	arg_2_0.panelAnim = arg_2_0._tf:Find("panel"):GetComponent(typeof(Animation))
	arg_2_0.cards = {}
	arg_2_0.themeCards = {}
	arg_2_0.indexData = {
		tag = 1,
		sortKey = 1,
		searchKey = "",
		order = 1
	}

	arg_2_0:RegisterEvent()
	arg_2_0:UpdateOrderTxt()
	arg_2_0:InitTags()
	onButton(arg_2_0, arg_2_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_renovation.tip
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_4_0)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_27")

	return
end

function var_0_0.PlayExitAnim(arg_5_0, arg_5_1)
	if arg_5_0.isAniming then
		return
	end

	arg_5_0.isAniming = true

	arg_5_0.dftAniEvent:SetEndEvent(function()
		arg_5_0.isAniming = false

		var_0_0.super.Hide(arg_5_0)
		arg_5_1()

		return
	end)
	arg_5_0.anim:Play("anim_IslandAgoraDecorationUI_Out")

	return
end

function var_0_0.OnSelectedItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.selectedId = arg_7_1

	for iter_7_0, iter_7_1 in pairs(arg_7_0.cards) do
		iter_7_1:UpdateSelected(arg_7_0.selectedId)
	end

	if not arg_7_2 then
		arg_7_0:TriggerTag(arg_7_1)

		return
	end

	if arg_7_0.selectedId > 0 and not arg_7_0.isHideState then
		triggerButton(arg_7_0.hideBtn)
		arg_7_0:FoldBtnsAndTop()
	elseif arg_7_3 then
		local var_7_1 = _.detect(arg_7_0.displays, function(arg_8_0)
			return arg_8_0:Contains(arg_7_3)
		end)

		if var_7_1 and var_7_1:GetAvailableCnt() > 0 then
			return
		end

		if arg_7_1 < 0 then
			triggerButton(arg_7_0.showBtn)
		end
	elseif arg_7_1 < 0 then
		triggerButton(arg_7_0.showBtn)
	end

	return
end

function var_0_0.TriggerTag(arg_9_0, arg_9_1)
	if arg_9_1 <= 0 then
		return
	end

	local var_9_0 = arg_9_0:GetView().agora:GetPlaceableItem(arg_9_1)

	if not var_9_0 then
		return
	end

	local var_9_1 = table.indexof(AgoraFurnitureType.PLACEMENT_TYPE, var_9_0:GetType())

	if var_9_1 > 0 then
		triggerToggle(arg_9_0.toggles[var_9_1], true)
	end

	return
end

function var_0_0.OnCreateSameItem(arg_10_0, arg_10_1)
	local var_10_0 = _.detect(arg_10_0.displays, function(arg_11_0)
		return arg_11_0:Contains(arg_10_1)
	end)

	if var_10_0 and var_10_0:GetAvailableCnt() > 0 then
		arg_10_0:Op("PlaceItemRandonPosition", var_10_0:GetAvailableItem().id)
	end

	return
end

function var_0_0.RegisterEvent(arg_12_0)
	function arg_12_0.scrollRect.onInitItem(arg_13_0)
		arg_12_0:OnInitItem(arg_13_0)

		return
	end

	function arg_12_0.scrollRect.onUpdateItem(arg_14_0, arg_14_1)
		arg_12_0:OnUpdateItem(arg_14_0, arg_14_1)

		return
	end

	function arg_12_0.scrollRect4Theme.onInitItem(arg_15_0)
		arg_12_0:OnInitItem4Theme(arg_15_0)

		return
	end

	function arg_12_0.scrollRect4Theme.onUpdateItem(arg_16_0, arg_16_1)
		arg_12_0:OnUpdateItem4Theme(arg_16_0, arg_16_1)

		return
	end

	onButton(arg_12_0, arg_12_0.agoraSaveBtn, function()
		if arg_12_0:TrySave() then
			arg_12_0:Op("Save")
		end

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.agoraClearBtn, function()
		arg_12_0:ShowMsgbox({
			content = i18n("island_agora_clear_tip"),
			onYes = function()
				arg_12_0:Op("ClearAll")

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.agoraRevertBtn, function()
		arg_12_0:ShowMsgbox({
			content = i18n("island_agora_revert_tip"),
			onYes = function()
				arg_12_0:Op("Revert")

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.capacityBtn, function()
		local var_22_0 = arg_12_0:GetView()

		arg_12_0:ShowMsgbox({
			type = IslandMsgBox.TYPE_AGORA_PLACED_LIST,
			list = var_22_0.agora:GetPlacedInfoList(),
			totalCnt = var_22_0.agora:GetMaxCapacity()
		})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.agoraShopBtn, function()
		if arg_12_0:GetView():GetController():CheckChange() then
			arg_12_0:Save()
		else
			arg_12_0:PlayExitAnim(function()
				arg_12_0:Op("ExitEditMode")
				arg_12_0:NotifiyIsland(ISLAND_EX_EVT.OPEN_PAGE, IslandShopPage, {
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
	onButton(arg_12_0, arg_12_0.backBtn, function()
		if arg_12_0:GetView():GetController():CheckChange() then
			arg_12_0:Save()
		else
			arg_12_0:PlayExitAnim(function()
				arg_12_0:Op("ExitEditMode")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onInputChanged(arg_12_0, arg_12_0.searchInput, function()
		local var_27_0 = getInputText(arg_12_0.searchInput)

		setActive(arg_12_0.searchClearBtn, var_27_0 ~= "")
		arg_12_0:OnSearch(var_27_0)

		return
	end)
	onButton(arg_12_0, arg_12_0.searchClearBtn, function()
		setInputText(arg_12_0.searchInput, "")

		arg_12_0.indexData.searchKey = ""

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.sortBtn, function()
		arg_12_0.sortPage:ExecuteAction("Show", arg_12_0.indexData, function(arg_30_0)
			arg_12_0:OnSort(arg_30_0)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.orderBtn, function()
		arg_12_0:OnOrder(1 - arg_12_0.indexData.order)

		return
	end, SFX_PANEL)

	arg_12_0.isHideState = false
	arg_12_0.isHideBtnAndTop = false

	onButton(arg_12_0, arg_12_0.hideBtn, function()
		arg_12_0.isHideState = true

		arg_12_0.panelAnim:Play("fold")

		return
	end, SFX_PANEL)
	onButton(arg_12_0, arg_12_0.showBtn, function()
		arg_12_0.isHideState = false

		arg_12_0.panelAnim:Play("unfold")

		if arg_12_0.isHideBtnAndTop then
			arg_12_0:UnFoldBtnsAndTop()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.TrySave(arg_34_0)
	local var_34_0 = arg_34_0:GetView():GetController():CanEnterEditMode()

	if not var_34_0 then
		({
			type = IslandMsgBox.TYPE_AOGRA_SAVE_CD
		}).duetime = arg_34_0:GetView():GetController().editCdTime
		;({
			type = IslandMsgBox.TYPE_AOGRA_SAVE_CD
		}).onNo = function()
			arg_34_0:Op("RevertAndExit")

			return
		end

		arg_34_0:ShowMsgbox({
			type = IslandMsgBox.TYPE_AOGRA_SAVE_CD
		})
	end

	return var_34_0
end

function var_0_0.Save(arg_36_0)
	if arg_36_0:TrySave() then
		arg_36_0:ShowMsgbox({
			content = i18n("island_agora_save_or_exit_tip"),
			noText = i18n("island_agora_exit_and_unsave"),
			yesText = i18n("island_agora_exit_and_save"),
			onYes = function()
				arg_36_0:Op("SaveAndExit")

				return
			end,
			onNo = function()
				arg_36_0:Op("RevertAndExit")

				return
			end
		})
	end

	return
end

function var_0_0.FoldBtnsAndTop(arg_39_0)
	setActive(arg_39_0.agoraSaveBtn, false)
	setActive(arg_39_0.agoraClearBtn, false)
	setActive(arg_39_0.agoraRevertBtn, false)
	setActive(arg_39_0.topPanel, false)

	arg_39_0.isHideBtnAndTop = true

	return
end

function var_0_0.UnFoldBtnsAndTop(arg_40_0)
	setActive(arg_40_0.agoraSaveBtn, true)
	setActive(arg_40_0.agoraClearBtn, true)
	setActive(arg_40_0.agoraRevertBtn, true)
	setActive(arg_40_0.topPanel, true)

	arg_40_0.isHideBtnAndTop = false

	return
end

function var_0_0.InitTags(arg_41_0)
	arg_41_0.toggles = {}

	arg_41_0.tagUIItemList:make(function(arg_42_0, arg_42_1, arg_42_2)
		if arg_42_0 == UIItemList.EventUpdate then
			local var_42_0 = AgoraFurnitureType.PLACEMENT_TYPE[arg_42_1 + 1]

			onToggle(arg_41_0, arg_42_2, function(arg_43_0)
				if arg_43_0 then
					arg_41_0.selectedTagIndex = arg_42_1 + 1

					arg_41_0:Op("NotifiyAgora", ISLAND_AGORA_EVT.TAG_CHANGE, var_42_0)
					arg_41_0:OnFliter(var_42_0)
				end

				return
			end, SFX_PANEL)
			setText(arg_42_2:Find("sel/Text"), AgoraFurnitureType.Type2CN(AgoraFurnitureType.PLACEMENT_TYPE[arg_42_1 + 1]))
			table.insert(arg_41_0.toggles, arg_42_2)
		end

		return
	end)
	arg_41_0.tagUIItemList:align(#AgoraFurnitureType.PLACEMENT_TYPE)
	onToggle(arg_41_0, arg_41_0.themeBtn, function(arg_44_0)
		if arg_44_0 then
			arg_41_0.selectedTagIndex = nil

			arg_41_0:FlushThemeList()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnInitItem4Theme(arg_45_0, arg_45_1)
	local var_45_0 = AgoraDecorationThemeCard.New(arg_45_1)

	onButton(arg_45_0, var_45_0.mainTr, function()
		if isa(var_45_0.theme, AgoraSystemTheme) then
			local var_46_0 = IslandMsgBox.TYPE_SYSTEM_THEME or IslandMsgBox.TYPE_THEME

			arg_45_0:ShowMsgbox({
				type = var_46_0,
				theme = var_45_0.theme,
				onYes = function()
					arg_45_0:Op("ApplyTheme", var_45_0.theme.id, var_0)

					return
				end,
				onDel = function()
					arg_45_0:Op("DeleteTheme", var_45_0.theme.id)

					return
				end
			})

			return
		end
	end, SFX_PANEL)
	onButton(arg_45_0, var_45_0.addTr, function()
		if not arg_45_0:GetView().agora:GetUseableThemeId() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_pos_place"))

			return
		end

		seriesAsync({
			function(arg_50_0)
				arg_45_0:PrepareToTakeScreenshot()
				arg_45_0:ShootScreen(var_0, arg_50_0)

				return
			end,
			function()
				arg_45_0:RevertTakeScreenshot()
				arg_45_0:ShowMsgbox({
					type = IslandMsgBox.TYPE_SAVE_THEME,
					id = var_0,
					onYes = function(arg_52_0)
						arg_45_0:Op("SaveTheme", var_0, arg_52_0)

						return
					end
				})

				return
			end
		})

		return
	end, SFX_PANEL)

	arg_45_0.themeCards[arg_45_1] = var_45_0

	return
end

function var_0_0.PrepareToTakeScreenshot(arg_53_0)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.AGORA_CAMERA_SHOOTSCREEN_NAME)
	arg_53_0:GetView():ShowOrHideContainer(false)

	return
end

function var_0_0.ShootScreen(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = 426
	local var_54_1 = 320

	BLHX.Rendering.HotUpdate.ScreenShooterPass.TakePhoto(IslandCameraMgr.instance._mainCamera, function(arg_55_0)
		local var_55_0

		if arg_55_0.width < var_54_0 or arg_55_0.height < var_54_1 then
			var_55_0 = arg_55_0

			goto label_55_0

			var_55_0 = UnityEngine.Texture2D.New(var_54_0, var_54_1)
		end

		var_55_0:SetPixels((arg_55_0:GetPixels(arg_55_0.width * 0.5 - var_54_0 * 0.5, arg_55_0.height * 0.5 - var_54_1 * 0.5, var_54_0, var_54_1)))
		var_55_0:Apply()

		::label_55_0::

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

function var_0_0.RevertTakeScreenshot(arg_56_0)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.AGORA_CAMERA_NAME)
	arg_56_0:GetView():ShowOrHideContainer(true)

	return
end

function var_0_0.OnUpdateItem4Theme(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_0.themeCards[arg_57_2] then
		arg_57_0:OnInitItem4Theme(arg_57_2)
	end

	arg_57_0.themeCards[arg_57_2]:Update(arg_57_0.displayThemes[arg_57_1 + 1])

	return
end

function var_0_0.GetDisplayThemes(arg_58_0)
	local var_58_0 = arg_58_0:GetView()
	local var_58_1 = var_58_0.agora:GetThemes()

	for iter_58_0, iter_58_1 in ipairs(var_58_1) do
		table.insert({}, iter_58_1)
	end

	if var_58_0.agora:GetMaxCustomThemeCnt() > #var_58_1 then
		table.insert({}, 1, {
			id = -1
		})
	end

	return {}
end

function var_0_0.OnInitItem(arg_59_0, arg_59_1)
	local var_59_0 = AgoraDecorationCard.New(arg_59_1)
	local var_59_1 = false

	local function var_59_2()
		if var_59_1 then
			arg_59_0.descPage:ExecuteAction("Hide")

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
			arg_59_0:Op("ClearNew", var_61_0.id)
		end

		if var_59_0.valueObject:IsOptionalShapeType() then
			arg_59_0.shapeSelectPanel:Show(var_59_0, function(arg_62_0)
				arg_59_0:GetView():EnterPaveTileMode(var_61_0, arg_62_0)

				return
			end)
		elseif var_59_0.valueObject:IsBuilding() then
			if var_61_0 then
				arg_59_0:Op("ReplaceBuilding", var_61_0.id)
			end
		elseif var_59_0.valueObject:IsFoundation() then
			if var_61_0 then
				arg_59_0:Op("ReplaceFoundation", var_61_0.id)
			end
		else
			if var_59_0.valueObject:IsUsing() then
				arg_59_0:Op("TrySelectItemById", var_59_0.valueObject:GetFirstItem().id)

				return
			end

			if var_61_0 then
				arg_59_0:Op("PlaceItemRandonPosition", var_61_0.id)
			end
		end

		return
	end)
	var_59_0.longPressTriggerEvent:RemoveAllListeners()
	var_59_0.longPressTriggerEvent:AddListener(function()
		var_59_1 = true

		arg_59_0.descPage:ExecuteAction("Show", var_59_0.valueObject, var_59_0._go.transform.position)

		return
	end)
	var_59_0.onReleasedEvent:RemoveAllListeners()
	var_59_0.onReleasedEvent:AddListener(function()
		if var_59_1 then
			arg_59_0.descPage:ExecuteAction("Hide")

			var_59_1 = false
		end

		return
	end)

	arg_59_0.cards[arg_59_1] = var_59_0

	return
end

function var_0_0.OnUpdateItem(arg_64_0, arg_64_1, arg_64_2)
	if not arg_64_0.cards[arg_64_2] then
		arg_64_0:OnInitItem(arg_64_2)
	end

	arg_64_0.cards[arg_64_2]:Update(arg_64_0.displays[arg_64_1 + 1], arg_64_0.selectedId)

	return
end

function var_0_0.OnFliter(arg_65_0, arg_65_1)
	arg_65_0.indexData.tag = arg_65_1

	arg_65_0.shapeSelectPanel:Hide()
	arg_65_0:FlushList()

	return
end

function var_0_0.OnSort(arg_66_0, arg_66_1)
	arg_66_0.indexData.sortKey = arg_66_1

	arg_66_0:UpdateOrderTxt()
	arg_66_0:FlushList()

	return
end

function var_0_0.OnSearch(arg_67_0, arg_67_1)
	arg_67_0.indexData.searchKey = arg_67_1

	arg_67_0:FlushList()

	return
end

function var_0_0.OnOrder(arg_68_0, arg_68_1)
	arg_68_0.indexData.order = arg_68_1
	arg_68_0.orderBtn.localScale = Vector3(1, arg_68_1 == 1 and 1 or -1, 1)

	arg_68_0:FlushList()

	return
end

function var_0_0.UpdateOrderTxt(arg_69_0)
	arg_69_0.orderTxt.text = AgoraFurnitureType.Sort2CN(arg_69_0.indexData.sortKey)

	return
end

function var_0_0.GetDisplays(arg_70_0)
	local var_70_0 = arg_70_0:GetView()

	for iter_70_0, iter_70_1 in pairs((var_70_0.agora:GetPlaceableList())) do
		if not ({})[iter_70_1.configId] then
			({})[iter_70_1.configId] = AgoraDecorationVO.New(iter_70_1.configId, var_70_0)
		end

		;({})[iter_70_1.configId]:AddItem(iter_70_1)
	end

	local var_70_1 = {}

	for iter_70_2, iter_70_3 in pairs({}) do
		if iter_70_3:IsType(arg_70_0.indexData.tag) and iter_70_3:IsMatchSearch(arg_70_0.indexData.searchKey) then
			table.insert(var_70_1, iter_70_3)
		end
	end

	table.sort(var_70_1, CompareFuncs(var_70_2))

	return var_70_1
end

function var_0_0.Flush(arg_79_0)
	local var_79_0 = arg_79_0.selectedTagIndex or 1

	triggerToggle(arg_79_0.toggles[var_79_0], true)
	arg_79_0:FlushCapacity()
	arg_79_0:FlushSaveBtn()
	arg_79_0.anim:Play("anim_IslandAgoraDecorationUI_In")

	return
end

function var_0_0.FlushCard(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0.cards or {}

	for iter_80_0, iter_80_1 in pairs(var_80_0) do
		if iter_80_1.valueObject:Contains(arg_80_1) then
			iter_80_1:Update(iter_80_1.valueObject, arg_80_0.selectedId)

			break
		end
	end

	return
end

function var_0_0.FlushList(arg_81_0)
	if not isActive(arg_81_0.scrollRect) then
		return
	end

	arg_81_0.displays = arg_81_0:GetDisplays()

	arg_81_0.scrollRect:SetTotalCount(#arg_81_0.displays)
	setActive(arg_81_0.emptyTr, #arg_81_0.displays == 0)

	return
end

function var_0_0.FlushThemeList(arg_82_0)
	if not isActive(arg_82_0.scrollRect4Theme) then
		return
	end

	arg_82_0.displayThemes = arg_82_0:GetDisplayThemes()

	arg_82_0.scrollRect4Theme:SetTotalCount(#arg_82_0.displayThemes)
	setActive(arg_82_0.emptyTr, false)

	return
end

function var_0_0.FlushCapacity(arg_83_0)
	arg_83_0.capacityTxt.text = i18n("island_agora_capacity") .. ":<color=#a0ff9d>" .. arg_83_0:GetView().agora:GetCapacity() .. "</color>/" .. arg_83_0:GetView().agora:GetMaxCapacity()

	return
end

function var_0_0.FlushSaveBtn(arg_84_0)
	arg_84_0:AddSaveCdTimer(arg_84_0:GetView():GetController().editCdTime)

	return
end

function var_0_0.AddSaveCdTimer(arg_85_0, arg_85_1)
	arg_85_0:RemoveSaveCdTimer()

	if arg_85_1 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
		arg_85_0.agoraSaveCdTxt.text = ""

		setActive(arg_85_0.agoraSaveBtn, true)
		setActive(arg_85_0.agoraSaveCdBtn, false)

		return
	end

	setActive(arg_85_0.agoraSaveBtn, false)
	setActive(arg_85_0.agoraSaveCdBtn, true)

	arg_85_0.saveCdTimer = Timer.New(function()
		local var_86_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_85_1 - var_86_0 <= 0 then
			arg_85_0:RemoveSaveCdTimer()
			arg_85_0:FlushSaveBtn()
		else
			local var_86_1 = arg_85_0.agoraSaveCdTxt

			var_86_1.text = pg.TimeMgr.GetInstance():DescCDTimeForMinute(arg_85_1 - var_86_0)
		end

		return
	end, 1, -1)

	arg_85_0.saveCdTimer:Start()
	arg_85_0.saveCdTimer.func()

	return
end

function var_0_0.RemoveSaveCdTimer(arg_87_0)
	if arg_87_0.saveCdTimer then
		arg_87_0.saveCdTimer:Stop()

		arg_87_0.saveCdTimer = nil
	end

	return
end

function var_0_0.OnDestroy(arg_88_0)
	ClearLScrollrect(arg_88_0.scrollRect)
	ClearLScrollrect(arg_88_0.scrollRect4Theme)

	if arg_88_0.dftAniEvent then
		arg_88_0.dftAniEvent:SetEndEvent(nil)
	end

	arg_88_0:RemoveSaveCdTimer()

	if arg_88_0.sortPage then
		arg_88_0.sortPage:Destroy()

		arg_88_0.sortPage = nil
	end

	if arg_88_0.descPage then
		arg_88_0.descPage:Destroy()

		arg_88_0.descPage = nil
	end

	if arg_88_0.shapeSelectPanel then
		arg_88_0.shapeSelectPanel:Destroy()

		arg_88_0.shapeSelectPanel = nil
	end

	local var_88_1 = arg_88_0.cards or {}

	for iter_88_0, iter_88_1 in var_88_0(var_88_1) do
		iter_88_1:Dispose()
	end

	arg_88_0.cards = nil

	local var_88_2 = arg_88_0.themeCards or {}

	for iter_88_2, iter_88_3 in pairs(var_88_2) do
		iter_88_3:Dispose()
	end

	arg_88_0.themeCards = nil

	return
end

return var_0_0
