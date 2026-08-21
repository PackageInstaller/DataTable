local var_0_0 = class("IslandShipMainPage", import(".IslandBaseShipDisplayPage"))

var_0_0.OPEN_PAGE = "IslandShipMainPage:OPEN_PAGE"
var_0_0.SELECT_SHIP = "IslandShipMainPage:SELECT_SHIP"
var_0_0.CLOSE_DOCK = "IslandShipMainPage:CLOSE_DOCK"
var_0_0.CLEAR_ITEM_ANIMATOR = "IslandShipMainPage:CLEAR_ITEM_ANIMATOR"
var_0_0.PAGE_DRESS = 1
var_0_0.PAGE_INFO = 2
var_0_0.PAGE_STATUS = 3
var_0_0.PAGE_PROFILE = 4

function var_0_0.getUIName(arg_1_0)
	return "IslandShipMainUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("top/back")
	arg_2_0.homeBtn = arg_2_0._tf:Find("top/home")
	arg_2_0.leftPanel = arg_2_0._tf:Find("adapt/left_panel")
	arg_2_0.dockBtn = arg_2_0._tf:Find("adapt/left_panel/dock_btn")
	arg_2_0.togglePanel = arg_2_0._tf:Find("top/toggles")
	arg_2_0.shipRect = arg_2_0._tf:Find("adapt/left_panel/ships"):GetComponent("LScrollRect")
	arg_2_0.shipContainer = arg_2_0._tf:Find("adapt/left_panel/ships/content")

	function arg_2_0.shipRect.onInitItem(arg_3_0)
		arg_2_0:OnInitItem(arg_3_0)

		return
	end

	function arg_2_0.shipRect.onUpdateItem(arg_4_0, arg_4_1)
		arg_2_0:OnUpdateItem(arg_4_0, arg_4_1)

		return
	end

	arg_2_0.toggles = {
		[var_0_0.PAGE_INFO] = arg_2_0._tf:Find("top/toggles/info"),
		[var_0_0.PAGE_DRESS] = arg_2_0._tf:Find("top/toggles/dress"),
		[var_0_0.PAGE_STATUS] = arg_2_0._tf:Find("top/toggles/gift"),
		[var_0_0.PAGE_PROFILE] = arg_2_0._tf:Find("topapt/toggles/data")
	}
	arg_2_0.pages = {
		[var_0_0.PAGE_INFO] = IslandShipInfoPage,
		[var_0_0.PAGE_DRESS] = IslandShipDressUpPageNew,
		[var_0_0.PAGE_STATUS] = IslandShipStatusPage,
		[var_0_0.PAGE_PROFILE] = IslandShipProfilePage
	}
	arg_2_0.cards = {}

	setActive(arg_2_0.togglePanel, true)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_chara_totalname"))
	setText(arg_2_0._tf:Find("top/title/Text/en"), i18n("island_chara_totalname_en"))

	return
end

function var_0_0.GetSmoothRotateObject(arg_5_0)
	return arg_5_0._tf:Find("adapt/char")
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddListener(var_0_0.CLOSE_DOCK, arg_6_0.OnCloseDock)
	arg_6_0:AddListener(var_0_0.OPEN_PAGE, arg_6_0.OnTriggerPage)
	arg_6_0:AddListener(IslandShipMainPage.SELECT_SHIP, arg_6_0.OnSelectShip)
	arg_6_0:AddListener(IslandCharacterAgency.ADD_SHIP, arg_6_0.OnAddShip)
	arg_6_0:AddListener(GAME.ISLAND_UPGRADE_SKILL_DONE, arg_6_0.OnSkillUpgrade)
	arg_6_0:AddListener(var_0_0.CLEAR_ITEM_ANIMATOR, arg_6_0.OnClearItemAnimator)

	return
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(var_0_0.CLOSE_DOCK, arg_7_0.OnCloseDock)
	arg_7_0:RemoveListener(var_0_0.OPEN_PAGE, arg_7_0.OnTriggerPage)
	arg_7_0:RemoveListener(IslandShipMainPage.SELECT_SHIP, arg_7_0.OnSelectShip)
	arg_7_0:RemoveListener(IslandCharacterAgency.ADD_SHIP, arg_7_0.OnAddShip)
	arg_7_0:RemoveListener(GAME.ISLAND_UPGRADE_SKILL_DONE, arg_7_0.OnSkillUpgrade)
	arg_7_0:RemoveListener(var_0_0.CLEAR_ITEM_ANIMATOR, arg_7_0.OnClearItemAnimator)

	return
end

function var_0_0.OnCloseDock(arg_8_0)
	arg_8_0:SetVisible(arg_8_0.leftPanel, true)

	return
end

function var_0_0.OnSkillUpgrade(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.cards) do
		iter_9_1:FlushRedDot()
	end

	return
end

function var_0_0.OnGotExtra(arg_10_0)
	if not arg_10_0.contextData.selectedId then
		return
	end

	local var_10_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency()

	arg_10_0:FlushExtraAward((var_10_0:GetShipById(arg_10_0.contextData.selectedId)))

	return
