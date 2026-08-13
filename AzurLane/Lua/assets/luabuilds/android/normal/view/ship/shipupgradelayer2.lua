class = var_0_10000

local var_0_0 = "ShipUpgradeLayer2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 3

function var_0_1.getUIName(arg_1_0)
	return "ShipBreakOutUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "ShipMainScene"
end

function var_0_1.setItems(arg_3_0, arg_3_1)
	arg_3_0.items = arg_3_1

	return
end

function var_0_1.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.player = arg_4_1

	return
end

function var_0_1.init(arg_5_0)
	local var_5_0 = arg_5_0._tf

	arg_5_0.leftPanel = var_1.Find(var_5_0, "blur_panel/left_panel")

	local var_5_1 = arg_5_0.leftPanel

	arg_5_0.stages = var_1.Find(var_5_1, "stageScrollRect/stages")
	setText = var_1

	local var_5_2 = arg_5_0.leftPanel
	local var_5_3 = var_2.Find(var_5_2, "bg/title/Image")

	i18n = var_5_2

	var_1(var_5_3, var_5_2("word_preview"))

	local var_5_4 = arg_5_0.leftPanel
	local var_5_5 = var_1.Find(var_5_4, "stageScrollRect")

	arg_5_0.stagesSnap = var_1.GetComponent(var_5_5, "HorizontalScrollSnap")

	local var_5_6 = arg_5_0.leftPanel

	arg_5_0.breakView = var_1.Find(var_5_6, "content/Text")

	local var_5_7 = arg_5_0._tf

	arg_5_0.rightPanel = var_1.Find(var_5_7, "blur_panel/right_panel")

	local var_5_8 = arg_5_0.rightPanel

	arg_5_0.attrs = var_1.Find(var_5_8, "top/attrs")

	local var_5_9 = arg_5_0.rightPanel

	arg_5_0.starTpl = var_1.Find(var_5_9, "top/rare/startpl")
	setActive = var_1

	var_1(arg_5_0.starTpl, false)

	local var_5_10 = arg_5_0.rightPanel

	arg_5_0.starsFrom = var_1.Find(var_5_10, "top/rare/stars_from")

	local var_5_11 = arg_5_0.rightPanel

	arg_5_0.starsTo = var_1.Find(var_5_11, "top/rare/stars_to")

	local var_5_12 = arg_5_0.rightPanel

	arg_5_0.starOpera = var_1.Find(var_5_12, "top/rare/opera")

	local var_5_13 = arg_5_0.rightPanel

	arg_5_0.materials = var_1.Find(var_5_13, "bottom/materials")

	local var_5_14 = arg_5_0.rightPanel

	arg_5_0.breakOutBtn = var_1.Find(var_5_14, "bottom/break_btn/tip_active/image")

	local var_5_15 = arg_5_0.rightPanel

	arg_5_0.appendStarTips = var_1.Find(var_5_15, "bottom/panel_title/tip")

	local var_5_16 = arg_5_0.rightPanel

	arg_5_0.tipActive = var_1.Find(var_5_16, "bottom/break_btn/tip_active")

	local var_5_17 = arg_5_0.rightPanel

	arg_5_0.tipDeactive = var_1.Find(var_5_17, "bottom/break_btn/tip_deactive")
	setText = var_1

	local var_5_18 = arg_5_0.rightPanel
	local var_5_19 = var_2.Find(var_5_18, "bottom/panel_title/tip")

	i18n = var_5_18

	var_1(var_5_19, var_5_18("breakout_tip"))

	setText = var_1

	local var_5_20 = arg_5_0.rightPanel
	local var_5_21 = var_2.Find(var_5_20, "bottom/break_btn/tip_deactive/values/ok")

	i18n = var_5_20

	var_1(var_5_21, var_5_20("text_confirm"))

	setText = var_1

	local var_5_22 = arg_5_0.rightPanel
	local var_5_23 = var_2.Find(var_5_22, "bottom/break_btn/tip_active/image/ok")

	i18n = var_5_22

	var_1(var_5_23, var_5_22("text_confirm"))

	local var_5_24 = arg_5_0.rightPanel

	arg_5_0.recommandBtn = var_1.Find(var_5_24, "bottom/auto_btn")
	arg_5_0.isEnoughItems = true

	local var_5_25 = arg_5_0.leftPanel

	arg_5_0.sea = var_1.Find(var_5_25, "sea")

	local var_5_26 = arg_5_0.sea

	arg_5_0.rawImage = var_1.GetComponent(var_5_26, "RawImage")
	setActive = var_1

	var_1(arg_5_0.rawImage, false)

	local var_5_27 = arg_5_0._tf

	arg_5_0.healTF = var_1.Find(var_5_27, "resources/heal")

	local var_5_28 = arg_5_0.healTF.transform

	Vector3 = var_5_27
	var_5_28.localPosition = var_5_27(-360, 50, 40)
	setActive = var_5_28

	var_5_28(arg_5_0.healTF, false)

	local var_5_29 = arg_5_0.rightPanel

	arg_5_0.qCharaContain = var_1.Find(var_5_29, "top/panel_bg/q_chara")

	local var_5_30 = arg_5_0.leftPanel

	arg_5_0.seaLoading = var_1.Find(var_5_30, "bg/loading")

	arg_5_0:playLoadingAni()

	ShipDestoryConfirmWindow = var_1
	arg_5_0.destroyConfirmWindow = var_1.New(arg_5_0._tf, arg_5_0.event)

	return
