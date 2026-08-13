class = var_0_10000

local var_0_0 = "IslandShipMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseShipDisplayPage"))

var_0_1.OPEN_PAGE = "IslandShipMainPage:OPEN_PAGE"
var_0_1.SELECT_SHIP = "IslandShipMainPage:SELECT_SHIP"
var_0_1.CLOSE_DOCK = "IslandShipMainPage:CLOSE_DOCK"
var_0_1.CLEAR_ITEM_ANIMATOR = "IslandShipMainPage:CLEAR_ITEM_ANIMATOR"
var_0_1.PAGE_DRESS = 1
var_0_1.PAGE_INFO = 2
var_0_1.PAGE_STATUS = 3
var_0_1.PAGE_PROFILE = 4

function var_0_1.getUIName(arg_1_0)
	return "IslandShipMainUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "top/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_1, "top/home")

	local var_2_2 = arg_2_0._tf

	arg_2_0.leftPanel = var_1.Find(var_2_2, "adapt/left_panel")

	local var_2_3 = arg_2_0._tf

	arg_2_0.dockBtn = var_1.Find(var_2_3, "adapt/left_panel/dock_btn")

	local var_2_4 = arg_2_0._tf

	arg_2_0.togglePanel = var_1.Find(var_2_4, "top/toggles")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "adapt/left_panel/ships")

	arg_2_0.shipRect = var_1.GetComponent(var_2_6, "LScrollRect")

	local var_2_7 = arg_2_0._tf

	arg_2_0.shipContainer = var_1.Find(var_2_7, "adapt/left_panel/ships/content")

	function arg_2_0.shipRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.shipRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	local var_2_8 = {}
	local var_2_9 = var_0_1.PAGE_INFO
	local var_2_10 = arg_2_0._tf

	var_2_8[var_2_9] = var_3.Find(var_2_10, "top/toggles/info")

	local var_2_11 = var_0_1.PAGE_DRESS
	local var_2_12 = arg_2_0._tf

	var_2_8[var_2_11] = var_3.Find(var_2_12, "top/toggles/dress")

	local var_2_13 = var_0_1.PAGE_STATUS
	local var_2_14 = arg_2_0._tf

	var_2_8[var_2_13] = var_3.Find(var_2_14, "top/toggles/gift")

	local var_2_15 = var_0_1.PAGE_PROFILE
	local var_2_16 = arg_2_0._tf

	var_2_8[var_2_15] = var_3.Find(var_2_16, "topapt/toggles/data")
	arg_2_0.toggles = var_2_8

	local var_2_17 = {}
	local var_2_18 = var_0_1.PAGE_INFO

	IslandShipInfoPage = var_3
	var_2_17[var_2_18] = var_3

	local var_2_19 = var_0_1.PAGE_DRESS

	IslandShipDressUpPageNew = var_3
	var_2_17[var_2_19] = var_3

	local var_2_20 = var_0_1.PAGE_STATUS

	IslandShipStatusPage = var_3
	var_2_17[var_2_20] = var_3

	local var_2_21 = var_0_1.PAGE_PROFILE

	IslandShipProfilePage = var_3
	var_2_17[var_2_21] = var_3
	arg_2_0.pages = var_2_17
	arg_2_0.cards = {}
	setActive = var_1

	var_1(arg_2_0.togglePanel, true)

	setText = var_1

	local var_2_22 = arg_2_0._tf
	local var_2_23 = var_2.Find(var_2_22, "top/title/Text")

	i18n = var_2_22

	var_1(var_2_23, var_2_22("island_chara_totalname"))

	setText = var_1

	local var_2_24 = arg_2_0._tf
	local var_2_25 = var_2.Find(var_2_24, "top/title/Text/en")

	i18n = var_2_24

	var_1(var_2_25, var_2_24("island_chara_totalname_en"))

	return
end

function var_0_1.GetSmoothRotateObject(arg_5_0)
	local var_5_0 = arg_5_0._tf

	return var_1.Find(var_5_0, "adapt/char")