end

function var_0_0.OnAddShip(arg_11_0)
	arg_11_0:Flush()

	if not arg_11_0.contextData.selectedId then
		-- block empty
	end

	return
end

function var_0_0.OnSelectShip(arg_12_0, arg_12_1)
	arg_12_0:ClickCard(getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_12_1), arg_12_1)

	return
end

function var_0_0.OnTriggerPage(arg_13_0, arg_13_1)
	arg_13_0:TriggerPage(arg_13_1)

	return
end

function var_0_0.OnInit(arg_14_0)
	onButton(arg_14_0, arg_14_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_character_info.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.homeBtn, function()
		arg_14_0:OnHome()

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.backBtn, function()
		if arg_14_0.childPage then
			arg_14_0.childPage:CheckInReturn(function()
				arg_14_0:Hide()

				arg_14_0.childPage = nil

				return
			end)
		else
			arg_14_0:Hide()
		end

		return
	end, SFX_PANEL)
	onButton(arg_14_0, arg_14_0.dockBtn, function()
		arg_14_0:OpenPage(IslandDockPage, arg_14_0:GetNeedHideUnlockShipFlag())
		arg_14_0:SetVisible(arg_14_0.leftPanel, false)

		return
	end, SFX_PANEL)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.toggles) do
		onToggle(arg_14_0, iter_14_1, function(arg_20_0)
			if arg_20_0 then
				if arg_14_0.childPage then
					arg_14_0.childPage:CheckInReturn(function()
						arg_14_0:SwitchPage(iter_14_0)

						return
					end)
				else
					arg_14_0:SwitchPage(iter_14_0)
				end
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.SwitchPage(arg_22_0, arg_22_1)
	if not arg_22_0.contextData.selectedId then
		return
	end

	if arg_22_0.page then
		arg_22_0:ClosePage(arg_22_0.page)

		arg_22_0.page = nil
	end

	local var_22_0 = arg_22_0.pages[arg_22_1]

	if arg_22_1 == 1 then
		arg_22_0.childPage = arg_22_0:OpenPage(var_22_0, arg_22_0.contextData.selectedId, false, arg_22_0.shipDressHelper, function(arg_23_0)
			arg_22_0:SetObjInitRotaion(arg_23_0)

			return
		end)
	else
		arg_22_0:OpenPage(var_22_0, arg_22_0.contextData.selectedId)

		arg_22_0.childPage = nil
	end

	arg_22_0.page = var_22_0

	return
end

function var_0_0.TriggerPage(arg_24_0, arg_24_1)
	triggerToggle(arg_24_0.toggles[arg_24_1], true)

	return
end

function var_0_0.Show(arg_25_0)
	var_0_0.super.Show(arg_25_0)
	arg_25_0:Flush()
	setActive(arg_25_0.togglePanel, true)

	return
end

function var_0_0.Flush(arg_26_0)
	arg_26_0:FlushShips((getProxy(IslandProxy):GetIsland():GetCharacterAgency()))
	arg_26_0:ActiveDefaultCard()

	return
end

function var_0_0.ActiveDefaultCard(arg_27_0)
	if arg_27_0.contextData.selectedId then
		arg_27_0.contextData.selectedId = nil

		arg_27_0:UpdateMainView((getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_27_0.contextData.selectedId)))
		setActive(arg_27_0.togglePanel, true)
	end

	return
end

function var_0_0.OnInitItem(arg_28_0, arg_28_1)
	local var_28_0 = IslandMiniShipCard.New(arg_28_1)

	onButton(arg_28_0, var_28_0.go, function()
		if arg_28_0.childPage then
			arg_28_0.childPage:CheckInReturn(function()
				arg_28_0.childPage = nil

				arg_28_0:ClickCard(var_28_0.ship, var_28_0.configId)

				return
			end)
		else
			arg_28_0:ClickCard(var_28_0.ship, var_28_0.configId)
		end

		return
	end, SFX_PANEL)

	arg_28_0.cards[arg_28_1] = var_28_0

	return
end