end

function var_0_1.loadChar(arg_6_0)
	if not arg_6_0.shipPrefab then
		local var_6_0 = arg_6_0.shipVO
		local var_6_1 = var_1.getPrefab(var_6_0)

		pg = var_6_0

		local var_6_2 = var_6_0.UIMgr.GetInstance()

		var_2.LoadingOn(var_6_2)

		SpineAnimChar = var_2

		local var_6_3 = var_2.New()

		var_2.SetPaint(var_6_3, var_6_1)
		var_2:Load(true, function(arg_7_0)
			pg = var_2_10001

			local var_7_0 = var_2_10001.UIMgr.GetInstance()

			var_1.LoadingOff(var_7_0)

			arg_6_0.shipPrefab = var_6_1
			arg_6_0.shipModel = arg_7_0

			local var_7_1 = arg_7_0
			local var_7_2 = arg_7_0.SetLocalScale

			Vector3 = var_2_10003

			var_7_2(var_7_1, var_2_10003(0.8, 0.8, 1))
			arg_7_0:SetParent(arg_6_0.qCharaContain)
			arg_7_0:SetAction("stand", 0)

			return
		end)
	end

	return
end

function var_0_1.recycleSpineChar(arg_8_0)
	if arg_8_0.shipPrefab and arg_8_0.shipModel then
		local var_8_0 = arg_8_0.shipModel

		var_1.Dispose(var_8_0)

		arg_8_0.shipPrefab = nil
		arg_8_0.shipModel = nil
	end

	return
end

function var_0_1.enabledToggles(arg_9_0, arg_9_1)
	eachChild = var_1_10002

	var_1_10002(arg_9_0.toggles, function(arg_10_0)
		arg_10_0:GetComponent("Toggle").enabled = arg_9_1

		return
	end)

	return
end

