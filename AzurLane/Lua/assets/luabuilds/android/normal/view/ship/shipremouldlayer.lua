class = var_0_10000

local var_0_0 = "ShipRemouldLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))
local var_0_2 = 5
local var_0_3 = 6
local var_0_4 = 1
local var_0_5 = 9
local var_0_6 = 55

Vector2 = var_0_10006

local var_0_7 = var_0_10006(-5, 25)

function var_0_1.getUIName(arg_1_0)
	return "ShipRemouldUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "ShipMainScene"
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.container = var_1.Find(var_3_0, "main/bg/container")

	local var_3_1 = arg_3_0.container

	arg_3_0.gridContainer = var_1.Find(var_3_1, "grids")

	local var_3_2 = arg_3_0.gridContainer

	arg_3_0.gridTF = var_1.Find(var_3_2, "grid_tpl")
	arg_3_0.height = arg_3_0.gridTF.sizeDelta.y + var_0_6
	arg_3_0.width = arg_3_0.gridTF.sizeDelta.x + var_0_5
	Vector2 = var_1
	arg_3_0.startPos = var_1(-1 * ((var_0_3 / 2 - 0.5) * arg_3_0.width) + var_0_7.x, (var_0_2 / 2 - 0.5) * arg_3_0.height + var_0_7.y)
	arg_3_0.containerWidth = var_0_3 * arg_3_0.gridTF.sizeDelta.x + (var_0_3 - 1) * var_0_5
	arg_3_0.containerHeight = var_0_2 * arg_3_0.gridTF.sizeDelta.y + (var_0_2 - 1) * var_0_6

	local var_3_3 = arg_3_0.container

	Vector2 = var_2
	var_3_3.sizeDelta = var_2(arg_3_0.containerWidth, arg_3_0.containerHeight)
	setActive = var_3_3

	var_3_3(arg_3_0.gridTF, false)

	local var_3_4 = arg_3_0._tf

	arg_3_0.infoPanel = var_1.Find(var_3_4, "main/info_panel")

	local var_3_5 = arg_3_0.infoPanel

	arg_3_0.itemContainer = var_1.Find(var_3_5, "usages/items")

	local var_3_6 = arg_3_0.itemContainer

	arg_3_0.itemTF = var_1.Find(var_3_6, "itemTF")

	local var_3_7 = arg_3_0.infoPanel
	local var_3_8 = var_1.Find(var_3_7, "name_container/Text")
	local var_3_9 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_3_0.infoName = var_3_9(var_3_8, var_3(var_4))

	local var_3_10 = arg_3_0.infoPanel

	arg_3_0.attrContainer = var_1.Find(var_3_10, "align/attrs")
	arg_3_0.attrTpl = arg_3_0:getTpl("attr", arg_3_0.attrContainer)
	arg_3_0.attrTplD = arg_3_0:getTpl("attrd", arg_3_0.attrContainer)

	local var_3_11 = arg_3_0.infoPanel

	arg_3_0.confirmBtn = var_1.Find(var_3_11, "confirm_btn/activity")

	local var_3_12 = arg_3_0.infoPanel

	arg_3_0.inactiveBtn = var_1.Find(var_3_12, "confirm_btn/inactivity")

	local var_3_13 = arg_3_0.infoPanel

	arg_3_0.completedteBtn = var_1.Find(var_3_13, "confirm_btn/complete")

	local var_3_14 = arg_3_0._tf

	arg_3_0.shipTF = var_1.Find(var_3_14, "main/info_panel/usages/shipTF")

	local var_3_15 = arg_3_0.infoPanel

	arg_3_0.skillDesc = var_1.Find(var_3_15, "align/skill_desc/text")

	local var_3_16 = arg_3_0.infoPanel

	arg_3_0.shipContainer = var_1.Find(var_3_16, "char_container")

	local var_3_17 = arg_3_0._tf

	arg_3_0.lineTpl = var_1.Find(var_3_17, "resources/line")

	local var_3_18 = arg_3_0.container

	arg_3_0.lineContainer = var_1.Find(var_3_18, "grids/lines")
	GameObject = var_1
	arg_3_0.helpBtn = var_1.Find("/OverlayCamera/Overlay/UIMain/common/help_btn")
	IsNil = var_1

	if not var_1(arg_3_0.helpBtn) then
		setActive = var_1

		var_1(arg_3_0.helpBtn, false)
	end

	local var_3_19 = arg_3_0._tf

	arg_3_0.tooltip = var_1.Find(var_3_19, "tooltip")
	setActive = var_1

	var_1(arg_3_0.tooltip, false)

	return
end

function var_0_1.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.playerVO = arg_4_1

	if arg_4_0.curtransformId then
		arg_4_0:updateInfo(arg_4_0.curtransformId)
	end

	return
end

function var_0_1.setItems(arg_5_0, arg_5_1)
	arg_5_0.itemsVO = arg_5_1

	return
end

function var_0_1.getItemCount(arg_6_0, arg_6_1)
	local var_6_0

	if not arg_6_0.itemsVO[arg_6_1] then
		Item = var_6_0
		var_6_0 = var_6_0.New({
			count = 0,
			id = arg_6_1
		})
	end

	return var_6_0.count
end

function var_0_1.setShipVO(arg_7_0, arg_7_1)
	arg_7_0.shipVO = arg_7_1
	math = var_1_10002

	local var_7_0 = var_1_10002.floor
	local var_7_1 = arg_7_0.shipVO

	arg_7_0.shipGroupId = var_7_0(var_3.getGroupId(var_7_1))

	return
end

function var_0_1.getShipTranformData(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.ship_data_trans[arg_8_0.shipGroupId]

	assert = var_2

	var_2(var_8_0, "config missed [pg.ship_data_trans] shipGroup>>>." .. arg_8_0.shipGroupId)

	local var_8_1 = {}

	ipairs = var_3

	for iter_8_0, iter_8_1 in var_3(var_8_0.transform_list) do
		ipairs = var_1_10008

		for iter_8_2, iter_8_3 in var_1_10008(iter_8_1) do
			local var_8_2 = iter_8_3[2]

			Vector2 = var_1_10014
			var_8_1[var_8_2] = var_1_10014(iter_8_0, iter_8_3[1])
		end
	end

	return var_8_1
end

function var_0_1.didEnter(arg_9_0)
	arg_9_0:initTranformInfo()
	arg_9_0:initShipModel()

	return
end

function var_0_1.initTranformInfo(arg_10_0)
	arg_10_0.transformIds = arg_10_0:getShipTranformData()
	arg_10_0.grids = {}
	pairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.transformIds) do
		cloneTplTo = var_1_10006
		var_1_10006 = var_1_10006(arg_10_0.gridTF, arg_10_0.gridContainer)
		go = var_7

		local var_10_0 = var_7(var_1_10006)

		var_10_0.name = iter_10_0
		Vector2 = var_10_0
		var_1_10006.localPosition = var_10_0(arg_10_0.startPos.x + arg_10_0.width * (iter_10_1.x - 1), arg_10_0.startPos.y - arg_10_0.height * (iter_10_1.y - 1))
		onToggle = var_7

		local var_10_1 = arg_10_0
		local var_10_2 = var_1_10006

		local function var_10_3(arg_11_0)
			if arg_11_0 and arg_10_0.curtransformId ~= iter_10_0 then
				local var_11_0 = arg_10_0

				var_1.updateInfo(var_11_0, iter_10_0)
			end

			return
		end

		SFX_PANEL = var_11

		var_7(var_10_1, var_10_2, var_10_3, var_11)

		arg_10_0.grids[iter_10_0] = var_1_10006
	end

	arg_10_0.lineTFs = {}
	pairs = var_1

	for iter_10_2, iter_10_3 in var_1(arg_10_0.transformIds) do
		arg_10_0:initLines(iter_10_2)
	end

	arg_10_0.posTransId = {}

	arg_10_0:updateLines()

	if arg_10_0.contextData.transformId then
		assert = var_1

		var_1(arg_10_0.grids[arg_10_0.contextData.transformId], "without this transform id:" .. arg_10_0.contextData.transformId)

		triggerToggle = var_1

		var_1(arg_10_0.grids[arg_10_0.contextData.transformId], true)
	end

	return