function var_0_0.ClickCard(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 then
		arg_31_0:ClearSelected(arg_31_0.contextData.selectedId)
		arg_31_0:UpdateMainView(arg_31_1)
		arg_31_0:MarkSelected(arg_31_2)
	else
		arg_31_0:UpdateUnlockView(arg_31_2)
	end

	return
end

function var_0_0.ClearSelected(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in pairs(arg_32_0.cards) do
		if iter_32_1.configId == arg_32_1 then
			iter_32_1:UpdateSelected(nil)

			break
		end
	end

	return
end

function var_0_0.MarkSelected(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in pairs(arg_33_0.cards) do
		if iter_33_1.configId == arg_33_1 then
			iter_33_1:UpdateSelected(iter_33_1.configId)

			break
		end
	end

	return
end

function var_0_0.OnUpdateItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.cards[arg_34_2]

	if not arg_34_0.cards[arg_34_2] then
		arg_34_0:OnInitItem(arg_34_2)

		var_34_0 = arg_34_0.cards[arg_34_2]
	end

	local var_34_1 = arg_34_0.displays[arg_34_1 + 1]

	if not arg_34_0.displays[arg_34_1 + 1] then
		return
	end

	var_34_0:Update(var_34_1, arg_34_0.contextData.selectedId)

	return
end

function var_0_0.FlushShips(arg_35_0, arg_35_1)
	arg_35_0.displays = {}
	arg_35_0.displays = arg_35_1:GetUnlockOrCanUnlockShipConfigIds()

	local var_35_0

	if #arg_35_0.displays > 0 then
		var_35_0 = arg_35_1:GetShipById(arg_35_0.displays[1])
	end

	local var_35_1 = arg_35_0.contextData

	var_35_1.selectedId = arg_35_0.contextData.selectedId or var_35_0 and var_35_0.configId

	arg_35_0.shipRect:SetTotalCount(#arg_35_0.displays)

	return
end

function var_0_0.CalcShipLayout(arg_36_0)
	if arg_36_0.shipContainer.rect.height < arg_36_0.shipRect.gameObject.transform.rect.height then
		arg_36_0.shipRect.gameObject.transform.offsetMax = Vector2(arg_36_0.shipRect.gameObject.transform.offsetMax.x, -((arg_36_0._tf.rect.height - arg_36_0.shipContainer.rect.height) * 0.5))
		arg_36_0.shipRect.gameObject.transform.offsetMin = Vector2(arg_36_0.shipRect.gameObject.transform.offsetMin.x, (arg_36_0._tf.rect.height - arg_36_0.shipContainer.rect.height) * 0.5)
	end

	return
end

function var_0_0.UpdateMainView(arg_37_0, arg_37_1)
	if arg_37_0.contextData.selectedId == arg_37_1.configId then
		return
	end

	arg_37_0.shipDressHelper = arg_37_0.shipDressHelper or IslandShipDressHelperNew.New()

	arg_37_0.shipDressHelper:SetShipId(arg_37_1.configId)
	arg_37_0:LoadCharacter(arg_37_1:GetModel())

	arg_37_0.contextData.selectedId = arg_37_1.configId

	arg_37_0:TriggerPage(var_0_0.PAGE_INFO)

	return
end

function var_0_0.UpdateUnlockView(arg_38_0, arg_38_1)
	arg_38_0:ShowMsgBox({
		content = i18n("island_open_ship_tip"),
		onYes = function()
			arg_38_0:Hide()
			arg_38_0:emit(IslandBaseMediator.SWITCH_MAP, IslandConst.LABORATORY_MAP_ID, IslandConst.LETTEROFINVITATION_SP)

			return
		end
	})

	return
end

function var_0_0.OnDestroy(arg_40_0)
	var_0_0.super.OnDestroy(arg_40_0)
	ClearLScrollrect(arg_40_0.shipRect)

	local var_40_0 = arg_40_0.cards or {}

	for iter_40_0, iter_40_1 in pairs(var_40_0) do
		iter_40_1:Dispose()
	end

	arg_40_0.cards = nil

	if arg_40_0.timer then
		arg_40_0.timer:Stop()
	end

	if arg_40_0.shipDressHelper then
		arg_40_0.shipDressHelper:Destroy()
	end

	return
end

function var_0_0.OnHide(arg_41_0)
	if arg_41_0.shipDressHelper then
		arg_41_0.shipDressHelper:Destroy()
	end

	return
end

function var_0_0.CanEsc(arg_42_0)
	if arg_42_0.childPage then
		arg_42_0.childPage:CheckInReturn(function()
			arg_42_0:Hide()

			arg_42_0.childPage = nil

			return
		end)

		return false
	else
		return true
	end

	return
end

function var_0_0.OnCharLoaded(arg_44_0, arg_44_1)
	if arg_44_0.shipDressHelper then
		arg_44_0.shipDressHelper:OnRoleLoaded(arg_44_0.role.transform, arg_44_1)
	end

	return
end

function var_0_0.SetObjInitRotaion(arg_45_0, arg_45_1)
	local var_45_0 = GetOrAddComponent(arg_45_0:GetSmoothRotateObject(), typeof(SmoothRotateObject))

	var_45_0.rotationSpeed = 5

	ReflectionHelp.RefSetProperty(typeof(SmoothRotateObject), "targetRotation", var_45_0, arg_45_1)

	if arg_45_0.timer then
		arg_45_0.timer:Stop()
	end

	arg_45_0.timer = Timer.New(function()
		var_45_0.rotationSpeed = pg.island_set.character_detail_camera_speed.key_value_int

		return
	end, 0.5, 1)

	arg_45_0.timer:Start()

	return
end

function var_0_0.GetNeedHideUnlockShipFlag(arg_47_0)
	return false
end

return var_0_0