function var_0_1.addDragListenter(arg_11_0)
	GetOrAddComponent = var_1_10001
	arg_11_0.dragTrigger = var_1_10001(arg_11_0._tf, "EventTriggerListener")

	local var_11_0
	local var_11_1 = 0

	var_1:AddBeginDragFunc(function()
		var_11_0 = nil
		var_11_1 = 0

		return
	end)
	var_1:AddDragFunc(function(arg_13_0, arg_13_1)
		local var_13_0 = arg_13_1.position

		if not var_11_0 then
			var_11_0 = var_13_0
		end

		var_11_1 = var_13_0.x - var_11_0.x

		return
	end)
	var_1:AddDragEndFunc(function(arg_14_0, arg_14_1)
		if var_11_1 < -50 then
			local var_14_0 = arg_11_0
			local var_14_1 = var_2.emit

			ShipUpgradeMediator2 = var_2_10004

			var_14_1(var_14_0, var_2_10004.NEXTSHIP, -1)
		elseif var_11_1 > 50 then
			local var_14_2 = arg_11_0
			local var_14_3 = var_2.emit

			ShipUpgradeMediator2 = var_2_10004

			var_14_3(var_14_2, var_2_10004.NEXTSHIP)
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_15_0)
	arg_15_0:BlurPanel(arg_15_0._tf, {
		groupDelta = -1
	})
	arg_15_0:addDragListenter()

	onButton = var_1

	var_1(arg_15_0, arg_15_0.seaLoading, function()
		if not arg_15_0.previewer then
			local var_16_0 = arg_15_0

			var_0.showBarrage(var_16_0)
		end

		return
	end)

	onButton = var_1

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.breakOutBtn

	local function var_15_2()
		local var_17_0 = {}
		local var_17_1 = arg_15_0.shipVO

		if var_1.isActivityNpc(var_17_1) then
			table = var_1

			var_1.insert(var_17_0, function(arg_18_0)
				pg = var_3_10001

				local var_18_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_18_1 = var_1.ShowMsgBox
				local var_18_2 = {}

				i18n = var_3_10004
				var_18_2.content = var_3_10004("npc_breakout_tip")
				var_18_2.onYes = arg_18_0

				var_18_1(var_18_0, var_18_2)

				return
			end)
		end

		seriesAsync = var_1

		var_1(var_17_0, function()
			ShipStatus = var_3_10000

			local var_19_0, var_19_1 = var_3_10000.ShipStatusCheck("onModify", arg_15_0.shipVO)

			if not var_19_0 then
				pg = var_2

				local var_19_2 = var_2.TipsMgr.GetInstance()

				var_2.ShowTips(var_19_2, var_19_1)

				return
			end

			if arg_15_0.breakCfg.breakout_id == 0 then
				pg = var_2

				local var_19_3 = var_2.TipsMgr.GetInstance()
				local var_19_4 = var_2.ShowTips

				i18n = var_3_10004

				var_19_4(var_19_3, var_3_10004("ship_upgradeStar_maxLevel"))

				return
			end

			if arg_15_0.shipVO.level < arg_15_0.breakCfg.level then
				pg = var_2

				local var_19_5 = var_2.TipsMgr.GetInstance()
				local var_19_6 = var_2.ShowTips

				i18n = var_3_10004

				var_19_6(var_19_5, var_3_10004("ship_upgradeStar_error_lvLimit"))

				return
			end

			if not arg_15_0.isEnoughItems then
				pg = var_2

				local var_19_7 = var_2.TipsMgr.GetInstance()
				local var_19_8 = var_2.ShowTips

				i18n = var_3_10004

				var_19_8(var_19_7, var_3_10004("ship_upgradeStar_error_noEnoughMatrail"))

				return
			end

			if arg_15_0.player.gold < arg_15_0.breakCfg.use_gold then
				GoShoppingMsgBox = var_2
				i18n = var_3
				var_3_10004 = "switch_to_shop_tip_2"
				i18n = var_3_10005

				local var_19_9 = var_3(var_3_10004, var_3_10005("word_gold"))

				ChargeScene = var_3_10004

				var_2(var_19_9, var_3_10004.TYPE_ITEM, {
					{
						59001,
						arg_15_0.breakCfg.use_gold - arg_15_0.player.gold,
						arg_15_0.breakCfg.use_gold
					}
				})

				return
			end

			if not arg_15_0.contextData.materialShipIds or #arg_15_0.contextData.materialShipIds < arg_15_0.breakCfg.use_char_num then
				pg = var_2

				local var_19_10 = var_2.TipsMgr.GetInstance()
				local var_19_11 = var_2.ShowTips

				i18n = var_3_10004

				var_19_11(var_19_10, var_3_10004("ship_upgradeStar_select_material_tip"))

				return
			end

			local var_19_12 = arg_15_0
			local var_19_13 = var_2.emit

			ShipUpgradeMediator2 = var_3_10004

			var_19_13(var_19_12, var_3_10004.UPGRADE_SHIP, arg_15_0.contextData.materialShipIds)

			return
		end)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_15_0, var_15_1, var_15_2, var_1_10005)

	onButton = var_1

	local var_15_3 = arg_15_0
	local var_15_4 = arg_15_0.recommandBtn

	local function var_15_5()
		getProxy = var_2_10000
		BayProxy = var_2_10001

		local var_20_0 = var_2_10000(var_2_10001)

		if arg_15_0.contextData.materialShipIds and #arg_15_0.contextData.materialShipIds == arg_15_0.breakCfg.use_char_num then
			return
		end

		local var_20_1 = var_20_0
		local var_20_2 = var_20_0.getUpgradeRecommendShip
		local var_20_3 = arg_15_0.shipVO
		local var_20_4

		if not arg_15_0.contextData.materialShipIds then
			var_20_4 = {}
		end

		local var_20_5 = #var_20_2(var_20_1, var_20_3, var_20_4, arg_15_0.breakCfg.use_char_num)

		if 0 < var_20_5 then
			var_20_5 = {}
			table = var_3

			var_3.insert(var_20_5, function(arg_21_0)
				ShipCalcHelper = var_3_10001

				local var_21_0 = var_3_10001.GetEliteAndHightLevelShips

				underscore = var_3_10002

				local var_21_1, var_21_2 = var_21_0(var_3_10002.map(var_0, function(arg_22_0)
					local var_22_0 = var_20_0

					return var_1.getShipById(var_22_0, arg_22_0)
				end))

				if #var_21_1 > 0 or #var_21_2 > 0 then
					local var_21_3 = arg_15_0.destroyConfirmWindow

					var_3.ExecuteAction(var_21_3, "Show", var_21_1, var_21_2, false, arg_21_0)
				else
					arg_21_0()
				end

				return
			end)

			seriesAsync = var_3

			var_3(var_20_5, function()
				arg_15_0.contextData.materialShipIds = var_0

				local var_23_0 = arg_15_0

				var_0.updateBreakOutView(var_23_0, arg_15_0.shipVO)

				return
			end)
		else
			pg = var_20_5

			local var_20_6 = var_20_5.TipsMgr.GetInstance()
			local var_20_7 = var_2.ShowTips

			i18n = var_20_4

			var_20_7(var_20_6, var_20_4("without_selected_ship"))
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_15_3, var_15_4, var_15_5, var_1_10005)
	arg_15_0:initMaterialShips()

	return