end

function var_0_1.AddListeners(arg_6_0)
	arg_6_0:AddListener(var_0_1.CLOSE_DOCK, arg_6_0.OnCloseDock)
	arg_6_0:AddListener(var_0_1.OPEN_PAGE, arg_6_0.OnTriggerPage)

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	IslandShipMainPage = var_3

	var_6_1(var_6_0, var_3.SELECT_SHIP, arg_6_0.OnSelectShip)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.AddListener

	IslandCharacterAgency = var_3

	var_6_3(var_6_2, var_3.ADD_SHIP, arg_6_0.OnAddShip)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.AddListener

	GAME = var_3

	var_6_5(var_6_4, var_3.ISLAND_UPGRADE_SKILL_DONE, arg_6_0.OnSkillUpgrade)
	arg_6_0:AddListener(var_0_1.CLEAR_ITEM_ANIMATOR, arg_6_0.OnClearItemAnimator)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(var_0_1.CLOSE_DOCK, arg_7_0.OnCloseDock)
	arg_7_0:RemoveListener(var_0_1.OPEN_PAGE, arg_7_0.OnTriggerPage)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	IslandShipMainPage = var_3

	var_7_1(var_7_0, var_3.SELECT_SHIP, arg_7_0.OnSelectShip)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.RemoveListener

	IslandCharacterAgency = var_3

	var_7_3(var_7_2, var_3.ADD_SHIP, arg_7_0.OnAddShip)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.RemoveListener

	GAME = var_3

	var_7_5(var_7_4, var_3.ISLAND_UPGRADE_SKILL_DONE, arg_7_0.OnSkillUpgrade)
	arg_7_0:RemoveListener(var_0_1.CLEAR_ITEM_ANIMATOR, arg_7_0.OnClearItemAnimator)

	return
end

function var_0_1.OnCloseDock(arg_8_0)
	arg_8_0:SetVisible(arg_8_0.leftPanel, true)

	return
end

function var_0_1.OnSkillUpgrade(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.cards) do
		iter_9_1:FlushRedDot()
	end

	return
end

function var_0_1.OnGotExtra(arg_10_0)
	if not arg_10_0.contextData.selectedId then
		return
	end

	getProxy = var_1
	IslandProxy = var_1_10002

	local var_10_0 = var_1(var_1_10002)
	local var_10_1 = var_1.GetIsland(var_10_0)
	local var_10_2 = var_1.GetCharacterAgency(var_10_1)
	local var_10_3 = var_1.GetShipById(var_10_2, arg_10_0.contextData.selectedId)

	arg_10_0:FlushExtraAward(var_10_3)

	return
end

function var_0_1.OnAddShip(arg_11_0)
	arg_11_0:Flush()

	if not arg_11_0.contextData.selectedId then
		-- block empty
	end

	return
end

function var_0_1.OnSelectShip(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)
	local var_12_1 = var_2.GetIsland(var_12_0)
	local var_12_2 = var_2.GetCharacterAgency(var_12_1)
	local var_12_3 = var_2.GetShipById(var_12_2, arg_12_1)

	arg_12_0:ClickCard(var_12_3, arg_12_1)

	return
end

function var_0_1.OnTriggerPage(arg_13_0, arg_13_1)
	arg_13_0:TriggerPage(arg_13_1)

	return
end