end

function var_0_1.initLines(arg_12_0, arg_12_1)
	local var_12_0 = 270
	local var_12_1 = 75

	arg_12_0.lineTFs[arg_12_1] = {}

	local var_12_2 = arg_12_0.transformIds[arg_12_1].x
	local var_12_3 = arg_12_0.transformIds[arg_12_1].y
	local var_12_4 = arg_12_0.grids[arg_12_1].sizeDelta
	local var_12_5 = var_6.localPosition
	local var_12_6 = arg_12_0.lineTpl

	pg = var_1_10010

	local var_12_7 = var_1_10010.transform_data_template[arg_12_1].condition_id

	pairs = var_1_10011

	for iter_12_0, iter_12_1 in var_1_10011(var_12_7) do
		local var_12_8 = arg_12_0.transformIds[iter_12_1].x
		local var_12_9 = arg_12_0.transformIds[iter_12_1].y

		Vector2 = var_1_10018
		var_1_10018 = var_1_10018(var_12_8 - var_12_2, var_12_9 - var_12_3)
		Vector2 = var_19

		if var_1_10018 ~= var_19.zero then
			cloneTplTo = var_19

			local var_12_10 = var_19(var_12_6, arg_12_0.lineContainer, var_12_2 .. "-" .. var_12_3 .. "-v")

			cloneTplTo = var_20

			local var_12_11 = var_20(var_12_6, arg_12_0.lineContainer, var_12_2 .. "-" .. var_12_3 .. "-h")
			local var_12_12 = var_1_10018.y < 0 and 90 or -90

			Vector3 = var_22
			var_12_10.eulerAngles = var_22(0, 0, var_12_12)

			local var_12_13 = var_1_10018.x < 0 and 180 or 0

			Vector3 = var_23
			var_12_11.eulerAngles = var_23(0, 0, var_12_13)
			math = var_23

			local var_12_14 = var_23.abs(var_1_10018.y)

			if 0 < var_12_14 then
				math = var_12_14

				local var_12_15 = var_12_14.abs(var_1_10018.x)
				local var_12_16

				if not (0 < var_12_15) then
					var_12_16 = false
				else
					var_12_16 = true
				end

				local var_12_17, var_12_18

				if var_12_16 then
					var_12_17 = var_12_5.y + (var_12_3 - var_12_9) * var_12_0
					Vector2 = var_12_18
					var_12_11.localPosition = var_12_18(var_12_5.x, var_12_17, 0)

					if not (var_1_10018.y < 0) or not (var_12_5.y + var_12_4.y / 2) then
						var_12_18 = var_12_5.y - var_12_4.y / 2
					end

					Vector2 = var_26
					var_12_10.localPosition = var_26(var_12_5.x, var_12_18)
					Vector2 = var_26
					math = var_27
					var_12_11.sizeDelta = var_26(var_27.abs(var_1_10018.x) * var_12_0, var_12_11.sizeDelta.y)
					Vector2 = var_26
					math = var_27
					var_12_10.sizeDelta = var_26(var_27.abs(var_1_10018.y) * var_12_0 - var_12_4.y / 2, var_12_10.sizeDelta.y)

					local var_12_19 = var_1_10018.x < 0 and var_12_12 < 0 and -1 or 1
					local var_12_20 = var_12_10
					local var_12_21 = var_12_10.Find(var_12_20, "corner")

					Vector3 = var_12_20
					var_12_21.localScale = var_12_20(1, var_12_19, 1)
				else
					Vector2 = var_12_17
					math = var_12_18
					var_12_11.sizeDelta = var_12_17(var_12_18.abs(var_1_10018.x) * var_12_0, var_12_11.sizeDelta.y)
					Vector2 = var_12_17
					math = var_25
					var_12_10.sizeDelta = var_12_17(var_25.abs(var_1_10018.y) * var_12_1, var_12_10.sizeDelta.y)
					var_12_11.localPosition = var_12_5

					if not (var_1_10018.y < 0) or not (var_12_5.y + var_12_4.y / 2) then
						var_12_17 = var_12_5.y - var_12_4.y / 2
					end

					Vector3 = var_25
					var_12_10.localPosition = var_25(var_12_5.x, var_12_17, 0)
				end

				setActive = var_12_17

				local var_12_22 = var_12_10
				local var_12_23 = var_12_10.Find(var_12_22, "arr")

				if not var_12_16 then
					::label_12_0::

					math = var_12_22
					var_12_22 = var_12_22.abs(var_1_10018.y) > 0
				end

				var_12_17(var_12_23, var_12_22)

				setActive = var_12_17

				var_12_17(var_12_10:Find("corner"), var_12_16)

				setActive = var_12_17

				var_12_17(var_12_11:Find("arr"), false)

				setActive = var_12_17

				var_12_17(var_12_11:Find("corner"), false)

				table = var_12_17

				var_12_17.insert(arg_12_0.lineTFs[arg_12_1], {
					id = iter_12_1,
					hrz = var_12_11,
					vec = var_12_10
				})
			end
		end
	end

	return
end

function var_0_1.updateLines(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0.transformIds) do
		arg_13_0:updateGridTF(iter_13_0)

		if arg_13_0:canRemould(iter_13_0) or arg_13_0:isFinished(iter_13_0) then
			ipairs = var_6

			local var_13_0

			if not arg_13_0.lineTFs[iter_13_0] then
				var_13_0 = {}
			end

			for iter_13_2, iter_13_3 in var_6(var_13_0) do
				local var_13_1 = iter_13_3.hrz

				var_11.GetComponent(var_13_1, "UIGrayScale").enabled = false

				local var_13_2 = iter_13_3.vec

				var_11.GetComponent(var_13_2, "UIGrayScale").enabled = false
			end
		end
	end

	return
end

function var_0_1.getLevelById(arg_14_0, arg_14_1)
	pg = var_1_10002

	return var_1_10002.transform_data_template[arg_14_1].level_limit
end

function var_0_1.getTransformLevel(arg_15_0, arg_15_1)
	if not arg_15_0.shipVO.transforms[arg_15_1] then
		return 0
	else
		return arg_15_0.shipVO.transforms[arg_15_1].level
	end

	return
end

var_0_1.STATE_FINISHED = 1
var_0_1.STATE_ACTIVE = 2
var_0_1.STATE_LOCK = 3