end

function var_0_1.getMaterialShip(arg_24_0, arg_24_1)
	local var_24_0

	for iter_24_0 = #arg_24_1, 1, -1 do
		local var_24_1 = arg_24_1[iter_24_0]

		if not var_7.isTestShip(var_24_1) then
			var_24_0 = iter_24_0

			break
		end
	end

	var_24_0 = var_24_0 or #arg_24_1

	return var_24_0
end

function var_0_1.setShip(arg_25_0, arg_25_1)
	arg_25_0.shipVO = arg_25_1
	pg = var_1_10002
	arg_25_0.shipTempCfg = var_1_10002.ship_data_template
	pg = var_2
	arg_25_0.shipBreakOutCfg = var_2.ship_data_breakout
	arg_25_0.breakIds = arg_25_0:getStages()
	arg_25_0.itemTFs = {}

	for iter_25_0 = 1, 3 do
		local var_25_0 = arg_25_0.itemTFs
		local var_25_1 = arg_25_0.materials

		var_25_0[iter_25_0] = var_7.Find(var_25_1, "item_" .. iter_25_0)
	end

	arg_25_0:updateBattleView()
	arg_25_0:updateBreakOutView(arg_25_0.shipVO)

	local var_25_2 = arg_25_0.shipVO.level < arg_25_0.breakCfg.level or arg_25_0.breakCfg.breakout_id == 0

	setActive = var_3

	var_3(arg_25_0.tipActive, not var_25_2)

	setActive = var_3

	var_3(arg_25_0.tipDeactive, var_25_2)

	setButtonEnabled = var_3

	var_3(arg_25_0.breakOutBtn, not var_25_2)

	setActive = var_3

	var_3(arg_25_0.recommandBtn, arg_25_0.breakCfg.breakout_id ~= 0)
	arg_25_0:loadChar()

	return
