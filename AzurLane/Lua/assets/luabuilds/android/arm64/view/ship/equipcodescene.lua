class = var_0_10000

local var_0_0 = "EquipCodeScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.optionsPath = {
	"adpter/frame/option"
}

function var_0_1.getUIName(arg_1_0)
	return "EquipCodeUI"
end

function var_0_1.setEquipments(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.equips = arg_2_1
	table = var_1_10003

	local var_2_0 = var_1_10003.sort
	local var_2_1 = arg_2_0.equips

	CompareFuncs = var_1_10006
	EquipmentSortCfg = var_1_10008

	local var_2_2 = var_1_10008.sortFunc

	EquipmentSortCfg = var_1_10010

	var_2_0(var_2_1, var_1_10006(var_2_2(var_1_10010.sort[1], false)))

	arg_2_0.spWeapons = arg_2_2
	table = var_2_0

	local var_2_3 = var_2_0.sort
	local var_2_4 = arg_2_0.spWeapons

	CompareFuncs = var_6
	SpWeaponSortCfg = var_8

	local var_2_5 = var_8.sortFunc

	SpWeaponSortCfg = var_10

	var_2_3(var_2_4, var_6(var_2_5(var_10.sort[1], false)))

	return
end

function var_0_1.setShip(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)

	arg_3_0.shipVO = var_2.getShipById(var_3_0, arg_3_1)
	arg_3_0.shipData = {}
	ipairs = var_2

	local var_3_1 = arg_3_0.shipVO

	for iter_3_0, iter_3_1 in var_2(var_4.getAllEquipments(var_3_1)) do
		if not iter_3_1 then
			arg_3_0.shipData[iter_3_0] = false
		else
			local var_3_2 = arg_3_0.shipData

			underscore = var_1_10008

			if not var_1_10008.detect(arg_3_0.equips, function(arg_4_0)
				return arg_4_0.configId == iter_3_1.configId and arg_4_0.shipId == arg_3_0.shipVO.id and arg_4_0.shipPos == iter_3_0
			end) then
				var_1_10008 = false
			end

			var_3_2[iter_3_0] = var_1_10008
		end
	end

	local var_3_3 = arg_3_0.shipVO

	if not var_2.GetSpWeapon(var_3_3) then
		arg_3_0.shipData[6] = false
	else
		local var_3_4 = arg_3_0.shipData

		underscore = var_3_3

		local var_3_5

		if not var_3_3.detect(arg_3_0.spWeapons, function(arg_5_0)
			return arg_5_0.configId == var_0.configId and arg_5_0:GetShipId() == arg_3_0.shipVO.id
		end) then
			var_3_5 = false
		end

		var_3_4[6] = var_3_5
	end

	return
end

function var_0_1.getEquipShipVO(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.shipVO
	local var_6_1 = var_2.clone(var_6_0)

	underscore = var_1_10003
	var_6_1.equipments = var_1_10003.first(arg_6_1, 5)

	local var_6_2

	if not arg_6_1[6] then
		var_6_2 = nil
	end

	var_6_1.spWeapon = var_6_2

	return var_6_1
end

local function var_0_2(arg_7_0, arg_7_1, arg_7_2)
	setActive = var_1_10003

	local var_7_0 = arg_7_0:Find("IconTpl")

	tobool = var_1_10006

	var_1_10003(var_7_0, var_1_10006(arg_7_1))

	if arg_7_1 then
		updateEquipment = var_1_10003

		var_1_10003(arg_7_0:Find("IconTpl"), arg_7_1)
	end

	if arg_7_0:Find("equip_flag") then
		setActive = var_3

		var_3(arg_7_0:Find("equip_flag"), arg_7_2)

		if arg_7_2 then
			setImageSprite = var_3

			local var_7_1 = arg_7_0:Find("equip_flag/Image")

			LoadSprite = var_6

			var_3(var_7_1, var_6("qicon/" .. arg_7_2:getPainting()))
		end
	end

	return
end

local function var_0_3(arg_8_0, arg_8_1, arg_8_2)
	setActive = var_1_10003

	local var_8_0 = arg_8_0:Find("IconTpl")

	tobool = var_1_10006

	var_1_10003(var_8_0, var_1_10006(arg_8_1))

	if arg_8_1 then
		updateSpWeapon = var_1_10003

		var_1_10003(arg_8_0:Find("IconTpl"), arg_8_1)
	end

	if arg_8_0:Find("equip_flag") then
		setActive = var_3

		var_3(arg_8_0:Find("equip_flag"), arg_8_2)

		if arg_8_2 then
			setImageSprite = var_3

			local var_8_1 = arg_8_0:Find("equip_flag/Image")

			LoadSprite = var_6

			var_3(var_8_1, var_6("qicon/" .. arg_8_2:getPainting()))
		end
	end

	return
end

local function var_0_4(arg_9_0, arg_9_1, arg_9_2)
	setActive = var_1_10003

	var_1_10003(arg_9_0:Find("Icon"), arg_9_1)

	setActive = var_1_10003

	var_1_10003(arg_9_0:Find("IconShadow"), arg_9_1)

	if arg_9_1 then
		UpdateSpWeaponSlot = var_1_10003

		var_1_10003(arg_9_0, arg_9_1)
	end

	if arg_9_0:Find("equip_flag") then
		setActive = var_3

		var_3(arg_9_0:Find("equip_flag"), arg_9_2)

		if arg_9_2 then
			setImageSprite = var_3

			local var_9_0 = arg_9_0:Find("equip_flag/Image")

			LoadSprite = var_6

			var_3(var_9_0, var_6("qicon/" .. arg_9_2:getPainting()))
		end
	end

	return
end

local function var_0_5(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:Find("error")

	if not arg_10_1 or not arg_10_2 then
		setActive = var_1_10004

		var_1_10004(var_10_0, false)

		goto label_10_0
	end

	if arg_10_1.configId == arg_10_2.configId then
		setActive = var_4

		var_4(var_10_0, false)

		goto label_10_0
	end

	local var_10_1 = false

	instanceof = var_5

	local var_10_2 = arg_10_1

	SpWeapon = var_1_10008

	if var_5(var_10_2, var_1_10008) then
		pg = var_10_3

		do
			local var_10_3

			if not var_10_3.spweapon_data_statistics then
				pg = var_10_3
				var_10_3 = var_10_3.equip_data_template
			end

			ipairs = var_6

			for iter_10_0, iter_10_1 in var_6({
				"next",
				"prev"
			}) do
				local var_10_4 = arg_10_1.configId

				while var_10_3[var_10_4][iter_10_1] > 0 do
					if var_10_3[var_10_4][iter_10_1] == arg_10_2.configId then
						var_10_1 = true

						break
					end
				end

				if var_10_1 then
					break
				end
			end

			setActive = var_6

			var_6(var_10_0, true)

			setText = var_6

			local var_10_5 = var_10_0:Find("Text")

			i18n = var_9

			var_6(var_10_5, var_9(var_10_1 and "equipcode_level_unmatched" or "equipcode_diff_selected"))
		end

		::label_10_0::

		return
	end
end

function var_0_1.onBackPressed(arg_11_0)
	local var_11_0 = {}

	for iter_11_0 = 1, #arg_11_0.shipData do
		local var_11_1

		if not arg_11_0.shipData[iter_11_0] or not arg_11_0.shipData[iter_11_0].configId then
			var_11_1 = 0
		end

		local var_11_2

		if not arg_11_0.equipData[iter_11_0] or not arg_11_0.equipData[iter_11_0].configId then
			var_11_2 = 0
		end

		if var_11_1 ~= var_11_2 then
			table = var_11_1

			var_11_1.insert(var_11_0, function(arg_12_0)
				pg = var_2_10001

				local var_12_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_12_1 = var_1.ShowMsgBox
				local var_12_2 = {}

				i18n = var_2_10005
				var_12_2.content = var_2_10005("equipcode_unsaved_tips")
				var_12_2.onYes = arg_12_0

				var_12_1(var_12_0, var_12_2)

				return
			end)

			break
		end
	end

	seriesAsync = var_2

	var_2(var_11_0, function()
		local var_13_0 = arg_11_0

		var_0.closeView(var_13_0)

		return
	end)

	return
end

local var_0_6

function var_0_1.init(arg_14_0)
	local var_14_0

	if not var_0_6 then
		var_14_0 = {}
		var_1_10002 = {}

		local var_14_1 = {
			num = 2
		}

		CustomIndexLayer = var_1_10004
		var_14_1.mode = var_1_10004.Mode.NUM
		underscore = var_4

		local var_14_2 = var_4.rest

		IndexConst = var_1_10006
		var_14_1.options = var_14_2(var_1_10006.ECodeLabelIndexs)
		underscore = var_4

		local var_14_3 = var_4.rest

		IndexConst = var_1_10006
		var_14_1.names = var_14_3(var_1_10006.ECodeLabelNames)
		var_1_10002.labelIndex = var_14_1
		var_14_0.customPanels = var_1_10002
		var_14_0.groupList = {
			{
				dropdown = false,
				titleENTxt = "indexsort_labeleng",
				titleTxt = "indexsort_label",
				tags = {
					"labelIndex"
				}
			}
		}
		i18n = var_1_10002
		var_14_0.tip = var_1_10002("equipcode_share_ruletips")
	end

	var_0_6 = var_14_0

	local var_14_4 = arg_14_0._tf

	arg_14_0.btnBack = var_1.Find(var_14_4, "adpter/frame/btnBack")
	onButton = var_1

	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.btnBack

	local function var_14_7()
		local var_15_0 = arg_14_0

		var_0.onBackPressed(var_15_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_14_5, var_14_6, var_14_7, var_1_10006)

	local var_14_8 = arg_14_0._tf

	arg_14_0.rtMainPanel = var_1.Find(var_14_8, "main_panel")
	onButton = var_1

	local var_14_9 = arg_14_0
	local var_14_10 = arg_14_0.rtMainPanel
	local var_14_11 = var_4.Find(var_14_10, "btns/btn_export")

	local function var_14_12()
		UniPasteBoard = var_2_10000

		local var_16_0 = var_2_10000.SetClipBoardString

		buildEquipCode = var_2_10002

		var_16_0(var_2_10002(arg_14_0.shipVO))

		pg = var_16_0

		local var_16_1 = var_16_0.TipsMgr.GetInstance()
		local var_16_2 = var_0.ShowTips

		i18n = var_2_10003

		var_16_2(var_16_1, var_2_10003("equipcode_export_success"))

		return
	end

	SFX_CONFIRM = var_14_10

	var_1(var_14_9, var_14_11, var_14_12, var_14_10)

	onButton = var_1

	local var_14_13 = arg_14_0
	local var_14_14 = arg_14_0.rtMainPanel
	local var_14_15 = var_4.Find(var_14_14, "share/btn_comments")

	local function var_14_16()
		local var_17_0 = arg_14_0
		local var_17_1 = var_0.emit

		EquipCodeMediator = var_2_10003

		local var_17_2 = var_2_10003.OPEN_EQUIP_CODE_SHARE
		local var_17_3 = arg_14_0.shipVO

		var_17_1(var_17_0, var_17_2, var_4.getGroupId(var_17_3))

		return
	end

	SFX_PANEL = var_14_14

	var_1(var_14_13, var_14_15, var_14_16, var_14_14)

	arg_14_0.tagIndexData = {}
	onButton = var_1

	local var_14_17 = arg_14_0
	local var_14_18 = arg_14_0.rtMainPanel
	local var_14_19 = var_4.Find(var_14_18, "share/btn_share")

	local function var_14_20()
		local var_18_0 = arg_14_0
		local var_18_1 = var_0.emit

		EquipCodeMediator = var_2_10003

		local var_18_2 = var_2_10003.OPEN_CUSTOM_INDEX

		setmetatable = var_2_10004

		local var_18_3 = {}

		Clone = var_2_10007
		var_18_3.indexDatas = var_2_10007(arg_14_0.tagIndexData)

		function var_18_3.callback(arg_19_0)
			arg_14_0.tagIndexData.labelIndex = arg_19_0.labelIndex

			local var_19_0 = 0
			local var_19_1 = arg_19_0.labelIndex

			while 0 < var_19_1 do
				var_19_0 = var_19_0 + 1
				bit = var_19_2
				var_19_1 = var_19_2.band(var_19_1, var_19_1 - 1)
			end

			local var_19_2

			if var_19_0 == 2 then
				buildEquipCode = var_19_2
				var_19_2 = var_19_2(arg_14_0.shipVO)

				local var_19_3 = {}
				local var_19_4 = arg_14_0.tagIndexData.labelIndex

				while 0 < var_19_4 do
					bit = var_3_10006
					var_19_4 = var_19_4 - var_3_10006.band(var_19_4, -var_19_4)
					var_3_10007 = 0

					while 0 < var_3_10006 do
						var_3_10007 = var_3_10007 + 1
						math = var_8
						var_3_10006 = var_8.floor(var_3_10006 / 2)
					end

					table = var_8

					local var_19_5 = var_8.insert

					var_3_10010 = var_19_3
					tostring = var_3_10011

					var_19_5(var_3_10010, var_3_10011(var_3_10007))
				end

				local var_19_6 = arg_14_0.shipVO

				var_3_10006 = var_3_10006.getGroupId(var_19_6)
				table = var_3_10007

				local var_19_7 = var_3_10007.concat
				local var_19_8 = {
					var_19_2
				}

				ConversionBase = var_3_10010
				var_19_8[2] = var_3_10010(32, var_3_10006)
				var_19_8[3] = var_19_3[1]
				var_19_8[4] = var_19_3[2]
				var_19_2 = var_19_7(var_19_8, "&")

				local var_19_9 = arg_14_0
				local var_19_10 = var_7.emit

				EquipCodeMediator = var_10

				var_19_10(var_19_9, var_10.SHARE_EQUIP_CODE, var_3_10006, var_19_2)
			else
				pg = var_19_2

				local var_19_11 = var_19_2.TipsMgr.GetInstance()
				local var_19_12 = var_3.ShowTips

				i18n = var_3_10006

				var_19_12(var_19_11, var_3_10006("equipcode_share_nolabel"))
			end

			return
		end

		var_18_1(var_18_0, var_18_2, var_2_10004(var_18_3, {
			__index = var_0_6
		}))

		return
	end

	SFX_PANEL = var_14_18

	var_1(var_14_17, var_14_19, var_14_20, var_14_18)

	local var_14_21 = arg_14_0._tf

	arg_14_0.rtCodePanel = var_1.Find(var_14_21, "code_panel")
	onButton = var_1

	local var_14_22 = arg_14_0
	local var_14_23 = arg_14_0.rtCodePanel
	local var_14_24 = var_4.Find(var_14_23, "btns/btn_import")

	local function var_14_25()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		i18n = var_2_10004
		var_20_2.content = var_2_10004("equipcode_confirm_doublecheck")

		function var_20_2.onYes()
			local var_21_0 = arg_14_0
			local var_21_1 = var_0.emit

			EquipCodeMediator = var_3_10003

			var_21_1(var_21_0, var_3_10003.IMPORT_SHIP_EQUIP, arg_14_0.shipVO.id, arg_14_0.equipData)

			return
		end

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_CONFIRM = var_14_23

	var_1(var_14_22, var_14_24, var_14_25, var_14_23)

	onButton = var_1

	local var_14_26 = arg_14_0
	local var_14_27 = arg_14_0.rtCodePanel
	local var_14_28 = var_4.Find(var_14_27, "btns/btn_withdrawn")

	local function var_14_29()
		arg_14_0.code = nil

		local var_22_0 = arg_14_0

		var_0.updateDispalyPanel(var_22_0, arg_14_0.rtCodePanel, "code")

		return
	end

	SFX_CANCEL = var_14_27

	var_1(var_14_26, var_14_28, var_14_29, var_14_27)

	onButton = var_1

	local var_14_30 = arg_14_0
	local var_14_31 = arg_14_0.rtCodePanel
	local var_14_32 = var_4.Find(var_14_31, "btns/btn_cancel")

	local function var_14_33()
		local var_23_0 = arg_14_0

		var_0.updateDispalyPanel(var_23_0, arg_14_0.rtCodePanel, "code")

		local var_23_1 = arg_14_0

		var_0.initQuickPanel(var_23_1)

		return
	end

	SFX_CANCEL = var_14_31

	var_1(var_14_30, var_14_32, var_14_33, var_14_31)

	onToggle = var_1

	local var_14_34 = arg_14_0
	local var_14_35 = arg_14_0.rtCodePanel

	var_1(var_14_34, var_4.Find(var_14_35, "btns/toggle_quick"), function(arg_24_0)
		setInputText = var_2_10001

		var_2_10001(arg_14_0.nameSearchInput, "")

		setActive = var_2_10001

		var_2_10001(arg_14_0.rtMainPanel, false)

		setActive = var_2_10001

		var_2_10001(arg_14_0.rtBottomPanel, false)

		setActive = var_2_10001

		var_2_10001(arg_14_0.rtQuickPanel, false)

		setActive = var_2_10001

		local var_24_0 = arg_14_0.rtCodePanel

		var_2_10001(var_3.Find(var_24_0, "btns/btn_withdrawn"), not arg_24_0)

		setActive = var_2_10001

		local var_24_1 = arg_14_0.rtCodePanel

		var_2_10001(var_3.Find(var_24_1, "btns/btn_cancel"), arg_24_0)

		if arg_14_0.quickIndex then
			triggerToggle = var_1

			local var_24_2 = arg_14_0.rtCodePanel
			local var_24_3 = var_3.Find(var_24_2, "equipments_quick")

			var_1(var_3.GetChild(var_24_3, arg_14_0.quickIndex - 1), false)
		end

		eachChild = var_1

		local var_24_4 = arg_14_0.rtCodePanel

		var_1(var_3.Find(var_24_4, "equipments_quick"), function(arg_25_0)
			SetCompomentEnabled = var_3_10001

			local var_25_0 = arg_25_0

			typeof = var_3_10004
			Toggle = var_3_10006

			var_3_10001(var_25_0, var_3_10004(var_3_10006), false)

			return
		end)

		local var_24_5 = arg_14_0

		LeanTween = var_2_10002

		local var_24_6 = var_2_10002.moveY
		local var_24_7 = arg_14_0.rtCodePanel
		local var_24_8 = arg_24_0 and 420 or 80

		math = var_6

		local var_24_9 = var_6.max

		math = var_2_10008

		local var_24_10 = var_24_6(var_24_7, var_24_8, var_24_9(var_2_10008.abs((arg_24_0 and 420 or 80) - arg_14_0.rtCodePanel.anchoredPosition.y), 0.1) / 2000)
		local var_24_11 = var_2.setOnComplete

		System = var_24_8
		var_24_5.ltID = var_24_11(var_24_10, var_24_8.Action(function()
			local var_26_0 = arg_14_0

			var_26_0.ltID = nil
			setActive = var_26_0

			var_26_0(arg_14_0.rtMainPanel, not arg_24_0)

			setActive = var_26_0

			var_26_0(arg_14_0.rtBottomPanel, not arg_24_0)

			setActive = var_26_0

			var_26_0(arg_14_0.rtQuickPanel, arg_24_0)

			if arg_24_0 then
				local var_26_1 = arg_14_0

				var_0.initQuickPanel(var_26_1)
			end

			return
		end)).uniqueId

		return
	end)

	eachChild = var_1

	local var_14_36 = arg_14_0.rtCodePanel

	var_1(var_3.Find(var_14_36, "equipments_quick"), function(arg_27_0)
		onToggle = var_2_10001

		local var_27_0 = arg_14_0
		local var_27_1 = arg_27_0

		local function var_27_2(arg_28_0)
			if arg_28_0 then
				local var_28_0 = arg_14_0
				local var_28_1 = arg_27_0

				var_28_0.quickIndex = var_2.GetSiblingIndex(var_28_1) + 1

				local var_28_2 = arg_14_0

				var_1.updateQuickPanel(var_28_2)
			else
				local var_28_3 = arg_14_0.quickIndex
				local var_28_4 = arg_27_0

				if var_28_3 == var_2.GetSiblingIndex(var_28_4) + 1 then
					arg_14_0.quickIndex = nil

					local var_28_5 = arg_14_0

					var_1.updateQuickPanel(var_28_5)
				end
			end

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_27_0, var_27_1, var_27_2, var_2_10006)

		SetCompomentEnabled = var_2_10001

		local var_27_3 = arg_27_0

		typeof = var_27_1
		Toggle = var_2_10006

		var_2_10001(var_27_3, var_27_1(var_2_10006), false)

		return
	end)

	local var_14_37 = arg_14_0._tf

	arg_14_0.rtQuickPanel = var_1.Find(var_14_37, "quick_panel")
	onToggle = var_1

	local var_14_38 = arg_14_0
	local var_14_39 = arg_14_0.rtQuickPanel
	local var_14_40 = var_4.Find(var_14_39, "title/equiping")

	local function var_14_41(arg_29_0)
		local var_29_0 = arg_14_0

		var_29_0.equipingFlag = arg_29_0
		isActive = var_29_0

		if var_29_0(arg_14_0.rtQuickPanel) then
			local var_29_1 = arg_14_0

			var_1.updateQuickPanel(var_29_1, true)
		end

		return
	end

	SFX_PANEL = var_14_39

	var_1(var_14_38, var_14_40, var_14_41, var_14_39)

	local var_14_42 = arg_14_0.rtQuickPanel

	arg_14_0.nameSearchInput = var_1.Find(var_14_42, "title/serachPanel/search")

	local var_14_43 = arg_14_0.nameSearchInput

	arg_14_0.nameSearchText = var_1.Find(var_14_43, "holder")
	setText = var_1

	local var_14_44 = arg_14_0.nameSearchText

	i18n = var_4

	var_1(var_14_44, var_4("search_equipment"))

	setInputText = var_1

	var_1(arg_14_0.nameSearchInput, "")

	onInputChanged = var_1

	var_1(arg_14_0, arg_14_0.nameSearchInput, function()
		local var_30_0 = arg_14_0

		var_0.updateQuickPanel(var_30_0, true)

		return
	end)

	local var_14_45

	if not arg_14_0.indexData then
		var_14_45 = {}
	end

	arg_14_0.indexData = var_14_45

	local var_14_46

	if not arg_14_0.spweaponIndexDatas then
		var_14_46 = {}
	end

	arg_14_0.spweaponIndexDatas = var_14_46

	local var_14_47 = arg_14_0.rtQuickPanel
	local var_14_48 = var_1.Find(var_14_47, "title/filter")

	onButton = var_1_10002

	local var_14_49 = arg_14_0
	local var_14_50 = var_14_48

	local function var_14_51()
		assert = var_2_10000

		var_2_10000(arg_14_0.quickIndex)

		switch = var_2_10000

		local var_31_0 = var_2_10000(arg_14_0.quickIndex, {
			[6] = function()
				setmetatable = var_3_10000

				local var_32_0 = {}

				Clone = var_3_10003
				var_32_0.indexDatas = var_3_10003(arg_14_0.spweaponIndexDatas)

				function var_32_0.callback(arg_33_0)
					arg_14_0.spweaponIndexDatas.typeIndex = arg_33_0.typeIndex

					local var_33_0 = arg_14_0.spweaponIndexDatas

					var_33_0.rarityIndex = arg_33_0.rarityIndex
					underscore = var_33_0

					local var_33_1 = var_33_0(arg_14_0.spweaponIndexDatas)
					local var_33_2 = var_1.chain(var_33_1)
					local var_33_3 = var_1.keys(var_33_2)
					local var_33_4 = var_1.all(var_33_3, function(arg_34_0)
						local var_34_0 = arg_14_0.spweaponIndexDatas[arg_34_0]

						StoreHouseConst = var_5_10002

						return var_34_0 == var_5_10002.SPWEAPON_INDEX_COMMON.customPanels[arg_34_0].options[1]
					end)
					local var_33_5 = var_1.value(var_33_4)

					setActive = var_2

					local var_33_6 = var_14_48

					var_2(var_4.Find(var_33_6, "on"), not var_33_5)

					setActive = var_2

					local var_33_7 = var_14_48

					var_2(var_4.Find(var_33_7, "off"), var_33_5)

					local var_33_8 = arg_14_0

					var_2.updateQuickPanel(var_33_8)

					return
				end

				local var_32_1 = {}

				StoreHouseConst = var_3_10004
				var_32_1.__index = var_3_10004.SPWEAPON_INDEX_COMMON

				return var_3_10000(var_32_0, var_32_1)
			end
		}, function()
			setmetatable = var_3_10000

			local var_35_0 = {}

			Clone = var_3_10003
			var_35_0.indexDatas = var_3_10003(arg_14_0.indexData)

			function var_35_0.callback(arg_36_0)
				arg_14_0.indexData.typeIndex = arg_36_0.typeIndex
				arg_14_0.indexData.equipPropertyIndex = arg_36_0.equipPropertyIndex
				arg_14_0.indexData.equipPropertyIndex2 = arg_36_0.equipPropertyIndex2
				arg_14_0.indexData.equipAmmoIndex1 = arg_36_0.equipAmmoIndex1
				arg_14_0.indexData.equipAmmoIndex2 = arg_36_0.equipAmmoIndex2
				arg_14_0.indexData.equipCampIndex = arg_36_0.equipCampIndex
				arg_14_0.indexData.rarityIndex = arg_36_0.rarityIndex

				local var_36_0 = arg_14_0.indexData

				var_36_0.extraIndex = arg_36_0.extraIndex
				underscore = var_36_0

				local var_36_1 = var_36_0(arg_14_0.indexData)
				local var_36_2 = var_1.chain(var_36_1)
				local var_36_3 = var_1.keys(var_36_2)
				local var_36_4 = var_1.all(var_36_3, function(arg_37_0)
					local var_37_0 = arg_14_0.indexData[arg_37_0]

					StoreHouseConst = var_5_10002

					return var_37_0 == var_5_10002.EQUIPMENT_INDEX_COMMON.customPanels[arg_37_0].options[1]
				end)
				local var_36_5 = var_1.value(var_36_4)

				setActive = var_2

				local var_36_6 = var_14_48

				var_2(var_4.Find(var_36_6, "on"), not var_36_5)

				setActive = var_2

				local var_36_7 = var_14_48

				var_2(var_4.Find(var_36_7, "off"), var_36_5)

				local var_36_8 = arg_14_0

				var_2.updateQuickPanel(var_36_8)

				return
			end

			local var_35_1 = {}

			StoreHouseConst = var_3_10004
			var_35_1.__index = var_3_10004.EQUIPMENT_INDEX_COMMON

			return var_3_10000(var_35_0, var_35_1)
		end)
		local var_31_1 = arg_14_0
		local var_31_2 = var_1.emit

		EquipCodeMediator = var_4

		var_31_2(var_31_1, var_4.OPEN_CUSTOM_INDEX, var_31_0)

		return
	end

	SFX_PANEL = var_7

	var_1_10002(var_14_49, var_14_50, var_14_51, var_7)

	local var_14_52 = arg_14_0.rtQuickPanel
	local var_14_53 = var_2.Find(var_14_52, "frame/container")

	arg_14_0.comList = var_2.GetComponent(var_14_53, "LScrollRect")

	function arg_14_0.comList.onInitItem(arg_38_0)
		ClearTweenItemAlphaAndWhite = var_2_10001

		var_2_10001(arg_38_0)

		return
	end

	function arg_14_0.comList.onReturnItem(arg_39_0, arg_39_1)
		ClearTweenItemAlphaAndWhite = var_2_10002

		var_2_10002(arg_39_1)

		return
	end

	local var_14_54 = arg_14_0.comList

	function var_14_54.onUpdateItem(arg_40_0, arg_40_1)
		if not arg_14_0.quickIndex then
			return
		end

		TweenItemAlphaAndWhite = var_2

		var_2(arg_40_1)

		tf = var_2

		local var_40_0 = var_2(arg_40_1)
		local var_40_1 = arg_14_0.filterEquipments[arg_40_0 + 1]

		setActive = var_4

		var_4(var_40_0:Find("unEquip"), not var_40_1)

		setActive = var_4

		var_4(var_40_0:Find("bg"), var_40_1)

		setActive = var_4

		var_4(var_40_0:Find("IconTpl"), var_40_1)

		if arg_14_0.quickIndex == 6 then
			local var_40_2 = var_0_3
			local var_40_3 = var_40_0
			local var_40_4 = var_40_1

			if var_40_1 and var_40_1.shipId then
				getProxy = var_8
				BayProxy = var_2_10010
				var_2_10010 = var_8(var_2_10010)

				local var_40_5

				if not var_8.getShipById(var_2_10010, var_40_1.shipId) then
					var_40_5 = nil
				end

				var_40_2(var_40_3, var_40_4, var_40_5)

				onButton = var_40_2

				local var_40_6 = arg_14_0

				var_40_4 = var_40_0

				local function var_40_7()
					local var_41_0 = {}

					if var_40_1 then
						PlayerPrefs = var_1

						if var_1.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
							table = var_1

							var_1.insert(var_41_0, function(arg_42_0)
								local var_42_0 = arg_14_0
								local var_42_1 = var_1.emit
								local var_42_2 = var_0_1.ON_SPWEAPON
								local var_42_3 = {
									quickFlag = true
								}

								EquipmentInfoMediator = var_4_10006
								var_42_3.type = var_4_10006.TYPE_REPLACE

								local var_42_4 = var_40_1

								var_42_3.oldSpWeaponUid = var_6.GetUID(var_42_4)

								local var_42_5 = var_40_1

								var_42_3.oldShipId = var_6.GetShipId(var_42_5)

								local var_42_6 = arg_14_0

								var_42_3.shipVO = var_6.getEquipShipVO(var_42_6, arg_14_0.equipData)
								var_42_3.quickCallback = arg_42_0

								var_42_1(var_42_0, var_42_2, var_42_3)

								return
							end)
						end
					end

					seriesAsync = var_1

					var_1(var_41_0, function()
						arg_14_0.equipData[arg_14_0.quickIndex] = var_40_1

						local var_43_0 = arg_14_0.rtCodePanel
						local var_43_1 = var_0.Find(var_43_0, "equipments_quick/SpSlot")
						local var_43_2 = var_0_4
						local var_43_3 = var_43_1
						local var_43_4 = var_40_1

						if var_40_1 and var_40_1.shipId then
							getProxy = var_5
							BayProxy = var_4_10007

							local var_43_5 = var_5(var_4_10007)
							local var_43_6

							if not var_5.getShipById(var_43_5, var_40_1.shipId) then
								var_43_6 = nil
							end

							var_43_2(var_43_3, var_43_4, var_43_6)
							var_0_5(var_43_1, arg_14_0.codeData[arg_14_0.quickIndex], var_40_1)

							local var_43_7 = arg_14_0

							var_1.updateQuickPanel(var_43_7)

							return
						end
					end)

					return
				end

				SFX_PANEL = var_9

				var_40_2(var_40_6, var_40_4, var_40_7, var_9)

				goto label_40_0

				local var_40_8 = var_0_2
				local var_40_9 = var_40_0

				if var_40_1 then
					setmetatable = var_40_4

					local var_40_10 = {}

					var_2_10010 = var_40_1.count
					underscore = var_2_10011
					var_40_10.count = var_2_10010 - var_2_10011.reduce(arg_14_0.equipData, 0, function(arg_44_0, arg_44_1)
						return arg_44_0 + (arg_44_1 == var_40_1 and 1 or 0)
					end)

					local var_40_11

					if not var_40_4(var_40_10, {
						__index = var_40_1
					}) then
						var_40_11 = var_40_1
					end

					if var_40_1 and var_40_1.shipId then
						getProxy = var_8
						BayProxy = var_2_10010

						do
							local var_40_12 = var_8(var_2_10010)
							local var_40_13

							if not var_8.getShipById(var_40_12, var_40_1.shipId) then
								var_40_13 = nil
							end

							var_40_8(var_40_9, var_40_11, var_40_13)

							setActive = var_40_8

							var_40_8(var_40_0:Find("IconTpl/mask"), var_40_1 and var_40_1.mask)

							onButton = var_40_8

							local var_40_14 = arg_14_0
							local var_40_15 = var_40_0

							local function var_40_16()
								if var_40_1 and var_40_1.mask then
									return
								end

								local var_45_0 = {}

								if var_40_1 then
									PlayerPrefs = var_1

									if var_1.GetInt("QUICK_CHANGE_EQUIP", 1) == 1 then
										table = var_1

										var_1.insert(var_45_0, function(arg_46_0)
											local var_46_0 = arg_14_0
											local var_46_1 = var_1.emit
											local var_46_2 = var_0_1.ON_EQUIPMENT
											local var_46_3 = {
												quickFlag = true
											}

											EquipmentInfoMediator = var_4_10006
											var_46_3.type = var_4_10006.TYPE_REPLACE
											var_46_3.equipmentId = var_40_1.id
											var_46_3.oldShipId = var_40_1.shipId
											var_46_3.oldPos = var_40_1.shipPos

											local var_46_4 = arg_14_0

											var_46_3.shipVO = var_6.getEquipShipVO(var_46_4, arg_14_0.equipData)
											var_46_3.pos = arg_14_0.quickIndex
											var_46_3.quickCallback = arg_46_0

											var_46_1(var_46_0, var_46_2, var_46_3)

											return
										end)
									end
								end

								seriesAsync = var_1

								var_1(var_45_0, function()
									arg_14_0.equipData[arg_14_0.quickIndex] = var_40_1

									local var_47_0 = arg_14_0.rtCodePanel
									local var_47_1 = var_0.Find(var_47_0, "equipments_quick")
									local var_47_2 = var_0.GetChild(var_47_1, arg_14_0.quickIndex - 1)
									local var_47_3 = var_0_2
									local var_47_4 = var_47_2
									local var_47_5 = var_40_1

									if var_40_1 and var_40_1.shipId then
										getProxy = var_5
										BayProxy = var_4_10007

										local var_47_6 = var_5(var_4_10007)
										local var_47_7

										if not var_5.getShipById(var_47_6, var_40_1.shipId) then
											var_47_7 = nil
										end

										var_47_3(var_47_4, var_47_5, var_47_7)
										var_0_5(var_47_2, arg_14_0.codeData[arg_14_0.quickIndex], var_40_1)

										local var_47_8 = arg_14_0

										var_1.updateQuickPanel(var_47_8)

										return
									end
								end)

								return
							end

							SFX_PANEL = var_9

							var_40_8(var_40_14, var_40_15, var_40_16, var_9)
						end

						::label_40_0::

						return
					end
				end
			end
		end
	end

	setText = var_14_54

	local var_14_55 = var_14_48:Find("on/text2")

	i18n = var_5

	var_14_54(var_14_55, var_5("quick_equip_tip2"))

	setText = var_14_54

	local var_14_56 = var_14_48:Find("off/text2")

	i18n = var_5

	var_14_54(var_14_56, var_5("quick_equip_tip2"))

	setText = var_14_54

	local var_14_57 = arg_14_0.rtQuickPanel
	local var_14_58 = var_4.Find(var_14_57, "title/equiping/on/text2")

	i18n = var_5

	var_14_54(var_14_58, var_5("quick_equip_tip1"))

	setText = var_14_54

	local var_14_59 = arg_14_0.rtQuickPanel
	local var_14_60 = var_4.Find(var_14_59, "title/equiping/off/text2")

	i18n = var_5

	var_14_54(var_14_60, var_5("quick_equip_tip1"))

	setText = var_14_54

	local var_14_61 = arg_14_0.rtQuickPanel
	local var_14_62 = var_4.Find(var_14_61, "title/text")

	i18n = var_5

	var_14_54(var_14_62, var_5("quick_equip_tip3"))

	setText = var_14_54

	local var_14_63 = arg_14_0.rtQuickPanel
	local var_14_64 = var_4.Find(var_14_63, "frame/emptyTitle/text")

	i18n = var_5

	var_14_54(var_14_64, var_5("quick_equip_tip4"))

	setText = var_14_54

	local var_14_65 = arg_14_0.rtQuickPanel
	local var_14_66 = var_4.Find(var_14_65, "frame/selectTitle/text")

	i18n = var_5

	var_14_54(var_14_66, var_5("quick_equip_tip5"))

	local var_14_67 = arg_14_0._tf

	arg_14_0.rtBottomPanel = var_2.Find(var_14_67, "bottom_panel")

	local var_14_68 = arg_14_0.rtBottomPanel

	arg_14_0.rtInputField = var_2.Find(var_14_68, "InputField")
	setText = var_2

	local var_14_69 = arg_14_0.rtInputField
	local var_14_70 = var_4.Find(var_14_69, "Placeholder")

	i18n = var_5

	var_2(var_14_70, var_5("equipcode_input"))

	setInputText = var_2

	local var_14_71 = arg_14_0.rtInputField
	local var_14_72

	if not arg_14_0.contextData.code then
		var_14_72 = nil
	end

	var_2(var_14_71, var_14_72)

	local var_14_73 = arg_14_0.rtBottomPanel

	arg_14_0.btnInput = var_2.Find(var_14_73, "btn_confirm")
	onButton = var_2

	local var_14_74 = arg_14_0
	local var_14_75 = arg_14_0.btnInput

	local function var_14_76()
		local var_48_0 = arg_14_0

		getInputText = var_2_10001
		var_48_0.code = var_2_10001(arg_14_0.rtInputField)

		local var_48_1 = arg_14_0

		var_0.updateDispalyPanel(var_48_1, arg_14_0.rtCodePanel, "code")

		return
	end

	SFX_CONFIRM = var_7

	var_2(var_14_74, var_14_75, var_14_76, var_7)

	return
end

function var_0_1.didEnter(arg_49_0)
	buildEquipCode = var_1_10001
	arg_49_0.code = var_1_10001(arg_49_0.shipVO)

	arg_49_0:updateDispalyPanel(arg_49_0.rtMainPanel, "main")
	arg_49_0:updateDispalyPanel(arg_49_0.rtCodePanel, "code")

	return
end

function var_0_1.updateDispalyPanel(arg_50_0, arg_50_1, arg_50_2)
	updateDrop = var_1_10003

	local var_50_0 = arg_50_1
	local var_50_1 = arg_50_1.Find(var_50_0, "IconTpl")
	local var_50_2 = {}

	DROP_TYPE_SHIP = var_50_0
	var_50_2.type = var_50_0
	var_50_2.id = arg_50_0.shipVO.configId

	var_1_10003(var_50_1, var_50_2)

	local var_50_3 = arg_50_0.shipVO
	local var_50_4 = var_3.IsSpweaponUnlock(var_50_3)

	setActive = var_1_10004

	var_1_10004(arg_50_1:Find("equipments/SpSlot/Lock"), not var_50_4)

	if arg_50_2 == "main" then
		ipairs = var_1_10004

		local var_50_5 = arg_50_0.shipVO

		for iter_50_0, iter_50_1 in var_1_10004(var_6.getAllEquipments(var_50_5)) do
			local var_50_6 = var_0_2

			var_1_10013 = arg_50_1
			var_1_10013 = arg_50_1.Find(var_1_10013, "equipments")

			var_50_6(var_11.GetChild(var_1_10013, iter_50_0 - 1), iter_50_1)
		end

		var_1_10004 = var_0_4

		local var_50_7 = arg_50_1:Find("equipments/SpSlot")

		var_50_6 = arg_50_0.shipVO

		var_1_10004(var_50_7, var_7.GetSpWeapon(var_50_6), arg_50_0.shipVO)
	elseif arg_50_2 == "code" then
		pg = var_1_10004
		var_1_10004 = var_1_10004.equip_data_template
		pg = var_50_3

		local var_50_8 = var_50_3.spweapon_data_statistics
		local var_50_9 = false

		arg_50_0.codeData = {}
		ipairs = var_7
		parseEquipCode = var_50_6

		for iter_50_2, iter_50_3 in var_7(var_50_6(arg_50_0.code)) do
			if iter_50_2 == 6 then
				local var_50_10 = arg_50_0.codeData

				if var_50_4 and var_50_8[iter_50_3] then
					SpWeapon = var_1_10013

					if not var_1_10013.New({
						id = iter_50_3
					}) then
						var_1_10013 = false
					end

					var_50_10[iter_50_2] = var_1_10013

					if arg_50_0.codeData[iter_50_2] then
						local var_50_11 = arg_50_0:getEquipShipVO(arg_50_0.codeData)

						if not var_12.CanEquipSpWeapon(var_50_11, arg_50_0.codeData[iter_50_2]) then
							arg_50_0.codeData[iter_50_2] = false
							var_50_9 = true
						end
					end

					var_0_4(arg_50_1:Find("equipments/SpSlot"), arg_50_0.codeData[iter_50_2])

					goto label_50_0

					local var_50_12 = arg_50_0.codeData

					if var_1_10004[iter_50_3] then
						Equipment = var_1_10013

						if not var_1_10013.New({
							id = iter_50_3
						}) then
							var_1_10013 = false
						end

						var_50_12[iter_50_2] = var_1_10013

						if arg_50_0.codeData[iter_50_2] then
							local var_50_13 = arg_50_0:getEquipShipVO(arg_50_0.codeData)

							if not var_12.canEquipAtPos(var_50_13, arg_50_0.codeData[iter_50_2], iter_50_2) then
								arg_50_0.codeData[iter_50_2] = false
								var_50_9 = true
							end
						end

						do
							local var_50_14 = var_0_2
							local var_50_15 = arg_50_1:Find("equipments")

							var_50_14(var_14.GetChild(var_50_15, iter_50_2 - 1), arg_50_0.codeData[iter_50_2])
						end

						::label_50_0::
					end
				end
			end
		end

		if var_50_9 then
			pg = var_7

			local var_50_16 = var_7.TipsMgr.GetInstance()
			local var_50_17 = var_7.ShowTips

			i18n = iter_50_2

			var_50_17(var_50_16, iter_50_2("equipcode_slot_unmatch"))
		end

		arg_50_0.equipData = {}
		ipairs = var_7

		for iter_50_4, iter_50_5 in var_7(arg_50_0.codeData) do
			if iter_50_5 and arg_50_0.shipData[iter_50_4] and iter_50_5.configId == arg_50_0.shipData[iter_50_4].configId then
				arg_50_0.equipData[iter_50_4] = arg_50_0.shipData[iter_50_4]
			end
		end

		ipairs = var_7

		for iter_50_6, iter_50_7 in var_7(arg_50_0.codeData) do
			if iter_50_7 and not arg_50_0.equipData[iter_50_6] then
				local var_50_18 = iter_50_6 == 6 and var_50_8 or var_1_10004

				var_1_10013 = {
					iter_50_7.configId
				}
				ipairs = var_14

				for iter_50_8, iter_50_9 in var_14({
					"next",
					"prev"
				}) do
					var_1_10019 = iter_50_7.configId

					while var_50_18[var_1_10019][iter_50_9] > 0 do
						var_1_10019 = var_50_18[var_1_10019][iter_50_9]
						table = var_20

						var_20.insert(var_1_10013, var_1_10019)
					end
				end

				if iter_50_6 == 6 then
					ipairs = var_14
					underscore = var_16

					for iter_50_10, iter_50_11 in var_14(var_16.filter(arg_50_0.spWeapons, function(arg_51_0)
						return not arg_51_0.shipId
					end)) do
						table = var_1_10019

						if var_1_10019.indexof(var_1_10013, iter_50_11.configId) then
							if arg_50_0.equipData[iter_50_6] then
								table = var_20

								if var_1_10019 < var_20.indexof(var_1_10013, arg_50_0.equipData[iter_50_6].configId) then
									arg_50_0.equipData[iter_50_6] = iter_50_11
								end
							end
						end
					end
				else
					ipairs = var_14
					underscore = var_16

					for iter_50_12, iter_50_13 in var_14(var_16.filter(arg_50_0.equips, function(arg_52_0)
						return not arg_52_0.shipId or arg_52_0.shipId == arg_50_0.shipVO.id
					end)) do
						table = var_1_10019

						if var_1_10019.indexof(var_1_10013, iter_50_13.configId) then
							if arg_50_0.equipData[iter_50_6] then
								table = var_20

								if var_1_10019 < var_20.indexof(var_1_10013, arg_50_0.equipData[iter_50_6].configId) then
									local var_50_19 = iter_50_13.count

									underscore = var_21

									if var_50_19 > var_21.reduce(arg_50_0.equipData, 0, function(arg_53_0, arg_53_1)
										return arg_53_0 + (arg_53_1 == iter_50_13 and 1 or 0)
									end) then
										arg_50_0.equipData[iter_50_6] = iter_50_13
									end
								end
							end
						end
					end
				end
			end

			local var_50_20 = arg_50_0.equipData

			defaultValue = var_1_10013
			var_50_20[iter_50_6] = var_1_10013(arg_50_0.equipData[iter_50_6], false)
		end

		setActive = var_7

		var_7(arg_50_1:Find("equipments_quick/SpSlot/Lock"), not var_50_4)

		ipairs = var_7

		for iter_50_14, iter_50_15 in var_7(arg_50_0.equipData) do
			local var_50_21 = arg_50_1:Find("equipments_quick")
			local var_50_22 = var_12.GetChild(var_50_21, iter_50_14 - 1)

			if iter_50_14 == 6 then
				local var_50_23 = var_0_4
				local var_50_24 = var_50_22
				local var_50_25 = iter_50_15

				if iter_50_15 and iter_50_15.shipId then
					getProxy = var_17
					BayProxy = var_1_10019
					var_1_10019 = var_17(var_1_10019)

					local var_50_26

					if not var_17.getShipById(var_1_10019, iter_50_15.shipId) then
						var_50_26 = nil
					end

					var_50_23(var_50_24, var_50_25, var_50_26)

					goto label_50_1

					local var_50_27 = var_0_2
					local var_50_28 = var_50_22
					local var_50_29 = iter_50_15

					if iter_50_15 and iter_50_15.shipId then
						getProxy = var_17
						BayProxy = var_1_10019
						var_1_10019 = var_17(var_1_10019)

						do
							local var_50_30

							if not var_17.getShipById(var_1_10019, iter_50_15.shipId) then
								var_50_30 = nil
							end

							var_50_27(var_50_28, var_50_29, var_50_30)
						end

						::label_50_1::

						var_0_5(var_50_22, arg_50_0.codeData[iter_50_14], iter_50_15)
					end
				end
			end
		end
	else
		assert = var_1_10004

		var_1_10004(false)
	end

	return
end

function var_0_1.initQuickPanel(arg_54_0)
	eachChild = var_1_10001

	local var_54_0 = arg_54_0.rtCodePanel

	var_1_10001(var_3.Find(var_54_0, "equipments_quick"), function(arg_55_0)
		if arg_55_0:GetSiblingIndex() + 1 == 6 then
			SetCompomentEnabled = var_1

			local var_55_0 = arg_55_0

			typeof = var_2_10004
			Toggle = var_2_10006
			var_2_10004 = var_2_10004(var_2_10006)

			local var_55_1 = arg_54_0.shipVO

			var_1(var_55_0, var_2_10004, var_5.IsSpweaponUnlock(var_55_1))
		else
			SetCompomentEnabled = var_1

			local var_55_2 = arg_55_0

			typeof = var_2_10004
			Toggle = var_2_10006

			var_1(var_55_2, var_2_10004(var_2_10006), true)
		end

		return
	end)

	if arg_54_0.quickIndex then
		triggerToggle = var_1

		local var_54_1 = arg_54_0.rtCodePanel
		local var_54_2 = var_3.Find(var_54_1, "equipments_quick")

		var_1(var_3.GetChild(var_54_2, arg_54_0.quickIndex - 1), false)
	end

	triggerToggle = var_1

	local var_54_3 = arg_54_0.rtQuickPanel

	var_1(var_3.Find(var_54_3, "title/equiping"), true)
	arg_54_0:updateQuickPanel()

	return
end

function var_0_1.updateQuickPanel(arg_56_0)
	isActive = var_1_10001

	if not var_1_10001(arg_56_0.rtQuickPanel) then
		return
	end

	setActive = var_1

	local var_56_0 = arg_56_0.rtQuickPanel

	var_1(var_3.Find(var_56_0, "title/filter"), arg_56_0.quickIndex)

	setActive = var_1

	local var_56_1 = arg_56_0.rtQuickPanel

	var_1(var_3.Find(var_56_1, "frame/selectTitle"), not arg_56_0.quickIndex)

	if arg_56_0.quickIndex then
		if arg_56_0.quickIndex == 6 then
			arg_56_0.filterEquipments = arg_56_0:getFilterSpWeapon()
		else
			arg_56_0.filterEquipments = arg_56_0:getFilterEquipments()
		end

		if arg_56_0.equipData[arg_56_0.quickIndex] then
			table = var_1

			var_1.insert(arg_56_0.filterEquipments, 1, false)
		end

		local var_56_2 = arg_56_0.comList

		var_1.SetTotalCount(var_56_2, #arg_56_0.filterEquipments)

		setActive = var_1

		local var_56_3 = arg_56_0.rtQuickPanel

		var_1(var_3.Find(var_56_3, "frame/emptyTitle"), #arg_56_0.filterEquipments == 0)
	else
		local var_56_4 = arg_56_0.comList

		var_1.SetTotalCount(var_56_4, 0)

		setActive = var_1

		local var_56_5 = arg_56_0.rtQuickPanel

		var_1(var_3.Find(var_56_5, "frame/emptyTitle"), false)
	end

	return
end

function var_0_1.getFilterEquipments(arg_57_0)
	local var_57_0 = arg_57_0:getEquipShipVO(arg_57_0.equipData)

	getInputText = var_1_10002

	local var_57_1 = var_1_10002(arg_57_0.nameSearchInput)
	local var_57_2 = {
		arg_57_0.indexData.equipPropertyIndex,
		arg_57_0.indexData.equipPropertyIndex2
	}

	underscore = var_4

	local var_57_3 = var_4(arg_57_0.equips)
	local var_57_4 = var_4.chain(var_57_3)
	local var_57_5 = var_4.filter(var_57_4, function(arg_58_0)
		if not arg_58_0.shipId or arg_57_0.equipingFlag then
			local var_58_0 = arg_58_0.count

			underscore = var_2_10002

			if var_58_0 > var_2_10002.reduce(arg_57_0.equipData, 0, function(arg_59_0, arg_59_1)
				return arg_59_0 + (arg_58_0 == arg_59_1 and 1 or 0)
			end) then
				local var_58_1 = var_57_0

				if not var_58_0.isForbiddenAtPos(var_58_1, arg_58_0, arg_57_0.quickIndex) then
					IndexConst = var_58_0

					if var_58_0.filterEquipByType(arg_58_0, arg_57_0.indexData.typeIndex) then
						IndexConst = var_58_0

						if var_58_0.filterEquipByProperty(arg_58_0, var_57_2) then
							IndexConst = var_58_0

							if var_58_0.filterEquipAmmo1(arg_58_0, arg_57_0.indexData.equipAmmoIndex1) then
								IndexConst = var_58_0

								if var_58_0.filterEquipAmmo2(arg_58_0, arg_57_0.indexData.equipAmmoIndex2) then
									IndexConst = var_58_0

									if var_58_0.filterEquipByCamp(arg_58_0, arg_57_0.indexData.equipCampIndex) then
										IndexConst = var_58_0

										if var_58_0.filterEquipByRarity(arg_58_0, arg_57_0.indexData.rarityIndex) then
											IndexConst = var_58_0

											if var_58_0.filterEquipByExtra(arg_58_0, arg_57_0.indexData.extraIndex) then
												if var_57_1 ~= "" then
													var_58_0 = arg_58_0:IsMatchKey(var_57_1)

													goto label_58_0

													var_58_0 = false
												else
													var_58_0 = true
												end
											end
										end
									end
								end
							end
						end
					end

					::label_58_0::

					return var_58_0
				end
			end
		end
	end)
	local var_57_6 = var_4.each(var_57_5, function(arg_60_0)
		local var_60_0 = var_57_0

		arg_60_0.mask = not var_1.canEquipAtPos(var_60_0, arg_60_0, arg_57_0.quickIndex)

		return
	end)

	return var_4.value(var_57_6)
end

function var_0_1.getFilterSpWeapon(arg_61_0)
	local var_61_0 = arg_61_0
	local var_61_1 = arg_61_0.getEquipShipVO(var_61_0, arg_61_0.equipData)

	getInputText = var_1_10002

	local var_61_2 = var_1_10002(arg_61_0.nameSearchInput)

	underscore = var_61_0

	return var_61_0.filter(arg_61_0.spWeapons, function(arg_62_0)
		if not arg_62_0.shipId or arg_61_0.equipingFlag then
			if arg_62_0 ~= arg_61_0.equipData[6] then
				local var_62_0 = var_61_1

				if not var_62_1.IsSpWeaponForbidden(var_62_0, arg_62_0) then
					IndexConst = var_62_1

					local var_62_1

					if var_62_1.filterSpWeaponByType(arg_62_0, arg_61_0.spweaponIndexDatas.typeIndex) then
						IndexConst = var_62_1

						if var_62_1.filterSpWeaponByRarity(arg_62_0, arg_61_0.spweaponIndexDatas.rarityIndex) then
							if var_61_2 ~= "" then
								var_62_1 = arg_62_0:IsMatchKey(var_61_2)

								goto label_62_0

								var_62_1 = false
							else
								var_62_1 = true
							end
						end
					end

					::label_62_0::

					return var_62_1
				end
			end
		end
	end)
end

function var_0_1.willExit(arg_63_0)
	if arg_63_0.ltID then
		LeanTween = var_1

		var_1.cancel(arg_63_0.ltID)

		arg_63_0.ltID = nil
	end

	return
end

return var_0_1