function var_0_1.OnInit(arg_14_0)
	onButton = var_1_10001

	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0._tf
	local var_14_2 = var_3.Find(var_14_1, "top/title/help")

	local function var_14_3()
		pg = var_2_10000

		local var_15_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_15_1 = var_0.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_15_2.type = var_2_10003
		pg = var_2_10003
		var_15_2.helps = var_2_10003.gametip.island_help_character_info.tip

		var_15_1(var_15_0, var_15_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_0, var_14_2, var_14_3, var_5)

	onButton = var_1_10001

	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.homeBtn

	local function var_14_6()
		local var_16_0 = arg_14_0

		var_0.OnHome(var_16_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_4, var_14_5, var_14_6, var_5)

	onButton = var_1_10001

	local var_14_7 = arg_14_0
	local var_14_8 = arg_14_0.backBtn

	local function var_14_9()
		if arg_14_0.childPage then
			local var_17_0 = arg_14_0.childPage

			var_0.CheckInReturn(var_17_0, function()
				local var_18_0 = arg_14_0

				var_0.Hide(var_18_0)

				arg_14_0.childPage = nil

				return
			end)
		else
			local var_17_1 = arg_14_0

			var_0.Hide(var_17_1)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_7, var_14_8, var_14_9, var_5)

	onButton = var_1_10001

	local var_14_10 = arg_14_0
	local var_14_11 = arg_14_0.dockBtn

	local function var_14_12()
		local var_19_0 = arg_14_0
		local var_19_1 = var_0.OpenPage

		IslandDockPage = var_2_10002

		local var_19_2 = arg_14_0

		var_19_1(var_19_0, var_2_10002, var_3.GetNeedHideUnlockShipFlag(var_19_2))

		local var_19_3 = arg_14_0

		var_0.SetVisible(var_19_3, arg_14_0.leftPanel, false)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_14_10, var_14_11, var_14_12, var_5)

	ipairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.toggles) do
		onToggle = var_1_10006

		local var_14_13 = arg_14_0
		local var_14_14 = iter_14_1

		local function var_14_15(arg_20_0)
			if arg_20_0 then
				if arg_14_0.childPage then
					local var_20_0 = arg_14_0.childPage

					var_1.CheckInReturn(var_20_0, function()
						local var_21_0 = arg_14_0

						var_0.SwitchPage(var_21_0, iter_14_0)

						return
					end)
				else
					local var_20_1 = arg_14_0

					var_1.SwitchPage(var_20_1, iter_14_0)
				end
			end

			return
		end

		SFX_PANEL = var_1_10010

		var_1_10006(var_14_13, var_14_14, var_14_15, var_1_10010)
	end

	return
end

function var_0_1.SwitchPage(arg_22_0, arg_22_1)
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
			local var_23_0 = arg_22_0

			var_1.SetObjInitRotaion(var_23_0, arg_23_0)

			return
		end)
	else
		arg_22_0:OpenPage(var_22_0, arg_22_0.contextData.selectedId)

		arg_22_0.childPage = nil
	end

	arg_22_0.page = var_22_0

	return
end