end

function var_0_1.getStages(arg_26_0)
	local var_26_0 = {}

	math = var_1_10002

	local var_26_1 = var_1_10002.floor(arg_26_0.shipVO.configId / 10)

	for iter_26_0 = 1, 4 do
		tonumber = var_1_10007
		var_1_10007 = var_1_10007(var_26_1 .. iter_26_0)
		assert = var_8

		var_8(arg_26_0.shipBreakOutCfg[var_1_10007], "必须存在配置" .. var_1_10007)

		table = var_8

		var_8.insert(var_26_0, var_1_10007)
	end

	return var_26_0
end

function var_0_1.updateStagesScrollView(arg_27_0)
	table = var_1_10001

	if var_1_10001.indexof(arg_27_0.breakIds, arg_27_0.shipVO.configId) and var_1 >= 1 and var_1 <= var_0_2 then
		local var_27_0 = arg_27_0.stages
		local var_27_1 = var_2.Find(var_27_0, "stage" .. var_1)
		local var_27_2 = var_2.GetComponent

		typeof = var_5
		Toggle = var_1_10006
		var_27_2(var_27_1, var_5(var_1_10006)).isOn = true
	end

	return
end

function var_0_1.updateBattleView(arg_28_0)
	if #arg_28_0.breakIds < var_0_2 then
		return
	end

	for iter_28_0 = 1, var_0_2 do
		var_1_10005 = arg_28_0.breakIds[iter_28_0]

		local var_28_0 = arg_28_0.shipBreakOutCfg[var_1_10005]

		assert = var_1_10007

		var_1_10007(var_28_0, "不存在配置" .. var_1_10005)

		local var_28_1 = arg_28_0.stages

		var_1_10007 = var_1_10007.Find(var_28_1, "stage" .. iter_28_0)
		onToggle = var_28_1

		local var_28_2 = arg_28_0
		local var_28_3 = var_1_10007

		local function var_28_4(arg_29_0)
			if arg_29_0 then
				local var_29_0 = var_28_0.breakout_view

				checkExist = var_2_10002
				pg = var_2_10003

				local var_29_1

				if not var_2_10002(var_2_10003.ship_data_template[var_28_0.breakout_id], {
					"specific_type"
				}) then
					var_29_1 = {}
				end

				ipairs = var_3

				for iter_29_0, iter_29_1 in var_3(var_29_1) do
					local var_29_2 = var_29_0
					local var_29_3 = "/"

					i18n = var_2_10010
					ShipType = var_2_10011
					var_29_0 = var_29_2 .. var_29_3 .. var_2_10010(var_2_10011.SpecificTableTips[iter_29_1])
				end

				changeToScrollText = var_3

				var_3(arg_28_0.breakView, var_29_0)

				local var_29_4 = arg_28_0

				var_3.switchStage(var_29_4, var_1_10005)
			end

			return
		end

		SFX_PANEL = var_1_10012

		var_28_1(var_28_2, var_28_3, var_28_4, var_1_10012)
	end

	local var_28_5 = arg_28_0.stages
	local var_28_6 = var_1.Find(var_28_5, "stage1")
	local var_28_7 = var_1.GetComponent

	typeof = iter_28_0
	Toggle = var_1_10005

	local var_28_8 = var_28_7(var_28_6, iter_28_0(var_1_10005)).group

	var_2.SetAllTogglesOff(var_28_8)

	table = var_2

	local var_28_9 = var_2.indexof(arg_28_0.breakIds, arg_28_0.shipVO.configId)

	math = var_3

	if var_3.clamp(var_28_9, 1, var_0_2) and var_2 >= 1 and var_2 <= var_0_2 then
		local var_28_10 = arg_28_0.stages
		local var_28_11 = var_3.Find(var_28_10, "stage" .. var_2)

		triggerToggle = var_28_10

		var_28_10(var_28_11, true)
	end

	return
end

local var_0_3 = {
	"durability",
	"cannon",
	"torpedo",
	"antiaircraft",
	"air",
	"antisub"
}

