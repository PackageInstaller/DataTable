local var_0_0 = class("IslandTechTreePanel", import("view.base.BaseSubView"))

var_0_0.VIEW_PADDING = 200
var_0_0.ELEMENT_SIZE = {
	x = 410,
	y = 180
}
var_0_0.LINE_TYPE = {
	C2 = 3,
	S = 1,
	C1 = 2
}
var_0_0.DEFAULT_MAX_Y = 10
var_0_0.EDGE_X = 2
var_0_0.EDGE_Y = 1
var_0_0.FocusPriorities = {
	IslandTechnology.STATUS.RECEIVE,
	IslandTechnology.STATUS.STUDYING,
	IslandTechnology.STATUS.NORMAL,
	IslandTechnology.STATUS.LOCK,
	IslandTechnology.STATUS.FINISHED
}

function var_0_0.getUIName(arg_1_0)
	return "IslandTechTreePanel"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.treeView = arg_2_0._tf:Find("view")
	arg_2_0.showContent = arg_2_0.treeView:Find("content")
	arg_2_0.debugContainer = arg_2_0.showContent:Find("debug")
	arg_2_0.itemUIList = UIItemList.New(arg_2_0.showContent:Find("items"), arg_2_0.showContent:Find("items/tpl"))
	arg_2_0.lineContainer = arg_2_0.showContent:Find("lines")
	arg_2_0.lineTpls = {
		[var_0_0.LINE_TYPE.S] = arg_2_0._tf:Find("line_tpls/s"),
		[var_0_0.LINE_TYPE.C1] = arg_2_0._tf:Find("line_tpls/c1"),
		[var_0_0.LINE_TYPE.C2] = arg_2_0._tf:Find("line_tpls/c2")
	}

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.itemUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:UpdateItem(arg_4_1, arg_4_2)
		end

		return
	end)

	arg_3_0.lineDatas = {}
	arg_3_0.displays = pg.island_technology_template.get_id_list_by_tech_belong[arg_3_0.contextData.type]
	arg_3_0.maxX, arg_3_0.maxY = 0, 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.displays) do
		arg_3_0.maxX = math.max(arg_3_0.maxX, pg.island_technology_template[iter_3_1].axis[1])
		arg_3_0.maxY = math.max(arg_3_0.maxY, pg.island_technology_template[iter_3_1].axis[2])
	end

	arg_3_0.maxX = arg_3_0.maxX + var_0_0.EDGE_X
	arg_3_0.maxY = math.max(var_0_0.DEFAULT_MAX_Y, arg_3_0.maxY + var_0_0.EDGE_Y)

	return
end

function var_0_0.UpdateItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2.name = arg_5_0.displays[arg_5_1 + 1]

	local var_5_0 = arg_5_0.techAgency:GetTechnology(arg_5_0.displays[arg_5_1 + 1])

	setAnchoredPosition(arg_5_2, arg_5_0:GetPositionById(var_5_0.id))
	setActive(arg_5_2:Find("selected"), false)
	var_0_0.SetTechName(arg_5_2:Find("name"), var_5_0:getConfig("tech_name"))

	local var_5_1 = var_5_0:GetStatus()
	local var_5_2 = var_5_1 == IslandTechnology.STATUS.FINISHED

	setTextColor(arg_5_2:Find("name/Text"), Color.NewHex(var_5_1 == IslandTechnology.STATUS.FINISHED and "1b3650" or "ffffff"))
	setTextColor(arg_5_2:Find("name/ScrollText"), Color.NewHex(var_5_2 and "1b3650" or "ffffff"))
	LoadImageSpriteAsync("island/IslandTechnology/" .. var_5_0:getConfig("tech_icon"), arg_5_2:Find("icon"), true)
	setImageColor(arg_5_2:Find("icon"), Color.NewHex(var_5_2 and "455a81" or "ffffff"))
	setActive(arg_5_2:Find("icon"), var_5_1 ~= IslandTechnology.STATUS.STUDYING and var_5_1 ~= IslandTechnology.STATUS.RECEIVE)
	eachChild(arg_5_2:Find("back"), function(arg_6_0)
		setActive(arg_6_0, arg_6_0.name == var_5_1)

		return
	end)
	setActive(arg_5_2:Find("back/normal"), not var_5_2 and var_5_1 ~= IslandTechnology.STATUS.STUDYING)
	eachChild(arg_5_2:Find("front"), function(arg_7_0)
		setActive(arg_7_0, arg_7_0.name == var_5_1)

		return
	end)
	onButton(arg_5_0, arg_5_2, function()
		existCall(arg_5_0.contextData.onItemClick, var_5_0.id, (arg_5_0._tf:InverseTransformPoint(arg_5_2.position)))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_9_0)
	arg_9_0.super.Show(arg_9_0)
	arg_9_0:Flush()
	arg_9_0:AutoFocus()

	return
end

