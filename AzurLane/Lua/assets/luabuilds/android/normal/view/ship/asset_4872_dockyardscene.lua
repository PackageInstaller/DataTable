class = var_0_10000

local var_0_0 = "DockyardScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 2
local var_0_3 = 0.2
local var_0_4 = 1

var_0_1.MODE_OVERVIEW = "overview"
var_0_1.MODE_DESTROY = "destroy"
var_0_1.MODE_SELECT = "select"
var_0_1.MODE_MOD = "modify"
var_0_1.MODE_WORLD = "world"
var_0_1.MODE_REMOULD = "remould"
var_0_1.MODE_UPGRADE = "upgrade"
var_0_1.MODE_GUILD_BOSS = "guildboss"
var_0_1.MODE_SHIP_PHANTOM = "phantom"
i18n = var_4
var_0_1.TITLE_CN_OVERVIEW = var_4("word_dockyard")
i18n = var_4
var_0_1.TITLE_CN_UPGRADE = var_4("word_dockyardUpgrade")
i18n = var_4
var_0_1.TITLE_CN_DESTROY = var_4("word_dockyardDestroy")
var_0_1.TITLE_EN_OVERVIEW = "dockyard"
var_0_1.TITLE_EN_UPGRADE = "modernization"
var_0_1.TITLE_EN_DESTROY = "retirement"
var_0_1.PRIOR_MODE_EQUIP_UP = 1
var_0_1.PRIOR_MODE_SHIP_UP = 2

function var_0_1.getUIName(arg_1_0)
	return "DockyardUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0.contextData

	defaultValue = var_1_10002
	var_2_0.mode = var_1_10002(var_2_0.mode, var_0_1.MODE_SELECT)
	defaultValue = var_2
	var_2_0.otherSelectedIds = var_2(var_2_0.otherSelectedIds, {})
	arg_2_0.teamTypeFilter = var_2_0.teamFilter

	local var_2_1

	if not var_2_0.selectedMin then
		var_2_1 = 1
	end

	arg_2_0.selectedMin = var_2_1
	arg_2_0.leastLimitMsg = var_2_0.leastLimitMsg

	local var_2_2

	if not var_2_0.selectedMax then
		var_2_2 = 0
	end

	arg_2_0.selectedMax = var_2_2

	local var_2_3

	if not var_2_0.selectedIds then
		var_2_3 = {}
	end

	var_2_0.selectedIds = var_2_3

	if var_2_0.infoShipId then
		table = var_2

		var_2.insert(var_2_0.selectedIds, var_2_0.infoShipId)

		var_2_0.infoShipId = nil
	end

	underscore = var_2

	local var_2_4 = var_2(var_2_0.selectedIds)
	local var_2_5 = var_2.chain(var_2_4)
	local var_2_6 = var_2.select(var_2_5, function(arg_3_0)
		getProxy = var_2_10001
		BayProxy = var_2_10002

		local var_3_0 = var_2_10001(var_2_10002)

		return var_1.RawGetShipById(var_3_0, arg_3_0) ~= nil
	end)
	local var_2_7 = var_2.first(var_2_6, arg_2_0.selectedMax)

	arg_2_0.selectedIds = var_2.value(var_2_7)
	var_2_0.selectedIds = nil

	local var_2_8

	if not var_2_0.onShip then
		function var_2_8(arg_4_0, arg_4_1, arg_4_2)
			return true
		end
	end

	arg_2_0.checkShip = var_2_8

	local var_2_9

	if not var_2_0.onCancelShip then
		function var_2_9(arg_5_0, arg_5_1, arg_5_2)
			return true
		end
	end

	arg_2_0.onCancelShip = var_2_9

	local var_2_10

	if not var_2_0.onClick then
		function var_2_10(arg_6_0, arg_6_1, arg_6_2)
			local var_6_0 = arg_2_0
			local var_6_1 = var_3.emit

			DockyardMediator = var_2_10005

			var_6_1(var_6_0, var_2_10005.ON_SHIP_DETAIL, arg_6_0, arg_6_1, arg_6_2)

			return
		end
	end

	arg_2_0.onClick = var_2_10
	arg_2_0.confirmSelect = var_2_0.confirmSelect
	arg_2_0.callbackQuit = var_2_0.callbackQuit

	local var_2_11

	if not var_2_0.onSelected then
		function var_2_11(arg_7_0, arg_7_1)
			warning = var_2_10002

			var_2_10002("not implemented.")

			return
		end
	end

	arg_2_0.onSelected = var_2_11

	local var_2_12 = arg_2_0._tf

	arg_2_0.blurPanel = var_2.Find(var_2_12, "blur_panel")

	local var_2_13 = arg_2_0.blurPanel

	arg_2_0.settingBtn = var_2.Find(var_2_13, "adapt/left_length/frame/setting")
	DockyardQuickSelectSettingPage = var_2
	arg_2_0.settingPanel = var_2.New(arg_2_0._tf, arg_2_0.event)

	local var_2_14 = arg_2_0.settingPanel

	var_2.OnSettingChanged(var_2_14, function()
		local var_8_0 = arg_2_0

		var_0.unselecteAllShips(var_8_0)

		return
	end)

	local var_2_15 = arg_2_0.blurPanel

	arg_2_0.topPanel = var_2.Find(var_2_15, "adapt/top")

	local var_2_16 = arg_2_0.topPanel

	arg_2_0.sortBtn = var_2.Find(var_2_16, "sort_button")

	local var_2_17 = arg_2_0.sortBtn

	arg_2_0.sortImgAsc = var_2.Find(var_2_17, "asc")

	local var_2_18 = arg_2_0.sortBtn

	arg_2_0.sortImgDesc = var_2.Find(var_2_18, "desc")

	local var_2_19 = arg_2_0.topPanel

	arg_2_0.leftTipsText = var_2.Find(var_2_19, "capacity")
	onButton = var_2

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0.leftTipsText
	local var_2_22 = var_4.Find(var_2_21, "switch")

	local function var_2_23()
		arg_2_0.isCapacityMeta = not arg_2_0.isCapacityMeta

		local var_9_0 = arg_2_0

		var_0.updateCapacityDisplay(var_9_0)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_20, var_2_22, var_2_23, var_6)

	onButton = var_2

	local var_2_24 = arg_2_0
	local var_2_25 = arg_2_0.leftTipsText
	local var_2_26 = var_4.Find(var_2_25, "plus")

	local function var_2_27()
		gotoChargeScene = var_2_10000

		var_2_10000()

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_24, var_2_26, var_2_27, var_6)

	onButton = var_2

	local var_2_28 = arg_2_0
	local var_2_29 = arg_2_0.leftTipsText
	local var_2_30 = var_4.Find(var_2_29, "tip")

	local function var_2_31()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {
			hideNo = true
		}

		i18n = var_2_10003
		var_11_2.content = var_2_10003("specialshipyard_tip")

		var_11_1(var_11_0, var_11_2)

		return
	end

	SFX_PANEL = var_6

	var_2(var_2_28, var_2_30, var_2_31, var_6)

	setActive = var_2

	var_2(arg_2_0.leftTipsText, false)

	local var_2_32 = arg_2_0.topPanel

	arg_2_0.indexBtn = var_2.Find(var_2_32, "index_button")

	local var_2_33 = arg_2_0.topPanel

	arg_2_0.switchPanel = var_2.Find(var_2_33, "switch")

	local var_2_34 = arg_2_0.switchPanel

	arg_2_0.preferenceAndAttrContainer = var_2.Find(var_2_34, "toggles")

	local var_2_35 = arg_2_0.switchPanel

	arg_2_0.preferenceBtn = var_2.Find(var_2_35, "toggles/preference_toggle")

	local var_2_36 = arg_2_0.switchPanel

	arg_2_0.attrBtn = var_2.Find(var_2_36, "toggles/attr_toggle")

	local var_2_37 = arg_2_0.topPanel

	arg_2_0.modLockFilter = var_2.Find(var_2_37, "mod_flter_lock")

	local var_2_38 = arg_2_0.topPanel

	arg_2_0.modLeveFilter = var_2.Find(var_2_38, "mod_flter_level")

	local var_2_39 = arg_2_0._tf

	arg_2_0.energyDescTF = var_2.Find(var_2_39, "energy_desc")

	local var_2_40 = arg_2_0.energyDescTF

	arg_2_0.energyDescTextTF = var_2.Find(var_2_40, "Text")

	local var_2_41 = arg_2_0.blurPanel

	arg_2_0.selectPanel = var_2.Find(var_2_41, "select_panel")

	local var_2_42 = arg_2_0.selectPanel

	arg_2_0.bottomTipsText = var_2.Find(var_2_42, "tip")

	local var_2_43 = arg_2_0.selectPanel

	arg_2_0.bottomTipsWithFrame = var_2.Find(var_2_43, "tipwithframe")
	setText = var_2

	local var_2_44 = arg_2_0.selectPanel
	local var_2_45 = var_3.Find(var_2_44, "bottom_info/bg_input/selected")

	i18n = var_2_44

	var_2(var_2_45, var_2_44("disassemble_selected") .. ":")

	local var_2_46 = arg_2_0.selectPanel

	arg_2_0.awardTF = var_2.Find(var_2_46, "bottom_info/bg_award")
	setText = var_2

	local var_2_47 = arg_2_0.awardTF
	local var_2_48 = var_3.Find(var_2_47, "label")

	i18n = var_2_47

	var_2(var_2_48, var_2_47("disassemble_available") .. ":")

	local var_2_49 = arg_2_0.selectPanel

	arg_2_0.modAttrsTF = var_2.Find(var_2_49, "bottom_info/bg_mod")

	local var_2_50 = arg_2_0.selectPanel

	arg_2_0.viewEquipmentBtn = var_2.Find(var_2_50, "view_equipments")

	local var_2_51 = arg_2_0.blurPanel

	arg_2_0.tipPanel = var_2.Find(var_2_51, "TipPanel")
	setActive = var_2

	var_2(arg_2_0.tipPanel, false)

	local var_2_52 = arg_2_0.blurPanel

	arg_2_0.worldPanel = var_2.Find(var_2_52, "world_port_panel")
	setActive = var_2

	var_2(arg_2_0.worldPanel, arg_2_0.contextData.mode == var_0_1.MODE_WORLD)

	local var_2_53 = arg_2_0.blurPanel

	arg_2_0.assultBtn = var_2.Find(var_2_53, "adapt/top/assult_btn")

	local var_2_54 = arg_2_0.topPanel

	arg_2_0.stampBtn = var_2.Find(var_2_54, "stamp")
	arg_2_0.isRemouldOrUpgradeMode = arg_2_0.contextData.mode == var_0_1.MODE_REMOULD or arg_2_0.contextData.mode == var_0_1.MODE_UPGRADE
	setActive = var_2

	var_2(arg_2_0.modLeveFilter, arg_2_0.isRemouldOrUpgradeMode)

	setActive = var_2

	var_2(arg_2_0.modLockFilter, arg_2_0.isRemouldOrUpgradeMode)

	setActive = var_2

	var_2(arg_2_0.assultBtn, arg_2_0.contextData.mode == var_0_1.MODE_GUILD_BOSS)

	switch = var_2

	var_2(arg_2_0.contextData.mode, {
		[var_0_1.MODE_OVERVIEW] = function()
			arg_2_0.selecteEnabled = false

			return
		end,
		[var_0_1.MODE_DESTROY] = function()
			arg_2_0.selecteEnabled = true
			arg_2_0.blacklist = {}

			local var_13_0 = arg_2_0

			UIItemList = var_1

			local var_13_1 = var_1.New
			local var_13_2 = arg_2_0.awardTF
			local var_13_3 = var_2.Find(var_13_2, "res_list")
			local var_13_4 = arg_2_0.awardTF

			var_13_0.destroyResList = var_13_1(var_13_3, var_3.Find(var_13_4, "res_list/res"))

			return
		end,
		[var_0_1.MODE_MOD] = function()
			local var_14_0 = arg_2_0

			var_14_0.selecteEnabled = true
			setText = var_14_0

			local var_14_1 = arg_2_0.modAttrsTF
			local var_14_2 = var_1.Find(var_14_1, "title/Text")

			i18n = var_14_1

			var_14_0(var_14_2, var_14_1("word_mod_value"))

			local var_14_3 = arg_2_0
			local var_14_4 = arg_2_0.modAttrsTF

			var_14_3.modAttrContainer = var_1.Find(var_14_4, "attrs")

			return
		end,
		[var_0_1.MODE_SHIP_PHANTOM] = function()
			arg_2_0.selecteEnabled = false

			return
		end
	}, function()
		arg_2_0.selecteEnabled = true

		return
	end)

	setActive = var_2

	local var_2_55 = arg_2_0.selectPanel
	local var_2_56

	if arg_2_0.selecteEnabled then
		var_2_56 = arg_2_0.contextData.mode ~= var_0_1.MODE_WORLD
	end

	var_2(var_2_55, var_2_56)

	setActive = var_2

	var_2(arg_2_0.worldPanel, arg_2_0.contextData.mode == var_0_1.MODE_WORLD)

	local var_2_57 = arg_2_0.contextData.mode == var_0_1.MODE_DESTROY

	setActive = var_3

	var_3(arg_2_0.settingBtn, var_2_57)

	setActive = var_3

	local var_2_58 = arg_2_0.selectPanel

	var_3(var_4.Find(var_2_58, "quick_select"), var_2_57)

	if arg_2_0.contextData.priorEquipUpShipIDList and arg_2_0.contextData.priorMode then
		setActive = var_3

		var_3(arg_2_0.tipPanel, true)

		local var_2_59 = arg_2_0.tipPanel
		local var_2_60 = var_3.Find(var_2_59, "EquipUP")
		local var_2_61 = arg_2_0.tipPanel
		local var_2_62 = var_4.Find(var_2_61, "ShipUP")

		setText = var_2_61

		local var_2_63 = var_2_60

		i18n = var_1_10007

		var_2_61(var_2_63, var_1_10007("fightfail_choiceequip"))

		setText = var_2_61

		local var_2_64 = var_2_62

		i18n = var_1_10007

		var_2_61(var_2_64, var_1_10007("fightfail_choicestrengthen"))

		setActive = var_2_61

		local var_2_65 = var_2_60

		var_1_10007 = arg_2_0.contextData.priorMode == var_0_1.PRIOR_MODE_EQUIP_UP

		var_2_61(var_2_65, var_1_10007)

		setActive = var_2_61

		local var_2_66 = var_2_62

		var_1_10007 = arg_2_0.contextData.priorMode == var_0_1.PRIOR_MODE_SHIP_UP

		var_2_61(var_2_66, var_1_10007)
	end

	local var_2_67 = arg_2_0._tf

	arg_2_0.togglePhantom = var_3.Find(var_2_67, "blur_panel/adapt/left_length/frame/toggle_phantom")
	onToggle = var_3

	local var_2_68 = arg_2_0
	local var_2_69 = arg_2_0.togglePhantom

	local function var_2_70(arg_17_0)
		if arg_2_0.inPhantom ~= arg_17_0 then
			arg_2_0.inPhantom = arg_17_0

			local var_17_0 = arg_2_0

			var_1.SwitchContainerDisplay(var_17_0)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_68, var_2_69, var_2_70, var_1_10007)

	setActive = var_3

	var_3(arg_2_0.togglePhantom, false)

	local var_2_71 = arg_2_0._tf

	arg_2_0.helpPhantom = var_3.Find(var_2_71, "blur_panel/adapt/left_length/frame/help_phantom")
	onButton = var_3

	local var_2_72 = arg_2_0
	local var_2_73 = arg_2_0.helpPhantom

	local function var_2_74()
		pg = var_2_10000

		local var_18_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_18_1 = var_0.ShowMsgBox
		local var_18_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_18_2.type = var_2_10003
		i18n = var_2_10003
		var_18_2.helps = var_2_10003("projection_help")

		var_18_1(var_18_0, var_18_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_2_72, var_2_73, var_2_74, var_1_10007)

	local var_2_75 = arg_2_0.contextData.mode == var_0_1.MODE_SHIP_PHANTOM and "phantom" or "dockyard"

	eachChild = var_4

	local var_2_76 = arg_2_0.topPanel

	var_4(var_5.Find(var_2_76, "titles"), function(arg_19_0, arg_19_1)
		setActive = var_2_10002

		var_2_10002(arg_19_0, arg_19_0.name == var_2_75)

		return
	end)

	local var_2_77 = arg_2_0._tf

	arg_2_0.listEmptyTF = var_4.Find(var_2_77, "empty")
	setActive = var_4

	var_4(arg_2_0.listEmptyTF, false)

	local var_2_78 = arg_2_0.listEmptyTF

	arg_2_0.listEmptyTxt = var_4.Find(var_2_78, "Text")
	setText = var_4

	local var_2_79 = arg_2_0.listEmptyTxt

	i18n = var_6

	var_4(var_2_79, var_6("list_empty_tip_dockyardui"))

	ShipDestroyPage = var_4
	arg_2_0.destroyPage = var_4.New(arg_2_0._tf, arg_2_0.event)

	local var_2_80 = arg_2_0.destroyPage

	var_4.SetCardClickCallBack(var_2_80, function(arg_20_0)
		local var_20_0 = arg_2_0.blacklist
		local var_20_1 = arg_20_0.shipVO

		var_20_0[var_2.getGroupId(var_20_1)] = true
		table = var_20_0

		if var_20_0.indexof(arg_2_0.selectedIds, arg_20_0.shipVO.id) and 0 < var_1 then
			table = var_2

			var_2.remove(arg_2_0.selectedIds, var_1)
		end

		local var_20_2 = arg_2_0

		var_2.updateDestroyRes(var_20_2)

		local var_20_3 = arg_2_0

		var_2.updateSelected(var_20_3)

		return
	end)

	local var_2_81 = arg_2_0.destroyPage

	var_4.SetConfirmCallBack(var_2_81, function()
		local var_21_0 = {}
		local var_21_1 = arg_2_0
		local var_21_2, var_21_3 = var_1.checkDestroyGold(var_21_1)

		if not var_21_3 then
			table = var_2_10003

			var_2_10003.insert(var_21_0, function(arg_22_0)
				pg = var_3_10001

				local var_22_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_22_1 = var_1.ShowMsgBox
				local var_22_2 = {}

				i18n = var_3_10004

				local var_22_3 = var_3_10004("oil_max_tip_title")

				i18n = var_5
				var_22_2.content = var_22_3 .. var_5("resource_max_tip_retire_1")
				var_22_2.onYes = arg_22_0

				var_22_1(var_22_0, var_22_2)

				return
			end)
		end

		underscore = var_2_10003

		local var_21_4 = var_2_10003.map(arg_2_0.selectedIds, function(arg_23_0)
			return arg_2_0.shipVOsById[arg_23_0]
		end)

		table = var_4

		var_4.insert(var_21_0, function(arg_24_0)
			local var_24_0 = arg_2_0

			var_1.checkDestroyShips(var_24_0, var_21_4, arg_24_0)

			return
		end)

		seriesAsync = var_4

		var_4(var_21_0, function()
			local var_25_0 = arg_2_0
			local var_25_1 = var_0.emit

			DockyardMediator = var_3_10002

			var_25_1(var_25_0, var_3_10002.ON_DESTROY_SHIPS, arg_2_0.selectedIds)

			return
		end)

		return
	end)

	ShipDestoryConfirmWindow = var_4
	arg_2_0.destroyConfirmWindow = var_4.New(arg_2_0._tf, arg_2_0.event)
	RecordableSearchBar = var_4

	local var_2_82 = var_4.New

	RecordableSearchBar = var_5

	local var_2_83 = var_5.CreateData
	local var_2_84 = {
		refresh_pos_when_expand = true
	}

	i18n = var_7
	var_2_84.holder = var_7("dockyard_search_holder")

	function var_2_84.onActive(arg_26_0)
		setActive = var_2_10001

		var_2_10001(arg_2_0.preferenceAndAttrContainer, not arg_26_0)

		return
	end

	function var_2_84.onInputChanged()
		local var_27_0 = arg_2_0

		var_0.filter(var_27_0)

		return
	end

	var_2_84.key = arg_2_0.__cname
	var_2_84.parent = arg_2_0.switchPanel

	local var_2_85 = arg_2_0.blurPanel

	var_2_84.expand_parent = var_7.Find(var_2_85, "adapt")
	Vector3 = var_7
	var_2_84.anchoredPosition = var_7(-33, -33, 0)
	arg_2_0.searchBar = var_2_82(var_2_83(var_2_84))

	return