function var_0_1.showBarrage(arg_30_0)
	WeaponPreviewer = var_1_10001
	arg_30_0.previewer = var_1_10001.New(arg_30_0.rawImage)

	local var_30_0 = arg_30_0.previewer

	var_1.configUI(var_30_0, arg_30_0.healTF)

	local var_30_1 = arg_30_0.previewer

	var_1.setDisplayWeapon(var_30_1, arg_30_0:getWaponIdsById(arg_30_0.breakOutId))

	local var_30_2 = arg_30_0.previewer

	var_1.load(var_30_2, 40000, arg_30_0.shipVO, arg_30_0:getAllWeaponIds(), function()
		local var_31_0 = arg_30_0

		var_0.stopLoadingAni(var_31_0)

		return
	end)

	return
end

function var_0_1.getWaponIdsById(arg_32_0, arg_32_1)
	return arg_32_0.shipBreakOutCfg[arg_32_1].weapon_ids
end

function var_0_1.switchStage(arg_33_0, arg_33_1)
	if arg_33_0.breakOutId == arg_33_1 then
		return
	end

	arg_33_0.breakOutId = arg_33_1

	if arg_33_0.previewer then
		local var_33_0 = arg_33_0.previewer

		var_2.setDisplayWeapon(var_33_0, arg_33_0:getWaponIdsById(arg_33_0.breakOutId))
	end

	return
end

function var_0_1.getAllWeaponIds(arg_34_0)
	local var_34_0 = {}

	ipairs = var_1_10002

	for iter_34_0, iter_34_1 in var_1_10002(arg_34_0.breakIds) do
		Clone = var_1_10007
		var_1_10007 = var_1_10007(arg_34_0.shipBreakOutCfg[iter_34_1].weapon_ids)

		local var_34_1 = {
			__add = function(arg_35_0, arg_35_1)
				ipairs = var_2_10002

				for iter_35_0, iter_35_1 in var_2_10002(arg_35_0) do
					table = var_2_10007

					if not var_2_10007.contains(arg_35_1, iter_35_1) then
						table = var_2_10007

						var_2_10007.insert(arg_35_1, iter_35_1)
					end
				end

				return arg_35_1
			end
		}

		setmetatable = var_9

		var_9(var_34_0, var_34_1)

		var_34_0 = var_34_0 + var_1_10007
	end

	return var_34_0
end