function var_0_1.getTransformState(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.getTransformLevel(var_16_0, arg_16_1)

	pg = var_16_0

	if var_16_1 == var_16_0.transform_data_template[arg_16_1].max_level then
		return var_0_1.STATE_FINISHED
	elseif arg_16_0:canRemould(arg_16_1) then
		return var_0_1.STATE_ACTIVE
	else
		return var_0_1.STATE_LOCK
	end

	return
end

function var_0_1.updateGridTF(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.grids[arg_17_1]

	pg = var_1_10003

	local var_17_1 = var_1_10003.transform_data_template[arg_17_1]

	setText = var_1_10004

	var_1_10004(var_17_0:Find("name"), var_17_1.name)

	local var_17_2 = var_17_0:Find("icon")
	local var_17_3 = var_4.GetComponent

	typeof = var_6
	Image = var_7

	local var_17_4 = var_17_3(var_17_2, var_6(var_7))

	GetSpriteFromAtlasAsync = var_17_2

	var_17_2("modicon", var_17_1.icon, function(arg_18_0)
		IsNil = var_2_10001

		if not var_2_10001(var_17_4) then
			var_17_4.sprite = arg_18_0
		end

		return
	end)

	local var_17_5 = arg_17_0
	local var_17_6 = arg_17_0.getTransformState(var_17_5, arg_17_1)

	setActive = var_17_5

	var_17_5(var_17_0:Find("bgs/finished"), var_17_6 == var_0_1.STATE_FINISHED)

	setActive = var_17_5

	var_17_5(var_17_0:Find("bgs/ongoing"), var_17_6 == var_0_1.STATE_ACTIVE)

	setActive = var_17_5

	var_17_5(var_17_0:Find("bgs/lock"), var_17_6 == var_0_1.STATE_LOCK)

	setActive = var_17_5

	var_17_5(var_17_0:Find("tags/finished"), var_17_6 == var_0_1.STATE_FINISHED)

	setActive = var_17_5

	var_17_5(var_17_0:Find("tags/ongoing"), var_17_6 == var_0_1.STATE_ACTIVE)

	setActive = var_17_5

	var_17_5(var_17_0:Find("tags/lock"), var_17_6 == var_0_1.STATE_LOCK)

	local var_17_7 = arg_17_0:getTransformLevel(arg_17_1)
	local var_17_8 = var_17_0:Find("icon/progress")

	if var_17_6 == var_0_1.STATE_FINISHED then
		setText = var_8

		var_8(var_17_8, var_17_7 .. "/" .. var_17_1.max_level)
	elseif var_17_6 == var_0_1.STATE_ACTIVE then
		setText = var_8

		var_8(var_17_8, var_17_7 .. "/" .. var_17_1.max_level)
	elseif var_17_6 == var_0_1.STATE_LOCK then
		local var_17_9, var_17_10, var_17_11 = arg_17_0:canRemould(arg_17_1)

		setText = var_1_10011

		var_1_10011(var_17_8, "")

		setActive = var_1_10011

		var_1_10011(var_17_0:Find("tags/lock/lock_prev"), var_17_11 and var_17_11[1] == 1)

		setActive = var_1_10011

		var_1_10011(var_17_0:Find("tags/lock/lock_level"), var_17_11 and var_17_11[1] == 2)

		setActive = var_1_10011

		var_1_10011(var_17_0:Find("tags/lock/lock_star"), var_17_11 and var_17_11[1] == 3)

		if var_17_11 and var_17_11[1] == 2 then
			setText = var_11

			var_11(var_17_0:Find("tags/lock/lock_level/Text"), var_17_11[2])
		elseif var_17_11 and var_17_11[1] == 3 then
			setText = var_11

			var_11(var_17_0:Find("tags/lock/lock_star/Text"), var_17_11[2])
		end
	end

	local var_17_12 = arg_17_0.transformIds[arg_17_1].x .. "_" .. arg_17_0.transformIds[arg_17_1].y
	local var_17_13

	if not arg_17_0.posTransId[var_17_12] then
		var_17_13 = arg_17_0.posTransId
		var_17_13[var_17_12] = arg_17_1
	elseif arg_17_0.posTransId[var_17_12] == arg_17_1 then
		-- block empty
	elseif var_17_6 == var_0_1.STATE_ACTIVE or arg_17_0:getTransformState(arg_17_0.posTransId[var_17_12]) ~= var_0_1.STATE_ACTIVE and arg_17_1 < arg_17_0.posTransId[var_17_12] then
		if arg_17_0.posTransId[var_17_12] == arg_17_0.curtransformId then
			arg_17_0.curtransformId = arg_17_1
		end

		setActive = var_17_13

		var_17_13(arg_17_0.grids[arg_17_0.posTransId[var_17_12]], false)

		var_17_13 = arg_17_0.posTransId
		var_17_13[var_17_12] = arg_17_1
	end

	setActive = var_17_13

	var_17_13(var_17_0, arg_17_1 == arg_17_0.posTransId[var_17_12])

	if arg_17_0.curtransformId == arg_17_1 then
		arg_17_0:updateInfo(arg_17_1)
	end

	return
end

function var_0_1.initShipModel(arg_19_0)
	local var_19_0 = arg_19_0.shipVO
	local var_19_1 = var_1.getPrefab(var_19_0)

	if arg_19_0.shipContainer.childCount ~= 0 then
		var_1_10003 = arg_19_0.shipModel

		var_2.Dispose(var_1_10003)
	end

	local function var_19_2(arg_20_0)
		IsNil = var_2_10001

		if not var_2_10001(arg_19_0._tf) then
			arg_19_0.shipModel = arg_20_0

			local var_20_0 = arg_20_0
			local var_20_1 = arg_20_0.SetLayer

			Layer = var_2_10003

			var_20_1(var_20_0, var_2_10003.UI)

			local var_20_2 = arg_20_0
			local var_20_3 = arg_20_0.SetLocalScale

			Vector3 = var_3

			var_20_3(var_20_2, var_3(var_0_4, var_0_4, 1))
			arg_20_0:SetParent(arg_19_0.shipContainer)

			local var_20_4 = arg_20_0
			local var_20_5 = arg_20_0.SetLocalPosition

			Vector2 = var_3

			var_20_5(var_20_4, var_3(0, 10))
			arg_20_0:SetAction("stand2", 0)
		end

		return
	end

	SpineAnimChar = var_1_10003

	local var_19_3 = var_1_10003.New()

	var_3.SetPaint(var_19_3, var_19_1)
	var_3:Load(true, function(arg_21_0)
		var_19_2(arg_21_0)

		return
	end)

	return
end

function var_0_1.updateInfo(arg_22_0, arg_22_1)
	if arg_22_0:isFinished(arg_22_1) then
		arg_22_0:updateFinished(arg_22_1)
	else
		arg_22_0:updateProgress(arg_22_1)
	end

	return
end

function var_0_1.updateFinished(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.shipVO.transforms[arg_23_1].level

	arg_23_0.curtransformId = arg_23_1
	pg = var_1_10003

	local var_23_1 = var_1_10003.transform_data_template[arg_23_1]

	arg_23_0.infoName.text = var_23_1.name

	local var_23_2 = {}

	for iter_23_0 = 1, var_23_0 do
		_ = var_1_10009

		var_1_10009.each(var_23_1.use_item[iter_23_0], function(arg_24_0)
			_ = var_2_10001

			if not var_2_10001.detect(var_23_2, function(arg_25_0)
				local var_25_0 = arg_25_0.type

				DROP_TYPE_ITEM = var_3_10002

				return var_25_0 == var_3_10002 and arg_25_0.id == arg_24_0[1]
			end) then
				table = var_2

				local var_24_0 = var_2.insert
				local var_24_1 = var_23_2
				local var_24_2 = {}

				DROP_TYPE_ITEM = var_2_10005
				var_24_2.type = var_2_10005
				var_24_2.id = arg_24_0[1]
				var_24_2.count = arg_24_0[2]

				var_24_0(var_24_1, var_24_2)
			else
				var_1.count = var_1.count + arg_24_0[2]
			end

			return
		end)
	end

	table = var_5

	local var_23_3 = var_5.insert
	local var_23_4 = var_23_2
	local var_23_5 = {}

	DROP_TYPE_ITEM = iter_23_0
	var_23_5.type = iter_23_0
	id2ItemId = iter_23_0
	PlayerConst = var_1_10009
	var_23_5.id = iter_23_0(var_1_10009.ResGold)
	var_23_5.count = var_23_1.use_gold * var_23_0

	var_23_3(var_23_4, var_23_5)

	for iter_23_1 = arg_23_0.itemContainer.childCount, #var_23_2 - 1 do
		cloneTplTo = var_1_10010

		var_1_10010(arg_23_0.itemTF, arg_23_0.itemContainer)
	end

	local var_23_6 = arg_23_0.itemContainer.childCount

	for iter_23_2 = 1, var_23_6 do
		local var_23_7 = arg_23_0.itemContainer
		local var_23_8 = var_10.GetChild(var_23_7, iter_23_2 - 1)

		setActive = var_23_7

		var_23_7(var_23_8, iter_23_2 <= #var_23_2)

		if iter_23_2 <= #var_23_2 then
			updateDrop = var_11

			var_11(var_23_8:Find("IconTpl"), var_23_2[iter_23_2])

			RemoveComponent = var_11

			local var_23_9 = var_23_8

			typeof = var_13
			Button = var_14

			var_11(var_23_9, var_13(var_14))
		end
	end

	setActive = var_6

	local var_23_10 = arg_23_0.shipTF
	local var_23_11 = var_23_1.use_ship

	var_6(var_23_10, 0 < var_23_11)

	if var_23_1.use_ship > 0 then
		setActive = var_6

		local var_23_12 = arg_23_0.shipTF

		var_6(var_7.Find(var_23_12, "addTF"), false)

		setActive = var_6

		local var_23_13 = arg_23_0.shipTF

		var_6(var_7.Find(var_23_13, "IconTpl"), true)

		updateDrop = var_6

		local var_23_14 = arg_23_0.shipTF
		local var_23_15 = var_7.Find(var_23_14, "IconTpl")
		local var_23_16 = {}

		DROP_TYPE_SHIP = var_9
		var_23_16.type = var_9
		var_23_16.id = arg_23_0.shipVO.configId

		var_6(var_23_15, var_23_16)

		removeOnButton = var_6

		var_6(arg_23_0.shipTF)
	end

	setActive = var_6

	var_6(arg_23_0.skillDesc.parent, var_23_1.skill_id ~= 0)

	local var_23_17, var_23_18

	if var_23_1.skill_id ~= 0 then
		pg = var_23_17
		var_23_17 = var_23_17.skill_data_template[var_23_1.skill_id].name
		setText = var_7
		var_23_18 = arg_23_0.skillDesc
		i18n = var_9

		var_7(var_23_18, var_9("ship_remould_material_unlock_skill", var_23_17))
	end

	removeAllChildren = var_23_17

	var_23_17(arg_23_0.attrContainer)

	local var_23_19
	local var_23_20

	_ = var_23_18

	var_23_18.each(var_23_1.ship_id, function(arg_26_0)
		if arg_26_0[1] == arg_23_0.shipVO.configId then
			var_23_19 = arg_26_0[2]
		end

		pg = var_1

		if var_1.ship_data_template[arg_26_0[1]].group_type == arg_23_0.shipVO.groupId then
			pg = var_1
			var_23_20 = var_1.ship_data_statistics[arg_26_0[2]].type
		end

		return
	end)

	local var_23_21

	if var_23_20 then
		cloneTplTo = var_23_21
		var_23_21 = var_23_21(arg_23_0.attrTplD, arg_23_0.attrContainer)
		setText = var_9

		local var_23_22 = var_23_21
		local var_23_23 = var_23_21.Find(var_23_22, "name")

		i18n = var_23_22

		var_9(var_23_23, var_23_22("common_ship_type"))

		setText = var_9

		local var_23_24 = var_23_21
		local var_23_25 = var_23_21.Find(var_23_24, "value")

		ShipType = var_23_24

		var_9(var_23_25, var_23_24.Type2Name(var_23_20))

		local var_23_26 = var_23_21
		local var_23_27 = var_23_21.Find(var_23_26, "quest")

		setActive = var_23_26

		var_23_26(var_23_27, true)

		onButton = var_23_26

		var_23_26(arg_23_0, var_23_21, function()
			local var_27_0 = arg_23_0

			var_0.showToolTip(var_27_0, arg_23_1)

			return
		end)
	else
		_ = var_23_21
		var_23_21 = var_23_21.reduce(var_23_1.effect, {}, function(arg_28_0, arg_28_1)
			pairs = var_2_10002

			for iter_28_0, iter_28_1 in var_2_10002(arg_28_1) do
				local var_28_0

				if not arg_28_0[iter_28_0] then
					var_28_0 = 0
				end

				arg_28_0[iter_28_0] = var_28_0 + iter_28_1
			end

			return arg_28_0
		end)

		local var_23_28 = arg_23_0.shipVO
		local var_23_29 = var_9.getShipProperties(var_23_28)

		pairs = var_23_28

		for iter_23_3, iter_23_4 in var_23_28(var_23_29) do
			if var_23_21[iter_23_3] then
				cloneTplTo = var_15

				local var_23_30 = var_15(arg_23_0.attrTplD, arg_23_0.attrContainer)
				local var_23_31 = arg_23_0
				local var_23_32 = arg_23_0.updateAttrTF_D
				local var_23_33 = var_23_30
				local var_23_34 = {}

				AttributeType = var_1_10020
				var_23_34.attrName = var_1_10020.Type2Name(iter_23_3)
				math = var_1_10020
				var_23_34.value = var_1_10020.floor(iter_23_4)
				var_23_34.addition = var_23_21[iter_23_3]

				var_23_32(var_23_31, var_23_33, var_23_34)
			end
		end

		pg = var_10

		local var_23_35 = var_10.ship_data_template[arg_23_0.shipVO.configId]

		for iter_23_5 = 1, 3 do
			if var_23_21["equipment_proficiency_" .. iter_23_5] then
				EquipType = var_15

				local var_23_36 = var_15.Types2Title(iter_23_5, arg_23_0.shipVO.configId)

				EquipType = var_16

				local var_23_37 = var_16.LabelToName(var_23_36)

				i18n = var_17

				local var_23_38 = var_23_37 .. var_17("common_proficiency")

				cloneTplTo = var_17

				local var_23_39 = var_17(arg_23_0.attrTplD, arg_23_0.attrContainer)
				local var_23_40 = arg_23_0
				local var_23_41 = arg_23_0.updateAttrTF_D
				local var_23_42 = var_23_39
				local var_23_43 = {
					attrName = var_23_38
				}
				local var_23_44 = arg_23_0.shipVO

				var_23_43.value = var_22.getEquipProficiencyByPos(var_23_44, iter_23_5) * 100
				var_23_43.addition = var_23_21["equipment_proficiency_" .. iter_23_5] * 100

				var_23_41(var_23_40, var_23_42, var_23_43, true)
			end
		end
	end

	setActive = var_23_21

	var_23_21(arg_23_0.confirmBtn, false)

	setActive = var_23_21

	var_23_21(arg_23_0.inactiveBtn, false)

	setActive = var_23_21

	var_23_21(arg_23_0.completedteBtn, arg_23_0:isFinished(arg_23_1))

	arg_23_0.contextData.transformId = arg_23_1

	return
end

function var_0_1.updateProgress(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.getTransformLevel(var_29_0, arg_29_1) + 1

	arg_29_0.curtransformId = arg_29_1
	pg = var_29_0

	local var_29_2 = var_29_0.transform_data_template[arg_29_1]

	arg_29_0.infoName.text = var_29_2.name

	local var_29_3, var_29_4 = arg_29_0:canRemould(arg_29_1)
	local var_29_5

	if not var_29_2.effect[var_29_1] then
		var_29_5 = {}
	end

	setActive = var_1_10007

	var_1_10007(arg_29_0.shipTF, false)

	setText = var_1_10007

	var_1_10007(arg_29_0.skillDesc, "")

	local var_29_6

	if var_29_2.use_item[var_29_1] then
		Clone = var_8
		var_29_6 = var_8(var_29_2.use_item[var_29_1])
	else
		var_29_6 = {}
	end

	local var_29_7

	if var_29_2.use_gold > 0 then
		table = var_29_7
		var_29_7 = var_29_7.insert

		local var_29_8 = var_29_6
		local var_29_9 = {}

		id2ItemId = var_1_10011
		PlayerConst = var_1_10012
		var_29_9[1] = var_1_10011(var_1_10012.ResGold)
		var_29_9[2] = var_29_2.use_gold

		var_29_7(var_29_8, var_29_9)
	end

	setActive = var_29_7

	var_29_7(arg_29_0.shipTF, var_29_2.use_ship ~= 0)

	local var_29_16

	if var_29_2.use_ship ~= 0 then
		local var_29_10

		if arg_29_0.contextData.materialShipIds then
			::label_29_0::

			table = var_29_10
			var_29_10 = var_29_10.getCount(var_29_16) ~= 0
		end

		setActive = var_10

		local var_29_11 = arg_29_0.shipTF

		var_10(var_1_10011.Find(var_29_11, "IconTpl"), var_29_10)

		setActive = var_10

		local var_29_12 = arg_29_0.shipTF

		var_10(var_1_10011.Find(var_29_12, "addTF"), not var_29_10)

		if var_29_10 then
			updateDrop = var_10

			local var_29_13 = arg_29_0.shipTF

			var_1_10011 = var_1_10011.Find(var_29_13, "IconTpl")

			local var_29_14 = {}

			getProxy = var_1_10013
			BayProxy = var_1_10014
			var_1_10014 = var_1_10013(var_1_10014)
			var_29_14.id = var_1_10013.getShipById(var_1_10014, var_29_16[1]).configId
			DROP_TYPE_SHIP = var_1_10013
			var_29_14.type = var_1_10013

			var_10(var_1_10011, var_29_14)
		end

		onButton = var_10
		var_1_10011 = arg_29_0

		local var_29_15 = arg_29_0.shipTF

		function var_1_10013()
			local var_30_1

			if var_29_3 then
				local var_30_0 = arg_29_0

				var_30_1 = var_30_1.emit
				ShipRemouldMediator = var_2_10002

				var_30_1(var_30_0, var_2_10002.ON_SELECTE_SHIP, arg_29_0.shipVO)
			else
				pg = var_30_1

				local var_30_2 = var_30_1.TipsMgr.GetInstance()

				var_0.ShowTips(var_30_2, var_29_4)
			end

			return
		end

		SFX_PANEL = var_1_10014

		var_10(var_1_10011, var_29_15, var_1_10013, var_1_10014)
	else
		var_29_16 = arg_29_0.contextData
		var_29_16.materialShipIds = nil
	end

	setActive = var_29_16

	var_29_16(arg_29_0.skillDesc.parent, var_29_2.skill_id ~= 0)

	if var_29_2.skill_id ~= 0 then
		pg = var_8

		local var_29_17 = var_8.skill_data_template[var_29_2.skill_id].name

		setText = var_9

		local var_29_18 = arg_29_0.skillDesc

		i18n = var_1_10011

		var_9(var_29_18, var_1_10011("ship_remould_material_unlock_skill", var_29_17))
	end

	for iter_29_0 = arg_29_0.itemContainer.childCount, #var_29_6 - 1 do
		cloneTplTo = var_1_10013

		var_1_10013(arg_29_0.itemTF, arg_29_0.itemContainer)
	end

	local var_29_19 = arg_29_0.itemContainer.childCount

	for iter_29_1 = 1, var_29_19 do
		local var_29_20 = arg_29_0.itemContainer
		local var_29_21 = var_13.GetChild(var_29_20, iter_29_1 - 1)

		setActive = var_29_20

		local var_29_22 = var_29_21

		iter_29_4 = iter_29_1 <= #var_29_6

		var_29_20(var_29_22, iter_29_4)

		if iter_29_1 <= #var_29_6 then
			local var_29_23 = var_29_6[iter_29_1]
			local var_29_24 = ""

			iter_29_4 = var_29_23[1]
			id2ItemId = var_1_10017
			PlayerConst = var_1_10018

			if iter_29_4 == var_1_10017(var_1_10018.ResGold) then
				iter_29_4 = arg_29_0.playerVO.gold
				iter_29_4 = var_29_23[2] <= iter_29_4
				setColorStr = var_1_10017
				var_1_10018 = var_29_23[2]

				if iter_29_4 then
					COLOR_WHITE = var_1_10019

					if not var_1_10019 then
						COLOR_RED = var_1_10019
					end

					var_29_24 = var_1_10017(var_1_10018, var_1_10019)

					if iter_29_4 then
						RemoveComponent = var_1_10017
						var_1_10018 = var_29_21
						typeof = var_1_10019
						Button = var_1_10020

						var_1_10017(var_1_10018, var_1_10019(var_1_10020))
					else
						onButton = var_1_10017

						var_1_10017(arg_29_0, var_29_21, function()
							ItemTipPanel = var_2_10000

							var_2_10000.ShowGoldBuyTip(var_29_23[2])

							return
						end)

						var_1_10018 = var_29_21
						var_1_10017 = var_29_21.GetComponent
						typeof = var_1_10019
						Button = var_1_10020
						var_1_10017 = var_1_10017(var_1_10018, var_1_10019(var_1_10020))
						var_1_10019 = var_29_21
						var_1_10019 = var_29_21.Find(var_1_10019, "IconTpl/icon_bg/icon")
						var_1_10018 = var_1_10018.GetComponent
						typeof = var_1_10020
						Image = var_1_10021
						var_1_10017.targetGraphic = var_1_10018(var_1_10019, var_1_10020(var_1_10021))
					end

					goto label_29_1

					var_1_10017 = arg_29_0
					iter_29_4 = arg_29_0.getItemCount(var_1_10017, var_29_23[1])
					iter_29_4 = var_29_23[2] <= iter_29_4
					setColorStr = var_1_10017
					var_1_10019 = arg_29_0
					var_1_10018 = arg_29_0.getItemCount(var_1_10019, var_29_23[1])

					if iter_29_4 then
						COLOR_WHITE = var_1_10019

						if not var_1_10019 then
							COLOR_RED = var_1_10019
						end

						var_29_24 = var_1_10017(var_1_10018, var_1_10019) .. "/" .. var_29_23[2]

						if not iter_29_4 then
							ItemTipPanel = var_1_10017

							if not var_1_10017.CanShowTip(var_29_23[1]) then
								RemoveComponent = var_1_10017
								var_1_10018 = var_29_21
								typeof = var_1_10019
								Button = var_1_10020

								var_1_10017(var_1_10018, var_1_10019(var_1_10020))
							else
								onButton = var_1_10017

								var_1_10017(arg_29_0, var_29_21, function()
									ItemTipPanel = var_2_10000

									var_2_10000.ShowItemTipbyID(var_29_23[1])

									return
								end)

								var_1_10018 = var_29_21
								var_1_10017 = var_29_21.GetComponent
								typeof = var_1_10019
								Button = var_1_10020
								var_1_10017 = var_1_10017(var_1_10018, var_1_10019(var_1_10020))
								var_1_10019 = var_29_21
								var_1_10019 = var_29_21.Find(var_1_10019, "IconTpl/icon_bg/icon")
								var_1_10018 = var_1_10018.GetComponent
								typeof = var_1_10020
								Image = var_1_10021
								var_1_10017.targetGraphic = var_1_10018(var_1_10019, var_1_10020(var_1_10021))
							end

							::label_29_1::

							updateDrop = iter_29_4
							var_1_10018 = var_29_21
							var_1_10017 = var_29_21.Find(var_1_10018, "IconTpl")
							var_1_10018 = {
								id = var_29_23[1]
							}
							DROP_TYPE_ITEM = var_1_10019
							var_1_10018.type = var_1_10019
							var_1_10018.count = var_29_24

							iter_29_4(var_1_10017, var_1_10018)
						end
					end
				end
			end
		end
	end

	removeAllChildren = var_9

	var_9(arg_29_0.attrContainer)

	local var_29_25
	local var_29_26

	_ = var_11

	var_11.each(var_29_2.ship_id, function(arg_33_0)
		if arg_33_0[1] == arg_29_0.shipVO.configId then
			var_29_25 = arg_33_0[2]
		end

		pg = var_1

		if var_1.ship_data_template[arg_33_0[1]].group_type == arg_29_0.shipVO.groupId then
			pg = var_1
			var_29_26 = var_1.ship_data_statistics[arg_33_0[2]].type
		end

		return
	end)

	if var_29_26 then
		cloneTplTo = var_11

		local var_29_27 = var_11(arg_29_0.attrTpl, arg_29_0.attrContainer)

		setText = var_12

		local var_29_28 = var_29_27
		local var_29_29 = var_29_27.Find(var_29_28, "name")

		i18n = var_29_28

		var_12(var_29_29, var_29_28("common_ship_type"))

		setText = var_12

		local var_29_30 = var_29_27
		local var_29_31 = var_29_27.Find(var_29_30, "pre_value")

		ShipType = var_29_30

		local var_29_32 = var_29_30.Type2Name

		iter_29_4 = arg_29_0.shipVO

		var_12(var_29_31, var_29_32(var_15.getShipType(iter_29_4)))

		setText = var_12

		local var_29_33 = var_29_27
		local var_29_34 = var_29_27.Find(var_29_33, "value")

		ShipType = var_29_33

		var_12(var_29_34, var_29_33.Type2Name(var_29_26))

		setActive = var_12

		var_12(var_29_27:Find("addtion"), false)

		local var_29_35 = var_29_27
		local var_29_36 = var_29_27.Find(var_29_35, "quest")

		if var_29_25 then
			setActive = var_29_35

			var_29_35(var_29_36, true)

			onButton = var_29_35

			var_29_35(arg_29_0, var_29_27, function()
				local var_34_0 = arg_29_0

				var_0.showToolTip(var_34_0, arg_29_1)

				return
			end)
		else
			setActive = var_29_35

			var_29_35(var_29_36, false)
		end
	else
		local var_29_37 = arg_29_0.shipVO
		local var_29_38 = var_11.getShipProperties(var_29_37)

		pairs = var_29_37

		for iter_29_2, iter_29_4 in var_29_37(var_29_38) do
			if var_29_5[iter_29_2] then
				cloneTplTo = var_17

				local var_29_39 = var_17(arg_29_0.attrTpl, arg_29_0.attrContainer)
				local var_29_40 = arg_29_0
				local var_29_41 = arg_29_0.updateAttrTF
				local var_29_42 = var_29_39
				local var_29_43 = {}

				AttributeType = var_1_10022
				var_29_43.attrName = var_1_10022.Type2Name(iter_29_2)
				math = var_1_10022
				var_29_43.value = var_1_10022.floor(iter_29_4)
				var_29_43.addition = var_29_5[iter_29_2]

				var_29_41(var_29_40, var_29_42, var_29_43)
			end
		end

		pg = var_12

		local var_29_44 = var_12.ship_data_template[arg_29_0.shipVO.configId]

		for iter_29_4 = 1, 3 do
			if var_29_5["equipment_proficiency_" .. iter_29_4] then
				EquipType = var_17

				local var_29_45 = var_17.Types2Title(iter_29_4, arg_29_0.shipVO.configId)

				EquipType = var_18

				local var_29_46 = var_18.LabelToName(var_29_45)

				i18n = var_19

				local var_29_47 = var_29_46 .. var_19("common_proficiency")

				cloneTplTo = var_19

				local var_29_48 = var_19(arg_29_0.attrTpl, arg_29_0.attrContainer)
				local var_29_49 = arg_29_0
				local var_29_50 = arg_29_0.updateAttrTF
				local var_29_51 = var_29_48
				local var_29_52 = {
					attrName = var_29_47
				}
				local var_29_53 = arg_29_0.shipVO

				var_29_52.value = var_24.getEquipProficiencyByPos(var_29_53, iter_29_4) * 100
				var_29_52.addition = var_29_5["equipment_proficiency_" .. iter_29_4] * 100

				var_29_50(var_29_49, var_29_51, var_29_52, true)
			end
		end
	end

	local var_29_54 = arg_29_0
	local var_29_55 = arg_29_0.isEnoughResource(var_29_54, arg_29_1)

	setActive = var_29_54

	var_29_54(arg_29_0.confirmBtn, var_29_3 and var_29_55)

	setActive = var_29_54

	var_29_54(arg_29_0.inactiveBtn, not var_29_3 or not var_29_55)

	setActive = var_29_54

	var_29_54(arg_29_0.completedteBtn, false)

	onButton = var_29_54

	local var_29_56 = arg_29_0
	local var_29_57 = arg_29_0.confirmBtn

	local function var_29_58()
		ShipStatus = var_2_10000

		local var_35_0, var_35_1 = var_2_10000.ShipStatusCheck("onModify", arg_29_0.shipVO)

		if not var_35_0 then
			pg = var_2

			local var_35_2 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_35_2, var_35_1)

			return
		end

		local var_35_3 = arg_29_0
		local var_35_4, var_35_5 = var_2.canRemould(var_35_3, arg_29_1)

		if not var_35_4 then
			pg = var_4

			local var_35_6 = var_4.TipsMgr.GetInstance()

			var_4.ShowTips(var_35_6, var_35_5)

			return
		end

		local var_35_7 = arg_29_0
		local var_35_8, var_35_9 = var_4.isEnoughResource(var_35_7, arg_29_1)

		if not var_35_8 then
			pg = var_6

			local var_35_10 = var_6.TipsMgr.GetInstance()

			var_6.ShowTips(var_35_10, var_35_9)

			return
		end

		if var_29_25 then
			pg = var_6
			var_2_10008 = var_6.MsgboxMgr.GetInstance()

			local var_35_11 = var_6.ShowMsgBox
			local var_35_12 = {
				modal = true
			}

			i18n = var_2_10010

			local var_35_13 = "ship_remould_warning_" .. var_29_25
			local var_35_14 = arg_29_0.shipVO

			var_35_12.content = var_2_10010(var_35_13, var_12.getName(var_35_14))

			function var_35_12.onYes()
				local var_36_0 = arg_29_0
				local var_36_1 = var_0.emit

				ShipRemouldMediator = var_3_10002

				var_36_1(var_36_0, var_3_10002.REMOULD_SHIP, arg_29_0.shipVO.id, arg_29_1)

				return
			end

			var_35_11(var_2_10008, var_35_12)

			var_2_10008 = var_6.contentText

			var_7.AddListener(var_2_10008, function(arg_37_0, arg_37_1)
				if arg_37_0 == "clickDetail" then
					local var_37_0 = arg_29_0

					var_2.showToolTip(var_37_0, arg_29_1)
				end

				return
			end)
		else
			local var_35_15 = arg_29_0
			local var_35_16 = var_6.emit

			ShipRemouldMediator = var_2_10008

			var_35_16(var_35_15, var_2_10008.REMOULD_SHIP, arg_29_0.shipVO.id, arg_29_1)
		end

		return
	end

	SFX_CONFIRM = iter_29_4

	var_29_54(var_29_56, var_29_57, var_29_58, iter_29_4)

	arg_29_0.contextData.transformId = arg_29_1

	return
end

function var_0_1.isUnlock(arg_38_0, arg_38_1)
	if not arg_38_0:isUnLockPrev(arg_38_1) then
		return false
	end

	if arg_38_0:getLevelById(arg_38_1) > arg_38_0.shipVO.level then
		return false
	end

	if not arg_38_0:isReachStar(arg_38_1) then
		return false
	end

	return true
end

function var_0_1.isFinished(arg_39_0, arg_39_1)
	pg = var_1_10002

	local var_39_0 = var_1_10002.transform_data_template[arg_39_1]
	local var_39_1 = arg_39_0:getTransformLevel(arg_39_1)

	if var_39_0.max_level == var_39_1 then
		return true
	end

	return false
end

function var_0_1.isReachStar(arg_40_0, arg_40_1)
	pg = var_1_10002

	local var_40_0 = var_1_10002.transform_data_template[arg_40_1]
	local var_40_1 = arg_40_0.shipVO

	return var_3.getStar(var_40_1) >= var_40_0.star_limit
end

function var_0_1.canRemould(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0
	local var_41_1

	if not arg_41_0.isUnLockPrev(var_41_0, arg_41_1) then
		var_41_1 = false
		i18n = var_41_0

		return var_41_1, var_41_0("ship_remould_prev_lock"), {
			1
		}
	end

	pg = var_41_1

	local var_41_2 = var_41_1.transform_data_template[arg_41_1]
	local var_41_3 = arg_41_0:getLevelById(arg_41_1)

	if arg_41_0.shipVO.level < var_41_3 then
		local var_41_4 = false

		i18n = var_4

		return var_41_4, var_4("ship_remould_need_level", var_41_2.level_limit), {
			2,
			var_41_2.level_limit
		}
	end

	local var_41_5 = arg_41_0

	if not arg_41_0.isReachStar(var_41_5, arg_41_1) then
		local var_41_6 = false

		i18n = var_41_5

		return var_41_6, var_41_5("ship_remould_need_star", var_41_2.star_limit), {
			3,
			var_41_2.star_limit
		}
	end

	local var_41_7 = arg_41_0

	if arg_41_0.isFinished(var_41_7, arg_41_1) then
		local var_41_8 = false

		i18n = var_41_7

		return var_41_8, var_41_7("ship_remould_finished"), {
			4
		}
	end

	return true
end

function var_0_1.isUnLockPrev(arg_42_0, arg_42_1)
	pg = var_1_10002

	local var_42_0 = var_1_10002.transform_data_template[arg_42_1]

	pairs = var_1_10003

	for iter_42_0, iter_42_1 in var_1_10003(var_42_0.condition_id) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.transform_data_template[iter_42_1]

		if not arg_42_0.shipVO.transforms[iter_42_1] or arg_42_0.shipVO.transforms[iter_42_1].level ~= var_1_10008.max_level then
			return false
		end
	end

	return true
end

function var_0_1.isEnoughResource(arg_43_0, arg_43_1)
	pg = var_1_10002

	local var_43_0 = var_1_10002.transform_data_template[arg_43_1]
	local var_43_1 = arg_43_0
	local var_43_2 = arg_43_0.getTransformLevel(var_43_1, arg_43_1) + 1

	ipairs = var_43_1

	local var_43_3

	if not var_43_0.use_item[var_43_2] then
		var_43_3 = {}
	end

	for iter_43_0, iter_43_1 in var_43_1(var_43_3) do
		if not arg_43_0.itemsVO[iter_43_1[1]] or arg_43_0.itemsVO[iter_43_1[1]].count < iter_43_1[2] then
			local var_43_4 = false

			i18n = var_10

			local var_43_5 = var_10("ship_remould_no_item")

			return
		end
	end

	local var_43_7

	if arg_43_0.playerVO.gold < var_43_0.use_gold then
		local var_43_6 = false

		i18n = var_43_7
		var_43_7 = var_43_7("ship_remould_no_gold")

		return
	end

	if var_43_0.use_ship ~= 0 and (not arg_43_0.contextData.materialShipIds or #arg_43_0.contextData.materialShipIds ~= var_43_0.use_ship) then
		local var_43_8 = false

		i18n = var_43_7

		local var_43_9 = var_43_7("ship_remould_no_material")

		return
	end

	return true
end

function var_0_1.updateAttrTF(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = arg_44_3 and "%" or ""

	setText = var_1_10005

	var_1_10005(arg_44_1:Find("name"), arg_44_2.attrName)

	setText = var_1_10005

	var_1_10005(arg_44_1:Find("pre_value"), arg_44_2.value .. var_44_0)

	setText = var_1_10005

	var_1_10005(arg_44_1:Find("value"), arg_44_2.addition + arg_44_2.value .. var_44_0)

	setText = var_1_10005

	local var_44_1 = arg_44_1:Find("addtion")
	local var_44_2

	if not (arg_44_2.addition > 0) or not ("+" .. arg_44_2.addition) then
		var_44_2 = arg_44_2.addition
	end

	var_1_10005(var_44_1, var_44_2 .. var_44_0)

	return
end

function var_0_1.updateAttrTF_D(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	local var_45_0 = arg_45_3 and "%" or ""

	setText = var_1_10005

	var_1_10005(arg_45_1:Find("name"), arg_45_2.attrName)

	setText = var_1_10005

	local var_45_1 = arg_45_1:Find("value")
	local var_45_2

	if not (arg_45_2.addition > 0) or not ("+" .. arg_45_2.addition) then
		var_45_2 = arg_45_2.addition
	end

	var_1_10005(var_45_1, var_45_2 .. var_45_0)

	return
end

function var_0_1.showToolTip(arg_46_0, arg_46_1)
	if not arg_46_0.shipVO then
		return
	end

	pg = var_2

	local var_46_0 = var_2.transform_data_template[arg_46_1]
	local var_46_1 = arg_46_0
	local var_46_2 = arg_46_0.isFinished(var_46_1, arg_46_1)

	setActive = var_46_1
	findTF = var_5

	var_46_1(var_5(arg_46_0.tooltip, "window/scrollview/list/attrs"), not var_46_2)

	local var_46_3

	if not var_46_2 then
		Clone = var_46_1
		var_46_1 = var_46_1(arg_46_0.shipVO)
		_ = var_46_3

		var_46_3.each(var_46_0.ship_id, function(arg_47_0)
			if arg_47_0[1] == arg_46_0.shipVO.configId then
				var_46_1.configId = arg_47_0[2]
			end

			return
		end)

		var_46_3 = var_46_1.transforms
		var_46_3[arg_46_1] = {
			level = 1,
			id = arg_46_1
		}
		var_46_3 = {}
		table = var_6

		local var_46_4 = var_6.insert
		local var_46_5 = var_46_3
		local var_46_6 = {}

		i18n = var_1_10009
		var_46_6.name = var_1_10009("common_ship_type")
		ShipType = var_9

		local var_46_7 = var_9.Type2Name
		local var_46_8 = arg_46_0.shipVO

		var_46_6.from = var_46_7(var_10.getShipType(var_46_8))
		ShipType = var_9
		var_46_6.to = var_9.Type2Name(var_46_1:getShipType())

		var_46_4(var_46_5, var_46_6)

		table = var_46_4

		local var_46_9 = var_46_4.insert
		local var_46_10 = var_46_3
		local var_46_11 = {}

		i18n = var_9
		var_46_11.name = var_9("attribute_armor_type")

		local var_46_12 = arg_46_0.shipVO

		var_46_11.from = var_9.getShipArmorName(var_46_12)
		var_46_11.to = var_46_1:getShipArmorName()

		var_46_9(var_46_10, var_46_11)

		local var_46_13 = {}

		AttributeType = var_46_10
		var_46_13[1] = var_46_10.Durability
		AttributeType = var_7
		var_46_13[2] = var_7.Cannon
		AttributeType = var_7
		var_46_13[3] = var_7.Torpedo
		AttributeType = var_7
		var_46_13[4] = var_7.AntiAircraft
		AttributeType = var_7
		var_46_13[5] = var_7.Air
		AttributeType = var_7
		var_46_13[6] = var_7.Reload
		AttributeType = var_7
		var_46_13[7] = var_7.Hit
		AttributeType = var_7
		var_46_13[8] = var_7.Expend
		AttributeType = var_7
		var_46_13[9] = var_7.Dodge
		AttributeType = var_7
		var_46_13[10] = var_7.AntiSub

		local var_46_14 = arg_46_0.shipVO
		local var_46_15 = var_7.getShipProperties(var_46_14)
		local var_46_16 = var_46_1
		local var_46_17 = var_46_1.getShipProperties(var_46_16)

		ipairs = var_46_16

		for iter_46_0, iter_46_1 in var_46_16(var_46_13) do
			local var_46_18 = {}

			AttributeType = var_1_10015

			if iter_46_1 == var_1_10015.Expend then
				AttributeType = var_1_10015
				var_46_18.name = var_1_10015.Type2Name(iter_46_1)

				local var_46_19 = arg_46_0.shipVO

				var_46_18.from = var_1_10015.getBattleTotalExpend(var_46_19)
				var_46_18.to = var_46_1:getBattleTotalExpend()
			else
				AttributeType = var_1_10015
				var_46_18.name = var_1_10015.Type2Name(iter_46_1)
				math = var_1_10015
				var_46_18.from = var_1_10015.floor(var_46_15[iter_46_1])
				math = var_1_10015
				var_46_18.to = var_1_10015.floor(var_46_17[iter_46_1])
			end

			var_46_18.add = var_46_18.to - var_46_18.from
			table = var_1_10015

			var_1_10015.insert(var_46_3, var_46_18)
		end

		UIItemList = var_9

		local var_46_20 = var_9.New

		findTF = var_10

		local var_46_21 = var_10(arg_46_0.tooltip, "window/scrollview/list/attrs")

		findTF = var_11

		local var_46_22 = var_46_20(var_46_21, var_11(arg_46_0.tooltip, "window/scrollview/list/attrs/attr"))

		var_9.make(var_46_22, function(arg_48_0, arg_48_1, arg_48_2)
			UIItemList = var_2_10003

			if arg_48_0 == var_2_10003.EventUpdate then
				local var_48_0 = var_46_3[arg_48_1 + 1]

				setText = var_4

				var_4(arg_48_2:Find("name"), var_48_0.name)

				setText = var_4

				var_4(arg_48_2:Find("pre_value"), var_48_0.from)

				local var_48_1 = arg_48_2:Find("addtion")
				local var_48_2 = "#A9F548"
				local var_48_3

				if var_48_0.add and var_48_0.from ~= var_48_0.to then
					setActive = var_48_3

					var_48_3(var_48_1, true)

					if var_48_0.from > var_48_0.to then
						var_48_2 = "#FF3333"
					end

					var_48_3 = var_48_0.from < var_48_0.to and "+" or ""
					setText = var_7

					local var_48_4 = var_48_1

					string = var_2_10009

					var_7(var_48_4, var_2_10009.format("<color=%s>[%s%s]</color>", var_48_2, var_48_3, var_48_0.add))

					setText = var_7

					local var_48_5 = arg_48_2
					local var_48_6 = arg_48_2.Find(var_48_5, "value")

					string = var_48_5

					var_7(var_48_6, var_48_5.format("<color=%s>%s</color>", var_48_2, var_48_0.to))
				else
					setActive = var_48_3

					var_48_3(var_48_1, false)

					setText = var_48_3

					local var_48_7 = arg_48_2
					local var_48_8 = arg_48_2.Find(var_48_7, "value")

					string = var_48_7

					var_48_3(var_48_8, var_48_7.format("<color=%s>%s</color>", var_48_2, var_48_0.to))
				end
			end

			return
		end)
		var_9:align(#var_46_3)
	end

	setText = var_46_1
	findTF = var_46_3

	var_46_1(var_46_3(arg_46_0.tooltip, "window/scrollview/list/content/"), var_46_0.descrip)

	onButton = var_46_1

	local var_46_23 = arg_46_0

	findTF = var_6

	local var_46_24 = var_6(arg_46_0.tooltip, "window/top/btnBack")

	local function var_46_25()
		local var_49_0 = arg_46_0

		var_0.closeTip(var_49_0)

		return
	end

	SFX_CANCEL = var_8

	var_46_1(var_46_23, var_46_24, var_46_25, var_8)

	onButton = var_46_1

	local var_46_26 = arg_46_0
	local var_46_27 = arg_46_0.tooltip

	local function var_46_28()
		local var_50_0 = arg_46_0

		var_0.closeTip(var_50_0)

		return
	end

	SFX_CANCEL = var_8

	var_46_1(var_46_26, var_46_27, var_46_28, var_8)

	setActive = var_46_1

	var_46_1(arg_46_0.tooltip, true)
	arg_46_0:OverlayPanel(arg_46_0.tooltip)

	return
end

function var_0_1.closeTip(arg_51_0)
	setActive = var_1_10001

	var_1_10001(arg_51_0.tooltip, false)
	arg_51_0:UnOverlayPanel(arg_51_0.tooltip, arg_51_0._tf)

	return
end

function var_0_1.willExit(arg_52_0)
	if arg_52_0.helpBtn then
		setActive = var_1

		var_1(arg_52_0.helpBtn, true)
	end

	arg_52_0:UnOverlayPanel(arg_52_0.tooltip, arg_52_0._tf)

	return
end

function var_0_1.onBackPressed(arg_53_0)
	isActive = var_1_10001

	if var_1_10001(arg_53_0.tooltip) then
		arg_53_0:closeTip()

		return
	end

	local var_53_0 = arg_53_0
	local var_53_1 = arg_53_0.emit

	BaseUI = var_1_10003

	var_53_1(var_53_0, var_1_10003.ON_BACK_PRESSED, true)

	return
end

return var_0_1
