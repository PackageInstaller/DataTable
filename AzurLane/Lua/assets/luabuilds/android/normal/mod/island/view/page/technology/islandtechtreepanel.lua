class = var_0_10000

local var_0_0 = "IslandTechTreePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.VIEW_PADDING = 200
var_0_1.ELEMENT_SIZE = {
	x = 410,
	y = 180
}
var_0_1.LINE_TYPE = {
	C2 = 3,
	S = 1,
	C1 = 2
}
var_0_1.DEFAULT_MAX_Y = 10
var_0_1.EDGE_X = 2
var_0_1.EDGE_Y = 1

local var_0_2 = {}

IslandTechnology = var_2
var_0_2[1] = var_2.STATUS.RECEIVE
IslandTechnology = var_2
var_0_2[2] = var_2.STATUS.STUDYING
IslandTechnology = var_2
var_0_2[3] = var_2.STATUS.NORMAL
IslandTechnology = var_2
var_0_2[4] = var_2.STATUS.LOCK
IslandTechnology = var_2
var_0_2[5] = var_2.STATUS.FINISHED
var_0_1.FocusPriorities = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "IslandTechTreePanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.treeView = var_1.Find(var_2_0, "view")

	local var_2_1 = arg_2_0.treeView

	arg_2_0.showContent = var_1.Find(var_2_1, "content")

	local var_2_2 = arg_2_0.showContent

	arg_2_0.debugContainer = var_1.Find(var_2_2, "debug")
	UIItemList = var_1

	local var_2_3 = var_1.New
	local var_2_4 = arg_2_0.showContent
	local var_2_5 = var_2.Find(var_2_4, "items")
	local var_2_6 = arg_2_0.showContent

	arg_2_0.itemUIList = var_2_3(var_2_5, var_3.Find(var_2_6, "items/tpl"))

	local var_2_7 = arg_2_0.showContent

	arg_2_0.lineContainer = var_1.Find(var_2_7, "lines")

	local var_2_8 = {}
	local var_2_9 = var_0_1.LINE_TYPE.S
	local var_2_10 = arg_2_0._tf

	var_2_8[var_2_9] = var_3.Find(var_2_10, "line_tpls/s")

	local var_2_11 = var_0_1.LINE_TYPE.C1
	local var_2_12 = arg_2_0._tf

	var_2_8[var_2_11] = var_3.Find(var_2_12, "line_tpls/c1")

	local var_2_13 = var_0_1.LINE_TYPE.C2
	local var_2_14 = arg_2_0._tf

	var_2_8[var_2_13] = var_3.Find(var_2_14, "line_tpls/c2")
	arg_2_0.lineTpls = var_2_8

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0.itemUIList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0

			var_3.UpdateItem(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

	arg_3_0.lineDatas = {}
	pg = var_1
	arg_3_0.displays = var_1.island_technology_template.get_id_list_by_tech_belong[arg_3_0.contextData.type]

	local var_3_1 = 0

	arg_3_0.maxY = 0
	arg_3_0.maxX = var_3_1
	ipairs = var_3_1

	for iter_3_0, iter_3_1 in var_3_1(arg_3_0.displays) do
		pg = var_1_10006
		var_1_10006 = var_1_10006.island_technology_template[iter_3_1].axis
		math = var_1_10007
		arg_3_0.maxX = var_1_10007.max(arg_3_0.maxX, var_1_10006[1])
		math = var_1_10007
		arg_3_0.maxY = var_1_10007.max(arg_3_0.maxY, var_1_10006[2])
	end

	arg_3_0.maxX = arg_3_0.maxX + var_0_1.EDGE_X
	math = var_1
	arg_3_0.maxY = var_1.max(var_0_1.DEFAULT_MAX_Y, arg_3_0.maxY + var_0_1.EDGE_Y)

	return
end

function var_0_1.UpdateItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2.name = arg_5_0.displays[arg_5_1 + 1]

	local var_5_0 = arg_5_0.techAgency
	local var_5_1 = var_4.GetTechnology(var_5_0, var_3)

	setAnchoredPosition = var_5_0

	var_5_0(arg_5_2, arg_5_0:GetPositionById(var_5_1.id))

	setActive = var_5_0

	var_5_0(arg_5_2:Find("selected"), false)
	var_0_1.SetTechName(arg_5_2:Find("name"), var_5_1:getConfig("tech_name"))

	local var_5_2 = var_5_1
	local var_5_3 = var_5_1.GetStatus(var_5_2)

	IslandTechnology = var_5_2

	local var_5_4 = var_5_3 == var_5_2.STATUS.FINISHED

	setTextColor = var_7

	local var_5_5 = arg_5_2
	local var_5_6 = arg_5_2.Find(var_5_5, "name/Text")

	Color = var_5_5

	var_7(var_5_6, var_5_5.NewHex(var_5_4 and "1b3650" or "ffffff"))

	setTextColor = var_7

	local var_5_7 = arg_5_2
	local var_5_8 = arg_5_2.Find(var_5_7, "name/ScrollText")

	Color = var_5_7

	var_7(var_5_8, var_5_7.NewHex(var_5_4 and "1b3650" or "ffffff"))

	LoadImageSpriteAsync = var_7

	var_7("island/IslandTechnology/" .. var_5_1:getConfig("tech_icon"), arg_5_2:Find("icon"), true)

	setImageColor = var_7

	local var_5_9 = arg_5_2
	local var_5_10 = arg_5_2.Find(var_5_9, "icon")

	Color = var_5_9

	var_7(var_5_10, var_5_9.NewHex(var_5_4 and "455a81" or "ffffff"))

	setActive = var_7

	local var_5_11 = arg_5_2
	local var_5_12 = arg_5_2.Find(var_5_11, "icon")

	IslandTechnology = var_5_11

	if var_5_3 ~= var_5_11.STATUS.STUDYING then
		IslandTechnology = var_9

		local var_5_13

		if var_5_3 == var_9.STATUS.RECEIVE then
			var_5_13 = false
		else
			var_5_13 = true
		end

		var_7(var_5_12, var_5_13)

		eachChild = var_7

		var_7(arg_5_2:Find("back"), function(arg_6_0)
			setActive = var_2_10001

			var_2_10001(arg_6_0, arg_6_0.name == var_5_3)

			return
		end)

		setActive = var_7

		local var_5_14 = arg_5_2
		local var_5_15 = arg_5_2.Find(var_5_14, "back/normal")

		if not var_5_4 then
			IslandTechnology = var_5_14

			local var_5_16

			if var_5_3 == var_5_14.STATUS.STUDYING then
				var_5_16 = false
			else
				var_5_16 = true
			end

			var_7(var_5_15, var_5_16)

			eachChild = var_7

			var_7(arg_5_2:Find("front"), function(arg_7_0)
				setActive = var_2_10001

				var_2_10001(arg_7_0, arg_7_0.name == var_5_3)

				return
			end)

			onButton = var_7

			local var_5_17 = arg_5_0
			local var_5_18 = arg_5_2

			local function var_5_19()
				local var_8_0 = arg_5_0._tf
				local var_8_1 = var_0.InverseTransformPoint(var_8_0, arg_5_2.position)

				existCall = var_8_0

				var_8_0(arg_5_0.contextData.onItemClick, var_5_1.id, var_8_1)

				return
			end

			SFX_PANEL = var_11

			var_7(var_5_17, var_5_18, var_5_19, var_11)

			return
		end
	end
end

function var_0_1.Show(arg_9_0)
	arg_9_0.super.Show(arg_9_0)
	arg_9_0:Flush()
	arg_9_0:AutoFocus()

	return
end

function var_0_1.Flush(arg_10_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.GetIsland(var_10_0)

	arg_10_0.techAgency = var_1.GetTechnologyAgency(var_10_1)

	if not arg_10_0.idx2pos then
		arg_10_0:InitTreeCS(arg_10_0.maxX, arg_10_0.maxY)
	end

	local var_10_2 = arg_10_0.itemUIList

	var_1.align(var_10_2, #arg_10_0.displays)

	return
end

function var_0_1.InitTreeCS(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.gridSize = {
		x = var_0_1.ELEMENT_SIZE.x / 2,
		y = var_0_1.ELEMENT_SIZE.y / 2
	}
	setSizeDelta = var_3

	var_3(arg_11_0.showContent, {
		x = arg_11_0.gridSize.x * arg_11_1 + var_0_1.VIEW_PADDING,
		y = arg_11_0.gridSize.y * arg_11_2
	})

	arg_11_0.idx2pos = {}
	pairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_0:GetTechTreeLineData()) do
		ipairs = var_1_10008

		for iter_11_2, iter_11_3 in var_1_10008(iter_11_1) do
			arg_11_0:UpdateLineTpl(iter_11_0, iter_11_3)
		end
	end

	return
end

function var_0_1.GetPositionById(arg_12_0, arg_12_1)
	pg = var_1_10002

	local var_12_0 = var_1_10002.island_technology_template[arg_12_1].axis

	return {
		x = arg_12_0.gridSize.x * var_12_0[1],
		y = -arg_12_0.gridSize.y * var_12_0[2]
	}
end

function var_0_1.UpdateLineTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetPositionById(arg_13_1)
	local var_13_1 = arg_13_0:GetPositionById(arg_13_2)
	local var_13_2 = arg_13_0:GetLineOutPutPos(var_13_0)
	local var_13_3 = arg_13_0:GetLineInPutPos(var_13_1)
	local var_13_4

	if var_13_0.y == var_13_1.y then
		cloneTplTo = var_13_4
		var_13_4 = var_13_4(arg_13_0.lineTpls[var_0_1.LINE_TYPE.S], arg_13_0.lineContainer)
		setLocalPosition = var_8

		var_8(var_13_4, var_13_2)

		setSizeDelta = var_8

		var_8(var_13_4, {
			x = var_13_3.x - var_13_2.x,
			y = var_13_4.sizeDelta.y
		})
	else
		math = var_13_4

		local var_13_5

		if not (var_13_4.abs(var_13_3.y - var_13_2.y) <= var_0_1.ELEMENT_SIZE.y / 2) or not var_0_1.LINE_TYPE.C1 then
			var_13_5 = var_0_1.LINE_TYPE.C2
		end

		cloneTplTo = var_9

		local var_13_6 = var_9(arg_13_0.lineTpls[var_13_5], arg_13_0.lineContainer)

		setLocalScale = var_10

		var_10(var_13_6, {
			y = var_13_1.y > var_13_0.y and -1 or 1
		})

		setLocalPosition = var_10

		var_10(var_13_6, var_13_2)

		setSizeDelta = var_10

		var_10(var_13_6, {
			x = var_13_3.x - var_13_2.x,
			y = var_7 + 6
		})
	end

	return
end

function var_0_1.GetLineOutPutPos(arg_14_0, arg_14_1)
	return {
		x = arg_14_1.x + 205,
		y = arg_14_1.y
	}
end

function var_0_1.GetLineInPutPos(arg_15_0, arg_15_1)
	return {
		x = arg_15_1.x - 210,
		y = arg_15_1.y
	}
end

function var_0_1.GetTechTreeLineData(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.island_technology_template
	local var_16_1 = {}

	ipairs = var_1_10003

	for iter_16_0, iter_16_1 in var_1_10003(var_16_0.get_id_list_by_tech_belong[arg_16_0.contextData.type]) do
		local var_16_2 = var_16_0[iter_16_1]
		local var_16_3 = {}

		ipairs = var_1_10010

		for iter_16_2, iter_16_3 in var_1_10010(var_16_2.sys_unlock) do
			var_1_10015 = iter_16_3[1]
			IslandTechnology = var_1_10016

			if var_1_10015 == var_1_10016.UNLOCK_TYPE.FINISH_TECHNOLOGY then
				table = var_1_10015

				var_1_10015.insert(var_16_3, iter_16_3[2])
			end
		end

		ipairs = var_1_10010

		for iter_16_4, iter_16_5 in var_1_10010(var_16_3) do
			assert = var_1_10015

			var_1_10015(var_16_0[iter_16_5], iter_16_1 .. "科研配置了不存在的前置科研id: " .. iter_16_5)

			if var_16_0[iter_16_5].tech_belong == arg_16_0.contextData.type then
				if not var_16_1[iter_16_5] then
					var_16_1[iter_16_5] = {}
				end

				table = var_1_10015

				if not var_1_10015.contains(var_16_1[iter_16_5], iter_16_1) then
					table = var_1_10015

					var_1_10015.insert(var_16_1[iter_16_5], iter_16_1)
				end
			end
		end
	end

	return var_16_1
end

function var_0_1.AutoFocus(arg_17_0)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.GetFocusTechId(var_17_0)

	math = var_17_0

	local var_17_2 = var_17_0.max(arg_17_0:GetPositionById(var_17_1).x - var_0_1.ELEMENT_SIZE.x / 2, 0)

	scrollTo = var_3

	var_3(arg_17_0.treeView, var_17_2 / arg_17_0.showContent.rect.width, 0)

	return
end

function var_0_1.GetFocusTechId(arg_18_0)
	local var_18_0 = {}

	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.displays) do
		local var_18_1 = arg_18_0.techAgency
		local var_18_2 = var_7.GetTechnology(var_18_1, iter_18_1)

		if not var_18_0[var_7.GetStatus(var_18_2)] then
			var_18_0[var_7] = {}
		end

		table = var_8

		var_8.insert(var_18_0[var_7], iter_18_1)
	end

	ipairs = var_2

	for iter_18_2, iter_18_3 in var_2(var_0_1.FocusPriorities) do
		if var_18_0[iter_18_3] and #var_7 > 0 then
			table = var_8

			local var_18_3 = var_8.sort
			local var_18_4 = var_7

			CompareFuncs = var_1_10010

			var_18_3(var_18_4, var_1_10010({
				function(arg_19_0)
					local var_19_0 = arg_18_0

					return var_1.GetPositionById(var_19_0, arg_19_0).x
				end,
				function(arg_20_0)
					return arg_20_0
				end
			}))

			return var_7[1]
		end
	end

	return arg_18_0.displays[1]
end

function var_0_1.OnDestroy(arg_21_0)
	return
end

function var_0_1.SetTechName(arg_22_0, arg_22_1)
	GetPerceptualSize = var_1_10002

	local var_22_0 = var_1_10002(arg_22_1)

	GetComponent = var_3

	local var_22_1 = arg_22_0
	local var_22_2 = arg_22_0.Find(var_22_1, "Text")

	typeof = var_22_1
	Text = var_6

	local var_22_3 = var_3(var_22_2, var_22_1(var_6))

	var_22_3.fontSize = var_22_0 > 8 and 28 or 32
	setActive = var_22_3

	var_22_3(arg_22_0:Find("Text"), var_22_0 <= 10)

	setActive = var_22_3

	var_22_3(arg_22_0:Find("ScrollText"), var_22_0 > 10)

	if 10 < var_22_0 then
		setScrollText = var_3

		var_3(arg_22_0:Find("ScrollText"), arg_22_1)
	else
		setText = var_3

		var_3(arg_22_0:Find("Text"), arg_22_1)
	end

	return
end

return var_0_1