function var_0_1.updateBreakOutView(arg_36_0, arg_36_1)
	arg_36_0.breakCfg = arg_36_0.shipBreakOutCfg[arg_36_1.configId]
	ipairs = var_2

	for iter_36_0, iter_36_1 in var_2(arg_36_0.itemTFs) do
		setActive = var_1_10007

		var_1_10007(iter_36_1, false)
	end

	local var_36_0 = arg_36_1
	local var_36_1 = arg_36_1.getShipProperties(var_36_0)

	Clone = var_36_0

	local var_36_2 = var_36_0(arg_36_1)

	var_36_2.configId = arg_36_0.breakCfg.breakout_id

	local var_36_3 = {}
	local var_36_4 = arg_36_0.breakCfg.breakout_id == 0
	local var_36_5 = arg_36_1:getBattleTotalExpend()
	local var_36_6
	local var_36_7
	local var_36_8 = arg_36_0.tipDeactive
	local var_36_9 = var_9.Find(var_36_8, "values/label")
	local var_36_10 = arg_36_0.tipDeactive
	local var_36_11 = var_10.Find(var_36_10, "values/value")

	setText = var_36_10

	var_36_10(var_36_9, "")

	setText = var_36_10

	var_36_10(var_36_11, "")

	if var_36_4 then
		var_36_3 = var_36_1
		var_36_6 = var_36_5
		setText = var_36_10

		local var_36_12 = var_36_9

		i18n = var_13

		var_36_10(var_36_12, var_13("word_level_upperLimit"))
	else
		var_36_7 = arg_36_0.shipTempCfg[arg_36_0.breakCfg.breakout_id].max_level
		var_36_3 = var_36_2:getShipProperties()
		var_36_3.level = var_36_7 >= arg_36_1:getMaxLevel() and var_36_7 or arg_36_1:getMaxLevel()
		var_36_6 = var_36_2:getBattleTotalExpend()
		setColorCount = var_11

		var_11(var_36_11, arg_36_0.shipVO.level, arg_36_0.breakCfg.level)

		setText = var_11

		local var_36_13 = var_36_9

		i18n = var_13

		var_11(var_36_13, var_13("word_level_require"))
	end

	local function var_36_14(arg_37_0, arg_37_1)
		setText = var_2_10002

		var_2_10002(arg_37_0:Find("name"), arg_37_1.name)

		setText = var_2_10002

		var_2_10002(arg_37_0:Find("value"), arg_37_1.preAttr)

		local var_37_0 = arg_37_0:Find("value1")
		local var_37_1 = arg_37_0:Find("addition")
		local var_37_2

		if arg_37_1.afterAttr == 0 then
			setColorStr = var_5
			var_37_2 = var_5(arg_37_1.afterAttr, "#FFFFFFFF")
		else
			setColorStr = var_5

			local var_37_3 = arg_37_1.afterAttr

			COLOR_GREEN = var_2_10007
			var_37_2 = var_5(var_37_3, var_2_10007)
		end

		setText = var_5

		var_5(var_37_0, var_37_2)

		setActive = var_5

		var_5(var_37_1, arg_37_1.afterAttr - arg_37_1.preAttr ~= 0)

		setText = var_5

		var_5(var_37_1, "(+" .. arg_37_1.afterAttr - arg_37_1.preAttr .. ")")

		return
	end

	local var_36_15 = 0

	if var_36_7 and var_36_7 ~= arg_36_0.shipTempCfg[arg_36_1.configId].max_level then
		local var_36_16 = arg_36_0.attrs
		local var_36_17, var_36_18 = var_13.Find(var_36_16, "attr_1"), var_36_14
		local var_36_19 = {
			preAttr = arg_36_0.shipTempCfg[arg_36_1.configId].max_level,
			afterAttr = var_36_7
		}

		i18n = var_17
		var_36_19.name = var_17("word_level_upperLimit")

		var_36_18(var_36_17, var_36_19)

		var_36_15 = 1
	end

	for iter_36_2 = 1, #var_0_3 do
		var_1_10018 = arg_36_0.attrs

		local var_36_20 = var_17.Find(var_1_10018, "attr_" .. var_36_15 + iter_36_2)

		setActive = var_1_10018

		var_1_10018(var_36_20, true)

		math = var_1_10018
		var_1_10018 = var_1_10018.floor(var_36_1[var_0_3[iter_36_2]])
		math = var_19

		local var_36_21 = var_19.floor(var_36_3[var_0_3[iter_36_2]])
		local var_36_22 = var_36_14
		local var_36_23 = var_36_20
		local var_36_24 = {
			preAttr = var_1_10018,
			afterAttr = var_36_21
		}

		i18n = var_1_10023
		var_36_24.name = var_1_10023("word_attr_" .. var_0_3[iter_36_2])

		var_36_22(var_36_23, var_36_24)
	end

	local var_36_25 = var_36_15 + #var_0_3 + 1
	local var_36_26 = arg_36_0.attrs
	local var_36_27 = var_14.Find(var_36_26, "attr_" .. var_36_25)

	setActive = var_36_26

	var_36_26(var_36_27, true)

	local var_36_28 = var_36_14
	local var_36_29 = var_36_27
	local var_36_30 = {
		preAttr = var_36_5,
		afterAttr = var_36_6
	}

	i18n = var_1_10018
	var_36_30.name = var_1_10018("word_attr_luck")

	var_36_28(var_36_29, var_36_30)

	for iter_36_3 = var_36_25 + 1, 8 do
		local var_36_31 = arg_36_0.attrs
		local var_36_32 = var_36_32.Find(var_36_31, "attr_" .. iter_36_3)

		setActive = var_36_31

		var_36_31(var_36_32, false)
	end

	removeAllChildren = var_15

	var_15(arg_36_0.starsFrom)

	for iter_36_4 = 1, arg_36_1:getStar() do
		cloneTplTo = var_36_32

		var_36_32(arg_36_0.starTpl, arg_36_0.starsFrom)
	end

	if var_36_4 then
		return
	end

	removeAllChildren = var_15

	var_15(arg_36_0.starsTo)

	if var_36_2:getStar() > arg_36_1:getStar() and not var_36_4 then
		for iter_36_5 = 1, var_36_2:getStar() do
			cloneTplTo = var_36_32

			var_36_32(arg_36_0.starTpl, arg_36_0.starsTo)
		end
	end

	setActive = var_15

	var_15(arg_36_0.appendStarTips, var_36_2:getStar() ~= arg_36_1:getStar())

	setActive = var_15

	var_15(arg_36_0.starOpera, var_36_2:getStar() ~= arg_36_1:getStar())

	local var_36_33 = arg_36_0.breakCfg.use_gold

	if arg_36_0.player.gold < var_36_33 then
		var_36_33 = "<color=#FB4A2C>" .. var_36_33 .. "</color>"
	end

	setText = var_16

	local var_36_34 = arg_36_0.tipActive

	var_16(var_17.Find(var_36_34, "text"), var_36_33)
	arg_36_0:initMaterialShips()

	return