function var_0_1.TriggerPage(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.toggles[arg_24_1]

	triggerToggle = var_1_10003

	var_1_10003(var_24_0, true)

	return
end

function var_0_1.Show(arg_25_0)
	var_0_1.super.Show(arg_25_0)
	arg_25_0:Flush()

	setActive = var_1

	var_1(arg_25_0.togglePanel, true)

	return
end

function var_0_1.Flush(arg_26_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_26_0 = var_1_10001(var_1_10002)
	local var_26_1 = var_1.GetIsland(var_26_0)
	local var_26_2 = var_1.GetCharacterAgency(var_26_1)

	arg_26_0:FlushShips(var_26_2)
	arg_26_0:ActiveDefaultCard()

	return
end

function var_0_1.ActiveDefaultCard(arg_27_0)
	if arg_27_0.contextData.selectedId then
		getProxy = var_1
		IslandProxy = var_1_10002

		local var_27_0 = var_1(var_1_10002)
		local var_27_1 = var_1.GetIsland(var_27_0)
		local var_27_2 = var_1.GetCharacterAgency(var_27_1)
		local var_27_3 = var_1.GetShipById(var_27_2, arg_27_0.contextData.selectedId)

		arg_27_0.contextData.selectedId = nil

		arg_27_0:UpdateMainView(var_27_3)

		setActive = var_3

		var_3(arg_27_0.togglePanel, true)
	end

	return
end

function var_0_1.OnInitItem(arg_28_0, arg_28_1)
	IslandMiniShipCard = var_1_10002

	local var_28_0 = var_1_10002.New(arg_28_1)

	onButton = var_3

	local var_28_1 = arg_28_0
	local var_28_2 = var_28_0.go

	local function var_28_3()
		if arg_28_0.childPage then
			local var_29_0 = arg_28_0.childPage

			var_0.CheckInReturn(var_29_0, function()
				arg_28_0.childPage = nil

				local var_30_0 = arg_28_0

				var_0.ClickCard(var_30_0, var_28_0.ship, var_28_0.configId)

				return
			end)
		else
			local var_29_1 = arg_28_0

			var_0.ClickCard(var_29_1, var_28_0.ship, var_28_0.configId)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_28_1, var_28_2, var_28_3, var_1_10007)

	arg_28_0.cards[arg_28_1] = var_28_0

	return
end

function var_0_1.ClickCard(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 then
		arg_31_0:ClearSelected(arg_31_0.contextData.selectedId)
		arg_31_0:UpdateMainView(arg_31_1)
		arg_31_0:MarkSelected(arg_31_2)
	else
		arg_31_0:UpdateUnlockView(arg_31_2)
	end

	return
end

function var_0_1.ClearSelected(arg_32_0, arg_32_1)
	pairs = var_1_10002

	for iter_32_0, iter_32_1 in var_1_10002(arg_32_0.cards) do
		if iter_32_1.configId == arg_32_1 then
			iter_32_1:UpdateSelected(nil)

			break
		end
	end

	return
end

function var_0_1.MarkSelected(arg_33_0, arg_33_1)
	pairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0.cards) do
		if iter_33_1.configId == arg_33_1 then
			iter_33_1:UpdateSelected(iter_33_1.configId)

			break
		end
	end

	return
end

function var_0_1.OnUpdateItem(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0.cards[arg_34_2] then
		arg_34_0:OnInitItem(arg_34_2)

		var_34_0 = arg_34_0.cards[arg_34_2]
	end

	if not arg_34_0.displays[arg_34_1 + 1] then
		return
	end

	var_34_0:Update(var_4, arg_34_0.contextData.selectedId)

	return
end

function var_0_1.FlushShips(arg_35_0, arg_35_1)
	arg_35_0.displays = {}
	arg_35_0.displays = arg_35_1:GetUnlockOrCanUnlockShipConfigIds()

	local var_35_0

	if #arg_35_0.displays > 0 then
		var_35_0 = arg_35_1:GetShipById(arg_35_0.displays[1])
	end

	local var_35_1 = arg_35_0.contextData
	local var_35_2

	if not arg_35_0.contextData.selectedId then
		var_35_2 = var_35_0 and var_35_0.configId
	end

	var_35_1.selectedId = var_35_2

	local var_35_3 = arg_35_0.shipRect

	var_3.SetTotalCount(var_35_3, #arg_35_0.displays)

	return
end

function var_0_1.CalcShipLayout(arg_36_0)
	if arg_36_0.shipContainer.rect.height < arg_36_0.shipRect.gameObject.transform.rect.height then
		local var_36_0 = (arg_36_0._tf.rect.height - var_1) * 0.5

		Vector2 = var_1_10005
		var_2.offsetMax = var_1_10005(var_2.offsetMax.x, -var_36_0)
		Vector2 = var_5
		var_2.offsetMin = var_5(var_2.offsetMin.x, var_36_0)
	end

	return
end

function var_0_1.UpdateMainView(arg_37_0, arg_37_1)
	if arg_37_0.contextData.selectedId == arg_37_1.configId then
		return
	end

	if not arg_37_0.shipDressHelper then
		IslandShipDressHelperNew = var_2
		arg_37_0.shipDressHelper = var_2.New()
	end

	local var_37_0 = arg_37_0.shipDressHelper

	var_2.SetShipId(var_37_0, arg_37_1.configId)
	arg_37_0:LoadCharacter(arg_37_1:GetModel())

	arg_37_0.contextData.selectedId = arg_37_1.configId

	arg_37_0:TriggerPage(var_0_1.PAGE_INFO)

	return
end

function var_0_1.UpdateUnlockView(arg_38_0, arg_38_1)
	pg = var_1_10002

	local var_38_0 = var_1_10002.island_chara_template[arg_38_1].name
	local var_38_1 = arg_38_0
	local var_38_2 = arg_38_0.ShowMsgBox
	local var_38_3 = {}

	i18n = var_1_10006
	var_38_3.content = var_1_10006("island_open_ship_tip")

	function var_38_3.onYes()
		local var_39_0 = arg_38_0

		var_0.Hide(var_39_0)

		local var_39_1 = arg_38_0
		local var_39_2 = var_0.emit

		IslandBaseMediator = var_2_10002

		local var_39_3 = var_2_10002.SWITCH_MAP

		IslandConst = var_2_10003

		local var_39_4 = var_2_10003.LABORATORY_MAP_ID

		IslandConst = var_2_10004

		var_39_2(var_39_1, var_39_3, var_39_4, var_2_10004.LETTEROFINVITATION_SP)

		return
	end

	var_38_2(var_38_1, var_38_3)

	return
end

function var_0_1.OnDestroy(arg_40_0)
	var_0_1.super.OnDestroy(arg_40_0)

	ClearLScrollrect = var_1

	var_1(arg_40_0.shipRect)

	pairs = var_1

	local var_40_0

	if not arg_40_0.cards then
		var_40_0 = {}
	end

	for iter_40_0, iter_40_1 in var_1(var_40_0) do
		iter_40_1:Dispose()
	end

	arg_40_0.cards = nil

	if arg_40_0.timer then
		local var_40_1 = arg_40_0.timer

		var_1.Stop(var_40_1)
	end

	if arg_40_0.shipDressHelper then
		local var_40_2 = arg_40_0.shipDressHelper

		var_1.Destroy(var_40_2)
	end

	return
end

function var_0_1.OnHide(arg_41_0)
	if arg_41_0.shipDressHelper then
		local var_41_0 = arg_41_0.shipDressHelper

		var_1.Destroy(var_41_0)
	end

	return
end

function var_0_1.CanEsc(arg_42_0)
	if arg_42_0.childPage then
		local var_42_0 = arg_42_0.childPage

		var_1.CheckInReturn(var_42_0, function()
			local var_43_0 = arg_42_0

			var_0.Hide(var_43_0)

			arg_42_0.childPage = nil

			return
		end)

		return false
	else
		return true
	end

	return
end

function var_0_1.OnCharLoaded(arg_44_0, arg_44_1)
	if arg_44_0.shipDressHelper then
		local var_44_0 = arg_44_0.shipDressHelper

		var_2.OnRoleLoaded(var_44_0, arg_44_0.role.transform, arg_44_1)
	end

	return
end

function var_0_1.SetObjInitRotaion(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0
	local var_45_1

	var_45_1, GetOrAddComponent = arg_45_0.GetSmoothRotateObject(var_45_0), var_45_0
	typeof = var_1_10005
	SmoothRotateObject = var_1_10006

	local var_45_2 = var_45_0(var_45_1, var_1_10005(var_1_10006))

	var_45_2.rotationSpeed = 5
	ReflectionHelp = var_4

	local var_45_3 = var_4.RefSetProperty

	typeof = var_5
	SmoothRotateObject = var_1_10006

	var_45_3(var_5(var_1_10006), "targetRotation", var_45_2, arg_45_1)

	if arg_45_0.timer then
		local var_45_4 = arg_45_0.timer

		var_4.Stop(var_45_4)
	end

	Timer = var_4
	arg_45_0.timer = var_4.New(function()
		pg = var_2_10000

		local var_46_0 = var_2_10000.island_set.character_detail_camera_speed.key_value_int

		var_45_2.rotationSpeed = var_46_0

		return
	end, 0.5, 1)

	local var_45_5 = arg_45_0.timer

	var_4.Start(var_45_5)

	return
end

function var_0_1.GetNeedHideUnlockShipFlag(arg_47_0)
	return false
end

return var_0_1