function var_0_0.Flush(arg_10_0)
	arg_10_0.techAgency = getProxy(IslandProxy):GetIsland():GetTechnologyAgency()

	if not arg_10_0.idx2pos then
		arg_10_0:InitTreeCS(arg_10_0.maxX, arg_10_0.maxY)
	end

	arg_10_0.itemUIList:align(#arg_10_0.displays)

	return
end

function var_0_0.InitTreeCS(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.gridSize = {
		x = var_0_0.ELEMENT_SIZE.x / 2,
		y = var_0_0.ELEMENT_SIZE.y / 2
	}

	setSizeDelta(arg_11_0.showContent, {
		x = arg_11_0.gridSize.x * arg_11_1 + var_0_0.VIEW_PADDING,
		y = arg_11_0.gridSize.y * arg_11_2
	})

	arg_11_0.idx2pos = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_0:GetTechTreeLineData()) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			arg_11_0:UpdateLineTpl(iter_11_0, iter_11_3)
		end
	end

	return
end

function var_0_0.GetPositionById(arg_12_0, arg_12_1)
	return {
		x = arg_12_0.gridSize.x * pg.island_technology_template[arg_12_1].axis[1],
		y = -arg_12_0.gridSize.y * pg.island_technology_template[arg_12_1].axis[2]
	}
end

function var_0_0.UpdateLineTpl(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetPositionById(arg_13_1)
	local var_13_1 = arg_13_0:GetPositionById(arg_13_2)
	local var_13_2 = arg_13_0:GetLineOutPutPos(var_13_0)
	local var_13_3 = arg_13_0:GetLineInPutPos(var_13_1)
	local var_13_5 = math.abs(var_13_3.y - var_13_2.y)

	if var_13_0.y == var_13_1.y then
		local var_13_4 = cloneTplTo(arg_13_0.lineTpls[var_0_0.LINE_TYPE.S], arg_13_0.lineContainer)

		setLocalPosition(var_13_4, var_13_2)
		setSizeDelta(var_13_4, {
			x = var_13_3.x - var_13_2.x,
			y = var_13_4.sizeDelta.y
		})

		goto label_13_0
	end

	::label_13_0::

	if var_13_5 <= var_0_0.ELEMENT_SIZE.y / 2 then
		do
			local var_13_6 = var_0_0.LINE_TYPE.C1 or var_0_0.LINE_TYPE.C2
			local var_13_7 = cloneTplTo(arg_13_0.lineTpls[var_13_6], arg_13_0.lineContainer)

			setLocalScale(var_13_7, {
				y = var_13_1.y > var_13_0.y and -1 or 1
			})
			setLocalPosition(var_13_7, var_13_2)
			setSizeDelta(var_13_7, {
				x = var_13_3.x - var_13_2.x,
				y = var_13_5 + 6
			})
		end

		return
	end
end

function var_0_0.GetLineOutPutPos(arg_14_0, arg_14_1)
	return {
		x = arg_14_1.x + 205,
		y = arg_14_1.y
	}
end

function var_0_0.GetLineInPutPos(arg_15_0, arg_15_1)
	return {
		x = arg_15_1.x - 210,
		y = arg_15_1.y
	}
end

function var_0_0.GetTechTreeLineData(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(pg.island_technology_template.get_id_list_by_tech_belong[arg_16_0.contextData.type]) do
		for iter_16_2, iter_16_3 in ipairs(pg.island_technology_template[iter_16_1].sys_unlock) do
			if iter_16_3[1] == IslandTechnology.UNLOCK_TYPE.FINISH_TECHNOLOGY then
				table.insert({}, iter_16_3[2])
			end
		end

		for iter_16_4, iter_16_5 in ipairs({}) do
			assert(pg.island_technology_template[iter_16_5], iter_16_1 .. "科研配置了不存在的前置科研id: " .. iter_16_5)

			if pg.island_technology_template[iter_16_5].tech_belong == arg_16_0.contextData.type then
				if not ({})[iter_16_5] then
					({})[iter_16_5] = {}
				end

				if not table.contains(({})[iter_16_5], iter_16_1) then
					table.insert(({})[iter_16_5], iter_16_1)
				end
			end
		end
	end

	return {}
end

function var_0_0.AutoFocus(arg_17_0)
	scrollTo(arg_17_0.treeView, math.max(arg_17_0:GetPositionById((arg_17_0:GetFocusTechId())).x - var_0_0.ELEMENT_SIZE.x / 2, 0) / arg_17_0.showContent.rect.width, 0)

	return
end

function var_0_0.GetFocusTechId(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.displays) do
		local var_18_0 = arg_18_0.techAgency:GetTechnology(iter_18_1):GetStatus()

		if not ({})[var_18_0] then
			({})[var_18_0] = {}
		end

		table.insert(({})[var_18_0], iter_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(var_0_0.FocusPriorities) do
		if ({})[iter_18_3] and #({})[iter_18_3] > 0 then
			table.sort(({})[iter_18_3], CompareFuncs({
				function(arg_19_0)
					return arg_18_0:GetPositionById(arg_19_0).x
				end,
				function(arg_20_0)
					return arg_20_0
				end
			}))

			return ({})[iter_18_3][1]
		end
	end

	return arg_18_0.displays[1]
end

function var_0_0.OnDestroy(arg_21_0)
	return
end

function var_0_0.SetTechName(arg_22_0, arg_22_1)
	local var_22_0 = GetPerceptualSize(arg_22_1)

	GetComponent(arg_22_0:Find("Text"), typeof(Text)).fontSize = var_22_0 > 8 and 28 or 32

	setActive(arg_22_0:Find("Text"), var_22_0 <= 10)
	setActive(arg_22_0:Find("ScrollText"), var_22_0 > 10)

	if var_22_0 > 10 then
		setScrollText(arg_22_0:Find("ScrollText"), arg_22_1)
	else
		setText(arg_22_0:Find("Text"), arg_22_1)
	end

	return
end

return var_0_0