end

function var_0_1.initMaterialShips(arg_38_0)
	local var_38_0 = arg_38_0.breakCfg.use_char_num

	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_38_1 = var_1_10002(var_1_10003)

	for iter_38_0 = 1, 3 do
		SetActive = var_1_10007

		var_1_10007(arg_38_0.itemTFs[iter_38_0], iter_38_0 <= var_38_0)

		local var_38_2 = arg_38_0.itemTFs[iter_38_0]

		var_1_10007 = var_1_10007.Find(var_38_2, "IconTpl")

		local var_38_3 = arg_38_0.contextData.materialShipIds
		local var_38_5

		if iter_38_0 <= var_38_0 and var_38_3 and var_38_3[iter_38_0] then
			local var_38_4 = var_38_1

			var_38_5 = var_38_1.getShipById(var_38_4, var_38_3[iter_38_0])
			updateShip = var_38_4

			var_38_4(var_1_10007, var_38_5, {
				initStar = true
			})

			SetActive = var_38_4

			var_38_4(var_1_10007, true)
		else
			SetActive = var_38_5

			var_38_5(var_1_10007, false)
		end

		onButton = var_38_5

		var_38_5(arg_38_0, arg_38_0.itemTFs[iter_38_0], function()
			local var_39_0 = arg_38_0
			local var_39_1 = var_0.emit

			ShipUpgradeMediator2 = var_2_10002

			var_39_1(var_39_0, var_2_10002.ON_SELECT_SHIP, arg_38_0.shipVO, var_38_0)

			return
		end)
	end

	return
end

function var_0_1.willExit(arg_40_0)
	arg_40_0:UnOverlayPanel(arg_40_0._tf)
	arg_40_0:recycleSpineChar()

	if arg_40_0.previewer then
		local var_40_0 = arg_40_0.previewer

		var_1.clear(var_40_0)

		arg_40_0.previewer = nil
	end

	if arg_40_0.dragTrigger then
		ClearEventTrigger = var_1

		var_1(arg_40_0.dragTrigger)

		arg_40_0.dragTrigger = nil
	end

	local var_40_1 = arg_40_0.destroyConfirmWindow

	var_1.Destroy(var_40_1)

	return
end

function var_0_1.playLoadingAni(arg_41_0)
	setActive = var_1_10001

	var_1_10001(arg_41_0.seaLoading, true)

	return
end

function var_0_1.stopLoadingAni(arg_42_0)
	setActive = var_1_10001

	var_1_10001(arg_42_0.seaLoading, false)

	return
end

function var_0_1.onBackPressed(arg_43_0)
	local var_43_0 = arg_43_0.destroyConfirmWindow

	if var_1.isShowing(var_43_0) then
		local var_43_1 = arg_43_0.destroyConfirmWindow

		var_1.ActionInvoke(var_43_1, "Hide")

		return
	end

	local var_43_2 = arg_43_0
	local var_43_3 = arg_43_0.emit

	BaseUI = var_1_10003

	var_43_3(var_43_2, var_1_10003.ON_BACK_PRESSED, true)

	return
end

return var_0_1