end

function var_0_1.SwitchContainerDisplay(arg_28_0)
	arg_28_0.isPhantomMode = arg_28_0.contextData.mode == var_0_1.MODE_SHIP_PHANTOM or arg_28_0.inPhantom
	setActive = var_1

	var_1(arg_28_0.switchPanel, not arg_28_0.isRemouldOrUpgradeMode and not arg_28_0.isPhantomMode)

	setActive = var_1

	var_1(arg_28_0.indexBtn, not arg_28_0.isRemouldOrUpgradeMode and not arg_28_0.isPhantomMode)

	setActive = var_1

	var_1(arg_28_0.sortBtn, not arg_28_0.isRemouldOrUpgradeMode and not arg_28_0.isPhantomMode)

	setActive = var_1

	local var_28_0 = arg_28_0._tf

	var_1(var_2.Find(var_28_0, "main/ship_container"), not arg_28_0.isPhantomMode)

	setActive = var_1

	local var_28_1 = arg_28_0._tf

	var_1(var_2.Find(var_28_1, "main/phantom_container"), arg_28_0.isPhantomMode)

	setActive = var_1

	var_1(arg_28_0.preferenceBtn, not arg_28_0.isPhantomMode)
	arg_28_0:updateBarInfo()

	setActive = var_1

	var_1(arg_28_0.helpPhantom, arg_28_0.contextData.mode == var_0_1.MODE_SHIP_PHANTOM)

	pg = var_1

	local var_28_2 = var_1.SeriesGuideMgr.GetInstance()

	if var_1.isEnd(var_28_2) then
		PlayerPrefs = var_1

		if var_1.GetInt("PHANTOM_HELP_FIRST", 0) == 0 then
			PlayerPrefs = var_1

			var_1.SetInt("PHANTOM_HELP_FIRST", 1)

			triggerButton = var_1

			var_1(arg_28_0.helpPhantom)
		end
	end

	switch = var_1
	tobool = var_28_2

	var_1(var_28_2(arg_28_0.isPhantomMode), {
		[true] = function()
			local var_29_0 = arg_28_0
			local var_29_1

			if not arg_28_0.initDic then
				var_29_1 = {}
			end

			var_29_0.initDic = var_29_1

			if arg_28_0.initDic.phantom then
				return
			end

			local var_29_2 = arg_28_0.initDic

			var_29_2.phantom = true
			getProxy = var_29_2
			TechnologyProxy = var_1

			local var_29_3 = var_29_2(var_1)
			local var_29_4 = arg_28_0._tf
			local var_29_5 = var_1.Find(var_29_4, "main/phantom_container/title/content")
			local var_29_6 = var_29_3
			local var_29_7 = var_29_3.getConfigMaxVersion(var_29_6)

			UIItemList = var_29_6

			var_29_6.StaticAlign(var_29_5, var_29_5:GetChild(0), var_29_7 + 1, function(arg_30_0, arg_30_1, arg_30_2)
				UIItemList = var_3_10003

				if arg_30_0 == var_3_10003.EventUpdate then
					arg_30_2.name = "phase_" .. arg_30_1
					GetImageSpriteFromAtlasAsync = var_3

					var_3("ui/dockyardui_atlas", arg_30_1, arg_30_2:Find("on"))

					GetImageSpriteFromAtlasAsync = var_3

					local var_30_0 = "ui/dockyardui_atlas"
					local var_30_1 = arg_30_1
					local var_30_2 = arg_30_2

					var_3(var_30_0, var_30_1, arg_30_2.Find(var_30_2, "off"))

					onToggle = var_3

					local var_30_3 = arg_28_0
					local var_30_4 = arg_30_2

					local function var_30_5(arg_31_0)
						if arg_31_0 then
							arg_28_0.selectVersion = arg_30_1

							local var_31_0 = arg_28_0

							underscore = var_2
							var_31_0.filterBluePrint = var_2.filter(arg_28_0.shipBluePrints, function(arg_32_0)
								return arg_30_1 == 0 or arg_32_0:getConfig("blueprint_version") == arg_30_1
							end)

							local var_31_1 = arg_28_0.phantomContainer

							var_1.SetTotalCount(var_31_1, #arg_28_0.filterBluePrint, 0)
						end

						return
					end

					SFX_PANEL = var_30_2

					var_3(var_30_3, var_30_4, var_30_5, var_30_2)
				end

				return
			end)

			setActive = var_3

			local var_29_8 = arg_28_0._tf

			var_3(var_4.Find(var_29_8, "main/phantom_container/view/tpl"), false)

			local var_29_9 = arg_28_0
			local var_29_10 = arg_28_0._tf
			local var_29_11 = var_4.Find(var_29_10, "main/phantom_container/view/groups")

			var_29_9.phantomContainer = var_4.GetComponent(var_29_11, "LScrollRect")
			arg_28_0.phantomContainer.enabled = true
			arg_28_0.phantomContainer.decelerationRate = 0.07

			function arg_28_0.phantomContainer.onInitItem(arg_33_0)
				local var_33_0 = arg_28_0

				var_1.getOrInitPhantom(var_33_0, arg_33_0)

				ClearTweenItemAlphaAndWhite = var_1

				var_1(arg_33_0)

				return
			end

			function arg_28_0.phantomContainer.onUpdateItem(arg_34_0, arg_34_1)
				local var_34_0 = arg_28_0

				var_2.updatePhantomGroup(var_34_0, arg_28_0.filterBluePrint[arg_34_0 + 1], arg_34_1)

				TweenItemAlphaAndWhite = var_2

				var_2(arg_34_1)

				return
			end

			function arg_28_0.phantomContainer.onReturnItem(arg_35_0, arg_35_1)
				if arg_28_0.exited then
					return
				end

				local var_35_0 = arg_28_0
				local var_35_1 = var_2.getOrInitPhantom(var_35_0, arg_35_1)

				var_2.clear(var_35_1)

				ClearTweenItemAlphaAndWhite = var_3

				var_3(arg_35_1)

				return
			end

			arg_28_0.scrollPhantoms = {}
			arg_28_0.phantomGroupDic = {}

			local var_29_12 = 0

			if arg_28_0.contextData.techVersion then
				underscore = var_4

				if #var_4.filter(arg_28_0.shipBluePrints, function(arg_36_0)
					return arg_28_0.contextData.techVersion == 0 or arg_36_0:getConfig("blueprint_version") == arg_28_0.contextData.techVersion
				end) > 0 then
					var_29_12 = arg_28_0.contextData.techVersion
				end
			end

			local var_29_13 = arg_28_0.contextData

			var_29_13.techVersion = nil
			triggerToggle = var_29_13

			local var_29_14 = arg_28_0._tf
			local var_29_15 = var_5.Find(var_29_14, "main/phantom_container/title/content")

			var_29_13(var_5.GetChild(var_29_15, var_29_12), true)

			return
		end,
		[false] = function()
			local var_37_0 = arg_28_0
			local var_37_1

			if not arg_28_0.initDic then
				var_37_1 = {}
			end

			var_37_0.initDic = var_37_1

			if arg_28_0.initDic.ship then
				return
			end

			arg_28_0.initDic.ship = true

			local var_37_2 = arg_28_0
			local var_37_3 = arg_28_0._tf
			local var_37_4 = var_1.Find(var_37_3, "main/ship_container/ships")

			var_37_2.shipContainer = var_1.GetComponent(var_37_4, "LScrollRect")
			arg_28_0.shipContainer.enabled = true
			arg_28_0.shipContainer.decelerationRate = 0.07

			function arg_28_0.shipContainer.onInitItem(arg_38_0)
				local var_38_0 = arg_28_0

				var_1.onInitItem(var_38_0, arg_38_0)

				return
			end

			function arg_28_0.shipContainer.onUpdateItem(arg_39_0, arg_39_1)
				local var_39_0 = arg_28_0

				var_2.onUpdateItem(var_39_0, arg_39_0, arg_39_1)

				return
			end

			function arg_28_0.shipContainer.onReturnItem(arg_40_0, arg_40_1)
				local var_40_0 = arg_28_0

				var_2.onReturnItem(var_40_0, arg_40_0, arg_40_1)

				return
			end

			function arg_28_0.shipContainer.onStart()
				local var_41_0 = arg_28_0

				var_0.updateSelected(var_41_0)

				return
			end

			local var_37_5 = arg_28_0
			local var_37_6 = arg_28_0._tf

			var_37_5.shipLayout = var_1.Find(var_37_6, "main/ship_container/ships")
			arg_28_0.scrollItems = {}

			local var_37_7 = arg_28_0

			var_37_7.cardItemDic = {}
			_G = var_37_7

			if var_37_7[arg_28_0.contextData.preView] then
				local var_37_8 = arg_28_0

				if not var_0.sortIndex then
					ShipIndexConst = var_37_6
					var_37_6 = var_37_6.SortLevel
				end

				var_37_8.sortIndex = var_37_6

				local var_37_9 = arg_28_0

				if not var_0.selectAsc then
					var_37_6 = false
				end

				var_37_9.selectAsc = var_37_6

				local var_37_10 = arg_28_0

				if not var_0.typeIndex then
					ShipIndexConst = var_37_6
					var_37_6 = var_37_6.TypeAll
				end

				var_37_10.typeIndex = var_37_6

				local var_37_11 = arg_28_0

				if not var_0.campIndex then
					ShipIndexConst = var_37_6
					var_37_6 = var_37_6.CampAll
				end

				var_37_11.campIndex = var_37_6

				local var_37_12 = arg_28_0

				if not var_0.rarityIndex then
					ShipIndexConst = var_37_6
					var_37_6 = var_37_6.RarityAll
				end

				var_37_12.rarityIndex = var_37_6

				local var_37_13 = arg_28_0

				if not var_0.extraIndex then
					ShipIndexConst = var_37_6
					var_37_6 = var_37_6.ExtraAll
				end

				var_37_13.extraIndex = var_37_6

				local var_37_14 = arg_28_0

				if not var_0.commonTag then
					Ship = var_37_6
					var_37_6 = var_37_6.PREFERENCE_TAG_NONE
				end

				var_37_14.commonTag = var_37_6
			elseif arg_28_0.contextData.sortData then
				local var_37_15 = arg_28_0.contextData.sortData

				var_37_6 = arg_28_0

				local var_37_16

				if not var_37_15.sort then
					ShipIndexConst = var_37_16
					var_37_16 = var_37_16.SortLevel
				end

				var_37_6.sortIndex = var_37_16
				var_37_6 = arg_28_0

				local var_37_17

				if not var_37_15.Asc then
					var_37_17 = false
				end

				var_37_6.selectAsc = var_37_17
				var_37_6 = arg_28_0

				local var_37_18

				if not var_37_15.typeIndex then
					ShipIndexConst = var_37_18
					var_37_18 = var_37_18.TypeAll
				end

				var_37_6.typeIndex = var_37_18
				var_37_6 = arg_28_0

				local var_37_19

				if not var_37_15.campIndex then
					ShipIndexConst = var_37_19
					var_37_19 = var_37_19.CampAll
				end

				var_37_6.campIndex = var_37_19
				var_37_6 = arg_28_0

				local var_37_20

				if not var_37_15.rarityIndex then
					ShipIndexConst = var_37_20
					var_37_20 = var_37_20.RarityAll
				end

				var_37_6.rarityIndex = var_37_20
				var_37_6 = arg_28_0

				local var_37_21

				if not var_37_15.extraIndex then
					ShipIndexConst = var_37_21
					var_37_21 = var_37_21.ExtraAll
				end

				var_37_6.extraIndex = var_37_21
				var_37_6 = arg_28_0

				local var_37_22

				if not var_37_15.commonTag then
					Ship = var_37_22
					var_37_22 = var_37_22.PREFERENCE_TAG_NONE
				end

				var_37_6.commonTag = var_37_22
			else
				local var_37_23 = arg_28_0

				DockyardScene = var_37_6

				local var_37_24

				if not var_37_6.selectAsc then
					var_37_24 = false
				end

				var_37_23.selectAsc = var_37_24

				local var_37_25 = arg_28_0

				DockyardScene = var_37_24

				local var_37_26

				if not var_37_24.sortIndex then
					ShipIndexConst = var_37_26
					var_37_26 = var_37_26.SortLevel
				end

				var_37_25.sortIndex = var_37_26

				local var_37_27 = arg_28_0

				DockyardScene = var_37_26

				local var_37_28

				if not var_37_26.typeIndex then
					ShipIndexConst = var_37_28
					var_37_28 = var_37_28.TypeAll
				end

				var_37_27.typeIndex = var_37_28

				local var_37_29 = arg_28_0

				DockyardScene = var_37_28

				local var_37_30

				if not var_37_28.campIndex then
					ShipIndexConst = var_37_30
					var_37_30 = var_37_30.CampAll
				end

				var_37_29.campIndex = var_37_30

				local var_37_31 = arg_28_0

				DockyardScene = var_37_30

				local var_37_32

				if not var_37_30.rarityIndex then
					ShipIndexConst = var_37_32
					var_37_32 = var_37_32.RarityAll
				end

				var_37_31.rarityIndex = var_37_32

				local var_37_33 = arg_28_0

				DockyardScene = var_37_32

				local var_37_34

				if not var_37_32.extraIndex then
					ShipIndexConst = var_37_34
					var_37_34 = var_37_34.ExtraAll
				end

				var_37_33.extraIndex = var_37_34

				local var_37_35 = arg_28_0

				DockyardScene = var_37_34

				local var_37_36

				if not var_37_34.commonTag then
					Ship = var_37_36
					var_37_36 = var_37_36.PREFERENCE_TAG_NONE
				end

				var_37_35.commonTag = var_37_36
			end

			local var_37_37 = arg_28_0

			var_1.updateIndexDatas(var_37_37)

			triggerToggle = var_1

			local var_37_38 = arg_28_0.preferenceBtn
			local var_37_39 = arg_28_0.commonTag

			Ship = var_2_10004

			var_1(var_37_38, var_37_39 == var_2_10004.PREFERENCE_TAG_COMMON)

			local var_37_40 = arg_28_0

			var_1.initIndexPanel(var_37_40)

			arg_28_0.itemDetailType = -1

			if arg_28_0.contextData.mode == var_0_1.MODE_DESTROY then
				arg_28_0.blacklist = {}

				local var_37_41 = arg_28_0.selectPanel
				local var_37_42 = var_1.GetComponent(var_37_41, "HorizontalLayoutGroup").padding

				var_37_42.right = 50
				setActive = var_37_42

				local var_37_43 = arg_28_0.selectPanel

				var_37_42(var_2.Find(var_37_43, "quick_select"), true)

				setActive = var_37_42

				var_37_42(arg_28_0.settingBtn, true)
			else
				local var_37_44 = arg_28_0.selectPanel
				local var_37_45 = var_1.GetComponent(var_37_44, "HorizontalLayoutGroup").padding

				var_37_45.right = 250
				setActive = var_37_45

				local var_37_46 = arg_28_0.selectPanel

				var_37_45(var_2.Find(var_37_46, "quick_select"), false)

				setActive = var_37_45

				var_37_45(arg_28_0.settingBtn, false)
			end

			local var_37_47

			if arg_28_0.contextData.mode == var_0_1.MODE_GUILD_BOSS then
				var_37_47 = arg_28_0
				var_37_47.isShowAssultShips = false
				triggerToggle = var_37_47

				var_37_47(arg_28_0.assultBtn, true)

				var_37_47 = arg_28_0
				GuildShipEquipmentsPage = var_2
				var_37_47.guildShipEquipmentsPage = var_2.New(arg_28_0._tf, arg_28_0.event)

				local var_37_48 = arg_28_0.guildShipEquipmentsPage

				var_37_47.SetCallBack(var_37_48, function()
					local var_42_0 = arg_28_0

					var_0.TriggerCard(var_42_0, -1)

					return
				end, function()
					local var_43_0 = arg_28_0

					var_0.TriggerCard(var_43_0, 1)

					return
				end)
			end

			eachChild = var_37_47

			var_37_47(arg_28_0.attrBtn, function(arg_44_0)
				setActive = var_3_10001

				var_3_10001(arg_44_0, false)

				return
			end)

			arg_28_0.isFormTactics = arg_28_0.contextData.prevPage == "NewNavalTacticsMediator"

			local var_37_49 = arg_28_0.attrBtn
			local var_37_50 = var_1.Find(var_37_49, "off")
			local var_37_51 = var_1.GetComponent(var_37_50, "Image")
			local var_37_52 = arg_28_0.attrBtn
			local var_37_53 = var_2.Find(var_37_52, "on")
			local var_37_54 = var_2.GetComponent(var_37_53, "Image")

			if arg_28_0.isFormTactics then
				GetImageSpriteFromAtlasAsync = var_3

				var_3("ui/dockyardui_atlas", "skill_off", var_37_51)

				GetImageSpriteFromAtlasAsync = var_3

				var_3("ui/dockyardui_atlas", "skill_on", var_37_54)
			else
				GetImageSpriteFromAtlasAsync = var_3

				var_3("ui/dockyardui_atlas", "attr_off", var_37_51)

				GetImageSpriteFromAtlasAsync = var_3

				var_3("ui/dockyardui_atlas", "attr_on", var_37_54)
			end

			triggerButton = var_3

			var_3(arg_28_0.attrBtn)

			if arg_28_0.isRemouldOrUpgradeMode then
				getProxy = var_3
				SettingsProxy = var_4

				local var_37_55 = var_3(var_4)
				local var_37_56 = arg_28_0

				var_2_10006 = var_37_55
				var_37_56.isFilterLevelForMod = var_37_55.GetDockYardLevelBtnFlag(var_2_10006)
				var_2_10005 = arg_28_0

				var_4.OnSwitch(var_2_10005, arg_28_0.modLeveFilter, arg_28_0.isFilterLevelForMod, function(arg_45_0)
					arg_28_0.isFilterLevelForMod = arg_45_0

					local var_45_0 = arg_28_0

					var_1.filter(var_45_0)

					return
				end)

				local var_37_57 = arg_28_0

				var_2_10006 = var_37_55
				var_37_57.isFilterLockForMod = var_37_55.GetDockYardLockBtnFlag(var_2_10006)
				var_2_10005 = arg_28_0

				var_4.OnSwitch(var_2_10005, arg_28_0.modLockFilter, arg_28_0.isFilterLockForMod, function(arg_46_0)
					arg_28_0.isFilterLockForMod = arg_46_0

					local var_46_0 = arg_28_0

					var_1.filter(var_46_0)

					return
				end)
			end

			local var_37_58 = arg_28_0.shipContainer
			local var_37_59 = var_3.GetComponentInChildren

			typeof = var_2_10005
			GridLayoutGroup = var_2_10006
			var_37_59(var_37_58, var_2_10005(var_2_10006)).constraintCount = 7

			local var_37_60 = arg_28_0

			var_3.filter(var_37_60)

			return
		end
	})

	if arg_28_0.isPhantomMode then
		setActive = var_1

		var_1(arg_28_0.listEmptyTF, #arg_28_0.filterBluePrint == 0)
	else
		setActive = var_1

		var_1(arg_28_0.listEmptyTF, #arg_28_0.shipVOs <= 0)
	end

	return
end

function var_0_1.isDefaultStatus(arg_47_0)
	local var_47_0 = arg_47_0.sortIndex

	ShipIndexConst = var_1_10002

	if var_47_0 == var_1_10002.SortLevel then
		if arg_47_0.typeIndex then
			local var_47_1 = arg_47_0.typeIndex

			ShipIndexConst = var_2

			if var_47_1 == var_2.TypeAll then
				if arg_47_0.campIndex then
					local var_47_2 = arg_47_0.campIndex

					ShipIndexConst = var_2

					if var_47_2 == var_2.CampAll then
						if arg_47_0.rarityIndex then
							local var_47_3 = arg_47_0.rarityIndex

							ShipIndexConst = var_2

							if var_47_3 == var_2.RarityAll then
								local var_47_5

								if arg_47_0.extraIndex then
									local var_47_4 = arg_47_0.extraIndex

									ShipIndexConst = var_2

									if var_47_4 ~= var_2.ExtraAll then
										var_47_5 = false

										goto label_47_0
									end
								end

								var_47_5 = true

								::label_47_0::

								return var_47_5
							end
						end
					end
				end
			end
		end
	end
end

function var_0_1.setShipsCount(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0.shipsCount = arg_48_1
	arg_48_0.specialShipCount = arg_48_2

	return
end

function var_0_1.GetCard(arg_49_0, arg_49_1)
	DockyardShipItem = var_1_10002

	return var_1_10002.New(arg_49_1, arg_49_0.contextData.hideTagFlags, arg_49_0.contextData.blockTagFlags)
end

function var_0_1.OnClickCard(arg_50_0, arg_50_1)
	if arg_50_1.shipVO then
		local var_50_1

		if not arg_50_0.selecteEnabled then
			pg = var_50_1

			local var_50_0 = var_50_1.CriMgr.GetInstance()

			var_50_1 = var_50_1.PlaySoundEffect_V3
			SFX_UI_CLICK = var_1_10004

			var_50_1(var_50_0, var_1_10004)

			DockyardScene = var_50_1
			var_50_1.value = arg_50_0.shipContainer.value

			arg_50_0.onClick(arg_50_1.shipVO, arg_50_0.shipVOs)

			goto label_50_0
		end

		pg = var_50_1

		local var_50_2 = var_50_1.CriMgr.GetInstance()

		var_50_1 = var_50_1.PlaySoundEffect_V3
		table = var_1_10004

		if var_1_10004.contains(arg_50_0.selectedIds, arg_50_1.shipVO.id) then
			SFX_UI_CANCEL = var_1_10004

			if not var_1_10004 then
				SFX_UI_FORMATION_SELECT = var_1_10004
			end

			var_50_1(var_50_2, var_1_10004)
			arg_50_0:selectShip(arg_50_1.shipVO)

			if false then
				pg = var_50_1

				local var_50_3 = var_50_1.CriMgr.GetInstance()
				local var_50_4 = var_2.PlaySoundEffect_V3

				SFX_UI_CLICK = var_1_10004

				var_50_4(var_50_3, var_1_10004)

				if arg_50_0.callbackQuit then
					arg_50_0.onSelected({}, function()
						local var_51_0 = arg_50_0

						var_0.back(var_51_0)

						return
					end)
				elseif not arg_50_1.isLoading then
					arg_50_0.onSelected({})
					arg_50_0:back()
				end
			end

			::label_50_0::

			return
		end
	end
end

function var_0_1.OnClickPhantom(arg_52_0, arg_52_1)
	if arg_52_1.phantomId == 0 then
		return
	else
		local var_52_0 = arg_52_0
		local var_52_1 = arg_52_0.emit

		DockyardMediator = var_1_10004

		var_52_1(var_52_0, var_1_10004.CHANGE_SKIN, arg_52_1)
	end

	return
end

function var_0_1.onInitItem(arg_53_0, arg_53_1)
	if arg_53_0.scrollItems[arg_53_1] then
		return arg_53_0.scrollItems[arg_53_1]
	end

	local var_53_0 = arg_53_0:GetCard(arg_53_1)

	var_2.updateDetail(var_53_0, arg_53_0.itemDetailType)

	var_2.isLoading = true
	onButton = var_3

	var_3(arg_53_0, var_2.go, function()
		local var_54_0 = arg_53_0

		var_0.OnClickCard(var_54_0, var_0)

		return
	end)

	GetOrAddComponent = var_3

	local var_53_1 = var_3(var_2.go, "UILongPressTrigger").onLongPressed
	local var_53_2 = arg_53_0.contextData.preView

	NewBackYardShipInfoLayer = var_5

	if var_53_2 == var_5.__cname then
		var_53_1:RemoveAllListeners()
		var_53_1:AddListener(function()
			if var_0.shipVO then
				arg_53_0.contextData.selectedIds = arg_53_0.selectedIds

				local var_55_0 = arg_53_0.onClick
				local var_55_1 = var_0.shipVO

				underscore = var_2_10002

				var_55_0(var_55_1, var_2_10002.select(arg_53_0.shipVOs, function(arg_56_0)
					return arg_56_0
				end), arg_53_0.contextData)
			end

			return
		end)
	else
		var_53_1:RemoveAllListeners()
	end

	arg_53_0.scrollItems[arg_53_1] = var_2

	return var_2
end

function var_0_1.getOrInitPhantom(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.scrollPhantoms
	local var_57_1

	if not arg_57_0.scrollPhantoms[arg_57_1] then
		var_57_1 = {
			isClear = true,
			go = arg_57_1
		}
		tf = var_1_10004
		var_57_1.tf = var_1_10004(arg_57_1)

		function var_57_1.updateSelected(arg_58_0, arg_58_1)
			local var_58_0 = arg_58_0.shipCard

			var_2.updateSelected(var_58_0, arg_58_1[0])

			eachChild = var_2

			local var_58_1 = arg_58_0.tf

			var_2(var_3.Find(var_58_1, "phantoms"), function(arg_59_0, arg_59_1)
				arg_59_1 = arg_59_1 + 1

				local var_59_0 = arg_58_0.phantoms[arg_59_1 + 1]

				setActive = var_3

				var_3(arg_59_0:Find("selected"), var_59_0 and arg_58_1[var_59_0.phantomId])

				return
			end)

			return
		end

		function var_57_1.clear(arg_60_0)
			if arg_60_0.isClear then
				return
			end

			local var_60_0 = arg_60_0.shipCard

			var_1.clear(var_60_0)

			arg_60_0.isClear = true

			return
		end
	end

	var_57_0[arg_57_1] = var_57_1

	return arg_57_0.scrollPhantoms[arg_57_1]
end

function var_0_1.updatePhantomGroup(arg_61_0, arg_61_1, arg_61_2)
	local var_61_0 = arg_61_0:getOrInitPhantom(arg_61_2)

	var_61_0.isClear = false
	arg_61_0.phantomGroupDic[arg_61_1.shipId] = arg_61_2

	local var_61_5

	if not var_61_0.shipCard then
		local var_61_1 = arg_61_0
		local var_61_2 = arg_61_0.GetCard
		local var_61_3 = var_61_0.tf
		local var_61_4 = var_6.Find(var_61_3, "card")

		var_61_5 = var_61_2(var_61_1, var_6.GetChild(var_61_4, 0).gameObject)
	end

	var_61_0.shipCard = var_61_5

	local var_61_6 = arg_61_0.shipVOsById[arg_61_1.shipId]
	local var_61_7 = var_4.getAllShipPhantom(var_61_6)

	assert = var_61_6

	var_61_6(var_61_7[1].phantomId == 0)

	var_61_0.phantoms = var_61_7

	local var_61_8 = var_61_0.shipCard

	var_5.update(var_61_8, var_61_7[1])

	local var_61_9 = var_61_0.shipCard
	local var_61_10 = var_5.updateSelected

	underscore = var_7

	var_61_10(var_61_9, var_7.any(arg_61_0.selectedIds, function(arg_62_0)
		return arg_62_0 == var_61_7[1].id
	end))
	arg_61_0:updateItemBlackBlock(var_61_0.shipCard)

	var_61_0.shipCard.isLoading = false

	local var_61_11 = var_61_0.shipCard

	var_5.updateIntimacyEnergy(var_61_11, false)

	local var_61_12 = var_61_0.shipCard

	var_5.updateIntimacy(var_61_12, false)

	onButton = var_5

	local var_61_13 = arg_61_0
	local var_61_14 = var_61_0.shipCard.tr

	local function var_61_15()
		local var_63_0 = arg_61_0

		var_0.OnClickPhantom(var_63_0, var_61_7[1])

		return
	end

	SFX_UI_CLICK = var_9

	var_5(var_61_13, var_61_14, var_61_15, var_9)

	getGameset = var_5

	local var_61_16 = var_5("technology_shadow_num")[1]
	local var_61_17 = var_61_0.tf
	local var_61_18 = var_6.Find(var_61_17, "phantoms")

	UIItemList = var_61_17

	var_61_17.StaticAlign(var_61_18, var_61_18:GetChild(0), var_61_16, function(arg_64_0, arg_64_1, arg_64_2)
		arg_64_1 = arg_64_1 + 1
		UIItemList = var_2_10003

		if arg_64_0 == var_2_10003.EventUpdate then
			local var_64_0 = var_61_7[arg_64_1 + 1]

			setActive = var_64_6

			local var_64_1 = arg_64_2
			local var_64_2 = arg_64_2.Find(var_64_1, "skin")

			tobool = var_64_1

			var_64_6(var_64_2, var_64_1(var_64_0))

			setActive = var_64_6

			var_64_6(arg_64_2:Find("lock"), not var_64_0)

			local var_64_6

			if var_64_0 then
				GetImageSpriteFromAtlasAsync = var_64_6

				local var_64_3 = "shipYardIcon/" .. var_64_0:getPainting()
				local var_64_4 = ""

				var_2_10008 = arg_64_2

				var_64_6(var_64_3, var_64_4, arg_64_2.Find(var_2_10008, "skin/Image"))

				local var_64_5 = var_64_0

				var_64_6 = var_64_0.getSkinId(var_64_5)
				changeToScrollText = var_64_5

				local var_64_7 = arg_64_2
				local var_64_8 = arg_64_2.Find(var_64_7, "skin/name/Text")

				pg = var_64_7

				var_64_5(var_64_8, var_64_7.ship_skin_template[var_64_6].name)

				setActive = var_64_5

				var_64_5(arg_64_2:Find("skin/status"), false)

				local var_64_9 = var_64_0
				local var_64_10 = var_64_0.GetShipPhantomMark(var_64_9)

				setActive = var_64_9
				var_2_10008 = arg_64_2

				local var_64_11 = arg_64_2.Find(var_2_10008, "selected")

				underscore = var_2_10008
				var_2_10008 = var_2_10008.any

				local var_64_12

				if not arg_61_0.selectedMarks then
					var_64_12 = {}
				end

				var_64_9(var_64_11, var_2_10008(var_64_12, function(arg_65_0)
					return var_64_10 == arg_65_0
				end))

				setActive = var_64_9
				var_2_10008 = arg_64_2

				local var_64_13 = arg_64_2.Find(var_2_10008, "skin/mark/base")

				var_2_10008 = arg_61_0.contextData.mode ~= var_0_1.MODE_SHIP_PHANTOM

				var_64_9(var_64_13, var_2_10008)

				setActive = var_64_9
				var_2_10008 = arg_64_2

				local var_64_14 = arg_64_2.Find(var_2_10008, "skin/mark/toggle")

				var_2_10008 = arg_61_0.contextData.mode == var_0_1.MODE_SHIP_PHANTOM

				var_64_9(var_64_14, var_2_10008)

				local var_64_15 = var_64_0
				local var_64_16 = var_64_0.getRandomFlag(var_64_15)

				onToggle = var_64_15
				var_2_10008 = arg_61_0

				local var_64_17 = arg_64_2:Find("skin/mark/toggle")

				local function var_64_18(arg_66_0)
					if arg_66_0 ~= var_64_16 then
						var_64_16 = arg_66_0

						local var_66_0 = arg_61_0
						local var_66_1 = var_1.emit

						DockyardMediator = var_3_10003

						local var_66_2 = var_3_10003.CHANGE_RANDOM_FLAG
						local var_66_3 = var_64_0

						var_66_1(var_66_0, var_66_2, var_4.GetShipPhantomMark(var_66_3), var_64_16)
					end

					return
				end

				SFX_UI_CLICK = var_11

				var_64_15(var_2_10008, var_64_17, var_64_18, var_11)

				triggerToggle = var_64_15

				var_64_15(arg_64_2:Find("skin/mark/toggle"), var_64_16)
			else
				setActive = var_64_6

				var_64_6(arg_64_2:Find("selected"), false)
			end

			onButton = var_64_6

			local var_64_19 = arg_61_0
			local var_64_20 = arg_64_2

			local function var_64_21()
				if var_64_0 then
					local var_67_0 = arg_61_0

					var_0.OnClickPhantom(var_67_0, var_64_0)
				else
					pg = var_0

					local var_67_1 = var_0.TipsMgr.GetInstance()
					local var_67_2 = var_0.ShowTips

					i18n = var_3_10002

					var_67_2(var_67_1, var_3_10002("shadow_unlock_tip"))
				end

				return
			end

			SFX_UI_CLICK = var_2_10008

			var_64_6(var_64_19, var_64_20, var_64_21, var_2_10008)
		end

		return
	end)

	return
end

function var_0_1.showEnergyDesc(arg_68_0, arg_68_1, arg_68_2)
	LeanTween = var_1_10003

	local var_68_0 = var_1_10003.isTweening

	go = var_1_10004

	local var_68_1

	if var_68_0(var_1_10004(arg_68_0.energyDescTF)) then
		LeanTween = var_68_1
		var_68_1 = var_68_1.cancel
		go = var_4

		var_68_1(var_4(arg_68_0.energyDescTF))

		var_68_1 = arg_68_0.energyDescTF
		Vector3 = var_4
		var_68_1.localScale = var_4.one
	end

	setText = var_68_1

	local var_68_2 = arg_68_0.energyDescTextTF

	i18n = var_5

	var_68_1(var_68_2, var_5(arg_68_2))

	local var_68_3 = arg_68_0.energyDescTF

	var_68_3.position = arg_68_1
	setActive = var_68_3

	var_68_3(arg_68_0.energyDescTF, true)

	LeanTween = var_68_3

	local var_68_4 = var_68_3.scale
	local var_68_5 = arg_68_0.energyDescTF

	Vector3 = var_5

	local var_68_6 = var_68_4(var_68_5, var_5.zero, 0.2)
	local var_68_7 = var_3.setDelay(var_68_6, 1)
	local var_68_8 = var_3.setFrom

	Vector3 = var_5

	local var_68_9 = var_68_8(var_68_7, var_5.one)
	local var_68_10 = var_3.setOnComplete

	System = var_5

	var_68_10(var_68_9, var_5.Action(function()
		local var_69_0 = arg_68_0.energyDescTF

		Vector3 = var_2_10001
		var_69_0.localScale = var_2_10001.one
		setActive = var_69_0

		var_69_0(arg_68_0.energyDescTF, false)

		return
	end))

	return
end

function var_0_1.onUpdateItem(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0

	if not arg_70_0.shipVOs[arg_70_1 + 1] or not var_3.id then
		var_70_0 = 0
	end

	arg_70_0.cardItemDic[var_70_0] = arg_70_2

	local var_70_1 = arg_70_0:onInitItem(arg_70_2)

	var_5.update(var_70_1, var_3)

	local var_70_2 = arg_70_0.contextData.mode

	DockyardScene = var_70_1

	if var_70_2 == var_70_1.MODE_WORLD then
		var_5:updateWorld()
	end

	local var_70_3 = var_5
	local var_70_4 = var_5.updateSelected
	local var_70_5

	if var_5.shipVO then
		underscore = var_70_5
		var_70_5 = var_70_5.any(arg_70_0.selectedIds, function(arg_71_0)
			return var_0.shipVO.id == arg_71_0
		end)
	end

	var_70_4(var_70_3, var_70_5)
	arg_70_0:updateItemBlackBlock(var_5)

	var_5.isLoading = false

	local var_70_6 = var_5
	local var_70_7 = var_5.updateIntimacyEnergy
	local var_70_8

	if not arg_70_0.contextData.energyDisplay then
		var_70_8 = arg_70_0.sortIndex
		ShipIndexConst = var_1_10009
		var_70_8 = var_70_8 == var_1_10009.SortEnergy
	end

	var_70_7(var_70_6, var_70_8)

	local var_70_9 = arg_70_0.sortIndex

	ShipIndexConst = var_70_6

	if var_70_9 ~= var_70_6.SortIntimacy then
		local var_70_10 = arg_70_0.extraIndex

		ShipIndexConst = var_7

		if var_70_10 == var_7.ExtraMarry then
			local var_70_11 = arg_70_0.contextData.mode

			DockyardScene = var_7

			local var_70_12

			if var_70_11 == var_7.MODE_UPGRADE then
				var_70_12 = false
			else
				var_70_12 = true
			end

			var_5:updateIntimacy(var_70_12)

			return
		end
	end
end

function var_0_1.onReturnItem(arg_72_0, arg_72_1, arg_72_2)
	if arg_72_0.exited then
		return
	end

	if arg_72_0.scrollItems[arg_72_2] then
		var_3:clear()
	end

	return
end

function var_0_1.updateIndexDatas(arg_73_0)
	local var_73_0 = arg_73_0.contextData
	local var_73_1

	if not arg_73_0.contextData.indexDatas then
		var_73_1 = {}
	end

	var_73_0.indexDatas = var_73_1
	arg_73_0.contextData.indexDatas.sortIndex = arg_73_0.sortIndex
	arg_73_0.contextData.indexDatas.typeIndex = arg_73_0.typeIndex
	arg_73_0.contextData.indexDatas.campIndex = arg_73_0.campIndex
	arg_73_0.contextData.indexDatas.rarityIndex = arg_73_0.rarityIndex
	arg_73_0.contextData.indexDatas.extraIndex = arg_73_0.extraIndex

	return
end

function var_0_1.initIndexPanel(arg_74_0)
	onButton = var_1_10001

	local var_74_0 = arg_74_0
	local var_74_1 = arg_74_0.indexBtn

	local function var_74_2()
		local var_75_0 = {}

		Clone = var_2_10001
		var_75_0.indexDatas = var_2_10001(arg_74_0.contextData.indexDatas)

		local var_75_1 = {
			minHeight = 650
		}
		local var_75_2 = {
			isSort = true
		}

		CustomIndexLayer = var_2_10003
		var_75_2.mode = var_2_10003.Mode.OR
		ShipIndexConst = var_3
		var_75_2.options = var_3.SortIndexs
		ShipIndexConst = var_3
		var_75_2.names = var_3.SortNames
		var_75_1.sortIndex = var_75_2

		local var_75_3 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_75_3.mode = var_3.Mode.OR
		ShipIndexConst = var_3
		var_75_3.options = var_3.SortPropertyIndexs
		ShipIndexConst = var_3
		var_75_3.names = var_3.SortPropertyNames
		var_75_1.sortPropertyIndex = var_75_3

		local var_75_4 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_75_4.mode = var_3.Mode.AND
		ShipIndexConst = var_3
		var_75_4.options = var_3.TypeIndexs
		ShipIndexConst = var_3
		var_75_4.names = var_3.TypeNames
		var_75_1.typeIndex = var_75_4

		local var_75_5 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_75_5.mode = var_3.Mode.AND
		ShipIndexConst = var_3
		var_75_5.options = var_3.CampIndexs
		ShipIndexConst = var_3
		var_75_5.names = var_3.CampNames
		var_75_1.campIndex = var_75_5

		local var_75_6 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_75_6.mode = var_3.Mode.AND
		ShipIndexConst = var_3
		var_75_6.options = var_3.RarityIndexs
		ShipIndexConst = var_3
		var_75_6.names = var_3.RarityNames
		var_75_1.rarityIndex = var_75_6

		local var_75_7 = {
			blueSeleted = true
		}

		CustomIndexLayer = var_3
		var_75_7.mode = var_3.Mode.OR
		ShipIndexConst = var_3
		var_75_7.options = var_3.ExtraIndexs
		ShipIndexConst = var_3
		var_75_7.names = var_3.ExtraNames
		var_75_1.extraIndex = var_75_7
		Vector2 = var_75_7
		var_75_1.layoutPos = var_75_7(0, -25)
		var_75_0.customPanels = var_75_1
		var_75_0.groupList = {
			{
				titleTxt = "indexsort_sort",
				dropdown = false,
				titleENTxt = "indexsort_sorteng",
				tags = {
					"sortIndex"
				},
				simpleDropdown = {
					"sortPropertyIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_indexeng",
				titleTxt = "indexsort_index",
				tags = {
					"typeIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_campeng",
				titleTxt = "indexsort_camp",
				tags = {
					"campIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_rarityeng",
				titleTxt = "indexsort_rarity",
				tags = {
					"rarityIndex"
				}
			},
			{
				dropdown = false,
				titleENTxt = "indexsort_indexeng",
				titleTxt = "indexsort_extraindex",
				tags = {
					"extraIndex"
				}
			}
		}

		function var_75_0.callback(arg_76_0)
			arg_74_0.sortIndex = arg_76_0.sortIndex
			arg_74_0.typeIndex = arg_76_0.typeIndex
			arg_74_0.campIndex = arg_76_0.campIndex
			arg_74_0.rarityIndex = arg_76_0.rarityIndex
			arg_74_0.extraIndex = arg_76_0.extraIndex

			local var_76_0 = arg_74_0

			var_1.updateIndexDatas(var_76_0)

			local var_76_1 = arg_74_0

			var_1.filter(var_76_1)

			return
		end

		local var_75_8 = arg_74_0
		local var_75_9 = var_1.emit

		DockyardMediator = var_3

		var_75_9(var_75_8, var_3.OPEN_DOCKYARD_INDEX, var_75_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_74_0, var_74_1, var_74_2, var_1_10005)

	onToggle = var_1_10001

	var_1_10001(arg_74_0, arg_74_0.preferenceBtn, function(arg_77_0)
		if arg_77_0 then
			local var_77_0 = arg_74_0

			Ship = var_2_10002
			var_77_0.commonTag = var_2_10002.PREFERENCE_TAG_COMMON
		else
			local var_77_1 = arg_74_0

			Ship = var_2_10002
			var_77_1.commonTag = var_2_10002.PREFERENCE_TAG_NONE
		end

		local var_77_2 = arg_74_0

		var_1.filter(var_77_2)

		return
	end)

	return
end

function var_0_1.setShips(arg_78_0, arg_78_1)
	arg_78_0.shipVOsById = arg_78_1
	getProxy = var_1_10002
	TechnologyProxy = var_1_10003

	local var_78_0 = var_1_10002(var_1_10003)

	arg_78_0.shipBluePrints = {}
	ipairs = var_3

	for iter_78_0, iter_78_1 in var_3(var_78_0:getAllBluePrintShipIds()) do
		getProxy = var_1_10008
		BayProxy = var_1_10009
		var_1_10009 = var_1_10008(var_1_10009)

		local var_78_1 = var_1_10008.getShipById(var_1_10009, iter_78_1)

		if #var_1_10008.getAllShipPhantomMarks(var_78_1) > 1 then
			table = var_1_10009

			var_1_10009.insert(arg_78_0.shipBluePrints, var_78_0:getBluePrintById(var_1_10008.groupId))
		end
	end

	table = var_3

	local var_78_2 = var_3.sort
	local var_78_3 = arg_78_0.shipBluePrints

	CompareFuncs = var_5

	var_78_2(var_78_3, var_5({
		function(arg_79_0)
			return arg_79_0:getConfig("blueprint_version")
		end,
		function(arg_80_0)
			return arg_80_0.id
		end
	}))

	return
end

function var_0_1.setPlayer(arg_81_0, arg_81_1)
	arg_81_0.player = arg_81_1

	arg_81_0:updateBarInfo()

	return
end

function var_0_1.updateBarInfo(arg_82_0)
	setActive = var_1_10001

	var_1_10001(arg_82_0.bottomTipsText, arg_82_0.contextData.leftTopInfo)

	setText = var_1_10001

	local var_82_0 = arg_82_0.bottomTipsText

	if arg_82_0.contextData.leftTopInfo then
		i18n = var_3

		local var_82_1

		if not var_3("dock_yard_left_tips", arg_82_0.contextData.leftTopInfo) then
			var_82_1 = ""
		end

		var_1_10001(var_82_0, var_82_1)

		setActive = var_1_10001

		var_1_10001(arg_82_0.bottomTipsWithFrame, arg_82_0.contextData.leftTopWithFrameInfo)

		setText = var_1_10001

		local var_82_2 = arg_82_0.bottomTipsWithFrame
		local var_82_3 = var_2.Find(var_82_2, "Text")
		local var_82_4

		if not arg_82_0.contextData.leftTopWithFrameInfo then
			var_82_4 = ""
		end

		var_1_10001(var_82_3, var_82_4)

		if arg_82_0.contextData.mode == var_0_1.MODE_WORLD or arg_82_0.contextData.mode == var_0_1.MODE_GUILD_BOSS or arg_82_0.contextData.mode == var_0_1.MODE_REMOULD or arg_82_0.isPhantomMode then
			setActive = var_1

			var_1(arg_82_0.leftTipsText, false)
		else
			setActive = var_1

			var_1(arg_82_0.leftTipsText, true)
			arg_82_0:updateCapacityDisplay()
		end

		return
	end
end

function var_0_1.updateCapacityDisplay(arg_83_0)
	setActive = var_1_10001

	local var_83_0 = arg_83_0.leftTipsText

	var_1_10001(var_2.Find(var_83_0, "plus"), not arg_83_0.isCapacityMeta)

	setActive = var_1_10001

	local var_83_1 = arg_83_0.leftTipsText

	var_1_10001(var_2.Find(var_83_1, "tip"), arg_83_0.isCapacityMeta)

	setActive = var_1_10001

	local var_83_2 = arg_83_0.leftTipsText

	var_1_10001(var_2.Find(var_83_2, "switch/off"), not arg_83_0.isCapacityMeta)

	setActive = var_1_10001

	local var_83_3 = arg_83_0.leftTipsText

	var_1_10001(var_2.Find(var_83_3, "switch/on"), arg_83_0.isCapacityMeta)

	if arg_83_0.isCapacityMeta then
		setText = var_1

		local var_83_4 = arg_83_0.leftTipsText
		local var_83_5 = var_2.Find(var_83_4, "label")

		i18n = var_83_4

		var_1(var_83_5, var_83_4("specialshipyard_name"))

		setText = var_1

		local var_83_6 = arg_83_0.leftTipsText

		var_1(var_2.Find(var_83_6, "Text"), arg_83_0.specialShipCount)
	else
		setText = var_1

		local var_83_7 = arg_83_0.leftTipsText
		local var_83_8 = var_2.Find(var_83_7, "label")

		i18n = var_83_7

		var_1(var_83_8, var_83_7("ship_dockyardScene_capacity"))

		setText = var_1

		local var_83_9 = arg_83_0.leftTipsText
		local var_83_10 = var_2.Find(var_83_9, "Text")
		local var_83_11 = arg_83_0.shipsCount
		local var_83_12 = "/"
		local var_83_13 = arg_83_0.player

		var_1(var_83_10, var_83_11 .. var_83_12 .. var_5.getMaxShipBag(var_83_13))
	end

	return
end

function var_0_1.initWorldPanel(arg_84_0)
	onButton = var_1_10001

	local var_84_0 = arg_84_0
	local var_84_1 = arg_84_0.worldPanel
	local var_84_2 = var_3.Find(var_84_1, "btn_repair")

	local function var_84_3()
		if #arg_84_0.selectedIds > 0 then
			local var_85_0 = arg_84_0

			var_0.repairWorldShip(var_85_0, arg_84_0.shipVOsById[arg_84_0.selectedIds[1]])
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_84_0, var_84_2, var_84_3, var_5)

	onButton = var_1_10001

	local var_84_4 = arg_84_0
	local var_84_5 = arg_84_0.worldPanel
	local var_84_6 = var_3.Find(var_84_5, "btn_repair_all")

	local function var_84_7()
		local var_86_0 = {}
		local var_86_1 = 0

		pairs = var_2_10002

		for iter_86_0, iter_86_1 in var_2_10002(arg_84_0.shipVOsById) do
			WorldConst = var_2_10007

			local var_86_2 = var_2_10007.FetchWorldShip(iter_86_1.id)

			if var_2_10007.IsBroken(var_86_2) or not var_2_10007:IsHpFull() then
				table = var_8

				var_8.insert(var_86_0, var_2_10007.id)

				nowWorld = var_8

				local var_86_3 = var_8()

				var_86_1 = var_86_1 + var_8.CalcRepairCost(var_86_3, var_2_10007)
			end
		end

		local var_86_5

		if #var_86_0 == 0 then
			pg = var_86_5

			local var_86_4 = var_86_5.TipsMgr.GetInstance()

			var_86_5 = var_86_5.ShowTips
			i18n = var_4

			var_86_5(var_86_4, var_4("world_ship_repair_no_need"))
		else
			pg = var_86_5

			local var_86_6 = var_86_5.MsgboxMgr.GetInstance()
			local var_86_7 = var_2.ShowMsgBox
			local var_86_8 = {}

			i18n = iter_86_0
			var_86_8.content = iter_86_0("world_ship_repair_all", var_86_1)

			function var_86_8.onYes()
				local var_87_0 = arg_84_0
				local var_87_1 = var_0.emit

				DockyardMediator = var_3_10002

				var_87_1(var_87_0, var_3_10002.ON_SHIP_REPAIR, var_86_0, var_86_1)

				return
			end

			var_86_7(var_86_6, var_86_8)
		end

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_84_4, var_84_6, var_84_7, var_5)

	return
end

function var_0_1.repairWorldShip(arg_88_0, arg_88_1)
	WorldConst = var_1_10002

	local var_88_0 = var_1_10002.FetchWorldShip(arg_88_1.id)

	nowWorld = var_3

	local var_88_1 = var_3()
	local var_88_2 = var_3.CalcRepairCost(var_88_1, var_88_0)

	if var_88_0:IsBroken() then
		pg = var_4

		local var_88_3 = var_4.MsgboxMgr.GetInstance()
		local var_88_4 = var_4.ShowMsgBox

		var_1_10006 = {}
		i18n = var_1_10007
		var_1_10006.content = var_1_10007("world_ship_repair_2", arg_88_1:getName(), var_88_2)

		function var_1_10006.onYes()
			local var_89_0 = arg_88_0
			local var_89_1 = var_0.emit

			DockyardMediator = var_2_10002

			var_89_1(var_89_0, var_2_10002.ON_SHIP_REPAIR, {
				var_88_0.id
			}, var_88_2)

			return
		end

		var_88_4(var_88_3, var_1_10006)
	else
		local var_88_6

		if not var_88_0:IsHpFull() then
			pg = var_88_6

			local var_88_5 = var_88_6.MsgboxMgr.GetInstance()

			var_88_6 = var_88_6.ShowMsgBox
			var_1_10006 = {}
			i18n = var_1_10007
			var_1_10006.content = var_1_10007("world_ship_repair_1", arg_88_1:getName(), var_88_2)

			function var_1_10006.onYes()
				local var_90_0 = arg_88_0
				local var_90_1 = var_0.emit

				DockyardMediator = var_2_10002

				var_90_1(var_90_0, var_2_10002.ON_SHIP_REPAIR, {
					var_88_0.id
				}, var_88_2)

				return
			end

			var_88_6(var_88_5, var_1_10006)
		else
			pg = var_88_6

			local var_88_7 = var_88_6.TipsMgr.GetInstance()
			local var_88_8 = var_4.ShowTips

			i18n = var_1_10006

			var_88_8(var_88_7, var_1_10006("world_ship_repair_no_need"))
		end
	end

	return
end

function var_0_1.filter(arg_91_0)
	local var_91_0 = arg_91_0
	local var_91_1 = arg_91_0.isDefaultStatus(var_91_0) and "shaixuan_off" or "shaixuan_on"

	LoadImageSpriteAtlasAsync = var_91_0

	var_91_0("ui/dockyardui_atlas", var_91_1, arg_91_0.indexBtn, true)

	if arg_91_0.isRemouldOrUpgradeMode then
		arg_91_0:filterForRemouldAndUpgrade()
	else
		arg_91_0:filterCommon()
	end

	local var_91_2 = 0

	if arg_91_0.contextData.quitTeam then
		var_91_2 = var_91_2 + 1
		table = var_3

		var_3.insert(arg_91_0.shipVOs, var_91_2, false)
	end

	if arg_91_0.contextData.priorEquipUpShipIDList then
		local var_91_3 = {}

		ipairs = var_4

		for iter_91_0, iter_91_1 in var_4(arg_91_0.contextData.priorEquipUpShipIDList) do
			var_91_3[iter_91_1] = true
		end

		for iter_91_2 = #arg_91_0.shipVOs, 1, -1 do
			type = iter_91_1
			iter_91_1 = iter_91_1(arg_91_0.shipVOs[iter_91_2]) == "table" and arg_91_0.shipVOs[iter_91_2].id

			if var_91_3[iter_91_1] then
				table = var_9
				var_91_3[iter_91_1] = var_9.remove(arg_91_0.shipVOs, iter_91_2)
			end
		end

		ipairs = var_4

		for iter_91_3, iter_91_4 in var_4(arg_91_0.contextData.priorEquipUpShipIDList) do
			local var_91_4 = var_91_3[iter_91_4]

			type = var_1_10010

			if var_1_10010(var_91_4) == "table" then
				var_91_2 = var_91_2 + 1
				table = var_1_10010

				var_1_10010.insert(arg_91_0.shipVOs, var_91_2, var_91_4)
			end
		end
	end

	if var_0_1.MODE_OVERVIEW == arg_91_0.contextData.mode then
		DockyardScene = var_3

		if var_3.value then
			local var_91_5 = arg_91_0
			local var_91_6 = arg_91_0.updateShipCount

			DockyardScene = var_5

			local var_91_7

			if not var_5.value then
				var_91_7 = 0
			end

			var_91_6(var_91_5, var_91_7)

			DockyardScene = var_91_6
			var_91_6.value = nil

			goto label_91_0
		end
	end

	arg_91_0:updateShipCount(0)

	::label_91_0::

	return
end

function var_0_1.filterForRemouldAndUpgrade(arg_92_0)
	arg_92_0.shipVOs = {}

	local var_92_0 = arg_92_0.isFilterLockForMod
	local var_92_1 = arg_92_0.isFilterLevelForMod

	local function var_92_2(arg_93_0)
		local var_93_0 = true

		if not var_92_0 then
			local var_93_1 = arg_93_0.lockState

			Ship = var_2_10003

			if var_93_1 == var_2_10003.LOCK_STATE_LOCK then
				var_93_0 = false
			end
		end

		if not var_92_1 and arg_93_0.level > 1 then
			var_93_0 = false
		end

		return var_93_0
	end

	pairs = var_1_10004

	for iter_92_0, iter_92_1 in var_1_10004(arg_92_0.shipVOsById) do
		if var_92_2(iter_92_1) then
			table = var_9

			var_9.insert(arg_92_0.shipVOs, iter_92_1)
		end
	end

	table = var_4

	local var_92_3 = var_4.sort
	local var_92_4 = arg_92_0.shipVOs

	CompareFuncs = var_6

	var_92_3(var_92_4, var_6({
		function(arg_94_0)
			return arg_94_0.level
		end,
		function(arg_95_0)
			return arg_95_0:isTestShip() and 1 or 0
		end
	}))

	return
end

function var_0_1.filterCommon(arg_96_0)
	arg_96_0.shipVOs = {}

	local var_96_0 = arg_96_0.sortIndex

	local function var_96_1(arg_97_0)
		if arg_96_0.contextData.mode ~= var_0_1.MODE_GUILD_BOSS then
			return true
		end

		if arg_96_0.isShowAssultShips then
			return true
		end

		if not arg_97_0.user then
			return true
		end

		if arg_97_0.user.id == arg_96_0.player.id then
			return true
		end

		return false
	end

	pairs = var_1_10003

	for iter_96_0, iter_96_1 in var_1_10003(arg_96_0.shipVOsById) do
		if arg_96_0.contextData.blockLock then
			var_1_10009 = iter_96_1

			local var_96_2 = iter_96_1.GetLockState(var_1_10009)

			Ship = var_1_10009

			if var_96_2 == var_1_10009.LOCK_STATE_LOCK then
				goto label_96_0
			end
		end

		if arg_96_0.teamTypeFilter then
			var_1_10009 = iter_96_1

			if iter_96_1.getTeamType(var_1_10009) ~= arg_96_0.teamTypeFilter then
				goto label_96_0
			end
		end

		ShipIndexConst = var_8

		if var_8.filterByType(iter_96_1, arg_96_0.typeIndex) then
			ShipIndexConst = var_8

			if var_8.filterByCamp(iter_96_1, arg_96_0.campIndex) then
				ShipIndexConst = var_8

				if var_8.filterByRarity(iter_96_1, arg_96_0.rarityIndex) then
					ShipIndexConst = var_8

					if var_8.filterByExtra(iter_96_1, arg_96_0.extraIndex) then
						local var_96_3 = arg_96_0.commonTag

						Ship = var_1_10009

						if (var_96_3 == var_1_10009.PREFERENCE_TAG_NONE or arg_96_0.commonTag == iter_96_1:GetPreferenceTag()) and var_96_1(iter_96_1) then
							table = var_8

							var_8.insert(arg_96_0.shipVOs, iter_96_1)
						end
					end
				end
			end
		end

		::label_96_0::
	end

	local var_96_4 = arg_96_0.searchBar

	if var_3.GetInputText(var_96_4) and var_3 ~= "" then
		underscore = var_96_4
		arg_96_0.shipVOs = var_96_4.filter(arg_96_0.shipVOs, function(arg_98_0)
			return arg_98_0:IsMatchKey(var_0)
		end)
	end

	ShipIndexConst = var_96_4

	local var_96_5, var_96_6 = var_96_4.getSortFuncAndName(var_96_0, arg_96_0.selectAsc)

	ShipIndexConst = var_6

	if var_96_0 ~= var_6.SortIntimacy and true or false then
		defaultValue = iter_96_1

		local var_96_7

		if not arg_96_0.contextData.hideTagFlags then
			var_96_7 = {}
		end

		local var_96_8 = var_96_7.inFleet

		ShipStatus = var_1_10009

		if not iter_96_1(var_96_8, var_1_10009.TAG_HIDE_BASE.inFleet) then
			table = var_7

			var_7.insert(var_96_5, 1, function(arg_99_0)
				return arg_99_0:getFlag("inFleet") and 0 or 1
			end)
		end
	end

	if var_96_5 then
		arg_96_0:SortShips(var_96_5)
	end

	arg_96_0:updateSelected()

	setActive = var_7

	var_7(arg_96_0.sortImgAsc, arg_96_0.selectAsc)

	setActive = var_7

	var_7(arg_96_0.sortImgDesc, not arg_96_0.selectAsc)

	setText = var_7

	local var_96_9 = arg_96_0.sortBtn
	local var_96_10 = var_8.Find(var_96_9, "Image")

	i18n = var_96_9

	var_7(var_96_10, var_96_9(var_96_6))

	return
end

function var_0_1.SortShips(arg_100_0, arg_100_1)
	pg = var_1_10002

	local var_100_0 = var_1_10002.NewGuideMgr.GetInstance()
	local var_100_1

	if var_2.IsBusy(var_100_0) then
		var_100_1 = {
			101171,
			201211,
			401231,
			301051
		}
		arg_100_1 = {
			function(arg_101_0)
				table = var_2_10001

				return var_2_10001.contains(var_100_1, arg_101_0.configId) and 0 or 1
			end
		}
	elseif arg_100_0.isFormTactics then
		table = var_100_1

		var_100_1.insert(arg_100_1, 1, function(arg_102_0)
			local var_102_0 = arg_102_0
			local var_102_1 = arg_102_0.getNation(var_102_0)

			Nation = var_102_0

			return var_102_1 == var_102_0.META and 1 or 0
		end)

		table = var_100_1

		var_100_1.insert(arg_100_1, 1, function(arg_103_0)
			return arg_103_0:isFullSkillLevel() and 1 or 0
		end)
	elseif arg_100_0.contextData.mode == var_0_1.MODE_OVERVIEW or arg_100_0.contextData.mode == var_0_1.MODE_SELECT then
		table = var_100_1

		var_100_1.insert(arg_100_1, 1, function(arg_104_0)
			return -arg_104_0.activityNpc
		end)
	elseif arg_100_0.contextData.mode == var_0_1.MODE_GUILD_BOSS then
		table = var_100_1

		var_100_1.insert(arg_100_1, 1, function(arg_105_0)
			return arg_105_0.guildRecommand and 0 or 1
		end)
	end

	table = var_100_1

	local var_100_2 = var_100_1.sort
	local var_100_3 = arg_100_0.shipVOs

	CompareFuncs = var_1_10004

	var_100_2(var_100_3, var_1_10004(arg_100_1))

	return
end

function var_0_1.UpdateGuildViewEquipmentsBtn(arg_106_0)
	setActive = var_1_10001

	var_1_10001(arg_106_0.viewEquipmentBtn, arg_106_0.contextData.mode == var_0_1.MODE_GUILD_BOSS and #arg_106_0.selectedIds > 0)

	return
end

function var_0_1.GetSelectCount(arg_107_0)
	return #arg_107_0.selectedIds
end

function var_0_1.GetConfirmSelect(arg_108_0)
	return arg_108_0.selectedIds
end

function var_0_1.didEnter(arg_109_0)
	if arg_109_0:isLayer() then
		arg_109_0:OverlayPanel(arg_109_0._tf, {
			groupDelta = -1
		})
	end

	arg_109_0:OverlayPanel(arg_109_0.blurPanel)
	arg_109_0:PlayUIAnimation(arg_109_0.blurPanel, "enter")

	setActive = var_1

	local var_109_0 = arg_109_0.stampBtn

	getProxy = var_3
	TaskProxy = var_4

	local var_109_1 = var_3(var_4)
	local var_109_2

	if var_3.mingshiTouchFlagEnabled(var_109_1) then
		var_109_2 = arg_109_0.contextData.mode ~= var_0_1.MODE_GUILD_BOSS
	end

	var_1(var_109_0, var_109_2)
	arg_109_0:UpdateGuildViewEquipmentsBtn()

	onButton = var_1

	local var_109_3 = arg_109_0
	local var_109_4 = arg_109_0.stampBtn

	local function var_109_5()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_110_0 = var_2_10000(var_2_10001)

		var_0.dealMingshiTouchFlag(var_110_0, 1)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_109_3, var_109_4, var_109_5, var_1_10005)

	onButton = var_1

	local var_109_6 = arg_109_0
	local var_109_7 = arg_109_0.topPanel
	local var_109_8 = var_3.Find(var_109_7, "back")

	local function var_109_9()
		local var_111_0 = arg_109_0

		var_0.back(var_111_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_109_6, var_109_8, var_109_9, var_5)

	onButton = var_1

	local var_109_10 = arg_109_0
	local var_109_11 = arg_109_0.sortBtn

	local function var_109_12()
		arg_109_0.selectAsc = not arg_109_0.selectAsc

		local var_112_0 = arg_109_0

		var_0.filter(var_112_0)

		return
	end

	SFX_UI_CLICK = var_5

	var_1(var_109_10, var_109_11, var_109_12, var_5)

	onToggle = var_1

	local var_109_13 = arg_109_0
	local var_109_14 = arg_109_0.assultBtn

	local function var_109_15(arg_113_0)
		arg_109_0.isShowAssultShips = arg_113_0

		local var_113_0 = arg_109_0

		var_1.filter(var_113_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_109_13, var_109_14, var_109_15, var_5)

	onButton = var_1

	local var_109_16 = arg_109_0
	local var_109_17 = arg_109_0.viewEquipmentBtn

	local function var_109_18()
		if not arg_109_0.selectedIds[#arg_109_0.selectedIds] then
			return
		end

		local var_114_0 = arg_109_0.shipVOsById[var_0].user
		local var_114_1 = arg_109_0.guildShipEquipmentsPage

		var_3.ExecuteAction(var_114_1, "Show", var_1, var_114_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_109_16, var_109_17, var_109_18, var_5)

	onButton = var_1

	local var_109_19 = arg_109_0
	local var_109_20 = arg_109_0.attrBtn

	local function var_109_21()
		local var_115_0

		if not arg_109_0.isFormTactics then
			var_115_0 = arg_109_0
			var_115_0.itemDetailType = (arg_109_0.itemDetailType + 1) % 4

			goto label_115_0
		end

		var_115_0 = arg_109_0

		local var_115_1 = arg_109_0.itemDetailType

		DockyardShipItem = var_2_10002

		if var_115_1 == var_2_10002.DetailType0 then
			DockyardShipItem = var_115_1

			if not var_115_1.DetailType3 then
				DockyardShipItem = var_115_1
				var_115_1 = var_115_1.DetailType0
			end

			var_115_0.itemDetailType = var_115_1

			::label_115_0::

			setActive = var_115_0

			local var_115_2 = arg_109_0.attrBtn
			local var_115_3 = var_1.Find(var_115_2, "off")
			local var_115_4 = arg_109_0.itemDetailType

			DockyardShipItem = var_3

			var_115_0(var_115_3, var_115_4 == var_3.DetailType0)

			setActive = var_115_0

			local var_115_5 = arg_109_0.attrBtn
			local var_115_6 = var_1.Find(var_115_5, "on")
			local var_115_7 = arg_109_0.itemDetailType

			DockyardShipItem = var_3

			var_115_0(var_115_6, var_115_7 ~= var_3.DetailType0)

			local var_115_8 = arg_109_0.attrBtn
			local var_115_9 = var_0.GetComponent(var_115_8, "Button")
			local var_115_10 = arg_109_0.itemDetailType

			DockyardShipItem = var_2

			if var_115_10 == var_2.DetailType0 then
				imageOff = var_115_10

				if not var_115_10 then
					imageOn = var_115_10
				end

				var_115_9.targetGraphic = var_115_10

				local var_115_11 = arg_109_0

				var_0.updateItemDetailType(var_115_11)

				return
			end
		end
	end

	SFX_PANEL = var_5

	var_1(var_109_19, var_109_20, var_109_21, var_5)

	onButton = var_1

	local var_109_22 = arg_109_0
	local var_109_23 = arg_109_0.selectPanel
	local var_109_24 = var_3.Find(var_109_23, "cancel_button")

	local function var_109_25()
		if arg_109_0.animating then
			return
		end

		if arg_109_0.contextData.mode == var_0_1.MODE_DESTROY then
			if #arg_109_0.selectedIds > 0 then
				local var_116_0 = arg_109_0

				var_0.unselecteAllShips(var_116_0)

				local var_116_1 = arg_109_0

				var_0.back(var_116_1)
			else
				local var_116_2 = arg_109_0

				var_0.back(var_116_2)
			end
		else
			local var_116_3 = arg_109_0

			var_0.back(var_116_3)

			return
		end

		return
	end

	SFX_CANCEL = var_5

	var_1(var_109_22, var_109_24, var_109_25, var_5)

	onButton = var_1

	local var_109_26 = arg_109_0
	local var_109_27 = arg_109_0.selectPanel
	local var_109_28 = var_3.Find(var_109_27, "confirm_button")

	local function var_109_29()
		if arg_109_0.animating then
			return
		end

		if arg_109_0.contextData.mode == var_0_1.MODE_DESTROY then
			local var_117_0 = arg_109_0
			local var_117_1, var_117_2 = var_0.checkDestroyGold(var_117_0)

			if not var_117_1 or not var_117_2 then
				if not var_117_1 then
					pg = var_2_10002

					local var_117_3 = var_2_10002.TipsMgr.GetInstance()

					var_2_10002 = var_2_10002.ShowTips
					i18n = var_2_10004
					var_2_10004 = var_2_10004("gold_max_tip_title")
					i18n = var_5

					var_2_10002(var_117_3, var_2_10004 .. var_5("resource_max_tip_retire"))
				elseif not var_117_1 then
					pg = var_2_10002

					local var_117_4 = var_2_10002.TipsMgr.GetInstance()

					var_2_10002 = var_2_10002.ShowTips
					i18n = var_2_10004

					local var_117_5 = var_2_10004("oil_max_tip_title")

					i18n = var_5

					var_2_10002(var_117_4, var_117_5 .. var_5("resource_max_tip_retire"))
				end

				return
			end
		end

		local var_117_6 = arg_109_0

		if var_0.GetSelectCount(var_117_6) < arg_109_0.selectedMin then
			if arg_109_0.leastLimitMsg then
				pg = var_0

				local var_117_7 = var_0.TipsMgr.GetInstance()

				var_0.ShowTips(var_117_7, arg_109_0.leastLimitMsg)
			else
				pg = var_0

				local var_117_8 = var_0.TipsMgr.GetInstance()
				local var_117_9 = var_0.ShowTips

				i18n = var_2_10002

				var_117_9(var_117_8, var_2_10002("ship_dockyardScene_error_choiseRoleMore", arg_109_0.selectedMin))
			end

			return
		end

		if arg_109_0.contextData.mode == var_0_1.MODE_DESTROY then
			local var_117_10 = arg_109_0

			var_0.displayDestroyPanel(var_117_10)
		else
			local var_117_11 = {}

			if arg_109_0.contextData.destroyCheck then
				underscore = var_1

				local var_117_12 = var_1.map(arg_109_0.selectedIds, function(arg_118_0)
					return arg_109_0.shipVOsById[arg_118_0]
				end)

				table = var_2

				var_2.insert(var_117_11, function(arg_119_0)
					local var_119_0 = arg_109_0

					var_1.checkDestroyShips(var_119_0, var_117_12, arg_119_0)

					return
				end)
			end

			local var_117_13 = arg_109_0
			local var_117_14 = var_1.GetConfirmSelect(var_117_13)

			if arg_109_0.confirmSelect then
				table = var_2

				var_2.insert(var_117_11, function(arg_120_0)
					arg_109_0.confirmSelect(var_117_14, function()
						arg_120_0(true)

						return
					end, arg_120_0)

					return
				end)

				seriesAsync = var_2

				var_2(var_117_11, function(arg_122_0)
					if arg_122_0 then
						arg_109_0.onSelected(var_117_14)
					end

					local var_122_0 = arg_109_0

					var_1.back(var_122_0)

					return
				end)
			else
				table = var_2

				var_2.insert(var_117_11, function(arg_123_0)
					if arg_109_0.callbackQuit then
						arg_109_0.onSelected(var_117_14, arg_123_0)
					else
						arg_109_0.onSelected(var_117_14)
						arg_123_0()
					end

					return
				end)

				seriesAsync = var_2

				var_2(var_117_11, function()
					local var_124_0 = arg_109_0

					var_0.back(var_124_0)

					return
				end)
			end
		end

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_109_26, var_109_28, var_109_29, var_5)

	onButton = var_1

	local var_109_30 = arg_109_0
	local var_109_31 = arg_109_0.selectPanel
	local var_109_32 = var_3.Find(var_109_31, "quick_select")

	local function var_109_33()
		if arg_109_0.animating then
			return
		end

		local var_125_0 = {}

		PlayerPrefs = var_2_10001
		var_125_0[1] = var_2_10001.GetInt("QuickSelectRarity1", 3)
		PlayerPrefs = var_1
		var_125_0[2] = var_1.GetInt("QuickSelectRarity2", 4)
		PlayerPrefs = var_1
		var_125_0[3] = var_1.GetInt("QuickSelectRarity3", 2)

		local var_125_1 = 3
		local var_125_2 = {}

		pairs = var_3

		for iter_125_0, iter_125_1 in var_3(var_125_0) do
			if iter_125_1 ~= 0 then
				local var_125_3

				if not var_125_2[iter_125_1] then
					var_125_3 = var_125_1
				end

				var_125_2[iter_125_1] = var_125_3
				var_125_1 = var_125_1 - 1
			end
		end

		getProxy = var_3
		BayProxy = var_4

		local var_125_4 = var_3(var_4)
		local var_125_5 = var_3.getShips(var_125_4)
		local var_125_6 = {}
		local var_125_7 = {}

		pairs = iter_125_0

		for iter_125_2, iter_125_3 in iter_125_0(var_125_5) do
			if iter_125_3:isMaxStar() then
				var_125_6[iter_125_3:getGroupId()] = true
			else
				local var_125_8 = iter_125_3:getMaxStar() - iter_125_3:getStar() + 1
				local var_125_9 = iter_125_3
				local var_125_10 = iter_125_3.GetLockState(var_125_9)

				Ship = var_125_9

				if var_125_10 == var_125_9.LOCK_STATE_UNLOCK then
					var_125_8 = var_125_8 + 1
				end

				local var_125_11 = var_125_7[iter_125_3:getGroupId()]

				var_125_7[iter_125_3:getGroupId()] = var_125_11 and var_125_11 < var_125_8 and var_125_11 or var_125_8
			end
		end

		_ = var_6

		local var_125_12 = var_6.select(arg_109_0.shipVOs, function(arg_126_0)
			if arg_126_0.configId ~= 100001 and arg_126_0.configId ~= 100011 then
				local var_126_0 = arg_126_0
				local var_126_1 = arg_126_0.GetLockState(var_126_0)

				Ship = var_126_0

				if var_126_1 == var_126_0.LOCK_STATE_UNLOCK then
					table = var_126_1

					if var_126_1.contains(var_125_0, arg_126_0:getRarity()) then
						if arg_126_0.level == 1 and not arg_109_0.blacklist[arg_126_0:getGroupId()] then
							table = var_126_1

							if not var_126_1.contains(arg_109_0.selectedIds, arg_126_0.id) then
								var_126_1 = not arg_126_0:hasAnyFlag({
									"inFleet",
									"inChapter",
									"inWorld",
									"inEvent",
									"inBackyard",
									"inClass",
									"inTactics",
									"inExercise",
									"inAdmiral",
									"inElite",
									"inActivity",
									"inGuildEvent",
									"inGuildBossEvent"
								})

								goto label_126_0
							end
						end

						var_126_1 = false

						if false then
							var_126_1 = true
						end
					end

					::label_126_0::

					return var_126_1
				end
			end
		end)

		_ = var_7

		if not var_7.all(var_125_12, function(arg_127_0)
			return arg_109_0.blacklist[arg_127_0:getGroupId()]
		end) then
			_ = var_7
			var_125_12 = var_7.select(var_125_12, function(arg_128_0)
				return not arg_109_0.blacklist[arg_128_0:getGroupId()]
			end)
		elseif #arg_109_0.selectedIds > 0 then
			var_125_12 = {}
		end

		table = var_7

		var_7.sort(var_125_12, function(arg_129_0, arg_129_1)
			local var_129_0

			if not var_125_2[arg_129_0:getRarity()] then
				var_129_0 = 0
			end

			local var_129_1

			if not var_125_2[arg_129_1:getRarity()] then
				var_129_1 = 0
			end

			if var_129_0 == var_129_1 then
				if arg_129_0:getGroupId() == arg_129_1:getGroupId() then
					return arg_129_0.createTime > arg_129_1.createTime
				end

				return arg_129_0.configId > arg_129_1.configId
			else
				return var_129_1 < var_129_0
			end

			return
		end)

		PlayerPrefs = var_7

		local var_125_13 = var_7.GetString("QuickSelectWhenHasAtLeastOneMaxstar", "KeepNone")

		PlayerPrefs = var_8

		local var_125_14 = var_8.GetString("QuickSelectWithoutMaxstar", "KeepAll")
		local var_125_15 = {}

		_ = var_10

		local var_125_16 = var_10.select(var_125_12, function(arg_130_0)
			if var_125_6[arg_130_0:getGroupId()] then
				if var_125_13 == "KeepNone" then
					return true
				elseif var_125_13 == "KeepOne" then
					if not var_125_15[arg_130_0:getGroupId()] then
						var_125_15[arg_130_0:getGroupId()] = true

						return false
					end

					return true
				elseif var_125_13 == "KeepAll" then
					return false
				end
			elseif var_125_14 == "KeepNone" then
				return true
			elseif var_125_14 == "KeepNeeded" then
				if var_125_7[arg_130_0:getGroupId()] > 0 then
					var_125_7[arg_130_0:getGroupId()] = var_125_7[arg_130_0:getGroupId()] - 1

					return false
				end

				return true
			elseif var_125_14 == "KeepAll" then
				return false
			end

			return
		end)
		local var_125_17 = 0
		local var_125_18 = false
		local var_125_19 = false
		local var_125_20 = 0
		local var_125_21 = 0

		ipairs = var_2_10015

		for iter_125_4, iter_125_5 in var_2_10015(arg_109_0.selectedIds) do
			local var_125_22 = arg_109_0.shipVOsById[iter_125_5]
			local var_125_23, var_125_24 = var_20.calReturnRes(var_125_22)

			var_125_20 = var_125_20 + var_125_23
			var_125_21 = var_125_21 + var_125_24
		end

		ipairs = var_15

		for iter_125_6, iter_125_7 in var_15(var_125_16) do
			if arg_109_0.selectedMax > 0 then
				local var_125_25 = arg_109_0.selectedMax
				local var_125_26 = arg_109_0

				if var_125_25 <= var_21.GetSelectCount(var_125_26) then
					break
				end
			end

			local var_125_27, var_125_28 = iter_125_7:calReturnRes()

			var_125_20 = var_125_20 + var_125_27
			var_125_21 = var_125_21 + var_125_28

			local var_125_29 = arg_109_0.player

			var_125_18 = var_22.OilMax(var_125_29, var_125_21)

			local var_125_30 = arg_109_0.player

			if var_22.GoldMax(var_125_30, var_125_20) then
				break
			end

			var_125_17 = var_125_17 + 1

			local var_125_31 = arg_109_0

			var_22.selectShip(var_125_31, iter_125_7)
		end

		local var_125_33

		if var_125_17 == 0 then
			local var_125_34

			if var_125_19 then
				if #arg_109_0.selectedIds == 0 then
					pg = var_125_33

					local var_125_32 = var_125_33.TipsMgr.GetInstance()

					var_125_33 = var_125_33.ShowTips
					i18n = var_125_34
					var_125_34 = var_125_34("gold_max_tip_title")
					i18n = iter_125_6

					var_125_33(var_125_32, var_125_34 .. iter_125_6("resource_max_tip_retire"))
				else
					pg = var_125_33

					local var_125_35 = var_125_33.TipsMgr.GetInstance()

					var_125_33 = var_125_33.ShowTips
					i18n = var_125_34

					var_125_33(var_125_35, var_125_34("gold_max_tip_title"))
				end
			elseif #arg_109_0.selectedIds > 0 then
				local var_125_36 = arg_109_0

				var_125_33.displayDestroyPanel(var_125_36)
			else
				pg = var_125_33

				local var_125_37 = var_125_33.TipsMgr.GetInstance()

				var_125_33 = var_125_33.ShowTips
				i18n = var_125_34

				var_125_33(var_125_37, var_125_34("retire_selectzero"))
			end
		elseif var_125_18 then
			pg = var_125_33

			local var_125_38 = var_125_33.MsgboxMgr.GetInstance()
			local var_125_39 = var_15.ShowMsgBox
			local var_125_40 = {}

			i18n = iter_125_6

			local var_125_41 = iter_125_6("oil_max_tip_title")

			i18n = var_19
			var_125_40.content = var_125_41 .. var_19("resource_max_tip_retire_1")

			function var_125_40.onYes()
				local var_131_0 = arg_109_0

				var_0.displayDestroyPanel(var_131_0)

				return
			end

			var_125_39(var_125_38, var_125_40)
		else
			local var_125_42 = arg_109_0

			var_15.displayDestroyPanel(var_125_42)
		end

		return
	end

	SFX_CONFIRM = var_5

	var_1(var_109_30, var_109_32, var_109_33, var_5)

	isActive = var_1

	if var_1(arg_109_0.togglePhantom) then
		triggerToggle = var_1

		local var_109_34 = arg_109_0.togglePhantom

		tobool = var_109_32

		var_1(var_109_34, var_109_32(arg_109_0.inPhantom))
	else
		arg_109_0:SwitchContainerDisplay()
	end

	arg_109_0:updateBarInfo()

	if arg_109_0.contextData.mode == var_0_1.MODE_WORLD then
		arg_109_0:initWorldPanel()
	elseif arg_109_0.contextData.mode == var_0_1.MODE_DESTROY then
		LOCK_DESTROY_GUIDE = var_1

		if not var_1 then
			pg = var_1

			local var_109_35 = var_1.SystemGuideMgr.GetInstance()

			var_1.Play(var_109_35, arg_109_0)
		end
	end

	setAnchoredPosition = var_1

	var_1(arg_109_0.topPanel, {
		y = arg_109_0.topPanel.rect.height
	})

	setAnchoredPosition = var_1

	var_1(arg_109_0.selectPanel, {
		y = -1 * arg_109_0.selectPanel.rect.height
	})

	onNextTick = var_1

	var_1(function()
		if arg_109_0.exited then
			return
		end

		local var_132_0 = arg_109_0

		var_0.uiStartAnimating(var_132_0)

		return
	end)

	AprilFoolBulinSubView = var_1
	arg_109_0.bulinTip = var_1.ShowAprilFoolBulin(arg_109_0)
	onButton = var_1

	var_1(arg_109_0, arg_109_0.settingBtn, function()
		local var_133_0 = arg_109_0.settingPanel

		var_0.Load(var_133_0)

		local var_133_1 = arg_109_0.settingPanel

		var_0.ActionInvoke(var_133_1, "Show")

		return
	end)

	pg = var_1

	local var_109_36 = var_1.SystemGuideMgr.GetInstance()

	var_1.Play(var_109_36, arg_109_0)

	return
end

function var_0_1.TriggerCard(arg_134_0, arg_134_1)
	if not arg_134_0.selectedIds[1] then
		return
	end

	local var_134_0

	ipairs = var_1_10004

	for iter_134_0, iter_134_1 in var_1_10004(arg_134_0.shipVOs) do
		if iter_134_1 and iter_134_1.id == var_2 then
			var_134_0 = iter_134_0

			break
		end
	end

	if not var_134_0 then
		return
	end

	local var_134_1 = var_134_0
	local var_134_2

	if not (function()
		var_134_1 = var_134_1 + arg_134_1

		if not arg_134_0.shipVOs[var_134_1] or arg_134_0.checkShip(var_0) then
			return var_0
		else
			return var_0()
		end

		return
	end)() then
		return
	end

	local function var_134_3()
		local var_136_0

		pairs = var_2_10001

		for iter_136_0, iter_136_1 in var_2_10001(arg_134_0.scrollItems) do
			if iter_136_1.shipVO and iter_136_1.go.name ~= "-1" and iter_136_1.shipVO.id == var_0.id then
				var_136_0 = iter_136_1

				break
			end
		end

		return var_136_0
	end

	if arg_134_0.cardItemDic[var_2] and arg_134_0.scrollItems[var_8] and var_9.shipVO.id == var_6.id and var_9 or nil then
		getBounds = var_1_10011

		local var_134_4 = arg_134_0._tf

		var_1_10011 = var_1_10011(var_12.Find(var_134_4, "main/ship_container"))
		getBounds = var_12

		local var_134_5 = var_12(var_134_19.tr)

		if not var_1_10011:Intersects(var_134_5) then
			local var_134_6 = arg_134_0.shipContainer
			local var_134_7 = var_14.HeadIndexToValue(var_134_6, 7)
			local var_134_8 = arg_134_0.shipContainer
			local var_134_9 = arg_134_1 * (var_134_7 - var_15.HeadIndexToValue(var_134_8, 1))
			local var_134_10 = arg_134_0.shipContainer.value + var_134_9
			local var_134_11 = arg_134_0.shipContainer

			var_17.SetNormalizedPosition(var_134_11, var_134_10, 1)
		end
	end

	local var_134_19

	if not var_134_19 then
		math = var_1_10011
		var_1_10011 = var_1_10011.ceil(var_134_1 / 7)
		math = var_12

		local var_134_12 = var_1_10011 - var_12.ceil(var_134_0 / 7)
		local var_134_13 = arg_134_0.shipContainer
		local var_134_14 = var_14.HeadIndexToValue(var_134_13, 21)
		local var_134_15 = arg_134_0.shipContainer
		local var_134_16 = var_134_12 * (var_134_14 - var_15.HeadIndexToValue(var_134_15, 1))
		local var_134_17 = arg_134_0.shipContainer.value + var_134_16
		local var_134_18 = arg_134_0.shipContainer

		var_17.SetNormalizedPosition(var_134_18, var_134_17, 1)

		var_134_19 = var_134_3()
	end

	if var_134_19 then
		triggerButton = var_1_10011

		var_1_10011(var_134_19.tr)

		local var_134_20 = arg_134_0.shipVOsById[var_134_19.shipVO.id]
		local var_134_21 = arg_134_0.guildShipEquipmentsPage

		var_12.Refresh(var_134_21, var_134_20, var_134_20.user)
	end

	return
end

function var_0_1.OnSwitch(arg_137_0, arg_137_1, arg_137_2, arg_137_3)
	local function var_137_0()
		setActive = var_2_10000

		local var_138_0 = arg_137_1

		var_2_10000(var_1.Find(var_138_0, "off"), not arg_137_2)

		setActive = var_2_10000

		local var_138_1 = arg_137_1

		var_2_10000(var_1.Find(var_138_1, "on"), arg_137_2)

		return
	end

	onButton = var_1_10005

	local var_137_1 = arg_137_0
	local var_137_2 = arg_137_1

	local function var_137_3()
		arg_137_2 = not arg_137_2

		if arg_137_3 then
			arg_137_3(arg_137_2)
		end

		var_137_0()

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10005(var_137_1, var_137_2, var_137_3, var_1_10009)
	var_137_0()

	return
end

function var_0_1.OnShipSkinChanged(arg_140_0, arg_140_1)
	ShipPhantom = var_1_10002

	local var_140_0, var_140_1 = var_1_10002.UnpackMark(arg_140_1)

	if arg_140_0.phantomGroupDic[var_140_0] and arg_140_0.scrollPhantoms[var_4] and var_5.shipCard.shipVO.id == var_140_0 then
		local var_140_2 = arg_140_0
		local var_140_3 = arg_140_0.updatePhantomGroup

		underscore = var_1_10008

		var_140_3(var_140_2, var_1_10008.detect(arg_140_0.filterBluePrint, function(arg_141_0)
			return arg_141_0.shipId == var_140_0
		end), var_4)
	end

	return
end

function var_0_1.onBackPressed(arg_142_0)
	local var_142_0 = arg_142_0.destroyConfirmWindow

	if var_1.isShowing(var_142_0) then
		local var_142_1 = arg_142_0.destroyConfirmWindow

		var_1.Hide(var_142_1)

		return
	end

	local var_142_2 = arg_142_0.destroyPage

	if var_1.isShowing(var_142_2) then
		local var_142_3 = arg_142_0.destroyPage

		var_1.Hide(var_142_3)

		return
	end

	local var_142_4 = arg_142_0.settingPanel

	if var_1.isShowing(var_142_4) then
		local var_142_5 = arg_142_0.settingPanel

		var_1.Hide(var_142_5)

		return
	end

	pg = var_1

	local var_142_6 = var_1.CriMgr.GetInstance()
	local var_142_7 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_142_7(var_142_6, var_1_10003)
	arg_142_0:back()

	return
end

function var_0_1.updateShipStatusById(arg_143_0, arg_143_1)
	if arg_143_0.cardItemDic[arg_143_1] and arg_143_0.scrollItems[var_2] and var_3.shipVO.id == arg_143_1 then
		local var_143_0 = var_3

		var_3.flush(var_143_0, arg_143_0.selectedIds)

		local var_143_1 = arg_143_0.contextData.mode

		DockyardScene = var_143_0

		if var_143_1 == var_143_0.MODE_WORLD then
			var_3:updateWorld()
		end
	end

	return
end

function var_0_1.checkDestroyGold(arg_144_0, arg_144_1)
	local var_144_0 = 0
	local var_144_1 = 0

	ipairs = var_1_10004

	for iter_144_0, iter_144_1 in var_1_10004(arg_144_0.selectedIds) do
		local var_144_2 = arg_144_0.shipVOsById[iter_144_1]
		local var_144_3, var_144_4 = var_9.calReturnRes(var_144_2)

		var_144_0 = var_144_0 + var_144_3
		var_144_1 = var_144_1 + var_144_4
	end

	if arg_144_1 then
		local var_144_5, var_144_6 = arg_144_1:calReturnRes()

		var_144_0 = var_144_0 + var_144_5
		var_144_1 = var_144_1 + var_144_6
	end

	local var_144_7 = arg_144_0.player
	local var_144_8 = var_4.OilMax(var_144_7, var_144_1)
	local var_144_9 = arg_144_0.player

	if var_5.GoldMax(var_144_9, var_144_0) then
		return false, not var_144_8
	end

	return true, not var_144_8
end

function var_0_1.selectShip(arg_145_0, arg_145_1)
	local var_145_0 = false
	local var_145_1

	ipairs = var_1_10004

	for iter_145_0, iter_145_1 in var_1_10004(arg_145_0.selectedIds) do
		if iter_145_1 == arg_145_1.id then
			var_145_0 = true
			var_145_1 = iter_145_0

			break
		end
	end

	if var_145_0 or arg_145_0.selectedMax == 1 and arg_145_0:GetSelectCount() > 0 then
		defaultValue = var_4

		local var_145_2 = var_4(var_145_1, 1)
		local var_145_3 = arg_145_0.shipVOsById[arg_145_0.selectedIds[var_145_2]]
		local var_145_4, var_145_5 = arg_145_0.onCancelShip(var_145_3, function()
			if not arg_145_0.exited then
				return
			end

			local var_146_0 = arg_145_0

			var_0.selectShip(var_146_0, arg_145_1)

			return
		end, arg_145_0.selectedIds)

		if not var_145_4 then
			if var_145_5 then
				pg = var_7
				iter_145_1 = var_7.TipsMgr.GetInstance()

				var_7.ShowTips(iter_145_1, var_145_5)
			end

			return
		end

		table = var_7

		var_7.remove(arg_145_0.selectedIds, var_145_2)

		if arg_145_0.selectedMax ~= 1 then
			iter_145_1 = arg_145_0

			arg_145_0.updateBlackBlocks(iter_145_1, var_145_3)
		end
	end

	if not var_145_0 then
		local var_145_6, var_145_7 = arg_145_0.checkShip(arg_145_1, function()
			if arg_145_0.exited then
				return
			end

			local var_147_0 = arg_145_0

			var_0.selectShip(var_147_0, arg_145_1)

			return
		end, arg_145_0.selectedIds)

		if not var_145_6 then
			if var_145_7 then
				pg = var_6

				local var_145_8 = var_6.TipsMgr.GetInstance()

				var_6.ShowTips(var_145_8, var_145_7)
			end

			return
		end

		local var_145_10

		if arg_145_0.selectedMax == 0 or arg_145_0:GetSelectCount() < arg_145_0.selectedMax then
			table = var_145_10

			var_145_10.insert(arg_145_0.selectedIds, arg_145_1.id)

			if arg_145_0.selectedMax ~= 1 then
				local var_145_9 = arg_145_0

				var_145_10 = arg_145_0.updateBlackBlocks
				removeShip = iter_145_1

				var_145_10(var_145_9, iter_145_1)
			end
		else
			pg = var_145_10

			local var_145_11 = var_145_10.TipsMgr.GetInstance()
			local var_145_12 = var_6.ShowTips

			i18n = iter_145_1

			var_145_12(var_145_11, iter_145_1("ship_dockyardScene_error_choiseRoleLess", arg_145_0.selectedMax))

			return
		end
	end

	arg_145_0:updateSelected()

	if arg_145_0.contextData.mode == var_0_1.MODE_DESTROY then
		arg_145_0:updateDestroyRes()
	elseif arg_145_0.contextData.mode == var_0_1.MODE_MOD then
		arg_145_0:updateModAttr()
	end

	arg_145_0:UpdateGuildViewEquipmentsBtn()

	return
end

function var_0_1.updateBlackBlocks(arg_148_0, arg_148_1)
	if not arg_148_0.contextData.useBlackBlock or not arg_148_1 then
		return
	end

	pairs = var_2

	for iter_148_0, iter_148_1 in var_2(arg_148_0.scrollItems) do
		arg_148_0:updateItemBlackBlock(iter_148_1)
	end

	return
end

function var_0_1.updateItemBlackBlock(arg_149_0, arg_149_1)
	if arg_149_0.contextData.useBlackBlock then
		if arg_149_0.selectedMax == 1 then
			arg_149_1:updateBlackBlock(arg_149_0.contextData.otherSelectedIds)
		else
			arg_149_1:updateBlackBlock(arg_149_0.selectedIds)
		end
	else
		arg_149_1:updateBlackBlock()
	end

	return
end

function var_0_1.unselecteAllShips(arg_150_0)
	arg_150_0.selectedIds = {}

	arg_150_0:updateSelected()
	arg_150_0:updateDestroyRes()

	return
end

function var_0_1.updateSelected(arg_151_0)
	if arg_151_0.shipContainer then
		pairs = var_1

		for iter_151_2, iter_151_1 in var_1(arg_151_0.scrollItems) do
			if not iter_151_1.isClear then
				local var_151_0

				if not iter_151_1.shipVO or not iter_151_1.shipVO.id then
					var_151_0 = nil
				end

				var_1_10008 = iter_151_1

				local var_151_1 = iter_151_1.updateSelected
				local var_151_2

				if iter_151_1.shipVO then
					underscore = var_151_2
					var_151_2 = var_151_2.any(arg_151_0.selectedIds, function(arg_152_0)
						return var_151_0 == arg_152_0
					end)
				end

				var_151_1(var_1_10008, var_151_2)
			end
		end
	end

	if arg_151_0.phantomContainer then
		pairs = var_1

		for iter_151_2, iter_151_3 in var_1(arg_151_0.scrollPhantoms) do
			if not iter_151_3.isClear then
				local var_151_3 = iter_151_3.shipCard.shipVO.id
				local var_151_4 = {}

				getGameset = var_1_10008
				var_1_10008 = var_1_10008("technology_shadow_num")[1]

				for iter_151_4 = 0, var_1_10008 do
					if iter_151_4 == 0 then
						underscore = var_1_10013
						var_151_4[iter_151_4] = var_1_10013.any(arg_151_0.selectedIds, function(arg_153_0)
							return var_151_3 == arg_153_0
						end)
					else
						underscore = var_1_10013
						var_151_4[iter_151_4] = var_1_10013.any(arg_151_0.selectedMarks, function(arg_154_0)
							ShipPhantom = var_2_10001

							return arg_154_0 == var_2_10001.PackMark(var_151_3, iter_151_4)
						end)
					end
				end

				iter_151_3:updateSelected(var_151_4)
			end
		end
	end

	if arg_151_0.selectedMax == 0 then
		setText = var_1

		local var_151_5 = arg_151_0.selectPanel
		local var_151_6 = var_2.Find(var_151_5, "bottom_info/bg_input/count")

		iter_151_2 = arg_151_0

		var_1(var_151_6, arg_151_0.GetSelectCount(iter_151_2))

		goto label_151_1
	end

	local var_151_7 = arg_151_0:GetSelectCount()

	if arg_151_0.contextData.mode ~= var_0_1.MODE_DESTROY or arg_151_0:GetSelectCount() == 0 then
		setColorStr = var_2

		local var_151_8 = var_151_7

		COLOR_WHITE = iter_151_2
		var_151_7 = var_2(var_151_8, iter_151_2)

		goto label_151_0
	end

	if arg_151_0.contextData.mode == var_0_1.MODE_DESTROY then
		setColorStr = var_2

		local var_151_9 = var_151_7

		if #arg_151_0.selectedIds == 10 then
			COLOR_RED = var_4

			if not var_4 then
				COLOR_GREEN = var_4
			end

			var_151_7 = var_2(var_151_9, var_4)

			::label_151_0::

			setText = var_2

			do
				local var_151_10 = arg_151_0.selectPanel

				var_2(var_3.Find(var_151_10, "bottom_info/bg_input/count"), var_151_7 .. "/" .. arg_151_0.selectedMax)
			end

			::label_151_1::

			if arg_151_0:GetSelectCount() < arg_151_0.selectedMin then
				setActive = var_1

				local var_151_11 = arg_151_0.selectPanel

				var_1(var_2.Find(var_151_11, "confirm_button/mask"), true)
			else
				setActive = var_1

				local var_151_12 = arg_151_0.selectPanel

				var_1(var_2.Find(var_151_12, "confirm_button/mask"), false)
			end

			if arg_151_0.contextData.mode == var_0_1.MODE_MOD then
				arg_151_0:updateModAttr()
			end

			return
		end
	end
end

function var_0_1.updateItemDetailType(arg_155_0)
	pairs = var_1_10001

	for iter_155_0, iter_155_1 in var_1_10001(arg_155_0.scrollItems) do
		iter_155_1:updateDetail(arg_155_0.itemDetailType)
	end

	local var_155_0 = arg_155_0.shipLayout
	local var_155_1 = arg_155_0.shipLayout.anchoredPosition

	Vector3 = var_3
	var_155_0.anchoredPosition = var_155_1 + var_3(0, 0.001, 0)

	return
end

function var_0_1.closeDestroyMode(arg_156_0)
	setActive = var_1_10001

	var_1_10001(arg_156_0.awardTF, false)

	setActive = var_1_10001

	var_1_10001(arg_156_0.bottomTipsText, true)

	return
end

function var_0_1.updateDestroyRes(arg_157_0)
	table = var_1_10001

	if var_1_10001.getCount(arg_157_0.selectedIds) == 0 then
		arg_157_0:closeDestroyMode()
	else
		setActive = var_1

		var_1(arg_157_0.awardTF, true)

		setActive = var_1

		var_1(arg_157_0.bottomTipsText, false)
	end

	_ = var_1

	local var_157_0 = var_1.map(arg_157_0.selectedIds, function(arg_158_0)
		return arg_157_0.shipVOsById[arg_158_0]
	end)

	ShipCalcHelper = var_2

	local var_157_1, var_157_2, var_157_3 = var_2.CalcDestoryRes(var_157_0)
	local var_157_4 = var_157_2 == 0

	if arg_157_0.destroyResList then
		local var_157_5 = (var_157_4 and 1 or 2) + #var_157_3
		local var_157_6 = arg_157_0.destroyResList

		var_7.make(var_157_6, function(arg_159_0, arg_159_1, arg_159_2)
			UIItemList = var_2_10003

			if arg_159_0 == var_2_10003.EventUpdate then
				local var_159_0 = ""
				local var_159_1 = 0

				if arg_159_1 == 0 then
					var_2_10005 = "Props/gold"
					var_159_1 = var_157_1
					var_159_0 = var_2_10005
				elseif arg_159_1 == 1 then
					if not var_157_4 then
						var_2_10005 = "Props/oil"
						var_159_1 = var_157_2
						var_159_0 = var_2_10005
					else
						var_2_10005 = var_157_3[1]
						Item = var_2_10006
						var_159_0, var_159_1 = var_2_10006.getConfigData(var_2_10005.id).icon, var_2_10005.count
					end
				elseif 1 < arg_159_1 then
					if not var_157_4 or not var_157_3[arg_159_1] then
						var_2_10005 = var_157_3[arg_159_1 - 1]
					end

					Item = var_2_10006
					var_159_0, var_159_1 = var_2_10006.getConfigData(var_2_10005.id).icon, var_2_10005.count
				end

				GetImageSpriteFromAtlasAsync = var_2_10005

				var_2_10005(var_159_0, "", arg_159_2:Find("icon"))

				setText = var_2_10005

				var_2_10005(arg_159_2:Find("Text"), "X" .. var_159_1)
			end

			return
		end)

		local var_157_7 = arg_157_0.destroyResList

		var_7.align(var_157_7, var_157_5)
	end

	if arg_157_0.destroyPage then
		local var_157_8 = arg_157_0.destroyPage

		if var_6.GetLoaded(var_157_8) then
			local var_157_9 = arg_157_0.destroyPage

			if var_6.isShowing(var_157_9) then
				local var_157_10 = arg_157_0.destroyPage

				var_6.RefreshRes(var_157_10)
			end
		end
	end

	return
end

function var_0_1.setModShip(arg_160_0, arg_160_1)
	arg_160_0.modShip = arg_160_1

	return
end

function var_0_1.updateModAttr(arg_161_0)
	table = var_1_10001

	if var_1_10001.getCount(arg_161_0.selectedIds) == 0 then
		arg_161_0:closeModAttr()
	else
		setActive = var_1

		var_1(arg_161_0.modAttrsTF, true)

		setActive = var_1

		var_1(arg_161_0.bottomTipsText, false)
	end

	local var_161_0 = arg_161_0.contextData.ignoredIds[1]
	local var_161_1 = {}

	ipairs = var_1_10003

	for iter_161_0, iter_161_1 in var_1_10003(arg_161_0.selectedIds) do
		table = var_1_10008

		var_1_10008.insert(var_161_1, arg_161_0.shipVOsById[iter_161_1])
	end

	ShipModLayer = var_3

	local var_161_2 = var_3.getModExpAdditions(arg_161_0.modShip, var_161_1)

	pairs = var_4
	ShipModAttr = var_5

	for iter_161_2, iter_161_3 in var_4(var_5.ID_TO_ATTR) do
		ShipModLayer = var_1_10009

		if iter_161_2 ~= var_1_10009.IGNORE_ID then
			local var_161_3 = arg_161_0.modAttrContainer

			var_1_10009 = var_1_10009.Find(var_161_3, "attr_" .. iter_161_2)
			setText = var_161_3

			var_161_3(var_1_10009:Find("value"), var_161_2[iter_161_3])

			setText = var_161_3

			local var_161_4 = var_1_10009
			local var_161_5 = var_1_10009.Find(var_161_4, "name")

			ShipModAttr = var_161_4

			var_161_3(var_161_5, var_161_4.id2Name(iter_161_2))
		end
	end

	return
end

function var_0_1.closeModAttr(arg_162_0)
	setActive = var_1_10001

	var_1_10001(arg_162_0.modAttrsTF, false)

	setActive = var_1_10001

	var_1_10001(arg_162_0.bottomTipsText, true)

	return
end

function var_0_1.removeShip(arg_163_0, arg_163_1)
	ipairs = var_1_10002

	for iter_163_0, iter_163_1 in var_1_10002(arg_163_0.selectedIds) do
		if iter_163_1 == arg_163_1 then
			table = var_1_10007

			var_1_10007.remove(arg_163_0.selectedIds, iter_163_0)

			break
		end
	end

	for iter_163_2 = #arg_163_0.shipVOs, 1, -1 do
		if arg_163_0.shipVOs[iter_163_2].id == arg_163_1 then
			table = var_6

			var_6.remove(arg_163_0.shipVOs, iter_163_2)

			break
		end
	end

	arg_163_0.shipVOsById[arg_163_1] = nil

	return
end

function var_0_1.updateShipCount(arg_164_0, arg_164_1)
	local var_164_0 = arg_164_0.shipContainer
	local var_164_1 = var_2.SetTotalCount
	local var_164_2 = #arg_164_0.shipVOs

	defaultValue = var_1_10005

	var_164_1(var_164_0, var_164_2, var_1_10005(arg_164_1, -1))

	setActive = var_164_1

	var_164_1(arg_164_0.listEmptyTF, #arg_164_0.shipVOs <= 0)

	return
end

function var_0_1.ClearShipsBlackBlock(arg_165_0)
	if not arg_165_0.shipVOsById then
		return
	end

	pairs = var_1

	for iter_165_0, iter_165_1 in var_1(arg_165_0.shipVOsById) do
		iter_165_1.blackBlock = false
	end

	return
end

function var_0_1.willExit(arg_166_0)
	arg_166_0:closeDestroyMode()
	arg_166_0:closeModAttr()
	arg_166_0:ClearShipsBlackBlock()

	if arg_166_0.guildShipEquipmentsPage then
		local var_166_0 = arg_166_0.guildShipEquipmentsPage

		var_1.Destroy(var_166_0)
	end

	if arg_166_0.settingPanel then
		local var_166_1 = arg_166_0.settingPanel

		var_1.Destroy(var_166_1)
	end

	if arg_166_0.destroyPage then
		local var_166_2 = arg_166_0.destroyPage

		var_1.Destroy(var_166_2)
	end

	if arg_166_0.destroyConfirmWindow then
		local var_166_3 = arg_166_0.destroyConfirmWindow

		var_1.Destroy(var_166_3)
	end

	if arg_166_0.contextData.mode == var_0_1.MODE_MOD then
		-- block empty
	elseif not arg_166_0.contextData.sortData then
		_G = var_1

		local var_166_4

		if var_1[arg_166_0.contextData.preView] then
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.sortIndex = arg_166_0.sortIndex
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.selectAsc = arg_166_0.selectAsc
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.typeIndex = arg_166_0.typeIndex
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.campIndex = arg_166_0.campIndex
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.rarityIndex = arg_166_0.rarityIndex
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.extraIndex = arg_166_0.extraIndex
			_G = var_166_4
			var_166_4 = var_166_4[arg_166_0.contextData.preView]
			var_166_4.commonTag = arg_166_0.commonTag
		else
			DockyardScene = var_166_4
			var_166_4.sortIndex = arg_166_0.sortIndex
			DockyardScene = var_166_4
			var_166_4.selectAsc = arg_166_0.selectAsc
			DockyardScene = var_166_4
			var_166_4.typeIndex = arg_166_0.typeIndex
			DockyardScene = var_166_4
			var_166_4.campIndex = arg_166_0.campIndex
			DockyardScene = var_166_4
			var_166_4.rarityIndex = arg_166_0.rarityIndex
			DockyardScene = var_166_4
			var_166_4.extraIndex = arg_166_0.extraIndex
			DockyardScene = var_166_4
			var_166_4.commonTag = arg_166_0.commonTag
		end
	end

	if arg_166_0.shipContainer then
		local var_166_5 = arg_166_0.shipContainer

		var_166_5.enabled = false
		pairs = var_166_5

		for iter_166_0, iter_166_1 in var_166_5(arg_166_0.scrollItems) do
			iter_166_1:clear()

			GetOrAddComponent = var_6

			local var_166_6 = var_6(iter_166_1.go, "UILongPressTrigger").onLongPressed

			var_6.RemoveAllListeners(var_166_6)
		end
	end

	local var_166_7

	if arg_166_0.phantomContainer then
		var_166_7 = arg_166_0.phantomContainer
		var_166_7.enabled = false
		pairs = var_166_7

		for iter_166_2, iter_166_3 in var_166_7(arg_166_0.scrollPhantoms) do
			iter_166_3:clear()
		end
	end

	LeanTween = var_166_7

	local var_166_8 = var_166_7.isTweening

	go = var_2

	if var_166_8(var_2(arg_166_0.energyDescTF)) then
		setActive = var_1

		var_1(arg_166_0.energyDescTF, false)

		LeanTween = var_1

		local var_166_9 = var_1.cancel

		go = var_2

		var_166_9(var_2(arg_166_0.energyDescTF))
	end

	local var_166_10 = arg_166_0

	arg_166_0.cancelAnimating(var_166_10)

	if arg_166_0.isRemouldOrUpgradeMode then
		getProxy = var_1
		SettingsProxy = var_166_10

		local var_166_11 = var_1(var_166_10)

		var_1.SetDockYardLockBtnFlag(var_166_11, arg_166_0.isFilterLockForMod)
		var_1:SetDockYardLevelBtnFlag(arg_166_0.isFilterLevelForMod)
	end

	if arg_166_0.bulinTip then
		local var_166_12 = arg_166_0.bulinTip

		var_1.Destroy(var_166_12)

		arg_166_0.bulinTip = nil
	end

	if arg_166_0.searchBar then
		local var_166_13 = arg_166_0.searchBar

		var_1.Dispose(var_166_13)

		arg_166_0.searchBar = nil
	end

	arg_166_0:UnOverlayPanel(arg_166_0.blurPanel, arg_166_0._tf)

	if arg_166_0:isLayer() then
		arg_166_0:UnOverlayPanel(arg_166_0._tf)
	end

	return
end

function var_0_1.uiStartAnimating(arg_167_0)
	local var_167_0 = arg_167_0.topPanel
	local var_167_1 = var_1.Find(var_167_0, "back")
	local var_167_2 = 0
	local var_167_3 = 0.3

	isActive = var_1_10004

	if var_1_10004(arg_167_0.selectPanel) then
		shiftPanel = var_4

		var_4(arg_167_0.selectPanel, nil, 0, var_167_3, var_167_2, true, true)
	end

	return
end

function var_0_1.uiExitAnimating(arg_168_0)
	if arg_168_0.contextData.mode == var_0_1.MODE_OVERVIEW then
		-- block empty
	else
		local var_168_0 = 0
		local var_168_1 = 0.3

		shiftPanel = var_1_10003

		var_1_10003(arg_168_0.selectPanel, nil, -1 * arg_168_0.selectPanel.rect.height, var_168_1, var_168_0, true, true)
	end

	return
end

function var_0_1.back(arg_169_0)
	if arg_169_0.exited then
		return
	end

	arg_169_0:closeView()

	return
end

function var_0_1.cancelAnimating(arg_170_0)
	LeanTween = var_1_10001

	local var_170_0 = var_1_10001.isTweening

	go = var_1_10002

	local var_170_1

	if var_170_0(var_1_10002(arg_170_0.topPanel)) then
		LeanTween = var_170_1
		var_170_1 = var_170_1.cancel
		go = var_2

		var_170_1(var_2(arg_170_0.topPanel))
	end

	LeanTween = var_170_1

	local var_170_2 = var_170_1.isTweening

	go = var_2

	if var_170_2(var_2(arg_170_0.selectPanel)) then
		LeanTween = var_1

		local var_170_3 = var_1.cancel

		go = var_2

		var_170_3(var_2(arg_170_0.selectPanel))
	end

	if arg_170_0.tweens then
		cancelTweens = var_1

		var_1(arg_170_0.tweens)
	end

	return
end

function var_0_1.quickExitFunc(arg_171_0)
	seriesAsync = var_1_10001

	var_1_10001({
		function(arg_172_0)
			if arg_171_0.contextData.onQuickHome then
				arg_171_0.contextData.onQuickHome(arg_172_0)
			else
				arg_172_0()
			end

			return
		end,
		function(arg_173_0)
			local var_173_0 = arg_171_0

			var_1.emit(var_173_0, var_0_1.ON_HOME)

			return
		end
	})

	return
end

function var_0_1.displayDestroyPanel(arg_174_0)
	local var_174_0 = arg_174_0.destroyPage

	var_1.ExecuteAction(var_174_0, "Show")

	local var_174_1 = arg_174_0.destroyPage

	var_1.ActionInvoke(var_174_1, "Refresh", arg_174_0.selectedIds, arg_174_0.shipVOsById)

	return
end

function var_0_1.closeDestroyPanel(arg_175_0)
	local var_175_0 = arg_175_0.destroyPage

	if var_1.isShowing(var_175_0) then
		local var_175_1 = arg_175_0.destroyPage

		var_1.Hide(var_175_1)
	end

	return
end

function var_0_1.checkDestroyShips(arg_176_0, arg_176_1, arg_176_2)
	local var_176_0 = {}

	PlayerPrefs = var_1_10004

	local var_176_1

	if var_1_10004.GetInt("RetireProtect", 1) == 0 then
		var_176_1 = {}
		pairs = var_5

		for iter_176_0, iter_176_1 in var_5(arg_176_1) do
			local var_176_2 = 0

			pairs = var_1_10011

			for iter_176_2, iter_176_3 in var_1_10011(arg_176_1) do
				if iter_176_3:getGroupId() == iter_176_1:getGroupId() then
					var_176_2 = var_176_2 + 1
				end
			end

			getProxy = var_1_10011
			BayProxy = var_12

			local var_176_3 = var_1_10011(var_12)

			if #var_1_10011.findShipsByGroup(var_176_3, iter_176_1:getGroupId()) == var_176_2 then
				local var_176_4 = false

				pairs = var_13

				for iter_176_4, iter_176_5 in var_13(var_176_1) do
					if iter_176_5:getGroupId() == iter_176_1:getGroupId() then
						var_176_4 = true

						break
					end
				end

				if not var_176_4 then
					table = var_13

					var_13.insert(var_176_1, iter_176_1)
				end
			end
		end

		if #var_176_1 > 0 then
			table = var_5

			var_5.insert(var_176_0, function(arg_177_0)
				local var_177_0 = arg_176_0.destroyConfirmWindow

				var_1.ExecuteAction(var_177_0, "ShowOneShipProtect", var_176_1, arg_177_0)

				return
			end)
		end
	end

	ShipCalcHelper = var_176_1

	local var_176_5, var_176_6 = var_176_1.GetEliteAndHightLevelShips(arg_176_1)

	if #var_176_5 > 0 or #var_176_6 > 0 then
		table = var_6

		var_6.insert(var_176_0, function(arg_178_0)
			local var_178_0 = false

			if arg_176_0.contextData.mode == var_0_1.MODE_DESTROY then
				local var_178_1 = {}

				ShipCalcHelper = var_3
				var_178_1[1] = var_3.CalcDestoryRes(arg_176_1)
				var_178_0 = var_178_1[4]
			end

			local var_178_2 = arg_176_0.destroyConfirmWindow

			var_2.ExecuteAction(var_178_2, "Show", var_176_5, var_176_6, var_178_0, arg_178_0)

			return
		end)
	end

	underscore = var_6

	if #var_6.filter(arg_176_1, function(arg_179_0)
		return arg_179_0:getFlag("inElite")
	end) > 0 then
		table = var_7

		var_7.insert(var_176_0, function(arg_180_0)
			local var_180_0 = arg_176_0.destroyConfirmWindow

			var_1.ExecuteAction(var_180_0, "ShowEliteTag", var_0, arg_180_0)

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_176_0, arg_176_2)

	return
end

return var_0_1
